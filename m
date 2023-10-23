Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D53E249EA
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PijFtjdj"
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0D9C10C
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:02 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-40790b0a224so29824055e9.0
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099121; x=1698703921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sKIi5pMDq0+MztaeX4hU+yA7cYdp8u+R0r274ddNIHU=;
        b=PijFtjdj2KGyfX3dRIi7Bq/JM8zAuu+R9p3+joMAsKuP3w2hQw166HGWnCF8yZcoB+
         /OvyKg5EfcX/+dbkNDIySbqOD/GVn3oCl3PlnLzJf5qBR7CJxcZS5zi+Zl0B25hVlFWD
         TkhMZaQ1FRqxDgDiQsnfnFiqHdEjyVTmH1/ck1eOg2XFY6rSWWKr/+f7wmt/rAQW6HLl
         2QTo6/6EyO9prL2bNwWcGubJR92/39lAp4KBBaLPDbSKIJlDVALi+0uqGzlslfBNdoiP
         WWUA5k26lxY1QWr4u7yiq7evm3uwdFB53zzZR0/kX5x/VljyAt8nktZHO14PPQtzNyz6
         F5/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099121; x=1698703921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sKIi5pMDq0+MztaeX4hU+yA7cYdp8u+R0r274ddNIHU=;
        b=dU9xtzJG6Vo8p/p/2QZYMVXC0srxD6LDAfm7KjAqEmM/+If0TnkcSNPG6LANTzcomr
         Kut358fl4Ot6s22nJRh4ule/A6rnn9cY4lKObRQR4fQ4ZbxgotuGVW+P3KUgaWTnWH+n
         BgbPg6TcJw14tyZIn8Go0bfrYFoVU+svdzRti0NtkfhDYIpB+cBITpQFAR3uMjVqux7O
         id2u01Tf1Ju86Ns5aQh9uacqJnZH82767Gfkv2OxmbKvsEjmu1QRbRaYc0w3hetN4gAg
         ZeTTqi0eWWmgGP1+hklSDbW2pkr+nBuS+9g5enk/qNmFZc5Dyti6hAxB87dpxJX/QWmx
         ZE1A==
X-Gm-Message-State: AOJu0YwI5MDfjNLvYWwInysp9P7UudnA8ibIL6peGYEv8H/+4LBG4gkK
	YuN+YmheUsjZm9oT2S4u1iJAn1pp1cDXBw==
X-Google-Smtp-Source: AGHT+IHMaJEdI5+AD4lCk5gYqY0GGLlMR8aSMIukBKtR1XSRw0fOz8aLsDvAvHOG59EeoiFM7IhieA==
X-Received: by 2002:a05:600c:1546:b0:3fe:4cbc:c345 with SMTP id f6-20020a05600c154600b003fe4cbcc345mr7756003wmg.41.1698099120882;
        Mon, 23 Oct 2023 15:12:00 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.12.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:12:00 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 7/7] log: add color.decorate.pseudoref config variable
Date: Mon, 23 Oct 2023 23:11:43 +0100
Message-ID: <20231023221143.72489-8-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231023221143.72489-1-andy.koppe@gmail.com>
References: <20231022214432.56325-1-andy.koppe@gmail.com>
 <20231023221143.72489-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the ability to show pseudorefs such as ORIG_HEAD and MERGE_HEAD in
log decorations. Add config variable color.decorate.pseudoref to
determine their color, defaulting to bold cyan, which is the same as
HEAD.

They will not be shown unless the default decoration filtering is
overridden with relevant log options such as --clear-decorations or
log.initialDecorationSet.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt                |  4 +++-
 commit.h                                      |  1 +
 log-tree.c                                    | 24 +++++++++++++++++++
 ..._--decorate=full_--clear-decorations_--all |  4 ++--
 ...f.log_--decorate_--clear-decorations_--all |  4 ++--
 t/t4202-log.sh                                | 21 +++++++++-------
 t/t4207-log-decoration-colors.sh              | 13 +++++++---
 7 files changed, 54 insertions(+), 17 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 005a2bdb03..7af7d65f76 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -92,6 +92,8 @@ color.decorate.<slot>::
 	the stash ref
 `ref`;;
 	any other refs (not shown by default)
