Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D074317C9
	for <git@vger.kernel.org>; Sun,  7 Apr 2024 03:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712460253; cv=none; b=f1FOnmceQA5cTDtUEi/Q/iW7ffwMMVz8ffgakOIRQlWwQIoRMWajv+dMMydM1uKF8+y0p5ZSWkRn9pxcQP1kYE9k8PeXnsF0bKdntu687gx2PA/osJwZELuh1EEN40FuLIWccV0MsfDRYqM0H6rk48C9rcaXwtyhpF7UBR/oEOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712460253; c=relaxed/simple;
	bh=R3YAh78oT9KMWdGdep2kP0qdj7Srh6JxZ9VU20IuylE=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=feS+h8fje/X52/TB+ufBfjp+Il2hu8SAkAwwWGNA/48GaQp3l91rEhVxt1k48i48TanNfxLLWnbmeiqI85vSckeVSEyGUXLoPjh3SuvR6PyI8MUnRupbm1RvJ/TTgdZje4veorTsV9iUkOpWjfDrv+MnQXSkZo5OX3ZKRKfnr70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KtaxtiSA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KtaxtiSA"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-343bccc0b2cso2275629f8f.1
        for <git@vger.kernel.org>; Sat, 06 Apr 2024 20:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712460249; x=1713065049; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t8L5Vkx3qlN2/4ts/sC52heCvdQIKHM8Xtika8n51RE=;
        b=KtaxtiSAMo0IOY+0KjfjNLbn2MZHWCD9TKFyjvM4dhVg9xIUf2kNoZ5RZvu+Qh0gVd
         jOAjBnfDv2xKL53X4GZyccQEmeroMCKZshWMC9/O7m1NDLuqYu9KmXYiiaKVri2wF4pU
         VOQsUHommc23IrQK1bqq2xGASimuRq0xNsIQ2HEQp3jequ3yTA0u/Q/0fg+1fLGDKWgH
         fKAJ7MDFeQU/T9+1beEzFxMWTgmSBOIFzEhX1fgHlSaME+aJ7Rr9f6Qkgn0AIB6Af2Fz
         ulZL8Iv/8QVCMZRipWy3AjYCmFTIm1qMa+FQofSD93qaQV8CWPDyKNqij6XYDtOyOZUr
         lnqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712460249; x=1713065049;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=t8L5Vkx3qlN2/4ts/sC52heCvdQIKHM8Xtika8n51RE=;
        b=VlcrL4Rh8LegYUFWTN9ij+hty6v4ncoqLMnP0m0bKBthGSOhyb0x6o39LuSh39OvUY
         bAvu8gTH4hUsLp27Ah5TMlqmmy2Z1UIHcHKoM5xyC2nfLB962StIW7wp5IoW1H4sJw1r
         vzAypxRhrfH30ucBTrIw+KX6PwaNf3umdlVVlZMWwG10tiCkfMCdy47fE4YOcicNTKn9
         7wZF0IVxc2oL0ggC6IBPH9pHixeVRZNtaDiXWB0gacDkR6WW5BAXcaKW0fAYsBEb+3da
         Ijshk/VSJDtuw/fCDJj6s3+gDGLufKW1ezMQdZE6iadagvbzINN4s6aCXC4qBIW16N1D
         FSCw==
X-Gm-Message-State: AOJu0YyFhKVh2QFiJhbrwJ1LFxP870NHoUdESmdw25weAlP4k3Ak1FZ9
	BxS7uDkr4kAcfTIrdoNxnOJbj39CqmHWjYdZbMNmLqrwBdFoCgKxaE8XZ3vZ
X-Google-Smtp-Source: AGHT+IH2DUY2Rg8/ZrnnvnV9O5DP+s7QdVZQX2KfjABARgbzkw5y9MBqXRauzm6H7Otw9RGQL+v+1Q==
X-Received: by 2002:a05:6000:188a:b0:341:7589:39b1 with SMTP id a10-20020a056000188a00b00341758939b1mr4573372wri.6.1712460249168;
        Sat, 06 Apr 2024 20:24:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u10-20020adff88a000000b00343e01d3f6dsm5679969wrp.3.2024.04.06.20.24.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Apr 2024 20:24:08 -0700 (PDT)
Message-Id: <pull.1710.v2.git.1712460247516.gitgitgadget@gmail.com>
In-Reply-To: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
References: <pull.1710.git.1712353687464.gitgitgadget@gmail.com>
From: "Max Coplan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 07 Apr 2024 03:24:07 +0000
Subject: [PATCH v2] log: add option to search for header or body
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    strager <strager.nds@gmail.com>,
    me <mchcopl@gmail.com>,
    Max Coplan <mchcopl@gmail.com>,
    =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
 =?UTF-8?q?an?= <mchcopl@gmail.com>

