Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8C5BA1FADF
	for <e@80x24.org>; Thu, 18 Jan 2018 14:51:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756418AbeAROvR (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Jan 2018 09:51:17 -0500
Received: from mail-lf0-f67.google.com ([209.85.215.67]:41205 "EHLO
        mail-lf0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756624AbeAROvP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jan 2018 09:51:15 -0500
Received: by mail-lf0-f67.google.com with SMTP id f136so5536482lff.8
        for <git@vger.kernel.org>; Thu, 18 Jan 2018 06:51:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:in-reply-to
         :references;
        bh=N5793sOt+WhgsrASRUmTlVkoKYcm1FZkVOXsFULF+iQ=;
        b=m5bs8R/pW3lAwwdWxoQM/RFrquz9sYZEtNzokK7HuoE8gqRP/ldlPCzDhZtqyQC3X1
         qtz5xN/jZh58c/u60Iwj8WbEa75pAC5dVCM7pKghaW7D1q1lpjNk6WEFdhgAPuZdRtwy
         kaKupgMQmIbbg3DFT/BLg29V/rhIoJNZP+DcthSUkGBCmJHh+d4CyGdSFdGM2jsndxls
         MBfgxuyF6uUxP3QwFovKerZMQSOrkQTmlHX7XCG68BZwofPD/fEoxwNXuEVs7Jctmnic
         CyIha5Tn35C8gXH5lgWNaRBCYrL/XiYwfLzGXcxy8+uTXf9Trd2JTgpAfJTLIMXZym2B
         sJwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=N5793sOt+WhgsrASRUmTlVkoKYcm1FZkVOXsFULF+iQ=;
        b=hhozrYzj2et2CqbwJfriWd7bQj/l+w0jmIqCjwNyyrWkXB8jmbh4IcVn4R7XbHwOJy
         GobZ6e/sBfIwrNr9HQY5z+lwVg1xOTLCGda/CeqYDhDCjOGYmZqAM99SONB3bqksqRTl
         GxmU9WFKLENKQFoq4fu8wyHYca6dxNwaRzi2q3iEr8Gq2GjgXIrOeE2Wcw1mWsJsmLwR
         IsXSMevqQohLYCRA3zK8cZNs1zA/fBkUgJhQ+yMSZTgxVWza+WB4zB6gIZ0imcHmP1Sn
         k0sdFQGCacgMZ8DwAvFAAhu26RM+fOg3XLqMiluqk78bUvTI+a48e8OgW3tVC9tNXssO
         X4OA==
X-Gm-Message-State: AKwxytfQE3MsMtr5nWCxf4qhDOnM2Gc7z9zUwsIDDy03b6/NfkC37JeS
        uc/TV9JrsFBg3p/ijleOByWtg4JNsrQ=
X-Google-Smtp-Source: ACJfBour6xuvP8K7knlBzoQJnlxSkk1hXOhOamqlv1dnEmSVGMdY9QP4dKO3Vyvljm+q0jPpjDZDPQ==
X-Received: by 10.25.155.205 with SMTP id d196mr1866336lfe.31.1516287073460;
        Thu, 18 Jan 2018 06:51:13 -0800 (PST)
Received: from localhost.localdomain ([188.121.16.104])
        by smtp.gmail.com with ESMTPSA id 23sm560988lju.28.2018.01.18.06.51.12
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 18 Jan 2018 06:51:12 -0800 (PST)
From:   Patryk Obara <patryk.obara@gmail.com>
To:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.ath.cx>
Subject: [PATCH 04/11] dir: convert struct sha1_stat to use object_id
Date:   Thu, 18 Jan 2018 15:50:56 +0100
Message-Id: <f0d34e3a120242410ced07f3578c30bc79143191.1516282880.git.patryk.obara@gmail.com>
X-Mailer: git-send-email 2.14.3
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
In-Reply-To: <cover.1516282880.git.patryk.obara@gmail.com>
References: <cover.1516282880.git.patryk.obara@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Convert the declaration of struct sha1_stat. Adjust all usages of this
struct and replace hash{clr,cmp,cpy} with oid{clr,cmp,cpy} wherever
possible.

Remove macro EMPTY_BLOB_SHA1_BIN, as it's no longer used.

Signed-off-by: Patryk Obara <patryk.obara@gmail.com>
---
 cache.h                              |  2 --
 dir.c                                | 31 ++++++++++++++++---------------
 dir.h                                |  2 +-
 t/helper/test-dump-untracked-cache.c |  4 ++--
 4 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/cache.h b/cache.h
index 8ed75d7260..04af1d69e4 100644
--- a/cache.h
+++ b/cache.h
@@ -1047,8 +1047,6 @@ extern const struct object_id empty_tree_oid;
 	"\xe6\x9d\xe2\x9b\xb2\xd1\xd6\x43\x4b\x8b" \
 	"\x29\xae\x77\x5a\xd8\xc2\xe4\x8c\x53\x91"
 extern const struct object_id empty_blob_oid;
-#define EMPTY_BLOB_SHA1_BIN (empty_blob_oid.hash)
-
 
 static inline int is_empty_blob_sha1(const unsigned char *sha1)
 {
diff --git a/dir.c b/dir.c
index 7c4b45e30e..effa531d35 100644
--- a/dir.c
+++ b/dir.c
@@ -253,7 +253,7 @@ static int do_read_blob(const struct object_id *oid,
 
 	if (sha1_stat) {
 		memset(&sha1_stat->stat, 0, sizeof(sha1_stat->stat));
-		hashcpy(sha1_stat->sha1, oid->hash);
+		oidcpy(&sha1_stat->oid, oid);
 	}
 
 	if (sz == 0) {
@@ -823,7 +823,7 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 		if (size == 0) {
 			if (sha1_stat) {
 				fill_stat_data(&sha1_stat->stat, &st);
-				hashcpy(sha1_stat->sha1, EMPTY_BLOB_SHA1_BIN);
+				oidcpy(&sha1_stat->oid, &empty_blob_oid);
 				sha1_stat->valid = 1;
 			}
 			close(fd);
@@ -847,10 +847,11 @@ static int add_excludes(const char *fname, const char *base, int baselen,
 				 !ce_stage(istate->cache[pos]) &&
 				 ce_uptodate(istate->cache[pos]) &&
 				 !would_convert_to_git(istate, fname))
-				hashcpy(sha1_stat->sha1,
-					istate->cache[pos]->oid.hash);
+				oidcpy(&sha1_stat->oid,
+				       &istate->cache[pos]->oid);
 			else
-				hash_sha1_file(buf, size, "blob", sha1_stat->sha1);
+				hash_sha1_file(buf, size, "blob",
+					       sha1_stat->oid.hash);
 			fill_stat_data(&sha1_stat->stat, &st);
 			sha1_stat->valid = 1;
 		}
@@ -1223,7 +1224,7 @@ static void prep_exclude(struct dir_struct *dir,
 		}
 
 		/* Try to read per-directory file */
-		hashclr(sha1_stat.sha1);
+		oidclr(&sha1_stat.oid);
 		sha1_stat.valid = 0;
 		if (dir->exclude_per_dir &&
 		    /*
@@ -1269,9 +1270,9 @@ static void prep_exclude(struct dir_struct *dir,
 		 * order, though, if you do that.
 		 */
 		if (untracked &&
-		    hashcmp(sha1_stat.sha1, untracked->exclude_sha1)) {
+		    hashcmp(sha1_stat.oid.hash, untracked->exclude_sha1)) {
 			invalidate_gitignore(dir->untracked, untracked);
-			hashcpy(untracked->exclude_sha1, sha1_stat.sha1);
+			hashcpy(untracked->exclude_sha1, sha1_stat.oid.hash);
 		}
 		dir->exclude_stack = stk;
 		current = stk->baselen;
@@ -2228,13 +2229,13 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
 
 	/* Validate $GIT_DIR/info/exclude and core.excludesfile */
 	root = dir->untracked->root;
-	if (hashcmp(dir->ss_info_exclude.sha1,
-		    dir->untracked->ss_info_exclude.sha1)) {
+	if (oidcmp(&dir->ss_info_exclude.oid,
+		   &dir->untracked->ss_info_exclude.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_info_exclude = dir->ss_info_exclude;
 	}
-	if (hashcmp(dir->ss_excludes_file.sha1,
-		    dir->untracked->ss_excludes_file.sha1)) {
+	if (oidcmp(&dir->ss_excludes_file.oid,
+		   &dir->untracked->ss_excludes_file.oid)) {
 		invalidate_gitignore(dir->untracked, root);
 		dir->untracked->ss_excludes_file = dir->ss_excludes_file;
 	}
@@ -2638,8 +2639,8 @@ void write_untracked_extension(struct strbuf *out, struct untracked_cache *untra
 	FLEX_ALLOC_MEM(ouc, exclude_per_dir, untracked->exclude_per_dir, len);
 	stat_data_to_disk(&ouc->info_exclude_stat, &untracked->ss_info_exclude.stat);
 	stat_data_to_disk(&ouc->excludes_file_stat, &untracked->ss_excludes_file.stat);
-	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.sha1);
-	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.sha1);
+	hashcpy(ouc->info_exclude_sha1, untracked->ss_info_exclude.oid.hash);
+	hashcpy(ouc->excludes_file_sha1, untracked->ss_excludes_file.oid.hash);
 	ouc->dir_flags = htonl(untracked->dir_flags);
 
 	varint_len = encode_varint(untracked->ident.len, varbuf);
@@ -2821,7 +2822,7 @@ static void load_sha1_stat(struct sha1_stat *sha1_stat,
 			   const unsigned char *sha1)
 {
 	stat_data_from_disk(&sha1_stat->stat, data);
-	hashcpy(sha1_stat->sha1, sha1);
+	hashcpy(sha1_stat->oid.hash, sha1);
 	sha1_stat->valid = 1;
 }
 
diff --git a/dir.h b/dir.h
index 11a047ba48..afbff73357 100644
--- a/dir.h
+++ b/dir.h
@@ -76,7 +76,7 @@ struct exclude_list_group {
 
 struct sha1_stat {
 	struct stat_data stat;
-	unsigned char sha1[20];
+	struct object_id oid;
 	int valid;
 };
 
diff --git a/t/helper/test-dump-untracked-cache.c b/t/helper/test-dump-untracked-cache.c
index f752532ffb..d7c55c2355 100644
--- a/t/helper/test-dump-untracked-cache.c
+++ b/t/helper/test-dump-untracked-cache.c
@@ -54,8 +54,8 @@ int cmd_main(int ac, const char **av)
 		printf("no untracked cache\n");
 		return 0;
 	}
-	printf("info/exclude %s\n", sha1_to_hex(uc->ss_info_exclude.sha1));
-	printf("core.excludesfile %s\n", sha1_to_hex(uc->ss_excludes_file.sha1));
+	printf("info/exclude %s\n", oid_to_hex(&uc->ss_info_exclude.oid));
+	printf("core.excludesfile %s\n", oid_to_hex(&uc->ss_excludes_file.oid));
 	printf("exclude_per_dir %s\n", uc->exclude_per_dir);
 	printf("flags %08x\n", uc->dir_flags);
 	if (uc->root)
-- 
2.14.3

