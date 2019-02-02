Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 861A11F453
	for <e@80x24.org>; Sat,  2 Feb 2019 13:31:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728225AbfBBNbK (ORCPT <rfc822;e@80x24.org>);
        Sat, 2 Feb 2019 08:31:10 -0500
Received: from mail-pg1-f193.google.com ([209.85.215.193]:43152 "EHLO
        mail-pg1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727961AbfBBNbI (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Feb 2019 08:31:08 -0500
Received: by mail-pg1-f193.google.com with SMTP id v28so4288998pgk.10
        for <git@vger.kernel.org>; Sat, 02 Feb 2019 05:31:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Jk4bKCwkogKKQ34axZb1eDG5+hZ7gRU3tZhU8knyD2w=;
        b=dS4AS6z2U9SLDHhRI02TPCujNl9lnQAKAuBzEsTuDJoIy+1WlSEy1D2UJg2oCCsIkZ
         9MTA/XXbFVyBsIV4JvDwlQufyaHZjzBSibCnlz+4s0AYpcjuzyqpZVAvGAiUDPfcS9rL
         CgLWIlxwJ0HTPCPbZWuGOj1WAxg2pBizTMFQM4AmciAzCT5/sfjChkX3z/ZVp0nbSKrb
         VvlT9sSNaWfyObE2KOxuz6y4CkKvbtWA9C4P489x/MYfSXQIxLnRpgkaBNZgz9b7VpBZ
         og3LXNH7Cl3P8sYzGHoNGiAe2bXonSPWP7nFEhAXY7t/Hpk37TkR2NVCwpqJjrF2Gu2w
         pZOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Jk4bKCwkogKKQ34axZb1eDG5+hZ7gRU3tZhU8knyD2w=;
        b=JRAaHsRtrRkwgVSmtkbjg0ZSpG6LF6JQ7wZwTE/DGhSMX264SUXTpxvjTdy5ITzaTV
         tg3mIlGGS/6eY4HH4N1FA+uCyRctqFXPhtvGPTaHGDeI085W/SabK8dWyWCj0CwLyGwD
         EMsWPJuKzrQv0wu+5FS1BZjXXbLiAr7VXakjwT+68WKJ56ekPPC6iQF0hYEhztQAdFHr
         2aPgc7Ik1CNd8LjbxOItQBn753oOq0mtws8u+H/lMfHmO4t5/N+OWU4QwGFUgvlvg7kp
         ugz+r9YLPOw7HHGQ6iNBNz4ZlSE3zEYU/J4KW4i+eZ/uUCKPRUe0BndQVxd2wE4cordm
         tsbA==
X-Gm-Message-State: AHQUAuZqj2DyIVYSQm6DN8tj7o38Lrgv0satCcHwElsgt6WcSNC0NHvg
        CxxmWDarzvOOdrPchVLYW8g=
X-Google-Smtp-Source: AHgI3IYD0tLvXfd9yYfIoGEA7RV5DM7kKyd86gn48HfMr7ZWKxLeTZfJMhY6sFdqPRphGERiN/7ZiQ==
X-Received: by 2002:a63:f109:: with SMTP id f9mr6095341pgi.286.1549114268105;
        Sat, 02 Feb 2019 05:31:08 -0800 (PST)
Received: from localhost.localdomain ([2408:84e1:c5:f1ee:7c5c:7512:51d2:8f91])
        by smtp.gmail.com with ESMTPSA id t21sm12580010pgg.24.2019.02.02.05.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 02 Feb 2019 05:31:07 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Sun Chao <sunchao9@huawei.com>
Cc:     Jiang Xin <worldhello.net@gmail.com>,
        Sun Chao <16657101987@163.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>
Subject: [PATCH v10 3/6] pack-redundant: delete redundant code
Date:   Sat,  2 Feb 2019 21:30:14 +0800
Message-Id: <20190202133017.1039-4-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.20.1.103.ged0fc2ca7b
In-Reply-To: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
References: <CAPig+cQh5TDKVaDi0gg9LZTo1Og_Qw6S2sH9cPABR9q05gEUfg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Sun Chao <sunchao9@huawei.com>

The objects in alt-odb are removed from `all_objects` twice in `load_all_objects`
and `scan_alt_odb_packs`, remove it from the later function.

Signed-off-by: Sun Chao <sunchao9@huawei.com>
Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 builtin/pack-redundant.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/pack-redundant.c b/builtin/pack-redundant.c
index f7dab0ec60..4a06f057dd 100644
--- a/builtin/pack-redundant.c
+++ b/builtin/pack-redundant.c
@@ -545,7 +545,6 @@ static void scan_alt_odb_packs(void)
 							alt->all_objects);
 			local = local->next;
 		}
-		llist_sorted_difference_inplace(all_objects, alt->all_objects);
 		alt = alt->next;
 	}
 }
-- 
2.20.1.103.ged0fc2ca7b

