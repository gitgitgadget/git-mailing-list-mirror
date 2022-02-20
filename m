Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B944C433FE
	for <git@archiver.kernel.org>; Sun, 20 Feb 2022 06:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234473AbiBTGzg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 20 Feb 2022 01:55:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:46796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234475AbiBTGzR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 20 Feb 2022 01:55:17 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108F935DEB
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:53 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c192so7726756wma.4
        for <git@vger.kernel.org>; Sat, 19 Feb 2022 22:54:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=J5MibgRZZG6DB2TDILZCHP5XiBcc14CKBs5+//5OYB0=;
        b=kXBxOPUYECiKsaP/Riw4zV/0zdIpyGUJiNeES3Nx9Tox0ON1Vwefl9aMOD0eCC5lV3
         L7u9XLgk+5OCZepVk71Mrrtb15tYSgHCgejRwtpLPS8O+cB+C5jAG02Yu/FLfdnJL6qQ
         zaORpVyQP8zK5CZnc01Tj5GJVdeWqYbYfGkYm/WWtLZsSXf5uJMccK0JAtLv5IE9lxO4
         cwQ6Nd/VVvyt3+m0SwjGaPN48BtHUrOPnhe8d6YPmd/AaBCcFcflRhmNSqZXzgCJAbhq
         IHALR+BoUfegVnsIL63xJ6ap9XEq48veGz6gt7aVqra0zWWHTfdY8PnNHoyZL7K0T8z5
         xD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=J5MibgRZZG6DB2TDILZCHP5XiBcc14CKBs5+//5OYB0=;
        b=xYsj5E1tc31yz/M8YsalltK+cB4BdKIkli0Tr5w7XTRhzx3xn2PZGuI07p3ngwWY4k
         L4L5VxEnnEqmIM/GePfvtcbDiQQPnPaFa24sQ96LQ2TLMc04ruHiMVYbgnmLdBywtdi4
         xe1Uv/zq2GDZbGamyY7qrC1gQS5IPUhbUAsml0Gz/RwRZCCixGnY7OZZ4QB/Mv0MiMls
         4wNR5PL5P+TPjO/mffp9zGudqs7OncyhYWpjAn8/rIvNoeNbwEnMCHq3rDnOJK29TEAy
         fzGquH3E26dCPyYVuZeLHoUOYbZXoqWNPFbCWOm70wkRAPR++E2lIOE0kSCc2a07Hhoz
         xmnw==
X-Gm-Message-State: AOAM532AEAZlYoYJGgNUoP5dzUjyltIPf3LQR8ubkVsuxMWQxWExV6bc
        N/H5xQcSC4mluogm9JlRuxzwAYFQtuI=
X-Google-Smtp-Source: ABdhPJzfWjhkADivs1SQebejvBH52/pwibrsIQjsnsRm4yKQhbU9BtLVuneCNQDNDAsP8r99iUY+4Q==
X-Received: by 2002:a05:600c:4f90:b0:350:d962:8944 with SMTP id n16-20020a05600c4f9000b00350d9628944mr13172857wmq.48.1645340091269;
        Sat, 19 Feb 2022 22:54:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ay38sm10871679wmb.3.2022.02.19.22.54.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Feb 2022 22:54:50 -0800 (PST)
Message-Id: <3c2ca198cec4986cf2d7651d854eef5542e7084d.1645340082.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
References: <pull.1122.v4.git.1644698093.gitgitgadget@gmail.com>
        <pull.1122.v5.git.1645340082.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 20 Feb 2022 06:54:39 +0000
Subject: [PATCH v5 09/12] merge-tree: provide easy access to `ls-files -u`
 style info
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

Much like `git merge` updates the index with information of the form
    (mode, oid, stage, name)
provide this output for conflicted files for merge-tree as well.
Provide a --name-only option for users to exclude the mode, oid, and
stage and only get the list of conflicted filenames.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 32 ++++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-write-tree.sh | 26 ++++++++++++++++++++++++--
 3 files changed, 60 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index deaeb49ae05..67a135e8f5d 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -50,6 +50,13 @@ discuss the first form.
 OPTIONS
 -------
 
+--name-only::
+	In the Conflicted file info section, instead of writing a list
+	of (mode, oid, stage, path) tuples to output for conflicted
+	files, just provide a list of filenames with conflicts (and
+	do not list filenames multiple times if they have multiple
+	conflicting stages).
+
 --[no-]messages::
 	Write any informational messages such as "Auto-merging <path>"
 	or CONFLICT notices to the end of stdout.  If unspecified, the
