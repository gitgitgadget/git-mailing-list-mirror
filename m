Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CF6123A6
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 11:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730720514; cv=none; b=T59bXXR4yZNP5qKycOVPsx/U1bsCmT861ydJZS2Bl2DDsA0aCgp8fX9xS/GOuyApgTdMzq6Jfg2d7ZLYMGhXONFX5YhTwpfK48jaJatH5rHBdVTNXdLAj23YHrQl0QERkCHxJ7KNWQKrKpX4CX6aEtXInCLFTaB/x36zFD8kRrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730720514; c=relaxed/simple;
	bh=Svit4jHniUbk4oKBi38oyrdKDvmANFCSjFN9joFZpnw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHXHNIwbwzdEZtdEL7VK9QlkVMkGSxgQiLZmLg2Q+PmG9j2FboaAPK5wvn4yvJDtkIf0v5UwVFDUhrhXrRYee4o2/go5l3Tm3JOuEdWNjN0zwID7BoJ2ooWQFiz0fNODG8Te62QItNVYUl6Gptx5gqXLUlgXaLkYU+pJTOaTE7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzdkMzqR; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzdkMzqR"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5c957d8bce2so2036768a12.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 03:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730720511; x=1731325311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLDz8QPCqzO4jUjWxj5vRR/em1j+G1vKmjw5wbiSUkE=;
        b=lzdkMzqR+EcQQ7P/Kma9ZlUSpAwKieVK4QvEXe6OUt2Ef/YrJFOihNbla/ZPNMtfWf
         0MpJ1FSXDbmVPODcIFqg+m/RyeSoqewXJuKRcohydt4BppKXOM83KChlWZKJa6rHK42J
         QMUGJ3VIeZxUCgn0pZ8mJjFMiS4MQ/9sP/WvqF7dItogcaoenTH9lenZsCqLzHKtpg3y
         QF7ZPu4eMlbTEACDj6tXYRwr34r8fcGoohtsNLXZEfKdYRpXUrRTYkVOIXNKmYEXxdeC
         TsctsLJ7L7rkhVgHbSHZ1c69/DPk5g7Wdy1rUsN9aBxWfIvySsfw8yp6E+Qq20Mo8e0b
         vfYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730720511; x=1731325311;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLDz8QPCqzO4jUjWxj5vRR/em1j+G1vKmjw5wbiSUkE=;
        b=DkYxNpVSuTGgnjuxUNbWkh5x7V1f5d6aZwF2SbEzxynoo2qgJndeAdfs5lQEYzYYgD
         lwmnW4eo6YS1l4Q+QU8m8A4lGTA0vbOU82KnPlfsbmBoDDY/g4yTi0j24bWhA7BAHz8E
         C3JplKrKUF1RPM2dtq4RkI2K4kkyzBCL6UXHU9VBHnk7IeEuMy8KwH4WJLwhO5mzaQsL
         avBuxFF7NEimW0P/SBw28Jk15gCqgpNIavo3TvmydMgWwhd7VAHkq4E8LxX1ebgHw7h8
         1MqpdM2+8gne/lq+WHj4jW+mR+JBeFaWPP/ZiPLBzEbhL3M3idHevpRP5jZ98qFj+1Zs
         EfoQ==
X-Gm-Message-State: AOJu0YxQLl2RrBXgF4Vt8cMZNpeMjZf8SKG0WNWs1SrlcsNmNasfghwN
	6Xs8sT9hzPP3hdV+RLc3SdZvua9uVVez/SOMNCKZp1wKXSKYy2C+IcxC/1nv
X-Google-Smtp-Source: AGHT+IEkxuGhIhVHCvw1w77x7xeJ81KBhtWrtvXCr8K+kX4xj+1xwhp8DIu7+EomDP3GjjrMPTUq4w==
X-Received: by 2002:a05:6402:22d1:b0:5c9:4631:c47e with SMTP id 4fb4d7f45d1cf-5ceb9264360mr10932989a12.13.1730720510389;
        Mon, 04 Nov 2024 03:41:50 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ceac7e97f2sm4157219a12.87.2024.11.04.03.41.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 03:41:49 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v5 0/9] packfile: avoid using the 'the_repository' global variable
Date: Mon,  4 Nov 2024 12:41:38 +0100
Message-ID: <cover.1730714298.git.karthik.188@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <cover.1729504640.git.karthik.188@gmail.com>
References: <cover.1729504640.git.karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The `packfile.c` file uses the global variable 'the_repository' extensively
throughout the code. Let's remove all usecases of this, by modifying the
required functions to accept a 'struct repository' instead. This is to clean up
usage of global state.

The first 3 patches are mostly internal to `packfile.c`, we add the repository
field to the `packed_git` struct and this is used to clear up some useages of
the global variables.

