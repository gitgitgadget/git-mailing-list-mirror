Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E84A634B194
	for <git@vger.kernel.org>; Fri,  3 Apr 2026 12:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775218216; cv=none; b=cxwGpRMYirljIVT041Bm4Kudeo2HIdHVOP/DDNjQ2PDVYyr2KFi4iBtFEjTR6lU+JtzjbSVCSNp5CvVTtTioQu76iAfv5sygc9ZdiCExBgXQ13E4jno2gVShGTsaqD3H3F5OkcT1TtF+h5We5piZF2WDv/4R4x8DPBOSIySwytw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775218216; c=relaxed/simple;
	bh=XwxXXq3BIBePWJk5kx+7tl7H4+1xyvVnX8js+ROiJF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QMVkuDn9cv2jl/zn1qDS2WnCJIYZwm+N+A+oNRgtPSrwsZCsRKUZ6w5u+d+zTqPintDHUZ/W76PB7Z7Ay0OxjinxlPFG7T8alD9ihXHyEQBsKlrhaHrp5mQhV9oPbKhgwOyV1QpSgiD49n6SRY+CCCdft+lYZwrE61IGYFtEQog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GRr9GaXZ; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRr9GaXZ"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-823c56765fdso925519b3a.1
        for <git@vger.kernel.org>; Fri, 03 Apr 2026 05:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775218214; x=1775823014; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m+58Y3CAcsl6tUUdKo7YRi5YI7kvQ5t84LJ6ZIYWqyk=;
        b=GRr9GaXZYa+cmoi2zvTKxbL69wfJlGVoBsnJOdJq6Lq3cRW9Ecz8JuuLmp3BbemIZy
         qLzCwyZsITShSWQDH2j/LwIl+EeC1oNhnff9W5We5puVdNjoTpMy61Zjt3wW00f6wUFq
         PgiNSDDs/vuRWDIHGKomDZkJMCMp82i24XmXmhJYCewjEa+5Nl79ZYST4vv3Kw9adhmq
         zXI7E52IsxfaiTfOT7+bqpp5FkiqdilICDiJfG4POYH3kdktcuSISBz8jE4WU2ylh4sg
         lwf6lxO0mzbtlf9ToVq4fjaDSnKz6j637e2NKmIZFxiXgBxjUYvHcffCpzuEtysjUw9Q
         +RBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775218214; x=1775823014;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=m+58Y3CAcsl6tUUdKo7YRi5YI7kvQ5t84LJ6ZIYWqyk=;
        b=dpjHsgq5A5j5cuEDxuxAQjMn2PiiNg6sPN78VM8AEd2RhFIa0ydzWsaRWIeGLCJcVO
         Rf7gIEQPwxoiaR8D41KJQpQ5OGSi770NR2/j+xTU7ofmIOZ1Y7LnNJOWY2n0tV9qBkSn
         6MFBBvYqoqSitqCSRoitoy/qRBNp37hXRyMgU/VSJPJydtiOIabCEMakIp5D82UwLvgn
         vrEHY4YbPCPxmzRzk3o79ITwB/erXnYkozv79UAeThmY2YwJTZlZiRjutFCLRUUuHUeq
         cUnSxtAGz0HG5kYFYMXjFg6jiWFAHkZY4lJKuLz5GJxqXvlAOJLTPfKct8QO/MjW19fP
         0zWw==
X-Gm-Message-State: AOJu0Yz9Tc0W6OCc8lb0OzCfRjEaIupyVyN5S1aAluA0EjHMUvATfDTO
	XU+Z6Wt9mufTXeLLwm+HgEp/e1y0CHpFv15zhBRs6Q8m2w4VKo34+ccmmDhG0A==
X-Gm-Gg: ATEYQzwTaw7Xk5V3uYrEs9PPv0QzpAw5B+Ycg+ZAx7GLjkFe7gRHF5S9O1RrEFmr4Bs
	JrrAEM9C/LDBNbD/2S08mm5/+clpAEzTYvTXkbEql+1ZCgoL7w5wxGt69TRn1sB5bC2HjXfo1kF
	271VQ5Fy/UriWhD3Rdu2UL8zDy2I+xjgoRVj/vCOUheCdGZMMakLOlvVsKAjWWWoFipBhIXnPXg
	+gcL39ygQEeDgtQ4iKnPNRXQHS+wFyJx7tcfMyZU35pyvnJ9IfkGBqZzb2SgUjedCQZTUY12iL4
	e3T/sqM0SiknSz0BG990lQ5vH2cIVIUT7HqxMLaQXIQl+6tAnmjiKdjrB8lQFr8jWbYqVlZfkSs
	nIs9lzURyWEUg+lMjiJMQCj75ncO+SZX5ZdGiOLrK6c5abClhgaGJ/oWi63I4TVAQ6lbdvWSSK0
	Scg9ZunJxDab34h1Q5x/p2QcvtRB7g+s/IT2dOKarD2r0=
X-Received: by 2002:a05:6a00:b92:b0:827:3b1b:43e6 with SMTP id d2e1a72fcca58-82d0da9a01fmr2963490b3a.21.1775218214074;
        Fri, 03 Apr 2026 05:10:14 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:1cd6:212e:a788:cbbb:a39d:2c2c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9c41b8dsm5390775b3a.34.2026.04.03.05.10.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 05:10:13 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	a3205153416@gmail.com,
	bkkaracay@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [PATCH v4 1/3] refs: add struct repository parameter in get_files_ref_lock_timeout_ms()
Date: Fri,  3 Apr 2026 17:38:58 +0530
Message-ID: <20260403120938.1142533-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260329101725.1092900-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260403120938.1142533-1-shreyanshpaliwalcmsmn@gmail.com>
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

