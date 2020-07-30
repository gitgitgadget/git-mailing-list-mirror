Return-Path: <SRS0=t8Cj=BJ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF4F3C433E1
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8B7D2074B
	for <git@archiver.kernel.org>; Thu, 30 Jul 2020 00:27:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l5mQNUhl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgG3A1r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 29 Jul 2020 20:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726709AbgG3A1q (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 29 Jul 2020 20:27:46 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EAA4C061794
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:46 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id 11so24161489qkn.2
        for <git@vger.kernel.org>; Wed, 29 Jul 2020 17:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PvFn9+O7VxuDfR6mRRfOLyNyh1E9qbeJgzaJFLZgc/Q=;
        b=l5mQNUhlvwvQ5g9mbxL84besHE4yqWRTtY4sd9Hz7FtHx6n0xbcyHAmkd162dKHjOP
         6JpeKfykDgf6BR8aRv5v3HYsyK0j8rcGJjWSmZW03INDoi4iHruzm75V2Q35gIecl+qq
         9LgFskgZAMna/X+zpEQJBCddmXoJ/zdo2rVo/kW467WkMWk7huQ1Jz/pBkiZy9leqm7Z
         IVq5D9w5lSsy+7ronxqfyd/CadEySH2Xqpt9PdGQx1Tr6Y7EREIjdvmy/mVLgoc+ISU7
         HSE74Bdfx2UleQ6vAsRmDDa9UB4ynUwT7fiInAYtN1LqVpVL85FEHfsM/53aScm6pbbb
         libQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PvFn9+O7VxuDfR6mRRfOLyNyh1E9qbeJgzaJFLZgc/Q=;
        b=iTvUupUc6992YLVojxUpVkAFAHEZQ3WqIMX1oaSHcuZFyapN18NzXxDUXZ4MXuvtsH
         kBozAyy8GxjvoPrDl9CTyHR+oJGKmvZEitsTnsjT0wclDClOTvQUhajrtromDki6PyXs
         OY8z4tzCa9Rlj06wGcN6bQNvdnnDSYhTNM+6bf9/2MX4RzQJDysMM58T7zSDp4TwpXFu
         wDdVIfOndshEJZrBflGROdxfHqgJ1Srr3Y/F4u6g08ZBD0jynv2bYTg1L2pPFgtKQCVM
         RCTiPZ42dRk3FB81ZsJKQcsrSixA9Cdy6XLH4ACD7KJRjZ7MCUF9fAYlAYTlrTcuDjqk
         oD0A==
X-Gm-Message-State: AOAM5321rpqiWDGZbiYgFOhjaqee1zmWurkhkp/6aFwmTSKu2WfRwbdk
        p/Sj4lbarP6RZAJ90FtVImvdzCHi/Z0=
X-Google-Smtp-Source: ABdhPJyFPlKiSzaShj1nLt5yc2IgWwqGzBwzceGosfhfIo506zIcmHJPAULVcfHJfSn3XEjeszndiw==
X-Received: by 2002:a05:620a:68a:: with SMTP id f10mr29016065qkh.281.1596068865197;
        Wed, 29 Jul 2020 17:27:45 -0700 (PDT)
Received: from localhost.localdomain (c-98-229-3-81.hsd1.vt.comcast.net. [98.229.3.81])
        by smtp.gmail.com with ESMTPSA id m32sm3239391qtd.94.2020.07.29.17.27.44
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Jul 2020 17:27:44 -0700 (PDT)
From:   Aaron Lipman <alipman88@gmail.com>
To:     git@vger.kernel.org
Cc:     Aaron Lipman <alipman88@gmail.com>
Subject: [PATCH v2 2/3] bisect: introduce first-parent flag
Date:   Wed, 29 Jul 2020 20:27:34 -0400
Message-Id: <20200730002735.87655-3-alipman88@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20200730002735.87655-1-alipman88@gmail.com>
References: <pull.686.git.1595951056.gitgitgadget@gmail.com>
 <20200730002735.87655-1-alipman88@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Upon seeing a merge commit when bisecting, this option may be used to
follow only the first parent.

In detecting regressions introduced through the merging of a branch, the
merge commit will be identified as introduction of the bug and its
ancestors will be ignored.

This option is particularly useful in avoiding false positives when a
merged branch contained broken or non-buildable commits, but the merge
itself was OK.

Signed-off-by: Aaron Lipman <alipman88@gmail.com>
---
 Documentation/git-bisect.txt | 13 ++++++++++++-
 bisect.c                     | 10 +++++++++-
 bisect.h                     |  2 ++
 builtin/bisect--helper.c     | 16 ++++++++++++----
 t/t6030-bisect-porcelain.sh  | 17 +++++++++++++++++
 5 files changed, 52 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-bisect.txt b/Documentation/git-bisect.txt
index 7586c5a843..0e993e4587 100644
--- a/Documentation/git-bisect.txt
+++ b/Documentation/git-bisect.txt
@@ -17,7 +17,7 @@ The command takes various subcommands, and different options depending
 on the subcommand:
 
  git bisect start [--term-{old,good}=<term> --term-{new,bad}=<term>]
-		  [--no-checkout] [<bad> [<good>...]] [--] [<paths>...]
+		  [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]
  git bisect (bad|new|<term-new>) [<rev>]
  git bisect (good|old|<term-old>) [<rev>...]
  git bisect terms [--term-good | --term-bad]
@@ -365,6 +365,17 @@ does not require a checked out tree.
 +
 If the repository is bare, `--no-checkout` is assumed.
 
+--first-parent::
++
+Follow only the first parent commit upon seeing a merge commit.
++
+In detecting regressions introduced through the merging of a branch, the merge
+commit will be identified as introduction of the bug and its ancestors will be
+ignored.
++
+This option is particularly useful in avoiding false positives when a merged
+branch contained broken or non-buildable commits, but the merge itself was OK.
+
 EXAMPLES
 --------
 
diff --git a/bisect.c b/bisect.c
index a11fdb1473..b495a19192 100644
--- a/bisect.c
+++ b/bisect.c
@@ -460,6 +460,7 @@ static GIT_PATH_FUNC(git_path_bisect_run, "BISECT_RUN")
 static GIT_PATH_FUNC(git_path_bisect_start, "BISECT_START")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_bisect_terms, "BISECT_TERMS")
