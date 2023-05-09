Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07D35C7EE23
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:19:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234437AbjEITS7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjEITS5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:18:57 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C52F422A
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:18:55 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f315712406so221463775e9.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:18:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659933; x=1686251933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ipTwC/d7JwjM/w6R1slaN4/FSPvrQMAOtKGhdfq3JK4=;
        b=P9YMvw2jQpbMyNa7jxnztoVHdf0Lpd0cw0XsavMQnzuAaL4fcrdcpc8LN5rgTHnvkO
         cupg30qyNnNVs7HAUihm90n+7fHfsxG9iwDshrKGf5PN8sijZC0EcQaAa/rqjMtg9bFI
         VHvBikBH72BvIVjKoqzNmyQoOeZU4AOf+l8ygh9D5N9LzNwioUlcVaddcHnLxLiYyuR4
         XhoGTUtBkrCrown6SCVMHOPfA2vbxJuVNnuwmgDsZYOSCJG7PlDwmwyo9iI6g7z/jnFG
         Xmh/QftqHV8k+xjl3bOXXpsovsxpAiA3tpVn/dhR9Nz90z5EU1Q59uwu73Zisl36RdLi
         HNkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659933; x=1686251933;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ipTwC/d7JwjM/w6R1slaN4/FSPvrQMAOtKGhdfq3JK4=;
        b=DCxhllexUpF7URD4YeRs/hsxi3jNwlrblZDHuB2S4dclaAOXmQ1ww1mNs/NYzznt2P
         9Xe+DqWwceHY4K0SzdnUebZseuVuuUHSnUchnBVzPM9y3TXW9wCWtXjI/OgS1PIN2oXm
         ov4hdyvMSoAZnP1v0H5GmVhsLEmyKeJ0jBbXDm8ToWo3VZvURrGkFA7IlJENRwUmfBy5
         4MOfwM3qRnOry+ACqTuA5pP/fwXDr1T7gmSRPQGV6MDlssnmpfOM3IL3Y5nXBQImRSrZ
         fQ515ugH+z7dYRsmpVndWi6LpIiSWMAb2Jc5hjCGj9p/NbNBoo3R6ks5o3PCbb/VRP0K
         fJWg==
X-Gm-Message-State: AC+VfDw5hKTZL5LEIPlVZm1ztb/sx2UBTSH1Fi2xz5zCsKIbT53iEE7K
        LDUE3wYM95zaczSO0ERgUouc4CNAo+Y=
X-Google-Smtp-Source: ACHHUZ4ntUWCx+gObzIdQygsfb1Ir3jzxACabojm0PEWDtVzjVy3PHRZc4pKNiszueBRk8acFRH5Fw==
X-Received: by 2002:a5d:514e:0:b0:307:91a0:ede1 with SMTP id u14-20020a5d514e000000b0030791a0ede1mr6476627wrt.7.1683659933364;
        Tue, 09 May 2023 12:18:53 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a05600c204100b003ed2c0a0f37sm20685445wmg.35.2023.05.09.12.18.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:18:53 -0700 (PDT)
Message-Id: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 May 2023 19:18:48 +0000
Subject: [PATCH v2 0/3] pack-refs: Teach --exclude option to exclude refs from being packed
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-pack-refs does not currently give much control over which refs are
packed. By default, all tags and already packed refs are packed. --all
allows the user to pack all refs. Beyond this the user does not have
control. Introduce a pair of options --include and --exclude that will allow
users full control over which refs end up in the packed-refs file.

Changes since v1:

 * Clarify that --all packs not just branch tips but all refs under refs/ in
   the documentation in patch 1
 * Add --include in patch 3

It's worth noting that [1] discussed a proposal for a pack refs v2 format
that would improve deletion speeds. The ref-table backend would also improve
performance of deletions. However, both of those proposals are still being
discussed.

 1. https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/

John Cai (3):
  docs: clarify git-pack-refs --all will pack all refs
  pack-refs: teach --exclude option to exclude refs from being packed
  pack-refs: teach pack-refs --include option

 Documentation/git-pack-refs.txt | 32 ++++++++++++++++++++++++++++----
 builtin/pack-refs.c             | 27 +++++++++++++++++++++++----
 refs.c                          |  4 ++--
 refs.h                          |  8 +++++++-
 refs/debug.c                    |  4 ++--
 refs/files-backend.c            | 24 ++++++++++++++++++------
 refs/packed-backend.c           |  2 +-
 refs/refs-internal.h            |  3 ++-
 t/helper/test-ref-store.c       |  3 ++-
 t/t3210-pack-refs.sh            | 28 ++++++++++++++++++++++++++++
 10 files changed, 113 insertions(+), 22 deletions(-)


