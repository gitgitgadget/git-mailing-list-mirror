Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SBL_CSS,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D9B3020179
	for <e@80x24.org>; Sun, 26 Jun 2016 12:25:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752167AbcFZMZF (ORCPT <rfc822;e@80x24.org>);
	Sun, 26 Jun 2016 08:25:05 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:33409 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752069AbcFZMZE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jun 2016 08:25:04 -0400
Received: by mail-pf0-f195.google.com with SMTP id c74so13431596pfb.0
        for <git@vger.kernel.org>; Sun, 26 Jun 2016 05:25:03 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eOXHuqbMoWpBXamnMjhlSV9m1ywrFSTz6CIkySFtGgo=;
        b=nZDbNxgtdv3ULzcFiQYY6Z7JkUXKuer9jegnpCCQGmrmZyCp/GRCIBOmJWJI1OFao5
         KFoTtTGKcgsfp0c9rVFoFc2YpUW/uPUHgHEHFPURTSMqRukCw4mot/yNHw7wHYdZDU15
         ON+ksbyPhSM35MzpQJ61sQ5Uy/SY5KY5Vg2NOYIdjNe068wvSv9vT+tpQEpCvngLoLHk
         cFdGzZmR/yJx3XmLUGBjyzEKL/EWRa/ngxf+IVg7xcj196EmJrii+wYZSN6BJw2mOuRV
         8Lmy7I4Lom7cZgdWpcNCieMLRpNM7XBb4pN5IKyOQ9/qwqvv+N5+e7cJMRmxBbJ1DXQq
         kk5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eOXHuqbMoWpBXamnMjhlSV9m1ywrFSTz6CIkySFtGgo=;
        b=WuCM95/izJ+pw2u5YNfRu8peHxRFC17zQ5A/NWJ2YZ19kivzKDyD6EH81N9LCCnbux
         vs2F71p/l8pD09jd9uGsfooJVrcDsvxa9DAgwOVak/zNm7gIJjIOpqmWSqRlCsIss4ln
         3ClPLKI0AhpVg0BGtb0GbNNhEHFjE8cF/Uzcb1o9pQ8NOzRLKXo8B7fle08tI32491mF
         uaKODU3azcWYKUHTWnU5HY/yDf0UZlaGpPqL2jJwhOLclmTAVfc1nVKpxeX8BjDQoj7o
         9vXrTMzqsdFvUwZtb3oMvEgK3FXq08MhEDI7YHS6knKTiTGsajOVFPYwliY8pX7dPUp4
         6//g==
X-Gm-Message-State: ALyK8tIVxVvyk/dwKEHLz3JvfK3/cwEwGgLwzxs1XSz5ovEOyWxatZRp5KvP+fXAOsal5w==
X-Received: by 10.98.89.85 with SMTP id n82mr24044301pfb.23.1466943902203;
        Sun, 26 Jun 2016 05:25:02 -0700 (PDT)
Received: from localhost.localdomain ([111.119.199.22])
        by smtp.gmail.com with ESMTPSA id e9sm4633670pfg.2.2016.06.26.05.24.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 26 Jun 2016 05:25:01 -0700 (PDT)
From:	Pranit Bauva <pranit.bauva@gmail.com>
To:	git@vger.kernel.org
Cc:	Pranit Bauva <pranit.bauva@gmail.com>, christian.couder@gmail.com,
	chriscool@tuxfamily.org, larsxschneider@gmail.com,
	sunshine@sunshineco.com
Subject: [PATCH v3 0/6] convert various shell functions in git-bisect to C
Date:	Sun, 26 Jun 2016 17:53:50 +0530
Message-Id: <20160626122356.28999-1-pranit.bauva@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160607205454.22576-1-pranit.bauva@gmail.com>
References: <20160607205454.22576-1-pranit.bauva@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

The major change introduced in this version is that I have used `struct
bisect_terms` to store term_good and term_bad and then I am passing around
the memory address of it to functions. Also I have made various changes
in accordance with the previous review.

Here is the link for v2.
http://thread.gmane.org/gmane.comp.version-control.git/297372

Thanks for suggestions Eric Sunshine, Christian Couder and Junio C Hammano.

Here's the interdiff:
diff --git a/builtin/am.c b/builtin/am.c
index 84f21d0..6ee158f 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -1307,7 +1307,7 @@ static int parse_mail(struct am_state *state, const char *mail)
 		goto finish;
 	}
 
-	if (is_empty_file(am_path(state, "patch"))) {
+	if (is_empty_or_missing_file(am_path(state, "patch"))) {
 		printf_ln(_("Patch is empty. Was it split wrong?"));
 		die_user_resolve(state);
 	}
@@ -1895,7 +1895,7 @@ next:
 		resume = 0;
 	}
 
