Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD9EFC6FA81
	for <git@archiver.kernel.org>; Fri,  2 Sep 2022 03:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235436AbiIBDxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Sep 2022 23:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235431AbiIBDxf (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Sep 2022 23:53:35 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F250B56C5
        for <git@vger.kernel.org>; Thu,  1 Sep 2022 20:53:34 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id n17-20020a05600c501100b003a84bf9b68bso642203wmr.3
        for <git@vger.kernel.org>; Thu, 01 Sep 2022 20:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=2x1cN/QUO0/83LkCFeNbesqr9VTXr52eUL3BvoBMMSU=;
        b=QyLSACcTUDHeBEtAyPg2wGQ73pKez+rt7DORrjRU5FBA3NgFY2SNsUF+C/jmpk9LrF
         a6/zzfz5jvcvvfAvQuBFznpsjYSedcVGL3ARAvfj+4+GTqY3wtMsEu9MD3tAXcSKNRjC
         lnI073GV8noL0CrXSPc0E01IWtSwFMuC3SN1+wNS/SiMUovanA7w8Ccg5wATG3YNMpKc
         HOWkjwm773PiOgZ6Zgyu35+/3zyHcJpzUtJ4mw1Bz+TwM6J1IFvoC8alUG2tzjS62+8J
         xjtB+HiIFmXp1CtIuJaJ9VjleLdMlr1AVU/q/uIBnCxCr+Cq8nI6fHTba7xOkdnk3M0g
         AfdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=2x1cN/QUO0/83LkCFeNbesqr9VTXr52eUL3BvoBMMSU=;
        b=R6+ThBaWlIEO2Pyeccunt+XbPmaayOvW1EJM4hPerXa8Br6CLJhDWi1SOhKz3lStzu
         lOwt7G2n0O7E1ijjLjwMdBUQ3s6IyiO6aP7CWHyHBxF4MVCrjPEU3/FGA99bNKddroo5
         4HrCVuhlKOCcWlqQ9Lej+Lved/PIkcYl2WxTdo0o3/wzRaHQ2ATv41oBWIkq2vwC/gH1
         syZikNYo/Ck2CUZNmRn7HOn9D4AuvhwibwDNzRrIHDhqFieX3WOmyL8SCQsr72CckLHy
         fEiiBNy/NDTlg4vrIdR4D+S5Pm2q7bsnP+J3OOfZKmJnT5BD86/M3EzWyTPyqQ8gKVK5
         MDcg==
X-Gm-Message-State: ACgBeo352nuM07ZpeuXjylJtNz6o3Mw5VFxUQEG+WyNnuZ3SFKO6KQVq
        1NR8CgQgnXCLT9Yqgpes1Mm75z8t51M=
X-Google-Smtp-Source: AA6agR5UkIWnvH4TaXrA349WVtH6A7pTloRIFjTzGNwoDYdE6237VCxtQnlQFWYoHKI1oWonYhfntw==
X-Received: by 2002:a05:600c:512a:b0:3a8:42e4:dfe7 with SMTP id o42-20020a05600c512a00b003a842e4dfe7mr1272260wms.193.1662090812476;
        Thu, 01 Sep 2022 20:53:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o24-20020a1c7518000000b003a83ca67f73sm867530wmc.3.2022.09.01.20.53.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 20:53:31 -0700 (PDT)
Message-Id: <ed28acaed973238b314d1ffc8d56ce61efbb5376.1662090810.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
References: <pull.1342.v2.git.1662016087.gitgitgadget@gmail.com>
        <pull.1342.v3.git.1662090810.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 02 Sep 2022 03:53:28 +0000
Subject: [PATCH v3 1/3] diff: have submodule_format logic avoid additional
 diff headers
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
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
as submodule changes.  Prevent that by explicitly checking for "phoney"
filepairs (i.e. filepairs with both modes being 0).

Reported-by: Philippe Blain <levraiphilippeblain@gmail.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  | 29 +++++++++++++++++++++++------
 t/t4069-remerge-diff.sh |  8 ++++++++
 2 files changed, 31 insertions(+), 6 deletions(-)

diff --git a/diff.c b/diff.c
index 974626a6211..7f8637f3006 100644
--- a/diff.c
+++ b/diff.c
@@ -3398,6 +3398,21 @@ static void add_formatted_headers(struct strbuf *msg,
 				     line_prefix, meta, reset);
 }
 
+static int diff_filepair_is_phoney(struct diff_filespec *one,
+				   struct diff_filespec *two)
+{
+	/*
+	 * This function specifically looks for pairs injected by
+	 * create_filepairs_for_header_only_notifications().  Such
+	 * pairs are "phoney" in that they do not represent any
+	 * content or even mode difference, but were inserted because
+	 * diff_queued_diff previously had no pair associated with
+	 * that path but we needed some pair to avoid losing the
+	 * "remerge CONFLICT" header associated with the path.
+	 */
+	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -3429,14 +3444,16 @@ static void builtin_diff(const char *name_a,
 
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
@@ -3456,12 +3473,12 @@ static void builtin_diff(const char *name_a,
 	b_two = quote_two(b_prefix, name_b + (*name_b == '/'));
 	lbl[0] = DIFF_FILE_VALID(one) ? a_one : "/dev/null";
 	lbl[1] = DIFF_FILE_VALID(two) ? b_two : "/dev/null";
-	if (!DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two)) {
+	if (diff_filepair_is_phoney(one, two)) {
 		/*
-		 * We should only reach this point for pairs from
+		 * We should only reach this point for pairs generated from
 		 * create_filepairs_for_header_only_notifications().  For
-		 * these, we should avoid the "/dev/null" special casing
-		 * above, meaning we avoid showing such pairs as either
+		 * these, we want to avoid the "/dev/null" special casing
+		 * above, because we do not want such pairs shown as either
 		 * "new file" or "deleted file" below.
 		 */
 		lbl[0] = a_one;
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

