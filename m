Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 971241865E3
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 11:27:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736594845; cv=none; b=fVG+AvoRxMXRSyh0nadIPez0pDqOH1IyvfxzTLt22ZTLEs4MOeEANgo6k9Ji9f8Itx0+Bp38gKfyZqyOyCs6ZTujYJmYwNEz5Wz4FnGA9ydSouRa/cwgQbzZJSiZwkWuTDmfpcDSFfjVMIMDlEV01ZWbKcrQXeP1p5B7sDzn+EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736594845; c=relaxed/simple;
	bh=MC/31/yNjhtvUNF/mY8yGkEyRUEZoDgnjIpzBadyHL4=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=NLwY+jzKZoIW4JzgoIB6kHXRiVRGIkNT23mw6tTySsaKgeR11cWbE2h0d9/QL33EBEgrOheZxGzk9nHV9urZvD7JPdh7P/QMpyv5S91Aat1DOv0ToxJm+Q9nrfr9H3ZpSR41+FJdoNTNsg4FTrl5s6jaXFgFAZetTUGWyyNYcnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfxIHJQC; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfxIHJQC"
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-436ce2ab251so20832375e9.1
        for <git@vger.kernel.org>; Sat, 11 Jan 2025 03:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736594842; x=1737199642; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vsDB8Xlu30y6l9a4Hijkg+sZg+JVoc904Yaas64V1no=;
        b=nfxIHJQC1AxXzciYFWVsuyig8JJO7E1x9uFBtVeiwZRuG1INlbPaEqFMr5qTYa9mkI
         PruQ3Kkx83ihn0VLuC3XbWxnm90nAUsfzs6Nz/01xIOiK8HWceS62hgmtOdkZsve+XAp
         bqeoy03UjmG7jA2YOFSboie37mmMY1Ec/gKqaNJ2k24KMvfF3BKF+reKHH7ITU+p7CI5
         QjAFt1ry16HJD4vukk7OTf34VQYFLQ0o0NKRzZrtgCR/zoTvLY5hbGXcE/g5KQ4b76Qy
         bEApt9upzc5FEG0JhI5YV1LOfKBLwCg4beIVChAfadwTs5xjKE+KPZVFNFa3WBjLusH2
         INPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736594842; x=1737199642;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vsDB8Xlu30y6l9a4Hijkg+sZg+JVoc904Yaas64V1no=;
        b=LNhGKnw/P64Mtkw9UtI4BKt8lhVf/zza3lENiRbsUy7DpDZsPWrlMY14q08by5AlI3
         QujxkB1c02QHGHBuZCxKP3064jYoMDB80gUPWL7D5ndDnnpCcX8B1WClZdXUzohf+2jU
         U6KiP3AGFmxADDfi9WsiHm8MZ6gAJjPSnlGF4HdHtJaooUh5IV46rNNRqZalj3BeJbsN
         Xhjsqws841gtTT7ubaLeTRHYSFsHvX4Cj/1OI45QVVZ9mY6iu8RbvCcwyDZfkhQmkPNL
         1/L2+ayj+Wy6/C5cH4DnYmlYZ8HmNKpls/Jm2UXaKK0CxZrnVyPuUUj7al3Zo9td0hEZ
         IdFA==
X-Gm-Message-State: AOJu0YxqPDDMyQoFiMLndyzi1hSIURukSCr/QhWkouXk78F+Ew8ccZ0e
	fL+jx2ontkapTjHn5VvsoPcTFR8CwcRMvtyne7tubg/XZ56X+RCiDjzy1g==
X-Gm-Gg: ASbGncshJ3gWAvEYR/7YPHoUxvmNm0krY+tE7B6CvdgQDTjEKT0Qja3CRzvNupcyZbG
	fC7R4lgXCPVf3kbZLH5I/F5RM2LxPCYHqOxM5XfrM8aFwzyNeZEB/hGFsao8o7eWVbXTcHWb/oZ
	p6lTevGYzuekoMsHhJIizCbS51yBR/CmIzi7B+OTnJ0HtD4i/HObTTcq7l/Z2TjY9Cis7lGZD7F
	BZOOId+KizsZIMM9xcEIHPIw3TH6qhMpoI8V2iGLyRtvQBzwfkTuKhfuA==
X-Google-Smtp-Source: AGHT+IHcdQPbSEGdJWWkJVMw7PLgLftY+C7ecMf4XqsR8DxQlcsk4oHCqn5W3VaEwvCW/uu6pxz6NQ==
X-Received: by 2002:a05:600c:5117:b0:431:60ec:7a96 with SMTP id 5b1f17b1804b1-436e26ddc53mr111546785e9.25.1736594841360;
        Sat, 11 Jan 2025 03:27:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2e92f7bsm115305335e9.38.2025.01.11.03.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jan 2025 03:27:20 -0800 (PST)
