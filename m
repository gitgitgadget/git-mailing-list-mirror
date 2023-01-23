Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A42CC05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 20:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232983AbjAWUI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 15:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232308AbjAWUI6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 15:08:58 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBABE305E1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:08:54 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id az20so33655886ejc.1
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 12:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IGzxkK8bST90pB1Sf+NK7LtYSnMNdmoNyJkH4zymZCc=;
        b=Jqy8peq3XPIEUb0Ab9fsHtR5v+kbz05jVBjmOYNANqg9ov+p1SQJM/47lzY9TDfpfc
         a542lSQZkulZmFbpdIDsXKiOc4x6xoEMHlglCxnUQ8/mWSQjCySdHIxQyUKWIQRhu1Tc
         IWGO49MrHTIsXBvtgyKww2w3gYsOBRTu2U280Ji7AmC4dgSMvRN+NR3cwgeMiP4hz5zV
         bjMkQtwfjc6ItGuXGcZdIEaR5wWFVa9TgYXd4d2GihvuPj+tEiTf8BjLNaNAY7Y51lIq
         XgHhx1Q6FSld6+x/JR4pe4mohL7gkRH0Qi4Lxyw8VgUmmeqy51ZVDlsz/aYSkCV22wRr
         pBHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IGzxkK8bST90pB1Sf+NK7LtYSnMNdmoNyJkH4zymZCc=;
        b=P0/9/WenjZUy4RxAHU2WO/F9IcCbcql2cLyQTikjMY9e57S8o8BPUGUylUb7/kFL9s
         5wVWSqNerSF/dQsvWHsggNkDnO6m4Vz7wlUvSu3tXJ6Xm7yNyfj9E0Qsd3/+uBsxO5At
         sU/9JGqMnUlgfFhFlngnEYmrWV1W0pDCPHLIWtBarLn1FaZpUBKIoyzRr73FB66l5mRP
         do7HlMttUcJ7MorS06HfRpnwZItTG596kQ4vGDMngSIuwkxjnueqNVMzzpASmt+0w2tS
         E4RBybDMbunuwqccJAp3xY7vstOmGgS5Avy8v+JNm2Bx65hIxiy92B+g7kX/dn74uvCm
         4piw==
X-Gm-Message-State: AFqh2kq22g2QPGyGk0UehDNreZY40cCkzk+6QK5u5UVxEJUEmfofEyEy
        qlmWiPwQGC3LCnm4S7bBJfI=
X-Google-Smtp-Source: AMrXdXtFGz75P2nyJb8QDNqOdkRMmjDMcLHkUa4Cd5Fp19cpJP7bfmPYCjMIQ/Al+PZxOivaX53yIg==
X-Received: by 2002:a17:907:bb92:b0:871:89d:75e with SMTP id xo18-20020a170907bb9200b00871089d075emr28708912ejc.16.1674504533468;
        Mon, 23 Jan 2023 12:08:53 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id re7-20020a170907a2c700b00877df3eea64sm194753ejc.155.2023.01.23.12.08.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 12:08:53 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <759fb313-ce88-4eb7-96c0-4adeb75ca9f9@dunelm.org.uk>
Date:   Mon, 23 Jan 2023 20:08:50 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 5/9] rebase: add coverage of other incompatible options
Content-Language: en-US
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
 <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
In-Reply-To: <5e4851e611ee18112bd71939ee900e02a8d590c5.1674367961.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 22/01/2023 06:12, Elijah Newren via GitGitGadget wrote:
> From: Elijah Newren <newren@gmail.com>
> 
> The git-rebase manual noted several sets of incompatible options, but
> we were missing tests for a few of these.  Further, we were missing
> code checks for some of these, which could result in command line
> options being silently ignored.
> 
> Also, note that adding a check for autosquash means that using
> --whitespace=fix together with the config setting rebase.autosquash=true
> will trigger an error.  A subsequent commit will improve the error
> message.

Thanks for updating the commit message and for the new commits at the 
end of the series.

