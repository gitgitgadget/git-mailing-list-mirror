Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167A6449B1A
	for <git@vger.kernel.org>; Wed,  2 Sep 2026 13:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356108; cv=none; b=sZJsvK7nIXYTX/NKWDtI2VRxCM2So76GoTFBXAFtLzVymNiJWR7G4CEZ2b+bEwTpmFLtIhXTwRtuEHSpBcv1sX7wVaVlg2+LSGcu/oPglua9r2eJ8KcvcEYvy0L4l6SKu3fwNSltpmzQI8f8rhdHyyxJoiJRHsrBBOLCNabatyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356108; c=relaxed/simple;
	bh=wKZT3LD54UvP2br+1R2sGr9KGjEUV+lvkjtc4WR3W3U=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:
	 In-Reply-To:References:To:Cc; b=HqbBqVLq5/rsQXDxNtBF6xMus5adisrYie5car05ZJRPlGfbxLQWnlrVbs9Y6V6RhG24eCKTVubbZf3dY388nQahTls2vWnB2Ux3jX+cAGWVsbdLyujuJF7DxH3Mnuzj1oD4cd+sWzKZ1XN76reffsUm3u2f0ocb25qD32/q+MI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=w9mSegE+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8wjlP89; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="w9mSegE+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8wjlP89"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id BEA8F7A0126;
	Wed,  2 Sep 2026 09:35:03 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 02 Sep 2026 09:35:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1788356103;
	 x=1788442503; bh=z7DE/RugGijotYllLnpdeyziLmF7be/RO11fxd4ilx4=; b=
	w9mSegE+qqtJHh3A1JhI9Mjn0CZz0saTJMbVoREvM5v+1iQRhq7xvHZESYdIbaC0
	7QpqEujos2njg7YjcOjMNGCN6ARxeDWDR/r73c8A1ZeWsV875lXGEvWAlij4VLhE
	vq/JlAkptgkLEYVkaoWIaHARfQvHf0BfqZ5hpoR6sKCpypGcoIVwU6HWjgviVYk9
	2H1XqCmTNOlLf1SE/s6UcoV/GoeFtcT1VBZRHjgvih7e7GH1iX91O8VRz5elVvi3
	TJHmWUDVUxEN89OzD3n0qdGunZ8zKpWzXLfPQr00ozbKmbTguo7211YDeeTh+NYo
	xbRvIYvMxHsiNLXA/S8I6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1788356103; x=
	1788442503; bh=z7DE/RugGijotYllLnpdeyziLmF7be/RO11fxd4ilx4=; b=i
	8wjlP89g4P1ngoMGgzzOz7JqqqDMuK/OtKRLRACLYht7+NvtxwWnE4/IJSb4PvOC
	rC2Z+UfzXfWrOogcvrbq+2HQYAoT5LHK6IpSb4Jv8zyDaJDWvwyAKuPwVSv+r1Q9
	y2l942inIlO4P7QPHh+OPp+F5bxUU1U3bNeHauWncgt/w7f+9bmfE6lBHmFTiwWd
	aIshc19Aik/rdDDpcgaELjH5HcoGtnsw/HVMDA/M4aTZeVE0fkN5cfLUa2t3Mnfu
	di5rpX/kulmMZL3KZqHi7p0iaF+Zl8cnxOoGP0h13gW2VYqqZc5MAGhfyv5i+6gf
	m45zOs1RdpzuU/nb40TzA==
X-ME-Sender: <xms:ByaYagFrFVZ8Pr1uWDRcobQv02ofM9D_YhY21t7QYyuWspDXyP2H2A>
    <xme:ByaYavUUwUDNqfmCXesCHT9S_1AfqWCONb-aIp4b2_-5BRD5_Rn5x4nnQbMCXUO1U
    pIYVJLT4SvcynNAdPeIilZCg7MREK4XL4WiJAWaVe0w4WDLf4cJjk4>
