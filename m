Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F376C7EE22
	for <git@archiver.kernel.org>; Tue,  9 May 2023 19:19:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234768AbjEITTF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 May 2023 15:19:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234420AbjEITS7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 May 2023 15:18:59 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C22423A
        for <git@vger.kernel.org>; Tue,  9 May 2023 12:18:57 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3f417ea5252so26815265e9.0
        for <git@vger.kernel.org>; Tue, 09 May 2023 12:18:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683659935; x=1686251935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aSvfGA6ZeDgICLM7bAi9aYm+Y1F51ka/7GJxA/PERUY=;
        b=KNBjuIaDm48B/PJKQlR23eHBvuNoas/Lle6rWyqt76YCsioQq378JT2qg9BeqAbaDt
         2x747DVxKtcfNJsUK+qcgfY+dxsREUcd9pDqS7RUVVycDGgiRCLE6+PwnwFFK+pRqDrZ
         QRQYH1cda+0v/AhVPF+NxyaCwGk3whODY0MYGm+DraVRbDgSHGxeZg7a/9sDF253fm39
         mykD6WS3H2E/FpF4uL0MfusY5v/Y0HOhYtv9oko2lcYo6HhF1hnLKvYTMVgC7dXGRs7J
         tFCr8Z3dYddF1zDEqw65VP7gNFvZZ6j5kQItJuurP4BsImhOTSBI8cTIWcu/qrlSbpqJ
         6/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683659935; x=1686251935;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aSvfGA6ZeDgICLM7bAi9aYm+Y1F51ka/7GJxA/PERUY=;
        b=loVhEUGAh3ZRgdSlyrvQ+v+J0dXFCDmIYhYSGm6uJJ9HEjPwG24SxeXxpS7Dikg1Lk
         zc+nCysCxL6yBEIRa7I+PKIiokXj8eZji8ynY/neZe69+e4oVMqJdZgoSvrOFemS5Ots
         OixBmvbHCy8bld6hlwuByUJeUGy0e5mIiZDnlMHUpe4fmL6/ETRPeZriWb5qOp7O6GRl
         aKMD3wKyQUXnmKjAbtDc8b40Aovwu5jHRebfcD2swosk1+cNXH3zMQO9WrK6JidTQTKS
         C2P3cRxu3HlzMmDAX+jrcZ94bsYUHUykoHzn8hp09p+E7Q/InSthE4t/M3oMnBZXOQFC
         r5pA==
X-Gm-Message-State: AC+VfDwlTNQ5zw1LV/fsmCJ9ejGBl8bA3+CXDlbeHjymIGr6idihCMRY
        GRo+hCT6ylgnMiSKJfnI++KFyDo8A4E=
X-Google-Smtp-Source: ACHHUZ5fLCzmx0Ny2uR4bzTkX50GSfrrAfzI9lfelKr20EpJlzAn2ClUp/gyLzOrK0AAGyuLguKvUw==
X-Received: by 2002:a05:600c:2055:b0:3f1:74c3:3c51 with SMTP id p21-20020a05600c205500b003f174c33c51mr10731856wmg.35.1683659935463;
        Tue, 09 May 2023 12:18:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id n22-20020a7bcbd6000000b003f41bb52834sm11225022wmi.38.2023.05.09.12.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 May 2023 12:18:55 -0700 (PDT)
Message-Id: <03950e8f120e48b7df68f3273bbb2f7bb1e9073d.1683659931.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
References: <pull.1501.git.git.1683215331910.gitgitgadget@gmail.com>
        <pull.1501.v2.git.git.1683659931.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 May 2023 19:18:51 +0000
Subject: [PATCH v2 3/3] pack-refs: teach pack-refs --include option
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
 Documentation/git-pack-refs.txt | 15 ++++++++++++++-
 builtin/pack-refs.c             | 10 ++++++++--
 refs.h                          |  1 +
 refs/files-backend.c            | 14 +++++++++++---
 t/t3210-pack-refs.sh            | 10 ++++++++++
 5 files changed, 44 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-pack-refs.txt b/Documentation/git-pack-refs.txt