+`pseudoref`;;
+	pseudorefs such as ORIG_HEAD or MERGE_HEAD (not shown by default)
 `grafted`;;
 	grafted and replaced commits
 `symbol`;;
@@ -99,7 +101,7 @@ color.decorate.<slot>::
 --
 +
 (Variable `log.initialDecorationSet` or linkgit:git-log[1] option
-`--clear-decorations` can be used to show all refs.)
+`--clear-decorations` can be used to show all refs and pseudorefs.)
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/commit.h b/commit.h
index f6b2125fc4..44dd3ce19b 100644
--- a/commit.h
+++ b/commit.h
@@ -56,6 +56,7 @@ enum decoration_type {
 	DECORATION_REF_STASH,
 	DECORATION_REF,
 	DECORATION_REF_HEAD,
+	DECORATION_REF_PSEUDO,
 	DECORATION_GRAFTED,
 	DECORATION_SYMBOL,
 };
diff --git a/log-tree.c b/log-tree.c
index fb3d87b83d..65ebb74d40 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -41,6 +41,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
+	[DECORATION_REF_PSEUDO]	= GIT_COLOR_BOLD_CYAN,
 	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 	[DECORATION_SYMBOL]	= GIT_COLOR_NIL,
 };
@@ -52,6 +53,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF]	= "ref",
 	[DECORATION_REF_HEAD]	= "HEAD",
+	[DECORATION_REF_PSEUDO]	= "pseudoref",
 	[DECORATION_GRAFTED]	= "grafted",
 	[DECORATION_SYMBOL]	= "symbol",
 };
@@ -208,6 +210,27 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	return 0;
 }
 
+static int add_pseudoref_decoration(const char *refname,
+				    const struct object_id *oid,
+				    int flags UNUSED,
+				    void *cb_data)
+{
+	struct object *obj;
+	enum object_type objtype;
+	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
+
+	if (filter && !ref_filter_match(refname, filter))
+		return 0;
+
+	objtype = oid_object_info(the_repository, oid, NULL);
+	if (objtype < 0)
+		return 0;
+
+	obj = lookup_object_by_type(the_repository, oid, objtype);
+	add_name_decoration(DECORATION_REF_PSEUDO, refname, obj);
+	return 0;
+}
+
 static int add_graft_decoration(const struct commit_graft *graft,
 				void *cb_data UNUSED)
 {
@@ -236,6 +259,7 @@ void load_ref_decorations(struct decoration_filter *filter, int flags)
 		decoration_loaded = 1;
 		decoration_flags = flags;
 		for_each_ref(add_ref_decoration, filter);
+		for_each_pseudoref(add_pseudoref_decoration, filter);
 		head_ref(add_ref_decoration, filter);
 		for_each_commit_graft(add_graft_decoration, filter);
 	}
