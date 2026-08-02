Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E7BB21A459
	for <git@vger.kernel.org>; Sun,  2 Aug 2026 09:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785663080; cv=none; b=JAPYknKKK4Dgg/MQd0scXNndNpslxkWslb+v66ScznMaRdM3VAIpsFK3RIxA4UX7DSlGJVgaJ9HmHIk6gBvV9mSAMlA3OTAI1FDGJPOxyEn+KDLFuVs7J3pQA9dQ4iCTFyonNL23EVzUmNgN0e0QtJTcebA7XxzbZYafOqQUOT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785663080; c=relaxed/simple;
	bh=LG32Qp9DjG4u5Zzd8SYswSUzrX/nSswcDP2NAPjn7Tk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=GYACj2mju+2B/VngBwole84ZbgBafPydvZ3wmcRdIwfvPWqHbmA/TsSet3ZpBrtv2R1UNJfkzHycrPwcl+voBFV6LGoBPVrWDUy9OJFueKZYmRN/X23hdslSnXJnCu2qLzPWoDDbwft42APJir9zjXbwBpVQjsKmwnShFA1B4l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MBK2xPI7; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MBK2xPI7"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c9eefcf9175so2081998a12.3
        for <git@vger.kernel.org>; Sun, 02 Aug 2026 02:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785663078; x=1786267878; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=fvOXMAOzi/r1vBJKS4QoD2DvzII6KhI14gUaW+H7228=;
        b=MBK2xPI7MpRW1mYSMjTReXdJVF+WBCNhfLwvzzAA4kSuVEnTfmFWaRzX+i5Z2CuT5M
         BWxuXJ8Z+iT2oycdMi0IX1ZjIhgM4ux1gBzSHZFkWL7Y9f8yRoFqVR/TBz7EGjzXetyV
         i+BM/F3Pnusd25f00JSRB2+/ULv4suQAXUKPKf5TzgKL0eEALxscjCXTfP3tiyYteIJA
         tw57OKzlDC+USHI9F4froAoYRQdGuJoHwd73c4NfkNZLsGJK9zdfGKM3II3hMkk0rtdS
         iTJNe+BuVfDruGzhWpVJeBCWk0M5Tdw/oTVBEoXYj4MOEHCp3yWolGZQKkL2+mxXOQaO
         KxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785663078; x=1786267878;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fvOXMAOzi/r1vBJKS4QoD2DvzII6KhI14gUaW+H7228=;
        b=VbbqAKABE0vvW/+d+QLGZ+A2lcWnJb39Pz6txoh+6kNwtqLrSREqMmT0VKM9cc6GOD
         LfbQujQxY3uq7j9IRkdNmggU95pl5wVZDvs/7TqJjHZc4ok5QOwK8qKy9/aKvwlDl+RN
         i8D4WEn7n0Sl0wJrVIndsXMYcsi4P5cIJzGIts6fp6UI4qEx2ql7K3H73WGNGkin/y8O
         IyQb2NUWigr4P/kXRZvu4XX7f7E8O6UrJgRR7c+gK5UGKeiw1yi4nAdhaJKF/TiXAh2j
         8QVIbYvsWxHsNqEiRe6708bxJkk3757Vx94N38IgqaxDjrLLXpvSOT+ELF+oQwxglLJT
         89Dg==
X-Gm-Message-State: AOJu0YzdGrhTpwen+bNHu6pa3plhUp0CCSC+YQ69gF8Wd+NEEwwqdOB0
	yb+DcoSLEXIx9S1Pv62Y0NkcZzp85C5OEdR3MqUsLT86kpr+2PmmUiEq5Y2AkA==