index c0f7426e519..f187925bdc0 100644
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
+`--exclude`, `--exclude` takes precedence. Using `--include` does not preclude
+all tags from being included by default. Symbolic refs and broken refs will never
+be packed. When used with `--all`, it will be a noop. Use `--no-include` to clear
+and reset the list of patterns.
+
 --exclude <pattern>::
 
 Do not pack refs matching the given `glob(7)` pattern. Repetitions of this option
@@ -70,6 +79,10 @@ unpack it.
 When used with `--all`, it will use the difference between the set of all refs,
 and what is provided to `--exclude`.
 
+When used with `--include`, it will use what is provided to `--include` as well
+as the the default of all tags and already packed refs, minus refs that are
+provided to `--exclude`.
+
 
 BUGS
 ----
diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 3dcbd6e2421..293cdd17181 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -7,7 +7,7 @@
 #include "revision.h"
 
 static char const * const pack_refs_usage[] = {
-	N_("git pack-refs [--all] [--no-prune] [--exclude <pattern>]"),
+	N_("git pack-refs [--all] [--no-prune] [--include <pattern>] [--exclude <pattern>]"),
 	NULL
 };
 
@@ -15,13 +15,19 @@ int cmd_pack_refs(int argc, const char **argv, const char *prefix)
 {
 	unsigned int flags = PACK_REFS_PRUNE;
 	static struct ref_exclusions excludes = REF_EXCLUSIONS_INIT;
-	struct pack_refs_opts pack_refs_opts = {.exclusions = &excludes, .flags = flags};
+	static struct string_list included_refs = STRING_LIST_INIT_NODUP;
+	struct pack_refs_opts pack_refs_opts = { .exclusions = &excludes,
+						 .flags = flags,
+						 .included_refs = &included_refs };
+
 	static struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
 	struct string_list_item *item;
 
 	struct option opts[] = {
 		OPT_BIT(0, "all",   &pack_refs_opts.flags, N_("pack everything"), PACK_REFS_ALL),
 		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), PACK_REFS_PRUNE),
+		OPT_STRING_LIST(0, "include", pack_refs_opts.included_refs, N_("pattern"),
+			N_("references to include")),
 		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
 			N_("references to exclude")),
 		OPT_END(),
diff --git a/refs.h b/refs.h
index 46020bd335c..2f91f4c4a90 100644
--- a/refs.h
+++ b/refs.h
@@ -66,6 +66,7 @@ struct worktree;
 struct pack_refs_opts {
 	unsigned int flags;
 	struct ref_exclusions *exclusions;
+	struct string_list *included_refs;
 };
 
 const char *refs_resolve_ref_unsafe(struct ref_store *refs,
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 6a51267f379..3f8974a4a32 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1181,6 +1181,17 @@ static int should_pack_ref(const char *refname,
 	    REF_WORKTREE_SHARED)
 		return 0;
 
+	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
+		return 0;
+
+	if (opts->included_refs && opts->included_refs->nr) {
+		struct string_list_item *item;
+
+		for_each_string_list_item(item, opts->included_refs)
+			if (!wildmatch(item->string, refname, 0))
+				return 1;
+	}
+
 	/* Do not pack non-tags unless PACK_REFS_ALL is set: */
 	if (!(opts->flags & PACK_REFS_ALL) && !starts_with(refname, "refs/tags/"))
 		return 0;
@@ -1193,9 +1204,6 @@ static int should_pack_ref(const char *refname,
 	if (!ref_resolves_to_object(refname, the_repository, oid, ref_flags))
 		return 0;
 
-	if (opts->exclusions && ref_excluded(opts->exclusions, refname))
-		return 0;
-
 	return 1;
 }
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index 31b9f72e84a..86b3ff6a3e0 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -126,6 +126,16 @@ test_expect_success \
      ! test -f .git/refs/heads/dont_pack3 &&
      ! test -f .git/refs/heads/dont_pack4'
 
+test_expect_success \
+    'test only included refs are packed' '
+     git branch pack_this1 &&
+     git branch pack_this2 &&
+     git tag dont_pack5 &&
+     git pack-refs --include refs/tags/pack_this* --exclude refs/tags/dont_pack* &&
+     test -f .git/refs/tags/dont_pack5 &&
+     ! test -f ./git/refs/heads/pack_this1 &&
+     ! test -f ./git/refs/heads/pack_this2'
+
 test_expect_success \
 	'see if up-to-date packed refs are preserved' \
 	'git branch q &&
-- 
gitgitgadget
