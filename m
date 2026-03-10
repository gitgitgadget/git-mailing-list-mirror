Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC5E2D2496
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773164743; cv=none; b=POdPz3s0yiUurTOGyb4JFAhhyGHpLnsaQutzrnDn0tYScAb9xctKJaNH5nu4NS8TAir+m9PC2bAQ/l0j5X/lAUKW/hNDp+BLzykMGArYcjPHRmGh0HqJYYdFfq/UVIUoe1IaEaF7gOytDnrM9pM/iccRmWAenSkkyb6cYpoV1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773164743; c=relaxed/simple;
	bh=VJk8UKgdSQF8OR7b6igiWsnJkhm74sQI5w6EjZPAxa0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=COPVUS/j3q6ctsFRz/L2mCVzzoK4qi+t6v9lV55dJ1ypQwsBLMMMe1o9w6kfdeRiZXrdv+iBQTP/7lP0rda2hP6y75N8SDDDZEmrREHTJegGEuN8mKmMUXEQoHQrbGQ1LVGaKC3rtbo9w+gdEDLKRLn0Jlanbitr940O+NyZpvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5mEPl84; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5mEPl84"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-827270d50d4so12963562b3a.3
        for <git@vger.kernel.org>; Tue, 10 Mar 2026 10:45:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773164742; x=1773769542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NHHh7vDwNnkAVISaJtSOwNXhsrq0qAcj78Ek+80xUSs=;
        b=D5mEPl84S8E5etkxSBtxjAgoLg/pQs9UQHGm5C0RSxp+qj64LrO6HGaZ7gLk9LaRQ1
         22EwrxOvIimPiY7K+302XctgVXu3IUnmHMsjbRvLfHGfy5SiDtGDLanwvlVcLdRNnoAn
         lbYtRbOsFTOkRLL2n6Pg+7H1Da82ohJMnk0s98AYdSRXPAntKe1qbq0qeGw50M3wV0Tv
         agVysCCrASWTX+t5W4w7I5R/vfUS06qHrnwQXYHtaA1FfVnI+HNf2XgTB1uJXZHe7rbc
         PeKssLqFoyMEjNBLZAIrpOUialZYlFVS20Om+DpuKs08FLsUWQvU6wctwoLb/dVRSd/S
         Fv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773164742; x=1773769542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NHHh7vDwNnkAVISaJtSOwNXhsrq0qAcj78Ek+80xUSs=;
        b=Qo+hxPr8C8E7JPHd7bsNMJTNWiuPp+73E9K5TnCmLM85lWkI30gyvvRJX59MI5iVdC
         Oj6y4iO/iaGYhresajuQly2Hj2SM+zlWCUt5t7Xf2Xp/aSGW5pAoyhFzS45Srgn/mJcA
         8JxvWY3DkQS6LtPhZ5hLc18+3o1Y+qBwvhUke3Z4fIikWOZfMVlVhHfhcCmCU4MB1iBU
         iykVoC8Y2mzYeanLIg1WDkWDPB1vuoXyWJ1u1GS5+VrKLutVif98Wap1cbUc7IPjz/F8
         sRIcXxiQ2K10/Jbl6MEj+SzHZNVIGoQJUHPf5ueHfIn9UZ7hhV6z4EUYJXjFwMVuQnVm
         nFLQ==
X-Gm-Message-State: AOJu0Yyz77r/AX7qrzBJ1fC8yzG6hWRTH+PCw1vrA6etZrSA3MUiXwUH
	JTdKyTHh3sfH3ruBPsj4vT+a1S5g0m2JHGte+0pnLmEL9anSAgk4k2X1mi9VjQ==
X-Gm-Gg: ATEYQzwy2sEr8xn5WY5wWtVeL0fKBSNUKhLh0OMmioAL0dbTagudU1T9zRaIv2eipYK
	dlxrwvNQLgkBaycmHBaQsG7DiFh1eTlYRNpJWGQGBRfDB+U6DR4RQTsGLJ+aE1Qy5PG2mgEgoyK
	xd12fGayo9BUy3Xd1Dsm4GWOXk9bFM5ndszLunbk4B8rA1zj2TJ2zkpZFCGM5Oizqh4xNrgkOjd
	wplFChTilV67NxEs57u8UtuLIR2oWZa9Mgm1GxcJ6SjNSH4bVqToo1luoAdU3RsV3Vgdvg9HvCF
	jA6lMXKaru9QPi59oU8l6Qh/CeehTz20AAi3IRtoOfNW4KsANwr4Kx4A62uiqMd8BpIFoyS/Cql
	t+Q9nO1nbYXrJBaqJBV9nOeZkcSpGAiYCENXNj5eGOWOw7NtNinClo3QbDeFRgqRG+TtkJO9rQz
	bj36IBUZDUgnvGspsA2xMv0PfBbqOYJ1SGLtgkkLCH/BeRN6PXcYgGFQ==
