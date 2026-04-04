Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF21264617
	for <git@vger.kernel.org>; Sat,  4 Apr 2026 13:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775311196; cv=none; b=jzGDv1qIsXwiaw+D8yC2roorpvmX92WeYpgPZAGECOwYe7CPKiL7LhHBDxSshE66LOc9qA7WcSAIQFX1h55rVC5vivi4KO8TVRcfQEU2CWXznrm9uUZkmgdCX80E/cV3GFCohB1XvV148sWraVO7bZWWRYPmk5zEf1LFTPG60Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775311196; c=relaxed/simple;
	bh=RZgHHCHXo54NWqe/zqwy5MLYXQy92Tjfgryufn18l0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oJpNYWt4Z59cgVpL+h5umtGJz6Xm3uFf4Bo7zUR5j22AKR0hm8vrnhQ4XjEjw4uh/DAwJ4Wqxed1VeReoBNEQ8kAZGn8YMMBntCMR1PzY+VDXNWj2QfgR6416cS2raU2zgrLvN8WXsDfJX79l9ML2ByR87kXY06Af8jhml8wKiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBMC/vvr; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBMC/vvr"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-c6dd5b01e14so915223a12.0
        for <git@vger.kernel.org>; Sat, 04 Apr 2026 06:59:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775311194; x=1775915994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SE1SBuU3OugMwVDYSPU/jtlZMd4LAB2P5z0PHnAwVg=;
        b=OBMC/vvrzAA51eDVn89MlcxWtXvbqg55B4ZWZDErCcUJMI185Aa2dvsuRd09mD3gyA
         uyzrOnEgGU2tW2g9O8ngDayErfx5N79kdIx8FPWGM2WEm8Syd9TqkbnN1vXjB/wD6et2
         Perqij3PxwDHCIkjTYGuxLlWQePDXAe9zVKMPaaxCLhFiZ7+TOsPnzoPHNCZxkh9GaZQ
         HrfZjPn9WQCdzlOFeDTf+0jsURer3zuUhp5yZx8E3shK/XWlAyZr6ofOl6no/I2/ynfO
         W0ozJbEfIfl9xTbfZGT0/dCmuOb43hKAT/K13LRzhMc6SzTK22TYm/VNXasBxCHJABfu
         IQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775311194; x=1775915994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SE1SBuU3OugMwVDYSPU/jtlZMd4LAB2P5z0PHnAwVg=;
        b=mywLG2yt0GexbYVpHxtYARNhc4EU10/otvlUpqHkObvxJicmf0gdR6VEBb1A30I+On
         iVf6slr2/MQCaECRTTt96YeppP4GFibU7asMwAoSUbcknzZaBECDMgTADSQSOrJMKWic
         P0aWzR6jMNqFWhfQbIt6iBLWvMCaYFrEx7OWJEeaIvZvDHdEp5V/jh4WrQTPSHxzR9BQ
         9sBy2w85or4/x/mOA8E1aSql8h8kEIeILHNFoVFX17GHcpoMo64Q0mdUXguPec73d83s
         inQQXw0qbrVQh/8qu+0uqxQQ+50R8GUxZQ1E8UjhCkaI5J01RLt/o97AXMv9lhOD+upX
         6u6A==
X-Gm-Message-State: AOJu0YzE6S1VGn6GwKwBw2j/66/9Ulc3F0nbGLm0btBy1Z7+c8f1Q2UZ
	DS4EbKXK5NpKem/z0+DNSS03KvlNMpPyBoQ6eGVm3GMVTm6VQF6qHXeLrXLkbg==
X-Gm-Gg: AeBDievhRF/Mw1qdBtNi+vtRDMC3RbuYBhszbafr5tggE7j1AWAf7nZioA0qy3zRAve
	LqXgMzOkjWtbn0lpwjI8UuP786V/mSZOnwa8bN1SNhZD6ieU2xKel7f9jowvtBdMkQk1InxZxCe
	OMrc84lQI3SKTaM5BMB+YPcE5zUHpr70b7YZNO3vDlsQtMtfnw4xa0mljKDmTL+mDZZd1LOHfC2
	oFuW1i3fCnQX4OEqRyaHyltXbBTjfos/B22aa2f+3yZdGgsKuCSjiryy2nXvJXipfkbNHoR8eIg
	oRjzJcDkR6HSLND3x5eGEh3Pavx6sQjZTIxicLy++B5fA/ZY6ahZeoKjxbWMaBQHObfIMFzc7WF
	TO/26ZoIyY2nqo/P/bl8xIDrI0TWa7KhQUoOdk4R9ih2+l2FIq6bHzmxcTfOr9iCDrN8b00E/Bp
	A5iXbVOAz8rpF3ruzGarQ3cnOsalNgVUUh9fF/y825Cr7+fCC+9ESctg==
X-Received: by 2002:a05:6a20:a108:b0:38d:ec8c:7e55 with SMTP id adf61e73a8af0-39f2f07e7bemr6916047637.32.1775311194296;
        Sat, 04 Apr 2026 06:59:54 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:8811:aff7:7421:f350:c0a6:bb03])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c76c6491fe0sm7071805a12.11.2026.04.04.06.59.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 06:59:54 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v5 1/3] refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
Date: Sat,  4 Apr 2026 19:28:38 +0530
Message-ID: <20260404135914.61195-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260404135914.61195-1-shreyanshpaliwalcmsmn@gmail.com>
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

This reduces reliance on the_repository global, though the function
still uses static variables and is not yet fully repository-scoped.
This can be addressed in a follow-up change.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 refs.c               |  4 ++--
 refs/files-backend.c | 19 +++++++++++++------
 refs/refs-internal.h |  2 +-
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/refs.c b/refs.c
index 685a0c247b..214ebfd5ce 100644
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

