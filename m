Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7171D2E2EE6
	for <git@vger.kernel.org>; Wed, 20 Aug 2025 14:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755701032; cv=none; b=R4tJh9YE4G6llXphuX0je/s5WArnEIO2jY2c3jw8Mj+YV+Nq5XbeEfLzZOZRXAyN7vt4x4oPgxLR11n13jzsh4JwN17RZe2t+TsvHZ+bNlb/S5JQNx+ESVVm9G8zuQUiGTrJKjE+Au7f/zaiigE492HDoF+sL3viW70jjG6xdlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755701032; c=relaxed/simple;
	bh=Qs4eBX7psppKujRvC8xCyJSW6kzYOy0Al5H6pAvNHjU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oBHCFWFyun+SbC5E1hgeriGo9EaMLKE9WyXFGj1tHdrSScLgWt/Yv0GTH+8eup/TgV8yCc8Si3bSLxfkGaQh2k0QLmBSJXEORPwV1BYvx/3CLWpNpmST6aZWo1EM3it1LnBikogcMeTNt48tvRsu9wmLUbFjlm1Au3vX+ceWdQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i4KHsUTp; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i4KHsUTp"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e2e8aff06so1534b3a.1
        for <git@vger.kernel.org>; Wed, 20 Aug 2025 07:43:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755701030; x=1756305830; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lrDlpluVnmiFPgAMPk1ZIv4gjtsgg9LSTMSnL6pu2Jg=;
        b=i4KHsUTp4hCR1eZj3ojkzostpxhwMoJYYBxILU4RFf1aMXHuCF1/ZlpwgMzHZkyOLA
         8/cxLBSOt96/pb+fp2zoRqNM1We6vhsY1FhLW/2ENM24bflB/hl5dtP5bFvSX2QDS5PG
         q4ixggT+47FzAEL+UTaUlGXHzRFfJ89Rh0I7yUZ/3mguLe7KT5/jWl6O54pt40LgsoPx
         JHvuq9lNckfhcE92vlFXhtwteVRUfyohplf2+F999ZVKtiM/GcdThGULUtsGVJkchaci
         rbd/HO06xYpD1HHgt19eG4X0+zdt75eqUOaRaQtfnOL5bh97DUMX4jQlJEqd733ADjxx
         i1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755701030; x=1756305830;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lrDlpluVnmiFPgAMPk1ZIv4gjtsgg9LSTMSnL6pu2Jg=;
        b=ZlOvY7/z0e7S0LAjeQripdzQm+jPB00hfizwVXrI6mQvsxhLJsNAZzkj/BV1FeYN8L
         jCitNuTv7xRsq6m4Jty87+HeVaf6DpHuHZUs+WIyUKgFHPtnKXbkSW/HdD9K5WzymMe8
         dhXTnexdVlDKxrqsYoRt0KFFxVeDvTZShvffhx9+wgaQ/6T5Hmze1PRpl0EgI1SsFxtU
         tJmO9wi2mUAdamw9bQmhBGl8CpHcu5C0OgcqxkGNeSMkpg5DQnhXLKyplXm5mZ/Sp6FM
         JbdqnxEnlLvkx8zRKQK5cq5qGKYfbxXzwVC7WVx71SZx3xs7vZpZrTNQsQangG0UbJ8M
         oQYA==
X-Gm-Message-State: AOJu0YxF6XGsN8sICf1q1lZ0S+thHfYI4Z504U+Dw6d+cOJFTCy3JXqp
	GfFohllwlQDD4ePhz1yQq2GUBnCCpVOkMGwPK3pN9npd7W1Lem36leGyPp/pog==
X-Gm-Gg: ASbGncvuliq6ojTflcBgp9fGXzoE8aI+Ey9aY3C+TCbuT0GtcnHT9J4UcKQ1CGPnE1r
	eliUCsY6esg2eC+xQjj+jOZoGvbIltK+SOmq+tDxUhXoaWpVz/c9ryQ1HToW4lu9Q/pN9OR6WiP
	IWIsvu0nR9UpGN8dV7fN0vJdHJ3rLAJqvQV7WZWHT14B4Fb4JKqnpHp2BIxsKNUoCjXdrLN6qVU
	gtW60EI37Iw5PS0r6Zljy/CcezWiG1GhVwx9BzvFlBdj0TSG09uQoNbZz/YXo58Q2kRKOiwjt08
	jsrYMhabv7/6ixr0mG6+rBsJHLAWcK9Q17ge0kG6kyx2vwxY1C1HB5F4gRX4hSFxIuKSrh2A9/d
	UAHHcr87BH1lhNNSvb/1GZB2irBPNqQpYbLuzFSFZq6IJzWTTZdBBiotcb2NjogY=
X-Google-Smtp-Source: AGHT+IF1GMmW0rOsXj8AO/doI0B1RIGoYoiDrivPTQCLs1YaDTXf47jzNHoGHjz89bILQVIQ5H9/TQ==
X-Received: by 2002:a05:6a20:734d:b0:23f:fbb1:c229 with SMTP id adf61e73a8af0-2431b50dd68mr5050631637.0.1755701030272;
        Wed, 20 Aug 2025 07:43:50 -0700 (PDT)
Received: from localhost.localdomain (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-76e923f8364sm1950291b3a.107.2025.08.20.07.43.48
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 20 Aug 2025 07:43:50 -0700 (PDT)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: ps@pks.im,
	karthik.188@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [GSoC PATCH 1/2] repo: add the flag -z as an alias for --format=nul
Date: Wed, 20 Aug 2025 11:42:46 -0300
Message-Id: <20250820144247.79197-2-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
References: <20250820144247.79197-1-lucasseikioshiro@gmail.com>
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
index 2870828d93..f2dc71193c 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -8,7 +8,7 @@ git-repo - Retrieve information about the repository
 SYNOPSIS
 --------
 [synopsis]
-git repo info [--format=(keyvalue|nul)] [<key>...]
+git repo info [--format=(keyvalue|nul)|-z] [<key>...]
 
 DESCRIPTION
 -----------
@@ -18,7 +18,7 @@ THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
 
 COMMANDS
 --------
-`info [--format=(keyvalue|nul)] [<key>...]`::
+`info [--format=(keyvalue|nul)|-z] [<key>...]`::
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
index 8c6e7f42ab..b2ec66e454 100644
--- a/builtin/repo.c
+++ b/builtin/repo.c
@@ -9,7 +9,7 @@
 #include "shallow.h"
 
 static const char *const repo_usage[] = {
-	"git repo info [--format=(keyvalue|nul)] [<key>...]",
+	"git repo info [--format=(keyvalue|nul)|-z] [<key>...]",
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

