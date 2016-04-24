From: Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 56/83] apply: move 'struct apply_state' to apply.h
Date: Sun, 24 Apr 2016 15:33:56 +0200
Message-ID: <1461504863-15946-57-git-send-email-chriscool@tuxfamily.org>
References: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>, Karsten Blees <karsten.blees@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Christian Couder <chriscool@tuxfamily.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 24 15:37:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1auKE6-0000Zb-Vw
	for gcvg-git-2@plane.gmane.org; Sun, 24 Apr 2016 15:37:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753103AbcDXNhZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 24 Apr 2016 09:37:25 -0400
Received: from mail-wm0-f42.google.com ([74.125.82.42]:38568 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752911AbcDXNgG (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 24 Apr 2016 09:36:06 -0400
Received: by mail-wm0-f42.google.com with SMTP id u206so89946617wme.1
        for <git@vger.kernel.org>; Sun, 24 Apr 2016 06:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=6cGuxTBmvLV6f69GYIwR8VKxEETw6bs0OHSrl2Xp8Nk=;
        b=aV2aiFwQBSBdkrKcVUmgBELbvx30irUUyZfyD3k3B/wrA0WSFPLOvbNsZ24AFTfB3D
         14ikq2+mVmEve7PXp4wj0fSsMk9D+fEPftTXiTonAPQHU+rgtvASu/itv5aXC3ooxkXK
         RBVkuJuwtmcwODj4wa22lMMb+e4LphSUulgNmqoS/jhEXIv66dz7KU7gKKBFxgEAvmX6
         SIwGCj/fkbSdwaWfRPdpcTd18KdP63aAZexbL35mHdJqCSKbqdCoVkcUHs5AbprWM3P7
         11YILTVfboaOMpS8yIbpW7v76k+kVDgdb2d7aSdcWmTgfeEgv7mbKo1CTl/JsKy8PMgi
         ajvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=6cGuxTBmvLV6f69GYIwR8VKxEETw6bs0OHSrl2Xp8Nk=;
        b=dZAmlfnvzTbNttvtjcYOvtWygzW5G73rxrukpoIJYSqD9e9RIBbMtaIfLYAXEXYVj3
         yror9VJ4fpNmDrDOR8w3ms6OoqxrNYj8oyXHliEoopXpxW6I16dqP4VOHYsZqv2slRL1
         NhsNVdnRkeTp8Zy/AQ+ULfb7elbxDUKRHysd48ysl6XL8etFg8vL9Iuvv4Zj+oXiJpim
         gHTd+o2k7sR2z6KOPwxWeU0df/LWm2kikRr5ekVBt1soJAEUvPatV//kGSmr85YZjPhp
         A4S7+3CDzVp//n8fr6+vh09mM1SQPX4tOaQ/CgTPRO5ht7QFcFevMVtYxQUJ9xHZKzDQ
         e/ew==
X-Gm-Message-State: AOPr4FVJ/YRPsbcu05/CJs2xaBUzzKHrGpUfO+LZuqH4iX/WiCb+573nt7V4TbmCcGaWYQ==
X-Received: by 10.194.125.201 with SMTP id ms9mr29387670wjb.71.1461504964870;
        Sun, 24 Apr 2016 06:36:04 -0700 (PDT)
Received: from localhost.localdomain (121.73.115.78.rev.sfr.net. [78.115.73.121])
        by smtp.gmail.com with ESMTPSA id j6sm6717101wjb.29.2016.04.24.06.36.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 24 Apr 2016 06:36:03 -0700 (PDT)
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.8.1.300.g5fed0c0
In-Reply-To: <1461504863-15946-1-git-send-email-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292372>

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 apply.h         | 124 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 builtin/apply.c | 121 +-----------------------------------------------------
 2 files changed, 125 insertions(+), 120 deletions(-)
 create mode 100644 apply.h

diff --git a/apply.h b/apply.h
new file mode 100644
index 0000000..98aafc6
--- /dev/null
+++ b/apply.h
@@ -0,0 +1,124 @@
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
+	const char *fake_ancestor;
+
+	int summary;
+
+	int threeway;
+
+	int no_add;
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
+
+	int update_index;
+
+	int unsafe_paths;
+
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
+	struct string_list symlink_changes;
+
+	int p_value;
+	int p_value_known;
+	unsigned int p_context;
+
+	const char *patch_input_file;
+
+	struct string_list limit_by_name;
+	int has_include;
+
+	struct strbuf root;
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
index de5c745..1c1ac7d 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -20,126 +20,7 @@
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
-	const char *fake_ancestor;
-
-	int summary;
-
-	int threeway;
-
-	int no_add;
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
-
-	int update_index;
-
-	int unsafe_paths;
-
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
-	struct string_list symlink_changes;
-
-	int p_value;
-	int p_value_known;
-	unsigned int p_context;
-
-	const char *patch_input_file;
-
-	struct string_list limit_by_name;
-	int has_include;
-
-	struct strbuf root;
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
2.8.1.300.g5fed0c0
