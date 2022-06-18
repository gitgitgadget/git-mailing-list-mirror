Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53FE2C43334
	for <git@archiver.kernel.org>; Sat, 18 Jun 2022 00:21:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383829AbiFRAVz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Jun 2022 20:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383656AbiFRAV2 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Jun 2022 20:21:28 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CFFE5C86C
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:17 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id a15so7532866wrh.2
        for <git@vger.kernel.org>; Fri, 17 Jun 2022 17:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NJvLjppATFP/LedW1KcY658sTKcAI5mB9yKUInFronM=;
        b=OqPpeArzTLj+WA2kQQhmsiKtyDg8s81YBUTWpQKRLV5ebd7Sryc7NSc9CHelrAsUsk
         ipKA/Rm4KAAY1wHn0nPCsz9F/dqFMflwwg8ktlPnUZo6XPfrjkMW1Iiq4ZaIfEAF+OzH
         YpwBupBrxoj+NaYtUK8b1unE67MZ+anGiQbzm8DReom7f+i8s13Q2OMZEQHjsYuotSjP
         Vs3znc3tW0PTIibhK+3K5yGbVuFSAiONgZ2QUY2IR5NDsMp79ZxgKo609gEGEOh28RQJ
         zi1YvLI4e8xgucds4ql4fs75hifqLrtj7EQRmSoLIh1rWbN8I/9NAnvQTOmyXOJHJw34
         MkHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NJvLjppATFP/LedW1KcY658sTKcAI5mB9yKUInFronM=;
        b=AznZH2Vp8qxH2LCv2JGKCzp2S9j5X4d2QgvNaCQE23XJz+9xrX+ij1/tTyUa/MxfSS
         2QzWYMyCZAnegE373Sg83/900n8krnAK+w9rEhlp5DCd/5X0PPyp5FZIMCZYcmZaNSzA
         ednF0DjEtF714VyEJIwlA6rrzkduDyrKAcIOQhY+l2cdOI6GOV4QBGmuJB9QBBfOp1O+
         PY7b9JmUW+di/iaywS+y8xOOaE5ZCYVAlpLGuMpPBS06XoiKqLsBK3ESUVj88Npgk+1m
         346Aj5rH7qwTNOHVHpiLGy9TcJjVw56xJPfo25uu4SNUMCbPdKCwdTjjKHWlAjTqp/UT
         d/Pg==
X-Gm-Message-State: AJIora85/35QV+MDjeFsBL5h3IwYfqAA/wKHH4HTKj4vqRkYAz2Z3LcD
        OXwtpqc+1VYilyQQZYfF2m8wE3RSXy8XyA==
X-Google-Smtp-Source: AGRyM1vCUHsx97ZGSHpk4cOCj0m/nTMMSzs18E6+W+6r07zUy/lSYeqDK+LHCZX2EtPOCcwbtG2KRQ==
X-Received: by 2002:a5d:4310:0:b0:21a:26a5:69b with SMTP id h16-20020a5d4310000000b0021a26a5069bmr11541123wrq.269.1655511675149;
        Fri, 17 Jun 2022 17:21:15 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v188-20020a1cacc5000000b003973c54bd69sm10462866wme.1.2022.06.17.17.21.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jun 2022 17:21:14 -0700 (PDT)
Message-Id: <d7360f58f166f46bb3fc977e3cd71cdbe23a8473.1655511660.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
References: <pull.1122.v6.git.1645602413.gitgitgadget@gmail.com>
        <pull.1122.v7.git.1655511660.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 18 Jun 2022 00:20:53 +0000
Subject: [PATCH v7 10/17] merge-tree: provide easy access to `ls-files -u`
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
 Documentation/git-merge-tree.txt | 34 ++++++++++++++++++++++++++------
 builtin/merge-tree.c             | 11 ++++++++++-
 t/t4301-merge-tree-write-tree.sh | 26 ++++++++++++++++++++++--
 3 files changed, 62 insertions(+), 9 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 68a51c82618..b89aabdb98e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -40,6 +40,13 @@ After the merge completes, a new toplevel tree object is created.  See
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
@@ -58,7 +65,7 @@ line:
 Whereas for a conflicted merge, the output is by default of the form:
 
 	<OID of toplevel tree>
-	<Conflicted file list>
+	<Conflicted file info>
 	<Informational messages>
 
 These are discussed individually below.
@@ -72,19 +79,24 @@ working tree at the end of `git merge`.  If there were conflicts, then
 files within this tree may have embedded conflict markers.
 
 [[CFI]]
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
 
 [[IM]]
 Informational messages
 ~~~~~~~~~~~~~~~~~~~~~~
 
 This always starts with a blank line to separate it from the previous
-section, and then has free-form messages about the merge, such as:
+sections, and then has free-form messages about the merge, such as:
 
   * "Auto-merging <file>"
   * "CONFLICT (rename/delete): <oldfile> renamed...but deleted in..."
@@ -116,6 +128,16 @@ used as a part of a series of steps such as:
 Note that when the exit status is non-zero, `NEWTREE` in this sequence
 will contain a lot more output than just a tree.
 
+For conflicts, the output includes the same information that you'd get
+with linkgit:git-merge[1]:
+
+  * what would be written to the working tree (the
+    <<OIDTLT,OID of toplevel tree>>)
+  * the higher order stages that would be written to the index (the
+    <<CFI,Conflicted file info>>)
+  * any messages that would have been printed to stdout (the
+    <<IM,Informational messages>>)
+
 [[DEPMERGE]]
 DEPRECATED DESCRIPTION
 ----------------------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 13a9536f7c1..c61b5b4a10d 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -400,6 +400,7 @@ enum mode {
 struct merge_tree_options {
 	int mode;
 	int show_messages;
+	int name_only;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -453,7 +454,11 @@ static int real_merge(struct merge_tree_options *o,
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
@@ -488,6 +493,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
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

