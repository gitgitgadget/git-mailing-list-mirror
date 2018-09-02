Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 74B251F404
	for <e@80x24.org>; Sun,  2 Sep 2018 07:43:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbeIBL54 (ORCPT <rfc822;e@80x24.org>);
        Sun, 2 Sep 2018 07:57:56 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:46844 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726006AbeIBL54 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Sep 2018 07:57:56 -0400
Received: by mail-lf1-f65.google.com with SMTP id e23-v6so12899431lfc.13
        for <git@vger.kernel.org>; Sun, 02 Sep 2018 00:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=G/4G5fm6B7vrC9rqry0ObpxhiJPQpgZqf0vP6BWJBvU=;
        b=JEEXtl8fgzaNIpKRq4G3Oi4MYbwWqEbpuVo1n9mcmKDrxORoCn1OBnXuCtRt38RQ9x
         /sKMWLd36TMNdDCJjBPBPpzrBA2cmygKavO2zfqPMmFd0VR2jT+GvRbbcUOTz29TEVST
         TqkCL4CdYTKsfVqexM7d+aWHsq2cvY6j2KVibLMa4tQ2d+dxQ17Zx2KFaXgRXuw+PknS
         k2Q5nBafPGkM+FcBn1BezP4lP8mi0tc1E7yAnP13ZLXJ1mac9QpNzNb31wraHMBqT9sh
         1dcnPFDeV5UCXjbS/dpFBLKi/wZFhiIdmF1Josj0ShmjygyPU+lJjkN6ILn7laPAq+oH
         ppcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=G/4G5fm6B7vrC9rqry0ObpxhiJPQpgZqf0vP6BWJBvU=;
        b=lgrlbaIkZE6vapKJQQ7ew9iV+IRBTJO0NT4iHDgMKAZlp0TFvNSuWbvhQlyayo6NLx
         x2sn3zw4npIMQ7xNzBHhhXgsNGy1YsAl6lMB1vEBSZK/DnrIJXQrFC5GTkDOxou1lXBP
         F1WY5EsfU/fTadJiwmUC4MpgYnJbRlT40vibgpCZ6pJ4Mbyi6Lujhq4HqNylxGpPKnoV
         ReUzaf63qY9skutjVL6v+/3cm4qQaADOM1Qyhs8IoXOFbLwJDnm8P3kUJn/PrUohzuNO
         1V5XfypxI3dmgGmcVj0H62NlxkEjpbt6VJuM+AP+mCIIkXjmdrBu0o0DfM0c2TmsYSeg
         Ax9w==
X-Gm-Message-State: APzg51BPMQuzyrY25qMmDOqviD2iLUXrN0Vn/szVt2V7NcmKd2Es/KOo
        zpoVrUgRpHTVSWGCluHKWAg=
X-Google-Smtp-Source: ANB0VdbpBlh7akB/2J7kKbKnIqcGoJHM7rrUtLRLaWL2YUlUCuZ1a5Y7KHMGIlY/7+zRAyf7Xb4cHQ==
X-Received: by 2002:a19:c4c9:: with SMTP id u192-v6mr13832518lff.87.1535874184102;
        Sun, 02 Sep 2018 00:43:04 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id p17-v6sm2690244ljg.64.2018.09.02.00.43.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 02 Sep 2018 00:43:03 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     christian.couder@gmail.com, git@vger.kernel.org, gitster@pobox.com,
        haraldnordgren@gmail.com, johannes.schindelin@gmx.de,
        tiagonbotelho@gmail.com, tiagonbotelho@hotmail.com
Subject: [PATCH] bisect.c: make show_list() build again
Date:   Sun,  2 Sep 2018 09:42:50 +0200
Message-Id: <20180902074250.6802-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
References: <CACsJy8AFo+mb8R-O-JKRPZk__csq6mbVXbnZhSd-nZ08zWfSeg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function only compiles when DEBUG_BISECT is 1, which is often not
the case. As a result there are two commits [1] [2] that break it but
the breakages went unnoticed because the code did not compile by
default. Update the function and include the new header file to make this
function build again.

In order to stop this from happening again, the function is now
compiled unconditionally but exits early unless DEBUG_BISECT is
non-zero. A smart compiler generates no extra code (not even a
function call). But even if it does not, this function does not seem
to be in a hot path that the extra cost becomes a big problem.

[1] bb408ac95d (bisect.c: use commit-slab for commit weight instead of
    commit->util - 2018-05-19)

[2] cbd53a2193 (object-store: move object access functions to
    object-store.h - 2018-05-15)

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 bisect.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/bisect.c b/bisect.c
index e1275ba79e..e65f6821b8 100644
--- a/bisect.c
+++ b/bisect.c
@@ -13,6 +13,7 @@
 #include "sha1-array.h"
 #include "argv-array.h"
 #include "commit-slab.h"
+#include "object-store.h"
 
 static struct oid_array good_revs;
 static struct oid_array skipped_revs;
@@ -120,14 +121,14 @@ static inline int halfway(struct commit_list *p, int nr)
 	}
 }
 
-#if !DEBUG_BISECT
-#define show_list(a,b,c,d) do { ; } while (0)
-#else
 static void show_list(const char *debug, int counted, int nr,
 		      struct commit_list *list)
 {
 	struct commit_list *p;
 
+	if (!DEBUG_BISECT)
+		return;
+
 	fprintf(stderr, "%s (%d/%d)\n", debug, counted, nr);
 
 	for (p = list; p; p = p->next) {
@@ -145,7 +146,7 @@ static void show_list(const char *debug, int counted, int nr,
 			(flags & TREESAME) ? ' ' : 'T',
 			(flags & UNINTERESTING) ? 'U' : ' ',
 			(flags & COUNTED) ? 'C' : ' ');
-		if (commit->util)
+		if (*commit_weight_at(&commit_weight, p->item))
 			fprintf(stderr, "%3d", weight(p));
 		else
 			fprintf(stderr, "---");
@@ -160,7 +161,6 @@ static void show_list(const char *debug, int counted, int nr,
 		fprintf(stderr, "\n");
 	}
 }
-#endif /* DEBUG_BISECT */
 
 static struct commit_list *best_bisection(struct commit_list *list, int nr)
 {
-- 
2.19.0.rc0.337.ge906d732e7

