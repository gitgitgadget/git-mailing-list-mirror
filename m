Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F751C7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:11:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239136AbjEKSLH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:11:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238397AbjEKSLE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:11:04 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BBA58690
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:40 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f315735514so295529865e9.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828637; x=1686420637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3q5J+mYP7ohToB0pqYz6lSFzcMovWrT5rQzxkTkRdA8=;
        b=nFwSBop84NcuH/405wyFRwNaJU07U07KU+putX9vguU9hKKTLnDxI5eu/9lePLFpPR
         lj1HNxmxdULdv7sr/eMw1FXdrxvod9DXtFzgbL1KpHm8P+VtizC4QScr1lGCO9nYsDO3
         Nbl+KOuPiAf2VAFN/cCLxxgbwgNYyyxvPWbqdjArB2Mk5/cEfMcEUFwvxmBt5wB+7qdf
         +VQyvK2pLQHfpGqTOSF7W0khyUm5BBt+X68VmQzTLfPW1gFY2n+WoYz1sBOuV2fLp/y9
         dd6vnLh+oOnTxjh4zAySD5WOKw5xd9nRnAFdRcU6mrE3WaH7T2tkoOrgAkbuCDJOD+6Z
         mzTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828637; x=1686420637;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3q5J+mYP7ohToB0pqYz6lSFzcMovWrT5rQzxkTkRdA8=;
        b=lLrxhMM2Lf4vuk/S/8IEn30Zaa5Crt/m7qdjtd+bMnRtKaFQq90LkSByoG2EsQhw4O
         u/F+aEC0UtTEKucdScRuC10MqF5uR7Uwyv59Sf4/jZXnKJ5wblbYX298DY+GwxR0CFAb
         MoCyrjjLGchMGPEAdU7zhlJ5P06OkSSN5t+/EjeRKFlXTBLw1MaSOsvOQ49S0YafgmwN
         ZWzl2Io8MK2RnLrd9QK3gSk952/MI0ZtwmODeActMKE7W201pnbBMnv9tNprwjw6RbNa
         gAneS/Ss0804yvb3Y25ZSBnodX6JoY0wxOIJMVJrNxCe2sQZzFtmeZ6WxTLEmLTZ2SCC
         OicA==
X-Gm-Message-State: AC+VfDwISpVfk47I7l44i7+TVTZamnED2yGFyIHx5FhDjGdWCGPm4LFv
        s5SCj9mxFwS2LNBPBUfQ8aYWr3tS+hs=
X-Google-Smtp-Source: ACHHUZ6XpL1gvnxvu/3kzWpzJX4hCUiCu7KJ6Ip5doCpA1P+xZe16+j2i3yE81HgGrJJ7M3RRkCFgg==
X-Received: by 2002:adf:e584:0:b0:2fe:e455:666c with SMTP id l4-20020adfe584000000b002fee455666cmr18802626wrm.33.1683828636651;
        Thu, 11 May 2023 11:10:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p1-20020a5d4581000000b0030639a86f9dsm20968331wrq.51.2023.05.11.11.10.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:10:36 -0700 (PDT)
Message-Id: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 18:10:30 +0000
Subject: [PATCH v3 0/4] pack-refs: allow users control over which refs to pack
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

Changes since v2:

 * repurpose ref_exclusions to be used for ref inclusions
 * fixed test formatting
 * adjusted --include to not include default of all tags

Changes since v1:

 * Clarify that --all packs not just branch tips but all refs under refs/ in
   the documentation in patch 1
 * Add --include in patch 3

It's worth noting that [1] discussed a proposal for a pack refs v2 format
that would improve deletion speeds. The ref-table backend would also improve
performance of deletions. However, both of those proposals are still being
discussed.

 1. https://lore.kernel.org/git/pull.1408.git.1667846164.gitgitgadget@gmail.com/

