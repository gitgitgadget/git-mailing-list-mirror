Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E8C83F0777
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 16:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774457337; cv=none; b=AduX904W/VXmli0dwMKaBZYW3Ko7JmKapF+PIudfFUXyhGrUYHUNLmZtjFNeEi/RrIoaZ1q5rLjNy6AlsHyoN5qfSoTupTV9DaCYyaoOG+39y/RILSbsB/BhURXbI78Dyl9x1NCksdEvm+6v/0QmdTti+YbcJcmxG+paLUPh7ck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774457337; c=relaxed/simple;
	bh=7ar9ihk93L8/f0ICj4sgJRhMsIQKxdNR9tkrKxRBf0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iWqa+Zd+NKH7o2yuW/TvlmsnIkS09ssBrR1DLtQyG8FtqO32DEu8tbCXKKCzoVN5Ool6ljPDwsdvprDGEbyb4DTK6Vb1RSSKSQUaBUrDT+Z7dwMtrtOpcGssDQ+SprGLFYq2kHR6nE4v1Yieh9JS9shVsF2wfmic0WoGuwGcZWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jF0RQrX3; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jF0RQrX3"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c73c990a96dso72443a12.0
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 09:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774457335; x=1775062135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hzZmQwqbITFMLYn8VaJbamD+vFalC9/1Plgf0JW+0jQ=;
        b=jF0RQrX3tRImc2IVdlC6XYKHJOnR0bD/XBoVbARe8QGoHK/H7cPbQsWLwVqXzdzJao
         WxXXbZHNNKnJjqGrdAQojMYawc4CWBsKX1boEQXT0t6bWm3cmbEE23zwW4IpcA6qEN9h
         M/PaL2holVOMn0MzXY/98VP9EpbVefyuORUF5hboK78oVUVecY65FyACGxNvznls5kmx
         uxVmlY49ubfvV3fFnMh7I8jrpvKuRH3XiEXu2kRhBcYHFaOUekHAkEFXYDCGXQy3Oh7g
         tov1eWHBxfoi5sdfwo6mxlmmgK4XTMzQDt6Lr4PxLoLM2w73ICXkCKa9TKci4wrWrTk3
         ZKdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774457335; x=1775062135;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hzZmQwqbITFMLYn8VaJbamD+vFalC9/1Plgf0JW+0jQ=;
        b=TorOginKVD7r7XQD0PgH4ysdYhqcyhqcKDfwA3PT6kwN26/jfbLdlBsp44ymBUHiKi
         D/Fx2octplSB/SMrUMQOmRUuHzlR6Tudez+X6Jhvm5thmIO1NxmXLKa5y9odTt/CgOND
         qB7WLMCYiDj7EAEEYjbP1kiBeVM8ScsxFKi+WUBi65g/Zhi3ZcESFLoF9O08U59gNUdn
         A79dl+8Cts8bgG6gFXp3Jt6iPnicxEQ6rgOpBfFUqK5LbNDf8tVXFBx2LAQCl4ffY05w
         9wgS+ql+idNWpKTnlUNHR8uuCZc3Pxc+Fd9CXHb7P847ppUS6cBiAbNIW8c0+peWZrCY
         4+gg==
X-Gm-Message-State: AOJu0YxbJxTPMrslpKYXUlmklz8kbG0uVE1TVSjP7K8vJiybl2rWY3KS
	NAtl3xbj8K4MSo3a/7aUP9g4hBHt5shogpqkdKpLOgm0X4/m2Mvz2sLF9aZwWw==
X-Gm-Gg: ATEYQzwNvA9OpFJ+Ofm5YvgLkwXiiRpXryxwKT3unNmxmUpHDWM3mnh5HfcywSPMc9r
	urITKdMw7liwRXE6E9AmJ5NQvV0dh5G/SChbNxwZp7YSyn1UbzwYYxmQUZHUdnpTaS63C1W5okb
	PNdXi2OHRbYZsW2Ig7qvDCe5mdiLsaXzy9OrEzMSig6ALgvv/pdvY97FEDBGIGQmX+1feuVEBbj
	R14z4Y/GoLaR5sEyXiLvMIqw2YbczwVe10AYa24EYPzh8a6ONoGTYtCSR/yLzrID0GfutD5d2Ez
	OrY7wk1axfI3L8wzTbawraePStM2e5nVFXU2DDbGC7iJNgILnpXIW05zSDsPZ5fpcejvOzzjhSp
	6W9VBFgEHPzC0vqdewC8uYgJ9wpcoNJldtXrwRQmtNVDCHxRB7yg8iLc9D0u8FD8sY2YktFHY0q
	Ag5wQPabib93syJeYbQmnmX4LsOJaKRfTrYHrOtJ87ZweHzsEXyCeHrg==
