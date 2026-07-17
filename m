Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5343D37B40C
	for <git@vger.kernel.org>; Fri, 17 Jul 2026 18:27:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784312863; cv=none; b=R16IXLoVyUMhIf6eHtl+QRfpUo5CCtM8hn19X9DyHQF1qmd1gxsVhJPBqNYUVsUzqXIXx9I09tjcDY2cCzsIP7inGUPNTswLfBJC1wIM/gYXTs60V+UvjAHezEPxgpXyuBFAoiUsEEArTJcCmnAw+Y8F3c3sEySPNDUVUByYI6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784312863; c=relaxed/simple;
	bh=PIzrKhYnN2vhV3HblAKJUhFKULzzvMEtFlGUZ40Xr3Q=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uU5ODSzZTu50tG1QB+ULSBamQkwGAMMpzzFb+dT2Ze6eVNuu+vZ0blWwxoinClJ9WY4x+wJiOvkY7UogvzAKie5Bv4yC/5Wlkf+GBDFGhDMSP/xvt0Hb1N6a9ttneGFFJFzWB6+qSWF53vNKD1XCRzpmQwA0dhzyYIhyYQdL+hs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWyMnXKO; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWyMnXKO"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-51c21495722so56198951cf.3
        for <git@vger.kernel.org>; Fri, 17 Jul 2026 11:27:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784312857; x=1784917657; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=uskmVoUVKS1PpZi6C1GuTVf0mDbhdkjHrTGtqJ/HmiA=;
        b=fWyMnXKOyYE4HEKHMN4vGwiCn79XB0hkCZK9xHKq2YJVT2S0FjlxQb4tEf4RlQ60Bb
         WPR0uNjBapWpq3PoK/zru+vknRpIhuriZplt1nGN5pXUpp8AJRXlN3AjfffAKq4fP9nw
         4qs43iKQ+ywie4pP3xbIygA7I44Apfkn1e7XlLccS3A9z+gEb7PiM7Fb1VY1bktkuXO3
         0/38HQCdHEOywT2KVr5+QYDqSwGUaXxm59JxpG3SjaIcxiAS2RpcJNED0YBu5mYKPsFa
         difMJN5tmxjTrWwuRrVop5DGKd0gafCrkkjTOy4eRUpQ3Fc6zKw2sdf0feC5vxDXoPoG
         +seQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784312857; x=1784917657;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=uskmVoUVKS1PpZi6C1GuTVf0mDbhdkjHrTGtqJ/HmiA=;
        b=g8epDuMVmdMtv82UyxpPzc3ckGB5Wpkqrb1sDJooW9lzGR/dgcMOHJYCJp5I+cNMeb
         XyFlHh5WKQUF81h/BBP3Vj8pRK+nVkB1FSm840uPHn/bFpBUeJXrbMZJ1IiObN+RuPfz
         4gBlhKa6T3XDby+SM3KQVpi0Es5D1zbikqIAO6XGicK99DhTkUBmVGTFe4j/52JxHxKb
         1OC4qOo637ioyisoqe/4VKApdbvt59Te7KdF/UdVx6rp0eMzkQZ/viCmcsmkiGSuS0zk
         l0d+/onxdESeMghD1TFyxFvrcYMpTt0zZMKtjfSEyDJijV6J78KxdOZmlU32VsNxugY8
         YYcA==
X-Gm-Message-State: AOJu0YxiJQEqriwR4XCVh70mfVwo1/fc7TF2O1vVknn2tTmw1KsvHWlu
	JHq/YdmxnhAYiyNvGYk5T743OcyXexWI4HM7trw01w+8mPBALN33sUMMcFKL6w==
