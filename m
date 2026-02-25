Received: from mail-vs1-f68.google.com (mail-vs1-f68.google.com [209.85.217.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39A42ED154
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 18:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772044640; cv=none; b=PnmZTn6rfR8u+X8h4aRM5zJYdA8jburEEv0iMXV3W2pUgHiqRVTPt8HfCGPNLKKfuYCizHdIXrmee0Qoqa8BgEa7q1cWNqZfHxsozaINqy3sQneNdp17vbJ6iws0M+xz4PoT9wFPGVBU19w29IHEuCmJ7Ds+7RyVNpBNxuCDbkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772044640; c=relaxed/simple;
	bh=3pK6duStGRlqfbmNEhgJ2TpC5Eb0Wljx0IeZXTLgh1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uBihRHPGlPbJDFEZY4yRbcwEl5Ffj6BJ56jXUs+8VU8sieQVa6TLCsv5lIFRCQToR/zYQggr1660mtsXH+XOCL6RDiIlU48/wJySl2DGdqcJ45phqzZ1H269+nYf6OQvnXlz3WlhzVXVXq9lgKwSfabgQiwDXP16sKLWT0vOIYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UeJvx3bY; arc=none smtp.client-ip=209.85.217.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UeJvx3bY"
Received: by mail-vs1-f68.google.com with SMTP id ada2fe7eead31-5ff09bb6335so417196137.2
        for <git@vger.kernel.org>; Wed, 25 Feb 2026 10:37:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772044638; x=1772649438; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEvaXiGurTnSUNvKLKHpKgwOnvSRSdl6BrAlY+eHVIY=;
        b=UeJvx3bYScLTnEDnxCvGdGmMemsnN9g5DEdl4sH7Zi6wP+K6jcvxveawI5EVKobosl
         6KgPhJNms9TWQuotOvW30SPlIq1QXV25aCRpZi94mmyR2H8Kj7DCUoNQFkl7X2dFfzdl
         RiqgFQJStsA7J4eNOFhHAOBQKG73T+cw7S/vFsiMtVsYdiWTIIVeuDAKJuBC5NC7mnFq
         5dDhJMNLRX0+UYq8YiTEox/KqM7gxL8b5x+s82qzhkouwPxdGGBtyGBRS7I0T+2yyOZU
         eGfmSCGqOjSmCMBYvBQWRjpaKwo//Zf9ofGw0esg0z2yjVLzVXXfYDwHNIMO3/XbE8qi
         OKjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772044638; x=1772649438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEvaXiGurTnSUNvKLKHpKgwOnvSRSdl6BrAlY+eHVIY=;
        b=Q05ZJ4ZVxykN4mJusg5edFq23O4siGhdtNpXU2CiXMXFZBhqxcZ0j35nspsVHhq/J8
         xGXbINFnYQjWuNb3PtkSPDGa1LyDc2DMjnoM/wZc2h8r1NiNPHM4lCET4u+0LwhHEgTS
         w7UO629p0kKzVDAaGh1tyIZQSJKP2WtjJc/pgRx1I4Xl8SoJW5/AGEHHYppnlXhI8I6u
         M8DPYTlkYF4h1oydqAZXnEDfOHvo2jCrgG++azEb/4+qOVunxxsal7L7M9eduHUT5z2t
         NpH7qAmvf9QoadjNMW+6525AlviOqltaYc13MHQmNDqbt1a1wAlVAeCod1Vdc+eL99th
         Lo9g==
X-Gm-Message-State: AOJu0YwD7FBfjkfQPiq6n04BNdYk2mMuGeE+mLVN1y9o5lSDrG1NgmEU
	v1wA7Qj/jKVVVYcw1Vlp6+ocEBl1UCWNbBqEaDdGeNnsXz3eM2T982VmUFO+vttK
X-Gm-Gg: ATEYQzybx1yO7Sp6A6W89Pw7MUN77uCpOBaOqdtPet1wbKly8f4loNuzHxfKYnLd9Ae
	+oqrzg3NwfsNKQmVNPGXsXBhfuznYDtDLQzGXJg1i62cdEmvYeHAAXRSwfcBFHfQ+2QX9gNiq38
	+BHUL17QggfEEp7v7PyV7xZWA7AuOK0pJtjj1GbwrIHjXjZvzLQLI9QNKJJ1p05x37/S5kKCVH/
	ulPDxEvfD2LvdhOFVnoUXgU9McplFnpaIO5deadtdM1IZ0vfQimfT/PFj+rwWxl829Lul3ckJQ1
	Mu534jHp4ggJYDbIPGVR7oDcXGJyu0jhZ1pLKca01WCrPd+AnfPUcm/llNF8nP8IkIsfA+vnMoq
	/aSnjaV222Q7Jma6WAa1yoAFhOm2WAgRIXkdWDNbqdnqxMm0FIDJpQTEhvdsjzyJiP45hu/Qf1T
	a9N2vJYmUkkY+kZr8fnj3VZssxu5QCozYDA1+aSqtepbVU5v8xOZA34yLk0W1v
X-Received: by 2002:a05:6102:5493:b0:5f5:4d9c:de4c with SMTP id ada2fe7eead31-5feb2e60da4mr6627275137.3.1772044637698;
        Wed, 25 Feb 2026 10:37:17 -0800 (PST)
Received: from localhost.localdomain ([189.62.150.156])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-94da89e129esm13457485241.5.2026.02.25.10.37.15
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Feb 2026 10:37:17 -0800 (PST)
From: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
To: git@vger.kernel.org
Cc: sunshine@sunshineco.com,
	ps@pks.im,
	gitster@pobox.com,
	jltobler@gmail.com,
	avila.jn@gmail.com,
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Subject: [PATCH v2 7/8] Documentation/git-repo: replace 'NUL' with '_NUL_'
Date: Wed, 25 Feb 2026 13:32:16 -0300
Message-ID: <20260225183559.79303-8-lucasseikioshiro@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260225183559.79303-1-lucasseikioshiro@gmail.com>
References: <20260218211845.96009-1-lucasseikioshiro@gmail.com>
 <20260225183559.79303-1-lucasseikioshiro@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace all occurrences of "NUL" by "_NUL_" in git-repo.adoc, following the
convention used by other documentation files.

Signed-off-by: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
---
 Documentation/git-repo.adoc | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-repo.adoc b/Documentation/git-repo.adoc
index 319d30bd86..f76f579b20 100644
--- a/Documentation/git-repo.adoc
+++ b/Documentation/git-repo.adoc
@@ -40,7 +40,7 @@ supported:
 
 `nul`:::
 	similar to `lines`, but using a newline character as the delimiter
-	between the key and the value and using a NUL character after each value.
+	between the key and the value and using a _NUL_ character after each value.
 	This format is better suited for being parsed by another applications than
 	`lines`. Unlike in the `lines` format, the values are never quoted.
 +
@@ -80,7 +80,7 @@ supported:
 	configuration variable `core.quotePath` (see linkgit:git-config[1]).
 
 `nul`:::
-	Similar to `lines`, but uses a NUL character to delimit between
+	Similar to `lines`, but uses a _NUL_ character to delimit between
 	key-value pairs instead of a newline. Also uses a newline character as
 	the delimiter between the key and value instead of '='. Unlike the
 	`lines` format, values containing "unusual" characters are never
-- 
2.50.1 (Apple Git-155)

