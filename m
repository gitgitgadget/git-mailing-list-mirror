Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147B02853EB
	for <git@vger.kernel.org>; Wed,  2 Jul 2025 15:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751471227; cv=none; b=RyVkybb7VguOONbJieJKqeI/0G413AayxKvy+nzyte8Ntq7wzG9nz5UBrrF1s6bfYFHyQn+Ufmw5keHDYuaZzO/1sK9diwVOVRxUnrppDfdkNjbrFT8k16tXJok54S3Zirqg0c/viM+fB4+LN8fzZzSuc8SDU+ZQR7tTOYt7R/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751471227; c=relaxed/simple;
	bh=6Y32wk6Ve9Z6kbRjH+6VD5rbHv3NtI2zoh4io/DIevs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jq46z8u+/A0q6gtLGc7UXsGisrlmd5TUK8sRpa8ywo4QxW363xo2ShC+I6H7YvsPRMby2M0uC3uStjZAI20HlFTnXMkMXderK92mCtTMmjiD2M7C4V4PnWHOJFoBNqKyKVlGx9qq+L0FQ6tAxbf+/C0SQ0kX1Tlx+cPGoE39vlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eRH/Oe0I; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eRH/Oe0I"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-74af4af04fdso42645b3a.1
        for <git@vger.kernel.org>; Wed, 02 Jul 2025 08:47:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751471225; x=1752076025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pAPcALZMlCbSybxxhOUzJlgiON0AKJN6EZu3eUb18jc=;
        b=eRH/Oe0Io/9uc8rYoyJYenes2Ckf9iSbIi0E5IVXj7LH+SifrkGu7JY6Vgxi4uTy5b
         mjH5swdJwgNQRpXXZHH+jQhzue3EIRElUAUTG5SO7k8O3f7Qu2Djv6T47g0yiB+nEsyl
         PZWbvaa28qB/5kLkXsop/iCXMGP3dFMa47jIvjuBMgXgAon6Myt52uMI7IfJKLkryQhs
         Z/X4GmMtCS9FAizVKlXwy3fEFevpxRJMmm6lEFUGlOf3ZVorq1vJ1QuJ+ZqVraR55Ool
         gvYUnNwLngahjBtPrbhDn4bGxjQTVapeWXjPX/47Mil0UlJ4ZpjiNT4JZDYV4YnWAZiS
         sPDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751471225; x=1752076025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAPcALZMlCbSybxxhOUzJlgiON0AKJN6EZu3eUb18jc=;
        b=UiXhDdZoLAfqAxjO97HgDbOgFBGYDzvyt5X4vtRDEaDgPqyjfPnn5BwvD/qgiVjBFX
         3hGaVenFZiAf6+tdVfEZ15Yg4GNNaCFNPlW8GHIOWFFqt/DTz8lfQ7RwBqpQoKFPm8dm
         ybtEfmpR43MfD5RIpP90RNKmqZ4JfnOg4Ag0EyC0fXH+9mYCDqpnYpjug2BCku7JlHpX
         G0fdF3I5gYNcb9V3FLaQP+Bnrla+JiO5YWBCNZafQ5ywU303a8sR/feCi7oWCaHO2upp
         mNIKvFErbqG7iK4lqII7blyKyeTF5t6dHW1dJhZ+gvcIKpT24xUQmWus3dAOZrDP1wQ6
         GXkQ==
X-Gm-Message-State: AOJu0Yw6YwBFExlFMsPHnqbYVyfLIIs4TCqWRro/cxnlJVFfMU3rTElc
	N1W2FllMmDAaxjCZOpMceSj+VFFKRSE/3aumhGirtwII1SvavO1lLvoTmA9Xng==
X-Gm-Gg: ASbGncu4NrOmIBaNzda/A7C5X7cqw3OTH+Dg6/yxq7AdknrDJ2cYHHOEq4IYSc4HJz/
	OvabjxMuAMCsSZ8WmTxin206smugzaHFttqWwzgaI3XBjf3bHsKxPsiKsXujxw7RG+oKcJoIzPr
	Pky6C0wgJTj6PipVLwjIWGf9qahm0MAjAG0agI/9JhJ6kB0BbqsRsaKsTwDlEEMzW3/Nt8p0FGd
	pw1gemywIlXCMd1TFpgP20wdn8J56HZsShf2SBCiKL5g4sfEiV/qnIB0djs10lcNjtD+QgrGNPR
	zi/qle2/Jdg/ph5SPlg6HK/rL2VGhbW0ccnQmwkHsfz94japlW7htajIntrUov/g9OOFl6YZ+FB
	+E2MQHDN4Wz4MVIfrE4eHenBZz6E=
X-Google-Smtp-Source: AGHT+IFvk9JhFZ7w/t6ekDB8xeCfByjbn2Cp+Ni6bM/NRjVECdIq/ghtynCaLm6W3hkvYRcqLsR3xw==
X-Received: by 2002:a05:6a21:33a4:b0:220:3804:f3d6 with SMTP id adf61e73a8af0-2241173a4c6mr80000637.2.1751471224625;
        Wed, 02 Jul 2025 08:47:04 -0700 (PDT)
Received: from localhost.localdomain ([2601:640:8e80:3680:8123:5123:76e8:a897])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e300a40dsm13334428a12.10.2025.07.02.08.47.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Jul 2025 08:47:04 -0700 (PDT)
From: =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
To: git@vger.kernel.org
Cc: pclouds@gmail.com,
	brad@comstyle.com,
	collin.funk1@gmail.com,
	=?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= <carenas@gmail.com>
Subject: [PATCH v2] builtin/gc: protect against sysctl() failure in total_ram
Date: Wed,  2 Jul 2025 08:46:49 -0700
Message-ID: <20250702154649.44210-1-carenas@gmail.com>
X-Mailer: git-send-email 2.50.0.147.gafe0d4ec5b
In-Reply-To: <20250702144244.43858-1-carenas@gmail.com>
References: <20250702144244.43858-1-carenas@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the unlikely scenario that sysctl() fails, and uninitialized
value could be returned.

Initialize the variable used and make sure its expected size
was correct before using it.

While at it, add a cast for consistency.

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
V1 would regress FreeBSD, so instead make sure that the obsoleted name isn't
used in OpenBSD/NetBSD instead

 builtin/gc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 845876ff02..3958707feb 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -539,7 +539,7 @@ static uint64_t total_ram(void)
 		return total;
 	}
 #elif defined(HAVE_BSD_SYSCTL) && (defined(HW_MEMSIZE) || defined(HW_PHYSMEM) || defined(HW_PHYSMEM64))
-	int64_t physical_memory;
+	int64_t physical_memory = 0;
 	int mib[2];
 	size_t length;
 
@@ -552,8 +552,9 @@ static uint64_t total_ram(void)
 	mib[1] = HW_PHYSMEM;
 # endif
 	length = sizeof(int64_t);
-	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0))
-		return physical_memory;
+	if (!sysctl(mib, 2, &physical_memory, &length, NULL, 0) &&
+	    length == sizeof(int64_t))
+		return (uint64_t)physical_memory;
 #elif defined(GIT_WINDOWS_NATIVE)
 	MEMORYSTATUSEX memInfo;
 
-- 
2.50.0.147.gafe0d4ec5b

