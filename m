Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A300C432C3
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC12822517
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727368AbgLWBjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbgLWBjF (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:05 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5675C061257
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:51 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id q18so16994007wrn.1
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=M3lM2mpsE26HYB9A1eUFW2nFsMtx1EKMsiBlItl88Lc=;
        b=KjtbeQx8VMf2ZJpicSw1FztIvIxhZe1fk7H09ri0dgh7Ti0Wb4wuqDUvnJE/jBc/nT
         B4Bwlmuh5KvdBLyaP1z5bqkUKjKMa7+FKUHyx3PVHUCa8EZnQY0D508YIElzrsx3VoGa
         IaJpStXLBhd7ikIrnIFglIWlq4dDAYGnSaUN48VuAtShDuILIh4fFdCd9JcIJdCbrkhK
         45ELIbAmAubGOi2mmEpyCW+RScqOTF9AhAq+bzK4rvZR7WEE1jjSn6G7GgCrCiuvmm1z
         JPVj1UyNX7UUEu+isSGPhG/0Ld95HC3pYr9OuBhFXR6Nu6KXwRR+ffBgljV4r/YKXTvV
         sqkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=M3lM2mpsE26HYB9A1eUFW2nFsMtx1EKMsiBlItl88Lc=;
        b=gAsfxovzQXt2Ym3PpPGA3DXh9jTFoHOlhHJTpf1R6QYWS0XfWfeKOP5q01kCC5UBUO
         WrFcRfRUzWWdY+oYHJHmc8i0jhMCYxk5p57bm0jNsqPA/VuLSzQ+mVKyZPOSnvrLcLzO
         rFwwC1a6hCIEJNRBDBK7yP4y2JnU2oPmfXGuahPGgqmB6252KkrX5kyWGwW22C0bqPjX
         4jwIZPh1sEoBpvYyA8f59sBaJOujQ2MtW/w0E25uGJnBg7rMoNxT/t1v8GUkUDDpyGQQ
         91eVdKJBcfwKb2WRIQnS3a+9xEd9i3nak6uH140oWqYyV5J8A69rjiQtUs0XMhQqPgP9
         ivqQ==
X-Gm-Message-State: AOAM530s6F+cJzWJpR7hEAaVMGkdBLakxoEVlgU6e0cU4EuqzG2V0Jn2
        hciW+K2/hYyCh/Zc4NKGyxecAp/bkH31Vw==
X-Google-Smtp-Source: ABdhPJw47jfFXtP88uEIDmDaSsxvmCq1f0nuDdEYXnhl4HXrvzJ6zItISvnSI6QS3ZDMXBmiclzzKA==
X-Received: by 2002:adf:e547:: with SMTP id z7mr26001577wrm.283.1608687470418;
        Tue, 22 Dec 2020 17:37:50 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:49 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 08/20] mktag tests: don't create "mytag" twice
Date:   Wed, 23 Dec 2020 02:35:53 +0100
Message-Id: <20201223013606.7972-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a test added in e0aaf781f6 (mktag.c: improve verification of
tagger field and tests, 2008-03-27) to not create "mytag", which
should only be created and verified at the end in an earlier test
added in 446c6faec6 (New tests and en-passant modifications to mktag.,
2006-07-29).

While we're at it let's prevent a similar logic error from creeping
into the test by asserting that "mytag" doesn't exist before we create
it. Let's do this by moving the test to use "update-ref", instead of
our own homebrew ad-hoc refstore update.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index bbd148618e..b6dcdbebe6 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -257,7 +257,7 @@ EOF
 
 test_expect_success \
     'allow empty tag email' \
-    'git mktag <tag.sig >.git/refs/tags/mytag'
+    'git mktag <tag.sig'
 
 ############################################################
 # 16. disallow spaces in tag email
@@ -383,16 +383,9 @@ tagger T A Gger <tagger@example.com> 1206478233 -0500
 
 EOF
 
-test_expect_success \
-    'create valid tag' \
-    'git mktag <tag.sig >.git/refs/tags/mytag'
-
-############################################################
-# 25. check mytag
-
-test_expect_success \
-    'check mytag' \
-    'git tag -l | grep mytag'
-
+test_expect_success 'create valid tag' '
+	git mktag <tag.sig >hash &&
+	git update-ref refs/tags/mytag $(cat hash) $(test_oid zero)
+'
 
 test_done
-- 
2.29.2.222.g5d2a92d10f8

