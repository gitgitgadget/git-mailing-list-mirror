Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7059C30CDAA
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 20:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763499001; cv=none; b=ErSyaEcR/ZKu4fteD4UX5P0gHl9g0ylr8ed+Hfus6t/XqisP7MMkakxRb0dJY20nk8qLF0IR/STRVKSMGtUiXVH6cT3W32c30pEMo5wDSwaM+M6yAJhxlwR/vdS96cF2RIf35vFwBnmpX6wjTnhkb4rUAMrjnijaJI88lo4QXIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763499001; c=relaxed/simple;
	bh=qOxBbe/TVNU0Y1DLauWpxXFvrI2CEXVVrXF18wAqVss=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A+elpDW0F1lpmlX+FnK4rSmouxotStlXE72g/oZ1FWcXWhLAPpjd1kLajUNZ9CXyTZyKRyxy1Ig2jQ1o6NIkRGx44PEsS2PWRD+P7VFikKk53v8WPtVqwIZ+TYAFytV6Y0BQybETQYi7tEafa/Ut9evN8gWb27aqtkdohDbyIHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E6XR0qsJ; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E6XR0qsJ"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-bc2abdcfc6fso3506620a12.2
        for <git@vger.kernel.org>; Tue, 18 Nov 2025 12:49:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763498998; x=1764103798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wbxl1MdB/5Vb6UMr+UpL4ZLkyGEfoFwyh8ZJX1SvxG4=;
        b=E6XR0qsJye7C7rz5cFIF8T4k4iC3yndi4zIhm/y4K9K1/f2gKwLLeNVCY4M6AJZYNJ
         Hveo2mZOhIb97Q+gpsoH6ShNGrydl+8TRCODRwO8cadPeLl2EAP8ms5q/6Apr8rWzfgl
         Go7+OONdqhLQ90hBTBj+sJpygUxodF0DBVGXB60xtrgYwND7vncuKrcjLtUGBGkzkcPL
         Fl6klprD4eOu4VAry/ynUo4k4qjVhSi+gw6JTfJ6Ncun5YkNXnYcRfJAZIfSopYSWpe0
         t/tIn8MNono2TApY+Btxubk9fE6JlGOM7AoWjYnBrqU15H9rf3IVJIOtarsV11csgmy4
         lw4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763498998; x=1764103798;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wbxl1MdB/5Vb6UMr+UpL4ZLkyGEfoFwyh8ZJX1SvxG4=;
        b=NbfeoymUkLgIn6UHd2H0xQmYkwhkRUWP2weC23RXooTcNX4R9Q2vdBeqlapTFDbvjJ
         9KR6XM76Sa9KaXziOneOa386JP2Pej02s+li6TV5Oo0NbZvUFYQIK1BRWF2QGBXDOBS6
         03uR+ko3pyzWo94JADR6LJ2OcdnkyaT3SPjJ4huenVONEsTm8yKm1wg51QaLooesbqMB
         Zwa4h/97ej+uIHiZXYw1bzXBextcGLFbolCjix/y7GtyGqTwXOw3M33HO3vhD/rwHMt7
         q5+PlZz+lJgz7ZkSIsaDt25FHi8uxeLNTiVTWfAwgL2r/tl6z5slMhsfntp29MDTW9Sf
         6iZw==
X-Gm-Message-State: AOJu0YzphXPmCIBxAmgWwykDNVxfK3Qo40+PMHDiATNs9Fkk/lnEFXq0
	KcZakMwkk/WJIAuASW27OxltDXfdJ9HCSWKwXOETJ4ZGemhTFxKONba1sruI9g==
X-Gm-Gg: ASbGncvuZBaapdXC8bD+w8WWd0z7e4VyB3CJzjWd5J8T1Y+kwaAySnIkIhO6Qlp54fd
	zopm/TrMJiOTTsH4WveSf0FZu+fQOUkJR62pCzaP8wT42QVX61CQLEt1HHHIvgBLjxwCF8g7Yct
	BjIYnRabb3pNH3GZ1FPcl270QTq9whXScr8D6WYhOHOtu9lD8hHIdnhkXwMpksfPDefHklz8tkB
	2Zex+mgCK/gw9OA4fPDfSow3FIutsi95u010YAp/CmD9kRwOPyNQ1xkFfAbz3GUSsvpeslnJYJZ
	y1QvRytEPRE4LXdCmzY4ZgyJwlNptHSNI123nk7VtpKaG0io7EE+dzJLpM24ITRgONspVCaJ6J0
	wRunS5bDf/WywiDyDe88ZgzFUQhoO4fl4qk7dkl0750azEuChG82DjAQ8jufumDqipEWgviqlnN
	wrCGnP9nEarY0xINKe9xrtY7/zfhHHuRYIy+KnorL5qPgshSH7Ut0xqbu+qx5y3azzPIQwyZvTL
	az+evTBoml/yDKk
X-Google-Smtp-Source: AGHT+IESCvL51CWwaNo+bO0Ku/DP/0oCUfvdlnTFFGosgUxNO1JhI0kD+Lhfe1yGbWk8Q4tdx0IFiA==
X-Received: by 2002:a05:7300:ec8a:b0:2a4:3593:ddd6 with SMTP id 5a478bee46e88-2a4abab9e24mr5860293eec.3.1763498998310;
        Tue, 18 Nov 2025 12:49:58 -0800 (PST)
Received: from localhost.localdomain (gwmind.semfio.usp.br. [143.107.127.12])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2a49db7a753sm61892214eec.6.2025.11.18.12.49.56
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 18 Nov 2025 12:49:58 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v5 2/2] repo: add --all to git-repo-info
Date: Tue, 18 Nov 2025 17:37:04 -0300
Message-ID: <20251118204929.43597-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251118204929.43597-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251118204929.43597-1-lucasseikioshiro@gmail.com>
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
 builtin/repo.c              | 29 +++++++++++++++++++++++++++--
 t/t1900-repo.sh             | 21 +++++++++++++++++++++
 3 files changed, 51 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index ce43cb19c8..70f0a6d2e4 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [-z] [<key>...]
+git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]
 git repo structure [--format=(table|keyvalue|nul)]
 
 DESCRIPTION
@@ -19,13 +19,13 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
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
index f9fb418494..e30e2416d4 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -15,7 +15,7 @@
 #include "utf8.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [-z] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)] [-z] [--all | <key>...]",
 	"git repo structure [--format=(table|keyvalue|nul)]",
 	NULL
 };
@@ -129,6 +129,23 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
+static int print_all_fields(struct repository *repo,
+			    enum output_format format)
+{
+	struct strbuf valbuf = STRBUF_INIT;
+
+	for (size_t i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		strbuf_reset(&valbuf);
+		field->get_value(repo, &valbuf);
+		print_field(format, field->key, valbuf.buf);
+	}
+
+	strbuf_release(&valbuf);
+	return 0;
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -152,6 +169,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -160,6 +178,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_END()
 	};
 
@@ -167,7 +186,13 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
-	return print_fields(argc, argv, repo, format);
+	if (all_keys && argc)
+		die(_("--all and <key> cannot be used together"));
+
+	if (all_keys)
+		return print_all_fields(repo, format);
+	else
+		return print_fields(argc, argv, repo, format);
 }
 
 struct ref_stats {
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

