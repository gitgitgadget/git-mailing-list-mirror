Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B482D052
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 22:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757975797; cv=none; b=LLlEvNznkzNp7uN8JTupvYe08sXOmm06OMguyC4088caNqcTI5A1CJNNuX7ybn6nDcT4R3VQmoGLcKqpoAHkjh6b+adSsrbumN2XZZNCEDdxUsojzR6lfasjTAU2cybRQU7qxIefAS7UmmUsDYZOYbkkneFkpdE1oz7NHnKDaIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757975797; c=relaxed/simple;
	bh=pGb0xZpDFqIDgiQtZCqYmfVbK8M2jJVZrz7D2YAHfHM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IRPgleWhE9Ix9UAG41Wc5fH4hbEY4FKNI4v6brZmmEx8cugimg5HxhDlwhzkuEGN92W31xwSt/+qi2jXMr98qxqUkfBRQyxVF3gQYJlcLH2v1j5Ho+mQE5LS6y8VpxY5LtY++GGadxRBky/zxSNPlQ5C3tC3d9f/9bStjwOeU24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WPsENcWX; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WPsENcWX"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-26058a9e3b5so19211415ad.2
        for <git@vger.kernel.org>; Mon, 15 Sep 2025 15:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757975795; x=1758580595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mtd9FwQtxuCm4CUrf/PdGNfUto52evN+UUuGKFoaUhU=;
        b=WPsENcWXRjUD49pz+sk0GsAenmb4ohSPeF4eZrkntwX2rpBuAXjMtSzP6LnoomsTDb
         jU8sEq98hZyAAweSefsD0hjOsSyx5pNM3q3PN3JH0yX1YycVcjuc3vidl4s5fITi74Ux
         5gaJ2q6c0lad0A7y5CBY5B2SpnMfjAmq4IklFi1UsEBx5VkAwe9pm6alZaW22Bp5moQU
         SfrcVIWVKSdNuqEgKdhOqfmkg46L2cYJjX+Tnmz11juah33svQYNnLHyJ8WGJHFJuT3l
         lSgCOb6vftjGptcyLUHHmT6h7TMk5Ikf64cD23+UPxmSl9laCY/ujBavyVMsuERqn0bU
         P5EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757975795; x=1758580595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mtd9FwQtxuCm4CUrf/PdGNfUto52evN+UUuGKFoaUhU=;
        b=pT9eOnedHkKv9BUWKn/IyVONBfXdOaFblyzKQb/HHKLG+93YIj92l8PClEWyXxFRIg
         BPgtXtSlhs4cFLb9VVaSeJPGtwyucesrdxf3wquRPHk8J+g1NMis2C53RtPzTpo3wR75
         MWQU+qtO9oEY8pcCpS9Lz/+nnpwoXB3siuQEZObqBamuVDl1uieXIqGC7kNdJq8j0I8y
         4yY9qhGh5NYnB3fhpuuUv8gsLyPWwmLklWeS1JpyiC6F3RktysQRd6njItTMiWhE9Lan
         GztSczRUn0oF4rf/RGQMrMmpNExQA2z9IO9SVzYB/cqTpTmX6VkK9+Uh0z1QZ4zzZxnX
         lPeA==
X-Gm-Message-State: AOJu0YxkU6WvIPkejunJQ2vl0N3qNqHD5N3Jt8Pb9r5+SmAXmkBUah2C
	SS2n4f4DwWBIViwMAPJTvxcTOz7JMBd+WkaO08rRgyO0VqvU+2LiR1VVjudHOA==
X-Gm-Gg: ASbGnctBbVKmMHeZxHjWPSccXZVYnTP1qRrsUQMj52EGjmk4aBCpvUUhqyWsTaVp3Kt
	UJx7N7GesGtmE9V2r64XbJBnY7VmvkEALDtRlWdth8yDGyMeS3N+/7EUky+Zfb3jFkFhv0xp7qf
	AThsxQfpPXeJC5ixXOJZpx7gU1+uiP8iusHe/rXFozCKzVfh/MjX3snElZ2FHZBvLymcC8dmQQg
	/8TXmyfKKQqcpgbQtHRbUooaIZel9nw4VEvnY5mQPvSygWa1J2paDRbF5x7CKL2DoTldqt901bo
	WiAYB6W/LjvVyEUtNVGplrfFTGoGp/s4tXNDaH0vOnq/kpg4l/OhpazGSc+4BdSXrDShIrlXTZK
	dO+psJXBnHOP4dvQJWrMueI1SpjnzzLQxbiOm3qf7ACAYSkXeRBh0chfgoBmD8QI5rw==
