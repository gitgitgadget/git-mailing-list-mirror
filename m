Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA5413A265
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 00:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753144169; cv=none; b=VshDBwVvjD2UwV8+8ogSawPMyc+ZfhslVYvWwAbHUquWEjz9tZcQLKVAgFA3DqNkrVFpf8EeevMfhXEZGRUZNeIk8x+Z8KVzijNGq+JJMtAm1bTDUT9490HnAnFY+brx4FnnwnNDoI7lXHttdg1Srhr+tM9ADmKO5Um6e58PPMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753144169; c=relaxed/simple;
	bh=tzV2AfJUQqA7M+G+aRUG1fX8d/N6wwHKJR6eYass9Lk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dX/gBY06hCw6WIhpe6UCHlp4rynM5/TdWa7/C1oB3Zhfj9CYIpkK2WfLmqCmGQNTLHAXoIKJ5Vj6gR6UEvf+cQ/59NG/NmsQcmuZkGEtq5r76jr2PejWYnokJOWnM+4ekj3NWpTNV3guozqB2ve56/btb450ajTYzqP/N9oKNhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zn5SVHM2; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zn5SVHM2"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-87f1b3a3e7bso2551638241.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 17:29:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753144166; x=1753748966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tCrI2PbUmB3IjgIXYcbZoXu/x22T0GAdBa3pI6YMJjc=;
        b=Zn5SVHM2Xb01MWJcEDnbEuUuHowvOIdcJOEVq21cQqGFo5MGPAqbx6lyjdbd1Uhhx+
         4mhkarYtNpI/99QZGSVuRSiqw0TRrTMVbr3HnpL8wPVkHhZVaH+wHmk/geFhNd95Gc5E
         sMtuRoJvCYhbKn3qQXAEIKJWrsWC+cMKMnQdN2+YF/GRng14b3BSkA4XjmRF5Aws53Bo
         DyT1sWrBeTqPze4F8irK5UBUtzoaTCDQgTxAfs4rC/KnZHxZt0V5UFIvxzwl19ZIXrAH
         qoEf6LHIlZ6v6TFsSiiFmIhseOT0sytL4o9f4arBWB6hfqFnY4hvYI3KNPpUAA5dgjyF
         5VLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753144166; x=1753748966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tCrI2PbUmB3IjgIXYcbZoXu/x22T0GAdBa3pI6YMJjc=;
        b=YzUskSeh+Ql9PkRfYLwJceSP6GRt2bLmg8T9fSddlm0o300TnBR8/QKJrUfHspYC/1
         pa26iW9x/jBknQvQEllT1rJLRwARB25VVhSd75OwXpaqQLIznXUh+TRqw8IzUN8L3ZcR
         zmi2vq6HibBV3t0Cy3Dg+zYL7PgYmccynTThP/lQSVpgpcDQhm7uysHz4aNvcwieu14g
         YzYNcPISmIF1Rea+Ypk5SqSc+RloCCr/DgdO1Q01OuT5k5Q+ukR/sXtXEPC0xLUl+9/p
         a36PPePQ2Rk07wzVisdroYeKp1OsoYySqZlAq5XaX54QKfmRX7rCpN5TMOKrEHUlxacA
         ZMjw==
X-Gm-Message-State: AOJu0YzN9NJ7mS8Uqbz2M3vxsnKETWVxTMRGvojvZnrTWp5MN8ulp261
	X1CqhBnL8C9ZbO5V1PBw4Oz2FAIZrcQJT9RyZCN21fyDZ6fuMZLUGGtxdhHkcA==
X-Gm-Gg: ASbGncvikFzuRLSjI+ONvN9D7GmHx7Y64dsLMnS/SdW1lJmwayMaWlqMMwwyQBxRyZq
	aSoqYN70yCPd/4c0G1N4O26cZ49YVDfV4lAnMNWEyhRXnyTmnQpEWiudvpLP3kXMgT4V4RS0AqZ
	vn+LoJwZexJNX0EwlXjq8lWSdnYxFipImA5oY2XJGs1gDOjNnoS2UF4J9G3yatMKhEfmm7YQ5tg
	yv1HZyVOTGuXWFwrSlnkxtc84/7vvCOMSVzYT7kGJeKkGSu7w6ybzphROWXw3NDnKy8MvVgmk3D
	7yJSiD5/hRXSZlu7vp1GAmxh5Bg1r+9C+eL4qepMnK+7LQzXKFO9CoDZqvhCF0rBQzPg+aPmpcF
	Ckd/Ph4nwJEr0RUpn7/qNxXOHWRKlzxgZz6URXOKmTAFbkvNFM2mg0oM=
X-Google-Smtp-Source: AGHT+IGyvnOC7XvcmyTZS05Ej/h+GxXtsOkTmWwSJn5Vmd+ZCso4N8+//FXcHN2vetpmWzGXf8fhvA==
X-Received: by 2002:a05:6102:4b14:b0:4e5:9fbe:79f1 with SMTP id ada2fe7eead31-4f993e9b374mr10927284137.24.1753144165988;
        Mon, 21 Jul 2025 17:29:25 -0700 (PDT)
