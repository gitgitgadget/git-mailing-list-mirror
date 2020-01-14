Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63726C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3221724673
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 19:26:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nCja9gpo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728851AbgANT0Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 14:26:16 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:39268 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728761AbgANT0M (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 14:26:12 -0500
Received: by mail-wm1-f66.google.com with SMTP id 20so15081369wmj.4
        for <git@vger.kernel.org>; Tue, 14 Jan 2020 11:26:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=kZjNlbNDbxfFNGcgF/MGxrsqBfQgD5aZVX4Dpk3rSLQ=;
        b=nCja9gpolguYR/MkvQ7tUONbDhviJaYEFibHieQoXqCo/yJvl58zmGvokBEjtJMoOQ
         mjmlJPPj4+Qlvfgjjl+JKhXiIbGPE/1RgQoz1FjUW0Vw2+NCNMN57UK5Bab/FMIPY0N9
         psKnLM0g0krcvXU/Nidd6PR4vc28iu9ls/OeOqTbOy+KgW8ZVHMoLG7I4QqIDnJqZipo
         38iPkB+cx/Ws5oMPjvq8mceJ9y9Suk4WaU8WeyY//V6UyPAo+x3TJZnTpziEwCIVMh4Q
         j9Lar/nQoHcadYDsyAuLiPnqLzAAe+HhPnShHiHbK3ZhsC2styOa77XU2r7ZFWQ9my1c
         pIXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=kZjNlbNDbxfFNGcgF/MGxrsqBfQgD5aZVX4Dpk3rSLQ=;
        b=hRxIvUTOc6akQ7YRpU5hYz+7Py354dIPKit9z5ZojntKVBLg9CSHqRedrtCCScbGK7
         mxNeMkKBWjvccbKTeD9ryKClkPRIfFYnybk+iiwjANZGFL1wfWEgMm21DSBNCNFdNBgc
         CLAVeMagsbWugeuQCQV3LA3vkxGr4VtXLZdVvm9ODYgXF2w1XLuU5QoD0yNV5SrCvWtv
         0v4UnQ78kfjC+GUvzpbDqMwnIgZITAh/S+o3LLNpjbtXPGBTsyfK23ZDcLdhe9VnTMZN
         p0KpB8xvRxNJR02RjM9i0Xrpw7EQB8vgvw1rLHDe9zyKTAVsh4Q7qDK0MwEg4NaMp/35
         YMfQ==
X-Gm-Message-State: APjAAAWqTeVmBzjJOceTxj5AW8UWeksvGxGvyLFEPS/ITEutJOT0QtAY
        eAd2gd5H7o3v5pUkNZ7O1M5CLrnl
X-Google-Smtp-Source: APXvYqzRtG1kmACQyVAoX0pe198Fol0gJXrTVlbiKlR22C5h+J1GuBPiBJmMGPHWZrkUwQCdPm5hsQ==
X-Received: by 2002:a7b:cc14:: with SMTP id f20mr29768580wmh.58.1579029970054;
        Tue, 14 Jan 2020 11:26:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm20978999wrx.20.2020.01.14.11.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jan 2020 11:26:09 -0800 (PST)
Message-Id: <79b6e9a565fde766954d7cda84a835b9015af6cb.1579029963.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.git.1579029962.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 14 Jan 2020 19:26:02 +0000
Subject: [PATCH 8/8] sparse-checkout: write escaped patterns in cone mode
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

If a user somehow creates a directory with an asterisk (*) or backslash
(\), then the "git sparse-checkout set" command will struggle to provide
the correct pattern in the sparse-checkout file. When not in cone mode,
the provided pattern is written directly into the sparse-checkout file.
However, in cone mode we expect a list of paths to directories and then
we convert those into patterns.

Even more specifically, the goal is to always allow the following from
the root of a repo:

  git ls-tree --name-only -d HEAD | git sparse-checkout set --stdin

The ls-tree command provides directory names with an unescaped asterisk.
It also quotes the directories that contain an escaped backslash. We
must remove these quotes, then keep the escaped backslashes.

However, there is some care needed for the timing of these escapes. The
in-memory pattern list is used to update the working directory before
writing the patterns to disk. Thus, we need the command to have the
unescaped names in the hashsets for the cone comparisons, then escape
the patterns later.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 builtin/sparse-checkout.c          | 48 ++++++++++++++++++++++++++++--
 t/t1091-sparse-checkout-builtin.sh | 21 +++++++++++--
 2 files changed, 64 insertions(+), 5 deletions(-)

diff --git a/builtin/sparse-checkout.c b/builtin/sparse-checkout.c
index 3cee8ab46e..61d2c30036 100644
--- a/builtin/sparse-checkout.c
+++ b/builtin/sparse-checkout.c
@@ -140,6 +140,22 @@ static int update_working_directory(struct pattern_list *pl)
 	return result;
 }
 
