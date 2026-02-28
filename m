Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FED1D5151
	for <git@vger.kernel.org>; Sat, 28 Feb 2026 22:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772318687; cv=none; b=pgxMU+gHXPVZfs31J3sYkQd5J3AHrSugdOc1t1iDEgDDHJJ20dH24k7Rqwjnx2bWwx+Qo1x4zOEOKRxYAqQ0uIe5gW7gD/ZzoVPLDmWl1kfQWwliFWET0EhbsZC6NA+9VQ+pxnx2ongnN+FjceQ0uWjuZUth2IRAecgY1alvnKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772318687; c=relaxed/simple;
	bh=B4iS6hIMuet3vunPFfwpanYf0BnOZ/COkayxNXjS0EU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d0mvIReZcvpMlVfBRVX9NlEo1SeyVtEBTvV8wwRiSiNaZ/5OLYmyYb6yTz4Uja4X/eAwdVDxhlX/pI9o+SSqDZlD+/Tz5k94nrCmRAKAVnlXQkZYLP+sytz7pt+3ZfMVS1sMQsVVeoEtBDFwLOW542GK0Rh3RzNEvxMfQyQ7Khs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fZaM+z9k; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fZaM+z9k"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5ff0f61abd7so822036137.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 14:44:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772318685; x=1772923485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Guu7lZ5dweaJ2OB4HmNZjQ60WdRZ28bnQrzsymNu/o=;
        b=fZaM+z9kglOaFGzuuzSzsIXt8Q4SAtWsRan0vsMcr5aijBbdLagN0+GHG3HzeBU32Z
         obsRSim8ghXHnIOKuXc+k52/3L5K28WW6Ep1sAPswowoyiHeBxeSUdWHuLNifqB0xCBG
         TN6PhfANvXdO9bhwh0CdxGBeqvvfj/rFhZW/xEM7AdVDoN1yqUtQEbQhEWaNfvGuG8FA
         TfQ//uu5D0dVrw0sPO48VXdQrkzw5acJHBayI40bh/A3P8nVCLexPgbe9lA/YLZjvGpV
         fCM2cw9A18BY0SFPStbcGZ7oVxxqksQjscRb8yjhBeHdBIuL8Vt0yHjUg5Og7OGAs3I+
         7HQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772318685; x=1772923485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3Guu7lZ5dweaJ2OB4HmNZjQ60WdRZ28bnQrzsymNu/o=;
        b=lvruavOScRjmwpBjBD3P/4TqnPX0/eiIpCS9k6/85lsNRSosZrXfG/Gbrq9GWx+rM9
         Yl65LTiqjAt7wQT8S3ZQ1oPCtpAqDdwPOSJ5wyz5tjgGFqQagiNWXSBmevSppAIFxawK
         2rEmo4/0vn2LVnFI4uo+Z9Hpnl0zXBBcIlhKontmOpmUkiDBb3rq6ZxmQIO+qUeRYRA/
         mQWAQwy/vXLEDsjre6TkTVQ0QdKXVcBW6RUfL4NBU76TGtHh54scfurhajI8LazpWDmI
         3jKCamJi6PYKCjl3YfC4YzwZ12XTdv5v57L+VA4n4DTCXZ9kr+7oATLZSh60GDPkHw0O
         Y9Lw==
X-Gm-Message-State: AOJu0YyqM/EAqB+Krj1seBz7TnQqpH4wSsktcwtK6+/fJrMGjlXw3CM1
	eEVzyCtZIidZvzNj14g2ftizLdRGUmf6VryPqQu2UvVeTYxrHKDE/U6wKZxOLZjh
X-Gm-Gg: ATEYQzwY6PFhL08ltCxf6kh1Yjhhmf02Y7Q5Gt+P1iKHrHTSJ4d9EeUb3PaWe+OuUnG
	u4cgp48gKgTotI45uxeqj/bS1BtodhIhVQP4bP7NLJ/7G9i9lCqdffTaqo5f37UaUxl0J0n+P2s
	XwIacL6jX8QV2gHbE/b7X6kJbxrJdEB8yfMQD+6gJHFXa+lOyf4Ot4noffxv4VK6w18EuuUHZiC
	a0IFKJlcXYReHZkNSfeP5x16wx1yaX+EnrTQVrYhTIywzR3ZoDR4l8qrBnioTuDpNu1scd8RNJf
	9IdvpTqWMXptMSdt84+7Dy6VygBYQrPuDpeN28tplsErziXPjteNpoYt+9q51pg59K8E0/5iJPs
	KVlGW/kRS1DQJsLr+affJZ5vr9+apFURFq9NQKZBkR7JOO7RoNLKXh0verbrbkor78WQgUy09jN
	pQhMQqwUyKYmIWx0UGEoOaB4IKPDU2ihLyvFswDvuEUjpCgTi4/PUiHaBzxMDbSMPmTUc1SDvAe
	fs4uA==
X-Received: by 2002:a05:6102:441c:b0:5f9:3a22:85a2 with SMTP id ada2fe7eead31-5ff3232eda1mr3122653137.12.1772318684779;
        Sat, 28 Feb 2026 14:44:44 -0800 (PST)
