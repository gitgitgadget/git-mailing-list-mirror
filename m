Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBACB14F135
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 07:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736494106; cv=none; b=S/49uHoAQ3antrfjhpF/8nO96/LEPuQLFfdtq+bnl3Ift+8CIP4+dLyS+OKMr4JzhToqA9SSs4BlUq2w2yAMzJsmwLUrgypZPMyd5zEmsOWcYi+5U7mxf+bYcMbFfo01KJrxcRL7yLyVyxp8bKxZg3cCAhyDRVq0H9GAjzHz14Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736494106; c=relaxed/simple;
	bh=bo9YJfl4rKUuqe3j42oKJRPDoqm+hkup0j2jddMV13s=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=u00DoOmH4JZSkW0gwuRwxJXbKCRptdmHrDVZUcMtsJsDV6aJUWxP1UzA3MjtY7h9cSnNGyLsUUeM8c7VDcyqdnB87C7w3MENb4KcDx8Z9ZW4MtiKZ430OYHFOK1joQR33/IqG6gQSm1sfP9ZSzSSfcCDpruBnEq659NfKQJTvpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGG6TVrj; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGG6TVrj"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4361dc6322fso12429625e9.3
        for <git@vger.kernel.org>; Thu, 09 Jan 2025 23:28:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736494102; x=1737098902; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y7e0dalqjep/Pg5h2IIBKq12oVqbWhDCULIi1W/4XYc=;
        b=hGG6TVrjAdN8ftS4GHha9b6KLuuXKX65gpI1NER4n7nO8Uy7fgU2jbq8ctiA5oJbos
         QCHU653aCDdyeJJwBkbKitydGiiVgk2Wu/XhaTUxWWprQteew5YDOhzs38RgTo7d4hB1
         Cwp/jh1E9cu24ZVFlB/IbcfLU3m928MGskEkE4lGOKary9IS4aODDk9gQJGys176NUwa
         fTERt72OVDz1rdYiVqAtRU5BlDYjQX0DOny5NhM1OneibFeS/RKrA8GavsgX4cGdjw8y
         d+XEiVDca0UQ6J3oErP01/jQ3L0xOdOvcPSXqoY+A49fBMZv7dm2V3gs/9nUogGPJLqW
         bT1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736494102; x=1737098902;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y7e0dalqjep/Pg5h2IIBKq12oVqbWhDCULIi1W/4XYc=;
        b=SHUvZu9tePxPsiUR0ZR4AmWbjCIEPhjvgPY5CliDCvMcAuXp/2pbRL2R0DWLV23Mja
         LNp7dHOkPBm7uTW/5zTi+XZrfZQqCQya6ksJb0xvEio/TwykoDdOvEEg/HK1kl7N3aTa
         dxh5y2aslWhWmmaQQqHknepD5VWOcGyUfx0dSTA9nt6+8zlp4Jy+MkNU9urKfxqjLvcg
         8Om9DlK1nl16jwXZRG323tDEXOis5w+GwWQETKFo+asIVVJ0qLDLptI62seBzC8rpdHb
         4K50qk8iSElfxdrEehfJJVsMnmcSgM+oCKT4GPSjceZAW+NOMYunvWCOhUqcuabBWcgh
         nCWw==
X-Gm-Message-State: AOJu0YzwSLmsAmg4aGs6Bg3UATac3NN56bUmBO2nvJXBwmLZ/Iq+FEA1
	sRHfFcnhwIkTAg49yRI54DPouH0wPtJZ4go8DPtE744mRY1sLQ7j2Usq1g==
X-Gm-Gg: ASbGncvhLC1UF6fKFouB3RhuTYX1JgWrm5ogSguzFMQvJ5tmVREX914y6b5VEnYft3f
	scnYP+CyTp0/hskEZxyAGiPK5W33zbUr8S9aC55+tRhG1ZnJdx0wVU8Iy95RBho0YpN1JGPX8WW
	IixHMv1RnDBfV21A15aZuyEeyHXd23FD6NPg9+eP/KHKTql4AXjj/GC5JBBRctGkP5XcPkhtyPO
	/mL4DG29GtyL6p8TJA9ARwGU3chQ1kPjLLeF5pM3zrmIHxRTlvSoEjkhw==
