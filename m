Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B69DC140E3C
	for <git@vger.kernel.org>; Mon, 20 Jan 2025 07:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737359697; cv=none; b=F5uhPK52zhHVszrkFAzpOk4m4Yf8fpiDsydVG34VfUX8qHKOVizK8yCQ3KMUMkE55W9nqh8RuywOZe+QMncDuSpAep0wy2sleXPx/e0kONQOE2mFqoXq4HAMw393ZPJaSUOc2qyv/NGjDpsT7chBLVDd67U8xr+rhHqbyKR9qn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737359697; c=relaxed/simple;
	bh=4AENtTLuU4F8BZGEmoZGCfAbwjKjza50fNE5RdkKd0E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIOAGWXwUS85a2cH8kAwsjeR/5M/DnYJSQw+4wB+t6G+D1ZpyiY1QH4nC3rFRUm+8Yv4uIgIVWvsO1hVSUhNEsNKW0hSXfuUFeuyYo05SfN4ukeE7Tkbc4U0EAyTxxTAPUc6GtR58ZTWHgEozw+Gjjy9pix492mN656KFn5r2pQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bGBLRNpM; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bGBLRNpM"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-21680814d42so68122145ad.2
        for <git@vger.kernel.org>; Sun, 19 Jan 2025 23:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737359695; x=1737964495; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r8hFZ+IK9PwIsSSuUKl+2gZ4tCgn9chMGTN5PCJKPZE=;
        b=bGBLRNpMe6nintfUm/pdnFUJCez7bE/+m4C20HJiCAv8MiUrQMli7Ep5niyXxPvtDf
         tcqbknt71+vOV11i3zMdt9srSWte2RI5BIjcrDPaV3+BGl6FO12VrCm9xU4Qiqw95o9m
         GjvafUhlWTqTrWG3zv/CQoAaSm47G6ZVQkwAkDjDKzBZG3LNOz8L6rNd6xv1ggZvyhJZ
         K28vizPmvcMeN7lvvMr6M/36MSFZ7I0vzASSKG4RLY8FPT95O54LWs9d1iJAozB1k6bb
         5mX0HPb3uywOEM6qsT7ReybI48+svv2qq0XxtmOH/LdfYAfmyAwcXBkrsBrYaTyB9E2k
         ohpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737359695; x=1737964495;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r8hFZ+IK9PwIsSSuUKl+2gZ4tCgn9chMGTN5PCJKPZE=;
        b=p1GK+M58clLerS3+2F2r5H0wO865ATX+hzjtQAREfOrIyvEptXLWu5MrhL7BZ4h3p1
         Qwz4cJ/T7hduqD7H0TRjhQ1GQYSJDZh/AfP02C4FMKJcyiR/UUOVRPcRIcbLeFfdnoRO
         RKr3I2Hlx7Xn5tkpBo8bJnMZTXZsv4COD5SXysqmcFZp3bPMY4OGxZ0mCLe5lv+ABHBF
         hiwwvrA9F83/Dthtx0PReaiXe58JYZABIWt3T/T+0/uo+HTcyUQ2UferiAgwlRru7N0z
         jk7jgPV2yqrj1eEMl7iXvVEcqEqBXbMDoFKFtM1kVejxzYDIEIPy92mW3dECYAu2q5aP
         9C6g==
X-Forwarded-Encrypted: i=1; AJvYcCX4oU3Ptjd4K2668JACX7WxBXJ6skEBAUI48jPWWWAqhMb2vtD3AlUcO89PcMnaDFKvOsE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxja0VHaEoHb8dR0JTfi0a2WuNXt4tbrlnfD4Q96sYsmx0t+c2d
	qcup/giu7SR6oPNHUwf6CblLP7M/1v8WF59gV5n7JdBH0Mrx8VZe
X-Gm-Gg: ASbGncuyVOfbEdMFB4OJ7lOes9Dl/ZI9hBqJdO60CUri37Wjtq5iyy6jsugiTD8GETR
	2z4mrj6yQ546rbTYrFNVVw6ctMt3B4loCWC1tp5nQ3k8h2FCknY24ueas22HYllbYedFtQD4gz0
	Mn69t/eMhW7waY7YcL13P+m2zFH4OHv6m8eADwJgOKuRKBg3uKB6FB9CZvPX6oc1XMH64d/gJAc
	qYZTwpZcnBK4yvEWCP+Od/FbkXLvNApSKNzn/ymo8JPljY+/lX82CMtsksw+EreXj7+GZT5yDYu
	5+m9Qg==
X-Google-Smtp-Source: AGHT+IGpAcjTh94vChBZYjR/T2maGWdXv+LnPa5SXjMDraoeJwPtV23io3U+/VQs6OumzBa1oLLnrA==
X-Received: by 2002:a05:6a21:6d9d:b0:1e0:d934:6189 with SMTP id adf61e73a8af0-1eb2159bf7amr20456391637.31.1737359694784;
        Sun, 19 Jan 2025 23:54:54 -0800 (PST)
Received: from localhost.localdomain ([172.56.123.18])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-a9bcdcf7c87sm5287630a12.43.2025.01.19.23.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2025 23:54:54 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Scott Chacon <schacon@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH] help: make help.autocorrect = 1 the same as "prompt"
Date: Sun, 19 Jan 2025 23:54:52 -0800
Message-ID: <20250120075452.137992-1-davvid@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <Z43y0mNhHsEdF22L@gmail.com>
References: <Z43y0mNhHsEdF22L@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Choose the least surprising behavior by prompting the user
when when help.autocorrect is set to a boolean "true" value.

