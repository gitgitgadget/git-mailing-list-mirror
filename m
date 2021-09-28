Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0C7C433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19576611C3
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 20:11:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242610AbhI1UMo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 16:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242568AbhI1UMo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 16:12:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB4BC06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:04 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id w4-20020a056902100400b005b6b29d9a27so134134ybt.20
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 13:11:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=x787tYsGp+u5xxJcSy4zMAuCI1u5BIWH2eV4xNAxr0s=;
        b=TT7hS8pSKg87mistj+2IJQFpFquMsPaMsSP0jdxeM7tKx+O/Jm4fvL1K5MkYFvZRUO
         WGHvnjvP8gyoqbAvOhgwD4sxKlrN+95e3LshSrLl7PWxdfFjmmzVDhcRSLEjimzBwjHs
         40qX6mvo9hzB3au0WilHrJcKPuNDp1IsZma0ZZGjxE7EpukdR1Qm11rMA0hEIQQlOjXy
         R5qSnl25wY0bKe9Pr3ybNVtTqfoRY6aklyxZq03aXcAxoD+S3X9LjCrnLgaCrPRfx+DK
         82ZPZFtJWiJiQIk+pQq+D03/8FLx3Cne1tcd9jLtdBO2qanSdZmYIbpTum9s5P4DEWU7
         hfkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=x787tYsGp+u5xxJcSy4zMAuCI1u5BIWH2eV4xNAxr0s=;
        b=KrN0PRA4vqHK4mYNXOPm2mjTf3KnOhBFhJynTbVmnM8j9225Ex0jOSaR9k9jigTJmB
         nAHYz503a6lIbMk+QxWF8D0xZ5+m3zWcs9AQLLq9/N/h3Ldw87gpcZRO0vDuVhlqZeCa
         jDT5n72F3gnRlJD62h5ZAZNUTkSBmytxl5+s7BaOY83wbJwwkB1XD155yJgzPejpmSFH
         b0NvRlLcZCdTns/INZCwvtoPoN8hFQyhnjlQLtc+CjCiW/ScwUfAHb00NEaqwiID7q8N
         sTkAyv1pV62s1zU+/zxtWfN4d9/bgHdHkJOEFJ7JY1rg670p4EUu0gojvy/ZISiji7Yw
         zcRQ==
X-Gm-Message-State: AOAM532ihMHvbed4nqfEkTbbWuMMCwZI7cbhT989pMDOWt8ufy+Y2Puy
        FnlbRxEJiubVM1n0UErZf5byI6nfDip/MDHdGPU1n+txsV+scuh17QZYni4kap98cukmhofx5AL
        oCJSzDhYD107ieCiTfEA7M4VGjFm76lijQGTvUrnxyaIAsI//hrfk2gtnME+1sl0T8dkMEnNpFh
        q6
X-Google-Smtp-Source: ABdhPJyVrv9o+6wBrxX+n2c0znos1po7pDyKt8nmA2SDApRwfkqWn+8Zk7EXEq9F21eM95cJ44VYw2uDQBqT0vRYogh/
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a25:7e81:: with SMTP id
 z123mr9231833ybc.64.1632859863318; Tue, 28 Sep 2021 13:11:03 -0700 (PDT)
Date:   Tue, 28 Sep 2021 13:10:46 -0700
In-Reply-To: <cover.1632242495.git.jonathantanmy@google.com>
Message-Id: <cover.1632859147.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1632242495.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
Subject: [PATCH v2 0/9] No more adding submodule ODB as alternate
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, peff@peff.net,
        newren@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is on a merge of jk/ref-paranoia and jt/add-submodule-odb-clean-up.

As requested, I've rebased this on jk/ref-paranoia and updated the ref
iterator code to no longer remove the DO_FOR_EACH_INCLUDE_BROKEN flag.
I've also changed how I handled the new repository field - instead of
storing it in the backend-independent struct ref_iterator, I now have
each backend handling it. This is a smaller change from the status quo
(each backend having implicit dependence on the_repository -> each
backend having explicit dependence on a repo).

