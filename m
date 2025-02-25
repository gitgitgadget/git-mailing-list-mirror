Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47F9B235BF4
	for <git@vger.kernel.org>; Tue, 25 Feb 2025 23:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740526974; cv=none; b=l7DCJOMUjoqYNAtBhu6ECfnFlgvsG3XgCiJUkkpTEDWQzILPAzmEpIVk4PqqrPq4SKkLZZMBMpVqbkzf/GQPMdYwV0w0B9lLtHFkZPtDLnQetUV1rXtS1dKXlJebwxqjs8oYjn/QnysepzVVgZYSzBQeKpN71hm0aC5yZcuvOU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740526974; c=relaxed/simple;
	bh=s5pmylBMPrgv8R6XXgZI0FuwefJC9j9tKO48NCXyWaE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IcifTKvGRxsZss4NVWrMO8BDUtlkkaXaa98OG2OT9jd2AKsKFr1yvP5IYv4uFQeJDl81GU24FP97CyVWNmh8Lc9bR0EiceqTAeRDna/4dNrL+uruNK+2VcDpnFHarGlImfOQK12IHbuPccWHiKK/LKi9U0l7YI86VcxHcSTgGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OI33AyDL; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OI33AyDL"
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7272f3477e9so1901772a34.3
        for <git@vger.kernel.org>; Tue, 25 Feb 2025 15:42:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740526972; x=1741131772; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D3RWgs1kZQK6RfOE4QBpVa0M0RoOUlUV1dcBc6a6OJk=;
        b=OI33AyDL6vbpZCEUSSOzOAuYcggLhFo4BmjV6NoyCk+fnGd5gIdwd0H0aNGXI6QuwG
         07VvKJ2kXb3OUGIvncVinzxJlJykmQVbsuEjKwt9stUz0muN4NOv7fioIpUgam/zDvti
         bRlrz2rdaQUGfysL0KrusMnwBSzscO/cveVBC3Meeb+OKDC0PRLbkwczBIhM9qLlRtgj
         euR6Fp41gKkPmQNoLqPqW0+qOkp+kxr/fR5qi7E/vKVwN3DtJNt3W6Rx4ZCHFNTYTmD6
         QcVnNp9ZBT6+qg4ph8BaRjPtdLsz8EI65vpZYBryqiA5ijo1MTUUsfcmDSf3Ge6gV6VG
         YHaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740526972; x=1741131772;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D3RWgs1kZQK6RfOE4QBpVa0M0RoOUlUV1dcBc6a6OJk=;
        b=PVpt8HBbIVWxYhH9yZt9CUvbHsx0ivYLqUJ4XqB1aiuH5AmI4EC3i9XE/WNpM//BIa
         80zjHe1AF+TOTnwXhCoXvugqGAUTdMk1QkFkC1ERc/YSE2fcGSM2axY1TXRW67fRPK0w
         QrRpsOvLB7GZeatoVpMvrkkqIltwh23j4R8NKDWadAAQh4KKZLZu5lOeiwqT3BV3iVvE
         QalgttMwhfDupgsmOcd3AUCR9jdo6ZM9OIbOUEvK95B/gT1RTl77JPqNRQDgU7wSlzit
         /Sg0/zLoEiG5vH4pOXKBBGfZjut5zt/Ll9f1m1XA0Yd40ThEzpgnt0aJIxLqZ/SnnOSW
         0PDA==
X-Gm-Message-State: AOJu0YwcRLS0IO49EG1sr/5/eQ8Y+0QDFv585zWRVEArF4OYeTQyr5/t
	c+LL+DYAIUf16iBYEadaUupB71zDQ/S3h3kqHOLKxnNhT56yERtaGVRq3V0d
X-Gm-Gg: ASbGncs2zXUtzPMN+ZaeXRWU4yVj/7+doGawj8l9BByUv5TKHhJfDhLu2/HbZtZAZT8
	/GuuwOrVxrK7oqDNJF/SdEtJMz7gO5FZggMNCH37DFyoXMOKje4KgtJC5BL15Xf7G++8P/Mo5D3
	nqyROANlqnGy0KJ/MkGPcsgHdsZyidFOClNOiOcPBIgis+L2K6eYJP9coIPG1NJQsg76h7XV9vx
	Cxgupp7a3ABpw8QZV94X1bxA+YL+PKbrCKZ0fVojRgDu0H6TvcWlfLhejeBiJRiiGbJa/EWKtuK
	OXycv25FgLTp1OkRpJeIKR6I3hV9JvkqaQ==