X-Gm-Gg: AR+sD11EYt66WA7FJYsrY3f1NF8dwpTwKtWHOaiul/RZA95m2FN83jU1i0KmvCXJWfO
	OYy/PuieXTcuK3Eon/OTA+LG2k/EhZwQ4zg0dQHS/GQ2M/uS2KpsXS3kk6ynKEpvav6vmVL8kvF
	dDzL4iqF5J+4nJ9hgHmTJRI/iiuxkSfRY5jXMM/KseOdH4ED/2ZohIXAEpjSwzIQPczhUNiBNxV
	5Xu2CzJUp5x8Lk5PwAkf1g76S6oQpK0lq7IfEts4phOJFb8H584J2IqESjkNqfrAMLKZmRawkCb
	epS0wzdu/mIzFBp+Cro+C6yG7MjGYVBa9eNr6SgEGvq5D1nihyc6z3aHShwmeIMYbK/iN+Gy76y
	RAvnBT5iNSbG2nqzVmkIennaosTfwOEP5oGg7T1ZfKhdqquWdCbTmTMDEkiwwn1PSicivUNP1Tn
	B5gGlV4sUL7/EnKCjOXbdnZ0fF2jF6c24kaa6ExTgoECbWgMJPA/lzXm48zYmmgcFI
X-Received: by 2002:a05:6a21:710e:b0:3c3:6528:c87 with SMTP id adf61e73a8af0-3c92a519c67mr6164334637.1.1785663077520;
        Sun, 02 Aug 2026 02:31:17 -0700 (PDT)
Received: from [127.0.0.1] ([57.154.167.113])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e06f88fsm24494299eec.20.2026.08.02.02.31.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 02:31:16 -0700 (PDT)
Message-Id: <pull.2335.v5.git.git.1785663075.gitgitgadget@gmail.com>
In-Reply-To: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
References: <pull.2335.v4.git.git.1785577445.gitgitgadget@gmail.com>
From: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 02 Aug 2026 09:31:13 +0000
Subject: [PATCH v5 0/2] bisect: add --reset-when-found to leave when done
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
Cc: Johannes Sixt <j6t@kdbg.org>,
    Harald Nordgren <haraldnordgren@gmail.com>

Add a --reset-when-found option to git bisect that resets the bisect session
when culprit is found.

Changes in v5:

 * Move automatic reset handling to cmd_bisect() after subcommand resources
   are closed.
 * Propagate the first-bad commit OID from bisect_next_all() and remove
   defer_reset plumbing.
 * Separate checkout from state cleanup in bisect_reset(), and use bool for
   its quiet flag.

Changes in v4:

 * Simplify translation calls.
 * Avoid git subshell calls in tests, that can bury errors.

Changes in v3:

 * Rename --auto-reset to --reset-when-found, including internal names.
 * Defer git bisect run cleanup until captured output is printed and
   BISECT_RUN is closed. Drop the open-descriptor preparatory change,
   retaining the existing filename-based output handling.

Changes in v2:

 * Add option --auto-reset[=<where>] with option to go to final commit as
   well as original.
 * Refactored tests.

Harald Nordgren (2):
  bisect: let bisect_reset() optionally check out quietly
  bisect: add --reset-when-found to leave when done

 Documentation/git-bisect.adoc |  14 ++-
 bisect.c                      |   6 +-
 bisect.h                      |   3 +-
 builtin/bisect.c              | 165 +++++++++++++++++++++++++++++++---
 t/t6030-bisect-porcelain.sh   | 121 +++++++++++++++++++++++++
 5 files changed, 292 insertions(+), 17 deletions(-)


base-commit: a97fcc37c2bc6340a8d7ce78dedf227aac4e9aa7
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2335%2FHaraldNordgren%2Fbisect-auto-reset-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2335/HaraldNordgren/bisect-auto-reset-v5
Pull-Request: https://github.com/git/git/pull/2335

