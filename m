Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C24730DECE
	for <git@vger.kernel.org>; Sun, 29 Mar 2026 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774779495; cv=none; b=Ex6pg0DZGrMBJr39IStf66n5m222mvcbqGENpyIBTDYjEUnV2J3neeWrqWvr3THG3m/0OyTFUAZvZWf9TkJKHJpU/JHNaE2v+QfzRb3ZUpv2adP6eI6nKKvMAjkMnqKv0VaMM1lGL2RVnlEHdbrSCwSfK8CY148ZzKRDsmoelhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774779495; c=relaxed/simple;
	bh=lLgTBFemq3TIbhQRZqzDaet1q5JWljRV/EelhXC2kR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JpMdLo46OGKIibGuN7AFWEyjCJEMlA51tiV0y4vp8d0qcqf4VLRDarZxxQHpUFjvbr10gd8yaozX9qQMt6fE9zHQ/GhCQ6kUN5jhN/rBXZSDal2MIbs3a4Oq71bCgOJXWryckXEeRhET4fW+HeHscohDk7WUhhKvbx+8x9cAu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdpoKkgj; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdpoKkgj"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso1166785ad.1
        for <git@vger.kernel.org>; Sun, 29 Mar 2026 03:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774779493; x=1775384293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kGCYmIAc6gMdreoaNJWU7+SosDwBgMhVeM3UzllYE2o=;
        b=XdpoKkgjo7QeuRfNsqxmHjQusFNjQmMWklHlsFk8dck6lhGbCJxmT+v3B4402USye+
         onLqj+66Fwja+pL5rL2c+SM0SATgLpjqR5tWJTA6WjJgIYqWNoykYPn4WP1C+MjHlQzw
         aYQvtjP1DqyInszbgdMLuN1OLo9X7+ifE/S6CrYWRjPYqawn8+0fOr7auQo+EAVSpGki
         8KYQyaVyzC0xn1hMatKwdao2C5JDKz2SuVicLWyqcYaoHMdU4LuqxJeR/XEEME/h/HQk
         AiPRKGbID6ev6vLShlKLJWrS3qBsTFTHxyIs5f4bWjBhcjXHsYpmkhgGBhPPq60ZWkB1
         isdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774779493; x=1775384293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kGCYmIAc6gMdreoaNJWU7+SosDwBgMhVeM3UzllYE2o=;
        b=PDp8i0cN45df/sPJSgQe5mLzxP9+VqnWPN8c/IcYfinr1PX496DKsxdwfQ5QZg+RXW
         AtcfEovKxu9Hp6Jr51hmBo34SCXMquVke+FXuiYGE/Ki2rcK237ULR1BqU45yivFB46j
         9phCc1+BOGxJlgKpxmhrteCFjKyA0uDISoDjQOI7t92POud2oyHDQr9E3yrxCeD7A5mA
         cFLmqwxFASWTXXsh0o1oyNvtPHK3awJTAESMNcA2gIDRgzT/esvFYHoBxDITTChukuWx
         ipiZ4gaaOwt6+WnMPqiK0nFOXGL8NNW/gJgHpAvDIx5Ni+mqc3VniggM10KjBkjRoyyb
         xjNw==
X-Gm-Message-State: AOJu0YywK8e8bS9FHu5WLKE8XSdexheK9IDU0DRP8Nc+PZ8ZZDVhGr3N
	BNK7tGFzLNO5T8TTTZj8X6MPQrm3MO/AMYQsLmdn9WyFbZzJu7Stg7G3zVddKA==
X-Gm-Gg: ATEYQzxxJr7DidAyYC+x3ibsS8lxshu/xg1aBL0cTonVtl5jvd5ZmLfK94yZ3b/6LWm
	PArcwq0ZiO6aFVaQLgsfDRnI9ztqlY8Qt5oSrsl8cj8mzUSU1chHgan+EGwtf4HsRHlwvaqrD12
	oB4H3ExJmzAq134yN+x4KxEZv6AqYLsVY6kwQLJOxoEdvzToMH7+i/GmpNnFbL2sY04P63W/S5j
	jahqiulN458x3GT3/ATWDvVHPVR+BgB5st1/48YFcKb9RmKTR/5RzS6DmjOJQa4ZaXj4Kv7h6p5
	HzGbtNRBHvO3fzux76OMvhUPFjdXPlZSOK53aO3S7VNAF6GDLMvHzNXAEiZiiwnM4/eFWv1MO6L
	OMom39gm6H0iBgszb/h60bBJr+e94sUkvIV2jgEYA5lqlgwT7Ug6vncfCSohw+yiRET/YOBqKoH
	lM/FN8MSQGqqkrtHYhMHCugyXsoS07mpNXEAKfmzYNhxk=
X-Received: by 2002:a17:902:f602:b0:2b2:5099:2f3e with SMTP id d9443c01a7336-2b2509934b0mr6378675ad.4.1774779493378;
        Sun, 29 Mar 2026 03:18:13 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:6fcd:e3ea:7ddd:8d9b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b242679bb3sm46199185ad.30.2026.03.29.03.18.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 03:18:13 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v3 2/5] refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
Date: Sun, 29 Mar 2026 15:46:40 +0530
Message-ID: <20260329101725.1092900-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
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

This reduces reliance on the_repository global.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 19 +++++++++++++------
 refs/refs-internal.h |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 5cdc8858c5..2f8c8427cd 100644
--- a/refs.c
+++ b/refs.c
@@ -989,7 +989,7 @@ enum ref_worktree_type parse_worktree_ref(const char *maybe_worktree_ref,
 	return REF_WORKTREE_SHARED;
 }
 
-long get_files_ref_lock_timeout_ms(void)
+long get_files_ref_lock_timeout_ms(struct repository *repo)
 {
 	static int configured = 0;
 
@@ -997,7 +997,7 @@ long get_files_ref_lock_timeout_ms(void)
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
+	cb_data.lk   = &lock->lk;
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

