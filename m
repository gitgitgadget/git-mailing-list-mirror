Return-Path: <SRS0=IAqa=EC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05CA4C56201
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9DF420872
	for <git@archiver.kernel.org>; Tue, 27 Oct 2020 02:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CgPikRTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2504364AbgJ0CIQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Oct 2020 22:08:16 -0400
Received: from mail-wm1-f52.google.com ([209.85.128.52]:34973 "EHLO
        mail-wm1-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504357AbgJ0CIO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Oct 2020 22:08:14 -0400
Received: by mail-wm1-f52.google.com with SMTP id h22so86082wmb.0
        for <git@vger.kernel.org>; Mon, 26 Oct 2020 19:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=68sc9B/0csd629noV8jhACYBrCHiFf55lnL+7AxCs08=;
        b=CgPikRTs5lcZHDUwVx/z5CTpUwfD7QyH+LL8Wvptv1056vP9Ar/RWDXswLKGntq0KA
         6j6tXJaIPaEB8ao6gy06TN3HSPrYOdoZYdoekV6Nng140PkcyE4U5zn7A8TGEVP4BdId
         WPPEtybmQ1R/dOVNkOWGm4UrzegdOqMhbPXpuIkj3szXceQI34HZ3NwDWUkxbeSDsiVq
         9l9sWdw8KGf/en6/4PZnS5kttjOZhzokvolFcqc9WfHvaJ2LI75DR8jK7OYL76k2g+HI
         95nqVzghajfCF3WdEGEg/1rT7c3bgIN6YmO8mysQI+b4szM2FDDfozh9Mbu/WSXCcccO
         2Cjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=68sc9B/0csd629noV8jhACYBrCHiFf55lnL+7AxCs08=;
        b=PuxU+NEM8O0ivUaDUojb0VwmNpMMnhzrgTiuuGRMTnJqxP7SOUWY+3XzYPic5cJXKW
         3EebjzOjYJOWxcauALGJBSgnHV/vtA5lkPVfPGrnlngqi90Af296/NiqQCNKR50vdasK
         BE8eXwGsAUfhQOvELL5WEwnQniVFZUunwfZUMK9N/0NwLM8AXEJ4okKHUx0Alr5SGnKd
         CmM79cQ+8/gurjdNI7aRv9Pk133tsz4DwVHF4cJqDaqK4ZJoFvvmCesDCgW6jiUEjuo4
         6OgQqKuSiAmVespA1S9bMhiGrkZ0dm4dtMp5cyLEUlBAiiOMngdMuWhBznp4ZlYlm7cK
         cp1Q==
X-Gm-Message-State: AOAM530+R4BbUE/NBnT1ObE7NEEZ987AazJhzXvksSDjFapiDYF3wv3t
        D9GKuCu7Dvocl3exE5aVf1mQU5nAug4=
X-Google-Smtp-Source: ABdhPJzZeOkwbZDbiG3PvHdNnwKn+SOJ1tuEwMJYapfyDpsLWbAFyQeqKc7WPP5grhJEyaI61ugYcQ==
X-Received: by 2002:a1c:9695:: with SMTP id y143mr103072wmd.146.1603764492447;
        Mon, 26 Oct 2020 19:08:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m12sm58163wmi.33.2020.10.26.19.08.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2020 19:08:11 -0700 (PDT)
Message-Id: <3357ea415e3437966f15bf73fbbeb21cda3df592.1603764490.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
References: <pull.895.v2.git.git.1603731448.gitgitgadget@gmail.com>
        <pull.895.v3.git.git.1603764490.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Oct 2020 02:08:07 +0000
Subject: [PATCH v3 1/4] merge-ort: barebones API of new merge strategy with
 empty implementation
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Peter Baumann <peter.baumann@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

This is the beginning of a new merge strategy.  While there are some API
differences, and the implementation has some differences in behavior, it
is essentially meant as an eventual drop-in replacement for
merge-recursive.c.  However, it is being built to exist side-by-side
with merge-recursive so that we have plenty of time to find out how
those differences pan out in the real world while people can still fall
back to merge-recursive.  (Also, I intend to avoid modifying
merge-recursive during this process, to keep it stable.)

The primary difference noticable here is that the updating of the
working tree and index is not done simultaneously with the merge
algorithm, but is a separate post-processing step.  The new API is
designed so that one can do repeated merges (e.g. during a rebase or
cherry-pick) and only update the index and working tree one time at the
end instead of updating it with every intermediate result.  Also, one
can perform a merge between two branches, neither of which match the
index or the working tree, without clobbering the index or working tree.

The next three commits will demonstrate various uses of this new API.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Makefile    |  1 +
 merge-ort.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 merge-ort.h | 58 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+)
 create mode 100644 merge-ort.c
 create mode 100644 merge-ort.h