> Signed-off-by: Elijah Newren <newren@gmail.com>
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1224,6 +1224,26 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   		if (options.fork_point < 0)
>   			options.fork_point = 0;
>   	}
> +	/*
> +	 * The apply backend does not support --[no-]reapply-cherry-picks.
> +	 * The behavior it implements by default is equivalent to
> +	 * --no-reapply-cherry-picks (due to passing --cherry-picks to
> +	 * format-patch), but --keep-base alters the upstream such that no
> +	 * cherry-picks can be found (effectively making it act like
> +	 * --reapply-cherry-picks).
> +	 *
> +	 * Now, if the user does specify --[no-]reapply-cherry-picks, but
> +	 * does so in such a way that options.reapply_cherry_picks ==
> +	 * keep_base, then the behavior they get will match what they
> +	 * expect despite options.reapply_cherry_picks being ignored.  We
> +	 * could just allow the flag in that case, but it seems better to
> +	 * just alert the user that they've specified a flag that the
> +	 * backend ignores.
> +	 */

I'm a bit confused by this. --keep-base works with either 
--reapply-cherry-picks (which is the default if --keep-base is given) or 
--no-reapply-cherry-picks. Just below this hunk we have

	if (options.reapply_cherry_picks < 0)
		options.reapply_cherry_picks = keep_base;

So we only set options.reapply_cherry_picks to match keep_base if the 
user did not specify -[-no]-reapply-cherry-picks on the commandline.

Best Wishes

Phillip

> +	if (options.reapply_cherry_picks >= 0)
> +		imply_merge(&options, options.reapply_cherry_picks ? "--reapply-cherry-picks" :
> +								     "--no-reapply-cherry-picks");
> +
>   	/*
>   	 * --keep-base defaults to --reapply-cherry-picks to avoid losing
>   	 * commits when using this option.
> @@ -1406,13 +1426,6 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.empty != EMPTY_UNSPECIFIED)
>   		imply_merge(&options, "--empty");
>   
> -	/*
> -	 * --keep-base implements --reapply-cherry-picks by altering upstream so
> -	 * it works with both backends.
> -	 */
> -	if (options.reapply_cherry_picks && !keep_base)
> -		imply_merge(&options, "--reapply-cherry-picks");
> -
>   	if (gpg_sign)
>   		options.gpg_sign_opt = xstrfmt("-S%s", gpg_sign);
>   
> @@ -1503,6 +1516,9 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.update_refs)
>   		imply_merge(&options, "--update-refs");
>   
> +	if (options.autosquash)
> +		imply_merge(&options, "--autosquash");
> +
>   	if (options.type == REBASE_UNSPECIFIED) {
>   		if (!strcmp(options.default_backend, "merge"))
>   			imply_merge(&options, "--merge");
> diff --git a/t/t3422-rebase-incompatible-options.sh b/t/t3422-rebase-incompatible-options.sh
> index f86274990b0..6a17b571ec7 100755
> --- a/t/t3422-rebase-incompatible-options.sh
> +++ b/t/t3422-rebase-incompatible-options.sh
> @@ -50,6 +50,11 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --strategy-option=ours A
>   	"
>   
> +	test_expect_success "$opt incompatible with --autosquash" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --autosquash A
> +	"
> +
>   	test_expect_success "$opt incompatible with --interactive" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --interactive A
> @@ -60,6 +65,26 @@ test_rebase_am_only () {
>   		test_must_fail git rebase $opt --exec 'true' A
>   	"
>   
> +	test_expect_success "$opt incompatible with --keep-empty" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --keep-empty A
> +	"
> +
> +	test_expect_success "$opt incompatible with --empty=..." "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --empty=ask A
> +	"
> +
> +	test_expect_success "$opt incompatible with --no-reapply-cherry-picks" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --no-reapply-cherry-picks A
> +	"
> +
> +	test_expect_success "$opt incompatible with --reapply-cherry-picks" "
> +		git checkout B^0 &&
> +		test_must_fail git rebase $opt --reapply-cherry-picks A
> +	"
> +
>   	test_expect_success "$opt incompatible with --update-refs" "
>   		git checkout B^0 &&
>   		test_must_fail git rebase $opt --update-refs A
