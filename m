Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD9158D70
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 12:43:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719578616; cv=none; b=ZXmprMSXqUUSU/5x90rXkFuWWxli9NmUDfqcxsJHHoDmkO1fTgYRKQDPs7qPjq9hizDWRlxVQ0aw3qHUNsiYpYGwKAvZQFzadUxkFIrNQg7h3ooiX2y57673IcRuVOF7dItFlxvVR+1d3hRckNEzDYfiB46i3zeCuwIzWxEyBO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719578616; c=relaxed/simple;
	bh=v7pEIAOQacxrKcSmfYu3MMPjIoqKiKMlpNo3w47ds7I=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=ToUH0/LTVPtlbwMRGOmupWTe+goPxMKiuzmtA5SX6pogFwe06/BSn8wwDmOvcKgEIB+hM1fUlV2EFEXFEiOWUrEKdIh5Vnn5xl6kLiR2vG06Mg852/+QZZQARjh0BrF/HGcasH1xwymXE+8H1d/u3gADYccxzQmIPP0OUjLuBh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YUSUTwED; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YUSUTwED"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-363bd55bcc2so331120f8f.2
        for <git@vger.kernel.org>; Fri, 28 Jun 2024 05:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719578613; x=1720183413; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=YUSUTwEDZYyIgRrXpzqWO7Uo6sAx/TC/ruPj8XQIvz03W66aytqqL5fM+uLfoIOoNk
         3DzxHSfo2/nu9dMbjMNQ7Y0KawwzWrjSc9ucLvpKUA2MwadkHhSp5QWS73ANovgmDkL8
         KuNnodIrPtqUpzlkop7RYb2y0rUnFsESxavpaW1nkA+/g6W0BFgci8n0TTdazGhd5D5j
         sNn9VxA7W/ObwG9RxszUkxje5GIKcm1N4mJROrybJp/D1StzfJri6inKZwqAB5avMe3t
         Cqz0/psNwZRhB9d4vlHNU0TNVjZSgBf4M1HyINmPLxgebDCDhoW8c/ulSjDUFGPJvvPW
         iiLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719578613; x=1720183413;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KauGz/GdUXdGho5U7fUDm2FdMS4nlt8MegpX3RmXHxs=;
        b=G/zWwS9cKXUNxsWJs7t1IeoGeQNL/W8seW7jiKzK5Jd1oYjQQISF6qk/Sb6ctmQqg5
         zPI3W10/y5TRLT3Y8VuDdt5FR0wtd8OJPe2quFqoRugpFnPWBpwgbpegY/LUNAV+gIFL
         VuPKGGrFXQqRY+nCgjt4HAs5h3NCh9LrdwQ7KjE71CP1sZProXBIunYMt26/uFUm2pHI
         1/OmsOvChWQZPFZs3ThxIxumXuG3+IIpYjvOQSG+hb6zcFQvZGBX61V6/SnxjFJ6fE8R
         5XcvZgeUjcTYJ21KcFXLS0/ICRM5Wy1qWIwT1WkHa0PJtQ7z5HUufGn+hR05odXWgz8y
         XfgQ==
X-Gm-Message-State: AOJu0YzmOf7jFyiZV+PvPDldSUgfPoXG08ABGEzzQTCkpwP2jW7EWDaB
	9HU4fz/Ku8R6uP6pOEh6kfDjUsJmPblIbX6Rr8YuHHisOqUEX3ieMqFn8g==
X-Google-Smtp-Source: AGHT+IF+zwXZ4F3qsl8YgX7CJ4geFaW6gXd4kvUNerPew2OWZ9g85K53v1lDwOagq6Rvp3V11VGeCA==
X-Received: by 2002:a05:6000:b44:b0:35f:11c5:5c74 with SMTP id ffacd0b85a97d-366e94cc54amr10031556f8f.36.1719578612859;
        Fri, 28 Jun 2024 05:43:32 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3675a0fc5f4sm2216498f8f.75.2024.06.28.05.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jun 2024 05:43:32 -0700 (PDT)
Message-Id: <db6ded0df0d8abed01442cb44703f3d662a06294.1719578605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
References: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
	<pull.1754.v3.git.1719578605.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 28 Jun 2024 12:43:24 +0000
Subject: [PATCH v3 4/5] sparse-index: count lstat() calls
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

The clear_skip_worktree.. methods already report some statistics about
how many cache entries are checked against path_found() due to having
the skip-worktree bit set. However, due to path_found() performing some
caching, this isn't the only information that would be helpful to
report.

Add a new lstat_count member to the path_found_data struct to count the
number of times path_found() calls lstat(). This will be helpful to help
explain performance problems in this method as well as to demonstrate
future changes to the caching algorithm in a more concrete way than
end-to-end timings.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/sparse-index.c b/sparse-index.c
index fec4f393360..8577fa726b8 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -442,6 +442,7 @@ void ensure_correct_sparsity(struct index_state *istate)
 struct path_found_data {
 	struct strbuf dir;
 	int dir_found;
+	size_t lstat_count;
 };
 
 #define PATH_FOUND_DATA_INIT { \
@@ -469,6 +470,7 @@ static int path_found(const char *path, struct path_found_data *data)
 	/*
 	 * If path itself exists, return 1.
 	 */
+	data->lstat_count++;
 	if (!lstat(path, &st))
 		return 1;
 
@@ -493,6 +495,7 @@ static int path_found(const char *path, struct path_found_data *data)
 	strbuf_reset(&data->dir);
 	strbuf_add(&data->dir, path, newdir - path + 1);
 
+	data->lstat_count++;
 	data->dir_found = !lstat(data->dir.buf, &st);
 
 	return 0;
@@ -524,6 +527,8 @@ static int clear_skip_worktree_from_present_files_sparse(struct index_state *ist
 
 	trace2_data_intmax("index", istate->repo,
 			   "sparse_path_count", path_count);
+	trace2_data_intmax("index", istate->repo,
+			   "sparse_lstat_count", data.lstat_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_sparse",
 			    istate->repo);
 	clear_path_found_data(&data);
@@ -553,6 +558,8 @@ static void clear_skip_worktree_from_present_files_full(struct index_state *ista
 
 	trace2_data_intmax("index", istate->repo,
 			   "full_path_count", path_count);
+	trace2_data_intmax("index", istate->repo,
+			   "full_lstat_count", data.lstat_count);
 	trace2_region_leave("index", "clear_skip_worktree_from_present_files_full",
 			    istate->repo);
 	clear_path_found_data(&data);
-- 
gitgitgadget

