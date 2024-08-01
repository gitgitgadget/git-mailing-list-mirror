Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 163321A8C05
	for <git@vger.kernel.org>; Thu,  1 Aug 2024 14:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722524344; cv=none; b=N6agMUp5M1HWxXWi2UP92X59i0DtCnKjPWXxslmuhKlGS67oqLDe7IgzfJLzD0wxrC/2AbpHcx9H+XHfxqBhYdje3ayvPqRIMX9hZe72GgEZkhPMQbwdNammk/oH4fVyNrGjCkAzgiOaKE7Vx2kkNcNtmBp7SX1FSJUKs13ZQz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722524344; c=relaxed/simple;
	bh=UC8cAPtf4eXYEGND0/AKLP7hNoTESXIdGGgksbRns3Y=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=p24Tq5dqaxlWZbnlNWxQUe937YK6vMSjEusv71cUGe7HUaiuhw3ZSgyLRuYz7a8laHbqlPzCIqej3LlZLEqfgzWDWNjEX4+VS6l7jhsLWm1gLrpflVsxRPJCJIJU/TMCUF/+Xh3ccnv8pVkempHeS4WZxlb8OCSTQb2ibD0yMX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CT9GdXsa; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CT9GdXsa"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f035ae0fd1so81829801fa.2
        for <git@vger.kernel.org>; Thu, 01 Aug 2024 07:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722524337; x=1723129137; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PD/AE/1g+uiomKNODslmjcMTk7TR8RINLqET2sValoM=;
        b=CT9GdXsaQWwcwmgLJCDp4VL1mIOUvRGJY+Rwu7+ZRNOth7kYn83EjwDVlK94BVqKTR
         wsulYYYVsC6Cg+KLBDnhjSp5DNN1tknQb+V+3igyR5OPJE+3bFsvyO99RgpV3HctED9x
         1eecOug6aFU6Ihh6cNbN202xfJK9dF1e4JxvRh5GajXCd9vCYuUhhkAofIT1EcNRrypN
         QFhBzW1vAlqw4V+Ov8ld/ILJ7+9akv9RVnDd2TNW6XbQtWuRGiF5o42IpptUcklbI9yz
         P28XbduP9QYurqW3zMskVLVU5tUyLnkmA8qFQE0dYG+wiKTiHJd/+V14VOvjH0WzjONq
         5/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722524337; x=1723129137;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PD/AE/1g+uiomKNODslmjcMTk7TR8RINLqET2sValoM=;
        b=CnxhLhttSIIbs7mBpbN/qmsRvI14a0VhJJPsM+9aVd+TSswlqE1xUcWtHTyrHYUnIg
         6M6WVOqgP6Qzc5TKQ5+waaHsgfnmRxZ59If2QwU/2A1R5249QVtLJTsdqr/vZ/JSdgo1
         nOSQo37/VH2BUwts5oQHviH3HSNzqlzskUuJuqusJOmwF0GFiSgJoM1kbCVS+bA3PYof
         eAOhuTzivy+i4ud0VYBUJAhUWVlOekrp9Tj5NBu8pXc8EooSwxdge+Oc9M41Yzp/mzAy
         sPgnHAlWI79Gs4/x/mgyTgkqdTjuvPhwucv9Z/+Dx5Y02p1B3cGUGSJ6X975qKXMqj1D
         ONSw==
X-Gm-Message-State: AOJu0YyRm4GnmiElkiMUHztUddmSjAr7lRMhMl1mOPnm2sNw5RyCmCSL
	9a059CA4Xkny/Hlc4agfSOKsol34fE7HSGugLm43DdOww8grB2SfDWLJLA==
X-Google-Smtp-Source: AGHT+IHiyFZfX+o51bAoVTDtZJhpLXiJD4t8p0XlxvJcQu64pnziT6svtQVPS46yLUBiEpcRyVjx3Q==
X-Received: by 2002:a2e:8502:0:b0:2ef:2ee3:6e75 with SMTP id 38308e7fff4ca-2f15aa8778emr4480631fa.17.1722524336839;
        Thu, 01 Aug 2024 07:58:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4282bb64a68sm62682595e9.38.2024.08.01.07.58.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 07:58:56 -0700 (PDT)
