From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] rebase: accept -<number> as another way of saying HEAD~<number>
Date: Mon, 03 Mar 2014 13:48:44 -0800
Message-ID: <xmqqha7fnebn.fsf@gitster.dls.corp.google.com>
References: <1393506078-7310-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-1-git-send-email-pclouds@gmail.com>
	<1393728794-29566-3-git-send-email-pclouds@gmail.com>
	<CAPig+cSPKSsVG_yqaQfOCswaENKdUGrWt_YcQ3yZCpgG5jQ+JQ@mail.gmail.com>
	<CAPig+cSFWT6kwZUFFUE3=TcfHRUJnx54+fcZCzJwmOSJKFsYeA@mail.gmail.com>
	<vpqlhwsr3ww.fsf@anie.imag.fr> <53144881.6090702@alum.mit.edu>
	<vpq7g8bfws8.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Eric Sunshine <sunshine@sunshineco.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Philip Oakley <philipoakley@iee.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Mar 03 22:48:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKajD-0004vO-Vy
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 22:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754891AbaCCVss (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 16:48:48 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56057 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564AbaCCVsr (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 16:48:47 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1D64771903;
	Mon,  3 Mar 2014 16:48:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wsGbFtr2PWBV9LspkbWkEmDopBw=; b=jlY0ot
	iHSwGtP0xSwMRaDdRYCIAyQ9Cdp73R5fF1NvWPozoPr1lH6S+voLNZcXDE1ngRSX
	Nwq3BgGZ6PXyiR8pAl9C9XOlKl6KgpIlqZJWaVauGI9rNWWxlF/UBnsuE2ABQC9E
	ZnhvypbXnWAUn0FrJa224kKGD//ebR0PsiZAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=KLdQ00joEvNe30ka2nL15QgkvBGNCfip
	I4GLq6jrMT1BpzhRxFKWZgqFBmg3CG3Vk0KFzEcalVQFY4m+TmfvFAUeg5is8Ujk
	szkEwjmFr3UUmN7twea5NHpypUlZJAFagSp4ZszZlOPRt2VpAq4fpoYzoMC9YRzO
	6l7IdJCDz2g=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 082D071902;
	Mon,  3 Mar 2014 16:48:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4775471900;
	Mon,  3 Mar 2014 16:48:46 -0500 (EST)
In-Reply-To: <vpq7g8bfws8.fsf@anie.imag.fr> (Matthieu Moy's message of "Mon,
	03 Mar 2014 10:37:11 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 98BB3DB4-A31D-11E3-9DFC-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243275>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> Michael Haggerty <mhagger@alum.mit.edu> writes:
>
>> Or perhaps "-NUM" should fail with an error message if any of the last
>> NUM commits are merges.  In that restricted scenario (which probably
>> accounts for 99% of rebases), "-NUM" is equivalent to "HEAD~NUM".
>
> Makes sense to me. So, -NUM would actually mean "rebase the last NUM
> commits" (as well as being an alias for HEAD~NUM), but would fail when
> it does not make sense (with an error message explaining the situation
> and pointing the user to HEAD~N if this is what he wanted).
>
> This would actually be a feature for me: I often want to rebase "recent
> enough" history, and when my @{upstream} isn't well positionned,...

Could you elaborate on this a bit?  What does "isn't well
positioned" mean?  Do you mean "the upstream has advanced but there
is no reason for my topic to build on that---I'd rather want to make
sure I can view 'diff @{1} HEAD' and understand what my changes
before the rebase was"?  That is, what you really want is

	git rebase -i --onto $(git merge-base @{upstream} HEAD) @{upstream}

but that is too long to type?

If it is very common (and I suspect it is), we may want to support
such a short-hand---the above does not make any sense without '-i',
but I would say with '-i' you do not want to reBASE on an updated
base most of the time.  "git rebase -i @{upstream}...HEAD" or
something?
