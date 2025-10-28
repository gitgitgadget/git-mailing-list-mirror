Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B065E2D739D
	for <git@vger.kernel.org>; Tue, 28 Oct 2025 08:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761639189; cv=none; b=HmnIbdxgW19K9zazvePifXAzdtPs9BbSHPng8zcUtftf7aDPco/K4vjaG4OYF3zxYem6YH1HGJU0t/SsUnECMxyDOUjQ8pa/LkrqXJsdD4pehz+xXNOfCTnKm/fFLRLecGARfyFxN4FWqFgzQjmuUbhCxshn6TnLuqDQQj8b7fI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761639189; c=relaxed/simple;
	bh=QyTAzSfoMSqvJXUGZU63SdM7mA2bxWF5yy69FV5Ot30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sRyOYu+C3hc9zqSsAigsTj9s2iCKJ+IwW+67Yh0stYdlaleX9WaOHT7wgMnbY+x5O0RiSACSOtDHBBNukhHvCawx38duAQhklJwLfzxqZSgKex0ZaQ6uWdvfR3Uwqw7sgOwQqPcdDYMyY4pXqIxMaw7fyPpP3jHHSulHApSSUvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK3crDDL; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK3crDDL"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-47114a40161so63707155e9.3
        for <git@vger.kernel.org>; Tue, 28 Oct 2025 01:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761639184; x=1762243984; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QNDuNe7nzciCYrLkXdEUqOu/PW1HnXoC0GWzTcY9CJs=;
        b=dK3crDDLMauzMJUsVZjnBCnRlCO9hE+zMMOVNcV2nq4OC9Fk/53BVfRLSujbi2TenL
         bj9BaKStlTlEs8ZO+E1iP8QcLXu/qHxA40p/4e6bm0KjDQbTEQYzKi3y/XIe/mEDPUVh
         JvzAMulFpyBKu7wTXenf9cDfi/79famx7/RA3YMVuCYSe8805wmNHUJd7EY0tiHoviPb
         bbbXOd1w5kDP7NDRKd0yXVjhdJLfpXul3mpQMEdY8UPU7Ll0wxMZyuwfyEw54jokCW4l
         KKspg+dN+CNdGQwkCWW+nu+jLTxAKgUgTNzWuRiKEwIZfiZqVgnYw8IlT50iAP+oO4fq
         G6Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761639184; x=1762243984;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QNDuNe7nzciCYrLkXdEUqOu/PW1HnXoC0GWzTcY9CJs=;
        b=hV/0XVeiUyNN0EvhqxZFm/39df9tIWKPcXjUd1Xu9gRNndPMkn5q4TzXIAeLU+MuRZ
         epXzA7RdgjkAAqHbtoRbTM3xeIA4/8JOJHskLPC0Fjkd/5pKxrfH+x7DmZvkwV62nuT/
         gg/aTNms+8K9dQ+6zD2Igrc57qkarFAy+iwJgt2XoNl3rElWkzPCC2fxvLIUD+kvhTap
         GIR5SsOSw0+izBU2iNQKdAqQtjWw3od/Uu0+0yEmg3pN3GzYFnpPCWNPgNL1pdsXYjSc
         pcsoq6O8OVFV1lJMOiEOORd4H+XMOL4Skl1WcGuMv15ac+eTNXeTwJFpcjfgUe1gFxJ8
         am4A==
X-Gm-Message-State: AOJu0YyGX+3m5Cm+kPhQEtH0Ge5zMntRzzQJB139v9YGl7JMGNw7dZSw
	JuR9NDCqF61tclsw03Eroccj6tfGZI/YUrNZweglM3j2dFAZ0IIxW6OcPYSL8g==
X-Gm-Gg: ASbGncuy+dGlpQykxZOr1VeVON/j1SwmlUMJM4KQu0vUnRjoBVTG38p2k715SX2iH7a
	snJBkwy0XrVvQIIfyXCBGRrV1kMQ5Smw0FId5izIuLBhlDfdD9igILscpAzRJbbanvdrWN4R7A+
	nw7Vu7/Pho8vhLsbIA9acyX6PymXJdW8oc1nbpA398vwzh1cL4EzAWHUW7ACeEBYS73KgkwPxeE
	EUdXH3GPQ4WM30EZ5hNtos8UrirxiHf0odnOZJLpk3T8tKeDRin8Elf2SlSgyHEQJXsz5CDkzqv
	ZSB3wfMJQ7DJaFzYt5sNI6QdYjbxfCiq4Vtjjru0OQvj5mh2t8TJiHtap4bLfyecvakKbNui25a
	N1VkEEINLhgmk2dVfznnfvR42OosEpLRBquLpdbKtLWIc2WfkGbUIwj3yPvs55Op04Nj/1cDxER
	B6hc4JW0h1N3sW83yjnegMR42+Z08=
X-Google-Smtp-Source: AGHT+IE3lMJvj/qLJVD6hAD0E1DihcnPxmkK051ATXf+Mt+I2u0f8gmCDbR1BFzoGaIccMfByARI2g==
X-Received: by 2002:a05:600c:1549:b0:475:de55:9304 with SMTP id 5b1f17b1804b1-47717e3c8b1mr20944825e9.19.1761639184066;
        Tue, 28 Oct 2025 01:13:04 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771906af34sm12830335e9.14.2025.10.28.01.13.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Oct 2025 01:13:03 -0700 (PDT)
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
Subject: [PATCH 2/5] gpg-interface: use left shift to define GPG_VERIFY_*
Date: Tue, 28 Oct 2025 09:12:29 +0100
Message-ID: <20251028081232.3068147-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.51.2.540.g4ad31e1014
In-Reply-To: <20251028081232.3068147-1-christian.couder@gmail.com>
References: <20251028081232.3068147-1-christian.couder@gmail.com>
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
2.51.2.540.g4ad31e1014