Message-Id: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
References: <pull.1712.git.git.1717694800.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 01 Aug 2024 14:58:51 +0000
Subject: [PATCH v2 0/3] keep track of unresolved value of symbolic-ref in ref iterators
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
Cc: Phillip Wood <phillip.wood123@gmail.com>,
    Kristoffer Haugsbakk <code@khaugsbakk.name>,
    Jeff King <peff@peff.net>,
    Patrick Steinhardt <ps@pks.im>,
    =?UTF-8?Q?Jean-No=C3=ABl?= Avila <avila.jn@gmail.com>,
    Linus Arver <linusarver@gmail.com>,
    John Cai <johncai86@gmail.com>

For reftable development, it's useful to be able to print out the direct
value of a symbolic reference before resolution. This is currently possible
with git-for-each-ref, but since the iterators do not keep track of the
value of the symbolic ref, a separate call needs to be made each time making
it inefficient.

Address this inefficiency by keeping track of the value of the symbolic
reference in the ref iterator. This patch series also ends with a commit to
use this value in the iterator through callbacks in ref-filter.c.

This series started with [1] but I decided to send a separate patch series
since it is substantially different.

Benchmarking shows that with these changes, we experience a speedup in
git-for-each-ref(1) on a repository with many symbolic refs:

$ hyperfine --warmup 5 "git for-each-ref --format='%(refname) %(objectname)
%(symref)'" "~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)'" Benchmark 1: git for-each-ref --format='%(refname)
%(objectname) %(symref)' Time (mean ± σ): 905.1 ms ± 13.2 ms [User: 56.3 ms,
System: 628.6 ms] Range (min … max): 893.4 ms … 936.9 ms 10 runs

Benchmark 2: ~/Projects/git/git for-each-ref --format='%(refname)
%(objectname) %(symref)' Time (mean ± σ): 482.2 ms ± 26.4 ms [User: 34.7 ms,
System: 410.6 ms] Range (min … max): 459.4 ms … 541.8 ms 10 runs

Summary ~/Projects/git/git for-each-ref --format='%(refname) %(objectname)
%(symref)' ran 1.88 ± 0.11 times faster than git for-each-ref
--format='%(refname) %(objectname) %(symref)'

Changes since V1:

 * Use the return value from refs_resolve_ref_unsafe instead of using an out
   parameter

 1. https://lore.kernel.org/git/pull.1684.git.git.1709592718743.gitgitgadget@gmail.com/

John Cai (3):
  refs: keep track of unresolved reference value in iterators
  refs: add referent to each_ref_fn
  ref-filter: populate symref from iterator

 bisect.c                    |  3 ++-
 builtin/bisect.c            |  4 +++-
 builtin/checkout.c          |  2 +-
 builtin/describe.c          |  2 +-
 builtin/fetch.c             |  3 ++-
 builtin/fsck.c              |  4 ++--
 builtin/gc.c                |  1 +
 builtin/name-rev.c          |  2 +-
 builtin/pack-objects.c      |  5 +++--
 builtin/receive-pack.c      |  2 +-
 builtin/remote.c            |  4 +++-
 builtin/repack.c            |  1 +
 builtin/replace.c           |  1 +
 builtin/rev-parse.c         |  4 ++--
 builtin/show-branch.c       |  8 ++++----
 builtin/show-ref.c          |  3 ++-
 builtin/submodule--helper.c |  1 +
 builtin/worktree.c          |  1 +
 commit-graph.c              |  1 +
 delta-islands.c             |  2 +-
 fetch-pack.c                |  2 ++
 help.c                      |  2 +-
 http-backend.c              |  4 ++--
 log-tree.c                  |  2 +-
 ls-refs.c                   |  4 ++--
 midx-write.c                |  2 +-
 negotiator/default.c        |  2 +-
 negotiator/skipping.c       |  2 +-
 notes.c                     |  2 +-
 object-name.c               |  2 +-
 pseudo-merge.c              |  1 +
 reachable.c                 |  2 +-
 ref-filter.c                | 12 +++++++-----
 reflog.c                    |  1 +
 refs.c                      | 14 +++++++-------
 refs.h                      |  2 +-
 refs/files-backend.c        | 16 +++++++++++-----
 refs/iterator.c             |  5 ++++-
 refs/ref-cache.c            |  8 ++++++++
 refs/ref-cache.h            |  2 ++
 refs/refs-internal.h        |  1 +
 refs/reftable-backend.c     |  8 ++++++--
 remote.c                    |  4 ++--
 replace-object.c            |  1 +
 revision.c                  |  2 +-
 server-info.c               |  2 +-
 shallow.c                   |  2 ++
 submodule.c                 |  2 ++
 t/helper/test-ref-store.c   |  2 +-
 upload-pack.c               |  8 ++++----
 walker.c                    |  1 +
 worktree.c                  |  2 +-
 52 files changed, 113 insertions(+), 63 deletions(-)


