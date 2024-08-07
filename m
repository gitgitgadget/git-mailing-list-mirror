Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1A6563CB
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 19:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723059775; cv=none; b=eYVHB/IRUcv9/HXPdl2gBdYx1vBO45scSpnK2XamPq/TDKvF3TXPgnT2RMFVvsyvqZrnxlZRuIUTMN6FCabWp8qYn2c9MysZnb/xhGiQWJSmDeYw3Y1pPd812EN+4iF9IAXkhHBAgTkPl1yoi7h4Ehn2GMcwY8WWg5DHvqbnNSc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723059775; c=relaxed/simple;
	bh=UvpFLmW17Pt7Dt90tRDoOVhmIL9IZcsxJ6jzR4Ei6jU=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=uhntaGuvWP3bZFjZbJRFvGEYJAEouSRDw5VqSOszaGh3VsR3SW94HNrRJ+a56lfAwshJxAfM0564g5VKN4xlOu5Fsc9RBjKLU/n2BDLU0uyvyU6sYClncAyaS5Pu0WWHoErbF25/3qf9hKgZiVs3UgwyToVWAHjGJ8aNrQjO8bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XzJmfZQb; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XzJmfZQb"
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2ef23d04541so1604601fa.2
        for <git@vger.kernel.org>; Wed, 07 Aug 2024 12:42:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723059771; x=1723664571; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ewVqucQobgQxv9YOqEkqqFQn9n4kG398GF9+lC8osR0=;
        b=XzJmfZQbCP8+/oSj5yJcTmzJdUNG/z9VcTMe0OWxmrko3WrNZy8VNoFKyCNBf3mj71
         Qqijv0FyC/MjG74r0OJvPTVJKIb6jDpfbe/0L780yM8fU+dAzLX8xmyGZfSfD77tLGC2
         xo6MT4kqQjZ1noQ5TikVywYD/w7PscDAF00GNXU0QK4qb/7trUlNj0IPC59/hvW+jA5k
         +0aj5eUuvkC/P/93EMcw3RK5MTnilzwsN+7FADe37rY5Opu+/67K+180GKNs/RR656FG
         sec7xswqQOyOtIgT2X/l7zsjzxQZhcKUMy9A4Uep0M75RuRMDbPK+AXU7a2SrC7vLUVD
         YCaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723059771; x=1723664571;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ewVqucQobgQxv9YOqEkqqFQn9n4kG398GF9+lC8osR0=;
        b=oA2fKNDl6rv98d6qy0nS2m5baAvEib5mwSG5WpFbbdWGneD/O0o0cy2f7Vx8evXFgK
         juv7pKKqWjX37xD5YweLRDbmnQVsrHOd4FWuVqFY87PscHJuGFctoZimT76+lcwzsVqO
         nn0AQpqrGDyJhrMZDp+bB7ayngq6VvHZRpybdOntt42S3Gapltuv4sip/3FF7h+hHwTy
         ycVYr8KxpuOQ6bROysE6A6K8VldIPEbNBIQFM+LcCIJASwRcc6SsCzIqDZdrcrrNq8pR
         zkRaPc7F5gWuKxke23PW1fSUy3lQPEQC9JjQkFC5pMOp4EWwTAThrOVSdmvVvN2AJ3s4
         iPng==
X-Gm-Message-State: AOJu0YwR3yVHjp/RPRVAdfQ7WJHhnwRlu7YCo3EH+kRGc+v6wyByMfVA
	QnUc9qIKcFrG4ixs5HLq/1VxlJSq4ZZl6OWtniyAs+tS/ONtl9+xHNWa8Q==
X-Google-Smtp-Source: AGHT+IEKCpqVL2h2xH5hxWwo4BE9HMRRYJ2+230xDSPnnveuK4iDlDqvQo4LlF87p8On9tIxevUXyw==
X-Received: by 2002:a2e:8718:0:b0:2ef:2f17:9ede with SMTP id 38308e7fff4ca-2f15ab6a35fmr128482701fa.49.1723059771082;
        Wed, 07 Aug 2024 12:42:51 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429057a92c8sm43381005e9.23.2024.08.07.12.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Aug 2024 12:42:50 -0700 (PDT)
Message-Id: <pull.1712.v3.git.git.1723059768.gitgitgadget@gmail.com>
In-Reply-To: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
References: <pull.1712.v2.git.git.1722524334.gitgitgadget@gmail.com>
From: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 07 Aug 2024 19:42:45 +0000
Subject: [PATCH v3 0/3] keep track of unresolved value of symbolic-ref in ref iterators
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

Changes since V2:

 * Style tweaks
 * Added a NEEDSWORK comment around fallback code
 * Stay consistent in the meaning of a non-NULL referent member in the
   iterator

Changes since V1

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
 ref-filter.c                | 17 ++++++++++++-----
 reflog.c                    |  1 +
 refs.c                      | 14 +++++++-------
 refs.h                      |  2 +-
 refs/files-backend.c        | 21 ++++++++++++++++-----
 refs/iterator.c             |  4 +++-
 refs/ref-cache.c            |  6 ++++++
 refs/ref-cache.h            |  2 ++
 refs/refs-internal.h        |  1 +
 refs/reftable-backend.c     | 10 ++++++++--
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
 52 files changed, 122 insertions(+), 63 deletions(-)


