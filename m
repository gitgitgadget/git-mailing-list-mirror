From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: teach --gpg-sign option
Date: Sun, 09 Oct 2011 15:27:06 -0700
Message-ID: <7v4nzhrebp.fsf@alter.siamese.dyndns.org>
References: <7vaa9f3pk8.fsf@alter.siamese.dyndns.org>
 <4E91FD57.7050808@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Mon Oct 10 00:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD1q0-00011F-IY
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 00:27:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469Ab1JIW1M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 18:27:12 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45216 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751143Ab1JIW1J (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 18:27:09 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 65EE163AA;
	Sun,  9 Oct 2011 18:27:08 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EPk0Xs9Fbwv7NIyTgx1af9rQNUs=; b=Q9Gqul
	axWU5fVulyszRgA4dCOEVXsXIZJvo86AnNRiTDbsOtcK4AOvOHRhI8+udIAl0H87
	0Aqy8aajvWFw9e2mkkFwo88IAQev7cCa3HFIZvhaERlEv4QcLzRSUkFRJDaf98OL
	Fu3Y9Ld95RIKB/CtKNCvDb/yMouMMcLMbYtss=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=l8JbtIS8oM1glqaDCbIXM3Md/5BJdvsP
	GE3FCr651Vh3RLeoOQLa7FZPNWVMHG3+Glvt4K4am1g2MW8zI0mV6UxRAslPbqtx
	fIhTgxA4M9P7/ry5tR739TUG+eIhcOBjwbs8dXcX3wUM1Biz4LcSNZpV9fpI6kzP
	P9K7HAGgTYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5D8D763A9;
	Sun,  9 Oct 2011 18:27:08 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E809D63A8; Sun,  9 Oct 2011
 18:27:07 -0400 (EDT)
In-Reply-To: <4E91FD57.7050808@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Sun, 09 Oct 2011 22:00:23 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: D2C35042-F2C5-11E0-AF60-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183214>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> BTW: commit --amend --gpg-sign strips an existing signature rather than
> adding one. We might want the user to have a say here.

I think it deserves a separate command (commit --add-gpg-sign) that is
used _only_ to add an additional signature by another person without
affecting anything else in the commit (i.e. the tree, the parents and the
author and committership information) from the viewpoint of the workflow,

Obviously that "add-signature" mode needs to be aware of the existing
signature. It is a deliberate design decision to strip existing signature
when anything in the commit changes, which is the norm for --amend.
