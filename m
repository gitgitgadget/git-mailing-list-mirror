Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADDF1F4736
	for <git@vger.kernel.org>; Wed, 30 Oct 2024 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730298765; cv=none; b=Fru6mv5ZnzK8AvMZBUckx1NA+mMXQrGdvc3KXcdfpNvzVF8mr92j/UWx9oMZWyAAMtA1PEkOwilXpV/uHkEp52S54ax//L4o3/rSn2NbTUWg8215T0ybkLNUV6PfgTxwx4Xh6+BYey//T55xsehAd37pQHtNrzJvXIIlbN+pdqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730298765; c=relaxed/simple;
	bh=8aM7wKgaJvvEY1fidDwSspRrU7r+kF3WElTVOmCS6TA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t3KUHlgOv4ryVm4ppbsCBxDdISEz2ZAc/fMqjobaPw3Aib9VPYGv1QXLpL9DCmh0Yf+sYNLON+yu3FVpiF5AG8nqhgm0THEXpyFf14vHgWcO2vVdw7dfIHNAD+p++TTOkl5U8/FTOSyUmOE+mldnl9IY9Y7OMiWQi4UlvMxcVYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GkqNQ6a0; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GkqNQ6a0"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-a9932aa108cso1016911466b.2
        for <git@vger.kernel.org>; Wed, 30 Oct 2024 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730298758; x=1730903558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=czRfkowfUTmPf01Fa+H7NyZ0j8/eAesUJBNy6PWpDf0=;
        b=GkqNQ6a0UgBEXp6zeGnXqLIp/p5E9ruyAngZ24v3pN908fXjrRRGLxBwOjfoZZ+Z8d
         xdYFZvd9n+YtVScaRQJAdeI4rTfA0hWI6hpRQb8PLvEDNE6ZXRWGDznyCrlQ0VHsjEp4
         eUxyl96TnA2UYdsbkNFFBbKqhiAxEN/XiMkF7l4DmqvdayjFhrLKovkAGxyDn4m4fXpl
         7Cb1/iu/XS2cdp7ySPCSkgMEDfyIYDIKA7mGP3Vcn0aB+NavUQeU4KuSAA3egYS0/xgi
         /xoGrEQ/h4sy+HfKSz5Jh7aMuX46OpDOpjPy6lCVWAmDFG77bl7E8zDzXur2V+/yRSh6
         3D9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730298758; x=1730903558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=czRfkowfUTmPf01Fa+H7NyZ0j8/eAesUJBNy6PWpDf0=;
        b=srpNPotM2fa48d3Ek9a2KOctipyXCZatDZwfJKk+B/WQQc8ibvmphvf8gEML3JEgjv
         PelbxNirPaJJH29Crz72/hJn7M5ZOAoFk0ruFFQvsCb1yW37noZlJUF7c1zY3SAooo+V
         r5ivgvNMaaWwCQn67VWk8GF9JTIJH/M4YWSZiHXtjK3YhF+5FxJ6tLlhU+z+t8dxpd4q
         3P5Se6uQtezMhex/loPSDlI20L9ELMlV/uhMIabRkRIuagH9HwAwQckoDwsl3F5pxKCG
         e92OBQ+2rDKtcKgAdo7efGQl/JdL3f9iuf9ZRgkBe7swkoVdKUDp7V8LGpXfln7V56Pg
         vxTA==
X-Gm-Message-State: AOJu0YwMzSNJSmSWLv1lyqsouFVxyxTDjaLXx659UAYm+1Vv0A2Z6vNl
	ttAJLk/fc2NO4PO4kIrNJna8/JPWnDzJelk0vyphi/YjqcLxWq8U
X-Google-Smtp-Source: AGHT+IGuPA3wUUvYx4tNsSX5ueMCwwmIdC5H+qR7O9FlQNB0POJGkbV8/BI9WPmMm3ESn2Zrdblqlw==
X-Received: by 2002:a17:907:3f0a:b0:a9a:ca1:5e09 with SMTP id a640c23a62f3a-a9de5f23b50mr1373274766b.29.1730298757826;
        Wed, 30 Oct 2024 07:32:37 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9b1dfbc7d4sm576821066b.32.2024.10.30.07.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Oct 2024 07:32:37 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v3 0/9]  packfile: avoid using the 'the_repository' global variable
Date: Wed, 30 Oct 2024 15:32:25 +0100
Message-ID: <cover.1730297934.git.karthik.188@gmail.com>
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

This series is based off on master: 6a11438f43 (The fifth batch, 2024-10-25),
with 'jk/dumb-http-finalize' merged in. I found no issues merging this with seen,
but since these patches cover a lot of files, there might be some conflicts.

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

 builtin/cat-file.c       |   7 +-
 builtin/count-objects.c  |   2 +-
 builtin/fast-import.c    |  15 ++--
 builtin/fsck.c           |  20 +++--
 builtin/gc.c             |   5 +-
 builtin/index-pack.c     |  20 +++--
 builtin/pack-objects.c   |  11 ++-
 builtin/pack-redundant.c |   2 +-
 builtin/repack.c         |   2 +-
 builtin/rev-list.c       |   2 +-
 commit-graph.c           |   4 +-
 config.c                 |  22 -----
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
 object-store-ll.h        |   9 +-
 pack-bitmap.c            |  97 +++++++++++++--------
 pack-objects.h           |   3 +-
 pack-write.c             |   1 +
 pack.h                   |   1 +
 packfile.c               | 182 ++++++++++++++++++++++++++-------------
 packfile.h               |  18 ++--
 promisor-remote.c        |   2 +-
 prune-packed.c           |   2 +-
 reachable.c              |   4 +-
 revision.c               |  13 +--
 tag.c                    |   2 +-
 34 files changed, 285 insertions(+), 192 deletions(-)