The next 3 patches are more disruptive, they modify the function definition of
`odb_pack_name`, `has_object[_kept]_pack` and `for_each_packed_object` to receive
a repository, helping remove other usages of 'the_repository' variable.

Finally, the last two patches deal with global config values. These values are
localized.

For v5, I've rebased the series off the new master: 8f8d6eee53 (The seventh
batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize' was
merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

Karthik Nayak (9):
  packfile: add repository to struct `packed_git`
  packfile: use `repository` from `packed_git` directly
  packfile: pass `repository` to static function in the file
  packfile: pass down repository to `odb_pack_name`
  packfile: pass down repository to `has_object[_kept]_pack`
  packfile: pass down repository to `for_each_packed_object`
  config: make `delta_base_cache_limit` a non-global variable
  config: make `packed_git_(limit|window_size)` non-global variables
  midx: add repository to `multi_pack_index` struct

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++---
 builtin/gc.c             |   5 +-
 builtin/index-pack.c     |  20 ++++--
 builtin/pack-objects.c   |  11 +--
 builtin/pack-redundant.c |   2 +-
 builtin/repack.c         |   2 +-
 builtin/rev-list.c       |   2 +-
 commit-graph.c           |   4 +-
 config.c                 |  22 ------
 connected.c              |   3 +-
 diff.c                   |   3 +-
 environment.c            |   3 -
 environment.h            |   1 -
 fsck.c                   |   2 +-
 http.c                   |   4 +-
 list-objects.c           |   7 +-
 midx-write.c             |   2 +-
 midx.c                   |   3 +-
 midx.h                   |   3 +
 object-store-ll.h        |   9 ++-
 pack-bitmap.c            |  90 ++++++++++++++----------
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   1 +
 packfile.c               | 144 ++++++++++++++++++++++-----------------
 packfile.h               |  18 +++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 repo-settings.c          |  14 ++++
 repo-settings.h          |   5 ++
 revision.c               |  13 ++--
 tag.c                    |   2 +-
 36 files changed, 261 insertions(+), 190 deletions(-)

