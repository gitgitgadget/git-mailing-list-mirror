Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A442945C07
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412199; cv=none; b=EE+IlNndus32p4L1A6O51elOx2xVAmCR4I0SIF/HgeqwFZ6rLvxs/BhdkyLuPIgmB1LHGOsN2tvbZdxvXGBKQkt+R/3dv11oO+iJdllqQBTK7gHg5b8xcNmwkD4cT8/722rpfgVNZGuq1AMl96DXe0B/7jpuTLFAzUgeUd26hAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412199; c=relaxed/simple;
	bh=Qz+nDsLZj+c5Zu02rUyu+EGfNUaXxkn9Om0dikyFjRQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PbDoS8EBR0LJRfluhUng6htukODlZwUmYMlTDGxyr9TjW6ko9H6fwUEgk86SgwSvk9gHvIDN86wfmWR/RHdTKpMJxFwK0MSJYNFZd20G32eXpiUAD9a7blfoNwv4o7zjZEhhHDS+E6MMFIGQc/WbnS6XsB4D87x8Rv0Tv2Kvin8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=na2CWu5b; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="na2CWu5b"
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2ec10324791so81956291fa.1
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412195; x=1720016995; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEaRIqkrn/nVU9/+27kkujxPuiy8ceVVFNZtvynEzTw=;
        b=na2CWu5bTXifeGzjjoKmXB5PBaKpunSsynNRsX4vvJdJJ01VXDDeuIMOt4F6jGF5UT
         Yj9t7y5nuNcOQKWoLXpXzC3WUR3BmhwhmPtute4HFlq5sDG7V/qjg8igidk/H6qvF32M
         9u87me5SnI+6zVHs+3UGRLbEUorgaMEkPLUtI9TdRKTnm1NOpjZRkRwkHwXvzD98JYNB
         sIwup11c1ftjNundLuLVt8Af6SbGci/U0QZA8FI+1LeXvxKAkKk3dVd7UlV9ug+KQUZL
         Bc1kwUUZyE8CxjhYMRjqcD+psdqNwiW6hYRquxoN4jtJYOJ4dn5Ns2XYFVa2+iAinpoZ
         uYTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412195; x=1720016995;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEaRIqkrn/nVU9/+27kkujxPuiy8ceVVFNZtvynEzTw=;
        b=a2JaeWlMsFCcJ1xioy6NNmIrTxX7VTC9LXSta/a0MSah39YX5pd5Di4aBTsN13USHe
         OQRmpOVhlYQgo71cZZN2F8kA9rxOplHr5B0krTywbOo72C6nWlp949sQnxVB6NaFmy1B
         8dW/ngrBQcrfV+dFDI1f2Z0p6R7VZV8De+lhxSiEq5BkMD+wyWQqr9MU2AB4kShZet4L
         PE5OVIXWPZWA5EI0BOdWHkKhDFxV/UfQE7UEw6clm61IkVj3G/gBc1l2g9ieWaXmyX9M
         m1ZhnLzcEZquH7Jfm4MRItTx2+PPlieWB+OwTP+XIij9ja1vzVcUChVItT6SttG9oXVD
         Eu0w==
X-Gm-Message-State: AOJu0YzeH4p3Vwi0aAxBCdHSYeE5eh+NXN953eUDsgRa5zRkMM7BQRyD
	5EkPKdHnGzHnPaHmDdV1Pkc/42n7MqhVm5xg6fhA0M2hDxQ7bZ6CI19j+A==
X-Google-Smtp-Source: AGHT+IHDW2A2mQ1ExPUKIgbYGplSk6mViBVUbT6k30odTm+lgudzPRa43b+D9F9MDAfw8hk8UQeLUw==
X-Received: by 2002:a2e:9f46:0:b0:2eb:d924:43fb with SMTP id 38308e7fff4ca-2ec5b2dd3ebmr61423571fa.41.1719412195192;
        Wed, 26 Jun 2024 07:29:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366f624cdacsm8038206f8f.70.2024.06.26.07.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:54 -0700 (PDT)
Message-Id: <69c3beaabf7ca8ccf5bbaa248328f77b1be915ba.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:48 +0000
Subject: [PATCH v2 2/5] sparse-index: refactor path_found()
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: gitster@pobox.com,
    newren@gmail.com,
    anh@canva.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

