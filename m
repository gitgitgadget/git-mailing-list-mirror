Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DD241EB
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 22:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lFEASuLN"
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46AF2FF
	for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-40838915cecso31560785e9.2
        for <git@vger.kernel.org>; Mon, 23 Oct 2023 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698099118; x=1698703918; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UhRKklJGxie/vlH3D+R+b+XR44576sUzPO/PvuzcSbY=;
        b=lFEASuLNk/Cm2aXfya/fVDVPMfQ1e3G8JXSAccvv40a3+1xEag6tBMhr/lG+k1p8fS
         OyReQVhL3gIdHyrVHzVzbtKlhHe3zvos+IkW7pRbplWgpgnNQtQMl5zkQqZHVGNGtg0i
         rJ/8kAtz14cZ95AMr7QzFdK+GFBJj+r6RekmGcP1M0XCmesMY0wnQKYlU5joT2lETkoo
         oJkGFGRzzc6NXpQV1+dtiFm0aBLb4qTT/X5HpExcEIkVK3PKcgXpQkLcxw9EYiZbr/pu
         LhxicqKuP3zoom3q1ixsil1q79ddiGyvAQays7nHGpcuvggZO0SiW/mHctvSB/L1SMsK
         U5tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698099118; x=1698703918;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UhRKklJGxie/vlH3D+R+b+XR44576sUzPO/PvuzcSbY=;
        b=mPi1iFY27i98wmesx4t1CQTYDT/ejGRWqt7RoKQSEh85LB401QFslV1khVmNpbGvQE
         2MB3sHQGgp1fbrkefcG7g5lm4rKTkCadzSXJ9nnoRSn4I8N1gysf9Yie62Hpn2RB53fe
         CGT5Gwb4jKcbrmJ+Wsnh7GzIWu08l9gTNkPYe85Upm0xgvwgK0WjEXXC8rn+2vtIVS09
         YXg7fogGwAhYLw8DXv939ZMIVZdA14SzW+qVSz6qUTCI4XG7FT3rqaTA1gf9Gza26ZdX
         dmmJQvcmzGmbHTD8w8z3hkVZ48e6F/80MFCC265STQm+r+AhfT9ykVirwzTlz5CAf86X
         RukA==
X-Gm-Message-State: AOJu0YzM2RgI1Sb+WkjRsfK/hbJ9uvI8Eh7mrrOPwLyNLW6poqR4Bhqx
	fnln4GxyCqvni2QDBZlc6EXWYdOVm2JUQQ==
X-Google-Smtp-Source: AGHT+IEhylOBywnuRDaSaNlpDaL67KNoJDdxpqPhE9/sRPUZTe5Em3i4PZXc51xwyGzKoUAEFwyQFg==
X-Received: by 2002:a05:600c:35ca:b0:407:7ea1:e9a4 with SMTP id r10-20020a05600c35ca00b004077ea1e9a4mr7976158wmq.5.1698099118647;
        Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id w11-20020a5d608b000000b0032008f99216sm8559953wrt.96.2023.10.23.15.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Oct 2023 15:11:58 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	stolee@gmail.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v3 4/7] log: add color.decorate.ref config variable
Date: Mon, 23 Oct 2023 23:11:40 +0100
Message-ID: <20231023221143.72489-5-andy.koppe@gmail.com>
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

Refs other than branches, remote-tracking branches, tags and the stash
do not appear in log decorations by default, but they can be shown by
using decoration filter options such as --clear-decorations or
log.initialDecorationSet. However, they would appear without color.

Add config variable color.decorate.ref for such refs, defaulting to bold
magenta, which is the same as refs/stash.

Document the new variable on the git-config page and amend
t4207-log-decoration-colors.sh to test it.

Signed-off-by: Andy Koppe <andy.koppe@gmail.com>
---
 Documentation/config/color.txt   | 5 +++++
 commit.h                         | 1 +
 log-tree.c                       | 4 +++-
 t/t4207-log-decoration-colors.sh | 9 +++++++--
 4 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/color.txt b/Documentation/config/color.txt
index cc0a881125..005a2bdb03 100644
--- a/Documentation/config/color.txt
+++ b/Documentation/config/color.txt
@@ -90,11 +90,16 @@ color.decorate.<slot>::
 	lightweight and annotated tags
 `stash`;;
 	the stash ref
+`ref`;;
+	any other refs (not shown by default)
 `grafted`;;
 	grafted and replaced commits
 `symbol`;;
 	punctuation symbols surrounding the other elements
 --
