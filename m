Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD44C0502A
	for <git@archiver.kernel.org>; Sat, 27 Aug 2022 12:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiH0Mos (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Aug 2022 08:44:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232806AbiH0Moi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Aug 2022 08:44:38 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 867BA31DCB
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:35 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id h5so4752142wru.7
        for <git@vger.kernel.org>; Sat, 27 Aug 2022 05:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=NGbWsZD/xP+Yj0+/RaEfg4uoVSXgFgsqty6tXzT97io=;
        b=kgflxm/REUuSY5nNxK+yh5LYxoU43PFkiQO/w2AtuGq+blpVLaE0QE5H8Zkkq6jWlS
         9MppTHok7EI5mIEz1bwO5uKUkr36JrZ2dxprjbhpL6Uax1WdM/4BWSwVf2CaTqBrvanp
         XTMhdXNpDosHOT7KWXnXHsnasnKhO1i5jy7pj/9YaPnaJfdlyzNDT720s7wHVqf+I7tp
         drbxmylqPSjZkjje+yHXIxrp/3zpwQ5Yp8c2LiIPxUvwqaxAIzFM+xP7Wp0nh1KDBjOp
         tLunAa11bfsPCKRM/y4aaiVf+i3SCo8Gd7fIaUlmA9WlE7YLdzE/Xi+vtBp+sY2Zt2jM
         nslg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=NGbWsZD/xP+Yj0+/RaEfg4uoVSXgFgsqty6tXzT97io=;
        b=gVoyd4ziJIRAHrmkbcpbKVAkiqf1/hCUGGtb4uEZS7ul4AKeEL78X8q41RtB0GH+us
         0FXVMs8zjKNY7R0pfTtDJseFr/VcjwIes+wXz0i5E5Tv71fZnVtDsJmaA0pKua8K8aJ5
         TJfbDdPcg+BvkWUNuJLFBoAiv55LwcO+2JxNEBb+yIWCwENZP33/QFM39KSKN9yaagzg
         iWJc2CVMkv46jE3TIvpedxBRGMcI6Z+UnOlzBJt/Jp3/v/m6CqaMIjUJHNJLoASvWz/c
         ntOARAEXmfyJTy49ZRfDLHgyHic2VGQ5nIze3oiogAiLDXhgbuBWMpIKe7yg8yR5jB4S
         C4cA==
X-Gm-Message-State: ACgBeo2cZNzPTOZrtw8bJwhox4fw+a4JoQrhB1stmvQlWyCzK20Q0/gA
        21fW0p8QXUryDCBkftzJIfUBosGk9Ag=
X-Google-Smtp-Source: AA6agR7mKovZmxhDujKlf6M5dKicWVkHesyHFZDfaFqcpbAgv1/98zMeq80TEOVJ0D+P4tE3i2m/LQ==
X-Received: by 2002:a05:6000:887:b0:21e:24a0:f302 with SMTP id ca7-20020a056000088700b0021e24a0f302mr2029221wrb.466.1661604273671;
        Sat, 27 Aug 2022 05:44:33 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c1c0500b003a2f6367049sm2734801wms.48.2022.08.27.05.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Aug 2022 05:44:33 -0700 (PDT)
Message-Id: <92b3b116ef8f879192d9deb94d68b73e29d5dcd6.1661604264.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
References: <pull.1132.v4.git.1656354677.gitgitgadget@gmail.com>
        <pull.1132.v5.git.1661604264.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 27 Aug 2022 12:44:13 +0000
Subject: [PATCH v5 05/16] bisect--helper: make `terms` an explicit singleton
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Pranit Bauva <pranit.bauva@gmail.com>,
        Tanushree Tumane <tanushreetumane@gmail.com>,
        Miriam Rubio <mirucam@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We tried very hard to keep code in `builtin/bisect--helper.c` in as
libifyable a state as possible.

However, we are about to migrate this built-in to the `OPT_SUBCOMMAND()`
API, which does not allow for passing any context (e.g. via a `void
*data` parameters as they are used in the config API).

Therefore, we _have_ to move the `terms` variable outside of
`cmd_bisect__helper()` and explicitly make it a singleton (as it
currently is, anyway).

Let's just make things consistent and stop passing around pointers to
that singleton; Use it directly instead.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/bisect--helper.c | 262 +++++++++++++++++++--------------------
 1 file changed, 128 insertions(+), 134 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 2f9c7f54f3f..7f4e8e707c1 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -40,30 +40,30 @@ struct add_bisect_ref_data {
 	unsigned int object_flags;
 };
 
-struct bisect_terms {
+static struct bisect_terms {
 	char *term_good;
 	char *term_bad;
-};
+} terms;
 
-static void free_terms(struct bisect_terms *terms)
+static void free_terms(void)
 {
-	FREE_AND_NULL(terms->term_good);
-	FREE_AND_NULL(terms->term_bad);
+	FREE_AND_NULL(terms.term_good);
+	FREE_AND_NULL(terms.term_bad);
 }
 
-static void set_terms(struct bisect_terms *terms, const char *bad,
+static void set_terms(const char *bad,
 		      const char *good)
 {
-	free((void *)terms->term_good);
-	terms->term_good = xstrdup(good);
-	free((void *)terms->term_bad);
-	terms->term_bad = xstrdup(bad);
+	free((void *)terms.term_good);
+	terms.term_good = xstrdup(good);
+	free((void *)terms.term_bad);
+	terms.term_bad = xstrdup(bad);
 }
 
 static const char vocab_bad[] = "bad|new";
 static const char vocab_good[] = "good|old";
 
-static int bisect_autostart(struct bisect_terms *terms);
+static int bisect_autostart(void);
 
 /*
  * Check whether the string `term` belongs to the set of strings
@@ -254,8 +254,7 @@ static void log_commit(FILE *fp, char *fmt, const char *state,
 	free(label);
 }
 
-static int bisect_write(const char *state, const char *rev,
-			const struct bisect_terms *terms, int nolog)
+static int bisect_write(const char *state, const char *rev, int nolog)
 {
 	struct strbuf tag = STRBUF_INIT;
 	struct object_id oid;
@@ -263,9 +262,9 @@ static int bisect_write(const char *state, const char *rev,
 	FILE *fp = NULL;
 	int res = 0;
 
-	if (!strcmp(state, terms->term_bad)) {
+	if (!strcmp(state, terms.term_bad)) {
 		strbuf_addf(&tag, "refs/bisect/%s", state);
-	} else if (one_of(state, terms->term_good, "skip", NULL)) {
+	} else if (one_of(state, terms.term_good, "skip", NULL)) {
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	} else {
 		res = error(_("Bad bisect_write argument: %s"), state);
@@ -302,27 +301,27 @@ finish:
 	return res;
 }
 
-static int check_and_set_terms(struct bisect_terms *terms, const char *cmd)
+static int check_and_set_terms(const char *cmd)
 {
 	int has_term_file = !is_empty_or_missing_file(git_path_bisect_terms());
 
 	if (one_of(cmd, "skip", "start", "terms", NULL))
 		return 0;
 
-	if (has_term_file && strcmp(cmd, terms->term_bad) &&
-	    strcmp(cmd, terms->term_good))
+	if (has_term_file && strcmp(cmd, terms.term_bad) &&
+	    strcmp(cmd, terms.term_good))
 		return error(_("Invalid command: you're currently in a "
-				"%s/%s bisect"), terms->term_bad,
-				terms->term_good);
+				"%s/%s bisect"), terms.term_bad,
+				terms.term_good);
 
 	if (!has_term_file) {
 		if (one_of(cmd, "bad", "good", NULL)) {
-			set_terms(terms, "bad", "good");
-			return write_terms(terms->term_bad, terms->term_good);
+			set_terms("bad", "good");
+			return write_terms(terms.term_bad, terms.term_good);
 		}
 		if (one_of(cmd, "new", "old", NULL)) {
-			set_terms(terms, "new", "old");
-			return write_terms(terms->term_bad, terms->term_good);
+			set_terms("new", "old");
+			return write_terms(terms.term_bad, terms.term_good);
 		}
 	}
 
@@ -346,8 +345,7 @@ static const char need_bisect_start_warning[] =
 	   "You then need to give me at least one %s and %s revision.\n"
 	   "You can use \"git bisect %s\" and \"git bisect %s\" for that.");
 
-static int decide_next(const struct bisect_terms *terms,
-		       const char *current_term, int missing_good,
+static int decide_next(const char *current_term, int missing_good,
 		       int missing_bad)
 {
 	if (!missing_good && !missing_bad)
@@ -356,13 +354,13 @@ static int decide_next(const struct bisect_terms *terms,
 		return -1;
 
 	if (missing_good && !missing_bad &&
-	    !strcmp(current_term, terms->term_good)) {
+	    !strcmp(current_term, terms.term_good)) {
 		char *yesno;
 		/*
 		 * have bad (or new) but not good (or old). We could bisect
 		 * although this is less optimum.
 		 */
-		warning(_("bisecting only with a %s commit"), terms->term_bad);
+		warning(_("bisecting only with a %s commit"), terms.term_bad);
 		if (!isatty(0))
 			return 0;
 		/*
@@ -384,11 +382,10 @@ static int decide_next(const struct bisect_terms *terms,
 			     vocab_good, vocab_bad, vocab_good, vocab_bad);
 }
 
-static void bisect_status(struct bisect_state *state,
-			  const struct bisect_terms *terms)
+static void bisect_status(struct bisect_state *state)
 {
-	char *bad_ref = xstrfmt("refs/bisect/%s", terms->term_bad);
-	char *good_glob = xstrfmt("%s-*", terms->term_good);
+	char *bad_ref = xstrfmt("refs/bisect/%s", terms.term_bad);
+	char *good_glob = xstrfmt("%s-*", terms.term_good);
 
 	if (ref_exists(bad_ref))
 		state->nr_bad = 1;
@@ -416,11 +413,11 @@ static void bisect_log_printf(const char *fmt, ...)
 	strbuf_release(&buf);
 }
 
-static void bisect_print_status(const struct bisect_terms *terms)
+static void bisect_print_status(void)
 {
 	struct bisect_state state = { 0 };
 
-	bisect_status(&state, terms);
+	bisect_status(&state);
 
 	/* If we had both, we'd already be started, and shouldn't get here. */
 	if (state.nr_good && state.nr_bad)
@@ -436,15 +433,14 @@ static void bisect_print_status(const struct bisect_terms *terms)
 		bisect_log_printf(_("status: waiting for good commit(s), bad commit known\n"));
 }
 
-static int bisect_next_check(const struct bisect_terms *terms,
-			     const char *current_term)
+static int bisect_next_check(const char *current_term)
 {
 	struct bisect_state state = { 0 };
-	bisect_status(&state, terms);
-	return decide_next(terms, current_term, !state.nr_good, !state.nr_bad);
+	bisect_status(&state);
+	return decide_next(current_term, !state.nr_good, !state.nr_bad);
 }
 
-static int get_terms(struct bisect_terms *terms)
+static int get_terms(void)
 {
 	struct strbuf str = STRBUF_INIT;
 	FILE *fp = NULL;
@@ -456,11 +452,11 @@ static int get_terms(struct bisect_terms *terms)
 		goto finish;
 	}
 
-	free_terms(terms);
+	free_terms();
 	strbuf_getline_lf(&str, fp);
-	terms->term_bad = strbuf_detach(&str, NULL);
+	terms.term_bad = strbuf_detach(&str, NULL);
 	strbuf_getline_lf(&str, fp);
-	terms->term_good = strbuf_detach(&str, NULL);
+	terms.term_good = strbuf_detach(&str, NULL);
 
 finish:
 	if (fp)
@@ -469,21 +465,21 @@ finish:
 	return res;
 }
 
