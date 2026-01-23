Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1932D0C66
	for <git@vger.kernel.org>; Fri, 23 Jan 2026 16:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769186962; cv=none; b=hTS5jGAvLVw7R314q7aBmbBg2nkse8l22MX9rlQVE8AnNYjuvlDVITAwP5tqCiFsb9+SFzm5/iqzCjix4elxikois67VRdKTuKc2y6jPz3R3XjmGPOGU5sYKTcAx7eLruNuVkzDy2ALItnH6LANTjcPeVDSjkcqNgL1dhnLsLCg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769186962; c=relaxed/simple;
	bh=ELS2/p6qYEhUNX+OgFl+PwQRscxcAKWBA6Ss3kCQCIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iB0s2PUxIgkwZjYClvOGTLa3rZjohsRJPem4nwZkexxgj0Ubre2BpNwuBZoDOgw5wDHyYD/h2zloHHjC18sOuZJcZ7xlvZXmAppYFNRBoRiyxrzQFb1xnbH54pk72sNbGLuy0bmjyDLhXsQtlxAIc9x5eowLdvFJNzgnEjQ8+wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hrkVzYmX; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrkVzYmX"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-1233b953bebso6179274c88.1
        for <git@vger.kernel.org>; Fri, 23 Jan 2026 08:49:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769186958; x=1769791758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GoJdaD8wNLfrnO9ZVjyrKLP1fP5Nm3eE+9TZBLqDggg=;
        b=hrkVzYmXsGOnysN8uBM4NgF2bu+Aqvz5U6dHJhZ/9mdcabSmF5AbVjTkZP5QEJ3evc
         11LcIrtUoC3dDAhpcsxoFPfL5QHETbyI9qGnn/EUYCmeAfAbKvqL3IMMx/s92S9vCk8y
         rua4xvWDFhs6Wt7Jxzguyt5ZTYHMr7xq+4BkCRLiq884rSBy50mOqaFNIlHijNSvHhGu
         wFwcTH/cvaRZb40S0pbGsIIQGI48NPxuu+xjgTf28wYEV5zB1VnsXCveI96mr209+GyK
         h4PGgPwFZJnpnXZdpvrVW9TR+tbMOBcBVHRx7KKH4fxM1CIl1jZxB/Eak213Y8cNfIiW
         U7LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769186958; x=1769791758;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GoJdaD8wNLfrnO9ZVjyrKLP1fP5Nm3eE+9TZBLqDggg=;
        b=foYsQI52wC90A2euYO6JtjTRmop1Xg01C0UYKWmNQchSBGnp37B6g9TfxpVdTKkvca
         x0Ol8dZZTGRIMtW/GYguFJZdACKvB4dtGJeoCbJ+qnAgKJrTIx1/uKgQp93zM5/ql7Po
         k3coW3oEWy0nrAqTj+aJCOB5QIRALdS1B+EUECBPZq28xFafqx+j/fr6L8z0/ysPZX8J
         cK8dDdDRV/Wywah/OyD728QVBNnwoFjCh9Wq14EPhPTASXT991qRzCI2uYc3sXsziUmM
         rwkHhTIJ39XSXZvEHzSoRwxtlPo59+YUArjTa7lqYCiDE8oyP+dvzVTiKfnUkaZk3A+v
         +DnA==
X-Gm-Message-State: AOJu0Yyp2WSYyzNJK/5pPySnpUOzK78mReB4VHjsCCv0WDOS9Bx00Diw
	c8neASzury8cea811pNsn7IaoZygPKi52oe+TwzMqoVJSmhHBAZwhjfCrDZoVA==