In advance of changing the behavior of path_found(), take all of the
intermediate data values and group them into a single struct. This
simplifies the method prototype as well as the initialization. Future
changes can be made directly to the struct and method without changing
the callers with this approach.

Note that the clear_path_found_data() method is currently empty, as
there is nothing to free. This method is a placeholder for future
changes that require a non-trivial implementation. Its stub is created
now so consumers could call it now and not change in future changes.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 45 +++++++++++++++++++++++++++++----------------
 1 file changed, 29 insertions(+), 16 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index e0457c87fff..de6e727f5c1 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -439,8 +439,22 @@ void ensure_correct_sparsity(struct index_state *istate)
 		ensure_full_index(istate);
 }
 
-static int path_found(const char *path, const char **dirname, size_t *dir_len,
-		      int *dir_found)
+struct path_found_data {
+	const char *dirname;
+	size_t dir_len;
+	int dir_found;
+};
+
+#define PATH_FOUND_DATA_INIT { \
+	.dir_found = 1 \
+}
+
+static void clear_path_found_data(struct path_found_data *data)
+{
+	return;
+}
+
+static int path_found(const char *path, struct path_found_data *data)
 {
 	struct stat st;
 	char *newdir;
@@ -450,7 +464,7 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	 * If dirname corresponds to a directory that doesn't exist, and this
 	 * path starts with dirname, then path can't exist.
 	 */
-	if (!*dir_found && !memcmp(path, *dirname, *dir_len))
+	if (!data->dir_found && !memcmp(path, data->dirname, data->dir_len))
 		return 0;
 
 	/*
@@ -472,15 +486,16 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 	 * If path starts with directory (which we already lstat'ed and found),
 	 * then no need to lstat parent directory again.
 	 */
-	if (*dir_found && *dirname && memcmp(path, *dirname, *dir_len))
+	if (data->dir_found && data->dirname &&
+	    memcmp(path, data->dirname, data->dir_len))
 		return 0;
 
 	/* Free previous dirname, and cache path's dirname */
-	*dirname = path;
-	*dir_len = newdir - path + 1;
+	data->dirname = path;
+	data->dir_len = newdir - path + 1;
 
-	tmp = xstrndup(path, *dir_len);
-	*dir_found = !lstat(tmp, &st);
+	tmp = xstrndup(path, data->dir_len);
+	data->dir_found = !lstat(tmp, &st);
 	free(tmp);
 
 	return 0;
@@ -488,9 +503,7 @@ static int path_found(const char *path, const char **dirname, size_t *dir_len,
 
 static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
 {
-	const char *last_dirname = NULL;
-	size_t dir_len = 0;
-	int dir_found = 1;
+	struct path_found_data data = PATH_FOUND_DATA_INIT;
 
 	int path_count = 0;
 	int to_restart = 0;
@@ -502,7 +515,7 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 
 		if (ce_skip_worktree(ce)) {
 			path_count++;
-			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found)) {
+			if (path_found(ce->name, &data)) {
 				if (S_ISSPARSEDIR(ce->ce_mode)) {
 					to_restart = 1;
 					break;
@@ -516,14 +529,13 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 			   "sparse_path_count", path_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
+	clear_path_found_data(&data);
 	return to_restart;
 }
 
 static void clear_skip_worktree_from_present_files_full(struct index_state *istate)
 {
-	const char *last_dirname = NULL;
-	size_t dir_len = 0;
-	int dir_found = 1;
+	struct path_found_data data = PATH_FOUND_DATA_INIT;
 
 	int path_count = 0;
 
@@ -537,7 +549,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 		if (ce_skip_worktree(ce)) {
 			path_count++;
-			if (path_found(ce->name, &last_dirname, &dir_len, &dir_found))
+			if (path_found(ce->name, &data))
 				ce->ce_flags &= ~CE_SKIP_WORKTREE;
 		}
 	}
@@ -546,6 +558,7 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 			   "full_path_count", path_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
+	clear_path_found_data(&data);
 }
 
 void clear_skip_worktree_from_present_files(struct index_state *istate)
-- 
gitgitgadget

