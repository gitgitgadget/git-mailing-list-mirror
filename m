Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C1EBC35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 177022072C
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsnBNJKd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729543AbgAXVTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:48 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:41186 "EHLO
        mail-wr1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726080AbgAXVTr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:47 -0500
Received: by mail-wr1-f67.google.com with SMTP id c9so3694242wrw.8
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=HMo63vmtNxJ43z/AIWFwaquDVwkiB+tEor0qG2hRPPU=;
        b=YsnBNJKdxz07ZYlFRIBtOJOzhIFhtGP/myYlrxcHqVRyCYxeQyMXcgEFN+GE6I2WDx
         8YhJA4n6QNCfvO/DY0paPyrzIhDLgC45DmDtzSTp130OySi7dVZMcG8GsiT+rQBweszh
         7Q3gNnKdeogCeIOAc1aqdg2QrrcqKXfCg7C+23n6cuy0+hUSshFx9i/CJyEvbwwJbJDZ
         jM4aWsG7cV4u4cCtzyHGE4x0PyVurIv8LHBOaPNVep16xX4S3zlElDW4XdMLuRgzzxkV
         2FBED/Sn9oDnKbR6xmhKtHFGi/BYDitJipsu0yOXro3sW00DEqyjocXE/rw8helIsGCJ
         xXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=HMo63vmtNxJ43z/AIWFwaquDVwkiB+tEor0qG2hRPPU=;
        b=J2SMdya6S2I0HCCq1jiRTsNH2rzwp5qQF51NafHAL43Ed1mvbNKC5b02FFzyQkX33P
         xMZblOxx3MLHlkxJ1ELIewGXT7goqf+9WNWM4nH2hQuUrcl4FNsxbiCHKArIirsGC9z9
         xiHhve3uIDZT9/y9UBJvRt7m56V0NyWWZNyKavoNQDsI+bb/+F7a8WKhdopcpqmJxPZE
         4pWQ0PqvbTdSRa2nn7/muUsixiTOZ8cQCTbawypab3o0McmQh/lBXVSvNiD0WexRaO/9
         dO2giv5Pbfu/c8Xd/Sv2To2b+tZ/W8CIcgsju6dzoEiHjA2yYuLVcLpDXYK2WzgFhtrZ
         MrCQ==
X-Gm-Message-State: APjAAAXIH9piVr1mX+e+Jn1YIBvegZmLkt1U4xLPyMdUEjxpIXOl8wZg
        qKnlnOzv3uDxYF8vq8AhWVIFEZTz
X-Google-Smtp-Source: APXvYqyEsKuohSkd1diwrVaaR6+2z/7y4zXX+bDXmElZEsM79SPSXAK6HJbQcRJOH9f8uCOooiN9ow==
X-Received: by 2002:adf:fe86:: with SMTP id l6mr6582799wrr.252.1579900783810;
        Fri, 24 Jan 2020 13:19:43 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m21sm8188010wmi.27.2020.01.24.13.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:43 -0800 (PST)
Message-Id: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:30 +0000
Subject: [PATCH v2 00/12] Harden the sparse-checkout builtin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series is based on ds/sparse-list-in-cone-mode.

This series attempts to clean up some rough edges in the sparse-checkout
feature, especially around the cone mode.

Unfortunately, after the v2.25.0 release, we noticed an issue with the "git
clone --sparse" option when using a URL instead of a local path. This is
fixed and properly tested here.

Also, let's improve Git's response to these more complicated scenarios:

 1. Running "git sparse-checkout init" in a worktree would complain because
    the "info" dir doesn't exist.
 2. Tracked paths that include "*" and "\" in their filenames.
 3. If a user edits the sparse-checkout file to have non-cone pattern, such
    as "**" anywhere or "*" in the wrong place, then we should respond
    appropriately. That is: warn that the patterns are not cone-mode, then
    revert to the old logic.

Updates in V2:

 * Added C-style quoting to the output of "git sparse-checkout list" in cone
   mode.
 * Improved documentation.
 * Responded to most style feedback. Hopefully I didn't miss anything.
 * I was lingering on this a little to see if I could also fix the issue
   raised in [1], but I have not figured that one out, yet.

[1] 
https://lore.kernel.org/git/062301d5d0bc$c3e17760$4ba46620$@Frontier.com/

Thanks, -Stolee

