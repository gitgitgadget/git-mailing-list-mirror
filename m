Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA9F2AE9A
	for <git@vger.kernel.org>; Thu, 31 Oct 2024 09:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730367600; cv=none; b=Vst6NIIqp5M6aGFm6PH1Uu4V/4nRqum4FKLCWqt6OBkgvKADNBbaT8+mIcn/+GLMhBQET96JMES7XG95ym2UcdCyWqBAVu5kaJyCwhXHHDUhcknn3zZrT4dSB8QFmBEZzxMPR5lwff/AKgXJajYwgIYPsi9KX4qLKoOLr6Xt12I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730367600; c=relaxed/simple;
	bh=IIcl9FX6gGoVAnVcaul+2HNaAEe45zD7+HJYy6M0oVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HqJ8oZKxno/0pUDmtldT0bCyJYJarLbSAuQbp3Yv7FRpB0/Z/aAfo35y1+gylNnLw/aU9t1q716KoDLOGsjIPuRvnMAZ470KFZhYfWWFSFjc72KlKVF/QLn5qxh2wJylL17EmT8sD23jcgfuErrmQhxdfZU8+u02M3rwBvLk13Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idKFLgQB; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idKFLgQB"
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a9a0c40849cso114140866b.3
        for <git@vger.kernel.org>; Thu, 31 Oct 2024 02:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730367595; x=1730972395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MRPMekRu8+2rbBuvRrV+jJOWqlvntx9xu3dHFT08fRQ=;
        b=idKFLgQBRBhIKPdQiqlDVEjl47R0D8qE8iyAT/nv1EbDNqoeM8cG+9yBiyBHFoiDRr
         MkRUQ9/fj3ePUuKJMextiefgQvBzVUwA+HC5L9PTNMDVfXhanNzce98IaEzwU36sccfm
         gfKakVIiGVGHGUmSTPsLKpYwlZzYHFsHYk4WwZJTjBIabowDdDveJPVyGQBtEZFabXnZ
         DXWDkCd4r1Ic0gDp6J+y/biPtOig2c2F6/uYw1zqhOD9mnfH/X/bHTYuBQ6USCNYsrD3
         O/YONG+vVVdVrsO+o+y7r8se214QuvH58NCRIp6OibaekvEOPeHQEc6NLtVeGdArUgnG
         cKFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730367595; x=1730972395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MRPMekRu8+2rbBuvRrV+jJOWqlvntx9xu3dHFT08fRQ=;
        b=PNymby9w72mhO0LbyYmlCyh27ER289/kzmygnrVRy7SagOxiYbz/84R/159efWljcn
         7uvOivmmuLLMIW/h1EcET11aeM6dm3fpkWLwUA4ecKl00dgLR805V+J8VTO9Fq3unSoM
         lir6aoddnvgqPRAU+zBnAkjOYq4bKa6HpZZDHIlUC5Ke2p2nud5sJvnvxkj7Ib9XSpW3
         Sl7z3LuBidcU0c8r9gk4J+YW2sY7TZWfIzcLQc7pH0OI22QpyMxSw6UuI953Mp7R40qd
         e46NmwnSnfad2jShgvMz5oahh9jt+62/knQgTDHPS5g5u4fev5bK6YoqRw4wj82sAse8
         No6Q==
X-Gm-Message-State: AOJu0YyyRf/hM3mRbOfj2VPVDJgS4TK10Z1KP05EsvfqmVnMuz7Mo4Be
	029wm3mY70nc3NctoZnHtbIpFCGaCXv2D4bcNdZEd4x+pVx6ArotEBFBWJ/G
X-Google-Smtp-Source: AGHT+IFsRz3BmgJU6lskZ8iddiBzgev+mxc5Ebnk6q86HhI8TvrgmV2mysBHE5MtPepTpLILhrC/vA==
X-Received: by 2002:a17:906:6a12:b0:a99:f746:385 with SMTP id a640c23a62f3a-a9e3a573d11mr720596166b.1.1730367594866;
        Thu, 31 Oct 2024 02:39:54 -0700 (PDT)
