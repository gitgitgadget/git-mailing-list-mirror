Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D32C77B7C
	for <git@archiver.kernel.org>; Fri, 12 May 2023 21:35:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239645AbjELVe6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 May 2023 17:34:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239977AbjELVes (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2023 17:34:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD78635A4
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f42711865eso43624945e9.0
        for <git@vger.kernel.org>; Fri, 12 May 2023 14:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683927285; x=1686519285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W7VJpD/Gxdcpj+V2XvtomJ+Hb31NcBvO91AQNfAH+vw=;
        b=Oc81KpHUvcEHKLzSpAavc2c86MoxE1ovfPfd9j1bN9GdBWMwSHa6EftRgTHA+yjbFE
         vTuGgpfUSlD6gcezPoWJmiGrYzdMaqSliJw5UBnom6QbYs8vkmZ/WcuSuKp4vYCIqLE+
         rlS5Fm/tLsuGKIj55zluf/aHEbxtaUgH1A2+KZ799XSD8yb2v/rTiD/2uxi37QqV8ekc
         MfiHdt1qcvc4Yq6HOBDxBrMtGlvR2ECZRQV9QXH7ikt3xH2nrU3U5wT9BRtUWvCDUG5j
         smM+LPsMfBOwyc9IAYpVbCxE+5+ZQGP+kJaITffdlvBJmBaQc4hgln9voCu0lx//0VTg
         wqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683927285; x=1686519285;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W7VJpD/Gxdcpj+V2XvtomJ+Hb31NcBvO91AQNfAH+vw=;
        b=lba0RjHUJdR5xpxzWb/8fM25ADYoSbsFt128q3XRH7PQfkS1l6uDu0veSJuINhvalL
         UTVaQ0jyaekSeUMJg2gBLMpM/FARWmQYvdzrvy8VoyqdHekqI0yZ9QI6ghy32zY3GBgq
         Dnd71iGgysMbtpozfB1y75iv6KYt2L2ENN/pQvB+yFwvYTVvAe8ngN0PXCIwo0UtJd2e
         MAbufi2Mtm6E2QJK91LKA98eFOpKn86EPUz7Bw6dCf7E1zKPphz6dIVWv8rM2PNaDhE5
         7H4WOu9rF2oETu4sBJBsiiasKbLfx5On+qY/JxiSrNJT3wW2MctJYOL1NM+yQPDnVYhs
         YK9g==
X-Gm-Message-State: AC+VfDz0NyuKNaBtqUQxp/GArqGHx2UjmJJDFa0bwEmj6cl6orhiVrZs
        oX3wjyGOqdb1M9XaEE7OGu7VPgIvLxQ=
X-Google-Smtp-Source: ACHHUZ7NdeXRQ/y54tmlwNaX735kx6KSjXmGL96OmBnhwj8LhE7SZv14zIZKNOL2zX1zWj1aBrwHMA==
X-Received: by 2002:a7b:c3cf:0:b0:3f4:220a:bbf8 with SMTP id t15-20020a7bc3cf000000b003f4220abbf8mr14841522wmj.34.1683927285091;
        Fri, 12 May 2023 14:34:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id x20-20020a1c7c14000000b003f17af4c4e0sm29493598wmc.9.2023.05.12.14.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 May 2023 14:34:44 -0700 (PDT)
Message-Id: <4bbe4c05cebf5cb15310807d3998eb93a481470e.1683927282.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
References: <pull.1501.v3.git.git.1683828635.gitgitgadget@gmail.com>
        <pull.1501.v4.git.git.1683927282.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 May 2023 21:34:42 +0000
Subject: [PATCH v4 3/3] pack-refs: teach pack-refs --include option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        John Cai <johncai86@gmail.com>
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
 builtin/pack-refs.c             | 15 +++++++++++++--
 refs.h                          |  1 +
 refs/files-backend.c            | 18 ++++++++++--------
 t/helper/test-ref-store.c       | 10 +++++++++-
 t/t3210-pack-refs.sh            | 21 +++++++++++++++++++++
 6 files changed, 67 insertions(+), 12 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index 546aa122dff..284956acb3c 100644
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
@@ -60,6 +60,15 @@ with many branches of historical interests.
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
 When used with `--all`, pack only loose refs which do not match any of
 the provided `--exclude` patterns.
 
+When used with `--include`, refs provided to `--include`, minus refs that are
+provided to `--exclude` will be packed.
+
 
 BUGS
 ----
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 1d1a64fe386..bcf383cac9d 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -7,7 +7,7 @@
 #include "revision.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
+	N_("git pack-refs [--all] [--no-prune] [--include <pattern>] [--exclude <pattern>]"),
 	NULL
 };
 
