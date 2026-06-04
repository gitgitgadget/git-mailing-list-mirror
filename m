Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A629421EF6
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 13:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780579553; cv=none; b=h4zVxoQ0uJyv6Am3r+I0JSI3w64ayRf/0iKRasxnD8aP6QmFxbIQ8cjhOmOgUs6ewhl1GHUficGI42AHDH1NNHkJ5Yy+Ls5tyLEiQzx1aRVerepaBAJHL9bNnh05ndy3p6QMEuJWowfzUgixomayMnQtfntDnxXBsuGlLS3JBms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780579553; c=relaxed/simple;
	bh=znAnEW0O3eLkJVtw5H/WnekHn647qJSevVEVMPwh444=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VakFpo8N2AnFJJkopNPnwnULao61PVBPeqDUJSalD9k4sVjkZf4KevFotUH9AbPDQYlY8uOl04pdc9HplJ7jmnnqpqdnL9FNM2qkExP2k/XjSCSP0mpuSGWjZTSM2Tp0JSjL6iwYykzRQ2yWx2nlVAr13AJge5sv2hq+YiUX4RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZpVv/Av8; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZpVv/Av8"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2c132ac5ec2so7114725ad.1
        for <git@vger.kernel.org>; Thu, 04 Jun 2026 06:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780579551; x=1781184351; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NciXSAjQ4NJhKDby4v/3MvN4AS+mXtcT1/X5+VRXHHU=;
        b=ZpVv/Av8AmHZTIURdH8kqrwZK+8mn13HqmUkTRIL6uJ5I/Wx+MzRPlXNqKpoeRa3tZ
         IEBp7i1EFEQevOFttLOCLyC7JnYCHo10VjrfL1nieX3i7qyK2n3IKrkiWcKI0XPolR4y
         mUawdhKyuc0oh1U27i77IiVKT/fCp/Mb5OqtV77Il+aympN1Nigqa+zVTOU5UaR8MxxZ
         LDrnRvjr3WBUMQKKJcJVa1aB+3GLYS80XZmjMg4ReCMBa/2/GOpgUq/RvhWH5sjU5Q3K
         jNabU996TDJsuCQW46CD4gYoIbNZ7U6oKR8d2LoQeYTyaKkFa5BIKYmhwjw2I/rub8bj
         yblQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780579551; x=1781184351;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NciXSAjQ4NJhKDby4v/3MvN4AS+mXtcT1/X5+VRXHHU=;
        b=hEoqFNgrKmYrfg9cXi5N2ZX8rNwY/tuTjkNEy/LQwDrtMjcJj5B7/EgTOExGGAbZUh
         nmIRr2OeRCC0hqV3dTIAvNjKfJ/uYixEuBMTHa0oPgBirlfviHAbHBTutmQC6PZCcZ7F
         bEQdoE+0jWboxxCUd5VfFBmeKYGo5VS9D1Y5S8UMKvGqcGKi7Q3m4fhGK8OViDgHQqsg
         Hyx714xppkG455aqSuO5lfEziPUwBir3ZFA7o8TOIItAd087h/EIw5h2mEAxgity2TAD
         JlF+1hPIqAAwuy+GnP4N37rFhLcsEZPzhFTlk/3U8F1iMmbhHxQLL/Q8/sLmVEsU9PA2
         fpyQ==
X-Gm-Message-State: AOJu0YzygnVBcn+md5Sl/DSFVbsQ7H8rxyp/Cmxjgcu4nP5z+U/DOaJa
	ou4J1+OiXlqALWCseQBSdKe2b9YDz386hFigYABlGUKBaLyeT+NET5TN
