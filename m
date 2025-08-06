Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B07D22BCF7F
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 19:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754510181; cv=none; b=IrIACRhC8mgCWJbK+pNc4zf9IwqedGHIJg1OaC+V2FYLffUZJjFE8mqC7fd3JCpXf9oWvwiAEye7rhoC23rA454TMpB84Ft0HkSCbh79SbyG3+0gwO/fhIUQG8ZS1S/3rFNUli64cA714Hlc35Gqr6w0sOnre0jx9CJO+YOf3PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754510181; c=relaxed/simple;
	bh=kzkThg/dLDuUctlzfbunnXve3c5GZbeC7STawvxYf1I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UHxjlRIF6os6b5Vkvfd/ZIz/z320/+QiPUp01i6+hWkh/1LGIt0UrxCQP3A+EDiSagO0B+EJWPXVvRRTKD00JTRQNM3VnZg0lMrYlYDc5gakjGkk6bE5wjRrFNCGjU/JlyNbMn+HVUH9EuZ5c8+Ss6PDGhXIG5OtHjVJLy0R+HI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OXZ7OFzo; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OXZ7OFzo"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7426c44e014so302752b3a.3
        for <git@vger.kernel.org>; Wed, 06 Aug 2025 12:56:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754510179; x=1755114979; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1en4D+ZbI7wW5a0j1JiI15lxnni1ZYfm6AhtF7J4qTU=;
        b=OXZ7OFzoxw7i9IQDx9JOIHeU6LAxMnyqojM7w63Ppsioftqv+mYZytwO/UyLV2T4yr
         azbrSgxi/QbMuwLmhsOZLvCc3beYsxn1Bfmnw9Txr2Cz/L9VZycNXKX8JcmOvhcDvYb9
         riv0Sle2XOmkfv6DD9+eqf21NNYl8XOvCVZL+7Vf/oEeRDk3JEdua1zfvBjTL+owggj+
         wdagjxI6aD9Pn5/IgDaJEiX6PzmL1KjAqdstYVEk6Gm2All1MRHtvgIzleqqaMo178GI
         1T/mbxs8DZMH5dUFR0EJ+QDRlOm1CeSdluLYHjZdHevJExSYDBSdR7S0jIVphCMjrF5X
         Vg5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754510179; x=1755114979;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1en4D+ZbI7wW5a0j1JiI15lxnni1ZYfm6AhtF7J4qTU=;
        b=n+ytScb3liADF7h0AfXFAtTxvFC0+BpPGsr7I82Xs4QmCbMda0so56KFwHfMYdimOS
         H58RiBDx7h5Mnh6XEig3lYS9wEhoiaRSYSWgem4YaAfMQNJXIrYSm2IL5sLB5TPm2kdH
         +WVkOx6IprUf30i87l9Zt65n8Os5fJfi40tHB7iSdeG1ASxbf4XiYHQrNf7vGXOochgg
         +YZ6A+kLW4OyhVk2wFiLA51nrKOBdzAhGI7irHKDgBcZJL6baUWLDHk0Qc9VsUc9/h5N
         3mVTrhXLUEwGvOa4zDX4222VvfZQOUmB60xtoP5wO1tJaIYgk/HUe9Y7lEA5xOhuBhTQ
         HixA==
X-Gm-Message-State: AOJu0YxG0q7AqJSAAaBJC7upmTQi5NSQrCyjM0FPlO40yOdeHZ72X0lI
	DcMHNbG8OfYTC+pP7q3BmCf710oysdSxI+Iu0LJezO4uqSsv7p3X6BOp7f7xTEZf