@@ -67,7 +74,7 @@ simply one line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -79,18 +86,23 @@ This is a tree object that represents what would be checked out in the
 working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
-Conflicted file list
+Conflicted file info
 ~~~~~~~~~~~~~~~~~~~~
 
-This is a sequence of lines containing a filename on each line, quoted
-as explained for the configuration variable `core.quotePath` (see
-linkgit:git-config[1]).
+This is a sequence of lines with the format
+
+	<mode> <object> <stage> <filename>
+
+The filename will be quoted as explained for the configuration
+variable `core.quotePath` (see linkgit:git-config[1]).  However, if
+the `--name-only` option is passed, the mode, object, and stage will
+be omitted.
 
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
 This always starts with a blank line to separate it from the previous
-section, and then has free-form messages about the merge, such as:
+sections, and then has free-form messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
@@ -120,6 +132,14 @@ Thus, it could be used as a part of a series of steps such as
 Note that when the exit status is non-zero, NEWTREE in this sequence
 will contain a lot more output than just a tree.
 
+git-merge-tree was written to provide users with the same information
+that they'd have access to if using `git merge`:
+  * what would be written to the working tree (the <OID of toplevel tree>)
+  * the higher order stages that would be written to the index (the
+    <Conflicted file info>)
+  * any messages that would have been printed to stdout (the <Informational
+    messages>)
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index cb4169d2271..1d4d6637b90 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -400,6 +400,7 @@ enum mode {
 struct merge_tree_options {
 	int mode;
 	int show_messages;
+	int name_only;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -456,7 +457,11 @@ static int real_merge(struct merge_tree_options *o,
 		merge_get_conflicted_files(&result, &conflicted_files);
 		for (i = 0; i < conflicted_files.nr; i++) {
 			const char *name = conflicted_files.items[i].string;
-			if (last && !strcmp(last, name))
+			struct stage_info *c = conflicted_files.items[i].util;
+			if (!o->name_only)
+				printf("%06o %s %d\t",
+				       c->mode, oid_to_hex(&c->oid), c->stage);
+			else if (last && !strcmp(last, name))
 				continue;
 			write_name_quoted_relative(
 				name, prefix, stdout, line_termination);
@@ -491,6 +496,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			    N_("do a trivial merge only"), MODE_TRIVIAL),
 		OPT_BOOL(0, "messages", &o.show_messages,
 			 N_("also show informational/conflict messages")),
+		OPT_BOOL_F(0, "name-only",
+			   &o.name_only,
+			   N_("list filenames without modes/oids/stages"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 8e6dba44288..0ec5f0d3f7e 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -65,6 +65,7 @@ test_expect_success 'Content merge and a few conflicts' '
 	expected_tree=$(git rev-parse AUTO_MERGE) &&
 
 	# We will redo the merge, while we are still in a conflicted state!
+	git ls-files -u >conflicted-file-info &&
 	test_when_finished "git reset --hard" &&
 
 	test_expect_code 1 git merge-tree --write-tree side1 side2 >RESULT &&
@@ -108,7 +109,7 @@ anonymize_hash() {
 }
 
 test_expect_success 'test conflict notices and such' '
-	test_expect_code 1 git merge-tree --write-tree side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --name-only side1 side2 >out &&
 	anonymize_hash out >actual &&
 
 	# Expected results:
@@ -143,7 +144,7 @@ do
 done
 
 test_expect_success 'Just the conflicted files without the messages' '
-	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	test_expect_code 1 git merge-tree --write-tree --no-messages --name-only side1 side2 >out &&
 	anonymize_hash out >actual &&
 
 	test_write_lines HASH greeting whatever~side1 >expect &&
@@ -151,4 +152,25 @@ test_expect_success 'Just the conflicted files without the messages' '
 	test_cmp expect actual
 '
 
+test_expect_success 'Check conflicted oids and modes without messages' '
+	test_expect_code 1 git merge-tree --write-tree --no-messages side1 side2 >out &&
+	anonymize_hash out >actual &&
+
+	# Compare the basic output format
+	q_to_tab >expect <<-\EOF &&
+	HASH
+	100644 HASH 1Qgreeting
+	100644 HASH 2Qgreeting
+	100644 HASH 3Qgreeting
+	100644 HASH 1Qwhatever~side1
+	100644 HASH 2Qwhatever~side1
+	EOF
+
+	test_cmp expect actual &&
+
+	# Check the actual hashes against the `ls-files -u` output too
+	tail -n +2 out | sed -e s/side1/HEAD/ >actual &&
+	test_cmp conflicted-file-info actual
+'
+
 test_done
-- 
gitgitgadget