The first 3 patches are rewritten, and the last 5 patches are the same
as before. Patch 4 is also the same as before, except that a change to
do_for_each_ref() to add a repo parameter was previously done in patch 1
of the v1 patchset and is no longer done in the corresponding patch of
this v2 patchset, so that needed to be done there.

Jonathan Tan (9):
  refs: plumb repo param in begin-iterator functions
  refs: teach arbitrary repo support to iterators
  refs: peeling non-the_repository iterators is BUG
  refs: teach refs_for_each_ref() arbitrary repos
  merge-{ort,recursive}: remove add_submodule_odb()
  object-file: only register submodule ODB if needed
  submodule: pass repo to check_has_commit()
  refs: change refs_for_each_ref_in() to take repo
  submodule: trace adding submodule ODB as alternate

 builtin/submodule--helper.c            | 16 ++++---
 merge-ort.c                            | 18 ++------
 merge-recursive.c                      | 41 ++++++++---------
 object-file.c                          |  3 +-
 object-name.c                          |  4 +-
 refs.c                                 | 63 ++++++++++++++------------
 refs.h                                 | 12 ++---
 refs/debug.c                           |  4 +-
 refs/files-backend.c                   | 13 ++++--
 refs/packed-backend.c                  | 17 +++++--
 refs/ref-cache.c                       | 10 ++++
 refs/ref-cache.h                       |  1 +
 refs/refs-internal.h                   |  4 +-
 revision.c                             | 12 ++---
 strbuf.c                               | 12 +++--
 strbuf.h                               |  6 ++-
 submodule.c                            | 28 ++++++++++--
 t/helper/test-ref-store.c              | 20 ++++----
 t/t5526-fetch-submodules.sh            |  3 ++
 t/t5531-deep-submodule-push.sh         |  3 ++
 t/t5545-push-options.sh                |  3 ++
 t/t5572-pull-submodule.sh              |  3 ++
 t/t6437-submodule-merge.sh             |  3 ++
 t/t7418-submodule-sparse-gitmodules.sh |  3 ++
 24 files changed, 186 insertions(+), 116 deletions(-)