Message-Id: <pull.1869.v3.git.git.1736594839527.gitgitgadget@gmail.com>
In-Reply-To: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
References: <pull.1869.v2.git.git.1736419777235.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 11 Jan 2025 11:27:19 +0000
Subject: [PATCH v3] help: interpret boolean string values for help.autocorrect
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
    Johannes Schindelin <Johannes.Schindelin@gmx.de>,
    Yongmin <yewon@revi.email>,
    Jeff King <peff@peff.net>,
    Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

A help.autocorrect value of 1 is currently interpreted as "wait 1
decisecond", which can be confusing to users who believe they are setting a
boolean value to turn the autocorrect feature on.

Interpret the value of help.autocorrect as either one of the accepted list
of special values ("never", "immediate", ...), a boolean or an integer. If
the value is 1, it is no longer interpreted as a decisecond value of 0.1s
but as a true boolean, the equivalent of "immediate". If the value is 2 or
more, continue treating it as a decisecond wait time.

False boolean string values ("off", "false", "no") are now equivalent to
"never", meaning that guessed values are still shown but nothing is
executed. True boolean string values are interpreted as "immediate".

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
    help: interpret boolean string values for help.autocorrect
    
    Basically just using Junio's suggested code from the ML, splitting most
    of the logic out into a parse_autocorrect method and then special casing
    a 1 integer as "immediate". I reverted to interpreting false boolean
    values as NEVER rather than 0, which means they no longer show guesses,
    which the last patch did.
    
    Changes since v2:
    
     * split out most logic into parse_autocorrect
     * interpret false boolean values as NEVER rather than 0
     * Update the help.txt documentation

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1869%2Fschacon%2Fmaster-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1869/schacon/master-v3
Pull-Request: https://github.com/git/git/pull/1869

