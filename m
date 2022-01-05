Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E09CC433EF
	for <git@archiver.kernel.org>; Wed,  5 Jan 2022 11:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239621AbiAELQB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jan 2022 06:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239618AbiAELQB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jan 2022 06:16:01 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E3C061761
        for <git@vger.kernel.org>; Wed,  5 Jan 2022 03:16:00 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id e5so24833126wmq.1
        for <git@vger.kernel.org>; Wed, 05 Jan 2022 03:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KeRWsn/HrKvTvZwpwRh/Y2yl3WtQzU3arfo4PUWWQK4=;
        b=SLQyAXmmDmzcw3hMEc1K1ODyU61VnKos4jEmAhwgs4dnOAPr2Fa4QJSq2A8sXwozb/
         V9VCqkzBcJsOIYYcWMyPRVzucZuk7sZiPEQ8BkBvytPe6j8hCAfAXZWeAIPkMO9RKgmU
         Y8mF/E9Myypjv3m1dTSDMslUEo0q8dRM0xHjh+0i1An4lA8sbmhPUGMqLjkJmo2TUZAg
         8ZaSgS/ZTDbL+F4rckh4zYwfWkpWpmqkonIdqihXwudSPAbyQhj0VR1BBAjdVa2607JO
         pExhFk1a72k2XQp2kGOAsanbO7XB5wWIjjPffaf55+f2a7osEHpaqvCAl48ITL+uOZAm
         J/xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=KeRWsn/HrKvTvZwpwRh/Y2yl3WtQzU3arfo4PUWWQK4=;
        b=BkG51tFldgBvLikEFDGHykHbKAZBrquaSFsGMcE0tvBIuRFbeg17coihtsfBURUTM1
         ydO8E4lE2TTmLWXSm5+e6xUG8ji5gGeUEpMALjNsTDm/ESSUm9/+MGhz3vTNztNOHTJA
         p8lnbNndoRtrhOYZWE0UBFI++s+kPlh0HB3vkAyO2RjnSjwGZ2/DJKxl89KybFEOaI1l
         /+ZCEAKWXMCPlTtnE0Qjx1Ceg5gckSDinsVxRUZJK9eR8j54y19d06mjBdozqrCTzlIK
         PpRs3DIRv0Z3Hd+ZvR1tjHo1SJAs0e6NRvIzEKXCb/y8GnbVGjJOncQY1FRPnOmvuG6y
         84gQ==
X-Gm-Message-State: AOAM531ZcuLrOxAeyRfXjVaWZMOuY3gfrl+1rMDWQr+ajlEkFleolDcj
        Lc/UkmOqJ5AxrVnRAe91+Qw=
X-Google-Smtp-Source: ABdhPJyjjm+Njuz8udVuyU52mIJiaYSONcczmBgYs960AL5uBMs7movbeZ+Uzr77xIHNqw1QB89PkA==
X-Received: by 2002:a1c:5403:: with SMTP id i3mr745814wmb.66.1641381359068;
        Wed, 05 Jan 2022 03:15:59 -0800 (PST)
Received: from [192.168.1.201] ([31.185.185.186])
        by smtp.googlemail.com with ESMTPSA id h3sm41221104wrt.94.2022.01.05.03.15.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Jan 2022 03:15:58 -0800 (PST)
Message-ID: <16666d32-833a-f3d7-351a-eeef7f25b002@gmail.com>
Date:   Wed, 5 Jan 2022 11:15:57 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v4 1/2] name-rev: deprecate --stdin in favor of
 --annotate-stdin
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        John Cai <johncai86@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1171.v3.git.git.1641221261.gitgitgadget@gmail.com>
 <pull.1171.v4.git.git.1641307776.gitgitgadget@gmail.com>
 <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <4e9200922a4c2c91e69e3b497fbf4c8702046a27.1641307776.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 04/01/2022 14:49, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> [...]
