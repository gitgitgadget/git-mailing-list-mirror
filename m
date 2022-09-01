Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25DFCECAAD2
	for <git@archiver.kernel.org>; Thu,  1 Sep 2022 07:09:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233366AbiIAHJR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 03:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233784AbiIAHIw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 03:08:52 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62F35123C19
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 00:08:13 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id ay39-20020a05600c1e2700b003a5503a80cfso853771wmb.2
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 00:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=YsSpKV12dBqc0+C/BVsHCBZP2FhOXS9OlkzNys7p+98=;
        b=jl2SbsGH6ddx6A6Nas02TVaMy+Nq4ottCe8W00B/mnnRkAb9LMmU2cOfX0Xl06mY7F
         ALMtvQ/QVekZkjyPhQlRSI4st1YbW+qL1i3Hpa01TTrGTtAG75u5Qc6I/+2a1laBqMEM
         XfxzbtV0UXPEB/PdYgsjpUt20/bVJGdtmqJRYhScxKnweQy1GhK84wYZXAKEkutNAWRk
         20j3uXviGKCBrmyJcO9SbbSYfFSsuOcMicRxDXIcAwaejCFuXJzXVndFEu8uttn+26gl
         2onuusXbtMoNA1EUr7q9Kp0UCWQMw5Tplez3gHm225kWCximyc+qFwbWftbjBT24FOTA
         a3yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=YsSpKV12dBqc0+C/BVsHCBZP2FhOXS9OlkzNys7p+98=;
        b=wlkf5iD/T0aMY5qtqkhYEknq8ot+foOO8YAje5Q7mWC0Gq79mi1hxlYB2a2cAUqDdb
         40e7mvJUOhE6E6D0ei7SgRQM+nI0vQDuu229NTkl1WS7ihkos4kt+2MkySnoAvcRNn6T
         EX4cJIHonIjKzor3IFvjDxQeR2OYwblUE3wIS+n/FeISbML6wDijbigg9wDsL6zFC9Vs
         4hZV/QPIyn6jFzhu9OhEY9y0JgVzBEoFXuV1IeSLyDBHXKNRfTZgxmkUvPDK/Oa/wkaP
         MFfbpPZ+wSNxEjGXq+42GYRuir6hwTsFgsv4XEDptHnK/dQdVgiVGmeRJibkcf+StDnM
         tuvg==
X-Gm-Message-State: ACgBeo3vgg4yu0wrvNLZMmqJPFWVBotTwyyWrRa4L4CUKvhr5V52KvMP
        216XCd0uqpsJdGo6Jwd2qUhMUQ/bFIU=
X-Google-Smtp-Source: AA6agR7J1D6B4hKsl7Bl7u/hFHjxv6edy4hbrlGYAHsx2f2JubjB/Z/+4IwRcR2GC3w+vfiqiUi1+A==
X-Received: by 2002:a05:600c:1906:b0:3a5:f9e0:fcb6 with SMTP id j6-20020a05600c190600b003a5f9e0fcb6mr4327353wmq.157.1662016091515;
        Thu, 01 Sep 2022 00:08:11 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p22-20020a05600c359600b003a604a29a34sm5783548wmq.35.2022.09.01.00.08.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 00:08:10 -0700 (PDT)
Message-Id: <aea0bbc1c6a33d62f6b3313d56664d53df8f620a.1662016087.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
        <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 01 Sep 2022 07:08:05 +0000
Subject: [PATCH v2 1/3] diff: have submodule_format logic avoid additional
 diff headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers,
created in create_filepairs_for_header_only_notifications().  These are
represented by inserting additional pairs in diff_queued_diff which
always have a mode of 0 and a null_oid.  When these were added, one
code path was noted to assume that at least one of the diff_filespecs
in the pair were valid, and that codepath was corrected.

The submodule_format handling is another codepath with the same issue;
it would operate on these additional headers and attempt to display them
as submodule changes.  Prevent that by explicitly checking for both
modes being 0.

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 14 +++++++++++---
 t/t4069-remerge-diff.sh |  8 ++++++++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a6211..d672efed7ab 100644
--- a/diff.c
+++ b/diff.c
@@ -3398,6 +3398,12 @@ static void add_formatted_headers(struct strbuf *msg,
 				     line_prefix, meta, reset);
 }
 
+static int diff_filepair_is_phoney(struct diff_filespec *one,
+				   struct diff_filespec *two)
+{
+	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3429,14 +3435,16 @@ static void builtin_diff(const char *name_a,
 
 	if (o->submodule_format == DIFF_SUBMODULE_LOG &&
 	    (!one->mode || S_ISGITLINK(one->mode)) &&
-	    (!two->mode || S_ISGITLINK(two->mode))) {
+	    (!two->mode || S_ISGITLINK(two->mode)) &&
+	    (!diff_filepair_is_phoney(one, two))) {
 		show_submodule_diff_summary(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
 		return;
 	} else if (o->submodule_format == DIFF_SUBMODULE_INLINE_DIFF &&
 		   (!one->mode || S_ISGITLINK(one->mode)) &&
-		   (!two->mode || S_ISGITLINK(two->mode))) {
+		   (!two->mode || S_ISGITLINK(two->mode)) &&
+		   (!diff_filepair_is_phoney(one, two))) {
 		show_submodule_inline_diff(o, one->path ? one->path : two->path,
 				&one->oid, &two->oid,
 				two->dirty_submodule);
@@ -3456,7 +3464,7 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
+	if (diff_filepair_is_phoney(one, two)) {
 		/*
 		 * We should only reach this point for pairs from
 		 * create_filepairs_for_header_only_notifications().  For
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 9e7cac68b1c..e3e6fbd97b2 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -185,6 +185,14 @@ test_expect_success 'remerge-diff w/ diff-filter=U: all conflict headers, no dif
 	test_cmp expect actual
 '
 
+test_expect_success 'submodule formatting ignores additional headers' '
+	# Reuses "expect" from last testcase
+
+	git show --oneline --remerge-diff --diff-filter=U --submodule=log >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'remerge-diff w/ diff-filter=R: relevant file + conflict header' '
 	git log -1 --oneline resolution >tmp &&
 	cat <<-EOF >>tmp &&
-- 
gitgitgadget

