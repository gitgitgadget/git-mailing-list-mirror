Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83CEA2F0E5E
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 09:39:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752658766; cv=none; b=q/GnauYY8eqAKSeDKeLtceW2M2fL5uY2Hsa0+P3jheWtoatYPWV0ugvKgwy8QTytU/JYgnWpLuGWmaaIzv2No1gDaP/WvBr9NCimw0ZJm7wllT78KYUKm2lAqefRXcsvrCrTz4N7aIJwC9can/S5do3kNk5d4O56H6ZWy62pfwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752658766; c=relaxed/simple;
	bh=gPmqIGUo4U4wyOXYaMkwsg5oKq9UaAtOnKmCxXnHIg8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SIyecVHbwPRAw75KTlMiN/DSKtD3ziohvsGKjIScv+JPQLDg3qbIZmJKwOTc1EX3jrZ4Ym8DM1iB39iCIb8QwmyHT0wSigVjuyZXO0zOqMTF5sPP4uBHtcxbV3fJpgZOu7x6uurPYUhBlZTRfg7MaYwem+35DdSD0bYdfL8tXvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BBc89MZP; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BBc89MZP"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4560d176f97so39698305e9.0
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 02:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752658763; x=1753263563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KhEQ4V8uoDws6tCkxlbwcINhCePrVBQISiUlPc3ULFI=;
        b=BBc89MZPkznx+xSd7rm38HnJkFMVOxW+NVmYyxdu5a4tU0KGBi7sVR9M31ZsLfYwh8
         4jIm5/cXoXeKe+AkDTWx0qrF5XhctkqksDiDgn0Nz8OvX4zY72lqH4fTGuq1HBbor8y8
         ENDavZFe09vUR5+m4YnnIubsmisUaWm6zDa64sC1cn66P0QFdyIzPKZKxbybUcnK/VE/
         +4PjStF5ApBsl1xtqY3WJxEMA0cbRPO1u6m8UigD29Qkqm0F2b/hqjknwdWqxvD6xsUz
         XpzFntRociIUdS688dITOyJHbY5zQN5ZjF9jHezw2fMU3xgncWi+WFpKdhuaU0dX9D8E
         a3sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752658763; x=1753263563;
        h=content-transfer-encoding:mime-version:reply-to:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KhEQ4V8uoDws6tCkxlbwcINhCePrVBQISiUlPc3ULFI=;
        b=ltuqQw4Y7KfWGXxZkHhaJHiko/xjujcai8HsryWjsxVwQZ3BnvXLPCHIaX0GP3Uesi
         fVcjyyd1Mt799s4bnjJmVVg1vCrUhMpN0e3HQNfecuQR6EsVTtueSsQtstY2xOBCUSyi
         KxAueojv1S8SBfB4FZf0jvSqyw2DRhQhr1+YZdmX2MmwDJVcu2hzdlbY5+m9KD7V6pAX
         5/9j6YklZz1uwUKAF1dRRb2BODNc0fBzJI/EsCwxS7c5X1H9swtDm7FVlYb7b+uZK9FU
         p1iZ5t+sVSMhouFCDVKhYTGSpLAtuCpZYQ/juzWE5udxtULA8HgpXrut4KBJZ7gPrrSG
         XEBQ==
X-Gm-Message-State: AOJu0YyVs13+MKZGyOD+3CwiS8rM0E0vA1fG1Q52hdACRWPs/ZQPhKS1
	IzOv88P5ihIGe4FfC5i9ebNA77BvLBSDUQf5zwfSUu0xzLB/PH1OD2Xevl9mDA==
