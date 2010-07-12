From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about 'branch -d' safety
Date: Mon, 12 Jul 2010 16:50:32 -0700
Message-ID: <7v39vo8dkn.fsf@alter.siamese.dyndns.org>
References: <20091230065442.6117@nanako3.lavabit.com>
 <m3lj9jknlr.fsf@localhost.localdomain> <20100711065505.GA19606@localhost>
 <201007110916.29567.jnareb@gmail.com> <20100711133730.GA10338@localhost>
 <7v1vb9hnd9.fsf@alter.siamese.dyndns.org> <20100712184754.GA18429@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
	Nicolas Sebrecht <nicolas.s.dev@gmx.fr>,
	Nanako Shiraishi <nanako3@lavabit.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Jul 13 01:50:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OYSlx-0003Cj-QW
	for gcvg-git-2@lo.gmane.org; Tue, 13 Jul 2010 01:50:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752280Ab0GLXut (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Jul 2010 19:50:49 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:62920 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751860Ab0GLXus (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jul 2010 19:50:48 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id EBCB1C45FD;
	Mon, 12 Jul 2010 19:50:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; s=sasl; bh=Xka9pdjkBp0hPVZ31DMX0x0c0Vs=; b=Gqo1mV
	g9MVzy/nZolzROIWkOVcJK+NKJ7IbG9UFNKZQ9NkUxTM4oKWUOnFFNX2uZxMocZ9
	Y71ReoHR/sfE3rQUCNS2CU80pS3r8MDOJjBr8WbbujdcVyMUVEERllvOi7BwQ+JC
	zB9ExQlMSHyi1uDJUQ+FPQJdBNpljWV9DvNOE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:in-reply-to:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=M2nAvpVBAZnL1SXSRH6sN9dd8pGPMgeP
	bPvJPGI9weT97S5RU/ZP0y7yISdHbGamF+UJc/SskreeDnXvwmdHjItrpLO5OnXq
	1P73c2j0wqRa7gMtVkPTqwwVOrJ74SxtXW8Wu07gNIn5uaCGHCv4dSXeQSfXF1Ft
	Y1lAbLNgIpY=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 82F68C45FC;
	Mon, 12 Jul 2010 19:50:41 -0400 (EDT)
Received: from pobox.com (unknown [69.181.135.33]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 747D2C45FB; Mon, 12 Jul
 2010 19:50:34 -0400 (EDT)
In-Reply-To: <20100712184754.GA18429@localhost> (Clemens Buchacher's message
 of "Mon\, 12 Jul 2010 20\:47\:55 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 478674DE-8E10-11DF-B3D4-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150855>

Clemens Buchacher <drizzd@aon.at> writes:

>> What problem are you guys really trying to solve?
>
> The reflog protects you from almost all involuntary loss of
> information.

And you call "git branch -[dD]" involuntary?

I am not entirely unsympathetic to add "git branch --undelete frotz" to our
vocabulary, but then we should leave users an easy way to really remove
things, and it shouldn't be "git branch -d --i-really-mean-it frotz".

It would probably be more like "git branch -d frotz" followed by "git
branch --purge frotz" or "git branch --purge \*" (if we name the operation
to remove cruft for undelete "purge", that is).