Received: from localhost.localdomain ([179.113.63.169])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-88b0ad603easm3344169241.16.2025.07.21.17.29.23
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 21 Jul 2025 17:29:25 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: oswald.buddenhagen@gmx.de,
	ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	jltobler@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v5 5/5] repo: add the --format flag
Date: Mon, 21 Jul 2025 21:28:35 -0300
Message-Id: <20250722002835.33428-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250722002835.33428-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250722002835.33428-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the --format flag to git-repo-info. By using this flag, the users
can choose the format for obtaining the data they requested.

Given that this command can be used for generating input for another
applications and for being read by end users, it requires at least two
formats: one for being read by humans and other for being read by
machines. Some other Git commands also have two output formats, notably
git-config which was the inspiration for the two formats that were
chosen here:

- keyvalue, where the retrieved data is printed one per line, using =
  for delimiting the key and the value. This is the default format,
  targeted for end users.
- null, where the retrieved data is separated by null characters, using
  the newline character for delimiting the key and the value. This
  format is targeted for being read by machines.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Helped-by: Justin Tobler <jltobler@gmail.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 13 +++++++++-
 builtin/repo.c              | 49 ++++++++++++++++++++++++++++++++++---
 t/t1900-repo.sh             | 13 ++++++++--
 3 files changed, 68 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 375b956d3f..5bdc3831a7 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -18,10 +18,21 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-info [<key>...]::
+info [--format=<format>] [<key>...]::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
++
+The output format can be chosen through the flag `--format`. Two formats are
+supported:
++
+* `keyvalue`: output key-value pairs one per line using the `=` character as
+the delimiter between the key and the value. This is the default.
+
+* `null`: similar to `keyvalue`, but using a newline character as the delimiter
+between the key and the value and using a null character after each value.
+This format is better suited for being parsed by another applications than
+`keyvalue`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 490fa9dd49..10d02bb3ea 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -8,6 +8,11 @@
 
 typedef const char *get_value_fn(struct repository *repo);
 
+enum output_format {
+	FORMAT_KEYVALUE,
+	FORMAT_NULL_TERMINATED,
+};
+
 struct field {
 	const char *key;
 	get_value_fn *add_field_callback;
@@ -61,9 +66,24 @@ static int qsort_strcmp(const void *va, const void *vb)
 	return strcmp(a, b);
 }
 
-static int print_fields(int argc, const char **argv, struct repository *repo)
+static int print_fields(int argc, const char **argv,
+			struct repository *repo,
+			enum output_format format)
 {
 	const char *last = "";
+	char kv_sep;
+	char field_sep;
+
+	switch (format) {
+	case FORMAT_KEYVALUE:
+		kv_sep = '=';
+		field_sep = '\n';
+		break;
+	case FORMAT_NULL_TERMINATED:
+		kv_sep = '\n';
+		field_sep = '\0';
+		break;
+	}
 
 	QSORT(argv, argc, qsort_strcmp);
 
@@ -81,17 +101,38 @@ static int print_fields(int argc, const char **argv, struct repository *repo)
 			return error("key %s not found", key);
 
 		value = callback(repo);
-		printf("%s=%s\n", key, value);
+		printf("%s%c%s%c", key, kv_sep, value, field_sep);
 		last = key;
 	}
 
 	return 0;
 }
 
-static int repo_info(int argc, const char **argv, const char *prefix UNUSED,
+static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	return print_fields(argc - 1, argv + 1, repo);
+	const char *format_str = "keyvalue";
+	enum output_format format;
+	const char *const repo_info_usage[] = {
+		"git repo info [<key>...]",
+		NULL
+	};
+	struct option options[] = {
+		OPT_STRING(0, "format", &format_str, N_("format"),
+			   N_("output format")),
+		OPT_END()
+	};
+
+	argc = parse_options(argc, argv, prefix, options, repo_info_usage, 0);
+
+	if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
+	else if (!strcmp(format_str, "null"))
+		format = FORMAT_NULL_TERMINATED;
+	else
+		die("invalid format %s", format_str);
+
+	return print_fields(argc, argv, repo, format);
 }
 
 int cmd_repo(int argc, const char **argv, const char *prefix,
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index c46ace1fd3..fdd3491429 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -20,11 +20,20 @@ test_repo_info () {
 	key=$3
 	expected_value=$4
 
-	test_expect_success "$label" '
+	test_expect_success "null-terminated: $label" '
+		test_when_finished "rm -rf repo" &&
+		eval "$init_command" &&
+		echo "$expected_value" | lf_to_nul >expected &&
+		git -C repo repo info --format=null "$key" >output &&
+		tail -n 1 output >actual &&
+		test_cmp expected actual
+	'
+
+	test_expect_success "key-value: $label" '
 		test_when_finished "rm -rf repo" &&
 		eval "$init_command" &&
 		echo "$expected_value" >expected &&
-		git -C repo repo info "$key" >output &&
+		git -C repo repo info --format=keyvalue "$key" >output &&
 		cut -d "=" -f 2 <output >actual &&
 		test_cmp expected actual
 	'
-- 
2.39.5 (Apple Git-154)

