Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FC52C35243
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D5C1220728
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 06:15:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpdHPA3G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730434AbgAPGPA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 01:15:00 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:36374 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730308AbgAPGOu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 01:14:50 -0500
Received: by mail-wr1-f65.google.com with SMTP id z3so17891565wru.3
        for <git@vger.kernel.org>; Wed, 15 Jan 2020 22:14:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=mpdHPA3G5TQwAaZ/F/benVjB1qKzlPTxAgl4ogIvm9WexhyNWo6iYP30Z7KYw+KF0z
         RBtWPAyWQFxcP4a/SmszObruzMUDJ4CeXpKjTemJNs7e1WAsyRHnAIs5GVnlru5KOr+G
         d8XMzwrFXrfrk/MHhADKQiv5IK65E6lhptC815Zzvm+BAPQueoKXjf4W0TBpOqoCZweG
         rPB3cBIxqPaSHFCqWjpuQW69a++S2mnHXq79TaIJlzj8S8YGp5pFOW6aeG3j+xfYNiS7
         YLUIzjiiUe6uc3mTNZDm4uq21L96gx+fc2v49g5DR/VcidQPHAkYd3NcAp1wvIyw8AXg
         56Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=BAhNliR1ZkRUC0qZ6iUsnYc0YkrscXoRR69gsMZ/BNk=;
        b=opfqnvzgM/ujxpiKsr+k6D2N3bIV0ZDmLeCZTgVHc0ND1cHshUTNsSwln31Oo/bTun
         b0k2zZUtQvhOg9DZrS8gEkZyE8j5PHepzj3Zxa0Rl9+ZEYA1UO+J/qVo2p+htULJvvKD
         Bk41FD0a05lFTr1ALM6EC9XT2wd5Zd4+K7e7NhClxZzLP5S2CpJ7vsEivFQTGabryX73
         tK5yk0I140G0fPK7nXwLMI60BHAniCp5AJYN/QObKcZXxzwmKC3fPh39fqHNMEAyMvRa
         T+nXXCxIudnLoGLT/L63JSU0HV/C2QZ5HXYgpFK0QEBszvqw76XVQc7kQlUMiBCq6CFY
         3RxQ==
X-Gm-Message-State: APjAAAWy00y/btsHir0cq6jutb0Ko4PrZsPTs9hjShzCcHIcCapbjm9R
        j+GqjJxK7d51AymJbcOtpQ6LZumW
X-Google-Smtp-Source: APXvYqyS7IETMkLRdZchha2BBnV+6lsgOGmdlFGtVkxBzfYEnkaI6Jw+TRGw7tA2bbid+IvoBqCx4Q==
X-Received: by 2002:adf:a109:: with SMTP id o9mr1362063wro.189.1579155288444;
        Wed, 15 Jan 2020 22:14:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 16sm3010909wmi.0.2020.01.15.22.14.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 22:14:47 -0800 (PST)
Message-Id: <1e3d4066c40d914fc2f0f290d6794952daead346.1579155274.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
        <pull.679.v4.git.git.1579155273.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 16 Jan 2020 06:14:31 +0000
Subject: [PATCH v4 17/19] rebase tests: repeat some tests using the merge
 backend instead of am
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes.Schindelin@gmx.de, phillip.wood@dunelm.org.uk,
        liu.denton@gmail.com, gitster@pobox.com, plroskin@gmail.com,
        alban.gruin@gmail.com, szeder.dev@gmail.com, jrnieder@gmail.com,
        emilyshaffer@google.com, Elijah Newren <newren@gmail.com>,
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

