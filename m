Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B10AC32771
	for <git@archiver.kernel.org>; Thu, 22 Sep 2022 02:52:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230391AbiIVCwZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Sep 2022 22:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiIVCwW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Sep 2022 22:52:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED97AD9A1
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 19:52:17 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id d14so3154461ilf.2
        for <git@vger.kernel.org>; Wed, 21 Sep 2022 19:52:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ORUw1M4/r57tRC4z/LqlWiAqvs/D8MT1kD9glOZz/Os=;
        b=VGlJM27RxsZodXMmfGqtqdeFFpM4V6Kjv0rY6c/ldTluAIVgxu1ap0dWp+kNhnL9nz
         Rw7JuBss/B3izM+EdNbIgVtHAlCSQ+K9qkTi0YgE3HPcccwPg0iyHe/kVEkativToeBf
         LtvC+5QaReqhchlnRYs78H52kNkZEQjeFuscYAi6TM597ra0xRI5RafeCvlKi4mbCWAC
         E39zBJACx2vQZqFt9O6fWjbqxOpjApsC4mQnmJUBCsK5ewzUyUvfBiBCDm956TVXyj1J
         ania5Y8cgwD6Bu09Vp7Rnju5tbrbSTzznxKLWWZ7D/bGKijD8+PjRu9DA+oCJxUsY+93
         NHgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ORUw1M4/r57tRC4z/LqlWiAqvs/D8MT1kD9glOZz/Os=;
        b=Qhh4QTjjVeFzRJNmGMYxuXtKlrROnZvtjDN352dZflZeat6pUBzNs1kzzeuvg0ayMi
         9KiLKnl8C2CHDR/otQNzXgvEh4yRnyIn09qetr7eQestFbwbd6JzEQ5NQol50RsLccKt
         XFITVHLh2ingw9RCEAORe0oEsQvLTdrB9KKaYWnNuSUfEWJdztk93OCTmb5U2lSvVS2M
         cnuVeITyVK/vmd5tuOrKbmWtRzRdcmtmB+ELpITQda/tYL44mZZqcv+g1Z/sHs8EKlsd
         g6hRAHKbjgvTD54rblciU44PBeVpGTof1NMO7jSu04GFhUfQbTkeqdTIQDdF5EvwGejR
         Yk7g==
X-Gm-Message-State: ACrzQf0AkPPrslZCGtJGWpXFUjF6hHHNyUqrKjcmCrj1ra/HNKNsc2cN
        lM3pudfO8FYYyKbEMbX7ixxk6h5U8+U=
X-Google-Smtp-Source: AMsMyM5VHaslxpyzRdWjjm5mty4J4DZqxt2PY8RXV5KKevq3DfNxniIheAJkj4HbCllTefr1Uz9ISg==
X-Received: by 2002:a92:d08e:0:b0:2f6:183:f602 with SMTP id h14-20020a92d08e000000b002f60183f602mr571393ilh.243.1663815136403;
        Wed, 21 Sep 2022 19:52:16 -0700 (PDT)
Received: from xavier.localdomain (75-169-14-186.slkc.qwest.net. [75.169.14.186])
        by smtp.gmail.com with ESMTPSA id q2-20020a02a982000000b0034a6d12aa25sm1712382jam.4.2022.09.21.19.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Sep 2022 19:52:15 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, chakrabortyabhradeep79@gmail.com,
        me@ttaylorr.com, kaartic.sivaraam@gmail.com, gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] pack-bitmap: improve grammar of "xor chain" error message
Date:   Wed, 21 Sep 2022 20:51:58 -0600
Message-Id: <20220922025158.415969-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 pack-bitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 9a208abc1f..9d5205055a 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -723,7 +723,7 @@ static struct stored_bitmap *lazy_bitmap_for_commit(struct bitmap_index *bitmap_
 		ALLOC_GROW(xor_items, xor_items_nr + 1, xor_items_alloc);
 
 		if (xor_items_nr + 1 >= bitmap_git->entry_count) {
-			error(_("corrupt bitmap lookup table: xor chain exceed entry count"));
+			error(_("corrupt bitmap lookup table: xor chain exceeds entry count"));
 			goto corrupt;
 		}
 
-- 
2.37.3

