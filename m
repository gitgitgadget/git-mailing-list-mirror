Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C65B1B29B9
	for <git@vger.kernel.org>; Thu, 20 Jun 2024 16:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718899887; cv=none; b=Z36p9lVcLIhNied9JLJcmwnk0U9lDorkfFUB7XLcVknKe6Y8cJVSL6KZBVIyc/EU4BuPozrSY46dQyDryucSP8hWhG601FsNj1+19k9tiqdNITlgnJNjI06hyNk6DRMy9+IhflnSLAQq+gCQWkI2wBAPFlpyAwh0fc9fQ/R10gg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718899887; c=relaxed/simple;
	bh=/SiHuettgMHg8Ks/9mWvhpAqHOKYKIYZrFACrCV40KI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fV/G7Oegh1xk0n6zG+sAqzoPTvSrEFEItLD9TU2PWOdrmHXIEnceoQrvp2j/WqGUrvbne+4C7ZcKLT1VJBhksRozedqzhWZOzqgeGqlmvfoDxkojmg2p4FBjl3weNUV90Dor/2u1juV7+YM6LW+BRir/SmDYbJVAXYiXozE5RLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XUr/UMm4; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XUr/UMm4"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-42108856c33so13761305e9.1
        for <git@vger.kernel.org>; Thu, 20 Jun 2024 09:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718899883; x=1719504683; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyEfFF4zOCU9gYDloKyPVM3FVbc/OWOLlCA9CrhoIEg=;
        b=XUr/UMm4TunYfPRw/AAp38zl7hUb+OlqJxSnr2UrsAIReFSjgPkCcXSPEGIW+6/aHp
         HDMaWzzcHOWCeTRQo1yPl3nrIFAHMy+OS9YbWwsK+f9FoppYc2LGlthkSeI+SZVhKDx5
         miDG8d/Wme71io0d0Qp337zzVXQ35TiIZ9AkldZnhsLKu67v1uO4E8EHPypGSLJ0VsJ2
         1KjqXhrywKa+Ilw9u+mLVxGfz4uBrOdNtiaC9f7EHON50xW2Do8tmHorZJIkZhjZSsCT
         vjscJS9sGYRWg6D1gwe3uYPq1WOim4eJI+PL6erjK8G2bcYqxtNxzy5u4cGi3i0cokj2
         h9fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718899883; x=1719504683;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xyEfFF4zOCU9gYDloKyPVM3FVbc/OWOLlCA9CrhoIEg=;
        b=p3bZPhDwyl36yjtfFB4wi4+cgQBsceR9KUrKejMOpAAHtnHkVuSIgW2FuJufwYA6cg
         Y4I/tfVigructnl9LQ/7+Wy3TNbAKazWeXJnkqM+C/g4vrO5ZpX10BPVVd6raEj6v0/X
         uG7G38EXBgB2RSbF260ZCLc+ELfNF/WVN3I3Ow3rIqLxfMxeMfnXsbJQsElni15W1DB8
         3m+zCjJnMKUuMlx79UZa0mPuMXJpFUVAUUjDnPqXeVwHZNqfXvKz2zdXWZKfPQ21GmEj
         /a7EQWhpFpLoVIkOuM2I7G2aLAXd0FGN4ADJaETcJc5L2gSNZ+mBQNsZ9OPweq1+sXOI
         PxQw==
X-Gm-Message-State: AOJu0YyXBSXQyLwCBCYiOw9mI0b1cImF7bsL1oqV/kPeNuYEv5SebqkT
	Em2XsOOxd43XKdcq21sJJTh9A4Wr3M1z2MXcGiBZa64BXv+9sH74Zba16Q==
X-Google-Smtp-Source: AGHT+IG41lJIfbZEv8KzF9+tuLzpZxZ1X9g2GftvS21dMIhRcr3NnJBiwfzXraGE7DzEGLz37i/MyQ==
X-Received: by 2002:a05:600c:4506:b0:422:291:6b3e with SMTP id 5b1f17b1804b1-4246f56d2b6mr86963085e9.1.1718899883200;
        Thu, 20 Jun 2024 09:11:23 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-360917c264bsm12847882f8f.56.2024.06.20.09.11.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jun 2024 09:11:22 -0700 (PDT)
Message-Id: <2654fcb7142a606c5684c762ed28bb5e8d9b4712.1718899877.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 20 Jun 2024 16:11:17 +0000
Subject: [PATCH 5/5] sparse-index: improve lstat caching of sparse paths
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

