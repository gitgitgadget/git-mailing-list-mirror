Received: from outgoing.mit.edu (outgoing-auth-1.mit.edu [18.9.28.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3303B1AB6D8
	for <git@vger.kernel.org>; Mon, 14 Oct 2024 13:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.9.28.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728911652; cv=none; b=F6huAA4m5BBJ71GpCwXUDHLB+wFoGV/Mc8alx8S2AQ/asBBwFtkj49Anw+CJ+8/6R288OMKpFe75yrPCcaeI1nwWrt1OZ2IOfeb/pjA7bpFIgC98Fz+eW2h4j8GuvIuOmaEsuc//bFCMqmPaOVcEr7MQB203hnAQScNyDmCnk/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728911652; c=relaxed/simple;
	bh=+UWl1T3spNHYf6PEPKDJZLJVND5awyHfWphqKt+fQY4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fIWeSo2K/3R+kp0DFaZJplDpB3m7Pu2VDQLPVVjpDiGb7jzjHBVAiPt7ktzDOwK75sLeD5GGb8AbX9cHSbrwtBAIIZw+yeyt4iF4Z8VkQBqSN/YLrLXOkAyP4dICz7W3/YB6WhdhWNtgxrqgBJTWaZhISx+wXUjWGcG+NTbZ7oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu; spf=pass smtp.mailfrom=mit.edu; dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b=bRI0B0nb; arc=none smtp.client-ip=18.9.28.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=mit.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mit.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mit.edu header.i=@mit.edu header.b="bRI0B0nb"
Received: from localhost (CSAIL-SQUARED.MIT.EDU [18.9.64.19])
	(authenticated bits=0)
        (User authenticated as asedeno@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 49EDDskL002048;
	Mon, 14 Oct 2024 09:13:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mit.edu; s=outgoing;
	t=1728911635; bh=P7SOKJfrh8vNYGgjD7pusgdyz5g8+KUU2mRF8pgTWI8=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=bRI0B0nbyLGiBXabzpYqDtj5wp5oRXZU+zJCRn6+Z7cpBwQgJzDooj7/S25uO7JiF
	 upUh/gyp3yKEhryzELqqAXsV5h1bU19Sg30D7ua7/vN1/Z9xZQDyEEYaLgoOhfu5TN
	 FIp5Hntp2HfL5VJ/WxFkr8kZcTnQmcrxvOGlYaAsvLFy8rmOlmgs1KzEuwd+YUXRQ0
	 1iCudqscP3MmD3gn/mStOHdG/lk3eWnAt1uvWi0Xws97yakKi2hhf1UX8gjuC0ebJC
	 pxn0XVo34vztJwihbllN6jV+ucFFjRzlHJrkKx6nuH9qQfBVyH75cjPjxKI5i2uO8p
	 y9FHUHtWleLbw==
From: =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
To: git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, sunshine@sunshineco.com, asedeno@google.com,
        =?UTF-8?q?Alejandro=20R=2E=20Sede=C3=B1o?= <asedeno@mit.edu>
Subject: [PATCH 2/2] Fix inconsistencies in git-curl-compat.h
Date: Mon, 14 Oct 2024 09:13:46 -0400
Message-ID: <20241014131346.3556163-3-asedeno@mit.edu>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241014131346.3556163-1-asedeno@mit.edu>
References: <20241014131346.3556163-1-asedeno@mit.edu>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Alejandro R. Sedeño <asedeno@mit.edu>
Signed-off-by: Alejandro R. Sedeño <asedeno@google.com>
---
 git-curl-compat.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/git-curl-compat.h b/git-curl-compat.h
index 08ae73e0f1..f9aebf93ae 100644
--- a/git-curl-compat.h
+++ b/git-curl-compat.h
@@ -76,7 +76,7 @@
  * CURLOPT_PINNEDPUBLICKEY was added in 7.39.0, released in November
  * 2014. CURLE_SSL_PINNEDPUBKEYNOTMATCH was added in that same version.
  */
-#if LIBCURL_VERSION_NUM >= 0x072c00
+#if LIBCURL_VERSION_NUM >= 0x072700
 #define GIT_CURL_HAVE_CURLOPT_PINNEDPUBLICKEY 1
 #define GIT_CURL_HAVE_CURLE_SSL_PINNEDPUBKEYNOTMATCH 1
 #endif
@@ -118,7 +118,7 @@
 #endif
 
 /**
- * CURL_SSLVERSION_TLSv1_3 was added in 7.53.0, released in February
+ * CURL_SSLVERSION_TLSv1_3 was added in 7.52.0, released in August
  * 2017.
  */
 #if LIBCURL_VERSION_NUM >= 0x073400
-- 
2.39.5

