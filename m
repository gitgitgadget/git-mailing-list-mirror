Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8432D12F5
	for <git@vger.kernel.org>; Thu,  9 Oct 2025 07:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759995971; cv=none; b=dkHAQAuvcq+qBzjgTzjP5btM4/bkVV47VsIBpgPjYpbxvGtV6i+zlMW3Za0478RtZR9XFJuY1v+Qhi9zVfo1MksmfZUM+BsUHjFOGX/aEmNjxGE0l/1o7Xtr5pdsFrfSXQn0/sfh8dCwIRWCZJc2tmh5Ii0u5bpfNr9YYfRxoA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759995971; c=relaxed/simple;
	bh=PgmdkJTzM09p6ogyBArizoajE92hkqHMqYrknpycNbc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=PGFvsdCphGWkalsHSsoSxt4YXBlWNZGbcbEQCcrgxnnv0R4aZhMvAJGOZOYgiO/7sRGzvfh4jGt+qdd9CuPcbtKVO8a+wFe7pvZQ+3UN8eXjEELB/8mL9jPoMZzyZjG16l1IaBnsPD3sZDcaQdZu4X99vg6mcL6N3kjUBhWeAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GvVsWhke; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GvVsWhke"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-42f95010871so690795ab.2
        for <git@vger.kernel.org>; Thu, 09 Oct 2025 00:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759995967; x=1760600767; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+3kUncL/VwIsZcCGKpsKDMCtDcC1ek7zjlM74D8Neo=;
        b=GvVsWhke5VflTbYQlnM3gaCedHutLw8KvRZX518+i9MOQwuaUWF/a3gs72pEKXYhk0
         KJaq9LlOe4Wj+t5n9MTynDWk7qCj0G1oWyWWPnNWYpoAcLv+EMh7dgW9Nkw9ke7jbkSE
         S4SaKASTlcMR9ssHOa6xHQBEJxqkJHDA5Fb1K7Tz1ZjPCWdLta7Q+PrRmePZGkFraJe3
         GlBp6nFwHmK33sscThpJwcVc3LGzvMr5nAh1ay2EyIctqDcA7/sVl6iFY/AmXZWHoiJR
         yVcuYro00DzGu4nCJvTd7VVdPgLq8THOOa4/QnuuNhSMyQB4sp+rSzVjSvOU4d5YiVcF
         m3PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759995967; x=1760600767;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+3kUncL/VwIsZcCGKpsKDMCtDcC1ek7zjlM74D8Neo=;
        b=WbFZx64QYzkyACEjJ0zLv+S8ayCAiJV68RXmavjKfq+ZAqhxzDELk+5ZYhiB5BCPCr
         Ng/fTJj4ttYXfTdn8RWjGU+eDupv2mtGFBX8cPPQWqaM8OHpGEAkzuQmICR2NNPVPMnl
         azmBFFs9yIqD86xkLpOOJ2CCwpc0Y0Fi725BJ5E43LG8ZD+udkTyLL3sBSeGlk14/LcN
         fPZI1H+fvYpQCpbSGSQXikJ8zZ39MUiGv1i4RQ5dXy/xupKfNnHOHa0u57BxHBVhu1Qo
         NckiImLczq/RpidAimQiL3y4WQzr+MsuHIe3esH+FJ/fGgnZqCEXzcj8hJ3RjzPaVFl+
         TQWA==
X-Gm-Message-State: AOJu0Yz2a/g7ROpdlnH50P/WUs4enmUsvpHCgfFcdnCBPrGBI+Ym8uqf
	PKqncJPONfc3V0kXktxd9AN/vc72ugmP/L6dyJTTPiIYH7Dku1MEdN9SIUOUwQ==
X-Gm-Gg: ASbGnculmRU5AeHJe+6XScm+HUtSbgCnXcjr8EOdXq2Ek7n/ZCawqLkBYsuTSsXMgOq
	GVuyh8lyyZCGic4kRrnzQN6NU4B12hiNZeEk1Btu9jbbFvrl0prc98J4jAzXp2ozHpR8SaLKEuV
	/Xmfw+Ir2VRB5p+9pU7fiNHwRVBc/zFX2Hms80kUWeARbwEA8Cg8zFm1oeAtUYG48RZubQv1iJs
	BqMkttkmRM1EdsaMLYi6fXdWe5TapAAsSYMzGNlvW60+hp+u62kYVkBc1C5tOekPpTTLYAQ16gL
	zUPyJyPSFuJ4nafqCrmJe4HDBNZ1J3ZYObEdYBZ25IU7Htcus4VLhwddkJkb98Ua1fLw5G77zd8
	ZV2EBV1HONo2Ym7ywYYVVErtUN5AIrPRCguINySOuKk6IzVF7zQ==
X-Google-Smtp-Source: AGHT+IGUxqSk0S8rF6NnEasfvk1fVMtu6X3iHv3zRUmLFEV9zm139J1KIJwuorlrEUVBCuMXTgyN2Q==
X-Received: by 2002:a05:6e02:1a22:b0:424:bec:4a01 with SMTP id e9e14a558f8ab-42f873d6985mr53329805ab.16.1759995966669;
        Thu, 09 Oct 2025 00:46:06 -0700 (PDT)
Received: from [127.0.0.1] ([135.232.201.67])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-42f90346b89sm8021065ab.23.2025.10.09.00.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 00:46:05 -0700 (PDT)
Message-Id: <484ef8b825e5d1d68a61f0f8cc2520457e8f4f3a.1759995961.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
References: <pull.1985.git.1759995961.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 09 Oct 2025 07:46:00 +0000
Subject: [PATCH 1/2] mingw: avoid relative `#include`s
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We want to make them relative to the top-level directory.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 compat/mingw.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/compat/mingw.c b/compat/mingw.c
index 8538e3d172..da99473f56 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1,22 +1,22 @@
 #define USE_THE_REPOSITORY_VARIABLE
 #define DISABLE_SIGN_COMPARE_WARNINGS
 
-#include "../git-compat-util.h"
+#include "git-compat-util.h"
 #include "win32.h"
 #include <aclapi.h>
 #include <sddl.h>
 #include <conio.h>
 #include <wchar.h>
-#include "../strbuf.h"
-#include "../run-command.h"
-#include "../abspath.h"
-#include "../alloc.h"
+#include "strbuf.h"
+#include "run-command.h"
+#include "abspath.h"
+#include "alloc.h"
 #include "win32/lazyload.h"
-#include "../config.h"
-#include "../environment.h"
-#include "../trace2.h"
-#include "../symlinks.h"
-#include "../wrapper.h"
+#include "config.h"
+#include "environment.h"
+#include "trace2.h"
+#include "symlinks.h"
+#include "wrapper.h"
 #include "dir.h"
 #include "gettext.h"
 #define SECURITY_WIN32
-- 
gitgitgadget

