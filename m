Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AF50C433EF
	for <git@archiver.kernel.org>; Sat, 26 Mar 2022 17:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiCZRQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 26 Mar 2022 13:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231805AbiCZRQM (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 26 Mar 2022 13:16:12 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3BD35844
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:35 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p12-20020a05600c430c00b0038cbdf52227so6092838wme.2
        for <git@vger.kernel.org>; Sat, 26 Mar 2022 10:14:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wiBv7ZUjybSR/SpCu7zmrYGSdGFuPZRTg18H8R6reX8=;
        b=XompFu9i5HCF0riaUh8C8C9KT8j3N4hvQwVELT5lTCFx1pTFSGFCWh1dqmnWHbwxCl
         qfafEQkd9ZJUZQIuyam08+9Lnc2Sdnu2qfNm1r4YeL/YF+mMZaSrjwSgWsJNE+GxdOJR
         dqXLBCTVIbUXArvk9bU2m8Qio7NDEGXwzewzH75I+5MPIwQqOzaCq0CrQEXqLkl+FZFL
         dfAkwb4PmZXhwGRuwYomXwyMr+56vGqJaNAl9TD5ETAifXQYWMbIi7oTD3NehVxJu2s0
         xNkQuRAqocf27KFSkjnoA+c/1wzp+rI0uqXC38CbgFFyZOBkHWepUhCtm0hYcW4mfB+E
         2gCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wiBv7ZUjybSR/SpCu7zmrYGSdGFuPZRTg18H8R6reX8=;
        b=HSElumpT7d5RLg3l0NwERM1rpjo1qlN86Ml4mcUOJ/sq6rS6li1bBd/x5d8/D2rX7y
         fkRb9JP4NQg4VRQYHpwCJDheRk7gXSQ41tRtwkmkZEUnur2HfUoCVbhFe/BGcOiOCVwi
         kmLy9yeQZgqsAP+ySE2bJnhUFQnYnr86ixLGo39q9Vytk7UuHL3we8RleDlpHB7bUpC/
         X05RMiD1iZ5UJJg0YrNH5w3b7wWJ/3ppbOAWDM2sm1ZsVICBBdO8CFqMEELgnaY4oPRT
         m5+KxngBA0BnL2PeSz8QeufFLBX6eRR0zzfkEUJevdhpkEoFc1wRUBez6/fHZCx3oWZd
         zYPQ==
X-Gm-Message-State: AOAM532cVChSQd/yabzX+Z3wJVTHlFGnYMFpHPKB0V5F47hQ/CbpVopH
        LdUtApmc5K68mYyUIEv7wm2kIerDQev3yg==
X-Google-Smtp-Source: ABdhPJxHcWOgvyaP1rlzG02n/CmO+hvocBkGPJxcYwabpwS7G1ZaDBnTlFQ/cgBgonh8wyxd64XBuA==
X-Received: by 2002:a7b:c017:0:b0:38c:8a13:466d with SMTP id c23-20020a7bc017000000b0038c8a13466dmr25649521wmb.128.1648314873690;
        Sat, 26 Mar 2022 10:14:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c4f1300b0038cb924c3d7sm7805913wmq.45.2022.03.26.10.14.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Mar 2022 10:14:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/7] pack-bitmap-write: remove unused bitmap_reset() function
Date:   Sat, 26 Mar 2022 18:14:16 +0100
Message-Id: <patch-v3-4.7-6bd89f3cf42-20220326T171200Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1535.gf8d72b9da1e
In-Reply-To: <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20220326T171200Z-avarab@gmail.com>
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
2.35.1.1535.gf8d72b9da1e

