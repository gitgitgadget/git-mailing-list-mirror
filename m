Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF3027467A
	for <git@vger.kernel.org>; Thu, 24 Jul 2025 08:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344900; cv=none; b=HkxrsRrYYh5gXq1xd4MBZpuBHHuuM1qSANl+k76NQ7R+B1nE12IjqApzgM0oubbUa+jjtwvHfHDqw7NelCdF/o+wkX26lSNaoaiRnHzKWDHq/dWaackYP/FM/hB/VXlrMDn1DLC9N6oOrpUUvgZCDtzKoRoJsTAfoBXSJujXHd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344900; c=relaxed/simple;
	bh=QAq2bgOGpAgoWCDNsH59njQTD4SoyJBiOtOPteP1Jiw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Dlt9ydB7t3FdQp2mhQBg0a4RVl7LR5Nn705W80yDIcbMIe9ZwJDoujszMmX1gmU8H4Xv8TFDCmmB8JEj0HcKwEeTMAigxroRWkqehA0y0tnWnpJlRzRyN8yQuGGpfmpbOiFxXMjJ9kTunHKSetXMvivO3UdqyzYT18ruyNM7dVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dXbw86ig; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dXbw86ig"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-451d54214adso4264665e9.3
        for <git@vger.kernel.org>; Thu, 24 Jul 2025 01:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753344896; x=1753949696; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zBzAp+XCnOwPKKAl5z+elC0PzJ9n64IN+auj81EYUgM=;
        b=dXbw86igfHOJT56ebjgZH1yYk5PoNOlAIcGYE9r+fJWaQR9F3zqQq4UZlUnDF9CbMQ
         9+PnCFo5gLweWRUhUbTyEBkF1BlShMbMDRoGsdl/ZhoiBzVNRXx2bHETB3coFsMMSuU2
         3kFmeZIwp6054Y68hpeSLx/579B3NXk6yTAiOr+j8/J9bo+R1UTyQRtv+wcHDEEyp0rl
         QqjmrrWTNRwqBiX9hcCSONUhElbPEcWISmX52z/7dvRgU2QlgbueLZnpoymsh9KC1u2B
         il5MeQp0Db+gvhUprpWl3+KhFiK7tjR/2JazwDQCzQ8zkIG04RX2N/qwXddal3Rw42Og
         G7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753344896; x=1753949696;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zBzAp+XCnOwPKKAl5z+elC0PzJ9n64IN+auj81EYUgM=;
        b=PTdSFnVsOP8DJJVB1XLicV0PwzISCJBSXANBXY10XsocuazYu8crJFOWegyMmeRerd
         rx5RbMzmRqXz8kq3GyMvDcJyC4k2FEXSG3UMysWpydBhUzLatC9ixE2CNtNIhWIGSkdC
         /EMCQ2LSq/EItCnUGclw2kXH5kbTMbqfnUD2VO7geNh4mkGjp5CrnHZ3U/VwXsxV6fR4
         pI5UHC1WMkd/LfJL+6wES0J4tTOy2S6Fmdm85jA0RmrW4mcVVzAb1Jxu48gbpEcmaA2C
         6HI+MCPoekSy5VrgwPe4dOnwCsrz1xUHtXpY1yCdl2RHCKgWcggxFxYlKMhONN015mPt
         +dcg==
X-Gm-Message-State: AOJu0YydAq9EHNqmUwPvJ4vSuhSYS9QkCbkDyuq0NzczAj/lfMdxFkTr
	AmjVdD58TgZmHyO+vDNzdnoL094FbEgoFw7uejUE8d33U6QL60hqoyBj3/FduUHv
X-Gm-Gg: ASbGncuvbh4ublFTmNlwcjiBf3WGzJsUnnhhQQXMyy2b7EaekclcFvEG91QnY6fSXFG
	88RMyWiVs3cPQsdeUHvHkzw48/GRGOlELGY4oz+zzeNhYutMVQptV5YyHSeZ3Y3uZguKuFOlUZL
	Q/UMIBN+GSzJoZ8+iE522caUPG9eVryK5ZBNmTCQkDskGBo4A9yQdD17mt8p2xOMc9LixE2jnvU
	1YKLx+L6RSoaZ64UAY/Dv9jsSTf7kRjfQDjuSJ13klv0bm9TjxhttryJZQrNyUG1my9VUfk0XDs
	TKGUwVqHolQoNw+ffeu+xlmjhBeIBvgwO48cVClZBj0a6kLuoPIFLrzFMtcxDeoedqUmGMBYgVk
	=
