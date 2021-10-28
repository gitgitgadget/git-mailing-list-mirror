Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0C71C433F5
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 13:58:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D69D8610A0
	for <git@archiver.kernel.org>; Thu, 28 Oct 2021 13:58:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbhJ1OAg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Oct 2021 10:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231247AbhJ1OA2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Oct 2021 10:00:28 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A058C061767
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 06:58:01 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 71so3631912wma.4
        for <git@vger.kernel.org>; Thu, 28 Oct 2021 06:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vmRkO86tSUTdabOYy42uRqbFE6qZ6AYPuGI7BpodQlE=;
        b=ntqOtkb8S0M1RK5Jl5yvNaxxRH2ZHucHU2KeVYdIsKQepdrS6E9E4wqFHWQpYyWYJq
         bUqfq0nIJCcZNm9OgoAv6ZrJadmKTeymrE9WiWa7qxBgk92yYcoIa3wFYTvhwdHh43q1
         rtl3rfW7k5Q23Kt9C0ihTHNcu/OPm/gmBhpymSoc/0vlcPqP7he0rwtvKYFFfuECFFML
         I8AG62DzoiW9y2nO3PerWg1fH8s4dqwSo2SNR/4KnUH7KQ7PMpd5HQCvS+zCwKhIZ5X9
         +lAoXPCY4T1oVTgOj4aabfGvfXovRVyYm8Iortd0LoU8O8DFd76eGfyj0cS4ZTeMpXe1
         1nmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=vmRkO86tSUTdabOYy42uRqbFE6qZ6AYPuGI7BpodQlE=;
        b=MLuNVSPDVHL9ZsT2vD9TwANBEZyNLF1lUbSI9imQbZPJ29N+Vq/XXQkQe3ZK+4AF8g
         blzIT7/r9GwcVV1Ayh+Q0Un3y9iC2/oZOvQO0clLlBXNMKYJNbFGIjlqT9vMSpyIC1se
         V7/HG478Hc1El+WJgCsYW5xOPCJejF9jO+4eJwb0RxaelHMv2Z3DFTA/aNv9iKfM8OMT
         0iMA/r38hTcrzwJ6GSt2icgLSuqOcj18rp7jeBIz9GI0YDj7JCNpKb9QiSumhEXNvPu2
         PnYrmht9ayBJw/4UA1qF4kXsjWf0WO1nvt1bcQAGCot6B9mgc5/JYQ+giohm0Yf05lPV
         3HNQ==
X-Gm-Message-State: AOAM5322DhGlqgWS6FETXPnTbZJ5Q+A+CbBemBxY7ykh5RWCO16BepdN
        ySEbHosJlaChGwJYPqdk4ys3PuLp9dE=
X-Google-Smtp-Source: ABdhPJyXTXmZpPnajNDZRaapm7fGxaj5GUevuKSku0Xw404PPvOv4FeBtWKirr2A1cjgHU8QwRB5Dw==
X-Received: by 2002:a05:600c:2dc1:: with SMTP id e1mr169765wmh.170.1635429479762;
        Thu, 28 Oct 2021 06:57:59 -0700 (PDT)
Received: from [192.168.1.240] ([31.185.185.186])
        by smtp.gmail.com with ESMTPSA id r27sm3190185wrr.70.2021.10.28.06.57.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Oct 2021 06:57:59 -0700 (PDT)
Message-ID: <edca7f6b-e89c-7efa-c6f5-2c3aaaea54f9@gmail.com>
Date:   Thu, 28 Oct 2021 14:57:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] Remove negation from the commit and merge option
 "--no-verify"
Content-Language: en-GB-large
To:     Alex Riesen <alexander.riesen@cetitec.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>
References: <YXfwanz3MynCLDmn@pflmari>
 <YXhwGQOTfD+ypbo8@coredump.intra.peff.net> <YXlBhmfXl3wFQ5Bj@pflmari>
 <YXlD5ecNSdeBSMoS@coredump.intra.peff.net> <YXlTpzrY7KFqRlno@pflmari>
 <xmqq4k92w7do.fsf@gitster.g> <YXpFTJTo0pKhM7xG@pflmari>
 <YXpZddOixrJDd//s@pflmari>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <YXpZddOixrJDd//s@pflmari>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 28/10/2021 09:04, Alex Riesen wrote:
> From: Alex Riesen <raa.lkml@gmail.com>
> 
> This allows re-enabling of the hooks disabled by an earlier "--no-verify"
> in command-line and makes the interface more consistent.

