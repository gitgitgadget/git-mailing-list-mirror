Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jtrKTGHm"
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EA81F3
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:34 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-40c032962c5so12940765e9.3
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585693; x=1702190493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wI1ud4HLkaVcpZYdQynYi6SrOVU+12fz4PaoZLJWSmg=;
        b=jtrKTGHmKAGh0dEBuhxXHaPOKgUiTbt8fw4CE16YOJyXVj+MnXHYrMVMvvq+f97N8X
         TrdcxllY7okEcZQZ29YfyZiK0M4mZJAQKr/eirVCP36pnHR+ZOq3JqfwG8bQdhCzgZ+G
         GMayI1g4JEFcHqiC0Zzku8mA2+X523+8k0OwN4PPKJyJX2uEENzdaAu49oceB1Swg2nn
         ZVlwZa66TLaF5Z9TQ6KML3fXL4MmuLIlcSfy9Zy6sqDJ1PdRPXse4E5WvAugyE+gdSM+
         2og22LM6383OZXOafwq5Urf3e9Syktcw02gov5A6VwDRXfGB8ebctzUugfQ3nKC6Vubx
         pw5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585693; x=1702190493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wI1ud4HLkaVcpZYdQynYi6SrOVU+12fz4PaoZLJWSmg=;
        b=U+AbHPAES/dV31LvKmZjBw8bzRmOWer48vn1CLAW/B1gpuEfNKpvTIJhGu4/i+Luxn
         EOQAMJ8HgXUe3s65oaIXMlJMVg41KhO32PA0HFsXX6EMEHqfs4wiP8Il/WXeit8euV1Z
         VUR4Uo+LC1Wt3iUDTsh/iD0PN29vRvVCVBocW5OAUSFtIaA2XLCvtG0zcz39QY3Zqzh2
         1/c1O3dSioCxLaK/qofCcBF/nXARj6Tnfwqxv71aspRWvDWGcsv+2uK7c+LdKc7grWld
         Rb8+Fno6W1mYx+xZgskMDVfMgk+9nop4+KeB+w2iSoBcM8GKGJsEiMQ6EI2Rm34J9EGW
         K22Q==
X-Gm-Message-State: AOJu0YzkN0Arjonls+6p2LHJ/zMtMkHFHFQIwdX7unnIZuYAl88ljZ5Z
	8rPgpKRMcKOPZ4Phxp4H5OCBLmukFMY=
X-Google-Smtp-Source: AGHT+IF1hg4pLPHpvWoPJrN4Io9SvC382AtQUE7ghCNUw6KRz9iL3iKLJ8kvbxxITmACx8Lj46hSAA==
X-Received: by 2002:a05:600c:35d3:b0:405:3d41:5646 with SMTP id r19-20020a05600c35d300b004053d415646mr1086304wmq.2.1701585692678;
        Sat, 02 Dec 2023 22:41:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w3-20020a05600c474300b0040b36050f1bsm10723143wmo.44.2023.12.02.22.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:32 -0800 (PST)
Message-ID: <6d25811965cb55f7044e98ea020da2516664ad35.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:18 +0000
Subject: [PATCH 09/12] submodule-config.h: remove unnecessary include
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

The unnecessary include in the header transitively pulled in some
other headers actually needed by source files, though.  Have those
source files explicitly include the headers they need.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 submodule-config.h        | 1 -
 t/helper/test-submodule.c | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/submodule-config.h b/submodule-config.h
index e8164cca3e4..958f320ac6c 100644
--- a/submodule-config.h
+++ b/submodule-config.h
@@ -3,7 +3,6 @@
 
 #include "config.h"
 #include "submodule.h"
-#include "strbuf.h"
 #include "tree-walk.h"
 
 /**
diff --git a/t/helper/test-submodule.c b/t/helper/test-submodule.c
index 356e0a26c5a..50c154d0370 100644
--- a/t/helper/test-submodule.c
+++ b/t/helper/test-submodule.c
@@ -4,6 +4,7 @@
 #include "remote.h"
 #include "repository.h"
 #include "setup.h"
+#include "strbuf.h"
 #include "submodule-config.h"
 #include "submodule.h"
 
-- 
gitgitgadget