From: =?UTF-8?q?Max=20=F0=9F=91=A8=F0=9F=8F=BD=E2=80=8D=F0=9F=92=BB=20Copl?=
 =?UTF-8?q?an?= <mchcopl@gmail.com>

Summary:
This change adds a new option to `git log` that allows users to search
for commits that match either the author or the commit message. This is
useful for finding commits that were either authored or co-authored by a
specific person.

Currently, the best way to find a commit either authored or co-authored
by a specific person is to use

```sh
$ echo \
    $(git log --author=Torvalds --pretty="%cd,%H\n" --date=iso-strict) \
    $(git log --grep="Co-authored-by: .*Torvalds" --pretty="%cd,%H\n" --date=iso-strict) \
| sort -n --reverse \
| awk -F, '{print $2}' \
| tr '\n' '\t' \
| xargs git show --stat --stdin
```

This is a bit of a pain, so this change adds a new option to `git log`.
Now finding either authors or co-authors is as simple as

```sh
$ git log --author=Torvalds --grep=Torvalds --match-header-or-grep
```

Test plan:
1. create commit authored by A and co-authored-by B
2. create commit authored by B
3. run
```sh
$ git log --author=B --grep="Co-authored-by: B" --match-header-or-grep
```
4. expect to see both commits

Signed-off-by: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>
---
    log: add option to search for header or body

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1710%2Fvegerot%2Fheader-or-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1710/vegerot/header-or-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1710