X-Google-Smtp-Source: AGHT+IETRXLhbjtMe47+9U7OaerpvkJT2t+M3A0j+rdvZc8upsW9Qb2Uj5v2wPOMnUYTdcBf2OOheA==
X-Received: by 2002:a05:6830:6e0f:b0:727:2751:6b9d with SMTP id 46e09a7af769-7289d0fad72mr3738921a34.9.1740526971668;
        Tue, 25 Feb 2025 15:42:51 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2c1113f5bc5sm609308fac.21.2025.02.25.15.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Feb 2025 15:42:50 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 1/3] diff: return diff_filepair from diff queue helpers
Date: Tue, 25 Feb 2025 17:39:23 -0600
Message-ID: <20250225233925.1345086-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250225233925.1345086-1-jltobler@gmail.com>
References: <20250212041825.2455031-1-jltobler@gmail.com>
 <20250225233925.1345086-1-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `diff_addremove()` and `diff_change()` functions set up and queue
diffs, but do not return the `diff_filepair` added to the queue. In a
subsequent commit, modifications to `diff_filepair` need to occur in
certain cases after being queued.

Since the existing `diff_addremove()` and `diff_change()` are also used
for callbacks in `diff_options` as types `add_remove_fn_t` and
`change_fn_t`, modifying the existing function signatures requires
further changes. The diff options for pruning use `file_add_remove()`
and `file_change()` where file pairs do not even get queued. Thus,
separate functions are implemented instead.

Split out the queuing operations into `diff_queue_addremove()` and
`diff_queue_change()` which also return a handle to the queued
`diff_filepair`.

Signed-off-by: Justin Tobler <jltobler@gmail.com>
---
 diff.c | 70 +++++++++++++++++++++++++++++++++++++++++-----------------
 diff.h | 25 +++++++++++++++++++++
 2 files changed, 75 insertions(+), 20 deletions(-)

diff --git a/diff.c b/diff.c
index 019fb893a7..b5a779f997 100644
--- a/diff.c
+++ b/diff.c
@@ -7157,16 +7157,19 @@ void compute_diffstat(struct diff_options *options,
 	options->found_changes = !!diffstat->nr;
 }
 
