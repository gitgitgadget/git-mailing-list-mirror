Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF74221FB4
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 11:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781524354; cv=none; b=TXdwVIQvuP17o5Ynycal7sWPJxzljc33bBPjblYGNlDMyrQ+ZG84mlH8FhxmtNmRh/ClsctbWrz1w3cbDlvGnp5T0Vp2X3pY86Hs4ATjzAWB69l/TYC+HY42J1yxEDDjmif73kl6Uo9wnUGqhuxAidSRxYH00C+AoXiDDReQAVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781524354; c=relaxed/simple;
	bh=H6nO+SDmMlOXcBD7ljGnGmIxgMn5eTdTUzuuLPS5isw=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Q40S6gihU5XVUse6ZGDwmO7G1O+eybHCuff9+WrkTojvh3TfQgr/P8RH0Ak72KNehN91eOr4ihdLLV9BlwJJqlR9d53Eh/UIHgb5N55X8MiwPrwpBQfnDd/U5Z047VsFQqera419obe9UG4+9QGgZapkFfbGlJ8N7ciw25jC2A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZJzO+99; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZJzO+99"
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8cce26ee1e9so51748536d6.2
        for <git@vger.kernel.org>; Mon, 15 Jun 2026 04:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781524352; x=1782129152; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDLdNCOWy1q2PloOJCNJEUFWAkpL7bAAYgVgTdfKYfM=;
        b=ZZJzO+99X7wPBMNbM/FjJ/0X/Ke/xJy98jgUY9H6xpDqp6T/Osdbqwc5aWCXHFmc1B
         tKsndRlbiVZRP5MNkOLgsha0z1gXhECWrrxf9TNDAIDt5vq0sXtBSr/XmM8zU34QpP0Z
         lQrDy8QbridEEGKah7YcBsAzJ1z4+oVOR2t+w/hsfvnfVKbasluJHBY4vvZehsberr6t
         9dUf0YCY4udyxWqiRYrmfbfhRbiO2Jpi3xG4riJxuWBXZDOJJYwBp0cpfPnigADY1p8Y
         HOIOfBkxXaDY3mUSWLc3VvJWqtw/JINBRoB4jcIHJ41ERfQsrPe2aBBQbB4Jbsn2fh6T
         6Pmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781524352; x=1782129152;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDLdNCOWy1q2PloOJCNJEUFWAkpL7bAAYgVgTdfKYfM=;
        b=egEZ0TM3DLN52G5cKddJt5FpAHXIiRAxVbjxRxfI3V/c4i7A9BPnBfgvgQmobPq49S
         RUPQkL/T1dkzxA975hBYICupcZC02RkjH2mKI4PlB2/yj48WSYXsVn4B+yPmG5LQBr/R
         00URB8e4vplzHUQPZFvx6wfzwJygzCSUd4BJORnwDdL+RFqD0mVc9ntuuLkzoDPgKSqF
         RVYXK/JtAPg4gQfDu9Y+rOg4eVxyTG7RJQLzYXOcdFm/8uLEZl4xNGt4+nbRl6Lwd22z
         EBnRdzMVvH4vT7FI9wF+qxwEF9WIRcP7zvYTeW7Zb4EUgN6VoBJaeVnHcHhHu8DDl+4c
         RXJw==
X-Gm-Message-State: AOJu0YwPVNUCABZ6o1z0E9o0unRZ92c5yN1pGYEH3G2Bmu8JwFyVIgGp
	tulIWY2yBRV6nwtvuoqqZH3s67+Vrpa+81jWueHmxUBKqFUgIpLU75+h/3dUlA==
