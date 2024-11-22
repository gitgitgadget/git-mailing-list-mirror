Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6E61D90BC
	for <git@vger.kernel.org>; Fri, 22 Nov 2024 10:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732270117; cv=none; b=nnNXJava2cPWlLhBlgY3t+WMAGRXioPJRt0m7AcH+O3DaXF2/QuhdKwTX2RWmEtWQXOfb9AzQ2S7WspoU+seg2ermdJ5sAbX4yP3P9NiF7eC3peG7uAsY++4/z7hLuMpHNNAdQF4alWPUwK10nq47OJleTj6jZ8p9YQX2H+MDEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732270117; c=relaxed/simple;
	bh=kNXy2BW0bF0N3zOgK/2Gd8ITjjvFRqfJRPOIUfFsEI4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArPblr1Ev8Afy0bRk4twcmoQ2cbMTUWtmZtViKC9DLNLbfT1Jcq5JKRRcszwUvHp7APJyZhJNATQZ5rSWQTS9baAEDUKvpN6bG+sG5Csd1WrMfBDbt8qvU7UAvCovafzdJznmut90NhlqI5bhVWr2fOlVjyzpBDXYK3ntbu4+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9RfBkuH; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9RfBkuH"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2fb57f97d75so21001681fa.2
        for <git@vger.kernel.org>; Fri, 22 Nov 2024 02:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1732270113; x=1732874913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pJKzXfnOlO/rgaxkttEDXzcm1YscKLurHLIjIlprMUI=;
        b=S9RfBkuHwuZCMvqRY1WNcfR1siGYwXUbsD0FT7K9OShAoY17mZxAK1A8hVd375mv7M
         AC3IRe1/qYpHY/GJa9/3CGwxR9qgAWdY+Ir5OMUftwUY79Hoa8odzvSKyPr5OeaG4+vc
         Y+SbJyffPphL3Z7VfoPnbPQJ7Blp21j7SPKt4wfe53Tidqhduv8XY0BoH+cla1vF/lbI
         bTjpsglvL9EVdJl8R7khY+3S3Vyy6/4vaWq32SlhViA2tev+oKJsT03b6dyTOKIRrhpn
         SuPcj0eG/L4iLRsKUoDyZBbVdw9jLQw7V7JDpuiowvlKWTGG18THDx1uDgPfwMby8b7u
         QlLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732270113; x=1732874913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pJKzXfnOlO/rgaxkttEDXzcm1YscKLurHLIjIlprMUI=;
        b=Sbzrhm6yJvBuTIYOPP/3oRNz1TtuaKZqqy8b3trExXet88EAjTdg9P7ASBt5Su1FGd
         yAyse39JdTqwE4Ri+tMNj0RIbVNsVYCXnbc1blI/bM8Dszhe9er9qdnIHzvoPFUvpDgR
         oroAjIoJUqg64mASU0W078D3QXubD+tWs6gSMpUveBTIOWpFOezDaTXoiP4TYXbWyDl7
         Vr7sc94yIV5nYbO1FB2eRLCYxCnLZGLhj/wX9BwZBGukFW3b6QhCdptsgh48HAqP3s2i
         B6fpBEYTpB/MoE+nWdfgLBu/yI/aa0MrhGK58pSlOwNwC6Ye74ATXrFEo6rgJBmleTv/
         F5yg==
X-Gm-Message-State: AOJu0Yxc3m4sfMJTDCBe8U0jOq3nhCFKow04Zs8dhNubNz7ohgIPzYfV
	XYd9UrRO/ZfNGUnYSBXyoVqr8xhopeHglNlRZuGmauKCRg2EgfMh
X-Gm-Gg: ASbGncsbA1So5TZroQ9ivveqVbNG1CClQ+zfGS6FijDA2d75LwW/mjMVFX0qF3EqK7Z
	r4THvBmCHttpMopX1PSb1PRlrLLrLduP8/4+j382ynoOr/8IZYDYJ8AUgRx99cnrBI1nU0ZIWXy
	iPkVxjUTWnxt9trYrekkZvtPttFVWKsa/H3UjBchbHOYHGBR2P6WAyQa/Ht1iWgWfJf+mH2K4cY
	ej2M79UbNFqkxMp8ertMP+w2MK6H0ro1+43lUZwOX6B6LaO9W8um4ay9szjaxY=