X-Google-Smtp-Source: AGHT+IFGRIsqFxJAiviAh2vL7lsWl0Kuq+Z5DSVQt4voCs6riJfTQxbFxTalPaX28PP8zp1z5V9U2A==
X-Received: by 2002:a05:600c:1c14:b0:436:1ac2:1ad2 with SMTP id 5b1f17b1804b1-436e26c0400mr84593405e9.19.1736494102080;
        Thu, 09 Jan 2025 23:28:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436e2dc0babsm77659575e9.14.2025.01.09.23.28.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2025 23:28:21 -0800 (PST)
Message-Id: <pull.1814.v2.git.1736494100622.gitgitgadget@gmail.com>
In-Reply-To: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
References: <pull.1814.git.1730937889182.gitgitgadget@gmail.com>
From: "Adam Murray via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 10 Jan 2025 07:28:20 +0000
Subject: [PATCH v2] trace2: prevent segfault on config collection where no
 value specified
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
Cc: Adam Murray <ad@canva.com>,
    Adam Murray <ad@canva.com>

From: Adam Murray <ad@canva.com>

When TRACE2 analytics is enabled, a git config option that has no value
causes a segfault.

Steps to Reproduce
GIT_TRACE2=true GIT_TRACE2_CONFIG_PARAMS=status.*
git -c status.relativePaths version
Expected Result
git version 2.46.0
Actual Result
zsh: segmentation fault GIT_TRACE2=true

This adds checks to prevent the segfault and instead return
an empty value.

Signed-off-by: Adam Murray <ad@canva.com>
---
    trace2: prevent segfault on config collection where no value specified
    
    cc: Jeff King peff@peff.net

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1814%2Fad-murray%2Ffix-trace2-segfault-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1814/ad-murray/fix-trace2-segfault-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/1814

