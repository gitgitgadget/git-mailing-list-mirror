Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3938DC433FE
	for <git@archiver.kernel.org>; Sun, 23 Oct 2022 01:28:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbiJWB2N (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 22 Oct 2022 21:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229976AbiJWB2M (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 22 Oct 2022 21:28:12 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63C429341
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:10 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id j7so10465703wrr.3
        for <git@vger.kernel.org>; Sat, 22 Oct 2022 18:28:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Tcz3Cmp3ArdC4uhphCrEpNsetNVr3qHIUTVX81UPqyE=;
        b=MuFJzECk5nFIgHH9ETDZEKFEPCtz69RnK9Uo9BXpX8JVmcNzIQTape/G00fWPOvPs7
         R4kNZx7ozoD1j4Rqj6z+/ZWkCE+k/Ffp+kj07uMZ9/RLsSnseYyBEj7ZfuaNYfMD/EB2
         L42bCFMZJPRbzYKgrsNAD4KFSNp03m7vJ1LqRjVU8y0qvQeSxRWVQ6IuNikGkGoEiUkF
         nILbe+uQk57fZ+QNXf2jEeQAKx3n/8d26hefTPcjBGbFK1GgpcsxfqJ9seES7Bk5emoD
         +e8hqT4GHoZMp5wIs2h+my6A/Cc0ROAjIlid6toMD3bKXRK/nDHreX5XixLHiSZmf7DB
         +H4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tcz3Cmp3ArdC4uhphCrEpNsetNVr3qHIUTVX81UPqyE=;
        b=l8CgRO9Mty9j+uUbxgjs3QnXRbw8nVQA9gw5BKwTy2FYIgtoqsbKYhPgmmTCYObOsq
         lIi35eM8mDuoEHXBb8nVKNSy2oY0RRhlinAxi2j91zYbHFWOH3rUjr1Sjjdzwj7ttsV+
         0oNFO+MeY4mYMtpytm4zsywCCBMRf4TzacFbYNJHYjpFtzXs/l4m/OOpOW+JMbdGcXig
         3DWXkb/g2RkvuYnA2roCWUbKQviiVFBlrfq5AmNHdR/jNN2Bexw6jWzhMAioNFnr402E
         QiR0LG2Ng/cqgZEPF7CC9EJIUvFOyPwH5v7JK9q895S7KKf5YYfjSm+Q2kxBPwtXTk8Y
         CHBA==
X-Gm-Message-State: ACrzQf1eTABcZq7eV5NTv0yr4eR9pA0+DYLNs90f0pXtwtvuCSQ4xMWq
        17LpWnV8jouXaVQWKGS/iqN/r/Kbc6k=
X-Google-Smtp-Source: AMsMyM78nEfLVvkbSBQ45nyIPJ1VGFzbGiw1XotEUr3nnT12K94uVVFCSm57seqSx8ebpm4/WDwQlA==
X-Received: by 2002:a05:6000:18ac:b0:232:c7c1:314f with SMTP id b12-20020a05600018ac00b00232c7c1314fmr15846518wri.109.1666488489011;
        Sat, 22 Oct 2022 18:28:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id iv13-20020a05600c548d00b003b4fdbb6319sm4227472wmb.21.2022.10.22.18.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Oct 2022 18:28:08 -0700 (PDT)
Message-Id: <60421a477f39dcf6ede7d87444b0c2378fe1dc6c.1666488485.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1361.git.1666488485.gitgitgadget@gmail.com>
References: <pull.1361.git.1666488485.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 23 Oct 2022 01:28:05 +0000
Subject: [PATCH 2/2] merge-tree: support multiple batched merges with --stdin
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Add an option, --stdin, to merge-tree which will accept lines of input
with two branches to merge per line, and which will perform all the
merges and give output for each in turn.  This option implies -z, and
modifies the output to also include a merge status since the exit code
of the program can no longer convey that information now that multiple
merges are involved.

This could be useful, for example, by Git hosting providers.  When one
branch is updated, one may want to check whether all code reviews
targetting that branch can still cleanly merge.  Avoiding the overhead
of starting up a separate process for each of those code reviews might
provide significant savings in a repository with many code reviews.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 Documentation/git-merge-tree.txt | 30 ++++++++++++++++++++++-
 builtin/merge-tree.c             | 42 +++++++++++++++++++++++++++++---
 t/t4301-merge-tree-write-tree.sh | 41 +++++++++++++++++++++++++++++++
 3 files changed, 109 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-merge-tree.txt b/Documentation/git-merge-tree.txt
index 9914b1bc0cd..04bcc416e6e 100644
--- a/Documentation/git-merge-tree.txt
+++ b/Documentation/git-merge-tree.txt
@@ -81,6 +81,31 @@ Whereas for a conflicted merge, the output is by default of the form:
 
 These are discussed individually below.
 
+However, there is an exception.  If `--stdin` is passed, then there is
+an extra section at the beginning, a NUL character at the end, and then
+all the sections repeat for each line of input.  Thus, if the first merge
+is conflicted and the second is clean, the output would be of the form:
+
+	<Merge status>
+	<OID of toplevel tree>
+	<Conflicted file info>
+	<Informational messages>
+	NUL
+	<Merge status>
+	<OID of toplevel tree>
+	NUL
+
+[[MS]]
+Merge status
+~~~~~~~~~~~~
+
+This is an integer status followed by a NUL character.  The integer status is:
+
+     0: merge had conflicts
+     1: merge was clean
+     &lt;0: something prevented the merge from running (e.g. access to repository
+	 objects denied by filesystem)
+
 [[OIDTLT]]
 OID of toplevel tree
 ~~~~~~~~~~~~~~~~~~~~
@@ -159,7 +184,10 @@ EXIT STATUS
 For a successful, non-conflicted merge, the exit status is 0.  When the
 merge has conflicts, the exit status is 1.  If the merge is not able to
 complete (or start) due to some kind of error, the exit status is
-something other than 0 or 1 (and the output is unspecified).
+something other than 0 or 1 (and the output is unspecified).  When
+--stdin is passed, the return status is 0 for both successful and
+conflicted merges, and something other than 0 or 1 if it cannot complete
+all the requested merges.
 
 USAGE NOTES
 -----------
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index ae5782917b9..fe853aa8f91 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -402,6 +402,7 @@ struct merge_tree_options {
 	int allow_unrelated_histories;
 	int show_messages;
 	int name_only;
+	int use_stdin;
 };
 
 static int real_merge(struct merge_tree_options *o,
@@ -412,6 +413,7 @@ static int real_merge(struct merge_tree_options *o,
 	struct commit_list *merge_bases = NULL;
 	struct merge_options opt;
 	struct merge_result result = { 0 };
+	int show_messages = o->show_messages;
 
 	parent1 = get_merge_parent(branch1);
 	if (!parent1)
@@ -443,9 +445,11 @@ static int real_merge(struct merge_tree_options *o,
 	if (result.clean < 0)
 		die(_("failure to merge"));
 
-	if (o->show_messages == -1)
-		o->show_messages = !result.clean;
+	if (show_messages == -1)
+		show_messages = !result.clean;
 
+	if (o->use_stdin)
+		printf("%d%c", result.clean, line_termination);
 	printf("%s%c", oid_to_hex(&result.tree->object.oid), line_termination);
 	if (!result.clean) {
 		struct string_list conflicted_files = STRING_LIST_INIT_NODUP;
@@ -467,11 +471,13 @@ static int real_merge(struct merge_tree_options *o,
 		}
 		string_list_clear(&conflicted_files, 1);
 	}
-	if (o->show_messages) {
+	if (show_messages) {
 		putchar(line_termination);
 		merge_display_update_messages(&opt, line_termination == '\0',
 					      &result);
 	}
+	if (o->use_stdin)
+		putchar(line_termination);
 	merge_finalize(&opt, &result);
 	return !result.clean; /* result.clean < 0 handled above */
 }
@@ -505,6 +511,10 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 			   &o.allow_unrelated_histories,
 			   N_("allow merging unrelated histories"),
 			   PARSE_OPT_NONEG),
+		OPT_BOOL_F(0, "stdin",
+			   &o.use_stdin,
+			   N_("perform multiple merges, one per line of input"),
+			   PARSE_OPT_NONEG),
 		OPT_END()
 	};
 
@@ -512,6 +522,32 @@ int cmd_merge_tree(int argc, const char **argv, const char *prefix)
 	original_argc = argc - 1; /* ignoring argv[0] */
 	argc = parse_options(argc, argv, prefix, mt_options,
 			     merge_tree_usage, PARSE_OPT_STOP_AT_NON_OPTION);
+
+	/* Handle --stdin */
+	if (o.use_stdin) {
+		struct strbuf buf = STRBUF_INIT;
+
+		if (o.mode == MODE_TRIVIAL)
+			die(_("--trivial-merge is incompatible with all other options"));
+		line_termination = '\0';
+		while (strbuf_getline_lf(&buf, stdin) != EOF) {
+			struct strbuf **split;
+			int result;
+
+			split = strbuf_split(&buf, ' ');
+			if (!split[0] || !split[1] || split[2])
+				die(_("malformed input line: '%s'."), buf.buf);
+			strbuf_rtrim(split[0]);
+			result = real_merge(&o, split[0]->buf, split[1]->buf, prefix);
+			if (result < 0)
+				die(_("merging cannot continue; got unclean result of %d"), result);
+			strbuf_list_free(split);
+		}
+		strbuf_release(&buf);
+		return 0;
+	}
+
+	/* Figure out which mode to use */
 	switch (o.mode) {
 	default:
 		BUG("unexpected command mode %d", o.mode);
diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 013b77144bd..cac85591b52 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -819,4 +819,45 @@ test_expect_success SANITY 'merge-ort fails gracefully in a read-only repository
 	test_must_fail git -C read-only merge-tree side1 side2
 '
 
+test_expect_success '--stdin with both a successful and a conflicted merge' '
+	printf "side1 side3\nside1 side2" | git merge-tree --stdin >actual &&
+
+	git checkout side1^0 &&
+	git merge side3 &&
+
+	printf "1\0" >expect &&
+	git rev-parse HEAD^{tree} | lf_to_nul >>expect &&
+	printf "\0" >>expect &&
+
+	git checkout side1^0 &&
+	test_must_fail git merge side2 &&
+	sed s/HEAD/side1/ greeting >tmp &&
+	mv tmp greeting &&
+	git add -u &&
+	git mv whatever~HEAD whatever~side1 &&
+
+	printf "0\0" >>expect &&
+	git write-tree | lf_to_nul >>expect &&
+
+	cat <<-EOF | q_to_tab | lf_to_nul >>expect &&
+	100644 $(git rev-parse side1~1:greeting) 1Qgreeting
+	100644 $(git rev-parse side1:greeting) 2Qgreeting
+	100644 $(git rev-parse side2:greeting) 3Qgreeting
+	100644 $(git rev-parse side1~1:whatever) 1Qwhatever~side1
+	100644 $(git rev-parse side1:whatever) 2Qwhatever~side1
+	EOF
+
+	q_to_nul <<-EOF >>expect &&
+	Q1QgreetingQAuto-mergingQAuto-merging greeting
+	Q1QgreetingQCONFLICT (contents)QCONFLICT (content): Merge conflict in greeting
+	Q1QnumbersQAuto-mergingQAuto-merging numbers
+	Q2Qwhatever~side1QwhateverQCONFLICT (file/directory)QCONFLICT (file/directory): directory in the way of whatever from side1; moving it to whatever~side1 instead.
+	Q1Qwhatever~side1QCONFLICT (modify/delete)QCONFLICT (modify/delete): whatever~side1 deleted in side2 and modified in side1.  Version side1 of whatever~side1 left in tree.
+	EOF
+
+	printf "\0\0" >>expect &&
+
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