X-Gm-Gg: AfdE7cng4LSYSPw1ABKmyXExpnlH9RIVRT2wIfxvj0RGWPKYSEO2TSMcoNVdAN4OO/q
	IPxWDinb6vfBNzQEqM5Ilkns/88NqZgS96OQFoGnHsTIATyQ2fxolZGNw/zuTsQeOWrD/iteure
	EbBe9yOBVu8qTw19ANwNbK6HgnwPw8o/q1t6o4oyfVqLSYar9afavX9CeVanj4AW0m8+c3ND/vg
	OvhEUxQjQZnABt2m0LswJUVDeNEgDSNwGprny3H41zZnJGaFcNGarkCJxmPZD/JF9w/gXpVXr/j
	D9r6YFl5b953FjrdLz86v5TbuOit1CxQWGebDMKi9gI3YsR0TrVVq2mkCYcx/fEsEX68pZXn8uV
	5kQgMlNJfdetLv8RKmnp8AHp1h9qGLA5Cg67usiXbMumFzfsfD9c6A+KM0dd3RZsRU/cwVWFV9F
	gIVO15vw==
X-Received: by 2002:ac8:7e8b:0:b0:516:e00e:6868 with SMTP id d75a77b69052e-5213e0828a4mr35378601cf.46.1784312856625;
        Fri, 17 Jul 2026 11:27:36 -0700 (PDT)
Received: from [127.0.0.1] ([172.214.156.84])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-5214f0161e4sm17729421cf.14.2026.07.17.11.27.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:27:35 -0700 (PDT)
Message-Id: <pull.2335.v2.git.git.1784312854.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
References: <pull.2335.git.git.1784180159.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 17 Jul 2026 18:27:31 +0000
Subject: [PATCH v2 0/3] bisect: add --auto-reset to leave when done
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Harald Nordgren <haraldnordgren@gmail.com>

Add a --auto-reset option to git bisect that resets the bisect session when
culprit is found.

Changes in v2:

 * Add option --auto-reset[=<where>] with option to go to final commit as
   well as original.
 * Refactored tests.

Harald Nordgren (3):
  bisect: read run output from the open descriptor
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --auto-reset to leave when done

 Documentation/git-bisect.adoc |  14 +++-
 bisect.c                      |   2 +
 builtin/bisect.c              | 132 +++++++++++++++++++++++++++++-----
 t/t6030-bisect-porcelain.sh   | 107 +++++++++++++++++++++++++++
 4 files changed, 234 insertions(+), 21 deletions(-)


base-commit: 44de1520f08d1dfebc3ab2d9f644208eaa5ac925
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v2
Pull-Request: https://github.com/git/git/pull/2335