base-commit: 557ae147e6cdc9db121269b058c757ac5092f9c9
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1712%2Fjohn-cai%2Fjc%2Fsymbolic-ref-in-iterator-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1712/john-cai/jc/symbolic-ref-in-iterator-v3
Pull-Request: https://github.com/git/git/pull/1712

Range-diff vs v2:

 1:  ac0957c9e6a ! 1:  fc3defd9c47 refs: keep track of unresolved reference value in iterators
     @@ refs/files-backend.c: static void loose_fill_ref_dir_regular_file(struct files_r
      -
      -	if (!refs_resolve_ref_unsafe(&refs->base, refname, RESOLVE_REF_READING,
      -				     &oid, &flag)) {
     -+	const char* referent = refs_resolve_ref_unsafe(&refs->base,
     ++	const char *referent = refs_resolve_ref_unsafe(&refs->base,
      +						       refname,
      +						       RESOLVE_REF_READING,
      +						       &oid, &flag);
     @@ refs/files-backend.c: static void loose_fill_ref_dir_regular_file(struct files_r
       	}
      -	add_entry_to_dir(dir, create_ref_entry(refname, &oid, flag));
      +
     ++	if (!(flag & REF_ISSYMREF))
     ++		referent = NULL;
     ++
      +	add_entry_to_dir(dir, create_ref_entry(refname, referent, &oid, flag));
       }
       
     @@ refs/files-backend.c: static int files_ref_iterator_advance(struct ref_iterator
       		iter->base.flags = iter->iter0->flags;
      +		if (iter->iter0->flags & REF_ISSYMREF)
      +			iter->base.referent = iter->iter0->referent;
     ++		else
     ++			iter->base.referent = NULL;
      +
       		return ITER_OK;
       	}
       
      
       ## refs/iterator.c ##
     -@@
     - #include "refs.h"
     - #include "refs/refs-internal.h"
     - #include "iterator.h"
     -+#include "strbuf.h"
     - 
     - int ref_iterator_advance(struct ref_iterator *ref_iterator)
     - {
      @@ refs/iterator.c: void base_ref_iterator_init(struct ref_iterator *iter,
       {
       	iter->vtable = vtable;
     @@ refs/ref-cache.c: struct ref_entry *create_ref_entry(const char *refname,
       	FLEX_ALLOC_STR(ref, name, refname);
       	oidcpy(&ref->u.value.oid, oid);
       	ref->flag = flag;
     -+
     -+	if (flag & REF_ISSYMREF)
     -+		ref->u.value.referent = xstrdup_or_null(referent);
     ++	ref->u.value.referent = xstrdup_or_null(referent);
      +
       	return ref;
       }
     @@ refs/refs-internal.h: enum do_for_each_ref_flags {
       };
      
       ## refs/reftable-backend.c ##
     +@@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
     + 	struct reftable_ref_iterator *iter =
     + 		(struct reftable_ref_iterator *)ref_iterator;
     + 	struct reftable_ref_store *refs = iter->refs;
     ++	const char *referent = NULL;
     + 
     + 	while (!iter->err) {
     + 		int flags = 0;
      @@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
       				the_repository->hash_algo);
       			break;
       		case REFTABLE_REF_SYMREF:
      -			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
      -						     RESOLVE_REF_READING, &iter->oid, &flags))
     -+			iter->base.referent = refs_resolve_ref_unsafe(&iter->refs->base,
     ++			referent = refs_resolve_ref_unsafe(&iter->refs->base,
      +								      iter->ref.refname,
      +								      RESOLVE_REF_READING,
      +								      &iter->oid,
      +								      &flags);
     -+			if (!iter->base.referent)
     ++			if (!referent)
       				oidclr(&iter->oid, the_repository->hash_algo);
       			break;
       		default:
     +@@ refs/reftable-backend.c: static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
     + 				continue;
     + 
     + 		iter->base.refname = iter->ref.refname;
     ++		iter->base.referent = referent;
     + 		iter->base.oid = &iter->oid;
     + 		iter->base.flags = flags;
     + 
 2:  1f3a604fae7 = 2:  0b6e732ad7e refs: add referent to each_ref_fn
 3:  3e147e7d850 ! 3:  83b70ab8287 ref-filter: populate symref from iterator
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## ref-filter.c ##
     +@@ ref-filter.c: static int populate_value(struct ref_array_item *ref, struct strbuf *err)
     + 
     + 	CALLOC_ARRAY(ref->value, used_atom_cnt);
     + 
     ++	/**
     ++	 * NEEDSWORK: The following code might be unncessary if all codepaths
     ++	 * that call populate_value() populates the symref member of ref_array_item
     ++	 * like in apply_ref_filter(). Currently pretty_print_ref() is the only codepath
     ++	 * that calls populate_value() without first populating symref.
     ++	 */
     + 	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
     + 		ref->symref = refs_resolve_refdup(get_main_ref_store(the_repository),
     + 						  ref->refname,
      @@ ref-filter.c: static int filter_ref_kind(struct ref_filter *filter, const char *refname)
       	return ref_kind_from_refname(refname);
       }
     @@ ref-filter.c: static struct ref_array_item *apply_ref_filter(const char *refname
       	ref->commit = commit;
       	ref->flag = flag;
       	ref->kind = kind;
     -+	if (flag & REF_ISSYMREF)
     -+		ref->symref = xstrdup_or_null(referent);
     ++	ref->symref = xstrdup_or_null(referent);
       
       	return ref;
       }

-- 
gitgitgadget
