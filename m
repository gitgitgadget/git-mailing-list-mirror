Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3EC13DDAE
	for <git@vger.kernel.org>; Mon, 20 Oct 2025 18:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760984407; cv=none; b=WB0JRMJQGf81QNu5IXE/vdXc4LVLr/tNl9NlK+POsIm4dvc+xkFDIs31pdB4Uxf8i3ozR8fgtxqNR0UlgdiOnNCiZ+EYx6/hXQFkohzJRK3b1ro41Dj+aGxidCnR9bvoYXGlJCFoWNBLQHlGBpTCnxhOY6dTGdvWTBLMmKeNwUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760984407; c=relaxed/simple;
	bh=TFMFfvk//3BmUTbzbMZacnGlBwZblRAwdTC+J17NHK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5R1sIsFYhBQ4A7kHqtn9LhLuzzars7enyFT75g7qFDPM5h/0w7UdGgvhqUb4ozdcCY+ggi3t7sE5YVAWGvn/MkRM7KCgz9ro2H66gUw95EG/votm+LYRjMXGKWPTNRC6GohSAK45zOgZCQMwpFERKgdowTHhRmrWZuVDQ5EgZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=epR9vNCn; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="epR9vNCn"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-77f67ba775aso6084522b3a.3
        for <git@vger.kernel.org>; Mon, 20 Oct 2025 11:20:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760984404; x=1761589204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OLJn1UZiWGFYCQwr55XzN5gFZy7CmNPNoeVp13jJwRM=;
        b=epR9vNCnVV49KPpZxi1nW73pjpEth5zVYcJSGD8mLudlWfu9nn6Xs9QrSpkjONtJxi
         LI7H+Df5mUyEevgARgcI5/t9YqltYZT7pfI7+YzW3zUNkRiAVDzEgJkf8Nd2wx9jKhuV
         kIurqhI7ZAls+3UlKo/OeYC/BVwp1LK/eEStnsDq1J11qFcrqs4pX/y/3UiBhsL6aC9M
         wv4tJzuzFvfTldQJ5tdmQMXD5UKfzLvAUWBOzeRG1WdtLhID8gWoqJJN7+yMYYVHaY0p
         +cKQplZxqS7XuHpdFEG/bFLPAPL2YbshQWnp6TmVpo38tM/hK0fZ7XxENmRP+0EZ4ezn
         5APg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760984404; x=1761589204;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OLJn1UZiWGFYCQwr55XzN5gFZy7CmNPNoeVp13jJwRM=;
        b=TcKxYzfEXTQub496Dc9NbJUl3jiW009IbYQkUK6FRR14tHX/pFJ5CJBVfq4MjTZ0SB
         T9fv7qkkBHF1374cUQImhQH7GWGxjP8vg2MO65hNrSOYFSquaJHPuhjon+ATMTICAphq
         1kXftCZFS2/j/C0UWs0aBv2GcEXneglq+02OuV8RtuM0RGPnvv0iSSwpJbQyh5A9Mbo8
         hQMIWmJiNkKhkxhNwmMrG2vc0Ejxf8OM98Zt2zVHgXPUrAEmNyS5gCbKYIvhh3FGiMG+
         Yx9rg87hjjN55fN7H2QGD/355TCvP4E7eDxyOK2HzZHwoFgXFgOnhdzVFBNoyEBD+2rY
         tCvA==
X-Gm-Message-State: AOJu0YzZwQIV1S9SGfXud0rrsQWLETBbJ4+3RWy6QCqUXcNoX9NQ0ru4
	JSRp2MtO5nlvInVtKyAm8SKehKpIHl7eoBhX7dcFQyXev1nEyshDuKGGxPtvoMe0
