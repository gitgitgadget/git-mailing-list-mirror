Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CEA913F016
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043957; cv=none; b=qXWy/O4zOMH3xpqwhGN/F0CYOjyRNWfmObCKUY4tlr/nNfNBF7z7uEx6RblK3LlFJB/pLXXFHCT1Brsz2hbdyjEH0bA3weU7HggIotsgi/iByXbVRzfVdT1D/vN5G5XDJL41eXj6gtvhWNZ5bygG/IEOJAk8PLJVRh4+gWqkKqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043957; c=relaxed/simple;
	bh=CoJ/+QyzIBYLgu4FOKZ4MSdJwVZc067kfddjiWWRUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CH01d2rRE5ydVYczrSkFdi21wIN3pX5Aa1chpUztz9RjizJcW5KBqmXk15AcX8xAQKBqp9wcZ34WuUZmh+5Gg35wRwC1LynEQC5trV/VBNZnDVHVtZ2CTAAFpnVo1qY+jIPAbePn2cmUQyWQFjv4CtYA+ZHEV9FC9i5qUpN4YWQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ixH3tHFL; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ixH3tHFL"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-412af1c91f3so3569415e9.1
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043954; x=1709648754; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=ixH3tHFLK3m7vjhRyEi5Fp4ZwaOvTzNUkYdMpZDVlEu0Y+8dIrbtqhJIK1lYrp7aJH
         c4Ueemp7evNAnHxMRA5BaUpIdvWYlfk5x4x9oIKSwxosLBrYydlW7NhNenV319flitcD
         88h6SB3jBjLCqHLXsSH6UL1P623o5pXX4g+xe9sBzGz8JVQQh2oMjtLWkNJhejlRSgXS
         /IyHcUotSDSrW4dAr5Xmt6iU+zkA8PqTJD1ys0U6cHQ1HoNjQ5adTzoqHNdC1eDEjnbd
         hruDdjL2q2zo5xN3Iu2P2M/1RHaVrtff9p2HLg5sArRIWqHu8ds9D4cuV7h81CcdEhDz
         XyAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043954; x=1709648754;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=AEpIBABrndJjvVxGKgeEOSu708M33y07seghMCiOCDVV3efLmlfKLgqZGUbKNLa8G0
         vCQ9x1lwZjX6E/npymAViiLBET7WHpXL6Jc5kibHTlEg20o+8mYREy2cTClKJ+Xek+Ei
         1Y6udgXzFaQBLthb9iPwp/f6WUoBzrexc26MI1ZWYR8fDFi+nnJODjpTLWHoHpvRXUP9
         cP3bBrtdhYlXzsyvbTzLN610BoyaiZwQF+5mUPt8CDSaJdEJ4WiFrv7P4C82KGLROONm
         JIuVulB+1XkpqzaLS+icX6Q94rgOXUlXzgmlRrvHdIlLx1Cw8GMYH8nSo5Ebg7Kfi0f/
         p3TA==
X-Gm-Message-State: AOJu0YzN3zMdgQyHGwthc4JavFvMCSu+eEtK4tYjuuX3MR6/IwfQaYTL
	JvOgPf+3innXSJsyDE987s8fi4EF+5u/6wLAC9HckSxA6jfhqMoQLk469eDCwWZX4Q==
X-Google-Smtp-Source: AGHT+IHGJ0LOthGFh97aDej+zJhIP4NnK1g15FXLCmj4vtduvzN/A2ZemiOOH1Atn90DxOHWhZHE6Q==
X-Received: by 2002:a05:600c:3112:b0:40f:b0bf:6abf with SMTP id g18-20020a05600c311200b0040fb0bf6abfmr6985545wmo.17.1709043954377;
        Tue, 27 Feb 2024 06:25:54 -0800 (PST)
Received: from host-sergy.. ([154.72.153.213])
        by smtp.gmail.com with ESMTPSA id t17-20020a05600c451100b00412a2060d5esm8459255wmo.23.2024.02.27.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:25:54 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for JavaScript function detection in userdiff.
Date: Tue, 27 Feb 2024 15:25:38 +0100
Message-ID: <20240227142540.73972-2-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227142540.73972-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227142540.73972-1-74214119+Sergius-Nyah@users.noreply.github.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>

This patch adds the regular expression for detecting JavaScript functions and expressions in Git diffs. The pattern accurately identifies function declerations, expressions, and definitions inside blocks.
---
 userdiff.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/userdiff.c b/userdiff.c
index e399543823..12e31ff14d 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -1,7 +1,7 @@
 #include "git-compat-util.h"
 #include "config.h"
 #include "userdiff.h"
-#include "attr.h"
+#include "attr.h" 
 #include "strbuf.h"
 
 static struct userdiff_driver *drivers;
@@ -183,6 +183,19 @@ PATTERNS("java",
 	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
 	 "|[-+*/<>%&^|=!]="
 	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
+PATTERNS("javascript",
+     /* 
+	  * Looks for lines that start with optional whitespace, followed 
+	  * by 'function'* and any characters (for function declarations), 
+      * or valid JavaScript identifiers, equals sign '=', 'function' keyword
+	  * and any characters (for function expressions).
+      * Also considers functions defined inside blocks with '{...}'.
+	  */ 
+	 "^[ \t]*(function[ \t]*.*|[a-zA-Z_$][0-9a-zA-Z_$]*[ \t]*=[ \t]*function[ \t]*.*|(\\{[ \t]*)?)\n",
+     /* This pattern matches JavaScript identifiers */
+     "[a-zA-Z_$][0-9a-zA-Z_$]*"
+     "|[-+0-9.eE]+|0[xX][0-9a-fA-F]+" 
+     "|[-+*/<>%&^|=!:]=|--|\\+\\+|<<=?|>>=?|&&|\\|\\|"), 
 PATTERNS("kotlin",
 	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
 	 /* -- */
@@ -192,7 +205,7 @@ PATTERNS("kotlin",
 	 /* integers and floats */
 	 "|[0-9][0-9_]*([.][0-9_]*)?([Ee][-+]?[0-9]+)?[fFlLuU]*"
 	 /* floating point numbers beginning with decimal point */
-	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]?"
+	 "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+ )?[fFlLuU]?"
 	 /* unary and binary operators */
 	 "|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|[?:.][.:]"),
 PATTERNS("markdown",
-- 
2.43.2