diff --git a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
index 1c030a6554..7d16978e7f 100644
--- a/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate=full_--clear-decorations_--all
@@ -33,13 +33,13 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (refs/heads/side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (FETCH_HEAD, refs/heads/side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate_--clear-decorations_--all b/t/t4013/diff.log_--decorate_--clear-decorations_--all
index 88be82cce3..4f9be50ce0 100644
--- a/t/t4013/diff.log_--decorate_--clear-decorations_--all
+++ b/t/t4013/diff.log_--decorate_--clear-decorations_--all
@@ -33,13 +33,13 @@ Date:   Mon Jun 26 00:04:00 2006 +0000
 
     Merge branch 'side'
 
-commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (side)
+commit c7a2ab9e8eac7b117442a607d5a9b3950ae34d5a (FETCH_HEAD, side)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:03:00 2006 +0000
 
     Side
 
-commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0
+commit 9a6d4949b6b76956d9d5e26f2791ec2ceff5fdc0 (ORIG_HEAD)
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:02:00 2006 +0000
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index af4a123cd2..b14da62e3e 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -927,7 +927,7 @@ test_expect_success 'multiple decorate-refs' '
 test_expect_success 'decorate-refs-exclude with glob' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -944,7 +944,7 @@ test_expect_success 'decorate-refs-exclude with glob' '
 test_expect_success 'decorate-refs-exclude without globs' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b, octopus-b)
 	octopus-a (tag: octopus-a, octopus-a)
@@ -961,7 +961,7 @@ test_expect_success 'decorate-refs-exclude without globs' '
 test_expect_success 'multiple decorate-refs-exclude' '
 	cat >expect.decorate <<-\EOF &&
 	Merge-tag-reach (HEAD -> main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: seventh)
 	octopus-b (tag: octopus-b)
 	octopus-a (tag: octopus-a)
@@ -1022,10 +1022,12 @@ test_expect_success 'decorate-refs-exclude and simplify-by-decoration' '
 	EOF
 	git log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--decorate-refs-exclude="*octopus*" \
+		--decorate-refs-exclude="ORIG_HEAD" \
 		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual &&
-	git -c log.excludeDecoration="*octopus*" log \
-		-n6 --decorate=short --pretty="tformat:%f%d" \
+	git -c log.excludeDecoration="*octopus*" \
+	    -c log.excludeDecoration="ORIG_HEAD" \
+	    log -n6 --decorate=short --pretty="tformat:%f%d" \
 		--simplify-by-decoration >actual &&
 	test_cmp expect.decorate actual
 '
@@ -1067,9 +1069,10 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 	test_cmp expect actual
 '
 
-test_expect_success 'decorate-refs-exclude HEAD' '
+test_expect_success 'decorate-refs-exclude HEAD ORIG_HEAD' '
 	git log --decorate=full --oneline \
-		--decorate-refs-exclude="HEAD" >actual &&
+		--decorate-refs-exclude="HEAD" \
+		--decorate-refs-exclude="ORIG_HEAD" >actual &&
 	! grep HEAD actual
 '
 
@@ -1107,7 +1110,7 @@ test_expect_success '--clear-decorations overrides defaults' '
 
 	cat >expect.all <<-\EOF &&
 	Merge-tag-reach (HEAD -> refs/heads/main)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	seventh (tag: refs/tags/seventh)
 	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
 	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
@@ -1139,7 +1142,7 @@ test_expect_success '--clear-decorations clears previous exclusions' '
 	cat >expect.all <<-\EOF &&
 	Merge-tag-reach (HEAD -> refs/heads/main)
 	reach (tag: refs/tags/reach, refs/heads/reach)
-	Merge-tags-octopus-a-and-octopus-b
+	Merge-tags-octopus-a-and-octopus-b (ORIG_HEAD)
 	octopus-b (tag: refs/tags/octopus-b, refs/heads/octopus-b)
 	octopus-a (tag: refs/tags/octopus-a, refs/heads/octopus-a)
 	seventh (tag: refs/tags/seventh)
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 4b51e34f8b..0b32e0bb8e 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.ref blue &&
+	git config color.decorate.pseudoref "bold cyan" &&
 	git config color.decorate.grafted black &&
 	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
@@ -30,6 +31,7 @@ test_expect_success setup '
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
 	c_ref="<BLUE>" &&
+	c_pseudoref="<BOLD;CYAN>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
 	c_symbol="<WHITE>" &&
@@ -46,7 +48,10 @@ test_expect_success setup '
 	test_commit B &&
 	git tag v1.0 &&
 	echo >>A.t &&
-	git stash save Changes to A.t
+	git stash save Changes to A.t &&
+	git reset other/main &&
+	git reset ORIG_HEAD &&
+	git revert --no-commit @~
 '
 
 cmp_filtered_decorations () {
@@ -63,17 +68,19 @@ ${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
 ${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_pseudoref}ORIG_HEAD${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_symbol}, ${c_reset}\
 ${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
 ${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_pseudoref}REVERT_HEAD${c_reset}${c_symbol}, ${c_reset}\
 ${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol}, ${c_reset}\
 ${c_ref}refs/foo${c_reset}${c_symbol})${c_reset} A
 	EOF
 
-	git log --first-parent --no-abbrev --decorate --clear-decorations \
-		--oneline --color=always --all >actual &&
+	git log --first-parent --no-abbrev --decorate --color=always \
+		--decorate-refs-exclude=FETCH_HEAD --oneline --all >actual &&
 	cmp_filtered_decorations
 '
 
-- 
2.42.GIT

