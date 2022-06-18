Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FC1CC43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383694AbiFRAVi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383709AbiFRAVS (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:18 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915645A2E1
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id m125-20020a1ca383000000b0039c63fe5f64so3082305wme.0
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NklJAMExKowYKfay6MxXIm7zrujP40tvGRFMqbVfzgo=;
        b=IO5VfoVJpWZkFdpgonAfa0PViBtCA7ZPa2wHFa975/otfxIhBSoXceed9mmxmCgBZR
         yMjf9VbCcoanTbkpfQKTSAmosht0HrvvjFz2/U9Y7u3YOeYNIQKzW+f7Y1ifcGvA8qpY
         hV3PJdnOIQk7lrmn0G8mKHb9en2uBF4B1cRqHgsJGXA5zrlY7IGvVjA6Arj7lwiV9rQF
         7Vx68P2vq/VmAQiv/ii/RzS+WyQFRK2aAi5CMuoPPHvV6bnCYdewJyKMJsPkryUObwsC
         afG+6zF+YQJN7LAwAS5fC77KCIIcLs1RbqJirspyRsjLoLWFpCNoWz/J2Fi8AzDGY14V
         goFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NklJAMExKowYKfay6MxXIm7zrujP40tvGRFMqbVfzgo=;
        b=E6ABeO5ghaStxcYCA1UQ4w0zdgashIb9mFa5wRclnNoKiRF4YzVo6EXR3DJxpIduvi
         mlygafiVjo2YJVj49JUlDggFpsAb3vcICOV6omKs++uGaji/P8obERsWP2WNOVICdLvl
         P6h3MHG+9gZSrSr8bjGuIO9hS0BovHfjbbtqFYzVsOK99wmAKf8UhSz+/uM7ciOfphZ8
         Uq9YfrgcO43NbBc0jO9AoekaUHX0KoFLoUwW15YOk62zobNvDI/uW1ikWbrt3W5ku6uV
         4/y5S/T9sGDHpi+5J0GAr2wJzZBa9yjriIUcuCuNkQXCcc0PMGWt6+fut1m2KG1CH/JY
         U48Q==
X-Gm-Message-State: AOAM5311UcKaQAz4Xeu3Tx+jjcPR7T4iAjIGBEv7irvuV9HAgaq1uRUN
        XhfTcfH5ojiSi8sw5Bxyz4b0VqIoGon1tw==
X-Google-Smtp-Source: ABdhPJzd6M1lwPD96jrBukjDjOqMB6pEb5pk01nOkUb25o6QfxDkkq7YMFjgS/a3cO/J3o1ICGRY6Q==
X-Received: by 2002:a7b:c757:0:b0:39c:69dd:b42a with SMTP id w23-20020a7bc757000000b0039c69ddb42amr23137350wmk.12.1655511673601;
        Fri, 17 Jun 2022 17:21:13 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b0021b8213fa3bsm2276101wrt.19.2022.06.17.17.21.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:13 -0700 (PDT)
Message-Id: <c92b81e7366f3c7b7fec1536ea2c41012b051bab.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:52 +0000
Subject: [PATCH v7 09/17] merge-tree: provide a list of which files have
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Altmanninger <aclopte@gmail.com>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Christian Couder <christian.couder@gmail.com>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Callers of `git merge-tree --write-tree` will often want to know which
files had conflicts.  While they could potentially attempt to parse the
CONFLICT notices printed, those messages are not meant to be machine
readable.  Provide a simpler mechanism of just printing the files (in
the same format as `git ls-files` with quoting, but restricted to
unmerged files) in the output before the free-form messages.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt |  9 +++++++++
 builtin/merge-tree.c             | 26 +++++++++++++++++++++++---
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 43 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 25b462be14e..68a51c82618 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -58,6 +58,7 @@ line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -70,6 +71,14 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
+[[CFI]]
+Conflicted file list
+~~~~~~~~~~~~~~~~~~~~
+
+This is a sequence of lines containing a filename on each line, quoted
+as explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
+
 [[IM]]
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 831d9c77583..13a9536f7c1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -11,6 +11,9 @@
 #include "blob.h"
 #include "exec-cmd.h"
 #include "merge-blobs.h"
+#include "quote.h"
+
+static int line_termination = '\n';
 
 struct merge_list {
 	struct merge_list *next;
@@ -400,7 +403,8 @@ struct merge_tree_options {
 };
 
 static int real_merge(struct merge_tree_options *o,
-		      const char *branch1, const char *branch2)
+		      const char *branch1, const char *branch2,
+		      const char *prefix)
 {
 	struct commit *parent1, *parent2;
 	struct commit_list *merge_bases = NULL;
@@ -441,8 +445,24 @@ static int real_merge(struct merge_tree_options *o,
 		o->show_messages = !result.clean;
 
 	puts(oid_to_hex(&result.tree->object.oid));
+	if (!result.clean) {
+		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
+		const char *last = NULL;
+		int i;
+
+		merge_get_conflicted_files(&result, &conflicted_files);
+		for (i = 0; i < conflicted_files.nr; i++) {
+			const char *name = conflicted_files.items[i].string;
+			if (last && !strcmp(last, name))
+				continue;
+			write_name_quoted_relative(
+				name, prefix, stdout, line_termination);
+			last = name;
+		}
+		string_list_clear(&conflicted_files, 1);
+	}
 	if (o->show_messages) {
-		printf("\n");
+		putchar(line_termination);
 		merge_display_update_messages(&opt, &result);
 	}
 	merge_finalize(&opt, &result);
@@ -508,7 +528,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 719d81e7173..8e6dba44288 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -117,6 +117,8 @@ test_expect_success 'test conflict notices and such' '
 	#   "whatever" has *both* a modify/delete and a file/directory conflict
 	cat <<-EOF >expect &&
 	HASH
+	greeting
+	whatever~side1
 
 	Auto-merging greeting
 	CONFLICT (content): Merge conflict in greeting
@@ -140,4 +142,13 @@ do
 	'
 done
 
+test_expect_success 'Just the conflicted files without the messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	test_write_lines HASH greeting whatever~side1 >expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget

