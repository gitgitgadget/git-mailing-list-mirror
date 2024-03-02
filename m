Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C158E154B1
	for <git@vger.kernel.org>; Sat,  2 Mar 2024 09:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709373482; cv=none; b=ByL1XxJnSHPu0X49E9QUZ0euYVddMMPd9x6yY8IHpH+TbnIpDlOul3fd2hd8JPJ85gFwR/kGdviFjgnbfdfr0nLQroGW5hA3Pw6GJdbISrdAuDY/+kSVXswp0klvwgkch4k6owhdP9EDU9f8F5KT9xv8rThE4s5EVP7mSqZgu0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709373482; c=relaxed/simple;
	bh=eY0A5gUvzXxiLB43BBLnIzkZDNk1Kxzcqun99OFP60I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHI86ECQ8n7UokO7RsaRYvAvyYIK39L9JZipwq/j/fNfp2D/+2FLxo6A4A/ELcUY/f1NkO6VFk5FvKFT5oFt97DrCvCAkzdfVaqQHDPMGan+3h45Cs1yVa3UEc4Zn1Oav6f7zIZx0ZsOd9uUgLe98RQEmteKVhlf1UUvp8IlDeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DUh7BFcP; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DUh7BFcP"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26fa294e56so540156566b.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 01:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709373479; x=1709978279; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=laUOs8uce5ii0sJ1QLxlNgGIaIpNatRA3GTYB5zPncU=;
        b=DUh7BFcP0vKVRZ+Z+At0UvLo0gseHlKTDPMNyCWD4C/lxsL/r5AfPMQalOaV0bAMm+
         Nz+enxVLGQhS8rmKJuhqAiDHSiZUs6SqZxCZtCdvnZME6qiTINNtQpkJDyxt/DKy6S6n
         8PwJ0D/i7l4GQcDhqOKSdjIEvZ4kjJF236RNji8qgtibZHjlP9NI3JQSpFTeveboMNKY
         mDGLFToOHEKubMQJ2cZa2rgHY4bGVlYXxZCLhzGgq5Dwg1AH/QCwC7+0rLQ4gpErZ22m
         qqzcmkQ+TjlzUkmZmKsrBgaL6PkYxExuuAl2KSqVscYeStlffdrHK8V4cqldDrBvaSia
         Is0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709373479; x=1709978279;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=laUOs8uce5ii0sJ1QLxlNgGIaIpNatRA3GTYB5zPncU=;
        b=tfBV5jZAsbJ+NJGA16gwSA/lSsxo89eH8JmCXPoQY04c5KfEVnpI4/yxvVHo/gMHFk
         Y0ERatfyPRmsyYWqUJaBFH6NHWIGWE9Fy7FGMFEXkDuw7STiIZwfg4/m789eu9n6/ydx
         r7/KzeZf3fSnPOtGu6LUF8OSLxyI7kRx9zGbIXgjTY4kXPAIVKZT//bM7v6rev8G9ZEP
         RJC4tUKkam1zzSLxeSo03RHQvGn8UBncw+73Znv6ELJBgm/cYYT8gp3sele9P/f5U2dT
         tRF/z7mTH8VTNTLz+oI3WuFDL50DEQY7l9ng4UQZ24tv3JUtQ2Q1MMKhAZzyQrtg1jOj
         KIUg==
X-Gm-Message-State: AOJu0YzU0nL4hi20PDJ1G0/qwcCpaS7HWGBfQt0w9oun0VRa23BZqAW8
	h9udiQF4nHhYSlshOTInrGpGiLmrfnHU7sVTQLtHI1pNt0lgqkpZ1H0FvUgOJvU=
X-Google-Smtp-Source: AGHT+IFLOQM1G5SkHLJXeW//Zmpzq3WnI6NqFk/IemMyJcpO6mItMUVvVftShpae5sB+yB6GUn0p0g==
X-Received: by 2002:a17:906:c2c9:b0:a44:c510:44b3 with SMTP id ch9-20020a170906c2c900b00a44c51044b3mr1366316ejb.61.1709373478834;
        Sat, 02 Mar 2024 01:57:58 -0800 (PST)
Received: from laptop.fritz.box ([2a02:2455:826e:4900:f403:1f77:2b7e:2436])
        by smtp.gmail.com with ESMTPSA id o9-20020a17090608c900b00a42f36174c7sm2555693eje.92.2024.03.02.01.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Mar 2024 01:57:58 -0800 (PST)
From: Karthik Nayak <karthik.188@gmail.com>
To: oliver@schinagl.nl
Cc: git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 2/2] diff: add 'diff.wordDiff' config option
Date: Sat,  2 Mar 2024 10:57:51 +0100
Message-ID: <20240302095751.123138-3-karthik.188@gmail.com>
X-Mailer: git-send-email 2.43.1
In-Reply-To: <20240302095751.123138-1-karthik.188@gmail.com>
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-diff(1) command supports the `--word-diff` which allows the
users to specify how to delimit word diffs. Provide this option also as
a config param 'diff.wordDiff'.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/config/diff.txt |  4 +++
 diff.c                        | 50 +++++++++++++++++++++++++++--------
 t/t4034-diff-words.sh         | 11 ++++++--
 3 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/Documentation/config/diff.txt b/Documentation/config/diff.txt