+static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 
 static void read_bisect_paths(struct argv_array *array)
@@ -981,6 +982,12 @@ void read_bisect_terms(const char **read_bad, const char **read_good)
 	fclose(fp);
 }
 
+int read_first_parent_option(void)
+{
+	const char *filename = git_path_bisect_first_parent();
+	return !access(filename, F_OK);
+}
+
 /*
  * We use the convention that return BISECT_INTERNAL_SUCCESS_1ST_BAD_FOUND (-10) means
  * the bisection process finished successfully.
@@ -997,7 +1004,7 @@ enum bisect_error bisect_next_all(struct repository *r, const char *prefix, int
 	enum bisect_error res = BISECT_OK;
 	struct object_id *bisect_rev;
 	char *steps_msg;
-	int first_parent_only = 0; /* TODO: pass --first-parent flag from git bisect start */
+	int first_parent_only = read_first_parent_option();
 
 	read_bisect_terms(&term_bad, &term_good);
 	if (read_bisect_refs())
@@ -1141,6 +1148,7 @@ int bisect_clean_state(void)
 	unlink_or_warn(git_path_bisect_names());
 	unlink_or_warn(git_path_bisect_run());
 	unlink_or_warn(git_path_bisect_terms());
+	unlink_or_warn(git_path_bisect_first_parent());
 	/* Cleanup head-name if it got left by an old version of git-bisect */
 	unlink_or_warn(git_path_head_name());
 	/*
diff --git a/bisect.h b/bisect.h
index a63af0505f..8ee80f5b48 100644
--- a/bisect.h
+++ b/bisect.h
@@ -66,6 +66,8 @@ int estimate_bisect_steps(int all);
 
 void read_bisect_terms(const char **bad, const char **good);
 
+int read_first_parent_option(void);
+
 int bisect_clean_state(void);
 
 #endif
diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index ec4996282e..1236f5df1d 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -17,6 +17,7 @@ static GIT_PATH_FUNC(git_path_bisect_head, "BISECT_HEAD")
 static GIT_PATH_FUNC(git_path_bisect_log, "BISECT_LOG")
 static GIT_PATH_FUNC(git_path_head_name, "head-name")
 static GIT_PATH_FUNC(git_path_bisect_names, "BISECT_NAMES")
+static GIT_PATH_FUNC(git_path_bisect_first_parent, "BISECT_FIRST_PARENT")
 
 static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --next-all [--no-checkout]"),
@@ -28,7 +29,7 @@ static const char * const git_bisect_helper_usage[] = {
 	N_("git bisect--helper --bisect-next-check <good_term> <bad_term> [<term>]"),
 	N_("git bisect--helper --bisect-terms [--term-good | --term-old | --term-bad | --term-new]"),
 	N_("git bisect--helper --bisect-start [--term-{old,good}=<term> --term-{new,bad}=<term>]"
-					     "[--no-checkout] [<bad> [<good>...]] [--] [<paths>...]"),
+					    " [--no-checkout] [--first-parent] [<bad> [<good>...]] [--] [<paths>...]"),
 	NULL
 };
 
@@ -422,7 +423,7 @@ static int bisect_append_log_quoted(const char **argv)
 }
 
 static int bisect_start(struct bisect_terms *terms, int no_checkout,
-			const char **argv, int argc)
+			int first_parent_only, const char **argv, int argc)
 {
 	int i, has_double_dash = 0, must_write_terms = 0, bad_seen = 0;
 	int flags, pathspec_pos, res = 0;
@@ -453,6 +454,8 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 			break;
 		} else if (!strcmp(arg, "--no-checkout")) {
 			no_checkout = 1;
+		} else if (!strcmp(arg, "--first-parent")) {
+			first_parent_only = 1;
 		} else if (!strcmp(arg, "--term-good") ||
 			 !strcmp(arg, "--term-old")) {
 			i++;
@@ -577,6 +580,9 @@ static int bisect_start(struct bisect_terms *terms, int no_checkout,
 	 */
 	write_file(git_path_bisect_start(), "%s\n", start_head.buf);
 
