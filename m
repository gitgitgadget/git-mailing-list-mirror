Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C6D13EFEC
	for <git@vger.kernel.org>; Tue, 27 Feb 2024 14:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043602; cv=none; b=aE6Diu+PRmnNSy+Ik45ou7MMRDmIc6PbHfaVwdKL0mz3La5WQNAzOJxeWcE/Vx0WrMnAujkacoHf02fwTq17PwioNBDkpxtwPaZWadVhIppXbINX1e/f2U3P8z64hFb1M0WLKfd2tNpmgJfxs72+8e49OsOoUGRNUbbKSR2Svl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043602; c=relaxed/simple;
	bh=CoJ/+QyzIBYLgu4FOKZ4MSdJwVZc067kfddjiWWRUpU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R29SwwEG6rWJoLYwWbd2estI+zWzzdSRbXPVJZZvQUucE495pltjhxaMXftXHBZp2Ux6i8MT6YVKWzqCCccgEtwHoYiA5p5om8GJxn9vuPR3B4Rb2UIJ4X7y2PU6lkKOXXre9SukHycpZGjRdRzcmwsu8B9GlhMwjVL1OCXaY6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpRLOBht; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpRLOBht"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e706f50beso545864566b.0
        for <git@vger.kernel.org>; Tue, 27 Feb 2024 06:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709043599; x=1709648399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=mpRLOBhtZAdFOjp/oxzGGFcxtRugiw7NFWN1T4bSU9nmb7n84iNgSKFq2VO3u8UCjL
         RCaq7/8ZTcBo57cKbvp8qExulGNWDx4aHHoWrlaCNZsE26RMajd2xxRlClVcL/EmHTKl
         Xbczea4hKUEaJAUiBSiPZt5qTkX/c0KGWuu6HhPVX+Cv5QeOuCMbvvZoSK8FxrlMRyVS
         88bK7xyMCK/gEp90OoXNfktAJmDaK1TMTA9mMEdzioC9ImBLQXN45K+l1UAuvg1J/u89
         UXM3GFObocB2ajHt5e8Vv3fAhvY3nRMWuxRtj9U53oTIYPcPT3BIZxGEi++H59DXK/Q8
         pmfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709043599; x=1709648399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XOt9UhPXq6SgcwQO/EitepoMTQ60svZF5CFJfCiZEdU=;
        b=IE+9O4NrsMxRjw14s5khXw8hwpBF2nNfCeGTPW0VBXAzYBU8/Zyup4nyC79sDWGtpH
         O1FHE/8IY3oxGR48NAZ4Kj5yYFBUjO1R3UkS525UZCuGj7IfYUQO16+R6R5M0nH7fe6l
         rIbFd6Qo6lH7mxOHAlkMq2FtSGFYyd9sTnTI79rHfNVYTuK540VBQV6gw5XQqUZGUZVK
         xsCSV/ZN/CVTDQQPeChO+EfPJdtBW8zxNOxOO1Z60A7e4nK/gtt6P15PQ9LkKdXJvxSm
         XbnuJYGU29ebHrUIoaeUK1Q6qLXqRF3Vv5QONsm+K85KD61GG6Q896KsOqxVWg4SQJ7/
         WL7w==
X-Gm-Message-State: AOJu0Yy1C3tXvbwyOGkHpVeO8DKDY4ASY2yBgoJhqq62r3dFp+BDbLsK
	6qHFslvs7h5bTBJC+pLjZl/p92y4iND0IX5AvpYJoqzn613V/Vyf
X-Google-Smtp-Source: AGHT+IFnizml5Z5nwtipq3uJSYqHaLu1fsAfE9hEItAGY9oIEVo6SbA/xso8KeU6ATqlOHeYZl9e5A==
X-Received: by 2002:a17:906:27d4:b0:a3f:d71d:d820 with SMTP id k20-20020a17090627d400b00a3fd71dd820mr7214401ejc.26.1709043599180;
        Tue, 27 Feb 2024 06:19:59 -0800 (PST)
Received: from host-sergy.. ([154.72.153.222])
        by smtp.gmail.com with ESMTPSA id s24-20020a170906bc5800b00a3efa4e033asm805915ejv.151.2024.02.27.06.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Feb 2024 06:19:58 -0800 (PST)
From: Sergius Nyah <sergiusnyah@gmail.com>
X-Google-Original-From: Sergius Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
To: christian.couder@gmail.com,
	pk@pks.im
Cc: git@vger.kernel.org,
	Sergius Justus Chesami Nyah <74214119+Sergius-Nyah@users.noreply.github.com>
Subject: [PATCH 1/2] Subject: [GSOC][RFC PATCH 1/2] Add builtin patterns for JavaScript function detection in userdiff.
Date: Tue, 27 Feb 2024 15:19:46 +0100
Message-ID: <20240227141947.71447-2-74214119+Sergius-Nyah@users.noreply.github.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240227141947.71447-1-74214119+Sergius-Nyah@users.noreply.github.com>
References: <CANAnif-OganZLi0Cu_uq=nveC+u5n14c=o_DQHT-wFOqQ9Vs0Q@mail.gmail.com>
 <20240227141947.71447-1-74214119+Sergius-Nyah@users.noreply.github.com>
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

