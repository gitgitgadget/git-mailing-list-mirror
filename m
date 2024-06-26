Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EDE187334
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 14:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719412202; cv=none; b=e8MeyUu+fZcZk/3M1xdXjpfGhRqtt0e9DuclKNvCDVrzEv5iq1pBIfNfYdOdUVZTu7F3xhmJ5ofqUqZi8bi3gdSvkbP0BSPol5syVkTK+elMnRUqIK7Ft1zlzVV0mgUpgoNwEcX8MYEPQm3WbBuB52Ov4zSu5rP9U55IT57CJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719412202; c=relaxed/simple;
	bh=DKdsyken6hSuTZ7OWFxnzzYgmY3pk6kxwlrSYyrHy1w=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=D/lbo5tcaw4XwuDAIlJ83xUQ81y6huUBegi7mtbpowXFXhVlJmH8GWVBWq8Pn2mbjoogqdv2ATVwPB7aiBhVPZqQ8+j4KGFjMiYLI0i8kI6tyMR5madTNMPh2ZcZQOR9DM1pSuoNSu6NnSFzMSJxBcd8POWFxKotY80tuEOAfpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F1+PSoMq; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F1+PSoMq"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-35f2c9e23d3so434151f8f.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 07:30:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719412199; x=1720016999; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KPk9QmR2Hw4pTGQX5+tllWwY8IL4/dZICpZqmT+9aEQ=;
        b=F1+PSoMqA9DernTCl6Ys4y3iQS1Dn9V/yhooRghZK1yWxweAckiq0Rs4WTS+s3cuor
         uCGLpAIZLqcIeodzLE8OH66rfz6G8idQtqkkF7cdsXodzE5DYqWqqFI3Sw0A9CbyqmkU
         77hxZZOhAAQxzTwiWuL+JwaKCNYQBLrXISx8lCq+nAlxjwKj/SpjluNjVMnG6g1WuQuY
         Ki/Iw1q91j5fbyFs60uqpn2MSA5e/OrRLBZrNLW/F+/nEYoNsGCpcT8KsLhUK5Sg/gg7
         EBWHODJJN2b8reDx0YEcvU+OjXLMTPjejuo1BiX+MrmJaaX0Jxh+RBK8GHocqhBtTNC2
         gh/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719412199; x=1720016999;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KPk9QmR2Hw4pTGQX5+tllWwY8IL4/dZICpZqmT+9aEQ=;
        b=c5PPrMzOH4peuX1VW14tq2qrVDnZxl7LA1xtQ9mvm6iXKQk9vZLRTXhtpO+cJfgwEk
         jrGFfk4JDLPuzkjaiiQuY5knoWPkKhiy+NrimrxbyEqiC+yXgZkNbiRT5053GGrqA8gb
         smCdji0+6i1j6lpFjE229BQI+ZPUBrd4ifkLdyXu5hVssxilvx0Q9rCBdA1pLK0POA7I
         qII9JvBwFMVSMCeDz/q8Afqf2eiZy0rg8L6hoh/7/u4Rl9ZW01l7foVW7QnqfKaHuCY0
         2LmQT/5ZBUSnotEUeHx3iC3RUMmhDNk4hoFZNVqxzWWwGoRjUN7sPzKrbAHfG38Mkw/2
         m2Fg==
X-Gm-Message-State: AOJu0YziWjXCsmsEvzNkfuSZipb+gybpPAjYY/Yco0FWd5QTvsFZDBOr
	cTO1NUrc4rDjahw42cUob1YIZVEUhHGqvFTv83pczhPXLRdwNu5OAfNDHg==
X-Google-Smtp-Source: AGHT+IHHzPVG5WD39QmIKJ7oQTKlpckBsrQLeoFjNei/stgy3YzHykjBQnZu//ILbpCjHXmhhs5thA==
X-Received: by 2002:a05:6000:542:b0:362:d0f7:1e2d with SMTP id ffacd0b85a97d-366e32f7094mr9638463f8f.22.1719412198385;
        Wed, 26 Jun 2024 07:29:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-366383f68acsm16078101f8f.2.2024.06.26.07.29.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jun 2024 07:29:57 -0700 (PDT)
Message-Id: <0cb344ac14fa942f781221663e2324fd2225fb5f.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
	<pull.1754.v2.git.1719412192.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Jun 2024 14:29:51 +0000
Subject: [PATCH v2 5/5] sparse-index: improve lstat caching of sparse paths
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
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
sparse-checkout. The initial implementation would lstat() every single
SKIP_WORKTREE path to see if it existed; if it ran across a sparse
directory that existed (when a sparse index was in use), then it would
expand the index and then check every SKIP_WORKTREE path.

Since these lstat() calls were very expensive, this was improved in
d79d299352 (Accelerate clear_skip_worktree_from_present_files() by
caching, 2022-01-14) by caching directories that do not exist so it
could avoid lstat()ing any files under such directories. However, there
are some inefficiencies in that caching mechanism.

The caching mechanism stored only the parent directory as not existing,
even if a higher parent directory also does not exist. This means that
wasted lstat() calls would occur when the paths passed to path_found()
change immediate parent directories but within the same parent directory
that does not exist.

To create an example repository that demonstrates this problem, it helps
to have a directory outside of the sparse-checkout that contains many
deep paths. In particular, the first paths (in lexicographic order)
underneath the sparse directory should have deep directory structures,
maximizing the difference between the old caching algorithm that looks
to a single parent and the new caching algorithm that looks to the
top-most missing directory.