Range-diff vs v1:

 1:  24ba9db7aa1 ! 1:  fd7bed52dda trace2: prevent segfault on config collection where no value specified
     @@ Commit message
          Actual Result
          zsh: segmentation fault GIT_TRACE2=true
      
     -    This adds a null check to prevent the segfault and instead return
     -    the "empty config value" error.
     +    This adds checks to prevent the segfault and instead return
     +    an empty value.
      
          Signed-off-by: Adam Murray <ad@canva.com>
      
     @@ t/t0210-trace2-normal.sh: test_expect_success 'bug messages followed by BUG() ar
      
       ## trace2.c ##
      @@ trace2.c: void trace2_def_param_fl(const char *file, int line, const char *param,
     - 	int j;
     - 	const char *redacted;
     - 
     --	if (!trace2_enabled)
     -+	if (!trace2_enabled || !value)
     + 	if (!trace2_enabled)
       		return;
       
     - 	redacted = redact_arg(value);
     +-	redacted = redact_arg(value);
     ++	redacted = value ? redact_arg(value): NULL;
     + 
     + 	for_each_wanted_builtin (j, tgt_j)
     + 		if (tgt_j->pfn_param_fl)
     +
     + ## trace2/tr2_tgt_event.c ##
     +@@ trace2/tr2_tgt_event.c: static void fn_param_fl(const char *file, int line, const char *param,
     + 	event_fmt_prepare(event_name, file, line, NULL, &jw);
     + 	jw_object_string(&jw, "scope", scope_name);
     + 	jw_object_string(&jw, "param", param);
     +-	jw_object_string(&jw, "value", value);
     ++	if (value)
     ++		jw_object_string(&jw, "value", value);
     + 	jw_end(&jw);
     + 
     + 	tr2_dst_write_line(&tr2dst_event, &jw.json);
     +
     + ## trace2/tr2_tgt_normal.c ##
     +@@ trace2/tr2_tgt_normal.c: static void fn_param_fl(const char *file, int line, const char *param,
     + 	enum config_scope scope = kvi->scope;
     + 	const char *scope_name = config_scope_name(scope);
     + 
     +-	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
     +-		    value);
     ++	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
     ++	if (value)
     ++		strbuf_addf(&buf_payload, "=%s", value);
     + 	normal_io_write_fl(file, line, &buf_payload);
     + 	strbuf_release(&buf_payload);
     + }
     +
     + ## trace2/tr2_tgt_perf.c ##
     +@@ trace2/tr2_tgt_perf.c: static void fn_param_fl(const char *file, int line, const char *param,
     + 	struct strbuf scope_payload = STRBUF_INIT;
     + 	enum config_scope scope = kvi->scope;
     + 	const char *scope_name = config_scope_name(scope);
     +-
     +-	strbuf_addf(&buf_payload, "%s:%s", param, value);
     ++	strbuf_addstr(&buf_payload, param);
     ++	if (value)
     ++		strbuf_addf(&buf_payload, ":%s", value);
     + 	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
     + 
     + 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,


 t/t0210-trace2-normal.sh | 8 ++++++++
 trace2.c                 | 2 +-
 trace2/tr2_tgt_event.c   | 3 ++-
 trace2/tr2_tgt_normal.c  | 5 +++--
 trace2/tr2_tgt_perf.c    | 5 +++--
 5 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/t/t0210-trace2-normal.sh b/t/t0210-trace2-normal.sh
index b9adc94aab4..4047ab562a4 100755
--- a/t/t0210-trace2-normal.sh
+++ b/t/t0210-trace2-normal.sh
@@ -244,6 +244,14 @@ test_expect_success 'bug messages followed by BUG() are written to trace2' '
 	test_cmp expect actual
 '
 
+test_expect_success 'empty configuration values are handled' '
+  test_when_finished "rm trace2.normal actual expect" &&
+  echo >expect &&
+  GIT_TRACE2="$(pwd)/trace2.normal"  GIT_TRACE2_CONFIG_PARAMS=foo.empty \
+	  git -c foo.empty config foo.empty >actual &&
+	test_cmp expect actual
+'
+
 sane_unset GIT_TRACE2_BRIEF
 
 # Now test without environment variables and get all Trace2 settings
diff --git a/trace2.c b/trace2.c
index f894532d053..49e7d1db88f 100644
--- a/trace2.c
+++ b/trace2.c
@@ -762,7 +762,7 @@ void trace2_def_param_fl(const char *file, int line, const char *param,
 	if (!trace2_enabled)
 		return;
 
-	redacted = redact_arg(value);
+	redacted = value ? redact_arg(value): NULL;
 
 	for_each_wanted_builtin (j, tgt_j)
 		if (tgt_j->pfn_param_fl)
diff --git a/trace2/tr2_tgt_event.c b/trace2/tr2_tgt_event.c
index 45b0850a5ec..8e09485c83c 100644
--- a/trace2/tr2_tgt_event.c
+++ b/trace2/tr2_tgt_event.c
@@ -491,7 +491,8 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	event_fmt_prepare(event_name, file, line, NULL, &jw);
 	jw_object_string(&jw, "scope", scope_name);
 	jw_object_string(&jw, "param", param);
-	jw_object_string(&jw, "value", value);
+	if (value)
+		jw_object_string(&jw, "value", value);
 	jw_end(&jw);
 
 	tr2_dst_write_line(&tr2dst_event, &jw.json);
diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index baef48aa698..924736ab360 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -307,8 +307,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
 
-	strbuf_addf(&buf_payload, "def_param scope:%s %s=%s", scope_name, param,
-		    value);
+	strbuf_addf(&buf_payload, "def_param scope:%s %s", scope_name, param);
+	if (value)
+		strbuf_addf(&buf_payload, "=%s", value);
 	normal_io_write_fl(file, line, &buf_payload);
 	strbuf_release(&buf_payload);
 }
diff --git a/trace2/tr2_tgt_perf.c b/trace2/tr2_tgt_perf.c
index a6f9a8a193e..19ae7433ef8 100644
--- a/trace2/tr2_tgt_perf.c
+++ b/trace2/tr2_tgt_perf.c
@@ -446,8 +446,9 @@ static void fn_param_fl(const char *file, int line, const char *param,
 	struct strbuf scope_payload = STRBUF_INIT;
 	enum config_scope scope = kvi->scope;
 	const char *scope_name = config_scope_name(scope);
-
-	strbuf_addf(&buf_payload, "%s:%s", param, value);
+	strbuf_addstr(&buf_payload, param);
+	if (value)
+		strbuf_addf(&buf_payload, ":%s", value);
 	strbuf_addf(&scope_payload, "%s:%s", "scope", scope_name);
 
 	perf_io_write_fl(file, line, event_name, NULL, NULL, NULL,

base-commit: 8f8d6eee531b3fa1a8ef14f169b0cb5035f7a772
-- 
gitgitgadget
