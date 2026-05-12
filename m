Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73561366831
	for <git@vger.kernel.org>; Tue, 12 May 2026 18:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609430; cv=none; b=pDc4hF+mjNZMN3AuwDyxzglZgGlvI2zkMabJeDnGyGOb0ms7wsFezkdd4V7M3EiobfaeizITA9s4vXN7XN3ZcBTWreDDXVgHadtg6kPnngRkMYpJlz1KxcBRj0jo9yLf5sczehr7tZq6zDcmnLgqDXESCzgJl+S3unzOSdeViPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609430; c=relaxed/simple;
	bh=eT1yXqiLmllvVoRZQeuhlpxdpsVIDhrCm3QR8L4tOU0=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qP6w6m7tIbzEqfjZw52kVsThQkvlUkAmsK0yEEF/XscSPztfI7J9uWhIVZKZoPifTTd8v00ZxEWILSY22lSWyIZKxzjNzrdAb5P+ppXtP0E31xeyuReuyUtaKEI/zX0iBCxteFHgrV79BaxviBbAUzY9rmVqP95vP0QjQEzOcss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R/VVfS6M; arc=none smtp.client-ip=74.125.82.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R/VVfS6M"
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-1334825de43so1190685c88.0
        for <git@vger.kernel.org>; Tue, 12 May 2026 11:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778609428; x=1779214228; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vMtQEZePQbh7W1BTrbBt9E1zsmj985sDf4jeUG2t3tQ=;
        b=R/VVfS6MyN8aA4HYFaSQHcW1O7jz3gD6f2K/1FyLIpFgyYT/apR96o5TFHBzZZaPgJ
         iZS5cSmn5vkufvuOfwCN2ReCpoAfxmuhgqH1kyi792S7gSh0kZBxLqw6TT17xQqRMfqw
         eEc4Hsz+CCdn5XVF9GtPWOUrA8VOxmx8SveZi9mk6A0sytPJzSbDrOFRoRcLgrrNkDgk
         dlfU2uTOMsKVdSTXPY6CxiKKHYjqk9AGWZs3BqQwbHWTsttx83GNjl4UYdbQ6PljJtMH
         HnPVs2jMLI7Y7zLEAnHAi6+BWZyBp7XCGCTiyll+v2t1RvWhK4IPOSe/5fQSw82tEOy1
         8F4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778609428; x=1779214228;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vMtQEZePQbh7W1BTrbBt9E1zsmj985sDf4jeUG2t3tQ=;
        b=C/8b/vFus4Y90L4kjJQjj3vbGUrkC/T5WAlDQ85QfCtTgAo9YCk4MCOTG5plxc475J
         gjfzybc0M2HGcS8WhYVc8qMghYT7ug5pQUKHOHCYKROuKlvH26CwRmfl1yZfKyMNpdjX
         2NeAiqQ4ML/21jeLvfEoEIE4OFIfh5TXahTEJjU0haKkb5L5GH02Cs8cZ9eI8LIkqdBF
         k/E/2B5YhyoXuPDvi9O4F/QBOyf+8VftK4MxwPxwFu71P/0nD0Z/mNv0SMhzI4vhOA0P
         pTHZO9xRssjAmlk/BaEsmZAUp6P2cmGu1I59Az/HpaL0Ycu3U2nbdGzFC+be46nTr2z/
         MDpw==
X-Gm-Message-State: AOJu0YwreaGj3wq/L4h5Ng7hyLjdgWH46/T/Y7J5b76ZAWQz6yXKL8qJ
	K9p1mD1k/CKVi4lfy0aylQ9QsN5WRGmvHsk/w+qy4yEUk2zh5w7+eOTUpPs7XA==
X-Gm-Gg: Acq92OE+6U98BJo0A0Po55pEe9BvdyEcCIwP9ELV44Pm+udwaApbQ00W+WlRtWgeUJK
	6jghdpqU7wp2XDr27gAWzpSk2jXDKigGzPLCXkuulsq5HI4JnHuDRjBTi3R2dRek0VbCh6jKs0Z
	twxaHNl8yYhR6Z0jNeuAO6ENceKVdWCw+aRKNvKpwJW7SNKW28TDBqdye5Qe2ZAIWcS5VoKiSWE
	sv7VT4V5Y52Ybx+JL9V7pJd6Z4pCtXdM6RP43L5+R1E0MJK9bYu+gtIjW4leA9gq1WP9hPF1l2q
	8O664TlJf09r23kf3/QtQuUNnXYT4onWgkgYEKtWB91KQS7S04m35ZUBvKqkmLNR7Hs2Ebf0Gnq
	4wxTiSk96JNeNqZHK7vAJ7JxSMGM4M3hLFcDokDoQjFXnL2ggbyj78RARGTbuNBBDT324CA1b/F
	cQq3XzmXliKhQ62ttKDAbBMz8d5GQ=
