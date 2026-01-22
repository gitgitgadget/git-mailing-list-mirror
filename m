Received: from mail-yx1-f43.google.com (mail-yx1-f43.google.com [74.125.224.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40CD1279DAF
	for <git@vger.kernel.org>; Thu, 22 Jan 2026 00:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769040054; cv=none; b=bctcp4zIwQ+u/N070pSEGwWBQdk+lTPPojhQDWhaoTnZAoICeMqwiPJmMPWXdRtu+To3+zEWJTP9JdBOxcE4LopA4vMbshYMocNqKwh/pudu7ft7AZfsIvTEZmC0f9PMUmveAV8g66bh2Zx5NflyrabWlY8bJ2KbtKpPny5urtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769040054; c=relaxed/simple;
	bh=LVe+c56uyuIwfBGT/K0SgN2/BVbIeL4shOg+EPNPcqM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dSchbpybPMGW/cgXgGJfRr/4hrbmzm4M2dcQrfY9UWtguMhG9PmytymHnmhpf1JMsN7om7m7fyS+N5xEWugBjCPNs3Bc5fwESnj/Z4hccErHnIGrJqggsp/86WgnASJ4AgQVL3Uz/xnfcwMOAO6FMTKNXxa527hw9aCrRn1oP+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=nrwyPKng; arc=none smtp.client-ip=74.125.224.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="nrwyPKng"
Received: by mail-yx1-f43.google.com with SMTP id 956f58d0204a3-646d9eb45afso470888d50.2
        for <git@vger.kernel.org>; Wed, 21 Jan 2026 16:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1769040052; x=1769644852; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LVe+c56uyuIwfBGT/K0SgN2/BVbIeL4shOg+EPNPcqM=;
        b=nrwyPKngBfzUyO/xsGmjihXo0M+IUiYhHwH7t6xxIff1nYfiyUxiQFHv9Du9D/kQm8
         o0b+C3kF8C+LCiHFHoCY5hHCxG0Bz+VIC+KleZ0CjIHHYUIvIEijmW640SzHnRrgBHzv
         zY7zyHZHc+1leRg+sSPNuwdt7Z3zw2rujQ9Ku86nNEiqOXN6R1kJOV2lAipSIqVFjxkB
         /eZkw1E/bF06Xz/vLPOQs2iDgV/ONlt1mnN+Hq2pAzzeIVOJij+SCsNMi1gRRB4dQpui
         EOUvzTKgEA+xOYnpSPORioKLYBPzzAEMiASoIcxvPsXVv/5wCe88R6o8BuWNbtYaPzUj
         7N7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769040052; x=1769644852;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LVe+c56uyuIwfBGT/K0SgN2/BVbIeL4shOg+EPNPcqM=;
        b=CtvKlaiQjw0/+SMkvg1enMwr9aw5WYo0ZzW1gYJuusClTAI9TYrHIYwpjDZ2afcyCb
         SA++fOzZTLgZYOgM3+jHvka2xiFsi0Z82X6sg/6JNyFngfV438nId2MvWj9tV8qX2GJh
         oAgmo1y+m3kLFdJLsCzSm4YOY72CasWb/B2I0Q1fVlMmFjRVRWgsEAO37GJDHf/56DI5
         7ZJCdMqXF71pOQR7hrkSjZ8MrdEH7VcBWyIdzCFm6Vigzn86EuJ46EpvaKpcHvRjUxiR
         RyL7iZXvfUjyx3D0lrradZ1B5yuom9HdQawOks+ID7R6V9E5iWbgjrMWguX1E9P6U1dv
         fnyg==
X-Forwarded-Encrypted: i=1; AJvYcCXBzyTVF7oFXBY/G32Y8W1XJ+l3kNId4to3qlxYojJj55wiJvrCuhFKeKb2WsumAGKKKhU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya0WIMHshGZiU8GfKJAudL2tT292VHcSRMXNK9gjTBt6HJeYsV
	/6iCDrxFlM23jIY91/9UuyNjlANfDS58GdlIJOUrNukuevXFoFeR4ZWLMWpz5ekdv5o=
X-Gm-Gg: AZuq6aIBi7uTc94W6U1v6GlNjCEhEBQmqurry5KtVEICR/zbzw6Y9ObpGErP2XU1qtq
	K0Xhgqhn+13FqiPUTe+97gOjfr8S9NfStzZ7Gyo6jb8ehtubzIV8OvKvEuWSQKxwkRL7nj9Juix
	6OZP/03FxCaMpI2HeoblN05PBfzPkJdXLv8PSa2Wd5ZkgdocZ1TVHQ5xnyz/pw7uF3Twz35ux+g
	AhT/E6JaVFL3jWiJHTUBKOb6oOMqHb5/NMSPc4IyUAQzW0OxdyO3q4iRFqoN6p8dw//Re3mZPcA
	y9HLWhcHLzT/lSTDuSHpf2q824s9y9EfrREXL3lfwKlOCC94DWpQ6jgLi1uGovo9G9m0+wsFy6M
	W/A61vlY8XpLL1PQzs56JKDrihWAZHX+pitwQEKAjKCzbfho8NKTNktblIq163yvnDU6FM4FQfI
	P5QeUKbL7buFRq5I3W0yLLyOJwMjmf3azLqZ1+/Jx9vXRsLeqzTDHDHsWp3tY2bTOnx0sq3a4mF
	GJoR6ueCBzp7gzvOw==
X-Received: by 2002:a05:690e:140f:b0:644:51b1:d036 with SMTP id 956f58d0204a3-649164f598dmr14547875d50.45.1769040051979;
        Wed, 21 Jan 2026 16:00:51 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6494656f913sm1826009d50.12.2026.01.21.16.00.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 16:00:51 -0800 (PST)
Date: Wed, 21 Jan 2026 19:00:49 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Karthik Nayak <karthik.188@gmail.com>,
	Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 02/14] odb: fix flags parameter to be unsigned
Message-ID: <aXFosXv328ZPjlcw@nand.local>
References: <20260121-pks-odb-for-each-object-v3-0-12c4dfd24227@pks.im>
 <20260121-pks-odb-for-each-object-v3-2-12c4dfd24227@pks.im>
 <20260121211128.GB723458@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260121211128.GB723458@coredump.intra.peff.net>

On Wed, Jan 21, 2026 at 04:11:28PM -0500, Jeff King wrote:
> On Wed, Jan 21, 2026 at 01:50:18PM +0100, Patrick Steinhardt wrote:
>
> > The `flags` parameter accepted by various `for_each_object()` functions
> > is a bitfield of multiple flags. Such parameters are typically unsigned
> > in the Git codebase, but we use `enum odb_for_each_object_flags` in
> > some places.
>
> I agree that using "unsigned" instead of "int" for flags is a good
> practice in general. But isn't using "unsigned" instead of an enum
> strictly worse?

I agree with you that we should be using an enum in these cases over
unsigned for the reasons you suggest. I've stumbled over this in the
past, so perhaps this is worth adding to the CodingGuidelines?

Thanks,
Taylor
