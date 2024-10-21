Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C7019923C
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 21:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729546574; cv=none; b=QZ8yJ/X2U8mzex8VronTAT9olWXYQR9tt4Fplt2PW0SMIpkyidEy3VZNfqJklYC3Me7bgT/Kquza8LpSX+UtE2TgWnwLDlJkbcV1Llg1KtDFut2JilGz2AJT61eFN6YW8/Wc59Oh8bEqGXGKtW6GP/CbKquSb2ggD4gsYiExU0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729546574; c=relaxed/simple;
	bh=/PDrJ6AXyq2vz0X2/bUu0bZKnz49B4N8vIqrRf7qPFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YGFS6WmqlsT5uDc0xsF1ByH2MoNwwpyFr5TTN1GHlSZBxA5ViowHTpW3uFNBraIoE6u9aesI1GEbfQVkO4Dr+1+jslcSCkjDZpWjBd2Akz6gpbrToE5RnOUPsYhn6yIvqQox4x32Hq2fvXizyZ4LY44hchCsr1U0A3IKta9rVys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Yig3b7XR; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Yig3b7XR"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-6e390d9ad1dso46052347b3.3
        for <git@vger.kernel.org>; Mon, 21 Oct 2024 14:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729546572; x=1730151372; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aKunLjbu6pBzNBgeVpjijCECa/eiVLj3e7dTKezbRpU=;
        b=Yig3b7XReDYxN6F8oEzhPwICFqhdgkmNe2nkTl1gQjHDgWnpc0m5yBwVducOzA+L5V
         3G9JuLMC1auhEDxCA5tmHgwZwXNx++aFhL9064Osmn4f2SN2q5Kn72xOnoHashz8QWD4
         lB2k+8pknIqIoU0uI4r5WvfMvdjkoSSppv696GvHBV5l29paijcM8M4gZHVo23SZourd
         PJs9b6jPHQBkuXnkh7Ih/0VvznpFhfUAG+6cXGfllZuJlAHSJsbWjx96dfe4i7JpJsLQ
         /nk/WbveR1uOZ2K6SNL/mV3QMmr9emMkDGS8OeJhg95WsbkC0IPKGNhSGPSyNQc3j2Te
         2uIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729546572; x=1730151372;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKunLjbu6pBzNBgeVpjijCECa/eiVLj3e7dTKezbRpU=;
        b=BxsX1LtooPxq7AEyw23pdwoV6Y0lGsl1bttsHjRUntg/VeEuQZSzQp3tY+70DxsVe6
         Dsdq4ZaPhTE0cnEjFxLVHUa4m42vynagFsON7wpNt2eH/w2R9TwmkbYbEAHZAfLzCq0X
         5I6pC6FRlnwqwpxZ4w8KG1LGiKsoTLt/4excYawLgr8EYXb7fLLVGXqlGo+aoHyJSdrR
         HHzbgYsNQ0PKnPfq0YIGkfwyczMaDE+b3Yl3jA5rYJEjb/ekxuITbWoNfG5T8aaBPvOs
         6Gc8PmXS6sf/dVx5kEl+RAUz/a24KRLH+UMRM5tokqFWkV9KUedsjw/cNVtlDUqSC3QR
         0rPg==
X-Gm-Message-State: AOJu0Yx/0195PI52resQn7PaLCgP+Zw30N0W2DM8d746QOLE2UbmppbX
	h3SPDu01SaGvgpuIXaHJ0aaKB41sJzv9lafTqC6wTvxgxsPa5v5drbNWnafEcp0=
X-Google-Smtp-Source: AGHT+IE/EvU3Auy29kyhHu+QYh0lbnM025PsfzoJyJaWyW+3+YrXETk37XVnLDpg1mXhAw5Ce6+SEA==
X-Received: by 2002:a05:690c:11:b0:6e0:447:f257 with SMTP id 00721157ae682-6e7d8252700mr4290107b3.22.1729546572441;
        Mon, 21 Oct 2024 14:36:12 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f59f6e72sm8283227b3.28.2024.10.21.14.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Oct 2024 14:36:12 -0700 (PDT)
Date: Mon, 21 Oct 2024 17:36:11 -0400
From: Taylor Blau <me@ttaylorr.com>
To: kristofferhaugsbakk@fastmail.com
Cc: git@vger.kernel.org, Kristoffer Haugsbakk <code@khaugsbakk.name>,
	avarab@gmail.com
Subject: Re: [PATCH 0/4] Documentation/git-bundle.txt: promote --all for full
 backup
Message-ID: <ZxbJS4BJ0vxBiOJG@nand.local>
References: <cover.1729451376.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover.1729451376.git.code@khaugsbakk.name>

On Sun, Oct 20, 2024 at 09:14:58PM +0200, kristofferhaugsbakk@fastmail.com wrote:
> +Cc is just `./contrib/contacts/git-contacts` minus Junio.

Ævar, who you CC'd here is currently inactive[^1], so it may be unlikely
that we receive a response from him.

> Kristoffer Haugsbakk (4):
>   Documentation/git-bundle.txt: mention --all in Synopsis
>   Documentation/git-bundle.txt: mention full backup example
>   Documentation/git-bundle.txt: mention --all in spec. refs
>   Documentation/git-bundle.txt: discuss naïve backups

As you suggested elsewhere in the thread, I dropped the first patch from
this series, but the other three look good. I had a small note on the
second patch (first after dropping), but let me know if you plan to
address it or not.

Thanks,
Taylor

[^1]: ...and missed. It would be nice to see you back sometime, Ævar.