X-Gm-Gg: ASbGncuUg/3dTS2eb6UFN1723wkXlG+zVxPhRG/lqVNYK5LC9jS32c4bx+3UK5hpaMI
	u3mTfcyqtC+UruCR+UkLObN2HJba/Np5WpAdcl7O07UgcvwK3HiktZdXudyTXwC7rjyilpZtVbO
	3jQmcwkoPzVJWPfxM/ppcsAAsiH6cFjD2wpPwv99peO6JWGYEV5f7ab2OZseC1f6Qnuj7nGHmsa
	cCkz6q+wVEVsdscHJdFwIQ2tXJwgLA+p8GznSyqVlQRoPpeUXd0inMVqrTb2KCINtrF5fxSFPQB
	8P34dBNWN+dzU/jTEc9WIohOA/kG0WcrY6ft1POwxwoC5qWbwYe+o5U9GHM/relg9U3lbT5VSm7
	9HuoEbAl8/2Bit5ywJbX1vpuxUaDJZjhlyLHdwi9WLw0K
X-Google-Smtp-Source: AGHT+IGb8osNdIRv53H6ye/bxQAWmCV+Oo4UUSCoIFegE5jlO9EXpYda2B8wnh+9aEF7N6NCIO4itw==
X-Received: by 2002:a05:600c:a00c:b0:455:de98:c504 with SMTP id 5b1f17b1804b1-4562e2bd5a8mr23904455e9.0.1752658762577;
        Wed, 16 Jul 2025 02:39:22 -0700 (PDT)
Received: from localhost.localdomain ([2a0a:ef40:7a5:4701:8cee:45ed:2bd5:e17c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4562e802ae4sm15592015e9.13.2025.07.16.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 02:39:22 -0700 (PDT)
From: Phillip Wood <phillip.wood123@gmail.com>
To: git@vger.kernel.org
Cc: =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	"Brian M . Carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Jeff King <peff@peff.net>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: [PATCH v3 2/3] git-compat-util: convert string predicates to return bool
Date: Wed, 16 Jul 2025 10:38:29 +0100
Message-ID: <26c3f48ac6c150b438c7b2f442f55a3d17141345.1752658700.git.phillip.wood@dunelm.org.uk>
X-Mailer: git-send-email 2.49.0.897.gfad3eb7d210
In-Reply-To: <cover.1752658700.git.phillip.wood@dunelm.org.uk>
References: <cover.1752499610.git.phillip.wood@dunelm.org.uk> <cover.1752658700.git.phillip.wood@dunelm.org.uk>
Reply-To: Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Phillip Wood <phillip.wood@dunelm.org.uk>

Since 8277dbe987 (git-compat-util: convert skip_{prefix,suffix}{,_mem}
to bool, 2023-12-16) a number of our string predicates have been
returning bool instead of int. Now that we've declared that experiment
a success, let's convert the return type of the case-independent
skip_iprefix() and skip_iprefix_mem() functions to match the return
type of their case-dependent equivalents. Returning bool instead of
int makes it clear that these functions are predicates.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 git-compat-util.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 5bd69ec0403..9408f463e31 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -897,35 +897,35 @@ static inline size_t xsize_t(off_t len)
  * is done via tolower(), so it is strictly ASCII (no multi-byte characters or
  * locale-specific conversions).
  */
-static inline int skip_iprefix(const char *str, const char *prefix,
+static inline bool skip_iprefix(const char *str, const char *prefix,
 			       const char **out)
 {
 	do {
 		if (!*prefix) {
 			*out = str;
-			return 1;
+			return true;
 		}
 	} while (tolower(*str++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 /*
  * Like skip_prefix_mem, but compare case-insensitively. Note that the
  * comparison is done via tolower(), so it is strictly ASCII (no multi-byte
  * characters or locale-specific conversions).
  */
-static inline int skip_iprefix_mem(const char *buf, size_t len,
+static inline bool skip_iprefix_mem(const char *buf, size_t len,
 				   const char *prefix,
 				   const char **out, size_t *outlen)
 {
 	do {
 		if (!*prefix) {
 			*out = buf;
 			*outlen = len;
-			return 1;
+			return true;
 		}
 	} while (len-- > 0 && tolower(*buf++) == tolower(*prefix++));
-	return 0;
+	return false;
 }
 
 static inline int strtoul_ui(char const *s, int base, unsigned int *result)
-- 
2.49.0.897.gfad3eb7d210

