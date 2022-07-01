Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9CD0C43334
	for <git@archiver.kernel.org>; Fri,  1 Jul 2022 10:31:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiGAKbo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Jul 2022 06:31:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234940AbiGAKbj (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Jul 2022 06:31:39 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 035FB76EA4
        for <git@vger.kernel.org>; Fri,  1 Jul 2022 03:31:30 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id i1so2532243wrb.11
        for <git@vger.kernel.org>; Fri, 01 Jul 2022 03:31:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hvVupZRPl6Bz/NIQ/1VvyFdDa8RI8fdMFY6c2PJqfQU=;
        b=hZfGUiQlSaYaLeC5/Q8qfxQ2+KMmoYWyoa9CZYFNRCHfcLP/jI+VpwnPsEZzvpYSXt
         pMaOqM/Q5NX+ud1x9XrgHwmfRuC5m/tLflnJvMqEI1IS5gxtMV+xZIAPh+ewQUeB/8wb
         ARy2AoZ941EfzhixFDeSWHGX0cZZv/hvmMI2CVFWYtx1IEull9/io32jddKfIOwKuBnp
         5k/Bw9Wnd8Y6Ow7un8F/LYJp9256aEfVAtFv1P1mLFt2/L1nlT5VNxOlcVyqb49klVg5
         +yZBh6iixPos6gGrUsDecCiQloq7c5VzWLhtMpb4YFJFx4bTTKpZoaJTtfEf0L0mmzel
         5alw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hvVupZRPl6Bz/NIQ/1VvyFdDa8RI8fdMFY6c2PJqfQU=;
        b=cDzz5L9Yw4lfvXoR97WUQqP+M7EFhgIZ5TJREgIWD1WulB8WqhoxeMhqoktHK9MfWB
         QWLnsEocIjaT03EpK4OvSlBaxhILgyfh4sY6l1lgCSQ6/oZozhh6kD62CgvKiXXTzWZo
         Go4cfIscEGBjC7mEz3ASmuS/Mqu+kyIliYk7wtOe5eLG8Y4K0jaTs0leAU04QR/nyrje
         H+sHhaaniCbTdnXcs7f2G73wBTmQ4f4ZBsRETfqZUWa4LjYxevAQwqV+PRljgRvoqS97
         r2WX97P7K+5tJXNNqEobn4wFY03TJszM1LVhSOIWJtctOoVn6H5mRZZpO7RhqAAPfwnw
         SLzw==
X-Gm-Message-State: AJIora9LZAekCxhaBXnSvsyTE1ATlKjsOJvj5HacZnffkZCw+LjqE6pe
        7TleBkBEbmei8B7WseR9aodPleyOHRls6g==
X-Google-Smtp-Source: AGRyM1syYHsaiDGPhVBpuneIgYxc+1iAikGYlj9HSSkUKpB8iRkiMXWM2m6EZFpw20bZZMS8fSH4EA==
X-Received: by 2002:a5d:66c3:0:b0:21b:994a:a6fa with SMTP id k3-20020a5d66c3000000b0021b994aa6famr12614775wrw.15.1656671488047;
        Fri, 01 Jul 2022 03:31:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c12c600b0039c811077d3sm9712790wmd.22.2022.07.01.03.31.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 03:31:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 4/4] cocci: generalize "unused" rule to cover more than "strbuf"
Date:   Fri,  1 Jul 2022 12:30:59 +0200
Message-Id: <patch-v3-4.4-45a429b9cc9-20220701T102506Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.0.900.g4d0de1cceb2
In-Reply-To: <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
References: <cover-v2-0.2-00000000000-20220621T223954Z-avarab@gmail.com> <cover-v3-0.4-00000000000-20220701T102506Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Generalize the newly added "unused.cocci" rule to find more than just
"struct strbuf", let's have it find the same unused patterns for
"struct string_list", as well as other code that uses
similar-looking *_{release,clear,free}() and {release,clear,free}_*()
functions.

See [1] for example of code that would be covered by the
"get_worktrees()" part of this rule. We'd still need work that the
series is based on (we were passing "worktrees" to a function), but
could now do the change in [1] automatically.

1. https://lore.kernel.org/git/Yq6eJFUPPTv%2Fzc0o@coredump.intra.peff.net/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/repack.c                |  2 --
 contrib/coccinelle/unused.cocci | 31 ++++++++++++++++++++++++-------
 2 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/builtin/repack.c b/builtin/repack.c
