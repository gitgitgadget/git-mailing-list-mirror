Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57038385
	for <git@vger.kernel.org>; Thu, 14 Mar 2024 22:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710455679; cv=none; b=pwVecocJynXJVIsTu3wPmQd9O8lY/NMWTELOn/ZuW7jwY/PTk7wRFW2IyKGyycO+NQR8bgG5NEnS/M8HjyEDiD98t9caYMCzWyzXRhRY4a70QIEDqKeBaX05x/etTPAiFjBtWtNELRVKizRLSXhu/90VNQ9Q6vodZeFY9ABJSuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710455679; c=relaxed/simple;
	bh=2Dq0v7lII9VMqpcyw/gZ8w8aQ5zV6yLACTo+4N24oow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ahUFw6Ovp1ub1Jgq5CXOFZfUnsIlIDWbzgPxm4uveQ4fKLg2SHi90yKMIsXj/AB2pjmQ9KHS7Ue1G5fqeqku63kiThHd5qBysowb7+cHqwTBZIJY4nLA27qUcoGeHVKgUFUPz2DIdL6CQxYmJVXstYKd0kPQazMeEtDjmp/gu2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KvzWBbhk; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KvzWBbhk"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-299b818d63aso1121820a91.0
        for <git@vger.kernel.org>; Thu, 14 Mar 2024 15:34:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710455677; x=1711060477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F/DNKAdkmAQkncYLcI/XVDKdMS//1UHZpj5Ap2ADUog=;
        b=KvzWBbhkz2U1F0jNexmyrsWUE2g40I0Gt/ZPHqtPLEU7e7fjt/h+TUB1BFYOt9y7TW
         TPgI4M77SEg4XkKKpzXUikrDudIpMa+SWtYMUzIkGOUAW7HDfEN20GQx4TmSdaMOivDc
         jcCOluwlTykWo9vSSulsBi27tc7XRvb9JmgLjChpdRTN506rLXBZMDCafoz4izcTAy11
         1LhL+PXaB5eZtTaKg0PXmviuJUx9dMGfwAyrLTwxk3i7OKglV7WN5b0rloAzFmcZb2go
         kg4xK8Z0FXXykccpFUYwi1mgmist8NENk/Is0X0xv1I2v4BuMf868sFosA/nYNVpa4VN
         LC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710455677; x=1711060477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=F/DNKAdkmAQkncYLcI/XVDKdMS//1UHZpj5Ap2ADUog=;
        b=QXPFx2HgR4QQAQnQQCGQIwpwqwKaqNqSxOZK83EahOb2+eY7JjuiwcU3eOF4H7KSdh
         +TU3C/uwTftI1Gzg9d7rZIVffVpWi401Fav3gQiIVrSsRfiQd4Xh7IILy1Cb9Agay1Zy
         wQOGffHuqIrOoAR4Ps2zMnfnkhexTv93hdvO23YEWbGJMQAB6QMcOJzLyh8JUvgAjYim
         w3ktB7BSJWRJm5hA9Z+UtQ6VVpmCYTDXKI6gXoab/B14s4Wy0A+sgUIO0C1TRBV+ehcj
         cVYJ8sY1F9Z+E03HRqZz2fr2FEITtoBy8lS/VEYqasRFOqA4BQ0JqbpwNP79eHbxT17Z
         2HSA==
X-Gm-Message-State: AOJu0YwV0YI6Vh+b06PZPmxbP4qBzyjG+UCSuM3gCNeG/9evC1DNRAoJ
	3xPEgwHmBwpIXmjQ6dnHNgOMp+7xihfAy+6lUG1uDGMLaDq883UgpcvKgFRGz/I=
X-Google-Smtp-Source: AGHT+IGgikeAsmFJfz8JeK6u9den4M+L+YL4oe6CyyOkLuTXWMPklso4jDZMPL7GU2Ip3ziwEB33KQ==
X-Received: by 2002:a17:90a:7e98:b0:29b:a345:620a with SMTP id j24-20020a17090a7e9800b0029ba345620amr4522614pjl.20.1710455677377;
        Thu, 14 Mar 2024 15:34:37 -0700 (PDT)
