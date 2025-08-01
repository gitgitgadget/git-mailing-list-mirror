Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C1F72472BF
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 13:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754053899; cv=none; b=ux2EOIzR/B9N+gYMPLkp4PrHtsxb7H5VpxSLFIMl8sRbP10aiQifuNWo6x12ichJ2Pqhl3nes6qDKJ9KBzEe4zYuOkJY5FnFQUou+u+jayYQkX0aT54C8ftN4HaFxoaxov8LpKknHyYiqI/RGqIyXsJ2J5aA4fTVRgaPx6JZi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754053899; c=relaxed/simple;
	bh=uFBR11/11qeBNZlUmIYQ68NXl8Fk5ubF5gl4q2OxK50=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qAS+RZ1w2HmyCYvTywfRhE8USlB027sFjhSrkSxOuWQVUn586AcTgYnag65B3g/NVk6PgWVXzgzjhaYTKC0c/3GEzegVjRvJKPJNatlGc5nsK9S1vOPgZGkLm5GmeFAqiIL27+hARxlg3jYUX/L40fznhfExfBb5w/JF275rgYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fRNczd4a; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRNczd4a"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-7426c44e014so2013987b3a.3
        for <git@vger.kernel.org>; Fri, 01 Aug 2025 06:11:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754053896; x=1754658696; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=USPQo/5UNpO9kj73NAEvdouvkIoiVDG7SXPrgJlDRM0=;
        b=fRNczd4a1nKsHVV3GmupfzBbgJxaYFAsYmrSWYXAHSxuHa4KIM3l1asbYeqkXZPlYt
         J0SEAmijsioGPyBhE0MiWvqvVXLYGqLkdY/NI8DxwXMpt8UJmJWtaQNsKJgMpSaQauVo
         0+MfT6stkNcK508Zbha2gz5RuNBqx9lbXDKib3XjXhKp2h3e07K0r4ou34Eub33FqUB9
         WTsrc6h0jsLvSCtfhVhcI/DZdpz5B6MIV2mGskM7p8/+y0X0MrPbXkI5FrN3KLusgM7E
         8RpLFLu8HO3kzLj0TlaWxbXcuu3sZ4IaLquAtLJVRPQ+1mrckmWvqGA7b2x6WOP1Fwr2
         uXlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754053896; x=1754658696;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=USPQo/5UNpO9kj73NAEvdouvkIoiVDG7SXPrgJlDRM0=;
        b=E6xiLKxMtfAR5c+2Ol5flZ3GimaQzqQRtf99RI/yuKIy6msRF+KJ37g8n6n/Nu4JUR
         ad8RaHLQHmFrq/RI+mZnGyyGpdD2kAmU5xZLnsKKc/iJu6ra2noddJpjWtJz23Igf80j
         uE/wdm7W20tSaGB6AALI71i7mUvUSl5+JTI2Nrm32/+pE6br6+CTOyV88adhpkfe+LKD
         q92zHYJaiKQ8tpNla7T8NpYIiLIFX9gnZaYBMO4+qKnhp6EVlSjpzd0mZCCRboVFIm39
         YD6dO4oBsU+EHMYipBSBw5pukWqyV5Sous27MWHAxRqPzw77oKQ9ei4o6F8IuGD1I3J1
         d9nA==
X-Gm-Message-State: AOJu0Yyu/Mb14PznmT2wGagGH5DWAv4wRImcXEJjb38ILN6t26yyOtIK
	y9m7H2az1Wl3qYZ8MVOSJO71IYXySSA4zz9110gGKYeJ9FAM2iwsAw6qjQ6Of8bp
