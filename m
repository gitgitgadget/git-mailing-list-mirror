Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085F384A36
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908708; cv=none; b=ashpLPFzxSfcTlJ/i4vmkdEEtplviszaYV0n756DZwGPxS5zRjvxd2LloW7tgJ1FpKmvOoC4zIzNqHSCny0cdnHifEMqYN2iHzCcOgikf2C9SjloTU2BVhreuRRdB/2zHt+AwlLRGNvacEOK2tTa77nYa7sCORpyjQgdmPr3Pi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908708; c=relaxed/simple;
	bh=5kRCL4V729b8quYnJKI0+Df+kwq80J92hg+LTtDYv3U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=sNaHQdBzEE06Y5eLob7YKR7CaIyAjrhkkAT1CnCaObcTHCtTIhGlfQPak0+Uajd94Z/aiIaNCNJkHQkUApyWHXJo6v+qdV6VINhyXrGZpQ2s91Ci5DfVerSHHzr9wBdEM1NXBqxS5lzuS5GdZp2o+X7F9CgwJLKGse13ZplJ77Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFXmMEBC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFXmMEBC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-42cb1758e41so1848775e9.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908705; x=1728513505; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gus9vfMsihlP6iFjKOCpqVgpv9OdoHGGDwa3WhiFK2U=;
        b=LFXmMEBCTQ8ZmjdiSQSN+Xsm5qEE0JPo+3d31+H6WK9ircOcnSTNjPKFWwRVXvSda2
         zmLMUq1IyHsFCsnt6/9UvdgANNOXKWWPbNhb5HPkKnemjJl1mnMWjwx3G+CoJ9Q26Di3
         IfJE0K4kyOIfJCmlKEWjWg1kRzO5/9xa9epeMuZ84OPFpjjVcNfgKtWehUKHTcldrLLa
         gvmiBmMhqAF5Fz51Y+YAZFo12ue91AfnUYtf/aJrYYBT5GtTMA6arymfe9DYelH1SaPq
         a3oKrpXJnUsSyzEIhy9YOFiJWxsMUSfM7AcLUlWcZiJRV8sss2VaMN0gHBle8FB4Q354
         kgrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908705; x=1728513505;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gus9vfMsihlP6iFjKOCpqVgpv9OdoHGGDwa3WhiFK2U=;
        b=A8rZFnawkutWsrbHMFPf3TPaqp4T3q55gRzwgiutmepYzbYNkBoRauIF9Vch1s1ZYo
         CJko0BfJjO6XS0sbcRHORXalgaMehRaF80by4mFMxBFQQphA1JXcyfRqjoDDuSG/gPLD
         s8InbzAoRmhYLjgGaaPV0c4FNEEZjsAtX4gGo+qFJajDbCmQ3Oo1VNAXRfBN6N/TdqH8
         8JACxZRg4QNghzCKoz6hOWo4L2Y8S36MoyBcXkgn5kqtEndphaWuq9D9B0KCaTVa0o1D
         x03YSRLSdd1VsKQIGB8Bw1ET18wXVu3dej/+VcVP/+Grqpj8aJ4Gu2xwP8HtGxQ7jSb7
         fTxA==
X-Gm-Message-State: AOJu0YzYK/A5LVLl0D+RCySwC6U7/DZdo9LAgLvy6KUQqUb9f040JIEi
	odXFxwcjEEdssPhlSxb4zGTJFVskYNUHob4OCtLQk7sWw09qYxpcvFBaG5y2
X-Google-Smtp-Source: AGHT+IGllTLyWqQpFcr/AQzW95AH+ui9ElKA2uDZrj6GU9MHuXjz5x6JZ6fUPs/b+8bsXTs8cRkCmg==
X-Received: by 2002:a05:600c:1ca2:b0:429:e6bb:a436 with SMTP id 5b1f17b1804b1-42f777beb49mr32212675e9.9.1727908704476;
        Wed, 02 Oct 2024 15:38:24 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:24 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 1/5] trace2: fix typos
Date: Thu,  3 Oct 2024 01:38:12 +0300
Message-Id: <20241002223816.14858-2-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
References: <20241002223816.14858-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix typos in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 trace2/tr2_ctr.c | 2 +-
 trace2/tr2_tls.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/trace2/tr2_ctr.c b/trace2/tr2_ctr.c
index 036b643578..ee17bfa86b 100644
--- a/trace2/tr2_ctr.c
+++ b/trace2/tr2_ctr.c
@@ -4,7 +4,7 @@
 #include "trace2/tr2_ctr.h"
 
 /*
- * A global counter block to aggregrate values from the partial sums
+ * A global counter block to aggregate values from the partial sums
  * from each thread.
  */
 static struct tr2_counter_block final_counter_block; /* access under tr2tls_mutex */
diff --git a/trace2/tr2_tls.h b/trace2/tr2_tls.h
index 3dfe6557fc..3bdbf4d275 100644
--- a/trace2/tr2_tls.h
+++ b/trace2/tr2_tls.h
@@ -11,7 +11,7 @@
  */
 
 /*
- * Arbitry limit for thread names for column alignment.
+ * Arbitrary limit for thread names for column alignment.
  */
 #define TR2_MAX_THREAD_NAME (24)
 
-- 
2.39.5

