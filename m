Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4F15EFBE
	for <git@vger.kernel.org>; Tue,  7 May 2024 12:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715086759; cv=none; b=fIfxOyQMwKfnRgHqmIM/HlmPAGnOnIIvJQKnEU7c5mnIlrgIPF3Rh86/LltVickK8z10+o55RaO+8DVmF4kwM3BeSV1Jtv8gf5RMeT/DPsPXqMPIOlNpglRMBu9DPobs0afCFe2LQgaDKoeMf2tInJ1fGdjFXcwKGOhpZfPQpPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715086759; c=relaxed/simple;
	bh=8Cpwg9SVdaD/59MRZDHF+nDBS+eA7g75P4eYM7fCFiA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h3cd89X/6y6V/hyxd1Q6Vjcvm6nrshXx5NW6JyTdGbGkt38/uuvz3yTvE+UmAlkGJbI53Y+DbTuzw0mY/xyZl7RHX6m8i82N8q9/etloDkfB2S589GAsaD2wv9PRCdB2GgMcWIYWdxI+ltjRW3WHWoez+U77+cHDN274xYewGgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=almzw2t5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="almzw2t5"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-34ddc9fe497so1801069f8f.3
        for <git@vger.kernel.org>; Tue, 07 May 2024 05:59:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715086756; x=1715691556; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4bWnQwRXDSaRDYI8/a0jyq2qjnHCQI0Rm6WE6HWRMg=;
        b=almzw2t5Z9rNlF9imJGjDSAQA/MC4eiZLR9oc1zXEsVtB9HCrbqC+/CzLsB+buWVKY
         h+FzcWYWmZPSQoCIjcAsQpyAOeuwi3VDZ54SOYOclb+3FO2nRcSFOStAywH2z2Fgk2hQ
         ouvVXPUlGwyMQMmSVVbWYxfN5x+a1T8o2LNSkdD2qKi9i1KaaV7ACdRVYh2ft6C5TeNg
         pgivqo02kASFwVpnsjMSgVhY2FyFp6UPus/V9Bx1U7KdZjiRNm9BpMn3oxAIN2xInsNr
         Dz84LF+pUIsvcMWWpyMjeQurT38X1yj+iP2E3WlJlxkoqes4SXbaN9EEEIsA7NVSu2Vp
         FBvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715086756; x=1715691556;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4bWnQwRXDSaRDYI8/a0jyq2qjnHCQI0Rm6WE6HWRMg=;
        b=WIT0CBQ0J6QeIzN8KPKMnrNheekx2vdRwj21fMD0MBz4HYlOlFvuuo93eo5Skn54al
         KgSnTAntL7maCTJlRtMtDSBmzFYh3DWRU8q5mG3UlNuWHhHYatakT7Xxv9yqMj+L2VSM
         MPEbyfyjnZt6ev0UDDfenAJfA2Drub6PQgv4+QifznvpsAIFF7J+3JL70vw8XBOpsNsn
         c6a/1eXckmkbFm1aLsrGthJGSfqwfkRGjO5s+htm5vUf2NfGcEHr/E7FwrF3/am8BU14
         1/ZK4WZbId+8c3JejNGO0hyQ8Vqu4Bm9QvqIH5qQU6lMeF0CqIMsELidvuZMLohNyDc/
         pDkw==
X-Gm-Message-State: AOJu0YybR+ZpMvk6UW/Tbg1Hqw5Y2bJkDnYlXFlN2+zYq9YhiX9URQ9G
	/IV8NK7l3oO816YspPnNZ0FZHET2nH0pVwrZH7yr5I5XGhilSmViJQ2VAw==
X-Google-Smtp-Source: AGHT+IGI+Vs54Da1A7px5vf6XAW+x0SmuaW5AHM+QndPuRUCusY0uLYcVzMUThwPBdkM0M/5/SA12g==
X-Received: by 2002:a05:6000:4013:b0:349:ca9b:545a with SMTP id cp19-20020a056000401300b00349ca9b545amr16033721wrb.29.1715086755712;
        Tue, 07 May 2024 05:59:15 -0700 (PDT)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:e6d6:a83d:4d4b:8baa])
        by smtp.gmail.com with ESMTPSA id q5-20020adff945000000b0034f5925edacsm3507566wrr.30.2024.05.07.05.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:59:15 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <knayak@gitlab.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	ps@pks.im,
	phillip.wood123@gmail.com
Subject: [PATCH v8 7/8] refs: rename `refs_create_symref()` to `refs_update_symref()`
Date: Tue,  7 May 2024 14:58:58 +0200
Message-ID: <20240507125859.132116-8-knayak@gitlab.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240507125859.132116-1-knayak@gitlab.com>
References: <20240507060035.28602-1-knayak@gitlab.com>
 <20240507125859.132116-1-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Karthik Nayak <karthik.188@gmail.com>

