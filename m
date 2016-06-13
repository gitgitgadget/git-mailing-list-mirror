From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 01/40] apply: move 'struct apply_state' to apply.h
Date: Mon, 13 Jun 2016 18:09:03 +0200
Message-ID: <20160613160942.1806-2-chriscool@tuxfamily.org>
References: <20160613160942.1806-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Johannes Sixt <j6t@kdbg.org>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 13 18:10:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bCURB-0003KT-Uh
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jun 2016 18:10:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1424768AbcFMQKB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jun 2016 12:10:01 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:34036 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1424605AbcFMQKA (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jun 2016 12:10:00 -0400
Received: by mail-wm0-f66.google.com with SMTP id n184so16049633wmn.1
        for <git@vger.kernel.org>; Mon, 13 Jun 2016 09:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eD/Mgs5oTelLoFRaiT5msZZAI+N1D4LuPruWFsSLCbo=;
        b=RYbdD6m5fLCFLH/fqRV9OueSCVSG/0pu5o7RqjSmFCwMUnLHM6zHs2hcjnzazg2bzW
         NWS9k/UUlkI/HkLqXfvxcKsByU0mOYIvsxO3neqjWl/O1QAtno1jHgs+ZUM8KMxvn+mi
         S0c3R7pvRwDAsbGCarSTRFP9suyWtDg6Q0GXx5Mln8VOulYAPzzLZvb5xYLOK2hNWS7b
         0kPuHXGGs+UCjBOL3M1N8F7TnFwFLaKGQGKhLMsyeuGnXwvNThktKxPgSU12fM5YMh37
         hzAWB05TdZUBuv8Nh8qRCJDBqzrpb+IwKQ9ARyJBlz0b9BJooO2pJvpq0YlTElq0jFzg
         sXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eD/Mgs5oTelLoFRaiT5msZZAI+N1D4LuPruWFsSLCbo=;
        b=gbIzcRimjuKg0Fl4b9YfPse8ZbR9gios5FeJtx6HqzeW/pOeV6/wzO+0tKgOKzOW0q
         RI9hss8Q97anz0diPKfufNjJr38CTqpCd11/+wyGoO4D39kcFegfPqIy6yqcVQhEz26g
         23f2azi80YKz49qIOwpNzW6QFH47LfbNYc/XdriEAOg1+SsP21m6ycvRrN1MT6UWJ6cX
         kqPT4PESYFgRLOYYOQGk3CfV4R624d9+Kg12H1RVtNtqK4r1/1rArjWfpZqRErcKOlwu
         fNb6vf81/CgUOBAioBuPzWk72cpMmyABej59HBG1LfYFjMntdNmWG7yY7fGhLx1eEhax
         /UNg==
X-Gm-Message-State: ALyK8tIkxBq6eZSqBFFbUzrO12Wdsib378JLRBtQDgRhZ4MnVr448C9HNDdL83T/OPg3Kw==
X-Received: by 10.28.218.149 with SMTP id r143mr368614wmg.102.1465834198415;
        Mon, 13 Jun 2016 09:09:58 -0700 (PDT)
Received: from localhost.localdomain (cha92-h01-128-78-31-246.dsl.sta.abo.bbox.fr. [128.78.31.246])
        by smtp.gmail.com with ESMTPSA id g10sm6445369wjl.25.2016.06.13.09.09.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 13 Jun 2016 09:09:57 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.9.0.rc2.411.gcd7457d
In-Reply-To: <20160613160942.1806-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/297195>

To libify `git apply` functionality we must make 'struct apply_state'
usable outside "builtin/apply.c".

Let's do that by creating a new "apply.h" and moving
'struct apply_state' there.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         | 100 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/apply.c |  98 +-----------------------------------------------------
 2 files changed, 101 insertions(+), 97 deletions(-)
 create mode 100644 apply.h

diff --git a/apply.h b/apply.h
new file mode 100644
index 0000000..9a98eae
--- /dev/null
+++ b/apply.h
@@ -0,0 +1,100 @@
+#ifndef APPLY_H
+#define APPLY_H
+
+enum ws_error_action {
+	nowarn_ws_error,
+	warn_on_ws_error,
+	die_on_ws_error,
+	correct_ws_error
+};
+
+enum ws_ignore {
+	ignore_ws_none,
+	ignore_ws_change
+};
+
+/*
+ * We need to keep track of how symlinks in the preimage are
+ * manipulated by the patches.  A patch to add a/b/c where a/b
+ * is a symlink should not be allowed to affect the directory
+ * the symlink points at, but if the same patch removes a/b,
+ * it is perfectly fine, as the patch removes a/b to make room
+ * to create a directory a/b so that a/b/c can be created.
+ *
+ * See also "struct string_list symlink_changes" in "struct
+ * apply_state".
+ */
+#define SYMLINK_GOES_AWAY 01
+#define SYMLINK_IN_RESULT 02
+
+struct apply_state {
+	const char *prefix;
+	int prefix_length;
+
+	/* These are lock_file related */
+	struct lock_file *lock_file;
+	int newfd;
+
+	/* These control what gets looked at and modified */
+	int apply; /* this is not a dry-run */
+	int cached; /* apply to the index only */
+	int check; /* preimage must match working tree, don't actually apply */
+	int check_index; /* preimage must match the indexed version */
+	int update_index; /* check_index && apply */
+
+	/* These control cosmetic aspect of the output */
+	int diffstat; /* just show a diffstat, and don't actually apply */
+	int numstat; /* just show a numeric diffstat, and don't actually apply */
+	int summary; /* just report creation, deletion, etc, and don't actually apply */
+
+	/* These boolean parameters control how the apply is done */
+	int allow_overlap;
+	int apply_in_reverse;
+	int apply_with_reject;
+	int apply_verbosely;
+	int no_add;
+	int threeway;
+	int unidiff_zero;
+	int unsafe_paths;
+
+	/* Other non boolean parameters */
+	const char *fake_ancestor;
+	const char *patch_input_file;
+	int line_termination;
+	struct strbuf root;
+	int p_value;
+	int p_value_known;
+	unsigned int p_context;
+
+	/* Exclude and include path parameters */
+	struct string_list limit_by_name;
+	int has_include;
+
+	/* Various "current state" */
+	int linenr; /* current line number */
+	struct string_list symlink_changes; /* we have to track symlinks */
+
+	/*
+	 * For "diff-stat" like behaviour, we keep track of the biggest change
+	 * we've seen, and the longest filename. That allows us to do simple
+	 * scaling.
+	 */
+	int max_change;
+	int max_len;
+
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
+	/* These control whitespace errors */
+	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
+	const char *whitespace_option;
+	int whitespace_error;
+	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
+};
+
+#endif
diff --git a/builtin/apply.c b/builtin/apply.c
index ecb7f1b..3a0c53a 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,103 +20,7 @@
 #include "xdiff-interface.h"
 #include "ll-merge.h"
 #include "rerere.h"
-
-enum ws_error_action {
-	nowarn_ws_error,
-	warn_on_ws_error,
-	die_on_ws_error,
-	correct_ws_error
-};
-
-
-enum ws_ignore {
-	ignore_ws_none,
-	ignore_ws_change
-};
-
-/*
- * We need to keep track of how symlinks in the preimage are
- * manipulated by the patches.  A patch to add a/b/c where a/b
- * is a symlink should not be allowed to affect the directory
- * the symlink points at, but if the same patch removes a/b,
- * it is perfectly fine, as the patch removes a/b to make room
- * to create a directory a/b so that a/b/c can be created.
- *
- * See also "struct string_list symlink_changes" in "struct
- * apply_state".
- */
-#define SYMLINK_GOES_AWAY 01
-#define SYMLINK_IN_RESULT 02
-
-struct apply_state {
-	const char *prefix;
-	int prefix_length;
-
-	/* These are lock_file related */
-	struct lock_file *lock_file;
-	int newfd;
-
-	/* These control what gets looked at and modified */
-	int apply; /* this is not a dry-run */
-	int cached; /* apply to the index only */
-	int check; /* preimage must match working tree, don't actually apply */
-	int check_index; /* preimage must match the indexed version */
-	int update_index; /* check_index && apply */
-
-	/* These control cosmetic aspect of the output */
-	int diffstat; /* just show a diffstat, and don't actually apply */
-	int numstat; /* just show a numeric diffstat, and don't actually apply */
-	int summary; /* just report creation, deletion, etc, and don't actually apply */
-
-	/* These boolean parameters control how the apply is done */
-	int allow_overlap;
-	int apply_in_reverse;
-	int apply_with_reject;
-	int apply_verbosely;
-	int no_add;
-	int threeway;
-	int unidiff_zero;
-	int unsafe_paths;
-
-	/* Other non boolean parameters */
-	const char *fake_ancestor;
-	const char *patch_input_file;
-	int line_termination;
-	struct strbuf root;
-	int p_value;
-	int p_value_known;
-	unsigned int p_context;
-
-	/* Exclude and include path parameters */
-	struct string_list limit_by_name;
-	int has_include;
-
-	/* Various "current state" */
-	int linenr; /* current line number */
-	struct string_list symlink_changes; /* we have to track symlinks */
-
-	/*
-	 * For "diff-stat" like behaviour, we keep track of the biggest change
-	 * we've seen, and the longest filename. That allows us to do simple
-	 * scaling.
-	 */
-	int max_change;
-	int max_len;
-
-	/*
-	 * Records filenames that have been touched, in order to handle
-	 * the case where more than one patches touch the same file.
-	 */
-	struct string_list fn_table;
-
-	/* These control whitespace errors */
-	enum ws_error_action ws_error_action;
-	enum ws_ignore ws_ignore_action;
-	const char *whitespace_option;
-	int whitespace_error;
-	int squelch_whitespace_errors;
-	int applied_after_fixing_ws;
-};
+#include "apply.h"
 
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
-- 
2.9.0.rc2.411.g3e2ca28