X-Received: by 2002:a05:6a00:983:b0:829:7e6d:cf20 with SMTP id d2e1a72fcca58-829a30dfcb6mr13381302b3a.58.1773164741556;
        Tue, 10 Mar 2026 10:45:41 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:2b10:af62:6ac0:52fa:9f8a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-829a48676besm13414023b3a.40.2026.03.10.10.45.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 10:45:41 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	christian.couder@gmail.com,
	karthik.188@gmail.com,
	jltobler@gmail.com,
	ayu.chandekar@gmail.com,
	siddharthasthana31@gmail.com,
	lucasseikioshiro@gmail.com,
	Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Subject: [GSOC][PATCH v2 1/2] editor: make editor_program local to editor.c
Date: Tue, 10 Mar 2026 23:10:48 +0530
Message-ID: <20260310174519.676851-2-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
References: <20260301105228.1738388-1-shreyanshpaliwalcmsmn@gmail.com>
 <20260310174519.676851-1-shreyanshpaliwalcmsmn@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

editor_program is a global variable defined in environment.c, which is set
by git_default_core_config(), but is used only by editor.c only in the
function git_editor().

Remove the global from the environment.c and localize it in editor.c.
Introduce a helper for setting the local editor_program variable by the
help of git_config_string(). Call this helper in the core.editor part of
the git_default_core_config().

This keeps the existing initialization timing and availability of the
variable, so invalid core.editor values are still reported early during
startup, causing no ux regression.

Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
---
 editor.c      | 8 ++++++++
 editor.h      | 2 ++
 environment.c | 5 ++---
 environment.h | 1 -
 4 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/editor.c b/editor.c
index fd174e6a03..b509d23f3b 100644
--- a/editor.c
+++ b/editor.c
@@ -18,6 +18,14 @@
 #define DEFAULT_EDITOR "vi"
 #endif

+static char *editor_program;
+
+int set_editor_program(const char *var, const char *value)
+{
+	FREE_AND_NULL(editor_program);
+	return git_config_string(&editor_program, var, value);
+}
+
 int is_terminal_dumb(void)
 {
 	const char *terminal = getenv("TERM");
diff --git a/editor.h b/editor.h
index f1c41df378..ced29046f8 100644
--- a/editor.h
+++ b/editor.h
@@ -8,6 +8,8 @@ const char *git_editor(void);
 const char *git_sequence_editor(void);
 int is_terminal_dumb(void);

+int set_editor_program(const char *var, const char *value);
+
 /**
  * Launch the user preferred editor to edit a file and fill the buffer
  * with the file's contents upon the user completing their editing. The
diff --git a/environment.c b/environment.c
index 0026eb2274..9aa9124328 100644
--- a/environment.c
+++ b/environment.c
@@ -37,6 +37,7 @@
 #include "setup.h"
 #include "ws.h"
 #include "write-or-die.h"
+#include "editor.h"

 static int pack_compression_seen;
 static int zlib_compression_seen;
@@ -61,7 +62,6 @@ int fsync_object_files = -1;
 int use_fsync = -1;
 enum fsync_method fsync_method = FSYNC_METHOD_DEFAULT;
 enum fsync_component fsync_components = FSYNC_COMPONENTS_DEFAULT;
-char *editor_program;
 char *askpass_program;
 char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
@@ -437,8 +437,7 @@ int git_default_core_config(const char *var, const char *value,
 	}

 	if (!strcmp(var, "core.editor")) {
-		FREE_AND_NULL(editor_program);
-		return git_config_string(&editor_program, var, value);
+		return set_editor_program(var, value);
 	}

 	if (!strcmp(var, "core.commentchar") ||
diff --git a/environment.h b/environment.h
index 27f657af04..053b678786 100644
--- a/environment.h
+++ b/environment.h
@@ -199,7 +199,6 @@ const char *get_commit_output_encoding(void);
 extern char *git_commit_encoding;
 extern char *git_log_output_encoding;

-extern char *editor_program;
 extern char *askpass_program;
 extern char *excludes_file;

--
2.53.0