-static int bisect_terms(struct bisect_terms *terms, const char *option)
+static int bisect_terms(const char *option)
 {
-	if (get_terms(terms))
+	if (get_terms())
 		return error(_("no terms defined"));
 
 	if (!option) {
 		printf(_("Your current terms are %s for the old state\n"
 			 "and %s for the new state.\n"),
-		       terms->term_good, terms->term_bad);
+		       terms.term_good, terms.term_bad);
 		return 0;
 	}
 	if (one_of(option, "--term-good", "--term-old", NULL))
-		printf("%s\n", terms->term_good);
+		printf("%s\n", terms.term_good);
 	else if (one_of(option, "--term-bad", "--term-new", NULL))
-		printf("%s\n", terms->term_bad);
+		printf("%s\n", terms.term_bad);
 	else
 		return error(_("invalid argument %s for 'git bisect terms'.\n"
 			       "Supported options are: "
@@ -527,18 +523,18 @@ static int add_bisect_ref(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
-static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
+static int prepare_revs(struct rev_info *revs)
 {
 	int res = 0;
 	struct add_bisect_ref_data cb = { revs };
-	char *good = xstrfmt("%s-*", terms->term_good);
+	char *good = xstrfmt("%s-*", terms.term_good);
 
 	/*
-	 * We cannot use terms->term_bad directly in
+	 * We cannot use terms.term_bad directly in
 	 * for_each_glob_ref_in() and we have to append a '*' to it,
 	 * otherwise for_each_glob_ref_in() will append '/' and '*'.
 	 */
-	char *bad = xstrfmt("%s*", terms->term_bad);
+	char *bad = xstrfmt("%s*", terms.term_bad);
 
 	/*
 	 * It is important to reset the flags used by revision walks
@@ -559,7 +555,7 @@ static int prepare_revs(struct bisect_terms *terms, struct rev_info *revs)
 	return res;
 }
 
-static int bisect_skipped_commits(struct bisect_terms *terms)
+static int bisect_skipped_commits(void)
 {
 	int res;
 	FILE *fp = NULL;
@@ -568,7 +564,7 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 	struct pretty_print_context pp = {0};
 	struct strbuf commit_name = STRBUF_INIT;
 
-	res = prepare_revs(terms, &revs);
+	res = prepare_revs(&revs);
 	if (res)
 		return res;
 
@@ -585,7 +581,7 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 		format_commit_message(commit, "%s",
 				      &commit_name, &pp);
 		fprintf(fp, "# possible first %s commit: [%s] %s\n",
-			terms->term_bad, oid_to_hex(&commit->object.oid),
+			terms.term_bad, oid_to_hex(&commit->object.oid),
 			commit_name.buf);
 	}
 
@@ -601,13 +597,13 @@ static int bisect_skipped_commits(struct bisect_terms *terms)
 	return 0;
 }
 
-static int bisect_successful(struct bisect_terms *terms)
+static int bisect_successful(void)
 {
 	struct object_id oid;
 	struct commit *commit;
 	struct pretty_print_context pp = {0};
 	struct strbuf commit_name = STRBUF_INIT;
-	char *bad_ref = xstrfmt("refs/bisect/%s",terms->term_bad);
+	char *bad_ref = xstrfmt("refs/bisect/%s",terms.term_bad);
 	int res;
 
 	read_ref(bad_ref, &oid);
@@ -615,7 +611,7 @@ static int bisect_successful(struct bisect_terms *terms)
 	format_commit_message(commit, "%s", &commit_name, &pp);
 
 	res = append_to_file(git_path_bisect_log(), "# first %s commit: [%s] %s\n",
-			    terms->term_bad, oid_to_hex(&commit->object.oid),
+			    terms.term_bad, oid_to_hex(&commit->object.oid),
 			    commit_name.buf);
 
 	strbuf_release(&commit_name);
@@ -623,40 +619,40 @@ static int bisect_successful(struct bisect_terms *terms)
 	return res;
 }
 
-static enum bisect_error bisect_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_next(const char *prefix)
 {
 	enum bisect_error res;
 
-	if (bisect_autostart(terms))
+	if (bisect_autostart())
 		return BISECT_FAILED;
 
-	if (bisect_next_check(terms, terms->term_good))
+	if (bisect_next_check(terms.term_good))
 		return BISECT_FAILED;
 
 	/* Perform all bisection computation */
 	res = bisect_next_all(the_repository, prefix);
 
 	if (res == BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND) {
-		res = bisect_successful(terms);
+		res = bisect_successful();
 		return res ? res : BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND;
 	} else if (res == BISECT_ONLY_SKIPPED_LEFT) {
-		res = bisect_skipped_commits(terms);
+		res = bisect_skipped_commits();
 		return res ? res : BISECT_ONLY_SKIPPED_LEFT;
 	}
 	return res;
 }
 
-static enum bisect_error bisect_auto_next(struct bisect_terms *terms, const char *prefix)
+static enum bisect_error bisect_auto_next(const char *prefix)
 {
-	if (bisect_next_check(terms, NULL)) {
-		bisect_print_status(terms);
+	if (bisect_next_check(NULL)) {
+		bisect_print_status();
 		return BISECT_OK;
 	}
 
-	return bisect_next(terms, prefix);
+	return bisect_next(prefix);
 }
 
-static enum bisect_error bisect_start(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_start(const char **argv, int argc)
 {
 	int no_checkout = 0;
 	int first_parent_only = 0;
@@ -698,26 +694,26 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 			if (argc <= i)
 				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
-			free((void *) terms->term_good);
-			terms->term_good = xstrdup(argv[i]);
+			free((void *) terms.term_good);
+			terms.term_good = xstrdup(argv[i]);
 		} else if (skip_prefix(arg, "--term-good=", &arg) ||
 			   skip_prefix(arg, "--term-old=", &arg)) {
 			must_write_terms = 1;
-			free((void *) terms->term_good);
-			terms->term_good = xstrdup(arg);
+			free((void *) terms.term_good);
+			terms.term_good = xstrdup(arg);
 		} else if (!strcmp(arg, "--term-bad") ||
 			 !strcmp(arg, "--term-new")) {
 			i++;
 			if (argc <= i)
 				return error(_("'' is not a valid term"));
 			must_write_terms = 1;
-			free((void *) terms->term_bad);
-			terms->term_bad = xstrdup(argv[i]);
+			free((void *) terms.term_bad);
+			terms.term_bad = xstrdup(argv[i]);
 		} else if (skip_prefix(arg, "--term-bad=", &arg) ||
 			   skip_prefix(arg, "--term-new=", &arg)) {
 			must_write_terms = 1;
-			free((void *) terms->term_bad);
-			terms->term_bad = xstrdup(arg);
+			free((void *) terms.term_bad);
+			terms.term_bad = xstrdup(arg);
 		} else if (starts_with(arg, "--")) {
 			return error(_("unrecognized option: '%s'"), arg);
 		} else if (!get_oidf(&oid, "%s^{commit}", arg)) {
@@ -741,10 +737,10 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 		must_write_terms = 1;
 	for (i = 0; i < revs.nr; i++) {
 		if (bad_seen) {
-			string_list_append(&states, terms->term_good);
+			string_list_append(&states, terms.term_good);
 		} else {
 			bad_seen = 1;
-			string_list_append(&states, terms->term_bad);
+			string_list_append(&states, terms.term_bad);
 		}
 	}
 
@@ -829,13 +825,13 @@ static enum bisect_error bisect_start(struct bisect_terms *terms, const char **a
 
 	for (i = 0; i < states.nr; i++)
 		if (bisect_write(states.items[i].string,
-				 revs.items[i].string, terms, 1)) {
+				 revs.items[i].string, 1)) {
 			res = BISECT_FAILED;
 			goto finish;
 		}
 
-	if (must_write_terms && write_terms(terms->term_bad,
-					    terms->term_good)) {
+	if (must_write_terms && write_terms(terms.term_bad,
+					    terms.term_good)) {
 		res = BISECT_FAILED;
 		goto finish;
 	}
@@ -852,7 +848,7 @@ finish:
 	if (res)
 		return res;
 
-	res = bisect_auto_next(terms, NULL);
+	res = bisect_auto_next(NULL);
 	if (!is_bisect_success(res))
 		bisect_clean_state();
 	return res;
@@ -863,7 +859,7 @@ static inline int file_is_not_empty(const char *path)
 	return !is_empty_or_missing_file(path);
 }
 
-static int bisect_autostart(struct bisect_terms *terms)
+static int bisect_autostart(void)
 {
 	int res;
 	const char *yesno;
@@ -885,12 +881,12 @@ static int bisect_autostart(struct bisect_terms *terms)
 	yesno = git_prompt(_("Do you want me to do it for you "
 			     "[Y/n]? "), PROMPT_ECHO);
 	res = tolower(*yesno) == 'n' ?
-		-1 : bisect_start(terms, empty_strvec, 0);
+		-1 : bisect_start(empty_strvec, 0);
 
 	return res;
 }
 
-static enum bisect_error bisect_state(struct bisect_terms *terms, const char **argv,
+static enum bisect_error bisect_state(const char **argv,
 				      int argc)
 {
 	const char *state;
@@ -902,18 +898,18 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	if (!argc)
 		return error(_("Please call `--bisect-state` with at least one argument"));
 
-	if (bisect_autostart(terms))
+	if (bisect_autostart())
 		return BISECT_FAILED;
 
 	state = argv[0];
-	if (check_and_set_terms(terms, state) ||
-	    !one_of(state, terms->term_good, terms->term_bad, "skip", NULL))
+	if (check_and_set_terms(state) ||
+	    !one_of(state, terms.term_good, terms.term_bad, "skip", NULL))
 		return BISECT_FAILED;
 
 	argv++;
 	argc--;
-	if (argc > 1 && !strcmp(state, terms->term_bad))
-		return error(_("'git bisect %s' can take only one argument."), terms->term_bad);
+	if (argc > 1 && !strcmp(state, terms.term_bad))
+		return error(_("'git bisect %s' can take only one argument."), terms.term_bad);
 
 	if (argc == 0) {
 		const char *head = "BISECT_HEAD";
@@ -956,7 +952,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	strbuf_release(&buf);
 
 	for (i = 0; i < revs.nr; i++) {
-		if (bisect_write(state, oid_to_hex(&revs.oid[i]), terms, 0)) {
+		if (bisect_write(state, oid_to_hex(&revs.oid[i]), 0)) {
 			oid_array_clear(&revs);
 			return BISECT_FAILED;
 		}
@@ -968,7 +964,7 @@ static enum bisect_error bisect_state(struct bisect_terms *terms, const char **a
 	}
 
 	oid_array_clear(&revs);
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(NULL);
 }
 
 static enum bisect_error bisect_log(void)
@@ -988,7 +984,7 @@ static enum bisect_error bisect_log(void)
 	return status ? BISECT_FAILED : BISECT_OK;
 }
 
-static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
+static int process_replay_line(struct strbuf *line)
 {
 	const char *p = line->buf + strspn(line->buf, " \t");
 	char *word_end, *rev;
@@ -1002,28 +998,28 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	rev = word_end + strspn(word_end, " \t");
 	*word_end = '\0'; /* NUL-terminate the word */
 
-	get_terms(terms);
-	if (check_and_set_terms(terms, p))
+	get_terms();
+	if (check_and_set_terms(p))
 		return -1;
 
 	if (!strcmp(p, "start")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_start(terms, argv.v, argv.nr);
+		res = bisect_start(argv.v, argv.nr);
 		strvec_clear(&argv);
 		return res;
 	}
 
-	if (one_of(p, terms->term_good,
-	   terms->term_bad, "skip", NULL))
-		return bisect_write(p, rev, terms, 0);
+	if (one_of(p, terms.term_good,
+	   terms.term_bad, "skip", NULL))
+		return bisect_write(p, rev, 0);
 
 	if (!strcmp(p, "terms")) {
 		struct strvec argv = STRVEC_INIT;
 		int res;
 		sq_dequote_to_strvec(rev, &argv);
-		res = bisect_terms(terms, argv.nr == 1 ? argv.v[0] : NULL);
+		res = bisect_terms(argv.nr == 1 ? argv.v[0] : NULL);
 		strvec_clear(&argv);
 		return res;
 	}
@@ -1032,7 +1028,7 @@ static int process_replay_line(struct bisect_terms *terms, struct strbuf *line)
 	return -1;
 }
 
-static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *filename)
+static enum bisect_error bisect_replay(const char *filename)
 {
 	FILE *fp = NULL;
 	enum bisect_error res = BISECT_OK;
@@ -1049,7 +1045,7 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 		return BISECT_FAILED;
 
 	while ((strbuf_getline(&line, fp) != EOF) && !res)
-		res = process_replay_line(terms, &line);
+		res = process_replay_line(&line);
 
 	strbuf_release(&line);
 	fclose(fp);
@@ -1057,10 +1053,10 @@ static enum bisect_error bisect_replay(struct bisect_terms *terms, const char *f
 	if (res)
 		return BISECT_FAILED;
 
-	return bisect_auto_next(terms, NULL);
+	return bisect_auto_next(NULL);
 }
 
-static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **argv, int argc)
+static enum bisect_error bisect_skip(const char **argv, int argc)
 {
 	int i;
 	enum bisect_error res;
@@ -1090,19 +1086,19 @@ static enum bisect_error bisect_skip(struct bisect_terms *terms, const char **ar
 			strvec_push(&argv_state, argv[i]);
 		}
 	}
-	res = bisect_state(terms, argv_state.v, argv_state.nr);
+	res = bisect_state(argv_state.v, argv_state.nr);
 
 	strvec_clear(&argv_state);
 	return res;
 }
 
-static int bisect_visualize(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_visualize(const char **argv, int argc)
 {
 	struct strvec args = STRVEC_INIT;
 	int flags = RUN_COMMAND_NO_STDIN, res = 0;
 	struct strbuf sb = STRBUF_INIT;
 
-	if (bisect_next_check(terms, NULL) != 0)
+	if (bisect_next_check(NULL) != 0)
 		return BISECT_FAILED;
 
 	if (!argc) {
@@ -1141,14 +1137,13 @@ static int get_first_good(const char *refname, const struct object_id *oid,
 	return 1;
 }
 
-static int verify_good(const struct bisect_terms *terms,
-		       const char **quoted_argv)
+static int verify_good(const char **quoted_argv)
 {
 	int rc;
 	enum bisect_error res;
 	struct object_id good_rev;
 	struct object_id current_rev;
-	char *good_glob = xstrfmt("%s-*", terms->term_good);
+	char *good_glob = xstrfmt("%s-*", terms.term_good);
 	int no_checkout = ref_exists("BISECT_HEAD");
 
 	for_each_glob_ref_in(get_first_good, good_glob, "refs/bisect/",
@@ -1172,7 +1167,7 @@ static int verify_good(const struct bisect_terms *terms,
 	return rc;
 }
 
-static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
+static int bisect_run(const char **argv, int argc)
 {
 	int res = BISECT_OK;
 	struct strbuf command = STRBUF_INIT;
@@ -1181,7 +1176,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	int temporary_stdout_fd, saved_stdout;
 	int is_first_run = 1;
 
-	if (bisect_next_check(terms, NULL))
+	if (bisect_next_check(NULL))
 		return BISECT_FAILED;
 
 	if (argc)
@@ -1205,7 +1200,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		 * missing or non-executable script.
 		 */
 		if (is_first_run && (res == 126 || res == 127)) {
-			int rc = verify_good(terms, run_args.v);
+			int rc = verify_good(run_args.v);
 			is_first_run = 0;
 			if (rc < 0) {
 				error(_("unable to verify '%s' on good"
@@ -1230,9 +1225,9 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		if (res == 125)
 			new_state = "skip";
 		else if (!res)
-			new_state = terms->term_good;
+			new_state = terms.term_good;
 		else
-			new_state = terms->term_bad;
+			new_state = terms.term_bad;
 
 		temporary_stdout_fd = open(git_path_bisect_run(), O_CREAT | O_WRONLY | O_TRUNC, 0666);
 
@@ -1245,7 +1240,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		saved_stdout = dup(1);
 		dup2(temporary_stdout_fd, 1);
 
-		res = bisect_state(terms, &new_state, 1);
+		res = bisect_state(&new_state, 1);
 
 		fflush(stdout);
 		dup2(saved_stdout, 1);
@@ -1314,7 +1309,6 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("use <cmd>... to automatically bisect"), BISECT_RUN),
 		OPT_END()
 	};
-	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage,
@@ -1332,22 +1326,22 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_TERMS:
 		if (argc > 1)
 			return error(_("--bisect-terms requires 0 or 1 argument"));
-		res = bisect_terms(&terms, argc == 1 ? argv[0] : NULL);
+		res = bisect_terms(argc == 1 ? argv[0] : NULL);
 		break;
 	case BISECT_START:
-		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, argv, argc);
+		set_terms("bad", "good");
+		res = bisect_start(argv, argc);
 		break;
 	case BISECT_NEXT:
 		if (argc)
 			return error(_("--bisect-next requires 0 arguments"));
-		get_terms(&terms);
-		res = bisect_next(&terms, prefix);
+		get_terms();
+		res = bisect_next(prefix);
 		break;
 	case BISECT_STATE:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_state(&terms, argv, argc);
+		set_terms("bad", "good");
+		get_terms();
+		res = bisect_state(argv, argc);
 		break;
 	case BISECT_LOG:
 		if (argc)
@@ -1357,28 +1351,28 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case BISECT_REPLAY:
 		if (argc != 1)
 			return error(_("no logfile given"));
-		set_terms(&terms, "bad", "good");
-		res = bisect_replay(&terms, argv[0]);
+		set_terms("bad", "good");
+		res = bisect_replay(argv[0]);
 		break;
 	case BISECT_SKIP:
-		set_terms(&terms, "bad", "good");
-		get_terms(&terms);
-		res = bisect_skip(&terms, argv, argc);
+		set_terms("bad", "good");
+		get_terms();
+		res = bisect_skip(argv, argc);
 		break;
 	case BISECT_VISUALIZE:
-		get_terms(&terms);
-		res = bisect_visualize(&terms, argv, argc);
+		get_terms();
+		res = bisect_visualize(argv, argc);
 		break;
 	case BISECT_RUN:
 		if (!argc)
 			return error(_("bisect run failed: no command provided."));
-		get_terms(&terms);
-		res = bisect_run(&terms, argv, argc);
+		get_terms();
+		res = bisect_run(argv, argc);
 		break;
 	default:
 		BUG("unknown subcommand %d", cmdmode);
 	}
-	free_terms(&terms);
+	free_terms();
 
 	return is_bisect_success(res) ? 0 : -res;
 }
-- 
gitgitgadget

