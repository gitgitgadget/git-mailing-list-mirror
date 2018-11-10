Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B1C8C1F453
	for <e@80x24.org>; Sat, 10 Nov 2018 05:49:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729031AbeKJPd2 (ORCPT <rfc822;e@80x24.org>);
        Sat, 10 Nov 2018 10:33:28 -0500
Received: from mail-lf1-f67.google.com ([209.85.167.67]:35621 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729006AbeKJPd1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Nov 2018 10:33:27 -0500
Received: by mail-lf1-f67.google.com with SMTP id e26so1048064lfc.2
        for <git@vger.kernel.org>; Fri, 09 Nov 2018 21:49:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EeLaNBGaj6wiCdP7HzdaXjOoJAHE1Rj9J8FIQM1/7nQ=;
        b=CbXoHpXiweC5uLwEemlh8cirZnVMRB6m54EW5HYnronEbqputd6jFw6op6Xahj8LRJ
         9dgmnLwMZrWfN0ALDrsTDSwX58kFTXCFwsZ10MOWNDZFtla+a92+jzNfMw6q81zjWA4e
         o0nnrXl4Wwpw5PPoedb5D7U88fpCg9aXFLapNB6FnFQNUxye3T3DfvtHqg3zISrU2VI2
         h/DJRk6p38TYVADjF9cv43HP2XacmG7tTiWkNWOFI1lK8xKmWNViS70TSjZquB6YLECz
         j9RYijmsavN8mAsP0gvMwQMdCwVrtTKkCQV0ZuW9s5fTqBJmZjcuZOAzwFI+s9QAHPmX
         xLKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EeLaNBGaj6wiCdP7HzdaXjOoJAHE1Rj9J8FIQM1/7nQ=;
        b=jPYZWxhyL+6EHs1BxkQZlqMUY5GvBG3q4VDrtUBiS20n95XqGOfEHlVJIraTJoIgAd
         v615XYJH0xuVItbbpyWW3xSiRe71XO4DVKacYZcSWPXEmmaJ4pflvW0eCUAgKfN7giUW
         oZzvt5c0+icrJ8F/qjN3GHE1I7n82CTDfK83j3zSiAIUSqHq7WoCU+DFPcJnoM9wZcL5
         lAgvTP0jNYE+CTj3ma9L5Uqwtcxda0xajeetG4VJGsgNaPZ1Sx/6OEC2x3XJWOoYR1/U
         CmvRlpVO3nzAvyR6eBbGxkO7VlvFKtQplAqpO1WXR4x49FDHmjd/qXXubdx1PduFW55k
         61SQ==
X-Gm-Message-State: AGRZ1gKjaXplUvnlGH1P3+x0weH6nqtzAmSHOQluKz4xnfb199bGxcA6
        QU7xg8j3wjCzL+LpBMoMyidRrKKP
X-Google-Smtp-Source: AJdET5cs0Alqm+QofqBxGslKHIrX1+86pTvwEnolbrEEK2+l6SVOBTHCTZ8lOKlaRmTU53hK/p754w==
X-Received: by 2002:a19:be16:: with SMTP id o22mr6759360lff.22.1541828979912;
        Fri, 09 Nov 2018 21:49:39 -0800 (PST)
Received: from localhost.localdomain (c80-216-12-205.bredband.comhem.se. [80.216.12.205])
        by smtp.gmail.com with ESMTPSA id h3sm144445lfj.25.2018.11.09.21.49.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 09 Nov 2018 21:49:38 -0800 (PST)
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v2 19/22] pack-check.c: remove the_repository references
Date:   Sat, 10 Nov 2018 06:49:07 +0100
Message-Id: <20181110054910.10568-20-pclouds@gmail.com>
X-Mailer: git-send-email 2.19.1.1231.g84aef82467
In-Reply-To: <20181110054910.10568-1-pclouds@gmail.com>
References: <20181110054910.10568-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 builtin/fsck.c | 3 ++-
 pack-check.c   | 9 +++++----
 pack.h         | 4 +++-
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 06eb421720..8ea2823864 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -752,7 +752,8 @@ int cmd_fsck(int argc, const char **argv, const char *prefix)
 			for (p = get_all_packs(the_repository); p;
 			     p = p->next) {
 				/* verify gives error messages itself */
-				if (verify_pack(p, fsck_obj_buffer,
+				if (verify_pack(the_repository,
+						p, fsck_obj_buffer,
 						progress, count))
 					errors_found |= ERROR_PACK;
 				count += p->num_objects;
diff --git a/pack-check.c b/pack-check.c
index fa5f0ff8fa..2cc3603189 100644
--- a/pack-check.c
+++ b/pack-check.c
@@ -48,7 +48,8 @@ int check_pack_crc(struct packed_git *p, struct pack_window **w_curs,
 	return data_crc != ntohl(*index_crc);
 }
 
-static int verify_packfile(struct packed_git *p,
+static int verify_packfile(struct repository *r,
+			   struct packed_git *p,
 			   struct pack_window **w_curs,
 			   verify_fn fn,
 			   struct progress *progress, uint32_t base_count)
@@ -135,7 +136,7 @@ static int verify_packfile(struct packed_git *p,
 			data = NULL;
 			data_valid = 0;
 		} else {
-			data = unpack_entry(the_repository, p, entries[i].offset, &type, &size);
+			data = unpack_entry(r, p, entries[i].offset, &type, &size);
 			data_valid = 1;
 		}
 
@@ -186,7 +187,7 @@ int verify_pack_index(struct packed_git *p)
 	return err;
 }
 
-int verify_pack(struct packed_git *p, verify_fn fn,
+int verify_pack(struct repository *r, struct packed_git *p, verify_fn fn,
 		struct progress *progress, uint32_t base_count)
 {
 	int err = 0;
@@ -196,7 +197,7 @@ int verify_pack(struct packed_git *p, verify_fn fn,
 	if (!p->index_data)
 		return -1;
 
-	err |= verify_packfile(p, &w_curs, fn, progress, base_count);
+	err |= verify_packfile(r, p, &w_curs, fn, progress, base_count);
 	unuse_pack(&w_curs);
 
 	return err;
diff --git a/pack.h b/pack.h
index 34a9d458b4..da99fdd1d2 100644
--- a/pack.h
+++ b/pack.h
@@ -4,6 +4,8 @@
 #include "object.h"
 #include "csum-file.h"
 
+struct repository;
+
 /*
  * Packed object header
  */
@@ -80,7 +82,7 @@ typedef int (*verify_fn)(const struct object_id *, enum object_type, unsigned lo
 extern const char *write_idx_file(const char *index_name, struct pack_idx_entry **objects, int nr_objects, const struct pack_idx_option *, const unsigned char *sha1);
 extern int check_pack_crc(struct packed_git *p, struct pack_window **w_curs, off_t offset, off_t len, unsigned int nr);
 extern int verify_pack_index(struct packed_git *);
-extern int verify_pack(struct packed_git *, verify_fn fn, struct progress *, uint32_t);
+extern int verify_pack(struct repository *, struct packed_git *, verify_fn fn, struct progress *, uint32_t);
 extern off_t write_pack_header(struct hashfile *f, uint32_t);
 extern void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
 extern char *index_pack_lockfile(int fd);
-- 
2.19.1.1231.g84aef82467