diff --git a/Makefile b/Makefile
index 95571ee3fc..088770c2ae 100644
--- a/Makefile
+++ b/Makefile
@@ -921,6 +921,7 @@ LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += mem-pool.o
 LIB_OBJS += merge-blobs.o
+LIB_OBJS += merge-ort.o
 LIB_OBJS += merge-recursive.o
 LIB_OBJS += merge.o
 LIB_OBJS += mergesort.o
diff --git a/merge-ort.c b/merge-ort.c
new file mode 100644
index 0000000000..b487901d3e
--- /dev/null
+++ b/merge-ort.c
@@ -0,0 +1,52 @@
+/*
+ * "Ostensibly Recursive's Twin" merge strategy, or "ort" for short.  Meant
+ * as a drop-in replacement for the "recursive" merge strategy, allowing one
+ * to replace
+ *
+ *   git merge [-s recursive]
+ *
+ * with
+ *
+ *   git merge -s ort
+ *
+ * Note: git's parser allows the space between '-s' and its argument to be
+ * missing.  (Should I have backronymed "ham", "alsa", "kip", "nap, "alvo",
+ * "cale", "peedy", or "ins" instead of "ort"?)
+ */
+
+#include "cache.h"
+#include "merge-ort.h"
+
+void merge_switch_to_result(struct merge_options *opt,
+			    struct tree *head,
+			    struct merge_result *result,
+			    int update_worktree_and_index,
+			    int display_update_msgs)
+{
+	die("Not yet implemented");
+	merge_finalize(opt, result);
+}
+
+void merge_finalize(struct merge_options *opt,
+		    struct merge_result *result)
+{
+	die("Not yet implemented");
+}
+
+void merge_incore_nonrecursive(struct merge_options *opt,
+			       struct tree *merge_base,
+			       struct tree *side1,
+			       struct tree *side2,
+			       struct merge_result *result)
+{
+	die("Not yet implemented");
+}
+
+void merge_incore_recursive(struct merge_options *opt,
+			    struct commit_list *merge_bases,
+			    struct commit *side1,
+			    struct commit *side2,
+			    struct merge_result *result)
+{
+	die("Not yet implemented");
+}
diff --git a/merge-ort.h b/merge-ort.h
new file mode 100644
index 0000000000..74adccad16
--- /dev/null
+++ b/merge-ort.h
@@ -0,0 +1,58 @@
+#ifndef MERGE_ORT_H
+#define MERGE_ORT_H
+
+#include "merge-recursive.h"
+
+struct commit;
+struct tree;
+
+struct merge_result {
+	/* Whether the merge is clean */
+	int clean;
+
+	/*
+	 * Result of merge.  If !clean, represents what would go in worktree
+	 * (thus possibly including files containing conflict markers).
+	 */
+	struct tree *tree;
+
+	/*
+	 * Additional metadata used by merge_switch_to_result() or future calls
+	 * to merge_incore_*().  Includes data needed to update the index (if
+	 * !clean) and to print "CONFLICT" messages.  Not for external use.
+	 */
+	void *priv;
+};
+
+/*
+ * rename-detecting three-way merge with recursive ancestor consolidation.
+ * working tree and index are untouched.
+ */
+void merge_incore_recursive(struct merge_options *opt,
+			    struct commit_list *merge_bases,
+			    struct commit *side1,
+			    struct commit *side2,
+			    struct merge_result *result);
+
+/*
+ * rename-detecting three-way merge, no recursion.
+ * working tree and index are untouched.
+ */
+void merge_incore_nonrecursive(struct merge_options *opt,
+			       struct tree *merge_base,
+			       struct tree *side1,
+			       struct tree *side2,
+			       struct merge_result *result);
+
+/* Update the working tree and index from head to result after incore merge */
+void merge_switch_to_result(struct merge_options *opt,
+			    struct tree *head,
+			    struct merge_result *result,
+			    int update_worktree_and_index,
+			    int display_update_msgs);
+
+/* Do needed cleanup when not calling merge_switch_to_result() */
+void merge_finalize(struct merge_options *opt,
+		    struct merge_result *result);
+
+#endif
-- 
gitgitgadget

