Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 844D5428499
	for <git@vger.kernel.org>; Tue,  9 Jun 2026 13:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781012983; cv=none; b=cB50TNkQR7PJraeHNuOHoH2ZE4Ydl4AiRijBhQ2DUT3milHQs2hVaHxxizXIaews+d2oEpx3MB4qMM1JeyY6//0eD4iFMRgI91UxHM5Z3HH6UBRcv+ZagUUiC5+sgycu3kp/sP5b1tWXJb6xBlGboB+52I7mGgmXbve151WOiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781012983; c=relaxed/simple;
	bh=HtiG3/Ed16rFda6XGed7smw9DRfsL3aWbCG9eAoR160=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9uwb/S4+ca4SNJGSXu8oycPoJnw5iZPJptBrihVCLuISwe/vIXxL+BC6zRLIarx5OiOaNhxcrbtqmhiIee3F4v6X44GeEC3mm+uPgz635rwZmEN8Ot0EHtrrakHiU87KZeibYiSxVNSA7ZgVd5+4OyCfKApTkKXRERT5a/lga4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TjK/U8T2; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TjK/U8T2"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8423f1e2f8eso4221514b3a.1
        for <git@vger.kernel.org>; Tue, 09 Jun 2026 06:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781012982; x=1781617782; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DJhOFOTu12azIINBQoyUoaJNJdafF713exVCxJ+uHJ4=;
        b=TjK/U8T2vIATDVcU/c+YXp1Lr7ej4lwaJxSKZiE4/1nhYCYny7LpYKMLvjD9SGHph8
         A91GfAktAy4tETHNQDb7BgAaNSqECGFpQUNAhdHWkyFEN/Ib/6Jf+h5wjQWB7J/Xk7zL
         lNWcuceljObeym3mRHCv369ySIHEknTj8BANzCKUr/2MTzn3O8nCQE5YtvVz4NGriCMl
         ZMZJY57D1AwMekXDOMjaGg6q25/co6I7LN2t7BrksIuuO78idG2CpMg6yPyhvPHQLp4M
         +PIqZxGijVzieQISS+cDxbbyL29dICCoGbtiDJ58pNPvM9b1spEea9Tf0sor6ycvgcgU
         B0Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781012982; x=1781617782;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DJhOFOTu12azIINBQoyUoaJNJdafF713exVCxJ+uHJ4=;
        b=nkQU1NzdRF6KALIa4PJT/CAoDKEv2VH/pogt5dPhQzV9oMm46DFOeUsd0gLr8USRK7
         MLrXV0a0s5UrbfcoRHbx3CTHoKNu49wwtmG/KCcjghS8KeHzf1XF1brLi97sBLYRRbuF
         gki/hehn/7/L7Q57DU1TqhhxzGadu2Saphih+nXFlsPh7yjioS41pXHAax0LdHUHjHj0
         LK1LbArOKeX/owAbiDM1L+SrYbx0tJCEcwKGlTssLp+iCU+curc+dxEFDhgjqjOvrP/9
         ZJESLuIyGt9xMr9eo5hILdRjPfL88Ggg61ekDhUx+RLBXcSiGMv7P1FcEYHTxiA7uB4j
         1PoA==
X-Gm-Message-State: AOJu0YzPcCAoTPTKlT3tZjf8rvz9Cm0HIXmT8GwA7zG2hNu5AH/1RCRa
	H+IJTKA0rkL/aIEZGB6QhPmWllTao7hfrpFq9HUFTKJug0m+vCnv8SKr/vCQJQ==
X-Gm-Gg: Acq92OHWiN7DBy6OcMkGsX+1nPyjQFYRsO/noAMEQGm9/SxEqAATIN28HkSalutmtN7
	ALQhONidjrjbCpfQsmAzHnmKkDhHLRNRvn4xSILqF97RiQ4kLP5YghFhuUDioOMh7sRUtanPohM
	LVxkzrj+9VBXU4ppRvcPIy9YCvuxyXEq9Ms36TX6Y8e60VRDrECJBQceUr/vQSYfHY6btFqjus7
	CKt1tAuncxJ26rVNjSVlqUxQGVWrXCy8Opm49W51p5oNq+yRQebGzIfezyerHkMIvTzwJ2ib9qD
	d83rBQFJrfb13wY1kVyLHgQQPFqQosZAUDNXsxfKzu+pDNnmuYgVbuBiA5G9C+oGtlAvRjzTuuY
	xC1iFNEynRVi+BhfcWvYBpcu345RH3/j2GMvQbxJ37JE9lt5lDqfoif/+/oVKjNoT0l/5Commew
	BvjpU4HSDzDM1DgErX35MWtkqCIYsTVMjLZeLYae9fV0oxG5CHLYd63d0Q
X-Received: by 2002:a05:6a00:3e07:b0:842:6419:3ed2 with SMTP id d2e1a72fcca58-842b0eecc85mr20876172b3a.33.1781012981731;
        Tue, 09 Jun 2026 06:49:41 -0700 (PDT)
Received: from Pushkar.localdomain ([49.37.115.98])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm26521690b3a.61.2026.06.09.06.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 06:49:41 -0700 (PDT)
From: Pushkar Singh <pushkarkumarsingh1970@gmail.com>
To: pushkarkumarsingh1970@gmail.com
Cc: git@vger.kernel.org,
	gitster@pobox.com,
	peff@peff.net
Subject: [PATCH v3] transport-helper: fix TSAN race in transfer_debug()
Date: Tue,  9 Jun 2026 13:47:42 +0000
Message-ID: <20260609134741.4727-2-pushkarkumarsingh1970@gmail.com>
X-Mailer: git-send-email 2.53.0.582.gca1db8a0f7
In-Reply-To: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>
References: <20260604132327.277693-3-pushkarkumarsingh1970@gmail.com>
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
Changes since v2:
- Treat an uninitialized transfer_debug_enabled as a BUG()
  instead of silently treating it as disabled.
- Follow Jeff King's suggestion to distinguish an
  uninitialized state from a disabled state.

 .tsan-suppressions |  1 -
 transport-helper.c | 19 ++++++++-----------
 2 files changed, 8 insertions(+), 12 deletions(-)

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
index 04d55572a9..5b639bff3d 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -1361,24 +1361,18 @@ int transport_helper_init(struct transport *transport, const char *name)
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
+	if (transfer_debug_enabled < 0)
+		BUG("somebody forgot to check GIT_TRANSLOOP_DEBUG!");
+	if (!transfer_debug_enabled)
 		return;
 
 	va_start(args, fmt);
@@ -1648,6 +1642,9 @@ int bidirectional_transfer_loop(int input, int output)
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

