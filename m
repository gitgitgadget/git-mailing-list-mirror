From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/4] diff/xdiff: refactor EOF-EOL detection
Date: Sat, 05 Jun 2010 21:00:32 -0700
Message-ID: <7vfx10yfmn.fsf@alter.siamese.dyndns.org>
References: <cover.1275575236.git.git@drmicha.warpmail.net>
 <08e635cee993d97e2a38d7766ced11c064ef7d87.1275575236.git.git@drmicha.warpmail.net> <7vsk537p8k.fsf@alter.siamese.dyndns.org> <4C08AD75.6040307@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sun Jun 06 06:00:55 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OL72X-0002en-Aw
	for gcvg-git-2@lo.gmane.org; Sun, 06 Jun 2010 06:00:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750738Ab0FFEAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jun 2010 00:00:44 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:65409 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750709Ab0FFEAn (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jun 2010 00:00:43 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 53756B9E1B;
	Sun,  6 Jun 2010 00:00:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=TnHnRF3DYBdji7B0FSAXXbJve0E=; b=jkxcBAnWTEvFS3zyYxwn+lk
	DKc4gA2Vx7QWkcGcRBX+WChjJ5SHbkOPG1iUOd7AIC5cFR4wssZixFucNJ8hw44o
	oaydUD7NBhFfBb3f0kAXU0a+SpwtMH9UjSJ1NnBI95UpU8Qry5pYgBZm/p/piJ/X
	rzgtFyuaamgRsw8GUNzw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=SRWM7nPebMN45UjKF7cq2TOzfsTaefzKVKFuJWVPLnWWHhtpN
	x5tZzTPK7yztpmtv2mfccyHQlmwTWIQhgSsAKUDQ0xQ9neX4Upz9ts/gT2rjTgXI
	IEtOzx5bK/Cu7PWJVVth7fsRtYS8klSyLQVnWIkwvxw13douA7ilQZt6d8=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E7D1CB9E1A;
	Sun,  6 Jun 2010 00:00:37 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 480D8B9E19; Sun,  6 Jun
 2010 00:00:34 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 10CC22B6-7120-11DF-A19A-6730EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148506>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> I'm sorry, but that makes 3 out of 3 respondents who didn't seem to read
> what I wrote.

You seem to think three out of three people didn't read nor understood
your argument, but my take on it is that three out of three of people who
cared about the issue thought your justification was not convincing.

Symlinks are minority among the tracked contents (e.g. in git.git there is
only one), and they are almost always a single incomplete line.  When they
change, you do want to notice, and I happen to find it a good visual aid
to have these incomplete line indicators, in addition to the unusual
120000 mode on the index line.

Peff uses --textconv to show changes to the exif information on his photo
collections.  If he has any symlinks, and if he finds that removal of "\No
newline" is a regression and not an improvement, what recourse does your
patch give him?  Saying --no-textconv to work around that regression is
not a solution, isn't it?

If you start from a false premise that "\No newline" was an unnecessary
warning, it may seem that the output (which almost always is given for
symlinks) needs "improving".  But have you considered a possibility that
removal of the line from the output is not an improvement?