index bd5ae0c337..00459beee2 100644
--- a/Documentation/config/diff.txt
+++ b/Documentation/config/diff.txt
@@ -225,3 +225,7 @@ diff.colorMovedWS::
 	When moved lines are colored using e.g. the `diff.colorMoved` setting,
 	this option controls the `<mode>` how spaces are treated
 	for details of valid modes see '--color-moved-ws' in linkgit:git-diff[1].
+
+diff.wordDiff::
+	Show a word diff, using the `<mode>` to delimit changed words.
+	For details of valid modes see '--word-diff' in linkgit:git-diff[1].
diff --git a/diff.c b/diff.c
index e50def4538..050d83ef85 100644
--- a/diff.c
+++ b/diff.c
@@ -69,6 +69,7 @@ static int diff_dirstat_permille_default = 30;
 static struct diff_options default_diff_options;
 static long diff_algorithm;
 static unsigned ws_error_highlight_default = WSEH_NEW;
+static int diff_word_diff_default;
 
 static char diff_colors[][COLOR_MAXLEN] = {
 	GIT_COLOR_RESET,
@@ -209,6 +210,23 @@ int git_config_rename(const char *var, const char *value)
 	return git_config_bool(var,value) ? DIFF_DETECT_RENAME : 0;
 }
 
+static int parse_word_diff_value(const char *value)
+{
+	if (!value)
+		return -1;
+	else if (!strcmp(value, "plain"))
+		return DIFF_WORDS_PLAIN;
+	else if (!strcmp(value, "color")) {
+		return DIFF_WORDS_COLOR;
+	}
+	else if (!strcmp(value, "porcelain"))
+		return DIFF_WORDS_PORCELAIN;
+	else if (!strcmp(value, "none"))
+		return DIFF_WORDS_NONE;
+
+	return -1;
+}
+
 long parse_algorithm_value(const char *value)
 {
 	if (!value)
@@ -452,6 +470,18 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 
+	if (!strcmp(var, "diff.worddiff")) {
+		if (!value)
+			return config_error_nonbool(var);
+		diff_word_diff_default = parse_word_diff_value(value);
+		if (diff_word_diff_default < 0)
+			return error(_("unknown value for config '%s': %s"),
+				     var, value);
+		if (diff_word_diff_default == DIFF_WORDS_COLOR)
+			diff_use_color_default = 1;
+		return 0;
+	}
+
 	if (git_color_config(var, value, cb) < 0)
 		return -1;
 
@@ -4724,6 +4754,7 @@ void repo_diff_setup(struct repository *r, struct diff_options *options)
 	options->use_color = diff_use_color_default;
 	options->detect_rename = diff_detect_rename_default;
 	options->xdl_opts |= diff_algorithm;
+	options->word_diff |= diff_word_diff_default;
 	if (diff_indent_heuristic)
 		DIFF_XDL_SET(options, INDENT_HEURISTIC);
 
@@ -5504,21 +5535,18 @@ static int diff_opt_word_diff(const struct option *opt,
 			      const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
+	int value;
 
 	BUG_ON_OPT_NEG(unset);
+
 	if (arg) {
-		if (!strcmp(arg, "plain"))
-			options->word_diff = DIFF_WORDS_PLAIN;
-		else if (!strcmp(arg, "color")) {
-			options->use_color = 1;
-			options->word_diff = DIFF_WORDS_COLOR;
-		}
-		else if (!strcmp(arg, "porcelain"))
-			options->word_diff = DIFF_WORDS_PORCELAIN;
-		else if (!strcmp(arg, "none"))
-			options->word_diff = DIFF_WORDS_NONE;
-		else
+		value = parse_word_diff_value(arg);
+		if (value < 0)
 			return error(_("bad --word-diff argument: %s"), arg);
+		if (value == DIFF_WORDS_COLOR)
+			options->use_color = 1;
+
+		options->word_diff = value;
 	} else {
 		if (options->word_diff == DIFF_WORDS_NONE)
 			options->word_diff = DIFF_WORDS_PLAIN;
diff --git a/t/t4034-diff-words.sh b/t/t4034-diff-words.sh
index 4f70aa6e9f..2cc391c339 100755
--- a/t/t4034-diff-words.sh
+++ b/t/t4034-diff-words.sh
@@ -56,12 +56,19 @@ diff_with_opts () {
 	post=$(git rev-parse --short $(git hash-object post)) &&
 	test_must_fail git diff --no-index "$@" pre post >output &&
 	test_decode_color <output >output.decrypted &&
-	sed -e "2s/index [^ ]*/index $pre..$post/" expect >expected
+	sed -e "2s/index [^ ]*/index $pre..$post/" expect >expected &&
 	test_cmp expected output.decrypted
 }
 
 word_diff () {
-	diff_with_opts "--word-diff=$1" $(echo "$@" | cut -d' ' -s -f 2-)
+	# Capture the rest of the arguments to passthrough.
+	rest=$(echo "$@" | cut -d' ' -s -f 2-) &&
+	# Test via the config route.
+	git config diff.wordDiff $1 &&
+	diff_with_opts $rest &&
+	git config --unset diff.wordDiff &&
+	# Test via the command option route.
+	diff_with_opts "--word-diff=$1" $rest
 }
 
 test_language_driver () {
-- 
2.43.GIT

