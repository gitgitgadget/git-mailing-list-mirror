Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LffRNO7q"
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A359F2
	for <git@vger.kernel.org>; Sat,  2 Dec 2023 22:41:29 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-3332f1512e8so1999802f8f.2
        for <git@vger.kernel.org>; Sat, 02 Dec 2023 22:41:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701585687; x=1702190487; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N3TGCI/YCgWfYljSZYwF1mWsCWRqnsoG9BODzgV1+jA=;
        b=LffRNO7qPyP44cIxnKY5YxCI0ieuVQoJ0InISdM4bH0uyJPlVaO2N4yiC5T7Xzp86n
         o/1aNjygg6gnSE0PWbu4ocX9tUZ/AGOirhUgFAs4mD8U3Yq7Y4T7qW+s+NvfsdE+d95K
         MprK5yGhFASKav8eDnSoQozausiDMtHJJIWHmCXo+2RzF2XjF5xG+cWuyvKt5ijXkM1m
         IC+49nMV6r3wItvXPLwxTtGyHA3W9/UtmeB9sIlC7akFOGtVFjCW4SPCb9XUyMTemg6K
         BRvtLoKUOaCkLtHXSLP9jZg4cIx64fAsnCnb72dU+f9ZzjmUZypPSmIbBrqomWZF9ukN
         dNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701585687; x=1702190487;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N3TGCI/YCgWfYljSZYwF1mWsCWRqnsoG9BODzgV1+jA=;
        b=JVvctg2yeJY7E1ATZhnJ3dSuP4ZILrXb295bZOspqb4AE0Np6cvFtqAVdlxJA6PJyA
         7SQ/MTNyj4CzvzXSxgiSoJQaxLCM9uOrzhukoo6s9NztQHz+K1LuOTDHD/W58mPdyVD6
         YZNW0yTylTc4y/u+YiqzUpSvOdZVRAQWny9R4oTEaFOizibfhiHbOO0g5lwsQlTMyUQE
         no7mri6IL2ViaUaP4CD60J4SlqjPvpaecO0h04DGJ3i3Gpz3gLHDKPXO81vtex0P9+FG
         Pm7hBbg0BZq0AzBUIoBVNjFjFlCxglOA326rAS/uY/saKDnGU72IDJ8b9kzcAeIyjkf6
         OYZQ==
X-Gm-Message-State: AOJu0Yy+FjDBeQZoQYciVuEUVs02CQSlc5J6GcS4N93k+lqk39vKmSjH
	PohfM4yz4exTnKQnEcWalY6oMv6ZUZg=
X-Google-Smtp-Source: AGHT+IFVLdammyN+sTRPUDzQCkwJZl/llBQsAr1BuJbmUrZA5SoVWFjZ8ZHy2fowMhkYFqlPo7GcFQ==
X-Received: by 2002:a5d:4908:0:b0:332:fe4c:2204 with SMTP id x8-20020a5d4908000000b00332fe4c2204mr2043226wrq.50.1701585687206;
        Sat, 02 Dec 2023 22:41:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o14-20020a056000010e00b00333359b522dsm4130309wrx.77.2023.12.02.22.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Dec 2023 22:41:27 -0800 (PST)
Message-ID: <43222a4dac44a4b1f740d6c9737cb6a5f9c4ac49.1701585683.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
References: <pull.1617.git.1701585682.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 03 Dec 2023 06:41:12 +0000
Subject: [PATCH 03/12] archive.h: remove unnecessary include
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
 archive-tar.c | 1 +
 archive-zip.c | 1 +
 archive.c     | 1 +
 archive.h     | 1 -
 4 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/archive-tar.c b/archive-tar.c
index 07269968399..f2a0ed77523 100644
--- a/archive-tar.c
+++ b/archive-tar.c
@@ -9,6 +9,7 @@
 #include "tar.h"
 #include "archive.h"
 #include "object-store-ll.h"
+#include "strbuf.h"
 #include "streaming.h"
 #include "run-command.h"
 #include "write-or-die.h"
diff --git a/archive-zip.c b/archive-zip.c
index 7229e3e454f..fd1d3f816d3 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -10,6 +10,7 @@
 #include "streaming.h"
 #include "utf8.h"
 #include "object-store-ll.h"
+#include "strbuf.h"
 #include "userdiff.h"
 #include "write-or-die.h"
 #include "xdiff-interface.h"
diff --git a/archive.c b/archive.c
index 4562a69a0cc..50fd35bd27b 100644
--- a/archive.c
+++ b/archive.c
@@ -5,6 +5,7 @@
 #include "environment.h"
 #include "gettext.h"
 #include "hex.h"
+#include "object-name.h"
 #include "path.h"
 #include "pretty.h"
 #include "setup.h"
diff --git a/archive.h b/archive.h
index 3a4bdfbd078..bbe65ba0f90 100644
--- a/archive.h
+++ b/archive.h
@@ -1,7 +1,6 @@
 #ifndef ARCHIVE_H
 #define ARCHIVE_H
 
-#include "object-name.h"
 #include "pathspec.h"
 #include "string-list.h"
 
-- 
gitgitgadget