X-ME-Received: <xmr:ByaYanwALwfAMBg0Jeq80fZmIikjMr22MDv3zDcjpNgg4Xnut4DCrOLI3Hk1KqS_rBWk-FU>
X-ME-Proxy-Cause: dmFkZTFDJIjCNgWtAyh5/vcuHgugFNLLp/jc1QCYr29zyC91U2D13/xnGmBtUxETlhA9Ul
    p56cmeMSUkmW7Gs0eYlRMuMrSQ07cjOyw0kG1MFXB0wIdmPQMGXJmo/AGzCtV8X9RQBJUS
    55cyF4/gbwoA2SwWg8r6n2oAyniBaVy+ldZorD5fg7uYuwZ5yBhQwFI8Q+Mr658bQ8UJRs
    JQ1C39kt0cQvayNhP+O0eGQ2ckg9wuycSeqCIFtzfyV7VBN6oE5anBOzF/1nzwOAE9xKCz
    CQlKFn1ld4K2dJgtTqbQswikMuBg7TbVGdFvEuMkDzZl4JX+CBKZ7vl3O9YoQmBsvt+uap
    723mzxolqoFTxhJm5cNu6/50ip0X2uFZUAEbfBliIJAzxGsYymCZa2MfS6z60u9CRMNi2m
    QSP8vVHQIEQPkiRRD1YbQplWnuDGpfuDzo2ONWTdMvGzMB9Zr9F2bBIypithOUyhse6HFL
    JYocxKnH2whVOsKWVfAcMdpH2octepOoIG7KXO/PMOnDvNVPuDVrwYtfER5PlYyPbsXx/j
    ISrCJNIVv95/vHzjaJR+xKNzqsqsNpLlGwxhBgTVuHgfM6LEzgTZL3F/ZpPQcs9ZNMT+1U
    ckcnJ4YbrxrcaUyU6hw8Iypp4ORjPCI/s0x18xhblUsUcPUCFh+fsHv3vLiQ
X-ME-Proxy: <xmx:ByaYatPlnGuPvB-hzYLuzK0649pC4bfct8M2glWmPXhK9tVyhHNzBA>
    <xmx:ByaYao7qk4qKtRDfgoGxquKlvVqkar3iJ4F8duwyM_rlC4DO28puHA>
    <xmx:ByaYauNdNuJ_FG1DFlv18zz7Z3kzuzWnQYKxns3sKQj9n7aR2E_1XQ>
    <xmx:ByaYammeWGyQ-897Bg_aMfy23KfdJmFLNTvX5nfyQqi1-Xfqv7S1gw>
    <xmx:ByaYarcNaY0LPVqgFj03mZ_Zk6Og-Nstn6n6wWxycvZA9sXNIQpqBdzK>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Sep 2026 09:35:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3da9d759 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Sep 2026 13:35:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Subject: [PATCH v2 00/13] odb: stop registering in-memory sources
Date: Wed, 02 Sep 2026 15:34:48 +0200
Message-Id: <20260902-pks-odb-registering-in-memory-sources-v2-0-c6ca12fdea4d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/42OTQ6DIBSEr2JY9zWAxZ+ueo/GhcJTaSMYnpo2x
 rsX9QJdTjLzfbMywmCR2D1ZWcDFkvUuBnlJmO5r1yFYEzOTXGa8EALGN4E3DQTsLE1x7DqwDgY
 cfPgC+TloJCiK7FZoU6o8VSyyxoCt/RyeZ3VmmpsX6mmH740+0iLhOLKIvXc6S/6vcxHAoczrV
 Eij2lqqR9xd7cCqbdt+QBSGu+kAAAA=
X-Change-ID: 20260811-pks-odb-registering-in-memory-sources-88648cd95735
In-Reply-To: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
References: <20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.15.2

Hi,

the object database has a list of sources that is used for two
different purposes:

  - We use it to track the list of alternates.

  - We use it to track temporary in-memory sources that we create for
    various purposes. Most importantly, this is used to link object
    database sources from submodules into the main store.

This dual-use is quite awkward, as it mixes two different levels of
concerns and thus as a consequence makes both harder to reason about.
It's also a source of bugs: we make assumptions about the ordering of
sources all over the place, and we furthermore assume in other places
that the sources only contain alternates in the first place. I don't
think this surfaces in the form of real bugs, but I've long disliked
this dual-use.

Furthermore, we want to migrate handling of alternates into the "files"
backend itself in a subsequent patch series. This is most importantly to
fix a performance regression by making the backend own all of its
alternates, but it also fixes a couple of longer-standing design issues
that I've been struggling with [1].

