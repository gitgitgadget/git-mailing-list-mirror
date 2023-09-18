Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E34CCD13D3
	for <git@archiver.kernel.org>; Mon, 18 Sep 2023 09:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240944AbjIRJy2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 Sep 2023 05:54:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241073AbjIRJyF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Sep 2023 05:54:05 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB03812B
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 02:53:52 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-502934c88b7so7035541e87.2
        for <git@vger.kernel.org>; Mon, 18 Sep 2023 02:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695030829; x=1695635629; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=w3gZy/33GbIYPAhYqlzFvh1b+kqAPWKl+mH8ZFfUmHE=;
        b=bhbG4glm3t/mQ7/YyIAPsqZGexZorG/kHrnlu1kR5GpdnGl6CkOa76h34dFkujA65/
         JY16x31WkUtF1tZn7e6m4GftLYOK87ZAud1n28wn9CX6nL6HytWEVJeYfaiFDIq/aJtt
         1XIzEJ6otEvlK2oVF2n7WoxxWfFUjoQ2UlovkVRpE40UqB0xJGIHjaWNYClcEIC6bciJ
         Qu7uUxBeJaq0H6KJuVhxiAOo+9OLPatRbMlN7dhm+kpLB6f9+eLut+gsZlWcfEsaW8YX
         A8cyWHPcfSMPYDvBwjRh4NegkHEGKtRyZHqjdvt4r2MHt7CLMQ/50nKMX5GljnrH9QpD
         WIJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695030829; x=1695635629;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w3gZy/33GbIYPAhYqlzFvh1b+kqAPWKl+mH8ZFfUmHE=;
        b=JbS1uitpboMDxaXFdWoDl8wtgjk/wzfHT0fV3XF6vZ88cdldxndMcGhfFfPPk0lCml
         xNggZSHdnvt+kQ9NX5KX1uMC/gBAr06cvngNPv1N9vK0azIM7QTxX16tp2uB5nWW0r03
         m4C3M1obUIKULCEUoSq7Syfw3kRzqwWByNWLPESowCGwv3WyX0NVQ+WZ0ctZ0kfvaEm7
         AOWnjA7EOswt9xzAzfD5TJotM8+1EdlMkmeGAXtaILvcVekxmnLMf3P7lgsO8E/hOoNg
         KUeC8sccZyZS4g5DVKZBM8XCgiQfEy+ZsYEdtk2aLxqsaGUHxQr9l2P7hooWcv7rtxVh
         NhuQ==
X-Gm-Message-State: AOJu0YyPHq26FQir9/bV5ExefAL6RLbobgXKp0If5cg44/IyLiizD8cM
        +CQHHFv9O9v2yFSmsHasrCYQCevLzTJ8og==
X-Google-Smtp-Source: AGHT+IGsbaw2kPWHUdnTQDT8+zadMzeduOCwH39Vdl3yNk7GnjRZL2InGQpXRAanT3R9ILIUzo+0Fg==
X-Received: by 2002:a05:6512:3d27:b0:503:5d8:da33 with SMTP id d39-20020a0565123d2700b0050305d8da33mr5674070lfv.20.1695030828925;
        Mon, 18 Sep 2023 02:53:48 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id z25-20020a1c4c19000000b003fe29f6b61bsm11838149wmf.46.2023.09.18.02.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Sep 2023 02:53:48 -0700 (PDT)
Message-ID: <67638fd7-ad63-4e20-87e1-bef121fef197@gmail.com>
Date:   Mon, 18 Sep 2023 10:53:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v5] merge-tree: add -X strategy option
To:     Izzy via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
        Izzy <winglovet@gmail.com>
References: <pull.1565.v4.git.1694836025469.gitgitgadget@gmail.com>
 <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <pull.1565.v5.git.1694853437494.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/09/2023 09:37, Izzy via GitGitGadget wrote:
> From: Tang Yuyi <winglovet@gmail.com>
> 
> Add merge strategy option to produce more customizable merge result such
> as automatically resolving conflicts.

I think adding a merge strategy option to merge-tree is a good idea, but 
have you tested this with anything apart from -Xours or -Xtheirs? It 
looks to me like those are the only two that this patch supports. If you 
look at parse_merge_opt() in merge-recursive.c you will see that there 
are many other options. In order to support all the merge options I 
think this patch needs a bit of refactoring.

> diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
> index 0de42aecf4b..97d0fe6c952 100644
> --- a/builtin/merge-tree.c
> +++ b/builtin/merge-tree.c
>   static int real_merge(struct merge_tree_options *o,
> @@ -439,6 +441,8 @@ static int real_merge(struct merge_tree_options *o,
>   
>   	init_merge_options(&opt, the_repository);
>   
> +	opt.recursive_variant = o->merge_options.recursive_variant;
> +

Rather that copying across individual members I think you should 
initialize o->merge_options properly in cmd_merge_tree() by calling 
init_merge_options() and then use o->merge_options instead of "opt" in 
this function. That way all the strategy options will be supported.

>   	opt.show_rename_progress = 0;
>   
>   	opt.branch1 = branch1;
> @@ -513,6 +517,7 @@ static int real_merge(struct merge_tree_options *o,
>   int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>   {
>   	struct merge_tree_options o = { .show_messages = -1 };
> +	struct strvec xopts = STRVEC_INIT;
>   	int expected_remaining_argc;
>   	int original_argc;
>   	const char *merge_base = NULL;
> @@ -548,6 +553,8 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
>   			   &merge_base,
>   			   N_("commit"),
>   			   N_("specify a merge-base for the merge")),
> +		OPT_STRVEC('X', "strategy-option", &xopts, N_("option=value"),
> +			N_("option for selected merge strategy")),
>   		OPT_END()
>   	};
>   
> @@ -556,6 +563,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)

You should add

	init_merge_options(&o.merge_options);

here to ensure it is properly initialized.

>   	argc = parse_options(argc, argv, prefix, mt_options,
>   			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);

This is the right place to call parse_merge_opt() but I think we should 
first check that the user has requested a real merge rather than a 
trivial merge.

	if (xopts.nr && o.mode == MODE_TRIVIAL)
		die(_("--trivial-merge is incompatible with all other options"));

Otherwise if the user passes in invalid strategy option to a trivial 
merge they'll get an error about an invalid strategy option rather than 
being told --strategy-option is not supported with --trivial-merge.

Ideally there would be a preparatory patch that moves the switch 
statement that is below the "if(o.use_stdin)" block up to this point so 
we'd always have set o.mode before checking if it is a trivial merge. (I 
think you'd to change the code slightly when it is moved to add a check 
for o.use_stdin)

Best Wishes

Phillip

> +	for (int x = 0; x < xopts.nr; x++)
> +		if (parse_merge_opt(&o.merge_options, xopts.v[x]))
> +			die(_("unknown strategy option: -X%s"), xopts.v[x]);
> +
>   	/* Handle --stdin */
>   	if (o.use_stdin) {
>   		struct strbuf buf = STRBUF_INIT;
> diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
> index 250f721795b..b2c8a43fce3 100755
> --- a/t/t4301-merge-tree-write-tree.sh
> +++ b/t/t4301-merge-tree-write-tree.sh
> @@ -22,6 +22,7 @@ test_expect_success setup '
>   	git branch side1 &&
>   	git branch side2 &&
>   	git branch side3 &&
> +	git branch side4 &&
>   
>   	git checkout side1 &&
>   	test_write_lines 1 2 3 4 5 6 >numbers &&
> @@ -46,6 +47,13 @@ test_expect_success setup '
>   	test_tick &&
>   	git commit -m rename-numbers &&
>   
> +	git checkout side4 &&
> +	test_write_lines 0 1 2 3 4 5 >numbers &&
> +	echo yo >greeting &&
> +	git add numbers greeting &&
> +	test_tick &&
> +	git commit -m other-content-modifications &&
> +
>   	git switch --orphan unrelated &&
>   	>something-else &&
>   	git add something-else &&
> @@ -97,6 +105,21 @@ test_expect_success 'Content merge and a few conflicts' '
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'Auto resolve conflicts by "ours" strategy option' '
> +	git checkout side1^0 &&
> +
> +	# make sure merge conflict exists
> +	test_must_fail git merge side4 &&
> +	git merge --abort &&
> +
> +	git merge -X ours side4 &&
> +	git rev-parse HEAD^{tree} >expected &&
> +
> +	git merge-tree -X ours side1 side4 >actual &&
> +
> +	test_cmp expected actual
> +'
> +
>   test_expect_success 'Barf on misspelled option, with exit code other than 0 or 1' '
>   	# Mis-spell with single "s" instead of double "s"
>   	test_expect_code 129 git merge-tree --write-tree --mesages FOOBAR side1 side2 2>expect &&
> 
> base-commit: ac83bc5054c2ac489166072334b4147ce6d0fccb

