Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 953CB13AEF
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UXJMpLMc"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A42F5F2
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:10 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40837ebba42so19538665e9.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011109; x=1698615909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Lu11DeIqaJvlSYbnTIJ9UATkSPIAqrXZQluwjc9Wv1M=;
        b=UXJMpLMcHQB1DhCxks3kgCu0xZRilSH6sfaFnBuhgbNJL/jqQt2BfLfd4G8QqlfcKG
         Ur9kdV5s06Fuk8Ek/o5luU9torQEZuTeYGxWc9cnLJQNeZowxpY5VSpQaZQxLQbIULpA
         FeKCA/tD7/sWyz4icCQrVpB5en2gvmORaaOm1UnpCx0JD+GNFvMbST6jBhMbgQvWObH5
         mRU6yrm7fPDJmbB0KJvqyuUjNsaiiz5LnQywAmBmIkYhuv1kNIhk8a+Vq5JG5jhbDrVx
         36M9WNrK+rlgZ2ufRboJSRfD48IckUL5XVgzEJpdA8ZVRhLb3CGEqPBuI5T5nbrIxROv
         qU9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011109; x=1698615909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lu11DeIqaJvlSYbnTIJ9UATkSPIAqrXZQluwjc9Wv1M=;
        b=iPW/7HVfdaV+C0aAliUOYT4WF8kOkWR+IPEkDYlqKGWg/ti7Zh8Z8+GJFhqQ4FL7HH
         Ky7ZJ7tkWeV1UQRRKX73WcTw13fei5QoO0Yb3+/4Ixv2HtEI8tXriRrWIeJM6w0U/txC
         Nc2+JVxhCzC2AJYwHfQzqKPrqRBXJlsMc13svLPb3ykO265iJ7YENRN02Qza184i1+i0
         14finr9dkmjWXLynsK5iGsehk5M71ZI+/oo7bcKJJ8pcxItEDXpcim/h8kVByJr3tw/U
         ww2bNMU75/nCyHtnEt2AN0bIaz5WZ1xViYzd4nTs14BD0SQQYf9y84fuEeqzn7oQdOJt
         qtuA==
X-Gm-Message-State: AOJu0YzAVgmeKwDbsRvq73mcIhxbhZzcEOCkoutx7/u/WxtE23WmxwFW
	wCEpBUfqbNI1MoCwkVYW4K7JZJlpMv8=
X-Google-Smtp-Source: AGHT+IG9m0PlT5g0czvbDf7Srh6tOGWnWqwn5spfUlGIjJudQ6DkD2RMUC9DnUvSBjWdvah5WhWk6w==
X-Received: by 2002:a05:600c:4fc7:b0:407:5b54:bb10 with SMTP id o7-20020a05600c4fc700b004075b54bb10mr6040852wmq.8.1698011108722;
        Sun, 22 Oct 2023 14:45:08 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:08 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 2/6] log: add color.decorate.symbol config variable
Date: Sun, 22 Oct 2023 22:44:28 +0100
Message-ID: <20231022214432.56325-3-andy.koppe@gmail.com>
X-Mailer: git-send-email 2.42.GIT
In-Reply-To: <20231022214432.56325-1-andy.koppe@gmail.com>
References: <20231019193911.1669705-1-andy.koppe@gmail.com>
 <20231022214432.56325-1-andy.koppe@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add new color.decorate.symbol config variable for determining the
color of the prefix, suffix, separator and pointer symbols used in
log --decorate output and related log format placeholders, to allow
them to be colored differently from commit hashes.

For backward compatibility, fall back to the commit hash color that can
be specified with the color.diff.commit variable if the new variable is
not provided.

Add the variable to the color.decorate.<slot> documentation.

Amend t4207-log-decoration-colors.sh to test it. Put ${c_reset} elements
in the expected output at the end of lines for consistency.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt   |  2 ++
 commit.h                         |  1 +
 log-tree.c                       | 15 ++++++---
 t/t4207-log-decoration-colors.sh | 58 +++++++++++++++++---------------
 4 files changed, 43 insertions(+), 33 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index 3453703f9b..cc0a881125 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -92,6 +92,8 @@ color.decorate.<slot>::
 	the stash ref
 `grafted`;;
 	grafted and replaced commits
+`symbol`;;
+	punctuation symbols surrounding the other elements
 --
 
 color.grep::
diff --git a/commit.h b/commit.h
index 28928833c5..cb13e4d5ba 100644
--- a/commit.h
+++ b/commit.h
@@ -56,6 +56,7 @@ enum decoration_type {
 	DECORATION_REF_STASH,
 	DECORATION_REF_HEAD,
 	DECORATION_GRAFTED,
+	DECORATION_SYMBOL,
 };
 
 void add_name_decoration(enum decoration_type type, const char *name, struct object *obj);
diff --git a/log-tree.c b/log-tree.c
index 504da6b519..5ad168458e 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -41,6 +41,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
 	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
 	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
