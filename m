Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79EBC57303
	for <git@vger.kernel.org>; Tue,  6 Feb 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707185377; cv=none; b=E3JpQZskfcC7L8hgHhwKiLxzGSFtWD57OW4grMaD5xqgYA10NRpQ/zp+K4rMUJmIVm+XWVNvRe1BvrmLgGShfn3d7IdtnGsaVFpezQefTptQtsOZtxgXh1mKXkxHc/CC+aJN6KiHXuZ3QzBZzILYfNoB0mJILwiWXEw1NsUkrdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707185377; c=relaxed/simple;
	bh=lefFL8fcAaryQ1v7S28VeEZ7ticOcEc1gZJ+N24sQbI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4vyrAwDk0XGZ5hbNj6OGq28y/oSNIDhiTTJBD+PtpfKv4D7jrNK5B5eOL2RiisrXOGH10cak05N54NkadKQuzK9SRPEU9eUsgBlL2TCOHRj1PrZQO94Fayd2RFDaOoK3vBamwn73JYsB5YsfDVwfbtdURunFBbHY27YkorqGbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ieGS8Vev; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieGS8Vev"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d7354ba334so44634995ad.1
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 18:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707185375; x=1707790175; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Mf3lLucVIqZtk5YO4W6AGvaA761l3Xeyk4k/fRjLyc=;
        b=ieGS8VevqwlcdNrVoazplLBmYe7RcGASpscfNFVHnV18nXawnkQRWOnCN3zRgcE3jM
         RYTCZxyO8qqwy72JWDVBIz+6hgKTV1UZtavuofH9USQZ5FvcgK4LShr+GXqDREXjVDT4
         ArsfvMcqhD0tEKEr3IMx6Q98X0rXto3z3eQidutEo5GllNmbMXL/KNwQcyRB9jAw1bgf
         /O0f/SN1IAmJ/Qq/WGYLTYi0MDGg2vhR3P0hh2LqSrhnRfjn8L+IRRi/4Sy0f/kxpCc2
         uLjfzFxbbHhf08YRk32Pa0jyXQzNXF+Np8claYZEOdksqNC3dYBJiECYGdbNqSt1L18C
         VP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707185375; x=1707790175;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Mf3lLucVIqZtk5YO4W6AGvaA761l3Xeyk4k/fRjLyc=;
        b=Yqv0bV5s83HXVS0B8w5LppNi+llwquQlwReJuuLU/QsxVCKN2CQ4Z9DNUveVjQlgKt
         LMx4ncPMomtlnp2mUoqM7SonxZPK7zcer6YTaIHS+4we3MFhN2SoFGswo6axxhQF1PF8
         PWiccsIHzp4h4spSQcZZ4iyRI2SGWqEBponi7/J1YQz4AO/ULBSnuiqhvV+XB2CYXG9s
         yTQLtb01q+PeQD4C5EAXze0Nj72LKyr2wAW/M7bEajIqATVjw1JvLrP4Fq74edHvFEOT
         UWqfC4UQtZGX6Wrx8oSY3xa7ILcjVfvq/yJOzmtv/wCPq9jNYQzQ53AiPnlnCnqIeWoB
         4AUQ==
X-Gm-Message-State: AOJu0YypJH6uha4hbcTB/9kcIo/EulrTIg5aVcW0K1UjsUXaAiO5pJOv
	tKeuUBFQJVlXpcSCb3E687Y7bkq1mu3KUytr7gaRzsYm7x97uGGX
X-Google-Smtp-Source: AGHT+IHIlTu3gSo7V9n4dZCO7z9P2os5tkyGTW1iaeCBVuGgyFwUZqrBhfYRtNF5ju9zG3MCgiqBvw==
X-Received: by 2002:a17:902:f54d:b0:1d9:8ac8:d784 with SMTP id h13-20020a170902f54d00b001d98ac8d784mr259192plf.7.1707185374840;
        Mon, 05 Feb 2024 18:09:34 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUoxUAjy6XeJAJSC8pb1fY8OyWP6S+y/QDh5Dw9iWBZ0c8OEKPQH6zZ5V9iELiOT1Pfow4iRAzz5rTZhnGm+sWmUuFriTt4/VG5g3/nVDwOVarF