X-Gm-Gg: ASbGncvVMBJGA5XDEd4RkF3aQXrKyoGJIHTJsAcI0FVTaRLKQnkn5A8Xjh7EM1vEPVz
	bWz5uu3YqqTMSohkh9yQTxMpD2UCLv8TjEXD3RawI3gkgDHTFYH+BYjqwHMC2d+Cb8yKwUEApk4
	UR5bD0nOVCOBtdNLU1EbavhWoEisoCz7DXFawqwDpm6dh00mh5uHjTxDf6u1jGZWfuFN9KF6cQ8
	WyKMwNFwsX2dXt7N0KvB7oCtQE/ehGSTp6wzdpCd64PTqmHpcO334K28uZ+pwWVkj8S+QnpIU1c
	jyu2g1zBd3T/Ks2ZjtP1GGbS670RIcsARtTs91ElBp9Q+ZLjuxZYJJVX6/WZRZWeYm0JS+aLUD5
	yfLsZSvexcwlc6uej/TSPUUDJOlg4hzZUiAZuS9/TyIFLTyTEFv0o+qmj1PFuEXk=
X-Google-Smtp-Source: AGHT+IHAwBtoD3ZxyJaj2gPPsxJw4R22gXJGCqXN3X/8CgDSUIp8F0f/Hspv1wNyXakyWg4xIM7E0Q==
X-Received: by 2002:a05:6a00:189a:b0:76b:e805:30e4 with SMTP id d2e1a72fcca58-76c3897f3e6mr411562b3a.24.1754510178610;
        Wed, 06 Aug 2025 12:56:18 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76bccfd026dsm16212400b3a.95.2025.08.06.12.56.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 06 Aug 2025 12:56:18 -0700 (PDT)
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
Subject: [GSoC PATCH v8 5/5] repo: add the --format flag
Date: Wed,  6 Aug 2025 16:55:37 -0300
Message-Id: <20250806195537.93302-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250806195537.93302-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250806195537.93302-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --format flag to git-repo-info. By using this flag, the users
can choose the format for obtaining the data they requested.

Given that this command can be used for generating input for other
applications and for being read by end users, it requires at least two
formats: one for being read by humans and other for being read by
machines. Some other Git commands also have two output formats, notably
git-config which was the inspiration for the two formats that were
chosen here:

- keyvalue, where the retrieved data is printed one per line, using =
  for delimiting the key and the value. This is the default format,
  targeted for end users.
- nul, where the retrieved data is separated by null characters, using
  the newline character for delimiting the key and the value. This
  format is targeted for being read by machines.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 36 ++++++++++++++++++++++++-----
 builtin/repo.c              | 46 ++++++++++++++++++++++++++++++++-----
 t/t1900-repo.sh             | 35 +++++++++++++++++++++-------
 3 files changed, 97 insertions(+), 20 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 1ae9c09fac..2b63954098 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [<key>...]
+git repo info [--format=(keyvalue|nul)] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,21 +18,28 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [<key>...]`::
+`info [--format=(keyvalue|nul)] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
 +
 The returned data is lexicographically sorted by the keys.
 +
-The output format consists of key-value pairs one per line using the `=`
-character as the delimiter between the key and the value. Values containing
-"unusual" characters are quoted as explained for the configuration variable
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+* `keyvalue`: output key-value pairs one per line using the `=` character as
+the delimiter between the key and the value. Values containing "unusual"
+characters are quoted as explained for the configuration variable
 `core.quotePath` (see linkgit:git-config[1]). This is the default.
 
