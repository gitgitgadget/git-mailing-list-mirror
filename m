Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506B91534EC
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 22:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754950637; cv=none; b=caV97QXePcZJWw2biz7UQbKDT4Dv0std+B0vOE+9mUiUvUqM8PdOT4R0MeTw67MOKSYxfRp2bnz811TBlP2+Vgmyf+TLY5ApqK70wiop+DNihK0BTVlf7qAw2abXDsRC+vrPweGS4jj1sCiPo6dO7C20k1WbXqEDy9GV3KUgCqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754950637; c=relaxed/simple;
	bh=Xtqh0aR26l0z4lkH3Mv6fd6oTykCXfJEaKpEx3NCAEA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNZnEHUA+zvDC/9674cnGDT8K7g022DBEmoAEmdukeCq5U3a0Vy0dqHmAde7yFTTjzkc0YVmIH6O7WjYulPcTUa47Owz4AgVmw1eGuEdyAkjXiNXj0UKGmYGaBmf5K7b/0LFDiUItzeWDHSLH2EpEinIyEMeZxriJZbML/piJOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yfkn27+q; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yfkn27+q"
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e917b687974so194940276.1
        for <git@vger.kernel.org>; Mon, 11 Aug 2025 15:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754950635; x=1755555435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=Yfkn27+qqX2sWPeFzqJ1HBYdSFvhfZEUylTtgp+YdKieM34fADDuqTyhl5YrC9PMhM
         PiEp9zumDh5H+RVzjrkUGGH4Ad8cmaxUPzX5aevYaPRwJp9lgUZd29/mVN5AFz/EpF2L
         QmIAxqWIVAwpG8fGPV85feGm/WI7nZLKXaDgw1OzvfbS+zwOXt0t3M2uLOMh1ZlkMLzM
         zdOv6r0tcBeFvX+n8qji/Yht7QoGP1Kf/mgAiAxGIRyTesrBXlJaThqH+TemIDz7uM4g
         moeNip4EDO0brfNNJAL4RyR/rKrlwFhoTB11dvLTewStNyB/K4pLgvf9CaJAY+vpE12d
         YXcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754950635; x=1755555435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yHObBpbzHMJinDzVbZmX8E3HkojQoP29R63sTkDC2Ss=;
        b=o20XA8Zva/R/TKqy+RQL06MzGRxUAJmQiGPdv1svE13tBWAnzfDkFYDkjRud6RUY0O
         t03whMF1qukgTOrr9EhxBOlNZv2SqdQg6coJaEk7zVg5kocgOrW/lGsR42D4wtSf9eN9
         +OoFysinBM7ccQ0AFRlcCOUQe46f93WjrGsgy3PkZ7QByrxpILHXUQ+JuarwjKTU324f
         1+JrI0zM6kwaZF31rPb1Mq+eI4UMmET/yAJbNy2wfMOLzXmIhSusSlY9XjAG12Oaxmt3
         wBXHaCF/r+gkwaLbCZXNM8eC5N/C0M01cj3r3o4bd9oAVGk5MIvmD2e5IoPmVvCu3c8b
         i8BA==
X-Gm-Message-State: AOJu0Yxfe7Hfy9LbOjzPVqa4lKMcNVRjtclFrdJWUE/9vvS8nHntHrAk
	LBUQuMAgBUh6Uzf2mzlx+XwmDeHguDbdXzxqc9GFoZ8ngM0NaOy+jhYDZAvw5U/r
X-Gm-Gg: ASbGnct2PvFTPFRec5ybsd3mUb6Jln7kEO2O41oRsDdpl7UdR2e6Zqy2+ql1iJUHPKt
	8NG5yCmNVCiSmLAEkGDhKXNPEQAxSFY7YYYzSigPvnFqW+062aiA5Ynkota6lQhZ+xRNGt8UHYY
	hAozeRmkZQCtA8HLCsPx87yVpC+Bn+UE9vuJouT4l2gNPyZNx/KL93h0hMrCld67m+zvgSSNexR
	cXRY0QN/r/b6rKWX6/KiyEyWNl1xtpTlVFPvlLAb43Afh1WQLNLNW+1rTUJKLHsPtL/uUo19yF8
	iFyy4Tq8OOfjCO7oFqgeeEo5VApg8zoGcImt97/ahvky+7Q94wZZs8F/Hem+loI35QfN4NMnTkL
	wWZn8FGTFSuwzu+ZpA9RTXS8xWEeE91aK5qqD3MmKtch7R/6m8BTJKsmq6gW7sduQsMbVMReqHU
	0befB9Yg==
X-Google-Smtp-Source: AGHT+IFbivO17IdE59a5VrtZqz5ASlc0aKQIMTN9ZMhlaSpk/3J5XBhRtzVVF1iFWQb1hXNE6nQFgQ==
X-Received: by 2002:a05:6902:6b03:b0:e90:6d16:8622 with SMTP id 3f1490d57ef6-e917a19d6aamr1956874276.2.1754950634803;
        Mon, 11 Aug 2025 15:17:14 -0700 (PDT)
Received: from localhost.localdomain ([2605:a601:90a8:8b00:7d40:489a:fc5:8804])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e917b3ec714sm176217276.11.2025.08.11.15.17.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Aug 2025 15:17:14 -0700 (PDT)
Sender: "D. Ben Knoble" <ben.knoble@gmail.com>
From: "D. Ben Knoble" <ben.knoble+github@gmail.com>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Junio C Hamano <gitster@pobox.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Elijah Newren <newren@gmail.com>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= <avarab@gmail.com>,
	Calvin Wan <calvinwan@google.com>
Subject: [PATCH v3 4/4] editor: use standard strvec API to receive environment for external editors
Date: Mon, 11 Aug 2025 18:16:55 -0400
Message-ID: <20250811221706.67168-5-ben.knoble+github@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250810160323.49372-1-ben.knoble+github@gmail.com>
References: <20250810160323.49372-1-ben.knoble+github@gmail.com>
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

