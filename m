Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40543FB1B
	for <git@vger.kernel.org>; Mon, 23 Jun 2025 22:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750717948; cv=none; b=KaadGWlnoybKC7jAOpd6VZ4/zlb4G+3xWoAQ+BfnShtEP4HFdH2F/OEp7rs1X8ha/DStm3moPuuoAwwJ1WAHV4xb3vLnEoGpblvDlPu9p06wHjAQUpnSavd/J99gfbrITrwIuYSbGEKNtUBSKiTFcLMZJrCKGt3jmurvpbtDKio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750717948; c=relaxed/simple;
	bh=oS9Rw0q5B8SlONPJERQ1PJP3j32Y8QaK6VtYJ0+cvks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SgkOje1qGcuaopmy2NYULRBDcRCFTgHZcmTPRdLkiuPvIrwvPBpJ4ip0FCAcE2hkZjnVkP7xT5T5WGHWNOkJDclmaLl0Nquv6EJ5L/rIsVQAkuCpJ2i+i2oyrB35RCs80XUSB9/8uA3HWhEsFKO2d+A2AFZJjkTqLFPMRTGBD54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=qifANkDU; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="qifANkDU"
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-712cba3c6dcso29449967b3.2
        for <git@vger.kernel.org>; Mon, 23 Jun 2025 15:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1750717945; x=1751322745; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=t4zq2j2+A4s3Qo9lswIHHjlcildVWNkJqAorXsOtYxU=;
        b=qifANkDUlPXVtPm2rLSzvHFVHdD1QxdxtihKzRkGJL1uqV0IuBaC+KFiyBxRWkGuXG
         xTkiTepS94hyRwtmITFSFlKZ/R/P29Mmwym7f3PXws+FoN8iJHNeI6rExt/DjGOq4lu4
         4i9Owmv7A10VV6HRe3c614qGRfHkbB6nAxWVYXKNWbRDp0oy5/qEwb1p4Rv0i/bjuADQ
         5xKL7lKiDtejTEGlJRH0KCtdgKEmKigb/h09hlQOfItTYz7IH2l3AeIHu9Q+eJN65jUs
         LseK5QZjGLwUQin8z3OKlSAaLs2EfYEnNsJlIOBZMBVWDkvIDlJuvIJe6BV2ZsQsTIg0
         0c0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750717945; x=1751322745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t4zq2j2+A4s3Qo9lswIHHjlcildVWNkJqAorXsOtYxU=;
        b=a3pObo8sWMRwocJ7GrgXwNQNfi4znuAJygBgudMJeLbq0Gvyxh/4MXwetEOUC69mOx
         aROtx2hSdkYyZnDVjA9BJ/ASOagmzlnnW52TjjK0s6dcdKLsNAuyxrydEQEjWf0cuJ37
         hQ8O3XAi7ekPvpCXE3zUTDJJt/iRtcs+BcYOUfk+GsPrQ/EZzlXGg15BTCiOKohjfTlY
         s1FKJWQ+GrUnwY24lx4Nvip1MYLDFKzxqopEW7fObNjtcETURJ2wuvHpVGqwXi0bAEft
         QXzQJmkXudGJoL5ZC5sLFmrFbBRiR1h8aM2AfNznFzRYjWCNp8sFlrrRs47ZqzHm2Ohx
         zFuA==
X-Gm-Message-State: AOJu0YzH0824RBgDMtRnAKvZx8IzyxinMf6y/ppR9qvUVnMhiB4v5+1a
	gHF7CNtzhAFkzzQxNBSOwjKajQUsdDoPbKdMUzK4FgV8dZ69q0I3FeY9toXuRKf+Q442804Xi4c
	Qgngh
X-Gm-Gg: ASbGncu0NGMIwKlxcMTfrkVpfSq3HLFIV0WcpNWFCKp34gFO8SGQ43CGAgIds1RiNhg
	thX4ekfwH4XaAPyOa4OHkAIUtMMu1JBcpThtLHNEgHmAllXVeNRydBSelDB5YN2PDbXGdSxPiUm
	D6/LTbVpLgddHAOAMnrYNZRV/tFnjEnR9CN0GNPmRa13l2PA+GnTHdP2uaRrhMKHbXm/2wp7dNE
	UK8YnT7IFapzQ9DxENAmOZ2A9qmHSK6UYhg2e43AnYiwTNW7KR/D/s5+WTXoe8eAlu7YxDtBM4N
	BeABUAPzRFfMb73rz8OoWg4WbIscmA37gk7iBGfogASGerq2OXY6hJ/2Oi94EqUQC30dcPttLHQ
	MFeJ8M+b/1PmvCsQRGyyroQlSuSbwuL57xg==
X-Google-Smtp-Source: AGHT+IFOFpp3bA8pNtcY0mOcQNE3xbK0kHZp+4AR2CyTaCTn4Sho85FP+67jRx+m44F+ZIVBD0FjIg==
X-Received: by 2002:a05:690c:6f92:b0:70d:f3bb:a731 with SMTP id 00721157ae682-712c63a8f60mr193170527b3.9.1750717945574;
        Mon, 23 Jun 2025 15:32:25 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-712c4bec110sm17516527b3.105.2025.06.23.15.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jun 2025 15:32:25 -0700 (PDT)
Date: Mon, 23 Jun 2025 18:32:24 -0400
From: Taylor Blau <me@ttaylorr.com>
To: git@vger.kernel.org
Cc: Elijah Newren <newren@gmail.com>, Jeff King <peff@peff.net>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v6 6/9] pack-objects: fix typo in 'show_object_pack_hint()'
Message-ID: <f31dd00a980669e746c5e8f1297c0a4b1f9b41b5.1750717921.git.me@ttaylorr.com>
References: <cover.1744413969.git.me@ttaylorr.com>
 <cover.1750717921.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1750717921.git.me@ttaylorr.com>

Noticed-by: Elijah Newren <newren@gmail.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 builtin/pack-objects.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 3437dbd7f1..9580b4ea1a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3767,7 +3767,7 @@ static void show_object_pack_hint(struct object *object, const char *name,
 	 * would typically pick up during a reachability traversal.
 	 *
 	 * Make a best-effort attempt to fill in the ->hash and ->no_try_delta
-	 * here using a now in order to perhaps improve the delta selection
+	 * fields here in order to perhaps improve the delta selection
 	 * process.
 	 */
 	oe->hash = pack_name_hash_fn(name);
-- 
2.50.0.61.g1981e40f2d

