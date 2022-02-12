Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2175AC433EF
	for <git@archiver.kernel.org>; Sat, 12 Feb 2022 20:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231667AbiBLUfQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 12 Feb 2022 15:35:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:53500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231625AbiBLUfK (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 12 Feb 2022 15:35:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD433606E9
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:02 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id x3-20020a05600c21c300b0037c01ad715bso5332263wmj.2
        for <git@vger.kernel.org>; Sat, 12 Feb 2022 12:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=CzqPmuiPlwT6a7QL+zHW/5Pt51e4bTxme/XtkOQKvGs=;
        b=FnnOhvQAm/15PmhSUpli638iZI9n8r+nXZKeG8LDlEjRSRokfvIwGRGyZf0BwtL/nN
         pavaCEvfDKEa32f7JFtJdUlCIsR/mxeylSBKI9HaZSWvvLMdC2wqn66o6R1mutOEYLbs
         U/AKf8oRVojGrdquU9EoVDxTwo7Z0AphrpOP2Gf0pZV9QWDqDLPOA33cqVPOVMZ4e4jC
         H4AFxCOFl34s0pyZFIKrrH/eysWb6pfuOkaUhvA4b07Dz6Tj3clADDQMNH3plMpoKyLH
         aM6xnCJnkd9icgIqQLt4UOJgEtjFSAPv7JX/49BOs0l691lkEHKnW8CKh5bCZ4zMqLON
         TtuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=CzqPmuiPlwT6a7QL+zHW/5Pt51e4bTxme/XtkOQKvGs=;
        b=CH8n0ksK/YEURbQXEoqlx0S9NwGVZprEHH0B7HHLyFVpb4WzEEwFJ60ZZFJH3wBmk7
         0P9CvjilIZaY5RoXT3bYVNaWZwW0hSEKP9GumanyKrr/wrdM+rOp7ImcHn5bu5e82DYb
         lEaHnD4c8nxQhHr8jCK2vBSN8V8bVR78oi+Uc5NaQtUwGbYuCQ8ltpGPp/ia/1gMyiqL
         mSLBomKfb2KnhREna4llwWI1koGztfHi9Xvb+ihDn0pyx+a3ZKgjB3NiR8LROfGH0YwT
         ko/Mc3iFupcClzHuo9adrfR01+gqgk6TWK+qd0GdLljiRrzW2mTWRZIaeqooajspCdHy
         Zlew==
X-Gm-Message-State: AOAM533IJIZ8/1S03pyDAtMlzOq0NKZtTd6jR1VRC/a2zWDVqAjQK2VL
        EVle5iErSpT6aAkZBLoWcL+8HEDhP7U=
X-Google-Smtp-Source: ABdhPJyyTm4zQT9N3DUlo+ProclEGXGLhx56Ptjucz1X2ulKP1wg0qF7bRDQDdtRN0MbifbtsGFTuA==
X-Received: by 2002:a7b:c381:: with SMTP id s1mr5352219wmj.114.1644698101331;
        Sat, 12 Feb 2022 12:35:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h18sm8321704wmq.8.2022.02.12.12.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Feb 2022 12:35:00 -0800 (PST)
Message-Id: <6058190d1b16a689ac5e4b4c077b594acf13acea.1644698093.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
References: <pull.1122.v3.git.1643787281.gitgitgadget@gmail.com>
        <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 12 Feb 2022 20:34:49 +0000
Subject: [PATCH v4 08/12] merge-tree: provide a list of which files have
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
 Documentation/git-merge-tree.txt |  8 ++++++++
 builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 41 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 869c38f8223..9f7eb03c6eb 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -67,6 +67,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
+	<Conflicted file list>
 	<Informational messages>
 
 These are discussed individually below.
@@ -78,6 +79,13 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
+Conflicted file list
+~~~~~~~~~~~~~~~~~~~~
+
+This is a sequence of lines containing a filename on each line, quoted
+as explained for the configuration variable `core.quotePath` (see
+linkgit:git-config[1]).
+
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index d44e8d087b1..cb4169d2271 100644
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
 	struct commit_list *common;
@@ -444,6 +448,22 @@ static int real_merge(struct merge_tree_options *o,
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
 		printf("\n");
 		merge_display_update_messages(&opt, &result);
@@ -511,7 +531,7 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 
 	/* Do the relevant type of merge */
 	if (o.mode == MODE_REAL)
-		return real_merge(&o, argv[0], argv[1]);
+		return real_merge(&o, argv[0], argv[1], prefix);
 	else
 		return trivial_merge(argv[0], argv[1], argv[2]);
 }
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 25adcf36bdf..0964c1145e6 100755
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