++
+(Variable `log.initialDecorationSet` or linkgit:git-log[1] option
+`--clear-decorations` can be used to show all refs.)
 
 color.grep::
 	When set to `always`, always highlight matches.  When `false` (or
diff --git a/commit.h b/commit.h
index cb13e4d5ba..f6b2125fc4 100644
--- a/commit.h
+++ b/commit.h
@@ -54,6 +54,7 @@ enum decoration_type {
 	DECORATION_REF_REMOTE,
 	DECORATION_REF_TAG,
 	DECORATION_REF_STASH,
+	DECORATION_REF,
 	DECORATION_REF_HEAD,
 	DECORATION_GRAFTED,
 	DECORATION_SYMBOL,
diff --git a/log-tree.c b/log-tree.c
index 890024f205..fb3d87b83d 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -39,6 +39,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	[DECORATION_REF_REMOTE]	= GIT_COLOR_BOLD_RED,
 	[DECORATION_REF_TAG]	= GIT_COLOR_BOLD_YELLOW,
 	[DECORATION_REF_STASH]	= GIT_COLOR_BOLD_MAGENTA,
+	[DECORATION_REF]	= GIT_COLOR_BOLD_MAGENTA,
 	[DECORATION_REF_HEAD]	= GIT_COLOR_BOLD_CYAN,
 	[DECORATION_GRAFTED]	= GIT_COLOR_BOLD_BLUE,
 	[DECORATION_SYMBOL]	= GIT_COLOR_NIL,
@@ -49,6 +50,7 @@ static const char *color_decorate_slots[] = {
 	[DECORATION_REF_REMOTE] = "remoteBranch",
 	[DECORATION_REF_TAG]	= "tag",
 	[DECORATION_REF_STASH]	= "stash",
+	[DECORATION_REF]	= "ref",
 	[DECORATION_REF_HEAD]	= "HEAD",
 	[DECORATION_GRAFTED]	= "grafted",
 	[DECORATION_SYMBOL]	= "symbol",
@@ -151,7 +153,7 @@ static int add_ref_decoration(const char *refname, const struct object_id *oid,
 	int i;
 	struct object *obj;
 	enum object_type objtype;
-	enum decoration_type deco_type = DECORATION_NONE;
+	enum decoration_type deco_type = DECORATION_REF;
 	struct decoration_filter *filter = (struct decoration_filter *)cb_data;
 	const char *git_replace_ref_base = ref_namespace[NAMESPACE_REPLACE].ref;
 
diff --git a/t/t4207-log-decoration-colors.sh b/t/t4207-log-decoration-colors.sh
index f4173b6114..4b51e34f8b 100755
--- a/t/t4207-log-decoration-colors.sh
+++ b/t/t4207-log-decoration-colors.sh
@@ -17,6 +17,7 @@ test_expect_success setup '
 	git config color.decorate.remoteBranch red &&
 	git config color.decorate.tag "reverse bold yellow" &&
 	git config color.decorate.stash magenta &&
+	git config color.decorate.ref blue &&
 	git config color.decorate.grafted black &&
 	git config color.decorate.symbol white &&
 	git config color.decorate.HEAD cyan &&
@@ -28,11 +29,13 @@ test_expect_success setup '
 	c_remoteBranch="<RED>" &&
 	c_tag="<BOLD;REVERSE;YELLOW>" &&
 	c_stash="<MAGENTA>" &&
+	c_ref="<BLUE>" &&
 	c_HEAD="<CYAN>" &&
 	c_grafted="<BLACK>" &&
 	c_symbol="<WHITE>" &&
 
 	test_commit A &&
+	git update-ref refs/foo A &&
 	git clone . other &&
 	(
 		cd other &&
@@ -65,10 +68,12 @@ ${c_remoteBranch}other/main${c_reset}${c_symbol})${c_reset} A1
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
 ${c_stash}refs/stash${c_reset}${c_symbol})${c_reset} On main: Changes to A.t
 	${c_commit}COMMIT_ID${c_reset}${c_symbol} (${c_reset}\
-${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol})${c_reset} A
+${c_tag}tag: ${c_reset}${c_tag}A${c_reset}${c_symbol}, ${c_reset}\
+${c_ref}refs/foo${c_reset}${c_symbol})${c_reset} A
 	EOF
 
-	git log --first-parent --no-abbrev --decorate --oneline --color=always --all >actual &&
+	git log --first-parent --no-abbrev --decorate --clear-decorations \
+		--oneline --color=always --all >actual &&
 	cmp_filtered_decorations
 '
 
-- 
2.42.GIT

