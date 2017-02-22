Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1ABCC201B0
	for <e@80x24.org>; Wed, 22 Feb 2017 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932596AbdBVOG1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Feb 2017 09:06:27 -0500
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33849 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932365AbdBVOGZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Feb 2017 09:06:25 -0500
Received: by mail-pg0-f65.google.com with SMTP id s67so552500pgb.1
        for <git@vger.kernel.org>; Wed, 22 Feb 2017 06:06:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=X+ZwudsWR/mPMLh3RdyJ6D4POTqqwTIDiXco6F0rMjA=;
        b=NageGSjZDZGZgqmh4fJhHsd8YqP0V8Tp78qhVcHIBrYYITl4TWAc0larkWgDrNE9wz
         MsuaqCNdG0+PNL4B3AgI7/BAMcnXmbePLZ5dJCocqtLH3Y0EAHvlANfeGD7EGVQWv4Sz
         trlmGV6j7oAWNrzCOlac23gzwnluWCwbUjZYCbfLtwJMm2ITE3p5BpLv3RWoi3ealtXR
         x7FWOoW29b0gHAPhQ0OTJTrlKWwiJBKUWX//Zcqn80n3pudhynT6uQy84oJl3fsxIbeS
         tF2oTe2d6PXDSGSdj76SEREQoHmyalLWQ7t9AOsueL1FombzReq2KUodVIH/RM58UZk6
         qGEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=X+ZwudsWR/mPMLh3RdyJ6D4POTqqwTIDiXco6F0rMjA=;
        b=IO6y4Y5Kjen/MjjVLWe8M/DEWtY/31w2Y/AmfmrWasuss9tn26wCnAqMjLrMKuxkMp
         Y1tXcQRB8QF+TPH4Y7Ic9ALOTXbQ/d8euhscOt39QdFRN8dX64vYTATvcx1o3cNbM5I2
         wMHyMBFisNjrP4GzTLL78u1Hcmo+KQRDSoVwpzMbcEM7vVr1JNLVZR46uDKXOFydhfkU
         B4o2Y9Mof3LGEy5R5TESEH2k4WAV5blec1sett7Ww0qS+GGG2ylvQa+DEX5gGF1fjBRt
         jIrg13iCtTiZhTET1DpxsSyKbuGLSTSOstpgqxSaTAVajj+Y1MVpGx1BUHBzcBChJXc8
         iclA==
X-Gm-Message-State: AMke39nUajHz/cS3WjehdAtB1XyKE1JpkqY6Bk9oUQ/1TeQUNbOXdhIONRX5QjStD0PHtQ==
X-Received: by 10.84.192.137 with SMTP id c9mr19748246pld.17.1487772384333;
        Wed, 22 Feb 2017 06:06:24 -0800 (PST)
Received: from ash ([115.73.162.84])
        by smtp.gmail.com with ESMTPSA id h17sm4087310pfh.62.2017.02.22.06.06.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 22 Feb 2017 06:06:23 -0800 (PST)
Received: by ash (sSMTP sendmail emulation); Wed, 22 Feb 2017 21:06:16 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Stefan Beller <sbeller@google.com>, novalis@novalis.org,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 07/24] files-backend: add and use files_refname_path()
Date:   Wed, 22 Feb 2017 21:04:33 +0700
Message-Id: <20170222140450.30886-8-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170222140450.30886-1-pclouds@gmail.com>
References: <20170218133303.3682-1-pclouds@gmail.com>
 <20170222140450.30886-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Keep repo-related path handling in one place. This will make it easier
to add submodule/multiworktree support later.

This automatically adds the "if submodule then use the submodule version
of git_path" to other call sites too. But it does not mean those
operations are sumodule-ready. Not yet.

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs/files-backend.c | 45 +++++++++++++++++++++++++--------------------
 1 file changed, 25 insertions(+), 20 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7b4ea4c56..72f4e1746 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1180,6 +1180,18 @@ static void files_reflog_path(struct files_ref_store *refs,
 	strbuf_git_path(sb, "logs/%s", refname);
 }
 
