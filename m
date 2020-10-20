Return-Path: <SRS0=RnkD=D3=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27F5C4363A
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:38:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F40F21D7B
	for <git@archiver.kernel.org>; Tue, 20 Oct 2020 13:38:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TuTPQtnM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407524AbgJTNiy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Oct 2020 09:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407496AbgJTNix (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Oct 2020 09:38:53 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69736C061755
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:38:53 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id d81so1821420wmc.1
        for <git@vger.kernel.org>; Tue, 20 Oct 2020 06:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Xr7TnG92gTZBARz2IIObtpWji60q2tNIVl1ip92Bf98=;
        b=TuTPQtnMCYjRA2V96Z0wyjy+T36dzOcQNfVxZaUsPas6HpB7ckp2ldOrkAPFzvgixN
         Q8jAAEUErIm2uNSMGItloCL9PnKZ2WKZzRKAN/wxUG47QXzPBZyrMQtQFxcqkz0RcA8e
         1068qtv018APuZ2j8Ip5Nfv2WVet9dU3zuxSxizrqXrjUkmhCgsyDBKkLOW7r5u7BxMO
         gdEip5nsNXPK+HjKf1GJXKN7o71NhqesXVxce+j5xfWp6IU5e9m3CDUMJ+1YzgpxkK7V
         p5OUo5VUrcmOSpEkx/ED2PehI2Y04TNupnRYeGxhHDCDv4Koro0zZGpaL03lJEam4OHa
         Lggw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Xr7TnG92gTZBARz2IIObtpWji60q2tNIVl1ip92Bf98=;
        b=g2k22hkgf+hBnWtW9jY9YS1lWNIXRj7fBzLCgNKiZ/L6pEYSFz3k1E4rgLG94xxQR1
         2BWpSFDoZXv9XNMLOTFUYdDS8mhcD08GQVys1NeqQTJcvNdrf3CAjpDfG9lVuLHUTXQr
         0eqjBnRfLatM7OLzx2j65nOOu6eQ0FDSgWdPZDLv8VZKh0B6KgonLuqRLUa/4OKO2KZ2
         j7l1BwZwIaOG9QBNkbGt1m7oUrVpQfvSJ2TLu/nlzMWHROkVKVmIP1FnkshrMZswJuOt
         0FYUXSghifsmfdVxcvObS28Du4Zp9rQbMQfxFtfCHpPDjJ055e6x+XVAI7Xg7QVIEtr4
         PVHA==
X-Gm-Message-State: AOAM5307KBC0AA5ZVY3mvmXsIYIhBQN1IHxeTta0PWiNaS/MksLstlQb
        Q28QyQ+Xe6ji2D954AHW+zg=
X-Google-Smtp-Source: ABdhPJwDjv/5dIidg6/WF9vPADoOYq9Eb5sqQw6Zv98szPwWDhONCiC8KkbOl2kzZZ2Pd8OyOow03g==
X-Received: by 2002:a7b:c3d3:: with SMTP id t19mr1329329wmj.139.1603201131946;
        Tue, 20 Oct 2020 06:38:51 -0700 (PDT)
Received: from [192.168.1.240] (13.45.90.146.dyn.plus.net. [146.90.45.13])
        by smtp.gmail.com with ESMTPSA id t13sm2836253wmj.15.2020.10.20.06.38.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Oct 2020 06:38:51 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [OUTREACHY][PATCH] diff: do not show submodule with untracked
 files as "-dirty"
To:     Sangeeta via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Sangeeta <sangunb09@gmail.com>
References: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <7af89857-5495-d008-3d8f-09b5fed32775@gmail.com>
Date:   Tue, 20 Oct 2020 14:38:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <pull.751.git.1602781723670.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Sangeeta

On 15/10/2020 18:08, Sangeeta via GitGitGadget wrote:
> From: sangu09 <sangunb09@gmail.com>

I think we require your full name on the From line to match the 
Signed-off-by line below (c.f. 
https://lore.kernel.org/git/xmqqpn5dd5dv.fsf@gitster.c.googlers.com)

> Git diff reports a submodule directory as -dirty even when there are only untracked files in the submodule directory.
> This is inconsistent with what `git describe --dirty` says when run in the submodule directory in that state.

That is a good summary of the issue that this change addresses, we 
normally wrap lines at 72 characters though.

> So this patch makes `git diff HEAD` consistent with `git describe --dirty` in case of untracked files. This can be solved by including the "--ignore-submodules=untracked" feature in git diff by default. So in order to make this as default behaviour I have added the behaviour of `ignore-submodules` in `repo_diff_setup()` function.

I think this could be a little more concise

This patch makes `git diff HEAD` consistent with `git describe --dirty` 
when a submodule contains untracked files by making 
`--ignore-submodules=untracked` the default.

> Also, to avoid `ignoreSubmodules` in user config being overwritten, I have made a  global variable >`diff_ignore_submodule_config` to keep a track whether `handle_ignore_submodules_arg` is called before or not.

It is good that you have thought about this and it is worth mentioning 
in the commit message, however unfortunately that variable does not seem 
to exist in the patch.

> 
> Signed-off-by: Sangeeta Jain <sangunb09@gmail.com>
> ---
>      [Outreachy] diff: do not show submodule with untracked files as "-dirty"
>      
>      Git diff reports a submodule directory as -dirty even when there are
>      only untracked files in the submodule directory. This is inconsistent
>      with what git describe --dirty says when run in the submodule directory
>      in that state.
>      
>      So this patch makes git diff HEAD consistent with git describe --dirty
>      in case of untracked files. This can be solved by including the
>      "--ignore-submodules=untracked" feature in git diff by default. So in
>      order to make this as default behaviour I have added the behaviour of
>      ignore-submodules in repo_diff_setup() function. Also, to avoid
>      ignoreSubmodules in user config being overwritten, I have made a global
>      variable diff_ignore_submodule_config to keep a track whether
>      handle_ignore_submodules_arg is called before or not.
> 
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-751%2Fsangu09%2Fhandle_untracked-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-751/sangu09/handle_untracked-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/751
> 
>   diff.c                                       |  1 +
>   submodule.c                                  |  2 ++
>   t/t3701-add-interactive.sh                   |  2 +-
>   t/t4027-diff-submodule.sh                    |  6 ++--
>   t/t4041-diff-submodule-option.sh             | 16 ++++-----
>   t/t4060-diff-submodule-option-diff-format.sh | 16 ++++-----
>   t/t7064-wtstatus-pv2.sh                      |  8 ++---
>   t/t7506-status-submodule.sh                  | 38 +++++---------------
>   8 files changed, 36 insertions(+), 53 deletions(-)
> 
> diff --git a/diff.c b/diff.c
> index 2bb2f8f57e..07d89e3e2b 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -4585,6 +4585,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
>   		DIFF_XDL_SET(options, INDENT_HEURISTIC);
>   
>   	options->orderfile = diff_order_file_cfg;
> +	options->flags.ignore_untracked_in_submodules = 1;

This unconditionally overrides diff.ignoreSubmodules, grepping seems to 
show that we don't have any tests that test a config value of "none". 
There are a few that check "dirty" which we should look at to consider 
if they still add value now we've changed the default.

>   	if (diff_no_prefix) {
>   		options->a_prefix = options->b_prefix = "";
> diff --git a/submodule.c b/submodule.c
> index b3bb59f066..762298c010 100644
> --- a/submodule.c
> +++ b/submodule.c
> @@ -1678,6 +1678,8 @@ unsigned is_submodule_modified(const char *path, int ignore_untracked)
>   	strvec_pushl(&cp.args, "status", "--porcelain=2", NULL);
>   	if (ignore_untracked)
>   		strvec_push(&cp.args, "-uno");
> +	else
> +        strvec_push (&cp.args, "--ignore-submodules=none");

We need to do this a a consequence of changing the default for 
'--ignore-submodules`, we should think what the consequences are for 
other users of `git status` and whether we need to do something similar 
there if diff.ignoreSubmodules is not set.

>   	prepare_submodule_repo_env(&cp.env_array);
>   	cp.git_cmd = 1;
> diff --git a/t/t3701-add-interactive.sh b/t/t3701-add-interactive.sh
> index ca04fac417..98e46ad1ae 100755
> --- a/t/t3701-add-interactive.sh
> +++ b/t/t3701-add-interactive.sh
> @@ -761,7 +761,7 @@ test_expect_success 'setup different kinds of dirty submodules' '
>   		echo dirty >>initial &&
>   		: >untracked
>   	) &&
> -	git -C for-submodules diff-files --name-only >actual &&
> +	git -C for-submodules diff-files --name-only --ignore-submodules=none >actual &&
>   	cat >expected <<-\EOF &&
>   	dirty-both-ways
>   	dirty-head
> diff --git a/t/t4027-diff-submodule.sh b/t/t4027-diff-submodule.sh
> index d7145ccca4..7bf2cb9c88 100755
> --- a/t/t4027-diff-submodule.sh
> +++ b/t/t4027-diff-submodule.sh
> @@ -93,7 +93,7 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked)' '
>   	) &&
>   	git diff HEAD >actual &&
>   	sed -e "1,/^@@/d" actual >actual.body &&
> -	expect_from_to >expect.body $subtip $subprev-dirty &&
> +	expect_from_to >expect.body $subtip $subprev &&
>   	test_cmp expect.body actual.body
>   '
>   
> @@ -168,13 +168,13 @@ test_expect_success 'git diff HEAD with dirty submodule (untracked, refs match)'
>   		git clean -qfdx &&
>   		>cruft
>   	) &&
> -	git diff HEAD >actual &&
> +	git diff --ignore-submodules=none HEAD >actual &&
>   	sed -e "1,/^@@/d" actual >actual.body &&
>   	expect_from_to >expect.body $subprev $subprev-dirty &&
>   	test_cmp expect.body actual.body &&
>   	git diff --ignore-submodules=all HEAD >actual2 &&
>   	test_must_be_empty actual2 &&
> -	git diff --ignore-submodules=untracked HEAD >actual3 &&
> +	git diff HEAD >actual3 &&

