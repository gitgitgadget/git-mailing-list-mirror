Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FE2D27442
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 10:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772362428; cv=none; b=JSEMI7lTk10ewMvFUol5WFbwrvbvG+Uts3JGbl4KcFH1yMR8kPbpMC6Q6Pgm3S/pQOahxTrcwrfr2PVOGcVbMaFVGxFVwukudPjgMBHP5nqLZxX4munbc28L5VoAHKbrvqadYE+F1MxRtyhicvHTphfcJa192t8DYc5TL/JAnd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772362428; c=relaxed/simple;
	bh=Cw5YQXJxjj1NUxgvNf9+dYU6LUjLZAY6gzeviVgCiAQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GOgDvPREFxlQKznoom6+8qDQ9/96chFXIdDICCkGLywHC1YkVfZxYvQNlc3GhTsuwlQZryjYLU8V2iF9xnWQlCbz3omdXkhtU/ZM5yCA9J3oeo0yvx+WD2+MDJuUhj0JoJLeTfTAqCDSZ1PF063Kkau2+4Xq9v8lrTSwl/p9gE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NYk3uLsl; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NYk3uLsl"
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ae46b9c70dso1749395ad.1
        for <git@vger.kernel.org>; Sun, 01 Mar 2026 02:53:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772362426; x=1772967226; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=muU3VKZmcJRcDymI08/zqnnTfR8IjB7h/jD5kAdFz2I=;
        b=NYk3uLslNj5Q6sF4LOnKMK6QEypJNm5MBbVT9mfNce1hdrKMYw5qSl5fz2yznUJFg7
         Al+HF5l75Zl4pU/oNiwq8mDnwvfmYjiFT3wNPh9S1VRdvuLk94BK6g7Q/i05pBto/5Bm
         qm95p9U+ZRTPK3+6mo3ac4BEomHWGC5O1ugxEndOCMuEDLXB9s3T78LOWWNrCDCrYnQa
         RMNmwrQJgb4i75Sysey+kcEYPvRUFAtaFW2BlZwKgdvkqGrPWZcl0+LXTzK+WyY4Avfu
         3xpobnTjImMET/BH9WoErQegMYYaT3H5YlWwBEVO20GVR/bJeRB11z6MNQEdhsUYIuJw
         PCrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772362426; x=1772967226;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=muU3VKZmcJRcDymI08/zqnnTfR8IjB7h/jD5kAdFz2I=;
        b=cWnHwgfj2IPpiFFKcRChV459BwydLtRJPCIkPQZgbwg8PFA/DSeTQKB/4z+iF1kySG
         U3CTR5DA1uPYEQ4wV8hXlLwQA7yK6bR+wH/zl80tKPic6RdIgdoWGqGcjB5bPk2VLg9o
         F1rCz4I5DKwWe0tCXIbQ1xPSx9sEhGmTo/bjlqyiAQ/QzxScu9s70PfYFNMbQuh91FEt
         gQuoU/P+ULhsKOqm1l9tBMSzbizhuTSg7bcT1cDAIppHqOTsNcDn+z9NQGbpGRvdvJ/y
         e/3Ef9HzjkwZm4fJ3YiUspdJv++rn1qV0YefPtlfOj3Ft4m3IV/xEzSswc90R4mTi1JM
         ui4w==
X-Gm-Message-State: AOJu0YwS+3lgJJu/e/qOx5GkCs9Dpb0ko7vBr4EGXX8h96QheFu9J8zw
	6T7fSmd7xjzGFTD7TSvePuddUrf7/lfXZfBiptGJ4TptklZl3op0uGNnh5/6Ug==