Range-diff against v4:
 1:  b3d518e998 =  1:  6c00e25c86 packfile: add repository to struct `packed_git`
 2:  bb9d9aa744 =  2:  70fc8a79af packfile: use `repository` from `packed_git` directly
 3:  d5df50fa36 =  3:  167a1f3a11 packfile: pass `repository` to static function in the file
 4:  0107801c3b =  4:  b7cfe78217 packfile: pass down repository to `odb_pack_name`
 5:  2d7608a367 =  5:  5566f5554c packfile: pass down repository to `has_object[_kept]_pack`
 6:  2c84026d02 =  6:  1b26e45a9b packfile: pass down repository to `for_each_packed_object`
 7:  84b89c8a0e !  7:  7654bf5e7e config: make `delta_base_cache_limit` a non-global variable
    @@ Commit message
         this value from the repository config, since the value is only used once
         in the entire subsystem.
     
    +    The type of the value is changed from `size_t` to an `unsigned long`
    +    since the default value is small enough to fit inside the latter on all
    +    platforms.
    +
         These changes are made to remove the usage of `delta_base_cache_limit`
         as a global variable in `packfile.c`. This brings us one step closer to
         removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
 8:  5bbdc7124d !  8:  2730aacd8e config: make `packed_git_(limit|window_size)` non-global variables
    @@ packfile.c
      
      #include "git-compat-util.h"
      #include "environment.h"
    -@@
    - #include "config.h"
    - #include "pack-objects.h"
    - 
    -+struct packfile_config {
    -+	unsigned long packed_git_window_size;
    -+	unsigned long packed_git_limit;
    -+};
    -+
    -+#define PACKFILE_CONFIG_INIT \
    -+{ \
    -+	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
    -+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
    -+}
    -+
    - char *odb_pack_name(struct repository *r, struct strbuf *buf,
    - 		    const unsigned char *hash, const char *ext)
    - {
     @@ packfile.c: static size_t pack_mapped;
      #define SZ_FMT PRIuMAX
      static inline uintmax_t sz_fmt(size_t s) { return s; }
      
     -void pack_report(void)
    -+static int packfile_config(const char *var, const char *value,
    -+			   const struct config_context *ctx, void *cb)
    -+{
    -+	struct packfile_config *config = cb;
    -+
    -+	if (!strcmp(var, "core.packedgitwindowsize")) {
    -+		int pgsz_x2 = getpagesize() * 2;
    -+		config->packed_git_window_size = git_config_ulong(var, value, ctx->kvi);
    -+
    -+		/* This value must be multiple of (pagesize * 2) */
    -+		config->packed_git_window_size /= pgsz_x2;
    -+		if (config->packed_git_window_size < 1)
    -+			config->packed_git_window_size = 1;
    -+		config->packed_git_window_size *= pgsz_x2;
    -+		return 0;
    -+	} else if (!strcmp(var, "core.packedgitlimit")) {
    -+		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
    -+		return 0;
    -+	} else {
    -+		return git_default_config(var, value, ctx, cb);
    -+	}
    -+}
    -+
     +void pack_report(struct repository *repo)
      {
    -+	struct packfile_config config = PACKFILE_CONFIG_INIT;
    -+	repo_config(repo, packfile_config, &config);
    -+
      	fprintf(stderr,
      		"pack_report: getpagesize()            = %10" SZ_FMT "\n"
      		"pack_report: core.packedGitWindowSize = %10" SZ_FMT "\n"
    @@ packfile.c: static size_t pack_mapped;
      		sz_fmt(getpagesize()),
     -		sz_fmt(packed_git_window_size),
     -		sz_fmt(packed_git_limit));
    -+		sz_fmt(config.packed_git_window_size),
    -+		sz_fmt(config.packed_git_limit));
    ++		sz_fmt(repo->settings.packed_git_window_size),
    ++		sz_fmt(repo->settings.packed_git_limit));
      	fprintf(stderr,
      		"pack_report: pack_used_ctr            = %10u\n"
      		"pack_report: pack_mmap_calls          = %10u\n"
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      		}
      		if (!win) {
     -			size_t window_align = packed_git_window_size / 2;
    -+			struct packfile_config config = PACKFILE_CONFIG_INIT;
     +			size_t window_align;
      			off_t len;
    - 
    -+			repo_config(p->repo, packfile_config, &config);
    -+			window_align = config.packed_git_window_size / 2;
    ++			struct repo_settings *settings = &p->repo->settings;
     +
    ++			window_align = settings->packed_git_window_size / 2;
    + 
      			if (p->pack_fd == -1 && open_packed_git(p))
      				die("packfile %s cannot be accessed", p->pack_name);
    - 
    +@@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      			CALLOC_ARRAY(win, 1);
      			win->offset = (offset / window_align) * window_align;
      			len = p->pack_size - win->offset;
     -			if (len > packed_git_window_size)
     -				len = packed_git_window_size;
    -+			if (len > config.packed_git_window_size)
    -+				len = config.packed_git_window_size;
    ++			if (len > settings->packed_git_window_size)
    ++				len = settings->packed_git_window_size;
      			win->len = (size_t)len;
      			pack_mapped += win->len;
     -			while (packed_git_limit < pack_mapped
     +
    -+			while (config.packed_git_limit < pack_mapped
    ++			while (settings->packed_git_limit < pack_mapped
      				&& unuse_one_window(p))
      				; /* nothing */
      			win->base = xmmap_gently(NULL, win->len,
    @@ packfile.h: unsigned long repo_approximate_object_count(struct repository *r);
      
      /*
       * mmap the index file for the specified packfile (if it is not
    +
    + ## repo-settings.c ##
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	const char *strval;
    + 	int manyfiles;
    + 	int read_changed_paths;
    ++	unsigned long longval;
    + 
    + 	if (!r->gitdir)
    + 		BUG("Cannot add settings for uninitialized repository");
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	 * removed.
    + 	 */
    + 	r->settings.command_requires_full_index = 1;
    ++
    ++	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &longval)) {
    ++		int pgsz_x2 = getpagesize() * 2;
    ++
    ++		/* This value must be multiple of (pagesize * 2) */
    ++		longval /= pgsz_x2;
    ++		if (longval < 1)
    ++			longval = 1;
    ++		r->settings.packed_git_window_size = longval * pgsz_x2;
    ++	}
    ++
    ++	if (!repo_config_get_ulong(r, "core.packedgitlimit", &longval))
    ++		r->settings.packed_git_limit = longval;
    + }
    + 
    + enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
    +
    + ## repo-settings.h ##
    +@@ repo-settings.h: struct repo_settings {
    + 
    + 	int core_multi_pack_index;
    + 	int warn_ambiguous_refs; /* lazily loaded via accessor */
    ++
    ++	size_t packed_git_window_size;
    ++	size_t packed_git_limit;
    + };
    + #define REPO_SETTINGS_INIT { \
    + 	.index_version = -1, \
    + 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
    + 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
    + 	.warn_ambiguous_refs = -1, \
    ++	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
    ++	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
    + }
    + 
    + void prepare_repo_settings(struct repository *r);
 9:  bb15a0be56 =  9:  8e33d40077 midx: add repository to `multi_pack_index` struct
-- 
2.47.0

