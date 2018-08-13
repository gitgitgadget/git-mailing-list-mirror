Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4BF7D1F404
	for <e@80x24.org>; Mon, 13 Aug 2018 16:15:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730054AbeHMS6h (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:58:37 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36344 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729943AbeHMS6h (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:58:37 -0400
Received: by mail-lj1-f195.google.com with SMTP id u7-v6so13057281lji.3
        for <git@vger.kernel.org>; Mon, 13 Aug 2018 09:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xu9cRu6hrFyZY44tipp1ZOQEpKMslLFH4Llf2hIvQNo=;
        b=QZcugzNL0gDO4vZufcmGAgs9qrTPaF//a2yk78+rYxK6Bp8D6iplcsI8LuDzYpraPs
         6IsqZKxdZlSNB4R8igLZUiZraKgWEY23/HFPrbktuvp1nJHNe/FpwPIUjLncndL1VVXM
         BKnDkG0keCkGNZ6JCuFuZJ8tQSsIpBQ1hTrCEADP4KsgBMsVGYM9pSf/jOnJwHg8xOMX
         GysoN6PFe4nwP3saAjNdSo/i6sgDmPkFXy3WDevV+F755DkYgUp93tbMT3eYZOp7W0Ln
         Ci3Z8NfK3mSixXHeE9zB08mjnxokdB6vEGYVZfSYCgB6K7VuR1tcF8kkFeBKuSQOTRtp
         MFOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xu9cRu6hrFyZY44tipp1ZOQEpKMslLFH4Llf2hIvQNo=;
        b=RnU6/GbXbHGFh8vhhvEsxvZTmhqBJAyjb54VzD49tcgN+W9q41Y8la06lRwSAcmUjB
         0nvlgycYrD02+aOn0Pr7lcD/j4Lq8L6Wi4QK+RlJ101xaQxAqP40Eb0rawahyUYcieXf
         HH4zGxFxR9YbEnu/Uwh2RsfDxrOwaRTnFH6fKjqnPbx+s0eQZ6VmqLc0aNXZPdYusnXO
         RRk5Q31iq9pi3hyLanvHBkc0lcnEZLh3EbtXG9YjOiZr6ZiIM5rcjVVMSxE+JCu5feQ4
         fcYaynxHL6en2ODwUaOQPVJ1/zwTPlwh9Tsf9VG/KOpLZwevsnjy9zE/lTiIwtj4vfGz
         lqUg==
X-Gm-Message-State: AOUpUlG6I4RoM6r75IKid1MTUXA7QKiSBAHJktFQuKCHdBUmAWRZZD5C
        SULM/jL1LmlWYeXbQ7yJP4qb2oeh
X-Google-Smtp-Source: AA+uWPzVZUgoo7LAo7GLiknBsex7IIQ5y9OeexN8BoNq8afch7Ap0SWW+T5nGXefRDGQQHYKUipvuA==
X-Received: by 2002:a2e:91d6:: with SMTP id u22-v6mr12288664ljg.64.1534176941930;
        Mon, 13 Aug 2018 09:15:41 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id d14-v6sm3066031ljc.56.2018.08.13.09.15.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Aug 2018 09:15:40 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 20/24] resolve-undo.c: use the right index instead of the_index
Date:   Mon, 13 Aug 2018 18:14:37 +0200
Message-Id: <20180813161441.16824-21-pclouds@gmail.com>
X-Mailer: git-send-email 2.18.0.1004.g6639190530
In-Reply-To: <20180813161441.16824-1-pclouds@gmail.com>
References: <20180813161441.16824-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 resolve-undo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/resolve-undo.c b/resolve-undo.c
index d2e2d22b7f..236320f179 100644
--- a/resolve-undo.c
+++ b/resolve-undo.c
@@ -188,7 +188,7 @@ void unmerge_index(struct index_state *istate, const struct pathspec *pathspec)
 
 	for (i = 0; i < istate->cache_nr; i++) {
 		const struct cache_entry *ce = istate->cache[i];
-		if (!ce_path_match(&the_index, ce, pathspec, NULL))
+		if (!ce_path_match(istate, ce, pathspec, NULL))
 			continue;
 		i = unmerge_index_entry_at(istate, i);
 	}
-- 
2.18.0.1004.g6639190530