X-Gm-Gg: ASbGncuyQeHra1yamXdtMX0s9k14da4Yeoi21P5L/piwDqOosJ3fIelLZEiHvw00fLK
	XKZwLyXGalXUAbDmL6MTV2lpjQO1cm2o4N9wUGRac5+4/srbOJ8Etc4rLKMtT2qgmZIYaEYj2RE
	sPKSG21jKWC3LOeYvifiRWMI3YFI58jZyNl5W4/Ffc6vVb9x1eElpmm+GMxR0yVziUoaQoaKYqG
	Mf/jOyR/D1UR+oE1hA2/9iOX9/qZ2pAALxXzByfxhq+NqQY717UkX92ZAkUAWHP6ltPgybHv8Df
	sQ59LGNimQfdLxTBaiXeeyNCDdSf+RipXdcvIOLLJu4GH3EJoOjUR4EwZGp9WRsj5Bh92GW9f5+
	pKl6XsVii/b1SvX0MFKLVauwvUGMN/NoGHOX/g+AjJMjhXfpeRDCAOGqAW3H3FR2G+scko2juXN
	HEEt+c5FEsvnHtwVtCFZ4EHBoNRPZyLbNxJSAChLvQzER8pMvvu7PJ0/T9KD4=
X-Google-Smtp-Source: AGHT+IHF7d4lWFnU/55Pwci301CKLpDkceomoNonTXMl1/8gkhdS5Rw5SxOdx89se3kobtoxbUljXg==
X-Received: by 2002:a05:6a20:244f:b0:2e8:1c23:5c2d with SMTP id adf61e73a8af0-334a863ac96mr19355612637.50.1760984404322;
        Mon, 20 Oct 2025 11:20:04 -0700 (PDT)
Received: from localhost.localdomain ([177.118.183.70])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6a76673a86sm8099382a12.10.2025.10.20.11.20.02
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 20 Oct 2025 11:20:04 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 2/2] repo: add --all to git-repo-info
Date: Mon, 20 Oct 2025 13:19:47 -0300
Message-ID: <20251020181943.6314-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
References: <20251020181943.6314-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a new flag `--all` to git-repo-info for requesting values for all
the available keys. By using this flag, the user can retrieve all the
values instead of searching what are the desired keys for what they
wants.

Helped-by: Karthik Nayak <karthik.188@gmail.com>
Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  7 ++++---
 builtin/repo.c              | 27 ++++++++++++++++++++++++++-
 t/t1900-repo.sh             | 29 +++++++++++++++++++++++++++++
 3 files changed, 59 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..1a9d0c50a9 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
 
 DESCRIPTION
 -----------
@@ -18,13 +18,14 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [-z] [<key>...]`::
+`info [--format=(keyvalue|nul)] [-z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
 +
 The values are returned in the same order in which their respective keys were
-requested.
+requested. The `--all` flag requests the values for all the available keys.
+Keys requested after `--all` will be duplicated.
 +
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 3b071e9a50..1c54db5810 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
 	NULL
 };
 
@@ -124,6 +124,26 @@ static int print_fields(int argc, const char **argv,
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
@@ -145,6 +165,7 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -153,11 +174,15 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_BOOL(0, "all", &all_keys, N_("return all keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (all_keys)
+		print_all_fields(repo, format);
+
 	return print_fields(argc, argv, repo, format);
 }
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 2beba67889..28635d0f92 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -4,6 +4,15 @@ test_description='test git repo-info'
 
 . ./test-lib.sh
 
+# git-repo-info keys. It must contain the same keys listed in the const
+# repo_info_fields, in lexicographical order.
+REPO_INFO_KEYS='
+	layout.bare
+	layout.shallow
+	object.format
+	references.format
+'
+
 # Test whether a key-value pair is correctly returned
 #
 # Usage: test_repo_info <label> <init command> <repo_name> <key> <expected value>
@@ -110,4 +119,24 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git repo info --all returns all key-value pairs' '
+	git repo info $REPO_INFO_KEYS >expect &&
+	git repo info --all >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --all <key> duplicates <key>' '
+	git repo info $REPO_INFO_KEYS object.format >expect &&
+	git repo info --all object.format >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --all <invalid key> warns about invalid key' '
+	git repo info $REPO_INFO_KEYS >expect &&
+	echo "error: key ${SQ}no.key${SQ} not found" >expect_err &&
+	test_must_fail git repo info --all no.key >actual 2>actual_err &&
+	test_cmp expect actual &&
+	test_cmp expect_err actual_err
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

