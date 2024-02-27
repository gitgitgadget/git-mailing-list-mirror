Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E30535AE
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 16:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709049788; cv=none; b=VRdOhDcgEXno2002ST6NIrHBCXo79Ektq2zcA5usadXqYnWKQaD0x3UhGY015IqTM3jl/6lkjw8ani/NeIpLQ/iOejNgg7LKLMMPILtMLInQAMSIVCU7eLd0Da5nV3++TH0Oko6yP25xYDxmkcLd505lo4SpsmKzb/dU7JOihmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709049788; c=relaxed/simple;
	bh=k0Mc46DnWHUAIS8GHynMptZz3uiwlY5VidaTXn1IkZw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MjBfTdvmTxDSOTOr12DWySjj1ZDdUOyW1Zl6eq74rRMWjFhoUcKgVYY61wKaOo80PKB88eo4z/1mQvf7BcIHboglqaRXUkL1+7YFzEOVqlk+74i2tYyIiXS6gPx4e/Ul6qRAD1Hrcwt3r36gQK1ZswPDZU7NOEdBX++YHot0H3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gZprDHGv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gZprDHGv"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-412a9e9c776so7826915e9.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 08:03:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709049785; x=1709654585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUAQ5Vm6Lh5Ods16TuV6PfrUiAhO5cmoXWkppP4UWn0=;
        b=gZprDHGv/T5N1ebq6J28IWGA4w7tBEsxFRbJcxeev6VVV1USjxj0pVUqU0mYIVNhKo
         g+LwHXm+9nImAGHX9uzZUs44j/nOASUk+UJKt/mZs433lz+PZcPEwMn43n7yGON3qqwa
         cGgznmlAhMCI9amyBypuKPIjA7+pj65RJo1vp+0byVvwTSqysA05xj4o7NPUYdeeEj8i
         SxvgsO2Nw92azm4938S9Of94mzP+a6hH54Kf+NHLsi8Jd6HzLFWExVr8rK7DtuU9sPLI
         dGoDE8kAiZoAcEXKcl0AX8Xf2iG1NdMOKBrwv3OqsyFK5Xb0nfTVqKYF3v9o+YANuO1A
         QEIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709049785; x=1709654585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUAQ5Vm6Lh5Ods16TuV6PfrUiAhO5cmoXWkppP4UWn0=;
        b=CJNxxYzbgvpEbQBEubIcfSsUo3r4WAP6ixWogbTYpxe5zGusqpzghX186phodbhUlp
         yHsKUgnp4C1kpKhNWnDotgFmXs33dghplUpI78dgTsQTh4DZmmCnoCqM6sASTB9pmfQ6
         QimddtFuz+HnG+wFBWzLKF9DS1tDHrYFVWB1vhCfYcbmU2B/C3ZwM0brp5AY9tmEOQ+U
         7Dkkgl7RPeSVk38KmUhuma1WTXg+QW4Qv40rd3Pz+w6KJxCC7T63Qg8OGEKAR1xmL8bb
         EiHXNWVvd03neL5uJxECkRhVpWCPrlakKSjPNLYTe2Oqfec72E858ksmx/9EflBLqYGS
         gK5Q==
X-Gm-Message-State: AOJu0YwKXK9hRh/kQkAI2lofBsjwd4B6/pTTVa6kpK09NQr3OBNDQXnh
	EvX/FuglY+MtlfDm2w3MsqTOE7OzYEK8C0BkZjGh/op9OC/k+aIJkyOeQ9Vw0jQ=
X-Google-Smtp-Source: AGHT+IEwzhN96HQ9XcGDEdZHAj19VO3RvtGQ5QkSQfj1WijfYSwbpfsnYB6OuQ+lWnoM5sxNB4zEUg==
X-Received: by 2002:a5d:5650:0:b0:33d:eb13:9e27 with SMTP id j16-20020a5d5650000000b0033deb139e27mr2549220wrw.23.1709049785171;
        Tue, 27 Feb 2024 08:03:05 -0800 (PST)
Received: from host-sergy.. ([154.72.153.219])
        by smtp.gmail.com with ESMTPSA id a2-20020a5d5702000000b0033ce5b3390esm11714323wrv.38.2024.02.27.08.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 08:03:04 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Nyah <sergiusnyah@gmail.com>
Subject: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for JavaScript function detection in userdiff.
Date: Tue, 27 Feb 2024 17:02:52 +0100
Message-ID: <20240227160253.104011-2-sergiusnyah@gmail.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227160253.104011-1-sergiusnyah@gmail.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227160253.104011-1-sergiusnyah@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
:wq