X-Gm-Gg: ASbGncs5v/6pdMSI/DOOTCpYnaOSQN+cd4gPs88trAART5W2cRf4zCxKqGQbFKIya6X
	U92muPhY3KaS1JpoZZqkFKD9wpNlO1B80gapUYHb4fB0BwjhFfTOOcegMIbE+jtakEDxjskHiFZ
	/d9NJWhIQAL01cFz7ZbejR9nPQIqmKVWNsXka9fhAIjItGyuJEegYPr6Jt/yzhYplBo0B55eRHJ
	YIavvKQKTlOvPNKlWfMeX0V467F+TDp9CPP6DXhYkgpcpd0e2LYTsbp6/a2OwQVYXz4ovXmfIgu
	Dc+02+Iz7d0YvOO4e7UGICJdBGfBI+8nbNtwR09izdGT3jP2FayDEacIOw/Me274Xxil2l1AcZT
	GrWEOa5tTxURJUrrGa+pHM/6FKvDtW4uFhLzOsL8vbeFFIdgZE0dQqvl06Xtk1qI/Yg==
X-Google-Smtp-Source: AGHT+IElTtM42StgdFW80ja8jpQRgQICa1VS6UT+UQx7UhGmELFSXTG5Q8T5U9267aN8ZFfy1rJV/A==
X-Received: by 2002:a05:6a20:7290:b0:23d:54bd:92e6 with SMTP id adf61e73a8af0-23dc0e1cdeamr18814633637.29.1754053896388;
        Fri, 01 Aug 2025 06:11:36 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8c1d:878:ec5d:4583:4785])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b422b7e4fc1sm3542272a12.28.2025.08.01.06.11.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 01 Aug 2025 06:11:36 -0700 (PDT)
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
Subject: [GSoC PATCH v7 4/5] repo: add the field layout.shallow
Date: Fri,  1 Aug 2025 10:11:09 -0300
Message-Id: <20250801131111.8115-5-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250801131111.8115-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250801131111.8115-1-lucasseikioshiro@gmail.com>
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
 t/t1900-repo.sh             | 11 +++++++++++
 3 files changed, 23 insertions(+)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 98358c5539..140ee3a0aa 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -35,6 +35,9 @@ values that they return:
 `layout.bare`::
 `true` if this is a bare repository, otherwise `false`.
 
+`layout.shallow`::
+`true` if this is a shallow repository, otherwise `false`.
+
 `references.format`::
 The reference storage format. The valid values are:
 +
diff --git a/builtin/repo.c b/builtin/repo.c
index 2d51bfa195..56c3a4027f 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -6,6 +6,7 @@
 #include "quote.h"
 #include "refs.h"
 #include "strbuf.h"
+#include "shallow.h"
 
 static const char *const repo_usage[] = {
 	"git repo info [<key>...]",
@@ -26,6 +27,13 @@ static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
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
@@ -36,6 +44,7 @@ static int get_references_format(struct repository *repo, struct strbuf *buf)
 /* repo_info_fields keys should be in lexicographical order */
 static const struct field repo_info_fields[] = {
 	{ "layout.bare", get_layout_bare },
+	{ "layout.shallow", get_layout_shallow },
 	{ "references.format", get_references_format },
 };
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 6c555e90c3..6706cb4c44 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -41,6 +41,16 @@ test_repo_info 'bare repository = false is retrieved correctly' '
 test_repo_info 'bare repository = true is retrieved correctly' '
 	git init --bare' 'nonbare' 'layout.bare' 'true'
 
+test_repo_info 'shallow repository = false is retrieved correctly' '
+	git init' 'nonshallow' 'layout.shallow' 'false'
+
+test_repo_info 'shallow repository = true is retrieved correctly' '
+	git init remote &&
+	echo x >remote/x &&
+	git -C remote add x &&
+	git -C remote commit -m x &&
+	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key '\'foo\'' not found" >expected_err &&
 	test_must_fail git repo info foo 2>actual_err &&
@@ -68,4 +78,5 @@ test_expect_success 'output is returned correctly when two keys are requested' '
 	git init --ref-format=files two-keys &&
 	git -C two-keys repo info layout.bare references.format
 '
+
 test_done
-- 
2.39.5 (Apple Git-154)