Thanks for working on this. Since 0f1930c587 ("parse-options: allow 
positivation of options starting, with no-", 2012-02-25) merge and 
commit have accepted "--verify" but it is undocumented. The 
documentation updates and fix to pull in this patch are very welcome, 
but I'm not sure we need the other changes. I've left a couple of 
comments below.

[As an aside we should probably improve the documentation in 
parse-options.h if both Peff and Junio did not know how it handles 
"--no-foo" but that is outside the scope of this patch]

> Incidentally, this also fixes unexpected calling of the hooks by "git
> pull" when "--no-verify" was specified, where it was incorrectly
> translated to "--no-verify-signatures". This caused the unexpected
> effect of the hooks being called. And an even more unexpected effect of
> disabling verification of signatures.

Ouch!

> Signed-off-by: Alexander Riesen <raa.lkml@gmail.com>
>[...]
> diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
> index a3baea32ae..ba66209274 100644
> --- a/Documentation/git-commit.txt
> +++ b/Documentation/git-commit.txt
> @@ -11,7 +11,7 @@ SYNOPSIS
>   'git commit' [-a | --interactive | --patch] [-s] [-v] [-u<mode>] [--amend]
>   	   [--dry-run] [(-c | -C | --fixup | --squash) <commit>]
>   	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
> -	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
> +	   [--allow-empty-message] [--[no-]verify] [-e] [--author=<author>]

I think for the synopsis it is fine just to list the most common 
options. Having --no-verify without the [no-] makes it clear that 
--verify is the default so is not a commonly used option.

>   	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
>   	   [-i | -o] [--pathspec-from-file=<file> [--pathspec-file-nul]]
>   	   [-S[<keyid>]] [--] [<pathspec>...]
> @@ -174,7 +174,13 @@ The `-m` option is mutually exclusive with `-c`, `-C`, and `-F`.
>   
>   -n::
>   --no-verify::
> -	This option bypasses the pre-commit and commit-msg hooks.
> +	By default, pre-merge and commit-msg hooks are run. When one of these

I think saying "the pre-merge and commit-msg hooks" would be clearer as 
you do below.

> +	options is given, these are bypassed.
> +	See also linkgit:githooks[5].
> +
> +--verify::
> +	This option re-enables running of the pre-commit and commit-msg hooks
> +	after an earlier `-n` or `--no-verify`.
>   	See also linkgit:githooks[5].

Some of the existing documentation describes the "--no-foo" option with 
"--foo" (e.g --[no-]signoff) but in other places we list the two options 
separately (e.g. --[no-]edit), I'd lean towards combining them as you 
have done for the merge documentation but I don't feel strongly about it.

>   --allow-empty::
> diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
> index 3819fadac1..324ae879d2 100644
> --- a/Documentation/git-merge.txt
> +++ b/Documentation/git-merge.txt
> @@ -10,7 +10,7 @@ SYNOPSIS
>   --------
>   [verse]
>   'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
> -	[--no-verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
> +	[--[no-]verify] [-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]

Again I'm not sure changing the synopsis makes things clearer.

>   	[--[no-]allow-unrelated-histories]
>   	[--[no-]rerere-autoupdate] [-m <msg>] [-F <file>] [<commit>...]
>   'git merge' (--continue | --abort | --quit)
> diff --git a/Documentation/merge-options.txt b/Documentation/merge-options.txt
> index 80d4831662..f8016b0f7b 100644
> --- a/Documentation/merge-options.txt
> +++ b/Documentation/merge-options.txt
> @@ -112,8 +112,9 @@ option can be used to override --squash.
>   +
>   With --squash, --commit is not allowed, and will fail.
>   
> ---no-verify::
> -	This option bypasses the pre-merge and commit-msg hooks.
> +--[no-]verify::
> +	By default, pre-merge and commit-msg hooks are run. When `--no-verify`

I think "the pre-merge ..." would be better here as well.

> +	is given, these are bypassed.
>   	See also linkgit:githooks[5].
>[...]   
> diff --git a/t/t5521-pull-options.sh b/t/t5521-pull-options.sh
> index db1a381cd9..7d3a8ae0d3 100755
> --- a/t/t5521-pull-options.sh
> +++ b/t/t5521-pull-options.sh
> @@ -225,4 +225,16 @@ test_expect_success 'git pull --no-signoff flag cancels --signoff flag' '
>   	test_must_be_empty actual
>   '
>   
> +test_expect_success 'git pull --no-verify flag passed to merge' '
> +	test_when_finished "rm -fr src dst actual" &&
> +	git init src &&
> +	test_commit -C src one &&
> +	git clone src dst &&
> +	write_script dst/.git/hooks/commit-msg <<-\EOF &&
> +	false
> +	EOF
> +	test_commit -C src two &&
> +	git -C dst pull --no-ff --no-verify
> +'

Thanks for adding a test

>   test_done
> diff --git a/t/t7504-commit-msg-hook.sh b/t/t7504-commit-msg-hook.sh
> index 31b9c6a2c1..166ff5fb26 100755
> --- a/t/t7504-commit-msg-hook.sh
> +++ b/t/t7504-commit-msg-hook.sh
> @@ -130,6 +130,14 @@ test_expect_success '--no-verify with failing hook' '
>   
>   '
>   
> +test_expect_success '-n with failing hook' '
> +
> +	echo "more" >> file &&
> +	git add file &&
> +	git commit -n -m "more"
> +
> +'

Is this to check that "-n" works like "--no-verify"?

I think it would be very useful to add another test that checks 
"--verify" overrides "--no-verify".

Best Wishes

Phillip