John Cai (4):
  docs: clarify git-pack-refs --all will pack all refs
  pack-refs: teach --exclude option to exclude refs from being packed
  revision: modify ref_exclusions to handle inclusions
  pack-refs: teach pack-refs --include option

 Documentation/git-pack-refs.txt | 31 ++++++++++++--
 builtin/pack-refs.c             | 34 ++++++++++++++--
 builtin/rev-parse.c             | 18 ++++-----
 refs.c                          |  4 +-
 refs.h                          |  7 +++-
 refs/debug.c                    |  4 +-
 refs/files-backend.c            | 23 ++++++-----
 refs/packed-backend.c           |  2 +-
 refs/refs-internal.h            |  3 +-
 revision.c                      | 71 ++++++++++++++++++++-------------
 revision.h                      | 28 ++++++++-----
 t/helper/test-ref-store.c       |  9 ++++-
 t/t3210-pack-refs.sh            | 37 +++++++++++++++++
 13 files changed, 199 insertions(+), 72 deletions(-)


base-commit: 91428f078b8a4fe6948a4c955af1a693841e3985
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1501%2Fjohn-cai%2Fjc%2Fexclude-refs-from-pack-refs-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1501/john-cai/jc/exclude-refs-from-pack-refs-v3
Pull-Request: https://github.com/git/git/pull/1501

