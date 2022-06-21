Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB390C43334
	for <git@archiver.kernel.org>; Tue, 21 Jun 2022 13:34:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351585AbiFUNeK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Jun 2022 09:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350501AbiFUNbB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Jun 2022 09:31:01 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0572AC67
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:21 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id h34-20020a17090a29a500b001eb01527d9eso12545248pjd.3
        for <git@vger.kernel.org>; Tue, 21 Jun 2022 06:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sEgHLQnfCPK8tnL9YoNpJVoKKjuvqic03Uyz1GHRvAY=;
        b=goetkn9ChbSvzOlbaHv5yFJVS+Z+mChzvE3VieiCJvAgTRlLVeWcLEpN4V4exKHk0V
         gZOqAEAi9+mIrGoLVb64Vrp8CnpNUP02kq5QPB/FTleTh5AE5+ai5H9kjNkcC+jPEigb
         cMd4yH+SkLR1EwSBdHoQT8hkrdqb6RNg1yfsLYgtCyuUx0G+e+bQzvtXz3AuGTxs+6LL
         IoVrccf13FRSBP+s8XeQ7cpWU8NVEIMHwTS0YRGfGdahzvffL074ElHpKBtvSlkAeSpv
         NRzHL2qsw2onT0SpwFq+KSu3UDY/LYSENk7ytKVkE3YVp8jzpDrnHs3ALAEhlMe1Mb3X
         EIrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sEgHLQnfCPK8tnL9YoNpJVoKKjuvqic03Uyz1GHRvAY=;
        b=vrkLci5vYXtGnBg+8hjYzKvMW2eozIjStzRTtelMDC1NC1bhr6l5RF+UtvriOiaQne
         iK0MEwjvKWc5bIIXdDuwXATwaZhKvz80G8w1Rey8Ylb9pfPyOaz+mBhsAbNZlOKpTMnX
         jVX1OewWAQGHmRwNyJ2D9Wj6bz8a/rhF+EmGBiLtkUH4UysE8bZd9e7t/O+NP1isvZi6
         EcoA+02aGeRaZLpthawK8Bs3g42MIZLuPE1n1ZOTjrUa1ZY3vjjS5AJXZYpdVT/Khwh9
         0wpNZ3ITYwbV2FW6aEmcJpsAVpoEw1oUxVjXqH10q70p79tyd8rF4l7irXszuCYbrEJS
         Qm7Q==
X-Gm-Message-State: AJIora8+vO62oOmPWUHDaiCGWWMW9wclRCEqFOhf1cB1wz2/ud1tWQYE
        pJPkuf4zfqJ5AKiifnuQeIA=
X-Google-Smtp-Source: AGRyM1tQaM08EumCDh8stTFLTvpNvmFoUcVysvdSZhoyAncda95zStrs40vy2OpkTLfxB9/209rEXg==
X-Received: by 2002:a17:90b:504:b0:1e6:a0a4:c823 with SMTP id r4-20020a17090b050400b001e6a0a4c823mr44052120pjz.190.1655817921306;
        Tue, 21 Jun 2022 06:25:21 -0700 (PDT)
Received: from code-infra-dev-cbj.ea134 ([140.205.70.41])
        by smtp.gmail.com with ESMTPSA id f8-20020a170902684800b0016a058b7547sm8602426pln.294.2022.06.21.06.25.18
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Jun 2022 06:25:20 -0700 (PDT)
From:   Teng Long <dyroneteng@gmail.com>
To:     dyroneteng@gmail.com
Cc:     avarab@gmail.com, derrickstolee@github.com, git@vger.kernel.org,
        gitster@pobox.com, me@ttaylorr.com, tenglong.tl@alibaba-inc.com
Subject: [PATCH v3 3/5] pack-bitmap.c: make warnings support i18N when opening bitmap
Date:   Tue, 21 Jun 2022 21:25:03 +0800
Message-Id: <d8dfe53dd47b05aa55cfa2ce9eed428212fd17b8.1655817253.git.dyroneteng@gmail.com>
X-Mailer: git-send-email 2.35.1.582.g270d558070.dirty
In-Reply-To: <cover.1655817253.git.dyroneteng@gmail.com>
References: <cover.1655817253.git.dyroneteng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When calling the "open_midx_bitmap_1()" or "open_pack_bitmap_1()", there
will be a warning if a normal bitmap or MIDX bitmap already has been
opened, then let's make the warning text supporting for translation.

Discussion in community:

  1. https://public-inbox.org/git/YkPGq0mDL4NG6D1o@nand.local/#t
  2. https://public-inbox.org/git/220330.868rsrpohm.gmgdl@evledraar.gmail.com/

Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Teng Long <dyroneteng@gmail.com>
---
 pack-bitmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index f13a6bfe3a..af0f41833e 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -330,7 +330,7 @@ static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
 		struct strbuf buf = STRBUF_INIT;
 		get_midx_filename(&buf, midx->object_dir);
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", buf.buf);
+		warning(_("ignoring extra bitmap file: %s"), buf.buf);
 		close(fd);
 		strbuf_release(&buf);
 		return -1;
@@ -387,7 +387,7 @@ static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
 
 	if (bitmap_git->pack || bitmap_git->midx) {
 		/* ignore extra bitmap file; we can only handle one */
-		warning("ignoring extra bitmap file: %s", packfile->pack_name);
+		warning(_("ignoring extra bitmap file: %s"), packfile->pack_name);
 		close(fd);
 		return -1;
 	}
-- 
2.35.1.582.g270d558070.dirty

