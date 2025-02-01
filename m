Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FAA81CACF6
	for <git@vger.kernel.org>; Sat,  1 Feb 2025 21:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738445605; cv=none; b=Qi/DQAZFsbtpOsiCB4Ga8G27ulZ1iAmXptdaoyIBOrHxewVm9HF9emmliRZf5huVuRhyQ6/i9TZjDE8tqJJ0NN+IwOYdboLbCwGfGgIrh+xO7Ck3xJUfIDsKi6oIllgMfqBlB8pdDJCXF2xyYmCyKK3Yw32I/+dx4022I7ivOgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738445605; c=relaxed/simple;
	bh=WkbSfWbYUei+bbZn6geYpHIsCnei6Fc5m/gOOIJgv9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q9hdP2QJ7KrsYegvpP6O2PaCoLi2hFsEouppGwrh/WceWUravQ+jaK/rNj5vuYNYUEKIpUkUYspJL+V0bW4HQwW2K+FphQh+5bZ+/0V5IL2zo6nj2xg+psY4b1Orv/NXNrSGcfTX8WOJrMcXfYG4BDWW6LI1ynoh7aTefgF2o10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ky1pPcuH; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ky1pPcuH"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-2f43d17b0e3so5448066a91.0
        for <git@vger.kernel.org>; Sat, 01 Feb 2025 13:33:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738445603; x=1739050403; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xpNvGGqZTn1WQSRjUYmsegi7K9LliL+/NFg0+znF63k=;
        b=ky1pPcuHhn3veubi9x8znrXxVwT/JMk+w3JbYiAl4M5X0YarKKe2g2aESWA/hDhSB5
         JBBT7KBh9pu8W9L6XOGQ5N3D+odaCBZS6qO/B8N/0RLCFQAxjer1qMhF6cS6EodPLpSn
         o44gmc6KQpwetaQGt1Hfh1cb7KIL6NUoY2r7P3ariH4PxhiHWqrHL9zmfp23UjZQ/Mzu
         UJe+Qi7WAJ47In6aHxzZPZQWEfSwF6HoPR9l++ZCowkh+hLmJi3ijshNAcohWmB8x+DA
         VcUuKf83ToWFkdwIzvvaKtWz4UyTtq3Nv8aRE1/bjv3/jAx4r6cOxNUDQfAUKKjFJLFr
         QceQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738445603; x=1739050403;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xpNvGGqZTn1WQSRjUYmsegi7K9LliL+/NFg0+znF63k=;
        b=hGxyv6RAcbQ0SAS7a5wATnCmxdB2uPOGcsJACtkdPua+sjRhlkj1zP8nHF4WddZkgb
         ER3yKdP+d5Zdac87Hilp7m7HD2mDI8gqkgJ+fjLx4DjAhE2gykBHFwVOExcALsmCPWg2
         /jhNEHqsAg3FFPcuRLBYsuvsaNfy1Ryxubeppe2h+vgdfgm8FeXGcNmL6m3USlZ0ZvRk
         Fwvm6L5NgDCfkaSz676ynux4Y7TDPePniX/3KSP4EvxH6kkqQ3X+Fr7USKC0WVm0oXk8
         KbbpaObV2rpCyAssxzauLyi02Mp0UD5VZqWO8tknbXzmWYqhml470FLwJ2+P2QNjtTyM
         rT/Q==
X-Gm-Message-State: AOJu0YyuooCy0xn9FswLhoU2RtPxMAvtIY0mfq9OHHy15vrQXzOR/uQ8
	4ZjEWjP++m+dUw+PgXVyo/4pKJHpsmcDmLQ3IJgAJ2u5s2Ie6PV77O+Ynw==