Received: from localhost.localdomain ([2804:14c:c4:89c7:617e:ea24:9d26:4bc7])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56a91659421sm11739094e0c.0.2026.02.28.14.44.41
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Feb 2026 14:44:44 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net,
	kumarayushjha123@gmail.com,
	a3205153416@gmail.com,
	jayatheerthkulkarni2005@gmail.com,
	valusoutrik@gmail.com,
	pushkarkumarsingh1970@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH 3/4] repo: add the --format-path flag
Date: Sat, 28 Feb 2026 19:05:57 -0300
Message-ID: <20260228224252.72788-4-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some paths handled by Git are better presented in their absolute format
and others are better presented relative to the current working
directory.

Add a `--format-path` flag to git-repo-info, allowing the user to force
the outputted paths to be either in the absolute or in the relative
format. This flag is similar to its homonymous in git-rev-parse, introduced in
fac60b8925 (rev-parse: add option for absolute or relative path
formatting, 2020-12-13).

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  8 ++++++--
 builtin/repo.c              | 24 +++++++++++++++++++-----
 t/t1900-repo-info.sh        |  7 +++++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 5e2968b707..478737b8ff 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(lines|nul) | -z] [--all | <key>...]
+git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]
 git repo info --keys [--format=(lines|nul) | -z]
 git repo structure [--format=(table|lines|nul) | -z]
 
@@ -20,7 +20,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(lines|nul) | -z] [--all | <key>...]`::
+`info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -45,6 +45,10 @@ supported:
 	`lines`. Unlike in the `lines` format, the values are never quoted.
 +
 `-z` is an alias for `--format=nul`.
++
+By default, the path values may be in the absolute or relative path, depending
+on the requested keys. However, the format can be forced by using the flag
+`--path-format`.
 
 `info --keys [--format=(lines|nul) | -z]`::
 	List all the available keys, one per line. The output format can be chosen
diff --git a/builtin/repo.c b/builtin/repo.c
index f943be7451..cff4c6db9b 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -7,17 +7,16 @@
 #include "parse-options.h"
 #include "path-walk.h"
 #include "progress.h"
+#include "path.h"
 #include "quote.h"
 #include "ref-filter.h"
 #include "refs.h"
 #include "revision.h"
-#include "strbuf.h"
-#include "string-list.h"
 #include "shallow.h"
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(lines|nul) | -z] [--all | <key>...]",
+	"git repo info [--format=(lines|nul) | -z] [--path-format=(absolute|relative)] [--all | <key>...]",
 	"git repo info --keys [--format=(lines|nul) | -z]",
 	"git repo structure [--format=(table|lines|nul) | -z]",
 	NULL
@@ -109,7 +108,8 @@ static void print_field(enum output_format format, const char *key,
 
 static int print_fields(int argc, const char **argv,
 			struct repository *repo,
-			enum output_format format)
+			enum output_format format,
+			enum path_format_type path_format UNUSED)
 {
 	int ret = 0;
 	struct strbuf valbuf = STRBUF_INIT;
@@ -197,6 +197,9 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	enum output_format format = FORMAT_NEWLINE_TERMINATED;
 	int all_keys = 0;
 	int show_keys = 0;
+	const char *path_format_str = NULL;
+	enum path_format_type path_format = PATH_FORMAT_DEFAULT;
+
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -207,6 +210,8 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       parse_format_cb),
 		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_BOOL(0, "keys", &show_keys, N_("show keys")),
+		OPT_STRING(0, "path-format", &path_format_str,
+			   N_("path-format"), N_("path format")),
 		OPT_END()
 	};
 
@@ -221,13 +226,22 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	if (format != FORMAT_NEWLINE_TERMINATED && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
+	if (path_format_str) {
+		if (!strcmp(path_format_str, "absolute"))
+			path_format = PATH_FORMAT_CANONICAL;
+		else if (!strcmp(path_format_str, "relative"))
+			path_format = PATH_FORMAT_RELATIVE;
+		else
+			die(_("invalid path format '%s'"), path_format_str);
+	}
+
 	if (all_keys && argc)
 		die(_("--all and <key> cannot be used together"));
 
 	if (all_keys)
 		return print_all_fields(repo, format);
 	else
-		return print_fields(argc, argv, repo, format);
+		return print_fields(argc, argv, repo, format, path_format);
 }
 
 struct ref_stats {
diff --git a/t/t1900-repo-info.sh b/t/t1900-repo-info.sh
index a9eb07abe8..f5c76067cb 100755
--- a/t/t1900-repo-info.sh
+++ b/t/t1900-repo-info.sh
@@ -149,4 +149,11 @@ test_expect_success 'git repo info --keys uses lines as its default output forma
 	test_cmp expect actual
 '
 
+test_expect_success 'git-repo-info aborts when requesting an invalid path format' '
+	test_when_finished "rm -f err expected" &&
+	echo "fatal: invalid path format '\'foo\''" >expected &&
+	test_must_fail git repo info --path-format=foo 2>err &&
+	test_cmp expected err
+'
+
 test_done
-- 
2.50.1 (Apple Git-155)

