From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 56/94] apply: move 'struct apply_state' to apply.h
Date: Wed, 11 May 2016 15:17:07 +0200
Message-ID: <20160511131745.2914-57-chriscool@tuxfamily.org>
References: <20160511131745.2914-1-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>,
	Jeff King <peff@peff.net>,
	Karsten Blees <karsten.blees@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 15:20:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0U41-0003kW-IK
	for gcvg-git-2@plane.gmane.org; Wed, 11 May 2016 15:20:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932297AbcEKNUZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 May 2016 09:20:25 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:33529 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751651AbcEKNUX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2016 09:20:23 -0400
Received: by mail-wm0-f65.google.com with SMTP id r12so9413955wme.0
        for <git@vger.kernel.org>; Wed, 11 May 2016 06:20:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VqbYwRPtkOiegiVMNEXIiye9rQSoEfZPyZjEld2ILTk=;
        b=rsPRhnMuFgQaEcFHB6/ser+4k9p3Vs3YYEC02b9XV0jcJYeK86fKFJUBmJCm1snx4U
         NS9YXJ6YiIshIQVPNZ4zrUnrBQNliLrL+LjnT8jQ5gDdv/TEffsmvlSafUBcZj5YmG2b
         58g4OC7QPr9ot7pVasqFHA2mDMQOEreZQKBbxtCpbRqyjkg+rTq2DImChvAvGeMShiYG
         jbO4lWNRV1X1slp0dLQ4KienFcFQ95bOYJErB3mnsJ8h5WWXHtdOXy0ojTmSIHcznMy9
         uCLQ6P4sGlxjo/HKLAjFpeqnubjo4XcK+S86p9ohDBqbmZ21kGtqKoXaYdd1fI8R4Lsv
         1ADg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VqbYwRPtkOiegiVMNEXIiye9rQSoEfZPyZjEld2ILTk=;
        b=dfGil+IfrLfj8RXWEQFuwCFz5RXi0TiIhWYSr5OJ0wUTMbPYwnpMob9I9mCgwzLC0T
         6fWwcY1PObp1cxIrUFdqlnDmMB8h3ZCKqIR0XUUnhMMoAwGh3ILOMMWnR92Mcd564rRd
         R3XyjLeIkp2An0378ZEPOZVjjn/5Go2f3D6bUojnKDs4pON8gkPFKYRzl0kxIAsOe7GU
         /wq5GzXQxpuLCHwOFI6CD8L0qVOcC/mvHJowlhyMJHvvepcFNhFxem+pBiTZfkmIiU+G
         Qj4tiqK4EFF/NIahva6HZ+SgwWxu1CYctQWokf1Y1V20/xJ2q2Mm9aZLDOcSm1hF2XIP
         B5Ng==
X-Gm-Message-State: AOPr4FXEz+13w7PihJd4HLHZX4/TnOc4cIcljc8N3/mhSXHV/UlXraIZs9b2cVw2EycI9w==
X-Received: by 10.194.107.6 with SMTP id gy6mr3855144wjb.20.1462972821586;
        Wed, 11 May 2016 06:20:21 -0700 (PDT)
Received: from localhost.localdomain ([80.215.130.96])
        by smtp.gmail.com with ESMTPSA id pm4sm8060791wjb.35.2016.05.11.06.20.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 11 May 2016 06:20:20 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.2.490.g3dabe57
In-Reply-To: <20160511131745.2914-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294284>

To libify `git apply` functionality we must make 'struct apply_state'
usable outside "builtin/apply.c".

Let's do that by creating a new "apply.h" and moving
'struct apply_state' there.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         | 115 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/apply.c | 112 +-----------------------------------------------------
 2 files changed, 116 insertions(+), 111 deletions(-)
 create mode 100644 apply.h

