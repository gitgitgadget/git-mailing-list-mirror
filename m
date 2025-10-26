Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3CC2D0C83
	for <git@vger.kernel.org>; Sun, 26 Oct 2025 22:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761519275; cv=none; b=KHzIBB32WHDpfFB8rnh3KncZd7Aui4vKhjBrbNTBdzPB2a2HX4yOCXFT0zVG8yTZDajmSdsOpOb9I52TwI2GJQkI9YCx+ddKBgJIq3WbYTAb/OfzQXnOah9uujy7ITCgvqUmbJU1RoSfDJHX4rXVwsKDwTQb+RUMUQSVpG2H18A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761519275; c=relaxed/simple;
	bh=VqbKZH+IgiGLG0PZsBMKHwpuE6liivBasE33PAFnscI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNpbYwmiVIFeKJZLlqeEUhcigFPLs8JUA9ZHKjcTRb1o9bEQN6/ZDqN6HLr8kDeVAtSlpvIjhHuniSiGnEsjxY8IhDtMZkXwt5pzYXBE/WsjBmqI15+iIweyUfwBH/uI9VHLNjb0qkWqQNiOQ2duQ7Ap8RiGiBz3gEe0nzAvfjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RujfhW6i; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RujfhW6i"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6a225b7e9eso2851543a12.0
        for <git@vger.kernel.org>; Sun, 26 Oct 2025 15:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761519272; x=1762124072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fnii937No4dSMzLmgL9SsMhpKU9HPWv7q+n8z/w3XcA=;
        b=RujfhW6ixAFsrfglneav9+Iif+YG7N0l7ba1RVTaKio1hYeRX5/fNMTy7t/xo6tGup
         ng9Lflr5j1nTbmhBz7Ehyo4zOGCFHhtI7zR7EQ3UcPdh3c9s7JbGkq88+A7nY50AHXN2
         lbOdDNqZLTExb2PM8QJE0K1SOi3AvsiiH9ylIQLNikflX96fIIoPCo1q9ws9RwlKoU6u
         eaiTwXwdmJIScNfvzZ//5R5PmPsfrnE0bopGWy56ZSzoD/aVuQRnayPDZeHd/MNe1bjN
         YiPb6ujO5JqytyBhjQZ6s2WyzBkuuIFm8I3EH7REtoQtcdMnUpAkzsl5XmxM6zFg3Dz4
         8xog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761519272; x=1762124072;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fnii937No4dSMzLmgL9SsMhpKU9HPWv7q+n8z/w3XcA=;
        b=J8JPUZkXMtw4NdHUeHCqGU9Ej0lnnAdUQFz0UyiL67M5W99gQre3YDmH3FxBMUsqWA
         0YgaBaFqHl8f91EAdevAyFukVI1kznYr2BmuHqm1i/A3z8ULfN5Nm9+sTHqhi/tQ/pwn
         DRrUu1m7Y96qVwfP6sbdjSfIVS/JKSH09qdu2QUNCFBNPLcluy2FjH+BQTY+3SRFY4YL
         rGxCSKWnuAFfQLQ7dajKUs0mdHJN07HgUNz+igPJMCnQWQ2tbCGhmSy2woS9gPeQSxlz
         R5RIELJ7QNwrP8U/0fv3vPrp97O6tvPN5HSDp13LRB2FxIaDgOVfUm3LkxQEyFLFKrdQ
         tqVw==
X-Gm-Message-State: AOJu0Yx8QaI7P83ChGiom13MDbDi6RQR2G65FeBU4hDN6y/rl2ROtWQz
	4PxOv+22CneW1SViG+Mt+YT1XESBbqWQ9YkPeHcxXhpe838xHgid5R0mPr2wbbl2
X-Gm-Gg: ASbGncsh8cepVvRBDZYwlrIJT5hBLS2xwhSMBLe4ZfnOqjob7lzfNdYQ25e15HKSlPF
	n7M/MmDzGjm2Ai7PWxMh2/nPGY0TKZDChVGH4YLvF49qbs1aY/dfKP935X0HaGyPK6GvHT2dmlN
	MJqi07BNLqZV3KkUc43r//SXlQBHw3jDqrD8ZjlgWUB0FC0hwDNAqbLmhIDE5lBPzlThbv01eWJ
	uQUzU2czexhPswIXsmOnQP9Tp2e2JW37EzRJCZvYpvQiIey/4igEVY2B7mkM5stefJvW9Nfod8t
	dqHbv6cbNV8Ajwoqmb0v5EKsFcPplD1hn7CM3dQnvi/ZhZkcFTHpXdMz/5soHkiOj7dCq3lPfz5
	mzIWTp/g8he8oY/G+Z1eexAXjEvt/FXRvwmuc09GQOSRozHsr4elH7490qAtybSPbfFdoXwmZaX
	eaj4+Im+XZVCg9oEBJ3okpOX/0xuQBSoQxF3GXq/WCpgRQB60KYUoMJhUTNg==
X-Google-Smtp-Source: AGHT+IF6OojwX7n3hb3WgPgUNsGqhL9aPhPCWL1LwUX2cIF1L41KMK0AARh9XDb6VoNJDLaETxsLTQ==
X-Received: by 2002:a17:902:c404:b0:250:6d0e:1e40 with SMTP id d9443c01a7336-2948b9575demr107191335ad.7.1761519271647;
        Sun, 26 Oct 2025 15:54:31 -0700 (PDT)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498d0c6eesm59657435ad.42.2025.10.26.15.54.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 26 Oct 2025 15:54:31 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v3 2/2] repo: add --all to git-repo-info
Date: Sun, 26 Oct 2025 19:52:08 -0300
Message-ID: <20251026225409.46647-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251026225409.46647-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251026225409.46647-1-lucasseikioshiro@gmail.com>
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
 Documentation/git-repo.adoc |  6 +++---
 builtin/repo.c              | 30 +++++++++++++++++++++++++++++-
 t/t1900-repo.sh             | 21 +++++++++++++++++++++
 3 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 209afd1b61..e61af9ce3b 100644
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
@@ -18,13 +18,13 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
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
 +
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
diff --git a/builtin/repo.c b/builtin/repo.c
index 3b071e9a50..67d647bb3c 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
 	NULL
 };
 
@@ -124,6 +124,24 @@ static int print_fields(int argc, const char **argv,
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
+
+		strbuf_reset(&valbuf);
+		field.get_value(repo, &valbuf);
+		print_field(format, field.key, &valbuf, &quotbuf);
+	}
+
+	strbuf_release(&valbuf);
+	strbuf_release(&quotbuf);
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -145,6 +163,7 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -153,11 +172,20 @@ static int repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_BOOL(0, "all", &all_keys, N_("return all keys")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
+	if (all_keys) {
+		if (argc)
+			die(_("--all and <key> cannot be used together"));
+
+		print_all_fields(repo, format);
+		return 0;
+	}
+
 	return print_fields(argc, argv, repo, format);
 }
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 2beba67889..51d55f11a5 100755
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
@@ -110,4 +119,16 @@ test_expect_success 'git repo info uses the last requested format' '
 	test_cmp expected actual
 '
 
+test_expect_success 'git repo info --all returns all key-value pairs' '
+	git repo info $REPO_INFO_KEYS >expect &&
+	git repo info --all >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git repo info --all <key> aborts' '
+	echo "fatal: --all and <key> cannot be used together" >expect &&
+	test_must_fail git repo info --all object.format 2>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

