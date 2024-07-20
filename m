Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BF13BE7F
	for <git@vger.kernel.org>; Sat, 20 Jul 2024 03:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721447038; cv=none; b=i2753jnk91iJxSoainBwT6+G0/MdmeLbLCpjATdUXrDYMgJfOuhs5ulJ05H9DBjQqaO6+kj92wzHFp4BB/6i70X0qTlJfEX9fXXJRp20+OFzAIcp17gZiX0UQCTiLREHRek5PNZpEIWYNPCmcIX1F/f/1ud6rtTraUDvT8J59iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721447038; c=relaxed/simple;
	bh=3TqlCere+U+JSxPVmJIJa/GjoI4TjZHgJ5VqdP41Qsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZisDmzHQHjAFaTxWYV17G4fXP++FR2oFPD0PS7cqh/uHk3RVRRKS9oGOo2CxJhjq1Ooyg0u4ifWhfVLLnRAqGXyvlrobQRU52dd5NUiSAMp+NGgW4qIauMQtjQ3S4QNxVgFCT6Pd5tNUd0B06lb2Lezjx+eRkXX5bBop3P58nq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BjwW1B19; arc=none smtp.client-ip=209.85.222.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BjwW1B19"
Received: by mail-qk1-f176.google.com with SMTP id af79cd13be357-79f323f084eso135296085a.3
        for <git@vger.kernel.org>; Fri, 19 Jul 2024 20:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721447036; x=1722051836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=odAwMZhqrTfkfMaTE3JegaUPfYg8rBgF4fRaR28KiOw=;
        b=BjwW1B1906QzG+OG/H/op1YqhQOFfz4wx9aSJx3JoWn5ktnDBi875GOYnA6DxCk06B
         R8XM09LPxiebtbGfyg6LAxzhDeYmxCNyKA9BxGe16iQki4Y+tqt0a8lqinOGSgDeif5o
         /gi6d7MpZO4gn5IrPsbADLPNMjtfGcKa1wZHiUwrY25ag2YQBdF9IxXvjm96zHJRcSnl
         rGQ2ECGC89QeLwv1kBvV4KgMHobXrgG+j3FP4WVEFCC0qJc5dNrIIaXQ2Dy084fxMm9N
         TlwoU+rNJD6uR91hQcD8Uk1NDPpgJPnxkQ0mq/H1YFHRQCRcSWcWQHbUN336/VkMRsNh
         U9MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721447036; x=1722051836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=odAwMZhqrTfkfMaTE3JegaUPfYg8rBgF4fRaR28KiOw=;
        b=C7o8CWVNzbeWEBKvLeAU3e69lhibmskVw37r9j2QfyDINyVL6UlBS2OLXq3ClS91pI
         pybXMo0ZJW4Gj2ZD8pZArxW4xAbSpMOR1sQUUQSbxN9DjeoMCU3PBYkzE6Y5gsBKxdE2
         gzORjtB1o5Te7DgVzn0q2SPAcQMxdh04qyGZtcvcpIZgn6pGOzOzGrb+Yq7yGOiUt+kl
         nmfi5RFGB/HU00S7kHcdcChxlZtghB0RYbXsG6C2J5WyOdzpioSgc1dM+TCpHyVJseA0
         5v2QqGyRb9uwUdILbYclP2QxLsOAHb6BfcccF28SGLlYs+yV3VRk1j0AkUy7Dsajx09i
         qaLQ==
X-Gm-Message-State: AOJu0YyoLip9jRvaIH08MkOJJtMEv0ppy2S/UB25KD3NQimYH+ZKETkQ
	OOegCoTwyU/pS7ODZak/3JHx9lukCu1htRG+g5YMMLG1T0c2Vo6MOh/oftB/4i0=
X-Google-Smtp-Source: AGHT+IHZJn+vetgMVCXEa2XVS4okto/+35EfLtf3+8c1LnUZQOQI2f8NsoZprLpGrULkYsqicuABHg==
X-Received: by 2002:a05:620a:2a16:b0:79d:5b21:804a with SMTP id af79cd13be357-7a1a130c2b7mr251349985a.14.1721447035777;
        Fri, 19 Jul 2024 20:43:55 -0700 (PDT)
Received: from localhost.localdomain (bras-base-unvlon5586w-grc-14-76-71-94-205.dsl.bell.ca. [76.71.94.205])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a199073b49sm150487385a.100.2024.07.19.20.43.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 19 Jul 2024 20:43:55 -0700 (PDT)
From: Eric Ju <eric.peijian@gmail.com>
To: git@vger.kernel.org
Cc: calvinwan@google.com,
	jonathantanmy@google.com,
	chriscool@tuxfamily.org,
	eric.peijian@gmail.com,
	karthik.188@gmail.com,
	toon@iotcl.com,
	jltobler@gmail.com
Subject: [PATCH v2 3/6] serve: advertise object-info feature
Date: Fri, 19 Jul 2024 23:43:34 -0400
Message-ID: <20240720034337.57125-4-eric.peijian@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240720034337.57125-1-eric.peijian@gmail.com>
References: <20240628190503.67389-1-eric.peijian@gmail.com>
 <20240720034337.57125-1-eric.peijian@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Calvin Wan <calvinwan@google.com>

In order for a client to know what object-info components a server can
provide, advertise supported object-info features. This will allow a
client to decide whether to query the server for object-info or fetch
as a fallback.

Helped-by: Jonathan Tan <jonathantanmy@google.com>
Helped-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Calvin Wan <calvinwan@google.com>
Signed-off-by: Eric Ju  <eric.peijian@gmail.com>
---
 serve.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/serve.c b/serve.c
index 884cd84ca8..3aae03405b 100644
--- a/serve.c
+++ b/serve.c
@@ -70,7 +70,7 @@ static void session_id_receive(struct repository *r UNUSED,
 	trace2_data_string("transfer", NULL, "client-sid", client_sid);
 }
 
-static int object_info_advertise(struct repository *r, struct strbuf *value UNUSED)
+static int object_info_advertise(struct repository *r, struct strbuf *value)
 {
 	if (advertise_object_info == -1 &&
 	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
@@ -78,6 +78,8 @@ static int object_info_advertise(struct repository *r, struct strbuf *value UNUS
 		/* disabled by default */
 		advertise_object_info = 0;
 	}
+	if (value && advertise_object_info)
+		strbuf_addstr(value, "size");
 	return advertise_object_info;
 }
 
-- 
2.45.2

