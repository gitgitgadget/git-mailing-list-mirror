Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0EF92F0C50
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 18:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756233138; cv=none; b=Jf6nPrs4UljxF/Rzsvxfw4aUEFiKHu50bsrPS/NQwzEz7SwtDmmjBP8yd3Rd5zTkFy5Os8bA1K1Kr+8sVWe3F6BW5rkMHbJccnWTk2/Hidd+Kl+U5Oxp+rQBQJZqU6HdsrmVRZt0CVQLKCxZqCS7cb/0BjiUh4uosf9zV27DPK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756233138; c=relaxed/simple;
	bh=0b7D9OEeGZQoOdvkPx82BPiquAd4vAsTs/rwI3Bvez0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kItoAZnTMYCZ7s7QbL43p+vTnwg8n3uFebcdCKcOL/VQQ3xWovZrG4JESJ5tUYvitFgCyLC40hX4wr3MoyK1Rm9oqn89R/rWvxmyEp4ZcMHGZth18xP3PyZPSTu4XNaNU0IU0mUy4okx5uKJeYw1mvGGXmZf2U0modFzFYZBDJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LCvHxKFh; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LCvHxKFh"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-76e2e89e89fso8004541b3a.1
        for <git@vger.kernel.org>; Tue, 26 Aug 2025 11:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756233134; x=1756837934; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LZjyQHmpT1/7JhKULWnMG7HEdm8a/XhkFfDv1uKTn28=;
        b=LCvHxKFh8LdwZvYNPAgyS8cFGBMMpfHYHWUJi8smH7MyeKUA7NmSIIwqr0wtJuPt2/
         Fe5xqNOsc0zV+YstPQ15bB5lBtU1zQYcL7J3Ciz2RATGjWQv1K5b2DfnAIVwUhQDP7a4
         Cz9aNN80GRevJNNV5EkjPFCBGcP3WbDmdcob4ouziEpSuEVjQRWerGrH5hVvHpgKPEqY
         1P6EJYOAAGxdfKjvifEA1Nl8hnLPjumMd/wg+F8RyrKOMjR2xiZZblGPs4CZ1W/NEB0L
         PJehNVUXgYhaZNasNh09cfIu45u07b3XLXkHMxrnaXdEKw7Iw4iYIBg9grNLHSwbmG3X
         7/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756233134; x=1756837934;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LZjyQHmpT1/7JhKULWnMG7HEdm8a/XhkFfDv1uKTn28=;
        b=jaerll/V+2IGrBSsS3NGTm5cvnka6QhsrRJ8ypu3+YLBim5R0iU167YJzOdpGImeSZ
         7ifQjGzFsWuGjGH7ysofHkovkYfcRe1EjdR4rrn07NG4GXq+d8SArxS+PkA1K1gRMzjN
         8APerHKtbKVYt06nkcNlNF/W9VDBWWIKSK8pQnumDanI315TA4ZnarD2RY0wpYou42fH
         WD9KGAkPlQLV0RgUschkxhVdvdFBo5OdNqt6322hzUQtdcE3R2loRAUl74OEy7NzjVY0
         GLzy1plMW18yI0jWNsFbiKaxUwR81L9v3Y0ayw7YYSqaJ7xmmwMceI6M7kh5BTF9E6A8
         sDRg==
X-Gm-Message-State: AOJu0Yx2VFykKTd38tRSG1gQWMMDJI6HcbFGWhtnUuFjaipcE3DBcMbC
	Kd7Z5zIAaBHIOUIT+RAc0uSZUFhPfuwBGuZhTgHxYCGPqvrfW3p2sC5oCD4hrw==
X-Gm-Gg: ASbGncvKERRlczoGXwxlq3rK5anwWaaSSu7Bjouuyy9xk4FmrYRTIVhfWWpGF66ZQPG
	ouy/LeY8o2C75TDcEfKClD48IeOUKm/8LgWA2bNVJfbb1BwvO84CCNtmr6PutAYBZwjMb5OUt0O
	mgEs7J86GiUtTl46rZx/Uy+wzTz7uYFlahaTnK3EXRDlrKnDjz+g+/GaCsVQaWziJzrePjQd6Us
	WCCAXsivvq9Xv8NLx+bXj+9gjKpxovXzxkJJzK29oGaN0gIUtH/7wnpMllZvorz4hrEUCaHu6hv
	e18xLBQZgOcH2RiV2e2vird8VgYslF5Ve3bm9a4D02u/U4ObXVL/s8EM92JEVaCXs6wtyL6Yskd
	WDWxetcDF/TsVQELwJOPKOEpaPaTYaGuJHTrGkFh0GwD3I1ubiTGyP0sEkb6oukU=