X-Gm-Gg: Acq92OGd8W5gSbT5z41GpxbZdbsXSYBVGxf1ybBhhDrJysN+WmJt+E1AXsMkWRAeR3F
	PIUOq7ML6bjt/31J/pYiOpxwEDT0YvsF/H0B2DR61R2Ao64O5vFcwNP4+9Ske6nyaRiqhOZgWAT
	ArsZXxem2JncXHGXC8CP+PJQcHroLSwMOll+fFxZ5X/mW0jEbpDKNOjSFuveQltzNI69KIjgyjs
	k3fcOapYJL7FnES7PWi7O7bW4TjEqeOOf34lgMC0ubWTt7Zy92NG5cc87UXkSvPv3ZfU0L+gzQh
	EL3WthYUOv/YqInVfaNOw4UvY9xo5TaCIgt8LpopRQaTnlf3oZlbV6mnnoRwhLdIQ+ytEaMQehT
	ZijSOo1ve9tWEmNwAU8lKHmhIIe2Xkqw6OSLDxRPJFXRzlsl4/IbX2ZCScXM41EY3UbpnCp+76L
	KsqI6nnjEOIO/SfBBAk/kptbnrAuqJMXDFxqpzdb7ssF+ObWfCcP1BV/67Kg==
X-Received: by 2002:a17:902:d2c2:b0:2bf:21e6:baee with SMTP id d9443c01a7336-2c1641be20dmr89457445ad.28.1780579551154;
        Thu, 04 Jun 2026 06:25:51 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.115.206])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f6d37esm87381515ad.9.2026.06.04.06.25.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2026 06:25:50 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net
Subject: [PATCH v2] transport-helper: fix TSAN race in transfer_debug()
Date: Thu,  4 Jun 2026 13:23:29 +0000
Message-ID: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
In-Reply-To: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com>
References: <20260602201309.38434-2-pushkarkumarsingh1970@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, transfer_debug() lazily initializes a static variable based
on GIT_TRANSLOOP_DEBUG. Since the function may be called from multiple
worker threads, this initialization is racy and is therefore suppressed
in .tsan-suppressions.

Initialize the variable in bidirectional_transfer_loop() before any
worker threads or processes are created. This patch removes the race and
allows dropping the corresponding TSAN suppression.

Signed-off-by: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
---
Changes since v1:
- Treat negative values as disabled by using transfer_debug_enabled <= 0

 .tsan-suppressions |  1 -
 transport-helper.c | 17 ++++++-----------
 2 files changed, 6 insertions(+), 12 deletions(-)

diff --git a/.tsan-suppressions b/.tsan-suppressions
index 5ba86d6845..d84883bd90 100644
--- a/.tsan-suppressions
+++ b/.tsan-suppressions
@@ -7,7 +7,6 @@
 # A static variable is written to racily, but we always write the same value, so
 # in practice it (hopefully!) doesn't matter.
 race:^want_color$
-race:^transfer_debug$
 
 # A boolean value, which tells whether the replace_map has been initialized or
 # not, is read racily with an update. As this variable is written to only once,
diff --git a/transport-helper.c b/transport-helper.c
index 04d55572a9..9e69c67cde 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1361,24 +1361,16 @@ int transport_helper_init(struct transport *transport, const char *name)
 /* This should be enough to hold debugging message. */
 #define PBUFFERSIZE 8192
 
+static int transfer_debug_enabled = -1;
+
 /* Print bidirectional transfer loop debug message. */
 __attribute__((format (printf, 1, 2)))
 static void transfer_debug(const char *fmt, ...)
 {
-	/*
-	 * NEEDSWORK: This function is sometimes used from multiple threads, and
-	 * we end up using debug_enabled racily. That "should not matter" since
-	 * we always write the same value, but it's still wrong. This function
-	 * is listed in .tsan-suppressions for the time being.
-	 */
-
 	va_list args;
 	char msgbuf[PBUFFERSIZE];
-	static int debug_enabled = -1;
 
-	if (debug_enabled < 0)
-		debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
-	if (!debug_enabled)
+	if (transfer_debug_enabled <= 0)
 		return;
 
 	va_start(args, fmt);
@@ -1648,6 +1640,9 @@ int bidirectional_transfer_loop(int input, int output)
 {
 	struct bidirectional_transfer_state state;
 
+	if (transfer_debug_enabled < 0)
+		transfer_debug_enabled = getenv("GIT_TRANSLOOP_DEBUG") ? 1 : 0;
+
 	/* Fill the state fields. */
 	state.ptg.src = input;
 	state.ptg.dest = 1;
-- 
2.53.0.582.gca1db8a0f7

