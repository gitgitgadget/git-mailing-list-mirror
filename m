Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B495A399007
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 10:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570278; cv=none; b=hgwQRqaF0fBwMekIW5Xq274PhS45mvr+bWsjU6iVW9NwwaC8VGhMhkoyhM1r3yIpAkZYJ8aLf3CzIsbx0mVA5D5uuM6lE4TZK/n4XDo7AfcX48Qh8vJhK6c5lOFOAsogJgMpalrB78F8IvH6zACTL+SwAKDgt/166+hak0k0/sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570278; c=relaxed/simple;
	bh=W6xOTXl2bFVirq8ugHFT/75EHhLK/GfxMKbnRXNDvzg=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=URR4asuaZf94zTtmWSP/CeJyuHWUAuTzJCEAO6U9gDsM8BV/KsTTz9cQYhI+lU7IFREt2cUGa4Yxm6wk+7D6nK3PGSMbQ/6BU4okud18xcyaJV7RacOCdIXoz1Zg6J2sJf450+l+Fm5/AazuP0hmVxDWfJiphM1gDKIXnySD0cA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g8MyXvhY; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g8MyXvhY"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-304545f5206so644955eec.0
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 03:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780570276; x=1781175076; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4Mtb08vPN8Q7D2/Glhku1lXRDYaYjPSPMSCkQoYTOAs=;
        b=g8MyXvhYlCJBMpra7dOkpNPlRcPtOt1ZnXnCqY746NhvyHS46iF1Q5BX0V0Y4u44et
         DAggf0fKS/nXfhff3NwuzdmiRoRPygNl/+2XYDkhOsaUWXnD1JA2hrcUGFynWVUQFeWh
         Q0/CgJscEIUU7F2PENzP+Axd3I2Y1xUPr40gF5vOyKKO/xsEgd9wHr3AueOrL3Q4+Mmf
         oN5j8nFr978hL2JodIeqKyDLIsraXxKulBfRnHsMiB39EZu4juhGi9opH1CsmN84lYC3
         ysd/q73l9eVdYgNs5uHeNw6w4nx/N8tk995+SNFbV/jFnMpnOpDwgPw9BpUj92DDSSWO
         +cEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780570276; x=1781175076;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Mtb08vPN8Q7D2/Glhku1lXRDYaYjPSPMSCkQoYTOAs=;
        b=PZZ6DfYhsm0iJefu7iw8A8a4vjIcomTVS3ROxKirZ6Z1LhHjT8gMctbQTX2FhT9uaL
         6FGDBi6cxUU+LbJUOCfyfkf5w3HdqkeOJ5rFelRiUC0+LJ9+oKITTJGWJwZv+UAZV5ei
         5wawqMHuoHXclCoHGExqb95u0AqDyVt9dNugIGiCCtoKULiSu5eGxA6QSY/MaXwpBcru
         3IJwlVakvTs+9EmBYpiCSn33qV6AR+1SbEq8zUdcd8pr5LBgeCOJhxvkuD1Kr7qzPvGb
         4QFg43fEOlSENhhsSaF9MtpLfPsvwvBDiQHlk6UHOLa5WrNiNhTQiNvpSAt/q+3cww2K
         3oFQ==
X-Gm-Message-State: AOJu0YzcFrweaDEQG0MOIdlRAZ9HEcicGzsVZSSe4irU2SdHG/wueFrI
	eBA19bw09UkonyUNm4QzgpTCKI3RQKsXLH/8kpO2erhkMeKVUxcMU8RG//s2qg==
X-Gm-Gg: Acq92OFYldZleqvWgBZG2bBiTjEV2EKUBjX98HEbEFw6xyPoHIcuYvsA6ujYGMqbfcA
	XRqx+7T5uTl68vusbo0hL10czqw3JidX3peZm4qzHTOjEdMJD+OkUlUQWW/M1zKB01UZ3srMlCs
	nBDLJ6v+7yzQn5tubqmnVgUcRLkU/iYlgafiAiXnXAGdm5WhXLUJLsTxbsfVOtUxkagk0mKtDGi
	UdNd/TgEPe7HUgGnh2c/MBgtUCYrdytou7dxqL6WB7U8aAQlXNkwYVI3ay1Bi4Sf0egvapA9gSQ
	Ofl+QOCuoZkas8xgxLizPy8Lb8mKQVt5uHKXZMrpm+rMx1+eJlWQwDosJ4KNQAezeR/hVSkmzqv
	i3e5rzXwRZtHHudw4Gcihn4zwqQ+ukB/8XOC0Bug5TTusUQqrUPWIBVJKpUGBp0FdZR1P+64N3w
	K7ncLSZrerOTLLwYdQpzAhi857x5NqDugntroviKQYMvfQUXLg
X-Received: by 2002:a05:7300:dc92:b0:304:b93a:511a with SMTP id 5a478bee46e88-3074fbd5411mr2991720eec.28.1780570275636;
        Thu, 04 Jun 2026 03:51:15 -0700 (PDT)
Received: from [127.0.0.1] ([172.182.209.49])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3074dba9d43sm4403453eec.10.2026.06.04.03.51.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 03:51:14 -0700 (PDT)
Message-Id: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 04 Jun 2026 10:51:05 +0000
Subject: [PATCH 0/7] More work supporting objects larger than 4GB on Windows
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
    Johannes Schindelin <johannes.schindelin@gmx.de>

This patch series tries to address the problems pointed out by the expensive
tests that now run in CI: t5608 and t7508 verify various aspects about
objects larger than 4GB, which Git does not currently handle correctly when
run on a platform where size_t is 64-bit and unsigned long is 32-bit.

Unfortunately, this conflicts heavily with ps/odb-source-loose. I rebased
the branch onto seen and pushed the result to
https://github.com/dscho/git/tree/refs/heads/objects-larger-than-4gb-on-windows-pt2-seen,
to make it easier to resolve merge conflicts. Here is the relevant
range-diff:

1:  f3aeae983a ! 1:  62adeb9818 odb: use size_t for object_info.sizep and the size APIs
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
 builtin/cat-file.c            | 39 ++++++++++++-------
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
 object-file.c                 | 18 +++------
 object.c                      |  2 +-
 odb.c                         | 12 +++---
 odb.h                         | 10 ++---
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
 71 files changed, 296 insertions(+), 253 deletions(-)


base-commit: 9ac3f193c05c2237e2b14ebaa1149e9fc8a1abe0
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2137%2Fdscho%2Fobjects-larger-than-4gb-on-windows-pt2-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2137/dscho/objects-larger-than-4gb-on-windows-pt2-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2137
-- 
gitgitgadget