X-Gm-Gg: Acq92OGrlfFJGF9LZ4ZTSSwHyPk+pfVRlPUsQem6NTdciMeEjDVyS/7NgISkfRONmoB
	K33dDPlm3/GzKYVewsy7UlYasyPZvuLeMruKmP5wRLGfsQwT6icUovlt/LQZpHk2EfNIp3/l2Bh
	9uN5jUqvSpQq4+/gZ4w1yqWr2it6YqiM+iJW+b0jIKWMaUTAmGF0t1HYVCs585nGJiN5vhlHrSW
	UtiTd7K031U62qLBmAF5Pp9HjM9PjPW6OnObyaAvuSmM+zKl+zs+UplhCDaitLJopOn9I+PHiI5
	Lfopo85/57yT7uQIbPrt+btwHRwnnEYxmyFdnNHdXB7V4LmE1xJb8P56U7YFbPxEX3bU+EdrAC6
	iUy+8cTlWer3uqPRd8ZO6LGwC7f5rKo5KhWqMfBTTQdEt9KhyHLMccyzuOGVjS34ikSOgq8KFzf
	TqfZa/iOyJLF2j3O3edlpTCxrhsQs=
X-Received: by 2002:a05:6214:311e:b0:8ce:cbbc:3a3a with SMTP id 6a1803df08f44-8d44c4b5eb1mr163626916d6.8.1781524351616;
        Mon, 15 Jun 2026 04:52:31 -0700 (PDT)
Received: from [127.0.0.1] ([64.236.143.211])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d300f6b1c5sm113029906d6.3.2026.06.15.04.52.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 04:52:31 -0700 (PDT)
Message-Id: <pull.2137.v2.git.1781524349.gitgitgadget@gmail.com>
In-Reply-To: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Mon, 15 Jun 2026 11:52:22 +0000
Subject: [PATCH v2 0/7] More work supporting objects larger than 4GB on Windows
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
Cc: Kristofer Karlsson <krka@spotify.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series tries to address the problems pointed out by the expensive
tests that now run in CI: t5608 and t7508 verify various aspects about
objects larger than 4GB, which Git does not currently handle correctly when
run on a platform where size_t is 64-bit and unsigned long is 32-bit.

Changes vs v1:

 * Rebased onto master, which merged ps/odb-source-loose (with which these
   patches previously conflicted rather badly).
 * Removed superfluous size_t s variables (thanks, Patrick!).

Johannes Schindelin (7):
  compat/msvc: use _chsize_s for ftruncate
  patch-delta: use size_t for sizes
  pack-objects(check_pack_inflate()): use size_t instead of unsigned
    long
  packfile: widen unpack_entry()'s size out-parameter to size_t
  pack-objects: use size_t for in-core object sizes
  packfile,delta: drop the `cast_size_t_to_ulong()` wrappers
  odb: use size_t for object_info.sizep and the size APIs

 apply.c                       |  8 ++--
 archive.c                     |  4 +-
 attr.c                        |  2 +-
 bisect.c                      |  2 +-
 blame.c                       | 15 +++++--
 builtin/cat-file.c            | 61 ++++++++++++++---------------
 builtin/difftool.c            |  2 +-
 builtin/fast-export.c         |  7 +++-
 builtin/fast-import.c         | 29 ++++++++++----
 builtin/fsck.c                |  2 +-
 builtin/grep.c                | 12 +++---
 builtin/index-pack.c          | 10 ++---
 builtin/log.c                 |  2 +-
 builtin/ls-files.c            |  2 +-
 builtin/ls-tree.c             |  4 +-
 builtin/merge-tree.c          |  6 +--
 builtin/mktag.c               |  2 +-
 builtin/notes.c               |  6 +--
 builtin/pack-objects.c        | 73 +++++++++++++++++++++--------------
 builtin/repo.c                |  4 +-
 builtin/tag.c                 |  4 +-
 builtin/unpack-file.c         |  2 +-
 builtin/unpack-objects.c      |  8 ++--
 bundle.c                      |  2 +-
 combine-diff.c                |  4 +-
 commit.c                      | 10 ++---
 compat/msvc-posix.h           | 24 +++++++++++-
 config.c                      |  2 +-
 delta.h                       | 20 +++-------
 diff.c                        |  5 ++-
 dir.c                         |  2 +-
 entry.c                       |  4 +-
 fmt-merge-msg.c               |  4 +-
 fsck.c                        |  2 +-
 grep.c                        |  4 +-
 http-push.c                   |  2 +-
 list-objects-filter.c         |  2 +-
 mailmap.c                     |  2 +-
 match-trees.c                 |  4 +-
 merge-blobs.c                 |  6 +--
 merge-blobs.h                 |  2 +-
 merge-ort.c                   |  2 +-
 notes-cache.c                 |  2 +-
 notes-merge.c                 |  2 +-
 notes.c                       |  8 ++--
 object-file.c                 |  6 +--
 object.c                      |  2 +-
 odb.c                         | 12 +++---
 odb.h                         | 10 ++---
 odb/source-loose.c            | 12 +-----
 odb/streaming.c               | 13 +------
 pack-bitmap.c                 |  4 +-
 pack-check.c                  |  5 +--
 pack-objects.h                |  2 +-
 packfile.c                    | 54 ++++++++++----------------
 packfile.h                    |  5 ++-
 patch-delta.c                 |  8 ++--
 path-walk.c                   |  2 +-
 protocol-caps.c               |  5 ++-
 read-cache.c                  |  6 +--
 ref-filter.c                  |  2 +-
 reflog.c                      |  2 +-
 rerere.c                      |  2 +-
 submodule-config.c            |  2 +-
 t/helper/test-delta.c         | 10 +++--
 t/helper/test-pack-deltas.c   |  3 +-
 t/helper/test-partial-clone.c |  2 +-
 t/unit-tests/u-odb-inmemory.c |  2 +-
 tag.c                         |  4 +-
 tree-walk.c                   | 10 +++--
 tree.c                        |  2 +-
 xdiff-interface.c             |  2 +-
 72 files changed, 300 insertions(+), 271 deletions(-)