Received: from brittons-large-Vivobook ([2600:380:4635:872e:d8c9:9f5d:4e33:1b6a])
        by smtp.gmail.com with ESMTPSA id l13-20020a170903244d00b001d7492d9890sm559532pls.146.2024.02.05.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 18:09:33 -0800 (PST)
Received: by brittons-large-Vivobook (Postfix, from userid 1000)
	id 74E8B520289; Mon,  5 Feb 2024 17:09:31 -0900 (AKST)
From: Britton Leo Kerin <britton.kerin@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Britton Leo Kerin <britton.kerin@gmail.com>
Subject: [PATCH v5 0/7] completion: improvements for git-bisect
Date: Mon,  5 Feb 2024 17:09:23 -0900
Message-ID: <20240206020930.312164-1-britton.kerin@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128223447.342493-1-britton.kerin@gmail.com>
References: <20240128223447.342493-1-britton.kerin@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Relative to v4 this make the following actual changes:

  * fixes GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME to 'master' for all of
    t9902-completion.sh as suggested by Junio.  This change affects all
    of t9902-completion.sh so I've put it by itself in it's own commit.

  * uses BISECT_TERMS to avoid pointless processes as suggested by Patrick.

The commits are also refactored as follows:

  * squashes the introduction of __git_complete_log_opts in with it's
    first use a suggested by Patrick.

  * spreads tests across commits as suggest by Patrick.

Thanks for the reviews.

Britton Leo Kerin (7):
  completion: tests: always use 'master' for default initial branch name
  completion: bisect: complete bad, new, old, and help subcommands
  completion: bisect: complete custom terms and related options
  completion: bisect: complete missing --first-parent and --no-checkout
    options
  completion: new function __git_complete_log_opts
  completion: bisect: complete log opts for visualize subcommand
  completion: bisect: recognize but do not complete view subcommand

 contrib/completion/git-completion.bash |  65 ++++++++++--
 t/t9902-completion.sh                  | 140 +++++++++++++++++++++++++
 2 files changed, 198 insertions(+), 7 deletions(-)

