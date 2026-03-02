Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17E6842EED4
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 19:26:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772479601; cv=none; b=sU5N9N7kE9Ybro6YkoTBtkqBGE0OrDZL4s3tV6yJMM4T76LlWII9bqOyqO/tfH3H04Q5Jo19WNmsJMylHyi6MtuCz+HfUi8pmX0B4bEQ2HP/vB3UWNvO//di221O+VOth/MbGYsmzVOb4BC/wAZtghaLxWZj9X0R6qt4oA3EqVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772479601; c=relaxed/simple;
	bh=V6He247RWLHV8A9nbS25qNnBAMam9PjM8RMtESBmZMU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jrSD6w51EtuIV4o7yVJkJ2W4TGd9HfColFTcCShwrPgY09m9zErz9R51TeuNP7IMMMJhrrvdnexA6Y1mbd2AFMqJqHMqWQNATRDnbjWipa8IxO1BvEIV9eeANKptNJPiPfrAyUS/Ll5XXix1i1EA63C8lps4+ftwsYEmBY4YLtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gYoAMwAH; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gYoAMwAH"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aaed195901so23137215ad.0
        for <git@vger.kernel.org>; Mon, 02 Mar 2026 11:26:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772479596; x=1773084396; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0OrtoVbYfZcSq1awduikvC41bp5NnMlyn2rvB1xAbBY=;
        b=gYoAMwAHNVejaXiwqKTnkJYQ6SIse+mZoqP+E0mkI3Wk2Z+HO6Yw2B0o2pFWm/eQ0y
         ANzTV6lCTaW9yB606XfPXQHTpTR9xVJS2obos7KBSq6pJXUVLVpAUJrIUp6sTTFd5Xw3
         YSZQROVevJ2v7ed3tjg7gt2OF9UyiO4sM54VFT3P7u931Qv5IrXBo5XueLcPQJxgxOi+
         NdWuOBQKjpFAncDZlft2t/GrjzWDKORSCMjimDRGzFRfiq1g99U4TBYQxCCrdAR5fBIa
         4UDcJzZD0a+og29NHsdjL+oxzHG+GSNiP86ZvSLiDRIetRdkVO3BqpxT5FRSzKCb6t8T
         nzSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772479596; x=1773084396;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0OrtoVbYfZcSq1awduikvC41bp5NnMlyn2rvB1xAbBY=;
        b=Oyn8yi8+hhwQHQPmE8St792dWOAWSl9r8Bx8FYs9Za3BLsw7pcMZdloyTZ6lioYICD
         NDsGM6IsxXz7k1S2r6cEMuGLusjPpHAGc6KK5mjPGrqVUCuU1WvgdBVLd4l4PboxhiZG
         VjtGZgNkmMdjDB/1aXLCUYlTSnFj92655/kvPxAliAQDeYnvVk9OtWsB3XyXr8a9ON8Q
         bcOpWUHMMzO9LBSXvdKoZWIionf6jth21ZYW6RI472m58dJbva/nD0822ov8dcnNfHLc
         qfVU1pHGobGgBSVSdzU50brdo26QyNb3JV1ieA1NV7zlUMa2ueB81tOtfzkAw9lYAoVy
         vt6w==
X-Gm-Message-State: AOJu0Yyfs4Dosw8U+6ZXr/u0dl8fXnxuHfuOjesLiXP7Gq09pUbnXvb2
	z+uHS4GqoT1Hne751ksGoKGjJV4W9e4CFjuYgEQ0T7Z4iJNIZsj3FUB8fqFb3mxEeLg=
X-Gm-Gg: ATEYQzxlrDK69rR5Ls2CjMOB6SQ0kqcJj//CReX40rwUchFfIIzFVGndzCs50Oww4V1
	nR0iW88a0t/hBd6hEhWMPScxvZ1BuwI7+0HoZFBaR4UziFTFiAFTiTUubc//163TkAEkb1nJuYT
	SAdClpfAz3WSW4lSX+VLbZ0fXf6TqFd+khkGcBGLr6liqTIIVWlIjd5sHNmR58BcFoFpBXi7rNW
	54tFrDjJhxkAFvze2SYnhE4cNjHW/LMh2IVMLv8FZbq9nbIW8jeKUpxdGrQPJH3I+44Q2E/aeO1
	svFVmbqJNDB10d3CsIl9keA1f8pAdM4R9YXCaxPeWzzT5c9S6Glh+wJNfknZaqCaMHZltTmPJLB
	YqAXQ5718T7pDt5LVq37maztKnqcNt6/Qpt8bTn3D10D79dgQokmayaXOcbdSP0d2hKqmuDyGHL
	/D2ChReci1mG208qlLsAntrHdsR1K8c30yLH13M2xMOozCWRAusocpw/uhW3NdxCznl8xGq1I=
X-Received: by 2002:a17:902:e785:b0:2ad:ca65:a398 with SMTP id d9443c01a7336-2ae2e50363dmr117795615ad.57.1772479595676;
        Mon, 02 Mar 2026 11:26:35 -0800 (PST)
Received: from localhost.localdomain ([2401:4900:5624:dbdc:8dbc:1a27:dc0a:17ee])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6b416bsm150850885ad.61.2026.03.02.11.26.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Mar 2026 11:26:35 -0800 (PST)
From: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
Subject: [PATCH v2] t: fix "that that" typo in lib-unicode-nfc-nfd.sh
Date: Tue,  3 Mar 2026 00:56:27 +0530
Message-ID: <20260302192627.83631-1-r.siddharth.shrimali@gmail.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
References: <20260302164521.79148-1-r.siddharth.shrimali@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the comments of lib-unicode-nfc-nfd.sh, "that that" was used
unintentionally. Remove the redundant "that" to improve clarity.

Signed-off-by: Siddharth Shrimali <r.siddharth.shrimali@gmail.com>
---
Changes since v1:
Dropped changes to t0019 and t6416 as the original "that that" 
phrasing in those files was grammatically intentional.

 t/lib-unicode-nfc-nfd.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-unicode-nfc-nfd.sh b/t/lib-unicode-nfc-nfd.sh
index aed0a4dd44..201ab9b24c 100755
--- a/t/lib-unicode-nfc-nfd.sh
+++ b/t/lib-unicode-nfc-nfd.sh
@@ -75,7 +75,7 @@ test_lazy_prereq UNICODE_NFD_PRESERVED '
 #
 # Note that I've used the canonical ordering of the
 # combining characters.  It is also possible to
-# swap them.  My testing shows that that non-standard
+# swap them.  My testing shows that non-standard
 # ordering also causes a collision in mkdir.  However,
 # the resulting names don't draw correctly on the
 # terminal (implying that the on-disk format also has
-- 
2.51.2

