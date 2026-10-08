Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05A03F1071
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791453145; cv=none; b=sif09yafg0ikmFMrM5v8cb/pt+aoC6JftlWDWCXv0nCbX1aM55hdi6I4I9Qpcy/J2U0IsUKzij16A4+qal5JUL3ZXtQFElvkjf+FxRfU1R2ux/Q9hNvxZZm1We5SHsO8MA2fmNczuqQz9xb29GjpJ6Bhs2ooWtAMsJni/RwTdnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791453145; c=relaxed/simple;
	bh=rPHDJQ1x3HKtQyLhrvZ7PcopXl97R7kGMawAWR5i0fo=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=UsrbjieS0VyenpyyqXQwg8WGuJiOtegOPLCyMNKQMq5iqqegw5Hmpz5gtQTjqQdIvjTfbjKK2vZIK6/0+l7y/udwcfM3eDwtt/P4wRMlxLtfo0bbYXOoNfUoc8n56zJ1KPvFbghuMiYiHp0V+BLkoqClgW2wIoWKjay03/eYlJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K5aqRUs5; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K5aqRUs5"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-86b41d77a05so1345169b3a.0
        for <git@vger.kernel.org>; Thu, 08 Oct 2026 02:52:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791453143; x=1792057943; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pmm2xHjRCPQFkXSKOElUV/h+gTMuxLMFzeQD05WGzFo=;
        b=K5aqRUs5XL2Mwvdl0pAngtBf9ZxaPO40MuRYPdK0ngaolUZilJq1bmrPnUpv3P+tKt
         4m+gyp16fe7FjJekKTQrthIM3sYk6V0hH82Ba7+ojqoYavH6m8lLws1q/m+r3MlB/V5K
         yb37LLQ87Q1khdnxZx8aduXJMMUguVa52S28NB3FwS9SglshPK+vic1tZnVi3684IUuG
         3CJGFu7Hy2EhlpHJ/7tHOE0bFtttTb+teZi6qOwbQ8G/qHlnd9BPu1kx+Hj/HK0PAS1Q
         zpWXS9P6ENuXd4QTfLp6bpWS9DYp5If7TtraeHydxk0ZiE58xGHeDJYBr0XYE1DiCnhT
         Gnag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791453143; x=1792057943;
        h=cc:to:mime-version:content-transfer-encoding:content-type:fcc
         :subject:date:from:references:in-reply-to:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pmm2xHjRCPQFkXSKOElUV/h+gTMuxLMFzeQD05WGzFo=;
        b=uvI/v+iLQv7TaVicv9CT2l41jqIyAfs0XHUuoocS8I495nS+ZPUjz8bd0FzkdtcEai
         8PGYXQ7yUSNmO4D3liUduSksGAd1w3ClH9kyiorLmZyfGopSs9++RksdukyVlB4tLXlC
         LGusfLAxZJqsbahCzbkE8485DPuRmzXsNtggBvuDCn1XIae/ENSCFbAAcNN0ggQnd4KS
         n3O4j4l5emZAmArfKOh4n91c2+w3joNu1RfzVRLqJ2z03SfQdG/bReNE9HWzF36qubhe
         cCdI1dNgfLO1iYGVcA3bpBg0KcszXKawareR98BI4AVBw6QPoDtVqE9lO7zHIjb+ZpSA
         q6PA==
X-Gm-Message-State: AFuF++kfy5usq56SPGY6QZy4qLmUFWLrDzlQu2Sie3bv5kos6f9toQyK
	qpa215jN+BM/yQbxdjiFrpg9tCH8bZdQoUvQYw0//h0mPMyiNRsxCSi+eXfSjQ==
