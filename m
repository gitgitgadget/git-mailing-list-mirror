Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 095C7A927
	for <git@vger.kernel.org>; Tue,  5 Aug 2025 02:41:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754361673; cv=none; b=JVrMKUfujGWmgx/Px4YhK9mK/aYw7bj19QuMZ4RYbjCfI5F/x9zSUP/6r7/EyW5E7qGT2kVSsgev5zh8nQIcwhIc/miu+X75+KZYEaP89eBmkO6rzDnL7jULO5EcPvwfyPaw9BQe1du1PRkgohWTUjghHsH9l6skg0k2cS/veT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754361673; c=relaxed/simple;
	bh=Xtqh0aR26l0z4lkH3Mv6fd6oTykCXfJEaKpEx3NCAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LunH4PCLV6rOjk4gTLSS+ybK6AeGhfLteSoMPzG96+haBB8KcTsGyn04tLkdxm2HJ7uPNPDLQzyPnHMYhLMgNlty4HldBhlZH7vhf5bFZxGQkoCNXYpWVNfZISpgLLNO5BLPQYgGLbKfIT7lq2qcg8GxmDaTPpiqMwLCPLr7QC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P1tcV1d5; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P1tcV1d5"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71b52d6d1e3so50841097b3.1
        for <git@vger.kernel.org>; Mon, 04 Aug 2025 19:41:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754361671; x=1754966471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=P1tcV1d5vVF9cCqahXYo0HpofkOuCmqp3nDMKGjJP4Cr5pZhXlT7wNIz/4J8uTipbl
         2O5CeDrF0LU7FmHbvzgo2TAfF9k2O7pkeo9QOCBoMLd/4ARo4krxUyNSdvZZ4BWQEGpI
         Ye0kwpoNhhOgV02BphsdPp+2WLmf7WU8XXWu+11NtiV4j/ZUqX0snihgVdJkys6zdU96
         LCWfBuP+vzbxCG7BSAzPov1CXbumhcVGfGlUomB44wM4y198+e0mnYCOxJ+mLj8CCXDt
         fMXMzf19uAXlskRRN+QXGJ/mts/Lw8MC5h0inT9ffceTSK4QwJ1JEnHxwfm9mKXGBK8B
         xVuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754361671; x=1754966471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=UDcsDqycIqxUmWZLhekl3mikoOLreg4l8f34LDLuFwju6XE/v+o4J2xiyvKa1o2qC4
         7wij53E6OVnwb2MQkV/HxDp43uSNKfPQtwjvT+Hrlza9kPr2MVeCF1wIORRYp6hcmDXb
         lwMjMQJv9J/LqX9UmzL+1F44RNl2XgIxmMPKEVz6pkWVTwUantsy5mxZedyHKyLPfuCe
         x1lTYzbnl2rya6clShK3FZaPZ4MKAqmz4NJqB8DpoyHNSDKYQ6Z2ZdAD4mC0E+l6iLxc
         01ZqlEtFcQiP/MkkuCpeI0RX6YuZrFYAwpq3JoBsLcs/W28xMXkOUzXMe7qRuT4X9ekp
         cK5A==
X-Gm-Message-State: AOJu0YyYrTuuVMNYtSCwbg2JB5cszzHyCd52N0+by9LpvdUR6/l2aU5V
	JQYHYvKTkE/DJdHwOP5cqb0i+mlvxkOWJuJ+atI/AVXtiLxSHL0vmBwQDytuvRrO
X-Gm-Gg: ASbGncutUJMY6dssFUnY/Ci67MdG+W0SYTYjA8rEzstxEjT+zfby02FfIAAMoYbm++J
	weKmVWgd+/eML0JCtGT5ccJrfZPxI09WS01I451O85WMZCIpkw3HJ1sjHeNTyy5hujy7cJiGQIu
	bVihYD4hsd5oVPURslaLwgvyWctMuDuWk3EeW7gIqr+uRXliYVFmFaJFCm7dhLN09gnft3mZ1QO
	u3nqKi5bIrgySqmfnsT2nXPjcgDrci9qoCjcjLzgbFQC/3AA6gLM268rq1BTldJhtA+CMijIGBf
	MUziqaObn3EmiZQpdIHbRt6+ZTgC/UjsFxcCLCZ5sr+9cMdDJBv/e+64p4lzLIGx1fTxOgExS8x
	TQv+Uhf+D2a2DGh8bMm71+iFn/ww+FSiBkor+fBwSAz5nyRkiK/ErFnjvHTk/eBtnX65ziSJe
X-Google-Smtp-Source: AGHT+IG2Woi9LWZKnsXnhriXQK1yGWLw5ecV1PQiWUaQngrvJUDV6SYyAmMH2RF4eXoPdB9j77DAGQ==
X-Received: by 2002:a05:690c:14:b0:71a:2d5f:49d0 with SMTP id 00721157ae682-71b7f0c5706mr130873457b3.1.1754361670676;
        Mon, 04 Aug 2025 19:41:10 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:f9db:16d6:17d4:7ce7])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-71b5a5ce7b5sm29895707b3.71.2025.08.04.19.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 19:41:10 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Calvin Wan <calvinwan@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>
Subject: [PATCH 2/2] editor: use standard strvec API to receive environment for external editors
Date: Mon,  4 Aug 2025 22:40:41 -0400
Message-ID: <20250805024044.30024-3-ben.knoble+github@gmail.com>
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

