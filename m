From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: suggest --amend --reset-author to fix commiter
 identity
Date: Fri, 07 Jan 2011 11:51:15 -0800
Message-ID: <7vsjx45w7g.fsf@alter.siamese.dyndns.org>
References: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Fri Jan 07 20:51:47 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbILj-0000HJ-E3
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 20:51:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755473Ab1AGTvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 14:51:23 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43242 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755199Ab1AGTvW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 14:51:22 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id B6B163657;
	Fri,  7 Jan 2011 14:52:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=xc/tzXBZYhF1nTkNDxKdcD5bQ3Q=; b=c1xjgO
	A4f9BGefj276ZEz2s3AtR6vSA/ImA8Iqrw6dRIz/OGFRS8TLkWGQEXj12DyflBie
	E5PMGNDbD7z3RAbN/93qjmrEyjgpdvxchO2SLFJOOWcM+RvDyy35qsy5fVI1NUaa
	IupBwTNuGC666APl30Th0dPDTcOtdiKJgblQw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pzdU7ntavmuKMKXCK9bsYU+n1+OW8P0m
	CgIhzPetKdcnjzVHc8RTv1cgWm5fvDyJ3hyCTqdV89KtykSAcxSHHyKLHwS1qEdf
	Ksa5D3QNzfsC9hw5qaMd9H3cRQr9YjleT2d8PU/428BLIFyTTVz8Eixx87MFnkzK
	Ukr4e3ulabU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 930ED3653;
	Fri,  7 Jan 2011 14:51:58 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A30CE364F; Fri,  7 Jan 2011
 14:51:55 -0500 (EST)
In-Reply-To: <1294409671-5479-1-git-send-email-Matthieu.Moy@imag.fr>
 (Matthieu Moy's message of "Fri\,  7 Jan 2011 15\:14\:31 +0100")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 9654AD56-1A97-11E0-9A0B-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164750>

Matthieu Moy <Matthieu.Moy@imag.fr> writes:

> The advantage of this command is that it is cut-and-paste ready, while
> using --author='...' requires the user to type his name and email a
> second time.
>
> Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
> ---
>  builtin/commit.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
>
> diff --git a/builtin/commit.c b/builtin/commit.c
> index 22ba54f..440223c 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -47,7 +47,11 @@ static const char implicit_ident_advice[] =
>  "\n"
>  "If the identity used for this commit is wrong, you can fix it with:\n"
>  "\n"
> -"    git commit --amend --author='Your Name <you@example.com>'\n";
> +"    git commit --amend --author='Your Name <you@example.com>'\n"
> +"\n"
> +"or\n"
> +"\n"
> +"    git commit --amend --reset-author\n";

I don't think making the "cheat-sheet" insn longer by offering more
choices is a good idea.  These are messages for lazy and busy people.

Wouldn't it work better to just get rid of the longer form and say
something like:

    ... here is how to tell your name to git (existing message) ...

    After doing the above, run

    	git commit --amend --reset-author

    to fix the identity used for this commit.
