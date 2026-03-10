Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 366F81B6D1A
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164748; cv=none; b=Xr7sl6bDFbOtuP9VXtXOsucaSryBb/59nW1NL1y2GPdw+AqTEFcA65Xjn+4sTRNsM0hDVDm/FanXJasuA592MZ+chM3YrY6qKaQmyc1IrLhU22lH9lb3EXeN1A6Ho3q4BRFZgj738g8xPO3ZYvpap8BlKZ3mtqLhNmFG92ZBWTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164748; c=relaxed/simple;
	bh=TxGCI+kAiDS0IH1uuJvkZ8apyFKiPCUJmcHAgowbLiU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OD/MvH00n8SVRJ5oR1nLKFkV4h1oVQBF/vdqGS13BJxLqxPofKGUu02izNzbVjZGs00JPeiSs5x+ZgKXKzTZZ5kQLvs5YBwlStqXK3FSIjco9tGUv77VzrUaP14x95Zxa8PBlzA/NVNv9djbCitF6JpNdUzgMp6eh2gKVlBpP44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoYwUGlR; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoYwUGlR"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82990763921so4986583b3a.1
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164746; x=1773769546; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mcxJzPmV6TwE4gSd6ebOC4SjAnerwkmLJIP3+BGhTgQ=;
        b=hoYwUGlRVS1pNN+c428vh4Ne7IKVoE3sGwmx4dz5PFzDGvRMqGDVGktANAuvV/eHA7
         HwAXx2RsqQaph61syh5GtaH2j4byikog2q2+TblRTcHi67yNE/yho3erL3zj/v+nvyBA
         Aq2WZslAv+oRDdAMGktFIygxQfBWz6eCBTYqmGuKJuJQ22oYvd8HnYDG5E60YLJ8U7IG
         TQHPvBkRRcCPmbXk4S4LnJbWZ5o7pkuL0ON6aNBRrPn8PIRbXU+iEN4CKAuJxz423INW
         lkSLutTuulqmL3IUTK/cq9kcZrLthL5C6VHHSUYlvtHHDqYuPP62kyiolZfwheYCVUhY
         kuTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164746; x=1773769546;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mcxJzPmV6TwE4gSd6ebOC4SjAnerwkmLJIP3+BGhTgQ=;
        b=tCdb5ilDal+/WAsWfNA8OK9+dmU26Z0qTJY25kc6ePYRSpWtUim14MLkjIiZdAJpf/
         KXKvEGCj3NdITsL5PWoCUeLdyaVv1vDc0Ep2HjKg2K0P1uPaJtPi6V/kbbk056VfcKpO
         gnpwxRNvD67stZIlIuEmCGUbILQ9a+hlMJ1IfnhAo25RRzQCtCeN9YF/vqbk8VBAMoH2
         3EhAKpXTuj2EtuR0dtlHRcqlC6CK9bCH4W3qUPKs8qTmmURQ7j5weHyjP3v9iUvQ6ZGu
         pknfjhtoiyBJodPr08B8WFM19YKCmAOSmARKNMsbXO31qe9XgIF1xgUSrKjd1ZdRHHlB
         OTiQ==
X-Gm-Message-State: AOJu0YxcdTzi/mDijGAWR7dZ2dnhGkdLr9xhfch9aG5cnIsYJyJz7Xza
	V+XusntEeDgmagXiW0L0PR/mcd68/Gm8Cq6y4Ky5DeZ6lndglbhBc0OlBKzwwQ==
X-Gm-Gg: ATEYQzyhlrsMwshhQAtxR2z103oIuUdXru268w5jnOpMR//5ju54B3FzZ957U3lCjhu
	dv046jq/Zw6KrsYfDtpFpRs/oDPEOZT+8xcSwI11IGS/L0AeYnDwscjcvArjAWe5vSiZkG2GhOK
	Dt5borr894hA+a7dDGXsOgzAAfhL8C4Y57VRH03aR9Kgtlt6mUgauNG/Rm38fNaZxCZrzGfpi3c
	bcbsTmFlcuKax5khntI0X3Jg2zi0xwWUGP3ZjoGD7TdkZCbswr9+UvT5A0WDFmn+2MGZzvLt613
	veaFynDW8NwtT1t8erkjcKfj7xd+OamU26U2wk3uiK3YWlNKSJJjAIu1S+YQ7KZL8FydaHj2rAG
	8XRBg9spvY9dcxYhPzbHwY1yw0CK+ed3JrXGY0GB/EfZreN42x0pMbIKeJ1bf0HuP67/On79HCQ
	IZTEWYHkZQsGJ7IJRUiw6onkG3dCM9i9+8hMB87D8OXKY=
