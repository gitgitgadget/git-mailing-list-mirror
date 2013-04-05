From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH 0/7] Rework git core for native submodules
Date: Fri, 05 Apr 2013 10:07:42 -0700
Message-ID: <7vfvz4dhy9.fsf@alter.siamese.dyndns.org>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
 <CA+55aFz1D_dMtMHHMpiGi3KL=Y-m4DVxHVr=1ZX8zYWQ2TPvwA@mail.gmail.com>
 <CALkWK0nNjvV5VGvT_eaubFoOhMnJ-N8FECAayd5A2K3BzeRh6Q@mail.gmail.com>
 <CA+55aFyQwJfiYo06y1bRNpKT6wOquhG9a9M_4YvLG_UT3b34-w@mail.gmail.com>
 <515DEE86.3020301@web.de> <7vd2uagd10.fsf@alter.siamese.dyndns.org>
 <CALkWK0kQ8qYXHKr4e93A1dh3Y1vL+HZvMR_1xtKkUr-_7bMS6Q@mail.gmail.com>
 <7vy5cyexuf.fsf@alter.siamese.dyndns.org>
 <CALkWK0kpf+AAzrLuqKQx5iv3nNKJ48R5etcBrcdoG46Z1ipgbQ@mail.gmail.com>
 <7vli8xgahc.fsf@alter.siamese.dyndns.org>
 <CALkWK0mcii_YGqiQTxhSOfgzn7MOHO0TEO3Rx3cRQLOi1ij5Tg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Git List <git@vger.kernel.org>, Heiko Voigt <hvoigt@hvoigt.net>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 06 19:22:14 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UOWLc-0002u6-HK
	for gcvg-git-2@plane.gmane.org; Sat, 06 Apr 2013 18:52:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162080Ab3DERHq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 5 Apr 2013 13:07:46 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:54254 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1162050Ab3DERHp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Apr 2013 13:07:45 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D43321476E;
	Fri,  5 Apr 2013 17:07:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CLygclVEr0aUvHaZHFNUcN6aM5s=; b=owz+sY
	SMy8oXk4+Rv9bWM2ddHS/DjTWpmWhBo0q2zcdTB2RSFFe+zmSGB/arwWf3j7Ch+U
	H0gLvSvZIrIFDlxD/PxdA3Q7wQmsP7guY3VWHIMSqW6ACUVQR1alboyzTkML1T6w
	NNEkCmPX658cbwLkrTroosukyHrYeHNGrzGIQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=WMDhUhhFH4DDCLsEDNQfHrY0jEcOupGP
	uoqwM5+7Tm/d8TTwa8j1TPslyNuHGhY/CGRupD0NsdU2ViJQRjcfiE3BeLo/Fum5
	un8oOXK2hbELyHLXGogaPV+c5jtYD+YqzkAFggCJ/jEVY087lR++ihiy1yy9wIJO
	rrjuujtSmLE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C89401476D;
	Fri,  5 Apr 2013 17:07:44 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 384F21476B; Fri,  5 Apr
 2013 17:07:44 +0000 (UTC)
In-Reply-To: <CALkWK0mcii_YGqiQTxhSOfgzn7MOHO0TEO3Rx3cRQLOi1ij5Tg@mail.gmail.com>
 (Ramkumar Ramachandra's message of "Fri, 5 Apr 2013 04:44:45 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 550403B8-9E13-11E2-82BE-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220206>

Ramkumar Ramachandra <artagnon@gmail.com> writes:

> Junio C Hamano wrote:
>> "git log -p .gitmodules" would be a way to review what changed in
>> the information about submodules.  Don't you need "git log-link" for
>> exactly the same reason why you need "git diff-link" in the first
>> place?
>>
>> So you may not have suggested it, but I suspect that was only
>> because you haven't had enough time to think things through.
>
> What is this git log -p .gitmodules doing?  It's walking down the
> commit history, and picking out the commits in which that blob
> changed.  Then it's diffing the blobs in those commits with each
> other.  Why is git log -p <link> any different?  We already know how
> to diff blobs, and we just need a way to diff links.

You already forget what you invented "git diff-link" as a "solution"
for, perhaps?

By recording the submodules themselve and information _about_ the
submodules separately (the latter is in .gitmodules), "git diff A"
can show the difference in submodule A, while "git diff .gitmodules"
can show a change, which is a possibly in-working-tree-only proposed
change, in information about submoudules.

Once you start recording the latter also at path "A", it becomes
unclear what "git diff A" should show.

That is what I said in the message, to which you invented "diff-link"
as a solution to the "unclear"-ness.

Am I misremembering the flow of discussion in this thread?