The clear_skip_worktree_from_present_files() method was first introduced
in af6a51875a (repo_read_index: clear SKIP_WORKTREE bit from files
present in worktree, 2022-01-14) to allow better interaction with the
working directory in the presence of paths outside of the
sparse-checkout cone. The initial implementation would lstat() every
single sparse tree to see if it existed, and if one did, then the sparse
index would expand and every sparse file would be checked.

Since these lstat() calls were very expensive, this was improved in
d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
caching, 2022-01-14) by caching directories that do not exist. However,
there are some inefficiencies in that caching mechanism.

The caching mechanism stored only the parent directory as not existing,
even if a higher parent directory also does not exist. This means that
wasted lstat() calls would occur when the sparse files change immediate
parent directories but within the same root directory that does not
exist.

To set up a scenario that triggers this code in an interesting way, we
need a sparse-checkout in cone mode and a sparse index. To trigger the
full index expansion and a call to the
clear_skip_worktree_from_present_files_full() method, we need one of the
sparse trees to actually exist on disk. The performance test script
p2000-sparse-operations.sh takes the sample repository and copies its
HEAD to several copies nested in directories of the form f<i>/f<j>/f<k>
where i, j, and k are numbers from 1 to 4. The sparse-checkout cone is
then selected as "f2/f4/". Creating "f1/f1/" will trigger the behavior
and also lead to some interesting cases for the caching algorithm since
"f1/f1/" exists but "f1/f2/" and "f3/" do not.

This is difficult to notice when running performance tests using the Git
repository (or a blow-up of the Git repository, as in
p2000-sparse-operations.sh) because Git has a very shallow directory
structure.

This change reorganizes the caching algorithm to focus on storing both
the deepest _existing_ directory and the next-level non-existing
directory. By doing a little extra work on the first sparse file, we can
short-circuit all of the sparse files that exist in that non-existing
directory. When in a repository where the first sparse file is likely to
have a much deeper path than the first non-existing directory, this can
realize significant gains.

The details of this algorithm require careful attention, so the new
implementation of path_found() has detailed comments, including the use
of a new max_common_dir_prefix() method that may be of independent
interest.

It's worth noting that this is not universally positive, since we are
doing extra lstat() calls to establish the exact path to cache. In the
blow-up of the Git repository, we can see that the lstat count
_increases_ from 28 to 31. However, these numbers were already
artificially low.

Using an internal monorepo with over two million paths at HEAD and a
typical sparse-checkout cone such that the index contains ~190,000
entries (including over two thousand sparse trees), I was able to
measure these lstat counts when one sparse directory actually exists on
disk:

  Sparse files in expanded index: 1,841,997
       full_lstat_count (before):   173,259
       full_lstat_count  (after):     6,521

This resulted in this absolute time change, on a warm disk:

      Time in full loop (before): 2.527 s
      Time in full loop  (after): 0.071 s

(These times were calculated on a Windows machine, where lstat() is
slower than a similar Linux machine.)

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 118 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 93 insertions(+), 25 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8577fa726b8..cccd8550dfe 100644
--- a/sparse-index.c
+++ b/sparse-index.c
@@ -440,14 +440,21 @@ void ensure_correct_sparsity(struct index_state *istate)
 }
 
 struct path_found_data {
+	/**
+	 * The path stored in 'dir', if non-empty, corresponds to the most-
+	 * recent path that we checked where:
+	 *
+	 *   1. The path should be a directory, according to the index.
+	 *   2. The path does not exist.
+	 *   3. The parent path _does_ exist. (This may be the root of the
+	 *      working directory.)
+	 */
 	struct strbuf dir;
-	int dir_found;
 	size_t lstat_count;
 };
 
 #define PATH_FOUND_DATA_INIT { \
-	.dir = STRBUF_INIT, \
-	.dir_found = 1 \
+	.dir = STRBUF_INIT \
 }
 
 static void clear_path_found_data(struct path_found_data *data)
@@ -455,50 +462,111 @@ static void clear_path_found_data(struct path_found_data *data)
 	strbuf_release(&data->dir);
 }
 