diff --git a/apply.h b/apply.h
new file mode 100644
index 0000000..aa11ea6
--- /dev/null
+++ b/apply.h
@@ -0,0 +1,115 @@
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
+	/*
+	 * Since lockfile.c keeps a linked list of all created
+	 * lock_file structures, it isn't safe to free(lock_file).
+	 */
+	struct lock_file *lock_file;
+	int newfd;
+
+	int apply;
+	int allow_overlap;
+	int apply_in_reverse;
+	int apply_with_reject;
+	int apply_verbosely;
+
+	/* --cached updates only the cache without ever touching the working tree. */
+	int cached;
+
+	/* --stat does just a diffstat, and doesn't actually apply */
+	int diffstat;
+
+	/* --numstat does numeric diffstat, and doesn't actually apply */
+	int numstat;
+
+	int summary;
+	int threeway;
+	int no_add;
+	const char *fake_ancestor;
+	const char *patch_input_file;
+	struct string_list limit_by_name;
+	int has_include;
+	struct strbuf root;
+	struct string_list symlink_changes;
+
+	/*
+	 *  --check turns on checking that the working tree matches the
+	 *    files that are being modified, but doesn't apply the patch
+	 */
+	int check;
+
+	/* --index updates the cache as well. */
+	int check_index;
+
+	int unidiff_zero;
+	int update_index;
+	int unsafe_paths;
+	int line_termination;
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
+	 * Various "current state", notably line numbers and what
+	 * file (and how) we're patching right now.. The "is_xxxx"
+	 * things are flags, where -1 means "don't know yet".
+	 */
+	int linenr;
+
+	/*
+	 * Records filenames that have been touched, in order to handle
+	 * the case where more than one patches touch the same file.
+	 */
+	struct string_list fn_table;
+
+	int p_value;
+	int p_value_known;
+	unsigned int p_context;
+
+	const char *whitespace_option;
+	int whitespace_error;
+	int squelch_whitespace_errors;
+	int applied_after_fixing_ws;
+
+	enum ws_error_action ws_error_action;
+	enum ws_ignore ws_ignore_action;
+};
+
+#endif
diff --git a/builtin/apply.c b/builtin/apply.c
index 58bcfeb..e42c8fe 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,117 +20,7 @@
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
-	/*
-	 * Since lockfile.c keeps a linked list of all created
-	 * lock_file structures, it isn't safe to free(lock_file).
-	 */
-	struct lock_file *lock_file;
-	int newfd;
-
-	int apply;
-	int allow_overlap;
-	int apply_in_reverse;
-	int apply_with_reject;
-	int apply_verbosely;
-
-	/* --cached updates only the cache without ever touching the working tree. */
-	int cached;
-
-	/* --stat does just a diffstat, and doesn't actually apply */
-	int diffstat;
-
-	/* --numstat does numeric diffstat, and doesn't actually apply */
-	int numstat;
-
-	int summary;
-	int threeway;
-	int no_add;
-	const char *fake_ancestor;
-	const char *patch_input_file;
-	struct string_list limit_by_name;
-	int has_include;
-	struct strbuf root;
-	struct string_list symlink_changes;
-
-	/*
-	 *  --check turns on checking that the working tree matches the
-	 *    files that are being modified, but doesn't apply the patch
-	 */
-	int check;
-
-	/* --index updates the cache as well. */
-	int check_index;
-
-	int unidiff_zero;
-	int update_index;
-	int unsafe_paths;
-	int line_termination;
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
-	 * Various "current state", notably line numbers and what
-	 * file (and how) we're patching right now.. The "is_xxxx"
-	 * things are flags, where -1 means "don't know yet".
-	 */
-	int linenr;
-
-	/*
-	 * Records filenames that have been touched, in order to handle
-	 * the case where more than one patches touch the same file.
-	 */
-	struct string_list fn_table;
-
-	int p_value;
-	int p_value_known;
-	unsigned int p_context;
-
-	const char *whitespace_option;
-	int whitespace_error;
-	int squelch_whitespace_errors;
-	int applied_after_fixing_ws;
-
-	enum ws_error_action ws_error_action;
-	enum ws_ignore ws_ignore_action;
-};
+#include "apply.h"
 
 static const char * const apply_usage[] = {
 	N_("git apply [<options>] [<patch>...]"),
-- 
2.8.2.490.g3dabe57
