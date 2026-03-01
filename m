Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AC927442
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362433; cv=none; b=mr+hsNJYp6hPTKzSAs6mS28+ePw0el2+BRe3GYeyJAJb42tgUXPcwsmi1tinJPb5u+niZYuV0g2i2DKmqvddRAd+60kiLZFGlfhXXM7iV8LZN4IyrVIu7TEpd/SfWLjXMH+spaXhTKSYcJJtyv05NqMYM6hj0a++ENkysmPqOXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362433; c=relaxed/simple;
	bh=kx1ANyyTbcRhNrQn56KsbJyc+1LYLo0eRuwh/KMCgDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t5EpptYI7wazDEoYuE/5mAt+AJIvfuv5zDLfb1yVjBYixHTwafcS647O/8bcgJXQxHYf6U3CTqr4O1yoNoioCQlO1WICtSJ5jO3IzCXJcaLk6WjfSMeV5YKnP8+hUjH+LEUZzw+h5x1Oy9jV35REFOVOlb5GBOtH/5wC2Tzi8LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hMw8IU7V; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hMw8IU7V"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf9191da3so21227495ad.2
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:53:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772362431; x=1772967231; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EfPpTtzWGlJNz5tL3Sr6SXc7tUhr4xeH2DRNqmDEQkE=;
        b=hMw8IU7Vck7nkN3NgPcQLgZl1QPe2Wyu8QqkZznpWb/ROgegY2/u90yryki//ws4MT
         MfHVYz8iZc8xhz8qNYM+ZHqdVpm09DhR1B+IlsdS/aEJi3TwzxAbqI5Jrq5ad8uqRECF
         JvCn9dM6frMXsdDHbpxxQ726bIaeIdgrYx0VyJ8IJLJqV45l5x7ZON9L6wfT0ndXoy30
         pi/5Z1VwyIducV/C1nJgwoenDW06LlvlDjFWMmwHPLzQSts3M8Uk/qf6acHiADhdfcw9
         k98dRzIbHdmzHAolQvu3InFM+WAAkJiTMnHG9uve1R/gHzn9OBqw18zUAHzfVNt0c/Mv
         cLBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362431; x=1772967231;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EfPpTtzWGlJNz5tL3Sr6SXc7tUhr4xeH2DRNqmDEQkE=;
        b=n3RaD/s7Ab6vGWkOgQBsFbcfGNHgDAVLPl9mNVkZv5BWpH2u+Mh1KxfqoPICXWz7RC
         e+OvFQ0ovolSYAH/TH87rfxN9wC9daTYTuhfh/KjY6j9ltIoXGSP/zYx/tuIozLrzuvp
         kefYWSRApJ3NZnbD3qgjCOwIw05zY3HvvbmbUcSM/3f2Ig0oCFgd/Hx/Z7EYWhhjnA1+
         IUrXeIDHtSC70PgZmY3I6XUhtIzlHJGvXatUhVJkYWgIf1YRE3zQzfWReiOMhAQoLTrp
         ih0U8bNkj784JgGhaK7erkbqQb12GEFNxHkbogFaEny/fOE2h5SVuHvlT3b5NLEXNOaI
         NdAg==
X-Gm-Message-State: AOJu0YytFV37Eat/gv07qBRz6CvRR0uIABWgE0K8sB7LQ8UE2tFYbGph
	Lk6SMRQFdPcGbG+Wme7H4NJ7nWFOy5PqlZd8ZnwbkEumZtwMKNKJVd1XlJU+tA==
X-Gm-Gg: ATEYQzxQhSYyz/a8sFCwVc7MysPmlbna71Xmo6WdzW+/0fqCobijnDWFyX5NXiOSh6w
	FKn+jC4dFj7XQWHaZfoZq77rvgef1tW+sw2oLc78Uxf88PBSMFhet/1OvMn3eLi1z2G43SiNtMh
	cK/L3/l3q5yqks6QLNfzCWvnorUtbSLdpCuvkh36tTexfUP/rlKu6nZD4eLHagaVkcghEA0GRx/
	PAqj9o9PR597Ug7YjdMHTaxhCzw0R5B2DtjcB1ilarSDm6pw5SrQqdBvljzmITu8g6Mq0P0Yniz
	sAYnEBYmuz37Fmf0vhIru5rPn26GGe4bg+8FwoKwC0/ZEDUnjdh81f3+Hcw9AKfunPp5yvQ4tKI
	bXo5tsdWPS3uZhKxgxEuzrWvOMjmfwtnQ82HFakLVcotqQjbKbvGd1ACLjRE55LkpjkUdLF47Ft
	Hbi/nunpsP6rACsRzfLw5zF2ar14UayniZLT4/EU7K
X-Received: by 2002:a17:902:e78b:b0:2ab:3ac6:8d03 with SMTP id d9443c01a7336-2ae2e3d655dmr73297705ad.36.1772362431467;
        Sun, 01 Mar 2026 02:53:51 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:6885:f84:629:dad0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3a9dd3e7sm43480525ad.40.2026.03.01.02.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:53:51 -0800 (PST)
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
Subject: [GSOC][PATCH 2/2] editor: remove the_repository usage
Date: Sun,  1 Mar 2026 16:12:59 +0530
Message-ID: <20260301105228.1738388-3-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
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

* builtin/var.c: Mostly the_repository is used in all the functions and
  there is no proper local access to a repository, so pass the_repository.

* editor.c: The caller is inside launch_sequence_editor() function which is
  called from rebase-interactive.c:edit_todo_list(), which does have a
  local repository instance, so pass it down the caller.

With no remaining global states in editor.c remove '#define
USE_THE_REPOSITORY_VARIABLE'. This removes another dependency on
the_repository and keeps editor code consistent with the ongoing effort to
reduce global state.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 builtin/var.c        |  2 +-
 editor.c             | 10 ++++------
 editor.h             |  4 ++--
 rebase-interactive.c |  2 +-
 4 files changed, 8 insertions(+), 10 deletions(-)

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
index b509d23f3b..1f97c362c2 100644
--- a/editor.c
+++ b/editor.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "git-compat-util.h"
 #include "abspath.h"
 #include "advice.h"
@@ -53,12 +51,12 @@ const char *git_editor(void)
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

@@ -138,9 +136,9 @@ int launch_editor(const char *path, struct strbuf *buffer, const char *const *en
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