The `refs_create_symref()` function is used to update/create a symref.
But it doesn't check the old target of the symref, if existing. It force
updates the symref. In this regard, the name `refs_create_symref()` is a
bit misleading. So let's rename it to `refs_update_symref()`. This is
akin to how 'git-update-ref(1)' also allows us to create apart from
update.

While we're here, rename the arguments in the function to clarify what
they actually signify and reduce confusion.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/branch.c          |  2 +-
 builtin/worktree.c        |  2 +-
 refs.c                    | 12 +++++-------
 refs.h                    |  2 +-
 t/helper/test-ref-store.c |  2 +-
 5 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index dd3e3a7dc0..4491f7a20c 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -555,7 +555,7 @@ static int replace_each_worktree_head_symref(struct worktree **worktrees,
 			continue;
 
 		refs = get_worktree_ref_store(worktrees[i]);
-		if (refs_create_symref(refs, "HEAD", newref, logmsg))
+		if (refs_update_symref(refs, "HEAD", newref, logmsg))
 			ret = error(_("HEAD of working tree %s is not updated"),
 				    worktrees[i]->path);
 	}
diff --git a/builtin/worktree.c b/builtin/worktree.c
index 7c6c72536b..480202c517 100644
--- a/builtin/worktree.c
+++ b/builtin/worktree.c
@@ -517,7 +517,7 @@ static int add_worktree(const char *path, const char *refname,
 		ret = refs_update_ref(wt_refs, NULL, "HEAD", &commit->object.oid,
 				      NULL, 0, UPDATE_REFS_MSG_ON_ERR);
 	else
-		ret = refs_create_symref(wt_refs, "HEAD", symref.buf, NULL);
+		ret = refs_update_symref(wt_refs, "HEAD", symref.buf, NULL);
 	if (ret)
 		goto done;
 
diff --git a/refs.c b/refs.c
index 507f5f0525..fa5471d219 100644
--- a/refs.c
+++ b/refs.c
@@ -2284,10 +2284,8 @@ int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
 	return peel_object(base, peeled) ? -1 : 0;
 }
 
-int refs_create_symref(struct ref_store *refs,
-		       const char *ref_target,
-		       const char *refs_heads_master,
-		       const char *logmsg)
+int refs_update_symref(struct ref_store *refs, const char *ref,
+		       const char *target, const char *logmsg)
 {
 	struct ref_transaction *transaction;
 	struct strbuf err = STRBUF_INIT;
@@ -2295,8 +2293,8 @@ int refs_create_symref(struct ref_store *refs,
 
 	transaction = ref_store_transaction_begin(refs, &err);
 	if (!transaction ||
-	    ref_transaction_update(transaction, ref_target, NULL, NULL,
-				   refs_heads_master, NULL, REF_NO_DEREF,
+	    ref_transaction_update(transaction, ref, NULL, NULL,
+				   target, NULL, REF_NO_DEREF,
 				   logmsg, &err) ||
 	    ref_transaction_commit(transaction, &err)) {
 		ret = error("%s", err.buf);
@@ -2312,7 +2310,7 @@ int refs_create_symref(struct ref_store *refs,
 int create_symref(const char *ref_target, const char *refs_heads_master,
 		  const char *logmsg)
 {
-	return refs_create_symref(get_main_ref_store(the_repository), ref_target,
+	return refs_update_symref(get_main_ref_store(the_repository), ref_target,
 				  refs_heads_master, logmsg);
 }
 
diff --git a/refs.h b/refs.h
index c7851bf587..71cc1c58e0 100644
--- a/refs.h
+++ b/refs.h
@@ -606,7 +606,7 @@ int refs_copy_existing_ref(struct ref_store *refs, const char *oldref,
 int copy_existing_ref(const char *oldref, const char *newref,
 			const char *logmsg);
 
-int refs_create_symref(struct ref_store *refs, const char *refname,
+int refs_update_symref(struct ref_store *refs, const char *refname,
 		       const char *target, const char *logmsg);
 int create_symref(const char *refname, const char *target, const char *logmsg);
 
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index 82bbf6e2e6..4651e4ced7 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -118,7 +118,7 @@ static int cmd_create_symref(struct ref_store *refs, const char **argv)
 	const char *target = notnull(*argv++, "target");
 	const char *logmsg = *argv++;
 
-	return refs_create_symref(refs, refname, target, logmsg);
+	return refs_update_symref(refs, refname, target, logmsg);
 }
 
 static struct flag_definition transaction_flags[] = {
-- 
2.43.GIT