Range-diff against v4:
1:  66153024c3 < -:  ---------- completion: bisect: complete bad, new, old, and help subcommands
-:  ---------- > 1:  71b73de914 completion: tests: always use 'master' for default initial branch name
8:  451b7a4467 ! 2:  3a478a7a08 completion: add tests for git-bisect
    @@ Metadata
     Author: Britton Leo Kerin <britton.kerin@gmail.com>

      ## Commit message ##
    -    completion: add tests for git-bisect
    +    completion: bisect: complete bad, new, old, and help subcommands

    -    There aren't any tests for completion of git bisect and it's
    -    subcommands.
    +    The bad, new, old and help subcommands to git-bisect(1) are not
    +    completed.

    +    Add the bad, new, old, and help subcommands to the appropriate lists
    +    such that the commands and their possible ref arguments are completed.
         Add tests.

    +    Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.c
    +
    + ## contrib/completion/git-completion.bash ##
    +@@ contrib/completion/git-completion.bash: _git_bisect ()
    + {
    + 	__git_has_doubledash && return
    +
    +-	local subcommands="start bad good skip reset visualize replay log run"
    ++	local subcommands="start bad new good old skip reset visualize replay log run help"
    + 	local subcommand="$(__git_find_on_cmdline "$subcommands")"
    + 	if [ -z "$subcommand" ]; then
    + 		__git_find_repo_path
    +@@ contrib/completion/git-completion.bash: _git_bisect ()
    + 	fi
    +
    + 	case "$subcommand" in
    +-	bad|good|reset|skip|start)
    ++	bad|new|good|old|reset|skip|start)
    + 		__git_complete_refs
    + 		;;
    + 	*)
    +
      ## t/t9902-completion.sh ##
     @@ t/t9902-completion.sh: test_expect_success 'git switch - with no options, complete local branches and u
      	EOF
    @@ t/t9902-completion.sh: test_expect_success 'git switch - with no options, comple
     +	EOF
     +'
     +
    -+test_expect_success 'git bisect - complete options to start subcommand' '
    -+	test_completion "git bisect start --" <<-\EOF
    -+	--term-new Z
    -+	--term-bad Z
    -+	--term-old Z
    -+	--term-good Z
    -+	--no-checkout Z
    -+	--first-parent Z
    -+	EOF
    -+'
    -+
     +test_expect_success 'setup for git-bisect tests requiring a repo' '
     +	git init git-bisect &&
     +	(
    @@ t/t9902-completion.sh: test_expect_success 'git switch - with no options, comple
     +		test_completion "git bisect " <<-\EOF
     +		start Z
     +		bad Z
    -+		custom_new Z
    -+		custom_old Z
     +		new Z
     +		good Z
     +		old Z
    -+		terms Z
     +		skip Z
     +		reset Z
     +		visualize Z
    @@ t/t9902-completion.sh: test_expect_success 'git switch - with no options, comple
     +		EOF
     +	)
     +'
    -+test_expect_success 'git-bisect - options to terms subcommand are candidates' '
    -+	(
    -+		cd git-bisect &&
    -+		test_completion "git bisect terms --" <<-\EOF
    -+		--term-bad Z
    -+		--term-good Z
    -+		--term-new Z
    -+		--term-old Z
    -+		EOF
    -+	)
    -+'
    -+
    -+test_expect_success 'git-bisect - git-log options to visualize subcommand are candidates' '
    -+	(
    -+		cd git-bisect &&
    -+		# The completion used for git-log and here does not complete
    -+		# every git-log option, so rather than hope to stay in sync
    -+		# with exactly what it does we will just spot-test here.
    -+		test_completion "git bisect visualize --sta" <<-\EOF &&
    -+		--stat Z
    -+		EOF
    -+		test_completion "git bisect visualize --summar" <<-\EOF
    -+		--summary Z
    -+		EOF
    -+	)
    -+'
    -+
    -+test_expect_success 'git-bisect - view subcommand is not a candidate' '
    -+	(
    -+		cd git-bisect &&
    -+		test_completion "git bisect vi" <<-\EOF
    -+		visualize Z
    -+		EOF
    -+	)
    -+'
    -+
    -+test_expect_success 'git-bisect - existing view subcommand is recognized and enables completion of git-log options' '
    -+	(
    -+		cd git-bisect &&
    -+		# The completion used for git-log and here does not complete
    -+		# every git-log option, so rather than hope to stay in sync
    -+		# with exactly what it does we will just spot-test here.
    -+		test_completion "git bisect view --sta" <<-\EOF &&
    -+		--stat Z
    -+		EOF
    -+		test_completion "git bisect view --summar" <<-\EOF
    -+		--summary Z
    -+		EOF
    -+	)
    -+'
     +
      test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
      	test_completion "git checkout " <<-\EOF
2:  7eb8c842a3 ! 3:  fab7159cf4 completion: bisect: complete custom terms and related options
    @@ Commit message
         these options or the new subcommands they define.

         Add support for these options and the custom subcommands by checking for
    -    them if a bisection is in progress and adding them to the list of
    -    subcommands.
    +    BISECT_TERMS and adding them to the list of subcommands.  Add tests.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: _git_bisect ()
     +
     +	# If a bisection is in progress get the terms being used.
     +	local term_bad term_good
    -+	if [ -f "$__git_repo_path"/BISECT_START ]; then
    ++	if [ -f "$__git_repo_path"/BISECT_TERMS ]; then
     +		term_bad=$(__git bisect terms --term-bad)
     +		term_good=$(__git bisect terms --term-good)
     +	fi
    @@ contrib/completion/git-completion.bash: _git_bisect ()
      		__git_complete_refs
      		;;
      	*)
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
    + 		test_completion "git bisect " <<-\EOF
    + 		start Z
    + 		bad Z
    ++		custom_new Z
    ++		custom_old Z
    + 		new Z
    + 		good Z
    + 		old Z
    ++		terms Z
    + 		skip Z
    + 		reset Z
    + 		visualize Z
    +@@ t/t9902-completion.sh: test_expect_success 'git-bisect - when bisecting all subcommands are candidates'
    + 		EOF
    + 	)
    + '
    ++test_expect_success 'git-bisect - options to terms subcommand are candidates' '
    ++	(
    ++		cd git-bisect &&
    ++		test_completion "git bisect terms --" <<-\EOF
    ++		--term-bad Z
    ++		--term-good Z
    ++		--term-new Z
    ++		--term-old Z
    ++		EOF
    ++	)
    ++'
    ++
    +
    + test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
    + 	test_completion "git checkout " <<-\EOF
