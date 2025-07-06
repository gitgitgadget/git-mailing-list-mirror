Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724792882C9
	for <git@vger.kernel.org>; Sun,  6 Jul 2025 23:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751844015; cv=none; b=RBbI1mBFgpDSkBtIWDhj20BBzdxk1g8yGiYbzspEVKWI/itAO9/ueNMrCI/DKQusBJTHeTOJ+VS8iFeYL04rGbU+U1XVeCRIZ095aHy9CZmbErN+SiolJUMGNn254jFFqbiA5IntkRO96ivexfEDzCef5vn2wYyQNGYhZx1DAJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751844015; c=relaxed/simple;
	bh=Y8yYpvtZry86Wq3n5FCHcjCJIC810Uh9WUb66nfVctM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=o+ztxIaDNuWq1M3zXWDROF2xRnc36PlXarHlmmqhtmoC5snx/UZdrnXcNv9GUAq3nA7Sru+1b0s1k5Eun9LagwJhKg6DCFwy9NSuYwMAQccZpsR7NtpuqWqSU5AfNbhIuk/BWMhdFIVHj0XsY9kuAZyn78lI+5NcR/R8CqfwpUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HopVIs8d; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HopVIs8d"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-6f8aa9e6ffdso25882716d6.3
        for <git@vger.kernel.org>; Sun, 06 Jul 2025 16:20:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751844012; x=1752448812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gD5OXU5gMZc+A8ahGwD3fOP9YHWe9DtsQLIbaDMKUsQ=;
        b=HopVIs8dfNx2NlX32RPLEcq0WBkXXJpwlR9iFPvYIv8lwLy5pPRBN7IOkki6WK2y9N
         Nk46tf+9v6KLotFvjMSPdwqNtEeHS/8Ez0rhwlII79a+iugL6cgB/qox0nVbDPKFLNS4
         9xP3ADTwBejPD+sgM1zmJTNlagc9K4gNLW4ttorOakNeluJP97+Hc5CsnCJlZpMYArCm
         pKYtW8uaFdfH+FaW8Su1tEx4CcpALH+sYeQWMZ5vop1iRDZ0r11e5XL+m+puGlmmy4Ha
         CSrGCKJQaTkRTzDKmwm/Slo7A9sbG6Mk9tDIgT5utZd/kQalVV6rDYBGotnkVwYYVFdr
         IblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751844012; x=1752448812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gD5OXU5gMZc+A8ahGwD3fOP9YHWe9DtsQLIbaDMKUsQ=;
        b=FVOdBeQkpFyDvWIDvBl4WOjsjPcIvVuHKCuwMjHsxEMpd5M6MoT+SQj/0KbMvU2Yeu
         SSx7hEgws6KH0Uv8y0QYrKtI4y1W9HD1FRmAV0wWU+yB0ah6MsJmJns0XGVulh7e4gM7
         XzDIF3NkvHMZKJM3npo7PodY34CP/fDWAV4LcBbfXI/Dy3E1rYss20Nygq2ZaPhUMLS+
         XigQtpHgEOU3I8X2ArGoE0JAg1iTuoUAu/iL1kOxPGoHzNmytRfj309zsmymrnrTkaO4
         N69nYoM/NjslC4f8rsZHB3bJPH5wco5rqxETbTT7ATYDcQiofCRaNaOr6hxSnNi7qcv/
         Bgtg==
X-Gm-Message-State: AOJu0YxM+Oj8VljP3PJDW6d1KbhhObRGPy+6CbWnEsTsUmOxmn/9Xrnl
	GeoJxXq1NSHWBpqh43OoiYi0AuvGJUz3s+dW8xNiR7ReuPbVD6jwbhg0dugKBg==
X-Gm-Gg: ASbGncu66duMEiZWyURfDqQsUPOVQyT8PBegeJ8BNEV9ZER9In3JjOzsWZSqRFHEgtQ
	0noqgtnVWNSU8yfuh6T+w3YO8QUZV1qu8Hjuibft2uj3RhflpGI9v+RFZvW5vJx7np/RDhkq+GR
	hERvX4Sz5MUXeZUMt5L/vUBJNM+JuQ/V7Z9IfBo+XVzjlTJ6r7Br163469kK9eFrvr+OrtJx6vp
	fgNaijprWNEREnCtH5RjzjGKS32YUhwI+SOchNTSAd4hAP3QGseeT3W9udhmpi1OZfJfEOrTx6P
	dY19kOvY85I6nR9gW2eYvGMeC2j6koC63J8VnnwReodcwCQKWKYGayYAhOKzHDlVbGGmSFmD1DL
	74O6Spw7abVjKXFSK+wWh/4Q2JQ==
X-Google-Smtp-Source: AGHT+IESSIgP74QfY8064EYJyshcEZmVdEJp20JuZ4woiWfCyMdIOg2mUWHr7/VopBirx2s2VMDV2Q==
X-Received: by 2002:a05:6214:1c89:b0:6fb:f00:48a9 with SMTP id 6a1803df08f44-702d15446e3mr122035666d6.19.1751844012133;
        Sun, 06 Jul 2025 16:20:12 -0700 (PDT)
