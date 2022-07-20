Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214CCC433EF
	for <git@archiver.kernel.org>; Wed, 20 Jul 2022 21:22:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230397AbiGTVWH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jul 2022 17:22:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiGTVWG (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jul 2022 17:22:06 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DDCF4D4EB
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:05 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n185so11627975wmn.4
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 14:22:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ClugNw9CmOqcvFZ7SKznLsqRvjuPtXXfdpbbOzXfJlo=;
        b=I2+kp1ITJKCrgLfbcU0QtzGvs+fKLh8ratZg3PWaeiliGetKauXGnuRUXHMAQibpEZ
         NgkKDlp/UeKzVQcMBNBG+MYdeHiWtAEU7F4DM5tpEr2lp13sEaeNWnpYV7TRpP99NGkP
         r8fKna9XodK/CDayok7RNdzEEja44k9kcXT6hbSTRKtKqr30UQpAp4tFjnqin7JX685i
         Ze9WL9Tu/T/k5jB8XX0+w+Qf+i0kuYvJrxhjQtb/kijIw8FbZc/zmEo1Z2rOVmdKzGKv
         O50n5E4Ln52lYo+nMGJXR/WyaXVNBvUGHQXCuae99i3Ogf4PwLlMBcKzwQ6xAaVZbHW5
         j6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ClugNw9CmOqcvFZ7SKznLsqRvjuPtXXfdpbbOzXfJlo=;
        b=aqGoQOCqvXrEgf64i8San3CjdhQBFN2bV1VrPTQPbsAOw8EFlcKdX5GjARjVbByrm7
         zzP9qyYiPY/bpwDQH8TIWKJGk87AyWwsgOGHgXGpAZ0VVozksMphoeyk04ZxuOt4TDLc
         V3O5UbU2zrI+NWEfrUqOjTkb7pSCBHeK/3teiLtfV+8oDPqGnhHSflxSpbNd1UHWugCJ
         SWGRT2nLXGUERqZ81XbKlbxIL1KS+WCLjGklHb+6fLn6lLomNCrBkTiu2pS+D4pa3hkN
         lPdp9jHgQK3POkkvhoq07GUnFjWPXK5Nri3LHxqXEGM88xt+xuXCfEgDmua5fYKw24LG
         pMsg==
X-Gm-Message-State: AJIora9MP7QiMkUt+vOaW7nDI9EchkxDNEwEJerHtXQXYbpOZdjFavTT
        FIIPBThlduUUKK+k3/b6nOw5kYzDPNbalg==
X-Google-Smtp-Source: AGRyM1uyz29KgLhLzb1CrKAD4IKqSow4tBXt4cqrvEzYDvRYjOnIqXhFCYJz09R4JrDnkgSkcWtMnw==
X-Received: by 2002:a1c:cc15:0:b0:3a3:a03:588 with SMTP id h21-20020a1ccc15000000b003a30a030588mr5656495wmb.29.1658352123767;
        Wed, 20 Jul 2022 14:22:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 8-20020a05600c024800b003a0375c4f73sm3605441wmj.44.2022.07.20.14.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 14:22:02 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 01/14] test-lib: use $1, not $@ in test_known_broken_{ok,failure}_
Date:   Wed, 20 Jul 2022 23:21:39 +0200
Message-Id: <patch-v2-01.14-e53cf647b44-20220720T211221Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1064.gc96144cf387
In-Reply-To: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20220719T205710Z-avarab@gmail.com> <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clarify that these two functions never take N arguments, they'll only
ever receive one. They've needlessly used $@ over $1 since
41ac414ea2b (Sane use of test_expect_failure, 2008-02-01).

In the future we might want to pass the test source to these, but now
that's not the case. This preparatory change helps to clarify a
follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..3f11ce35112 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -804,14 +804,14 @@ test_failure_ () {
 
 test_known_broken_ok_ () {
 	test_fixed=$(($test_fixed+1))
-	say_color error "ok $test_count - $@ # TODO known breakage vanished"
-	finalize_test_case_output fixed "$@"
+	say_color error "ok $test_count - $1 # TODO known breakage vanished"
+	finalize_test_case_output fixed "$1"
 }
 
 test_known_broken_failure_ () {
 	test_broken=$(($test_broken+1))
-	say_color warn "not ok $test_count - $@ # TODO known breakage"
-	finalize_test_case_output broken "$@"
+	say_color warn "not ok $test_count - $1 # TODO known breakage"
+	finalize_test_case_output broken "$1"
 }
 
 test_debug () {
-- 
2.37.1.1064.gc96144cf387

