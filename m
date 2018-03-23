Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DA721F404
	for <e@80x24.org>; Fri, 23 Mar 2018 17:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751479AbeCWRWu (ORCPT <rfc822;e@80x24.org>);
        Fri, 23 Mar 2018 13:22:50 -0400
Received: from mail-lf0-f66.google.com ([209.85.215.66]:34072 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751857AbeCWRVw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Mar 2018 13:21:52 -0400
Received: by mail-lf0-f66.google.com with SMTP id c78-v6so14702847lfh.1
        for <git@vger.kernel.org>; Fri, 23 Mar 2018 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=au1XsnPa/OQbodCahwZuQ6rdqfIWIMY04CzscGGaX7Y=;
        b=sEB3t9jWTIyn+Bs5LKLz1m0oMxaKiTjAMA0ajllMleRhA3H9kHKX/09nYBXH0Waca2
         2fz7vtMHOv4LJIX2RywMqFQ/q2BYmWpL+7t8nQqgjrdMT3WxqyHbzO7ctKCIGCIYH229
         hjzc0qxwjqh6RmAe4Mgh/4j+JM/SMzSg2igBmlNwCOXPqm5RacefIv1CjNmv54Wjdv7Q
         REKlC3mtXcl560r5uv/DVoNh7hQT4JCkly8BV49KwwwjmokdDubqNRMN4PluQBExopIS
         prCvtkt5z3dU86YZMaPYUISCBM1EEj6NcXBGNR9fQm7gfppRp3apWOtgUjt+mFWt+i2z
         YJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=au1XsnPa/OQbodCahwZuQ6rdqfIWIMY04CzscGGaX7Y=;
        b=Nt9SRG6HeZ5GUmu+WoGXacvEyu5FhSSS6OOwzyruSXQB6QMBp9b250NN5YBfvPF+4l
         Tq2uTUsTqyWWeIwyE/No2xTIqnin0MPdnOTtFXA10THRzC91i8DoRlNnFDVDrUhKG7Wc
         cOggb60/Kle1G3ATmuPqkigYzYBFfh+0LiAm9AybJ7G0Yh6mo8Aud8VMlu+YlahOACuk
         1DldV586Eww3/bQ9XXY+Cw6ZBxslREUgetk2MtkYuU121STcbgMklHBJk/1Q2oFkCG8/
         uCVBV6yYjNYR1JxfBLGbcNv/viZJSe9vguUmjMJUY1e7O/UD2RlDeW8NRe/scBCGf/h0
         Ho0A==
X-Gm-Message-State: AElRT7ESki/dchQiRGIj+XmBHIdLrXGJAuoj7H5B6abUN1KaXNwqrPjB
        Tbof6caTu3MTxC1GRqIv+5A=
X-Google-Smtp-Source: AG47ELvFsyJ8ZuTj7pEsWVS0M8YfV6Rm/nNffLnLMKVF3GKJBxCu/gw0c+t19hAi+RLniPj14VmV2w==
X-Received: by 10.46.16.85 with SMTP id j82mr17974113lje.139.1521825710413;
        Fri, 23 Mar 2018 10:21:50 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g13sm1973028lja.65.2018.03.23.10.21.49
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 23 Mar 2018 10:21:49 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com,
        Brandon Williams <bmwill@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/27] pack: move approximate object count to object store
Date:   Fri, 23 Mar 2018 18:21:02 +0100
Message-Id: <20180323172121.17725-9-pclouds@gmail.com>
X-Mailer: git-send-email 2.17.0.rc0.348.gd5a49e0b6f
In-Reply-To: <20180323172121.17725-1-pclouds@gmail.com>
References: <20180303113637.26518-1-pclouds@gmail.com>
 <20180323172121.17725-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

The approximate_object_count() function maintains a rough count of
objects in a repository to estimate how long object name abbreviates
should be.  Object names are scoped to a repository and the
appropriate length may differ by repository, so the object count
should not be global.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 object-store.h |  8 ++++++++
 packfile.c     | 11 +++++------
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/object-store.h b/object-store.h
index 6a07a14d63..b53e125902 100644
--- a/object-store.h
+++ b/object-store.h
@@ -99,6 +99,14 @@ struct raw_object_store {
 	/* A most-recently-used ordered version of the packed_git list. */
 	struct list_head packed_git_mru;
 
+	/*
+	 * A fast, rough count of the number of objects in the repository.
+	 * These two fields are not meant for direct access. Use
+	 * approximate_object_count() instead.
+	 */
+	unsigned long approximate_object_count;
+	unsigned approximate_object_count_valid : 1;
+
 	/*
 	 * Whether packed_git has already been populated with this repository's
 	 * packs.
diff --git a/packfile.c b/packfile.c
index 2a053711cf..b0b24ea9b8 100644
--- a/packfile.c
+++ b/packfile.c
@@ -803,8 +803,6 @@ static void prepare_packed_git_one(char *objdir, int local)
 	strbuf_release(&path);
 }
 
-static int approximate_object_count_valid;
-
 /*
  * Give a fast, rough count of the number of objects in the repository. This
  * ignores loose objects completely. If you have a lot of them, then either
@@ -814,8 +812,8 @@ static int approximate_object_count_valid;
  */
 unsigned long approximate_object_count(void)
 {
-	static unsigned long count;
-	if (!approximate_object_count_valid) {
+	if (!the_repository->objects->approximate_object_count_valid) {
+		unsigned long count;
 		struct packed_git *p;
 
 		prepare_packed_git();
@@ -825,8 +823,9 @@ unsigned long approximate_object_count(void)
 				continue;
 			count += p->num_objects;
 		}
+		the_repository->objects->approximate_object_count = count;
 	}
-	return count;
+	return the_repository->objects->approximate_object_count;
 }
 
 static void *get_next_packed_git(const void *p)
@@ -901,7 +900,7 @@ void prepare_packed_git(void)
 
 void reprepare_packed_git(void)
 {
-	approximate_object_count_valid = 0;
+	the_repository->objects->approximate_object_count_valid = 0;
 	the_repository->objects->packed_git_initialized = 0;
 	prepare_packed_git();
 }
-- 
2.17.0.rc0.348.gd5a49e0b6f

