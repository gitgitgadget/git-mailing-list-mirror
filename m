Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DF41758B
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754579063; cv=none; b=bKm7mAURLaAyTuz05mv4yR2BZthuE/IUgFa3EtTqNEaAkGhenzZIZdEkd1kE3195TI3pVsjKGH5lnSxiWBIwXCyh5SWb0wZFf7fgr6ZWLaZEABzdZgMyqVXJx7C13JI8pB8VEzLSziETAEz8hFcm7/D/j+e9UHLRDw5+2/uC6Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754579063; c=relaxed/simple;
	bh=7tyHW5NTFR7tOiurwiJmPnWa7YXvZoTXP+uJb4P6D5s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qFEFscKV2JO/+5rWUMear/YFv22MHHS5ikwENezk7j04wGPa9SBkLWroCL5fjHS93FRzPyEgYU4xYJphVEOhqNbBy2pJzNr/BS9NtHHwGt4mDNv2uNAeuWenVnm9C0dSg7kIhD3m0tCleEFYLg34Daemvjyx59CxrYWSLOp5kGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+NLHjV7; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+NLHjV7"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so760695a12.3
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754579058; x=1755183858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HW/EyHoZlrUd6ahoC+VW2h/GvUx+w8TgoZ78sIS7wlI=;
        b=Y+NLHjV771ZO5NGZxl6I61AeWMQbC3gTV8nJwWhD1SqPzceLHZOE7pA8DfFtoon5pW
         v2AEI1Sx2y329FUht7uJeNoLsGh19sMNlPSb264ll7wPRckH25pKFNpu1qBmMmwBv1Fs
         XPZHp4+mrC6CYsOOxpsFEEpsewJqNTyPdZylXrQWGw5tf+A6MtSj/U5yFnY3kWbS95M/
         i24eMDBJvVOjh19hXwyp0PUlGR1Gmv3n2Vxj0e3+H/yV4h+/53DjyeRwc1zOdViAj66J
         +A/cKMEY+Ab9WmcZbmfWbTzMPJvPAWcl2j4E5qbW4ry5NOrDlljvUl/g28f+agWOal1m
         4MQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754579058; x=1755183858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HW/EyHoZlrUd6ahoC+VW2h/GvUx+w8TgoZ78sIS7wlI=;
        b=w/29eOW/xVwwSpux58R9uMtEZQbMm68FBX8dtYniGFOZDK5froN1IBTxwJHs3fxskV
         XyprYerrGURevlAopDlJf0i9WvTen7XSYSNq2anEj+74Jud/UufbbsgcKO5dCLCtrKVz
         MNM/A6xO0n11rHKNwUJiSqG3gUXPLhoWghRwCekUmfGiio+RG1QqVFgJ9jQFnlGeVEj3
         MoqNJxP2t2ik/IDdsbe7gF1GO4kCa06Fd4k3KHu6n2B7UYhUn7NOMAxCKDedV8+deQmW
         GNpTEWblaCfKtrHtLAVcZe+BnMmeelLBTovIPJDENtBIELOHrlfjS/bZNEymIk9k1Lsq
         O8xA==
X-Gm-Message-State: AOJu0YwLgKvz0wbV7FXZZ3SZUr5IuxdA0UK88eAY7zWaZ347J06PtwPo
	Sncg4mP6gYIThnuEgAed1IJmFBZuhZFNPelod3m7Vuu7tX8tLRl+8V3uua55hg==
X-Gm-Gg: ASbGncuI6Kqhyri9RMNiWhl2rykj0eUBTzkjcnk8d6V4gOU67Ni+CYk2OGaNRJrAspQ
	WcsKdLkiU6fq/+wvkUcwK/wt9W9zFtgvRm7J/wbbdgGhIg93b3FDhFBAEQ7VJP0ukvwGPwnID6f
	6AGBFzNHuBtMtTB0k0f4U/6v1vcdIzLCjtn9ZOAPgH2532DYP1XVQvYv3qVI4Iyszve1o4RWKkt
	J4QsyR5rvjMRsODMZq6I4Ufp0musf5sNRnySbb387QxUhD4/XO/BezEP/BQ0VzD0IO5l6MjtBac
	XzQRdDMZl88FeS1Oc5/V2By4VFgtsOqa3SGnGrPY4JgtACBm8xXheZTMQSO7LPVZeOJaFXcy6JL
	GwuwnAis1D/U958QFfItJbUTaNcguyh2JaCBmmKQumA9WIq2oqO21wQQd6+NaUw==
X-Google-Smtp-Source: AGHT+IF9+dYEI/aTqEJesmKDt+sgFwIDV3H8dphF4wu1Bc5i/l0j6K5JXtMFhhIjOa8Fox67Tx5sNQ==
X-Received: by 2002:a17:903:11c6:b0:240:7753:3bff with SMTP id d9443c01a7336-242a0b3e623mr86166425ad.30.1754579058107;
        Thu, 07 Aug 2025 08:04:18 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:8359:45d5:14c8:c621:17ff])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2426dec66desm106617065ad.54.2025.08.07.08.04.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 07 Aug 2025 08:04:17 -0700 (PDT)
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
Subject: [GSoC PATCH v9 5/5] repo: add the --format flag
Date: Thu,  7 Aug 2025 12:02:39 -0300
Message-Id: <20250807150239.6987-6-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250807150239.6987-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250807150239.6987-1-lucasseikioshiro@gmail.com>
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
index 312fd08c34..aca29729eb 100644
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
+			BUG("not a valid output format: %d", format);
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
index 2018772631..eb37c9d16b 100755
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
 	echo "error: key ${SQ}foo${SQ} not found" >expected_err &&
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

