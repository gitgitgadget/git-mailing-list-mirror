Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 328411F453
	for <e@80x24.org>; Fri, 21 Sep 2018 15:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390614AbeIUVrd (ORCPT <rfc822;e@80x24.org>);
        Fri, 21 Sep 2018 17:47:33 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45704 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389545AbeIUVrd (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Sep 2018 17:47:33 -0400
Received: by mail-lf1-f66.google.com with SMTP id m80-v6so1354041lfi.12
        for <git@vger.kernel.org>; Fri, 21 Sep 2018 08:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+HSksfOAJW0/fs3Czs+73DPnuuXehKnw5jG2Ch+GXFE=;
        b=FpbGU48Y4f6Lg3fhiAT3wmWprVXYl+Mj10j7NIAtvjXlrpVmnZdEw9c2N5uSppbb89
         9uZTCvVBstpVCzAopexzH58b1Z2iLA/8qle627Kii6a3cVyT9q8/o4TIxrICbBsD0bor
         /uTxfhYH/h/mCxNg2l6//9o4ac8NBq/Q2mxNABv80LLCz1/kRfnD8BfkD5puNiC78mcT
         MDRsRMiaDhP0jnzqGZhmAVJbB74ak526WSM6e4mlt3EXN6+v96gYte8jUt5YFQnoGoJs
         0zTC5Zm6Ddnr/zWbb4/EJ/YL0UXMRB/CbNylyvpLB1LUzXI0YW6T3DioKddjie0mx/l0
         4Vzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+HSksfOAJW0/fs3Czs+73DPnuuXehKnw5jG2Ch+GXFE=;
        b=cp8rvc/HmXOaKkWXSAG3z5g+3EwobARSeSAYOFGbbdcHDarTLmwoEOWy1wG6wC5P9S
         nPHlsKtPSOtVJy9kyK7MyYkzjlSMnEn5p2CHVSXAPE5ATl2vDWzGipsIHFOYRN1RrHzE
         djp2jcaCuedRwdgOj0u0qdp2LFbW4vP32NVP257Pt2duvn4elqTcTbrrFsmokg/IMc3b
         5BJGhDHcz/s9z43p6BYTli4KR7qlzdVh62FZDQVqKle/twKdftsWF3CPjaYZyemxQk2T
         FTdutsZRdYzTxCxOrE+t885GkyQqpJyrBDz43Qxe8nP5DSozODNH/hn2HpdIoAppz+Jx
         FJGw==
X-Gm-Message-State: APzg51Cy/cRUwo3hJtfLd5Y3rELm6keD5Oo3FSj513HW+YhWgUJNJJfe
        y/22J02/JnUt2tUpWCngpw0=
X-Google-Smtp-Source: ANB0VdZgOZwH0LGR5urnp1eWjOay2WJtjIUHuGHAS7KlnKNmWOZHAgXysIzBWCynh1SdttFKKw547g==
X-Received: by 2002:a19:655d:: with SMTP id c29-v6mr29821497lfj.138.1537545481517;
        Fri, 21 Sep 2018 08:58:01 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id o19-v6sm2192978lfk.30.2018.09.21.08.58.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 21 Sep 2018 08:58:00 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, gitster@pobox.com, sbeller@google.com
Subject: [PATCH v5 12/23] merge-blobs.c: remove implicit dependency on the_index
Date:   Fri, 21 Sep 2018 17:57:28 +0200
Message-Id: <20180921155739.14407-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.640.gcd3aa10a8a
In-Reply-To: <20180921155739.14407-1-pclouds@gmail.com>
References: <20180915161759.8272-1-pclouds@gmail.com>
 <20180921155739.14407-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
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
2.19.0.640.gcd3aa10a8a