X-Gm-Gg: ASbGnctQnm1inhW293p6GCCuXVGuchZpmod5JBQPnYKYwDCTriGcS3ghJcNfA51J86i
	Hd3BAB5MQg1mJ0U4mKNHdlnAFBysuPWrcrQuwCOMvWfVYqTT265d7hDEV/adRnhyRgKdPl0IACN
	ToFqi64YcUZfKHGgFoR+yx2i+/a4jDtba9Er7yN9wtJk/N4TrEcu+YYBiJWkBAp9HOTMlnSOXG3
	yBMG0hCz2kxSlonagNmhlTxIg80oBOxydLQtbGFBUzaEubcrmJxOt5Bya5fIEZtC9m0+3TDT0H3
	/9ezg4aclMP3rUFPKHiww34AZZE=
X-Google-Smtp-Source: AGHT+IGXLYSihCFv7MieBcHUC/dDnUblmyNEGOZTAtzru6I20YtdyR07sWlRwJBRG8ehEvYCZjVosQ==
X-Received: by 2002:a05:6a00:2184:b0:72d:3861:895c with SMTP id d2e1a72fcca58-72fd0bf47f2mr27095435b3a.8.1738445603290;
        Sat, 01 Feb 2025 13:33:23 -0800 (PST)
Received: from localhost.localdomain ([172.56.122.18])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72ffde3d977sm2453292b3a.177.2025.02.01.13.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2025 13:33:22 -0800 (PST)
From: David Aguilar <davvid@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Yongmin <yewon@revi.email>,
	Jeff King <peff@peff.net>
Subject: [PATCH 2/2] help: add "show" as a valid configuration value
Date: Sat,  1 Feb 2025 13:33:19 -0800
Message-ID: <20250201213319.153109-2-davvid@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250201213319.153109-1-davvid@gmail.com>
References: <pull.1869.v4.git.git.1736760824201.gitgitgadget@gmail.com>
 <20250201213319.153109-1-davvid@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a literal value for showing the suggested autocorrection
for consistency with the rest of the help.autocorrect options.

Signed-off-by: David Aguilar <davvid@gmail.com>
---
This is just for consistency with the other config values and
can be dropped if it's not useful.

 Documentation/config/help.txt | 2 +-
 help.c                        | 2 ++
 t/t9003-help-autocorrect.sh   | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/help.txt b/Documentation/config/help.txt
index 676ba3a55f..b369589cec 100644
--- a/Documentation/config/help.txt
+++ b/Documentation/config/help.txt
@@ -11,7 +11,7 @@ help.autoCorrect::
 	If git detects typos and can identify exactly one valid command similar
 	to the error, git will try to suggest the correct command or even
 	run the suggestion automatically. Possible config values are:
-	 - 0, "false", "off", "no": show the suggested command (default).
+	 - 0, "false", "off", "no", "show": show the suggested command (default).
 	 - 1, "true", "on", "yes", "immediate": run the suggested command
 immediately.
 	 - positive number > 1: run the suggested command after specified
diff --git a/help.c b/help.c
index 55425c0d97..8d91afe851 100644
--- a/help.c
+++ b/help.c
@@ -574,6 +574,8 @@ static int parse_autocorrect(const char *value)
 		return AUTOCORRECT_NEVER;
 	if (!strcmp(value, "immediate"))
 		return AUTOCORRECT_IMMEDIATELY;
+	if (!strcmp(value, "show"))
+		return AUTOCORRECT_SHOW;
 
 	return 0;
 }
diff --git a/t/t9003-help-autocorrect.sh b/t/t9003-help-autocorrect.sh
index 5ebfc00f52..8da318d2b5 100755
--- a/t/t9003-help-autocorrect.sh
+++ b/t/t9003-help-autocorrect.sh
@@ -28,7 +28,7 @@ test_expect_success 'setup' '
 	test_cmp expect actual
 '
 
-for show in false no off 0
+for show in false no off 0 show
 do
 	test_expect_success 'autocorrect showing candidates' '
 		git config help.autocorrect $show &&
-- 
2.48.0.rc2.34.gefa3f50b25