X-Gm-Gg: AYBFou2PPI8WbHJayTrz60a79X4fAgB/TUpDUO0u3izVBzzcrt8PGdRkJypS94N991g
	Pv2UwYx61wUFxIvE20QhYAKqcj15pSQHENkhIC7KiwxF7QK7w8k/Demjy6ntIT35KawL1XauGUJ
	3HsWsK1aMIGCqbVv7fHbp3tvWmqQJgUux4AdS95ml8IZ2vrba324DwHe9Ko42ekuMyAospWDl/8
	m/PoV5EnLhuoEGP7ZuwikG7JqEl55LBbnl0zg6oR5nNZJHReyh/f0Y8uune79Z1vwyEfbYWoF3c
	/7TvmheJil+COpnKHZ2Fzka7t1/xjB0fbR5Jl9ndN6EH05XoZND+VmSu7KHmX93lc1ZEMVe2/vZ
	vodnxExtF17VlDuAD58MKRGRgLFhy1knY8maoDBtxhzMAHk/Q1Us6RdNBC946EUHOCC9K5obkA/
	1zyQKQUgUeHsBGgvcK/qaX3HFeWzgKZaI+nxpchoqHnsKD1Wra2ywjwjFVklXcj5TXKItmTKT6R
	kY=
X-Received: by 2002:a05:6a00:1d21:b0:88b:72d6:b80e with SMTP id d2e1a72fcca58-891b0c8396cmr3757517b3a.13.1791453142896;
        Thu, 08 Oct 2026 02:52:22 -0700 (PDT)
Received: from [127.0.0.1] ([4.154.246.147])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-892bb2a5ba8sm1363098b3a.30.2026.10.08.02.52.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 02:52:22 -0700 (PDT)
Message-Id: <pull.2219.v3.git.1791453141.gitgitgadget@gmail.com>
In-Reply-To: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
References: <pull.2219.git.1789385483.gitgitgadget@gmail.com>
From: "qeesung via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 Oct 2026 09:52:16 +0000
Subject: [PATCH v3 0/5] repack: don't lose objects to a ".keep" that appears mid-run
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Taylor Blau <ttaylorr@openai.com>,
    Junio C Hamano <gitster@pobox.com>,
    Justin Tobler <jltobler@gmail.com>,
    qeesung <qeesung@live.com>

A concurrent push or fetch can make "git repack -d" delete a pack whose
objects were never copied anywhere, and exit 0. We hit this in production: a
ref pointing at a commit that no longer exists, on git 2.43, and it
reproduces on master.

What happens:

 * repack scans for ".keep" files and decides which packs to delete, then
   spawns pack-objects with --honor-pack-keep, which scans again;
 * in between, an index-pack --keep finishes -- a push migrating its
   quarantine, or a fetch -- and installs a ".keep" next to a pack that
   repack has already decided to delete;
 * pack-objects sees that ".keep" and leaves the pack's objects out; repack
   deletes the pack by its earlier list, with force_delete.

The fix is to stop the two processes from scanning separately: hand
pack-objects the snapshot repack took at startup (5/5). Patches 1-4 are what
5/5 needs to be safe:

 * 1/5: under --stdin-packs=follow, a --keep-pack pack stops the traversal
   like a "^" pack; on-disk ".keep" packs never did.
 * 2/5: the cruft walk goes by a stale kept-pack cache, which
   --honor-pack-keep happened to mask. Pre-existing, reproducible today.
 * 3/5: look --keep-pack names up in a sorted list; it gets long.
 * 4/5: --keep-pack-from-file, since a repository can have more kept packs
   than fit on a command line (32K characters on Windows).

Every fix comes with a test that fails without it; the race itself is
reproduced in t7703 by having a ".keep" appear as pack-objects starts. The
full suite passes.

Interaction with topics in seen:

 * ps/odb-files-alternates turns the list of object sources into a single
   files source with a list of object directories, so
   repo_invalidate_kept_pack_caches() from 2/5 needs to walk those instead.
   The textual merge is clean, but the build breaks; this resolution follows
   has_object_kept_pack() on that topic:
   
   void repo_invalidate_kept_pack_caches(struct repository *r) { struct
   odb_source_files *files = odb_source_files_downcast(r->objects->source);
   for (struct odb_files_dir *dir = files->dirs; dir; dir = dir->next)
   invalidate_kept_pack_cache(dir->packed); }

 * tb/repack-cruft-less-midx-corner-cases appends tests to the end of t5331,
   as does 4/5; keep both. That topic also hands kept packs to the
   "--stdin-packs=follow" walk as '^' or '!', so with this series such a
   pack is named twice, once on stdin and once in the file from 5/5. The two
   compose: a '^' pack still stops the walk, and a '!' pack is open either
   way.