Range-diff vs v1:

 1:  3fd365835d = 1:  0de8b12f65 bisect: read run output from the open descriptor
 2:  a7670baafc = 2:  8a2dcdf305 bisect: let bisect_reset() optionally check out quietly
 3:  a9194b1d00 ! 3:  5b3704fbd4 bisect: add --auto-reset to leave when done
     @@ Metadata
       ## Commit message ##
          bisect: add --auto-reset to leave when done
      
     -    When a bisection finished, "git bisect" reported the first bad commit
     -    but left the session active until "git bisect reset" was run by hand.
     +    When a bisection finishes, "git bisect" reports the first bad commit
     +    but leaves the session active until "git bisect reset" is run by hand.
      
     -    Add an "--auto-reset" option, accepted by both "git bisect start" and
     -    "git bisect run", that resets as soon as the first bad commit is found,
     -    returning to the commit checked out before "git bisect start". The flag
     -    is persisted in a BISECT_AUTO_RESET state file and the restoring
     -    checkout is done quietly.
     +    Add an "--auto-reset[=<where>]" option, accepted by both "git bisect
     +    start" and "git bisect run", that resets as soon as the first bad commit
     +    is found. The "original" value returns to the commit checked out before
     +    "git bisect start", while "found" leaves the first bad commit checked
     +    out; omitting the value defaults to "original".
     +
     +    Persist the selected target in a BISECT_AUTO_RESET state file and perform
     +    the reset quietly. Reject this option together with "--no-checkout",
     +    since that mode must not check out either target.
      
          Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
      
     @@ Documentation/git-bisect.adoc: SYNOPSIS
       [synopsis]
       git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]
      -		 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]
     -+		 [--no-checkout] [--first-parent] [--auto-reset] [<bad> [<good>...]] [--] [<pathspec>...]
     ++		 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]
       git bisect (bad|new|<term-new>) [<rev>]
       git bisect (good|old|<term-old>) [<rev>...]
       git bisect terms [--term-(good|old) | --term-(bad|new)]
     @@ Documentation/git-bisect.adoc: git bisect reset [<commit>]
       git bisect replay <logfile>
       git bisect log
      -git bisect run <cmd> [<arg>...]
     -+git bisect run [--auto-reset] <cmd> [<arg>...]
     ++git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]
       git bisect help
       
       DESCRIPTION
     @@ Documentation/git-bisect.adoc: ignored.
       This option is particularly useful in avoiding false positives when a merged
       branch contained broken or non-buildable commits, but the merge itself was OK.
       
     -+`--auto-reset`::
     -+	Once the first bad commit is found, clean up the bisection state and
     -+	return to the commit that was checked out before `git bisect start`,
     -+	as if `git bisect reset` had been run. The first bad commit is still
     -+	reported before resetting.
     ++`--auto-reset[=<where>]`::
     ++	Once the first bad commit is found, report it and clean up the
     ++	bisection state. `<where>` may be `original` to return to the commit
     ++	checked out before `git bisect start`, or `found` to leave the first
     ++	bad commit checked out. If `<where>` is omitted, it defaults to
     ++	`original`.
      ++
     -+This option may be given to `git bisect start` or to `git bisect run`.
     ++This option may be given to `git bisect start` or to `git bisect run`. It
     ++cannot be used for a bisection started with `--no-checkout`.
      +
       EXAMPLES
       --------
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       #define BUILTIN_GIT_BISECT_START_USAGE \
       	N_("git bisect start [--term-(bad|new)=<term-new> --term-(good|old)=<term-old>]\n" \
      -	   "                 [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<pathspec>...]")
     -+	   "                 [--no-checkout] [--first-parent] [--auto-reset] [<bad> [<good>...]] [--] [<pathspec>...]")
     ++	   "                 [--no-checkout] [--first-parent] [--auto-reset[=<where>]] [<bad> [<good>...]] [--] [<pathspec>...]")
       #define BUILTIN_GIT_BISECT_BAD_USAGE \
       	N_("git bisect (bad|new|<term-new>) [<rev>]")
       #define BUILTIN_GIT_BISECT_GOOD_USAGE \
     @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
       	"git bisect log"
       #define BUILTIN_GIT_BISECT_RUN_USAGE \
      -	N_("git bisect run <cmd> [<arg>...]")
     -+	N_("git bisect run [--auto-reset] <cmd> [<arg>...]")
     ++	N_("git bisect run [--auto-reset[=<where>]] <cmd> [<arg>...]")
       #define BUILTIN_GIT_BISECT_HELP_USAGE \
       	"git bisect help"
       
     +@@ builtin/bisect.c: static const char * const git_bisect_usage[] = {
     + 	NULL
     + };
     + 
     ++enum auto_reset_mode {
     ++	AUTO_RESET_NONE,
     ++	AUTO_RESET_ORIGINAL,
     ++	AUTO_RESET_FOUND,
     ++};
     ++
     + struct add_bisect_ref_data {
     + 	struct rev_info *revs;
     + 	unsigned int object_flags;
     +@@ builtin/bisect.c: static int bisect_reset(const char *commit, int quiet)
     + 	return bisect_clean_state();
     + }
     + 
     ++static int parse_auto_reset(const char *value, enum auto_reset_mode *mode)
     ++{
     ++	if (!strcmp(value, "original"))
     ++		*mode = AUTO_RESET_ORIGINAL;
     ++	else if (!strcmp(value, "found"))
     ++		*mode = AUTO_RESET_FOUND;
     ++	else
     ++		return error(_("invalid value for '--auto-reset': '%s'"), value);
     ++
     ++	return 0;
     ++}
     ++
     ++static const char *auto_reset_mode_name(enum auto_reset_mode mode)
     ++{
     ++	switch (mode) {
     ++	case AUTO_RESET_ORIGINAL:
     ++		return "original";
     ++	case AUTO_RESET_FOUND:
     ++		return "found";
     ++	case AUTO_RESET_NONE:
     ++		BUG("no name for unset auto-reset mode");
     ++	}
     ++	BUG("unknown auto-reset mode %d", mode);
     ++}
     ++
     ++static int bisect_auto_reset(struct bisect_terms *terms)
     ++{
     ++	struct strbuf value = STRBUF_INIT;
     ++	enum auto_reset_mode mode;
     ++	char *commit = NULL;
     ++	int res;
     ++
     ++	if (strbuf_read_file(&value, git_path_bisect_auto_reset(), 0) < 0) {
     ++		res = error_errno(_("could not read '%s'"),
     ++				  git_path_bisect_auto_reset());
     ++		goto cleanup;
     ++	}
     ++	strbuf_trim(&value);
     ++	if (parse_auto_reset(value.buf, &mode)) {
     ++		res = -1;
     ++		goto cleanup;
     ++	}
     ++
     ++	if (mode == AUTO_RESET_FOUND)
     ++		commit = xstrfmt("refs/bisect/%s", terms->term_bad);
     ++	res = bisect_reset(commit, 1);
     ++
     ++cleanup:
     ++	free(commit);
     ++	strbuf_release(&value);
     ++	return res;
     ++}
     ++
     + static void log_commit(FILE *fp,
     + 		       const char *fmt, const char *state,
     + 		       struct commit *commit)
      @@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
       
       	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
       		res = bisect_successful(terms);
      +		if (!res && !is_empty_or_missing_file(git_path_bisect_auto_reset()))
     -+			res = bisect_reset(NULL, 1);
     ++			res = bisect_auto_reset(terms);
       		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
       	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
       		res = bisect_skipped_commits(terms);
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       {
       	int no_checkout = 0;
       	int first_parent_only = 0;
     -+	int auto_reset = 0;
     ++	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
       	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
       	int flags, pathspec_pos;
       	enum bisect_error res = BISECT_OK;
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       		} else if (!strcmp(arg, "--first-parent")) {
       			first_parent_only = 1;
      +		} else if (!strcmp(arg, "--auto-reset")) {
     -+			auto_reset = 1;
     ++			auto_reset = AUTO_RESET_ORIGINAL;
     ++		} else if (skip_prefix(arg, "--auto-reset=", &arg)) {
     ++			if (parse_auto_reset(arg, &auto_reset)) {
     ++				res = BISECT_FAILED;
     ++				goto finish;
     ++			}
       		} else if (!strcmp(arg, "--term-good") ||
       			 !strcmp(arg, "--term-old")) {
       			i++;
     +@@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
     + 			break;
     + 		}
     + 	}
     ++	if (auto_reset != AUTO_RESET_NONE && no_checkout) {
     ++		res = error(_("'--auto-reset' cannot be used with '--no-checkout'"));
     ++		goto finish;
     ++	}
     + 	pathspec_pos = i;
     + 
     + 	/*
      @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
       	if (first_parent_only)
       		write_file(git_path_bisect_first_parent(), "\n");
       
     -+	if (auto_reset)
     -+		write_file(git_path_bisect_auto_reset(), "\n");
     ++	if (auto_reset != AUTO_RESET_NONE)
     ++		write_file(git_path_bisect_auto_reset(), "%s\n",
     ++			   auto_reset_mode_name(auto_reset));
      +
       	if (no_checkout) {
       		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
       			res = error(_("invalid ref: '%s'"), start_head.buf);
     +@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     + {
     + 	int res = BISECT_OK;
     + 	struct strbuf command = STRBUF_INIT;
     ++	enum auto_reset_mode auto_reset = AUTO_RESET_NONE;
     ++	const char *auto_reset_arg;
     + 	const char *new_state;
     + 	int temporary_stdout_fd, saved_stdout;
     + 	int is_first_run = 1;
      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
       	if (bisect_next_check(terms, NULL))
       		return BISECT_FAILED;
       
     -+	if (argc && !strcmp(argv[0], "--auto-reset")) {
     -+		write_file(git_path_bisect_auto_reset(), "\n");
     ++	if (argc && !strcmp(argv[0], "--auto-reset"))
     ++		auto_reset = AUTO_RESET_ORIGINAL;
     ++	else if (argc && skip_prefix(argv[0], "--auto-reset=", &auto_reset_arg)) {
     ++		if (parse_auto_reset(auto_reset_arg, &auto_reset))
     ++			return BISECT_FAILED;
     ++	}
     ++
     ++	if (auto_reset != AUTO_RESET_NONE) {
     ++		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
     ++			return error(_("'--auto-reset' cannot be used with '--no-checkout'"));
     ++		write_file(git_path_bisect_auto_reset(), "%s\n",
     ++			   auto_reset_mode_name(auto_reset));
      +		argc--;
      +		argv++;
      +	}
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       		return BISECT_FAILED;
      
       ## t/t6030-bisect-porcelain.sh ##
     +@@ t/t6030-bisect-porcelain.sh: test_bisect_usage () {
     + 	test_cmp expect actual
     + }
     + 
     ++test_bisect_state_file () {
     ++	test_path_is_file "$(git rev-parse --git-path "$1")"
     ++}
     ++
     ++test_bisect_state_missing () {
     ++	test_path_is_missing "$(git rev-parse --git-path "$1")"
     ++}
     ++
     ++bisect_start_and_finish () {
     ++	git bisect start "$1" $HASH4 $HASH2 &&
     ++	git bisect bad
     ++}
     ++
     ++bisect_run_auto_reset () {
     ++	write_script test_script.sh <<-\EOF &&
     ++	! grep Another hello >/dev/null
     ++	EOF
     ++	git bisect start $HASH4 $HASH2 &&
     ++	git bisect run "$1" ./test_script.sh >my_bisect_log.txt &&
     ++	test_grep "$HASH3 is the first .bad. commit" my_bisect_log.txt
     ++}
     ++
     ++test_auto_reset_fails () {
     ++	local pattern="$1" &&
     ++	local state_file="$2" &&
     ++	shift 2 &&
     ++	test_must_fail "$@" 2>err &&
     ++	test_grep -- "$pattern" err &&
     ++	test_bisect_state_missing "$state_file"
     ++}
     ++
     + test_expect_success 'bisect usage' "
     + 	test_bisect_usage 1 git bisect reset extra1 extra2 <<-\EOF &&
     + 	error: 'git bisect reset' requires either no argument or a commit
      @@ t/t6030-bisect-porcelain.sh: test_expect_success '"git bisect run" simple case' '
       	git bisect reset
       '
       
     -+test_expect_success '"git bisect start --auto-reset" leaves the bisection' '
     -+	test_when_finished "git bisect reset" &&
     -+	git bisect start --auto-reset $HASH4 $HASH2 &&
     -+	git bisect bad &&
     -+	test_path_is_missing "$(git rev-parse --git-path BISECT_START)"
     ++test_expect_success '"git bisect start --auto-reset" defaults to original' '
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	git checkout main &&
     ++	bisect_start_and_finish --auto-reset &&
     ++	test "$HASH4" = "$(git rev-parse HEAD)" &&
     ++	test main = "$(git branch --show-current)" &&
     ++	test_bisect_state_missing BISECT_START &&
     ++
     ++	bisect_start_and_finish --auto-reset=original &&
     ++	test "$HASH4" = "$(git rev-parse HEAD)" &&
     ++	test main = "$(git branch --show-current)" &&
     ++	test_bisect_state_missing BISECT_START
      +'
      +
     -+test_expect_success '"git bisect run --auto-reset" leaves the bisection' '
     -+	test_when_finished "git bisect reset" &&
     -+	write_script test_script.sh <<-\EOF &&
     -+	! grep Another hello >/dev/null
     -+	EOF
     ++test_expect_success '"git bisect start --auto-reset=found" leaves first bad checked out' '
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	bisect_start_and_finish --auto-reset=found &&
     ++	test "$HASH3" = "$(git rev-parse HEAD)" &&
     ++	test_bisect_state_missing BISECT_START
     ++'
     ++
     ++test_expect_success '"git bisect run --auto-reset" defaults to original' '
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	bisect_run_auto_reset --auto-reset &&
     ++	test "$HASH4" = "$(git rev-parse HEAD)" &&
     ++	test main = "$(git branch --show-current)" &&
     ++	test_bisect_state_missing BISECT_START
     ++'
     ++
     ++test_expect_success '"git bisect run --auto-reset=found" leaves first bad checked out' '
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	bisect_run_auto_reset --auto-reset=found &&
     ++	test "$HASH3" = "$(git rev-parse HEAD)" &&
     ++	test_bisect_state_missing BISECT_START
     ++'
     ++
     ++test_expect_success '--auto-reset rejects an unknown reset target' '
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	test_auto_reset_fails \
     ++		"invalid value for.*--auto-reset.*unknown" BISECT_START \
     ++		git bisect start --auto-reset=unknown $HASH4 $HASH2 &&
     ++
      +	git bisect start $HASH4 $HASH2 &&
     -+	git bisect run --auto-reset ./test_script.sh >my_bisect_log.txt &&
     -+	grep "$HASH3 is the first .bad. commit" my_bisect_log.txt &&
     -+	test_path_is_missing "$(git rev-parse --git-path BISECT_START)"
     ++	test_auto_reset_fails \
     ++		"invalid value for.*--auto-reset.*unknown" BISECT_AUTO_RESET \
     ++		git bisect run --auto-reset=unknown true
     ++'
     ++
     ++test_expect_success '--auto-reset cannot be used with --no-checkout' '
     ++	test_when_finished "git bisect reset" &&
     ++	test_auto_reset_fails \
     ++		"cannot be used with.*--no-checkout" BISECT_START \
     ++		git bisect start --auto-reset=original --no-checkout $HASH4 $HASH2 &&
     ++
     ++	git bisect start --no-checkout $HASH4 $HASH2 &&
     ++	test_auto_reset_fails \
     ++		"cannot be used with.*--no-checkout" BISECT_AUTO_RESET \
     ++		git bisect run --auto-reset=found true
      +'
      +
      +test_expect_success 'without --auto-reset the bisection state is kept' '
      +	test_when_finished "git bisect reset" &&
      +	git bisect start $HASH4 $HASH2 &&
      +	git bisect bad &&
     -+	test_path_is_file "$(git rev-parse --git-path BISECT_START)"
     ++	test_bisect_state_file BISECT_START
      +'
      +
      +test_expect_success '--auto-reset does not leak into a later bisection' '
     -+	test_when_finished "git bisect reset" &&
     -+	git bisect start --auto-reset $HASH4 $HASH2 &&
     -+	git bisect bad &&
     ++	test_when_finished "git bisect reset; git checkout main" &&
     ++	bisect_start_and_finish --auto-reset &&
     ++
      +	git bisect start $HASH4 $HASH2 &&
      +	git bisect bad &&
     -+	test_path_is_file "$(git rev-parse --git-path BISECT_START)"
     ++	test_bisect_state_file BISECT_START
      +'
      +
       # We want to automatically find the commit that

-- 
gitgitgadget
