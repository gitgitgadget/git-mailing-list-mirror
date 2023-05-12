Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA33FC77B75
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:35:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239902AbjELVfD (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239808AbjELVer (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:34:47 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A951BE3
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:45 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3f41d087b24so54100865e9.1
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QXUWnZCXybMVe/Z9BubfmPH92y9R1VU/OkLVq/FVXLk=;
        b=HYdQPM2rfl6d46LQo40rnpouVZeQjOKyxVDF7gCgG3mxbPPn4mnoXdA6nzHJw0BEFp
         SjhmGtLxhq5zomlS7KS/cL/STHoh28Pf9vNbufcsjiTi0l/JihpyDbQeX/M8lQQMFkha
         htPdqJeZDBdhqUvXuxBt89AE4aCiWr4UHAoh2Dqg947LVEpmPcwRQ1zZpmKo6/X9n8BV
         +fvdyQPrQy/I7TTOkIlJH57wNhsjGVG/P5K42Ici/n58Ov9NXXepy5WujC9alXKJ/Yw5
         kcqXrlFI9GJr+lk/3/fVqMpkr7xfoN4J19r6IyGj8aHGic4csX3DLMbqI4FJKyq/m5J4
         MpTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927284; x=1686519284;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QXUWnZCXybMVe/Z9BubfmPH92y9R1VU/OkLVq/FVXLk=;
        b=KeHGLBm8uKmPk55YOkFE8BeaowCyLxgQp8E1YsdzcJJZnAM9Z5sH77kQkog+GM4iGl
         tBMfLOxJWiR6+6N2jzQZt2eJyYFZZSDg8fF15vqBok2DLpq1zLge7n76HKc4Xbu2ERJX
         ScE3JNXHx5jqJ5dE54pvsG8+5XnHfJl5BwP2CaSygqxBQt+8fyZ+XPl5CbsYh/vyfIpq
         vNMnDpFIE7IZmlbNA+W3lmp2cTNit62aKuUqJm1C8p95QLzA8v6Bg7Fziy48Y0mvHISK
         LVIWkW2SQuPFLgfNdNH+6cbgQNPt4XpNiHYwD+RCFIPNLmqby9hJdN6yMsdKUfjn7Phf
         9rAQ==
X-Gm-Message-State: AC+VfDxLwSMT6pQ8FuQFjv9txpY3KzIV+9g0dt+imEKm4fo7W1c4WC0U
        PGw/oZgQdaomjNEgEm1S//6Q6Mu+N5c=
X-Google-Smtp-Source: ACHHUZ4s7xFIzMQ4vYPzsvzf/XLqCy/gxLCLlweMG/Sc5VIatyMOMR2bJuJX7Ze99diNbSmNmuP1nQ==
X-Received: by 2002:a7b:c4c3:0:b0:3f1:75ae:1cfe with SMTP id g3-20020a7bc4c3000000b003f175ae1cfemr17709219wmk.7.1683927283512;
        Fri, 12 May 2023 14:34:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020adfdec6000000b002c70ce264bfsm24416776wrn.76.2023.05.12.14.34.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:34:43 -0700 (PDT)
Message-Id: <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
References: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 21:34:39 +0000
Subject: [PATCH v4 0/3] pack-refs: allow users control over which refs to pack
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

git-pack-refs does not currently give much control over which refs are
packed. By default, all tags and already packed refs are packed. --all
allows the user to pack all refs. Beyond this the user does not have
control. Introduce a pair of options --include and --exclude that will allow
users full control over which refs end up in the packed-refs file.

Changes since v3:

 * got rid of extending ref_exclusions
 * use a strvec instead of a string_list to keep track of included refs

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

John Cai (3):
  docs: clarify git-pack-refs --all will pack all refs
  pack-refs: teach --exclude option to exclude refs from being packed
  pack-refs: teach pack-refs --include option

 Documentation/git-pack-refs.txt | 29 +++++++++++++++++++++++---
 builtin/pack-refs.c             | 31 +++++++++++++++++++++++----
 refs.c                          |  4 ++--
 refs.h                          |  8 ++++++-
 refs/debug.c                    |  4 ++--
 refs/files-backend.c            | 26 ++++++++++++++---------
 refs/packed-backend.c           |  2 +-
 refs/refs-internal.h            |  3 ++-
 revision.h                      |  2 +-
 t/helper/test-ref-store.c       | 11 +++++++++-
 t/t3210-pack-refs.sh            | 37 +++++++++++++++++++++++++++++++++
 11 files changed, 131 insertions(+), 26 deletions(-)


base-commit: 91428f078b8a4fe6948a4c955af1a693841e3985
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1501%2Fjohn-cai%2Fjc%2Fexclude-refs-from-pack-refs-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1501/john-cai/jc/exclude-refs-from-pack-refs-v4
Pull-Request: https://github.com/git/git/pull/1501

Range-diff vs v3:

 1:  0d462010b79 ! 1:  554da1dc705 docs: clarify git-pack-refs --all will pack all refs
     @@ Commit message
          Signed-off-by: John Cai <johncai86@gmail.com>
      
       ## Documentation/git-pack-refs.txt ##
     -@@ Documentation/git-pack-refs.txt: OPTIONS
     - 
     - The command by default packs all tags and refs that are already
     +@@ Documentation/git-pack-refs.txt: The command by default packs all tags and refs that are already
       packed, and leaves other refs
     --alone.  This is because branches are expected to be actively
     -+alone. This is because branches are expected to be actively
     + alone.  This is because branches are expected to be actively
       developed and packing their tips does not help performance.
      -This option causes branch tips to be packed as well.  Useful for
      -a repository with many branches of historical interests.
     -+This option causes all refs to be packed as well, with the exception of hidden
     -+and broken refs. Useful for a repository with many branches of historical
     -+interests.
     ++This option causes all refs to be packed as well, with the exception
     ++of hidden refs, broken refs, and symbolic refs. Useful for a repository
     ++with many branches of historical interests.
       
       --no-prune::
       
 2:  8c5c66a3050 ! 2:  69300845df1 pack-refs: teach --exclude option to exclude refs from being packed
     @@ Documentation/git-pack-refs.txt: git-pack-refs - Pack heads and tags for efficie
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-pack-refs.txt: interests.
     +@@ Documentation/git-pack-refs.txt: with many branches of historical interests.
       The command usually removes loose refs under `$GIT_DIR/refs`
       hierarchy after packing them.  This option tells it not to.
       
     @@ Documentation/git-pack-refs.txt: interests.
      +patterns. If a ref is already packed, including it with `--exclude` will not
      +unpack it.
      +
     -+When used with `--all`, it will use the difference between the set of all refs,
     -+and what is provided to `--exclude`.
     ++When used with `--all`, pack only loose refs which do not match any of
     ++the provided `--exclude` patterns.
      +
       
       BUGS
     @@ refs/files-backend.c: static void prune_refs(struct files_ref_store *refs, struc
       	    REF_WORKTREE_SHARED)
       		return 0;
       
     -+	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
     ++	if (ref_excluded(opts->exclusions, refname))
      +		return 0;
      +
       	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
     @@ t/t3210-pack-refs.sh: test_expect_success \
      +	git pack-refs --all --exclude "refs/heads/dont_pack*" &&
      +	test -f .git/refs/heads/dont_pack1 &&
      +	test -f .git/refs/heads/dont_pack2 &&
     -+	! test -f ./git/refs/heads/pack_this'
     ++	! test -f .git/refs/heads/pack_this'
      +
      +test_expect_success 'test --no-exclude refs clears excluded refs' '
      +	git branch dont_pack3 &&
 3:  0a0693ad612 < -:  ----------- revision: modify ref_exclusions to handle inclusions
 4:  b2f3b98cd24 ! 3:  4bbe4c05ceb pack-refs: teach pack-refs --include option
     @@ Documentation/git-pack-refs.txt: git-pack-refs - Pack heads and tags for efficie
       
       DESCRIPTION
       -----------
     -@@ Documentation/git-pack-refs.txt: interests.
     +@@ Documentation/git-pack-refs.txt: with many branches of historical interests.
       The command usually removes loose refs under `$GIT_DIR/refs`
       hierarchy after packing them.  This option tells it not to.
       
     @@ Documentation/git-pack-refs.txt: interests.
       
       Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
      @@ Documentation/git-pack-refs.txt: unpack it.
     - When used with `--all`, it will use the difference between the set of all refs,
     - and what is provided to `--exclude`.
     + When used with `--all`, pack only loose refs which do not match any of
     + the provided `--exclude` patterns.
       
      +When used with `--include`, refs provided to `--include`, minus refs that are
      +provided to `--exclude` will be packed.
     @@ Documentation/git-pack-refs.txt: unpack it.
      
       ## builtin/pack-refs.c ##
      @@
     - #include "refs.h"
     - #include "repository.h"
       #include "revision.h"
     -+#include "trace.h"
       
       static char const * const pack_refs_usage[] = {
      -	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
     @@ builtin/pack-refs.c
      @@ builtin/pack-refs.c: int cmd_pack_refs(int argc, const char **argv, const char *prefix)
       {
       	unsigned int flags = PACK_REFS_PRUNE;
     - 	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
     --	struct pack_refs_opts pack_refs_opts = {.visibility = &visibility, .flags = flags};
     -+	struct pack_refs_opts pack_refs_opts = { .visibility = &visibility,
     + 	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
     +-	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
     ++	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
     ++	struct pack_refs_opts pack_refs_opts = { .exclusions = &excludes,
     ++						 .includes = &included_refs,
      +						 .flags = flags };
       	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
     -+	static struct string_list option_included_refs = STRING_LIST_INIT_NODUP;
       	struct string_list_item *item;
       
       	struct option opts[] = {
       		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
       		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
     -+		OPT_STRING_LIST(0, "include", &option_included_refs, N_("pattern"),
     ++		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
      +			N_("references to include")),
       		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
       			N_("references to exclude")),
       		OPT_END(),
      @@ builtin/pack-refs.c: int cmd_pack_refs(int argc, const char **argv, const char *prefix)
       	for_each_string_list_item(item, &option_excluded_refs)
     - 		add_ref_exclusion(pack_refs_opts.visibility, item->string);
     + 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
       
     -+	for_each_string_list_item(item, &option_included_refs)
     -+		add_ref_inclusion(pack_refs_opts.visibility, item->string);
     -+
      +	if (pack_refs_opts.flags & PACK_REFS_ALL)
     -+		add_ref_inclusion(pack_refs_opts.visibility, "*");
     ++		string_list_append(pack_refs_opts.includes, "*");
      +
     -+	if (!pack_refs_opts.visibility->included_refs.nr)
     -+		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
     ++	if (!pack_refs_opts.includes->nr)
     ++		string_list_append(pack_refs_opts.includes, "refs/tags/*");
      +
       	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
       }
      
     + ## refs.h ##
     +@@ refs.h: struct worktree;
     + struct pack_refs_opts {
     + 	unsigned int flags;
     + 	struct ref_exclusions *exclusions;
     ++	struct string_list *includes;
     + };
     + 
     + const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     +
       ## refs/files-backend.c ##
      @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
     + 			   const struct object_id *oid, unsigned int ref_flags,
     + 			   struct pack_refs_opts *opts)
     + {
     ++	struct string_list_item *item;
     ++
     + 	/* Do not pack per-worktree refs: */
     + 	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
       	    REF_WORKTREE_SHARED)
       		return 0;
       
     --	if (opts->visibility && ref_excluded(opts->visibility, refname))
     +-	if (ref_excluded(opts->exclusions, refname))
      -		return 0;
      -
      -	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
     @@ refs/files-backend.c: static int should_pack_ref(const char *refname,
       		return 0;
       
      -	return 1;
     -+	if (opts->visibility && ref_excluded(opts->visibility, refname))
     ++	if (ref_excluded(opts->exclusions, refname))
      +		return 0;
      +
     -+	if (opts->visibility && ref_included(opts->visibility, refname))
     -+		return 1;
     ++	for_each_string_list_item(item, opts->includes)
     ++		if (!wildmatch(item->string, refname, 0))
     ++			return 1;
      +
      +	return 0;
       }
     @@ t/helper/test-ref-store.c: static struct flag_definition pack_flags[] = { FLAG_D
       {
       	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
      -	struct pack_refs_opts pack_opts = { .flags = flags };
     -+	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
     ++	static struct ref_exclusions exclusions = REF_EXCLUSIONS_INIT;
     ++	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
      +	struct pack_refs_opts pack_opts = { .flags = flags,
     -+					    .visibility = &visibility };
     ++					    .exclusions = &exclusions,
     ++					    .includes = &included_refs };
      +
      +	if (pack_opts.flags & PACK_REFS_ALL)
     -+		add_ref_inclusion(pack_opts.visibility, "*");
     ++		string_list_append(pack_opts.includes, "*");
       
       	return refs_pack_refs(refs, &pack_opts);
       }
     @@ t/t3210-pack-refs.sh: test_expect_success 'test --no-exclude refs clears exclude
      +	git tag dont_pack5 &&
      +	git pack-refs --include "refs/heads/pack_this*" &&
      +	test -f .git/refs/tags/dont_pack5 &&
     -+	! test -f ./git/refs/heads/pack_this1 &&
     -+	! test -f ./git/refs/heads/pack_this2'
     ++	! test -f .git/refs/heads/pack_this1 &&
     ++	! test -f .git/refs/heads/pack_this2'
      +
      +test_expect_success 'test --no-include refs clears included refs' '
      +	git branch pack1 &&

-- 
gitgitgadget
