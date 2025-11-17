Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4538833B6D2
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 15:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763392956; cv=none; b=NA5CiynyUnQDUSKTNb4wfDu/SP33/5xnfY/irj8DbJmNcRth8mVyGRG23VE6T173SaRRi+YD5vcCp/t4IQM4HuNIwWAnK3b94INfMEh7HYopcc7dy8s+/3PMX2981j3WRoV75YJcXFSMS20P3THMH5HSKwzcJRUKUAaIpqAOnlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763392956; c=relaxed/simple;
	bh=PuENJBooFg8ybMfoaU+RW/Yq4SYOLcT0g+gyY2hgeXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SXxHfWvVQHfMZyvbgSd335hUIgFzSGJH+uhDllpk8T8L7ReV8igjlIYIM12VFcXySuOsO1defXkCIlpeRRGvpKOfK/71da/+c+dE+BircTe6XSG4ogjVMUfF+loO/X8X4yFpNMREEbtPfT0JD5id/HEa8+27XJPODy6l4pyU+bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DnUlGieW; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnUlGieW"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7b8bbf16b71so4780179b3a.2
        for <git@vger.kernel.org>; Mon, 17 Nov 2025 07:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763392954; x=1763997754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0ZVKju4KFWcVJtfh2ubZWJgcqqJ3wNBMURSeC1jMRCA=;
        b=DnUlGieWOVyLS3dc0FXk/fzg6Hm1nFyB9NeKgHTOAUZoKqS1eZpb8D3bG95WNA6rsN
         vp2O2ts6q5ez9snpbmZVinc6fSrINrfatDDzD4K/cdvuT3LHT6iwhZ1rXsbjpirtUSq8
         3LcoWChZycghhlBc4M1/XgXHGgwx2cYotu3751W5vkvY26xDYbu4iaWZ3CGbgddq8vFE
         GiijG+3G8qPHwKVNdzVa4CRl8i/PY5la7l28GysmUavC9Or0WIDMJHTsNfJhiyp1cWof
         TZaBNi32eH0+jjfjqkgQoHmddJRH6z7NSXGnbemZU0v6WRbBSY17lZQRHTJt2pCU4y9l
         5xlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763392954; x=1763997754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0ZVKju4KFWcVJtfh2ubZWJgcqqJ3wNBMURSeC1jMRCA=;
        b=MI2s6oyCdyGO4okYW1utm3BIKTfvZGuq4X7PB8Hih6oBG7jMpdy7rEl9L44+qnqX/y
         EFh9ciKxM2+u/Zv7GAMKp19pQ3Zb4eZ1ImCq2WjB0oZKwqSjS1WaSn0m/i+PlH4NzrrT
         R5rFaeeQA3/zRLQV43nfaCrcvKwemyN/y2yLDHTHJrEMsqikSiS96V3VjdOGZYcVtphi
         deHqpC5SNOjcvM2XUkui/jx+FnDN2m7Hle6fASetkZQoVgNy6rOVO/pTuZIOUY3kNGzH
         jLy3Rsqq+IJMSceI1Z9y0kZxYxtWTuxeuhyt8orZQbMgBJdNLtSKqNhPzC3UYKQykIwQ
         n+Xw==
X-Gm-Message-State: AOJu0Ywiu5QNqUz3q/M0owcXVDSPS0PFl0CrQttovtjQVZF3XEeb0vld
	sCIrh5y4P7EUTm3ZecIyXpyayW3vqvk7v1laEDhEKbK7pOskC8UszuNBYBH37YM9
X-Gm-Gg: ASbGncvjiRFZEQKXAPKtV4eyQiobkVxPkT/XZE4vWu2r5KQcM2473gGfCT79BbmeRTH
	9gMOS59DWAQFvpExbZpcAMQng5MrjGf+nqNit7wfaz51NM4hDmFuHGPoCKVrle/cibkZIf9FSEM
	64ZOYJusyZx7oKf1yYnq/un12mFQ9t8Z6RA9X82fGsycPaAzyYUT+hpTY2gnidMYUPuhTrPpXVd
	/AagqOhzIODQSLnpMNt61zzoLYFNeNtZy80YVL3V1YHdpRJWzTW342f8Jb4CHYf8n/ebSuctW/u
	uu/FkrJ5Dwi91b/fgjDrctmpLzwp5GQ9xnCqzRXsJSp2nAxUhB4ePxmlJ33WhacEX2WP2YxIwAW
	gB4Vq+3baAKWrXC8EEAP+itkjRMvoK0X59CH5RfrTD9OtyvfMtpLRezsVDa/TeTgg/tALmHLX0d
	zUjo22jT7R5wiuiV0GXgMiOhrLhkjQaVe7Dq+3H22B9Jvm5WQ=
X-Google-Smtp-Source: AGHT+IFIikA2GDTtL6HQyIrgTGRH/2ZJPVpdE/tdXIjuYdosDJNxbIWMGLGHZHnyIuxD9tK45HMbDA==
X-Received: by 2002:a05:7022:1e08:b0:11b:ade6:45bd with SMTP id a92af1059eb24-11bade6480emr2676757c88.8.1763392954248;
        Mon, 17 Nov 2025 07:22:34 -0800 (PST)
Received: from localhost.localdomain ([191.181.59.93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11b06088625sm50245998c88.8.2025.11.17.07.22.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 17 Nov 2025 07:22:33 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v4 2/2] repo: add --all to git-repo-info
Date: Mon, 17 Nov 2025 12:02:52 -0300
Message-ID: <20251117151844.14802-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251117151844.14802-1-lucasseikioshiro@gmail.com>
References: <20250915223618.13093-1-lucasseikioshiro@gmail.com>
 <20251117151844.14802-1-lucasseikioshiro@gmail.com>
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
 builtin/repo.c              | 28 +++++++++++++++++++++++++++-
 t/t1900-repo.sh             | 21 +++++++++++++++++++++
 3 files changed, 51 insertions(+), 4 deletions(-)

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
index f9fb418494..22a9ecb3a1 100644
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
@@ -129,6 +129,22 @@ static int print_fields(int argc, const char **argv,
 	return ret;
 }
 
+static void print_all_fields(struct repository *repo,
+			     enum output_format format)
+{
+	struct strbuf valbuf = STRBUF_INIT;
+
+	for (unsigned long i = 0; i < ARRAY_SIZE(repo_info_fields); i++) {
+		const struct field *field = &repo_info_fields[i];
+
+		strbuf_reset(&valbuf);
+		field->get_value(repo, &valbuf);
+		print_field(format, field->key, valbuf.buf);
+	}
+
+	strbuf_release(&valbuf);
+}
+
 static int parse_format_cb(const struct option *opt,
 			   const char *arg, int unset UNUSED)
 {
@@ -152,6 +168,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			 struct repository *repo)
 {
 	enum output_format format = FORMAT_KEYVALUE;
+	int all_keys = 0;
 	struct option options[] = {
 		OPT_CALLBACK_F(0, "format", &format, N_("format"),
 			       N_("output format"),
@@ -160,6 +177,7 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 			       N_("synonym for --format=nul"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
 			       parse_format_cb),
+		OPT_BOOL(0, "all", &all_keys, N_("print all keys/values")),
 		OPT_END()
 	};
 
@@ -167,6 +185,14 @@ static int cmd_repo_info(int argc, const char **argv, const char *prefix,
 	if (format != FORMAT_KEYVALUE && format != FORMAT_NUL_TERMINATED)
 		die(_("unsupported output format"));
 
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