+	GIT_COLOR_NIL,		/* SYMBOL */
 };
 
 static const char *color_decorate_slots[] = {
@@ -50,6 +51,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_STASH]	= "stash",
 	[DECORATION_REF_HEAD]	= "HEAD",
 	[DECORATION_GRAFTED]	= "grafted",
+	[DECORATION_SYMBOL]	= "symbol",
 };
 
 static const char *decorate_get_color(int decorate_use_color, enum decoration_type ix)
@@ -312,7 +314,7 @@ void format_decorations(struct strbuf *sb,
 {
 	const struct name_decoration *decoration;
 	const struct name_decoration *current_and_HEAD;
-	const char *color_commit, *color_reset;
+	const char *color_symbol, *color_reset;
 
 	const char *prefix = " (";
 	const char *suffix = ")";
@@ -337,7 +339,10 @@ void format_decorations(struct strbuf *sb,
 			tag = opts->tag;
 	}
 
-	color_commit = diff_get_color(use_color, DIFF_COMMIT);
+	color_symbol = decorate_get_color(use_color, DECORATION_SYMBOL);
+	if (color_is_nil(color_symbol))
+		color_symbol = diff_get_color(use_color, DIFF_COMMIT);
+
 	color_reset = decorate_get_color(use_color, DECORATION_NONE);
 
 	current_and_HEAD = current_pointed_by_HEAD(decoration);
@@ -352,7 +357,7 @@ void format_decorations(struct strbuf *sb,
 				decorate_get_color(use_color, decoration->type);
 
 			if (*prefix) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbol);
 				strbuf_addstr(sb, prefix);
 				strbuf_addstr(sb, color_reset);
 			}
@@ -369,7 +374,7 @@ void format_decorations(struct strbuf *sb,
 
 			if (current_and_HEAD &&
 			    decoration->type == DECORATION_REF_HEAD) {
-				strbuf_addstr(sb, color_commit);
+				strbuf_addstr(sb, color_symbol);
 				strbuf_addstr(sb, pointer);
 				strbuf_addstr(sb, color_reset);
 				strbuf_addstr(sb, decorate_get_color(use_color, current_and_HEAD->type));
@@ -382,7 +387,7 @@ void format_decorations(struct strbuf *sb,
 		decoration = decoration->next;
 	}
 	if (*suffix) {
-		strbuf_addstr(sb, color_commit);
+		strbuf_addstr(sb, color_symbol);
 		strbuf_addstr(sb, suffix);
 		strbuf_addstr(sb, color_reset);
 	}
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index 21986a866d..f4173b6114 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -18,6 +18,7 @@ test_expect_success setup '
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
 	git config color.decorate.grafted black &&
+	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
 
 	c_reset="<RESET>" &&
@@ -29,6 +30,7 @@ test_expect_success setup '
 	c_stash="<MAGENTA>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
+	c_symbol="<WHITE>" &&
 
 	test_commit A &&
 	git clone . other &&
@@ -53,17 +55,17 @@ cmp_filtered_decorations () {
 # to this test since it does not contain any decoration, hence --first-parent
 test_expect_success 'commit decorations colored correctly' '
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_commit}, \
-${c_reset}${c_remoteBranch}other/main${c_reset}${c_commit})${c_reset} A1
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_stash}refs/stash${c_reset}${c_commit})${c_reset} On main: Changes to A.t
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
+${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A1${c_reset}${c_symbol}, ${c_reset}\
+${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
@@ -78,14 +80,14 @@ test_expect_success 'test coloring with replace-objects' '
 	git replace HEAD~1 HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbol})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}C${c_reset}${c_symbol}, ${c_reset}\
+${c_grafted}replaced${c_reset}${c_symbol})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
@@ -104,15 +106,15 @@ test_expect_success 'test coloring with grafted commit' '
 	git replace --graft HEAD HEAD~2 &&
 
 	cat >expect <<-EOF &&
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}${c_HEAD}HEAD${c_reset}\
-${c_commit} -> ${c_reset}${c_branch}main${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_commit}, \
-${c_reset}${c_grafted}replaced${c_reset}${c_commit})${c_reset} D
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_commit}, \
-${c_reset}${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_commit})${c_reset} B
-	${c_commit}COMMIT_ID${c_reset}${c_commit} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_commit})${c_reset} A
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}${c_HEAD}HEAD${c_reset}\
+${c_symbol} -> ${c_reset}${c_branch}main${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}D${c_reset}${c_symbol}, ${c_reset}\
+${c_grafted}replaced${c_reset}${c_symbol})${c_reset} D
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}v1.0${c_reset}${c_symbol}, ${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}B${c_reset}${c_symbol})${c_reset} B
+	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
 	EOF
 
 	git log --first-parent --no-abbrev --decorate --oneline --color=always HEAD >actual &&
-- 
2.42.GIT