+	if (first_parent_only)
+		write_file(git_path_bisect_first_parent(), "\n");
+
 	if (no_checkout) {
 		if (get_oid(start_head.buf, &oid) < 0) {
 			res = error(_("invalid ref: '%s'"), start_head.buf);
@@ -632,7 +638,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		BISECT_TERMS,
 		BISECT_START
 	} cmdmode = 0;
-	int no_checkout = 0, res = 0, nolog = 0;
+	int no_checkout = 0, first_parent_only = 0, res = 0, nolog = 0;
 	struct option options[] = {
 		OPT_CMDMODE(0, "next-all", &cmdmode,
 			 N_("perform 'git bisect next'"), NEXT_ALL),
@@ -656,6 +662,8 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 			 N_("start the bisect session"), BISECT_START),
 		OPT_BOOL(0, "no-checkout", &no_checkout,
 			 N_("update BISECT_HEAD instead of checking out the current commit")),
+		OPT_BOOL(0, "first-parent", &first_parent_only,
+			 N_("only trace the first parent of merge commits")),
 		OPT_BOOL(0, "no-log", &nolog,
 			 N_("no log for BISECT_WRITE")),
 		OPT_END()
@@ -713,7 +721,7 @@ int cmd_bisect__helper(int argc, const char **argv, const char *prefix)
 		break;
 	case BISECT_START:
 		set_terms(&terms, "bad", "good");
-		res = bisect_start(&terms, no_checkout, argv, argc);
+		res = bisect_start(&terms, no_checkout, first_parent_only, argv, argc);
 		break;
 	default:
 		return error("BUG: unknown subcommand '%d'", cmdmode);
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 36d9b2b2e4..7965698310 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -458,6 +458,23 @@ test_expect_success 'many merge bases creation' '
 	grep "$SIDE_HASH5" merge_bases.txt
 '
 
+# We want to automatically find the merge that
+# introduced "line" into hello.
+test_expect_success \
+    '"git bisect run --first-parent" simple case' \
+    'echo "#"\!"/bin/sh" > test_script.sh &&
+     echo "grep line hello > /dev/null" >> test_script.sh &&
+     echo "test \$? -ne 0" >> test_script.sh &&
+     chmod +x test_script.sh &&
+     git bisect start --first-parent &&
+     test_path_is_file ".git/BISECT_FIRST_PARENT" &&
+     git bisect good $HASH4 &&
+     git bisect bad $B_HASH &&
+     git bisect run ./test_script.sh > my_bisect_log.txt &&
+     grep "$B_HASH is the first bad commit" my_bisect_log.txt &&
+     git bisect reset &&
+     test_path_is_missing ".git/BISECT_FIRST_PARENT"'
+
 test_expect_success 'good merge bases when good and bad are siblings' '
 	git bisect start "$B_HASH" "$A_HASH" > my_bisect_log.txt &&
 	test_i18ngrep "merge base must be tested" my_bisect_log.txt &&
-- 
2.24.3 (Apple Git-128)