Range-diff against v2:
 1:  26d2461cc3 !  1:  5afb9af0af packfile: add repository to struct `packed_git`
    @@ Commit message
         on the global `the_repository` object in `packfile.c` by simply using
         repository information now readily available in the struct.
     
    +    We do need to consider that a pack file could be part of the alternates
    +    of a repository, but considering that we only have one repository struct
    +    and also that we currently anyways use 'the_repository'. We should be
    +    OK with this change.
    +
         We also modify `alloc_packed_git` to ensure that the repository is added
         to newly created `packed_git` structs. This requires modifying the
         function and all its callee to pass the repository object down the
         levels.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fast-import.c ##
    @@ builtin/fast-import.c: static void start_packfile(void)
      
      	p->pack_fd = pack_fd;
      	p->do_not_close = 1;
    -+	p->repo = the_repository;
    ++	p->r = the_repository;
      	pack_file = hashfd(pack_fd, p->pack_name);
      
      	pack_data = p;
    @@ builtin/fast-import.c: static void end_packfile(void)
      
      		/* Register the packfile with core git's machinery. */
     -		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
    -+		new_p = add_packed_git(the_repository, idx_name, strlen(idx_name), 1);
    ++		new_p = add_packed_git(pack_data->r, idx_name, strlen(idx_name), 1);
      		if (!new_p)
      			die("core git rejected index %s", idx_name);
      		all_packs[pack_id] = new_p;
    @@ midx.c: int prepare_midx_pack(struct repository *r, struct multi_pack_index *m,
     
      ## object-store-ll.h ##
     @@
    - #include "hashmap.h"
    - #include "object.h"
    - #include "list.h"
    -+#include "repository.h"
    - #include "thread-utils.h"
    - #include "oidset.h"
    + struct oidmap;
    + struct oidtree;
    + struct strbuf;
    ++struct repository;
      
    + struct object_directory {
    + 	struct object_directory *next;
     @@ object-store-ll.h: struct packed_git {
      	 */
      	const uint32_t *mtimes_map;
      	size_t mtimes_size;
     +
     +	/* repo dentoes the repository this packed file belongs to */
    -+	struct repository *repo;
    ++	struct repository *r;
     +
      	/* something like ".git/objects/pack/xxxxx.pack" */
      	char pack_name[FLEX_ARRAY]; /* more */
    @@ packfile.c: uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
      }
      
     -static struct packed_git *alloc_packed_git(int extra)
    -+static struct packed_git *alloc_packed_git(struct repository *repo, int extra)
    ++static struct packed_git *alloc_packed_git(struct repository *r, int extra)
      {
      	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
      	memset(p, 0, sizeof(*p));
      	p->pack_fd = -1;
    -+	p->repo = repo;
    ++	p->r = r;
      	return p;
      }
      
    @@ packfile.c: static char *pack_path_from_idx(const char *idx_path)
      }
      
     -struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path)
    -+struct packed_git *parse_pack_index(struct repository *repo,
    -+				    unsigned char *sha1, const char *idx_path)
    ++struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
    ++				    const char *idx_path)
      {
      	char *path = pack_path_from_idx(idx_path);
      	size_t alloc = st_add(strlen(path), 1);
     -	struct packed_git *p = alloc_packed_git(alloc);
    -+	struct packed_git *p = alloc_packed_git(repo, alloc);
    ++	struct packed_git *p = alloc_packed_git(r, alloc);
      
      	memcpy(p->pack_name, path, alloc); /* includes NUL */
      	free(path);
    @@ packfile.c: void unuse_pack(struct pack_window **w_cursor)
      }
      
     -struct packed_git *add_packed_git(const char *path, size_t path_len, int local)
    -+struct packed_git *add_packed_git(struct repository *repo, const char *path,
    ++struct packed_git *add_packed_git(struct repository *r, const char *path,
     +				  size_t path_len, int local)
      {
      	struct stat st;
    @@ packfile.c: struct packed_git *add_packed_git(const char *path, size_t path_len,
      	 */
      	alloc = st_add3(path_len, strlen(".promisor"), 1);
     -	p = alloc_packed_git(alloc);
    -+	p = alloc_packed_git(repo, alloc);
    ++	p = alloc_packed_git(r, alloc);
      	memcpy(p->pack_name, path, path_len);
      
      	xsnprintf(p->pack_name + path_len, alloc - path_len, ".keep");
    @@ packfile.h: const char *pack_basename(struct packed_git *p);
       * packs. You probably want add_packed_git() instead.
       */
     -struct packed_git *parse_pack_index(unsigned char *sha1, const char *idx_path);
    -+struct packed_git *parse_pack_index(struct repository *repo,
    -+				    unsigned char *sha1, const char *idx_path);
    ++struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
    ++				    const char *idx_path);
      
      typedef void each_file_in_pack_dir_fn(const char *full_path, size_t full_path_len,
      				      const char *file_name, void *data);
    @@ packfile.h: void close_pack(struct packed_git *);
      void unuse_pack(struct pack_window **);
      void clear_delta_base_cache(void);
     -struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
    -+struct packed_git *add_packed_git(struct repository *repo, const char *path,
    ++struct packed_git *add_packed_git(struct repository *r, const char *path,
     +				  size_t path_len, int local);
      
      /*
 2:  ca03355686 !  2:  5350b4f9fb packfile: use `repository` from `packed_git` directly
    @@ Commit message
         where there is no struct `packed_git` locally available, which will be
         fixed in the following commits.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## packfile.c ##
    @@ packfile.c: static int check_packed_git_idx(const char *path, struct packed_git
      	int fd = git_open(path), ret;
      	struct stat st;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->r->hash_algo->rawsz;
      
      	if (fd < 0)
      		return -1;
    -@@ packfile.c: struct packed_git *parse_pack_index(struct repository *repo,
    +@@ packfile.c: struct packed_git *parse_pack_index(struct repository *r, unsigned char *sha1,
      
      	memcpy(p->pack_name, path, alloc); /* includes NUL */
      	free(path);
     -	hashcpy(p->hash, sha1, the_repository->hash_algo);
    -+	hashcpy(p->hash, sha1, p->repo->hash_algo);
    ++	hashcpy(p->hash, sha1, p->r->hash_algo);
      	if (check_packed_git_idx(idx_path, p)) {
      		free(p);
      		return NULL;
    @@ packfile.c: static int unuse_one_window(struct packed_git *current)
      	if (current)
      		scan_windows(current, &lru_p, &lru_w, &lru_l);
     -	for (p = the_repository->objects->packed_git; p; p = p->next)
    -+	for (p = current->repo->objects->packed_git; p; p = p->next)
    ++	for (p = current->r->objects->packed_git; p; p = p->next)
      		scan_windows(p, &lru_p, &lru_w, &lru_l);
      	if (lru_p) {
      		munmap(lru_w->base, lru_w->len);
    @@ packfile.c: static int open_packed_git_1(struct packed_git *p)
      	unsigned char *idx_hash;
      	ssize_t read_result;
     -	const unsigned hashsz = the_hash_algo->rawsz;
    -+	const unsigned hashsz = p->repo->hash_algo->rawsz;
    ++	const unsigned hashsz = p->r->hash_algo->rawsz;
      
      	if (open_pack_index(p))
      		return error("packfile %s index unavailable", p->pack_name);
    @@ packfile.c: static int open_packed_git_1(struct packed_git *p)
      		return error("packfile %s signature is unavailable", p->pack_name);
      	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
     -	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
    -+	if (!hasheq(hash, idx_hash, p->repo->hash_algo))
    ++	if (!hasheq(hash, idx_hash, p->r->hash_algo))
      		return error("packfile %s does not match index", p->pack_name);
      	return 0;
      }
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
      		die("packfile %s cannot be accessed", p->pack_name);
     -	if (offset > (p->pack_size - the_hash_algo->rawsz))
    -+	if (offset > (p->pack_size - p->repo->hash_algo->rawsz))
    ++	if (offset > (p->pack_size - p->r->hash_algo->rawsz))
      		die("offset beyond end of packfile (truncated pack?)");
      	if (offset < 0)
      		die(_("offset before end of packfile (broken .idx?)"));
    -@@ packfile.c: struct packed_git *add_packed_git(struct repository *repo, const char *path,
    +@@ packfile.c: struct packed_git *add_packed_git(struct repository *r, const char *path,
      	struct stat st;
      	size_t alloc;
      	struct packed_git *p;
    @@ packfile.c: struct packed_git *add_packed_git(struct repository *repo, const cha
      
      	/*
      	 * Make sure a corresponding .pack file exists and that
    -@@ packfile.c: struct packed_git *add_packed_git(struct repository *repo, const char *path,
    +@@ packfile.c: struct packed_git *add_packed_git(struct repository *r, const char *path,
      	p->pack_size = st.st_size;
      	p->pack_local = local;
      	p->mtime = st.st_mtime;
     -	if (path_len < the_hash_algo->hexsz ||
     -	    get_hash_hex(path + path_len - the_hash_algo->hexsz, p->hash))
     -		hashclr(p->hash, the_repository->hash_algo);
    -+	if (path_len < repo->hash_algo->hexsz ||
    -+	    get_oid_hex_algop(path + path_len - repo->hash_algo->hexsz, &oid,
    -+			      repo->hash_algo))
    -+		hashclr(p->hash, repo->hash_algo);
    ++	if (path_len < r->hash_algo->hexsz ||
    ++	    get_oid_hex_algop(path + path_len - r->hash_algo->hexsz, &oid,
    ++			      r->hash_algo))
    ++		hashclr(p->hash, r->hash_algo);
     +	else
    -+		memcpy(p->hash, oid.hash, repo->hash_algo->rawsz);
    ++		hashcpy(p->hash, oid.hash, r->hash_algo);
     +
      	return p;
      }
    @@ packfile.c: off_t get_delta_base(struct packed_git *p,
      		/* The base entry _must_ be in the same pack */
      		struct object_id oid;
     -		oidread(&oid, base_info, the_repository->hash_algo);
    -+		oidread(&oid, base_info, p->repo->hash_algo);
    ++		oidread(&oid, base_info, p->r->hash_algo);
      		base_offset = find_pack_entry_one(&oid, p);
     -		*curpos += the_hash_algo->rawsz;
    -+		*curpos += p->repo->hash_algo->rawsz;
    ++		*curpos += p->r->hash_algo->rawsz;
      	} else
      		die("I am totally screwed");
      	return base_offset;
    @@ packfile.c: static int get_delta_base_oid(struct packed_git *p,
      	if (type == OBJ_REF_DELTA) {
      		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
     -		oidread(oid, base, the_repository->hash_algo);
    -+		oidread(oid, base, p->repo->hash_algo);
    ++		oidread(oid, base, p->r->hash_algo);
      		return 0;
      	} else if (type == OBJ_OFS_DELTA) {
      		uint32_t base_pos;
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      			}
      		} else
     -			oidclr(oi->delta_base_oid, the_repository->hash_algo);
    -+			oidclr(oi->delta_base_oid, p->repo->hash_algo);
    ++			oidclr(oi->delta_base_oid, p->r->hash_algo);
      	}
      
      	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
    @@ packfile.c: int bsearch_pack(const struct object_id *oid, const struct packed_gi
      	const unsigned char *index_fanout = p->index_data;
      	const unsigned char *index_lookup;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->r->hash_algo->rawsz;
      	int index_lookup_width;
      
      	if (!index_fanout)
    @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
      {
      	const unsigned char *index = p->index_data;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->r->hash_algo->rawsz;
      	if (!index) {
      		if (open_pack_index(p))
      			return -1;
    @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
      	if (p->index_version == 1) {
      		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
     -			the_repository->hash_algo);
    -+			p->repo->hash_algo);
    ++			p->r->hash_algo);
      	} else {
      		index += 8;
     -		oidread(oid, index + st_mult(hashsz, n),
     -			the_repository->hash_algo);
    -+		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
    ++		oidread(oid, index + st_mult(hashsz, n), p->r->hash_algo);
      	}
      	return 0;
      }
    @@ packfile.c: void check_pack_index_ptr(const struct packed_git *p, const void *vp
      {
      	const unsigned char *index = p->index_data;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->repo->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->r->hash_algo->rawsz;
      	index += 4 * 256;
      	if (p->index_version == 1) {
      		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
    @@ packfile.c: int for_each_object_in_pack(struct packed_git *p,
      
      	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
     -		if (load_pack_revindex(the_repository, p))
    -+		if (load_pack_revindex(p->repo, p))
    ++		if (load_pack_revindex(p->r, p))
      			return -1;
      	}
      
    @@ packfile.c: static int add_promisor_object(const struct object_id *oid,
      	int we_parsed_object;
      
     -	obj = lookup_object(the_repository, oid);
    -+	obj = lookup_object(pack->repo, oid);
    ++	obj = lookup_object(pack->r, oid);
      	if (obj && obj->parsed) {
      		we_parsed_object = 0;
      	} else {
      		we_parsed_object = 1;
     -		obj = parse_object(the_repository, oid);
    -+		obj = parse_object(pack->repo, oid);
    ++		obj = parse_object(pack->r, oid);
      	}
      
      	if (!obj)
 -:  ---------- >  3:  5b975cb6d6 packfile: pass `repository` to static function in the file
 4:  73ba9945a7 !  4:  13a166fcca packfile: pass down repository to `odb_pack_name`
    @@ builtin/fast-import.c: static char *keep_pack(const char *curr_index_name)
      	int keep_fd;
      
     -	odb_pack_name(&name, pack_data->hash, "keep");
    -+	odb_pack_name(the_repository, &name, pack_data->hash, "keep");
    ++	odb_pack_name(pack_data->r, &name, pack_data->hash, "keep");
      	keep_fd = odb_pack_keep(name.buf);
      	if (keep_fd < 0)
      		die_errno("cannot create keep file");
    @@ builtin/fast-import.c: static char *keep_pack(const char *curr_index_name)
      		die_errno("failed to write keep file");
      
     -	odb_pack_name(&name, pack_data->hash, "pack");
    -+	odb_pack_name(the_repository, &name, pack_data->hash, "pack");
    ++	odb_pack_name(pack_data->r, &name, pack_data->hash, "pack");
      	if (finalize_object_file(pack_data->pack_name, name.buf))
      		die("cannot store pack file");
      
     -	odb_pack_name(&name, pack_data->hash, "idx");
    -+	odb_pack_name(the_repository, &name, pack_data->hash, "idx");
    ++	odb_pack_name(pack_data->r, &name, pack_data->hash, "idx");
      	if (finalize_object_file(curr_index_name, name.buf))
      		die("cannot store index file");
      	free((void *)curr_index_name);
    @@ builtin/fast-import.c: static void unkeep_all_packs(void)
      	for (k = 0; k < pack_id; k++) {
      		struct packed_git *p = all_packs[k];
     -		odb_pack_name(&name, p->hash, "keep");
    -+		odb_pack_name(p->repo, &name, p->hash, "keep");
    ++		odb_pack_name(p->r, &name, p->hash, "keep");
      		unlink_or_warn(name.buf);
      	}
      	strbuf_release(&name);
    @@ builtin/index-pack.c: static void rename_tmp_packfile(const char **final_name,
      			    ext, *final_name);
     
      ## builtin/pack-redundant.c ##
    -@@ builtin/pack-redundant.c: static void load_all(void)
    - 	}
    - }
    - 
    --int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo UNUSED) {
    -+int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, struct repository *repo) {
    - 	int i; int i_still_use_this = 0; struct pack_list *min = NULL, *red, *pl;
    - 	struct llist *ignore;
    - 	struct strbuf idx_name = STRBUF_INIT;
     @@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, const char *prefix UNUSED, s
      	pl = red = pack_list_difference(local_packs, min);
      	while (pl) {
      		printf("%s\n%s\n",
     -		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
    -+		       odb_pack_name(repo, &idx_name, pl->pack->hash, "idx"),
    ++		       odb_pack_name(pl->pack->r, &idx_name, pl->pack->hash, "idx"),
      		       pl->pack->pack_name);
      		pl = pl->next;
      	}
    @@ packfile.c
     -char *odb_pack_name(struct strbuf *buf,
     -		    const unsigned char *hash,
     -		    const char *ext)
    -+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
    ++char *odb_pack_name(struct repository *r, struct strbuf *buf,
     +		    const unsigned char *hash, const char *ext)
      {
      	strbuf_reset(buf);
     -	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(the_repository),
     -		    hash_to_hex(hash), ext);
    -+	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(repo),
    -+		    hash_to_hex_algop(hash, repo->hash_algo), ext);
    ++	strbuf_addf(buf, "%s/pack/pack-%s.%s", repo_get_object_directory(r),
    ++		    hash_to_hex_algop(hash, r->hash_algo), ext);
      	return buf->buf;
      }
      
    @@ packfile.h: struct pack_entry {
       * Example: odb_pack_name(out, sha1, "idx") => ".git/objects/pack/pack-1234..idx"
       */
     -char *odb_pack_name(struct strbuf *buf, const unsigned char *sha1, const char *ext);
    -+char *odb_pack_name(struct repository *repo, struct strbuf *buf,
    ++char *odb_pack_name(struct repository *r, struct strbuf *buf,
     +		    const unsigned char *hash, const char *ext);
      
      /*
 5:  4e883a4d1c !  5:  1fac06f19e packfile: pass down repository to `has_object[_kept]_pack`
    @@ builtin/pack-objects.c: static int want_found_object(const struct object_id *oid
      		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
      			return 0;
     -		if (has_object_kept_pack(oid, flags))
    -+		if (has_object_kept_pack(the_repository, oid, flags))
    ++		if (has_object_kept_pack(p->r, oid, flags))
      			return 0;
      	}
      
    @@ builtin/pack-objects.c: static void show_cruft_commit(struct commit *commit, voi
      static int cruft_include_check_obj(struct object *obj, void *data UNUSED)
      {
     -	return !has_object_kept_pack(&obj->oid, IN_CORE_KEEP_PACKS);
    -+	return !has_object_kept_pack(the_repository, &obj->oid, IN_CORE_KEEP_PACKS);
    ++	return !has_object_kept_pack(to_pack.repo, &obj->oid, IN_CORE_KEEP_PACKS);
      }
      
      static int cruft_include_check(struct commit *commit, void *data)
    @@ diff.c: static int reuse_worktree_file(struct index_state *istate,
      	 */
     -	if (!FAST_WORKING_DIRECTORY && !want_file && has_object_pack(oid))
     +	if (!FAST_WORKING_DIRECTORY && !want_file &&
    -+	    has_object_pack(the_repository, oid))
    ++	    has_object_pack(istate->repo, oid))
      		return 0;
      
      	/*
    @@ packfile.c: int find_kept_pack_entry(struct repository *r,
      }
      
     -int has_object_pack(const struct object_id *oid)
    -+int has_object_pack(struct repository *repo, const struct object_id *oid)
    ++int has_object_pack(struct repository *r, const struct object_id *oid)
      {
      	struct pack_entry e;
     -	return find_pack_entry(the_repository, oid, &e);
    -+	return find_pack_entry(repo, oid, &e);
    ++	return find_pack_entry(r, oid, &e);
      }
      
     -int has_object_kept_pack(const struct object_id *oid, unsigned flags)
    -+int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
    ++int has_object_kept_pack(struct repository *r, const struct object_id *oid,
     +			 unsigned flags)
      {
      	struct pack_entry e;
     -	return find_kept_pack_entry(the_repository, oid, flags, &e);
    -+	return find_kept_pack_entry(repo, oid, flags, &e);
    ++	return find_kept_pack_entry(r, oid, flags, &e);
      }
      
      int for_each_object_in_pack(struct packed_git *p,
    @@ packfile.h: const struct packed_git *has_packed_and_bad(struct repository *, con
      
     -int has_object_pack(const struct object_id *oid);
     -int has_object_kept_pack(const struct object_id *oid, unsigned flags);
    -+int has_object_pack(struct repository *repo, const struct object_id *oid);
    -+int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
    ++int has_object_pack(struct repository *r, const struct object_id *oid);
    ++int has_object_kept_pack(struct repository *r, const struct object_id *oid,
     +			 unsigned flags);
      
      /*
 6:  7c599e16f6 !  6:  a5fb3b1a4a packfile: pass down repository to `for_each_packed_object`
    @@ builtin/pack-objects.c: static void show_object__ma_allow_promisor(struct object
      	 */
     -	if (!has_object(the_repository, &obj->oid, 0) && is_promisor_object(&obj->oid))
     +	if (!has_object(the_repository, &obj->oid, 0) &&
    -+	    is_promisor_object(the_repository, &obj->oid))
    ++	    is_promisor_object(to_pack.repo, &obj->oid))
      		return;
      
      	show_object(obj, name, data);
    @@ builtin/pack-objects.c: static int add_object_in_unpacked_pack(const struct obje
      static void add_objects_in_unpacked_packs(void)
      {
     -	if (for_each_packed_object(add_object_in_unpacked_pack, NULL,
    -+	if (for_each_packed_object(the_repository,
    ++	if (for_each_packed_object(to_pack.repo,
     +				   add_object_in_unpacked_pack,
     +				   NULL,
      				   FOR_EACH_OBJECT_PACK_ORDER |
    @@ packfile.c: static int add_promisor_object(const struct object_id *oid,
      }
      
     -int is_promisor_object(const struct object_id *oid)
    -+int is_promisor_object(struct repository *repo, const struct object_id *oid)
    ++int is_promisor_object(struct repository *r, const struct object_id *oid)
      {
      	static struct oidset promisor_objects;
      	static int promisor_objects_prepared;
    @@ packfile.c: static int add_promisor_object(const struct object_id *oid,
      	if (!promisor_objects_prepared) {
     -		if (repo_has_promisor_remote(the_repository)) {
     -			for_each_packed_object(add_promisor_object,
    -+		if (repo_has_promisor_remote(repo)) {
    -+			for_each_packed_object(repo, add_promisor_object,
    ++		if (repo_has_promisor_remote(r)) {
    ++			for_each_packed_object(r, add_promisor_object,
      					       &promisor_objects,
      					       FOR_EACH_OBJECT_PROMISOR_ONLY |
      					       FOR_EACH_OBJECT_PACK_ORDER);
     
      ## packfile.h ##
    -@@ packfile.h: int has_object_kept_pack(struct repository *repo, const struct object_id *oid,
    +@@ packfile.h: int has_object_kept_pack(struct repository *r, const struct object_id *oid,
       * Return 1 if an object in a promisor packfile is or refers to the given
       * object, 0 otherwise.
       */
     -int is_promisor_object(const struct object_id *oid);
    -+int is_promisor_object(struct repository *repo, const struct object_id *oid);
    ++int is_promisor_object(struct repository *r, const struct object_id *oid);
      
      /*
       * Expose a function for fuzz testing.
 7:  89ee3f48ce !  7:  6e5951ceea config: make `delta_base_cache_limit` a non-global variable
    @@ Commit message
         this value from the repository config, since the value is only used once
         in the entire subsystem.
     
    +    These changes are made to remove the usage of `delta_base_cache_limit`
    +    as a global variable in `packfile.c`. This brings us one step closer to
    +    removing the `USE_THE_REPOSITORY_VARIABLE` definition in `packfile.c`
    +    which we complete in the next patch.
    +
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/gc.c ##
    @@ packfile.c
     +#include "config.h"
     +#include "pack-objects.h"
      
    - char *odb_pack_name(struct repository *repo, struct strbuf *buf,
    + char *odb_pack_name(struct repository *r, struct strbuf *buf,
      		    const unsigned char *hash, const char *ext)
     @@ packfile.c: void clear_delta_base_cache(void)
      }
 8:  e99b1dad54 !  8:  ec9061fbbd config: make `packed_git_(limit|window_size)` non-global variables
    @@ Commit message
         means we can also remove the `USE_THE_REPOSITORY_VARIABLE` guard from
         the file.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
      ## builtin/fast-import.c ##
    @@ packfile.c
     +#define PACKFILE_CONFIG_INIT \
     +{ \
     +	.packed_git_window_size = DEFAULT_PACKED_GIT_WINDOW_SIZE, \
    -+	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT,  \
    ++	.packed_git_limit = DEFAULT_PACKED_GIT_LIMIT, \
     +}
     +
    - char *odb_pack_name(struct repository *repo, struct strbuf *buf,
    + char *odb_pack_name(struct repository *r, struct strbuf *buf,
      		    const unsigned char *hash, const char *ext)
      {
     @@ packfile.c: static size_t pack_mapped;
    @@ packfile.c: static size_t pack_mapped;
     -void pack_report(void)
     +static int packfile_config(const char *var, const char *value,
     +			   const struct config_context *ctx, void *cb)
    - {
    ++{
     +	struct packfile_config *config = cb;
     +
     +	if (!strcmp(var, "core.packedgitwindowsize")) {
    @@ packfile.c: static size_t pack_mapped;
     +			config->packed_git_window_size = 1;
     +		config->packed_git_window_size *= pgsz_x2;
     +		return 0;
    -+	}
    -+
    -+	if (!strcmp(var, "core.packedgitlimit")) {
    ++	} else if (!strcmp(var, "core.packedgitlimit")) {
     +		config->packed_git_limit = git_config_ulong(var, value, ctx->kvi);
     +		return 0;
    ++	} else {
    ++		return git_default_config(var, value, ctx, cb);
     +	}
    -+
    -+	return git_default_config(var, value, ctx, cb);
     +}
     +
    -+
     +void pack_report(struct repository *repo)
    -+{
    + {
     +	struct packfile_config config = PACKFILE_CONFIG_INIT;
     +	repo_config(repo, packfile_config, &config);
     +
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
     +			size_t window_align;
      			off_t len;
      
    -+			repo_config(p->repo, packfile_config, &config);
    ++			repo_config(p->r, packfile_config, &config);
     +			window_align = config.packed_git_window_size / 2;
     +
      			if (p->pack_fd == -1 && open_packed_git(p))
 3:  1f8ef580e5 !  9:  c0b386412d packfile: pass `repository` to static function in the file
    @@ Metadata
     Author: Karthik Nayak <karthik.188@gmail.com>
     
      ## Commit message ##
    -    packfile: pass `repository` to static function in the file
    +    midx: add repository to `multi_pack_index` struct
     
    -    Some of the static functions in the `packfile.c` access global
    -    variables, which can simply be avoiding by passing the `repository`
    -    struct down to them. Let's do that.
    +    The `multi_pack_index` struct represents the MIDX for a repository.
    +    Here, we add a pointer to the repository in this struct, allowing direct
    +    use of the repository variable without relying on the global
    +    `the_repository` struct.
    +
    +    With this addition, we can determine the repository associated with a
    +    `bitmap_index` struct. A `bitmap_index` points to either a `packed_git`
    +    or a `multi_pack_index`, both of which have direct repository
    +    references. To support this, we introduce a static helper function,
    +    `bitmap_repo`, in `pack-bitmap.c`, which retrieves a repository given a
    +    `bitmap_index`.
    +
    +    With this, we clear up all usages of `the_repository` within
    +    `pack-bitmap.c` and also remove the `USE_THE_REPOSITORY_VARIABLE`
    +    definition. Bringing us another step closer to remove all global
    +    variable usage.
    +
    +    Although this change also opens up the potential to clean up `midx.c`,
    +    doing so would require additional refactoring to pass the repository
    +    struct to functions where the MIDX struct is created: a task better
    +    suited for future patches.
     
         Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
     
    - ## packfile.c ##
    -@@ packfile.c: static void find_lru_pack(struct packed_git *p, struct packed_git **lru_p, struc
    - 	*accept_windows_inuse = has_windows_inuse;
    + ## midx.c ##
    +@@ midx.c: static struct multi_pack_index *load_multi_pack_index_one(const char *object_dir
    + 	m->data = midx_map;
    + 	m->data_len = midx_size;
    + 	m->local = local;
    ++	m->r = the_repository;
    + 
    + 	m->signature = get_be32(m->data);
    + 	if (m->signature != MIDX_SIGNATURE)
    +
    + ## midx.h ##
    +@@ midx.h: struct multi_pack_index {
    + 
    + 	const char **pack_names;
    + 	struct packed_git **packs;
    ++
    ++	struct repository *r;
    ++
    + 	char object_dir[FLEX_ARRAY];
    + };
    + 
    +
    + ## pack-bitmap.c ##
    +@@
    +-#define USE_THE_REPOSITORY_VARIABLE
    +-
    + #include "git-compat-util.h"
    + #include "commit.h"
    + #include "gettext.h"
    +@@ pack-bitmap.c: static uint32_t bitmap_num_objects(struct bitmap_index *index)
    + 	return index->pack->num_objects;
      }
      
    --static int close_one_pack(void)
    -+static int close_one_pack(struct repository *repo)
    ++static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
    ++{
    ++	if (bitmap_is_midx(bitmap_git))
    ++		return bitmap_git->midx->r;
    ++	return bitmap_git->pack->r;
    ++}
    ++
    + static int load_bitmap_header(struct bitmap_index *index)
      {
    - 	struct packed_git *p, *lru_p = NULL;
    - 	struct pack_window *mru_w = NULL;
    - 	int accept_windows_inuse = 1;
    + 	struct bitmap_disk_header *header = (void *)index->map;
    +-	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + the_hash_algo->rawsz;
    ++	const struct git_hash_algo *hash_algo = bitmap_repo(index)->hash_algo;
    ++
    ++	size_t header_size = sizeof(*header) - GIT_MAX_RAWSZ + hash_algo->rawsz;
      
    --	for (p = the_repository->objects->packed_git; p; p = p->next) {
    -+	for (p = repo->objects->packed_git; p; p = p->next) {
    - 		if (p->pack_fd == -1)
    - 			continue;
    - 		find_lru_pack(p, &lru_p, &mru_w, &accept_windows_inuse);
    -@@ packfile.c: static int open_packed_git_1(struct packed_git *p)
    - 			pack_max_fds = 1;
    +-	if (index->map_size < header_size + the_hash_algo->rawsz)
    ++	if (index->map_size < header_size + hash_algo->rawsz)
    + 		return error(_("corrupted bitmap index (too small)"));
    + 
    + 	if (memcmp(header->magic, BITMAP_IDX_SIGNATURE, sizeof(BITMAP_IDX_SIGNATURE)) != 0)
    +@@ pack-bitmap.c: static int load_bitmap_header(struct bitmap_index *index)
    + 	{
    + 		uint32_t flags = ntohs(header->options);
    + 		size_t cache_size = st_mult(bitmap_num_objects(index), sizeof(uint32_t));
    +-		unsigned char *index_end = index->map + index->map_size - the_hash_algo->rawsz;
    ++		unsigned char *index_end = index->map + index->map_size - hash_algo->rawsz;
    + 
    + 		if ((flags & BITMAP_OPT_FULL_DAG) == 0)
    + 			BUG("unsupported options for bitmap index file "
    +@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    + 	if (bitmap_git->pack || bitmap_git->midx) {
    + 		struct strbuf buf = STRBUF_INIT;
    + 		get_midx_filename(&buf, midx->object_dir);
    +-		trace2_data_string("bitmap", the_repository,
    ++		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
    + 				   "ignoring extra midx bitmap file", buf.buf);
    + 		close(fd);
    + 		strbuf_release(&buf);
    +@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    + 		goto cleanup;
    + 
    + 	if (!hasheq(get_midx_checksum(bitmap_git->midx), bitmap_git->checksum,
    +-		    the_repository->hash_algo)) {
    ++		    bitmap_repo(bitmap_git)->hash_algo)) {
    + 		error(_("checksum doesn't match in MIDX and bitmap"));
    + 		goto cleanup;
    + 	}
    +@@ pack-bitmap.c: static int open_midx_bitmap_1(struct bitmap_index *bitmap_git,
    + 	}
    + 
    + 	for (i = 0; i < bitmap_git->midx->num_packs; i++) {
    +-		if (prepare_midx_pack(the_repository, bitmap_git->midx, i)) {
    ++		if (prepare_midx_pack(bitmap_repo(bitmap_git),
    ++				      bitmap_git->midx,
    ++				      i)) {
    + 			warning(_("could not open pack %s"),
    + 				bitmap_git->midx->pack_names[i]);
    + 			goto cleanup;
    +@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
      	}
      
    --	while (pack_max_fds <= pack_open_fds && close_one_pack())
    -+	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
    - 		; /* nothing */
    + 	if (bitmap_git->pack || bitmap_git->midx) {
    +-		trace2_data_string("bitmap", the_repository,
    +-				   "ignoring extra bitmap file", packfile->pack_name);
    ++		trace2_data_string("bitmap", bitmap_repo(bitmap_git),
    ++				   "ignoring extra bitmap file",
    ++				   packfile->pack_name);
    + 		close(fd);
    + 		return -1;
    + 	}
    +@@ pack-bitmap.c: static int open_pack_bitmap_1(struct bitmap_index *bitmap_git, struct packed_git
    + 		return -1;
    + 	}
      
    - 	p->pack_fd = git_open(p->pack_name);
    -@@ packfile.c: static int open_packed_git(struct packed_git *p)
    - 	return -1;
    +-	trace2_data_string("bitmap", the_repository, "opened bitmap file",
    +-			   packfile->pack_name);
    ++	trace2_data_string("bitmap", bitmap_repo(bitmap_git),
    ++			   "opened bitmap file", packfile->pack_name);
    + 	return 0;
      }
      
    --static int in_window(struct pack_window *win, off_t offset)
    -+static int in_window(struct repository *repo, struct pack_window *win,
    -+		     off_t offset)
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
    + 
    + struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
    + {
    +-	struct repository *r = the_repository;
    ++	struct repository *r = midx->r;
    + 	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
    + 
    + 	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
    +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
      {
    - 	/* We must promise at least one full hash after the
    - 	 * offset is available from this window, otherwise the offset
    -@@ packfile.c: static int in_window(struct pack_window *win, off_t offset)
    + 	struct bitmap_boundary_cb cb;
    + 	struct object_list *root;
    ++	struct repository *repo;
    + 	unsigned int i;
    + 	unsigned int tmp_blobs, tmp_trees, tmp_tags;
    + 	int any_missing = 0;
    +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
    + 	cb.base = bitmap_new();
    + 	object_array_init(&cb.boundary);
    + 
    ++	repo = bitmap_repo(bitmap_git);
    ++
    + 	revs->ignore_missing_links = 1;
    + 
    + 	if (bitmap_git->pseudo_merges.nr) {
    +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
    + 	 * revision walk to (a) OR in any bitmaps that are UNINTERESTING
    + 	 * between the tips and boundary, and (b) record the boundary.
      	 */
    - 	off_t win_off = win->offset;
    - 	return win_off <= offset
    --		&& (offset + the_hash_algo->rawsz) <= (win_off + win->len);
    -+		&& (offset + repo->hash_algo->rawsz) <= (win_off + win->len);
    +-	trace2_region_enter("pack-bitmap", "boundary-prepare", the_repository);
    ++	trace2_region_enter("pack-bitmap", "boundary-prepare", repo);
    + 	if (prepare_revision_walk(revs))
    + 		die("revision walk setup failed");
    +-	trace2_region_leave("pack-bitmap", "boundary-prepare", the_repository);
    ++	trace2_region_leave("pack-bitmap", "boundary-prepare", repo);
    + 
    +-	trace2_region_enter("pack-bitmap", "boundary-traverse", the_repository);
    ++	trace2_region_enter("pack-bitmap", "boundary-traverse", repo);
    + 	revs->boundary = 1;
    + 	traverse_commit_list_filtered(revs,
    + 				      show_boundary_commit,
    + 				      show_boundary_object,
    + 				      &cb, NULL);
    + 	revs->boundary = 0;
    +-	trace2_region_leave("pack-bitmap", "boundary-traverse", the_repository);
    ++	trace2_region_leave("pack-bitmap", "boundary-traverse", repo);
    + 
    + 	revs->blob_objects = tmp_blobs;
    + 	revs->tree_objects = tmp_trees;
    +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
    + 	/*
    + 	 * Then add the boundary commit(s) as fill-in traversal tips.
    + 	 */
    +-	trace2_region_enter("pack-bitmap", "boundary-fill-in", the_repository);
    ++	trace2_region_enter("pack-bitmap", "boundary-fill-in", repo);
    + 	for (i = 0; i < cb.boundary.nr; i++) {
    + 		struct object *obj = cb.boundary.objects[i].item;
    + 		if (bitmap_walk_contains(bitmap_git, cb.base, &obj->oid))
    +@@ pack-bitmap.c: static struct bitmap *find_boundary_objects(struct bitmap_index *bitmap_git,
    + 	}
    + 	if (revs->pending.nr)
    + 		cb.base = fill_in_bitmap(bitmap_git, revs, cb.base, NULL);
    +-	trace2_region_leave("pack-bitmap", "boundary-fill-in", the_repository);
    ++	trace2_region_leave("pack-bitmap", "boundary-fill-in", repo);
    + 
    + cleanup:
    + 	object_array_clear(&cb.boundary);
    +@@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
    + 			ofs = pack_pos_to_offset(pack, pos);
    + 		}
    + 
    +-		if (packed_object_info(the_repository, pack, ofs, &oi) < 0) {
    ++		if (packed_object_info(bitmap_repo(bitmap_git), pack, ofs,
    ++				       &oi) < 0) {
    + 			struct object_id oid;
    + 			nth_bitmap_object_oid(bitmap_git, &oid,
    + 					      pack_pos_to_index(pack, pos));
    +@@ pack-bitmap.c: static unsigned long get_size_by_pos(struct bitmap_index *bitmap_git,
    + 	} else {
    + 		struct eindex *eindex = &bitmap_git->ext_index;
    + 		struct object *obj = eindex->objects[pos - bitmap_num_objects(bitmap_git)];
    +-		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    ++		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
    ++					     &oi, 0) < 0)
    + 			die(_("unable to get size of %s"), oid_to_hex(&obj->oid));
    + 	}
    + 
    +@@ pack-bitmap.c: static void filter_packed_objects_from_bitmap(struct bitmap_index *bitmap_git,
    + 		bitmap_unset(result, i);
    + 
    + 	for (i = 0; i < eindex->count; ++i) {
    +-		if (has_object_pack(the_repository, &eindex->objects[i]->oid))
    ++		if (has_object_pack(bitmap_repo(bitmap_git),
    ++				    &eindex->objects[i]->oid))
    + 			bitmap_unset(result, objects_nr + i);
    + 	}
      }
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 	struct bitmap *haves_bitmap = NULL;
      
    - unsigned char *use_pack(struct packed_git *p,
    -@@ packfile.c: unsigned char *use_pack(struct packed_git *p,
    - 	if (offset < 0)
    - 		die(_("offset before end of packfile (broken .idx?)"));
    - 
    --	if (!win || !in_window(win, offset)) {
    -+	if (!win || !in_window(p->repo, win, offset)) {
    - 		if (win)
    - 			win->inuse_cnt--;
    - 		for (win = p->windows; win; win = win->next) {
    --			if (in_window(win, offset))
    -+			if (in_window(p->repo, win, offset))
    - 				break;
    + 	struct bitmap_index *bitmap_git;
    ++	struct repository *repo;
    + 
    + 	/*
    + 	 * We can't do pathspec limiting with bitmaps, because we don't know
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 	if (!use_boundary_traversal)
    + 		object_array_clear(&revs->pending);
    + 
    ++	repo = bitmap_repo(bitmap_git);
    ++
    + 	if (haves) {
    +-		if (use_boundary_traversal) {
    +-			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
    ++		if (use_boundary_traversal)
    ++		{
    ++			trace2_region_enter("pack-bitmap", "haves/boundary", repo);
    + 			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
    +-			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
    +-		} else {
    +-			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
    ++			trace2_region_leave("pack-bitmap", "haves/boundary", repo);
    ++		}
    ++		else
    ++		{
    ++			trace2_region_enter("pack-bitmap", "haves/classic", repo);
    + 			revs->ignore_missing_links = 1;
    + 			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
    + 			reset_revision_walk();
    + 			revs->ignore_missing_links = 0;
    +-			trace2_region_leave("pack-bitmap", "haves/classic", the_repository);
    ++			trace2_region_leave("pack-bitmap", "haves/classic", repo);
      		}
    - 		if (!win) {
    + 
    + 		if (!haves_bitmap)
    +@@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
    + 	object_list_free(&wants);
    + 	object_list_free(&haves);
    + 
    +-	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_satisfied",
    ++	trace2_data_intmax("bitmap", repo, "pseudo_merges_satisfied",
    + 			   pseudo_merges_satisfied_nr);
    +-	trace2_data_intmax("bitmap", the_repository, "pseudo_merges_cascades",
    ++	trace2_data_intmax("bitmap", repo, "pseudo_merges_cascades",
    + 			   pseudo_merges_cascades_nr);
    +-	trace2_data_intmax("bitmap", the_repository, "bitmap/hits",
    ++	trace2_data_intmax("bitmap", repo, "bitmap/hits",
    + 			   existing_bitmaps_hits_nr);
    +-	trace2_data_intmax("bitmap", the_repository, "bitmap/misses",
    ++	trace2_data_intmax("bitmap", repo, "bitmap/misses",
    + 			   existing_bitmaps_misses_nr);
    +-	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_with_bitmap",
    ++	trace2_data_intmax("bitmap", repo, "bitmap/roots_with_bitmap",
    + 			   roots_with_bitmaps_nr);
    +-	trace2_data_intmax("bitmap", the_repository, "bitmap/roots_without_bitmap",
    ++	trace2_data_intmax("bitmap", repo, "bitmap/roots_without_bitmap",
    + 			   roots_without_bitmaps_nr);
    + 
    + 	return bitmap_git;
    +@@ pack-bitmap.c: void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
    + 					struct bitmap **reuse_out,
    + 					int multi_pack_reuse)
    + {
    +-	struct repository *r = the_repository;
    ++	struct repository *r = bitmap_repo(bitmap_git);
    + 	struct bitmapped_pack *packs = NULL;
    + 	struct bitmap *result = bitmap_git->result;
    + 	struct bitmap *reuse;
    +@@ pack-bitmap.c: int rebuild_bitmap(const uint32_t *reposition,
    + uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
    + 				struct packing_data *mapping)
    + {
    +-	struct repository *r = the_repository;
    ++	struct repository *r = bitmap_repo(bitmap_git);
    + 	uint32_t i, num_objects;
    + 	uint32_t *reposition;
    + 
    +@@ pack-bitmap.c: static off_t get_disk_usage_for_extended(struct bitmap_index *bitmap_git)
    + 				st_add(bitmap_num_objects(bitmap_git), i)))
    + 			continue;
    + 
    +-		if (oid_object_info_extended(the_repository, &obj->oid, &oi, 0) < 0)
    ++		if (oid_object_info_extended(bitmap_repo(bitmap_git), &obj->oid,
    ++					     &oi, 0) < 0)
    + 			die(_("unable to get disk usage of '%s'"),
    + 			    oid_to_hex(&obj->oid));
    + 
-- 
2.47.0

