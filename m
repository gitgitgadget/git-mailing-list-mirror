Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDF6D56762
	for <git@vger.kernel.org>; Wed, 14 Feb 2024 14:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707920738; cv=none; b=hTMnUY3nCnmdInr8WEtanzeGY2QVFLMDFu68Ym8F4IHvx6kfSy0eD5H+UECbEvcvFfb4lLt38zN9kXXIZlUD78stNG2P4qVsxFOBJ1sCyd+ybBalqnRPzz++LamBour+/znhD4hsUpxsbxk9ijxdC6WSZrLZ1yMYg0lfRhxWrCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707920738; c=relaxed/simple;
	bh=Dxc33nRNIlbA6elYpHiYl94IJgiQQMD1Pj78f3PoRxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NLCkdXCbRG1MoIFA7Uy2hrsbqmNmt3VyUMho3jRXVGzyNZDCCiU3ALPnoKwLV0muMNBpFjonjY1+ACkpVOCxiSo2YS0gM6Im5/y2zTNWciXZiJbBwIbl/EcWJpsMAiREh80/DmQAZAMjIkJsCrDQ8LgnCo/Nk4pE/NVUDdtmEpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hue/R9kD; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hue/R9kD"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-411f03e5c46so3349055e9.0
        for <git@vger.kernel.org>; Wed, 14 Feb 2024 06:25:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707920733; x=1708525533; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gnUxNkCNK+Mk0z25u0z4dFKFaLh9Oge/JjoqROpyqc4=;
        b=Hue/R9kDX2069L5XOxqDL02uFLEqwQB5LvHFol07FRI47dnmn4Lp/G+x89U9NsqLko
         tplqiX4xAB4mOB9v99snAv3K5DvPEUGqLm/55napT7IAnftMOcdnKYWrmiMXnDhbEpyu
         OFCU1R3m46+wtkFPAS6Neqb+kAPxA6BYwjswGiKLPdykO5tG4XAv3TYgAoWi/g6ddPx+
         0DidKKBq7zLwUpH1YTNbMadiBSomiWUsxuRRo0K/AJujakGEC9RbklX8vzC2SulK1Rf5
         /jDYWqOMh2Ub8nJ86ReDDNyA+I0QIN2zCpcRQN8Yc9n7VxOvf06U6CAjFwWhRHSNhKYH
         pK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707920733; x=1708525533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gnUxNkCNK+Mk0z25u0z4dFKFaLh9Oge/JjoqROpyqc4=;
        b=hcmIGItjPGnmn+4BC4oaOXr3pjEpcNs5lby8Wi89jr+XBTBYZUdCaeuT+WDr4FouUc
         cKUahq5EUVNPaN8/YV+l6Hc/zmVi9+16wU+4/nabRgcneA78R/t8Q84HLU1ao1jYRmXl
         qT0sp88LVPrZgUIixc5wKNA04Do2ZMTmC25LSNxadS/XdSbt4l3AF67/0cvxz65Z9fMj
         6qr02PzYM/ZrLH9vypbnDICPyhteVvXmKXhItPB+hS7mk4NAmue9GdnjkZHStsNrtZtT
         o6l+9If0YCK1KlddTiLEMpsmkUrGAmFPO1842/W4IvVWRZP1us/w4t4z7fIk6JCGXt4f
         VziA==
X-Gm-Message-State: AOJu0YwhY/EmVu4nyGrxh1R3Q6UHIellPCI4qR6cpHy4715DOSMZvuM0
	8HrkzQomvALINF/F8oPd+I75wc0xcAr6F/mcCU8nOwkdJFT55XlnKgya40Sc
X-Google-Smtp-Source: AGHT+IGV+AG7Epd/2JWu5JTELbGDs8A0sYmbFZO797EVt9t00TQ5o5GltRUCT4i+hxEZsFaR3Smg0g==
X-Received: by 2002:a05:600c:35c1:b0:410:99ee:d65a with SMTP id r1-20020a05600c35c100b0041099eed65amr1738208wmq.20.1707920733203;
        Wed, 14 Feb 2024 06:25:33 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXK7d0wvp6fVsWsSiMw6SK5PKojRQGP9ZV5OZO/9ONz7Iypv2dxPxpXprI+snasMqdcdRmnqr0Huh/T5oAwquoKG1IKqV8XzDNuDVaVA+7u85ZW47bfoVtRzcLZzGP6Zx7vh0szqRAyF2soqaBsEp96co7w4BDehPyV4LpfFe2wFc+6YkiNcZEdCbtrvIeGynm7owc+V359gsr14EqqA/z4Di+CzCMWKyntGV8j3oLz
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:4d2b:b120:8137:3062])
        by smtp.gmail.com with ESMTPSA id z1-20020a05600c0a0100b00411ce6def3fsm2146871wmp.38.2024.02.14.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 06:25:32 -0800 (PST)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	John Cai <johncai86@gmail.com>,
	Linus Arver <linusa@google.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 2/5] revision: clarify a 'return NULL' in get_reference()
Date: Wed, 14 Feb 2024 15:25:10 +0100
Message-ID: <20240214142513.4002639-3-christian.couder@gmail.com>
X-Mailer: git-send-email 2.44.0.rc0.51.gda36843b44
In-Reply-To: <20240214142513.4002639-1-christian.couder@gmail.com>
References: <20240208135055.2705260-1-christian.couder@gmail.com>
 <20240214142513.4002639-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In general when we know a pointer variable is NULL, it's clearer to
explicitly return NULL than to return that variable.

In get_reference() when 'object' is NULL, we already return NULL
when 'revs->exclude_promisor_objects && is_promisor_object(oid)' is
true, but we return 'object' when 'revs->ignore_missing' is true.

Let's make the code clearer and more uniform by also explicitly
returning NULL when 'revs->ignore_missing' is true.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 revision.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 2424c9bd67..4c5cd7c3ce 100644
--- a/revision.c
+++ b/revision.c
@@ -385,7 +385,7 @@ static struct object *get_reference(struct rev_info *revs, const char *name,
 
 	if (!object) {
 		if (revs->ignore_missing)
-			return object;
+			return NULL;
 		if (revs->exclude_promisor_objects && is_promisor_object(oid))
 			return NULL;
 		die("bad object %s", name);
-- 
2.44.0.rc0.51.gda36843b44