This checks the new default which is good

>   	test_must_be_empty actual3 &&
>   	git diff --ignore-submodules=dirty HEAD >actual4 &&
>   	test_must_be_empty actual4
> diff --git a/t/t4041-diff-submodule-option.sh b/t/t4041-diff-submodule-option.sh
> index f852136585..bb368b685d 100755
> --- a/t/t4041-diff-submodule-option.sh
> +++ b/t/t4041-diff-submodule-option.sh
> @@ -262,7 +262,7 @@ test_expect_success 'submodule is up to date' '
>   
>   test_expect_success 'submodule contains untracked content' '
>   	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	EOF
> @@ -270,7 +270,7 @@ test_expect_success 'submodule contains untracked content' '
>   '
>   
>   test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>   	test_must_be_empty actual
>   '
>   
> @@ -286,7 +286,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>   
>   test_expect_success 'submodule contains untracked and modified content' '
>   	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD --ignore-submodules=none >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 contains modified content
> @@ -296,7 +296,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>   
>   test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>   	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains modified content
>   	EOF
> @@ -337,7 +337,7 @@ test_expect_success 'submodule is modified' '
>   
>   test_expect_success 'modified submodule contains untracked content' '
>   	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p  --ignore-submodules=none --submodule=log HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 $head6..$head8:
> @@ -347,7 +347,7 @@ test_expect_success 'modified submodule contains untracked content' '
>   '
>   
>   test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 $head6..$head8:
>   	  > change
> @@ -371,7 +371,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>   
>   test_expect_success 'modified submodule contains untracked and modified content' '
>   	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=log HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=log HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 contains modified content
> @@ -383,7 +383,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>   
>   test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>   	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=log HEAD >actual &&
> +	git diff-index -p --submodule=log HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains modified content
>   	Submodule sm1 $head6..$head8:
> diff --git a/t/t4060-diff-submodule-option-diff-format.sh b/t/t4060-diff-submodule-option-diff-format.sh
> index fc8229c726..dc7b242697 100755
> --- a/t/t4060-diff-submodule-option-diff-format.sh
> +++ b/t/t4060-diff-submodule-option-diff-format.sh
> @@ -409,7 +409,7 @@ test_expect_success 'submodule is up to date' '
>   
>   test_expect_success 'submodule contains untracked content' '
>   	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	EOF
> @@ -417,7 +417,7 @@ test_expect_success 'submodule contains untracked content' '
>   '
>   
>   test_expect_success 'submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>   	test_must_be_empty actual
>   '
>   
> @@ -433,7 +433,7 @@ test_expect_success 'submodule contains untracked content (all ignored)' '
>   
>   test_expect_success 'submodule contains untracked and modified content' '
>   	echo new > sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 contains modified content
> @@ -451,7 +451,7 @@ test_expect_success 'submodule contains untracked and modified content' '
>   # NOT OK
>   test_expect_success 'submodule contains untracked and modified content (untracked ignored)' '
>   	echo new > sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains modified content
>   	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -512,7 +512,7 @@ test_expect_success 'submodule is modified' '
>   
>   test_expect_success 'modified submodule contains untracked content' '
>   	echo new > sm1/new-file &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 $head7..$head8:
> @@ -528,7 +528,7 @@ test_expect_success 'modified submodule contains untracked content' '
>   '
>   
>   test_expect_success 'modified submodule contains untracked content (untracked ignored)' '
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 $head7..$head8:
>   	diff --git a/sm1/foo6 b/sm1/foo6
> @@ -564,7 +564,7 @@ test_expect_success 'modified submodule contains untracked content (all ignored)
>   
>   test_expect_success 'modified submodule contains untracked and modified content' '
>   	echo modification >> sm1/foo6 &&
> -	git diff-index -p --submodule=diff HEAD >actual &&
> +	git diff-index -p --ignore-submodules=none --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains untracked content
>   	Submodule sm1 contains modified content
> @@ -583,7 +583,7 @@ test_expect_success 'modified submodule contains untracked and modified content'
>   
>   test_expect_success 'modified submodule contains untracked and modified content (untracked ignored)' '
>   	echo modification >> sm1/foo6 &&
> -	git diff-index -p --ignore-submodules=untracked --submodule=diff HEAD >actual &&
> +	git diff-index -p --submodule=diff HEAD >actual &&
>   	cat >expected <<-EOF &&
>   	Submodule sm1 contains modified content
>   	Submodule sm1 $head7..$head8:

