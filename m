Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD8B4B5AE
	for <git@vger.kernel.org>; Wed, 19 Mar 2025 00:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742344258; cv=none; b=gbukSdv0ETfeCI44jPIqTqjeON2zIZp2s66GxLNzzQ6GGxk8wg/nno9fsGAWZyfnPXmeO4KwzZrtPqsr6d+H00gOAhiElR/nxVjetRiT1T4TlnW5mAV38LjLMCIH3lH6QLAB8oA6hcWIORvmWDNka3iwwo3A+nFMY+09kAwto4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742344258; c=relaxed/simple;
	bh=08s867wJXh1I/107ijU50aZusZtlGqOwo6vOycnscUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sHYB32GYrVJDTjkCYbseGdFAGR1pedcetjSLBzWdNazZZ9UMhF9tjmzzVtQnVdYtr7MBaAkIp4M4zDEkWxGYMqzkcFf9c/xfWpCxCCxh9hxPv8gAlxvzzCo3uvREVtwGD9iDaMcaEGGfboEtkTBcqmtxvQEM45Z2uXMZUMcTelA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=jIcDbKry; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="jIcDbKry"
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-4766631a6a4so62966201cf.2
        for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1742344256; x=1742949056; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=08s867wJXh1I/107ijU50aZusZtlGqOwo6vOycnscUo=;
        b=jIcDbKry5aXEnCuJ4IMCFVDLFABm9FcY035TPqK0v9GRuHvCjabNmkhAJDDTDlcx0j
         /v+zq/RjL2sZUn4dNz76J55KO+IH6ibknopqX8Ox75/QR6mBWy9P48ezYtRsJ8VIvmB6
         rgMu7hGMU6fSRtCgObrnpIbWfqT4Ztt3tBjCbY8Dzv/dGUNZL87wB2zAEk7TaQTDMZUy
         fOhlbPcqcNkzcQfZCTTE3G1kwGK6MPYXEIsqTD87y3w++h3gGlDdxh1u1wwNm64SQOig
         9WnoqzPHychLZG3Ic1THjeEeu63Zt0mNVS406R+jtItLmWU/rTSmYlSVHXDr/QZWHYLQ
         k2Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742344256; x=1742949056;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08s867wJXh1I/107ijU50aZusZtlGqOwo6vOycnscUo=;
        b=VVT64kENXXhY+eXQKMC7GsUtGWn/1eBTdHly3tLVuihcrIWvCAtbhU8kZ8qhfZxmSv
         NBAjqd2f80DJFujrgN6cDEqAMHgRzQlsTwk64F8Zs6mdNtGiIwHwxfiY697XY4fGjGTk
         V/cgMxmFU2Eb3gIHw4zTc5mCKycXFHm1j4QZIg6HoSaArgUDTItAo+ju2bM8vY9R4ZqR
         hd3GHnSki7MabR2WRVjhNsZQ6QCtTaHHyjUdsJVLQSdRj/WLQ/2gzhaBJZj04sBhEP24
         EWhJxoX4d1heZIIoWru0zaTZ/MaCdGxEr0bkqgJkkqgxzWV65YVPNZiQgg9iGfKlhgQX
         FkwQ==
X-Gm-Message-State: AOJu0YwfmIK44xkS7SoJKTWfhxcHIAsj7hdWcFUeAAVZas/fhHsrbA20
	nsQS72vtnI0LZ281Ph1F7G4IjerYAAcv6pWy0NXheiYPBWKcCCCpShKyzsPRVyk=
X-Gm-Gg: ASbGncud8nTdsUTKoHeUZeZrViakm5zUpG3dt0oFLPZMkgrFjXUJ/ZtV2XK/FNOksR4
	88MVZRG8ur9uvpC+4JCV/PvLcOhW5I4R78t+d+vrbIBxE7dW0tSQHYSMi+6v4BIqvQ2MXNbNTTH
	N9OTT7iM4clf9O7l4taW4YXcHGRsf3JwpLGR/32zumJWD5SItU9JNd5qlh8EYm7Tcv5lJDfncZn
	1LiXBflOht3tMAaRjgxQDhk9s7C4hb/OyulNhY/IeJJHkOlP++z/Kh8Qe2xTdfy12pltpVGzOCn
	orDnQFANzhbE2TyaUv2K9DqpDm7UJP+ICeSURpd/G0jEnFVFOx1kqAA+KjFhrsekIHPPUxtfuX/
	9r/vXA76CIla6oFok
X-Google-Smtp-Source: AGHT+IGRggIXBZOTrU85/CTvFwC3nGl3iBKpGH2ZHFG71ERT73wRLCl2iCKyx1FXyZt9Pt/h7bK74g==
X-Received: by 2002:a05:622a:1e8c:b0:473:8698:de12 with SMTP id d75a77b69052e-477082be79amr18560381cf.4.1742344255970;
        Tue, 18 Mar 2025 17:30:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id d75a77b69052e-476bb824a8csm73265401cf.65.2025.03.18.17.30.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Mar 2025 17:30:55 -0700 (PDT)
Date: Tue, 18 Mar 2025 20:30:54 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4 08/13] pack-bitmap.c: compute disk-usage with
 incremental MIDXs
Message-ID: <Z9oQPlUbeMI2IbV3@nand.local>
References: <cover.1723755667.git.me@ttaylorr.com>
 <cover.1741983492.git.me@ttaylorr.com>
 <c1eefeae993f2c8778dd0ec9626f977dbb2011a2.1741983492.git.me@ttaylorr.com>
 <20250318014139.GD1471939@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250318014139.GD1471939@coredump.intra.peff.net>

On Mon, Mar 17, 2025 at 09:41:39PM -0400, Jeff King wrote:
> On Fri, Mar 14, 2025 at 04:18:44PM -0400, Taylor Blau wrote:
>
> > In a similar fashion as previous commits, use nth_midxed_pack() instead
> > of accessing the MIDX's ->packs array directly to support incremental
> > MIDXs.
>
> Probably not worth it to change it in an actual patch, but is it worth
> renaming midx->packs to something else to make sure we catch all of the
> spots that need to be considered? Or maybe you already did that, which
> is how you found all of these. :)

That's how I found them originally ;-).

Thanks,
Taylor
