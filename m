Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E8D23E340
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 12:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761827635; cv=none; b=Da7uFMvkjygrU2dcesqet0s3r+Jdf3V2tsC2b7nB5SHidXGYvYURa5lPapAnM0F/y6NxyAuvEd4rnajGfPjnlq2Vu4GGVc5qgqYh2bj0q42kWr1Hh/VlkJqQJO8XZISnn/2LtfuKtcct3i6hXxr/gURo6UDVsN5a2iJn7TjGdCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761827635; c=relaxed/simple;
	bh=lfQiNbfG+hRT8dhvEjgGEbLpKiJHz8YyWfDhu6h6/cA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MC7rP0NBpCXl97AtWCtVRsZ700UpwLDBtiQsUiaHsqxZ9TlS3bCypUmRTofrQXPwggLJd8XHwORqk9/Y5ufyFURj9utKDUCWZgJVQwi/H2JIs41kVq0qluQ8ElMlJprq1zr+F5DSIvz3xoftK1lOzPSR67FSwXt/uW4BkpzTXVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KypVhn3T; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KypVhn3T"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-429a0d1c31aso656526f8f.1
        for <git@vger.kernel.org>; Thu, 30 Oct 2025 05:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761827630; x=1762432430; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVcoXPb9+dLsdGcLf4T4GwjDON9xhZUs496ve9rbF6E=;
        b=KypVhn3TTiysxUm0v5nrbcm65vEsV/x8K500Nfya2W3YtbLpyEHLCsJdidwtATwe0a
         1kxzgpVpNEy2ogW4N1WDlUUQy5UFAMOr3k75wE9oM96CqRGDeQ61OnLPiVQb2AAaa6/r
         O828op4TYWcta2NLd4uTGeQj8koCjAh/cY29fEJtETY6qWe+LUm562iaXT4lddyM+GUT
         O2e2X2MB9QAjFOFUZAKfc7xcwKXE9d3Bcy7ifOeBqCoiSPHP8shpt3rja9fLiPAe3Uug
         bpjZkXOGNSIma9jqm/1hN8rHjClMJFwFFfb0cRLf/z/BWFbYQjZRk9uDkDu8IhHMU3od
         6ZuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761827630; x=1762432430;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVcoXPb9+dLsdGcLf4T4GwjDON9xhZUs496ve9rbF6E=;
        b=EACpd2FnSGbbVOyqu0aVqq0fO079ye260Z3cRfM9Oal8O3723BCJmdn2vgSZF6cp/R
         98XclQV1+BJ7absJhJ6W2djDOdCWfzuw/t5RZNMYaDgdWIsghbkn44NNwdHV3xLS4XC2
         qSwzjaVIH+jjV5cqoYzOMCGbcEpSthQ6eBKUELhFOsh34sF0lf9IPPENtd5njYEs25Qv
         eoPt4kSHjL6T6IgmunP4eyETcAn0007UqJYSsQy9h+NFBuJHB94UWz6kWP5QV1In/6Go
         0djrC6g8aV6OZATBxsIxnXP56+cZ8TkHrqBpCPjbCuYI001VTH6eNFCpOUvwjz6HtCqe
         nGLA==
X-Gm-Message-State: AOJu0YxMR0AaP2YIu7jZO5fdQzGAOYQBw2Kx/3ozKQZqZ9Jow9d0G9yb
	2QNh07go1oYKtR164YZJ4i5cNXr11yNkZmgjkotYEqIVTkeBqaaQjHxcfFkfhw==
X-Gm-Gg: ASbGncsH/mvBxl1harNUfwxZJISBcWmX9jv45PwoT17vomO3sCoI4/dOydoxoZPCJA1
	llSoI13ax+nmeshEu3iIN4zN1gNnKg4w6RBNVI1POSx3H97cMro4wOUAPOKArtCruTHKgD121yf
	4tZEyg8CVmFsorCONbhNJAqic3sX+CysiAmovN8ZAWLigLLqIfOZ9KEqVQAKuL2vFi0pbp5R9Q8
	IfW5PEmzWjr9I5EswM69q4u3D9IAJMmhLGVLIKx7Y6e714L/6DEemJcWiqGpKUu5bo2CbjTSsq1
	7Vq3WCrxMjl407VnxteVMnwAeAXGcFKjHx0bigiXiwVyONvxfPuyLRHtKX/bWeedVHpY0fGWzWW
	hIqE4ifHphUfeXxxU7IM3B6/aw+pSG0X1S7cJHx7dAroF/XAlPPLML3KQK7ikZryzp+lpa/RYfu
	1E72c+2hBDhcDeezFwP2KEzjAhbNjMGfHTYnib
X-Google-Smtp-Source: AGHT+IFzt2EMVDG6rCxCr0LEHLxDAtKObN4SK7U1urg/wx/EfeWcFqUmE2IgcAOu75194BgWBRLVig==
X-Received: by 2002:a05:6000:4713:b0:403:8633:b7e3 with SMTP id ffacd0b85a97d-429b4c543dcmr2782356f8f.30.1761827630176;
        Thu, 30 Oct 2025 05:33:50 -0700 (PDT)
Received: from christian--20230123--2G7D3.lan ([2001:861:2074:39a0:8aa2:a86f:99be:b78d])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429ba3574a2sm2364595f8f.44.2025.10.30.05.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:33:48 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] gpg-interface: use left shift to define GPG_VERIFY_*
Date: Thu, 30 Oct 2025 13:33:29 +0100
Message-ID: <20251030123332.3337684-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.617.g2aaa867cd1
In-Reply-To: <20251030123332.3337684-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
 <20251030123332.3337684-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In "gpg-interface.h", the definitions of the GPG_VERIFY_* boolean flags
are currently using 1, 2 and 4 while we often prefer the bitwise left
shift operator, `<<`, for that purpose to make it clearer that they are
boolean.

Let's use the left shift operator here too. Let's also fix an indent
issue with "4" while at it.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 gpg-interface.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.h b/gpg-interface.h
index 50487aa148..ead1ed6967 100644
--- a/gpg-interface.h
+++ b/gpg-interface.h
@@ -3,9 +3,9 @@
 
 struct strbuf;
 
-#define GPG_VERIFY_VERBOSE		1
-#define GPG_VERIFY_RAW			2
-#define GPG_VERIFY_OMIT_STATUS	4
+#define GPG_VERIFY_VERBOSE	(1<<0)
+#define GPG_VERIFY_RAW		(1<<1)
+#define GPG_VERIFY_OMIT_STATUS	(1<<2)
 
 enum signature_trust_level {
 	TRUST_UNDEFINED,
-- 
2.51.2.617.g2aaa867cd1

