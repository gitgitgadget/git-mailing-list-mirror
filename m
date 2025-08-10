Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1200726A0EB
	for <git@vger.kernel.org>; Sun, 10 Aug 2025 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754841824; cv=none; b=SgXIP+Caf0Tnr27WRd5Xd8Yz+dbtu8dUTReNG9y94oXVlH8brgW3w9WMUMzKnRL48eT1qdQpEcNoxbUkEYrKM89YMdahjTaE02xDkPN0aUMDmyvarQynOJCTGH+cjbI0mlaQGM6y77xM8Pj+KwGkQHGLNIKWriXuEiIhjJK1jck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754841824; c=relaxed/simple;
	bh=Xtqh0aR26l0z4lkH3Mv6fd6oTykCXfJEaKpEx3NCAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jq3WHwq9iW8Fq3/6oWsg/gWrrCF91Fp7fvd9mJORKwX6dycgjB6yJ17g9c78V7utPy5omMPYOVhC2mI418lB35H6NvTSDGJaTrtn9E60KyeNb5d+PCJ1ETTmEiY4QyZ1QfMRr3mNh8vt0FgJnqryJqWYMfxHJX5QXnF/XPl2U/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YVoxiMn8; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YVoxiMn8"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71b49bbb95cso33699317b3.1
        for <git@vger.kernel.org>; Sun, 10 Aug 2025 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754841822; x=1755446622; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=YVoxiMn8YH0LgxYloAiCnRzC9Ji8FWG+d3t3cLRPsooBOdxSt4gwFC1DpH/Gel2GEc
         WP2JS+/PL1sj/NSR/1gB0nVSqB8+frTK+hwXDdJOqGVefeh3/3o7JEdwI8M3dl4Evpex
         SWjUxU8hbDyKgy4ZcoQfGT1QqzjNMjjLV9Vdj8fj+UsHcm0zuGdDZGX5tkxY8GPIaGft
         Y8F4vAzSqlx/mHejA4dLwvZvcKUAvfiCvAs/gvz2vu5DHwt4wWpxwLJSBwlrIt808aN5
         29RvMFW8b15D/Os3D/ZZSEfAUaKzmtngN8U97YDMb/loKGHBHwnz8LiD27xrYitCIi+V
         k19Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754841822; x=1755446622;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=qkiO5zj9fHu9U/NddlJDj+NmiieFojWZLduoSFxmmG+9OKNBkOfEZFj10Bv9DPPi+/
         eVW5V/yOHWWpiSc0z77FNEqPidb/R5ETL0FUPrG5xtwmx97CwzRcXATdn//8HEkXFVwf
         TbjNyugTDA6NcDz1ctoY6jrKwRDCSRTromUC0PikAayfbGSzY37y9XA6rDgZhr3H0jxR
         UQWhhvaL+n13T7iuXgxnDahM0C5TTWTgRgIIF7Bfi3VhDrxpL0SNUGRdZKdu5tJu2hr3
         EDxPpKck0NwbUpMJUK8s4dXluRNl40gzHv5cjrBZM37Yjghzmc6w9Blbm+6jNA+l3cLQ
         lsdw==
X-Gm-Message-State: AOJu0Yyyq7/UvesT9rYnVusRIcfi9ChU8/ZG7cEBY3LK5tBWUHwvWgc/
	YRJrpXTP6aN5BpEF7DTZSzNAatoccnYiqXleckV1435Hb+QHMPhrZp6Y5He8Mruk
X-Gm-Gg: ASbGncuJtbq8+zWBesKauRDibKOifrIGCPfDt1q5OiIh6XzTplWSsqAWepWBomHQRne
	GpqozG9JtPhCkDKtbBENJpJDC6t5FbQSFVJ3xeJBEQ5MAmsA1jTysOJVigvNn9wSUDRuOxxmY1j
	GRJWi8aPcV40vuI8ruFrzNmo9eKuIohFiG5wAxzngQvgAJsWUYwdXnvP4nP9nLC/V+vn12ZzdsF
	bKtui5+so9bNjazh2MZ/zqj2WLisxp59G2RZwbDn+CKBzc7Mv4K554ztJDep5vLWVZcC0vl+coH
	BX/FrLL+3uImbnT6oP8xdnmwbYQ2dnurRCGMranpXPtHLIry8/x/WR1Zoj63OQAXFjnXKHUET40
	N6+D6L4bkMcbP58OOSajUUl84jmu3O+b4RFvLuzuRyzipmQ+LJbMEiUjLNSgoqYCIO1RIEZRh