Received: from localhost.localdomain ([2804:14c:32:934a:8cb5:107d:e42b:6887])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-702c4d50947sm49891716d6.78.2025.07.06.16.20.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 06 Jul 2025 16:20:11 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	ben.knoble@gmail.com,
	gitster@pobox.com,
	phillip.wood@dunelm.org.uk,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC RFC PATCH v3 2/5] repo-info: add the --format flag
Date: Sun,  6 Jul 2025 20:19:35 -0300
Message-Id: <20250706231938.16113-3-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250706231938.16113-1-lucasseikioshiro@gmail.com>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250706231938.16113-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, git-rev-parse with the 'options for files' flags returns only
the requested values (e.g. `git rev-parse --show-toplevel
--show-ref-format` returns the top-level repository and the reference
storage format), dumping them only separated by line feeds.

However, from the perspective of a programmatic interface, this format
is not a good choice as, for example:

- it doesn't show the keys of the requested fields, meaning that the
  caller depends on the order of the requested fields for parsing them;

- there's no guarantee that each line contains the value of one field,
  for example, the returned values may contain line feeds.

This way, given that git-repo-info aims to produce a machine-readable
output, it needs to follow other formats that are better suited for
those means, for example:

- JSON, which is widely used as a data exchange format;

- null-terminated, composed zero or more <key><LF><value><NUL> entries.

Add the --format flag to the repo-info command, allowing the user to
choose between output formats. Add as options "json" and
"null-terminated", and use "json" as the default format.

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Junio C Hamano <gitster@pobox.com>
Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo-info.adoc | 32 ++++++++++++++++-
 builtin/repo-info.c              | 61 ++++++++++++++++++++++++++++++--
 2 files changed, 90 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repo-info.adoc b/Documentation/git-repo-info.adoc
index d5f34fc46e..bf1d391482 100644
--- a/Documentation/git-repo-info.adoc
+++ b/Documentation/git-repo-info.adoc
@@ -8,7 +8,7 @@ git-repo-info - Retrieve information about a repository
 SYNOPSIS
 --------
 [synopsis]
-git repo-info
+git repo-info [--format <format>] [<field>...]
 
 DESCRIPTION
 -----------
@@ -25,6 +25,36 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 OPTIONS
 -------
+`--format`::
+Specify the output format `<format>`. The valid values are:
++
+* `json`: output the data in JSON format, following this schema:
++
+----------------
+{
+  "category1": {
+    "field1": value1,
+    "field2": value2,
+    ...
+  },
+  "category2": {
+    "field3": value3,
+    ...
+  },
+  ...
+}
+----------------
+* `null-terminated`: output the data in a null-terminated format,
+following this syntax:
++
+----------------
+category1.field1<LF>value1<NUL>
+category1.field2<LF>value2<NUL>
+...
+----------------
++
+In this format, the fields will be returned in the same order they were
+requested.
 
 `<key>`::
 Key of the value that will be retrieved. It should be in the format
diff --git a/builtin/repo-info.c b/builtin/repo-info.c
index 0180c89908..cb4785169f 100644
--- a/builtin/repo-info.c
+++ b/builtin/repo-info.c
@@ -1,21 +1,78 @@
 #include "builtin.h"
+#include "json-writer.h"
 #include "parse-options.h"
 
+enum output_format {
+	FORMAT_JSON,
+	FORMAT_NULL_TERMINATED,
+};
+
+struct repo_info {
+	struct repository *repo;
+	enum output_format format;
+};
+
+static void repo_info_init(struct repo_info *repo_info,
+			   struct repository *repo,
+			   const char *format)
+{
+	repo_info->repo = repo;
+
+	if (!format || !strcmp(format, "json"))
+		repo_info->format = FORMAT_JSON;
+	else if (!strcmp(format, "null-terminated"))
+		repo_info->format = FORMAT_NULL_TERMINATED;
+	else
+		die("invalid format %s", format);
+}
+
+static void repo_info_print_json(struct repo_info *repo_info UNUSED)
+{
+	struct json_writer jw;
+
+	jw_init(&jw);
+
+	jw_object_begin(&jw, 1);
+	jw_end(&jw);
+
+	puts(jw.json.buf);
+	jw_release(&jw);
+}
+
+static void repo_info_print(struct repo_info *repo_info)
+{
+	switch (repo_info->format) {
+	case FORMAT_JSON:
+		repo_info_print_json(repo_info);
+		break;
+	case FORMAT_NULL_TERMINATED:
+		break;
+	default:
+		BUG("%d: not a valid repo-info format", repo_info->format);
+	}
+}
+
 int cmd_repo_info(int argc,
 		  const char **argv,
 		  const char *prefix,
-		  struct repository *repo UNUSED)
+		  struct repository *repo)
 {
 	const char *const repo_info_usage[] = {
-		"git repo-info",
+		"git repo-info [--format <format>] [<field>...]",
 		NULL
 	};
+	struct repo_info repo_info;
+	const char *format = NULL;
 	struct option options[] = {
+		OPT_STRING(0, "format", &format, N_("format"),
+			   N_("output format")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_info_usage,
 			     0);
+	repo_info_init(&repo_info, repo, format);
+	repo_info_print(&repo_info);
 
 	return 0;
 }
-- 
2.39.5 (Apple Git-154)