-	if (!is_empty_file(am_path(state, "rewritten"))) {
+	if (!is_empty_or_missing_file(am_path(state, "rewritten"))) {
 		assert(state->rebasing);
 		copy_notes_for_rebase(state);
 		run_post_rewrite_hook(state);
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index eebfcf0..e946ba9 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -26,6 +26,25 @@ static const char * const git_bisect_helper_usage[] = {
 	NULL
 };
 
+struct bisect_terms {
+	struct strbuf term_good;
+	struct strbuf term_bad;
+};
+
+static int bisect_terms_init(struct bisect_terms *term)
+{
+	strbuf_init(&term->term_good, 0);
+	strbuf_init(&term->term_bad, 0);
+	return 0;
+}
+
+static int bisect_terms_release(struct bisect_terms *term)
+{
+	strbuf_release(&term->term_good);
+	strbuf_release(&term->term_good);
+	return 0;
+}
+
 /*
  * Check whether the string `term` belongs to the set of strings
  * included in the variable arguments.
@@ -110,6 +129,7 @@ static int bisect_clean_state(void)
 	for_each_ref_in("refs/bisect/", mark_for_removal, (void *) &refs_for_removal);
 	string_list_append(&refs_for_removal, xstrdup("BISECT_HEAD"));
 	result = delete_refs(&refs_for_removal);
+	refs_for_removal.strdup_strings = 1;
 	string_list_clear(&refs_for_removal, 0);
 	remove_path(git_path_bisect_expected_rev());
 	remove_path(git_path_bisect_ancestors_ok());
@@ -138,12 +158,11 @@ static int bisect_reset(const char *commit)
 			return 0;
 		}
 		strbuf_rtrim(&branch);
-
 	} else {
 		struct object_id oid;
 		if (get_oid(commit, &oid))
 			return error(_("'%s' is not a valid commit"), commit);
-		strbuf_addf(&branch, "%s", commit);
+		strbuf_addstr(&branch, commit);
 	}
 
 	if (!file_exists(git_path_bisect_head())) {
@@ -151,7 +170,7 @@ static int bisect_reset(const char *commit)
 		argv_array_pushl(&argv, "checkout", branch.buf, "--", NULL);
 		if (run_command_v_opt(argv.argv, RUN_GIT_CMD)) {
 			error(_("Could not check out original HEAD '%s'. Try"
-					"'git bisect reset <commit>'."), branch.buf);
+				"'git bisect reset <commit>'."), branch.buf);
 			strbuf_release(&branch);
 			argv_array_clear(&argv);
 			return -1;
@@ -166,15 +185,11 @@ static int bisect_reset(const char *commit)
 static int is_expected_rev(const char *expected_hex)
 {
 	struct strbuf actual_hex = STRBUF_INIT;
-	int res;
-
-	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) < 0) {
-		strbuf_release(&actual_hex);
-		return 0;
+	int res = 0;
+	if (strbuf_read_file(&actual_hex, git_path_bisect_expected_rev(), 0) >= 0) {
+		strbuf_trim(&actual_hex);
+		res = !strcmp(actual_hex.buf, expected_hex);
 	}
-
-	strbuf_trim(&actual_hex);
-	res = !strcmp(actual_hex.buf, expected_hex);
 	strbuf_release(&actual_hex);
 	return res;
 }
@@ -194,8 +209,7 @@ static int check_expected_revs(const char **revs, int rev_nr)
 }
 
 static int bisect_write(const char *state, const char *rev,
-			const char *term_good, const char *term_bad,
-			int nolog)
+			const struct bisect_terms *term, int nolog)
 {
 	struct strbuf tag = STRBUF_INIT;
 	struct strbuf commit_name = STRBUF_INIT;
@@ -204,9 +218,9 @@ static int bisect_write(const char *state, const char *rev,
 	struct pretty_print_context pp = {0};
 	FILE *fp;
 
-	if (!strcmp(state, term_bad))
+	if (!strcmp(state, term->term_bad.buf))
 		strbuf_addf(&tag, "refs/bisect/%s", state);
-	else if(one_of(state, term_good, "skip", NULL))
+	else if(one_of(state, term->term_good.buf, "skip", NULL))
 		strbuf_addf(&tag, "refs/bisect/%s-%s", state, rev);
 	else
 		return error(_("Bad bisect_write argument: %s"), state);
@@ -221,23 +235,21 @@ static int bisect_write(const char *state, const char *rev,
 		strbuf_release(&tag);
 		return -1;
 	}
+	strbuf_release(&tag);
 
 	fp = fopen(git_path_bisect_log(), "a");
-	if (!fp) {
-		strbuf_release(&tag);
+	if (!fp)
 		return error_errno(_("couldn't open the file '%s'"), git_path_bisect_log());
-	}
 
 	commit = lookup_commit_reference(oid.hash);
 	format_commit_message(commit, "%s", &commit_name, &pp);
 	fprintf(fp, "# %s: [%s] %s\n", state, sha1_to_hex(oid.hash),
 		commit_name.buf);
+	strbuf_release(&commit_name);
 
 	if (!nolog)
 		fprintf(fp, "git bisect %s %s\n", state, rev);
 
-	strbuf_release(&commit_name);
-	strbuf_release(&tag);
 	fclose(fp);
 	return 0;
 }
@@ -252,7 +264,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		CHECK_EXPECTED_REVS,
 		BISECT_WRITE
 	} cmdmode = 0;
-	int no_checkout = 0;
+	int no_checkout = 0, res = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -270,6 +282,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
 		OPT_END()
 	};
+	struct bisect_terms state;
+	bisect_terms_init(&state);
 
 	argc = parse_options(argc, argv, prefix, options,
 			     git_bisect_helper_usage, 0);
@@ -284,24 +298,32 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 	case WRITE_TERMS:
 		if (argc != 2)
 			die(_("--write-terms requires two arguments"));
-		return write_terms(argv[0], argv[1]);
+		res = write_terms(argv[0], argv[1]);
+		break;
 	case BISECT_CLEAN_STATE:
 		if (argc != 0)
 			die(_("--bisect-clean-state requires no arguments"));
-		return bisect_clean_state();
+		res = bisect_clean_state();
+		break;
 	case BISECT_RESET:
 		if (argc > 1)
 			die(_("--bisect-reset requires either zero or one arguments"));
-		return bisect_reset(argc ? argv[0] : NULL);
+		res = bisect_reset(argc ? argv[0] : NULL);
+		break;
 	case CHECK_EXPECTED_REVS:
-		return check_expected_revs(argv, argc);
+		res = check_expected_revs(argv, argc);
+		break;
 	case BISECT_WRITE:
 		if (argc != 4 && argc != 5)
 			die(_("--bisect-write requires either 4 or 5 arguments"));
 		nolog = (argc == 5) && !strcmp(argv[4], "nolog");
-		return bisect_write(argv[0], argv[1], argv[2], argv[3], nolog);
+		strbuf_addstr(&state.term_good, argv[2]);
+		strbuf_addstr(&state.term_bad, argv[3]);
+		res = bisect_write(argv[0], argv[1], &state, nolog);
+		break;
 	default:
 		die("BUG: unknown subcommand '%d'", cmdmode);
 	}
-	return 0;
+	bisect_terms_release(&state);
+	return res;
 }
diff --git a/cache.h b/cache.h
index 8eaad70..91e2f81 100644
--- a/cache.h
+++ b/cache.h
@@ -1871,6 +1871,6 @@ void sleep_millisec(int millisec);
 void safe_create_dir(const char *dir, int share);
 
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
-extern int is_empty_file(const char *filename);
+extern int is_empty_or_missing_file(const char *filename);
 
 #endif /* CACHE_H */
diff --git a/wrapper.c b/wrapper.c
index 36a3eeb..e70e4d1 100644
--- a/wrapper.c
+++ b/wrapper.c
@@ -697,14 +697,14 @@ void sleep_millisec(int millisec)
 	poll(NULL, 0, millisec);
 }
 
-int is_empty_file(const char *filename)
+int is_empty_or_missing_file(const char *filename)
 {
 	struct stat st;
 
 	if (stat(filename, &st) < 0) {
 		if (errno == ENOENT)
 			return 1;
-		error_errno(_("could not stat %s"), filename);
+		die_errno(_("could not stat %s"), filename);
 	}
 
 	return !st.st_size;



Pranit Bauva (6):
  bisect--helper: `bisect_clean_state` shell function in C
  t6030: explicitly test for bisection cleanup
  wrapper: move is_empty_file() and rename it as
    is_empty_or_missing_file()
  bisect--helper: `bisect_reset` shell function in C
  bisect--helper: `is_expected_rev` & `check_expected_revs` shell
    function in C
  bisect--helper: `bisect_write` shell function in C

 builtin/am.c                |  20 +---
 builtin/bisect--helper.c    | 222 +++++++++++++++++++++++++++++++++++++++++++-
 cache.h                     |   3 +
 git-bisect.sh               |  97 ++-----------------
 t/t6030-bisect-porcelain.sh |  17 ++++
 wrapper.c                   |  13 +++
 6 files changed, 263 insertions(+), 109 deletions(-)

-- 
2.9.0

