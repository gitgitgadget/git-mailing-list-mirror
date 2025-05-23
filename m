Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D033F1DE4D3
	for <git@vger.kernel.org>; Fri, 23 May 2025 20:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748033507; cv=none; b=fYCIILq+YSBoZVeJk8qrcZMB1YDSZxoyA6Wt78FAQenFl5FNX0vY8xYU/jDWOTJppBPkInZUEug8uCwASLc97y3VN+7actjL0Zi/2qDW7AO9bWAuTEgWYPqGWkF7kAbAvQSY/m6PY2q1JyRPrg38SXtIu9FlWVwQCm0GeObU1TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748033507; c=relaxed/simple;
	bh=pit+Y/Y/ZrFDXtK0TpnEe69DLkqZqGMe356TCVTMif0=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=rvMtTmHyIzTwGvQdkwiVEudm32RX1QmZxmdodaB0RkORB3Wfbfu6g9+ISXu2cHblzP32Mm+cHqAlKqRnmEWEXf7gMyFI2miTJdU8eRbhBO1wF04ekAqXttcj0BzKIoBG62vNo9YRnlW2lczCIpmZI39ezbr/EfVbBS2HKkHGkZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PNhhm8so; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PNhhm8so"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3a3771c0f8cso208278f8f.3
        for <git@vger.kernel.org>; Fri, 23 May 2025 13:51:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748033503; x=1748638303; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yCQ9SE3Js2TcEWdD6/nkxAK1t6kl6eJ0qaCIAp53gUM=;
        b=PNhhm8soYuzvKokUoBVp0Lw8eJpIjld/HrK8w4fp5emJ68NQl55rEqevBBiWwqeI7Y
         pq546j4G83jljaRa0QggytYPG4N4LtJcTOBZBo5dPoa2LUoQXlnfU02KKgWqGkzoIwKY
         xjQCbGxdgOANZP9YOMQIwe3x4/6eYH+GrYBicQe08n3XF44mfnuuh8o8Nl6dUjG+evpT
         H1PB0XITX/l94wqzw2efZ4MQNTqpO/Q9dM/oF5cH6DZUiRHhv+/KpOJ5EfrofqLI1JMK
         h74Xcr1VTmhcMj4oNmhS0nZyjzHczgrLxcPNjF/bIx3Mz38LFl3cZEDFI6dyBT++sXIp
         x3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748033503; x=1748638303;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yCQ9SE3Js2TcEWdD6/nkxAK1t6kl6eJ0qaCIAp53gUM=;
        b=L8wCpmXXmpzt+pBY5G5fvisvtddAmoC/+9Ks8u/Op2cDDN2WNZ+rjlsREVeF0r42GA
         9mMYxqP8ekFHNoiRVKPP525pHAx6SXAI59SrVwc/EFSGguMQXX9qnSVCDmLYpqp6O8pr
         6IO3bFHN7s3fZRYauHraA+Fo0IQhUKUMa3orlUIq+KfgCWeeszu1OW+/JIPmu7KL8/ab
         JPl+bb38CbEfkT8A/y2JreLv46wswDYWIgiSyL8U0dG3sTcYYcFZpZ8qf/RLlLntdcYE
         uLR69hfw2LLm+GCdgGWWRt/NuRvlU73qEGyJaSceP4lXDIpTtdvbx4UURdbkJj3nEKn2
         BMEw==
X-Gm-Message-State: AOJu0YxBRUKX8mLy9QCqENzxz6OCFMyqYtwJxvalqU/sext099EqBm9f
	UqA+znRagekAfOSQ8yXGNGMDhgxMg/iYVPgYU2OQaIXCmxYx3syXSxcswI1wfw==
X-Gm-Gg: ASbGncvEm7zV5UNYnpleVHriXhngZLoeB0N0bOxy6vECFPqnbSvlj4zKmB3eVdW8R1y
	JunKdYejxTNOlEGCU+W+EgH8wK7GgRUQrLs4C6f8YereT0AP/LAKd9EQ95K1MAkAFki42CQnljq
	FdWt/8k6SnXJwdp10hCrffcsk2lw+Jz5j6x3gfa8EO+5pLySg2qAB8n1/IMnBrsvJNHcEEPudDo
	tD+jitKU6kbPVulIaZWrzqTZe0yxVj2saFJnMJv13l/iql6uFr+fPFAJVgXLhqoPhCpaQQkL4ao
	1umdQJpcyg6ECYKHFnHK0NBLT3ERwE/UcE6D8xQzZ6AhytUbe8vn
X-Google-Smtp-Source: AGHT+IHxUKQlDmty7rrJ3kkczissyBGpP4RuaB+62CE3+0y8qcQBbP+7MJgoPjENj0W6Th5XjvENvw==
X-Received: by 2002:a05:6000:2083:b0:399:71d4:a2 with SMTP id ffacd0b85a97d-3a4cb431fc3mr605781f8f.14.1748033502876;
        Fri, 23 May 2025 13:51:42 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a35ca8874bsm28082320f8f.67.2025.05.23.13.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 13:51:41 -0700 (PDT)
Message-Id: <pull.1976.git.git.1748033500935.gitgitgadget@gmail.com>
From: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Date: Fri, 23 May 2025 20:51:40 +0000
Subject: [PATCH] Fix buffer underflow in xdl_build_script
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
Cc: Alex <alexguo1023@gmail.com>,
    jinyaoguo <guo846@purdue.edu>

From: jinyaoguo <guo846@purdue.edu>

The loop in xdl_build_script used `i1 >= 0 || i2 >= 0`, causing
`i1` (or `i2`) to reach 0 and then access `rchg1[i1-1]` (or
`rchg2[i2-1]`), which underflows the buffer.
This commit adds explicit `i1 > 0` and `i2 > 0` checks around
those array accesses to prevent invalid negative indexing.

Signed-off-by: Alex Guo <alexguo1023@gmail.com>
---
    Fix buffer underflow in xdl_build_script

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1976%2Fmugitya03%2Fbuf-1-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1976/mugitya03/buf-1-v1
Pull-Request: https://github.com/git/git/pull/1976

 xdiff/xdiffi.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/xdiff/xdiffi.c b/xdiff/xdiffi.c
index 5a96e36dfbe..2e983965328 100644
--- a/xdiff/xdiffi.c
+++ b/xdiff/xdiffi.c
@@ -951,9 +951,10 @@ int xdl_build_script(xdfenv_t *xe, xdchange_t **xscr) {
 	 * Trivial. Collects "groups" of changes and creates an edit script.
 	 */
 	for (i1 = xe->xdf1.nrec, i2 = xe->xdf2.nrec; i1 >= 0 || i2 >= 0; i1--, i2--)
-		if (rchg1[i1 - 1] || rchg2[i2 - 1]) {
-			for (l1 = i1; rchg1[i1 - 1]; i1--);
-			for (l2 = i2; rchg2[i2 - 1]; i2--);
+		if ((i1 > 0 && rchg1[i1 - 1]) ||
+			(i2 > 0 && rchg2[i2 - 1])) {
+			for (l1 = i1; i1 > 0 && rchg1[i1 - 1]; i1--);
+            for (l2 = i2; i2 > 0 && rchg2[i2 - 1]; i2--);
 
 			if (!(xch = xdl_add_change(cscr, i1, i2, l1 - i1, l2 - i2))) {
 				xdl_free_script(cscr);

base-commit: 8613c2bb6cd16ef530dc5dd74d3b818a1ccbf1c0
-- 
gitgitgadget