-void diff_addremove(struct diff_options *options,
-		    int addremove, unsigned mode,
-		    const struct object_id *oid,
-		    int oid_valid,
-		    const char *concatpath, unsigned dirty_submodule)
+struct diff_filepair *diff_queue_addremove(struct diff_queue_struct *queue,
+					   struct diff_options *options,
+					   int addremove, unsigned mode,
+					   const struct object_id *oid,
+					   int oid_valid,
+					   const char *concatpath,
+					   unsigned dirty_submodule)
 {
 	struct diff_filespec *one, *two;
+	struct diff_filepair *pair;
 
 	if (S_ISGITLINK(mode) && is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	/* This may look odd, but it is a preparation for
 	 * feeding "there are unchanged files which should
@@ -7186,7 +7189,7 @@ void diff_addremove(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7198,25 +7201,29 @@ void diff_addremove(struct diff_options *options,
 		two->dirty_submodule = dirty_submodule;
 	}
 
-	diff_queue(&diff_queued_diff, one, two);
+	pair = diff_queue(queue, one, two);
 	if (!options->flags.diff_from_contents)
 		options->flags.has_changes = 1;
+
+	return pair;
 }
 
-void diff_change(struct diff_options *options,
-		 unsigned old_mode, unsigned new_mode,
-		 const struct object_id *old_oid,
-		 const struct object_id *new_oid,
-		 int old_oid_valid, int new_oid_valid,
-		 const char *concatpath,
-		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
+struct diff_filepair *diff_queue_change(struct diff_queue_struct *queue,
+					struct diff_options *options,
+					unsigned old_mode, unsigned new_mode,
+					const struct object_id *old_oid,
+					const struct object_id *new_oid,
+					int old_oid_valid, int new_oid_valid,
+					const char *concatpath,
+					unsigned old_dirty_submodule,
+					unsigned new_dirty_submodule)
 {
 	struct diff_filespec *one, *two;
 	struct diff_filepair *p;
 
 	if (S_ISGITLINK(old_mode) && S_ISGITLINK(new_mode) &&
 	    is_submodule_ignored(concatpath, options))
-		return;
+		return NULL;
 
 	if (options->flags.reverse_diff) {
 		SWAP(old_mode, new_mode);
@@ -7227,7 +7234,7 @@ void diff_change(struct diff_options *options,
 
 	if (options->prefix &&
 	    strncmp(concatpath, options->prefix, options->prefix_length))
-		return;
+		return NULL;
 
 	one = alloc_filespec(concatpath);
 	two = alloc_filespec(concatpath);
@@ -7235,19 +7242,42 @@ void diff_change(struct diff_options *options,
 	fill_filespec(two, new_oid, new_oid_valid, new_mode);
 	one->dirty_submodule = old_dirty_submodule;
 	two->dirty_submodule = new_dirty_submodule;
-	p = diff_queue(&diff_queued_diff, one, two);
+	p = diff_queue(queue, one, two);
 
 	if (options->flags.diff_from_contents)
-		return;
+		return p;
 
 	if (options->flags.quick && options->skip_stat_unmatch &&
 	    !diff_filespec_check_stat_unmatch(options->repo, p)) {
 		diff_free_filespec_data(p->one);
 		diff_free_filespec_data(p->two);
-		return;
+		return p;
 	}
 
 	options->flags.has_changes = 1;
+
+	return p;
+}
+
+void diff_addremove(struct diff_options *options, int addremove, unsigned mode,
+		    const struct object_id *oid, int oid_valid,
+		    const char *concatpath, unsigned dirty_submodule)
+{
+	diff_queue_addremove(&diff_queued_diff, options, addremove, mode, oid,
+			     oid_valid, concatpath, dirty_submodule);
+}
+
+void diff_change(struct diff_options *options,
+		 unsigned old_mode, unsigned new_mode,
+		 const struct object_id *old_oid,
+		 const struct object_id *new_oid,
+		 int old_oid_valid, int new_oid_valid,
+		 const char *concatpath,
+		 unsigned old_dirty_submodule, unsigned new_dirty_submodule)
+{
+	diff_queue_change(&diff_queued_diff, options, old_mode, new_mode,
+			  old_oid, new_oid, old_oid_valid, new_oid_valid,
+			  concatpath, old_dirty_submodule, new_dirty_submodule);
 }
 
 struct diff_filepair *diff_unmerge(struct diff_options *options, const char *path)
diff --git a/diff.h b/diff.h
index 0a566f5531..63afa17e84 100644
--- a/diff.h
+++ b/diff.h
@@ -508,6 +508,31 @@ void diff_set_default_prefix(struct diff_options *options);
 
 int diff_can_quit_early(struct diff_options *);
 
+/*
+ * Stages changes in the provided diff queue for file additions and deletions.
+ * If a file pair gets queued, it is returned.
+ */
+struct diff_filepair *diff_queue_addremove(struct diff_queue_struct *queue,
+					   struct diff_options *,
+					   int addremove, unsigned mode,
+					   const struct object_id *oid,
+					   int oid_valid, const char *fullpath,
+					   unsigned dirty_submodule);
+
+/*
+ * Stages changes in the provided diff queue for file modifications.
+ * If a file pair gets queued, it is returned.
+ */
+struct diff_filepair *diff_queue_change(struct diff_queue_struct *queue,
+					struct diff_options *,
+					unsigned mode1, unsigned mode2,
+					const struct object_id *old_oid,
+					const struct object_id *new_oid,
+					int old_oid_valid, int new_oid_valid,
+					const char *fullpath,
+					unsigned dirty_submodule1,
+					unsigned dirty_submodule2);
+
 void diff_addremove(struct diff_options *,
 		    int addremove,
 		    unsigned mode,
-- 
2.48.1

