Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A56B1F453
	for <e@80x24.org>; Sat,  3 Nov 2018 08:49:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727689AbeKCR7q (ORCPT <rfc822;e@80x24.org>);
        Sat, 3 Nov 2018 13:59:46 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42829 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726550AbeKCR7q (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 3 Nov 2018 13:59:46 -0400
Received: by mail-lj1-f195.google.com with SMTP id f3-v6so3716215ljk.9
        for <git@vger.kernel.org>; Sat, 03 Nov 2018 01:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HIuouUZtGpLfggu6yazomKtoLyzAYkfMX0xVLEOsNn4=;
        b=Kkvv1EKgq7HKL2cS3zO25Ck269b2pvlt4qZYdrXP71Vzg7hElkCO0uOhujAD7LTBL0
         BRLh1YZi3TYymjg74QSmR9PwQ1SRTBsqvR7+0JzbTjHWSCNViY1n+mgFZNg8KmfbcyLA
         h/SI4AwANtiqrNikqvySNoTc71vCNvOmMVj8W2YMXiECniZQJkAtkyq8EXw0HH3cibse
         miVRLfu+JqGNkzvUF+LiFJuRQIv1njCgOS/iaIxLCzYR1v0LzXAglZNvxG0HjzaoNX+I
         3VfNdS82oxjK1gGQM7q4Z5E42Cbec8vE3eMpRCfnSASDDCYTYSOW+AYfiT+HYdLsJNpn
         /Z9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HIuouUZtGpLfggu6yazomKtoLyzAYkfMX0xVLEOsNn4=;
        b=N7UIpOwp8ArFMrQiGYWv/oNxlre/HTu2t25iQ5h1Yy/vNX0yTbKhGLZy/BBrczfPit
         7hcwzSOTyqn4aExaNCIaYIzm2AoNB4ETz0D/mAHE6vFpD2BDr/i7zZdAIHpv2s8dF3xk
         X1BP5B14d7oyAZpGN4y5gdROQ1c49rrMNuyY0Evdonpt+HGSIM0wgmRoNw84HPELf/lb
         SqXd6FXt+LeVWT6DbzOsVtXzG/DxuyUodvgZzyrLlMbDvPa39mwUU4uEN5P2NYYnWZB3
         /gJFG0iVrBJVB40mb2FT7PcpoREu8Whntu+7NTTriZUO1AFyKHQQ31bbdLKrI094gvEy
         VEOg==
X-Gm-Message-State: AGRZ1gJJdYxQHxZHOHlOtShDLkqYl1mEQjszoI0A78PYhuLrPATJgNhd
        sqxE50XnvAEaWXx3KSGL2W4=
X-Google-Smtp-Source: AJdET5cC3ri/m40j1HO0DTvnUh7HoGjApSFjUC36Qw7bybNKIk3OZrxrB7Uef/yrG6uG8346RV8kAg==
X-Received: by 2002:a2e:87da:: with SMTP id v26-v6mr10415637ljj.13.1541234948284;
        Sat, 03 Nov 2018 01:49:08 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id s191-v6sm657373lfe.17.2018.11.03.01.49.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 03 Nov 2018 01:49:07 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, peartben@gmail.com,
        peff@peff.net
Subject: [PATCH v3 06/14] attr.c: remove #ifdef NO_PTHREADS
Date:   Sat,  3 Nov 2018 09:48:42 +0100
Message-Id: <20181103084850.9584-7-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1005.gac84295441
In-Reply-To: <20181103084850.9584-1-pclouds@gmail.com>
References: <20181027173008.18852-1-pclouds@gmail.com>
 <20181103084850.9584-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 attr.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/attr.c b/attr.c
index 60d284796d..eaece6658d 100644
--- a/attr.c
+++ b/attr.c
@@ -41,23 +41,17 @@ const char *git_attr_name(const struct git_attr *attr)
 
 struct attr_hashmap {
 	struct hashmap map;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 };
 
 static inline void hashmap_lock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&map->mutex);
-#endif
 }
 
 static inline void hashmap_unlock(struct attr_hashmap *map)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&map->mutex);
-#endif
 }
 
 /*
@@ -498,23 +492,17 @@ static struct check_vector {
 	size_t nr;
 	size_t alloc;
 	struct attr_check **checks;
-#ifndef NO_PTHREADS
 	pthread_mutex_t mutex;
-#endif
 } check_vector;
 
 static inline void vector_lock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_lock(&check_vector.mutex);
-#endif
 }
 
 static inline void vector_unlock(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_unlock(&check_vector.mutex);
-#endif
 }
 
 static void check_vector_add(struct attr_check *c)
@@ -1181,8 +1169,6 @@ void git_all_attrs(const struct index_state *istate,
 
 void attr_start(void)
 {
-#ifndef NO_PTHREADS
 	pthread_mutex_init(&g_attr_hashmap.mutex, NULL);
 	pthread_mutex_init(&check_vector.mutex, NULL);
-#endif
 }
-- 
2.19.1.1005.gac84295441

