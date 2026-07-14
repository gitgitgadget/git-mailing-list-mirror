Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD303BB9FE
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 04:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784002400; cv=none; b=sxM8zcdWN8+yl2EgzZKBcCEfiYujJKPWqtpTzOYlsYqWVFwke1w+eYPN/IY5ADk+vKTPDc1q5zHyJ7fhtf4xNDsG0+I4f5fixgSCkJjmRMm+z6CG1OGuOhGZpbCPG34isIpPUGQNE45dtVlEhalFkGcGM9l+tl0QiPSDwMmJRSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784002400; c=relaxed/simple;
	bh=7ByowW7JJRNpUo58osAGf9XCRuKj0RwhR+tLH8a+WaQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dToZlBQuWXg18124s/w1KTlzOwDP0MkWMW9o8PrJbyjXVjgsnM8zHN0wQYGSeKaGbuKu+HdzpDPDqsqiwYFxdvP/Mqc6X3EOEYrKkrR87g2eZB8Dn3USI6eQbjK8jyzk83lhvD4ryhdtx5ehOQjdGltRx7zcH2WTiMSDVazjjYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com; spf=pass smtp.mailfrom=openai.com; dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b=ery79Ni2; arc=none smtp.client-ip=209.85.219.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=openai.com header.i=@openai.com header.b="ery79Ni2"
Received: by mail-qv1-f51.google.com with SMTP id 6a1803df08f44-8ee88fce572so7310126d6.1
        for <git@vger.kernel.org>; Mon, 13 Jul 2026 21:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1784002397; x=1784607197; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ncCe1YJhfG5NWneH7iCAK9AJeSuZBJuXJSC/GQJJnGg=;
        b=ery79Ni2rf4MgXJtsMSU6y0D1J7kKBDvSvCwBL2Rxm3T2IfW6fICUQcdFW2836uRb7
         XLe5NR5/EfxWocJK3bE2H+2fTSXM2rxzj1w8Gw9ISlZB7NWK6v9L4T0xbX3EJMY9Tdc/
         SnLtXdYe3SdT5z+65DJcLio+yhL0G9IEF+QTw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784002397; x=1784607197;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ncCe1YJhfG5NWneH7iCAK9AJeSuZBJuXJSC/GQJJnGg=;
        b=YZynB9Bw6rCoY3w1LIQrLLXEdJa+HFwRNH4HTPF2/BFMGhEMjiBpWLyvnFSU1SFmwh
         ZFBl5QS5TDT0CGsy4eBpBmDOyppc0fnI8WbSiOr86x/ajQlnjjnc1INBec+Mw1d+LPgs
         6miLlBzys1YfZgFTLLvkLNkYpI5QR894O7cv6oCE7UpizYVOfIoJlawX1kWZQ9b3AE++
         37OPnPh7l0H4uH85JRP5XmSdlRkuEagKsXUeSzVWm4Mux/YlLXXzagBVtRnWV7DzEIPm
         xx3k1lLl/pmMhkVYr7rMdVNvPNYt5iLGkxq5C3Zc0pH98Od7lNsqE6bBkXZGV0CRUkVY
         oEzQ==
X-Gm-Message-State: AOJu0YwzrQiUswf4BUwjn6xoG1Uc0rA3W/HYkTJm1URR8nMsZBfylDGn
	reWIVvVi3So90T/lSiXT6v/hpt9pHlfz1rWbAb+KXxiOsRIyMl5xoN96xWAoHrNVU+w=
X-Gm-Gg: AfdE7cmPN4XF9sEVWQ4JR720WcUvDCqjPLPKHuyZamiBIJzpmQt8uPBmIFJTJkUaDE7
	fv7rVtc+3TYalo+D8FcgrACaXBzvFvW/cahkokqb2k4WZwawzzMqEHy3yu5tL6r0p9K9o/MMz7p
	Vpwy7jk6YWM0/pxQASyX3+q2As5YzDUbvEBoccpwjhi0BV+zkjE/j1F/RJgPz7beY30EXzA2+3I
	Xl3McKvebQxrZGuMOulvE6VDa96ApLXL8LNmgVbmB2YvXQ2Knl6O18cHWkL3986PNY9MIoQUQ8I
	rRHs5uI/zYiuAjaGFua8aiEzAVRoITIYI09lG1AHNrU4S/PBxOLm3ELCvNxCqG8hnY70gtLSbiz
	QtshfdE4n6j3xCdUO2K5eTq2nKeiFMJZRuSV8ZAKi07XAJg1olIzZcDdjCtUxxILmLDAYWLc/c5
	KZQmywWYwie+ipWr6CI4loyaoY
X-Received: by 2002:a05:6214:3202:b0:8f3:4ea2:427f with SMTP id 6a1803df08f44-90400b8ac03mr139904466d6.1.1784002397650;
        Mon, 13 Jul 2026 21:13:17 -0700 (PDT)
Received: from com-79390 ([209.249.37.131])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd81f4bbdsm150909976d6.36.2026.07.13.21.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 21:13:17 -0700 (PDT)
Date: Mon, 13 Jul 2026 21:13:14 -0700
From: Taylor Blau <ttaylorr@openai.com>
To: Ted Nyman <tnyman@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 0/2] packfile URIs: support concurrent downloads
Message-ID: <alW3Wm2scg8TjPXy@com-79390>
References: <cover.1783982021.git.tnyman@openai.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1783982021.git.tnyman@openai.com>

On Mon, Jul 13, 2026 at 03:37:58PM -0700, Ted Nyman wrote:
> Ted Nyman (2):
>   http: use unique tempfiles for packfile URI downloads
>   fetch-pack: accept "pack" output for packfile URIs

I left one pretty minor style-nit on the first patch, but otherwise this
looks good to me.

Thanks,
Taylor
