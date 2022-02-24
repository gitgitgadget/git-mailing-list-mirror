Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C03C433F5
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232438AbiBXJeJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:34:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232791AbiBXJdw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:52 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D1E26A3B2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:22 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso3092393wms.4
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=u+wInzSzWpQ0YKwQtdHcCXtrdX+ESLpBhAm2LEgiNMs=;
        b=pVVGZ5Ri8FNLxpzDHPkR7U9YZSmR+Px3sXqpthVThpnhREMy9UdBQqBHJByyk+PBuD
         VdTNXFuNDiJj/ceb2eItxYrzO9VzsfqsZKDIpTubvWaJktYy4kSUte4OUEQ0Slf2nr6k
         UxBLlJTAn7n+c9ppJmbcqTNZZCKDYSDTCo1NhJYmm6Y860J1WnkGrxb8M8/i8nrzW93z
         GaFAHlSRLfGs8X7ByMZIQ9p/WmcS/Ruyk9l3FNRroaSYTtylTCaXYQRfstcvuQXxFlQU
         meqstwitqqxhw2rliEAQZLejC/3ILXDO95wReCLURTvZH23q7S+kxKvzYCv5tLUZCVV4
         acuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=u+wInzSzWpQ0YKwQtdHcCXtrdX+ESLpBhAm2LEgiNMs=;
        b=o/dAAkxEluguQCnQwngGmUhsFyzpWXKXnn3tjDA94Wfa8jr+pR+9vUKxq/wiP5pBLN
         Z34/sRxG0YVXH+tNe5e85htHJkjR4LVr5eIpdxpBvttLMJAQ3PzYHnuK3drRRFaIQcMy
         56/cdv9LbrYkOjejrOyrAcppvH7L3ofLSbAup1zPNEraz7rAKuTg6B6ZY+v1sRtQuyEv
         pf473ll4uTIQZt0KULfQENE0UWYpU2BfbruH9Ge8jhgNaNIZ6w2bp5G87o5iTX4gQEsk
         BWWQ3giYWlT8CHGdB1mOVW21SJeONtGCTPaagRyh6y7dipoLsG6R9/sPWCelzasQ9heJ
         2gbQ==
X-Gm-Message-State: AOAM530FUdtV8uFmEsAfB0UfV1ObraoyqEqZ5WtcZlA/xtwLX7aPLKqg
        ZQIgqmd/lb4zD1Tk1IBKJ3zNlRX0GONM0Q==
X-Google-Smtp-Source: ABdhPJxX9TIJXkw072QIgecl9/0pPjZWTriiwrn3lExHCl0fB2R2XjF6NOJQKX0kohHukiYUVkQcfg==
X-Received: by 2002:a1c:a54f:0:b0:380:4f49:624a with SMTP id o76-20020a1ca54f000000b003804f49624amr1536535wme.164.1645695200714;
        Thu, 24 Feb 2022 01:33:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:20 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/12] misc *.c: use designated initializers for struct assignments
Date:   Thu, 24 Feb 2022 10:33:06 +0100
Message-Id: <patch-11.12-169d47fd06c-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a few miscellaneous non-designated initializer assignments to
use designated initializers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 attr.c        | 2 +-
 notes-merge.c | 1 +
 object-file.c | 9 +++++----
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/attr.c b/attr.c
index 79adaa50ea1..9ad12578cce 100644
--- a/attr.c
+++ b/attr.c
@@ -80,7 +80,7 @@ static int attr_hash_entry_cmp(const void *unused_cmp_data,
  * Access to this dictionary must be surrounded with a mutex.
  */
 static struct attr_hashmap g_attr_hashmap = {
-	HASHMAP_INIT(attr_hash_entry_cmp, NULL)
+	.map = HASHMAP_INIT(attr_hash_entry_cmp, NULL),
 };
 
 /*
diff --git a/notes-merge.c b/notes-merge.c
index 01d596920ea..d749af1ab8b 100644
--- a/notes-merge.c
+++ b/notes-merge.c
@@ -113,6 +113,7 @@ static struct notes_merge_pair *find_notes_merge_pair_pos(
 }
 
 static struct object_id uninitialized = {
+	.hash =
 	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff" \
 	"\xff\xff\xff\xff\xff\xff\xff\xff\xff\xff"
 };
diff --git a/object-file.c b/object-file.c
index 03bd6a3baf3..5074471b471 100644
--- a/object-file.c
+++ b/object-file.c
@@ -274,10 +274,11 @@ static struct cached_object {
 static int cached_object_nr, cached_object_alloc;
 
 static struct cached_object empty_tree = {
-	{ EMPTY_TREE_SHA1_BIN_LITERAL },
-	OBJ_TREE,
-	"",
-	0
+	.oid = {
+		.hash = EMPTY_TREE_SHA1_BIN_LITERAL,
+	},
+	.type = OBJ_TREE,
+	.buf = "",
 };
 
 static struct cached_object *find_cached_object(const struct object_id *oid)
-- 
2.35.1.1157.g524e2d5a0db

