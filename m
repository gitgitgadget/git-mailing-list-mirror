Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B872C324E
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 18:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760378579; cv=none; b=fFZIdUl1mlyaE56TRFmc5jx94Gqyi1tNyBAe6R6biX46a0npj/dJXs0xEGfXuaFnD/HyMy+vST5+lMYYbdt2nDJhNZfwQUdrHx6PQg8TdXbt5P1UlevGdhxuEW+k+tjS1UN0c3+5pv9hnNZ8FqHTCy+pmO6PgNb80a/LkcA9pO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760378579; c=relaxed/simple;
	bh=+XZGfb5kbtqmuvqr2sJv95IJvHNy1xFeR3txdZfOpcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rt41p64PPZ92XRVl+yDqKZkOeBYWPc1SelkT+90FTfRFSL3NikTboxMqvIIe68UbRq0QMjidf0GcGrFA4ypQXs3GO7ClxYESmX4qwmYYngH3PA2sfFlX/6N5eHqdFnsG79Itk7lTUFtEwQXv8Ou/69e+C19tuhocERlm+lRgD1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KDkR0zOA; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KDkR0zOA"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-46e3a50bc0fso33936275e9.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 11:02:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760378575; x=1760983375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T2rUuUTeEJten9aw0adFrSCORQ3j3Yam3QwhMecyg38=;
        b=KDkR0zOAnYNIBn8fR5wGwFiEy6WfnnpcrrS/Q0OZbWgog3bvxgwGADOy9ew4rHIgaW
         bNlDS6106uAQpdyp2Cvcr36J3ogXhrWm/HlJbIimkaIZTX05XbHww0G0iyHjyKZLa8bl
         Gs+6JYDalUnGfk/qPOOlxVF9xNi+P+f8oHOgai794DYr0xPV4YAPSWAWr1FkTP3htefT
         2kZMsZSEsO9SNQDOxY/BUj0Cfeai105i8LXLPjzDBV0FDNVskufPShhZr1bmIM4zGcUl
         rDk/z4+AwmZJzrOPfPgQ1GUbbnnUSS78kx/+nc2WUTdanK+W+p09dN736sdcziHECS4Q
         8x1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760378575; x=1760983375;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T2rUuUTeEJten9aw0adFrSCORQ3j3Yam3QwhMecyg38=;
        b=kRVhfdwWnMl14jLcOev9UMho42jzCHvvwIxKuwT1sBUEbpFxX8R3DelmUS17Cp2H1j
         uI0d1/nHccqxChDqA+ILcpoVg9T5fTIocR/eG1U1FH/J6day8JyqwBvTCkMNty4GqbeU
         1EqSryJI9axDWinYZmzdCu6J67HcuFdiwyfb8O/sjROrC19eIHoEFPpHbsHrAG7O0otb
         cfrOqL2vqSJSApjRKyg29eTxbsFaz5+ro6/oVOtRPYrm013zNtmkVCy1n9ycUeUDgT8y
         caXLQFRv55D2tyyJ8g7BjpqW/jzLd3lF2akkGvAdUgGVPxC299Ve3FzuB2R+YgDP/DKe
         209g==
X-Gm-Message-State: AOJu0YzAO5PtzG7S9cENYN30DCFuD31DhEEBLQ4evejeagaE0WwEAE5o
	OCfokSEecNemTGKotFbZOIZdHknNhCiR5ktxEjeVYC+cdJKT0ttfPURzu9WG/Pu0Tz2A4w==
X-Gm-Gg: ASbGncsPYaILDw654Y1NAEHfs7nMN2iKDZjIXyT0r3FCugosKaVVkMn9DIo37aFJSKQ
	NrNiTa/UjLV0wQoaHTjq7d2USaBzH9/qAebAp9DStA+i7V5/Gqtmunr7V9WQ6E2K6L07lm4EjmQ
	M1qtM0Puiam9Ak8Md3pniy0uxX/LX6UTGyuko00XIIucX45STJboLKhHVRRJsKSv8gHRkqhj7aS
	W50ydNRe/Lg+qUX1X7dcJ7eCKeu05NLFBXI/yEKF0t9+A9o0CXsvgLwi8UTnF6PIx6i/51FAtPh
	02yHd4Arz2F17QtcaWSbqhVb0NbLMYqp4SZ1XcIBc/Ze5BofpV3tGe2U0mDGAxnTIYFoBN9GW9v
	lEbDO9V7z98RsM2tjL7n38JNZYY4PR/t3Cq/p++JoZZ3S196vTnREJhzPOqg91/RmSdkXcUKkZO
	to/O0tjg1Mb3K3nfTelB2RgJI=
X-Google-Smtp-Source: AGHT+IEZbvIv4ZtpWxYuqtm0TlAaoaC3ne/Ejlrl5hsKIJJAT0lpgqUEd4Uf8sP6AY9rwgMcmyMScw==
X-Received: by 2002:a05:600c:a43:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-46fb32e50fcmr138898735e9.32.1760378574467;
        Mon, 13 Oct 2025 11:02:54 -0700 (PDT)
Received: from localhost.localdomain ([105.113.110.199])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46fb479c171sm196865325e9.0.2025.10.13.11.02.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Oct 2025 11:02:54 -0700 (PDT)
From: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
To: git@vger.kernel.org
Cc: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
Subject: [PATCH] [PATCH] [Outreachy]: remove outdated NEEDSWORK comment
Date: Mon, 13 Oct 2025 19:02:17 +0100
Message-ID: <20251013180217.248177-1-okhuomonajayi54@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The NEEDSWORK comment about const correctness is no longer needed.
The hashmap API mandates that cmpfn_data is const, and casting to
opt (non-const) is the only reasonable approach. No functional change
is required, and this commit clarifies the code for future readers.

Signed-off-by: Okhuomon Ajayi <okhuomonajayi54@gmail.com>
---
 patch-ids.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/patch-ids.c b/patch-ids.c
index b6b808332f..24309913b9 100644
--- a/patch-ids.c
+++ b/patch-ids.c
@@ -42,7 +42,7 @@ static int patch_id_neq(const void *cmpfn_data,
 			const void *keydata UNUSED)
 {
 	
-	const struct diff_options *opt = (void *)cmpfn_data;
+        struct diff_options *opt = (void *)cmpfn_data;
 	struct patch_id *a, *b;
 
 	a = container_of(eptr, struct patch_id, ent);
-- 
2.43.0

