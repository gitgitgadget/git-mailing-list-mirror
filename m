Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F334E1C860B
	for <git@vger.kernel.org>; Sat,  1 Nov 2025 16:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762013724; cv=none; b=BE6v39RmxvRaZep0dfrcRMTTjIOYSdjb2XBsQEEv/e6VSFM07f38stsB5+SZGS/9R8lHq9GGx3uxIl8a5+BD8jgR9NQP68Gzz7A8rp3Dw6NhNXXQwEPunt7odJaQD8G+Hy7RSD3APpbvlMCMQU6c7JKc+5l18IqER1QxAO6B5gM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762013724; c=relaxed/simple;
	bh=dNqUWhhYWlK4vAAMSBjvMSpbdZg/lMViCKrUjP/WvgE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JSDFF/QKA1ijCjrisarNtw86DKufe2XT3n6LYJFDzy33J+RMqludNIWe+R2LBU57qJl01q20/1Rkv9QLR3+6oCGIKccEG1Aw3aEnR7jWLXK4DiKwuy0+dIOwU2QuCovw9h8Ze5PsqG9lEGmZIC5EL4zb4Us2bB8AGM0gj9KWxZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UvhKy//l; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UvhKy//l"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-474975af41dso23604455e9.2
        for <git@vger.kernel.org>; Sat, 01 Nov 2025 09:15:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762013721; x=1762618521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y2imedx2EkUkHZAP8FEyCXKsR/8hEUsa+nQid92Pfjo=;
        b=UvhKy//lHkgfyNaL6krMqz2Ptr9w+dzwSZpw4jseIdt1a4qRqW4QOcjDVB4uNrfjs2
         BD2eMJEe6kykwKZgnbULzTEvUByOFXZQvVsSslP4f82zOeq5af5aU64pp2sdmtINKCPe
         7y816B/s+93cPK+/Yl+AqSurl1NecNKg2nsT9Ck9uOJ6jSrb0lSAy3syGVCHJfdMNL5a
         wQRdFSsI16+0BJwtuCBXHxLp+y2PMaDUehHqQE9KfqWjur+kZ25fzQTwQuijGqURDlLD
         HWgqORp/jFPX9FJ+aPkJ3mGJQPjhDeobg4HPqhcCzAbMRYc1ieesXLfBTdrG6wNIq/WV
         AtVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762013721; x=1762618521;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y2imedx2EkUkHZAP8FEyCXKsR/8hEUsa+nQid92Pfjo=;
        b=bAQgKWHm7q/YZ5Gm8vOrN5QsVIcNFAbDcRq6onGX5kXhEEPa4C6HPy32RWHSBkq/BO
         Xp1vH8EDPdEkMmf0PcSrlEKR/U442e5nq5dRQJsGb7mQ2oNYAJ8XszUqZW1n3JK4rWEU
         Bp7fXSCJuIY5XE0p+EMN5geM/lHqukv+XnS+Bs99ilDg+3SGvdlLKI2JaFfBWhEjWMVp
         fGYGB8/qXLryY4gGStC2Xfdib6fUU5dlszAMPMT51VT8AKYve4Z2P4eAJEK9ypYL/FQM
         f1JrneOQkypkryVjwEaAmfhicSs4mLEMDbqV3T5LcLqyw5CTnzYEdjuYSw/EplPFhyAA
         55/w==
X-Gm-Message-State: AOJu0YySjIkj31wJPCSNPSL7rfJJv8EXm1iiifABWxfnn5gQFhUOHZ5o
	aWOPU/d6aDmtfwWeiJiFbOGpMQ5DrpMJcnbfN628IVJiSz0gH3Fz9FfU+7RVgxpy
X-Gm-Gg: ASbGncsaAzc9TSGjQBSgTDlTbA6VHlZT+zsFimS761ou9WpXC8byPv2OCYNiF5tErUT
	WDeL1797cWhT66shFnCY+1QOI6AIri/JU1K53YPZ70w4mmvL2NLAnOBAoVZYC/J/6T3630UQfd0
	YKhBb5Iqqg0X+RXEUsWmLlWSVIonK0zbI61smy/Bql89CG0F4wHFeo8YX7k9fGLP9fsSzbojY5S
	0qCN/RQSCmL0oYwDd1+D7nSjH58MN1VVSmDI0Vc8yxHM2TwhVzLPCWUtfePoyVbZxNawSM1S0Te
	cVPgZGAFQxPsr4vGzP/KqW0g5S4FiPDH55Nldsh3kswEGvwuwFNabyb3w1nDpPGKY+VMVyZlF9F
	JOHwkTJ6jrCp4NBlUgO00C7mmwU7xj7EDQ0idUcmhqSZhFYk7Y9D2Ia/PmFnvjMo/9pvigwGXxS
	NVme3lDlmSRlIPmOK6yxExHMLp9pzKOh/TAO8=
X-Google-Smtp-Source: AGHT+IFrOKYTnyTMXiPkzmm/Gc0gZAOMWLIGh2hmJHY2/0Xxqvgeq3BwBxMj8Z0UuQu+ejUstkWQug==
X-Received: by 2002:a05:600c:3b1c:b0:46e:761b:e7ff with SMTP id 5b1f17b1804b1-4773089004amr73420155e9.28.1762013720793;
        Sat, 01 Nov 2025 09:15:20 -0700 (PDT)
Received: from QueenJ-PC ([105.113.79.41])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429c13f2b5asm9640536f8f.40.2025.11.01.09.15.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Nov 2025 09:15:20 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: QueenJcloud <qjessa662@gmail.com>
Subject: [PATCH] gitprotocol-http: document invalid 'want' error handling
Date: Sat,  1 Nov 2025 17:15:12 +0100
Message-ID: <20251101161513.1794-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation to describe how the server responds when a client sends an
invalid 'want' line during the HTTP protocol exchange. This helps clarify the
behavior of Git when handling malformed or unknown object requests, and
ensures developers understand how such errors are reported.

Signed-off-by: Queen Ediri Jessa <qjessa662@gmail.com>
---
 Documentation/gitprotocol-http.adoc | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/Documentation/gitprotocol-http.adoc b/Documentation/gitprotocol-http.adoc
index d024010414..8818e9dc03 100644
--- a/Documentation/gitprotocol-http.adoc
+++ b/Documentation/gitprotocol-http.adoc
@@ -443,7 +443,17 @@ If no "want" objects are received, send an error:
 TODO: Define error if no "want" lines are requested.
 
 If any "want" object is not reachable, send an error:
-TODO: Define error if an invalid "want" is requested.
+When the client sends an invalid `want` line, the server responds with an
+appropriate error message indicating the invalid object request. This ensures
+the client can detect and handle protocol violations gracefully.
+
+For example, a malformed or unknown object hash in a `want` command will result
+in a response similar to:
+
+    error invalid 'want' <object-id>
+
+This helps maintain clear communication between client and server during
+fetch operations.
 
 Create an empty list, `s_common`.
 
-- 
2.51.0.573.gb660e2dcb9