X-Gm-Gg: ATEYQzyygZZGT48lyP/J1bU53LNhXNXw0T3C+3QdUvvvGifDkgXpkmxQP4zOCPm9qZd
	FNdrL0ysWvwFOqgnTjqaccXBBAqyxkUQN3Oh++v015q5iWQE0COLFw9HPdV1fLsAVVMIddyMaTX
	ShonrSaTdhcfbpawDHY093LvbIX5OeEfzWtilayJI+jfL8KFkfFRwxpfm+LqqFaKZqYcwrbHf3P
	V7+ZBk7c3OLS5AnxS+MB0zUneWqyEK4sCVUlS38ss5dWIB5hIvtqlY/iP6FHBpMhllB7E7aRy7s
	fTmujY5Auz6q3rN2J4aH/NWCNcwrekd2rlrvggGCrvhxvdLZHM522q09MJlKB+qMGkTuKJCl4eD
	QsusaPiu6xMrnK57WCjfpn9zyaiM1je8lRX4p/MXTsILwY2tJZWJ6SoU/7mmu4gEjnVPQGRQmB7
	8B+dKn1W2UPFgkAylZwI593n7gLLpS7cTg1MZu2ehw
X-Received: by 2002:a17:902:e852:b0:2a7:bbe0:f01f with SMTP id d9443c01a7336-2ae2b630f2bmr84542665ad.2.1772362426364;
        Sun, 01 Mar 2026 02:53:46 -0800 (PST)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:6885:f84:629:dad0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae3a9dd3e7sm43480525ad.40.2026.03.01.02.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 02:53:46 -0800 (PST)
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
Subject: [GSOC][PATCH 1/2] editor: make editor_program local to editor.c
Date: Sun,  1 Mar 2026 16:12:58 +0530
Message-ID: <20260301105228.1738388-2-shreyanshpaliwalcmsmn@gmail.com>
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

editor_program is a global variable defined in environment.c, which is set
by git_default_core_config(), but is used only by editor.c in the function
git_editor().

Remove the global from the environment.c and localize it in editor.c.
Introduce a helper for setting the local editor_program variable by the
help of git_config_string(). Call this helper in the core.editor part of
the git_default_core_config().

This keeps the existing initialization timing and availability of the
variable, so invalid core.editor values are still reported early during
startup, causing no ux regression.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 editor.c      | 8 ++++++++
 editor.h      | 2 ++
 environment.c | 5 ++---
 environment.h | 1 -
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/editor.c b/editor.c
index fd174e6a03..b509d23f3b 100644
--- a/editor.c
+++ b/editor.c
@@ -18,6 +18,14 @@
 #define DEFAULT_EDITOR "vi"
 #endif

+static char *editor_program;
+
+int set_editor_program(const char *var, const char *value)
+{
+	FREE_AND_NULL(editor_program);
+	return git_config_string(&editor_program, var, value);
+}
+
 int is_terminal_dumb(void)
 {
 	const char *terminal = getenv("TERM");
diff --git a/editor.h b/editor.h
index f1c41df378..ced29046f8 100644
--- a/editor.h
+++ b/editor.h
@@ -8,6 +8,8 @@ const char *git_editor(void);
 const char *git_sequence_editor(void);
 int is_terminal_dumb(void);

+int set_editor_program(const char *var, const char *value);
+
 /**
  * Launch the user preferred editor to edit a file and fill the buffer
  * with the file's contents upon the user completing their editing. The
diff --git a/environment.c b/environment.c
index 0026eb2274..9aa9124328 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,7 @@
 #include "setup.h"
 #include "ws.h"
 #include "write-or-die.h"
+#include "editor.h"

 static int pack_compression_seen;
 static int zlib_compression_seen;
@@ -61,7 +62,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-char *editor_program;
 char *askpass_program;
 char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
@@ -437,8 +437,7 @@ int git_default_core_config(const char *var, const char *value,
 	}

 	if (!strcmp(var, "core.editor")) {
-		FREE_AND_NULL(editor_program);
-		return git_config_string(&editor_program, var, value);
+		return set_editor_program(var, value);
 	}

 	if (!strcmp(var, "core.commentchar") ||
diff --git a/environment.h b/environment.h
index 27f657af04..053b678786 100644
--- a/environment.h
+++ b/environment.h
@@ -199,7 +199,6 @@ const char *get_commit_output_encoding(void);
 extern char *git_commit_encoding;
 extern char *git_log_output_encoding;

-extern char *editor_program;
 extern char *askpass_program;
 extern char *excludes_file;

--
2.53.0