X-Received: by 2002:a05:7022:1b08:b0:12a:6a64:81ee with SMTP id a92af1059eb24-1342ee48a59mr43644c88.3.1778609428296;
        Tue, 12 May 2026 11:10:28 -0700 (PDT)
Received: from [127.0.0.1] ([57.151.128.208])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1327865955fsm25126691c88.11.2026.05.12.11.10.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 11:10:27 -0700 (PDT)
Message-Id: <fc3d2bc31e648615296ec8bc6ef30692aab9ac11.1778609423.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
References: <pull.2105.git.1778022144.gitgitgadget@gmail.com>
	<pull.2105.v2.git.1778609423.gitgitgadget@gmail.com>
From: "Michael Montalbo via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 12 May 2026 18:10:21 +0000
Subject: [PATCH v2 2/4] diff: reject negative values for -U/--unified
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
Cc: Michael Montalbo <mmontalbo@gmail.com>,
    Michael Montalbo <mmontalbo@gmail.com>

From: Michael Montalbo <mmontalbo@gmail.com>

Passing a negative value to -U is silently accepted and produces
corrupt unified diff output with malformed hunk headers:

    $ git log -1 -p -U-500 -- GIT-VERSION-GEN | grep '^@@'
    @@ -503,999- +503,999- @@

Line 503 of a 106-line file, count "999-" is not a valid integer.

The config variable diff.context already rejects negative values, but
the command line callback diff_opt_unified() uses strtol() with no
range check.

Change the type of diff_options.context and its static default from
int to unsigned int, matching the change to interhunkcontext in the
previous commit. The type change requires reworking the callback and
config parsing to validate in a local variable before assigning to
the now-unsigned field.

Unlike --inter-hunk-context which could be converted to OPT_UNSIGNED,
-U needs OPT_CALLBACK_F for PARSE_OPT_OPTARG (bare -U with no value
enables patch output). Add a range check in the callback instead.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 diff.c                  | 12 ++++++++----
 diff.h                  |  2 +-
 t/t4055-diff-context.sh |  5 +++++
 3 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/diff.c b/diff.c
index 5df28e49c5..1771b2c444 100644
--- a/diff.c
+++ b/diff.c
@@ -60,7 +60,7 @@ static int diff_suppress_blank_empty;
 static enum git_colorbool diff_use_color_default = GIT_COLOR_UNKNOWN;
 static int diff_color_moved_default;
 static int diff_color_moved_ws_default;
-static int diff_context_default = 3;
+static unsigned int diff_context_default = 3;
 static unsigned int diff_interhunk_context_default;
 static char *diff_word_regex_cfg;
 static struct external_diff external_diff_cfg;
@@ -382,9 +382,10 @@ int git_diff_ui_config(const char *var, const char *value,
 		return 0;
 	}
 	if (!strcmp(var, "diff.context")) {
-		diff_context_default = git_config_int(var, value, ctx->kvi);
-		if (diff_context_default < 0)
+		int val = git_config_int(var, value, ctx->kvi);
+		if (val < 0)
 			return -1;
+		diff_context_default = val;
 		return 0;
 	}
 	if (!strcmp(var, "diff.interhunkcontext")) {
@@ -5924,9 +5925,12 @@ static int diff_opt_unified(const struct option *opt,
 	BUG_ON_OPT_NEG(unset);
 
 	if (arg) {
-		options->context = strtol(arg, &s, 10);
+		long val = strtol(arg, &s, 10);
 		if (*s)
 			return error(_("%s expects a numerical value"), "--unified");
+		if (val < 0)
+			return error(_("%s expects a non-negative integer"), "--unified");
+		options->context = val;
 	}
 	enable_patch_output(&options->output_format);
 
diff --git a/diff.h b/diff.h
index 033d633db4..bb5cddaf34 100644
--- a/diff.h
+++ b/diff.h
@@ -294,7 +294,7 @@ struct diff_options {
 	enum git_colorbool use_color;
 
 	/* Number of context lines to generate in patch output. */
-	int context;
+	unsigned int context;
 
 	unsigned int interhunkcontext;
 
diff --git a/t/t4055-diff-context.sh b/t/t4055-diff-context.sh
index 1384a81957..b26f6eea7c 100755
--- a/t/t4055-diff-context.sh
+++ b/t/t4055-diff-context.sh
@@ -82,6 +82,11 @@ test_expect_success 'negative integer config parsing' '
 	test_grep "bad config variable" output
 '
 
+test_expect_success '-U-1 is rejected' '
+	test_must_fail git diff -U-1 2>err &&
+	test_grep "expects a non-negative integer" err
+'
+
 test_expect_success '-U0 is valid, so is diff.context=0' '
 	test_config diff.context 0 &&
 	git diff >output &&
-- 
gitgitgadget

