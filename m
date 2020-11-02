Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C70C5C00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:11:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5EC3022226
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 18:11:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Fp8SqqtG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgKBSLL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 13:11:11 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50676 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgKBSLL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 13:11:11 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E18E8D5AD;
        Mon,  2 Nov 2020 13:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=0uxXEgYxF9IWB57iGYY2IA3enkQ=; b=Fp8SqqtGxeZfdY7OM1f4
        6Rd/g35sDhZ3uqTZfXiwmHtw7kjGYY65jUCog/nHQFvbuZUCAIeQjvv23AVaNxIH
        sepXLj+ctxblZlOj9k31pPrjsaULIo+cwRMFK33Sw0qXt5scBFlNjWeAk1U2C4hn
        iqR0qsmhP1213Yz8Hb9jTko=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=DQUmuAjj3EWsnRpuW2YITqXpy+SJH2+7G8NwVpuhOZyEnG
        im4f3CxvaCqMzi8ZrpMiBkIkWHjTBdrz2ULh6ah7SJKKiYuZz8ACb+BsJs4Q7i6l
        IsFRH0tj8c+/knfTfWmakEinXFKO0/Jp7KDlZUvA6tRk0N+sVioNwAIvFLs5E=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6C5D48D5AB;
        Mon,  2 Nov 2020 13:11:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 7C0518D5A9;
        Mon,  2 Nov 2020 13:11:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] doc/diff-options: fix out of place mentions of
 '--patch/-p'
References: <20201031193734.22702-1-sorganov@gmail.com>
Date:   Mon, 02 Nov 2020 10:11:05 -0800
Message-ID: <xmqq7dr3wrwm.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C8098586-1D36-11EB-AC24-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sergey Organov <sorganov@gmail.com> writes:

> First, references to --patch and -p appeared in the description of
> git-format-patch, where the options themselves are not included.

Fun.  The -U<n> option in "git diff-index -U9" implicitly turns
"--patch" on, but it is hard to say that the same option in "git
format-patch -U9" turns "--patch" on, as it is in effect even
without the -U<n> option.

It makes readers wonder what, if anything, needs to be done for "git
diff -U9", but let's leave it out of the scope of this change, which
is strict improvement for "format-patch" documentation.

Thanks.

> Next, the description of --unified option elsewhere had duplicate implied
> statements: "Implies --patch. Implies -p."
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  Documentation/diff-options.txt | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
> index 573fb9bb71e2..320304033483 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -36,9 +36,9 @@ endif::git-format-patch[]
>  -U<n>::
>  --unified=<n>::
>  	Generate diffs with <n> lines of context instead of
> -	the usual three. Implies `--patch`.
> +	the usual three.
>  ifndef::git-format-patch[]
> -	Implies `-p`.
> +	Implies `--patch`.
>  endif::git-format-patch[]
>  
>  --output=<file>::
> @@ -441,7 +441,10 @@ endif::git-format-patch[]
>  
>  --binary::
>  	In addition to `--full-index`, output a binary diff that
> -	can be applied with `git-apply`. Implies `--patch`.
> +	can be applied with `git-apply`.
> +ifndef::git-format-patch[]
> +	Implies `--patch`.
> +endif::git-format-patch[]
>  
>  --abbrev[=<n>]::
>  	Instead of showing the full 40-byte hexadecimal object
