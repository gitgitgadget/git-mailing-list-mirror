Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XXaYizWH"
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C9CDE6
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:35 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-3316a4bc37dso3264403f8f.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585693; x=1702190493; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oCWixEfH4TB7v+wqSA2k0k7641XZv4vbXlQI8FYdHFA=;
        b=XXaYizWHXjbSvX2vYHRxudHJEHTS61CLKElqF6W6bTjjWYYoHTC/60jp2v1a7z2kHW
         xentPHygjh0Kob/jn4GuM6aJcgR8RPd9pneW0H8K+TY4PQIAJyoXk5/Vy+sDlBQEit1r
         mnwW0/ekRnGnYeH6ki4uaMYkAuHQQHo/LJlnJ4hORBn+lygtVl8rxsLNSqVDk/vxQ/nf
         fBc85NM5DuCDA2bZ/T/Feh/xEj7Q4h7xXBjM+GobHtAkR4qMnzSv6sPB5aZPx7+ZHkA2
         l6QPGsYWMJRw5H+ZBe/67lXlfj9rHWh/b0GyQXg/Adl2WHBipBe03ud6edpVO7S2s6yv
         FZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585693; x=1702190493;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oCWixEfH4TB7v+wqSA2k0k7641XZv4vbXlQI8FYdHFA=;
        b=JhQCjRCUASAMM2K0g7NMuwICqrr2FhJK8vNBfV6FYEpu3bWI4fgH84G5gbQg24KheW
         2XCCOF/2i56kB8GSS8FfPms4gyq8S6Ft27SKNYujnjq0qqQv7KyMYhADynJAlNEVIid4
         3BouAh2kX3ptOLol8qWEd72hwGhgPcE7LDAcKDW7rMQoKsqd+tMjlsblEufLxQVEqHkM
         Nvqn1c1fgAxCzgtJAlgOa736wzQFJRlX9e5o2bpZAb6mGkyx7B225SJIW2HtFqQwo/He
         BtLVe+J9Y5JDZThKUq7HEdya63eykY8ysHswCwQKYgqLPnT7YNuypsy7zPBL8OLhfUFk
         aWJA==
X-Gm-Message-State: AOJu0Yzn1LV6ZBTGd4hz/cDeJi8SLY3KrsCQ9kRhEJ8pd7x10dOyUOuo
	3Gi5Im9VUw8p0hkOdjawMriyYqy0sF4=
X-Google-Smtp-Source: AGHT+IFVEwczJ/YS/RTD2HCu8S5ub6QUS34oBH15UsMt6zjFidZNP3VTOUM3b6/VgNyGy3tNeDK0pw==
X-Received: by 2002:a05:600c:2048:b0:40b:5e21:cc4a with SMTP id p8-20020a05600c204800b0040b5e21cc4amr1390272wmg.117.1701585693341;
        Sat, 02 Dec 2023 22:41:33 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h15-20020a05600c314f00b004083a105f27sm14210488wmo.26.2023.12.02.22.41.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:33 -0800 (PST)
Message-ID: <72fd5e2941fd77c9da29d97fcfee248ed2afb06d.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:19 +0000
Subject: [PATCH 10/12] trace2/tr2_tls.h: remove unnecessary include
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
 trace2/tr2_tgt_normal.c | 1 +
 trace2/tr2_tls.c        | 1 +
 trace2/tr2_tls.h        | 1 -
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/trace2/tr2_tgt_normal.c b/trace2/tr2_tgt_normal.c
index 38d5ebddf65..baef48aa698 100644
--- a/trace2/tr2_tgt_normal.c
+++ b/trace2/tr2_tgt_normal.c
@@ -2,6 +2,7 @@
 #include "config.h"
 #include "repository.h"
 #include "run-command.h"
+#include "strbuf.h"
 #include "quote.h"
 #include "version.h"
 #include "trace2/tr2_dst.h"
diff --git a/trace2/tr2_tls.c b/trace2/tr2_tls.c
index 601c9e5036f..4f75392952b 100644
--- a/trace2/tr2_tls.c
+++ b/trace2/tr2_tls.c
@@ -1,4 +1,5 @@
 #include "git-compat-util.h"
+#include "strbuf.h"
 #include "thread-utils.h"
 #include "trace.h"
 #include "trace2/tr2_tls.h"
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index f9049805d4d..3dfe6557fc4 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -1,7 +1,6 @@
 #ifndef TR2_TLS_H
 #define TR2_TLS_H
 
-#include "strbuf.h"
 #include "trace2/tr2_ctr.h"
 #include "trace2/tr2_tmr.h"
 
-- 
gitgitgadget