+/**
+ * Return the length of the largest common substring that ends in a
+ * slash ('/') to indicate the largest common parent directory. Returns
+ * zero if no common directory exists.
+ */
+static size_t max_common_dir_prefix(const char *path1, const char *path2)
+{
+	size_t common_prefix = 0;
+	for (size_t i = 0; path1[i] && path2[i]; i++) {
+		if (path1[i] != path2[i])
+			break;
+
+		/*
+		 * If they agree at a directory separator, then add one
+		 * to make sure it is included in the common prefix string.
+		 */
+		if (path1[i] == '/')
+			common_prefix = i + 1;
+	}
+
+	return common_prefix;
+}
+
 static int path_found(const char *path, struct path_found_data *data)
 {
 	struct stat st;
-	char *newdir;
+	size_t common_prefix;
 
 	/*
-	 * If dirname corresponds to a directory that doesn't exist, and this
-	 * path starts with dirname, then path can't exist.
+	 * If data->dir is non-empty, then it contains a path that doesn't
+	 * exist, including an ending slash ('/'). If it is a prefix of 'path',
+	 * then we can return 0.
 	 */
-	if (!data->dir_found && !memcmp(path, data->dir.buf, data->dir.len))
+	if (data->dir.len && !memcmp(path, data->dir.buf, data->dir.len))
 		return 0;
 
 	/*
-	 * If path itself exists, return 1.
+	 * Otherwise, we must check if the current path exists. If it does, then
+	 * return 1. The cached directory will be skipped until we come across
+	 * a missing path again.
 	 */
 	data->lstat_count++;
 	if (!lstat(path, &st))
 		return 1;
 
 	/*
-	 * Otherwise, path does not exist so we'll return 0...but we'll first
-	 * determine some info about its parent directory so we can avoid
-	 * lstat calls for future cache entries.
+	 * At this point, we know that 'path' doesn't exist, and we know that
+	 * the parent directory of 'data->dir' does exist. Let's set 'data->dir'
+	 * to be the top-most non-existing directory of 'path'. If the first
+	 * parent of 'path' exists, then we will act ast though 'path'
+	 * corresponds to a directory (by adding a slash).
 	 */
-	newdir = strrchr(path, '/');
-	if (!newdir)
-		return 0; /* Didn't find a parent dir; just return 0 now. */
+	common_prefix = max_common_dir_prefix(path, data->dir.buf);
 
 	/*
-	 * If path starts with directory (which we already lstat'ed and found),
-	 * then no need to lstat parent directory again.
+	 * At this point, 'path' and 'data->dir' have a common existing parent
+	 * directory given by path[0..common_prefix] (which could have length 0).
+	 * We "grow" the data->dir buffer by checking for existing directories
+	 * along 'path'.
 	 */
-	if (data->dir_found && data->dir.buf &&
-	    memcmp(path, data->dir.buf, data->dir.len))
-		return 0;
 
-	/* Free previous dirname, and cache path's dirname */
-	strbuf_reset(&data->dir);
-	strbuf_add(&data->dir, path, newdir - path + 1);
+	strbuf_setlen(&data->dir, common_prefix);
+	while (1) {
+		/* Find the next directory in 'path'. */
+		const char *next_slash = strchr(path + data->dir.len, '/');
 
-	data->lstat_count++;
-	data->dir_found = !lstat(data->dir.buf, &st);
+		/*
+		 * If there are no more slashes, then 'path' doesn't contain a
+		 * non-existent _parent_ directory. Set 'data->dir' to be equal
+		 * to 'path' plus an additional slash, so it can be used for
+		 * caching in the future. The filename of 'path' is considered
+		 * a non-existent directory.
+		 *
+		 * Note: if "{path}/" exists as a directory, then it will never
+		 * appear as a prefix of other callers to this method, assuming
+		 * the context from the clear_skip_worktree... methods. If this
+		 * method is reused, then this must be reconsidered.
+		 */
+		if (!next_slash) {
+			strbuf_addstr(&data->dir, path + data->dir.len);
+			strbuf_addch(&data->dir, '/');
+			break;
+		}
 
-	return 0;
+		/*
+		 * Now that we have a slash, let's grow 'data->dir' to include
+		 * this slash, then test if we should stop.
+		 */
+		strbuf_add(&data->dir, path + data->dir.len,
+			   (next_slash - path) - data->dir.len + 1);
+
+		/* If the path doesn't exist, then stop here. */
+		data->lstat_count++;
+		if (lstat(data->dir.buf, &st))
+			return 0;
+	}
+
+	/*
+	 * At this point, 'data->dir' is equal to 'path' plus a slash character,
+	 * and the parent directory of 'path' definitely exists. Let's return
+	 * the case of whether 'path' exists.
+	 */
+
+	data->lstat_count++;
+	return !lstat(path, &st);
 }
 
 static int clear_skip_worktree_from_present_files_sparse(struct index_state *istate)
-- 
gitgitgadget