Range-diff vs v2:

 1:  0b40b24b95d = 1:  0d462010b79 docs: clarify git-pack-refs --all will pack all refs
 2:  027b3f85a0b ! 2:  8c5c66a3050 pack-refs: teach --exclude option to exclude refs from being packed
     @@ Commit message
          pack-refs: teach --exclude option to exclude refs from being packed
      
          At GitLab, we have a system that creates ephemeral internal refs that
     -    don't live long before getting deleted. Having an option to not include
     +    don't live long before getting deleted. Having an option to exclude
          certain refs from a packed-refs file allows these internal references to
          be deleted much more efficiently.
      
     @@ builtin/pack-refs.c
      +			N_("references to exclude")),
       		OPT_END(),
       	};
     -+
       	git_config(git_default_config, NULL);
       	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
       		usage_with_options(pack_refs_usage, opts);
     @@ refs/files-backend.c: static void prune_refs(struct files_ref_store *refs, struc
       {
       	/* Do not pack per-worktree refs: */
       	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
     -@@ refs/files-backend.c: static int should_pack_ref(const char *refname,
     + 	    REF_WORKTREE_SHARED)
       		return 0;
       
     ++	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
     ++		return 0;
     ++
       	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
      -	if (!(pack_flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
      +	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
     @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       
       	/* Do not pack symbolic refs: */
      @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
     - 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
     - 		return 0;
     - 
     -+	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
     -+		return 0;
     -+
       	return 1;
       }
       
     @@ refs/refs-internal.h: typedef int ref_transaction_commit_fn(struct ref_store *re
       			     const char *ref_target,
       			     const char *refs_heads_master,
      
     + ## revision.h ##
     +@@ revision.h: struct rev_cmdline_info {
     + struct ref_exclusions {
     + 	/*
     + 	 * Excluded refs is a list of wildmatch patterns. If any of the
     +-	 * patterns matches, the reference will be excluded.
     ++	 * patterns match, the reference will be excluded.
     + 	 */
     + 	struct string_list excluded_refs;
     + 
     +
       ## t/helper/test-ref-store.c ##
      @@ t/helper/test-ref-store.c: static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
       static int cmd_pack_refs(struct ref_store *refs, const char **argv)
     @@ t/t3210-pack-refs.sh: test_expect_success \
            git branch -d n/o/p &&
            git branch n'
       
     -+test_expect_success \
     -+    'test excluded refs are not packed' '
     -+     git branch dont_pack1 &&
     -+     git branch dont_pack2 &&
     -+     git branch pack_this &&
     -+     git pack-refs --all --exclude refs/heads/dont_pack* &&
     -+     test -f .git/refs/heads/dont_pack1 &&
     -+     test -f .git/refs/heads/dont_pack2 &&
     -+     ! test -f ./git/refs/heads/pack_this'
     ++test_expect_success 'test excluded refs are not packed' '
     ++	git branch dont_pack1 &&
     ++	git branch dont_pack2 &&
     ++	git branch pack_this &&
     ++	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
     ++	test -f .git/refs/heads/dont_pack1 &&
     ++	test -f .git/refs/heads/dont_pack2 &&
     ++	! test -f ./git/refs/heads/pack_this'
      +
     -+test_expect_success \
     -+    'test --no-exclude refs clears excluded refs' '
     -+     git branch dont_pack3 &&
     -+     git branch dont_pack4 &&
     -+     git pack-refs --all --exclude refs/heads/dont_pack* --no-exclude &&
     -+     ! test -f .git/refs/heads/dont_pack3 &&
     -+     ! test -f .git/refs/heads/dont_pack4'
     ++test_expect_success 'test --no-exclude refs clears excluded refs' '
     ++	git branch dont_pack3 &&
     ++	git branch dont_pack4 &&
     ++	git pack-refs --all --exclude "refs/heads/dont_pack*" --no-exclude &&
     ++	! test -f .git/refs/heads/dont_pack3 &&
     ++	! test -f .git/refs/heads/dont_pack4'
      +
       test_expect_success \
       	'see if up-to-date packed refs are preserved' \
 -:  ----------- > 3:  0a0693ad612 revision: modify ref_exclusions to handle inclusions
 3:  03950e8f120 ! 4:  b2f3b98cd24 pack-refs: teach pack-refs --include option
     @@ Documentation/git-pack-refs.txt: interests.
      +
      +Pack refs based on a `glob(7)` pattern. Repetitions of this option
      +accumulate inclusion patterns. If a ref is both included in `--include` and
     -+`--exclude`, `--exclude` takes precedence. Using `--include` does not preclude
     -+all tags from being included by default. Symbolic refs and broken refs will never
     ++`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
     ++tags from being included by default. Symbolic refs and broken refs will never
      +be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
      +and reset the list of patterns.
      +
     @@ Documentation/git-pack-refs.txt: unpack it.
       When used with `--all`, it will use the difference between the set of all refs,
       and what is provided to `--exclude`.
       
     -+When used with `--include`, it will use what is provided to `--include` as well
     -+as the the default of all tags and already packed refs, minus refs that are
     -+provided to `--exclude`.
     ++When used with `--include`, refs provided to `--include`, minus refs that are
     ++provided to `--exclude` will be packed.
      +
       
       BUGS
     @@ Documentation/git-pack-refs.txt: unpack it.
      
       ## builtin/pack-refs.c ##
      @@
     + #include "refs.h"
     + #include "repository.h"
       #include "revision.h"
     ++#include "trace.h"
       
       static char const * const pack_refs_usage[] = {
      -	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
     @@ builtin/pack-refs.c
      @@ builtin/pack-refs.c: int cmd_pack_refs(int argc, const char **argv, const char *prefix)
       {
       	unsigned int flags = PACK_REFS_PRUNE;
     - 	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
     --	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
     -+	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
     -+	struct pack_refs_opts pack_refs_opts = { .exclusions = &excludes,
     -+						 .flags = flags,
     -+						 .included_refs = &included_refs };
     -+
     + 	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
     +-	struct pack_refs_opts pack_refs_opts = {.visibility = &visibility, .flags = flags};
     ++	struct pack_refs_opts pack_refs_opts = { .visibility = &visibility,
     ++						 .flags = flags };
       	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
     ++	static struct string_list option_included_refs = STRING_LIST_INIT_NODUP;
       	struct string_list_item *item;
       
       	struct option opts[] = {
       		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
       		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
     -+		OPT_STRING_LIST(0, "include", pack_refs_opts.included_refs, N_("pattern"),
     ++		OPT_STRING_LIST(0, "include", &option_included_refs, N_("pattern"),
      +			N_("references to include")),
       		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
       			N_("references to exclude")),
       		OPT_END(),
     -
     - ## refs.h ##
     -@@ refs.h: struct worktree;
     - struct pack_refs_opts {
     - 	unsigned int flags;
     - 	struct ref_exclusions *exclusions;
     -+	struct string_list *included_refs;
     - };
     +@@ builtin/pack-refs.c: int cmd_pack_refs(int argc, const char **argv, const char *prefix)
     + 	for_each_string_list_item(item, &option_excluded_refs)
     + 		add_ref_exclusion(pack_refs_opts.visibility, item->string);
       
     - const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     ++	for_each_string_list_item(item, &option_included_refs)
     ++		add_ref_inclusion(pack_refs_opts.visibility, item->string);
     ++
     ++	if (pack_refs_opts.flags & PACK_REFS_ALL)
     ++		add_ref_inclusion(pack_refs_opts.visibility, "*");
     ++
     ++	if (!pack_refs_opts.visibility->included_refs.nr)
     ++		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
     ++
     + 	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
     + }
      
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       	    REF_WORKTREE_SHARED)
       		return 0;
       
     -+	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
     -+		return 0;
     -+
     -+	if (opts->included_refs && opts->included_refs->nr) {
     -+		struct string_list_item *item;
     -+
     -+		for_each_string_list_item(item, opts->included_refs)
     -+			if (!wildmatch(item->string, refname, 0))
     -+				return 1;
     -+	}
     -+
     - 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
     - 	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
     +-	if (opts->visibility && ref_excluded(opts->visibility, refname))
     +-		return 0;
     +-
     +-	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
     +-	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
     +-		return 0;
     +-
     + 	/* Do not pack symbolic refs: */
     + 	if (ref_flags & REF_ISSYMREF)
       		return 0;
      @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
       		return 0;
       
     --	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
     --		return 0;
     --
     - 	return 1;
     +-	return 1;
     ++	if (opts->visibility && ref_excluded(opts->visibility, refname))
     ++		return 0;
     ++
     ++	if (opts->visibility && ref_included(opts->visibility, refname))
     ++		return 1;
     ++
     ++	return 0;
       }
       
     + static int files_pack_refs(struct ref_store *ref_store,
     +
     + ## t/helper/test-ref-store.c ##
     +@@
     + #include "worktree.h"
     + #include "object-store.h"
     + #include "repository.h"
     ++#include "revision.h"
     + 
     + struct flag_definition {
     + 	const char *name;
     +@@ t/helper/test-ref-store.c: static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
     + static int cmd_pack_refs(struct ref_store *refs, const char **argv)
     + {
     + 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
     +-	struct pack_refs_opts pack_opts = { .flags = flags };
     ++	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
     ++	struct pack_refs_opts pack_opts = { .flags = flags,
     ++					    .visibility = &visibility };
     ++
     ++	if (pack_opts.flags & PACK_REFS_ALL)
     ++		add_ref_inclusion(pack_opts.visibility, "*");
     + 
     + 	return refs_pack_refs(refs, &pack_opts);
     + }
      
       ## t/t3210-pack-refs.sh ##
     -@@ t/t3210-pack-refs.sh: test_expect_success \
     -      ! test -f .git/refs/heads/dont_pack3 &&
     -      ! test -f .git/refs/heads/dont_pack4'
     +@@ t/t3210-pack-refs.sh: test_expect_success 'test --no-exclude refs clears excluded refs' '
     + 	! test -f .git/refs/heads/dont_pack3 &&
     + 	! test -f .git/refs/heads/dont_pack4'
       
     -+test_expect_success \
     -+    'test only included refs are packed' '
     -+     git branch pack_this1 &&
     -+     git branch pack_this2 &&
     -+     git tag dont_pack5 &&
     -+     git pack-refs --include refs/tags/pack_this* --exclude refs/tags/dont_pack* &&
     -+     test -f .git/refs/tags/dont_pack5 &&
     -+     ! test -f ./git/refs/heads/pack_this1 &&
     -+     ! test -f ./git/refs/heads/pack_this2'
     ++test_expect_success 'test only included refs are packed' '
     ++	git branch pack_this1 &&
     ++	git branch pack_this2 &&
     ++	git tag dont_pack5 &&
     ++	git pack-refs --include "refs/heads/pack_this*" &&
     ++	test -f .git/refs/tags/dont_pack5 &&
     ++	! test -f ./git/refs/heads/pack_this1 &&
     ++	! test -f ./git/refs/heads/pack_this2'
     ++
     ++test_expect_success 'test --no-include refs clears included refs' '
     ++	git branch pack1 &&
     ++	git branch pack2 &&
     ++	git pack-refs --include "refs/heads/pack*" --no-include &&
     ++	test -f .git/refs/heads/pack1 &&
     ++	test -f .git/refs/heads/pack2'
     ++
     ++test_expect_success 'test --exclude takes precedence over --include' '
     ++	git branch dont_pack5 &&
     ++	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
     ++	test -f .git/refs/heads/dont_pack5'
      +
       test_expect_success \
       	'see if up-to-date packed refs are preserved' \

-- 
gitgitgadget