X-Google-Smtp-Source: AGHT+IGkZqDI6uUdFV3Hxripwx9XqJcTmHrtMNXlkSZVWs1ayC0ZlBP/6kO6Hnfa/H+S10LtH2mVfA==
X-Received: by 2002:a05:6a20:7284:b0:240:13fa:7bff with SMTP id adf61e73a8af0-24340e1b2f0mr25833529637.33.1756233133502;
        Tue, 26 Aug 2025 11:32:13 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3276af0786dsm193214a91.27.2025.08.26.11.32.11
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 26 Aug 2025 11:32:13 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	gitster@pobox.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH v2 1/2] repo: add the flag -z as an alias for --format=nul
Date: Tue, 26 Aug 2025 15:32:04 -0300
Message-Id: <20250826183205.19566-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250826183205.19566-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
 <20250826183205.19566-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Other Git commands that have nul-terminated output (e.g. git-config,
git-status, git-ls-files) have a flag `-z` for using the null character
as the record separator.

Add the `-z` flag to git-repo-info as an alias for `--format=nul`,
making it consistent with the behavior of the other commands.

Mentored-by: Karthik Nayak <karthik.188@gmail.com>
Mentored-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc |  6 ++++--
 builtin/repo.c              | 17 ++++++++++++-----
 t/t1900-repo.sh             | 12 ++++++++++++
 3 files changed, 28 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 2870828d93..8224a88bc8 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [<key>...]
+git repo info [--format=(keyvalue|nul) | -z] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [<key>...]`::
+`info [--format=(keyvalue|nul) | -z] [<key>...]`::
 	Retrieve metadata-related information about the current repository. Only
 	the requested data will be returned based on their keys (see "INFO KEYS"
 	section below).
@@ -40,6 +40,8 @@ supported:
 	between the key and the value and using a NUL character after each value.
 	This format is better suited for being parsed by another applications than
 	`keyvalue`. Unlike in the `keyvalue` format, the values are never quoted.
++
+`-z` is an alias for `--format=nul`.
 
 INFO KEYS
 ---------
diff --git a/builtin/repo.c b/builtin/repo.c
index 8c6e7f42ab..5df33de42e 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [<key>...]",
+	"git repo info [--format=(keyvalue|nul) | -z] [<key>...]",
 	NULL
 };
 
@@ -115,20 +115,27 @@ static int print_fields(int argc, const char **argv,
 static int repo_info(int argc, const char **argv, const char *prefix,
 		     struct repository *repo)
 {
-	const char *format_str = "keyvalue";
+	const char *format_str = NULL;
 	enum output_format format;
+	int format_nul = 0;
 	struct option options[] = {
 		OPT_STRING(0, "format", &format_str, N_("format"),
 			   N_("output format")),
+		OPT_BOOL('z', NULL, &format_nul, N_("alias for --format=nul")),
 		OPT_END()
 	};
 
 	argc = parse_options(argc, argv, prefix, options, repo_usage, 0);
 
-	if (!strcmp(format_str, "keyvalue"))
-		format = FORMAT_KEYVALUE;
-	else if (!strcmp(format_str, "nul"))
+	die_for_incompatible_opt2(!!format_nul, "-z",
+				  !!format_str, "--format");
+
+	format_str = format_str ? format_str : "keyvalue";
+
+	if (format_nul || !strcmp(format_str, "nul"))
 		format = FORMAT_NUL_TERMINATED;
+	else if (!strcmp(format_str, "keyvalue"))
+		format = FORMAT_KEYVALUE;
 	else
 		die(_("invalid format '%s'"), format_str);
 
diff --git a/t/t1900-repo.sh b/t/t1900-repo.sh
index a69c715357..3df55dcc79 100755
--- a/t/t1900-repo.sh
+++ b/t/t1900-repo.sh
@@ -92,4 +92,16 @@ test_expect_success 'git-repo-info aborts when requesting an invalid format' '
 	test_cmp expect actual
 '
 
+test_expect_success '-z uses nul-terminated format' '
+	printf "layout.bare\nfalse\0layout.shallow\nfalse\0" >expected &&
+	git repo info -z layout.bare layout.shallow >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'git repo info fails when using --format and -z' '
+	echo "fatal: options ${SQ}-z${SQ} and ${SQ}--format${SQ} cannot be used together" >expected &&
+	test_must_fail git repo info -z --format=keyvalue 2>actual &&
+	test_cmp expected actual
+'
+
 test_done
-- 
2.39.5 (Apple Git-154)