The performance test script p2000-sparse-operations.sh takes the sample
repository and copies its HEAD to several copies nested in directories
of the form f<i>/f<j>/f<k> where i, j, and k are numbers from 1 to 4.
The sparse-checkout cone is then selected as "f2/f4/". Creating "f1/f1/"
will trigger the behavior and also lead to some interesting cases for
the caching algorithm since "f1/f1/" exists but "f1/f2/" and "f3/" do
not.

This is difficult to notice when running performance tests using the Git
repository (or a blow-up of the Git repository, as in
p2000-sparse-operations.sh) because Git has a very shallow directory
structure.

This change reorganizes the caching algorithm to focus on storing the
highest level leading directory that does not exist; specifically this
means that that directory's parent _does_ exist. By doing a little extra
work on a path passed to path_found(), we can short-circuit all of the
paths passed to path_found() afterwards that match a prefix with that
non-existing directory. When in a repository where the first sparse file
is likely to have a much deeper path than the first non-existing
directory, this can realize significant gains.

The details of this algorithm require careful attention, so the new
implementation of path_found() has detailed comments, including the use
of a new max_common_dir_prefix() method that may be of independent
interest.

It's worth noting that this is not universally positive, since we are
doing extra lstat() calls to establish the exact path to cache. In the
blow-up of the Git repository, we can see that the lstat count
_increases_ from 28 to 31. However, these numbers were already
artificially low.

Contributor Elijah Newren created a publicly-available test repository
that demonstrates the difference in these caching algorithms in the most
extreme way. To test, follow these steps:

  git clone --sparse https://github.com/newren/gvfs-like-git-bomb
  cd gvfs-like-git-bomb
  ./runme.sh                   # NOTE: check scripts before running!

At this point, assuming you do not have index.sparse=true set globally,
the index has one million paths with the SKIP_WORKTREE bit and they will
all be sent to path_found() in the sparse loop. You can measure this by
running 'git status' with GIT_TRACE2_PERF=1:

    Sparse files in the index: 1,000,000
  sparse_lstat_count (before):   200,000
   sparse_lstat_count (after):         2

And here are the performance numbers:

  Benchmark 1: old
    Time (mean ± σ):     397.5 ms ±   4.1 ms
    Range (min … max):   391.2 ms … 404.8 ms    10 runs

  Benchmark 2: new
    Time (mean ± σ):     252.7 ms ±   3.1 ms
    Range (min … max):   249.4 ms … 259.5 ms    11 runs

  Summary
    'new' ran
      1.57 ± 0.02 times faster than 'old'

By modifying this example further, we can demonstrate a more realistic
example and include the sparse index expansion. Continue by creating
this directory, confusing both caching algorithms somewhat:

  mkdir -p bomb/d/e/f/a/a

Then re-run the 'git status' tests to see these statistics:

    Sparse files in the index: 1,000,000
  sparse_lstat_count (before):   724,010
   sparse_lstat_count (after):       106

  Benchmark 1: old
    Time (mean ± σ):     753.0 ms ±   3.5 ms
    Range (min … max):   749.7 ms … 760.9 ms    10 runs

  Benchmark 2: new
    Time (mean ± σ):     201.4 ms ±   3.2 ms
    Range (min … max):   196.0 ms … 207.9 ms    14 runs

  Summary
    'new' ran
      3.74 ± 0.06 times faster than 'old'

Note that if this repository had a sparse index enabled, the additional
cost of expanding the sparse index affects the total time of these
commands by over four seconds, significantly diminishing the benefit of
the caching algorithm. Having existing paths outside of the
sparse-checkout is a known performance issue for the sparse index and is
a known trade-off for the performance benefits given when no such paths
exist.

Using an internal monorepo with over two million paths at HEAD and a
typical sparse-checkout cone such that the sparse index contains
~190,000 entries (including over two thousand sparse trees), I was able
to measure these lstat counts when one sparse directory actually exists
on disk:

  Sparse files in expanded index: 1,841,997
       full_lstat_count (before): 1,188,161
       full_lstat_count  (after):     4,404

This resulted in this absolute time change, on a warm disk:

      Time in full loop (before): 13.481 s
      Time in full loop  (after):  0.081 s

(These times were calculated on a Windows machine, where lstat() is
slower than a similar Linux machine.)

Helped-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 sparse-index.c | 114 ++++++++++++++++++++++++++++++++++++++-----------
 1 file changed, 90 insertions(+), 24 deletions(-)

diff --git a/sparse-index.c b/sparse-index.c
index 8577fa726b8..7e433250248 100644
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
@@ -455,49 +462,108 @@ static void clear_path_found_data(struct path_found_data *data)
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
+	 * parent of 'path' exists, then we will act as though 'path'
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
+		const char *rest = path + data->dir.len;
+		const char *next_slash = strchr(rest, '/');
 
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
+			strbuf_addstr(&data->dir, rest);
+			strbuf_addch(&data->dir, '/');
+			break;
+		}
 
+		/*
+		 * Now that we have a slash, let's grow 'data->dir' to include
+		 * this slash, then test if we should stop.
+		 */
+		strbuf_add(&data->dir, rest, next_slash - rest + 1);
+
+		/* If the parent dir doesn't exist, then stop here. */
+		data->lstat_count++;
+		if (lstat(data->dir.buf, &st))
+			return 0;
+	}
+
+	/*
+	 * At this point, 'data->dir' is equal to 'path' plus a slash character,
+	 * and the parent directory of 'path' definitely exists. Moreover, we
+	 * know that 'path' doesn't exist, or we would have returned 1 earlier.
+	 */
 	return 0;
 }
 
-- 
gitgitgadget
