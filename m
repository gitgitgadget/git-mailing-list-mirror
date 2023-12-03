Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gWgHkTrs"
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0ACB4E6
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:32 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-40b479ec4a3so33866865e9.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585690; x=1702190490; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ttkeYFSt4eNhwg/B0nagXg282CBMg4rUewvl4yzbtls=;
        b=gWgHkTrsvq7Ae5OlmuC8pTXbEhfWhkU+788+1ll7MmRBdKcN5Cd4ZntBcp8KF6t5ki
         uHPVw1gsikN1SYm8VO+p8+pWvi1LgLSIbttSBGR2V4NBV2rs/3p/gaXHlSrKyvn2zQaP
         Pa4cxbyFx9FzLk/zOQLhCfphoE0Z6M4bDObOnm26S/11qu/begH1ufbjy9Bh13GlBQZW
         k5ui/nXneI4PfRPQSqyizjHYfLVjxnrLVGhhkaxAw9svEob2LRlF9pgqaJT8EUZ0tuAH
         rQa/bgdSyPIWenA5XdWNAzX391FBi7GuWBaITaHjsPYeUDZrQVcHHwcGt3G5/1qvGbl+
         ZbLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585690; x=1702190490;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ttkeYFSt4eNhwg/B0nagXg282CBMg4rUewvl4yzbtls=;
        b=KRoYeJGqVjhAfnmT6lvavPB+Lw5aDz5TtPgT+h417i78JdfX7h5NRyNbc34Zs4w8PE
         dnaDkBEmQ/Kz5bNWXszI06egFXsJL0CBJMjWVcQlAFXXLw4i4KKndF2459qIoUdPBmSS
         iTfd6g5tEbLP7x6cxNu4r6MI+baaUWrCV5/C6IHn9QeNkLK6w43ZD03jYtfIAoTN3RRf
         76Pj5y4Ok/hJ/XKENYwLG1LyvhKA5xz7W9l/mfyzLQa0gEj5WU++v7tgDiv8fcJCKgje
         dOAdhgN6jWq2g5k6QK8mSmKJCyFFpOEvypsk9a0iZowNmPHfBn7Y4IUTlO/lX0i9sSIv
         DBsA==
X-Gm-Message-State: AOJu0Yy2Ah5dgZdwIoW3Fp653PwwGYq8l3BNkZHYr9Qxoutic4kU8geh
	7wuDFrMzRF9BCNXap0JWdg/N1G6sGJI=
X-Google-Smtp-Source: AGHT+IHFlPG6Gqte7/UfudynU5PGhK/BnLPM/pUJiX6hWUC0OlCubD7ITqACmYQy+ijL2aulGqWBXQ==
X-Received: by 2002:a05:600c:1914:b0:40b:5e1b:549f with SMTP id j20-20020a05600c191400b0040b5e1b549fmr1959175wmq.43.1701585689770;
        Sat, 02 Dec 2023 22:41:29 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z3-20020a05600c0a0300b0040839fcb217sm10957989wmp.8.2023.12.02.22.41.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:29 -0800 (PST)
Message-ID: <393c5ca3a1dc26fb56a0ef54c010930ba33d546c.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:15 +0000
Subject: [PATCH 06/12] http.h: remove unnecessary include
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
 http-fetch.c  | 1 +
 http-push.c   | 1 +
 http.h        | 1 -
 remote-curl.c | 1 +
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/http-fetch.c b/http-fetch.c
index 93695a440ad..bec94988bbe 100644
--- a/http-fetch.c
+++ b/http-fetch.c
@@ -6,6 +6,7 @@
 #include "walker.h"
 #include "setup.h"
 #include "strvec.h"
+#include "url.h"
 #include "urlmatch.h"
 #include "trace2.h"
 
diff --git a/http-push.c b/http-push.c
index 329513270c8..b4d0b2a6aa3 100644
--- a/http-push.c
+++ b/http-push.c
@@ -15,6 +15,7 @@
 #include "strvec.h"
 #include "tree.h"
 #include "tree-walk.h"
+#include "url.h"
 #include "packfile.h"
 #include "object-store-ll.h"
 #include "commit-reach.h"
diff --git a/http.h b/http.h
index 3a409bccd4e..3af19a8bf53 100644
--- a/http.h
+++ b/http.h
@@ -10,7 +10,6 @@ struct packed_git;
 
 #include "strbuf.h"
 #include "remote.h"
-#include "url.h"
 
 #define DEFAULT_MAX_REQUESTS 5
 
diff --git a/remote-curl.c b/remote-curl.c
index 204feebabe4..55eefa70f97 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -21,6 +21,7 @@
 #include "quote.h"
 #include "trace2.h"
 #include "transport.h"
+#include "url.h"
 #include "write-or-die.h"
 
 static struct remote *remote;
-- 
gitgitgadget