Make "0" and other "false" boolean values the same as "never".

Make "help.autocorrect = show" the same as the default behavior
so that users can override it in a repository-local .git/config.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
Here's what the proposed changes to make "true" = "prompt"
might look like.

 Documentation/config/help.txt | 26 ++++++++++++++++--------
 help.c                        | 14 +++++++++----
 t/t9003-help-autocorrect.sh   | 38 +++++++++++++++++------------------
 3 files changed, 47 insertions(+), 31 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index a4c6079af8..344b4b13f7 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,14 +11,24 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0: show the suggested command (default).
-	 - 1, "true", "on", "yes", "immediate": run the suggested command
-immediately.
-	 - positive number > 1: run the suggested command after specified
-deciseconds (0.1 sec).
-	 - "false", "off", "no", "never": don't run or show any suggested command.
-	 - "prompt": show the suggestion and prompt for confirmation to run
-the command.
++
+--
+show;;
+	Show the suggested command but do not run it. This is the default.
+
+immediate;;
+	Run the suggested command immediately.
+
+never, false, off, no, 0;;
+	Do not run or show the suggested command.
+
+prompt, true, on, yes, 1;;
+	Show the suggestion and prompt for confirmation to run the command.
+
+positive number greater than 1;;
+	Run the suggested command after specified deciseconds (0.1 sec).
+--
++
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 7148963e46..447e0c9423 100644
--- a/help.c
+++ b/help.c
@@ -552,6 +552,7 @@ struct help_unknown_cmd_config {
 	struct cmdnames aliases;
 };
 
+#define AUTOCORRECT_SHOW (-4)
 #define AUTOCORRECT_PROMPT (-3)
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
@@ -560,7 +561,7 @@ static int parse_autocorrect(const char *value)
 {
 	switch (git_parse_maybe_bool_text(value)) {
 		case 1:
-			return AUTOCORRECT_IMMEDIATELY;
+			return AUTOCORRECT_PROMPT;
 		case 0:
 			return AUTOCORRECT_NEVER;
 		default: /* other random text */
@@ -573,6 +574,8 @@ static int parse_autocorrect(const char *value)
 		return AUTOCORRECT_NEVER;
 	if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
+	if (!strcmp(value, "show"))
+		return AUTOCORRECT_SHOW;
 
 	return 0;
 }
@@ -589,8 +592,10 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 
 		if (!v) {
 			v = git_config_int(var, value, ctx->kvi);
-			if (v < 0 || v == 1)
-				v = AUTOCORRECT_IMMEDIATELY;
+			if (v == 1)
+				v = AUTOCORRECT_PROMPT;
+			else if (v <= 0)
+				v = AUTOCORRECT_NEVER;
 		}
 
 		cfg->autocorrect = v;
@@ -713,7 +718,8 @@ char *help_unknown_cmd(const char *cmd)
 		     n++)
 			; /* still counting */
 	}
-	if (cfg.autocorrect && n == 1 && SIMILAR_ENOUGH(best_similarity)) {
+	if (cfg.autocorrect && cfg.autocorrect != AUTOCORRECT_SHOW &&
+	    n == 1 && SIMILAR_ENOUGH(best_similarity)) {
 		char *assumed = xstrdup(main_cmds.names[0]->name);
 
 		fprintf_ln(stderr,
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 85a5074b5e..ea20526248 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -29,7 +29,7 @@ test_expect_success 'setup' '
 '
 
 test_expect_success 'autocorrect showing candidates' '
-	git config help.autocorrect 0 &&
+	git config help.autocorrect show &&
 
 	test_must_fail git lfg 2>actual &&
 	grep "^	lgf" actual &&
@@ -38,28 +38,28 @@ test_expect_success 'autocorrect showing candidates' '
 	grep "^	distimdistim" actual
 '
 
-for immediate in -1 immediate
-do
-	test_expect_success 'autocorrect running commands' '
-		git config help.autocorrect $immediate &&
+test_expect_success 'autocorrect running commands' '
+	git config help.autocorrect immediate &&
 
-		git lfg >actual &&
-		echo "a single log entry" >expect &&
-		test_cmp expect actual &&
+	git lfg >actual &&
+	echo "a single log entry" >expect &&
+	test_cmp expect actual &&
 
-		git distimdist >actual &&
-		echo "distimdistim was called" >expect &&
-		test_cmp expect actual
-	'
-done
+	git distimdist >actual &&
+	echo "distimdistim was called" >expect &&
+	test_cmp expect actual
+'
 
-test_expect_success 'autocorrect can be declined altogether' '
-	git config help.autocorrect never &&
+for never in -1 0 no false never
+do
+	test_expect_success 'autocorrect can be declined altogether' '
+		git config help.autocorrect $never &&
 
-	test_must_fail git lfg 2>actual &&
-	grep "is not a git command" actual &&
-	test_line_count = 1 actual
-'
+		test_must_fail git lfg 2>actual &&
+		grep "is not a git command" actual &&
+		test_line_count = 1 actual
+	'
+done
 
 test_expect_success 'autocorrect works in work tree created from bare repo' '
 	git clone --bare . bare.git &&
-- 
2.48.0.rc2.33.gfa4adeb460

