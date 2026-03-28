Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F37ACA45
	for <git@vger.kernel.org>; Sat, 28 Mar 2026 14:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774707154; cv=none; b=jPDoAXHaXroghjrW1J7t/E6a1nyu7Wvt4sXTtRF99UYqantfRcx/lPOR54okBWfjhVGSCfbewGbBumFsuBM7g8/q5xW565CKB+9xCku626oXx3J9GrmxOdFeA8UauB+tKaW4AQ7g/nBzS9ED/LGwRKWW9o3L4QkvAbCxVMICgjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774707154; c=relaxed/simple;
	bh=oAIkGyQh7PbzORZpWw3g0GaFpjO/iM2e7P9vhZfqFFg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYO9Ge+I4Civf1gW+ZgF9XUBodvS8Oc1XG+spvJis8ROaO4tZDXQVisC9ejkR3K1Cf+ZvhdHb6rsAeeiO/kOlT33yOSOC2tSrsXxwKoZr6WO1gj9VwfRfrNxZ50skW/W5wroouEcaTOZuNrdDGtuWodiJyVXMrTXIBh6WgXEx9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k/G3MvL1; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k/G3MvL1"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-c76864f4e58so716057a12.1
        for <git@vger.kernel.org>; Sat, 28 Mar 2026 07:12:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774707153; x=1775311953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NWCNBCDUQXB++tLqFuN+vV+mTjejfhOHdCdFFMGLbrQ=;
        b=k/G3MvL1uh3uXBMApT5kcUJPca7RtM+d35SSxQRTO/gZQylgTDVRkhFbyGPg1iIeBH
         SBzs4RiTyvn892Tc19szQgM1xv1WKiuZVR4WEkqyQg2v041OULQ6CRjPZK6OhM0ebGfW
         K90YGHqSsdtNlNIbbej2AMY1KuG2ocOCg+CGzdIN9ihkgDqTY2GH7fjZbChJvHQhimq1
         0N+RoX4KK+kgxQ+jIFoNJPNf73Eh11CTbbJnDPF13U8+fxxy2jcm57+E5tRZngEpxJes
         v6WgyBRsdvoUT2ezHp43CcTPHbgzkzKrXYGaare0ix7AghZXmfbsx4UtqCSq8UOpThGk
         URAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774707153; x=1775311953;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NWCNBCDUQXB++tLqFuN+vV+mTjejfhOHdCdFFMGLbrQ=;
        b=AATm0eSgiNPmgdK1CkTt39SOEnQGQ28zhIX0Qyq0Eu038Fruzk3XKiGWJbJSDyoh4i
         2Qgo9u5VhfsN+3kSQcZntwslaSnhj3H0qLtzRZxyV5kH9t2Tjr3CdXWe7ZIlqXAs2nVM
         8OWJ9pf5BBETqm86vKzeBAkF8HjhD48QWKFCbib5+l/yyqIuDZINPFadPyax8U8g/jfb
         6muoTMoV/IG0typyrRvPC9roDcz4zm2HgpZKS3TNc12bPiLeUJPLYVnUHfj7AMofBNrB
         MYRCPqEiaiNLLImtrnaO834hZvlS5Y0HfIysrbYq0XzXNbc5a6Rh4iIOSs6ReaVqSCUI
         nEBA==
X-Gm-Message-State: AOJu0Yxan1NppwKVl1i88yDP3KGYbylUDlPEjl51JkWHusUEXaOshHEm
	HM1GAcZ9Y3tkVNpFECDKCODahtFiSFNATVqSJBYp7FVCnXhpoxiw9DAX6/8o6w==
X-Gm-Gg: ATEYQzyNyYCYE5G3NKwfWiHDQG8294IjvsKaMmPiVZozRcN/VNESMLRb7+ypZQ7f2pQ
	/gRoJ/oOVH6nYG/w1YEZMPRYPyHlhiHL/enQzEX0q1qNGHKuSpcVlJ9DfPJ7e0ZH73Ge3awW+aV
	cVOH1uchlsi9DDUXgLcQ70/5oPB24pTHf6GA2HHTRA4cIuUAYLJsbpO85SIyBtoyC+wxBUr5kLT
	jmDnUEY+rxoHsbm/n7OHXOau5//oYicaWrqVEetppXLc+nFbZFW61uJG+CltCVxBeoUW6ODvxUl
	TM5iMR5aN4wx5ulvAezXN9M6R1J3RZWqSw/gPk1ZhvvP2ZX3NH1k/o6/LpI2SptyMgQaybKKJvU
	aJ7S/3BYdsqcR/jXBr/ojhLmVSFxEn7ipalZ6z+DuSzDkt7ZDFctJsUjfxH7I2YEsr8UmaNskxe
	2/gxmGtS0GQ/16kahLiX77bfqF8kPZgsLfMf5UZW+36Q==
X-Received: by 2002:a17:903:19eb:b0:2b0:5a4c:726a with SMTP id d9443c01a7336-2b0cdcd55f7mr70017085ad.43.1774707152550;
        Sat, 28 Mar 2026 07:12:32 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:1b3c:5de4:c8b:1b79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427a27f2sm33173855ad.67.2026.03.28.07.12.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Mar 2026 07:12:31 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v2 2/5] refs: make get_files_ref_lock_timeout_ms() repostory aware
Date: Sat, 28 Mar 2026 19:39:33 +0530
Message-ID: <20260328141146.1095115-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260325164833.1216577-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260328141146.1095115-1-shreyanshpaliwalcmsmn@gmail.com>
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
