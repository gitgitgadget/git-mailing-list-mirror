Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A44DBC7EE24
	for <git@archiver.kernel.org>; Thu, 11 May 2023 18:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239172AbjEKSLM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 May 2023 14:11:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239097AbjEKSLF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 May 2023 14:11:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 574F859C9
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:43 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f42c865535so35010495e9.1
        for <git@vger.kernel.org>; Thu, 11 May 2023 11:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683828639; x=1686420639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owB2XbBuAy7BfVLhS6ZUa1LnzDFPKxnqC/ILRkr5XeY=;
        b=VXQyJWdsG0L7Y1GGNlAO+VD8Di4ZVLPfgHsYRRxnwlQp+L7Hc0wVN/E7yW6amQOWPJ
         xAWrz+LsFXP8Cf/6fcGG/CP/2iAwooqIW+qptqaR7lT+NxOL6JdloA80eH5mCn95CN48
         gQYl/QljrUiBpVGFMlQszvPMqhQf3tUwozO1MPCJqPB2X5ptdYp2IyvxNEt/KzWMd/Bu
         fJ1f759PhUuA+4KWusapAcRaqYUDXwsGLUUgdj9uNGDKmJgkiheAS3Bdu3alTrsBFe2W
         Pgt1mfEOb99h16ZCO8ncfFyrqFKFyqCdSETIch2Fpjli03rXGWw+jnD4CWkCaQey51yy
         kqvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683828639; x=1686420639;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owB2XbBuAy7BfVLhS6ZUa1LnzDFPKxnqC/ILRkr5XeY=;
        b=H7o9XlPCwRKgt7x+DdIuxDJ+9m8VMocay9r7xg7GBu5q7rxkEHsHzT1NBX4dJw5FnM
         e11lL8T2KGtrmbzxAz5Y98JAo890gmb13pZa+wCCtvIkRNedyN4DirPqH7ZLmM02LqxK
         PAB+FmgXjouq5PXoZv3CndeYvXdH9ShFkRjYn9pvtlO3Zd4j/0guBiHlyrrJXnHeZdV9
         EEPKm06x5PLtJaj1NEVvv03d7xRvkCW3PdH3G8q0zBqYN7J2kECMmo7Fhf8svWHkjX9e
         ON5r1nqRUmoCiz4l+nOmc1olOw1H9VHt/bAydsx9pXlCD82EeswWCnkJp6NAf51+mBVd
         AG8Q==
X-Gm-Message-State: AC+VfDwCvpLb+ckDdk9aChVxCqjRHPpCJUPJ6W1fQxip+f90gPl6iJ62
        tfOi3zp9YyV2t0/w9jmkLPbRn79iWg0=
X-Google-Smtp-Source: ACHHUZ79rMgoTL0Oh4lOYc0QZGN/NvjxSxl1h2O34/PTCzMrWPUEDNcMaH3hvw/lRYN6E44FYh1+kg==
X-Received: by 2002:a5d:4008:0:b0:306:39e5:f338 with SMTP id n8-20020a5d4008000000b0030639e5f338mr13146618wrp.62.1683828639303;
        Thu, 11 May 2023 11:10:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c3-20020a7bc843000000b003f31d44f0cbsm26535845wml.29.2023.05.11.11.10.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 May 2023 11:10:38 -0700 (PDT)
Message-Id: <b2f3b98cd2461a25ab708adbcd8a95f5e2b18e5e.1683828635.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
References: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
        <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 11 May 2023 18:10:34 +0000
Subject: [PATCH v3 4/4] pack-refs: teach pack-refs --include option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Allow users to be more selective over which refs to pack by adding an
--include option to git-pack-refs.

The existing options allow some measure of selectivity. By default
git-pack-refs packs all tags. --all can be used to include all refs,
and the previous commit added the ability to exclude certain refs with
--exclude.

While these knobs give the user some selection over which refs to pack,
it could be useful to give more control. For instance, a repository may
have a set of branches that are rarely updated and would benefit from
being packed. --include would allow the user to easily include a set of
branches to be packed while leaving everything else unpacked.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 Documentation/git-pack-refs.txt | 14 +++++++++++++-
 builtin/pack-refs.c             | 18 ++++++++++++++++--
 refs/files-backend.c            | 15 +++++++--------
 t/helper/test-ref-store.c       |  8 +++++++-
 t/t3210-pack-refs.sh            | 21 +++++++++++++++++++++
 5 files changed, 64 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index c0f7426e519..85874a5f5dc 100644
--- a/Documentation/git-pack-refs.txt
+++ b/Documentation/git-pack-refs.txt
@@ -8,7 +8,7 @@ git-pack-refs - Pack heads and tags for efficient repository access
 SYNOPSIS
 --------
 [verse]
-'git pack-refs' [--all] [--no-prune] [--exclude <pattern>]
+'git pack-refs' [--all] [--no-prune] [--include <pattern>] [--exclude <pattern>]
 
 DESCRIPTION
 -----------