Range-diff vs v4:

 1:  e39670edf4 ! 1:  b6ab87fd29 bisect: let bisect_reset() optionally check out quietly
     @@ builtin/bisect.c: static int write_terms(const char *bad, const char *good)
       }
       
      -static int bisect_reset(const char *commit)
     -+static int bisect_reset(const char *commit, int quiet)
     ++static int bisect_reset(const char *commit, bool quiet)
       {
       	struct strbuf branch = STRBUF_INIT;
       
     @@ builtin/bisect.c: static enum bisect_error bisect_replay(struct bisect_terms *te
       		return error(_("cannot read file '%s' for replaying"), filename);
       
      -	if (bisect_reset(NULL))
     -+	if (bisect_reset(NULL, 0))
     ++	if (bisect_reset(NULL, false))
       		return BISECT_FAILED;
       
       	fp = fopen(filename, "r");
     @@ builtin/bisect.c: static int cmd_bisect__reset(int argc, const char **argv, cons
       		return error(_("'%s' requires either no argument or a commit"),
       			     "git bisect reset");
      -	return bisect_reset(argc ? argv[0] : NULL);
     -+	return bisect_reset(argc ? argv[0] : NULL, 0);
     ++	return bisect_reset(argc ? argv[0] : NULL, false);
       }
       
       static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
 2:  f5f370df1b ! 2:  ec362f3b82 bisect: add --reset-when-found to leave when done
     @@ Commit message
          Persist the selected target in a BISECT_RESET_WHEN_FOUND state file
          and perform the reset quietly.
      
     -    For "git bisect run", defer the reset until after the captured output
     -    is printed and BISECT_RUN is closed. This lets cleanup remove the file
     -    on systems that cannot unlink an open file.
     +    Propagate the internal first-bad result and its commit to
     +    cmd_bisect(), which performs the reset after the subcommand has
     +    returned. For "git bisect run", this means BISECT_RUN has been printed
     +    and closed before cleanup, which also works on systems that cannot
     +    unlink an open file.
      
          Reject this option together with "--no-checkout", since that mode must
          not check out either target.
     @@ bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       
       static void read_bisect_paths(struct strvec *array)
       {
     +@@ bisect.c: void read_bisect_terms(char **read_bad, char **read_good)
     +  * the end of bisect_helper::cmd_bisect__helper() helps bypassing
     +  * all the code related to finding a commit to test.
     +  */
     +-enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
     ++enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
     ++				  struct object_id *first_bad)
     + {
     + 	struct strvec rev_argv = STRVEC_INIT;
     + 	struct rev_info revs = REV_INFO_INIT;
     +@@ bisect.c: enum bisect_error bisect_next_all(struct repository *r, const char *prefix)
     + 		res = error_if_skipped_commits(tried, current_bad_oid);
     + 		if (res)
     + 			goto cleanup;
     ++		oidcpy(first_bad, bisect_rev);
     + 		printf("%s is the first '%s' commit\n", oid_to_hex(bisect_rev),
     + 			term_bad);
     + 
      @@ bisect.c: int bisect_clean_state(void)
       	unlink_or_warn(git_path_bisect_run());
       	unlink_or_warn(git_path_bisect_terms());
     @@ bisect.c: int bisect_clean_state(void)
       	 * Cleanup BISECT_START last to support the --no-checkout option
       	 * introduced in the commit 4796e823a.
      
     + ## bisect.h ##
     +@@ bisect.h: struct bisect_state {
     + 	unsigned int nr_bad;
     + };
     + 
     +-enum bisect_error bisect_next_all(struct repository *r, const char *prefix);
     ++enum bisect_error bisect_next_all(struct repository *r, const char *prefix,
     ++				  struct object_id *first_bad);
     + 
     + int estimate_bisect_steps(int all);
     + 
     +
       ## builtin/bisect.c ##
      @@ builtin/bisect.c: static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
       static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
     @@ builtin/bisect.c: static const char * const git_bisect_usage[] = {
       struct add_bisect_ref_data {
       	struct rev_info *revs;
       	unsigned int object_flags;
     -@@ builtin/bisect.c: static int bisect_reset(const char *commit, int quiet)
     - 	return bisect_clean_state();
     - }
     +@@ builtin/bisect.c: struct bisect_terms {
     + 	char *term_bad;
     + };
       
     ++static struct object_id first_bad_oid;
     ++
     + static void free_terms(struct bisect_terms *terms)
     + {
     + 	FREE_AND_NULL(terms->term_good);
     +@@ builtin/bisect.c: static int bisect_reset(const char *commit, bool quiet)
     + 	}
     + 
     + 	strbuf_release(&branch);
     +-	return bisect_clean_state();
     ++	return 0;
     ++}
     ++
      +static int parse_reset_when_found(const char *value,
      +				  enum reset_when_found_mode *mode)
      +{
     @@ builtin/bisect.c: static int bisect_reset(const char *commit, int quiet)
      +	BUG("unknown reset-when-found mode %d", mode);
      +}
      +
     -+static int bisect_reset_when_found(struct bisect_terms *terms)
     ++static int read_reset_when_found(enum reset_when_found_mode *mode)
      +{
      +	struct strbuf value = STRBUF_INIT;
     -+	enum reset_when_found_mode mode;
     -+	char *commit = NULL;
     -+	int res;
     ++	int res = 0;
     ++
     ++	*mode = RESET_WHEN_FOUND_NONE;
     ++	if (is_empty_or_missing_file(git_path_bisect_reset_when_found()))
     ++		return 0;
      +
      +	if (strbuf_read_file(&value, git_path_bisect_reset_when_found(), 0) < 0) {
      +		res = error_errno(_("could not read '%s'"),
      +				  git_path_bisect_reset_when_found());
     -+		goto cleanup;
     ++		goto out;
      +	}
      +	strbuf_trim(&value);
     -+	if (parse_reset_when_found(value.buf, &mode)) {
     ++	if (parse_reset_when_found(value.buf, mode))
      +		res = -1;
     -+		goto cleanup;
     -+	}
      +
     -+	if (mode == RESET_WHEN_FOUND_TO_FOUND)
     -+		commit = xstrfmt("refs/bisect/%s", terms->term_bad);
     -+	res = bisect_reset(commit, 1);
     -+
     -+cleanup:
     -+	free(commit);
     ++out:
      +	strbuf_release(&value);
      +	return res;
      +}
      +
     ++static int bisect_reset_when_found(enum reset_when_found_mode mode)
     ++{
     ++	char first_bad_hex[GIT_MAX_HEXSZ + 1];
     ++	const char *commit = NULL;
     ++	int res;
     ++
     ++	if (mode == RESET_WHEN_FOUND_TO_FOUND)
     ++		commit = oid_to_hex_r(first_bad_hex, &first_bad_oid);
     ++	else if (mode == RESET_WHEN_FOUND_NONE)
     ++		BUG("automatic reset requested without a reset mode");
     ++
     ++	res = bisect_reset(commit, true);
     ++	if (!res)
     ++		res = bisect_clean_state();
     ++
     ++	return res;
     + }
     + 
       static void log_commit(FILE *fp,
     - 		       const char *fmt, const char *state,
     - 		       struct commit *commit)
      @@ builtin/bisect.c: static int bisect_successful(struct bisect_terms *terms)
       	return res;
       }
       
      -static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
      +static enum bisect_error bisect_next(struct bisect_terms *terms,
     -+				     const char *prefix, bool defer_reset)
     ++				     const char *prefix)
       {
       	enum bisect_error res;
       
      @@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
     + 		return BISECT_FAILED;
     + 
     + 	/* Perform all bisection computation */
     +-	res = bisect_next_all(the_repository, prefix);
     ++	res = bisect_next_all(the_repository, prefix, &first_bad_oid);
       
       	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
       		res = bisect_successful(terms);
     -+		if (!res && !defer_reset &&
     -+		    !is_empty_or_missing_file(git_path_bisect_reset_when_found()))
     -+			res = bisect_reset_when_found(terms);
     - 		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
     - 	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
     - 		res = bisect_skipped_commits(terms);
      @@ builtin/bisect.c: static enum bisect_error bisect_next(struct bisect_terms *terms, const char *pre
       	return res;
       }
       
      -static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
      +static enum bisect_error bisect_auto_next(struct bisect_terms *terms,
     -+					  const char *prefix, bool defer_reset)
     ++					  const char *prefix)
       {
       	if (bisect_next_check(terms, NULL)) {
       		bisect_print_status(terms);
     - 		return BISECT_OK;
     - 	}
     - 
     --	return bisect_next(terms, prefix);
     -+	return bisect_next(terms, prefix, defer_reset);
     - }
     - 
     - static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
      @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
     - {
     - 	int no_checkout = 0;
     - 	int first_parent_only = 0;
     + 	struct strbuf bisect_names = STRBUF_INIT;
     + 	struct object_id head_oid;
     + 	struct object_id oid;
      +	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
     - 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
     - 	int flags, pathspec_pos;
     - 	enum bisect_error res = BISECT_OK;
     + 	const char *head;
     + 
     + 	if (is_bare_repository(the_repository))
      @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *terms, int argc,
       			no_checkout = 1;
       		} else if (!strcmp(arg, "--first-parent")) {
     @@ builtin/bisect.c: static enum bisect_error bisect_start(struct bisect_terms *ter
       	if (no_checkout) {
       		if (repo_get_oid(the_repository, start_head.buf, &oid) < 0) {
       			res = error(_("invalid ref: '%s'"), start_head.buf);
     -@@ builtin/bisect.c: finish:
     - 	if (res)
     - 		return res;
     - 
     --	res = bisect_auto_next(terms, NULL);
     -+	res = bisect_auto_next(terms, NULL, false);
     - 	if (!is_bisect_success(res))
     - 		bisect_clean_state();
     - 	return res;
     -@@ builtin/bisect.c: static int bisect_autostart(struct bisect_terms *terms)
     - }
     - 
     - static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
     --				      const char **argv)
     -+				      const char **argv, bool defer_reset)
     - {
     - 	const char *state;
     - 	int i, verify_expected = 1;
     -@@ builtin/bisect.c: static enum bisect_error bisect_state(struct bisect_terms *terms, int argc,
     - 	}
     - 
     - 	oid_array_clear(&revs);
     --	return bisect_auto_next(terms, NULL);
     -+	return bisect_auto_next(terms, NULL, defer_reset);
     - }
     - 
     - static enum bisect_error bisect_log(void)
      @@ builtin/bisect.c: static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
     - 	if (res)
     - 		return BISECT_FAILED;
     + 	if (is_empty_or_missing_file(filename))
     + 		return error(_("cannot read file '%s' for replaying"), filename);
       
     --	return bisect_auto_next(terms, NULL);
     -+	return bisect_auto_next(terms, NULL, false);
     - }
     - 
     - static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
     -@@ builtin/bisect.c: static enum bisect_error bisect_skip(struct bisect_terms *terms, int argc,
     - 			strvec_push(&argv_state, argv[i]);
     - 		}
     - 	}
     --	res = bisect_state(terms, argv_state.nr, argv_state.v);
     -+	res = bisect_state(terms, argv_state.nr, argv_state.v, false);
     +-	if (bisect_reset(NULL, false))
     ++	if (bisect_clean_state())
     + 		return BISECT_FAILED;
       
     - 	strvec_clear(&argv_state);
     - 	return res;
     + 	fp = fopen(filename, "r");
      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
       {
       	int res = BISECT_OK;
       	struct strbuf command = STRBUF_INIT;
     -+	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
      +	const char *reset_when_found_arg;
       	const char *new_state;
       	int temporary_stdout_fd, saved_stdout;
       	int is_first_run = 1;
     -@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     ++	enum reset_when_found_mode reset_when_found = RESET_WHEN_FOUND_NONE;
     ++	bool reset_when_found_arg_seen = false;
     + 
       	if (bisect_next_check(terms, NULL))
       		return BISECT_FAILED;
       
     -+	if (argc && !strcmp(argv[0], "--reset-when-found"))
     ++	if (argc && !strcmp(argv[0], "--reset-when-found")) {
      +		reset_when_found = RESET_WHEN_FOUND_TO_ORIGINAL;
     -+	else if (argc && skip_prefix(argv[0], "--reset-when-found=",
     ++		reset_when_found_arg_seen = true;
     ++	} else if (argc && skip_prefix(argv[0], "--reset-when-found=",
      +				    &reset_when_found_arg)) {
     -+		if (parse_reset_when_found(reset_when_found_arg, &reset_when_found))
     ++		if (parse_reset_when_found(reset_when_found_arg,
     ++					   &reset_when_found))
      +			return BISECT_FAILED;
     ++		reset_when_found_arg_seen = true;
      +	}
      +
     -+	if (reset_when_found != RESET_WHEN_FOUND_NONE) {
     -+		if (refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
     -+			return error(_("options '%s' and '%s' cannot be used together"),
     -+				     "--reset-when-found", "--no-checkout");
     ++	if (reset_when_found != RESET_WHEN_FOUND_NONE &&
     ++	    refs_ref_exists(get_main_ref_store(the_repository), "BISECT_HEAD"))
     ++		return error(_("options '%s' and '%s' cannot be used together"),
     ++			     "--reset-when-found", "--no-checkout");
     ++
     ++	if (reset_when_found_arg_seen) {
      +		write_file(git_path_bisect_reset_when_found(), "%s\n",
      +			   reset_when_found_mode_name(reset_when_found));
      +		argc--;
     @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, co
       	if (!argc) {
       		error(_("bisect run failed: no command provided."));
       		return BISECT_FAILED;
     -@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     - 		saved_stdout = dup(1);
     - 		dup2(temporary_stdout_fd, 1);
     - 
     --		res = bisect_state(terms, 1, &new_state);
     -+		res = bisect_state(terms, 1, &new_state, true);
     - 
     - 		fflush(stdout);
     - 		dup2(saved_stdout, 1);
      @@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
       			res = BISECT_OK;
       		} else if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
       			printf(_("bisect found first '%s' commit\n"), terms->term_bad);
      -			res = BISECT_OK;
     -+			if (!is_empty_or_missing_file(git_path_bisect_reset_when_found()) &&
     -+			    bisect_reset_when_found(terms))
     -+				res = BISECT_FAILED;
     -+			else
     -+				res = BISECT_OK;
       		} else if (res) {
       			error(_("bisect run failed: 'git bisect %s'"
       				" exited with error code %d"), new_state, res);
     -@@ builtin/bisect.c: static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *pref
     - 		return error(_("'%s' requires 0 arguments"),
     - 			     "git bisect next");
     - 	get_terms(&terms);
     --	res = bisect_next(&terms, prefix);
     -+	res = bisect_next(&terms, prefix, false);
     - 	free_terms(&terms);
     - 	return res;
     +@@ builtin/bisect.c: static int bisect_run(struct bisect_terms *terms, int argc, const char **argv)
     + static int cmd_bisect__reset(int argc, const char **argv, const char *prefix UNUSED,
     + 			     struct repository *repo UNUSED)
     + {
     ++	int res;
     ++
     + 	if (argc > 1)
     + 		return error(_("'%s' requires either no argument or a commit"),
     + 			     "git bisect reset");
     +-	return bisect_reset(argc ? argv[0] : NULL, false);
     ++	res = bisect_reset(argc ? argv[0] : NULL, false);
     ++	if (res)
     ++		return res;
     ++	return bisect_clean_state();
       }
     + 
     + static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED,
      @@ builtin/bisect.c: int cmd_bisect(int argc,
       		    !one_of(argv[0], terms.term_good, terms.term_bad, NULL))
       			usage_msg_optf(_("unknown command: '%s'"), git_bisect_usage,
       				       options, argv[0]);
      -		res = bisect_state(&terms, argc, argv);
     -+		res = bisect_state(&terms, argc, argv, false);
     ++		else
     ++			res = bisect_state(&terms, argc, argv);
       		free_terms(&terms);
       	} else {
       		argc--;
     +@@ builtin/bisect.c: int cmd_bisect(int argc,
     + 		res = fn(argc, argv, prefix, repo);
     + 	}
     + 
     ++	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
     ++		enum reset_when_found_mode mode;
     ++
     ++		if (read_reset_when_found(&mode))
     ++			res = BISECT_FAILED;
     ++		else if (mode != RESET_WHEN_FOUND_NONE &&
     ++			 bisect_reset_when_found(mode))
     ++			res = BISECT_FAILED;
     ++	}
     ++
     + 	return is_bisect_success(res) ? 0 : -res;
     + }
      
       ## t/t6030-bisect-porcelain.sh ##
      @@ t/t6030-bisect-porcelain.sh: test_bisect_usage () {

-- 
gitgitgadget