Received: from archlinux.fritz.box ([2a02:2455:825d:6a00:6bb4:436f:5699:ff21])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9e564940d5sm46399566b.26.2024.10.31.02.39.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 02:39:54 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
To: karthik.188@gmail.com
Cc: git@vger.kernel.org,
	me@ttaylorr.com,
	peff@peff.net
Subject: [PATCH v4 0/9] packfile: avoid using the 'the_repository' global variable
Date: Thu, 31 Oct 2024 10:39:43 +0100
Message-ID: <cover.1730366765.git.karthik.188@gmail.com>
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
 pack-bitmap.c            |  90 +++++++++++--------
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
 34 files changed, 280 insertions(+), 190 deletions(-)

Range-diff against v3:
 1:  5afb9af0af !  1:  b3d518e998 packfile: add repository to struct `packed_git`
    @@ builtin/fast-import.c: static void start_packfile(void)
      
      	p->pack_fd = pack_fd;
      	p->do_not_close = 1;
    -+	p->r = the_repository;
    ++	p->repo = the_repository;
      	pack_file = hashfd(pack_fd, p->pack_name);
      
      	pack_data = p;
    @@ builtin/fast-import.c: static void end_packfile(void)
      
      		/* Register the packfile with core git's machinery. */
     -		new_p = add_packed_git(idx_name, strlen(idx_name), 1);
    -+		new_p = add_packed_git(pack_data->r, idx_name, strlen(idx_name), 1);
    ++		new_p = add_packed_git(pack_data->repo, idx_name, strlen(idx_name), 1);
      		if (!new_p)
      			die("core git rejected index %s", idx_name);
      		all_packs[pack_id] = new_p;
    @@ object-store-ll.h: struct packed_git {
      	size_t mtimes_size;
     +
     +	/* repo dentoes the repository this packed file belongs to */
    -+	struct repository *r;
    ++	struct repository *repo;
     +
      	/* something like ".git/objects/pack/xxxxx.pack" */
      	char pack_name[FLEX_ARRAY]; /* more */
    @@ packfile.c: uint32_t get_pack_fanout(struct packed_git *p, uint32_t value)
      	struct packed_git *p = xmalloc(st_add(sizeof(*p), extra));
      	memset(p, 0, sizeof(*p));
      	p->pack_fd = -1;
    -+	p->r = r;
    ++	p->repo = r;
      	return p;
      }
      
 2:  5350b4f9fb !  2:  bb9d9aa744 packfile: use `repository` from `packed_git` directly
    @@ packfile.c: static int check_packed_git_idx(const char *path, struct packed_git
      	int fd = git_open(path), ret;
      	struct stat st;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->r->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->repo->hash_algo->rawsz;
      
      	if (fd < 0)
      		return -1;
    @@ packfile.c: struct packed_git *parse_pack_index(struct repository *r, unsigned c
      	memcpy(p->pack_name, path, alloc); /* includes NUL */
      	free(path);
     -	hashcpy(p->hash, sha1, the_repository->hash_algo);
    -+	hashcpy(p->hash, sha1, p->r->hash_algo);
    ++	hashcpy(p->hash, sha1, p->repo->hash_algo);
      	if (check_packed_git_idx(idx_path, p)) {
      		free(p);
      		return NULL;
    @@ packfile.c: static int unuse_one_window(struct packed_git *current)
      	if (current)
      		scan_windows(current, &lru_p, &lru_w, &lru_l);
     -	for (p = the_repository->objects->packed_git; p; p = p->next)
    -+	for (p = current->r->objects->packed_git; p; p = p->next)
    ++	for (p = current->repo->objects->packed_git; p; p = p->next)
      		scan_windows(p, &lru_p, &lru_w, &lru_l);
      	if (lru_p) {
      		munmap(lru_w->base, lru_w->len);
    @@ packfile.c: static int open_packed_git_1(struct packed_git *p)
      	unsigned char *idx_hash;
      	ssize_t read_result;
     -	const unsigned hashsz = the_hash_algo->rawsz;
    -+	const unsigned hashsz = p->r->hash_algo->rawsz;
    ++	const unsigned hashsz = p->repo->hash_algo->rawsz;
      
      	if (open_pack_index(p))
      		return error("packfile %s index unavailable", p->pack_name);
    @@ packfile.c: static int open_packed_git_1(struct packed_git *p)
      		return error("packfile %s signature is unavailable", p->pack_name);
      	idx_hash = ((unsigned char *)p->index_data) + p->index_size - hashsz * 2;
     -	if (!hasheq(hash, idx_hash, the_repository->hash_algo))
    -+	if (!hasheq(hash, idx_hash, p->r->hash_algo))
    ++	if (!hasheq(hash, idx_hash, p->repo->hash_algo))
      		return error("packfile %s does not match index", p->pack_name);
      	return 0;
      }
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      	if (!p->pack_size && p->pack_fd == -1 && open_packed_git(p))
      		die("packfile %s cannot be accessed", p->pack_name);
     -	if (offset > (p->pack_size - the_hash_algo->rawsz))
    -+	if (offset > (p->pack_size - p->r->hash_algo->rawsz))
    ++	if (offset > (p->pack_size - p->repo->hash_algo->rawsz))
      		die("offset beyond end of packfile (truncated pack?)");
      	if (offset < 0)
      		die(_("offset before end of packfile (broken .idx?)"));
    @@ packfile.c: off_t get_delta_base(struct packed_git *p,
      		/* The base entry _must_ be in the same pack */
      		struct object_id oid;
     -		oidread(&oid, base_info, the_repository->hash_algo);
    -+		oidread(&oid, base_info, p->r->hash_algo);
    ++		oidread(&oid, base_info, p->repo->hash_algo);
      		base_offset = find_pack_entry_one(&oid, p);
     -		*curpos += the_hash_algo->rawsz;
    -+		*curpos += p->r->hash_algo->rawsz;
    ++		*curpos += p->repo->hash_algo->rawsz;
      	} else
      		die("I am totally screwed");
      	return base_offset;
    @@ packfile.c: static int get_delta_base_oid(struct packed_git *p,
      	if (type == OBJ_REF_DELTA) {
      		unsigned char *base = use_pack(p, w_curs, curpos, NULL);
     -		oidread(oid, base, the_repository->hash_algo);
    -+		oidread(oid, base, p->r->hash_algo);
    ++		oidread(oid, base, p->repo->hash_algo);
      		return 0;
      	} else if (type == OBJ_OFS_DELTA) {
      		uint32_t base_pos;
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
      			}
      		} else
     -			oidclr(oi->delta_base_oid, the_repository->hash_algo);
    -+			oidclr(oi->delta_base_oid, p->r->hash_algo);
    ++			oidclr(oi->delta_base_oid, p->repo->hash_algo);
      	}
      
      	oi->whence = in_delta_base_cache(p, obj_offset) ? OI_DBCACHED :
    @@ packfile.c: int bsearch_pack(const struct object_id *oid, const struct packed_gi
      	const unsigned char *index_fanout = p->index_data;
      	const unsigned char *index_lookup;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->r->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->repo->hash_algo->rawsz;
      	int index_lookup_width;
      
      	if (!index_fanout)
    @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
      {
      	const unsigned char *index = p->index_data;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->r->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->repo->hash_algo->rawsz;
      	if (!index) {
      		if (open_pack_index(p))
      			return -1;
    @@ packfile.c: int nth_packed_object_id(struct object_id *oid,
      	if (p->index_version == 1) {
      		oidread(oid, index + st_add(st_mult(hashsz + 4, n), 4),
     -			the_repository->hash_algo);
    -+			p->r->hash_algo);
    ++			p->repo->hash_algo);
      	} else {
      		index += 8;
     -		oidread(oid, index + st_mult(hashsz, n),
     -			the_repository->hash_algo);
    -+		oidread(oid, index + st_mult(hashsz, n), p->r->hash_algo);
    ++		oidread(oid, index + st_mult(hashsz, n), p->repo->hash_algo);
      	}
      	return 0;
      }
    @@ packfile.c: void check_pack_index_ptr(const struct packed_git *p, const void *vp
      {
      	const unsigned char *index = p->index_data;
     -	const unsigned int hashsz = the_hash_algo->rawsz;
    -+	const unsigned int hashsz = p->r->hash_algo->rawsz;
    ++	const unsigned int hashsz = p->repo->hash_algo->rawsz;
      	index += 4 * 256;
      	if (p->index_version == 1) {
      		return ntohl(*((uint32_t *)(index + st_mult(hashsz + 4, n))));
    @@ packfile.c: int for_each_object_in_pack(struct packed_git *p,
      
      	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
     -		if (load_pack_revindex(the_repository, p))
    -+		if (load_pack_revindex(p->r, p))
    ++		if (load_pack_revindex(p->repo, p))
      			return -1;
      	}
      
    @@ packfile.c: static int add_promisor_object(const struct object_id *oid,
      	int we_parsed_object;
      
     -	obj = lookup_object(the_repository, oid);
    -+	obj = lookup_object(pack->r, oid);
    ++	obj = lookup_object(pack->repo, oid);
      	if (obj && obj->parsed) {
      		we_parsed_object = 0;
      	} else {
      		we_parsed_object = 1;
     -		obj = parse_object(the_repository, oid);
    -+		obj = parse_object(pack->r, oid);
    ++		obj = parse_object(pack->repo, oid);
      	}
      
      	if (!obj)
 3:  5b975cb6d6 !  3:  d5df50fa36 packfile: pass `repository` to static function in the file
    @@ packfile.c: static int open_packed_git_1(struct packed_git *p)
      	}
      
     -	while (pack_max_fds <= pack_open_fds && close_one_pack())
    -+	while (pack_max_fds <= pack_open_fds && close_one_pack(p->r))
    ++	while (pack_max_fds <= pack_open_fds && close_one_pack(p->repo))
      		; /* nothing */
      
      	p->pack_fd = git_open(p->pack_name);
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
      		die(_("offset before end of packfile (broken .idx?)"));
      
     -	if (!win || !in_window(win, offset)) {
    -+	if (!win || !in_window(p->r, win, offset)) {
    ++	if (!win || !in_window(p->repo, win, offset)) {
      		if (win)
      			win->inuse_cnt--;
      		for (win = p->windows; win; win = win->next) {
     -			if (in_window(win, offset))
    -+			if (in_window(p->r, win, offset))
    ++			if (in_window(p->repo, win, offset))
      				break;
      		}
      		if (!win) {
 4:  13a166fcca !  4:  0107801c3b packfile: pass down repository to `odb_pack_name`
    @@ builtin/fast-import.c: static char *keep_pack(const char *curr_index_name)
      	int keep_fd;
      
     -	odb_pack_name(&name, pack_data->hash, "keep");
    -+	odb_pack_name(pack_data->r, &name, pack_data->hash, "keep");
    ++	odb_pack_name(pack_data->repo, &name, pack_data->hash, "keep");
      	keep_fd = odb_pack_keep(name.buf);
      	if (keep_fd < 0)
      		die_errno("cannot create keep file");
    @@ builtin/fast-import.c: static char *keep_pack(const char *curr_index_name)
      		die_errno("failed to write keep file");
      
     -	odb_pack_name(&name, pack_data->hash, "pack");
    -+	odb_pack_name(pack_data->r, &name, pack_data->hash, "pack");
    ++	odb_pack_name(pack_data->repo, &name, pack_data->hash, "pack");
      	if (finalize_object_file(pack_data->pack_name, name.buf))
      		die("cannot store pack file");
      
     -	odb_pack_name(&name, pack_data->hash, "idx");
    -+	odb_pack_name(pack_data->r, &name, pack_data->hash, "idx");
    ++	odb_pack_name(pack_data->repo, &name, pack_data->hash, "idx");
      	if (finalize_object_file(curr_index_name, name.buf))
      		die("cannot store index file");
      	free((void *)curr_index_name);
    @@ builtin/fast-import.c: static void unkeep_all_packs(void)
      	for (k = 0; k < pack_id; k++) {
      		struct packed_git *p = all_packs[k];
     -		odb_pack_name(&name, p->hash, "keep");
    -+		odb_pack_name(p->r, &name, p->hash, "keep");
    ++		odb_pack_name(p->repo, &name, p->hash, "keep");
      		unlink_or_warn(name.buf);
      	}
      	strbuf_release(&name);
    @@ builtin/pack-redundant.c: int cmd_pack_redundant(int argc, const char **argv, co
      	while (pl) {
      		printf("%s\n%s\n",
     -		       odb_pack_name(&idx_name, pl->pack->hash, "idx"),
    -+		       odb_pack_name(pl->pack->r, &idx_name, pl->pack->hash, "idx"),
    ++		       odb_pack_name(pl->pack->repo, &idx_name, pl->pack->hash, "idx"),
      		       pl->pack->pack_name);
      		pl = pl->next;
      	}
 5:  1fac06f19e !  5:  2d7608a367 packfile: pass down repository to `has_object[_kept]_pack`
    @@ builtin/pack-objects.c: static int want_found_object(const struct object_id *oid
      		if (ignore_packed_keep_in_core && p->pack_keep_in_core)
      			return 0;
     -		if (has_object_kept_pack(oid, flags))
    -+		if (has_object_kept_pack(p->r, oid, flags))
    ++		if (has_object_kept_pack(p->repo, oid, flags))
      			return 0;
      	}
      
 6:  a5fb3b1a4a =  6:  2c84026d02 packfile: pass down repository to `for_each_packed_object`
 7:  6e5951ceea =  7:  84b89c8a0e config: make `delta_base_cache_limit` a non-global variable
 8:  ec9061fbbd !  8:  5bbdc7124d config: make `packed_git_(limit|window_size)` non-global variables
    @@ packfile.c: unsigned char *use_pack(struct packed_git *p,
     +			size_t window_align;
      			off_t len;
      
    -+			repo_config(p->r, packfile_config, &config);
    ++			repo_config(p->repo, packfile_config, &config);
     +			window_align = config.packed_git_window_size / 2;
     +
      			if (p->pack_fd == -1 && open_packed_git(p))
 9:  c0b386412d !  9:  bb15a0be56 midx: add repository to `multi_pack_index` struct
    @@ midx.c: static struct multi_pack_index *load_multi_pack_index_one(const char *ob
      	m->data = midx_map;
      	m->data_len = midx_size;
      	m->local = local;
    -+	m->r = the_repository;
    ++	m->repo = the_repository;
      
      	m->signature = get_be32(m->data);
      	if (m->signature != MIDX_SIGNATURE)
    @@ midx.h: struct multi_pack_index {
      	const char **pack_names;
      	struct packed_git **packs;
     +
    -+	struct repository *r;
    ++	struct repository *repo;
     +
      	char object_dir[FLEX_ARRAY];
      };
    @@ pack-bitmap.c: static uint32_t bitmap_num_objects(struct bitmap_index *index)
     +static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
     +{
     +	if (bitmap_is_midx(bitmap_git))
    -+		return bitmap_git->midx->r;
    -+	return bitmap_git->pack->r;
    ++		return bitmap_git->midx->repo;
    ++	return bitmap_git->pack->repo;
     +}
     +
      static int load_bitmap_header(struct bitmap_index *index)
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_git(struct repository *r)
      struct bitmap_index *prepare_midx_bitmap_git(struct multi_pack_index *midx)
      {
     -	struct repository *r = the_repository;
    -+	struct repository *r = midx->r;
    ++	struct repository *r = midx->repo;
      	struct bitmap_index *bitmap_git = xcalloc(1, sizeof(*bitmap_git));
      
      	if (!open_midx_bitmap_1(bitmap_git, midx) && !load_bitmap(r, bitmap_git))
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     +	repo = bitmap_repo(bitmap_git);
     +
      	if (haves) {
    --		if (use_boundary_traversal) {
    + 		if (use_boundary_traversal) {
     -			trace2_region_enter("pack-bitmap", "haves/boundary", the_repository);
    -+		if (use_boundary_traversal)
    -+		{
     +			trace2_region_enter("pack-bitmap", "haves/boundary", repo);
      			haves_bitmap = find_boundary_objects(bitmap_git, revs, haves);
     -			trace2_region_leave("pack-bitmap", "haves/boundary", the_repository);
    --		} else {
    --			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
     +			trace2_region_leave("pack-bitmap", "haves/boundary", repo);
    -+		}
    -+		else
    -+		{
    + 		} else {
    +-			trace2_region_enter("pack-bitmap", "haves/classic", the_repository);
     +			trace2_region_enter("pack-bitmap", "haves/classic", repo);
      			revs->ignore_missing_links = 1;
      			haves_bitmap = find_objects(bitmap_git, revs, haves, NULL);
-- 
2.47.0