+static char *escaped_pattern(char *pattern)
+{
+	char *p = pattern;
+	struct strbuf final = STRBUF_INIT;
+
+	while (*p) {
+		if (*p == '*' || *p == '\\')
+			strbuf_addch(&final, '\\');
+
+		strbuf_addch(&final, *p);
+		p++;
+	}
+
+	return strbuf_detach(&final, NULL);
+}
+
 static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 {
 	int i;
@@ -164,10 +180,11 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	fprintf(fp, "/*\n!/*/\n");
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 
 		if (strlen(pattern))
 			fprintf(fp, "%s/\n!%s/*/\n", pattern, pattern);
+		free(pattern);
 	}
 
 	string_list_clear(&sl, 0);
@@ -185,8 +202,9 @@ static void write_cone_to_file(FILE *fp, struct pattern_list *pl)
 	string_list_remove_duplicates(&sl, 0);
 
 	for (i = 0; i < sl.nr; i++) {
-		char *pattern = sl.items[i].string;
+		char *pattern = escaped_pattern(sl.items[i].string);
 		fprintf(fp, "%s/\n", pattern);
+		free(pattern);
 	}
 }
 
@@ -337,7 +355,9 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 {
 	struct pattern_entry *e = xmalloc(sizeof(*e));
 	e->patternlen = path->len;
-	e->pattern = strbuf_detach(path, NULL);
+	e->pattern = dup_and_filter_pattern(path->buf);
+	strbuf_release(path);
+
 	hashmap_entry_init(&e->ent,
 			   ignore_case ?
 			   strihash(e->pattern) :
@@ -369,6 +389,7 @@ static void insert_recursive_pattern(struct pattern_list *pl, struct strbuf *pat
 
 static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 {
+	int i;
 	strbuf_trim(line);
 
 	strbuf_trim_trailing_dir_sep(line);
@@ -376,6 +397,27 @@ static void strbuf_to_cone_pattern(struct strbuf *line, struct pattern_list *pl)
 	if (!line->len)
 		return;
 
+	for (i = 0; i < line->len; i++) {
+		if (line->buf[i] == '*') {
+			strbuf_insert(line, i, "\\", 1);
+			i++;
+		}
+
+		if (line->buf[i] == '\\') {
+			if (i < line->len - 1 && line->buf[i + 1] == '\\')
+				i++;
+			else
+				strbuf_insert(line, i, "\\", 1);
+
+			i++;
+		}
+	}
+
+	if (line->buf[0] == '"' && line->buf[line->len - 1] == '"') {
+		strbuf_remove(line, 0, 1);
+		strbuf_remove(line, line->len - 1, 1);
+	}
+
 	if (line->buf[0] != '/')
 		strbuf_insert(line, 0, "/", 1);
 
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index 051c1f3bf2..3da7c10bd9 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -309,6 +309,9 @@ check_read_tree_errors () {
 	REPO=$1
 	FILES=$2
 	ERRORS=$3
+	git -C $REPO -c core.sparseCheckoutCone=false read-tree -mu HEAD 2>err &&
+	test_must_be_empty err &&
+	check_files $REPO "$FILES" &&
 	git -C $REPO read-tree -mu HEAD 2>err &&
 	if test -z "$ERRORS"
 	then
@@ -379,14 +382,28 @@ test_expect_success BSLASHPSPEC 'pattern-checks: escaped "*"' '
 	git -C escaped reset --hard $COMMIT &&
 	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist" &&
 	git -C escaped sparse-checkout init --cone &&
-	cat >escaped/.git/info/sparse-checkout <<-\EOF &&
+	git -C escaped sparse-checkout set zbad\\dir zdoes\*not\*exist zdoes\*exist &&
+	cat >expect <<-\EOF &&
 	/*
 	!/*/
 	/zbad\\dir/
+	/zdoes\*exist/
 	/zdoes\*not\*exist/
+	EOF
+	test_cmp expect escaped/.git/info/sparse-checkout &&
+	check_read_tree_errors escaped "a zbad\\dir zdoes*exist" &&
+	git -C escaped ls-tree -d --name-only HEAD | git -C escaped sparse-checkout set --stdin &&
+	cat >expect <<-\EOF &&
+	/*
+	!/*/
+	/deep/
+	/folder1/
+	/folder2/
+	/zbad\\dir/
 	/zdoes\*exist/
 	EOF
-	check_read_tree_errors escaped "a zbad\\dir zdoes*exist"
+	test_cmp expect escaped/.git/info/sparse-checkout &&
+	check_files escaped "a deep folder1 folder2 zbad\\dir zdoes*exist"
 '
 
 test_done
-- 
gitgitgadget
