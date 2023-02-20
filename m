Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 130F7C636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 09:31:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjBTJbi (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 04:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229646AbjBTJbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 04:31:37 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0BC6E9F
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:31:35 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id bg25-20020a05600c3c9900b003e21af96703so1369238wmb.2
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 01:31:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mjOm5i4dwY49y2bRFYb6wICU7XrFDlVQl8wbHPX+tiI=;
        b=TmnwAaD7XOkkzsy/v0y/P2sLR3dHKFjYkaRKodpYy21bY8AyfrPNkotLAwD9tUGLMf
         t/8pX3OOZE2FybbtZLbTJtMqUvs6nFYyciAf60BWa3dzlFxRTK/1V2zXTF2QqWaTVk4B
         a7KUtf4ZfPR/1BkX1Gq5p/t2a2lN4komL31XbGvejDkXTiIZPtwFtacZNLI+Y872nI3v
         dDqDVlVatIMEHe7390RpLSLopURxAhbuwjFlmLhp+N4PR8zNbeVCQcMC9snU99vD4h0g
         upgWcyaR8sKW7Zb5zNyFWsALyPVrYCwFXZq7hACOiDAcCk4zyKYaxBkvL7SrwF32wOCa
         y8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mjOm5i4dwY49y2bRFYb6wICU7XrFDlVQl8wbHPX+tiI=;
        b=TtiiSX7FiZq4fxDRzeafHzipQVJfkuDi64ml8KAiSBpT5lRrf1kR5qUUnfb8v4oYcd
         kqoG19VH6pMwxgfDAH60ikelTSLeSntDW/FcArnOWWsQgTM8RL+EbbB4xKlZGdFN/cWz
         ziRBmLOXGKrqnIDdJcUGAHgaUAfqgDPEN15IkWDgtswE/0cocXg6d6ZrJ3tToMfi3cyR
         o5nuKu7LT86I57QwOfr9KaoMw2t0qoMnKh9lVZ/WwHHie+KlRVSLjrZ6yL1SqCcccd/X
         nVTq4kgXZAWtz70Zgm7nu9S6XF9g170Bhd5wOkm1lfBKNJNija/Bqf7OClg5wIMr+wpy
         2uzQ==
X-Gm-Message-State: AO0yUKWc0k79bbxK0szrjCWcFmu0sw90zRQ+QvMZNmwegJ3xzYTDTaeR
        CifqVyeKQgQn3H+ZY0HfJWg=
X-Google-Smtp-Source: AK7set+ljTLN+jU3+ZYiNY09k8g6qk1FDPjuX0Pb3TqUKVkxgn5ZnCCf0JxdParWWLILpcsge/K/rw==
X-Received: by 2002:a05:600c:755:b0:3e2:1fe9:8d1b with SMTP id j21-20020a05600c075500b003e21fe98d1bmr8111077wmn.6.1676885494274;
        Mon, 20 Feb 2023 01:31:34 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c0b5a00b003e20970175dsm301721wmr.32.2023.02.20.01.31.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 01:31:33 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <8857003a-f33d-00c5-5e1e-bfbcd60924ae@dunelm.org.uk>
Date:   Mon, 20 Feb 2023 09:31:30 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/2] rebase: add a --rebase-merges=drop option
Content-Language: en-US
To:     Alex Henrie <alexhenrie24@gmail.com>, git@vger.kernel.org,
        tao@klerks.biz, gitster@pobox.com, newren@gmail.com,
        phillip.wood123@gmail.com, Johannes.Schindelin@gmx.de
References: <20230220033224.10400-1-alexhenrie24@gmail.com>
In-Reply-To: <20230220033224.10400-1-alexhenrie24@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Alex

On 20/02/2023 03:32, Alex Henrie wrote:
> Name the new option "drop" intead of "no" or "false" to avoid confusion > in the future if --rebase-merges grows the ability to truly "rebase"
> merge commits by reusing the conflict resolution information from the
> original merge commit, and we want to add an option to ignore the
> conflict resolution information.
> 
> This option can be used to countermand a previous --rebase-merges
> option.

I'm a bit confused as to the reason for this change - what's the 
advantage over just saying --no-rebase-merges which already exists?

Best Wishes

Phillip

> Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
> ---
>   Documentation/git-rebase.txt |  2 +-
>   builtin/rebase.c             |  2 +-
>   t/t3430-rebase-merges.sh     | 30 ++++++++++++++++++++++++++++++
>   3 files changed, 32 insertions(+), 2 deletions(-)
> 
> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 9a295bcee4..92e90f96aa 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -528,7 +528,7 @@ have the long commit hash prepended to the format.
>   See also INCOMPATIBLE OPTIONS below.
>   
>   -r::
> ---rebase-merges[=(rebase-cousins|no-rebase-cousins)]::
> +--rebase-merges[=(rebase-cousins|no-rebase-cousins|drop)]::
>   	By default, a rebase will simply drop merge commits from the todo
>   	list, and put the rebased commits into a single, linear branch.
>   	With `--rebase-merges`, the rebase will instead try to preserve
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 6635f10d52..96c0474379 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1436,7 +1436,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>   	if (options.exec.nr)
>   		imply_merge(&options, "--exec");
>   
> -	if (rebase_merges) {
> +	if (rebase_merges && strcmp("drop", rebase_merges)) {
>   		if (!*rebase_merges)
>   			; /* default mode; do nothing */
>   		else if (!strcmp("rebase-cousins", rebase_merges))
> diff --git a/t/t3430-rebase-merges.sh b/t/t3430-rebase-merges.sh
> index fa2a06c19f..861c8405f2 100755
> --- a/t/t3430-rebase-merges.sh
> +++ b/t/t3430-rebase-merges.sh
> @@ -250,6 +250,36 @@ test_expect_success 'with a branch tip that was cherry-picked already' '
>   	EOF
>   '
>   
> +test_expect_success 'do not rebase merges unless asked' '
> +	git checkout -b rebase-merges-default E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before &&
> +	test_tick &&
> +	git rebase C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
> +test_expect_success 'do not rebase merges when asked to drop them' '
> +	git checkout -b rebase-merges-drop E &&
> +	before="$(git rev-parse --verify HEAD)" &&
> +	test_tick &&
> +	git rebase --rebase-merges C &&
> +	test_cmp_rev HEAD $before &&
> +	test_tick &&
> +	git rebase --rebase-merges=drop C &&
> +	test_cmp_graph C.. <<-\EOF
> +	* B
> +	* D
> +	o C
> +	EOF
> +'
> +
>   test_expect_success 'do not rebase cousins unless asked for' '
>   	git checkout -b cousins main &&
>   	before="$(git rev-parse --verify HEAD)" &&