Most importantly though: this whole machinery is not even needed at all.
A couple years ago we have already refactored our codebase so that
submodule sources don't even have to be linked into the main object
database anymore. And all the other use cases where we link sources into
the main object database can be trivially converted, too.

So this patch series does exactly that: it removes the mechanism to link
ad-hoc sources into the object database entirely. This ensures that the
list of sources is exactly the list of alternates, and that makes it
easier to move them into the "files" backend in a subsequent patch
series.

There is one exception though: creating transactions still creates a
temporary quarantine directory. This mechanism is left as-is for now,
but as it's an implementation detail of the "files" backend anyway
that's not conflicting with our above stated goals.

This series is built on top of 1630431f32 (The 21st batch, 2026-08-31)
with ty/repository-fetch-if-missing at 508ec9837c (repository: move
fetch_if_missing into struct repository, 2026-08-15) merged into it.
There's still two merge conflicts, but these are trivial to resolve: in
"odb.c" and "odb.h" you simply remove both ours and theirs, and in
"builtin/multi-pack-index.c" you only need to munge the parameters a
bit.

Changes in v2:
  - Adapt `cache_tree_fully_valid()` to take a `struct index_state` as
    input instead of taking both a repository and a cache tree, as
    suggested by Junio.
  - Link to v1: https://patch.msgid.link/20260901-pks-odb-registering-in-memory-sources-v1-0-97a312d5fa25@pks.im

Thanks!

Patrick

[1]: <amLgMqkqxR8mKIbT@pks.im>

---
Patrick Steinhardt (13):
      cache-tree: drop `the_repository` in `cache_tree_fully_valid()`
      cache-tree: remove dependency on `the_repository`
      submodule-config: remove uses of `the_repository`
      submodule-config: stop using `the_hash_algo`
      submodule-config: stop registering submodule sources
      builtin/grep: stop registering submodule ODB as source
      odb: remove infrastructure to register submodule sources
      tmp-objdir: drop unused function to register alternate
      odb/packed: fix memory leaks when freeing source
      builtin/multi-pack-index: refuse unknown sources with "--object-dir="
      t/helper: adapt read-midx to not link ad-hoc source anymore
      t/helper: stop registering alternates in "ref-store" command
      odb: remove the ability to link sources ad-hoc

 builtin/checkout.c                     |  2 +-
 builtin/commit.c                       |  2 +-
 builtin/fetch.c                        |  2 +-
 builtin/grep.c                         | 28 +++-------
 builtin/multi-pack-index.c             |  3 +-
 builtin/submodule--helper.c            |  8 +--
 cache-tree.c                           | 95 +++++++++++++++++++---------------
 cache-tree.h                           |  7 +--
 odb.c                                  | 42 ---------------
 odb.h                                  | 22 --------
 odb/source-packed.c                    |  1 +
 read-cache-ll.h                        |  5 +-
 read-cache.c                           |  9 ++--
 sequencer.c                            |  2 +-
 sparse-index.c                         |  2 +-
 submodule-config.c                     | 59 +++++++++++----------
 submodule-config.h                     | 12 +++--
 submodule.c                            |  2 +-
 t/README                               |  7 ---
 t/helper/test-read-midx.c              | 43 ++++++++++-----
 t/helper/test-ref-store.c              |  8 ---
 t/helper/test-submodule.c              |  4 +-
 t/t5319-multi-pack-index.sh            |  9 ++--
 t/t5526-fetch-submodules.sh            |  3 --
 t/t5531-deep-submodule-push.sh         |  3 --
 t/t5545-push-options.sh                |  3 --
 t/t5572-pull-submodule.sh              |  3 --
 t/t6437-submodule-merge.sh             |  3 --
 t/t7418-submodule-sparse-gitmodules.sh |  3 --
 t/t7814-grep-recurse-submodules.sh     |  3 --
 tmp-objdir.c                           |  5 --
 tmp-objdir.h                           |  6 ---
 unpack-trees.c                         |  9 ++--
 33 files changed, 168 insertions(+), 247 deletions(-)

