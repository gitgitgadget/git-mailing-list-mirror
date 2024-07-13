Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C11051448DC
	for <git@vger.kernel.org>; Sat, 13 Jul 2024 21:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720904913; cv=none; b=o2/oLrxUuRZYWVKp97pj4tctl7L43CDgNfJaoi2UMu7frR4Th9Aw3LyDJ1gJ26FddG1L6NarNiyYngJLOnvSSUy0QtyUYd8ue56YefustLazkJfIS0+k/OLl/kh5iz8TmXHmFnLwurx7qPaXCoQT8MvzVOFKhsdQdjs0FYqGYEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720904913; c=relaxed/simple;
	bh=SSXWLOtFLA49xGelkQoShQtMLAJnv1L6G9J5dfCKfzI=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=Xq6YfbxM6uQoHDHPEHc3syjah330JUEEdWx3XbzlKe3mR2Zhkn9/itDSWskKVCzHwZBDSRNmHDtiiTqlQxoSLq7XmhTS3n/sLGxXBMGOlAXMKRzI1vtwlXB8pyfqRTWFbz5uJYqXro4I8lipsCqBxNByEDXmzJFhNPAYw672Q/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gibmiCHQ; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gibmiCHQ"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4266dc7591fso21200485e9.0
        for <git@vger.kernel.org>; Sat, 13 Jul 2024 14:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720904909; x=1721509709; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o+KoE7ACa4NLm9SmoicvJ3gvk7Uiwb/D8yBVlIBGtQs=;
        b=gibmiCHQYDEGikbm8du5TrgUrBDpftH8XcerjE1Eo8WYt1St113VvsspupS37XMVuw
         wlc5vJSlhjTmnvek2ZZ+pui5YiSoTohDP3xT9UYGErbf4pgNBL76aP3LevYolYgWpRmh
         9M1Q1f60VyHoio4mOaYQCgL1bhyHQKPPWw29ftthImsaw2kSjmwXSR3VLeiyau0zj+Ad
         j8pId7bx3ZQoYS/AzVkaDPsHg6kr5dCKPTCk2ZAKwSxc4gOOFKbs03OdoyfEmceELBUY
         HbefXlpwzWWw9x5OKLndqgFVLWxs676GSbnflsCE1mKnMOwHuKn1b+q2qRK8o/DL3tym
         Rg8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720904909; x=1721509709;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o+KoE7ACa4NLm9SmoicvJ3gvk7Uiwb/D8yBVlIBGtQs=;
        b=OuLqXF+wXb5Trs/K4fK/yqvkITlwlm/jDoKYB/QBDeThitvUVOJPFyAFJ9X+HjllBY
         u+9KsKupSlSYUlJ/FWQx9qUU0argbvZxB3KXL/qRifri3JWjoO12Y1OedY2aoy23pURo
         tZkGdnlGta94+ZUy4qTr4800LVXFIJSxwPBvSeR5OGIqXLoP0aEr/KaXRsw0HQEVhYsd
         a3IlIerQef2suZCPLX6zX0CGUP6UMDVGD2qi1olfaXiOPCViV+a5mlClmfMu1KLEsQGe
         hsLPT8EMUPUxJqcUytOv/x+LzdErM8KNRINCVs50hMcL4khGcUWFXpIn7WFPQiY/YYDk
         zaWw==
X-Gm-Message-State: AOJu0YzYXG22n7ix7eBidjnqgaszHpavWK+5LNwMPOiD2VEGU4I0zeUB
	P75UXsX2FSiAc/8i7v+6PCRxp4Ct5vRv9j3wijLtj8AF2rPkByqtRWEH+g==
X-Google-Smtp-Source: AGHT+IEJFUx9lJUwymL7MEJ9t3sYnSHIXYRth3LpAjRdzx9awaZTbteTGMCIrh44hsF+xwDKCb7CnA==
X-Received: by 2002:a5d:5f88:0:b0:367:8847:5bf4 with SMTP id ffacd0b85a97d-367cea46d6emr13362733f8f.10.1720904909401;
        Sat, 13 Jul 2024 14:08:29 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4279f2cc21esm67492595e9.31.2024.07.13.14.08.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jul 2024 14:08:28 -0700 (PDT)
Message-Id: <f46315ac0b24879283846682878139641203d4ae.1720904905.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
References: <pull.1760.v2.git.1720739496.gitgitgadget@gmail.com>
	<pull.1760.v3.git.1720904905.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sat, 13 Jul 2024 21:08:20 +0000
Subject: [PATCH v3 3/7] win32: override `fspathcmp()` with a directory
 separator-aware version
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
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

On Windows, the backslash is the directory separator, even if the
forward slash can be used, too, at least since Windows NT.

This means that the paths `a/b` and `a\b` are equivalent, and
`fspathcmp()` needs to be made aware of that fact.

