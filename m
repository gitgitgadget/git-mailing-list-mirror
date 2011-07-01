From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] (trivial) add helpful "use --soft" for bare reset
Date: Fri, 01 Jul 2011 09:39:50 -0700
Message-ID: <7vei2aosyx.fsf@alter.siamese.dyndns.org>
References: <20110626221428.GA26780@spacedout.fries.net>
 <7vk4c3qlqa.fsf@alter.siamese.dyndns.org>
 <20110630190608.GB26701@spacedout.fries.net>
 <7vwrg3ozi5.fsf@alter.siamese.dyndns.org>
 <20110630220843.GC26701@spacedout.fries.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Bronson <bronson@rinspin.com>
To: David Fries <david@fries.net>
X-From: git-owner@vger.kernel.org Fri Jul 01 18:40:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QcglK-0007tS-Ik
	for gcvg-git-2@lo.gmane.org; Fri, 01 Jul 2011 18:40:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757277Ab1GAQkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jul 2011 12:40:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61576 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757265Ab1GAQjy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jul 2011 12:39:54 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B1F7148F9;
	Fri,  1 Jul 2011 12:42:07 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Sv6cQ9r5RtSUVjNkF3aB5eocvW4=; b=afcqgw
	MhOsQQmlafvoxh66yrC8zd6vxSMkjtm6JmMoRsqhMVCFftqY2TZLqqkZYqmpR47+
	rI6EMziLNfzjzBNVZPqIOK47+NfVDVW9yQEMTWGyE3zmzXnjE9eLF56CnaUwMNPx
	eJ3n/y0OYmi0h88drrHemf+JKPw04aX5iPXbA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=aph02oE33Z7VeM4yDkMNf8e9QTs0BaP7
	cUm11zsgHNWSUU+doVbWFGG7bPFlq3312+nWr1+pgD+4pJfR9FCTcybz9zK80FdR
	6LfFg7J/I/u5/n93So5KpkKsGFUw4Gx5xH903Vjt7qirI/v5wP4QbXV9XeNlDOEL
	bjkRGIi9fgc=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id A9D8748F8;
	Fri,  1 Jul 2011 12:42:07 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id F2D8448F7; Fri,  1 Jul 2011
 12:42:06 -0400 (EDT)
In-Reply-To: <20110630220843.GC26701@spacedout.fries.net> (David Fries's
 message of "Thu, 30 Jun 2011 17:08:43 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0EB8EEFE-A401-11E0-AC07-5875C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176523>

David Fries <david@fries.net> writes:

> But at work push -f no longer works, it's administratively denied from
> remote for certain branches, the kind that you generally never want to
> rewind.  But on occasion we do.  The options are to administratively
> change permissions, push -f, change back, or login to the server,
> clone, push -f, or manipulate the bare repository directly.  Modifying
> the bare repository is the quickest and git-update-ref works, it just
> isn't in the porcelain commands, so less likely to be known.

That is expected. Whoever denies "administratively" a push that rewinds
the history would have the authority to grant exception to the policy, and
ability to help you rewind the history. You would need to work with
them. If "them" happens to be "you", then you are expected to have that
authority and ability, which may include to have direct write access to
the repository and to know update-ref.

> ....  I'm not concerned about a user
> actually being in a bare repository thinking they're not, because
> resetting the index or working directory can loose information that
> you can't get back by looking at the ref-log until gc runs, and
> nothing woring on the index or working directory will work so they'll
> figure it out soon enough.

You may not be concerned, but I am; otherwise the message you are
responding to wouldn't have been written. And I would agree they'll figure
it out soon enough with the current error message, that does not have an
advice to look at update-ref, which is irrelevant. I am mostly worried
about the additional wrong (for their situation) advice throwing them off
track.

>> In such a scenario, the mistake is not that I used a wrong command "reset"
>> in an attempt to update the tip of the branch. The mistake is that I tried
>> to use the right command to update the index, but I did it in a wrong
>> place. "Did you mean to do that somewhere else?" would be a much more
>> appropriate advice in that case.
>
> Yes, your message would be appropriate in that case, but there's no
> way for git to guess that.

That is exactly my point. If we cannot guess reliably, I do not want to
see us giving an inappropriate advice that does not apply to the user's
situation, potentially leading the user in the wrong direction.
