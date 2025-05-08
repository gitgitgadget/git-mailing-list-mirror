Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3E44B1E6D
	for <git@vger.kernel.org>; Thu,  8 May 2025 13:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746711588; cv=none; b=BlPNUiS4eGO173bc/2fqYi1iuyJLj8j92tHxxz1vxgO3zlnHhEXqNLNx/+Wd/j5YmwNfOps/5PmBR1tVxxTEeGPTtjM7a4EodTKHEy7RIpWTkmCoUQjpuVe/MrRPyq6TxFL6glLoWBgBHEhjOziJI6YYoa3mMkV680+ESaVo5Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746711588; c=relaxed/simple;
	bh=RrTIQgjcQezfVSNqLq7ZrKfbknwaDK559NIfi1qDou0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=s3FtQWBgIimSUCgdLmH3eSH/DJiY6motBzHGse1tTC2FbA55h6LHoGPrYzs5UeN91pfrtrOa1cFV/qx2T1wbpEKi+5tkFt9O4vBaMvdNl/Q/nF9LGoEmGqrhcV3lAOW3OJpmFGjASVsoTFs09htiT405uIBW4U9WarV3F9bF2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FqsAZHyW; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FqsAZHyW"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-441ab63a415so10380375e9.3
        for <git@vger.kernel.org>; Thu, 08 May 2025 06:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746711584; x=1747316384; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=WJvm7F7FCWMkUu8MNBogTOzceZDoSK7n0fbfJNuFts4=;
        b=FqsAZHyWAR8dN+n4fG2hDP6ZMjF7q7aW9i/SHdlk0sl2ivCrwuuJYSEY0T1ZUJBFn5
         416E0RAKPhVDF/prSzYIj7JhWDj9kB5Dj2VkOPthnumcHjJiJ6C6V7HyuLP2mpf1usfy
         ITVR3c2VKpT5+RKZfqrq7GOwzXygxXjMvBFY3RTRDYw2ce+9i7r2GBn3Bdvr8AmWUfe8
         nk6bcHrf7B95/lfHRV5rcrxBVaic4HVN6liT/PfhGr5WIdcUd0oPD+5RK0k+jQbm/iLU
         Cnnak17/jcQ5kZEgeLHgx2e8dFJFHRzCHbg/atTg3nOMLkxBmNXBxy+Uu/9ZSM+WeSuJ
         3pbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746711584; x=1747316384;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WJvm7F7FCWMkUu8MNBogTOzceZDoSK7n0fbfJNuFts4=;
        b=r/6u2BKQ4cnhUYbbb8J0Jci0qMQni7biu1+bsK3soe1ub2CkDY0tmowaiJiFoyhlmE
         ctWjSHFxxtzw6HbnSNbr9sF7eQLqQGvG05MwjorqCPD6Kyl9WE6gOqe0+B65p8m3BqaV
         uPSb3yrVHPgDXBd8ETKd/T98TWddKsH1UpE+Nj3ozzTrs8LqhK5bm0hFt4ZVeWOmC59s
         hEj3WRiTh/6OOuNGOrWGhz1WGwKRowd1GOXZV1AwRSAazs/1zsCPvGzbaR812gRyhJks
         KkklViz53DdWKeDwmzVFOaEwsngabq6H5X2EUJjkgO3squ63bNf5dLIe/oj8sM1FXfCK
         nsgg==
X-Gm-Message-State: AOJu0Yzq5MfSSNjInnoEw1LZAWrWW4h7iKO1jTzLXP0ryCOr0S8l3sqm
	RD5AUM2HAMqbC30+KBv0WLp0X6VYpULU0rEhwzztrp9luDrFtgcuNojVPw==
X-Gm-Gg: ASbGncvXFsiZKL2QTzKXw7lo3Hmo6vUTx9CMbFVmTM8eE+TKmUi33y0P2is58Ai3Vx+
	1ljLV24GQ8C9Khb6hG46tUA1rHeAS3pO1iX00DC0UX2wxq9KNZGVDkb4ZmgQyFNWtCnaBH27rrV
	faPFZLHLk1wPzaKUCPS1ufxP3TmC0FHffjQvor2lm3/rZw4268O7nqMIULj1gqwurz7froQnB69
	1bLWuCUZ3cFcZrHwxzyC8vNf+4A+QN+fU3MiVjZCwtUboF9vp+PL/7Ap5uXSl6CDJBc6xKznPP4
	jg4YIa6xEJbhzp2i9JaW66qOH+iRrbLJEBwLk9AXxQ==
X-Google-Smtp-Source: AGHT+IE1iOLpapeezOLksguioyI77tSkR1+4o5+ZWqtZUSOSNItM32Qc5VFFTjcc2LFLJB+ExqnS5w==
X-Received: by 2002:a5d:5f86:0:b0:3a0:b979:4e7c with SMTP id ffacd0b85a97d-3a0b9794e9cmr3169523f8f.3.1746711584057;
        Thu, 08 May 2025 06:39:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a0af3255afsm8458559f8f.66.2025.05.08.06.39.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 May 2025 06:39:43 -0700 (PDT)
Message-Id: <pull.1955.git.git.1746711583166.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 08 May 2025 13:39:43 +0000
Subject: [PATCH] REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc
 failed
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
Cc: Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
failed. This leak can be fixed by add a free(x) before set x to NULL.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc failed
    
    REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
    failed. This leak can be fixed by add a free(x) before set x to NULL.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1955%2Fbrandb97%2Ffix-REFTABLE-REALLOC-leak-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1955/brandb97/fix-REFTABLE-REALLOC-leak-v1
Pull-Request: https://github.com/git/git/pull/1955

 reftable/basics.h | 28 ++++++++++++++++++++--------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index d8888c12629..c7651f0cda8 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -200,14 +200,26 @@ static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
 		} \
 	} while (0)
 #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
-#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
-		size_t alloc_size; \
-		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
-			errno = ENOMEM; \
-			(x) = NULL; \
-		} else { \
-			(x) = reftable_realloc((x), alloc_size); \
-		} \
+#define REFTABLE_REALLOC_ARRAY(x, alloc)                                      \
+	do {                                                                  \
+		size_t alloc_size;                                            \
+		void *new_p;                                                  \
+		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < \
+		    0) {                                                      \
+			goto cleanup;                                         \
+		} else {                                                      \
+			new_p = reftable_realloc((x), alloc_size);            \
+			if (!new_p) {                                         \
+				goto cleanup;                                 \
+			}                                                     \
+			(x) = new_p;                                          \
+		}                                                             \
+		break;                                                        \
+	cleanup:                                                              \
+		if (x)                                                        \
+			free(x);                                              \
+		errno = ENOMEM;                                               \
+		(x) = NULL;                                                   \
 	} while (0)
 
 static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
