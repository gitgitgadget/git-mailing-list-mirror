Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55040C433EF
	for <git@archiver.kernel.org>; Wed, 23 Feb 2022 07:47:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiBWHrn (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Feb 2022 02:47:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238755AbiBWHrc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Feb 2022 02:47:32 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1200A6A075
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:04 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id d14-20020a05600c34ce00b0037bf4d14dc7so3717873wmq.3
        for <git@vger.kernel.org>; Tue, 22 Feb 2022 23:47:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=XU31w+RDeQVF/hdGuYvGcOqYHJUPM+dwnKV4wxmDH2s=;
        b=QkSMPnm4mbkeK1clMla4yo+tQcGg5ArPXgjC+1Nb15DMeI0hKxO/2WJOGkr5zlwuAn
         OADxBQazoMsjpjWhOJYiZJC86mM5073sZ0wBWvfZ0q7/OQCmcuMVLKNKokrB40+T+VZM
         rt3oD71j8FzMKUSScnz7oyyU9WtGui4bNOV0JndG+F1DrGUaQVnW23uv9k+iFbkDzs0H
         qhFs4+n/RN477wPlZGoO4ctMk4EBRCfatjEbyuCrfIcfCscMrZraSqZEgznJuiWYqym6
         pzX45pqCWXSDhKxeRMV7ROgFOPCQ+63IdbK0QfC1/cflN5AcXLAky6Ucg+pYu0fSJgNP
         qgag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=XU31w+RDeQVF/hdGuYvGcOqYHJUPM+dwnKV4wxmDH2s=;
        b=cOD4lglHLBKiW4LCcC/N46/7+vZ9igoA0YYqGoLppiY9VX5GH3Oh4u72ttJYZ20ali
         xxOIB0kigtI7MQFNk8/Vllqr9+qhEpWZeC7LS4ZDoID2wyDiLPbSXMaolX+4VRK6AqAX
         XVzEoZCuLnUo31EkrVKezYlqUwPZIHovdaCUxHS98HYF0pg4ZuOK41cD3x4TNcSgQAo0
         l/e6X3yD8BQKnnPDc+Zy68jqN1QMfT67JENISBlRuw4GGsNEk2yFZH+jT/h9QUvE6NX7
         o+ZCkqBgkJ7Z1sW0+fqWaYbmLQqxaQV4CJUaKkVc3oCpFQvEsoScIDuqv+zdOp+/gVfq
         FD5Q==
X-Gm-Message-State: AOAM531sKpHgVCo0KMf+nIVVfTqy4yPmtWzhyR4t/UTL/87QhUdBN3I3
        pAJtoMjX83OjULSTomlVgGSyc8jECQY=
X-Google-Smtp-Source: ABdhPJw4AIe5IGe5Z0aDYkQFO3sSs9C4pGuKyVFEL4Ss203JtmFR+mWHCBQnsOPwiB+WfWArCYQWag==
X-Received: by 2002:a7b:c853:0:b0:380:e16c:19e7 with SMTP id c19-20020a7bc853000000b00380e16c19e7mr4362141wml.172.1645602422452;
        Tue, 22 Feb 2022 23:47:02 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t1sm67193031wre.45.2022.02.22.23.47.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Feb 2022 23:47:02 -0800 (PST)
Message-Id: <7b1ee417f3d5a4c1778da289f1b93b28dabe4a4e.1645602413.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
References: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
        <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 23 Feb 2022 07:46:49 +0000
Subject: [PATCH v6 08/12] merge-tree: provide a list of which files have
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
 builtin/merge-tree.c             | 24 ++++++++++++++++++++++--
 t/t4301-merge-tree-write-tree.sh | 11 +++++++++++
 3 files changed, 42 insertions(+), 2 deletions(-)

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
index 831d9c77583..3653526cc0a 100644
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
@@ -441,6 +445,22 @@ static int real_merge(struct merge_tree_options *o,
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