With that resolution, seen with this series merged passes the full suite.

Changes since v2:

 * 2/5: the loop that drops the kept-pack cache of every object source moved
   from pack-objects into packfile.c, as repo_invalidate_kept_pack_caches(),
   next to has_object_kept_pack() which reads that cache; the per-store
   helper is static again. This keeps pack-objects from gaining a direct use
   of the files backend, but the loop still assumes every source is one,
   like its neighbours, so the layering issue Junio raised is not solved
   here: https://lore.kernel.org/git/xmqqcxu3c15i.fsf@gitster.g/ (I first
   misread his question as asking whether the fix itself had to wait for
   that rework; it was about the layering.)
 * The rest is unchanged.

Changes since v1:

 * Dropped the receive-pack patch; Justin Tobler is fixing that side by
   having the ODB transaction create the ".keep" itself:
   https://lore.kernel.org/git/aql8Wt2q9RnQpjEC@jtobler--20250820-SHC54/

Qin ShiCheng (5):
  pack-objects: keep --keep-pack open when following
  pack-objects: reset kept-pack cache for cruft walk
  pack-objects: sort --keep-pack list for lookup
  pack-objects: add --keep-pack-from-file
  repack: tell pack-objects which packs are kept

 Documentation/git-pack-objects.adoc |  8 +++
 builtin/pack-objects.c              | 66 +++++++++++++++++-----
 builtin/repack.c                    | 15 +++++
 odb/source-packed.h                 |  3 +-
 packfile.c                          | 19 ++++++-
 packfile.h                          |  7 +++
 repack-filtered.c                   |  3 -
 repack.c                            | 34 ++++++++++-
 repack.h                            | 17 +++++-
 t/t5329-pack-objects-cruft.sh       | 40 +++++++++++++
 t/t5331-pack-objects-stdin.sh       | 87 +++++++++++++++++++++++++++++
 t/t7700-repack.sh                   | 43 ++++++++++++++
 t/t7703-repack-geometric.sh         | 72 ++++++++++++++++++++++++
 13 files changed, 391 insertions(+), 23 deletions(-)


base-commit: 3cb9185f65410273787f74333cc027d2ea5daada
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2219%2Fqeesung%2Frepack-kept-packs-snapshot-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2219/qeesung/repack-kept-packs-snapshot-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/2219

