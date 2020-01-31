Return-Path: <SRS0=EOdt=3U=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7F4C35240
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B039621734
	for <git@archiver.kernel.org>; Fri, 31 Jan 2020 20:16:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GuP6175p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726264AbgAaUQU (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jan 2020 15:16:20 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:53674 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgAaUQU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jan 2020 15:16:20 -0500
Received: by mail-wm1-f67.google.com with SMTP id s10so9338357wmh.3
        for <git@vger.kernel.org>; Fri, 31 Jan 2020 12:16:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=wu6PEBJtVuiayApeaGjtpUUZzhmiPOMKgzoa04yxXFs=;
        b=GuP6175pXND2X0R/0L0e2jQ8jfXt6f5WvkcqAyE79oykUOeyQ8k5SueQBxtk4nWtPG
         vyToMCrxpKSaKaWYW9WJvOjdxrBosPv5+GiVlwQTNFs/AHVBKx1GwT1GkNuMX5kM/7lY
         y3b3nckvwjuK2SZZveGj5z9pBiMeu9cYmF40Me6uoywTSfCM38RyFmi2ScOnrHOT9Xr5
         nv1ycesN4jMcEiBFZMQMRFdl1p4e02GbI6FL8k5sBOTDk/7K3X+yvqwf70kpXRbGl63V
         si+st+BdWC6H4usss0LI1FJUr+RO+o2xYUPVRpgitvIvHQkbGcJ+ynf+KYkPm4dpOwC+
         3UWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=wu6PEBJtVuiayApeaGjtpUUZzhmiPOMKgzoa04yxXFs=;
        b=P2XCFdIiZgLT0bEwHuW0OlY14wQZcbBwHj7ZLaZFi3/7yeKFo4ptHxpr0Q4F0c/WK8
         y7akZntKdWMPEdSMtE8cOfDP4cEPiIGFiAw9GL3oLZuQa6HfHST38Dgf/VVtPwf22hZa
         qUqkJil5pHCQGqHgnJKaJJVIsudX5+64dtv8PmqSkH0N6Tj4x0y4KgGBlWbknXqQt/tC
         kNYt3vlW4VPS5ECOh4mJfEIpgl5CFamzhkFY8sr2ASNqDoxVDcaflU8o1WzVmgDvRcKK
         1AieA8TGNKj7GKu9TPl+OZRtYtnU1J3txK6D3jjgokhwGwAE2JJUTiuvOj4BmZ8nY1K/
         iUeg==
X-Gm-Message-State: APjAAAXW2wJPPvIErhVbensFylwfQTuNfPyKJPX26DoguNKkrzr8cZ2G
        Pdj9RV2CacaywbZRKqg04saXp9At
X-Google-Smtp-Source: APXvYqxbmXiZwuqm3SJwkL4n2sjdbG/XLk2gCqIFk5wWGh8VsnAfoxZbh7S9LC/2Oh9vTGE/fqR2vA==
X-Received: by 2002:a05:600c:211:: with SMTP id 17mr13646380wmi.60.1580501776416;
        Fri, 31 Jan 2020 12:16:16 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y10sm13001777wrw.68.2020.01.31.12.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 12:16:15 -0800 (PST)
Message-Id: <pull.513.v4.git.1580501775.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
References: <pull.513.v3.git.1580236003.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jan 2020 20:16:00 +0000
Subject: [PATCH v4 00/15] Harden the sparse-checkout builtin
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

Update in V3:

 * Input now uses Peff's recommended pattern: unquote C-style strings over
   stdin and otherwise do not un-escape input.

[1] 
https://lore.kernel.org/git/062301d5d0bc$c3e17760$4ba46620$@Frontier.com/

Thanks, -Stolee

Derrick Stolee (14):
  t1091: use check_files to reduce boilerplate
  t1091: improve here-docs
  sparse-checkout: create leading directories
  clone: fix --sparse option with URLs
  sparse-checkout: cone mode does not recognize "**"
  sparse-checkout: detect short patterns
  sparse-checkout: warn on globs in cone patterns
  sparse-checkout: properly match escaped characters
  sparse-checkout: write escaped patterns in cone mode
  sparse-checkout: unquote C-style strings over --stdin
  sparse-checkout: use C-style quotes in 'list' subcommand
  sparse-checkout: escape all glob characters on write
  sparse-checkout: improve docs around 'set' in cone mode
  sparse-checkout: fix cone mode behavior mismatch

Jeff King (1):
  sparse-checkout: fix documentation typo for core.sparseCheckoutCone

 Documentation/git-sparse-checkout.txt |  19 +-
 builtin/clone.c                       |   2 +-
 builtin/sparse-checkout.c             |  48 +++-
 dir.c                                 |  79 +++++-
 t/t1091-sparse-checkout-builtin.sh    | 352 +++++++++++++++-----------
 unpack-trees.c                        |   2 +-
 6 files changed, 346 insertions(+), 156 deletions(-)


base-commit: 4fd683b6a35eabd23dd5183da7f654a1e1f00325
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-513%2Fderrickstolee%2Fsparse-harden-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-513/derrickstolee/sparse-harden-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/513

Range-diff vs v3:

  1:  1cc825412f =  1:  1cc825412f t1091: use check_files to reduce boilerplate
  2:  b7a6ad145a =  2:  b7a6ad145a t1091: improve here-docs
  3:  5497ad8778 =  3:  5497ad8778 sparse-checkout: create leading directories
  4:  4991a51f6d =  4:  4991a51f6d clone: fix --sparse option with URLs
  5:  ae78c3069b =  5:  ae78c3069b sparse-checkout: fix documentation typo for core.sparseCheckoutCone
  6:  2ad4d3e467 =  6:  2ad4d3e467 sparse-checkout: cone mode does not recognize "**"
  7:  aace064510 =  7:  aace064510 sparse-checkout: detect short patterns
  8:  d2a510a3bb !  8:  66caabef5f sparse-checkout: warn on incorrect '*' in patterns
     @@ -1,6 +1,6 @@
      Author: Derrick Stolee <dstolee@microsoft.com>
      
     -    sparse-checkout: warn on incorrect '*' in patterns
     +    sparse-checkout: warn on globs in cone patterns
      
          In cone mode, the sparse-checkout commmand will write patterns that
          allow faster pattern matching. This matching only works if the patterns
     @@ -9,10 +9,10 @@
          cone mode matching to fail.
      
          The cone mode patterns may end in "/*" but otherwise an un-escaped
     -    asterisk is invalid. Add checks to disable cone mode when seeing these
     -    values.
     +    asterisk or other glob character is invalid. Add checks to disable
     +    cone mode when seeing these values.
      
     -    A later change will properly handle escaped asterisks.
     +    A later change will properly handle escaped globs.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ -43,16 +43,23 @@
      +	next = given->pattern + 2;
      +
      +	while (*cur) {
     -+		/* We care about *cur == '*' */
     -+		if (*cur != '*')
     ++		/* Watch for glob characters '*', '\', '[', '?' */
     ++		if (!is_glob_special(*cur))
      +			goto increment;
      +
      +		/* But only if *prev != '\\' */
      +		if (*prev == '\\')
      +			goto increment;
      +
     ++		/* But allow the initial '\' */
     ++		if (*cur == '\\' &&
     ++		    is_glob_special(*next))
     ++			goto increment;
     ++
      +		/* But a trailing '/' then '*' is fine */
     -+		if (*prev == '/' && *next == 0)
     ++		if (*prev == '/' &&
     ++		    *cur == '*' &&
     ++		    *next == 0)
      +			goto increment;
      +
      +		/* Not a cone pattern. */
     @@ -94,6 +101,18 @@
      +	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
      +'
      +
     ++test_expect_success 'pattern-checks: contained glob characters' '
     ++	for c in "[a]" "\\" "?" "*"
     ++	do
     ++		cat >repo/.git/info/sparse-checkout <<-EOF &&
     ++		/*
     ++		!/*/
     ++		something$c-else/
     ++		EOF
     ++		check_read_tree_errors repo "a" "disabling cone pattern matching"
     ++	done
     ++'
     ++
      +test_expect_success 'pattern-checks: escaped "*"' '
      +	cat >repo/.git/info/sparse-checkout <<-\EOF &&
      +	/*
  9:  9ea69e9069 !  9:  4c86d01f0e sparse-checkout: properly match escaped characters
     @@ -23,6 +23,7 @@
      +static char *dup_and_filter_pattern(const char *pattern)
      +{
      +	char *set, *read;
     ++	size_t count  = 0;
      +	char *result = xstrdup(pattern);
      +
      +	set = result;
     @@ -37,11 +38,14 @@
      +
      +		set++;
      +		read++;
     ++		count++;
      +	}
      +	*set = 0;
      +
     -+	if (*(read - 2) == '/' && *(read - 1) == '*')
     -+		*(read - 2) = 0;
     ++	if (count > 2 &&
     ++	    *(set - 1) == '*' &&
     ++	    *(set - 2) == '/')
     ++		*(set - 2) = 0;
      +
      +	return result;
      +}
     @@ -73,7 +77,7 @@
       --- a/t/t1091-sparse-checkout-builtin.sh
       +++ b/t/t1091-sparse-checkout-builtin.sh
      @@
     - 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
     + 	done
       '
       
      -test_expect_success 'pattern-checks: escaped "*"' '
     @@ -96,6 +100,7 @@
       	!/*/
      -	/does\*not\*exist/
      +	/zbad\\dir/
     ++	!/zbad\\dir/*/
      +	/zdoes\*not\*exist/
      +	/zdoes\*exist/
       	EOF
 10:  e2f9afc70c ! 10:  0b9346f67b sparse-checkout: write escaped patterns in cone mode
     @@ -9,26 +9,12 @@
          However, in cone mode we expect a list of paths to directories and then
          we convert those into patterns.
      
     -    Even more specifically, the goal is to always allow the following from
     -    the root of a repo:
     -
     -      git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin
     -
     -    The ls-tree command provides directory names with an unescaped asterisk.
     -    It also quotes the directories that contain an escaped backslash. We
     -    must remove these quotes, then keep the escaped backslashes.
     -
          However, there is some care needed for the timing of these escapes. The
          in-memory pattern list is used to update the working directory before
          writing the patterns to disk. Thus, we need the command to have the
          unescaped names in the hashsets for the cone comparisons, then escape
          the patterns later.
      
     -    Use unquote_c_style() when parsing lines from stdin. Command-line
     -    arguments will be parsed as-is, assuming the user can do the correct
     -    level of escaping from their environment to match the exact directory
     -    names.
     -
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
     @@ -89,29 +75,6 @@
       	}
       }
       
     -@@
     - 		pl.use_cone_patterns = 1;
     - 
     - 		if (set_opts.use_stdin) {
     --			while (!strbuf_getline(&line, stdin))
     -+			struct strbuf unquoted = STRBUF_INIT;
     -+			while (!strbuf_getline(&line, stdin)) {
     -+				if (line.buf[0] == '"') {
     -+					strbuf_setlen(&unquoted, 0);
     -+					if (unquote_c_style(&unquoted, line.buf, NULL))
     -+						die(_("unable to unquote C-style string '%s'"),
     -+						line.buf);
     -+
     -+					strbuf_swap(&unquoted, &line);
     -+				}
     -+
     - 				strbuf_to_cone_pattern(&line, &pl);
     -+			}
     -+
     -+			strbuf_release(&unquoted);
     - 		} else {
     - 			for (i = 0; i < argc; i++) {
     - 				strbuf_setlen(&line, 0);
      
       diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
       --- a/t/t1091-sparse-checkout-builtin.sh
     @@ -131,29 +94,18 @@
       	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
       	git -C escaped sparse-checkout init --cone &&
      -	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
     -+	git -C escaped sparse-checkout set zbad\\dir "zdoes*not*exist" "zdoes*exist" &&
     ++	git -C escaped sparse-checkout set zbad\\dir/bogus "zdoes*not*exist" "zdoes*exist" &&
      +	cat >expect <<-\EOF &&
       	/*
       	!/*/
       	/zbad\\dir/
     -+	/zdoes\*exist/
     - 	/zdoes\*not\*exist/
     -+	EOF
     -+	test_cmp expect escaped/.git/info/sparse-checkout &&
     -+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
     -+	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
     -+	cat >expect <<-\EOF &&
     -+	/*
     -+	!/*/
     -+	/deep/
     -+	/folder1/
     -+	/folder2/
     -+	/zbad\\dir/
     + 	!/zbad\\dir/*/
     +-	/zdoes\*not\*exist/
     ++	/zbad\\dir/bogus/
       	/zdoes\*exist/
     ++	/zdoes\*not\*exist/
       	EOF
     --	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
      +	test_cmp expect escaped/.git/info/sparse-checkout &&
     -+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
     + 	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
       '
       
     - test_done
  -:  ---------- > 11:  9f682e6076 sparse-checkout: unquote C-style strings over --stdin
 11:  ec714a4cf0 = 12:  e2c6f85617 sparse-checkout: use C-style quotes in 'list' subcommand
  -:  ---------- > 13:  54be8e89eb sparse-checkout: escape all glob characters on write
 12:  1867746d97 = 14:  3dd8f97b3a sparse-checkout: improve docs around 'set' in cone mode
  -:  ---------- > 15:  5e9fcce75f sparse-checkout: fix cone mode behavior mismatch

-- 
gitgitgadget
