Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E78C81F404
	for <e@80x24.org>; Sun,  9 Sep 2018 08:55:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726710AbeIINno (ORCPT <rfc822;e@80x24.org>);
        Sun, 9 Sep 2018 09:43:44 -0400
Received: from mail-lj1-f182.google.com ([209.85.208.182]:39146 "EHLO
        mail-lj1-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbeIINnn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 Sep 2018 09:43:43 -0400
Received: by mail-lj1-f182.google.com with SMTP id l15-v6so15396361lji.6
        for <git@vger.kernel.org>; Sun, 09 Sep 2018 01:54:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ceBadMZ4VIHK7Tp3w1dVnVbwTi259/zbamh77cqvH+0=;
        b=lHAQI69KhvyzUqmjAAF6orxshifitu/V5XSywSeUBY+YnYoeUisIl5nNPUYQRbNVYV
         bVtZ1pZ0ynD2Qe2COOQy+ab6pmAsDIR8CxAy9A23N1eEmzuINhv/NfqmAIpIMr6GjcjM
         OBrPCFjBVNpuXH1rp9gaoT/k9Btb5orO3aDQhNxzgif/SW4juGJZYpPEcIDUi3mmvQVv
         Xv6sut2GbsgOcB/qBlpyikrteTuZseOD5YU5ld1qUo3F45mItLeihl6FEnb3I4SBx+A2
         RJlxY6Xwxln0uPMqtwhcL13HJnk5Hkp+jTffL0usSxral6MJh66PmbD3rcHUa3rEaanC
         mPgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ceBadMZ4VIHK7Tp3w1dVnVbwTi259/zbamh77cqvH+0=;
        b=MUfcAv+KaWwlj6W1B7VDHTqGKLzud7NwVt/El623EDCXumSfRoPaSZAv4LNDPUcNZu
         BnJMSsgv5Gl0qVIyOht3sAc641DkWyNEE0NzFGTWzqwL5b3GWxbJMj61XspebW+Z28gy
         8IiISLMG8PXOa83X738j/68CKq5mXj+O+D8Y9njHxDSLClt02iihTmSJgRdWmYkxYDZj
         MDHUoetvQ7MLYn5f2trBUB50j34fMvm0GR+D5NmOvNgSESWo3KuQc+CqhRta5hM5ETVS
         4ZlI1Xq7cn+nMSmNI5wq/c+9Xwgz55LUxxBfSu7YWziTQokYMkziiqm82RXvMQOpWg02
         h6HQ==
X-Gm-Message-State: APzg51C1ox871H76oqXoeHI40nISDycZ6swGN2K/m69K+9Cfx5YcLEDz
        JJSp64QvRLmmfEsfd14J1o0=
X-Google-Smtp-Source: ANB0VdY7iThXHsA2MlsglxpOOloaXQe+paC0MA2S2c80XGOZpzIOqAu8BJ2+7tIeBsguC3JzAqX4+Q==
X-Received: by 2002:a2e:144c:: with SMTP id 12-v6mr9797207lju.122.1536483285343;
        Sun, 09 Sep 2018 01:54:45 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id g16-v6sm2102525lfb.5.2018.09.09.01.54.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 09 Sep 2018 01:54:44 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, sbeller@google.com,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 12/23] merge-blobs.c: remove implicit dependency on the_index
Date:   Sun,  9 Sep 2018 10:54:07 +0200
Message-Id: <20180909085418.31531-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180909085418.31531-1-pclouds@gmail.com>
References: <20180903180932.32260-1-pclouds@gmail.com>
 <20180909085418.31531-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

