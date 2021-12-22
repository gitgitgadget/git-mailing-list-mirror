Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 552F7C433FE
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 10:59:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbhLVK7x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 05:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244337AbhLVK7u (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 05:59:50 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CB68C06173F
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:49 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso1231046wmf.3
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 02:59:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=B2tMnh8d8ih9qHUp1SrO+05Dkn2J4Ex9VrM70kwBxTQ=;
        b=DQmt3EDxZ00ERdpQ7YQkAs/k9loH7zdcxdRYazuQ74Q295j53HFAJ6pDfWOgMBzqsS
         DA234T45Ss+3f1Q62AJY1AHBwtfIBEtswgmVqDVICBzNzTSdTF2nuWh67BL/8jid6MCb
         OEH8OoLoqQOt22BnaTYW1DJnFiqiJFhHS/6aJUj28AGWqICNT1RKS8EeO4lIgNe3ZjGP
         If+1IZ81deReeX72VEF5OLDv2W6Q0IToGNJ6l+DuHDDshGAL8iYPrFlZQwVP3Ipqlwu6
         OaYBM6ymqIs0VZZwr3CRa9FvgSsT7nuYuE16meOUnzBReyO8oNbFhFYdm7dkcA15BmWq
         zylg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=B2tMnh8d8ih9qHUp1SrO+05Dkn2J4Ex9VrM70kwBxTQ=;
        b=YZOQT0mO4+uuUNrft0/6x9InD7962/9YwRF83dlV3pMN1M+GxkgldnxhAv77VzrUFm
         lO7byyRgM2dsC0DsvBfWJSzDvMLjvO5YwtCKLxvXBbzeu18Sa0A5pH/8xwUHFgk2ZNfV
         UUamqWRnodthNeGSzxAPKbZO96bmuCfsshHA2mLQNEUfs4G/M1BCe4PghO/7Aj6jkwPL
         aMn1L7qSJp8wu+D3hDRT4LkOp8o0r7FFsC0p6zYSDzLCbYHHwX0B+873+FIaPFtpolCa
         8qOg4nHS/GD2hlHzOKeVJm0GFahWiszCTyRiG69NGjyG1Ecpti6uxYGh/ce4UyoThtAf
         7d2g==
X-Gm-Message-State: AOAM532HvXaSMJIOGFtgmpxz/CugNVI2CdobKjGx54CAARnyLNp9vlDG
        pydsQ8pyNmJ1uAO3kC56rfxqzNPya8A=
X-Google-Smtp-Source: ABdhPJz4k9PUHjXvqF39xr13/gIiAqk8mwCrb7MCvYiOxnb0VHNEcR36eHJXfgmqM5eartotnNzS0g==
X-Received: by 2002:a05:600c:3844:: with SMTP id s4mr544493wmr.124.1640170788029;
        Wed, 22 Dec 2021 02:59:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s189sm5820693wme.0.2021.12.22.02.59.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 02:59:47 -0800 (PST)
Message-Id: <854bd15787618978b2da3941b5b749dadc1a186f.1640170784.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
References: <pull.1168.git.git.1640170784.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 10:59:43 +0000
Subject: [PATCH 3/4] t7004: create separate tags for different tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Reftable intentionally keeps reflog data for deleted refs.

This breaks tests that delete and recreate "refs/tags/tag_with_reflog" as traces
of the deletion are left in reflog. To resolve this, use a differently named ref
for each test case.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t7004-tag.sh | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 082be85dffc..301d1190482 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -94,10 +94,10 @@ test_expect_success 'creating a tag with --create-reflog should create reflog' '
 	git log -1 \
 		--format="format:tag: tagging %h (%s, %cd)%n" \
 		--date=format:%Y-%m-%d >expected &&
-	test_when_finished "git tag -d tag_with_reflog" &&
-	git tag --create-reflog tag_with_reflog &&
-	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
+	test_when_finished "git tag -d tag_with_reflog1" &&
+	git tag --create-reflog tag_with_reflog1 &&
+	git reflog exists refs/tags/tag_with_reflog1 &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog1 >actual &&
 	test_cmp expected actual
 '
 
@@ -105,10 +105,10 @@ test_expect_success 'annotated tag with --create-reflog has correct message' '
 	git log -1 \
 		--format="format:tag: tagging %h (%s, %cd)%n" \
 		--date=format:%Y-%m-%d >expected &&
-	test_when_finished "git tag -d tag_with_reflog" &&
-	git tag -m "annotated tag" --create-reflog tag_with_reflog &&
-	git reflog exists refs/tags/tag_with_reflog &&
-	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog >actual &&
+	test_when_finished "git tag -d tag_with_reflog2" &&
+	git tag -m "annotated tag" --create-reflog tag_with_reflog2 &&
+	git reflog exists refs/tags/tag_with_reflog2 &&
+	sed -e "s/^.*	//" .git/logs/refs/tags/tag_with_reflog2 >actual &&
 	test_cmp expected actual
 '
 
@@ -118,10 +118,10 @@ test_expect_success '--create-reflog does not create reflog on failure' '
 '
 
 test_expect_success 'option core.logAllRefUpdates=always creates reflog' '
-	test_when_finished "git tag -d tag_with_reflog" &&
+	test_when_finished "git tag -d tag_with_reflog3" &&
 	test_config core.logAllRefUpdates always &&
-	git tag tag_with_reflog &&
-	git reflog exists refs/tags/tag_with_reflog
+	git tag tag_with_reflog3 &&
+	git reflog exists refs/tags/tag_with_reflog3
 '
 
 test_expect_success 'listing all tags if one exists should succeed' '
-- 
gitgitgadget

