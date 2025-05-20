Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A501E50B
	for <git@vger.kernel.org>; Tue, 20 May 2025 19:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747769746; cv=none; b=QApmmIZJMstC3jhWrTeRCVYYdretp0CviZZP39+G+xWBiDACnkAbt+7rA9Rq3SE6ZITdO78WDCi9qM37aBLCjDitIr7RxSJKjqJQBt/T2jzSGr5gWSiFvfO02Z5iB79mtL4gJTaobaI8DQgTXE+ixosqQduy70CrNG4PU7S3nO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747769746; c=relaxed/simple;
	bh=+OK33re4xAknUBeyaANnY2lWROKt8MeshoYcwNq9p2c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EXQM7+h2MUTWTgFydi4nbdg9mpRe9alPZL1S7QON8AfcdFx/Pfb4dVTsl8jje166sEJdvbkCpnGnTcGOl3RUMhwh5M9zy3iFCaDj0TCWF1APxobVn5458Y0FxIpcwrw6+diWncqlHW6RA/QKgLToIqr9Kf7AmvtlLp04XrpjxLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y/PSaND7; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y/PSaND7"
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-e7c5d4709caso2653864276.1
        for <git@vger.kernel.org>; Tue, 20 May 2025 12:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747769742; x=1748374542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q3IKGuEt9Drhp+U97WnyFe1+ZPzJvxUDSYg2Q8OFSnI=;
        b=Y/PSaND7Oy+xqhQuHOBmTikNVFDFHKMJGQvG2dzEI2CNSUSYrkF/akICuiy35qRG7D
         AxKc6k3RGWS4bkh2WsvicjD5+appMbceMSgz6pKfNqrw7ao8Mfs4/DYdOrLO846EkAMa
         ZnmpKl/hPqQ7m7g/sRjlKjuSpB/B9ZbyWfCVG4UdX8pJH/Z86RsqXIIOtvfUj/dOfh5g
         YDOvQ6DwLuhUlGIN3yEKjm9deqQM4fFJljuXy2HJ8gTjG9lebft5hGCHnajhBbfa2KJi
         9wvhu7AET95zKFH4PVDSjAtIO7X0slCVbc+vQTSPJ84Ai9ZT3NXrFakN/tk85UEv3G2R
         m+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747769742; x=1748374542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Q3IKGuEt9Drhp+U97WnyFe1+ZPzJvxUDSYg2Q8OFSnI=;
        b=N/RS2Spk+Zjo8osE7YDtOD50UMrKj1wo/VwZNYwihc0ptYzJin82IZLiWSma+86nRF
         1og72qel1REa6blLoCy+VAu2/BpXYkDiZt+jSCPk7futviU5Z1luXSCq2TAter92Jfbh
         F7vUInyGHFIn2bDO2eLDqYIW3nPQA72rO1yLT2QN/moggcAMPLi7AdUR/DQnr8q15TMX
         NWDHV0ijOcuMPrYUWmkOSM2DSurvUzekRdUHF5ZDwKr/l39mb9Wj+StdthI02AIChdUx
         j1ZJ+tiCQ+zYQ0S7BJ1mxA/fkgU35bCzQsurycSiz9rqqnhxhDW610G1XCn9Y7EzQnmv
         Cs4g==
X-Gm-Message-State: AOJu0YzIK8BcT/fBOEbBMlHu/PU9ke6KctGkW50LrxmsD1cGKy5b/C4T
	Md+sovfxfe0iCAkuOC6eVkZ2M09J8KbNLTWq6QKmuEHKDV32qvWESpHfoO4mvwsd
X-Gm-Gg: ASbGnct0vFN1n+gNUN50YA1iMVwIM9Pt71zACwpzllfpi5XWzUGrQWzsV5BfN4MON0F
	3HLrYopGdQIWgOYvC8n2vetbQy2mEJR2/hBQwS+dhGYc5T0hZdYC1Q2VACklRhN89QN/HE0zXCw
	LbigC4lbdyoEGYV4tVfPUbtJFcAJF0llPgkCHrD4VtRbGqoDK3S7GqStJXjdIFLzqoN33VGJN+8
	G+glUbDVZRwhjKnEtK/YglReSN3xr57uTrQnQsOkpay+O47VBFjnkl61Jh2exnzo5c7jQreTnLr
	/REu5zAyDjGy7paY7HJHENuSV2DfjCj8nwWlYpkPvbKpzvqplRZvDtNp5c+n76HJ4IPgdbH8n/L
	ORG2cX/5c8ISVZ5ZH9FvigkJG08y9ogn94JME
X-Google-Smtp-Source: AGHT+IGed5EY/sP8Ed5lLDh48FgFMu9v+8E9RRSy51AsmkRnMwCn2gohCPXR+5l5MW5sH0FisIIqQQ==
X-Received: by 2002:a05:6902:1585:b0:e7d:3b61:e25b with SMTP id 3f1490d57ef6-e7d3b61e592mr11389122276.11.1747769742313;
        Tue, 20 May 2025 12:35:42 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a6:1600:41e8:72c5:601a:7e86])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e7d597dd6e0sm131664276.26.2025.05.20.12.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 May 2025 12:35:42 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Calvin Wan <calvinwan@google.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>
Subject: [PATCH 2/4] editor: use standard strvec API to receive environment for external editors
Date: Tue, 20 May 2025 15:34:56 -0400
Message-ID: <20250520193506.95199-3-ben.knoble+github@gmail.com>
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
surrounding APIs evolved to use strvecs, the editor code did not.

There is only one caller of all 3 editor APIs that does not pass a NULL
environment (the same caller for which this parameter was added), and
it already has a strvec available to use.

Signed-off-by: D. Ben Knoble <ben.knoble+github@gmail.com>
Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/commit.c |  2 +-
 editor.c         | 10 +++++-----
 editor.h         |  7 ++++---
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 66bd91fd52..fdda1d1df0 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1100,7 +1100,7 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		struct strvec env = STRVEC_INIT;
 
 		strvec_pushf(&env, "GIT_INDEX_FILE=%s", index_file);
-		if (launch_editor(git_path_commit_editmsg(), NULL, env.v)) {
+		if (launch_editor(git_path_commit_editmsg(), NULL, &env)) {
 			fprintf(stderr,
 			_("Please supply the message using either -m or -F option.\n"));
 			exit(1);
diff --git a/editor.c b/editor.c
index b79d97b0e7..5bc9d39178 100644
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