X-Google-Smtp-Source: AGHT+IEXYCoIvCz82kma76d5qHx+kOfaMkJRVKl4vmNabpUecszLCC5lwXsKTucKDw1+guZfE9KGcQ==
X-Received: by 2002:a2e:be94:0:b0:2fb:4c08:be08 with SMTP id 38308e7fff4ca-2ffa716cf15mr11647981fa.11.1732270112705;
        Fri, 22 Nov 2024 02:08:32 -0800 (PST)
Received: from localhost.localdomain ([217.110.80.4])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5d01d3b0b50sm756849a12.30.2024.11.22.02.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 02:08:32 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net,
	gitster@pobox.com
Subject: [PATCH v8 00/10] packfile: avoid using the 'the_repository' global variable
Date: Fri, 22 Nov 2024 11:08:19 +0100
Message-ID: <cover.1732269840.git.karthik.188@gmail.com>
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

Finally, the next two patches deal with global config values. These values are
localized. The last patch is removal of an unecessary call to `prepare_packed_git()`.
For v5 onwards, I've rebased the series off the master: 8f8d6eee53 (The
seventh batch, 2024-11-01), as a dependency for this series 'jk/dumb-http-finalize'
was merged to master. I've found no conflicts while merging with seen & next. But
since this series does touch multiple files, there could be future conflicts.

Changes in v8:
- Fix typos in comments
- For packfile.c use delta_base_cache_limit from the repository
settings, this avoids loading the config in hot paths.
- Rename `longval` to `ulongval` to better signify the type.

Changes in v7:
- Cleanup stale commit message.
- Add missing space in `if` statement.
- Fix typo s/incase/in case/.

Changes in v6:
- Lazy load repository settings in packfile.c. This ensures that the settings are
available for sure and we do not rely on callees setting it.
- Use `size_t` for `delta_base_cache_limit`.

Changes in v5:
- Move packed_git* settings to repo_settings to ensure we don't keep reparsing the
settings in `use_pack`.

Changes in v4:
- Renamed the repository field within `packed_git` and `multi_pack_index` from
`r` to `repo`, while keeping function parameters to be `r`.
- Fixed bad braces.

Changes in v3:
- Improved commit messages. In the first commit to talk about how packed_git
struct could also be part of the alternates of a repository. In the 7th commit
to talk about the motive behind removing the global variable.
- Changed 'packed_git->repo' to 'packed_git->r' to keep it consistent with the
rest of the code base.
- Replaced 'the_repository' with locally available access to the repository
struct in multiple regions.
- Removed unecessary inclusion of the 'repository.h' header file by forward
declaring the 'repository' struct.
- Replace memcpy with hashcpy.
- Change the logic in the 7th patch to use if else statements.
- Added an extra commit to cleanup `pack-bitmap.c`.

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

Taylor Blau (1):
  packfile.c: remove unnecessary prepare_packed_git() call

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++---
 builtin/gc.c             |   8 ++-
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
 pack.h                   |   2 +
 packfile.c               | 144 ++++++++++++++++++++++-----------------
 packfile.h               |  18 +++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 repo-settings.c          |  18 +++++
 repo-settings.h          |   7 ++
 revision.c               |  13 ++--
 tag.c                    |   2 +-
 36 files changed, 271 insertions(+), 190 deletions(-)