Range-diff vs v2:

 1:  07b47b70ded ! 1:  4ce7652d19e help: interpret boolean string values for help.autocorrect
     @@ Commit message
          but as a true boolean, the equivalent of "immediate". If the value is 2 or
          more, continue treating it as a decisecond wait time.
      
     -    False boolean string values ("off", "false", "no") are now equivalent to 0,
     -    meaning that guessed values are still shown but nothing is executed (as
     -    opposed to "never", which does not show the guesses). True boolean string
     -    values are interpreted as "immediate".
     +    False boolean string values ("off", "false", "no") are now equivalent to
     +    "never", meaning that guessed values are still shown but nothing is
     +    executed. True boolean string values are interpreted as "immediate".
      
          Signed-off-by: Scott Chacon <schacon@gmail.com>
      
     @@ Documentation/config/help.txt: help.autoCorrect::
       	run the suggestion automatically. Possible config values are:
      -	 - 0 (default): show the suggested command.
      -	 - positive number: run the suggested command after specified
     -+	 - 0, false boolean string: show the suggested command (default).
     -+	 - 1, true boolean string: run the suggested command immediately.
     ++	 - 0: show the suggested command (default).
     ++	 - 1, "true", "on", "yes": run the suggested command immediately.
      +	 - positive number > 1: run the suggested command after specified
       deciseconds (0.1 sec).
       	 - "immediate": run the suggested command immediately.
       	 - "prompt": show the suggestion and prompt for confirmation to run
     + the command.
     +-	 - "never": don't run or show any suggested command.
     ++	 - "false", "off", "no", "never": don't run or show any suggested command.
     + 
     + help.htmlPath::
     + 	Specify the path where the HTML documentation resides. File system paths
      
       ## help.c ##
     +@@ help.c: struct help_unknown_cmd_config {
     + #define AUTOCORRECT_NEVER (-2)
     + #define AUTOCORRECT_IMMEDIATELY (-1)
     + 
     ++static int parse_autocorrect(const char *value)
     ++{
     ++	switch (git_parse_maybe_bool_text(value)) {
     ++		case 1:
     ++			return AUTOCORRECT_IMMEDIATELY;
     ++		case 0:
     ++			return AUTOCORRECT_NEVER;
     ++		default: /* other random text */
     ++			break;
     ++	}
     ++
     ++	if (!strcmp(value, "prompt"))
     ++		return AUTOCORRECT_PROMPT;
     ++	if (!strcmp(value, "never"))
     ++		return AUTOCORRECT_NEVER;
     ++	if (!strcmp(value, "immediate"))
     ++		return AUTOCORRECT_IMMEDIATELY;
     ++
     ++	return 0;
     ++}
     ++
     + static int git_unknown_cmd_config(const char *var, const char *value,
     + 				  const struct config_context *ctx,
     + 				  void *cb)
      @@ help.c: static int git_unknown_cmd_config(const char *var, const char *value,
     - 		} else if (!strcmp(value, "prompt")) {
     - 			cfg->autocorrect = AUTOCORRECT_PROMPT;
     - 		} else {
     + 	const char *p;
     + 
     + 	if (!strcmp(var, "help.autocorrect")) {
     +-		if (!value)
     +-			return config_error_nonbool(var);
     +-		if (!strcmp(value, "never")) {
     +-			cfg->autocorrect = AUTOCORRECT_NEVER;
     +-		} else if (!strcmp(value, "immediate")) {
     +-			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
     +-		} else if (!strcmp(value, "prompt")) {
     +-			cfg->autocorrect = AUTOCORRECT_PROMPT;
     +-		} else {
      -			int v = git_config_int(var, value, ctx->kvi);
      -			cfg->autocorrect = (v < 0)
      -				? AUTOCORRECT_IMMEDIATELY : v;
     -+			int is_bool;
     -+			int v = git_config_bool_or_int(var, value, ctx->kvi, &is_bool);
     -+			if (is_bool) {
     -+				if (v == 0) {
     -+					cfg->autocorrect = 0;
     -+				} else {
     -+					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
     -+				}
     -+			} else {
     -+				if (v < 0 || v == 1) {
     -+					cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
     -+				} else {
     -+					cfg->autocorrect = v;
     -+				}
     -+			}
     ++		int v = parse_autocorrect(value);
     ++
     ++		if (!v) {
     ++			v = git_config_int(var, value, ctx->kvi);
     ++			if (v < 0 || v == 1)
     ++				v = AUTOCORRECT_IMMEDIATELY;
       		}
     ++
     ++		cfg->autocorrect = v;
       	}
     ++
       	/* Also use aliases for command lookup */
     + 	if (skip_prefix(var, "alias.", &p))
     + 		add_cmdname(&cfg->aliases, p, strlen(p));


 Documentation/config/help.txt |  7 +++---
 help.c                        | 42 +++++++++++++++++++++++++----------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 610701f9a37..16b124b1c17 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,13 +11,14 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0 (default): show the suggested command.
-	 - positive number: run the suggested command after specified
+	 - 0: show the suggested command (default).
+	 - 1, "true", "on", "yes": run the suggested command immediately.
+	 - positive number > 1: run the suggested command after specified
 deciseconds (0.1 sec).
 	 - "immediate": run the suggested command immediately.
 	 - "prompt": show the suggestion and prompt for confirmation to run
 the command.
-	 - "never": don't run or show any suggested command.
+	 - "false", "off", "no", "never": don't run or show any suggested command.
 
 help.htmlPath::
 	Specify the path where the HTML documentation resides. File system paths
diff --git a/help.c b/help.c
index 5483ea8fd29..7148963e468 100644
--- a/help.c
+++ b/help.c
@@ -556,6 +556,27 @@ struct help_unknown_cmd_config {
 #define AUTOCORRECT_NEVER (-2)
 #define AUTOCORRECT_IMMEDIATELY (-1)
 
+static int parse_autocorrect(const char *value)
+{
+	switch (git_parse_maybe_bool_text(value)) {
+		case 1:
+			return AUTOCORRECT_IMMEDIATELY;
+		case 0:
+			return AUTOCORRECT_NEVER;
+		default: /* other random text */
+			break;
+	}
+
+	if (!strcmp(value, "prompt"))
+		return AUTOCORRECT_PROMPT;
+	if (!strcmp(value, "never"))
+		return AUTOCORRECT_NEVER;
+	if (!strcmp(value, "immediate"))
+		return AUTOCORRECT_IMMEDIATELY;
+
+	return 0;
+}
+
 static int git_unknown_cmd_config(const char *var, const char *value,
 				  const struct config_context *ctx,
 				  void *cb)
@@ -564,20 +585,17 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 	const char *p;
 
 	if (!strcmp(var, "help.autocorrect")) {
-		if (!value)
-			return config_error_nonbool(var);
-		if (!strcmp(value, "never")) {
-			cfg->autocorrect = AUTOCORRECT_NEVER;
-		} else if (!strcmp(value, "immediate")) {
-			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
-		} else if (!strcmp(value, "prompt")) {
-			cfg->autocorrect = AUTOCORRECT_PROMPT;
-		} else {
-			int v = git_config_int(var, value, ctx->kvi);
-			cfg->autocorrect = (v < 0)
-				? AUTOCORRECT_IMMEDIATELY : v;
+		int v = parse_autocorrect(value);
+
+		if (!v) {
+			v = git_config_int(var, value, ctx->kvi);
+			if (v < 0 || v == 1)
+				v = AUTOCORRECT_IMMEDIATELY;
 		}
+
+		cfg->autocorrect = v;
 	}
+
 	/* Also use aliases for command lookup */
 	if (skip_prefix(var, "alias.", &p))
 		add_cmdname(&cfg->aliases, p, strlen(p));

base-commit: fbe8d3079d4a96aeb4e4529cc93cc0043b759a05
-- 
gitgitgadget