index 4a7ae4cf489..482b66f57d6 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -727,7 +727,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	struct child_process cmd = CHILD_PROCESS_INIT;
 	struct string_list_item *item;
 	struct string_list names = STRING_LIST_INIT_DUP;
-	struct string_list rollback = STRING_LIST_INIT_NODUP;
 	struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
 	struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
 	struct pack_geometry *geometry = NULL;
@@ -1117,7 +1116,6 @@ int cmd_repack(int argc, const char **argv, const char *prefix)
 	}
 
 	string_list_clear(&names, 0);
-	string_list_clear(&rollback, 0);
 	string_list_clear(&existing_nonkept_packs, 0);
 	string_list_clear(&existing_kept_packs, 0);
 	clear_pack_geometry(geometry);
diff --git a/contrib/coccinelle/unused.cocci b/contrib/coccinelle/unused.cocci
index 9f0101c1350..a1b09d2d73d 100644
--- a/contrib/coccinelle/unused.cocci
+++ b/contrib/coccinelle/unused.cocci
@@ -1,5 +1,5 @@
 // This rule finds sequences of "unused" declerations and uses of
-// "struct strbuf".
+// "struct strbuf" and other common types.
 //
 // I.e. this finds cases where we only declare the variable, and then
 // release it, e.g.:
@@ -20,14 +20,18 @@
 @@
 type T;
 identifier I;
-// STRBUF_INIT
-constant INIT_MACRO =~ "^STRBUF_INIT$";
+// STRBUF_INIT, but also e.g. STRING_LIST_INIT_DUP (so no anchoring)
+constant INIT_MACRO =~ "_INIT";
 // x[mc]alloc() etc.
 identifier MALLOC1 =~ "^x?[mc]alloc$";
+// I = get_worktrees() etc.
+identifier INIT_ASSIGN1 =~ "^get_worktrees$";
 // strbuf_init(&I, ...) etc.
-identifier INIT_CALL1 =~ "^strbuf_init$";
-// strbuf_release()
-identifier REL1 =~ "^strbuf_release$";
+identifier INIT_CALL1 =~ "^[a-z_]*_init$";
+// stbuf_release(), string_list_clear() etc.
+identifier REL1 =~ "^[a-z_]*_(release|clear|free)$";
+// release_patch(), clear_pathspec() etc.
+identifier REL2 =~ "^(release|clear|free)_[a-z_]*$";
 @@
 
 // .. A declaration like "struct strbuf buf;"...
@@ -52,6 +56,10 @@ identifier REL1 =~ "^strbuf_release$";
 // "strbuf_init(&buf, ...)" ...
 - \( INIT_CALL1 \)( \( I \| &I \), ...);
 |
+// .. or e.g. "worktrees = get_worktrees();", i.e. a known "assignment
+// init" ...
+- I = \( INIT_ASSIGN1 \)(...);
+|
 // .. or to follow-up a "struct strbuf *buf" with e.g. "buf =
 // xmalloc(...)" (which may in turn be followed-up by a
 // "strbuf_init()", which we'll match with INIT_CALL1) ...
@@ -61,11 +69,20 @@ identifier REL1 =~ "^strbuf_release$";
 
 // ... and then no mention of "buf" or "&buf" until we get to a
 // strbuf_release(&buf) at the end ...
-- \( REL1 \)( \( &I \| I \) );
+(
+- \( REL1 \| REL2 \)( \( I \| &I \), ...);
+|
+- \( REL1 \| REL2 \)( \( &I \| I \) );
+)
 // ... and no use *after* either, e.g. we don't want to delete
 // init/strbuf_release() patterns, where "&buf" could be used
 // afterwards.
   ... when != \( I \| &I \)
+// Note that we're intentionally loose in accepting e.g. a
+// "strbuf_init(&buf)" followed by a "string_list_clear(&buf,
+// 0)". It's assumed that the compiler will catch any such invalid
+// code, i.e. that our constructors/destructors don't take a "void *".
+//
 // This rule also isn't capable of finding cases where &buf is used,
 // but only to e.g. pass that variable to a static function which
 // doesn't use it. The analysis is only function-local.
-- 
2.37.0.900.g4d0de1cceb2

