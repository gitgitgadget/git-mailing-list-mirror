Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FC0D3B8BBB
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777293691; cv=none; b=F5vEzE21UBnqIotb0wWim5VhBqkcUii46lOgcwCT3yARI7tIF7KThW2hJncXt73BCbJuunP77j/TkpstarIMnQ0GddIbubEQ5NyEI++dRbFPGD/jxY8v3G1cMracL28CmxZvcsNH6c1JW3/W7vbVlvwDcyGl8k+drQL8abGoZGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777293691; c=relaxed/simple;
	bh=V86hC0vHHEGBZuTlOThoZJlQrveRVql517amhktT/hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E7Y3fZV7jOZDt+JDqapkxc4c+L66M4vdChZ90zsa8vA0DkSXJpTJqb0f51HGYxCLD1hgW0P9LznxgI/g9wDJ2cUuB0lQ9X623+UM2/TQtsVSNuEguaPlzidMZrsvmZODu1p2FV6IYXbCXZbn7plMcZM65+2ehXzr0xdX3CCGuko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=soowpu0Z; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="soowpu0Z"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6634bb959a2so13678884a12.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 05:41:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777293688; x=1777898488; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1KkhxjsyRcnJTrUjtJgWHdYDv1dUQDhWzX+W4wBjKI=;
        b=soowpu0Z/Hcsr72Y4N5Xj0XQKJtPeHKc5uSEOAAaBHZTxNuiIZ2WBqSjRE2zfrySb9
         DucAd34BLHoA+3R2+fwTyYEHZwTS/MMflgUFQPpX7iIC9L4enxqXkn6wavD982yVQY54
         lAG6rfXbmukKG/MzaTu6leGyiZ330fl4RehPHWbbgSPuE6cU5Yb7VjuGSKTNsLWc8hbU
         /O0nIq/xGV/dEu5+ZpaXS+K/K5ZAWlUjjMev2yqV1rgB8q9jGNcr3UaPCAYmTFNnJV0C
         KBNafymn8iPdCEXtXPnrPgZtmuYDYSXZNPSW9KDmgPqLyhdGwymaTa4gzDhWmJarTEyD
         ug0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777293688; x=1777898488;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=g1KkhxjsyRcnJTrUjtJgWHdYDv1dUQDhWzX+W4wBjKI=;
        b=mbIsKQMbMFjZQ82Ua594yDfjDqhOqwWXvHcprH2149OvYA4O6y+VNxXzfE2ap23g6I
         MplDzyjfGL69690pIoGHDfC2f1LnPTDwHqNgyFj/1aLoRypyF275Y2iVtqLxy/zrGmHg
         aQdHygEG0f9BTbpHQbJ/6URQfSa/dzgOIv9ZghFp1Kwusf4zzqLwd2sBFfgvYdueCinZ
         NxH8ErEtwYoUC1z5Jqdyi+I1Kav09kJdJpP31E+TxlTsPEWaWpZkMJU7mzz8Ov/5QRtI
         5AWw6Kv+kFqC96+N4WER6Olo2PZ/JiCJ0UIdorvVgWBPZBpDQl6vSItxxY4gD8tEtNEv
         sOJQ==
X-Gm-Message-State: AOJu0YxsnoIU21HHoX9bhv9RgXz0RSjeLqRrOokUytAQ3zaQhONQyymo
	EGhtCGDC/9a2UjOxRrheSz1OyxNbhp5HlkXjDW9Agv8+jSX7hAsTzLMwMjpqaA==
X-Gm-Gg: AeBDievp+RZYgu9lPsig5AP7aHDmOnnnIfjY1m6gv5bkR1vKaY9zQU40L3yYpk19N9i
	kGjd8sp6Agaj6pH5//daLtVsWTWSltz/58lrLzb+9ebzFfcVgawcEvPn3BUPARyu86C6QXvN4+R
	zuyWKKeyUC0rPUs1PD7im6yjqSiZOp1c2kYggUC0QQg8H2qLEqTk68pW1wVBz6rFFc7P0Na+i4b
	qH81SrZlbMl2bBnGmfosDHqCqh+3HNgzeBFaUOOFKSA1ICXpH1o6RJunJySo40IMTuYOQjjStMJ
	1ObPzwARzy4IzAh8IPLDuo7cTR51oFLc6NwAGR/qMXjW9QnR2dpxb5tBlBk5o+nBW3rRgLKd7Lf
	msODyXKeQ0NTZEHS//WRFQD9ysqGfrX6iYXjBGu5FlqOGzlaFXKY8cc/PVzZXhBa/0WxV9mnGHF
	QOria+T0S0joejlNnx5V243uYHMyb+WhLuLx6e3ddGfQ4h53/Kqh8rztfqI0qhzQx8myHecb+rO
	ESS/3xkP3ceqptTCQXaXnXRchvnPtAiWOvwJ7kpLECn+m52Dw==
X-Received: by 2002:a05:6402:1941:b0:66a:19bd:5cb8 with SMTP id 4fb4d7f45d1cf-672bfdc381emr17661992a12.18.1777293688077;
        Mon, 27 Apr 2026 05:41:28 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6744dcdf29fsm6760446a12.30.2026.04.27.05.41.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 05:41:27 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	Taylor Blau <me@ttaylorr.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 1/8] t5710: simplify 'mkdir X' followed by 'git -C X init'
Date: Mon, 27 Apr 2026 14:41:01 +0200
Message-ID: <20260427124108.3524129-2-christian.couder@gmail.com>
X-Mailer: git-send-email 2.54.0.19.gb68b9497aa
In-Reply-To: <20260427124108.3524129-1-christian.couder@gmail.com>
References: <20251223111113.47473-1-christian.couder@gmail.com>
 <20260427124108.3524129-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's simpler and more efficient to just use `git init client` instead
of `mkdir client && git -C client init`.

So let's replace the latter with the former.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5710-promisor-remote-capability.sh | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index b404ad9f0a..bf1cc54605 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -177,8 +177,7 @@ test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.lop.promisor true &&
 	git -C client config remote.lop.fetch "+refs/heads/*:refs/remotes/lop/*" &&
 	git -C client config remote.lop.url "$TRASH_DIRECTORY_URL/lop" &&
@@ -231,8 +230,7 @@ test_expect_success "init + fetch two promisors but only one advertised" '
 	# Create a promisor that will be configured but not be used
 	git init --bare unused_lop &&
 
-	mkdir client &&
-	git -C client init &&
+	git init client &&
 	git -C client config remote.unused_lop.promisor true &&
 	git -C client config remote.unused_lop.fetch "+refs/heads/*:refs/remotes/unused_lop/*" &&
 	git -C client config remote.unused_lop.url "$TRASH_DIRECTORY_URL/unused_lop" &&
-- 
2.54.0.19.gb68b9497aa