+* `nul`: similar to `keyvalue`, but using a newline character as the delimiter
+between the key and the value and using a null character after each value.
+This format is better suited for being parsed by another applications than
+`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
+
 INFO KEYS
 ---------
-
 In order to obtain a set of values from `git repo info`, you should provide
 the keys that identify them. Here's a list of the available keys and the
 values that they return:
@@ -48,6 +55,23 @@ The reference storage format. The valid values are:
 +
 include::ref-storage-format.adoc[]
 
+EXAMPLES
+--------
+
+* Retrieves the reference format of the current repository:
++
+------------
+git repo info references.format
+------------
++
+
+* Retrieves whether the current repository is bare and whether it is shallow
+using the `nul` format:
++
+------------
+git repo info --format=nul layout.bare layout.shallow
+------------
+
 SEE ALSO
 --------
 linkgit:git-rev-parse[1]
diff --git a/builtin/repo.c b/builtin/repo.c
index 312fd08c34..37b5726816 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,12 +9,17 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [<key>...]",
 	NULL
 };
 
 typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NUL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *get_value;
@@ -73,7 +78,9 @@ static int qsort_strcmp(const void *va, const void *vb)
 	return strcmp(a, b);
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	int ret = 0;
 	const char *last = "";
@@ -101,8 +108,18 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 		}
 
 		get_value(repo, &valbuf);
-		quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
-		printf("%s=%s\n", key, quotbuf.buf);
+
+		switch (format) {
+		case FORMAT_KEYVALUE:
+			quote_c_style(valbuf.buf, &quotbuf, NULL, 0);
+			printf("%s=%s\n", key, quotbuf.buf);
+			break;
+		case FORMAT_NUL_TERMINATED:
+			printf("%s\n%s%c", key, valbuf.buf, '\0');
+			break;
+		default:
+			BUG("%d: not a valid output format", format);
+		}
 	}
 
 	strbuf_release(&valbuf);
@@ -110,10 +127,27 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 	return ret;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
+
+	if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
+	else if (!strcmp(format_str, "nul"))
+		format = FORMAT_NUL_TERMINATED;
+	else
+		die(_("invalid format '%s'"), format_str);
+
+	return print_fields(argc, argv, repo, format);
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index ef8205f7fd..573cf62575 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -21,12 +21,22 @@ test_repo_info () {
 	key=$4
 	expected_value=$5
 
-	test_expect_success "$label" '
-		eval "$init_command $repo_name" &&
-		echo "$key=$expected_value" >expected &&
-		git -C $repo_name repo info "$key" >actual &&
+	repo_name_keyvalue="$repo_name"-keyvalue
+	repo_name_nul="$repo_name"-nul
+
+	test_expect_success "keyvalue: $label" '
+		eval "$init_command $repo_name_keyvalue" &&
+		echo "$key=$expected_value" > expected &&
+		git -C "$repo_name_keyvalue" repo info "$key" >actual &&
 		test_cmp expected actual
 	'
+
+	test_expect_success "nul: $label" '
+		eval "$init_command $repo_name_nul" &&
+		printf "%s\n%s\0" "$key" "$expected_value" >expected &&
+		git -C "$repo_name_nul" repo info --format=nul "$key" >actual &&
+		test_cmp_bin expected actual
+	'
 }
 
 test_repo_info 'ref format files is retrieved correctly' '
@@ -44,12 +54,15 @@ test_repo_info 'bare repository = true is retrieved correctly' \
 test_repo_info 'shallow repository = false is retrieved correctly' \
 	'git init' 'nonshallow' 'layout.shallow' 'false'
 
-test_repo_info 'shallow repository = true is retrieved correctly' \
-	'git init remote &&
+test_expect_success 'setup remote' '
+	git init remote &&
 	echo x >remote/x &&
 	git -C remote add x &&
-	git -C remote commit -m x &&
-	git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
+	git -C remote commit -m x
+'
+
+test_repo_info 'shallow repository = true is retrieved correctly' \
+	'git clone --depth 1 "file://$PWD/remote"' 'shallow' 'layout.shallow' 'true'
 
 test_expect_success 'git-repo-info fails if an invalid key is requested' '
 	echo "error: key '\'foo\'' not found" >expected_err &&
@@ -80,4 +93,10 @@ test_expect_success 'output is returned correctly when two keys are requested' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid format' '
+	echo "fatal: invalid format '\'foo\''" >expected &&
+	test_must_fail git repo info --format=foo 2>err &&
+	test_cmp expected err
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

