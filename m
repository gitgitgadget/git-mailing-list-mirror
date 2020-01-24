Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F87C35242
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2B1072075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IJIkO+u1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387448AbgAXVTy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:54 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51078 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729606AbgAXVTw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:52 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so831868wmb.0
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=+p5yz6bczx0SIx1s+zTSiq30ctBb3sXqhyz6snbVs6g=;
        b=IJIkO+u12WLOhyKGxXLhrW4hGxtmiOV8BjGN659DHliZh0t+KXRO9WBv/YVjgTmk4p
         IflTt3MvTlRu1E+ttebZbfOmMrnHGmFuD+DWk+G3QNpRAF71TVmk1JSxYhmIq0JeUn+2
         3UUI5oXx2sHpFKhr33/BPZ80AVB9qmLmjcCS0J9nsQ9i4Q54PsD/rmJX2qFZFD310QPd
         dOkcZqX4N1huDatO8QA9IyMyhowIPMJrllwEiWdlp85Hlo53gSQx07UcLnj/WH/1VZjz
         y3n+EQHGCyR8IAS23cO9tfIKPeszHSJbTpo45hP0y0XZz5GXM3X1kysT04y2ify0Bn5S
         6oNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=+p5yz6bczx0SIx1s+zTSiq30ctBb3sXqhyz6snbVs6g=;
        b=fkoi0fcNHgK0Ghf3+iH/wlUzhHhqPNTegEvqDbtuT15bcAkIYlOkT9ZpyyuhHR/rtW
         564BAeDzOYOA7rgjBeoNZ4evqqEoXdENaKcRk1M2PaRCxKxHYfDq45WJ3Y86IBylhu/x
         5XCq7pePOmP/GDuLhNR8qr64HoQjRKW/MfJ9VgRYvepTw29co5TUh6O5vMksnMlqKXfG
         sXskfzSgycx32aUgTj5oGNPYk6PLss1QnutYRiORxAvg5rVtp3Z1bExIv8yVO+2kTRrd
         IUOTTVXkpkRkHSZ6GgCD9ebSgydo9Xbtp6M7B9Tgt1P1vm4zBZL+hbhIKuMHAo0qdMGG
         Z1eg==
X-Gm-Message-State: APjAAAVfFRjfpJqLa2UB67Bt6cf6tdHQ83H0srNILHMzZnFkbFWPLIlk
        MJjhcsZWrDHaXDYIyMebS4BPJgU6
X-Google-Smtp-Source: APXvYqycTlgz0u6HpQqjM2mE64bREGdln+GEaI5BV1R1i7851kRuC64Vrhj/h4FvmHe5nPBCRcHDQQ==
X-Received: by 2002:a1c:960c:: with SMTP id y12mr995588wmd.9.1579900790137;
        Fri, 24 Jan 2020 13:19:50 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o4sm8875247wrw.97.2020.01.24.13.19.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:49 -0800 (PST)
Message-Id: <65c53d7526ca3cae1a1bfab8c9727221542665f6.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:39 +0000
Subject: [PATCH v2 09/12] sparse-checkout: properly match escaped characters
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the sparse-checkout feature uses hashset containment
queries to match paths. Make this algorithm respect escaped asterisk
(*) and backslash (\) characters.

Create dup_and_filter_pattern() method to convert a pattern by
removing escape characters and dropping an optional "/*" at the end.
This method is available in dir.h as we will use it in
builtin/sparse-checkout.c in a later change.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 31 +++++++++++++++++++++++++++---
 dir.h                              |  1 +
 t/t1091-sparse-checkout-builtin.sh | 22 +++++++++++++++++----
 3 files changed, 47 insertions(+), 7 deletions(-)

diff --git a/dir.c b/dir.c
index 7cb78c8b87..6d8abc09c3 100644
--- a/dir.c
+++ b/dir.c
@@ -630,6 +630,32 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 	return strncmp(ee1->pattern, ee2->pattern, min_len);
 }
 
+char *dup_and_filter_pattern(const char *pattern)
+{
+	char *set, *read;
+	char *result = xstrdup(pattern);
+
+	set = result;
+	read = result;
+
+	while (*read) {
+		/* skip escape characters (once) */
+		if (*read == '\\')
+			read++;
+
+		*set = *read;
+
+		set++;
+		read++;
+	}
+	*set = 0;
+
+	if (*(read - 2) == '/' && *(read - 1) == '*')
+		*(read - 2) = 0;
+
+	return result;
+}
+
 static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern *given)
 {
 	struct pattern_entry *translated;
@@ -695,8 +721,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 			goto clear_hashmaps;
 		}
 
-		truncated = xstrdup(given->pattern);
-		truncated[given->patternlen - 2] = 0;
+		truncated = dup_and_filter_pattern(given->pattern);
 
 		translated = xmalloc(sizeof(struct pattern_entry));
 		translated->pattern = truncated;
@@ -730,7 +755,7 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 
 	translated = xmalloc(sizeof(struct pattern_entry));
 
-	translated->pattern = xstrdup(given->pattern);
+	translated->pattern = dup_and_filter_pattern(given->pattern);
 	translated->patternlen = given->patternlen;
 	hashmap_entry_init(&translated->ent,
 			   ignore_case ?
diff --git a/dir.h b/dir.h
index 77a43dbf89..6dcd9d33e7 100644
--- a/dir.h
+++ b/dir.h
@@ -304,6 +304,7 @@ int pl_hashmap_cmp(const void *unused_cmp_data,
 		   const struct hashmap_entry *a,
 		   const struct hashmap_entry *b,
 		   const void *key);
+char *dup_and_filter_pattern(const char *pattern);
 int hashmap_contains_parent(struct hashmap *map,
 			    const char *path,
 			    struct strbuf *buffer);
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 470900f6f4..0a21a5e15d 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -366,13 +366,27 @@ test_expect_success 'pattern-checks: starting "*"' '
 	check_read_tree_errors repo "a deep" "disabling cone pattern matching"
 '
 
-test_expect_success 'pattern-checks: escaped "*"' '
-	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
+	git clone repo escaped &&
+	TREEOID=$(git -C escaped rev-parse HEAD:folder1) &&
+	NEWTREE=$(git -C escaped mktree <<-EOF
+	$(git -C escaped ls-tree HEAD)
+	040000 tree $TREEOID	zbad\\dir
+	040000 tree $TREEOID	zdoes*exist
+	EOF
+	) &&
+	COMMIT=$(git -C escaped commit-tree $NEWTREE -p HEAD) &&
+	git -C escaped reset --hard $COMMIT &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
+	git -C escaped sparse-checkout init --cone &&
+	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
 	/*
 	!/*/
-	/does\*not\*exist/
+	/zbad\\dir/
+	/zdoes\*not\*exist/
+	/zdoes\*exist/
 	EOF
-	check_read_tree_errors repo "a" ""
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget

