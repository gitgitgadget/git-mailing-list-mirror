Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A035F31A60
	for <git@vger.kernel.org>; Thu, 18 Jan 2024 21:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705614866; cv=none; b=PuEgfnZGFZ3/ZK/HtCR08aOAbReK9OXpxjXnLXWNgEl9Iy7xPNhIjI9vuqLlTvM+ZsTNpL6dBF6ORqOsG9t9WqiknrLY8OgiMdtaTJftXTSkKM8LqtwUzwDm21PrUr3scPsLyOnyeLcvE9kKWEcLReAB3d7HpXQvy7YqepW+jvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705614866; c=relaxed/simple;
	bh=jo5FnlUjuZneufLRJ1Mxqan0lFBv4fd3o21nVGtzLhU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=APcUWZmMiBQReVRpPUrkI7V3unmCZaS9tdiyHu7UV05e4QWC/LdExUmIOAslxW9eeDXsP1C7WB+j8Soc0sg8ZhqpWq4DsMWmdpdpIG5aEQaUrRXicbg28dx8LzVHXI10VXCAIq7s3yTejoavoHeJXMnYaoZGCJXet2oRs93cUp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BPlE4DfH; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BPlE4DfH"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1d70c3c2212so1251685ad.1
        for <git@vger.kernel.org>; Thu, 18 Jan 2024 13:54:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705614864; x=1706219664; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=icEuU/I6p5zQzSRXbLp+TrUGomeO+5w6HV77xYPs6SQ=;
        b=BPlE4DfHDbiDvgOT3YYMfKcN8IdHtWO/u07G+H8+anEBdrSMtQQaK+SC84V3XPy1HW
         jVsA1SQiSNMMhAeyIC77WaPhQbgvibL1lTdr6clVboal6NfjnqlwQLin999D2Kh3FjIz
         pBG8H8dLMZn/HfexCbMNXdFGCLHhz4w5RV7Mn06eGwlpczcuvJ/ICgByr9f/tpleAFpL
         jnTSeEL4ixXru1NG3gTJXytSi+IrtBsGig3vfrSedZIwVGwN57sZOpNuSJofiJP0s0qD
         Pl+2cVoiNRgOf9Th6pFjPRPPGWHkSwO81SUStaJ/cK+/pDiG2P/tO61E8KTcjipES9sk
         +uFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705614864; x=1706219664;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=icEuU/I6p5zQzSRXbLp+TrUGomeO+5w6HV77xYPs6SQ=;
        b=JUZNk6G5raUhvz2vv2hU3Qyr97q+AesnECUWZe9CEesV8AeY40SL85VK4vtqAOavmx
         2tQDS59vsXoLppn986T1na7mTGbFU4h1DY6hTZwsSL40pfwzgMqf00bJ20wRte8wVl5q
         QYXjOMbDhjk5eq1eQYdDGsbiTTC7qn/IYc2jZrDK2f3bqi2zZq6yGNGSXCOSGbAuQSfG
         hp2F9qA2hzoyLJrnytdJux+VvI5LmZDx/2H/ndSTBrgjloA2B6mMOXntECSMSjDJMsZV
         RF1t0t6dBuTlvsz85d5w622b0jekX6uEomo14pVg55LIsSW5TQnowfAP+RSj+vdIOcwp
         tj7A==
X-Gm-Message-State: AOJu0Yy2xA9CIl4E7QjfqVTM1qpI25mK1cVzc/nuOQoMLea6aGP1fbCn
	26pYeUan45u2GTfVH9M85hWxXdeXeUg4M47ynq33EuQO1jZjtHocq4Z53VL506s=
X-Google-Smtp-Source: AGHT+IHDBTY8+jDs/E+AeJIWm1OQ910ikfCdS+iBxUP6hJuG9wOmkjOM5NyqgtKkajkXi8qcw4QQQA==
X-Received: by 2002:a17:902:f806:b0:1d5:be4d:1afb with SMTP id ix6-20020a170902f80600b001d5be4d1afbmr1897791plb.14.1705614864517;
        Thu, 18 Jan 2024 13:54:24 -0800 (PST)
Received: from localhost.localdomain ([2402:a00:401:a99b:65e8:f5a4:7adb:5726])
        by smtp.gmail.com with ESMTPSA id mp14-20020a170902fd0e00b001d5e6f008bdsm1827767plb.132.2024.01.18.13.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 13:54:24 -0800 (PST)
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: git@vger.kernel.org
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Subject: [PATCH 1/2] t0024: avoid losing exit status to pipes
Date: Fri, 19 Jan 2024 03:23:39 +0530
Message-ID: <20240118215407.8609-1-shyamthakkar001@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace pipe with redirection operator '>' to store the output
to a temporary file after 'git archive' command since the pipe
will swallow the command's exit code and a crash won't
necessarily be noticed.

Also refactor an existing use of '>' to avoid having a space after
'>', according to Documentation/CodingGuidelines.

Signed-off-by: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
---
 t/t0024-crlf-archive.sh | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index a34de56420..fa4da7c2b3 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -9,7 +9,7 @@ test_expect_success setup '
 
 	git config core.autocrlf true &&
 
-	printf "CRLF line ending\r\nAnd another\r\n" > sample &&
+	printf "CRLF line ending\r\nAnd another\r\n" >sample &&
 	git add sample &&
 
 	test_tick &&
@@ -19,8 +19,8 @@ test_expect_success setup '
 
 test_expect_success 'tar archive' '
 
-	git archive --format=tar HEAD |
-	( mkdir untarred && cd untarred && "$TAR" -xf - ) &&
+	git archive --format=tar HEAD >test.tar &&
+	( mkdir untarred && cd untarred && "$TAR" -xf ../test.tar ) &&
 
 	test_cmp sample untarred/sample
 
-- 
2.43.0