base-commit: f85cd430b12b0d3e4f1a30ef3239a1b73d5f6331
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1501%2Fjohn-cai%2Fjc%2Fexclude-refs-from-pack-refs-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1501/john-cai/jc/exclude-refs-from-pack-refs-v2
Pull-Request: https://github.com/git/git/pull/1501

Range-diff vs v1:

 -:  ----------- > 1:  0b40b24b95d docs: clarify git-pack-refs --all will pack all refs
 1:  fb4d5b911ae ! 2:  027b3f85a0b pack-refs: teach --exclude option to exclude refs from being packed
     @@
       ## Metadata ##
     -Author: John Cai <jcai@gitlab.com>
     +Author: John Cai <johncai86@gmail.com>
      
       ## Commit message ##
          pack-refs: teach --exclude option to exclude refs from being packed
      
     -    Currently once refs are packed into a pack-refs file, deleting them can be
     -    slow since it involves a full file scan of the entire pack-refs file. At
     -    GitLab, we have a system that creates ephemeral internal refs that don't
     -    live long before getting deleted. Having an option to not include certain
     -    refs from a pack-refs file allows these internal references to be deleted
     -    much more efficiently.
     +    At GitLab, we have a system that creates ephemeral internal refs that
     +    don't live long before getting deleted. Having an option to not include
     +    certain refs from a packed-refs file allows these internal references to
     +    be deleted much more efficiently.
      
          Add an --exclude option to the pack-refs builtin, and use the ref
          exclusions API to exclude certain refs from being packed into the final
     -    pack-refs file
     +    packed-refs file
      
          Signed-off-by: John Cai <johncai86@gmail.com>
      
     @@ Documentation/git-pack-refs.txt: git-pack-refs - Pack heads and tags for efficie
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-pack-refs.txt: a repository with many branches of historical interests.
     +@@ Documentation/git-pack-refs.txt: interests.
       The command usually removes loose refs under `$GIT_DIR/refs`
       hierarchy after packing them.  This option tells it not to.
       
     @@ Documentation/git-pack-refs.txt: a repository with many branches of historical i
      +
      +Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
      +accumulate exclusion patterns. Use `--no-exclude` to clear and reset the list of
     -+patterns.
     ++patterns. If a ref is already packed, including it with `--exclude` will not
     ++unpack it.
     ++
     ++When used with `--all`, it will use the difference between the set of all refs,
     ++and what is provided to `--exclude`.
      +
       
       BUGS
     @@ builtin/pack-refs.c
       {
       	unsigned int flags = PACK_REFS_PRUNE;
      +	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
     -+	struct pack_refs_opts pack_opts = {.exclusions = &excludes};
     ++	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
      +	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
      +	struct string_list_item *item;
      +
       	struct option opts[] = {
     - 		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
     - 		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
     +-		OPT_BIT(0, "all",   &flags, N_("pack everything"), PACK_REFS_ALL),
     +-		OPT_BIT(0, "prune", &flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
     ++		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
     ++		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
      +		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
      +			N_("references to exclude")),
       		OPT_END(),
     @@ builtin/pack-refs.c
      -	return refs_pack_refs(get_main_ref_store(the_repository), flags);
      +
      +	for_each_string_list_item(item, &option_excluded_refs)
     -+		add_ref_exclusion(pack_opts.exclusions, item->string);
     ++		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
      +
     -+	return refs_pack_refs(get_main_ref_store(the_repository), flags, &pack_opts);
     ++	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
       }
      
       ## refs.c ##
     @@ refs.c: void base_ref_store_init(struct ref_store *refs, struct repository *repo
       
       /* backend functions */
      -int refs_pack_refs(struct ref_store *refs, unsigned int flags)
     -+int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *pack_opts)
     ++int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts)
       {
      -	return refs->be->pack_refs(refs, flags);
     -+	return refs->be->pack_refs(refs, flags, pack_opts);
     ++	return refs->be->pack_refs(refs, opts);
       }
       
       int peel_iterated_oid(const struct object_id *base, struct object_id *peeled)
     @@ refs.h: struct worktree;
       #define RESOLVE_REF_ALLOW_BAD_NAME 0x04
       
      +struct pack_refs_opts {
     ++	unsigned int flags;
      +	struct ref_exclusions *exclusions;
      +};
      +
     @@ refs.h: void warn_dangling_symrefs(FILE *fp, const char *msg_fmt,
        * flags: Combination of the above PACK_REFS_* flags.
        */
      -int refs_pack_refs(struct ref_store *refs, unsigned int flags);
     -+int refs_pack_refs(struct ref_store *refs, unsigned int flags, struct pack_refs_opts *opts);
     ++int refs_pack_refs(struct ref_store *refs, struct pack_refs_opts *opts);
       
       /*
        * Setup reflog before using. Fill in err and return -1 on failure.
     @@ refs/debug.c: static int debug_initial_transaction_commit(struct ref_store *refs
       }
       
      -static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags)
     -+static int debug_pack_refs(struct ref_store *ref_store, unsigned int flags, struct pack_refs_opts *opts)
     ++static int debug_pack_refs(struct ref_store *ref_store, struct pack_refs_opts *opts)
       {
       	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      -	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
     -+	int res = drefs->refs->be->pack_refs(drefs->refs, flags, opts);
     ++	int res = drefs->refs->be->pack_refs(drefs->refs, opts);
       	trace_printf_key(&trace_refs, "pack_refs: %d\n", res);
       	return res;
       }
     @@ refs/files-backend.c: static void prune_refs(struct files_ref_store *refs, struc
       static int should_pack_ref(const char *refname,
       			   const struct object_id *oid, unsigned int ref_flags,
      -			   unsigned int pack_flags)
     -+			   unsigned int pack_flags,
      +			   struct pack_refs_opts *opts)
       {
       	/* Do not pack per-worktree refs: */
       	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
     +@@ refs/files-backend.c: static int should_pack_ref(const char *refname,
     + 		return 0;
     + 
     + 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
     +-	if (!(pack_flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
     ++	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
     + 		return 0;
     + 
     + 	/* Do not pack symbolic refs: */
      @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
       		return 0;
     @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       
      -static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
      +static int files_pack_refs(struct ref_store *ref_store,
     -+			   unsigned int flags,
     -+			   struct pack_refs_opts *pack_opts)
     ++			   struct pack_refs_opts *opts)
       {
       	struct files_ref_store *refs =
       		files_downcast(ref_store, REF_STORE_WRITE | REF_STORE_ODB,
      @@ refs/files-backend.c: static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
     + 		 * in the packed ref cache. If the reference should be
       		 * pruned, also add it to refs_to_prune.
       		 */
     - 		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
     +-		if (!should_pack_ref(iter->refname, iter->oid, iter->flags,
      -				     flags))
     -+				     flags, pack_opts))
     ++		if (!should_pack_ref(iter->refname, iter->oid, iter->flags, opts))
       			continue;
       
       		/*
     +@@ refs/files-backend.c: static int files_pack_refs(struct ref_store *ref_store, unsigned int flags)
     + 			    iter->refname, err.buf);
     + 
     + 		/* Schedule the loose reference for pruning if requested. */
     +-		if ((flags & PACK_REFS_PRUNE)) {
     ++		if ((opts->flags & PACK_REFS_PRUNE)) {
     + 			struct ref_to_prune *n;
     + 			FLEX_ALLOC_STR(n, name, iter->refname);
     + 			oidcpy(&n->oid, iter->oid);
      
       ## refs/packed-backend.c ##
      @@ refs/packed-backend.c: static int packed_delete_refs(struct ref_store *ref_store, const char *msg,
     @@ refs/packed-backend.c: static int packed_delete_refs(struct ref_store *ref_store
       
       static int packed_pack_refs(struct ref_store *ref_store UNUSED,
      -			    unsigned int flags UNUSED)
     -+			    unsigned int flags UNUSED,
      +			    struct pack_refs_opts *pack_opts UNUSED)
       {
       	/*
     @@ refs/refs-internal.h: typedef int ref_transaction_commit_fn(struct ref_store *re
       
      -typedef int pack_refs_fn(struct ref_store *ref_store, unsigned int flags);
      +typedef int pack_refs_fn(struct ref_store *ref_store,
     -+			 unsigned int flags,
      +			 struct pack_refs_opts *opts);
       typedef int create_symref_fn(struct ref_store *ref_store,
       			     const char *ref_target,
     @@ t/helper/test-ref-store.c: static struct flag_definition pack_flags[] = { FLAG_D
       static int cmd_pack_refs(struct ref_store *refs, const char **argv)
       {
       	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
     -+	struct pack_refs_opts pack_opts = { 0 };
     ++	struct pack_refs_opts pack_opts = { .flags = flags };
       
      -	return refs_pack_refs(refs, flags);
     -+	return refs_pack_refs(refs, flags, &pack_opts);
     ++	return refs_pack_refs(refs, &pack_opts);
       }
       
       static int cmd_create_symref(struct ref_store *refs, const char **argv)
 -:  ----------- > 3:  03950e8f120 pack-refs: teach pack-refs --include option

-- 
gitgitgadget