Derrick Stolee (11):
  t1091: use check_files to reduce boilerplate
  t1091: improve here-docs
  sparse-checkout: create leading directories
  clone: fix --sparse option with URLs
  sparse-checkout: cone mode does not recognize "**"
  sparse-checkout: detect short patterns
  sparse-checkout: warn on incorrect '*' in patterns
  sparse-checkout: properly match escaped characters
  sparse-checkout: write escaped patterns in cone mode
  sparse-checkout: use C-style quotes in 'list' subcommand
  sparse-checkout: improve docs around 'set' in cone mode

Jeff King (1):
  sparse-checkout: fix documentation typo for core.sparseCheckoutCone

 Documentation/git-sparse-checkout.txt |  19 +-
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             |  59 ++++-
 dir.c                                 |  68 +++++-
 dir.h                                 |   1 +
 t/t1091-sparse-checkout-builtin.sh    | 323 +++++++++++++++-----------
 6 files changed, 317 insertions(+), 155 deletions(-)


base-commit: 4fd683b6a35eabd23dd5183da7f654a1e1f00325
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-513%2Fderrickstolee%2Fsparse-harden-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-513/derrickstolee/sparse-harden-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/513

Range-diff vs v1:

  -:  ---------- >  1:  1cc825412f t1091: use check_files to reduce boilerplate
  1:  9f7791ae5e !  2:  b7a6ad145a t1091: use check_files to reduce boilerplate
     @@ -1,14 +1,11 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    t1091: use check_files to reduce boilerplate
     +    t1091: improve here-docs
      
     -    When testing the sparse-checkout feature, we need to compare the
     -    contents of the working-directory against some expected output.
     -    Using here-docs was useful in the beginning, but became repetetive
     -    as the test script grew.
     -
     -    Create a check_files helper to make the tests simpler and easier
     -    to extend. It also reduces instances of bad here-doc whitespace.
     +    t1091-sparse-checkout-builtin.sh uses here-docs to populate the
     +    expected contents of the sparse-checkout file. These do not use
     +    shell interpolation, so use "-\EOF" instead of "-EOF". Also use
     +    proper tabbing.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -16,20 +13,6 @@
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	(cd "$1" && printf '%s\n' *)
     - }
     - 
     -+check_files() {
     -+	DIR=$1
     -+	printf "%s\n" $2 >expect &&
     -+	list_files $DIR >actual &&
     -+	test_cmp expect actual
     -+}
     -+
     - test_expect_success 'setup' '
     - 	git init repo &&
     - 	(
     -@@
       
       test_expect_success 'git sparse-checkout list (populated)' '
       	test_when_finished rm -f repo/.git/info/sparse-checkout &&
     @@ -59,11 +42,7 @@
       	EOF
       	test_cmp expect repo/.git/info/sparse-checkout &&
       	test_cmp_config -C repo true core.sparsecheckout &&
     --	list_files repo >dir  &&
     --	echo a >expect &&
     --	test_cmp expect dir
     -+	check_files repo a
     - '
     +@@
       
       test_expect_success 'git sparse-checkout list after init' '
       	git -C repo sparse-checkout list >actual &&
     @@ -90,16 +69,8 @@
      +	*folder*
       	EOF
       	test_cmp expect repo/.git/info/sparse-checkout &&
     --	list_files repo >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a folder1 folder2"
     - '
     - 
     + 	check_files repo a folder1 folder2
     +@@
       test_expect_success 'clone --sparse' '
       	git clone --sparse repo clone &&
       	git -C clone sparse-checkout list >actual &&
     @@ -111,13 +82,7 @@
      +	!/*/
       	EOF
       	test_cmp expect actual &&
     --	list_files clone >dir &&
     --	echo a >expect &&
     --	test_cmp expect dir
     -+	check_files clone a
     - '
     - 
     - test_expect_success 'set enables config' '
     + 	check_files clone a
      @@
       
       test_expect_success 'set sparse-checkout using builtin' '
     @@ -133,15 +98,7 @@
       	EOF
       	git -C repo sparse-checkout list >actual &&
       	test_cmp expect actual &&
     - 	test_cmp expect repo/.git/info/sparse-checkout &&
     --	list_files repo >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a folder1 folder2"
     +@@
       '
       
       test_expect_success 'set sparse-checkout using --stdin' '
     @@ -158,72 +115,10 @@
       	EOF
       	git -C repo sparse-checkout set --stdin <expect &&
       	git -C repo sparse-checkout list >actual &&
     - 	test_cmp expect actual &&
     - 	test_cmp expect repo/.git/info/sparse-checkout &&
     --	list_files repo >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a folder1 folder2"
     - '
     - 
     - test_expect_success 'cone mode: match patterns' '
     -@@
     - 	git -C repo read-tree -mu HEAD 2>err &&
     - 	test_i18ngrep ! "disabling cone patterns" err &&
     - 	git -C repo reset --hard &&
     --	list_files repo >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a folder1 folder2"
     - '
     - 
     - test_expect_success 'cone mode: warn on bad pattern' '
      @@
     - 	test_path_is_file repo/.git/info/sparse-checkout &&
     - 	git -C repo config --list >config &&
     - 	test_must_fail git config core.sparseCheckout &&
     --	list_files repo >dir &&
     --	cat >expect <<-EOF &&
     --		a
     --		deep
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a deep folder1 folder2"
     - '
     - 
     - test_expect_success 'cone mode: init and set' '
     -@@
     - 	test_cmp expect dir &&
     - 	git -C repo sparse-checkout set deep/deeper1/deepest/ 2>err &&
     - 	test_must_be_empty err &&
     --	list_files repo >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		deep
     --	EOF
     --	test_cmp expect dir &&
     --	list_files repo/deep >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		deeper1
     --	EOF
     --	test_cmp expect dir &&
     --	list_files repo/deep/deeper1 >dir  &&
     --	cat >expect <<-EOF &&
     --		a
     --		deepest
     --	EOF
     --	test_cmp expect dir &&
     + 	check_files repo a deep &&
     + 	check_files repo/deep a deeper1 &&
     + 	check_files repo/deep/deeper1 a deepest &&
      -	cat >expect <<-EOF &&
      -		/*
      -		!/*/
     @@ -232,9 +127,6 @@
      -		/deep/deeper1/
      -		!/deep/deeper1/*/
      -		/deep/deeper1/deepest/
     -+	check_files repo "a deep" &&
     -+	check_files repo/deep "a deeper1" &&
     -+	check_files repo/deep/deeper1 "a deepest" &&
      +	cat >expect <<-\EOF &&
      +	/*
      +	!/*/
     @@ -253,14 +145,7 @@
      +	folder2
       	EOF
       	test_must_be_empty err &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --		folder2
     --	EOF
     --	list_files repo >dir &&
     --	test_cmp expect dir
     -+	check_files repo "a folder1 folder2"
     + 	check_files repo a folder1 folder2
       '
       
       test_expect_success 'cone mode: list' '
     @@ -288,21 +173,6 @@
       	EOF
       	test_cmp repo/.git/info/sparse-checkout expect
       '
     -@@
     - 	test_must_fail git -C repo sparse-checkout set deep/deeper1 2>err &&
     - 	test_i18ngrep "cannot set sparse-checkout patterns" err &&
     - 	test_cmp repo/.git/info/sparse-checkout expect &&
     --	list_files repo/deep >dir &&
     --	cat >expect <<-EOF &&
     --		a
     --		deeper1
     --		deeper2
     --	EOF
     --	test_cmp dir expect
     -+	check_files repo/deep "a deeper1 deeper2"
     - '
     - 
     - test_expect_success 'revert to old sparse-checkout on empty update' '
      @@
       test_expect_success 'cone mode: set with core.ignoreCase=true' '
       	git -C repo sparse-checkout init --cone &&
     @@ -317,37 +187,4 @@
      +	/folder1/
       	EOF
       	test_cmp expect repo/.git/info/sparse-checkout &&
     --	list_files repo >dir &&
     --	cat >expect <<-EOF &&
     --		a
     --		folder1
     --	EOF
     --	test_cmp expect dir
     -+	check_files repo "a folder1"
     - '
     - 
     - test_expect_success 'interaction with submodules' '
     -@@
     - 		git sparse-checkout init --cone &&
     - 		git sparse-checkout set folder1
     - 	) &&
     --	list_files super >dir &&
     --	cat >expect <<-\EOF &&
     --		a
     --		folder1
     --		modules
     --	EOF
     --	test_cmp expect dir &&
     --	list_files super/modules/child >dir &&
     --	cat >expect <<-\EOF &&
     --		a
     --		deep
     --		folder1
     --		folder2
     --	EOF
     --	test_cmp expect dir
     -+	check_files super "a folder1 modules" &&
     -+	check_files super/modules/child "a deep folder1 folder2"
     - '
     - 
     - test_done
     + 	check_files repo a folder1
  2:  53a266f9aa !  3:  5497ad8778 sparse-checkout: create leading directories
     @@ -34,7 +34,7 @@
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	check_files super/modules/child "a deep folder1 folder2"
     + 	check_files super/modules/child a deep folder1 folder2
       '
       
      +test_expect_success 'different sparse-checkouts with worktrees' '
     @@ -43,8 +43,8 @@
      +	git -C worktree sparse-checkout init --cone &&
      +	git -C repo sparse-checkout set folder1 &&
      +	git -C worktree sparse-checkout set deep/deeper1 &&
     -+	check_files repo "a folder1" &&
     -+	check_files worktree "a deep"
     ++	check_files repo a folder1 &&
     ++	check_files worktree a deep
      +'
      +
       test_done
  3:  3ef8e021a5 !  4:  4991a51f6d clone: fix --sparse option with URLs
     @@ -22,6 +22,7 @@
          Update that target directory to evaluate this correctly. I have also
          manually tested that https:// URLs are handled correctly as well.
      
     +    Acked-by: Taylor Blau <me@ttaylorr.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/clone.c b/builtin/clone.c
  -:  ---------- >  5:  ae78c3069b sparse-checkout: fix documentation typo for core.sparseCheckoutCone
  4:  dfa7e20444 !  6:  2ad4d3e467 sparse-checkout: cone mode does not recognize "**"
     @@ -30,7 +30,6 @@
       
      +	if (strstr(given->pattern, "**")) {
      +		/* Not a cone pattern. */
     -+		pl->use_cone_patterns = 0;
      +		warning(_("unrecognized pattern: '%s'"), given->pattern);
      +		goto clear_hashmaps;
      +	}
     @@ -38,12 +37,17 @@
       	if (given->patternlen > 2 &&
       	    !strcmp(given->pattern + given->patternlen - 2, "/*")) {
       		if (!(given->flags & PATTERN_FLAG_NEGATIVE)) {
     + 			/* Not a cone pattern. */
     +-			pl->use_cone_patterns = 0;
     + 			warning(_("unrecognized pattern: '%s'"), given->pattern);
     + 			goto clear_hashmaps;
     + 		}
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	check_files worktree "a deep"
     + 	check_files worktree a deep
       '
       
      +check_read_tree_errors () {
     @@ -57,7 +61,7 @@
      +	else
      +		test_i18ngrep "$ERRORS" err
      +	fi &&
     -+	check_files $REPO "$FILES"
     ++	check_files $REPO $FILES
      +}
      +
      +test_expect_success 'pattern-checks: /A/**' '
  5:  9be49908fd !  7:  aace064510 sparse-checkout: detect short patterns
     @@ -21,8 +21,8 @@
      +	if (given->patternlen <= 2 ||
      +	    strstr(given->pattern, "**")) {
       		/* Not a cone pattern. */
     - 		pl->use_cone_patterns = 0;
       		warning(_("unrecognized pattern: '%s'"), given->pattern);
     + 		goto clear_hashmaps;
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
  6:  77a514f50b !  8:  d2a510a3bb sparse-checkout: warn on incorrect '*' in patterns
     @@ -34,8 +34,7 @@
      +	    *given->pattern == '*' ||
       	    strstr(given->pattern, "**")) {
       		/* Not a cone pattern. */
     - 		pl->use_cone_patterns = 0;
     -@@
     + 		warning(_("unrecognized pattern: '%s'"), given->pattern);
       		goto clear_hashmaps;
       	}
       
     @@ -57,7 +56,6 @@
      +			goto increment;
      +
      +		/* Not a cone pattern. */
     -+		pl->use_cone_patterns = 0;
      +		warning(_("unrecognized pattern: '%s'"), given->pattern);
      +		goto clear_hashmaps;
      +
  7:  09dbe1f902 !  9:  65c53d7526 sparse-checkout: properly match escaped characters
     @@ -9,7 +9,7 @@
          Create dup_and_filter_pattern() method to convert a pattern by
          removing escape characters and dropping an optional "/*" at the end.
          This method is available in dir.h as we will use it in
     -    builtin/sparse-chekcout.c in a later change.
     +    builtin/sparse-checkout.c in a later change.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
  8:  79b6e9a565 = 10:  c27a17a2fc sparse-checkout: write escaped patterns in cone mode
  -:  ---------- > 11:  526d5becbc sparse-checkout: use C-style quotes in 'list' subcommand
  -:  ---------- > 12:  1b5858adee sparse-checkout: improve docs around 'set' in cone mode

-- 
gitgitgadget