> diff --git a/builtin/name-rev.c b/builtin/name-rev.c
> index 27f60153a6c..21370afdaf9 100644
> --- a/builtin/name-rev.c
> +++ b/builtin/name-rev.c
> @@ -527,7 +527,7 @@ static void name_rev_line(char *p, struct name_ref_data *data)
>   int cmd_name_rev(int argc, const char **argv, const char *prefix)
>   {
>   	struct object_array revs = OBJECT_ARRAY_INIT;
> -	int all = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
> +	int all = 0, annotate_stdin = 0, transform_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
>   	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
>   	struct option opts[] = {
>   		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
> @@ -539,6 +539,7 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>   		OPT_GROUP(""),
>   		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
>   		OPT_BOOL(0, "stdin", &transform_stdin, N_("read from stdin")),

If the intention is to deprecate this option then it might be worth 
marking it as PARSE_OPT_HIDDEN so that it is not shown by 'git name-rev 
-h'. (You need to change OPT_BOOL to OPT_BOOL_F to pass the flag)

> +		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
>   		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
>   		OPT_BOOL(0, "always",     &always,
>   			   N_("show abbreviated commit object as fallback")),
> @@ -554,11 +555,19 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>   	init_commit_rev_name(&rev_names);
>   	git_config(git_default_config, NULL);
>   	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
> -	if (all + transform_stdin + !!argc > 1) {
> +
> +	if (transform_stdin) {
> +		warning("--stdin is deprecated. Please use --annotate-stdin instead, "
> +					"which is functionally equivalent.\n"
> +					"This option will be removed in a future release.");
> +		annotate_stdin = 1;
> +	}
> +
> +	if (all + annotate_stdin + !!argc > 1) {
>   		error("Specify either a list, or --all, not both!");
>   		usage_with_options(name_rev_usage, opts);
>   	}
> -	if (all || transform_stdin)
> +	if (all || annotate_stdin)
>   		cutoff = 0;
>   
>   	for (; argc; argc--, argv++) {
> @@ -613,8 +622,8 @@ int cmd_name_rev(int argc, const char **argv, const char *prefix)
>   	for_each_ref(name_ref, &data);
>   	name_tips();
>   
> -	if (transform_stdin) {
> -		char buffer[2048];
> +	if (annotate_stdin) {
> +		struct strbuf sb = STRBUF_INIT;

I think this hunk belongs in the next patch. Before posting a patch 
series I find it helpful to run

     git rebase --keep-base -x'make -j4 git && cd t && prove -j4 <tests 
I think might fail> :: --root=/dev/shm'

to check that the individual patches compile and pass the relevant 
tests. I've never got round to trying it but git-test[1] also lets you 
test all the commits in a series

Best Wishes

Phillip

[1] https://github.com/mhagger/git-test

>   		while (!feof(stdin)) {
>   			char *p = fgets(buffer, sizeof(buffer), stdin);
> diff --git a/t/t3412-rebase-root.sh b/t/t3412-rebase-root.sh
> index 19c6f4acbf6..1e9f7833dd6 100755
> --- a/t/t3412-rebase-root.sh
> +++ b/t/t3412-rebase-root.sh
> @@ -11,7 +11,7 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>   
>   log_with_names () {
>   	git rev-list --topo-order --parents --pretty="tformat:%s" HEAD |
> -	git name-rev --stdin --name-only --refs=refs/heads/$1
> +	git name-rev --annotate-stdin --name-only --refs=refs/heads/$1
>   }
>   
>   
> diff --git a/t/t4202-log.sh b/t/t4202-log.sh
> index 50495598619..dc884107de4 100755
> --- a/t/t4202-log.sh
> +++ b/t/t4202-log.sh
> @@ -659,7 +659,7 @@ EOF
>   
>   test_expect_success 'log --graph with full output' '
>   	git log --graph --date-order --pretty=short |
> -		git name-rev --name-only --stdin |
> +		git name-rev --name-only --annotate-stdin |
>   		sed "s/Merge:.*/Merge: A B/;s/ *\$//" >actual &&
>   	test_cmp expect actual
>   '
> diff --git a/t/t6007-rev-list-cherry-pick-file.sh b/t/t6007-rev-list-cherry-pick-file.sh
> index aebe4b69e13..6f3e5439771 100755
> --- a/t/t6007-rev-list-cherry-pick-file.sh
> +++ b/t/t6007-rev-list-cherry-pick-file.sh
> @@ -58,7 +58,7 @@ EOF
>   
>   test_expect_success '--left-right' '
>   	git rev-list --left-right B...C > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -78,14 +78,14 @@ EOF
>   
>   test_expect_success '--cherry-pick bar does not come up empty' '
>   	git rev-list --left-right --cherry-pick B...C -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
>   
>   test_expect_success 'bar does not come up empty' '
>   	git rev-list --left-right B...C -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -97,14 +97,14 @@ EOF
>   
>   test_expect_success '--cherry-pick bar does not come up empty (II)' '
>   	git rev-list --left-right --cherry-pick F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
>   
>   test_expect_success 'name-rev multiple --refs combine inclusive' '
>   	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" \
>   		<actual >actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -116,7 +116,7 @@ EOF
>   test_expect_success 'name-rev --refs excludes non-matched patterns' '
>   	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
>   	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs="*tags/F" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/F" \
>   		<actual >actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -128,14 +128,14 @@ EOF
>   test_expect_success 'name-rev --exclude excludes matched patterns' '
>   	git rev-list --left-right --right-only --cherry-pick F...E -- bar >>expect &&
>   	git rev-list --left-right --cherry-pick F...E -- bar >actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" --exclude="*E" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" --exclude="*E" \
>   		<actual >actual.named &&
>   	test_cmp expect actual.named
>   '
>   
>   test_expect_success 'name-rev --no-refs clears the refs list' '
>   	git rev-list --left-right --cherry-pick F...E -- bar >expect &&
> -	git name-rev --stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/F" --refs="*tags/E" --no-refs --refs="*tags/G" \
>   		<expect >actual &&
>   	test_cmp expect actual
>   '
> @@ -149,7 +149,7 @@ EOF
>   
>   test_expect_success '--cherry-mark' '
>   	git rev-list --cherry-mark F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -163,7 +163,7 @@ EOF
>   
>   test_expect_success '--cherry-mark --left-right' '
>   	git rev-list --cherry-mark --left-right F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -174,14 +174,14 @@ EOF
>   
>   test_expect_success '--cherry-pick --right-only' '
>   	git rev-list --cherry-pick --right-only F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
>   
>   test_expect_success '--cherry-pick --left-only' '
>   	git rev-list --cherry-pick --left-only E...F -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> @@ -193,7 +193,7 @@ EOF
>   
>   test_expect_success '--cherry' '
>   	git rev-list --cherry F...E -- bar > actual &&
> -	git name-rev --stdin --name-only --refs="*tags/*" \
> +	git name-rev --annotate-stdin --name-only --refs="*tags/*" \
>   		< actual > actual.named &&
>   	test_cmp expect actual.named
>   '
> diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
> index 4f7fa8b6c03..4fedc614fa6 100755
> --- a/t/t6012-rev-list-simplify.sh
> +++ b/t/t6012-rev-list-simplify.sh
> @@ -12,7 +12,7 @@ note () {
>   }
>   
>   unnote () {
> -	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
> +	git name-rev --tags --annotate-stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\)) |\1 |g"
>   }
>   
>   #
> diff --git a/t/t6111-rev-list-treesame.sh b/t/t6111-rev-list-treesame.sh
> index e07b6070e0e..90ff1416400 100755
> --- a/t/t6111-rev-list-treesame.sh
> +++ b/t/t6111-rev-list-treesame.sh
> @@ -23,7 +23,8 @@ note () {
>   }
>   
>   unnote () {
> -	git name-rev --tags --stdin | sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
> +	git name-rev --tags --annotate-stdin | \
> +	sed -e "s|$OID_REGEX (tags/\([^)]*\))\([ 	]\)|\1\2|g"
>   }
>   
>   test_expect_success setup '
> diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
> index d8af2bb9d2b..9781b92aedd 100755
> --- a/t/t6120-describe.sh
> +++ b/t/t6120-describe.sh
> @@ -270,7 +270,7 @@ test_expect_success 'name-rev --all' '
>   	test_cmp expect actual
>   '
>   
> -test_expect_success 'name-rev --stdin' '
> +test_expect_success 'name-rev --annotate-stdin' '
>   	>expect.unsorted &&
>   	for rev in $(git rev-list --all)
>   	do
> @@ -278,11 +278,16 @@ test_expect_success 'name-rev --stdin' '
>   		echo "$rev ($name)" >>expect.unsorted || return 1
>   	done &&
>   	sort <expect.unsorted >expect &&
> -	git rev-list --all | git name-rev --stdin >actual.unsorted &&
> +	git rev-list --all | git name-rev --annotate-stdin >actual.unsorted &&
>   	sort <actual.unsorted >actual &&
>   	test_cmp expect actual
>   '
>   
> +test_expect_success 'name-rev --stdin deprecated' "
> +	git rev-list --all | git name-rev --stdin 2>actual &&
> +	grep -E 'warning: --stdin is deprecated' actual
> +"
> +
>   test_expect_success 'describe --contains with the exact tags' '
>   	echo "A^0" >expect &&
>   	tag_object=$(git rev-parse refs/tags/A) &&
> 

