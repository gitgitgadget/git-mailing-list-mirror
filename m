Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0898F218EB1
	for <git@vger.kernel.org>; Fri,  9 May 2025 07:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746776693; cv=none; b=VZi8kPYlTPgdxVQ0/+D8XOOHpvg6wqROBw09Ddj7qymptUUfkdeZ39WfwoIiwUYXumfoFZr3avyRawwlTPqd91+P9f5Zv4geyqnNQO9hLxgxXl25fbfsUNteeEJExhs5OAbUQBlCvbkJuV++TQROHkkERuvndJA9sOkszwsTVdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746776693; c=relaxed/simple;
	bh=2UVtIaPApmYpWu2vWUqTsP8hbuqmrLhphSlr8fK1dzk=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=rxTCutjCNjGnkT6p53JQlFv5YPE4XAqDEXgvYUXjBN859ImOfHd2+6Xe23W7bT0BsF55CL44jCygox11jxKsRjvUHOTVFaqUkYLqniKB+JfYx+a6/muoTmI/oiLDCy3jh0jKPywMQYIeV9yQq4nYMJ/u4wXl+QOwxk+2p97VGdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mKOCX4N+; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mKOCX4N+"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-3a0bdcd7357so1228250f8f.1
        for <git@vger.kernel.org>; Fri, 09 May 2025 00:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746776689; x=1747381489; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a+TxgxnQBrR+znPMSUoHpRaDnzgIzfNXpKsUF25lFuE=;
        b=mKOCX4N+dpDdHGFMGa/B1VPCDBTOFWwKssCBesh+SiK9mQSP1s8E5dE3w2/7rE8Ojl
         qx2+i7WHYZoCJPzYGNsjO9vf8BbvXzuI5t4wE8m/yY8mblYMFnKZKFMv8Ehx8U7IEjMC
         7iomTCDmR1FY9USDqZDjWFF56CDsD4jUyxbxUV1KgtcNk7V6dKWKzIZj/GtHW/Qw0BcN
         Qhgxyaq+RjtUh4TnudDEiPbhxOPOI43Z9X8nYxH20x1QwgP25o1jmfkwsYrhZTDySRwA
         VznkRovRE3aEjHjigEx6Df1lNGpbd5a73NLCR+Xc4jBvv4LKikypSu5y+RKL/Oh/BAhJ
         9+Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746776689; x=1747381489;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a+TxgxnQBrR+znPMSUoHpRaDnzgIzfNXpKsUF25lFuE=;
        b=qgkOES7W+WXHlyDTLlPMcti9z8QlT6BgQoy7CqtUxCR2BdEyvDGKSdPkfwvaZg4xE1
         OYUm0tGETiBZsUqfCZK/ewMNCdRkfGmklGcJ8EW7vf1n8fFq7iYkSRYC6DTUu4tUdXjD
         Nhb9t57fMkk1eSS6kS8Mp8DSxFDU6oB8oXfFBS0W3yVM+BPX0bmBD7o41vWMoI/hBSS0
         zdS8/RJzfdNjiEHqDeWegIq+uGsP7Z7RaS/2Tr3lRy4/tf3up16f3Q+reYbmMRQzBy9s
         hNimqHnaXaQFuWu9OBlGtXDTzZuyZ+eF9YZC1NoClRq2pQFLf63TS9crcNcfjvj/cQv+
         V/Qg==
X-Gm-Message-State: AOJu0YynD3V57+HnqbyFNAqhvhyUcPIBb47JfBF8xQgg3AHHze20RX9f
	lM5er4OF/lW71d12QigApDguXO0x/JkQDhN4fC/hIPnYKqGI1jojcZJwJA==