Range-diff against v1:
 1:  493fff7f47 <  -:  ---------- refs: make _advance() check struct repo, not flag
 2:  e404b5eb1a <  -:  ---------- refs: add repo paramater to _iterator_peel()
 -:  ---------- >  1:  e364b13a37 refs: plumb repo param in begin-iterator functions
 3:  3ed77eedb8 !  2:  ec153eff7b refs iterator: support non-the_repository advance
    @@ Metadata
     Author: Jonathan Tan <jonathantanmy@google.com>
     
      ## Commit message ##
    -    refs iterator: support non-the_repository advance
    +    refs: teach arbitrary repo support to iterators
     
    -    Support repositories other than the_repository when advancing through an
    -    iterator.
    +    Note that should_pack_ref() is called when writing refs, which is only
    +    supported for the_repository, hence the_repository is hardcoded there.
     
         Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
     
    @@ refs.c: int refname_is_safe(const char *refname)
      	}
     
      ## refs/files-backend.c ##
    +@@ refs/files-backend.c: struct files_ref_iterator {
    + 	struct ref_iterator base;
    + 
    + 	struct ref_iterator *iter0;
    ++	struct repository *repo;
    + 	unsigned int flags;
    + };
    + 
    +@@ refs/files-backend.c: static int files_ref_iterator_advance(struct ref_iterator *ref_iterator)
    + 
    + 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
    + 		    !ref_resolves_to_object(iter->iter0->refname,
    ++					    iter->repo,
    + 					    iter->iter0->oid,
    + 					    iter->iter0->flags))
    + 			continue;
    +@@ refs/files-backend.c: static struct ref_iterator *files_ref_iterator_begin(
    + 	base_ref_iterator_init(ref_iterator, &files_ref_iterator_vtable,
    + 			       overlay_iter->ordered);
    + 	iter->iter0 = overlay_iter;
    ++	iter->repo = repo;
    + 	iter->flags = flags;
    + 
    + 	return ref_iterator;
     @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
      		return 0;
      
    @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
      
      	return 1;
     
    - ## refs/iterator.c ##
    -@@ refs/iterator.c: int ref_iterator_advance(struct ref_iterator *ref_iterator)
    - {
    - 	int ok;
    + ## refs/packed-backend.c ##
    +@@ refs/packed-backend.c: struct packed_ref_iterator {
    + 	struct object_id oid, peeled;
    + 	struct strbuf refname_buf;
    + 
    ++	struct repository *repo;
    + 	unsigned int flags;
    + };
      
    --	if (ref_iterator->repo && ref_iterator->repo != the_repository)
    --		/*
    --		 * NEEDSWORK: make ref_resolves_to_object() support
    --		 * arbitrary repositories
    --		 */
    --		BUG("ref_iterator->repo must be NULL or the_repository");
    - 	while ((ok = ref_iterator->vtable->advance(ref_iterator)) == ITER_OK) {
    - 		if (ref_iterator->repo &&
    - 		    !ref_resolves_to_object(ref_iterator->refname,
    -+					    ref_iterator->repo,
    - 					    ref_iterator->oid,
    - 					    ref_iterator->flags))
    +@@ refs/packed-backend.c: static int packed_ref_iterator_advance(struct ref_iterator *ref_iterator)
      			continue;
    + 
    + 		if (!(iter->flags & DO_FOR_EACH_INCLUDE_BROKEN) &&
    +-		    !ref_resolves_to_object(iter->base.refname, &iter->oid,
    +-					    iter->flags))
    ++		    !ref_resolves_to_object(iter->base.refname, iter->repo,
    ++					    &iter->oid, iter->flags))
    + 			continue;
    + 
    + 		return ITER_OK;
    +@@ refs/packed-backend.c: static struct ref_iterator *packed_ref_iterator_begin(
    + 
    + 	iter->base.oid = &iter->oid;
    + 
    ++	iter->repo = repo;
    + 	iter->flags = flags;
    + 
    + 	if (prefix && *prefix)
     
      ## refs/refs-internal.h ##
     @@ refs/refs-internal.h: int refname_is_safe(const char *refname);
 -:  ---------- >  3:  dd1a8871f4 refs: peeling non-the_repository iterators is BUG
 4:  f3a45fba84 !  4:  da0c9c2d44 refs: teach refs_for_each_ref() arbitrary repos
    @@ refs.c: int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
      }
      
      struct ref_iterator *refs_ref_iterator_begin(
    +@@ refs.c: static int do_for_each_ref_helper(struct repository *r,
    + 
    + static int do_for_each_ref(struct ref_store *refs, const char *prefix,
    + 			   each_ref_fn fn, int trim,
    ++			   struct repository *repo,
    + 			   enum do_for_each_ref_flags flags, void *cb_data)
    + {
    + 	struct ref_iterator *iter;
     @@ refs.c: static int do_for_each_ref(struct ref_store *refs, const char *prefix,
    + 	if (!refs)
    + 		return 0;
    + 
    +-	iter = refs_ref_iterator_begin(refs, prefix, trim, the_repository, flags);
    ++	iter = refs_ref_iterator_begin(refs, prefix, trim, repo, flags);
    + 
    +-	return do_for_each_repo_ref_iterator(the_repository, iter,
    ++	return do_for_each_repo_ref_iterator(repo, iter,
      					do_for_each_ref_helper, &hp);
      }
      
     -int refs_for_each_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
     +int refs_for_each_ref(struct repository *repo, each_ref_fn fn, void *cb_data)
      {
    --	return do_for_each_ref(refs, "", fn, 0, the_repository, 0, cb_data);
    +-	return do_for_each_ref(refs, "", fn, 0, 0, cb_data);
     +	return do_for_each_ref(get_main_ref_store(repo), "", fn, 0, repo, 0, cb_data);
      }
      
    @@ refs.c: static int do_for_each_ref(struct ref_store *refs, const char *prefix,
      }
      
      int refs_for_each_ref_in(struct ref_store *refs, const char *prefix,
    + 			 each_ref_fn fn, void *cb_data)
    + {
    +-	return do_for_each_ref(refs, prefix, fn, strlen(prefix), 0, cb_data);
    ++	return do_for_each_ref(refs, prefix, fn, strlen(prefix), the_repository, 0, cb_data);
    + }
    + 
    + int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
    +@@ refs.c: int for_each_ref_in(const char *prefix, each_ref_fn fn, void *cb_data)
    + int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
    + {
    + 	return do_for_each_ref(get_main_ref_store(the_repository),
    +-			       prefix, fn, 0, 0, cb_data);
    ++			       prefix, fn, 0, the_repository, 0, cb_data);
    + }
    + 
    + int refs_for_each_fullref_in(struct ref_store *refs, const char *prefix,
    + 			     each_ref_fn fn, void *cb_data)
    + {
    +-	return do_for_each_ref(refs, prefix, fn, 0, 0, cb_data);
    ++	return do_for_each_ref(refs, prefix, fn, 0, the_repository, 0, cb_data);
    + }
    + 
    + int for_each_replace_ref(struct repository *r, each_repo_ref_fn fn, void *cb_data)
    +@@ refs.c: int for_each_namespaced_ref(each_ref_fn fn, void *cb_data)
    + 	int ret;
    + 	strbuf_addf(&buf, "%srefs/", get_git_namespace());
    + 	ret = do_for_each_ref(get_main_ref_store(the_repository),
    +-			      buf.buf, fn, 0, 0, cb_data);
    ++			      buf.buf, fn, 0, the_repository, 0, cb_data);
    + 	strbuf_release(&buf);
    + 	return ret;
    + }
    + 
    + int refs_for_each_rawref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
    + {
    +-	return do_for_each_ref(refs, "", fn, 0,
    ++	return do_for_each_ref(refs, "", fn, 0, the_repository,
    + 			       DO_FOR_EACH_INCLUDE_BROKEN, cb_data);
    + }
    + 
     @@ refs.c: static struct ref_store *ref_store_init(const char *gitdir,
      
      struct ref_store *get_main_ref_store(struct repository *r)
 5:  0655a321bd !  5:  dd70820d66 merge-{ort,recursive}: remove add_submodule_odb()
    @@ Commit message
         merge-{ort,recursive}: remove add_submodule_odb()
     
         After the parent commit and some of its ancestors, the only place
    -    commits are being accessed through alternates are in the user-facing
    +    commits are being accessed through alternates is in the user-facing
         message formatting code. Fix those, and remove the add_submodule_odb()
         calls.
     
 6:  a62741e779 =  6:  9c5ce004b2 object-file: only register submodule ODB if needed
 7:  20adc937b7 =  7:  1fca3b1a25 submodule: pass repo to check_has_commit()
 8:  efebc4e97d !  8:  7b5087a14d refs: change refs_for_each_ref_in() to take repo
    @@ refs.c: int for_each_ref(each_ref_fn fn, void *cb_data)
     +	return refs_for_each_ref_in(the_repository, prefix, fn, cb_data);
      }
      
    - int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data, unsigned int broken)
    + int for_each_fullref_in(const char *prefix, each_ref_fn fn, void *cb_data)
     
      ## refs.h ##
     @@ refs.h: int refs_head_ref(struct repository *repo,
 9:  933c505de8 =  9:  cef2a97840 submodule: trace adding submodule ODB as alternate
-- 
2.33.0.685.g46640cef36-goog