X-Gm-Gg: AZuq6aIun9dwf10hxNkEL2S26xeD28IQxfN519JA58yLt41+X2y/o8VTiu3JfQM8keL
	PFVaUirI17JXga1bGpP6jiG1VEvq5bGycefv7JFGHJM9kc0u71oj2rDVPtzJo/9v+1bV1dy5Qea
	Ka+c94DZ6AN4+m4w63TG3RsRjh8L6KQyru1irA/dWCVXGQnrj/X9c/4ofpVKwar4f1+vYqajDKJ
	T0DWBn7mPs01bd9VPyNb5eYsacAkxGdqkhJ73BUWRpt4v8TN3AZcQS9TrcZhDzRqbB83mVgx7CQ
	NhbzB6LqxXdqT7UPsy2zuKeU0GEEcstXACMIhFF3xMPcofxPLSScmosP3+Z4KKdBVcTfqmZMXqx
	Ff1ywpsRfXn5SYO8Coz9GnPjyWNMXN9x0SP3mrQCKcj13nsrhlMvosqXktmaAxEoJEYV20qrNVF
	hNscL6E8mn0Au2wS19dAFW7jrPXO8WVwkyo/M0dFKm3pcuLdf9mEp1XxyiUA==
X-Received: by 2002:a05:7022:660c:b0:119:e56b:c75a with SMTP id a92af1059eb24-1247dbf8d14mr2005519c88.31.1769186957906;
        Fri, 23 Jan 2026 08:49:17 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1247d9a3f22sm5522640c88.13.2026.01.23.08.49.14
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Jan 2026 08:49:17 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 1/2] repo: rename "keyvalue" to "lines"
Date: Fri, 23 Jan 2026 13:34:53 -0300
Message-ID: <20260123164900.35092-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260123164900.35092-1-lucasseikioshiro@gmail.com>
References: <20251207190532.67107-1-lucasseikioshiro@gmail.com>
 <20260123164900.35092-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The output format name "keyvalue" isn't so descriptive. Rename it to
"lines", since it describes better the syntax of the output format and
it isn't tied to key-value pairs.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 21 +++++++++++----------
 builtin/repo.c              | 19 ++++++++++---------
 t/t1900-repo.sh             |  4 ++--
 t/t1901-repo-structure.sh   |  4 ++--
 4 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 7d70270dfa..693e1bbced 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,8 +8,8 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]
-git repo structure [--format=(table|keyvalue|nul) | -z]
+git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo structure [--format=(table|lines|nul) | -z]
 
 DESCRIPTION
 -----------
@@ -19,7 +19,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul) | -z] [--all | <key>...]`::
+`info [--format=(lines|nul) | -z] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -30,21 +30,22 @@ requested. The `--all` flag requests the values for all the available keys.
 The output format can be chosen through the flag `--format`. Two formats are
 supported:
 +
-`keyvalue`:::
+
+`lines`:::
 	output key-value pairs one per line using the `=` character as
 	the delimiter between the key and the value. Values containing "unusual"
 	characters are quoted as explained for the configuration variable
 	`core.quotePath` (see linkgit:git-config[1]). This is the default.
 
 `nul`:::
-	similar to `keyvalue`, but using a newline character as the delimiter
+	similar to `lines`, but using a newline character as the delimiter
 	between the key and the value and using a NUL character after each value.
 	This format is better suited for being parsed by another applications than
-	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
+	`lines`. Unlike in the `lines` format, the values are never quoted.
 +
 `-z` is an alias for `--format=nul`.
 
-`structure [--format=(table|keyvalue|nul) | -z]`::
+`structure [--format=(table|lines|nul) | -z]`::
 	Retrieve statistics about the current repository structure. The
 	following kinds of information are reported:
 +
@@ -61,17 +62,17 @@ supported:
 	change and is not intended for machine parsing. This is the default
 	format.
 
-`keyvalue`:::
+`lines`:::
 	Each line of output contains a key-value pair for a repository stat.
 	The '=' character is used to delimit between the key and the value.
 	Values containing "unusual" characters are quoted as explained for the
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
-	Similar to `keyvalue`, but uses a NUL character to delimit between
+	Similar to `lines`, but uses a NUL character to delimit between
 	key-value pairs instead of a newline. Also uses a newline character as
 	the delimiter between the key and value instead of '='. Unlike the
-	`keyvalue` format, values containing "unusual" characters are never
+	`lines` format, values containing "unusual" characters are never
 	quoted.
 +
 `-z` is an alias for `--format=nul`.