X-Received: by 2002:a05:6a00:21d6:b0:823:d2c:b156 with SMTP id d2e1a72fcca58-829a2de2fc3mr14434105b3a.5.1773164746240;
        Tue, 10 Mar 2026 10:45:46 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:af62:6ac0:52fa:9f8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48676besm13414023b3a.40.2026.03.10.10.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:45:45 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH v2 2/2] editor: remove the_repository usage
Date: Tue, 10 Mar 2026 23:10:49 +0530
Message-ID: <20260310174519.676851-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

git_sequence_editor() reads sequence.editor using the_repository. Pass
struct repository through the callers instead of relying on the global
state. It is called from,

- builtin/var.c: Mostly the_repository is used in all the functions and
  there is no proper local access to a repository, so pass the_repository.

- editor.c: The caller is inside launch_sequence_editor() function which is
  called from rebase-interactive.c:edit_todo_list(), which does have a
  local repository instance, so pass it down the caller.

With no remaining global states in editor.c remove '#define
USE_THE_REPOSITORY_VARIABLE' and drop the dependency on 'environment.h'.
This removes another dependency on the_repository and keeps editor code
consistent with the ongoing effort to reduce global state.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/var.c        |  2 +-
 editor.c             | 11 ++++-------
 editor.h             |  4 ++--
 rebase-interactive.c |  2 +-
 4 files changed, 8 insertions(+), 11 deletions(-)

diff --git a/builtin/var.c b/builtin/var.c
index cc3a43cde2..7da263b129 100644
--- a/builtin/var.c
+++ b/builtin/var.c
@@ -38,7 +38,7 @@ static char *editor(int ident_flag UNUSED)

 static char *sequence_editor(int ident_flag UNUSED)
 {
-	return xstrdup_or_null(git_sequence_editor());
+	return xstrdup_or_null(git_sequence_editor(the_repository));
 }

 static char *pager(int ident_flag UNUSED)
diff --git a/editor.c b/editor.c
index b509d23f3b..b78c8a687f 100644
--- a/editor.c
+++ b/editor.c
@@ -1,11 +1,8 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
 #include "config.h"
 #include "editor.h"
-#include "environment.h"
 #include "gettext.h"
 #include "pager.h"
 #include "path.h"
@@ -53,12 +50,12 @@ const char *git_editor(void)
 	return editor;
 }

-const char *git_sequence_editor(void)
+const char *git_sequence_editor(struct repository *r)
 {
 	const char *editor = getenv("GIT_SEQUENCE_EDITOR");

 	if (!editor)
-		repo_config_get_string_tmp(the_repository, "sequence.editor", &editor);
+		repo_config_get_string_tmp(r, "sequence.editor", &editor);
 	if (!editor)
 		editor = git_editor();

@@ -138,9 +135,9 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
 }

 int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env)
+			   const char *const *env, struct repository *r)
 {
-	return launch_specified_editor(git_sequence_editor(), path, buffer, env);
+	return launch_specified_editor(git_sequence_editor(r), path, buffer, env);
 }

 int strbuf_edit_interactively(struct repository *r,
diff --git a/editor.h b/editor.h
index ced29046f8..bcd0cebc85 100644
--- a/editor.h
+++ b/editor.h
@@ -5,7 +5,7 @@ struct repository;
 struct strbuf;

 const char *git_editor(void);
-const char *git_sequence_editor(void);
+const char *git_sequence_editor(struct repository *r);
 int is_terminal_dumb(void);

 int set_editor_program(const char *var, const char *value);
@@ -21,7 +21,7 @@ int launch_editor(const char *path, struct strbuf *buffer,
 		  const char *const *env);

 int launch_sequence_editor(const char *path, struct strbuf *buffer,
-			   const char *const *env);
+			   const char *const *env, struct repository *r);

 /*
  * In contrast to `launch_editor()`, this function writes out the contents
diff --git a/rebase-interactive.c b/rebase-interactive.c
index 809f76a87b..405ef353af 100644
--- a/rebase-interactive.c
+++ b/rebase-interactive.c
@@ -132,7 +132,7 @@ int edit_todo_list(struct repository *r, struct replay_opts *opts,
 				    (flags | TODO_LIST_APPEND_TODO_HELP) & ~TODO_LIST_SHORTEN_IDS) < 0)
 		return error(_("could not write '%s'."), rebase_path_todo_backup());

-	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL))
+	if (launch_sequence_editor(todo_file, &new_todo->buf, NULL, r))
 		return -2;

 	strbuf_stripspace(&new_todo->buf, comment_line_str);
--
2.53.0

