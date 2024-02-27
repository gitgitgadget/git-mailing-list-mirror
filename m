Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04C2B13B2B8
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:21:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043697; cv=none; b=h5iSeARmITDSIrkY1cb2Q91QDfjmdtjxJ6RWuNv5djoaIO39ViAAJl9bmI6nydjBBJeblWV4Wt4h1r4P7fwXDrCwPuAuDeGfK41nUmerEwj5UOhlpccPrCbiyVR6JQrigUXh94xwLnhDJPaPWPLQrDSm4NBcCmuMO465asQVsgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043697; c=relaxed/simple;
	bh=CoJ/+QyzIBYLgu4FOKZ4MSdJwVZc067kfddjiWWRUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MdrC5JPLOmev9baK5oyzmHrX+glYni7c/bxop1ZhdCopANMvkJe1zWMrysdG4wXirnWUH+bQf2aV1CrBw8fL7hY9bOkc+9CfUdwi3IiJBXHnzEHSmDefti9mip26RtvyPioXVHvF8J9/Gi999ZLEP56XDMMaPynDgayi8XpyUpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KPzcTgJg; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KPzcTgJg"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a3e5d82ad86so607453766b.2
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043694; x=1709648494; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=KPzcTgJg7ii5k+xXg7VZ+NHmsP+aTgOU2vvkjnCVkSv2sTerQxzWJ2CK5UiRYZcNZm
         3DW083HLGZdpkLd7M05veL12eNAdipMt0gH7yQ6nb4UxHhnOEr0X4TmQRrZydm3R5M/L
         agw1MHYBONQFH3eHVb32EESxBjRQA23LJJWhpnaA42NAB8gwb4vEX4iaaZGWHR3UE9AQ
         rHzKzcOVasakYSNPhqlnH0Paf0HKgUnkBb+UgKCIf9LWR2V1SPUz5rUDevqT4EHxvm/c
         eX9s8A96SKPpMdjDr0nScCYF++PJ8VJhbFjzYkBGQBswTOawSth+/w3HdnaRgSTfEOd5
         mgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043694; x=1709648494;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=grCfzhOPtJgdxZjO/mbN9hRWrKaBfEruuuNfqQZrE3NaYY5ru9tab9WD64wRQ5OoTQ
         2EyTf0OPo68SonwBC79coZ02mO/eeeZPyruJsArZoKyPr1qbJKRgpx7MaCOnJeC/r33r
         E3Gmf+YdcrBffQMYtH++5+rtZZXChbdOYU3H3dIliZyFKGl95Czl/xHANhFVg0Muap5b
         SAASnu2IzUqxL56+QRoftLRDwCRz8U7z05l4eHMaRJ+CNMO8h5rSpvSbGw7esVHd8zzb
         EJMWi7I1UIj8zQFVr27Ey6TIktK1HPJc4AJMgexEMsfzWn4oCtn3kkOKowiO6/eiu7BN
         Qbgw==
X-Gm-Message-State: AOJu0YwJlUqlEWMeWGQj33whkrPvijLD5p1rouLnBLxKdqfQkTWRWeuI
	F4mN9Wk6NPlKow0ITWLAshgla9B/+T3j2CcODfJWwDUVI6XqoMCa
X-Google-Smtp-Source: AGHT+IFt8T5PzyUi25EvFoQv34XcPqN5xIxEsJAquWtBts1Zh39U6M3Acp7X4jJP+touTKTusoGN5w==
X-Received: by 2002:a17:906:f894:b0:a3e:72ca:700d with SMTP id lg20-20020a170906f89400b00a3e72ca700dmr6500196ejb.45.1709043694216;
        Tue, 27 Feb 2024 06:21:34 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id lh11-20020a170906f8cb00b00a3fb62260e3sm810127ejb.72.2024.02.27.06.21.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:21:33 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for JavaScript function detection in userdiff.
Date: Tue, 27 Feb 2024 15:21:20 +0100
Message-ID: <20240227142121.72518-2-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227142121.72518-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227142121.72518-1-74214119+Sergius-Nyah@users.noreply.github.com>
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

