Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3AD143736
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 02:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742782272; cv=none; b=e1NOh+FozuWp89VJKmnE81ZInn0UsHTucei1ClcGFkrXa6oPwOYV1Tuu9ttKwhdSwY6YIX7j50+NHhhFkPJfsUl+ALGzn6JgMJn4Anlns7EcnbJTbtR7v+ET0RDtBrGLllyNqV9lysnd0gr4ReAIPKcfUtbvVY+HzqJsXNE5BsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742782272; c=relaxed/simple;
	bh=8x7+qJs8CTx09ttZa6L63ZAcJwEirt3YjtFjSSyezhY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=av6xXQWfdnuKjxdnSm9TIsO7KYrucOIPozETIYJrEhqg7igwJaBZYtsz9I/IDPSFIQpVnYJFyFb9Fqh++NYDtUcvWgxpryVEadRVkFCZ09KeWNdgdFuKMdb93Tu7Vqc6g/xX08T42b8MDlsfXWHY9/sW1gEgT2ntbdqQIZVKQXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=idu5BaA5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="idu5BaA5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2260c915749so48314685ad.3
        for <git@vger.kernel.org>; Sun, 23 Mar 2025 19:11:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742782269; x=1743387069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LG0ls1jJfjsoJJHwe3YsjgmRJ4JLk3LJsjb7nYs7J4s=;
        b=idu5BaA5YvEbKo+RDGTMgo2NwLAzqvG0VQXdWn71BmQSpE+l4Q3p4/Ump2NlpZs+do
         i2HcCtADsN7pcbs0swR1o3GeORXBHVC+QWqgrvljj2/PNQlrFahbRIm0iUjIOz4XxDi8
         fkYlU8ghWhbnKdHpD0SJW+JIgoeu+sdcugU+nKK6SP3IDOx9XxmqHCaOSMAmHM5oNfYR
         WkI/Po/SdUyZrReEw+dDhPheLBOLolhu1t3cPVVYfQ7lfQRWGEIBgCR4L+Bkx2oObd8C
         rn7Y9BkC5WZsNBb2iKwKB1BXl49icnClTAKdWWcVu5gJ8DKy4GHndxoKxvKw8vWyMrdD
         JYpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742782269; x=1743387069;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LG0ls1jJfjsoJJHwe3YsjgmRJ4JLk3LJsjb7nYs7J4s=;
        b=X3rFnPl+k4th6mazaIw4a8NrxlIwrJT7CMO8eLhRGgyGboL5W8QY21qfoVQGaHQ/wQ
         vCAuahK23C2D9st1i88Lzj4p6i/UF82NGPCQG2A9qjZXukA3MiCzUL8hHqQn17SgoP/x
         Pzz2w9HwmhWzXC4Rw+4QbArnq04K0Vgp907nLlaOhldyoky3b+od24EOMjj3EFXSVRBN
         nwumm5zzn/YRwV+Z7Wd6XAoIHKO0ko24NtBuAkcMN8YgZrfxYKpZIHUheOX7Pfyl/oyg
         6qgUYfy0xGTwAIFrhds8a1thTwES4ygxCIPnKVwVENkDHluulg9oPfy+7lB/wLOdibYJ
         +0gQ==
X-Gm-Message-State: AOJu0Yznjyr1lNnoJdiN9aAQ+YDKn7Rdq9A5HvSBD7u29nnEwtULwHyT
	Br22dqiuu2wozLo/ORA9A3gll3cqgZuZymNk+wQJBV0ImVfLrrQOMCPgjQ==
X-Gm-Gg: ASbGncs0PEg/bHjakFmHvJERWgHaRL7OlQyAtXfdTVkNpkjCCh02YXbZUumShtcvVjJ
	ZhqUUo1TgGw8tIi+dOeNVrd3tTbKemHz8RvNblLodW59efr59huLoXKSD3Psu4nXIZQnd2KetWI
	enZF+JCKHMPzlgYUGHdg1Pvm6r7ngtIpiFosxGNG33Kv+BkPoFAXePbyI1pxBfjPlALGenvswLc
	Ee9kboBtVeIP1RAxo7VJDgJltZJkBU00WruVhL0gsKYi595wDunrMzSQZiWLSe6FYN1OeetGOvd
	1aZmx5ZHqSZtkFW2fZ7FRMspe1V8wjc19d1zJwKq+jI9eRkJOb0Q5adMajTy9bgUAGgvWH7Bqkv
	jAjbB3dM0Y4A=