X-Gm-Gg: ASbGnctiHUm+MwhhMPOavaQERWD3ECJ3Qano9eJxX9HM4FN61QkUf7aM/0lLV+olaM3
	IAGRx3xRRkfSh/pgyhd0FTyB190kLuq281/Div+dv4UGFJpqk4tJwk7R1/iiwBtJv0u+y9jWVB7
	mDwJzXaSzi91Ng57zmJqT1BlY8Q09RM+Sj4WghUJM5vi5cueEZz6kkqka4ux1Dt6lBP7geTr2BM
	7jXRCvB1+gaIXUhb2LvdUMDIth4jmj4X9DnLJUagcubApVtLDiMiCXCMEZhSVbt8M99Ii0poE28
	KiOOz8M8eY5mPyWKknRkBHoUKiDqd889vH1fhCdLqA==
X-Google-Smtp-Source: AGHT+IGMJG/LiIhL2333KaOoCkR0qRZKB62cioEQ+/pjXwckNdezsOwMD8JTizj+43vHZvE7aagodw==
X-Received: by 2002:a05:6000:2485:b0:3a0:92a3:24bf with SMTP id ffacd0b85a97d-3a1f646b392mr1646736f8f.30.1746776689307;
        Fri, 09 May 2025 00:44:49 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a1f58f2af7sm2434949f8f.52.2025.05.09.00.44.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 May 2025 00:44:48 -0700 (PDT)
Message-Id: <pull.1955.v3.git.git.1746776686718.gitgitgadget@gmail.com>
In-Reply-To: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
References: <pull.1955.v2.git.git.1746756263207.gitgitgadget@gmail.com>
From: "Lidong Yan via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 07:44:46 +0000
Subject: [PATCH v3] REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused
 macro
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
Cc: =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Patrick Steinhardt <ps@pks.im>,
    Lidong Yan <502024330056@smail.nju.edu.cn>,
    Lidong Yan <502024330056@smail.nju.edu.cn>

From: Lidong Yan <502024330056@smail.nju.edu.cn>

REFTABLE_REALLOC_ARRAY will cause memory leak if realloc failed.
Since it is unused, remove this unsafe macro.

Signed-off-by: Lidong Yan <502024330056@smail.nju.edu.cn>
---
    REFTABLE_REALLOC_ARRAY: fix potential memory leak if realloc failed
    
    REFTABLE_REALLOC_ARRAY doesn't free origin pointer when reftable_realloc
    failed. This leak can be fixed by add a free(x) before set x to NULL.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1955%2Fbrandb97%2Ffix-REFTABLE-REALLOC-leak-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1955/brandb97/fix-REFTABLE-REALLOC-leak-v3
Pull-Request: https://github.com/git/git/pull/1955

Range-diff vs v2:

 1:  6cc191f9db8 ! 1:  107f9ce3bd0 REFTABLE_REALLOC_ARRAY: remove this unsafe yet unused macro
     @@ Commit message
      
       ## reftable/basics.h ##
      @@ reftable/basics.h: static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
     - 			(x) = reftable_malloc(alloc_size); \
       		} \
       	} while (0)
     --#define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
     + #define REFTABLE_CALLOC_ARRAY(x, alloc) (x) = reftable_calloc((alloc), sizeof(*(x)))
      -#define REFTABLE_REALLOC_ARRAY(x, alloc) do { \
      -		size_t alloc_size; \
      -		if (reftable_alloc_size(sizeof(*(x)), (alloc), &alloc_size) < 0) { \
     @@ reftable/basics.h: static inline int reftable_alloc_size(size_t nelem, size_t el
      -			(x) = reftable_realloc((x), alloc_size); \
      -		} \
      -	} while (0)
     -+#define REFTABLE_CALLOC_ARRAY(x, alloc) \
     -+	(x) = reftable_calloc((alloc), sizeof(*(x)))
       
       static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
       					size_t *allocp)


 reftable/basics.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/reftable/basics.h b/reftable/basics.h
index d8888c12629..1674a6f8b80 100644
--- a/reftable/basics.h
+++ b/reftable/basics.h
@@ -200,15 +200,6 @@ static inline int reftable_alloc_size(size_t nelem, size_t elsize, size_t *out)
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
-	} while (0)
 
 static inline void *reftable_alloc_grow(void *p, size_t nelem, size_t elsize,
 					size_t *allocp)

base-commit: 6f84262c44a89851c3ae5a6e4c1a9d06b2068d75
-- 
gitgitgadget