+static void files_refname_path(struct files_ref_store *refs,
+			       struct strbuf *sb,
+			       const char *refname)
+{
+	if (refs->submodule) {
+		strbuf_git_path_submodule(sb, refs->submodule, "%s", refname);
+		return;
+	}
+
+	strbuf_git_path(sb, "%s", refname);
+}
+
 /*
  * Get the packed_ref_cache for the specified files_ref_store,
  * creating it if necessary.
@@ -1251,10 +1263,7 @@ static void read_loose_refs(const char *dirname, struct ref_dir *dir)
 	size_t path_baselen;
 	int err = 0;
 
-	if (refs->submodule)
-		err = strbuf_git_path_submodule(&path, refs->submodule, "%s", dirname);
-	else
-		strbuf_git_path(&path, "%s", dirname);
+	files_refname_path(refs, &path, dirname);
 	path_baselen = path.len;
 
 	if (err) {
@@ -1396,10 +1405,7 @@ static int files_read_raw_ref(struct ref_store *ref_store,
 	*type = 0;
 	strbuf_reset(&sb_path);
 
-	if (refs->submodule)
-		strbuf_git_path_submodule(&sb_path, refs->submodule, "%s", refname);
-	else
-		strbuf_git_path(&sb_path, "%s", refname);
+	files_refname_path(refs, &sb_path, refname);
 
 	path = sb_path.buf;
 
@@ -1587,7 +1593,7 @@ static int lock_raw_ref(struct files_ref_store *refs,
 	*lock_p = lock = xcalloc(1, sizeof(*lock));
 
 	lock->ref_name = xstrdup(refname);
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_refname_path(refs, &ref_file, refname);
 
 retry:
 	switch (safe_create_leading_directories(ref_file.buf)) {
@@ -2059,7 +2065,7 @@ static struct ref_lock *lock_ref_sha1_basic(struct files_ref_store *refs,
 	if (flags & REF_DELETING)
 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
 
-	strbuf_git_path(&ref_file, "%s", refname);
+	files_refname_path(refs, &ref_file, refname);
 	resolved = !!resolve_ref_unsafe(refname, resolve_flags,
 					lock->old_oid.hash, type);
 	if (!resolved && errno == EISDIR) {
@@ -2358,7 +2364,7 @@ static void try_remove_empty_parents(struct files_ref_store *refs,
 		strbuf_setlen(&buf, q - buf.buf);
 
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "%s", buf.buf);
+		files_refname_path(refs, &sb, buf.buf);
 		if ((flags & REMOVE_EMPTY_PARENTS_REF) && rmdir(sb.buf))
 			flags &= ~REMOVE_EMPTY_PARENTS_REF;
 
@@ -2668,7 +2674,7 @@ static int files_rename_ref(struct ref_store *ref_store,
 			struct strbuf path = STRBUF_INIT;
 			int result;
 
-			strbuf_git_path(&path, "%s", newrefname);
+			files_refname_path(refs, &path, newrefname);
 			result = remove_empty_directories(&path);
 			strbuf_release(&path);
 
@@ -3901,7 +3907,7 @@ static int files_transaction_commit(struct ref_store *ref_store,
 			    update->type & REF_ISSYMREF) {
 				/* It is a loose reference. */
 				strbuf_reset(&sb);
-				strbuf_git_path(&sb, "%s", lock->ref_name);
+				files_refname_path(refs, &sb, lock->ref_name);
 				if (unlink_or_msg(sb.buf, err)) {
 					ret = TRANSACTION_GENERIC_ERROR;
 					goto cleanup;
@@ -4201,25 +4207,24 @@ static int files_reflog_expire(struct ref_store *ref_store,
 
 static int files_init_db(struct ref_store *ref_store, struct strbuf *err)
 {
+	struct files_ref_store *refs =
+		files_downcast(ref_store, 0, "init_db");
 	struct strbuf sb = STRBUF_INIT;
 
-	/* Check validity (but we don't need the result): */
-	files_downcast(ref_store, 0, "init_db");
-
 	/*
 	 * Create .git/refs/{heads,tags}
 	 */
-	strbuf_git_path(&sb, "refs/heads");
+	files_refname_path(refs, &sb, "refs/heads");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
-	strbuf_git_path(&sb, "refs/tags");
+	files_refname_path(refs, &sb, "refs/tags");
 	safe_create_dir(sb.buf, 1);
 	strbuf_reset(&sb);
 	if (get_shared_repository()) {
-		strbuf_git_path(&sb, "refs/heads");
+		files_refname_path(refs, &sb, "refs/heads");
 		adjust_shared_perm(sb.buf);
 		strbuf_reset(&sb);
-		strbuf_git_path(&sb, "refs/tags");
+		files_refname_path(refs, &sb, "refs/tags");
 		adjust_shared_perm(sb.buf);
 	}
 	strbuf_release(&sb);
-- 
2.11.0.157.gd943d85

