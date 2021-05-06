Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E2DFC433B4
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4F46121F
	for <git@archiver.kernel.org>; Thu,  6 May 2021 16:52:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236153AbhEFQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 May 2021 12:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbhEFQxo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 May 2021 12:53:44 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 636C9C06138B
        for <git@vger.kernel.org>; Thu,  6 May 2021 09:52:46 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id s5-20020a7bc0c50000b0290147d0c21c51so3403661wmh.4
        for <git@vger.kernel.org>; Thu, 06 May 2021 09:52:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=x6GvtC21N81eSxYX9fXQ4E4xIU4uGASvgWOykQevpXU=;
        b=V4oveJgjNMyB/wiPlPX4OMR3Yw9OSsh4uJTH9beDoWwrKLZddjTE5e9MfG2sj9DoRC
         ftAlN5Mcr9maPwHV1ilTXDPijoZwzfmDGdVkbDKEh5l8v9nj6YtrvGZI7mH5gkyDz2wS
         2tMfx9sYDVGGOO2cVYwdF1SeuISom2MO/IY8XF77TDLxJUHi2o92qjgjCCVY65U7l+eH
         LkcMB9Zp9/ldld1rzE6VxYApOCxdJEwxCdJaupE8xSlPokgduXiE0yn3sWtDDgB4fw54
         he7TSXrob0FHSshSc/qjwp34LV4nPzTjQE3PLJaSsCPWxcrYRnPiJg0gOcilMQ/2d35r
         B68w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x6GvtC21N81eSxYX9fXQ4E4xIU4uGASvgWOykQevpXU=;
        b=f2/PmVbjF3E4aJ5P+QfwxXMnMJfjRcnRXRrtPn8iBQWGnPR5ilhoS60eRS21UwNERp
         0Z9H3yTRB1TCh1J5/WtfgMK3Hse0+MkphcuS1fi3/JzzZY1/U9qea8YGJN/Eo9i0T0y3
         nfSLTGdQunw9AZTC6Kl4mEsP8CrFnzpgcW9yvNlCZEQiEsbyT8c+/7Kln3rApHfdBOo/
         8OOdzaUpdAzajGuIO6ylBR9wNE8qU8vyNAE6sU/0Ns8pgouIGwKHmHnzfR3j69Z6ssF3
         Sy4jw7/XmvNWVm66nfkhPG2FAyD/FBA4IZLdPH+Qj33tgG2mZTnmr9vu6L7DYcZpw0+I
         hCsg==
X-Gm-Message-State: AOAM530vufpj5dU+6BDyQs/jPIdCwRK4MXrQJAOm9muBdp7JKZJXjcLe
        WzAvygtOfRBAsQ7ghkocIL0=
X-Google-Smtp-Source: ABdhPJxDOxuFfyiPb5JIpThfKZIeBnvb4oIH2d3yiZL/SouSFST9j8U+T9Rfjm/SK/D4iqt/Icagrg==
X-Received: by 2002:a1c:ed05:: with SMTP id l5mr16417261wmh.154.1620319965141;
        Thu, 06 May 2021 09:52:45 -0700 (PDT)
Received: from Inspiron.home (2a01cb04010c42006d71140a7638f172.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:6d71:140a:7638:f172])
        by smtp.gmail.com with ESMTPSA id y14sm5354482wrr.82.2021.05.06.09.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 May 2021 09:52:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Firmin Martin <firminmartin24@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v1 6/8] t4014: fix tests overwriting cover letter in silent
Date:   Thu,  6 May 2021 18:51:00 +0200
Message-Id: <20210506165102.123739-7-firminmartin24@gmail.com>
X-Mailer: git-send-email 2.31.1.450.g14fbf8793d
In-Reply-To: <20210506165102.123739-1-firminmartin24@gmail.com>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are broken due to the new configuration option
format.confirmOvewrite whose the default value requires confirmation
from user whenever an existing cover letter is subject to be
overwritten.

Also change some pairs of git config and git config --unset to a single
test_config.

Signed-off-by: Firmin Martin <firminmartin24@gmail.com>
---
 t/t4014-format-patch.sh | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/t/t4014-format-patch.sh b/t/t4014-format-patch.sh
index cf7e48f4de..a34598beca 100755
--- a/t/t4014-format-patch.sh
+++ b/t/t4014-format-patch.sh
@@ -669,11 +669,13 @@ test_expect_success 'failure to write cover-letter aborts gracefully' '
 '
 
 test_expect_success 'cover-letter inherits diff options' '
+	test_when_finished "rm 0000-cover-letter.patch" &&
 	git mv file foo &&
 	git commit -m foo &&
 	git format-patch --no-renames --cover-letter -1 &&
 	check_patch 0000-cover-letter.patch &&
 	! grep "file => foo .* 0 *\$" 0000-cover-letter.patch &&
+	rm 0000-cover-letter.patch &&
 	git format-patch --cover-letter -1 -M &&
 	grep "file => foo .* 0 *\$" 0000-cover-letter.patch
 '
@@ -1917,10 +1919,9 @@ test_expect_success 'cover letter with nothing' '
 
 test_expect_success 'cover letter auto' '
 	mkdir -p tmp &&
-	test_when_finished "rm -rf tmp;
-		git config --unset format.coverletter" &&
+	test_when_finished "rm -rf tmp" &&
 
-	git config format.coverletter auto &&
+	test_config format.coverletter auto &&
 	git format-patch -o tmp -1 >list &&
 	test_line_count = 1 list &&
 	git format-patch -o tmp -2 >list &&
@@ -1929,10 +1930,10 @@ test_expect_success 'cover letter auto' '
 
 test_expect_success 'cover letter auto user override' '
 	mkdir -p tmp &&
-	test_when_finished "rm -rf tmp;
-		git config --unset format.coverletter" &&
+	test_when_finished "rm -rf tmp" &&
 
-	git config format.coverletter auto &&
+	test_config format.confirmOverwrite never &&
+	test_config format.coverletter auto &&
 	git format-patch -o tmp --cover-letter -1 >list &&
 	test_line_count = 2 list &&
 	git format-patch -o tmp --cover-letter -2 >list &&
@@ -2386,6 +2387,7 @@ test_expect_success 'interdiff: setup' '
 '
 
 test_expect_success 'interdiff: cover-letter' '
+	test_when_finished "rm 0000-cover-letter.patch" &&
 	sed "y/q/ /" >expect <<-\EOF &&
 	+fleep
 	--q
@@ -2398,16 +2400,19 @@ test_expect_success 'interdiff: cover-letter' '
 '
 
 test_expect_success 'interdiff: reroll-count' '
+	test_when_finished "rm v2-0000-cover-letter.patch" &&
 	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
 
 test_expect_success 'interdiff: reroll-count with a non-integer' '
+	test_when_finished "rm v2.2-0000-cover-letter.patch" &&
 	git format-patch --cover-letter --interdiff=boop~2 -v2.2 -1 boop &&
 	test_i18ngrep "^Interdiff:$" v2.2-0000-cover-letter.patch
 '
 
 test_expect_success 'interdiff: reroll-count with a integer' '
+	test_when_finished "rm v2-0000-cover-letter.patch" &&
 	git format-patch --cover-letter --interdiff=boop~2 -v2 -1 boop &&
 	test_i18ngrep "^Interdiff ..* v1:$" v2-0000-cover-letter.patch
 '
-- 
2.31.1.449.g4a44fa8106