diff --git a/builtin/repo.c b/builtin/repo.c
index 0ea045abc1..4031612bc8 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -17,8 +17,8 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul) | -z] [--all | <key>...]",
-	"git repo structure [--format=(table|keyvalue|nul) | -z]",
+	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
 };
 
@@ -26,7 +26,7 @@ typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
 
 enum output_format {
 	FORMAT_TABLE,
-	FORMAT_KEYVALUE,
+	FORMAT_LINES,
 	FORMAT_NUL_TERMINATED,
 };
 
@@ -91,7 +91,7 @@ static void print_field(enum output_format format, const char *key,
 			const char *value)
 {
 	switch (format) {
-	case FORMAT_KEYVALUE:
+	case FORMAT_LINES:
 		printf("%s=", key);
 		quote_c_style(value, NULL, stdout, 0);
 		putchar('\n');
@@ -157,8 +157,8 @@ static int parse_format_cb(const struct option *opt,
 		*format = FORMAT_NUL_TERMINATED;
 	else if (!strcmp(arg, "nul"))
 		*format = FORMAT_NUL_TERMINATED;
-	else if (!strcmp(arg, "keyvalue"))
-		*format = FORMAT_KEYVALUE;
+	else if (!strcmp(arg, "lines"))
+		*format = FORMAT_LINES;
 	else if (!strcmp(arg, "table"))
 		*format = FORMAT_TABLE;
 	else
@@ -170,7 +170,7 @@ static int parse_format_cb(const struct option *opt,
 static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
-	enum output_format format = FORMAT_KEYVALUE;
+	enum output_format format = FORMAT_LINES;
 	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
@@ -185,7 +185,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
-	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
+
+	if (format != FORMAT_LINES && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
 	if (all_keys && argc)
@@ -671,7 +672,7 @@ static int cmd_repo_structure(int argc, const char **argv, const char *prefix,
 		stats_table_setup_structure(&table, &stats);
 		stats_table_print_structure(&table);
 		break;
-	case FORMAT_KEYVALUE:
+	case FORMAT_LINES:
 		structure_keyvalue_print(&stats, '=', '\n');
 		break;
 	case FORMAT_NUL_TERMINATED:
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index 51d55f11a5..4155211e5d 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -34,7 +34,7 @@ test_repo_info () {
 		eval "$init_command $repo_name"
 	'
 
-	test_expect_success "keyvalue: $label" '
+	test_expect_success "lines: $label" '
 		echo "$key=$expected_value" > expect &&
 		git -C "$repo_name" repo info "$key" >actual &&
 		test_cmp expect actual
@@ -115,7 +115,7 @@ test_expect_success '-z uses nul-terminated format' '
 
 test_expect_success 'git repo info uses the last requested format' '
 	echo "layout.bare=false" >expected &&
-	git repo info --format=nul -z --format=keyvalue layout.bare >actual &&
+	git repo info --format=nul -z --format=lines layout.bare >actual &&
 	test_cmp expected actual
 '
 
diff --git a/t/t1901-repo-structure.sh b/t/t1901-repo-structure.sh
index 17ff164b05..a6f2591d9a 100755
--- a/t/t1901-repo-structure.sh
+++ b/t/t1901-repo-structure.sh
@@ -113,7 +113,7 @@ test_expect_success SHA1 'repository with references and objects' '
 	)
 '
 
-test_expect_success SHA1 'keyvalue and nul format' '
+test_expect_success SHA1 'lines and nul format' '
 	test_when_finished "rm -rf repo" &&
 	git init repo &&
 	(
@@ -140,7 +140,7 @@ test_expect_success SHA1 'keyvalue and nul format' '
 		objects.tags.disk_size=$(object_type_disk_usage tag)
 		EOF
 
-		git repo structure --format=keyvalue >out 2>err &&
+		git repo structure --format=lines >out 2>err &&
 
 		test_cmp expect out &&
 		test_line_count = 0 err &&
-- 
2.50.1 (Apple Git-155)

