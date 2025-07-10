Received: from mail-pf1-f196.google.com (mail-pf1-f196.google.com [209.85.210.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00C13156F4A
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 08:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137326; cv=none; b=BUzbJBAKJA7wkiQEl3PXcqkQcOeQ6mIZh4xPQA6yRX6QvwIwLnAGlbn4iOK9MGeEmscVDQ2F/VdIyS8VA/0pfYyVCz8Lx9ouNCpUL26tTuexmUO4fe5yRD0y8p65vGywBhSbybxeyDRSHD6j6o3lvbb76HF2/hagBqcLZE8x5/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137326; c=relaxed/simple;
	bh=mcRfsUvON005T3V5NydRvBmE3TRYl/owSTUxbj9/7Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=evotUtUVjSpb13rz2UvdpMSv1Xiv/U954nPj0r02pbla0ovMvZEueO8+SUdaVzPUrN4d8hWV5ZITEHmEwvHI/w2nfuWHM/9siKiFE6OCwIqy8UXQnhDB5etCe6a1j9OiVjqoKSd1Z5eEQ7BXQ2PWLbnWyP6V+r6vMq/Pl6ea8pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R1Ap0Obs; arc=none smtp.client-ip=209.85.210.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R1Ap0Obs"
Received: by mail-pf1-f196.google.com with SMTP id d2e1a72fcca58-74ce477af25so474859b3a.3
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 01:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752137323; x=1752742123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n4jGB7Y+TUrz3jCyQyTVzmcwF9TeYtsPVEkCPHI3t1s=;
        b=R1Ap0Obs1QFIbfZC/lAKYXulef8Cts1kTAOEoeeVoYgIoeA6AEQWE9R1+DLxiqN3hT
         HJrSUNH22LB/afVu5WIpknPvo2HMkXNMME/ZwSpCKwVq/b7GvATEBALtuStOqMVWNii+
         2AKBH5sSAUHn6HwW8ekgVy5DvfDktK81m8aBOmIS0sLDZyA9DMOBPnoASsJcaX1XPE5e
         mxmnXETUfxZmdrbwtQ2ElMH3hzP4T4/rjcLGh2gdCCuygVE4lObKWccWjo3vzUcgJd1k
         cgzgcoJwXY5/00T6Da/8QA12uQsm5GP+Q0ySyx42L/YtOH+ufnjUwP/qt+hNys7F/6G5
         wXKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752137323; x=1752742123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n4jGB7Y+TUrz3jCyQyTVzmcwF9TeYtsPVEkCPHI3t1s=;
        b=sh5S+Vv3oRdYwGYos/20yi7I4VSvDUOb9IaLg4+lLP3NEG7ER6beHG72gkkBtu7n+7
         eREYqLWc5xBYzWY/0q9QLYpow7Q0nwcaBaPgbxWGvVnMQDqTxS4vXHgU2fzqJgLsX5j7
         OdBZgci3bRezibKPgiA+0v5hhew/nUjitCj2yAbjy8GDBUbskxa+JC1pELc1KQorzymM
         16EeTQbhACTD6CLlxhpDYYaT12W0z/VvIQXCz7HRnkC6OB86nVgT0UydBSIKJKjUNgd6
         +dNVVLuEYpfZNmbaW5+B6zOGV4ohwOMkUSWFqKJ7M6qUgiH1Z2ZnbDUWV8rwBznYVUwe
         176g==
X-Forwarded-Encrypted: i=1; AJvYcCWrOZT9BrUmJoOZfF5djANzSbPguqox/rBvcu9tROFueRaalaysxk+Tsxw29QpKGos/6mE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJw6DMyxFa7TkbzevG/HGxSURj46DiHT8iOUEVaJ443KWERwS4
	4VbY7aRgmqhcNfPZY4zo9r3ZLYwE+noOlFCq5s7TDDUDyvZFMhB4nJYkvscug/bY
X-Gm-Gg: ASbGncuLkMCiYyE0iNskTdMGuw/5guz+NZfttNM8TieD/eZtArj+8mvFMbkU2/j5mNd
	BYtX54ZNAfsCxlm6tHoWAfCn+I8hNo3gF0SzsBJDrBVrCIg3ovIA/26Ewp93P7jTx9LQGsv0SV/
	JDZXcD3/dmz5g8xeSThT19sWdtQHcuuo8eGAPerWxWMLrHYK6GNwakNP6G8W0RyPIag+UO7KM0y
	qSugSqoJU4BkuHfGj0asw5QGkIsmpMd+sexTft/euGO1mhLPT6Che7L9+54MbdCXcUY1L7ITSTk
	zJe3yQHh2MigN6k50eqZeEE7EbJFA/T+L7rvBkPEYn6LC8r1SAQD6QbKwfEWDAdukLWN
X-Google-Smtp-Source: AGHT+IGlU3jBe0AUA02zhu7CngDYzanlKYBGMUqiCwsxvnDQfxcndz4bDuULokCeyaDCabEgbWSBLw==
X-Received: by 2002:a05:6a00:bd90:b0:748:68dd:ecc8 with SMTP id d2e1a72fcca58-74eb566a8f1mr3486943b3a.22.1752137322784;
        Thu, 10 Jul 2025 01:48:42 -0700 (PDT)
Received: from r760 ([188.253.126.203])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74eb9f22d93sm1535777b3a.89.2025.07.10.01.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 01:48:42 -0700 (PDT)
From: Lidong Yan <yldhome2d2@gmail.com>
X-Google-Original-From: Lidong Yan <502024330056@smail.nju.edu.cn>
To: yldhome2d2@gmail.com
Cc: 502024330056@smail.nju.edu.cn,
	git@vger.kernel.org,
	gitster@pobox.com,
	toon@iotcl.com
Subject: [PATCH v5 0/4] bloom: enable bloom filter optimization for multiple pathspec elements in revision traversal
Date: Thu, 10 Jul 2025 16:48:25 +0800
Message-ID: <20250710084829.2171855-1-502024330056@smail.nju.edu.cn>
X-Mailer: git-send-email 2.50.0.110.g198a7da17c
In-Reply-To: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
References: <20250704111437.2660251-1-502024330056@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The revision traversal limited by pathspec has optimization when
the pathspec has only one element, it does not use any pathspec
magic (other than literal), and there is no wildcard. The absence
of optimization for multiple pathspec elements in revision traversal
cause an issue raised by Kai Koponen at
  https://lore.kernel.org/git/CADYQcGqaMC=4jgbmnF9Q11oC11jfrqyvH8EuiRRHytpMXd4wYA@mail.gmail.com/

While it is much harder to lift the latter two limitations,
supporting a pathspec with multiple elements is relatively easy.
Just make sure we hash each of them separately and ask the bloom
filter about them, and if we see none of them can possibly be
affected by the commit, we can skip without tree comparison.

The difference from v4 is:
  - for the bloom_key_* functions, we now pass struct bloom_key *
    as the first parameter.
  - bloom_keyvec_fill_key() and bloom_keyvec_new() have been merged
    into a single function, so that each key is filled during the
    creation of the bloom_keyvec.

Below is a comparison of the time taken to run git log on Git and
LLVM repositories before and after applying this patch.

Setup commit-graph:
  $ cd ~/src/git && git commit-graph write --split --reachable --changed-paths
  $ cd ~/src/llvm && git commit-graph write --split --reachable --changed-paths

Run git log on Git repository
  $ cd ~/src/git
  $ hash -p /usr/bin/git git # my system git binary is 2.43.0
  $ time git log -100 -- commit.c commit-graph.c >/dev/null
  real	0m0.055s
  user	0m0.040s
  sys	  0m0.015s
  $ hash -p ~/bin/git/bin/git git
  $ time git log -100 -- commit.c commit-graph.c >/dev/null
  real	0m0.039s
  user	0m0.020s
  sys	  0m0.020s

Run git log in LLVM repository
  $ cd ~/src/llvm
  $ hash -p /usr/bin/git git # my system git binary is 2.43.0
  $ time git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h >/dev/null
  real	0m2.365s
  user	0m2.252s
  sys	  0m0.113s
  $ hash -p ~/bin/git/bin/git git
  $ time git log -100 -- llvm/lib/Support/CommandLine.cpp llvm/lib/Support/CommandLine.h >/dev/null
  real	0m0.240s
  user	0m0.158s
  sys	  0m0.064s

Lidong Yan (4):
  bloom: add test helper to return murmur3 hash
  bloom: rename function operates on bloom_key
  bloom: replace struct bloom_key * with struct bloom_keyvec
  bloom: optimize multiple pathspec items in revision traversal

 blame.c               |  2 +-
 bloom.c               | 84 +++++++++++++++++++++++++++++++++---
 bloom.h               | 54 +++++++++++++++++------
 line-log.c            |  5 ++-
 revision.c            | 99 +++++++++++++++++++------------------------
 revision.h            |  6 +--
 t/helper/test-bloom.c |  8 ++--
 t/t4216-log-bloom.sh  | 23 ++++++----
 8 files changed, 187 insertions(+), 94 deletions(-)

Range-diff against v4:
1:  d6883e9d6c = 1:  31c048dcdb bloom: add test helper to return murmur3 hash
2:  f114556c0f ! 2:  d2603c1752 bloom: rename function operates on bloom_key
    @@ blame.c: static void add_bloom_key(struct blame_bloom_data *bd,
      
      	bd->keys[bd->nr] = xmalloc(sizeof(struct bloom_key));
     -	fill_bloom_key(path, strlen(path), bd->keys[bd->nr], bd->settings);
    -+	bloom_key_fill(path, strlen(path), bd->keys[bd->nr], bd->settings);
    ++	bloom_key_fill(bd->keys[bd->nr], path, strlen(path), bd->settings);
      	bd->nr++;
      }
      
    @@ bloom.c: static uint32_t murmur3_seeded_v1(uint32_t seed, const char *data, size
      }
      
     -void fill_bloom_key(const char *data,
    -+void bloom_key_fill(const char *data,
    - 		    size_t len,
    - 		    struct bloom_key *key,
    +-		    size_t len,
    +-		    struct bloom_key *key,
    ++void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
      		    const struct bloom_filter_settings *settings)
    + {
    + 	int i;
     @@ bloom.c: void fill_bloom_key(const char *data,
      		key->hashes[i] = hash0 + i * hash1;
      }
    @@ bloom.c: struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
      		hashmap_for_each_entry(&pathmap, &iter, e, entry) {
      			struct bloom_key key;
     -			fill_bloom_key(e->path, strlen(e->path), &key, settings);
    -+			bloom_key_fill(e->path, strlen(e->path), &key, settings);
    ++			bloom_key_fill(&key, e->path, strlen(e->path), settings);
      			add_key_to_filter(&key, filter, settings);
     -			clear_bloom_key(&key);
     +			bloom_key_clear(&key);
    @@ bloom.h: int load_bloom_filter_from_graph(struct commit_graph *g,
      				 uint32_t graph_pos);
      
     -void fill_bloom_key(const char *data,
    -+void bloom_key_fill(const char *data,
    - 		    size_t len,
    - 		    struct bloom_key *key,
    +-		    size_t len,
    +-		    struct bloom_key *key,
    ++void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
      		    const struct bloom_filter_settings *settings);
     -void clear_bloom_key(struct bloom_key *key);
     +void bloom_key_clear(struct bloom_key *key);
    @@ line-log.c: static int bloom_filter_check(struct rev_info *rev,
      
      	while (!result && range) {
     -		fill_bloom_key(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
    -+		bloom_key_fill(range->path, strlen(range->path), &key, rev->bloom_filter_settings);
    ++		bloom_key_fill(&key, range->path, strlen(range->path),
    ++			       rev->bloom_filter_settings);
      
      		if (bloom_filter_contains(filter, &key, rev->bloom_filter_settings))
      			result = 1;
    @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
      
     -	fill_bloom_key(path, len, &revs->bloom_keys[0],
    -+	bloom_key_fill(path, len, &revs->bloom_keys[0],
    ++	bloom_key_fill(&revs->bloom_keys[0], path, len,
      		       revs->bloom_filter_settings);
      	path_component_nr = 1;
      
    @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      	while (p > path) {
      		if (*p == '/')
     -			fill_bloom_key(path, p - path,
    -+			bloom_key_fill(path, p - path,
    - 				       &revs->bloom_keys[path_component_nr++],
    +-				       &revs->bloom_keys[path_component_nr++],
    ++			bloom_key_fill(&revs->bloom_keys[path_component_nr++],
    ++				       path, p - path,
      				       revs->bloom_filter_settings);
      		p--;
    + 	}
     @@ revision.c: void release_revisions(struct rev_info *revs)
      	oidset_clear(&revs->missing_commits);
      
    @@ t/helper/test-bloom.c: static struct bloom_filter_settings settings = DEFAULT_BL
      		struct bloom_key key;
      
     -		fill_bloom_key(data, strlen(data), &key, &settings);
    -+		bloom_key_fill(data, strlen(data), &key, &settings);
    ++		bloom_key_fill(&key, data, strlen(data), &settings);
      		printf("Hashes:");
      		for (size_t i = 0; i < settings.num_hashes; i++)
      			printf("0x%08x|", key.hashes[i]);
3:  c042907b92 ! 3:  60a3b16bbb bloom: replace struct bloom_key * with struct bloom_keyvec
    @@ Metadata
      ## Commit message ##
         bloom: replace struct bloom_key * with struct bloom_keyvec
     
    -    The revision traversal limited by pathspec has optimization when
    -    the pathspec has only one element. To support optimization for
    -    multiple pathspec items, we need to modify the data structures
    -    in struct rev_info.
    +    Previously, we stored bloom keys in a flat array and marked a commit
    +    as NOT TREESAME if any key reported "definitely not changed".
     
    -    struct rev_info uses bloom_keys and bloom_nr to store the bloom keys
    -    corresponding to a single pathspec item. To allow struct rev_info
    -    to store bloom keys for multiple pathspec items, a new data structure
    -    `struct bloom_keyvec` is introduced. Each `struct bloom_keyvec`
    -    corresponds to a single pathspec item.
    +    To support multiple pathspec items, we now require that for each
    +    pathspec item, there exists a bloom key reporting "definitely not
    +    changed".
     
    -    In `struct rev_info`, replace bloom_keys and bloom_nr with bloom_keyvecs
    -    and bloom_keyvec_nr. This commit still optimize one pathspec item, thus
    -    bloom_keyvec_nr can only be 0 or 1.
    +    This "for every" condition makes a flat array insufficient, so we
    +    introduce a new structure to group keys by a single pathspec item.
    +    `struct bloom_keyvec` is introduced to replace `struct bloom_key *`
    +    and `bloom_key_nr`. And because we want to support multiple pathspec
    +    items, we added a bloom_keyvec * and a bloom_keyvec_nr field to
    +    `struct rev_info` to represent an array of bloom_keyvecs. This commit
    +    still optimize only one pathspec item, thus bloom_keyvec_nr can only
    +    be 0 or 1.
     
         New bloom_keyvec_* functions are added to create and destroy a keyvec.
         bloom_filter_contains_vec() is added to check if all key in keyvec is
    -    contained in a bloom filter. bloom_keyvec_fill_key() is added to
    -    initialize a key in keyvec.
    +    contained in a bloom filter.
     
         Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
     
    @@ bloom.c: void deinit_bloom_filters(void)
      	deep_clear_bloom_filter_slab(&bloom_filters, free_one_bloom_filter);
      }
      
    -+struct bloom_keyvec *bloom_keyvec_new(size_t count)
    ++struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
    ++				      const struct bloom_filter_settings *settings)
     +{
     +	struct bloom_keyvec *vec;
    -+	size_t sz = sizeof(struct bloom_keyvec);
    -+	sz += count * sizeof(struct bloom_key);
    ++	const char *p;
    ++	size_t sz;
    ++	size_t nr = 1;
    ++
    ++	p = path;
    ++	while (*p) {
    ++		/*
    ++		 * At this point, the path is normalized to use Unix-style
    ++		 * path separators. This is required due to how the
    ++		 * changed-path Bloom filters store the paths.
    ++		 */
    ++		if (*p == '/')
    ++			nr++;
    ++		p++;
    ++	}
    ++
    ++	sz = sizeof(struct bloom_keyvec);
    ++	sz += nr * sizeof(struct bloom_key);
     +	vec = (struct bloom_keyvec *)xcalloc(1, sz);
    -+	vec->count = count;
    ++	if (!vec)
    ++		return NULL;
    ++	vec->count = nr;
    ++
    ++	bloom_key_fill(&vec->key[0], path, len, settings);
    ++	nr = 1;
    ++	p = path + len - 1;
    ++	while (p > path) {
    ++		if (*p == '/') {
    ++			bloom_key_fill(&vec->key[nr++], path, p - path, settings);
    ++		}
    ++		p--;
    ++	}
    ++	assert(nr == vec->count);
     +	return vec;
     +}
     +
    @@ bloom.h: struct bloom_key {
      int load_bloom_filter_from_graph(struct commit_graph *g,
      				 struct bloom_filter *filter,
      				 uint32_t graph_pos);
    -@@ bloom.h: void bloom_key_fill(const char *data,
    +@@ bloom.h: void bloom_key_fill(struct bloom_key *key, const char *data, size_t len,
      		    const struct bloom_filter_settings *settings);
      void bloom_key_clear(struct bloom_key *key);
      
    -+struct bloom_keyvec *bloom_keyvec_new(size_t count);
    ++/*
    ++ * bloom_keyvec_fill - Allocate and populate a bloom_keyvec with keys for the
    ++ * given path.
    ++ *
    ++ * This function splits the input path by '/' and generates a bloom key for each
    ++ * prefix, in reverse order of specificity. For example, given the input
    ++ * "a/b/c", it will generate bloom keys for:
    ++ *   - "a/b/c"
    ++ *   - "a/b"
    ++ *   - "a"
    ++ *
    ++ * The resulting keys are stored in a newly allocated bloom_keyvec.
    ++ */
    ++struct bloom_keyvec *bloom_keyvec_new(const char *path, size_t len,
    ++				      const struct bloom_filter_settings *settings);
     +void bloom_keyvec_free(struct bloom_keyvec *vec);
    -+
    -+static inline void bloom_keyvec_fill_key(const char *data, size_t len,
    -+					 struct bloom_keyvec *vec, size_t nr,
    -+					 const struct bloom_filter_settings *settings)
    -+{
    -+	assert(nr < vec->count);
    -+	bloom_key_fill(data, len, &vec->key[nr], settings);
    -+}
     +
      void add_key_to_filter(const struct bloom_key *key,
      		       struct bloom_filter *filter,
    @@ bloom.h: int bloom_filter_contains(const struct bloom_filter *filter,
      			  const struct bloom_key *key,
      			  const struct bloom_filter_settings *settings);
      
    ++/*
    ++ * bloom_filter_contains_vec - Check if all keys in a key vector are in the
    ++ * Bloom filter.
    ++ *
    ++ * Returns 1 if **all** keys in the vector are present in the filter,
    ++ * 0 if **any** key is not present.
    ++ */
     +int bloom_filter_contains_vec(const struct bloom_filter *filter,
     +			      const struct bloom_keyvec *v,
     +			      const struct bloom_filter_settings *settings);
    @@ bloom.h: int bloom_filter_contains(const struct bloom_filter *filter,
     
      ## revision.c ##
     @@ revision.c: static int forbid_bloom_filters(struct pathspec *spec)
    + 	return 0;
    + }
    + 
    ++static void release_revisions_bloom_keyvecs(struct rev_info *revs);
    ++
      static void prepare_to_use_bloom_filter(struct rev_info *revs)
      {
      	struct pathspec_item *pi;
    @@ revision.c: static int forbid_bloom_filters(struct pathspec *spec)
      	char *path_alloc = NULL;
      	const char *path, *p;
      	size_t len;
    +-	int path_component_nr = 1;
    + 
    + 	if (!revs->commits)
    + 		return;
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
    - 		p++;
    - 	}
    + 	if (!revs->pruning.pathspec.nr)
    + 		return;
      
    --	revs->bloom_keys_nr = path_component_nr;
    --	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
     +	revs->bloom_keyvecs_nr = 1;
     +	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
    -+	bloom_keyvec = bloom_keyvec_new(path_component_nr);
    -+	revs->bloom_keyvecs[0] = bloom_keyvec;
    + 	pi = &revs->pruning.pathspec.items[0];
    + 
    + 	/* remove single trailing slash from path, if needed */
    +@@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
    + 		path = pi->match;
      
    --	bloom_key_fill(path, len, &revs->bloom_keys[0],
    + 	len = strlen(path);
    +-	if (!len) {
    +-		revs->bloom_filter_settings = NULL;
    +-		free(path_alloc);
    +-		return;
    +-	}
    +-
    +-	p = path;
    +-	while (*p) {
    +-		/*
    +-		 * At this point, the path is normalized to use Unix-style
    +-		 * path separators. This is required due to how the
    +-		 * changed-path Bloom filters store the paths.
    +-		 */
    +-		if (*p == '/')
    +-			path_component_nr++;
    +-		p++;
    +-	}
    +-
    +-	revs->bloom_keys_nr = path_component_nr;
    +-	ALLOC_ARRAY(revs->bloom_keys, revs->bloom_keys_nr);
    ++	if (!len)
    ++		goto fail;
    + 
    +-	bloom_key_fill(&revs->bloom_keys[0], path, len,
     -		       revs->bloom_filter_settings);
    -+	bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
    -+			      revs->bloom_filter_settings);
    - 	path_component_nr = 1;
    - 
    - 	p = path + len - 1;
    - 	while (p > path) {
    - 		if (*p == '/')
    --			bloom_key_fill(path, p - path,
    --				       &revs->bloom_keys[path_component_nr++],
    +-	path_component_nr = 1;
    +-
    +-	p = path + len - 1;
    +-	while (p > path) {
    +-		if (*p == '/')
    +-			bloom_key_fill(&revs->bloom_keys[path_component_nr++],
    +-				       path, p - path,
     -				       revs->bloom_filter_settings);
    -+			bloom_keyvec_fill_key(path, p - path, bloom_keyvec,
    -+					      path_component_nr++,
    -+					      revs->bloom_filter_settings);
    - 		p--;
    +-		p--;
    +-	}
    ++	revs->bloom_keyvecs[0] =
    ++		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
    + 
    + 	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
    + 		atexit(trace2_bloom_filter_statistics_atexit);
    + 		bloom_filter_atexit_registered = 1;
      	}
      
    -@@ revision.c: static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
    ++	return;
    ++
    ++fail:
    ++	revs->bloom_filter_settings = NULL;
    + 	free(path_alloc);
    ++	release_revisions_bloom_keyvecs(revs);
    + }
    + 
    + static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
      						 struct commit *commit)
      {
      	struct bloom_filter *filter;
    @@ revision.c: static int rev_same_tree_as_empty(struct rev_info *revs, struct comm
      		bloom_ret = check_maybe_different_in_bloom_filter(revs, commit);
      		if (!bloom_ret)
      			return 1;
    +@@ revision.c: static void release_revisions_mailmap(struct string_list *mailmap)
    + 
    + static void release_revisions_topo_walk_info(struct topo_walk_info *info);
    + 
    ++static void release_revisions_bloom_keyvecs(struct rev_info *revs)
    ++{
    ++	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
    ++		bloom_keyvec_free(revs->bloom_keyvecs[nr]);
    ++	FREE_AND_NULL(revs->bloom_keyvecs);
    ++	revs->bloom_keyvecs_nr = 0;
    ++}
    ++
    + static void free_void_commit_list(void *list)
    + {
    + 	free_commit_list(list);
     @@ revision.c: void release_revisions(struct rev_info *revs)
    + 	clear_decoration(&revs->treesame, free);
      	line_log_free(revs);
      	oidset_clear(&revs->missing_commits);
    - 
    +-
     -	for (int i = 0; i < revs->bloom_keys_nr; i++)
     -		bloom_key_clear(&revs->bloom_keys[i]);
     -	FREE_AND_NULL(revs->bloom_keys);
     -	revs->bloom_keys_nr = 0;
    -+	for (size_t i = 0; i < revs->bloom_keyvecs_nr; i++)
    -+		bloom_keyvec_free(revs->bloom_keyvecs[i]);
    -+	FREE_AND_NULL(revs->bloom_keyvecs);
    -+	revs->bloom_keyvecs_nr = 0;
    ++	release_revisions_bloom_keyvecs(revs);
      }
      
      static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
4:  de4d554b55 ! 4:  198a7da17c bloom: optimize multiple pathspec items in revision traversal
    @@ Commit message
     
         To enable optimize multiple pathspec items in revision traversal,
         return 0 if all pathspec item is literal in forbid_bloom_filters().
    -    Add code to initialize and check each pathspec item's bloom_keyvec.
    -
    -    Add new function release_revisions_bloom_keyvecs() to free all bloom
    -    keyvec owned by rev_info.
    +    Add for loops to initialize and check each pathspec item's bloom_keyvec
    +    when optimization is possible.
     
         Add new test cases in t/t4216-log-bloom.sh to ensure
           - consistent results between the optimization for multiple pathspec
    @@ revision.c: static int forbid_bloom_filters(struct pathspec *spec)
      
      	return 0;
      }
    - 
    -+static void release_revisions_bloom_keyvecs(struct rev_info *revs);
    -+
    - static void prepare_to_use_bloom_filter(struct rev_info *revs)
    - {
    - 	struct pathspec_item *pi;
    -@@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
    - 	char *path_alloc = NULL;
    - 	const char *path, *p;
    - 	size_t len;
    --	int path_component_nr = 1;
    -+	int path_component_nr;
    - 
    - 	if (!revs->commits)
    - 		return;
     @@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
      	if (!revs->pruning.pathspec.nr)
      		return;
      
    +-	revs->bloom_keyvecs_nr = 1;
    +-	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
     -	pi = &revs->pruning.pathspec.items[0];
    --
    ++	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
    ++	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
    ++	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
    ++		pi = &revs->pruning.pathspec.items[i];
    + 
     -	/* remove single trailing slash from path, if needed */
     -	if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
     -		path_alloc = xmemdupz(pi->match, pi->len - 1);
     -		path = path_alloc;
     -	} else
     -		path = pi->match;
    --
    --	len = strlen(path);
    --	if (!len) {
    --		revs->bloom_filter_settings = NULL;
    --		free(path_alloc);
    --		return;
    --	}
    --
    --	p = path;
    --	while (*p) {
    --		/*
    --		 * At this point, the path is normalized to use Unix-style
    --		 * path separators. This is required due to how the
    --		 * changed-path Bloom filters store the paths.
    --		 */
    --		if (*p == '/')
    --			path_component_nr++;
    --		p++;
    --	}
    --
    --	revs->bloom_keyvecs_nr = 1;
    --	CALLOC_ARRAY(revs->bloom_keyvecs, 1);
    --	bloom_keyvec = bloom_keyvec_new(path_component_nr);
    --	revs->bloom_keyvecs[0] = bloom_keyvec;
    --
    --	bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
    --			      revs->bloom_filter_settings);
    --	path_component_nr = 1;
    -+	revs->bloom_keyvecs_nr = revs->pruning.pathspec.nr;
    -+	CALLOC_ARRAY(revs->bloom_keyvecs, revs->bloom_keyvecs_nr);
    -+	for (int i = 0; i < revs->pruning.pathspec.nr; i++) {
    -+		pi = &revs->pruning.pathspec.items[i];
    -+		path_component_nr = 1;
    -+
     +		/* remove single trailing slash from path, if needed */
     +		if (pi->len > 0 && pi->match[pi->len - 1] == '/') {
     +			path_alloc = xmemdupz(pi->match, pi->len - 1);
     +			path = path_alloc;
     +		} else
     +			path = pi->match;
    -+
    + 
    +-	len = strlen(path);
    +-	if (!len)
    +-		goto fail;
     +		len = strlen(path);
     +		if (!len)
     +			goto fail;
    -+
    -+		p = path;
    -+		while (*p) {
    -+			/*
    -+			 * At this point, the path is normalized to use
    -+			 * Unix-style path separators. This is required due to
    -+			 * how the changed-path Bloom filters store the paths.
    -+			 */
    -+			if (*p == '/')
    -+				path_component_nr++;
    -+			p++;
    -+		}
      
    --	p = path + len - 1;
    --	while (p > path) {
    --		if (*p == '/')
    --			bloom_keyvec_fill_key(path, p - path, bloom_keyvec,
    --					      path_component_nr++,
    --					      revs->bloom_filter_settings);
    --		p--;
    -+		bloom_keyvec = bloom_keyvec_new(path_component_nr);
    -+		revs->bloom_keyvecs[i] = bloom_keyvec;
    -+
    -+		bloom_keyvec_fill_key(path, len, bloom_keyvec, 0,
    -+				      revs->bloom_filter_settings);
    -+		path_component_nr = 1;
    -+
    -+		p = path + len - 1;
    -+		while (p > path) {
    -+			if (*p == '/')
    -+				bloom_keyvec_fill_key(path, p - path,
    -+						      bloom_keyvec,
    -+						      path_component_nr++,
    -+						      revs->bloom_filter_settings);
    -+			p--;
    -+		}
    +-	revs->bloom_keyvecs[0] =
    +-		bloom_keyvec_new(path, len, revs->bloom_filter_settings);
    ++		revs->bloom_keyvecs[i] =
    ++			bloom_keyvec_new(path, len, revs->bloom_filter_settings);
     +		FREE_AND_NULL(path_alloc);
    - 	}
    ++	}
      
      	if (trace2_is_enabled() && !bloom_filter_atexit_registered) {
    -@@ revision.c: static void prepare_to_use_bloom_filter(struct rev_info *revs)
    - 		bloom_filter_atexit_registered = 1;
    - 	}
    - 
    -+	return;
    -+
    -+fail:
    -+	revs->bloom_filter_settings = NULL;
    - 	free(path_alloc);
    -+	release_revisions_bloom_keyvecs(revs);
    - }
    - 
    - static int check_maybe_different_in_bloom_filter(struct rev_info *revs,
    -@@ revision.c: static void release_revisions_mailmap(struct string_list *mailmap)
    - 
    - static void release_revisions_topo_walk_info(struct topo_walk_info *info);
    - 
    -+static void release_revisions_bloom_keyvecs(struct rev_info *revs)
    -+{
    -+	for (size_t nr = 0; nr < revs->bloom_keyvecs_nr; nr++)
    -+		bloom_keyvec_free(revs->bloom_keyvecs[nr]);
    -+	FREE_AND_NULL(revs->bloom_keyvecs);
    -+	revs->bloom_keyvecs_nr = 0;
    -+}
    -+
    - static void free_void_commit_list(void *list)
    - {
    - 	free_commit_list(list);
    -@@ revision.c: void release_revisions(struct rev_info *revs)
    - 	clear_decoration(&revs->treesame, free);
    - 	line_log_free(revs);
    - 	oidset_clear(&revs->missing_commits);
    --
    --	for (size_t i = 0; i < revs->bloom_keyvecs_nr; i++)
    --		bloom_keyvec_free(revs->bloom_keyvecs[i]);
    --	FREE_AND_NULL(revs->bloom_keyvecs);
    --	revs->bloom_keyvecs_nr = 0;
    -+	release_revisions_bloom_keyvecs(revs);
    - }
    - 
    - static void add_child(struct rev_info *revs, struct commit *parent, struct commit *child)
    + 		atexit(trace2_bloom_filter_statistics_atexit);
     
      ## t/t4216-log-bloom.sh ##
     @@ t/t4216-log-bloom.sh: sane_unset GIT_TRACE2_CONFIG_PARAMS
-- 
2.50.0.107.g33b6ec8c79

