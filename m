Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE41EB5FE
	for <git@vger.kernel.org>; Sat, 16 Aug 2025 22:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755384407; cv=none; b=ps3JuoTidbeMikenKXb918EEG8LmiQR2N36b2z3YdRzJ8rgj4/TxLSPE3I1p2JOt5ny3lz78VCenvTUOp4n4VgnAjkBNb1oxSvtlxqUVf6sH6AW4qVKpFMTqngDatzxt6t7WzxOz549z17XyiR9ct7AxTCLXS6l5gLmn4mU+hK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755384407; c=relaxed/simple;
	bh=FzCulLbtybr0Nun3QYMSdCOFPlRjIRGxTr9PLQCz1KA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KUqilNREAKhUJnXlzkPAUvc6YvES/j9GPMNGcfgK2y/eJkdh6tUVLySx6Nx7U5ivJoKFfoxLFggyIJFrbFU5u8+X1u8jZaK7EI5ZNBrZSPeaclrc1wdMkSoWZG0qfD/sqVLF14izA/kMR1hcwBueBL1Ei/pjEJWjznZ5CXoiF18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mx+w6KMk; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mx+w6KMk"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-b472f0106feso1198369a12.2
        for <git@vger.kernel.org>; Sat, 16 Aug 2025 15:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755384405; x=1755989205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRtPyPqFNUDKXJxGCs5tGI3mgsfmcD6XcvO9yvcRkHw=;
        b=Mx+w6KMkYdbInW9aRcRiF1JpU0t+Be/gW/G4Jxu6DueK4SUplLWg+BSW1vWKLuApAk
         fTp5hLlWWfYzgmtbcJZEEz/Zf9O+MpBagNTf0OdcLKfBMdPSeERFn/xykmAtN8qC99Z/
         XlESjNC27py4o2DqOyVwm+q812Jg01d4GGIe+YZtwV3SvjbdsnNpgL0uyxv+GwiTeZuJ
         gNdSjQhiGPY5QNwlQSXgDHnaRlESarKZ//605fro3nnV2gsfl0xfwSbg+jmCBM+DSAq7
         MAmkdmF57Fh+Ogl5k9BYDZyhIzAGk3Yp6m2fQ6llrGNok6RXAxtdhIxgfJUCb7m84G6o
         kgig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755384405; x=1755989205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QRtPyPqFNUDKXJxGCs5tGI3mgsfmcD6XcvO9yvcRkHw=;
        b=Zhn9QTByZsNO5hzNuO6bnyNONtaqYFmf5Dd5w5X+iFmFDTXHSp9zyKM71F2FwYMVk1
         ifqyENLTRZPxi100y8n7UA52sxiGLHyNNjunSmgZFrKt2iSitJefwv4tadawQkpJWOi9
         bbrfn4ll7H0DJGMwurpxU2zNzyKQriuTvKsuf8dNUF/8VfW1yVSqUW2vSUPCGT7uOIz0
         VzYz5QDKg4aCI31yOVKgQOwjcCRxLIyZTUtpG42L3EEdWnfMwoDAGicChQ56Q8/COjI7
         LM1CFiDfstfC/caXqLH5CqBgk5TjKPYee9hRNso2YZItgl4/3ha32zzEYkNXxqqAPFB4
         az8g==
X-Gm-Message-State: AOJu0YwF9+m+9FB2WFP2exNc+ec1AD/D1w6mgAeeqVlXYtsXE2G3+V9h
	TEx3X1wBVBIZBV8v2qjM5FnVwGGCIvAvWR8C6FvP+X4LqRqHlloac4OOuziEpg==
X-Gm-Gg: ASbGncvo+jFXOCRN80O5APYpZdG0ACyEhZOlkrqpJiIOyIge7xy5ABjnSBK4IQk7nI3
	dN0A4u2PrtcJjho6d4q/CWflgv0W/Jr6kFXaqT1rRmAYlNAKWYR74eyHKEkesC0fttBz13/2h8z
	Ezwcbnyy02ShRmE7pUVA1gAZEv+1sqVmY6v+XB+z2ulo6tdH9XMbG2EONp2C6D38hpYryZY8Jy6
	GbenP4juycjjM0StetSkFUQ9N1pj7QIZuTN6Au6uPY4LYBtf89fcvJJF63YWiXxMNaxfVuqhl4A
	hEwm9hO0kEt790YhFK3wpMzgVYIm1qaLivxXUoPDUABNZgCPqO/irG6SevaHxMWcUoch+bEbN4b
	NTqZbtBksQszfiN3vjgOEfF5JxHShBFgiXyzoikpAs7v2LtKWNFajc60gF7Ac1w==
X-Google-Smtp-Source: AGHT+IGPJvDDQK/gWdQ/J3hkhDwDQTI0WpSihWF3Stp5v1zdtnpUNt5eATHQJQUUgj6zRd/X172Otg==
X-Received: by 2002:a17:90b:278a:b0:323:28ac:3c59 with SMTP id 98e67ed59e1d1-32341ec4ad6mr7130515a91.13.1755384405019;
        Sat, 16 Aug 2025 15:46:45 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8e83:e855:1cad:1392:e988])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b472d5ad0f7sm4617280a12.2.2025.08.16.15.46.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 16 Aug 2025 15:46:44 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	jn.avila@free.fr,
	sunshine@sunshineco.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v11 4/5] repo: add the field layout.shallow
Date: Sat, 16 Aug 2025 19:46:02 -0300
Message-Id: <20250816224603.3307-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250816224603.3307-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250816224603.3307-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit is part of the series that introduces the new subcommand
git-repo-info.

The flag `--is-shallow-repository` from git-rev-parse is used for
retrieving whether the repository is shallow. This way, it is used for
querying repository metadata, fitting in the purpose of git-repo-info.

Then, add a new field `layout.shallow` to the git-repo-info subcommand
containing that information.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  3 +++
 builtin/repo.c              |  9 +++++++++
 t/t1900-repo.sh             | 13 +++++++++++++
 3 files changed, 25 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 932b08c26f..01b7f9c95e 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -41,6 +41,9 @@ values that they return:
 `layout.bare`::
 	`true` if this is a bare repository, otherwise `false`.
 
+`layout.shallow`::
+	`true` if this is a shallow repository, otherwise `false`.
+
 `references.format`::
 	The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index aada476e1c..3c9140593b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [<key>...]",
@@ -25,6 +26,13 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
 	return 0;
 }
 
+static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
+{
+	strbuf_addstr(buf,
+		      is_repository_shallow(repo) ? "true" : "false");
+	return 0;
+}
+
 static int get_references_format(struct repository *repo, struct strbuf *buf)
 {
 	strbuf_addstr(buf,
@@ -35,6 +43,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 /* repo_info_fields keys must be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index b0438d276e..6a9cbf3d47 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -44,6 +44,19 @@ test_repo_info 'bare repository = false is retrieved correctly' \
 test_repo_info 'bare repository = true is retrieved correctly' \
 	'git init --bare' 'bare' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' \
+	'git init' 'nonshallow' 'layout.shallow' 'false'
+
+test_expect_success 'setup remote' '
+	git init remote &&
+	echo x >remote/x &&
+	git -C remote add x &&
+	git -C remote commit -m x
+'
+
+test_repo_info 'shallow repository = true is retrieved correctly' \
+	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+
 test_expect_success 'values returned in order requested' '
 	cat >expect <<-\EOF &&
 	layout.bare=false
-- 
2.39.5 (Apple Git-154)