Range-diff vs v1:

 1:  dc6b5664159 ! 1:  c7f14e59b4f feat(log): add option to search for header or body to `git log`
     @@ Metadata
      Author: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>
      
       ## Commit message ##
     -    feat(log): add option to search for header or body to `git log`
     -
     -    Note to reviewer: I hate the name `--header-or`!  Please help me come up
     -    with a better name.
     +    log: add option to search for header or body
      
          Summary:
          This change adds a new option to `git log` that allows users to search
     @@ Commit message
          by a specific person is to use
      
          ```sh
     -    echo \
     +    $ echo \
              $(git log --author=Torvalds --pretty="%cd,%H\n" --date=iso-strict) \
              $(git log --grep="Co-authored-by: .*Torvalds" --pretty="%cd,%H\n" --date=iso-strict) \
          | sort -n --reverse \
     @@ Commit message
          Now finding either authors or co-authors is as simple as
      
          ```sh
     -    git log --author=Torvalds --grep=Torvalds --header-or
     +    $ git log --author=Torvalds --grep=Torvalds --match-header-or-grep
          ```
      
          Test plan:
          1. create commit authored by A and co-authored-by B
          2. create commit authored by B
     -    3. run `git log --author=B --grep="Co-authored-by: B" --header-or`
     +    3. run
     +    ```sh
     +    $ git log --author=B --grep="Co-authored-by: B" --match-header-or-grep
     +    ```
          4. expect to see both commits
      
          Signed-off-by: Max 👨🏽‍💻 Coplan <mchcopl@gmail.com>
      
     + ## Documentation/rev-list-options.txt ##
     +@@ Documentation/rev-list-options.txt: endif::git-rev-list[]
     + 	Limit the commits output to ones that match all given `--grep`,
     + 	instead of ones that match at least one.
     + 
     ++--match-header-or-grep::
     ++	Limit the commits output to ones that match either header patterns
     ++	(`--author`, `--committer`, or `--grep-reflog`) or `--grep`, instead
     ++	of ones that match both the header and grep patterns
     +++
     ++For example, `--author=me --grep=Co-authored-by: me` limits to commits either
     ++authored or co-authored by me.
     ++
     + --invert-grep::
     + 	Limit the commits output to ones with a log message that do not
     + 	match the pattern specified with `--grep=<pattern>`.
     +
     + ## contrib/completion/git-completion.bash ##
     +@@ contrib/completion/git-completion.bash: __git_log_gitk_options="
     + # Options that go well for log and shortlog (not gitk)
     + __git_log_shortlog_options="
     + 	--author= --committer= --grep=
     +-	--all-match --invert-grep
     ++	--all-match --invert-grep --match-header-or-grep
     + "
     + # Options accepted by log and show
     + __git_log_show_options="
     +
       ## grep.c ##
      @@ grep.c: void compile_grep_patterns(struct grep_opt *opt)
     - 	if (opt->no_body_match && opt->pattern_expression)
     - 		opt->pattern_expression = grep_not_expr(opt->pattern_expression);
     - 
     --	if (!header_expr)
     -+	if (!header_expr || opt->header_or)
     - 		return;
       
       	if (!opt->pattern_expression)
     + 		opt->pattern_expression = header_expr;
     +-	else if (opt->all_match)
     ++	else if (opt->all_match || opt->match_header_or_grep)
     + 		opt->pattern_expression = grep_splice_or(header_expr,
     + 							 opt->pattern_expression);
     + 	else
     +@@ grep.c: int grep_source(struct grep_opt *opt, struct grep_source *gs)
     + 	opt->body_hit = 0;
     + 	grep_source_1(opt, gs, 1);
     + 
     +-	if (opt->all_match && !chk_hit_marker(opt->pattern_expression))
     ++	if (!opt->match_header_or_grep && opt->all_match && !chk_hit_marker(opt->pattern_expression))
     + 		return 0;
     + 	if (opt->no_body_match && opt->body_hit)
     + 		return 0;
      
       ## grep.h ##
      @@ grep.h: struct grep_opt {
       	int count;
       	int word_regexp;
       	int all_match;
     -+	int header_or;
     ++	int match_header_or_grep;
       	int no_body_match;
       	int body_hit;
       #define GREP_BINARY_DEFAULT	0
     @@ revision.c: static int handle_revision_opt(struct rev_info *revs, int argc, cons
       		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
       	} else if (!strcmp(arg, "--all-match")) {
       		revs->grep_filter.all_match = 1;
     -+	// @@@ must-fix: find a better name
     -+	} else if (!strcmp(arg, "--header-or")) {
     -+		revs->grep_filter.header_or = 1;
     ++	} else if (!strcmp(arg, "--match-header-or-grep")) {
     ++		revs->grep_filter.match_header_or_grep = 1;
       	} else if (!strcmp(arg, "--invert-grep")) {
       		revs->grep_filter.no_body_match = 1;
       	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
     @@ t/t7810-grep.sh: test_expect_success 'log --grep --author uses intersection' '
       	test_cmp expect actual
       '
       
     -+test_expect_success 'log --grep --author --header-or uses union' '
     ++test_expect_success 'log --grep --author --match-header-or-grep uses union' '
      +	# grep matches only third and fourth
      +	# author matches only initial and third
     -+	git log --author="A U Thor" --grep=r --header-or --format=%s >actual &&
     -+	{
     -+	    echo fourth && echo third
     -+	} >expect &&
     ++	git log --author="A U Thor" --grep=r --match-header-or-grep --format=%s >actual &&
     ++	test_write_lines fourth third initial >expect &&
      +	test_cmp expect actual
      +'
     -+
      +
       test_expect_success 'log --grep --grep --author takes union of greps and intersects with author' '
       	# grep matches initial and second but not third
       	# author matches only initial and third
     +@@ t/t7810-grep.sh: test_expect_success 'log --grep --grep --author takes union of greps and interse
     + 	test_cmp expect actual
     + '
     + 
     +-test_expect_success 'log ---all-match -grep --author --author still takes union of authors and intersects with grep' '
     ++test_expect_success 'log --author --grep --grep --match-header-or-grep takes union of greps and author' '
     ++	# grep matches initial and second but not third
     ++	# author matches only initial and third
     ++	git log --author="A U Thor" --grep=second --grep=initial --match-header-or-grep --format=%s >actual &&
     ++	test_write_lines third second initial >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'log --author --grep --grep --all-match --match-header-or-grep still takes union of greps and author' '
     ++	# grep matches initial and second but not third
     ++	# author matches only initial and third
     ++	git log --author="A U Thor" --grep=second --grep=initial --all-match --match-header-or-grep --format=%s >actual &&
     ++	test_write_lines third second initial >expect &&
     ++	test_cmp expect actual
     ++'
     ++
     ++test_expect_success 'log --all-match --grep --author --author still takes union of authors and intersects with grep' '
     + 	# grep matches only initial and third
     + 	# author matches all but second
     + 	git log --all-match --author="Thor" --author="Night" --grep=i --format=%s >actual &&


 Documentation/rev-list-options.txt     |  8 ++++++++
 contrib/completion/git-completion.bash |  2 +-
 grep.c                                 |  4 ++--
 grep.h                                 |  1 +
 revision.c                             |  2 ++
 t/t7810-grep.sh                        | 26 +++++++++++++++++++++++++-
 6 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 00ccf687441..db0979ac498 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -71,6 +71,14 @@ endif::git-rev-list[]
 	Limit the commits output to ones that match all given `--grep`,
 	instead of ones that match at least one.
 
+--match-header-or-grep::
+	Limit the commits output to ones that match either header patterns
+	(`--author`, `--committer`, or `--grep-reflog`) or `--grep`, instead
+	of ones that match both the header and grep patterns
++
+For example, `--author=me --grep=Co-authored-by: me` limits to commits either
+authored or co-authored by me.
+
 --invert-grep::
 	Limit the commits output to ones with a log message that do not
 	match the pattern specified with `--grep=<pattern>`.
diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 75193ded4bd..30fc6ed08bd 100644
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -2170,7 +2170,7 @@ __git_log_gitk_options="
 # Options that go well for log and shortlog (not gitk)
 __git_log_shortlog_options="
 	--author= --committer= --grep=
-	--all-match --invert-grep
+	--all-match --invert-grep --match-header-or-grep
 "
 # Options accepted by log and show
 __git_log_show_options="
diff --git a/grep.c b/grep.c
index ac34bfeafb3..72cf599660a 100644
--- a/grep.c
+++ b/grep.c
@@ -802,7 +802,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 
 	if (!opt->pattern_expression)
 		opt->pattern_expression = header_expr;
-	else if (opt->all_match)
+	else if (opt->all_match || opt->match_header_or_grep)
 		opt->pattern_expression = grep_splice_or(header_expr,
 							 opt->pattern_expression);
 	else
@@ -1829,7 +1829,7 @@ int grep_source(struct grep_opt *opt, struct grep_source *gs)
 	opt->body_hit = 0;
 	grep_source_1(opt, gs, 1);
 
-	if (opt->all_match && !chk_hit_marker(opt->pattern_expression))
+	if (!opt->match_header_or_grep && opt->all_match && !chk_hit_marker(opt->pattern_expression))
 		return 0;
 	if (opt->no_body_match && opt->body_hit)
 		return 0;
diff --git a/grep.h b/grep.h
index 926c0875c42..861584dba98 100644
--- a/grep.h
+++ b/grep.h
@@ -147,6 +147,7 @@ struct grep_opt {
 	int count;
 	int word_regexp;
 	int all_match;
+	int match_header_or_grep;
 	int no_body_match;
 	int body_hit;
 #define GREP_BINARY_DEFAULT	0
diff --git a/revision.c b/revision.c
index 7e45f765d9f..786c229f56d 100644
--- a/revision.c
+++ b/revision.c
@@ -2646,6 +2646,8 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_PCRE;
 	} else if (!strcmp(arg, "--all-match")) {
 		revs->grep_filter.all_match = 1;
+	} else if (!strcmp(arg, "--match-header-or-grep")) {
+		revs->grep_filter.match_header_or_grep = 1;
 	} else if (!strcmp(arg, "--invert-grep")) {
 		revs->grep_filter.no_body_match = 1;
 	} else if ((argcount = parse_long_opt("encoding", argv, &optarg))) {
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 875dcfd98f3..c78ce150f4d 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -961,6 +961,14 @@ test_expect_success 'log --grep --author uses intersection' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --grep --author --match-header-or-grep uses union' '
+	# grep matches only third and fourth
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=r --match-header-or-grep --format=%s >actual &&
+	test_write_lines fourth third initial >expect &&
+	test_cmp expect actual
+'
+
 test_expect_success 'log --grep --grep --author takes union of greps and intersects with author' '
 	# grep matches initial and second but not third
 	# author matches only initial and third
@@ -971,7 +979,23 @@ test_expect_success 'log --grep --grep --author takes union of greps and interse
 	test_cmp expect actual
 '
 
-test_expect_success 'log ---all-match -grep --author --author still takes union of authors and intersects with grep' '
+test_expect_success 'log --author --grep --grep --match-header-or-grep takes union of greps and author' '
+	# grep matches initial and second but not third
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=second --grep=initial --match-header-or-grep --format=%s >actual &&
+	test_write_lines third second initial >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --author --grep --grep --all-match --match-header-or-grep still takes union of greps and author' '
+	# grep matches initial and second but not third
+	# author matches only initial and third
+	git log --author="A U Thor" --grep=second --grep=initial --all-match --match-header-or-grep --format=%s >actual &&
+	test_write_lines third second initial >expect &&
+	test_cmp expect actual
+'
+
+test_expect_success 'log --all-match --grep --author --author still takes union of authors and intersects with grep' '
 	# grep matches only initial and third
 	# author matches all but second
 	git log --all-match --author="Thor" --author="Night" --grep=i --format=%s >actual &&

base-commit: 7774cfed6261ce2900c84e55906da708c711d601
-- 
gitgitgadget