base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1712%2Fjohn-cai%2Fjc%2Fsymbolic-ref-in-iterator-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1712/john-cai/jc/symbolic-ref-in-iterator-v2
Pull-Request: https://github.com/git/git/pull/1712

Range-diff vs v1:

 1:  011c10f4886 < -:  ----------- refs: add referent parameter to refs_resolve_ref_unsafe
 2:  7202ada0542 ! 1:  ac0957c9e6a refs: keep track of unresolved reference value in iterators
     @@ refs/files-backend.c: static void loose_fill_ref_dir_regular_file(struct files_r
       {
       	struct object_id oid;
       	int flag;
     -+	const char* referent = NULL;
     - 
     --	if (!refs_resolve_ref_unsafe(&refs->base, refname, NULL, RESOLVE_REF_READING,
     -+	if (!refs_resolve_ref_unsafe(&refs->base, refname, referent, RESOLVE_REF_READING,
     - 				     &oid, &flag)) {
     - 		oidclr(&oid);
     +-
     +-	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
     +-				     &oid, &flag)) {
     ++	const char* referent = refs_resolve_ref_unsafe(&refs->base,
     ++						       refname,
     ++						       RESOLVE_REF_READING,
     ++						       &oid, &flag);
     ++	if (!referent) {
     + 		oidclr(&oid, the_repository->hash_algo);
       		flag |= REF_ISBROKEN;
     + 	} else if (is_null_oid(&oid)) {
      @@ refs/files-backend.c: static void loose_fill_ref_dir_regular_file(struct files_ref_store *refs,
     - 		oidclr(&oid);
     + 		oidclr(&oid, the_repository->hash_algo);
       		flag |= REF_BAD_NAME | REF_ISBROKEN;
       	}
      -	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
     ++
      +	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
       }
       
     @@ refs/ref-cache.c: struct ref_dir *get_ref_dir(struct ref_entry *entry)
       				   const struct object_id *oid, int flag)
       {
       	struct ref_entry *ref;
     - 
     +@@ refs/ref-cache.c: struct ref_entry *create_ref_entry(const char *refname,
       	FLEX_ALLOC_STR(ref, name, refname);
       	oidcpy(&ref->u.value.oid, oid);
     -+	if (referent)
     -+		ref->u.value.referent = xstrdup(referent);
     -+
       	ref->flag = flag;
     ++
     ++	if (flag & REF_ISSYMREF)
     ++		ref->u.value.referent = xstrdup_or_null(referent);
     ++
       	return ref;
       }
     + 
     +@@ refs/ref-cache.c: static void free_ref_entry(struct ref_entry *entry)
     + 		 */
     + 		clear_ref_dir(&entry->u.subdir);
     + 	}
     ++	free(entry->u.value.referent);
     + 	free(entry);
     + }
     + 
      @@ refs/ref-cache.c: static int cache_ref_iterator_advance(struct ref_iterator *ref_iterator)
       			level->index = -1;
       		} else {
     @@ refs/ref-cache.h: struct ref_value {
       	 * referred to by the last reference in the symlink chain.
       	 */
       	struct object_id oid;
     -+	const char *referent;
     ++	char *referent;
       };
       
       /*
     @@ refs/refs-internal.h: enum do_for_each_ref_flags {
      
       ## refs/reftable-backend.c ##
      @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
     - 			oidread(&iter->oid, iter->ref.value.val2.value);
     + 				the_repository->hash_algo);
       			break;
       		case REFTABLE_REF_SYMREF:
     --			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, NULL,
     -+			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname, iter->base.referent,
     - 						     RESOLVE_REF_READING, &iter->oid, &flags))
     - 				oidclr(&iter->oid);
     +-			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
     +-						     RESOLVE_REF_READING, &iter->oid, &flags))
     ++			iter->base.referent = refs_resolve_ref_unsafe(&iter->refs->base,
     ++								      iter->ref.refname,
     ++								      RESOLVE_REF_READING,
     ++								      &iter->oid,
     ++								      &flags);
     ++			if (!iter->base.referent)
     + 				oidclr(&iter->oid, the_repository->hash_algo);
       			break;
     + 		default:
 3:  33914f84a64 ! 2:  1f3a604fae7 refs: add referent to each_ref_fn
     @@ object-name.c: struct handle_one_ref_cb {
       			  void *cb_data)
       {
      
     + ## pseudo-merge.c ##
     +@@ pseudo-merge.c: void load_pseudo_merges_from_config(struct string_list *list)
     + }
     + 
     + static int find_pseudo_merge_group_for_ref(const char *refname,
     ++					   const char *referent UNUSED,
     + 					   const struct object_id *oid,
     + 					   int flags UNUSED,
     + 					   void *_data)
     +
       ## reachable.c ##
      @@ reachable.c: static void add_rebase_files(struct rev_info *revs)
       	free_worktrees(worktrees);
     @@ refs.c: int refs_head_ref_namespaced(struct ref_store *refs, each_ref_fn fn, voi
       	return ret;
      @@ refs.c: int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
       
     - 	if (refs_resolve_ref_unsafe(refs, "HEAD", NULL, RESOLVE_REF_READING,
     + 	if (refs_resolve_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
       				    &oid, &flag))
      -		return fn("HEAD", &oid, flag, cb_data);
      +		return fn("HEAD", NULL, &oid, flag, cb_data);
     @@ refs.c: struct do_for_each_reflog_help {
       				     const struct object_id *oid UNUSED,
       				     int flags,
       				     void *cb_data)
     +@@ refs.c: struct migration_data {
     + 	struct strbuf *errbuf;
     + };
     + 
     +-static int migrate_one_ref(const char *refname, const struct object_id *oid,
     ++static int migrate_one_ref(const char *refname, const char *referent UNUSED, const struct object_id *oid,
     + 			   int flags, void *cb_data)
     + {
     + 	struct migration_data *data = cb_data;
      
       ## refs.h ##
      @@ refs.h: struct ref_transaction;
     @@ walker.c: static int interpret_target(struct walker *walker, char *target, struc
      
       ## worktree.c ##
      @@ worktree.c: int other_head_refs(each_ref_fn fn, void *cb_data)
     - 					    NULL,
     + 					    refname.buf,
       					    RESOLVE_REF_READING,
       					    &oid, &flag))
      -			ret = fn(refname.buf, &oid, flag, cb_data);
 4:  6d5b1b62e6c ! 3:  3e147e7d850 ref-filter: populate symref from iterator
     @@ Metadata
       ## Commit message ##
          ref-filter: populate symref from iterator
      
     -    With a previous commit, the reference the symbolic ref points is saved
     +    With a previous commit, the reference the symbolic ref points to is saved
          in the ref iterator records. Instead of making a separate call to
          resolve_refdup() each time, we can just populate the ref_array_item with
          the value from the iterator.
     @@ ref-filter.c: static struct ref_array_item *apply_ref_filter(const char *refname
       	ref->commit = commit;
       	ref->flag = flag;
       	ref->kind = kind;
     -+	ref->symref = referent;
     ++	if (flag & REF_ISSYMREF)
     ++		ref->symref = xstrdup_or_null(referent);
       
       	return ref;
       }

-- 
gitgitgadget
