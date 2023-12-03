Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MiEc8Ns0"
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4ACBF2
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:33 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 5b1f17b1804b1-40b54261524so39329355e9.3
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585692; x=1702190492; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xSzRHp5BbQ8RHnANLkfpKqCzWCpWXu9TeHXFY5OAtwo=;
        b=MiEc8Ns0N3vFyuLnZ+Wbl/N0Gce08fC13NJ3mDX9+z4VuKmRjfWW7Gg62vVWUL3DEU
         yHdTFb5XiYvg3H1ue2lH8AdHjgVRHMcBSFx0S2/L8LaEKt+VwlGv3Z3TVmF9CRbNItXr
         5AIQZijLFpf3JcWkxBDdpp0JWOXmBSYDk7otatMGvEspF4QvCKx5TOtEePVVAi0LK2CO
         v6y4tuqnArrFwsC1eEufRHSey8j7QmSTwxhNoNoxcJRvs8shjfGaXyOG8SLkeE7aHQTF
         vAwcCgsRwI3jLnvKMCxA1+ae79Va6Dq1dlCcY8uDme79pLCd7Ui5/LmvCael1/stPFpC
         AU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585692; x=1702190492;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xSzRHp5BbQ8RHnANLkfpKqCzWCpWXu9TeHXFY5OAtwo=;
        b=TfQto+QpeA5e5SbCCu9p6Ajd362FYCgobGEFVtH7rrO01oTCX4W2gkXJvA5cZXyv1y
         8WVVNioiVikP3ATSGcQK5l3S0CDlvsWk2r9nXvc2zWIAk/jvp8cU/avQBM4L/bkJ8ZMB
         e6N0JcPt2F0H7fHl2G7z6N0bCXnyzSLYhGmzxt8Gfo7GotcoYx66RDoy5yUeFNpj9s7a
         tNKYh8p8/9VGewK2slSEH6hiE/NvDM+FEcBDKn1D8EmHIiYmj1FgG/YPPu9khJTjTngP
         IYSoGp7hVnmaCGrGXmqhy+N8EQ1m3lEBjAz32S0TSJErsmZ73XU/jSTSf50OtvnrnASZ
         qgVQ==
X-Gm-Message-State: AOJu0YyNYqRXFfxU6riAtkkJnxxgEnuGJ5CF7xBsZ31Mq+mnG9miwQhZ
	tySyIPrzcTLVmN0s6+CsL+BqeqBZ5NI=
X-Google-Smtp-Source: AGHT+IG6YVDBCanmQaBiN4CLvVD4Wug2iYYfchYVhQTEw/y9NrWTXUue7hnacrcyDka/F5D0Cql1Bg==
X-Received: by 2002:a1c:790c:0:b0:40b:5e21:dd48 with SMTP id l12-20020a1c790c000000b0040b5e21dd48mr220631wme.118.1701585692069;
        Sat, 02 Dec 2023 22:41:32 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020a5d6781000000b003333f9200d8sm2152539wru.84.2023.12.02.22.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:31 -0800 (PST)
Message-ID: <bc1fe09e996374868e8381a62ee5882df6b91223.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:17 +0000
Subject: [PATCH 08/12] pkt-line.h: remove unnecessary include
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
 pkt-line.c               | 1 +
 pkt-line.h               | 1 -
 t/helper/test-pkt-line.c | 1 +
 3 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/pkt-line.c b/pkt-line.c
index af83a19f4df..236dd3a3ee1 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -4,6 +4,7 @@
 #include "gettext.h"
 #include "hex.h"
 #include "run-command.h"
+#include "sideband.h"
 #include "trace.h"
 #include "write-or-die.h"
 
diff --git a/pkt-line.h b/pkt-line.h
index 954eec87197..aedef56286f 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -2,7 +2,6 @@
 #define PKTLINE_H
 
 #include "strbuf.h"
-#include "sideband.h"
 
 /*
  * Write a packetized stream, where each line is preceded by
diff --git a/t/helper/test-pkt-line.c b/t/helper/test-pkt-line.c
index f4d134a1452..77e99c37df0 100644
--- a/t/helper/test-pkt-line.c
+++ b/t/helper/test-pkt-line.c
@@ -1,6 +1,7 @@
 #include "git-compat-util.h"
 #include "test-tool.h"
 #include "pkt-line.h"
+#include "sideband.h"
 #include "write-or-die.h"
 
 static void pack_line(const char *line)
-- 
gitgitgadget

