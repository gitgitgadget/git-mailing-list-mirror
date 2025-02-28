Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C47F1D14FF
	for <git@vger.kernel.org>; Fri, 28 Feb 2025 21:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740778649; cv=none; b=OiAXVrG+jjyweOcsnem+0spUbyvuI9CuGqJThuagnb5gkw0CkRbjdlZe3Bc28BgXhAHuLi9srLwkfOULJMUOrsbBpGIfjHMWbGKwj294c/jHE+SMUl2ZCgamOF3lbRAK7EYWV7bfPHTlOKZEajyaKVx4ctwXUhwIOTwws/IK/Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740778649; c=relaxed/simple;
	bh=HYZ5VGtA4GCCDe7sBh9xrA92vGqyzGbqPcOQ4GDLiD8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t2iTn63XR/KBISdvrl85cyLmISndkm2hlWeiGikOxsr1dZ3bF8jbp9ctsdLE5Qj4u8R955TkfiPuodpYwuwI8GDKlKnuiWgJNixB+4SPZL4iLYvxy0YLnzXyBnUZ9pFi/nmcTp0Y9x2JaVrAegZE1sXpmplWlGYVSHic+F9XZcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dQpAMtlp; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dQpAMtlp"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7272a839f3dso681374a34.3
        for <git@vger.kernel.org>; Fri, 28 Feb 2025 13:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740778646; x=1741383446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ckOzq8PgJzuzv0amvxCPQqI+rojvDGfMOfTmgTr0nfw=;
        b=dQpAMtlpGz1FXH1XQSKyJ2H7quHRNMhcJSsIjgjG6GTCSlCyvKMjM7PBzHxwCH4ylK
         k8d4611glASCca8Or8xL8ftwHXsbWtDraxlo49zpMtSXYwTkReNFhiSttebs7RIn/U3e
         gP1r8vJLVhY7sDb2jH1lyOoNPkiuzmbGvgs+XI+fKOI8ufzSXbUUIu4Y93LFeIPMVoyM
         nh1KjlgEN1EXl0tGO17Pa1xk+suKowrVD8Y1AaZrCf2QXU3fmFaLytwYIoPyd+eIUeXN
         K7I+ynlhaEeqSQlO9giIe7a7BvTAgd1XdPoth8oE6XBg9XEpViWw31CmZheBBzPNKKvT
         p0Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740778646; x=1741383446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ckOzq8PgJzuzv0amvxCPQqI+rojvDGfMOfTmgTr0nfw=;
        b=av2dD/A86sEIVJOP91UhfeOMDYfErF4DfbRLPRhDjs7ah3y0WHxdoL8/B+r/VBUrwH
         KoutUlL9Fvfoj3QKesMx1htgYmJPTcAwECMc17uDlpyRkLDxOCNj4UDzzKBe3BI6QqMi
         6M8eAK5L9/eTYWhM1x0LKtxT5PEFLB119XXxo7hB54A3aN27y/iNvXj/4QwSyJWANKa1
         Fv7SHblHWLtgGfWnqs7HOQDspG1ZSysgXtQbRqgKBTwn52lBgrNHAEiesUujSKdSEG3K
         K5LfRgAHzs3DybCfYjouMBQkGYXCoBXjOdUIvGCQSFMBGAMYEqgf8YVOFsnBEhF4YARj
         6Uqw==
X-Gm-Message-State: AOJu0Yxc1MmQWZhVRzU1yjGBNl95/lElq47ue7NRfziXaolPHdYEdDyj
	x00gJJ4qc1cYIjM1WBroRUlIHJ5ekNEDxIi919msrJeSk/OMXkb19YWdbjjP
X-Gm-Gg: ASbGncsOJCPdI6WHNjOLxo9Fny4UvUxON8iCSSiNqPQjhb5iKR1cTECNEvN9h5XDyAj
	NwRkFYrsIfRmjMVYXwlXshzAgMu3MSz5gZ1a9lINwtHkcIDZdZlv3aZmnJUD6m+ezmcJYhkN1Wr
	muJezuSB0HC3YtlltYL4piJ2wuzpMAmhkVopjjpr03+wfPlKV8mBrpyTW/aJUwH3Truf82QMx7I
	im7UUKzws4IMdHfZkUCz+5HpLXMtycK2Fh1Ogwlh1HixuXB8LUpWq3eUABiWWf6tjAgzVFn7Gbj
	gtaBKp+bkRDOB/xSNngjz1BANOfWfZP9yWjQ2975FNih30VGhA0S
X-Google-Smtp-Source: AGHT+IHJ54vpQtYYAuDPWxDo13Lh8fMK6GwcO1JyNGPLeCCR3NhV3cwXnlrw7w35upz7q7Xa6MxZUA==
X-Received: by 2002:a05:6830:6d13:b0:727:41d9:bcd3 with SMTP id 46e09a7af769-728b829e750mr3386477a34.13.1740778646167;
        Fri, 28 Feb 2025 13:37:26 -0800 (PST)
Received: from denethor.localdomain ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5feaad46205sm783589eaf.36.2025.02.28.13.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2025 13:37:25 -0800 (PST)
From: Justin Tobler <jltobler@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v5 1/4] diff: return diff_filepair from diff queue helpers
Date: Fri, 28 Feb 2025 15:33:43 -0600
Message-ID: <20250228213346.1335224-2-jltobler@gmail.com>
X-Mailer: git-send-email 2.49.0.rc0
In-Reply-To: <20250228213346.1335224-1-jltobler@gmail.com>
References: <20250228002604.3859939-1-jltobler@gmail.com>
 <20250228213346.1335224-1-jltobler@gmail.com>
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
`diff_filepair`. Both `diff_addremove()` and `diff_change()` are
reimplemented as thin wrappers around the new functions.

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
2.49.0.rc0