X-Received: by 2002:a17:902:c412:b0:2b0:5e63:fc45 with SMTP id d9443c01a7336-2b0b08791b9mr51123175ad.0.1774457335395;
        Wed, 25 Mar 2026 09:48:55 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6f26:76cd:bafb:15d6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc76ba80sm3901275ad.2.2026.03.25.09.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 09:48:54 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH 2/5] refs: make get_files_ref_lock_timeout_ms() repostory aware
Date: Wed, 25 Mar 2026 22:14:19 +0530
Message-ID: <20260325164833.1216577-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

get_files_ref_lock_timeout_ms() calls repo_config_get_int() using
the_repository, as no repository instance is available in its scope. Add a
struct repository parameter and use it instead of the_repository.

Update all callers accordingly. In files-backend.c, lock_raw_ref() can
obtain repository instance from the struct ref_transaction via
transaction->ref_store->repo and pass it down. For create_reflock(), which
is used as a callback, introduce a small wrapper struct to pass both struct
lock_file and struct repository through the callback data.

This removes reliance on the_repository global and makes the timeout lookup
operate on the correct repository context.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 19 +++++++++++++------
 refs/refs-internal.h |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 840965519e..e7256b3a84 100644
--- a/refs.c
+++ b/refs.c
@@ -990,7 +990,7 @@ enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
 	return REF_WORKTREE_SHARED;
 }
 
-long get_files_ref_lock_timeout_ms(void)
+long get_files_ref_lock_timeout_ms(struct repository *repo)
 {
 	static int configured = 0;
 
@@ -998,7 +998,7 @@ long get_files_ref_lock_timeout_ms(void)
 	static int timeout_ms = 100;
 
 	if (!configured) {
-		repo_config_get_int(the_repository, "core.filesreflocktimeout", &timeout_ms);
+		repo_config_get_int(repo, "core.filesreflocktimeout", &timeout_ms);
 		configured = 1;
 	}
 
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 7ce0d57478..ee8dd771a4 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -792,7 +792,7 @@ static enum ref_transaction_error lock_raw_ref(struct files_ref_store *refs,
 
 	if (hold_lock_file_for_update_timeout(
 			    &lock->lk, ref_file.buf, LOCK_NO_DEREF,
-			    get_files_ref_lock_timeout_ms()) < 0) {
+			    get_files_ref_lock_timeout_ms(transaction->ref_store->repo)) < 0) {
 		int myerr = errno;
 		errno = 0;
 		if (myerr == ENOENT && --attempts_remaining > 0) {
@@ -1190,13 +1190,17 @@ static int remove_empty_directories(struct strbuf *path)
 	return remove_dir_recursively(path, REMOVE_DIR_EMPTY_ONLY);
 }
 
+struct create_reflock_cb {
+    struct lock_file *lk;
+    struct repository *repo;
+};
+
 static int create_reflock(const char *path, void *cb)
 {
-	struct lock_file *lk = cb;
-
+	struct create_reflock_cb *data = cb;
 	return hold_lock_file_for_update_timeout(
-			lk, path, LOCK_NO_DEREF,
-			get_files_ref_lock_timeout_ms()) < 0 ? -1 : 0;
+			data->lk, path, LOCK_NO_DEREF,
+			get_files_ref_lock_timeout_ms(data->repo)) < 0 ? -1 : 0;
 }
 
 /*
@@ -1208,6 +1212,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
+	struct create_reflock_cb cb_data;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1229,8 +1234,10 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 
 	lock->ref_name = xstrdup(refname);
 	lock->count = 1;
+	cb_data.lk = &lock->lk;
+	cb_data.repo = refs->base.repo;
 
-	if (raceproof_create_file(ref_file.buf, create_reflock, &lock->lk)) {
+	if (raceproof_create_file(ref_file.buf, create_reflock, &cb_data)) {
 		unable_to_lock_message(ref_file.buf, errno, err);
 		goto error_return;
 	}
diff --git a/refs/refs-internal.h b/refs/refs-internal.h
index d79e35fd26..e4cfd9e19e 100644
--- a/refs/refs-internal.h
+++ b/refs/refs-internal.h
@@ -43,7 +43,7 @@ struct ref_transaction;
  * Return the length of time to retry acquiring a loose reference lock
  * before giving up, in milliseconds:
  */
-long get_files_ref_lock_timeout_ms(void);
+long get_files_ref_lock_timeout_ms(struct repository *repo);
 
 /*
  * Return true iff refname is minimally safe. "Safe" here means that
-- 
2.53.0