Range-diff versus v1:

 -:  ---------- >  1:  4870d0661d cache-tree: drop `the_repository` in `cache_tree_fully_valid()`
 1:  a4e2648526 !  2:  755652bfe1 cache-tree: remove dependency on `the_repository`
    @@ Commit message
     
         Signed-off-by: Patrick Steinhardt <ps@pks.im>
     
    - ## builtin/checkout.c ##
    -@@ builtin/checkout.c: static int merge_working_tree(const struct checkout_opts *opts,
    - 		}
    - 	}
    - 
    --	if (!cache_tree_fully_valid(the_repository->index->cache_tree))
    -+	if (!cache_tree_fully_valid(the_repository, the_repository->index->cache_tree))
    - 		cache_tree_update(the_repository->index, WRITE_TREE_SILENT | WRITE_TREE_REPAIR);
    - 
    - 	if (write_locked_index(the_repository->index, &lock_file, COMMIT_LOCK))
    -
    - ## builtin/commit.c ##
    -@@ builtin/commit.c: static const char *prepare_index(const char **argv, const char *prefix,
    - 				       LOCK_DIE_ON_ERROR);
    - 		refresh_cache_or_die(refresh_flags);
    - 		if (the_repository->index->cache_changed
    --		    || !cache_tree_fully_valid(the_repository->index->cache_tree))
    -+		    || !cache_tree_fully_valid(the_repository, the_repository->index->cache_tree))
    - 			cache_tree_update(the_repository->index, WRITE_TREE_SILENT);
    - 		if (write_locked_index(the_repository->index, &index_lock,
    - 				       COMMIT_LOCK | SKIP_IF_UNCHANGED))
    -
      ## cache-tree.c ##
     @@
     -#define USE_THE_REPOSITORY_VARIABLE
      #define DISABLE_SIGN_COMPARE_WARNINGS
      
      #include "git-compat-util.h"
    -@@ cache-tree.c: static void discard_unused_subtrees(struct cache_tree *it)
    - 	}
    - }
    - 
    --int cache_tree_fully_valid(struct cache_tree *it)
    -+int cache_tree_fully_valid(struct repository *repo, struct cache_tree *it)
    - {
    - 	int i;
    - 	if (!it)
    - 		return 0;
    - 	if (it->entry_count < 0 ||
    --	    !odb_has_object(the_repository->objects, &it->oid,
    -+	    !odb_has_object(repo->objects, &it->oid,
    - 			    ODB_HAS_OBJECT_RECHECK_PACKED | ODB_HAS_OBJECT_FETCH_PROMISOR))
    - 		return 0;
    - 	for (i = 0; i < it->subtree_nr; i++) {
    --		if (!cache_tree_fully_valid(it->down[i]->cache_tree))
    -+		if (!cache_tree_fully_valid(repo, it->down[i]->cache_tree))
    - 			return 0;
    - 	}
    - 	return 1;
    +@@ cache-tree.c: int cache_tree_fully_valid(struct index_state *istate)
    + 						istate->cache_tree);
      }
      
     -static int must_check_existence(const struct cache_entry *ce)
    @@ cache-tree.c: static struct cache_tree *read_one(const char **buffer, unsigned l
      
      	return result;
      }
    -@@ cache-tree.c: struct tree *write_in_core_index_as_tree(struct repository *repo,
    - 	int was_valid, ret;
    - 
    - 	was_valid = index_state->cache_tree &&
    --		    cache_tree_fully_valid(index_state->cache_tree);
    -+		    cache_tree_fully_valid(repo, index_state->cache_tree);
    - 
    - 	ret = write_index_as_tree_internal(&o, index_state, was_valid, 0, NULL);
    - 	if (ret == WRITE_TREE_UNMERGED_INDEX) {
     @@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
      	hold_lock_file_for_update(&lock_file, index_path, LOCK_DIE_ON_ERROR);
      
    @@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state
      	if (entries < 0) {
      		ret = WRITE_TREE_UNREADABLE_INDEX;
      		goto out;
    -@@ cache-tree.c: int write_index_as_tree(struct object_id *oid, struct index_state *index_state,
    - 
    - 	was_valid = !(flags & WRITE_TREE_IGNORE_CACHE_TREE) &&
    - 		    index_state->cache_tree &&
    --		    cache_tree_fully_valid(index_state->cache_tree);
    -+		    cache_tree_fully_valid(index_state->repo, index_state->cache_tree);
    - 
    - 	ret = write_index_as_tree_internal(oid, index_state, was_valid, flags,
    - 					   prefix);
     @@ cache-tree.c: static void prime_cache_tree_rec(struct repository *r,
      			struct cache_tree_sub *sub;
      			struct tree *subtree = lookup_tree(r, &entry.oid);
    @@ cache-tree.h: struct cache_tree_sub *cache_tree_sub(struct cache_tree *, const c
     +struct cache_tree *cache_tree_read(struct repository *repo,
     +				   const char *buffer, unsigned long size);
      
    --int cache_tree_fully_valid(struct cache_tree *);
    -+int cache_tree_fully_valid(struct repository *, struct cache_tree *);
    + int cache_tree_fully_valid(struct index_state *);
      int cache_tree_update(struct index_state *, int);
    - int cache_tree_verify(struct repository *, struct index_state *);
    - 
     
      ## read-cache-ll.h ##
     @@ read-cache-ll.h: void validate_cache_entries(const struct index_state *istate);
    @@ read-cache.c: void prefetch_cache_entries(const struct index_state *istate,
      		if (!odb_read_object_info_extended(the_repository->objects,
      						   &ce->oid, NULL,
     
    - ## sequencer.c ##
    -@@ sequencer.c: static int do_recursive_merge(struct repository *r,
    - 
    - static struct object_id *get_cache_tree_oid(struct index_state *istate)
    - {
    --	if (!cache_tree_fully_valid(istate->cache_tree))
    -+	if (!cache_tree_fully_valid(istate->repo, istate->cache_tree))
    - 		if (cache_tree_update(istate, 0)) {
    - 			error(_("unable to update cache tree"));
    - 			return NULL;
    -
    - ## sparse-index.c ##
    -@@ sparse-index.c: int convert_to_sparse(struct index_state *istate, int flags)
    - 	if (index_has_unmerged_entries(istate))
    - 		return 0;
    - 
    --	if (!cache_tree_fully_valid(istate->cache_tree)) {
    -+	if (!cache_tree_fully_valid(istate->repo, istate->cache_tree)) {
    - 		/* Clear and recompute the cache-tree */
    - 		cache_tree_free(&istate->cache_tree);
    - 
    -
      ## unpack-trees.c ##
     @@ unpack-trees.c: static void report_collided_checkout(struct index_state *index)
      	string_list_clear(&list, 0);
    @@ unpack-trees.c: static int check_updates(struct unpack_trees_options *o,
      			size_t last_pc_queue_size = pc_queue_size();
      
      			if (ce->ce_flags & CE_WT_REMOVE)
    -@@ unpack-trees.c: int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
    - 			}
    - 
    - 			if (!o->skip_cache_tree_update &&
    --			    !cache_tree_fully_valid(o->internal.result.cache_tree))
    -+			    !cache_tree_fully_valid(the_repository, o->internal.result.cache_tree))
    - 				cache_tree_update(&o->internal.result,
    - 						  WRITE_TREE_SILENT |
    - 						  WRITE_TREE_REPAIR);
 2:  bedb614b5c =  3:  46bbe548a6 submodule-config: remove uses of `the_repository`
 3:  8fa02cdd5c =  4:  65f8634bda submodule-config: stop using `the_hash_algo`
 4:  ebf1dfb548 =  5:  4faf4fdd57 submodule-config: stop registering submodule sources
 5:  dfe1a212f7 =  6:  dee5aca311 builtin/grep: stop registering submodule ODB as source
 6:  1644e49419 =  7:  2ce128799a odb: remove infrastructure to register submodule sources
 7:  3f3ccfba74 =  8:  0a174f6304 tmp-objdir: drop unused function to register alternate
 8:  f1341b797b =  9:  d22c376cd2 odb/packed: fix memory leaks when freeing source
 9:  c1f6d9ebdd = 10:  09405ade4c builtin/multi-pack-index: refuse unknown sources with "--object-dir="
10:  c5b9c1c96e = 11:  557b3ab923 t/helper: adapt read-midx to not link ad-hoc source anymore
11:  3f43f73cd8 = 12:  78b26c172a t/helper: stop registering alternates in "ref-store" command
12:  4c670d726f = 13:  1ca49caf1c odb: remove the ability to link sources ad-hoc

---
base-commit: e5d60560f61f520e9ea350645a6cc9770b0f1607
change-id: 20260811-pks-odb-registering-in-memory-sources-88648cd95735