base-commit: ea97ad8d017de0c9037451a78008a0fd60abea0c
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2137%2Fdscho%2Fobjects-larger-than-4gb-on-windows-pt2-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2137/dscho/objects-larger-than-4gb-on-windows-pt2-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/2137

Range-diff vs v1:

 1:  de9fc5c455 = 1:  531bca775c compat/msvc: use _chsize_s for ftruncate
 2:  1fd7646ca1 = 2:  66a642c39e patch-delta: use size_t for sizes
 3:  ddb75326cd = 3:  271a5299e3 pack-objects(check_pack_inflate()): use size_t instead of unsigned long
 4:  bdebc36f21 = 4:  5c329535df packfile: widen unpack_entry()'s size out-parameter to size_t
 5:  68750ba2d1 = 5:  01b9209b26 pack-objects: use size_t for in-core object sizes
 6:  460d733fee = 6:  12c142f8ab packfile,delta: drop the `cast_size_t_to_ulong()` wrappers
 7:  f3aeae983a ! 7:  37d030d867 odb: use size_t for object_info.sizep and the size APIs
     @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
       	struct object_info oi = OBJECT_INFO_INIT;
       	unsigned flags = OBJECT_INFO_LOOKUP_REPLACE;
      @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
     - 		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
     - 			size_t s = size;
     - 			buf = replace_idents_using_mailmap(buf, &s);
     + 		if (odb_read_object_info_extended(the_repository->objects, &oid, &oi, flags) < 0)
     + 			die("git cat-file: could not get object info");
     + 
     +-		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
     +-			size_t s = size;
     +-			buf = replace_idents_using_mailmap(buf, &s);
      -			size = cast_size_t_to_ulong(s);
     -+			size = s;
     - 		}
     +-		}
     ++		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG))
     ++			buf = replace_idents_using_mailmap(buf, &size);
       
       		printf("%"PRIuMAX"\n", (uintmax_t)size);
     + 		ret = 0;
      @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
       		break;
       
     @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const
       
       	case 'p':
      @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
     - 		if (use_mailmap) {
     - 			size_t s = size;
     - 			buf = replace_idents_using_mailmap(buf, &s);
     + 		if (!buf)
     + 			die("Cannot read object %s", obj_name);
     + 
     +-		if (use_mailmap) {
     +-			size_t s = size;
     +-			buf = replace_idents_using_mailmap(buf, &s);
      -			size = cast_size_t_to_ulong(s);
     -+			size = s;
     - 		}
     +-		}
     ++		if (use_mailmap)
     ++			buf = replace_idents_using_mailmap(buf, &size);
       
       		/* otherwise just spit out the data */
     + 		break;
      @@ builtin/cat-file.c: static int cat_one_file(int opt, const char *exp_type, const char *obj_name)
     - 		if (use_mailmap) {
     - 			size_t s = size;
     - 			buf = replace_idents_using_mailmap(buf, &s);
     + 		buf = odb_read_object_peeled(the_repository->objects, &oid,
     + 					     exp_type_id, &size, NULL);
     + 
     +-		if (use_mailmap) {
     +-			size_t s = size;
     +-			buf = replace_idents_using_mailmap(buf, &s);
      -			size = cast_size_t_to_ulong(s);
     -+			size = s;
     - 		}
     +-		}
     ++		if (use_mailmap)
     ++			buf = replace_idents_using_mailmap(buf, &size);
       		break;
       	}
     + 	default:
      @@ builtin/cat-file.c: cleanup:
       struct expand_data {
       	struct object_id oid;
     @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, s
       
       		contents = odb_read_object(the_repository->objects, oid,
      @@ builtin/cat-file.c: static void print_object_or_die(struct batch_options *opt, struct expand_data *d
     - 		if (use_mailmap) {
     - 			size_t s = size;
     - 			contents = replace_idents_using_mailmap(contents, &s);
     + 		if (!contents)
     + 			die("object %s disappeared", oid_to_hex(oid));
     + 
     +-		if (use_mailmap) {
     +-			size_t s = size;
     +-			contents = replace_idents_using_mailmap(contents, &s);
      -			size = cast_size_t_to_ulong(s);
     -+			size = s;
     - 		}
     +-		}
     ++		if (use_mailmap)
     ++			contents = replace_idents_using_mailmap(contents, &size);
       
       		if (type != data->type)
     + 			die("object %s changed type!?", oid_to_hex(oid));
      @@ builtin/cat-file.c: static void batch_object_write(const char *obj_name,
     + 		}
     + 
     + 		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
     +-			size_t s = data->size;
     + 			char *buf = NULL;
     + 
     + 			buf = odb_read_object(the_repository->objects, &data->oid,
     + 					      &data->type, &data->size);
       			if (!buf)
       				die(_("unable to read %s"), oid_to_hex(&data->oid));
     - 			buf = replace_idents_using_mailmap(buf, &s);
     +-			buf = replace_idents_using_mailmap(buf, &s);
      -			data->size = cast_size_t_to_ulong(s);
     -+			data->size = s;
     ++			buf = replace_idents_using_mailmap(buf, &data->size);
       
       			free(buf);
       		}
     @@ builtin/log.c: static int show_blob_object(const struct object_id *oid, struct r
      
       ## builtin/ls-files.c ##
      @@ builtin/ls-files.c: static void expand_objectsize(struct repository *repo, struct strbuf *line,
     - 			      const enum object_type type, unsigned int padded)
     - {
     + 	size_t len;
     + 
       	if (type == OBJ_BLOB) {
      -		unsigned long size;
      +		size_t size;
     @@ builtin/ls-files.c: static void expand_objectsize(struct repository *repo, struc
      
       ## builtin/ls-tree.c ##
      @@ builtin/ls-tree.c: static void expand_objectsize(struct strbuf *line, const struct object_id *oid,
     - 			      const enum object_type type, unsigned int padded)
     - {
     + 	size_t len;
     + 
       	if (type == OBJ_BLOB) {
      -		unsigned long size;
      +		size_t size;
     @@ notes.c: static void format_note(struct notes_tree *t, const struct object_id *o
       	if (!t)
      
       ## object-file.c ##
     -@@ object-file.c: static int parse_loose_header(const char *hdr, struct object_info *oi)
     +@@ object-file.c: int parse_loose_header(const char *hdr, struct object_info *oi)
       	}
       
       	if (oi->sizep)
     @@ object-file.c: static int parse_loose_header(const char *hdr, struct object_info
       
       	/*
       	 * The length must be followed by a zero byte
     -@@ object-file.c: static int read_object_info_from_path(struct odb_source *source,
     - 	void *map = NULL;
     - 	git_zstream stream, *stream_to_end = NULL;
     - 	char hdr[MAX_HEADER_LEN];
     --	unsigned long size_scratch;
     -+	size_t size_scratch;
     - 	enum object_type type_scratch;
     - 	struct stat st;
     - 
      @@ object-file.c: int force_object_loose(struct odb_source *source,
     - {
     + 	struct odb_source_files *files = odb_source_files_downcast(source);
       	const struct git_hash_algo *compat = source->odb->repo->compat_hash_algo;
       	void *buf;
      -	unsigned long len;
     @@ object-file.c: int read_loose_object(struct repository *repo,
       
       	fd = git_open(path);
       	if (fd >= 0)
     -@@ object-file.c: int odb_source_loose_read_object_stream(struct odb_read_stream **out,
     - 	struct object_info oi = OBJECT_INFO_INIT;
     - 	struct odb_loose_read_stream *st;
     - 	unsigned long mapsize;
     --	unsigned long size_ul;
     - 	void *mapped;
     - 
     - 	mapped = odb_source_loose_map_object(source, oid, &mapsize);
     -@@ object-file.c: int odb_source_loose_read_object_stream(struct odb_read_stream **out,
     - 		goto error;
     - 	}
     - 
     --	/*
     --	 * object_info.sizep is unsigned long* (32-bit on Windows), but
     --	 * st->base.size is size_t (64-bit). Use temporary variable.
     --	 * Note: loose objects >4GB would still truncate here, but such
     --	 * large loose objects are uncommon (they'd normally be packed).
     --	 */
     --	oi.sizep = &size_ul;
     -+	oi.sizep = &st->base.size;
     - 	oi.typep = &st->base.type;
     - 
     - 	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
     - 		goto error;
     --	st->base.size = size_ul;
     - 
     - 	st->mapped = mapped;
     - 	st->mapsize = mapsize;
      
       ## object.c ##
      @@ object.c: struct object *parse_object_with_flags(struct repository *r,
     @@ odb.h: int odb_read_object_info_extended(struct object_database *odb,
       enum odb_has_object_flags {
       	/* Retry packed storage after checking packed and loose storage */
      
     + ## odb/source-loose.c ##
     +@@ odb/source-loose.c: static int read_object_info_from_path(struct odb_source_loose *loose,
     + 	void *map = NULL;
     + 	git_zstream stream, *stream_to_end = NULL;
     + 	char hdr[MAX_HEADER_LEN];
     +-	unsigned long size_scratch;
     ++	size_t size_scratch;
     + 	enum object_type type_scratch;
     + 	struct stat st;
     + 
     +@@ odb/source-loose.c: static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
     + 	struct object_info oi = OBJECT_INFO_INIT;
     + 	struct odb_loose_read_stream *st;
     + 	unsigned long mapsize;
     +-	unsigned long size_ul;
     + 	void *mapped;
     + 
     + 	mapped = odb_source_loose_map_object(loose, oid, &mapsize);
     +@@ odb/source-loose.c: static int odb_source_loose_read_object_stream(struct odb_read_stream **out,
     + 		goto error;
     + 	}
     + 
     +-	/*
     +-	 * object_info.sizep is unsigned long* (32-bit on Windows), but
     +-	 * st->base.size is size_t (64-bit). Use temporary variable.
     +-	 * Note: loose objects >4GB would still truncate here, but such
     +-	 * large loose objects are uncommon (they'd normally be packed).
     +-	 */
     +-	oi.sizep = &size_ul;
     ++	oi.sizep = &st->base.size;
     + 	oi.typep = &st->base.type;
     + 
     + 	if (parse_loose_header(st->hdr, &oi) < 0 || st->base.type < 0)
     + 		goto error;
     +-	st->base.size = size_ul;
     + 
     + 	st->mapped = mapped;
     + 	st->mapsize = mapsize;
     +
       ## odb/streaming.c ##
      @@ odb/streaming.c: static int open_istream_incore(struct odb_read_stream **out,
       		.base.read = read_istream_incore,

-- 
gitgitgadget