Range-diff vs v2:

 1:  8cf72312c5 = 1:  8cf72312c5 pack-objects: keep --keep-pack open when following
 2:  77aec8941f ! 2:  58019e4983 pack-objects: reset kept-pack cache for cruft walk
     @@ Commit message
          dropped when asked about a different kind of kept pack. Collecting
          builds it while the unlisted pack is still marked, the walk asks the
          same kind of question, and so the unlisted pack stays in it: the walk
     -    stops there, and whatever lies beyond it in an expired pack is lost.
     +    stops there, and whatever lies beyond it in an expired pack is left
     +    out of the cruft pack, to go when that pack is deleted.
      
          This went unnoticed because of "--honor-pack-keep". repack passes it,
          and when there is a ".keep" file it makes the collecting side ask
     @@ Commit message
          ".keep" file away and the objects are lost today. A later commit stops
          repack from passing "--honor-pack-keep" at all, so fix this first.
      
     -    Expose the invalidation packfile.c already has and call it after
     -    re-marking. The test builds an unreachable chain whose middle commit
     -    sits in a pack pack-objects is not told about and whose oldest objects
     -    have expired; without the fix the cruft pack holds only the recent tip.
     +    Drop the cache after re-marking. The loop over the object sources
     +    that does so lives in packfile.c, as repo_invalidate_kept_pack_caches(),
     +    next to has_object_kept_pack() which reads the cache. Like it, the
     +    loop assumes every source is a files backend; keeping that assumption
     +    in packfile.c rather than adding it to pack-objects means the two can
     +    move together once packfile management is pushed down into that
     +    backend.
     +
     +    The test builds an unreachable chain whose middle commit sits in a
     +    pack pack-objects is not told about and whose oldest objects have
     +    expired; without the fix the cruft pack holds only the recent tip.
      
          Signed-off-by: Qin ShiCheng <qeesung@live.com>
      
       ## builtin/pack-objects.c ##
     -@@ builtin/pack-objects.c: static void enumerate_cruft_objects(void)
     - static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs)
     - {
     - 	struct packed_git *p;
     -+	struct odb_source *source;
     - 	struct rev_info revs;
     - 	int ret;
     - 
      @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct string_list *fresh_packs
       	/*
       	 * Re-mark only the fresh packs as kept so that objects in
     @@ builtin/pack-objects.c: static void enumerate_and_traverse_cruft_objects(struct
       	repo_for_each_pack(the_repository, p)
       		p->pack_keep_in_core = 0;
       	mark_pack_kept_in_core(fresh_packs, 1);
     -+	for (source = the_repository->objects->sources; source;
     -+	     source = source->next) {
     -+		struct odb_source_files *files = odb_source_files_downcast(source);
     -+		packfile_store_invalidate_kept_pack_cache(files->packed);
     -+	}
     ++	repo_invalidate_kept_pack_caches(the_repository);
       
       	if (prepare_revision_walk(&revs))
       		die(_("revision walk setup failed"));
     @@ odb/source-packed.h: struct odb_source_packed {
       	 * invalidated when the stored flags and the flags passed to
      -	 * `packfile_store_get_kept_pack_cache()` mismatch.
      +	 * `packfile_store_get_kept_pack_cache()` mismatch, or explicitly via
     -+	 * `packfile_store_invalidate_kept_pack_cache()`.
     ++	 * `repo_invalidate_kept_pack_caches()`.
       	 */
       	struct {
       		struct packed_git **packs;
     @@ packfile.c: int packfile_fill_entry(struct packed_git *p,
       	return 1;
       }
       
     -+void packfile_store_invalidate_kept_pack_cache(struct odb_source_packed *store)
     ++static void invalidate_kept_pack_cache(struct odb_source_packed *store)
      +{
      +	FREE_AND_NULL(store->kept_cache.packs);
      +	store->kept_cache.flags = 0;
      +}
     ++
     ++void repo_invalidate_kept_pack_caches(struct repository *r)
     ++{
     ++	struct odb_source *source;
     ++
     ++	for (source = r->objects->sources; source; source = source->next) {
     ++		struct odb_source_files *files = odb_source_files_downcast(source);
     ++		invalidate_kept_pack_cache(files->packed);
     ++	}
     ++}
      +
       static void maybe_invalidate_kept_pack_cache(struct odb_source_packed *store,
       					     unsigned flags)
     @@ packfile.c: static void maybe_invalidate_kept_pack_cache(struct odb_source_packe
       		return;
      -	FREE_AND_NULL(store->kept_cache.packs);
      -	store->kept_cache.flags = 0;
     -+	packfile_store_invalidate_kept_pack_cache(store);
     ++	invalidate_kept_pack_cache(store);
       }
       
       struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed *store,
     @@ packfile.h: enum kept_pack_type {
       						       unsigned flags);
       
      +/*
     -+ * Drop the cache of kept packs so that the next call to
     -+ * `packfile_store_get_kept_pack_cache()` rebuilds it, e.g. after changing
     -+ * which packs are kept in core.
     ++ * Drop every packfile store's cache of kept packs, so that the next call
     ++ * to `packfile_store_get_kept_pack_cache()` rebuilds it, e.g. after
     ++ * changing which packs are kept in core.
      + */
     -+void packfile_store_invalidate_kept_pack_cache(struct odb_source_packed *store);
     ++void repo_invalidate_kept_pack_caches(struct repository *r);
      +
       struct pack_window {
       	struct pack_window *next;
 3:  b76e06a467 = 3:  ff2146d002 pack-objects: sort --keep-pack list for lookup
 4:  20a051cfb6 = 4:  148175cfa0 pack-objects: add --keep-pack-from-file
 5:  4684fd8552 = 5:  8f3b9d9ee0 repack: tell pack-objects which packs are kept

-- 
gitgitgadget