3:  5f5076bb93 < -:  ---------- completion: bisect: complete missing --first-parent and --no-checkout options
4:  c8ffa0e915 < -:  ---------- completion: new function __git_complete_log_opts
5:  733613d1ed < -:  ---------- completion: log: use __git_complete_log_opts
-:  ---------- > 4:  73f3343b94 completion: bisect: complete missing --first-parent and --no-checkout options
-:  ---------- > 5:  a20846bbd3 completion: new function __git_complete_log_opts
6:  06f5973b3b ! 6:  fe5545c9a3 completion: bisect: complete log opts for visualize subcommand
    @@ Commit message
         Make completion of porcelain git-log options and option arguments to the
         visualize subcommand work by calling __git_complete_log_opts when the
         start of an option to the subcommand is seen (visualize doesn't support
    -    any options besides the git-log options).
    +    any options besides the git-log options).  Add test.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: _git_bisect ()
      	bad|new|"$term_bad"|good|old|"$term_good"|reset|skip)
      		__git_complete_refs
      		;;
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'git-bisect - options to terms subcommand are candidates' '
    + 	)
    + '
    +
    ++test_expect_success 'git-bisect - git-log options to visualize subcommand are candidates' '
    ++	(
    ++		cd git-bisect &&
    ++		# The completion used for git-log and here does not complete
    ++		# every git-log option, so rather than hope to stay in sync
    ++		# with exactly what it does we will just spot-test here.
    ++		test_completion "git bisect visualize --sta" <<-\EOF &&
    ++		--stat Z
    ++		EOF
    ++		test_completion "git bisect visualize --summar" <<-\EOF
    ++		--summary Z
    ++		EOF
    ++	)
    ++'
    +
    + test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
    + 	test_completion "git checkout " <<-\EOF
7:  1dc9323f24 ! 7:  c9102ac532 completion: bisect: recognize but do not complete view subcommand
    @@ Commit message
         completion for it.

         Recognize but do not complete the view command by creating and using
    -    separate lists of completable_subcommands and all_subcommands.
    +    separate lists of completable_subcommands and all_subcommands.  Add
    +    tests.

         Signed-off-by: Britton Leo Kerin <britton.kerin@gmail.com>

    @@ contrib/completion/git-completion.bash: _git_bisect ()
      		__git_complete_log_opts
      		return
      		;;
    +
    + ## t/t9902-completion.sh ##
    +@@ t/t9902-completion.sh: test_expect_success 'git-bisect - git-log options to visualize subcommand are ca
    + 	)
    + '
    +
    ++test_expect_success 'git-bisect - view subcommand is not a candidate' '
    ++	(
    ++		cd git-bisect &&
    ++		test_completion "git bisect vi" <<-\EOF
    ++		visualize Z
    ++		EOF
    ++	)
    ++'
    ++
    ++test_expect_success 'git-bisect - existing view subcommand is recognized and enables completion of git-log options' '
    ++	(
    ++		cd git-bisect &&
    ++		# The completion used for git-log and here does not complete
    ++		# every git-log option, so rather than hope to stay in sync
    ++		# with exactly what it does we will just spot-test here.
    ++		test_completion "git bisect view --sta" <<-\EOF &&
    ++		--stat Z
    ++		EOF
    ++		test_completion "git bisect view --summar" <<-\EOF
    ++		--summary Z
    ++		EOF
    ++	)
    ++'
    ++
    + test_expect_success 'git checkout - completes refs and unique remote branches for DWIM' '
    + 	test_completion "git checkout " <<-\EOF
    + 	HEAD Z
--
2.43.0