Note that we have to override both `fspathcmp()` and `fspathncmp()`, and
the former cannot be a mere pre-processor constant that transforms calls
to `fspathcmp(a, b)` into `fspathncmp(a, b, (size_t)-1)` because the
function `report_collided_checkout()` in `unpack-trees.c` wants to
assign `list.cmp = fspathcmp`.

Also note that `fspatheq()` does _not_ need to be overridden because it
calls `fspathcmp()` internally.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/win32/path-utils.c | 37 +++++++++++++++++++++++++++++++++++++
 compat/win32/path-utils.h |  4 ++++
 dir.c                     |  4 ++--
 dir.h                     |  4 ++--
 git-compat-util.h         |  8 ++++++++
 5 files changed, 53 insertions(+), 4 deletions(-)

diff --git a/compat/win32/path-utils.c b/compat/win32/path-utils.c
index ebf2f12eb66..b658ca3f811 100644
--- a/compat/win32/path-utils.c
+++ b/compat/win32/path-utils.c
@@ -1,4 +1,5 @@
 #include "../../git-compat-util.h"
+#include "../../environment.h"
 
 int win32_has_dos_drive_prefix(const char *path)
 {
@@ -50,3 +51,39 @@ int win32_offset_1st_component(const char *path)
 
 	return pos + is_dir_sep(*pos) - path;
 }
+
+int win32_fspathncmp(const char *a, const char *b, size_t count)
+{
+	int diff;
+
+	for (;;) {
+		if (!count--)
+			return 0;
+		if (!*a)
+			return *b ? -1 : 0;
+		if (!*b)
+			return +1;
+
+		if (is_dir_sep(*a)) {
+			if (!is_dir_sep(*b))
+				return -1;
+			a++;
+			b++;
+			continue;
+		} else if (is_dir_sep(*b))
+			return +1;
+
+		diff = ignore_case ?
+			(unsigned char)tolower(*a) - (int)(unsigned char)tolower(*b) :
+			(unsigned char)*a - (int)(unsigned char)*b;
+		if (diff)
+			return diff;
+		a++;
+		b++;
+	}
+}
+
+int win32_fspathcmp(const char *a, const char *b)
+{
+	return win32_fspathncmp(a, b, (size_t)-1);
+}
diff --git a/compat/win32/path-utils.h b/compat/win32/path-utils.h
index 65fa3b9263a..a561c700e75 100644
--- a/compat/win32/path-utils.h
+++ b/compat/win32/path-utils.h
@@ -29,5 +29,9 @@ static inline int win32_has_dir_sep(const char *path)
 #define has_dir_sep(path) win32_has_dir_sep(path)
 int win32_offset_1st_component(const char *path);
 #define offset_1st_component win32_offset_1st_component
+int win32_fspathcmp(const char *a, const char *b);
+#define fspathcmp win32_fspathcmp
+int win32_fspathncmp(const char *a, const char *b, size_t count);
+#define fspathncmp win32_fspathncmp
 
 #endif
diff --git a/dir.c b/dir.c
index b7a6625ebda..5a23376bdae 100644
--- a/dir.c
+++ b/dir.c
@@ -95,7 +95,7 @@ int count_slashes(const char *s)
 	return cnt;
 }
 
-int fspathcmp(const char *a, const char *b)
+int git_fspathcmp(const char *a, const char *b)
 {
 	return ignore_case ? strcasecmp(a, b) : strcmp(a, b);
 }
@@ -105,7 +105,7 @@ int fspatheq(const char *a, const char *b)
 	return !fspathcmp(a, b);
 }
 
-int fspathncmp(const char *a, const char *b, size_t count)
+int git_fspathncmp(const char *a, const char *b, size_t count)
 {
 	return ignore_case ? strncasecmp(a, b, count) : strncmp(a, b, count);
 }
diff --git a/dir.h b/dir.h
index 69a76d8bdd3..a3a2f00f5d9 100644
--- a/dir.h
+++ b/dir.h
@@ -541,9 +541,9 @@ int remove_dir_recursively(struct strbuf *path, int flag);
  */
 int remove_path(const char *path);
 
-int fspathcmp(const char *a, const char *b);
+int git_fspathcmp(const char *a, const char *b);
 int fspatheq(const char *a, const char *b);
-int fspathncmp(const char *a, const char *b, size_t count);
+int git_fspathncmp(const char *a, const char *b, size_t count);
 unsigned int fspathhash(const char *str);
 
 /*
diff --git a/git-compat-util.h b/git-compat-util.h
index ca7678a379d..71b4d23f038 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -506,6 +506,14 @@ static inline int git_offset_1st_component(const char *path)
 #define offset_1st_component git_offset_1st_component
 #endif
 
+#ifndef fspathcmp
+#define fspathcmp git_fspathcmp
+#endif
+
+#ifndef fspathncmp
+#define fspathncmp git_fspathncmp
+#endif
+
 #ifndef is_valid_path
 #define is_valid_path(path) 1
 #endif
-- 
gitgitgadget

