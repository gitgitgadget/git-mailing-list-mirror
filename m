Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2BBEECAAD8
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 06:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiHaGWB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 02:22:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230135AbiHaGV4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 02:21:56 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF0A57F0A2
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m16so16832209wru.9
        for <git@vger.kernel.org>; Tue, 30 Aug 2022 23:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=dso/EkPu7BV76tVN9V5okbMakWUf48L2CSkTxwVCr8g=;
        b=VMqDCa2fdl+0A1ucybl6ajIK4xsMZeKiK0b6loUajI4cZSEfeFUPw9QJQlrlwOcDW1
         DCUE07pp8Wm2vAV17i0a5gC7G6JlucDWM1POAMNBPl/Z/tCgLJsE2ZD0Z1qucUzxlum0
         +Q0HB4ub8L1OU+J1VqueNoZTt3MFmwlkISLqzjrol7DGUvZIjEzbbvA7xSYOj4ihz93v
         F0GUxZwyyGQa/a7kQdyInCHUdGhljG+x+zwdaV0FsLJt8t7B7AotnojvG9QBQI8oqKIz
         HXnRBngNf0CkjmSm7bb/jhIMH423ND0jWQGybk4BQssMwoqV0VDbcoMfUA4ozCxYOIq+
         h2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=dso/EkPu7BV76tVN9V5okbMakWUf48L2CSkTxwVCr8g=;
        b=2unuvEvZPUivmHBzGPeqCJXfZnjD0ShN1L60+XM9NXbM3tAyKDTJyn5V9K7UVV3lWM
         FQ7bAz6J/qryj2nzIZKg8OsNObL5DZuOjlwE+abKnmD191XnSYd9f2vjhfim4CfhJEUH
         mOJLi0o5SnRBzdOIjvEDgn6zbt3qMQjDJS6eSObIcIrOd4Fak4AH/ZBrlYRpJTyaQ4fE
         7kmlPFEIQlJaKTCyB+mTlaPwpI2zzustBGYr5WBYdBTxPlwKNDe6JbLmenyVrBcVult1
         PZK0T6vpbHDqk0xmJ6Boh4R2q/Tzq8Xqsig72F2faKEWTcXPhbyvfRU+mVNPY35PKzTc
         8J2w==
X-Gm-Message-State: ACgBeo0uDxtIoWF1T7hKUP9rygwoCsxzkndqALDRXK7FR578NcBg3nei
        oA6Nwe05BWq+sUQwbOCuajTSZ+fRrIo=
X-Google-Smtp-Source: AA6agR6TLLWBeiMQP8WQj1LxXDU/zKEp7K1spPDZd4YTfg+j9WGWRth950taj3Tcngx1m0XwMorPug==
X-Received: by 2002:adf:fc08:0:b0:21e:d133:3500 with SMTP id i8-20020adffc08000000b0021ed1333500mr11408999wrr.353.1661926913242;
        Tue, 30 Aug 2022 23:21:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id cc18-20020a5d5c12000000b002253604bbefsm5895395wrb.75.2022.08.30.23.21.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 23:21:52 -0700 (PDT)
Message-Id: <feac97494600e522125b7bb202f4dc5ca020ca99.1661926908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
References: <pull.1342.git.1661926908.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 31 Aug 2022 06:21:47 +0000
Subject: [PATCH 2/3] diff: fix filtering of additional headers under
 --remerge-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Commit 95433eeed9 ("diff: add ability to insert additional headers for
paths", 2022-02-02) introduced the possibility of additional headers.
Because there could be conflicts with no content differences (e.g. a
modify/delete conflict resolved in favor of taking the modified file
as-is), that commit also modified the diff_queue_is_empty() and
diff_flush_patch() logic to ensure these headers were included even if
there was no associated content diff.

However, when the pickaxe is active, we really only want the remerge
conflict headers to be shown when there is an associated content diff.
Adjust the logic in these two functions accordingly.

This also removes the TEST_PASSES_SANITIZE_LEAK=true declaration from
t4069, as there is apparently some kind of memory leak with the pickaxe
code.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 diff.c                  |  2 ++
 t/t4069-remerge-diff.sh | 17 ++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/diff.c b/diff.c
index be23f660570..9535e755c73 100644
--- a/diff.c
+++ b/diff.c
@@ -5854,6 +5854,7 @@ static void diff_flush_patch(struct diff_filepair *p, struct diff_options *o)
 {
 	int include_conflict_headers =
 	    (additional_headers(o, p->one->path) &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	/*
@@ -5909,6 +5910,7 @@ int diff_queue_is_empty(struct diff_options *o)
 	int i;
 	int include_conflict_headers =
 	    (o->additional_path_headers &&
+	     !o->pickaxe_opts &&
 	     (!o->filter || filter_bit_tst(DIFF_STATUS_UNMERGED, o)));
 
 	if (include_conflict_headers)
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index e3e6fbd97b2..95a16d19aec 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,7 +2,6 @@
 
 test_description='remerge-diff handling'
 
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
@@ -90,6 +89,22 @@ test_expect_success 'remerge-diff with both a resolved conflict and an unrelated
 	test_cmp expect actual
 '
 
+test_expect_success 'pickaxe still includes additional headers for relevant changes' '
+	# reuses "expect" from the previous testcase
+
+	git log --oneline --remerge-diff -Sacht ab_resolution >tmp &&
+	sed -e "s/[0-9a-f]\{7,\}/HASH/g" tmp >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'can filter out additional headers with pickaxe' '
+	git show --remerge-diff --submodule=log --find-object=HEAD ab_resolution >actual &&
+	test_must_be_empty actual &&
+
+	git show --remerge-diff -S"not present" --all >actual &&
+	test_must_be_empty actual
+'
+
 test_expect_success 'setup non-content conflicts' '
 	git switch --orphan base &&
 
-- 
gitgitgadget