X-Google-Smtp-Source: AGHT+IEyFaNRz8+4igB/xwT2NA03MUfBfCBe+T2PmfRMtEPEEhotaXvoLQOmyGJAteDCjjG2Ct+jYg==
X-Received: by 2002:a05:690c:a9a:b0:71c:1e33:367d with SMTP id 00721157ae682-71c1e333d12mr27277107b3.33.1754841821578;
        Sun, 10 Aug 2025 09:03:41 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:dc6d:d141:d6d7:493e])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a3a999esm64149937b3.2.2025.08.10.09.03.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Aug 2025 09:03:41 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH 3/3] editor: use standard strvec API to receive environment for external editors
Date: Sun, 10 Aug 2025 12:03:19 -0400
Message-ID: <20250810160323.49372-4-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250520193506.95199-1-ben.knoble+github@gmail.com>
References: <20250520193506.95199-1-ben.knoble+github@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Going back to the introduction of the env parameter for the editor in
8babab95af (builtin-commit.c: export GIT_INDEX_FILE for launch_editor as
well., 2007-11-26), we pass a constant array of strings: as the
surrounding APIs evolved to use strvecs (see 8d7aa4ba6a
(builtin/commit.c: remove the PATH_MAX limitation via dynamic
allocation, 2017-01-13) and later 46b225f153 (Merge branch 'jk/strvec',
2020-08-10)), the editor code did not.

There is only one caller of all 3 editor APIs that does not pass a NULL
environment (the same caller for which this parameter was added), and
it already has a strvec available to use.

Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
---
 builtin/commit.c |  2 +-
 editor.c         | 10 +++++-----
 editor.h         |  7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index b5b9608813..16cad7fb03 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1116,7 +1116,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct strvec env = STRVEC_INIT;
 
 		strvec_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env.v)) {
+		if (launch_editor(git_path_commit_editmsg(), NULL, &env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
diff --git a/editor.c b/editor.c
index fd174e6a03..0bc781d50c 100644
--- a/editor.c
+++ b/editor.c
@@ -58,7 +58,7 @@ const char *git_sequence_editor(void)
 }
 
 static int launch_specified_editor(const char *editor, const char *path,
-				   struct strbuf *buffer, const char *const *env)
+				   struct strbuf *buffer, const struct strvec *env)
 {
 	if (!editor)
 		return error("Terminal is dumb, but EDITOR unset");
@@ -89,7 +89,7 @@ static int launch_specified_editor(const char *editor, const char *path,
 
 		strvec_pushl(&p.args, editor, realpath.buf, NULL);
 		if (env)
-			strvec_pushv(&p.env, (const char **)env);
+			strvec_pushv(&p.env, env->v);
 		p.use_shell = 1;
 		p.trace2_child_class = "editor";
 		if (start_command(&p) < 0) {
@@ -124,20 +124,20 @@ static int launch_specified_editor(const char *editor, const char *path,
 	return 0;
 }
 
-int launch_editor(const char *path, struct strbuf *buffer, const char *const *env)
+int launch_editor(const char *path, struct strbuf *buffer, const struct strvec *env)
 {
 	return launch_specified_editor(git_editor(), path, buffer, env);
 }
 
 int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env)
+			   const struct strvec *env)
 {
 	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
 }
 
 int strbuf_edit_interactively(struct repository *r,
 			      struct strbuf *buffer, const char *path,
-			      const char *const *env)
+			      const struct strvec *env)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int fd, res = 0;
diff --git a/editor.h b/editor.h
index f1c41df378..627e992f4d 100644
--- a/editor.h
+++ b/editor.h
@@ -3,6 +3,7 @@
 
 struct repository;
 struct strbuf;
+struct strvec;
 
 const char *git_editor(void);
 const char *git_sequence_editor(void);
@@ -16,10 +17,10 @@ int is_terminal_dumb(void);
  * file's contents are not read into the buffer upon completion.
  */
 int launch_editor(const char *path, struct strbuf *buffer,
-		  const char *const *env);
+		  const struct strvec *env);
 
 int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env);
+			   const struct strvec *env);
 
 /*
  * In contrast to `launch_editor()`, this function writes out the contents
@@ -30,6 +31,6 @@ int launch_sequence_editor(const char *path, struct strbuf *buffer,
  * If `path` is relative, it refers to a file in the `.git` directory.
  */
 int strbuf_edit_interactively(struct repository *r, struct strbuf *buffer,
-			      const char *path, const char *const *env);
+			      const char *path, const struct strvec *env);
 
 #endif
-- 
2.48.1

