Return-Path: <SRS0=vT7Y=2N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A31C2D0DA
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E507C20643
	for <git@archiver.kernel.org>; Mon, 23 Dec 2019 18:50:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e5aTvvn/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726948AbfLWSuQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Dec 2019 13:50:16 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:38122 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726907AbfLWSuM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Dec 2019 13:50:12 -0500
Received: by mail-ed1-f65.google.com with SMTP id i16so16119244edr.5
        for <git@vger.kernel.org>; Mon, 23 Dec 2019 10:50:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=e5aTvvn/enSi/95489Te5CL9UclTu/GkpvPN8hFVVqy9yr6ngA+mTGxiy/iHOCRGFG
         uWWd3DnACaC0bGmCDxBgs93kBHgmf0Vsm/RirafpOccmYtOMEdVgLdQi7pf3cbcvLzmD
         MXrBfV7s3hDJDY+MK/uneb+zHNKM1tfm5UQNC4l1osbLnpQLGj2RQwKhTUfjldyuaDIW
         85aE/Hru7gU38GM6ZJhLay8oyEn5PSvAG2DkOhoToaOnUEdAjWy0B5GoGIZWLdza5R26
         Jnwn0QHGwxe6Xsqs7L/jGtj15V7sMm9LoChX4kciXN2jH0OnRToh9NXQodcGrCOzkING
         1ZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=DbFCtfxBp2HjlkDe7Mzp2ANRjBMe5UHrXF8XVrYSlDS5tA2eUowbA+GxKQhmfmlBw5
         zsqM2cS1Wu2PMc9kpXw1UlUvcb1e8+gmR86WgURR7qW1U+KjIHgOxcyRT2jCJ9Lp6/AF
         +hS7zqKDFyRECbvUXoZ/Ipyu3wKwtiRgCidmOfbHNH3Jjum3k446pF0zmUedyXaNFSp3
         XvanisD4jGaZHhndV73/S8MAlzdzuNCns9ZcWOE/jWSSAgsc7rWDI8dCCxIS/x65SkJS
         fE59ji/Fszw9QMYN5OxjRkr0cfxbiQQkOAkVrPvm/mFEjbkHsdVoC0N/WONV7re+zisD
         Y3bA==
X-Gm-Message-State: APjAAAURnsjY0nlulg967ft50PcF/1AKqLTrttBl6nKycgzjNsFQUMMA
        dAf/HsAhaUwlVn9Uhwq4/ab8/AaU
X-Google-Smtp-Source: APXvYqz5oWg0F1p1a5lR+ynthFNC6Q2l8FwCgc6FPkIJrMF5ajF5CZ/LLJLTtJXQeRiJFmqo1pvE1A==
X-Received: by 2002:a05:6402:1595:: with SMTP id c21mr34764725edv.32.1577127010497;
        Mon, 23 Dec 2019 10:50:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t25sm2338968edt.60.2019.12.23.10.50.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Dec 2019 10:50:10 -0800 (PST)
Message-Id: <02878813611384791af5f53d06372f0f1b9575e9.1577127000.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
References: <pull.679.git.git.1576861788.gitgitgadget@gmail.com>
        <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Dec 2019 18:49:57 +0000
Subject: [PATCH v2 13/15] rebase tests: repeat some tests using the merge
 backend instead of am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com,
        Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

In order to ensure the merge/interactive backend gets similar coverage
to the am one, add some tests for cases where previously only the am
backend was tested.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t5520-pull.sh                   | 17 +++++++++++++++--
 t/t6047-diff3-conflict-markers.sh | 13 +++++++++++--
 2 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index 602d996a33..3fff6a06fa 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -277,14 +277,27 @@ test_expect_success '--rebase' '
 	test_cmp expect actual
 '
 
-test_expect_success '--rebase fast forward' '
+test_expect_success '--rebase (merge) fast forward' '
 	git reset --hard before-rebase &&
 	git checkout -b ff &&
 	echo another modification >file &&
 	git commit -m third file &&
 
 	git checkout to-rebase &&
-	git pull --rebase . ff &&
+	git -c rebase.backend=merge pull --rebase . ff &&
+	test_cmp_rev HEAD ff &&
+
+	# The above only validates the result.  Did we actually bypass rebase?
+	git reflog -1 >reflog.actual &&
+	sed "s/^[0-9a-f][0-9a-f]*/OBJID/" reflog.actual >reflog.fuzzy &&
+	echo "OBJID HEAD@{0}: pull --rebase . ff: Fast-forward" >reflog.expected &&
+	test_cmp reflog.expected reflog.fuzzy
+'
+
+test_expect_success '--rebase (am) fast forward' '
+	git reset --hard before-rebase &&
+
+	git -c rebase.backend=am pull --rebase . ff &&
 	test_cmp_rev HEAD ff &&
 
 	# The above only validates the result.  Did we actually bypass rebase?
diff --git a/t/t6047-diff3-conflict-markers.sh b/t/t6047-diff3-conflict-markers.sh
index 860542aad0..d383ce8130 100755
--- a/t/t6047-diff3-conflict-markers.sh
+++ b/t/t6047-diff3-conflict-markers.sh
@@ -186,7 +186,7 @@ test_expect_success 'check multiple merge bases' '
 	)
 '
 
-test_expect_success 'rebase describes fake ancestor base' '
+test_expect_success 'rebase --merge describes parent of commit being picked' '
 	test_create_repo rebase &&
 	(
 		cd rebase &&
@@ -194,7 +194,16 @@ test_expect_success 'rebase describes fake ancestor base' '
 		test_commit master file &&
 		git checkout -b side HEAD^ &&
 		test_commit side file &&
-		test_must_fail git -c merge.conflictstyle=diff3 rebase master &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --merge master &&
+		grep "||||||| parent of" file
+	)
+'
+
+test_expect_success 'rebase --am describes fake ancestor base' '
+	(
+		cd rebase &&
+		git rebase --abort &&
+		test_must_fail git -c merge.conflictstyle=diff3 rebase --am master &&
 		grep "||||||| constructed merge base" file
 	)
 '
-- 
gitgitgadget