Range-diff against v7:
 1:  6c00e25c86 !  1:  d1fdd6996a packfile: add repository to struct `packed_git`
    @@ object-store-ll.h: struct packed_git {
      	const uint32_t *mtimes_map;
      	size_t mtimes_size;
     +
    -+	/* repo dentoes the repository this packed file belongs to */
    ++	/* repo denotes the repository this packfile belongs to */
     +	struct repository *repo;
     +
      	/* something like ".git/objects/pack/xxxxx.pack" */
 2:  70fc8a79af =  2:  65c09858ce packfile: use `repository` from `packed_git` directly
 3:  167a1f3a11 =  3:  80632934d1 packfile: pass `repository` to static function in the file
 4:  b7cfe78217 =  4:  67d71eab83 packfile: pass down repository to `odb_pack_name`
 5:  5566f5554c =  5:  ee210fa153 packfile: pass down repository to `has_object[_kept]_pack`
 6:  1b26e45a9b =  6:  8db7094f4e packfile: pass down repository to `for_each_packed_object`
 7:  1bdc34f4d8 !  7:  d1b6e8801b config: make `delta_base_cache_limit` a non-global variable
    @@ Commit message
     
         The `delta_base_cache_limit` variable is a global config variable used
         by multiple subsystems. Let's make this non-global, by adding this
    -    variable to the stack of each of the subsystems where it is used.
    +    variable independently to the subsystems where it is used.
     
    -    In `gc.c` we add it to the `gc_config` struct and also the constructor
    -    function. In `index-pack.c` we add it to the `pack_idx_option` struct
    -    and its constructor. Finally, in `packfile.c` we dynamically retrieve
    -    this value from the repository config, since the value is only used once
    -    in the entire subsystem.
    +    First, add the setting to the `repo_settings` struct, this provides
    +    access to the config in places where the repository is available. Use
    +    this in `packfile.c`.
    +
    +    In `index-pack.c` we add it to the `pack_idx_option` struct and its
    +    constructor. While the repository struct is available here, it may not
    +    be set  because `git index-pack` can be used without a repository.
    +
    +    In `gc.c` add it to the `gc_config` struct and also the constructor
    +    function. The gc functions currently do not have direct access to a
    +    repository struct.
     
         These changes are made to remove the usage of `delta_base_cache_limit`
         as a global variable in `packfile.c`. This brings us one step closer to
    @@ pack.h: struct pack_idx_option {
      	 */
      	int anomaly_alloc, anomaly_nr;
      	uint32_t *anomaly;
    -+	unsigned long delta_base_cache_limit;
    ++
    ++	size_t delta_base_cache_limit;
      };
      
      void reset_pack_idx_option(struct pack_idx_option *);
     
      ## packfile.c ##
    -@@
    - #include "commit-graph.h"
    - #include "pack-revindex.h"
    - #include "promisor-remote.h"
    -+#include "config.h"
    -+#include "pack-objects.h"
    - 
    - char *odb_pack_name(struct repository *r, struct strbuf *buf,
    - 		    const unsigned char *hash, const char *ext)
     @@ packfile.c: void clear_delta_base_cache(void)
      }
      
    @@ packfile.c: void clear_delta_base_cache(void)
      	struct delta_base_cache_entry *ent;
      	struct list_head *lru, *tmp;
     @@ packfile.c: void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
    - 	struct unpack_entry_stack_ent *delta_stack = small_delta_stack;
      	int delta_stack_nr = 0, delta_stack_alloc = UNPACK_ENTRY_STACK_PREALLOC;
      	int base_from_cache = 0;
    -+	unsigned long delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT;
    -+
    -+	repo_config_get_ulong(r, "core.deltabasecachelimit", &delta_base_cache_limit);
      
    ++	prepare_repo_settings(p->repo);
    ++
      	write_pack_access_log(p, obj_offset);
      
    + 	/* PHASE 1: drill down to the innermost base object */
     @@ packfile.c: void *unpack_entry(struct repository *r, struct packed_git *p, off_t obj_offset,
      		 * before we are done using it.
      		 */
      		if (!external_base)
     -			add_delta_base_cache(p, base_obj_offset, base, base_size, type);
    -+			add_delta_base_cache(p, base_obj_offset, base,
    -+					     base_size, delta_base_cache_limit,
    ++			add_delta_base_cache(p, base_obj_offset, base, base_size,
    ++					     p->repo->settings.delta_base_cache_limit,
     +					     type);
      
      		free(delta_data);
      		free(external_base);
    +
    + ## repo-settings.c ##
    +@@
    + #include "repo-settings.h"
    + #include "repository.h"
    + #include "midx.h"
    ++#include "pack-objects.h"
    + 
    + static void repo_cfg_bool(struct repository *r, const char *key, int *dest,
    + 			  int def)
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	const char *strval;
    + 	int manyfiles;
    + 	int read_changed_paths;
    ++	unsigned long ulongval;
    + 
    + 	if (!r->gitdir)
    + 		BUG("Cannot add settings for uninitialized repository");
    +@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    + 	 * removed.
    + 	 */
    + 	r->settings.command_requires_full_index = 1;
    ++
    ++	if (!repo_config_get_ulong(r, "core.deltabasecachelimit", &ulongval))
    ++		r->settings.delta_base_cache_limit = ulongval;
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
    ++	size_t delta_base_cache_limit;
    + };
    + #define REPO_SETTINGS_INIT { \
    + 	.index_version = -1, \
    + 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
    + 	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
    + 	.warn_ambiguous_refs = -1, \
    ++	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
    + }
    + 
    + void prepare_repo_settings(struct repository *r);
 8:  7b6baa89ac !  8:  30a52f192f config: make `packed_git_(limit|window_size)` non-global variables
    @@ packfile.h: unsigned long repo_approximate_object_count(struct repository *r);
     
      ## repo-settings.c ##
     @@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    - 	const char *strval;
    - 	int manyfiles;
    - 	int read_changed_paths;
    -+	unsigned long longval;
      
    - 	if (!r->gitdir)
    - 		BUG("Cannot add settings for uninitialized repository");
    -@@ repo-settings.c: void prepare_repo_settings(struct repository *r)
    - 	 * removed.
    - 	 */
    - 	r->settings.command_requires_full_index = 1;
    + 	if (!repo_config_get_ulong(r, "core.deltabasecachelimit", &ulongval))
    + 		r->settings.delta_base_cache_limit = ulongval;
     +
    -+	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &longval)) {
    ++	if (!repo_config_get_ulong(r, "core.packedgitwindowsize", &ulongval)) {
     +		int pgsz_x2 = getpagesize() * 2;
     +
     +		/* This value must be multiple of (pagesize * 2) */
    -+		longval /= pgsz_x2;
    -+		if (longval < 1)
    -+			longval = 1;
    -+		r->settings.packed_git_window_size = longval * pgsz_x2;
    ++		ulongval /= pgsz_x2;
    ++		if (ulongval < 1)
    ++			ulongval = 1;
    ++		r->settings.packed_git_window_size = ulongval * pgsz_x2;
     +	}
     +
    -+	if (!repo_config_get_ulong(r, "core.packedgitlimit", &longval))
    -+		r->settings.packed_git_limit = longval;
    ++	if (!repo_config_get_ulong(r, "core.packedgitlimit", &ulongval))
    ++		r->settings.packed_git_limit = ulongval;
      }
      
      enum log_refs_config repo_settings_get_log_all_ref_updates(struct repository *repo)
     
      ## repo-settings.h ##
     @@ repo-settings.h: struct repo_settings {
    - 
    - 	int core_multi_pack_index;
      	int warn_ambiguous_refs; /* lazily loaded via accessor */
    -+
    + 
    + 	size_t delta_base_cache_limit;
     +	size_t packed_git_window_size;
     +	size_t packed_git_limit;
      };
      #define REPO_SETTINGS_INIT { \
      	.index_version = -1, \
    - 	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
    +@@ repo-settings.h: struct repo_settings {
      	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
      	.warn_ambiguous_refs = -1, \
    + 	.delta_base_cache_limit = DEFAULT_DELTA_BASE_CACHE_LIMIT, \
     +	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
     +	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
      }
 9:  a3667d87ec =  9:  2fe5d2506f midx: add repository to `multi_pack_index` struct
 -:  ---------- > 10:  05989c2e27 packfile.c: remove unnecessary prepare_packed_git() call
-- 
2.47.0

