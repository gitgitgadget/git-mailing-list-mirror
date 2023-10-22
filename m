Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B980513AF5
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 21:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Asqp4TN4"
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC06F7
	for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:11 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id ffacd0b85a97d-307d58b3efbso1780536f8f.0
        for <git@vger.kernel.org>; Sun, 22 Oct 2023 14:45:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698011109; x=1698615909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SKNvv76h6oFsXfERJ/ugxcpECYkaIj6DhESuGPeiaZ0=;
        b=Asqp4TN4XAd/pBmEjyIWpNQB4A0A5uUKZCKo+GM7vVyT8BhqQT6gJKW2Ry2mqGTapi
         CkYZ24Wmc82X27SvQo4TCRyiMjWj6lLSkqC/K3C7jiHpeY/ukUpGLY9tq9Bfhi0P3WzE
         HKikwQH0xhwpCWlaPSaAZlrEucQav6MyuFBuia9lruYyw0hZFLOgBUN/W9rrOAzspANJ
         hJGM1KRXD1j9LOUuw/hsR05Udt90iEzRN003AHqkkssnU8NdtXcMNao/SJE7lgw/Lh5v
         v7Xp+7vv85OWn3NhANRHuRBceLk92nVuZGI7CQtYJmA320fyFRMU4dmAHcAldPzwnbvo
         c5jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698011109; x=1698615909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SKNvv76h6oFsXfERJ/ugxcpECYkaIj6DhESuGPeiaZ0=;
        b=dbw+QiucryJKcEg39I4HdOKoqSEbHJ5mDjNI7exwCKAlSAPnm/CQxhEhJRTId8v5u1
         BD5Tr9zYUheXrRw7KRiykggljXCIIoRF+kks7tC1rZo+D2o1TMT89ebIihX8c2rCZY2U
         8pYGIPjoBygXaOW5fjZnV3g9akDp/rmBS05W5jI+I+4gYuiX0uIzoMISu/z4rV5XAeUd
         qp+YHl1MWaDBBF70qT2e2dDwVKc1ubufgrxn1d4W9vhExfCmhc0tsUXei2BjYxxnz6R0
         W7BkJKswAbgS4HSleeCKpoQQZggYmEkVyaPGtvDred6ve6zHkoGUEvfBKPz0ECUeM8cD
         7Bow==
X-Gm-Message-State: AOJu0Yx5ktL421V6ohwFhwWoMxzHntZyQfhFaFVYlawgwCxmKut8fVPP
	hmlzvHDC8n3dfY9pzHu5PYAT05weFWo=
X-Google-Smtp-Source: AGHT+IGnWFWbjN0kxFbWHbsOmobHp7EBMMm4qqr3UYJlPJiwgY7sAK8VYy79PaFcJpDirtM+EiU08g==
X-Received: by 2002:adf:f549:0:b0:32d:e478:9d7c with SMTP id j9-20020adff549000000b0032de4789d7cmr6315358wrp.24.1698011109436;
        Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
Received: from localhost.localdomain (cpc105060-sgyl40-2-0-cust995.18-2.cable.virginm.net. [81.111.15.228])
        by smtp.gmail.com with ESMTPSA id v3-20020adff683000000b0032d9523de65sm6291972wrp.48.2023.10.22.14.45.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Oct 2023 14:45:09 -0700 (PDT)
From: Andy Koppe <andy.koppe@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Andy Koppe <andy.koppe@gmail.com>
Subject: [PATCH v2 3/6] log: add color.decorate.ref config variable
Date: Sun, 22 Oct 2023 22:44:29 +0100
Message-ID: <20231022214432.56325-4-andy.koppe@gmail.com>
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
index 5ad168458e..36558f3008 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -39,6 +39,7 @@ static char decoration_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_BOLD_RED,	/* REF_REMOTE */
 	GIT_COLOR_BOLD_YELLOW,	/* REF_TAG */
 	GIT_COLOR_BOLD_MAGENTA,	/* REF_STASH */
+	GIT_COLOR_BOLD_MAGENTA, /* REF */
 	GIT_COLOR_BOLD_CYAN,	/* REF_HEAD */
 	GIT_COLOR_BOLD_BLUE,	/* GRAFTED */
 	GIT_COLOR_NIL,		/* SYMBOL */
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

