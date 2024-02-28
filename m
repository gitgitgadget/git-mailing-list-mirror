Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77D0242064
	for <git@vger.kernel.org>; Wed, 28 Feb 2024 15:00:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709132448; cv=none; b=FSMQeOXkbP7YrJ+8JRQQvLVufCSOczwTpC0hSmf+pCuhAE7ZcdrohfYKQ/u+Z8r755Z0OsDATbNgoOujt7LIbIMWYRS6e9l9IHI6ybWc8LDL211uKYlZAHCEN284m1ihpNZnwBliHm3B80KozL1DF8do0z3GbJ76Zh9/OReXxA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709132448; c=relaxed/simple;
	bh=U03A2rfZ0fybT3pYTuLmVR4PiBDfYYB+MAlQGRlZYvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KOBNy1kzZ/3kxu/i96d9vxYXS7UqxLY6V/QZd+Xhxdsr5NrfZ83ZodcLUBcMsPb+ffluS0aNdJDZfyccoWckbS4wleQt5OvEENiPftvHWSq9xD4BFi8dCWnyn9rYi1kekZxRR32HCQiaNkteoAIkqMNQ1pVBlN+Vds9eZQ8TfGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cxu03Zam; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cxu03Zam"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-33de6da5565so1574338f8f.2
        for <git@vger.kernel.org>; Wed, 28 Feb 2024 07:00:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709132444; x=1709737244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=naB3bWPwHADsAmkXWJRgVdr2Spuff5rmNhlLjik3S00=;
        b=Cxu03ZamoVvMae9T+LIzOBm5JZvcBJ50Py3LtzMq6zrTzf7InNm4dwjUL4j4Ys8ICe
         0OxGPDZthGpBf/awr3KB6JzgdUXBXxHcQpV0cHllYVfCZYh3HYd1uA1O2sNUAjo1lzVG
         8yqOGL/C9g7u8Weqdy6xPJSZJY/10oCFcf+5QLM6Jxler11zA5p9kso5rGxDC+XlLUpm
         diDQtbN6YqpBuxLXXlWgfOSr8u7MGZ+fulXxKMeq3wcHj77hT04sb9udqDHfqKSZrnNo
         lMSUS94S+HFucCoUuBQA1QEv03xgKbuEdOgsoDwDZLlUEZDvpWaSHh3h9dtSlw8CXXWk
         YIEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709132444; x=1709737244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=naB3bWPwHADsAmkXWJRgVdr2Spuff5rmNhlLjik3S00=;
        b=oki29nLB486ecFBBam9m6FXUA3a1PFoHI3B01R9H7OoxkEnVezeMPvNeTqoRqM37uH
         4XUvLcYAJYnAYnrqqiIR6rmRMcNHUoW17OQZvnrEkp4JEV2K6pe6gIo/tjBv/x2spdeW
         o3xkcG/p/+/J5EpEm1ZxFQT0suxwbaZlaE7yz3Y1IcXLi1J20PC45pRh+sTUlo4PJQGz
         snaxJpfswuivUH3y6cA0geLnRTCduIsiaoTatVR/odTj2IdhMXVjBMo8swHTpa25WbnK
         iKpzAJLVQTY1q0hcrpjdkVqxx4RqlDjz28mjhaOrC1uIaGKnXO0sYBjiqoMBcMFQ04dw
         uWYw==
X-Gm-Message-State: AOJu0YxUGlhrbw8Tq9yYK1etwv3qFItC3EaLi3VBrBvC3Dq9bV+3jgkR
	atqlT9TTl+KKkYn+pdBHIWmUFalRTnlKHTZIzfnKcrWLcZocHoly9/63olgZc3BfKQ==
X-Google-Smtp-Source: AGHT+IF1pKGx2RXPmqh+LquHf+OhrE/TnTnFRQQjRA/ClkUA99sCVigEpXt8/imXbrm9uKhFb9DJLA==
X-Received: by 2002:adf:fd08:0:b0:33d:2474:afd1 with SMTP id e8-20020adffd08000000b0033d2474afd1mr8087199wrr.20.1709132441574;
        Wed, 28 Feb 2024 07:00:41 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id ay25-20020a5d6f19000000b0033da430f286sm15244034wrb.69.2024.02.28.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Feb 2024 07:00:41 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: git@vger.kernel.org,
	christian.couder@gmail.com
Cc: pk@pks.im,
	shyamthakkar001@gmail.com,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [GSOC][PATCH] Userdiff: add builtin patterns for JavaScript.
Date: Wed, 28 Feb 2024 16:00:34 +0100
Message-ID: <20240228150034.313196-1-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This commit introduces builtin patterns for JavaScript in userdiff and adds a new test
case in t4018-diff-funcname.sh to verify the enhanced JavaScript function detection in Git diffs.
Signed-off-by: Sergius Justus Chesami Nyah <sergiusnyah@gmail.com>
---
...-PATCH-1-2-Add-builtin-patterns-for-.patch | 53 ++++++-------------
t/t4018-diff-funcname.sh                      | 25 ++++++++-
2 files changed, 38 insertions(+), 40 deletions(-)

diff --git a/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch b/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch
index 43593866bc..9c3b80665e 100644
--- a/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch
+++ b/Pattern/0001-Subject-GSOC-RFC-PATCH-1-2-Add-builtin-patterns-for-.patch
-This patch adds the regular expression for detecting JavaScript functions and expressions in Git diffs. The pattern accurately identifies function declerations, expressions, and definitions inside blocks.
----
+This patch adds the regular expression for detecting JavaScript functions and expressions in Git diffs.
userdiff.c | 17 +++++++++++++++--
1 file changed, 15 insertions(+), 2 deletions(-)

@@ -18,40 +16,19 @@ index e399543823..12e31ff14d 100644
#include "git-compat-util.h"
#include "config.h"
#include "userdiff.h"
#include "strbuf.h"

+PATTERNS("javascript",
-+     /*
++      * Looks for lines that start with optional whitespace, followed
++      * by 'function'* and any characters (for function declarations),
++      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
+       * and any characters (for function expressions).
++      * Also considers functions defined inside blocks with '{...}'.
++      */
+      "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
-+     /* This pattern matches JavaScript identifiers */
-+     "[a-zA-Z_$][0-9a-zA-Z_$]*"
-+     "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+"
-+     "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"),

Here is the test file.

-test_done
+test_expect_success 'identify builtin patterns in Javascript' '
+    # setup
+    echo "function myFunction() { return true; }" > test.js &&
+    echo "var myVar = function() { return false; }" >> test.js &&
+    git add test.js &&
+    git commit -m "add test.js" &&
+
+    # modify the file
+    echo "function myFunction() { return false; }" > test.js &&
+    echo "var myVar = function() { return true; }" >> test.js &&
+
+    # command under test
+    git diff >output &&
+
+    # check results
+    test_i18ngrep "function myFunction() { return true; }" output &&
+    test_i18ngrep "function myFunction() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return false; }" output &&
+    test_i18ngrep "var myVar = function() { return true; }" output
+'
+
+test_done
--
2.43.2
