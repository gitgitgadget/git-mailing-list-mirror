Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8EFE2367D0
	for <git@vger.kernel.org>; Wed, 21 May 2025 08:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747816299; cv=none; b=NkupLtShAnB+eNurp2F8KHEICUElaf1h0neaKH5U5RYgA2EqWKNeWh0pGm6iv97U5qKeX4v+6qytYTzf7ex1x+HNHkHjJVxdwuMrMTECj2MzpL5EIgS6Ft15ZTF0OGqdXLtjFgZMvRmLmQPQnEyHE1O7NJDnjYWdMo7Ur2m+raE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747816299; c=relaxed/simple;
	bh=RIXZqSRSQa1M92I84R845YUpbzbzGc9VApWbHaEX3ic=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eZAssSJaHA5kcLthPBrT2G2HsLeRfDzSw6C/Fm00grF5aR13zbLPvYTgrEkhCjYqsxQodGzpUVD0T1Zw6NHCJraAN0nluMaDOlsRodP3zx12PGIFeQSZgvTh2jku56gNeX123dfddINFvIYDgGuaqfzCDgmhbII/uod/tgXNcoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=Vj+Q2cZ5; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="Vj+Q2cZ5"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22e033a3a07so66492785ad.0
        for <git@vger.kernel.org>; Wed, 21 May 2025 01:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1747816296; x=1748421096; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=RIXZqSRSQa1M92I84R845YUpbzbzGc9VApWbHaEX3ic=;
        b=Vj+Q2cZ5zz54hFriVMJUcjS5tP75eFlEbjMfuHvVqWIf5jnrd5ag60J2CcxDbUb6Ye
         2761WSni+VVs1KVyXmh+dykXplROm7+UlngU2PKS5Y5v0SvMmdj+2zZnZUhdTrdL/crl
         GkltKRTwkaGB7Bg24wJ3lkX82zmquwbEgZoNlXayVueXwaQmmzpesSso9YoWF4sZKtJa
         JizB/y/KDpNtEg3ghzv1lb9xvF9RpLYYqPC0KbiWLn7FkqVXpMr7/72PynoDTihnN2ko
         MXTjXBDkDnBU6NadLaGc1Kv5x+vMs+9esb7EEbZoHffQ1sOZToHObtVbtWCFgZzxT82r
         dWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747816296; x=1748421096;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RIXZqSRSQa1M92I84R845YUpbzbzGc9VApWbHaEX3ic=;
        b=njRbT90pkcpnTWH/+ZjZjZ9/GBZg/YCrIDz5XffZb0fJnWkbg3fIwlrbZIwnLb35eu
         ArsXnUsZJ0bfx6SngYT5lR2NrupthdBYcDti5xjPuMckJUN47EpzxRhxa01EK1zlSh0X
         K704ODckkBSBKHD/p14q6e1z4DE8/5pzoXcvco5fQnKBlZO5ZswaEJfkxOsD+CsEa5Rt
         Z/tlCGXufSHLAp8bAncCMyuMphQ6LY1jnq50tYbb7qsh0M05HftlGloTqDsGeKZ6UC/S
         yS4VQhyocebVH0ggUmYtBZfuvoZ+RQ3Z3qZlTNI2jJihxpzCf2ACiIGr7aM79NU2/AP9
         Wgig==
X-Gm-Message-State: AOJu0YxwbFvUGnXUtnPsITmJ7e3vtaViQMNkyD4964gCxxzl1pl3HZaE
	XnlBQRYNGZkAYXmDrj4m79ar93Jbgjn0Tqa8yWeDe8eVbDsgPXQ24cvUEivAo9xxeCcCFAMu24/
	sSt5M1tVSWgY32oBOSojT2RhQBbY181cLPl6vybQqK1xgfuxyMeRzdxM=
X-Gm-Gg: ASbGncsiDmGbwu02Yw7wYpeW6kLIq3TXH007b8URw6uBY/65Qor2Mb/hJvKCdUkyUex
	8o1WF2GHBV4pdZKXtILpIr5cyyLoK4IPmhU7aAqC5YgW2z9Yesa242QAQRNGdzmepqfFFTa/Aia
	2hl8ptjMtOAM5LQYiMDu5j2IbwSAMENtM+ig==
X-Google-Smtp-Source: AGHT+IFQ2ANWfNuBsWoJAu28xsQpkEj5j/Del24wBgFjMsBtudkk25/iZfs/qqIy6rzfPRasmRSWSJ6JYb0F69ITsT8=
X-Received: by 2002:a17:902:d50f:b0:22c:33b2:e40e with SMTP id
 d9443c01a7336-231d43d9ed6mr258603885ad.2.1747816296121; Wed, 21 May 2025
 01:31:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250508104437.51513-1-hanyang.tony@bytedance.com>
In-Reply-To: <20250508104437.51513-1-hanyang.tony@bytedance.com>
From: Han Young <hanyang.tony@bytedance.com>
Date: Wed, 21 May 2025 16:31:24 +0800
X-Gm-Features: AX0GCFu7BnN71ZR1DsF5QwnbrTuS1MAukJlw1ehwxzvr2vRb6mt1amypoYlewaM
Message-ID: <CAG1j3zF4yUGqxLG2gDjo3CzUPrsPnFt1d=ATYHYdXdC=k-UCHg@mail.gmail.com>
Subject: Re: [PATCH v2] builtin/repack: Honor --keep-pack and .keep when
 repacking promisor objects
To: git@vger.kernel.org
Cc: trnka@scm.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

By the way, the origin patch is
https://lore.kernel.org/git/19759704.fSG56mABFh@electra/
Somehow this patch isn't a reply to the original, I must have pasted the
wrong message id.
