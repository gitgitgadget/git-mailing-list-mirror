Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25973C6FA83
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 13:57:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232248AbiI0N5L (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 09:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiI0N5H (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 09:57:07 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 613EC13EAD0
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:06 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v28so2301798wrd.3
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 06:57:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=qUGXZWINOtbksg5hfwpSctgavHbBEju8FNrCKNxG26MQemUzPx/3j9oPpxR4NGLCPd
         bFq+6iBbMMGKW972nifZaVk52yKAqLUxOJWVYMa96pJnAVZHh97cDjB6so9i5637UWps
         nGP41lL559zAgsyJ5AWyNt7luXYdoG6OfucJCCgxwJsThfxLdcrAC/fCQaPidVHzSlaM
         r/D4FVWuhi/kPxOgfKrYnUCw/nkOo4uvao/WPrGgsR67pKbnJveSQDQSP/hm9ZAVRFR9
         H2ql3P8/CFr1dZElaCNIlnMHwJI2s9kI9wXBSRHpLvs7TEzArLi2/y/7cy+EtnRZ1ttP
         NOgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date;
        bh=+wfgInJm6w/BE/avCK/39XOq++2Nf2TlMT5gggZ1o1U=;
        b=FyRKEg4CG+uhBxBlTanCTbx4fNg5U9ryzlIP3i+A8kMC/oOrLMZuEUExaAXskVN+4w
         S/iXtd9U1gIzP6KVMdxRnyCapII+wwCoZVkaYFRQDq4i6EkKw8rJJyhQPDi/sGzjl4Uc
         antYa8qfwST7tbNCJTzDENWmImf/3ewFW5VyZqB/uFD6tQwM3zvHN7n7zD3L+KUn5hUf
         HLNLx3NkOGseM/1LI+XMnq4l5SyzfuuyNZ+7myfSwPjucE38XPqKDrramT6Z3Des0ZXL
         x/+iPN2MgOUJrP0owaSp8UKjpdaqkx/truLPhUKBY7PAEvN+V4Rmr8AjEDe9QA5/komb
         jA4g==
X-Gm-Message-State: ACrzQf0Uq+AoD22dEsn7AIQc74DKl+NAIggACoXH56e0vKvilADxDxY7
        qDLl7Af+50sUg7rvrOmT1Nw7DkBqHbY=
X-Google-Smtp-Source: AMsMyM4EcNV022F7e2L5z9X0GYZ88AfHVKnHl9yIrOeEX31YRo6oQKzlHZPoc4ifoBTun0VGfjK1uQ==
X-Received: by 2002:adf:db0d:0:b0:22a:eeed:5145 with SMTP id s13-20020adfdb0d000000b0022aeeed5145mr17095465wri.590.1664287024499;
        Tue, 27 Sep 2022 06:57:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p32-20020a05600c1da000b003a4efb794d7sm2014603wms.36.2022.09.27.06.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Sep 2022 06:57:04 -0700 (PDT)
Message-Id: <a768c326c0fc749c40369461865688b5dd3f25af.1664287021.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
References: <pull.1358.v3.git.1664218087.gitgitgadget@gmail.com>
        <pull.1358.v4.git.1664287021.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Sep 2022 13:56:59 +0000
Subject: [PATCH v4 2/4] scalar: make 'unregister' idempotent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, vdye@github.com,
        SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The 'scalar unregister' command removes a repository from the list of
registered Scalar repositories and removes it from the list of
repositories registered for background maintenance. If the repository
was not already registered for background maintenance, then the command
fails, even if the repository was still registered as a Scalar
repository.

After using 'scalar clone' or 'scalar register', the repository would be
enrolled in background maintenance since those commands run 'git
maintenance start'. If the user runs 'git maintenance unregister' on
that repository, then it is still in the list of repositories which get
new config updates from 'scalar reconfigure'. The 'scalar unregister'
command would fail since 'git maintenance unregister' would fail.

Further, the add_or_remove_enlistment() method in scalar.c already has
this idempotent nature built in as an expectation since it returns zero
when the scalar.repo list already has the proper containment of the
repository.

The previous change added the 'git maintenance unregister --force'
option, so use it within 'scalar unregister' to make it idempotent.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 scalar.c          | 5 ++++-
 t/t9210-scalar.sh | 5 ++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/scalar.c b/scalar.c
index c5c1ce68919..6de9c0ee523 100644
--- a/scalar.c
+++ b/scalar.c
@@ -207,7 +207,10 @@ static int set_recommended_config(int reconfigure)
 
 static int toggle_maintenance(int enable)
 {
-	return run_git("maintenance", enable ? "start" : "unregister", NULL);
+	return run_git("maintenance",
+		       enable ? "start" : "unregister",
+		       enable ? NULL : "--force",
+		       NULL);
 }
 
 static int add_or_remove_enlistment(int add)
diff --git a/t/t9210-scalar.sh b/t/t9210-scalar.sh
index 14ca575a214..be51a8bb7a4 100755
--- a/t/t9210-scalar.sh
+++ b/t/t9210-scalar.sh
@@ -116,7 +116,10 @@ test_expect_success 'scalar unregister' '
 	test_must_fail git config --get --global --fixed-value \
 		maintenance.repo "$(pwd)/vanish/src" &&
 	scalar list >scalar.repos &&
-	! grep -F "$(pwd)/vanish/src" scalar.repos
+	! grep -F "$(pwd)/vanish/src" scalar.repos &&
+
+	# scalar unregister should be idempotent
+	scalar unregister vanish
 '
 
 test_expect_success 'set up repository to clone' '
-- 
gitgitgadget

