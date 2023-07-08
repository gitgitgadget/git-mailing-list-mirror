Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55178EB64D9
	for <git@archiver.kernel.org>; Sat,  8 Jul 2023 01:06:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjGHBGJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jul 2023 21:06:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232693AbjGHBGH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2023 21:06:07 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19B05210C
        for <git@vger.kernel.org>; Fri,  7 Jul 2023 18:06:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-313f1085ac2so2505961f8f.1
        for <git@vger.kernel.org>; Fri, 07 Jul 2023 18:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688778364; x=1691370364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRK67iEkSwyCOlZn0KK2nItT0FjFXldI5YwsF3b15JA=;
        b=Qv3A/84L+1LU1LqZuZ8lf8upPc+KvDaK7ceTYsvq2VoHI2sfx8Xu/zANIWxGNMArfD
         dKU2TwNsgjVVCkl8G58WbSD7j8m8zyx3lqmAAojRPUfe7QU7Xt4O3vlr5LLAJ9g78Tlt
         xiq3TjaEDrn9ejqB6E7nBUWAYzSw40eXDbJj9Hmyetxlf3j/clCdoG6CKHW1tXrcUSOL
         amsm09b9phEmqHGA1O/K3C6vYuWgM0QrVKVlhUtUlxdFD8R0zEEsaSSSa80KflGrVd3C
         yJVKNVRbIWeCsFKbJnviT8LWF2WuHrdpSbxTNAhsXI7GWNFTc+qixvbYvFtYk6oSqeXI
         wTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688778364; x=1691370364;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRK67iEkSwyCOlZn0KK2nItT0FjFXldI5YwsF3b15JA=;
        b=Ue6pagoC0I1ooYheC7F9lwf/bYrSvzozaobwgng+lTWWQTH72v24iyVvK08sQTe61v
         PFO4XJm/tePoOjzwWuu04vG5HoRvA4rsvJ7fUQUxqajevgGHLjfXTcDnfeloHsj3tw6h
         5yVMKEXCp/oCl/oBC90YErg1XQO2FqUG1hmqt5qj3SeMbykwjVKS2ErWb/qbEt08P9HZ
         mVnYuaiKx/B6AkIqpAtxeuJuVPB/ynIY6ebucFX1ITzn1RKw01g9l4mxAqkZJY3pKkJr
         EtdwhKRRiOHNWcAB7nXQUTVcVlKMSZ2ht4gNY+BYemcz74dkb7rZAqOCsL0pju1UyFOo
         XxsQ==
X-Gm-Message-State: ABy/qLZCef0Drfv+frC1Al55tlktl180N3FtwffaV2g4JJeQbs3fzYmJ
        VOnnSKxf3r8qhr/tE+Jcy8PehH+ZkgE=
X-Google-Smtp-Source: APBJJlEtjXjSv2iE8qkqheXMKKzVMnqB7PT1VmcPuL4ovC/rYwLkbSvxCvWQ0a1bPPchb2gdLg8kQA==
X-Received: by 2002:adf:f8c3:0:b0:314:30ed:9b55 with SMTP id f3-20020adff8c3000000b0031430ed9b55mr1518928wrq.15.1688778364322;
        Fri, 07 Jul 2023 18:06:04 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p11-20020a056000018b00b003141e86e751sm5725015wrx.5.2023.07.07.18.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jul 2023 18:06:03 -0700 (PDT)
Message-Id: <d430a4ed8ee9d5a3d45a3a2b373ed3377cf5fd62.1688778359.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
References: <pull.1556.git.1688778359.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sat, 08 Jul 2023 01:05:57 +0000
Subject: [PATCH 3/5] SubmittingPatches: discuss subsystems separately from
 git.git
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Linus Arver <linusa@google.com>, Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

The discussion around subsystems disrupts the flow of discussion in the
surrounding area, which only deals with branches used for the git.git
project. So move this bullet point out to the end.

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/SubmittingPatches | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 5611580fb4c..48918181f49 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -35,14 +35,14 @@ change is relevant to.
   to stabilize, you would have to rebase it (see the "depends on other
   topics" above).
 
-* Some parts of the system have dedicated maintainers with their own
-  repositories (see the section "Subsystems" below).  Changes to
-  these parts should be based on their trees.
-
 To find the tip of a topic branch, run `git log --first-parent
 master..seen` and look for the merge commit. The second parent of this
 commit is the tip of the topic branch.
 
+Note that some parts of the system have dedicated maintainers with their
+own separate source code repositories (see the section "Subsystems"
+below).
+
 [[separate-commits]]
 === Make separate commits for logically separate changes.
 
-- 
gitgitgadget