X-Google-Smtp-Source: AGHT+IFNKApocCnB5/Zo73FSvKluJs81zz6IMi4VbfNDIuwsc/tyjyv2/1tUwQzPOh2QxINRJPDlgw==
X-Received: by 2002:a05:600c:a08e:b0:456:1c7c:73df with SMTP id 5b1f17b1804b1-45868d41d40mr51906055e9.27.1753344896025;
        Thu, 24 Jul 2025 01:14:56 -0700 (PDT)
Received: from [127.0.0.2] ([82.163.201.2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4586e7d1326sm14678865e9.0.2025.07.24.01.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jul 2025 01:14:55 -0700 (PDT)
From: Karthik Nayak <karthik.188@gmail.com>
Date: Thu, 24 Jul 2025 10:14:42 +0200
Subject: [PATCH 1/5] ref-cache: use 'size_t' instead of int for length
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250724-kn-small-cleanups-v1-1-0c70f591de3e@gmail.com>
References: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
In-Reply-To: <20250724-kn-small-cleanups-v1-0-0c70f591de3e@gmail.com>
To: git@vger.kernel.org
Cc: Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1630; i=karthik.188@gmail.com;
 h=from:subject:message-id; bh=QAq2bgOGpAgoWCDNsH59njQTD4SoyJBiOtOPteP1Jiw=;
 b=owJ4nAHtARL+kA0DAAoBPtWfJI5GjH8ByyZiAGiB6307+U6p48Gpq8F7jTcMpo9qIqjBFZndK
 9zTiIxpkkFLY4kBswQAAQoAHRYhBFfOTH9jdXEPy2XGBj7VnySORox/BQJoget9AAoJED7VnySO
 Rox/M1AL/j++HuL6s0OSN8rAT5U5/c9Yx54wMkRX8zSG0G3y5naNF1coNAm2MDF1WqAzTyPlvA/
 59bzltiQ8EL13FoogpuPyFKLIjISRBz5NYwUbOvz0tLY5b9XXVfuMVe//M00S6sXZ5crPLd0YFj
 +UliMDCaOztsE0Ztm6HTkJztjf6C1FBNsAHENEiJJAwgNUuEKQsWwX0nm1d8Q9yptsQlzTu2yEM
 wMp0VrNEav/UvqZsBlazHw3ZTS3mVtENDSRLfHBRwcRkEm3B9/H4ped8tUIJpAc6C0o5FfF3/AB
 OEay2FWwBdLZT1VfdfBqSMjgmAekmRNe/0AzqMiVylrfhtCCpvqhkf5mloKSgUzjhKPrv7/80M+
 rf2+/j3RxWO82pMdP90XQeLor1drZYnOVp7/NKW2doEmEVsBN9tER8fd270klQdhFhHWIhAcOOZ
 zwX4NSKdoYo8yT3vGKZoanC7h+bpYuP41UiJhSVPYbz+6kMhRZbIjEEMqB8K8nKGBHxtc4VLi47
 5Y=
X-Developer-Key: i=karthik.188@gmail.com; a=openpgp;
 fpr=57CE4C7F6375710FCB65C6063ED59F248E468C7F

The commit 090eb5336c (refs: selectively set prefix in the seek
functions, 2025-07-15) modified the ref-cache iterator to support
seeking to a specified marker without setting the prefix.

The commit adds and uses an integer 'len' to capture the length of the
seek marker to compare with the entries of a given directory. Since the
type of the variable is 'int', this is met with a typecast of converting
a `strlen` to 'int' so it can be assigned to the 'len' variable.

This is whole operation is a bit wrong:
1. Since the 'len' variable is eventually used in a 'strncmp', it should
have been of type 'size_t'.
2. This also truncates the value provided from 'strlen' to an int, which
could cause a large refname to produce a negative number.

Let's do the correct thing here and simply use 'size_t' for `len`.

Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 refs/ref-cache.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 1d95b56d40..8df7ae43e5 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
 		 * indexing to each level as needed.
 		 */
 		do {
-			int len, idx;
+			int idx;
+			size_t len;
 			int cmp = 0;
 
 			sort_ref_dir(dir);
 
 			slash = strchr(slash, '/');
-			len = slash ? slash - refname : (int)strlen(refname);
+			len = slash ? (size_t)(slash - refname) : strlen(refname);
 
 			for (idx = 0; idx < dir->nr; idx++) {
 				cmp = strncmp(refname, dir->entries[idx]->name, len);

-- 
2.49.0