I think all the diff tests look fine and we seem to have a good mix of 
testing the new default and --ignore-submodules=none

> diff --git a/t/t7064-wtstatus-pv2.sh b/t/t7064-wtstatus-pv2.sh
> index 537787e598..200626251e 100755
> --- a/t/t7064-wtstatus-pv2.sh
> +++ b/t/t7064-wtstatus-pv2.sh
> @@ -483,7 +483,7 @@ test_expect_success 'create and add submodule, submodule appears clean (A. S...)
>   	)
>   '
>   
> -test_expect_success 'untracked changes in added submodule (AM S..U)' '
> +test_expect_success 'untracked changes in added submodule (A. S...))' '

typo: there's an extra ')'

>   	(	cd super_repo &&
>   		## create untracked file in the submodule.
>   		(	cd sub1 &&
> @@ -500,7 +500,7 @@ test_expect_success 'untracked changes in added submodule (AM S..U)' '
>   		# branch.upstream origin/master
>   		# branch.ab +0 -0
>   		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> -		1 AM S..U 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		1 A. S... 000000 160000 160000 $ZERO_OID $HSUB sub1
>   		EOF
>   
>   		git status --porcelain=v2 --branch --untracked-files=all >actual &&
> @@ -560,7 +560,7 @@ test_expect_success 'staged and unstaged changes in added (AM S.M.)' '
>   	)
>   '
>   
> -test_expect_success 'staged and untracked changes in added submodule (AM S.MU)' '
> +test_expect_success 'staged and untracked changes in added submodule (AM S.M.)' '
>   	(	cd super_repo &&
>   		(	cd sub1 &&
>   			## stage new changes in tracked file.
> @@ -579,7 +579,7 @@ test_expect_success 'staged and untracked changes in added submodule (AM S.MU)'
>   		# branch.upstream origin/master
>   		# branch.ab +0 -0
>   		1 A. N... 000000 100644 100644 $ZERO_OID $HMOD .gitmodules
> -		1 AM S.MU 000000 160000 160000 $ZERO_OID $HSUB sub1
> +		1 AM S.M. 000000 160000 160000 $ZERO_OID $HSUB sub1
>   		EOF
>

I'm not sure about the changes in this file, maybe we should be testing 
the new default and --ignore-submodules=none

>   		git status --porcelain=v2 --branch --untracked-files=all >actual &&
> diff --git a/t/t7506-status-submodule.sh b/t/t7506-status-submodule.sh
> index 3fcb44767f..b7ff7928fb 100755
> --- a/t/t7506-status-submodule.sh
> +++ b/t/t7506-status-submodule.sh
> @@ -95,7 +95,7 @@ test_expect_success 'status with untracked file in submodule' '
>   	(cd sub && git reset --hard) &&
>   	echo "content" >sub/new-file &&
>   	git status >output &&
> -	test_i18ngrep "modified:   sub (untracked content)" output
> +	test_i18ngrep "^nothing to commit" output
>   '
>   
>   test_expect_success 'status -uno with untracked file in submodule' '
> @@ -105,23 +105,19 @@ test_expect_success 'status -uno with untracked file in submodule' '
>   
>   test_expect_success 'status with untracked file in submodule (porcelain)' '
>   	git status --porcelain >output &&
> -	diff output - <<-\EOF
> -	 M sub
> -	EOF
> +	test_must_be_empty output
>   '
>   
>   test_expect_success 'status with untracked file in submodule (short)' '
>   	git status --short >output &&
> -	diff output - <<-\EOF
> -	 ? sub
> -	EOF
> +	test_must_be_empty output
>   '
>   
>   test_expect_success 'status with added and untracked file in submodule' '
>   	(cd sub && git reset --hard && echo >foo && git add foo) &&
>   	echo "content" >sub/new-file &&
>   	git status >output &&
> -	test_i18ngrep "modified:   sub (modified content, untracked content)" output
> +	test_i18ngrep "modified:   sub (modified content)" output
>   '
>   
>   test_expect_success 'status with added and untracked file in submodule (porcelain)' '
> @@ -169,7 +165,7 @@ test_expect_success 'status with untracked file in modified submodule' '
>   	(cd sub && git reset --hard) &&
>   	echo "content" >sub/new-file &&
>   	git status >output &&
> -	test_i18ngrep "modified:   sub (new commits, untracked content)" output
> +	test_i18ngrep "modified:   sub (new commits)" output
>   '
>   
>   test_expect_success 'status with untracked file in modified submodule (porcelain)' '
> @@ -183,7 +179,7 @@ test_expect_success 'status with added and untracked file in modified submodule'
>   	(cd sub && git reset --hard && echo >foo && git add foo) &&
>   	echo "content" >sub/new-file &&
>   	git status >output &&
> -	test_i18ngrep "modified:   sub (new commits, modified content, untracked content)" output
> +	test_i18ngrep "modified:   sub (new commits, modified content)" output
>   '
>   
>   test_expect_success 'status with added and untracked file in modified submodule (porcelain)' '
> @@ -350,30 +346,17 @@ test_expect_success 'setup superproject with untracked file in nested submodule'
>   
>   test_expect_success 'status with untracked file in nested submodule (porcelain)' '
>   	git -C super status --porcelain >output &&
> -	diff output - <<-\EOF
> -	 M sub1
> -	 M sub2
> -	 M sub3
> -	EOF
> +	test_must_be_empty output
>   '
>   
>   test_expect_success 'status with untracked file in nested submodule (porcelain=2)' '
>   	git -C super status --porcelain=2 >output &&
> -	sanitize_output output &&
> -	diff output - <<-\EOF
> -	1 .M S..U 160000 160000 160000 HASH HASH sub1
> -	1 .M S..U 160000 160000 160000 HASH HASH sub2
> -	1 .M S..U 160000 160000 160000 HASH HASH sub3
> -	EOF
> +	test_must_be_empty output
>   '
>   
>   test_expect_success 'status with untracked file in nested submodule (short)' '
>   	git -C super status --short >output &&
> -	diff output - <<-\EOF
> -	 ? sub1
> -	 ? sub2
> -	 ? sub3
> -	EOF
> +	test_must_be_empty output
>   '
>   
>   test_expect_success 'setup superproject with modified file in nested submodule' '
> @@ -386,7 +369,6 @@ test_expect_success 'status with added file in nested submodule (porcelain)' '
>   	diff output - <<-\EOF
>   	 M sub1
>   	 M sub2
> -	 M sub3
>   	EOF
>   '
>   
> @@ -396,7 +378,6 @@ test_expect_success 'status with added file in nested submodule (porcelain=2)' '
>   	diff output - <<-\EOF
>   	1 .M S.M. 160000 160000 160000 HASH HASH sub1
>   	1 .M S.M. 160000 160000 160000 HASH HASH sub2
> -	1 .M S..U 160000 160000 160000 HASH HASH sub3
>   	EOF
>   '
>   
> @@ -405,7 +386,6 @@ test_expect_success 'status with added file in nested submodule (short)' '
>   	diff output - <<-\EOF
>   	 m sub1
>   	 m sub2
> -	 ? sub3
>   	EOF
>   '

I think we want to keep testing that we get the correct output when 
--ignore-submodules=none as well as maybe adding a couple of new tests 
that check the default in this file, rather than changing the expected 
output.

Best Wishes

Phillip


> base-commit: d98273ba77e1ab9ec755576bc86c716a97bf59d7
> 