@@ -15,13 +15,18 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
 	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
-	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
+	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_refs_opts = { .exclusions = &excludes,
+						 .includes = &included_refs,
+						 .flags = flags };
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
+			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
 			N_("references to exclude")),
 		OPT_END(),
@@ -33,5 +38,11 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
 
+	if (pack_refs_opts.flags & PACK_REFS_ALL)
+		string_list_append(pack_refs_opts.includes, "*");
+
+	if (!pack_refs_opts.includes->nr)
+		string_list_append(pack_refs_opts.includes, "refs/tags/*");
+
 	return refs_pack_refs(get_main_ref_store(the_repository), &pack_refs_opts);
 }
diff --git a/refs.h b/refs.h
index 46020bd335c..933fdebe584 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,7 @@ struct worktree;
 struct pack_refs_opts {
 	unsigned int flags;
 	struct ref_exclusions *exclusions;
+	struct string_list *includes;
 };
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 5075e6c0d28..629e95ff857 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1178,18 +1178,13 @@ static int should_pack_ref(const char *refname,
 			   const struct object_id *oid, unsigned int ref_flags,
 			   struct pack_refs_opts *opts)
 {
+	struct string_list_item *item;
+
 	/* Do not pack per-worktree refs: */
 	if (parse_worktree_ref(refname, NULL, NULL, NULL) !=
 	    REF_WORKTREE_SHARED)
 		return 0;
 
-	if (ref_excluded(opts->exclusions, refname))
-		return 0;
-
-	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
-	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
-		return 0;
-
 	/* Do not pack symbolic refs: */
 	if (ref_flags & REF_ISSYMREF)
 		return 0;
@@ -1198,7 +1193,14 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
-	return 1;
+	if (ref_excluded(opts->exclusions, refname))
+		return 0;
+
+	for_each_string_list_item(item, opts->includes)
+		if (!wildmatch(item->string, refname, 0))
+			return 1;
+
+	return 0;
 }
 
 static int files_pack_refs(struct ref_store *ref_store,
diff --git a/t/helper/test-ref-store.c b/t/helper/test-ref-store.c
index de4197708d9..a6977b5e839 100644
--- a/t/helper/test-ref-store.c
+++ b/t/helper/test-ref-store.c
@@ -5,6 +5,7 @@
 #include "worktree.h"
 #include "object-store.h"
 #include "repository.h"
+#include "revision.h"
 
 struct flag_definition {
 	const char *name;
@@ -116,7 +117,14 @@ static struct flag_definition pack_flags[] = { FLAG_DEF(PACK_REFS_PRUNE),
 static int cmd_pack_refs(struct ref_store *refs, const char **argv)
 {
 	unsigned int flags = arg_flags(*argv++, "flags", pack_flags);
-	struct pack_refs_opts pack_opts = { .flags = flags };
+	static struct ref_exclusions exclusions = REF_EXCLUSIONS_INIT;
+	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_opts = { .flags = flags,
+					    .exclusions = &exclusions,
+					    .includes = &included_refs };
+
+	if (pack_opts.flags & PACK_REFS_ALL)
+		string_list_append(pack_opts.includes, "*");
 
 	return refs_pack_refs(refs, &pack_opts);
 }
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 925b90cd3ba..9f399d2f75a 100755
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
+	! test -f .git/refs/heads/pack_this1 &&
+	! test -f .git/refs/heads/pack_this2'
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
