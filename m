Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB647C433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 14:21:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235851AbhLVOVP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 09:21:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245725AbhLVOVD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 09:21:03 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20C90C061747
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:03 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c66so1689740wma.5
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 06:21:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=z1lsY1IELUoUSjAMa97erruqhiY9BJgxhgMt/g/gEqo=;
        b=XWyfrZpAfofFbgBhbrSXLVOXKfecLh3s3AEPCrDQpgmdEQ9PC8S2FMVag3rNAsMY+u
         RXjqdgzx4kUIA9OQwSQ9hjTcQKJgvmt3MqF5ynjpoS6on/UGeAKRAgCDWffVvc8o15kY
         ieuH93HOBVQXxJo0aPBBBBgObefRtyhCgTid5K0SEb4bDgbJc5ZoMVuU3M1aOM1ZHH2n
         /XqdjLMnWweW7ZNlwFlm34UAfi04ZM/iqbUGmzRpx39xzW3SONWDMCyGt+wJkDnrx2+O
         /R5aVb30ZiIUT8/M94Fc+62t3uDW0g+EJb2cAERZYeBFjhdEH/16JX/hGwlHfh16E3kf
         3big==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=z1lsY1IELUoUSjAMa97erruqhiY9BJgxhgMt/g/gEqo=;
        b=QA1k97M9phvc8atFksauM6i1rBt0mgmLidW/wbYp3QsSJa44nK46j9Fvhkm+5+xiLv
         i35U/MoUzCTjxIBEq5lX6r16rKaXUnfL1htUoe5IZD0Vfm70VlZcKGvYQb064shLxhPC
         FW0J4TzaoLRojkLbP7wlw9W4y2EpHqSCLHcieIi4Tj2Oud1sE4PdITcTR/U7wRWgjSCM
         1k0fKPO36ghNviNwy9IySKzcKR+bl75g/rLUPzAIrHivw+zfDUmTn8XepUeoWMRY8BkS
         M7ubduV7IK6GURICUGebAoG0Nilpk8QFsE3iV9+Ss/0U2Wlg2ZCx0oIBcltVsBZYQVj7
         vSMg==
X-Gm-Message-State: AOAM531q7Y2LGd7gcB7rAV1wU4P7FAj4/v6kThE8AFC8lmWbpvDuQNYn
        Ir52xOYB/Hwb2m5wV8kpj+vwWq6LtG4=
X-Google-Smtp-Source: ABdhPJxM2qYhi8fTh+LgDP3Hgjtr3H8rW9V+U/HK5Ig9ZGvZVFb9FpUZwKBiwwAjknk7kudWOrJ2iw==
X-Received: by 2002:a1c:730a:: with SMTP id d10mr1133275wmb.108.1640182861578;
        Wed, 22 Dec 2021 06:21:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h27sm5687749wmc.43.2021.12.22.06.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 06:21:01 -0800 (PST)
Message-Id: <4952c9e724b82356ca2debfe4fd115b63198bc74.1640182856.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
References: <pull.1080.v3.git.1639149192.gitgitgadget@gmail.com>
        <pull.1080.v4.git.1640182856.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 14:20:55 +0000
Subject: [PATCH v4 4/5] t1091/t3705: remove 'test-tool read-cache --table'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, vdye@github.com,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

Now that 'git ls-files --sparse' exists, we can use it to verify the
state of a sparse index instead of 'test-tool read-cache table'. Replace
these usages within t1091-sparse-checkout-builtin.sh and
t3705-add-sparse-checkout.sh.

The important changes are due to the different output format. In t3705,
we need to use the '--stage' output to get a file mode and OID, but
it also includes a stage value and drops the object type. This leads
to some differences in how we handle looking for specific entries.

In t1091, the test focuses on enabling the sparse index, so we do not
need the --stage flag to demonstrate how the index changes, and instead
can use a diff.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t1091-sparse-checkout-builtin.sh | 25 ++++++++++++++++++++-----
 t/t3705-add-sparse-checkout.sh     |  8 ++++----
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 272ba1b566b..680e0043c36 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -212,12 +212,27 @@ test_expect_success 'sparse-index enabled and disabled' '
 
 		git -C repo sparse-checkout init --cone --sparse-index &&
 		test_cmp_config -C repo true index.sparse &&
-		test-tool -C repo read-cache --table >cache &&
-		grep " tree " cache &&
-
+		git -C repo ls-files --sparse >sparse &&
 		git -C repo sparse-checkout disable &&
-		test-tool -C repo read-cache --table >cache &&
-		! grep " tree " cache &&
+		git -C repo ls-files --sparse >full &&
+
+		cat >expect <<-\EOF &&
+		@@ -1,4 +1,7 @@
+		 a
+		-deep/
+		-folder1/
+		-folder2/
+		+deep/a
+		+deep/deeper1/a
+		+deep/deeper1/deepest/a
+		+deep/deeper2/a
+		+folder1/a
+		+folder2/a
+		EOF
+
+		diff -u sparse full | tail -n +3 >actual &&
+		test_cmp expect actual &&
+
 		git -C repo config --list >config &&
 		! grep index.sparse config
 	)
diff --git a/t/t3705-add-sparse-checkout.sh b/t/t3705-add-sparse-checkout.sh
index f3143c92908..81f3384eeed 100755
--- a/t/t3705-add-sparse-checkout.sh
+++ b/t/t3705-add-sparse-checkout.sh
@@ -181,13 +181,13 @@ test_expect_success 'git add fails outside of sparse-checkout definition' '
 	# Avoid munging CRLFs to avoid an error message
 	git -c core.autocrlf=input add --sparse sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100644 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100644 .*sparse_entry\$" actual &&
 
 	git add --sparse --chmod=+x sparse_entry 2>stderr &&
 	test_must_be_empty stderr &&
-	test-tool read-cache --table >actual &&
-	grep "^100755 blob.*sparse_entry\$" actual &&
+	git ls-files --stage >actual &&
+	grep "^100755 .*sparse_entry\$" actual &&
 
 	git reset &&
 
-- 
gitgitgadget

