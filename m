Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5C7B820259
	for <e@80x24.org>; Tue,  6 Dec 2016 12:55:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752747AbcLFMyA (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Dec 2016 07:54:00 -0500
Received: from mail-pg0-f67.google.com ([74.125.83.67]:35533 "EHLO
        mail-pg0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751686AbcLFMx7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Dec 2016 07:53:59 -0500
Received: by mail-pg0-f67.google.com with SMTP id p66so19825871pga.2
        for <git@vger.kernel.org>; Tue, 06 Dec 2016 04:53:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PFL7uxR03C4elFIHG7/F8w6EmU1p1THZm2PH2jAvsCo=;
        b=RfdBHGn7l5hB1O4+6EXoQCBp2o4bEoPPTmdv3iRRoqZbs6l1ROL8wfjAc2A9LYT7kK
         XuNAzkQtO61rWIB/Fowbf6i8CIfk5ZiYorljKwew2EdTbyPo3pw6FZFQuM6Vvvz7gWNa
         XKZ0Q4IaOCuJxGbn6LqPxcf2zxJIp1w1/qcsPd114Wrtm/OVqaMODQhKC2LGDExBwTrX
         8fRPUznBww81F9YDxMbvwmbbb3gje754pCQ5593CSkhtLzj/JHEfjV5Uy5AwMIaVv88n
         uydB2C+gDXDB5aIoN/6w5/RGcYPJLYFoQG9geFv3jZp4LSMOK/aRnh+aE1mvxaASsaPD
         6K5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PFL7uxR03C4elFIHG7/F8w6EmU1p1THZm2PH2jAvsCo=;
        b=D9nylAnGP+OXPIKHG4d9+UzRh7oRglJCj7/kcbIk3lQQWo91ock9g1qtTy8T6uyf0i
         v9sJNmVAsG5+ESkaX96en8o0sLxx16FjEx8n/oHQC6ySSsyWo6pGLGBx4jQL1sbKwILg
         naRQQoVqbRE5cKeq20OXUf+diGQ/G0kN77fthl3RjIyZAZPRoeXktBGy3j7CbWia89on
         OtmBTiqEytYqxqHPGKRlZYjAfy8ImZU25UIjNmhiJNKYU7U/RHWZtB1dTZP9uuz8WM4I
         2zsm3RZ2ujq2rXfHkGsR7PSWRLGMXMIa1mlKv8kHepY/s+0OIyleG5whsx36g2bDMNIa
         t4dA==
X-Gm-Message-State: AKaTC00BIzFn9uvJhsveeM4aGAEwCGSnn2XgYlIn7L0ocZBR9/NMvBtS3kRignB3EGq1og==
X-Received: by 10.84.218.72 with SMTP id f8mr136698531plm.141.1481028838714;
        Tue, 06 Dec 2016 04:53:58 -0800 (PST)
Received: from ash ([115.73.166.29])
        by smtp.gmail.com with ESMTPSA id p25sm34900271pfk.20.2016.12.06.04.53.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 06 Dec 2016 04:53:57 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Tue, 06 Dec 2016 19:53:52 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     rv@rasmusvillemoes.dk, Jeff King <peff@peff.net>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 1/6] shallow.c: rename fields in paint_info to better express their purposes
Date:   Tue,  6 Dec 2016 19:53:34 +0700
Message-Id: <20161206125339.16803-2-pclouds@gmail.com>
X-Mailer: git-send-email 2.8.2.524.g6ff3d78
In-Reply-To: <20161206125339.16803-1-pclouds@gmail.com>
References: <1480710664-26290-1-git-send-email-rv@rasmusvillemoes.dk>
 <20161206125339.16803-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

paint_alloc() is basically malloc(), tuned for allocating a fixed number
of bits on every call without worrying about freeing any individual
allocation since all will be freed at the end. It does it by allocating
a big block of memory every time it runs out of "free memory". "slab" is
a poor choice of name, at least poorer than "pool".

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 shallow.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/shallow.c b/shallow.c
index 4d0b005..8100dfd 100644
--- a/shallow.c
+++ b/shallow.c
@@ -434,9 +434,9 @@ define_commit_slab(ref_bitmap, uint32_t *);
 struct paint_info {
 	struct ref_bitmap ref_bitmap;
 	unsigned nr_bits;
-	char **slab;
+	char **pools;
 	char *free, *end;
-	unsigned slab_count;
+	unsigned pool_count;
 };
 
 static uint32_t *paint_alloc(struct paint_info *info)
@@ -444,11 +444,11 @@ static uint32_t *paint_alloc(struct paint_info *info)
 	unsigned nr = (info->nr_bits + 31) / 32;
 	unsigned size = nr * sizeof(uint32_t);
 	void *p;
-	if (!info->slab_count || info->free + size > info->end) {
-		info->slab_count++;
-		REALLOC_ARRAY(info->slab, info->slab_count);
+	if (!info->pool_count || info->free + size > info->end) {
+		info->pool_count++;
+		REALLOC_ARRAY(info->pools, info->pool_count);
 		info->free = xmalloc(COMMIT_SLAB_SIZE);
-		info->slab[info->slab_count - 1] = info->free;
+		info->pools[info->pool_count - 1] = info->free;
 		info->end = info->free + COMMIT_SLAB_SIZE;
 	}
 	p = info->free;
@@ -624,9 +624,9 @@ void assign_shallow_commits_to_refs(struct shallow_info *info,
 		post_assign_shallow(info, &pi.ref_bitmap, ref_status);
 
 	clear_ref_bitmap(&pi.ref_bitmap);
-	for (i = 0; i < pi.slab_count; i++)
-		free(pi.slab[i]);
-	free(pi.slab);
+	for (i = 0; i < pi.pool_count; i++)
+		free(pi.pools[i]);
+	free(pi.pools);
 	free(shallow);
 }
 
-- 
2.8.2.524.g6ff3d78

