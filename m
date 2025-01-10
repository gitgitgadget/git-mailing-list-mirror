Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D3320A5D5
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 21:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736545141; cv=none; b=auUKekaP2QcdnLLytIGn47Tisc/hnv9kbjn9w+0j/0ppfeNtVki9G7zdRQoZLPWZMZos8oOv1Mxz6XzN0HNLFP7CF8kAEpUSnqu8CoVb2fPKB72sJidLO2W6VPf8k1HFuRjy/5CvsPyPlrWaY5D5K+zIsVQhqpf/2iYy9d4E0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736545141; c=relaxed/simple;
	bh=lerGk4wSx9h9uHpASLVq3RWQg2bBlUNlaPlJGyU0pkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEF4jMlHGi/uT8G8NVODXb6fV7Y8Mf0NOk4jF3DJzIc+c/36BCnTCx+oLYdkCSFJEoG3WeWcdbjvXDEEgHt6Vwkle+R727b6eVquIrglVE4TAylEd1o8KvdUe7Jxj/0lo2ZDFZp4MeZtzLkVBSF1Mu+nmKorIzya8r9kEnIl0nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=aU61Vv0h; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="aU61Vv0h"
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e479e529ebcso3679642276.3
        for <git@vger.kernel.org>; Fri, 10 Jan 2025 13:38:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1736545138; x=1737149938; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=XDLbm+QONOhQByYPTlcJ7GIxeaGhcr7mmw5BSb89wNs=;
        b=aU61Vv0h8ofdXKQSopLW5UOoajgc48jZrUGOZL6C2A0VoKmiycyjW18qIxXzRTgkVn
         u1fMkNpcH99PMlt0TT/2IYLtbXa8wD/d8cwrZmuh6sMSx+ihYryKN9bXnnzBAf/K6zf0
         WMhOGesTgkZkVToR6zn0WxOOdJfK2kI9+CarFT4NFkc7rcaJ0aDOyAIezV4CxlPqOoPO
         E21ACryAQ2K67JAcAii3hnyugixG4p+gxeON+yO506wvQwvwr/wDTafWBAdcelOfDAHe
         jvWtHRaPmZZ9cQJGRKhaof4yTosYifoneKb23y96tlZ+sGSzDuycbSWW2jKAZr/4wRzz
         OEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736545138; x=1737149938;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XDLbm+QONOhQByYPTlcJ7GIxeaGhcr7mmw5BSb89wNs=;
        b=ulzVJyxIPPx/1KeW4amqiCdlSN8wS2eQdrVO1XKaosreVi0vibrQHYsnVkbEOfshlT
         4J2Gat5li6u7GaTZMskH2bLZGhanygCWnObLARLVtjD10ok50uFuufcTS8uP3FOHvYmu
         ZztrBPZrT3i8xnmG6JTtlOxPvVOAhHEWGP8wKdq6YeQRlb6R7nm0DpjK7E1BGZPuZtx6
         O1HzS7sAaAXlPcG8GXvehM5wQr/1FFaukGCrg+GlMC6uF3QL3P9kFF+xN2x8GUjybMxf
         uFGuq90jM9R/OsG3qlQyipiWH60Uvw8rZfmP87inTezVmABQgf/kW/FbFe0u78ubLhYx
         RVxQ==
X-Gm-Message-State: AOJu0YzjMavtPgsldNZuYb4cT4FOEbpaWrKE0E6D9BiZrT5B4I88e1Rj
	7VujRmAr7LaEoVzSDWoAyTLUMwTIZgHbZnDAy3bMZjU7feYTVmhI39BYUYqHiK9zEt/IKBQz8yg
	7lfU=
X-Gm-Gg: ASbGncskQkOS2yBrQob8dBMXy/IhEh3p+l3TiBibnRqUX+uZ3vv/kEqr984KyhY486z
	xseVH3MC75RWVol9Rpx3enJASu5R3PzLpOwRSvPEjhjX42TICyUHMBVWcVG44bOSbi2B4wFwV8b
	tPMlUfHDb8QgC5AxqLnGih0kh4HHT+m03KVXlfl2HjPAp5GVdsr790bQvSF3OFVekAxGplD0zwt
	lPci70KVeLmPMbprMu00JfGiJGQzd+6r9GNUuiHWGj1IVCV/H8R5WBuRKIchi8kb42BhV7uHnBh
	tJSzfWVSpIsyehDT0rqssH2cTKZ8
X-Google-Smtp-Source: AGHT+IHh17MH978gfUTaoEtNP12tB6mmW4EO6Pn9ETtFlxI5mMAswdqQkCA2dB6f/VPRavx+505hgQ==
X-Received: by 2002:a05:6902:1023:b0:e49:c11a:7576 with SMTP id 3f1490d57ef6-e54ee20dea3mr10052726276.34.1736545138457;
        Fri, 10 Jan 2025 13:38:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e55a593ef45sm487598276.5.2025.01.10.13.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2025 13:38:57 -0800 (PST)
Date: Fri, 10 Jan 2025 16:38:56 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH 3/6] hash.h: introduce `unsafe_hash_algo()`
Message-ID: <Z4GTcKTVFOFmSsgO@nand.local>
References: <cover.1732130001.git.me@ttaylorr.com>
 <17f92dba34bee235177c8100daab49068fe37254.1732130001.git.me@ttaylorr.com>
 <20241121093731.GD602681@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241121093731.GD602681@coredump.intra.peff.net>

On Thu, Nov 21, 2024 at 04:37:31AM -0500, Jeff King wrote:
> If we don't care about the speed of this function, then an
> implementation like:
>
>   for (i = 0; i < GIT_HASH_NALGOS; i++) {
> 	if (p == &hash_algos[i] || p == hash_algos[i]->unsafe)
> 		return i;
>   }
>   return GIT_HASH_UNKNOWN;
>
> would work. I'm not sure if that would be measurable. I was surprised at
> the number of places that hash_algo_by_ptr() is called. Many low-level
> oid functions need it because we store the integer id there rather than
> a direct pointer (so oidread(), oidclr(), oid_object_info_extended(),
> and so on). But I'd also expect the loop above to be pretty fast. So I
> dunno.

Concerns about the speed aside (I agree that the for loop is likely to
be very fast, and will probably get unrolled by modern compilers), this
looks good to me with one small tweak.

We can't use `hash_algos[i]->unsafe` directly it might be NULL, so the
function as above would change the behavior of hash_algo_by_ptr()
slightly when provided NULL (it would return SHA-256 instead of
UNKNOWN).

So I think you'd want to write the loop like:

    size_t i;

    for (i = 0; i < GIT_HASH_NALGOS) {
        const struct git_hash_algo *algop = &hash_algos[i];

        if (p == algop || (algop->unsafe && p == algop->unsafe))
            return i;
    }

    return GIT_HASH_UNKNOWN;

Thanks,
Taylor
