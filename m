Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09726C4332F
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D653E61B39
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbhKSU3e (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhKSU3d (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:33 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECB38C061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:30 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso11376334wmr.4
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+fXHDkEJAyOLyq4z+kpsAhVP9UO1z7EHqLXgH2Woa+A=;
        b=jmaZDEzZg+VtHd/2TmHCEPHc+zboJVLonKSLAFzX5DKUje0rRLwAdJr8OJdQ1m2jp6
         aTzeJNeOVcH/Yr9ISZLi5DeM3SfCvh2sXhOYZErnNoZg4E2WlsaNJfjoQyBXQ4zQlEpf
         Wvtd0CaMm6a5UneDkD57GBYPg4aNWyaYkqwfs2pAjpMQ4sOzX77KD4fgiStjyaWDi8U5
         ujakuU53KcVc+o3T/+JP8IRo5DK7D+PQx+MVEUY26zeXb3r2Y3NxgbX8xBaPw0AHXSAt
         dLXJTLUF3m+CcyQ+glEIs/U+Y/lNskTPyFVoAPO/bLAlaPJzMnVKvoTbVHnaFtZ+tPkv
         Jjyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+fXHDkEJAyOLyq4z+kpsAhVP9UO1z7EHqLXgH2Woa+A=;
        b=KqvbdBzvPkIhwQyBlCA+xWwa/w13PEbFXoiyvo7GdkgaYhMyDL1q98Zocr/gl8tsWJ
         /1uzRUbCgxyEzpjtfGi/plFDcV0Rg3xR1ki1V2R+fnUHYB/EuB+NaRZMstkCCJ0B4LFF
         yMCQgoRl5sBfpByhRbHdymTgblEEvJ9XpFP8rS0Xw/KbXOrw5RS0H7MzDcbzZBL7FAiD
         2bUIT6gAVtlPupcCjhN4H6ea8NfV+c0Koc4rZ1RwgOTrng4giw5vOhXSm7cpIrVVITqv
         jxNX4N6/mlRb53RJ4zPhK4IwfUJjI+AybAXR04xAKiklTC/1MvEgxt/+sf/83V7EaEMU
         yfyg==
X-Gm-Message-State: AOAM531x7UAqLn878DHfjqUzD07uSveD/SbAdsEI2dAwI63Po/sD0dDT
        BU84LQ0ZdWwg10p4rOctOcMV8gwZmBgrbA==
X-Google-Smtp-Source: ABdhPJyi/FA3o7vsUBGo5nfaXc3evHfof5LNTyptf5w1fwopMgbTlNCEPOyQzqjKbAFV6f2AOLR+Nw==
X-Received: by 2002:a05:600c:2195:: with SMTP id e21mr3146898wme.187.1637353589250;
        Fri, 19 Nov 2021 12:26:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/5] pack-bitmap-write: remove unused bitmap_reset() function
Date:   Fri, 19 Nov 2021 21:26:22 +0100
Message-Id: <patch-v2-2.5-c9026af8953-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function hasn't been used since 449fa5ee069 (pack-bitmap-write:
ignore BITMAP_FLAG_REUSE, 2020-12-08), which was a cleanup commit
intending to get rid of the code around the reusing of bitmaps.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 ewah/bitmap.c | 5 -----
 ewah/ewok.h   | 1 -
 2 files changed, 6 deletions(-)

diff --git a/ewah/bitmap.c b/ewah/bitmap.c
index 38a47c44db4..87d5cc8fa30 100644
--- a/ewah/bitmap.c
+++ b/ewah/bitmap.c
@@ -216,11 +216,6 @@ int bitmap_is_subset(struct bitmap *self, struct bitmap *other)
 	return 0;
 }
 
-void bitmap_reset(struct bitmap *bitmap)
-{
-	memset(bitmap->words, 0x0, bitmap->word_alloc * sizeof(eword_t));
-}
-
 void bitmap_free(struct bitmap *bitmap)
 {
 	if (bitmap == NULL)
diff --git a/ewah/ewok.h b/ewah/ewok.h
index 66920965da1..7eb8b9b6301 100644
--- a/ewah/ewok.h
+++ b/ewah/ewok.h
@@ -177,7 +177,6 @@ struct bitmap *bitmap_dup(const struct bitmap *src);
 void bitmap_set(struct bitmap *self, size_t pos);
 void bitmap_unset(struct bitmap *self, size_t pos);
 int bitmap_get(struct bitmap *self, size_t pos);
-void bitmap_reset(struct bitmap *self);
 void bitmap_free(struct bitmap *self);
 int bitmap_equals(struct bitmap *self, struct bitmap *other);
 int bitmap_is_subset(struct bitmap *self, struct bitmap *other);
-- 
2.34.0.823.gcc3243ae16c

