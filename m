Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99915ECAAA1
	for <git@archiver.kernel.org>; Tue, 30 Aug 2022 13:27:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbiH3N1M (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 30 Aug 2022 09:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230208AbiH3N0z (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2022 09:26:55 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8015ABF5B
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:26:35 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e20so14191143wri.13
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 06:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc;
        bh=kD6CTFU/L7ofVTg2EMD4NE9uDBRzIOwKZz0MIKHsPGw=;
        b=LHE9kyrres23mxIZ6Hh3u9MOrPx5xNouojgFK/zPiEtxXeV1KUCapxw84NzdsCa/I4
         LodznMmqDu53v5XXc2zVoAQZ/V11CXkque4u1+6xivwjOXiSS64kw1W3M9TkSZirNSOs
         zzwrUI7Y/366dhJPetR1+ZNEUi7nxxdhHyJ4uSvREFwyYo4Phg/s4SEdiTjIgcHU8XEj
         g4KG3H0NOJsuV8iLTRAzdWr/DlH/O0PvJb2W2Xr2ibveyAl+ExmP2S7/bOCSdBQ8PY3l
         PB2zw/SDfWWB8CgT+D1mOPdHgNqPF1Zod9tjK7Q6H12x+UCwPaMV6rVsyIJCUhRSJwmz
         qVxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=kD6CTFU/L7ofVTg2EMD4NE9uDBRzIOwKZz0MIKHsPGw=;
        b=BGukWtB+jHXJBd9wWo8JSQ7sqS9gPTXHUhylUyiy1bJ8sLlabfNTppsK4s9VxWZ2L9
         HGRKx6UXauixBa3vrE2R+gOdJ5+kbz/PvOy9oawhNmLCzurWvNmelW+mZfQdi9H+evWD
         IiZ+v0Q0iwZboccgMClF3irrqqQgAMkLUlr82Vhcw/iC2zgUPE34lLxvAoYC1FLWXf72
         0bsWYEP3ulefuEjtvNtlpo/6jZp2t6NCmlhVRohVIcGVihWcbN12AXqsnEdqww5UW/jw
         A318dHeR32K/gvtrvr6HK14SuK7cy2JdNlYGkiCBaRy8y+1zO5r3SBeeakmPAiik0kVZ
         RN/g==
X-Gm-Message-State: ACgBeo2L8+ATbsWIN5GYOrg24VL+D9nVxKg/eKLTfmsb0cu9Js46qFbv
        KOtVJvtr6Hre7Nbp6Ae1LCY=
X-Google-Smtp-Source: AA6agR6lUEdnfGnboFYWB7tput/1wO1wnnNh0KTykeG1EY6iT7G/99aCJpRbUh8j/0wN3V8GkyldJg==
X-Received: by 2002:a05:6000:52:b0:226:d497:d1a1 with SMTP id k18-20020a056000005200b00226d497d1a1mr7918513wrx.431.1661865989979;
        Tue, 30 Aug 2022 06:26:29 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id c18-20020adffb52000000b00225239d9265sm9843592wrs.74.2022.08.30.06.26.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Aug 2022 06:26:29 -0700 (PDT)
Message-ID: <c205f8e2-62f9-d4b2-0ccf-51dcabc12224@gmail.com>
Date:   Tue, 30 Aug 2022 14:26:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 5/5] add -p: ignore dirty submodules
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1336.v2.git.1661376112.gitgitgadget@gmail.com>
 <pull.1336.v3.git.1661785916.gitgitgadget@gmail.com>
 <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <cfa6914aee0d3ef84d726b97699f438fd4b254d9.1661785916.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

On 29/08/2022 16:11, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> Thanks to alwyas running `diff-index` and `diff-files` with the
> `--numstat` option (the latter with `--ignore-submodules=dirty`) before
> even generating any real diff to parse, the Perl version of `git add -p`
> simply ignored dirty submodules and does not even offer them up for
> staging.

I had a bit of a hard time understanding this paragraph. To me the fact 
that the perl version is using --numstat is not that important here, 
what is important is that it is using --ignore-submodules=dirty when it 
generates its list of files to show and that information is consigned to 
a parenthesized aside.

The fix itself looks good.

Best Wishes

Phillip

> However, the built-in variant did not use that flag because it tries to
> run only one `diff` command, skipping the unneeded
> `diff-index`/`diff-files` invocation of the Perl variant and therefore
> only faithfully recapitulates what the Perl code does once it _does_
> generate and parse the real diff.
> 
> This causes a problem when running the built-in `add -p` with
> `diff-so-fancy` because that diff colorizer always inserts an empty line
> before the diff header to ensure that it produces 4 lines as expected by
> `git add -p` (the equivalent of the non-colorized `diff`, `index`, `---`
> and `+++` lines). But `git diff-files` does not produce any `index` line
> for dirty submodules.
> 
> The underlying problem is not even the discrepancy in lines, but that
> `git add -p` presents diffs for dirty submodules: there is nothing that
> _can_ be staged for those.
> 
> Let's fix that bug, and teach the built-in `add -p` to ignore dirty
> submodules, too. This _incidentally_ also fixes the `diff-so-fancy`
> problem ;-)
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>   add-patch.c                |  3 ++-
>   t/t3701-add-interactive.sh | 12 ++++++++++++
>   2 files changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/add-patch.c b/add-patch.c
> index 0217cdd7c4a..ee6a3d3b712 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -426,7 +426,8 @@ static int parse_diff(struct add_p_state *s, const struct pathspec *ps)
>   	}
>   	color_arg_index = args.nr;
>   	/* Use `--no-color` explicitly, just in case `diff.color = always`. */
> -	strvec_pushl(&args, "--no-color", "-p", "--", NULL);
> +	strvec_pushl(&args, "--no-color", "--ignore-submodules=dirty", "-p",
> +		     "--", NULL);
>   	for (i = 0; i < ps->nr; i++)
>   		strvec_push(&args, ps->items[i].original);
>   
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index 39e68b6d066..a4f45fc48a0 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -965,6 +965,18 @@ test_expect_success 'status ignores dirty submodules (except HEAD)' '
>   	! grep dirty-otherwise output
>   '
>   
> +test_expect_success 'handle submodules' '
> +	echo 123 >>for-submodules/dirty-otherwise/initial.t &&
> +
> +	force_color git -C for-submodules add -p dirty-otherwise >output 2>&1 &&
> +	grep "No changes" output &&
> +
> +	force_color git -C for-submodules add -p dirty-head >output 2>&1 <y &&
> +	git -C for-submodules ls-files --stage dirty-head >actual &&
> +	rev="$(git -C for-submodules/dirty-head rev-parse HEAD)" &&
> +	grep "$rev" actual
> +'
> +
>   test_expect_success 'set up pathological context' '
>   	git reset --hard &&
>   	test_write_lines a a a a a a a a a a a >a &&
