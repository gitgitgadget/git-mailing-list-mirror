Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362E9158868
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:43:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578613; cv=none; b=rnl5ev9UK8EI03rEf6ly7Ny0Cmpqe6gThD2PrfsT8UsWijfbOST5DlYVp6aPnXy1vSpwoD8GmsLsC0Gq3MPZhSOgejkO1uDtdBut5EBoC9tKRRCEDh3zAlXms36Xw6H15JmTnh3L8smJiWZQcF6h8CIQvxV8JiGlErg/UKtvTQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578613; c=relaxed/simple;
	bh=Qz+nDsLZj+c5Zu02rUyu+EGfNUaXxkn9Om0dikyFjRQ=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=MYdCMd1+aTN+OJyRLVfUuncRv8nRfTqHtEQjt3RTQBLPtIekzz+Tl6yaeIXVjmfxnQgUaLTWvh0OZ57zomQ98zoiSKcEwJY/eAVN6l2JzxA/Jy56xwCxR+1EwRzUBz7rMy4Ebcdjmbu+mPdp60Fhh/ZyeNX7yWF/4U8f/1605yQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ccL0w+V9; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ccL0w+V9"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42562a984d3so4474985e9.3
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578609; x=1720183409; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rEaRIqkrn/nVU9/+27kkujxPuiy8ceVVFNZtvynEzTw=;
        b=ccL0w+V9f8EjwmndZH4LziMmSLczdQs5PfvxHMgS20WF/L468VE8EOFd2WjA7m3+du
         5p/DLDNQVJemg6HlgyrCUSdz1Ea2wYgQtIUnCG6HIXlBIumNTm/fFS8LCFoZzl7+/VLf
         XupUCez3Su/QhpJDBeT8VAUdIV71I2eK/Nt4Au8wLJvzsZXP2e8oBg0B5I8LAAWq+E9s
         m3tFThtbkBvASlKHF3kWynTwIOBkyP6+T8GYsf95IihFdY7QIfH0JF0+gBOSyo/q5cuZ
         tVbBC6DlOZD9Vx0EHWCI/bGvbSRTU+fM5jxFpXXoWTM8m5WzEuRtuu7BfT1Zx1832zxd
         a0Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578609; x=1720183409;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rEaRIqkrn/nVU9/+27kkujxPuiy8ceVVFNZtvynEzTw=;
        b=raflh2MdaG/03jB4w0C8PDymX2vrxuTiMFYzOwxgcxeNQagf/JEG48xld8GP9I3oOD
         9I3ymHdZKGIO9v1OAsrE7PQdRVgkol7ZuypkdyyQVp7kFTfrVXiJkawn2BJYk9Gz9EuX
         yQLGQRl19IEZJS+Q6Otf68P8DvcMmlbgvd2iGgv457YprzMPqp84yXYTsRw+8W5OWA2w
         lDWrUZ/OSsJ0y56FE0ruy1z4aJFvwncC41IV9mp9waKH30b1HWQvU8vsFaBH+BVhwvA7
         2rlOxOtjXGOwsdWm6jJhIt54e+Oo0n7tFBX7MslO75RsX16Pvt5WpE+fi6T5+76tYBV2
         IySQ==
X-Gm-Message-State: AOJu0YzqUfWtViaONXCJ9BXpW8TS4Psews7MJYR5pj746tn2a48YzGp5
	QVEap8A8JFH2JZoFkjHDm6+Ej62nKMlmU+Du9eVZzOVlXfDNmK2ZKPlsPw==
X-Google-Smtp-Source: AGHT+IHMiXcoh+rYa7tzgL5ietdZ0apECsDjT0qb7QJvdE8j607KDNHtAxNOxuxwfX6sZXMYUL8oPg==
X-Received: by 2002:a05:600c:1c29:b0:424:a5df:b998 with SMTP id 5b1f17b1804b1-424a5dfba38mr65167665e9.9.1719578609233;
        Fri, 28 Jun 2024 05:43:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b068e93sm33952985e9.24.2024.06.28.05.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:43:28 -0700 (PDT)
Message-Id: <c242e2c9168108e814b4a428b77caca674045351.1719578605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Jun 2024 12:43:22 +0000
Subject: [PATCH v3 2/5] sparse-index: refactor path_found()
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

