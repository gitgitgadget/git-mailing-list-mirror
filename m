Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b8moxfwh"
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4FE0F3
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:29 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-3316d09c645so3297146f8f.0
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585687; x=1702190487; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKpv5ZFzjn3B1VgPJnotlQlSa+AAZOHqDH7ko024YjQ=;
        b=b8moxfwhTZ7w90KCnY1v4ABWpZHyNkUiIiAGTYfZjT+AUdERywoc3vInJ1IBSyEEft
         4SQl0QPwNrHZm1rCV7jp13nn0nPiO1QvGAlNjsmv0d0Fn81a2mM+qMPbnXYr8LeejUnh
         KwkoTzan8T7r58oFW/cxwjxx5F/tr2lspZGw73/2u/6wtwKndyvS4ymj+T+qWM18m7hA
         bpMrdXpUZMC++rhO6HDRrlt2Xmutej3a0W01qUwjOYcwJBSqZGElCkUWBI1iwCRIKiJ+
         n5TciSZg2oY8p4ZfEmrWNSHFDae6nhXve3CkDHIp8Efnro3XXyb87xQPXQfk/q+QUMm4
         c2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585687; x=1702190487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKpv5ZFzjn3B1VgPJnotlQlSa+AAZOHqDH7ko024YjQ=;
        b=um0lf79q8H5fhDwkL1Jcu2V1qDsPnZhsGwvVHvmpx1PZIZnxvnO0/tU1QYPCGMj8ZK
         7BJBl4F02VbbyH0MHNeugFzy6tqP1F8e4uCe31cjArgbboiSlu52TltO2isF7IAuJY5r
         DPL/9sWSBcEXcd+8oxFeq2vQPmaWSFoj1mVc8ZckhbyBxXcAu4EWUk1BiKjEK70MW3qr
         nm/LYIVbq9RxVc4Dq2byK81bKQdUF2lhBFmZEzHDw68O1ru9U28QqjlcQKwELkXTMHCk
         sccEg1sRgQdy6t3FpLZ3G1S3spiLiEY8FFrzWPd7TLiiJe0b6d5lWEvA0ftHczP48HGL
         n7dA==
X-Gm-Message-State: AOJu0YxBrufjgQ/qpbGC6YWsK74SlSTSSZP5Rwe8FG01q4zl1fdk/KZu
	hY/1DSEEqJywiC+bppC8jiNXh97YTbk=
X-Google-Smtp-Source: AGHT+IEj9S34jnkgUBr/WmiiHx3Y0zMxHqYhv1ipcNVHUn3NYR4W2uunMYOLwp16tfche8GORCbvnQ==
X-Received: by 2002:a5d:550f:0:b0:333:434b:5fb7 with SMTP id b15-20020a5d550f000000b00333434b5fb7mr208764wrv.66.1701585687638;
        Sat, 02 Dec 2023 22:41:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o13-20020a5d648d000000b00332e67d6564sm8451481wri.67.2023.12.02.22.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:27 -0800 (PST)
Message-ID: <bd69a954e9ada2822188bbfb8797fe198964adba.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:13 +0000
Subject: [PATCH 04/12] blame.h: remove unnecessary includes
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
 blame.c | 2 ++
 blame.h | 3 ---
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/blame.c b/blame.c
index 141756975bf..1a16d4eb6a5 100644
--- a/blame.c
+++ b/blame.c
@@ -3,6 +3,7 @@
 #include "object-store-ll.h"
 #include "cache-tree.h"
 #include "mergesort.h"
+#include "commit.h"
 #include "convert.h"
 #include "diff.h"
 #include "diffcore.h"
@@ -10,6 +11,7 @@
 #include "hex.h"
 #include "path.h"
 #include "read-cache.h"
+#include "revision.h"
 #include "setup.h"
 #include "tag.h"
 #include "trace2.h"
diff --git a/blame.h b/blame.h
index 31ddc85f19e..5b4e47d44c6 100644
--- a/blame.h
+++ b/blame.h
@@ -1,12 +1,9 @@
 #ifndef BLAME_H
 #define BLAME_H
 
-#include "commit.h"
 #include "oidset.h"
 #include "xdiff-interface.h"
-#include "revision.h"
 #include "prio-queue.h"
-#include "diff.h"
 
 #define PICKAXE_BLAME_MOVE		01
 #define PICKAXE_BLAME_COPY		02
-- 
gitgitgadget

