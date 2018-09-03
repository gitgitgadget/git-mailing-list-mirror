Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F05221F404
	for <e@80x24.org>; Mon,  3 Sep 2018 18:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728048AbeICWbq (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Sep 2018 18:31:46 -0400
Received: from mail-lf1-f51.google.com ([209.85.167.51]:39665 "EHLO
        mail-lf1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727493AbeICWbq (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Sep 2018 18:31:46 -0400
Received: by mail-lf1-f51.google.com with SMTP id v77-v6so1029188lfa.6
        for <git@vger.kernel.org>; Mon, 03 Sep 2018 11:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=godt78QaZtinH6eZ0oacpx6/1Rk8D+L6fWoYq4y1brqniTt3kWKsVTgi1qncHSJVoG
         FXYAJ1SuZaUenK7Eng0bH8IjKuGLkNmkseucwRh4wEHYr492T0766b0og9FrjdohMosR
         B4VVzNlodS8QAjcJnDzm7CGcYO1D7sLwoV3sqMDQZTZZ47RWQmrrEAhQfoIe43r09D8C
         Erd0LmwzHh5wgaEZO43pOE35oPwa1wfghiTfWKwUnY4bvewfjLqR/b/zwjnrUt2l9iL+
         mqZ5RIePlzfSznzBIlSLOEIQFzGpMudgUwgfJnRyppMkstQ/yr2hk1KkumD+EEm33L9m
         fGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Kmz5XExMAKl+5AoXWbMCP7EYer3lvZ90ZLpn9goGG4Y=;
        b=q7uU0C1LASFEMWn12yaiHZ8rV9mZ7R88rMHvDL4Oob0jh/XdETRr+J42gjbdCWC4cL
         +hdy4ML+xQsa8/hrbyF4Hqrid68ftsnhcg9ai7GHOFr6dGO4jwQr6fG9+9bXlWhcD6A5
         SXprORrTp4wBUAoiLU/UN7OwQsD8Qjd8+6t++UXzlSXlyRD8miR3N5uDB3aCgeQ6+nct
         JBt2XJ2xv3Ll1Zpzac2vK71+bp7C3J+cL0Ow1E6FQrZCCQzM5NIo1cKQ1FPmJ4JeFYXy
         MjmIvJcTGX68/EG6gBL7sKAaMqejgFLC4W6v+DKpVOIJJukHcM9NOqSYMBocbUQ2eHub
         5kMw==
X-Gm-Message-State: APzg51CE+A20M5mj/uWyRhH1bh1syIusunVlKvwWiXFtQhM0omeUjsLb
        ZcoZy/8xkds3G5fI6Wj+RRItpznU
X-Google-Smtp-Source: ANB0VdZfpjPt6ssYk3mmtOz0aMPXnO2JumZY9032HCKRcusFrFLCGkKqra4ReonJnQr+Wf5L17q1hw==
X-Received: by 2002:a19:e44c:: with SMTP id b73-v6mr8659238lfh.117.1535998225430;
        Mon, 03 Sep 2018 11:10:25 -0700 (PDT)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id x20-v6sm3706062lfi.8.2018.09.03.11.10.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Sep 2018 11:10:24 -0700 (PDT)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     pclouds@gmail.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH v2 12/24] merge-blobs.c: remove implicit dependency on the_index
Date:   Mon,  3 Sep 2018 20:09:20 +0200
Message-Id: <20180903180932.32260-13-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.0.rc0.337.ge906d732e7
In-Reply-To: <20180903180932.32260-1-pclouds@gmail.com>
References: <20180826100314.5137-1-pclouds@gmail.com>
 <20180903180932.32260-1-pclouds@gmail.com>
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