X-Google-Smtp-Source: AGHT+IHDZzZ+Gxr23H8p9eopdxKSbCKxWlj1rkDRdc8t6psQrGIjrBa6oqMaAozjTn2fd5n1plMuRQ==
X-Received: by 2002:a05:6a00:3d43:b0:732:2923:b70f with SMTP id d2e1a72fcca58-7390599ea49mr19472198b3a.11.1742782268617;
        Sun, 23 Mar 2025 19:11:08 -0700 (PDT)
Received: from localhost.localdomain ([2804:7f0:b77d:1b50:1d6c:cbd3:c52f:6b5d])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73905fd57f7sm6592913b3a.44.2025.03.23.19.11.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 23 Mar 2025 19:11:08 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	"D . Ben Knoble" <ben.knoble@gmail.com>
Subject: [GSoC PATCH v2] userdiff: add builtin driver for gitconfig syntax
Date: Sun, 23 Mar 2025 23:11:01 -0300
Message-Id: <20250324021101.7483-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From Documentation/config.adoc:

Add a new builtin driver for gitconfig files, where:

- the funcname regular expression matches sections and subsections,
  i. e. the pattern [SECTION] or [SECTION "SUBSECTION"], where the
  section is composed by alphanumeric numbers, `-` and `.`, and
  subsection names may be composed by any characters;

- word_regex is more permissive than the syntax specification, matching
  any word with one or more non-whitespace characters without checking
  if it is a valid variable name or value.

A more detailed description on the format of gitconfig syntax can be
seen by running `git show cfd409:Documentation/config.txt`.

Also add tests for the new userdiff driver. These files define sections
and subsections, with and without indentation.

Helped-by: Patrick Steinhardt <ps@pks.im>
Helped-by: D. Ben Knoble <ben.knoble@gmail.com>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---

Hi!

This v2 removes the quoted text from the commit message, using a reference to
the documentation file and the commit that last changed the lines where it was
copied before.

I'm also adding the missing newlines at the end of the test files.

 t/t4018/gitconfig-section             | 6 ++++++
 t/t4018/gitconfig-section-noindent    | 6 ++++++
 t/t4018/gitconfig-subsection          | 8 ++++++++
 t/t4018/gitconfig-subsection-noindent | 8 ++++++++
 userdiff.c                            | 4 ++++
 5 files changed, 32 insertions(+)
 create mode 100644 t/t4018/gitconfig-section
 create mode 100644 t/t4018/gitconfig-section-noindent
 create mode 100644 t/t4018/gitconfig-subsection
 create mode 100644 t/t4018/gitconfig-subsection-noindent

diff --git a/t/t4018/gitconfig-section b/t/t4018/gitconfig-section
new file mode 100644
index 0000000000..18c85eb613
--- /dev/null
+++ b/t/t4018/gitconfig-section
@@ -0,0 +1,6 @@
+[RIGHT]
+        # comment
+        ; comment
+        name = value
+        ChangeMe
+
diff --git a/t/t4018/gitconfig-section-noindent b/t/t4018/gitconfig-section-noindent
new file mode 100644
index 0000000000..5c58a7ac92
--- /dev/null
+++ b/t/t4018/gitconfig-section-noindent
@@ -0,0 +1,6 @@
+[RIGHT]
+# comment
+; comment
+name = value
+ChangeMe
+
diff --git a/t/t4018/gitconfig-subsection b/t/t4018/gitconfig-subsection
new file mode 100644
index 0000000000..569be04a32
--- /dev/null
+++ b/t/t4018/gitconfig-subsection
@@ -0,0 +1,8 @@
+[LEFT]
+
+[LEFT "RIGHT"]
+      # comment
+      ; comment
+      name = value
+      ChangeMe
+
diff --git a/t/t4018/gitconfig-subsection-noindent b/t/t4018/gitconfig-subsection-noindent
new file mode 100644
index 0000000000..85c5074f47
--- /dev/null
+++ b/t/t4018/gitconfig-subsection-noindent
@@ -0,0 +1,8 @@
+[LEFT]
+
+[LEFT "RIGHT"]
+# comment
+; comment
+name = value
+ChangeMe
+
diff --git a/userdiff.c b/userdiff.c
index 340c4eb4f7..5bbcc2b690 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -198,6 +198,10 @@ IPATTERN("fountain",
 	 "^((\\.[^.]|(int|ext|est|int\\.?/ext|i/e)[. ]).*)$",
 	 /* -- */
 	 "[^ \t-]+"),
+PATTERNS("gitconfig",
+         "^\\[[a-zA-Z0-9]+\\]|\\[[a-zA-Z0-9]+[ \t]+\".+\"\\]$",
+         /* -- */
+         "[^ \t]+"),
 PATTERNS("golang",
 	 /* Functions */
 	 "^[ \t]*(func[ \t]*.*(\\{[ \t]*)?)\n"
-- 
2.39.5 (Apple Git-154)

