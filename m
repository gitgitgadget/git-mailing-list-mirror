Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C4AF1F404
	for <e@80x24.org>; Sun, 26 Aug 2018 10:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726826AbeHZNpf (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Aug 2018 09:45:35 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:46420 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726680AbeHZNpe (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Aug 2018 09:45:34 -0400
Received: by mail-lj1-f196.google.com with SMTP id 203-v6so9988793ljj.13
        for <git@vger.kernel.org>; Sun, 26 Aug 2018 03:03:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=aQalyKGKrrbx/RI29EwFqoa8thUsfQ0TaLhfQ+UPzn4kNM0z7w24Dl42zEHiKq+1Ai
         W7Z1y6sBmxTjQHXbAEOVLuc8jOwZ2mkfF8Oa+j/30O2rSvn08mu5W3BOocgGG9wiNcr2
         lnljgX+7346/Hs7HUZN7qq0mgLvQXj6lvWXLJ/eFE5h7nOefcevzDAUsNsLyQMa08cV2
         jNGQs2OoT7PgPq8D0YWpLfErE+i2mj/M2Q2UsBih51F2UaAHhhSl25QXeIaQiaQelKgx
         YWXIaTmeMnSzvIFLeVujMTwG39nmKog3B406fYcry3a3Jh9bKjjHjwZENN1QQLhKGk4l
         gJvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=LT2dr7NAlxrTSVdnLolHU/aFflNn4zbN+yjZbUQ4vp/Jeb9asboooYaGfX4ltnfI3o
         QgtLGYj5jWMX8oxgFwTYbnTlA4RTcCDh7HsvQKiyxgxvBCdSSCwnH58t/BVwbmpxar4T
         kMNChvXcFSlUu65P9wBiX7zNfQ+51S/46LBm4TbuDOBzS6KFJ3fjfFlb5+nuLVBYilLB
         C5Y/5Q+6aUs5qssEJ6NzTiR4/02P0PVqEG/1+WVviCJhSLwHVYH4O2vxtr2oEdJOatua
         SOMPhk1s+oGSL9duAE8255TSOKPti6yUlGZEdyKwdma9aqtW4n3MV5v3x3eh2nxRCzV5
         E61g==
X-Gm-Message-State: APzg51A8S+PlCR8ku14QFGQZE1oXs9CmizvHtHMLIdGRb7ZWglYodTmq
        ahHilay7N/UPRMcuBi44e8GHPEwr
X-Google-Smtp-Source: ANB0VdYyD10k+bUPWNEbUc2VKuOon8Sp0nC7jUfW8GfplrpfHo9LqlEeG7Ylc4mDVnd+LNCXUbb3sg==
X-Received: by 2002:a2e:85d5:: with SMTP id h21-v6mr5538361ljj.103.1535277807626;
        Sun, 26 Aug 2018 03:03:27 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id z5-v6sm2276882lfg.75.2018.08.26.03.03.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 26 Aug 2018 03:03:27 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH 10/21] merge-blobs.c: remove implicit dependency on the_index
Date:   Sun, 26 Aug 2018 12:03:03 +0200
Message-Id: <20180826100314.5137-11-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180826100314.5137-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/merge-tree.c |  2 +-
 merge-blobs.c        | 15 +++++++++++----
 merge-blobs.h        |  7 +++++--
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index f8023bae1e..f32941fdab 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -76,7 +76,7 @@ static void *result(struct merge_list *entry, unsigned long *size)
 	their = NULL;
 	if (entry)
 		their = entry->blob;
-	return merge_blobs(path, base, our, their, size);
+	return merge_blobs(&the_index, path, base, our, their, size);
 }
 
 static void *origin(struct merge_list *entry, unsigned long *size)
diff --git a/merge-blobs.c b/merge-blobs.c
index 668fb2e05d..ee0a0e90c9 100644
--- a/merge-blobs.c
+++ b/merge-blobs.c
@@ -29,7 +29,12 @@ static void free_mmfile(mmfile_t *f)
 	free(f->ptr);
 }
 
-static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our, mmfile_t *their, unsigned long *size)
+static void *three_way_filemerge(struct index_state *istate,
+				 const char *path,
+				 mmfile_t *base,
+				 mmfile_t *our,
+				 mmfile_t *their,
+				 unsigned long *size)
 {
 	int merge_status;
 	mmbuffer_t res;
@@ -42,7 +47,7 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	 */
 	merge_status = ll_merge(&res, path, base, NULL,
 				our, ".our", their, ".their",
-				&the_index, NULL);
+				istate, NULL);
 	if (merge_status < 0)
 		return NULL;
 
@@ -50,7 +55,9 @@ static void *three_way_filemerge(const char *path, mmfile_t *base, mmfile_t *our
 	return res.ptr;
 }
 
-void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct blob *their, unsigned long *size)
+void *merge_blobs(struct index_state *istate, const char *path,
+		  struct blob *base, struct blob *our,
+		  struct blob *their, unsigned long *size)
 {
 	void *res = NULL;
 	mmfile_t f1, f2, common;
@@ -83,7 +90,7 @@ void *merge_blobs(const char *path, struct blob *base, struct blob *our, struct
 		common.ptr = xstrdup("");
 		common.size = 0;
 	}
-	res = three_way_filemerge(path, &common, &f1, &f2, size);
+	res = three_way_filemerge(istate, path, &common, &f1, &f2, size);
 	free_mmfile(&common);
 out_free_f2_f1:
 	free_mmfile(&f2);
diff --git a/merge-blobs.h b/merge-blobs.h
index 62b569e472..cc31038b80 100644
--- a/merge-blobs.h
+++ b/merge-blobs.h
@@ -1,8 +1,11 @@
 #ifndef MERGE_BLOBS_H
 #define MERGE_BLOBS_H
 
-#include "blob.h"
+struct blob;
+struct index_state;
 
-extern void *merge_blobs(const char *, struct blob *, struct blob *, struct blob *, unsigned long *);
+extern void *merge_blobs(struct index_state *, const char *,
+			 struct blob *, struct blob *,
+			 struct blob *, unsigned long *);
 
 #endif /* MERGE_BLOBS_H */
-- 
2.19.0.rc0.337.ge906d732e7