@@ -60,6 +60,15 @@ interests.
 The command usually removes loose refs under `$GIT_DIR/refs`
 hierarchy after packing them.  This option tells it not to.
 
+--include <pattern>::
+
+Pack refs based on a `glob(7)` pattern. Repetitions of this option
+accumulate inclusion patterns. If a ref is both included in `--include` and
+`--exclude`, `--exclude` takes precedence. Using `--include` will preclude all
+tags from being included by default. Symbolic refs and broken refs will never
+be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
+and reset the list of patterns.
+
 --exclude <pattern>::
 
 Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
@@ -70,6 +79,9 @@ unpack it.
 When used with `--all`, it will use the difference between the set of all refs,
 and what is provided to `--exclude`.
 
+When used with `--include`, refs provided to `--include`, minus refs that are
+provided to `--exclude` will be packed.
+
 
 BUGS
 ----
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 2464575a665..5062206f22e 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -5,9 +5,10 @@
 #include "refs.h"
 #include "repository.h"
 #include "revision.h"
+#include "trace.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
+	N_("git pack-refs [--all] [--no-prune] [--include <pattern>] [--exclude <pattern>]"),
 	NULL
 };
 
@@ -15,13 +16,17 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
 	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
-	struct pack_refs_opts pack_refs_opts = {.visibility = &visibility, .flags = flags};
+	struct pack_refs_opts pack_refs_opts = { .visibility = &visibility,
+						 .flags = flags };
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
+	static struct string_list option_included_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_STRING_LIST(0, "include", &option_included_refs, N_("pattern"),
+			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
 			N_("references to exclude")),
 		OPT_END(),
@@ -33,5 +38,14 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.visibility, item->string);
 
+	for_each_string_list_item(item, &option_included_refs)
+		add_ref_inclusion(pack_refs_opts.visibility, item->string);
+
+	if (pack_refs_opts.flags & PACK_REFS_ALL)
+		add_ref_inclusion(pack_refs_opts.visibility, "*");
+
+	if (!pack_refs_opts.visibility->included_refs.nr)
+		add_ref_inclusion(pack_refs_opts.visibility, "refs/tags/*");
+
 	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
 }
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 3ef19199788..c669cf8001a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1183,13 +1183,6 @@ static int should_pack_ref(const char *refname,
 	    REF_WORKTREE_SHARED)
 		return 0;
 
-	if (opts->visibility && ref_excluded(opts->visibility, refname))
-		return 0;
-
-	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
-	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
-		return 0;
-
 	/* Do not pack symbolic refs: */
 	if (ref_flags & REF_ISSYMREF)
 		return 0;
@@ -1198,7 +1191,13 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
-	return 1;
+	if (opts->visibility && ref_excluded(opts->visibility, refname))
+		return 0;
+
+	if (opts->visibility && ref_included(opts->visibility, refname))
+		return 1;
+
+	return 0;
 }
 
 static int files_pack_refs(struct ref_store *ref_store,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index de4197708d9..0dec1223362 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "object-store.h"
 #include "repository.h"
+#include "revision.h"
 
 struct flag_definition {
 	const char *name;
@@ -116,7 +117,12 @@ static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
-	struct pack_refs_opts pack_opts = { .flags = flags };
+	static struct ref_visibility visibility = REF_VISIBILITY_INIT;
+	struct pack_refs_opts pack_opts = { .flags = flags,
+					    .visibility = &visibility };
+
+	if (pack_opts.flags & PACK_REFS_ALL)
+		add_ref_inclusion(pack_opts.visibility, "*");
 
 	return refs_pack_refs(refs, &pack_opts);
 }
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index ddfc1b6e5f1..9ff6326b646 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -124,6 +124,27 @@ test_expect_success 'test --no-exclude refs clears excluded refs' '
 	! test -f .git/refs/heads/dont_pack3 &&
 	! test -f .git/refs/heads/dont_pack4'
 
+test_expect_success 'test only included refs are packed' '
+	git branch pack_this1 &&
+	git branch pack_this2 &&
+	git tag dont_pack5 &&
+	git pack-refs --include "refs/heads/pack_this*" &&
+	test -f .git/refs/tags/dont_pack5 &&
+	! test -f ./git/refs/heads/pack_this1 &&
+	! test -f ./git/refs/heads/pack_this2'
+
+test_expect_success 'test --no-include refs clears included refs' '
+	git branch pack1 &&
+	git branch pack2 &&
+	git pack-refs --include "refs/heads/pack*" --no-include &&
+	test -f .git/refs/heads/pack1 &&
+	test -f .git/refs/heads/pack2'
+
+test_expect_success 'test --exclude takes precedence over --include' '
+	git branch dont_pack5 &&
+	git pack-refs --include "refs/heads/pack*" --exclude "refs/heads/pack*" &&
+	test -f .git/refs/heads/dont_pack5'
+
 test_expect_success \
 	'see if up-to-date packed refs are preserved' \
 	'git branch q &&
-- 
gitgitgadget