Received: from SUPERFORTRESS.. (p093208.f.east.v6connect.net. [221.113.93.208])
        by smtp.gmail.com with ESMTPSA id qc9-20020a17090b288900b0029bbab9516fsm1486232pjb.40.2024.03.14.15.34.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 15:34:37 -0700 (PDT)
From: Jiamu Sun <baiorettohr@gmail.com>
X-Google-Original-From: Jiamu Sun <barroit@linux.com>
To: git@vger.kernel.org
Cc: barroit@linux.com
Subject: [PATCH v3] bugreport.c: fix a crash in `git bugreport` with `--no-suffix` option
Date: Fri, 15 Mar 2024 07:34:06 +0900
Message-ID: <20240314223406.79283-1-barroit@linux.com>
X-Mailer: git-send-email 2.44.GIT
In-Reply-To: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
References: <pull.1693.v2.git.1710388817.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

executing `git bugreport --no-suffix` led to a segmentation fault
due to strbuf_addftime() being called with a NULL option_suffix
variable. This occurs because negating the "--[no-]suffix" option
causes the parser to set option_suffix to NULL, which is not
handled prior to calling strbuf_addftime().

By adding a NULL check, the `--no-suffix` option is now available.
Using this option disables the suffix, and the file is just named
`git-bugreport` without any disambiguation measure.

Signed-off-by: Jiamu Sun <barroit@linux.com>
---
Changes since v2:
- Squashed the previous patch series into a single patch for
  clarity

 Documentation/git-bugreport.txt |  6 +++++-
 builtin/bugreport.c             | 10 +++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-bugreport.txt b/Documentation/git-bugreport.txt
index ca626f7fc6..112658b3c3 100644
--- a/Documentation/git-bugreport.txt
+++ b/Documentation/git-bugreport.txt
@@ -8,7 +8,8 @@ git-bugreport - Collect information for user to file a bug report
 SYNOPSIS
 --------
 [verse]
-'git bugreport' [(-o | --output-directory) <path>] [(-s | --suffix) <format>]
+'git bugreport' [(-o | --output-directory) <path>]
+		[(-s | --suffix) <format> | --no-suffix]
 		[--diagnose[=<mode>]]
 
 DESCRIPTION
@@ -51,9 +52,12 @@ OPTIONS
 
 -s <format>::
 --suffix <format>::
+--no-suffix::
 	Specify an alternate suffix for the bugreport name, to create a file
 	named 'git-bugreport-<formatted-suffix>'. This should take the form of a
 	strftime(3) format string; the current local time will be used.
+	`--no-suffix` disables the suffix and the file is just named
+	`git-bugreport` without any disambiguation measure.
 
 --no-diagnose::
 --diagnose[=<mode>]::
diff --git a/builtin/bugreport.c b/builtin/bugreport.c
index 3106e56a13..25f860a0d9 100644
--- a/builtin/bugreport.c
+++ b/builtin/bugreport.c
@@ -64,7 +64,8 @@ static void get_populated_hooks(struct strbuf *hook_info, int nongit)
 }
 
 static const char * const bugreport_usage[] = {
-	N_("git bugreport [(-o | --output-directory) <path>] [(-s | --suffix) <format>]\n"
+	N_("git bugreport [(-o | --output-directory) <path>]\n"
+	   "              [(-s | --suffix) <format> | --no-suffix]\n"
 	   "              [--diagnose[=<mode>]]"),
 	NULL
 };
@@ -138,8 +139,11 @@ int cmd_bugreport(int argc, const char **argv, const char *prefix)
 	strbuf_complete(&report_path, '/');
 	output_path_len = report_path.len;
 
-	strbuf_addstr(&report_path, "git-bugreport-");
-	strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	strbuf_addstr(&report_path, "git-bugreport");
+	if (option_suffix) {
+		strbuf_addch(&report_path, '-');
+		strbuf_addftime(&report_path, option_suffix, localtime_r(&now, &tm), 0, 0);
+	}
 	strbuf_addstr(&report_path, ".txt");
 
 	switch (safe_create_leading_directories(report_path.buf)) {
-- 
2.44.GIT