X-Google-Smtp-Source: AGHT+IH6FSRDN8wjbQOWCcstAz3/YcSJruop4Kq7/dBdW8VA5HTcJWBQt8zWEMPeEZ98K4lUUcg2Rw==
X-Received: by 2002:a17:903:1b68:b0:264:4e4a:904d with SMTP id d9443c01a7336-2644e4a9270mr71543225ad.15.1757975795208;
        Mon, 15 Sep 2025 15:36:35 -0700 (PDT)
Received: from localhost.localdomain ([191.181.57.234])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-32dd98b43a7sm15666316a91.13.2025.09.15.15.36.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 15 Sep 2025 15:36:34 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH] repo: add --all to git-repo-info
Date: Mon, 15 Sep 2025 19:36:17 -0300
Message-Id: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new flag `--all` to git-repo-info for requesting all the available
keys. By using this flag, the user can retrieve all the values instead
of searching what are the desired keys for what they wants.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
Hi!

This patch is an epilogue of my GSoC, as it was requested to have some
way to retrieve all the values without needing to pass all the keys.

This is built on top of the current master, a483264b01 (The ninth
batch, 2025-09-15).

 Documentation/git-repo.adoc |  6 ++--
 builtin/repo.c              | 62 ++++++++++++++++++++++++++++---------
 t/t1900-repo.sh             |  6 ++++
 3 files changed, 56 insertions(+), 18 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..2caf093a9a 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,13 +18,13 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
+`info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
 +
 The values are returned in the same order in which their respective keys were
-requested.
+requested. The `--all` flag requests all keys.
 +
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
diff --git a/builtin/repo.c b/builtin/repo.c
index bbb0966f2d..906d8a3e12 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [--all] [<key>...]",
 	NULL
 };
 
@@ -77,6 +77,24 @@ static get_value_fn *get_value_fn_for_key(const char *key)
 	return found ? found->get_value : NULL;
 }
 
+static void print_field(enum output_format format, const char *key,
+			struct strbuf *valbuf, struct strbuf *quotbuf)
+{
+	strbuf_reset(quotbuf);
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		quote_c_style(valbuf->buf, quotbuf, NULL, 0);
+		printf("%s=%s\n", key, quotbuf->buf);
+		break;
+	case FORMAT_NUL_TERMINATED:
+		printf("%s\n%s%c", key, valbuf->buf, '\0');
+		break;
+	default:
+		BUG("not a valid output format: %d", format);
+	}
+}
+
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
 			enum output_format format)
@@ -97,21 +115,8 @@ static int print_fields(int argc, const char **argv,
 		}
 
 		strbuf_reset(&valbuf);
-		strbuf_reset(&quotbuf);
-
 		get_value(repo, &valbuf);
-
-		switch (format) {
-		case FORMAT_KEYVALUE:
-			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-			printf("%s=%s\n", key, quotbuf.buf);
-			break;
-		case FORMAT_NUL_TERMINATED:
-			printf("%s\n%s%c", key, valbuf.buf, '\0');
-			break;
-		default:
-			BUG("not a valid output format: %d", format);
-		}
+		print_field(format, key, &valbuf, &quotbuf);
 	}
 
 	strbuf_release(&valbuf);
@@ -119,6 +124,26 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
+static void print_all_fields(struct repository *repo,
+			     enum output_format format)
+{
+	struct strbuf valbuf = STRBUF_INIT;
+	struct strbuf quotbuf = STRBUF_INIT;
+
+	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		struct field field = repo_info_fields[i];
+		get_value_fn *get_value = field.get_value;
+		const char *key = field.key;
+
+		strbuf_reset(&valbuf);
+		get_value(repo, &valbuf);
+		print_field(format, key, &valbuf, &quotbuf);
+	}
+
+	strbuf_release(&valbuf);
+	strbuf_release(&quotbuf);
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -140,6 +165,7 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -148,11 +174,17 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_BOOL(0, "all", &all_keys, N_("return all keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (all_keys) {
+		print_all_fields(repo, format);
+		return 0;
+	}
+
 	return print_fields(argc, argv, repo, format);
 }
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 2beba67889..b1391a47b6 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -110,4 +110,10 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git repo info --all returns all fields' '
+	git repo info layout.bare layout.shallow object.format references.format >expect &&
+	git repo info --all >actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

