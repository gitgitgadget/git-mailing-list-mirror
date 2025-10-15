Received: from mail-io1-f51.google.com (mail-io1-f51.google.com [209.85.166.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0A12475CB
	for <git@vger.kernel.org>; Wed, 15 Oct 2025 21:19:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760563192; cv=none; b=dU/L4CHnTM619nKQQVi1nru7M5VJMcocnM223C830uSCG4lGnse6YotZgiRtfmD+98AQ/zqkXsttdo8pmZBS1UkWWEMe9HRAsdXrObRzN7qvdX6QNcBusT7ilrc13/RcMCTDjgex5vByQHlMlSqepDau5dfLWyRPcQwLlvosw8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760563192; c=relaxed/simple;
	bh=TwhBntaKhjZGRoPZaPgD8rdEdCE1piA76R/lFzV549k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WB8ub6FC4j+ZST/Yl+WEuN0U82vlHDQy5sHi2diYm2fAsoTGJewHwn7W3fkSMg/ovCvG6RiWjMCH7meU3Dsw3GX2DkHCW2CMsPA8m/U3hirSYinh2fmoT5ozbA3jMa9r9qqWB4mjlDL7ofCt5ZwBRWs6NPV8qzYoljzrRukKOlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=GTOkD+k6; arc=none smtp.client-ip=209.85.166.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="GTOkD+k6"
Received: by mail-io1-f51.google.com with SMTP id ca18e2360f4ac-930cfdfabb3so70539839f.1
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 14:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1760563189; x=1761167989; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zlNYoc+IIxrkCka1QirPLSBGKynEJSWJaoiBzD9ThnI=;
        b=GTOkD+k6f3dO15ROb0IqH/Y3QRGeCypkkKIs45qhF+XGjjjFCfy+d3SBQzquAiCs+9
         zwu0UuMbW1CNUemoJlAZDFgjNWoUVF+6GFyGt/71ujmhORSU62GeMC/K5mUTKXLqcvKS
         gIJdOTusn8nE/Nuz68VMGbDdgwDIfLO8CspxcGI27lvoGkB9tBBlHoc0BMJvX0MIv50O
         m0qm2YOyHg9RJfNcMP5TTOU2s/bL13mk4Uzy7u9zufB97CusJhsS3yr9I01h27/wMAoa
         +WSbJWI/0jk38DsAouIvo+Z1zn0h/xSE3eaW6aCVW4R5DIuzoLvdFgUjYPrPX5KiKpDn
         vNYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760563189; x=1761167989;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zlNYoc+IIxrkCka1QirPLSBGKynEJSWJaoiBzD9ThnI=;
        b=AAtfE+4zwROSGp3mVMgcUxJLcYiYtfRYNjXRKbJJ81bsiXewRWvcSDd7YdyC/MI3a7
         KR6cicUiW5dE+uFDTTjt5XCszUMih2R4zdZdlIuNvfwH4bVsZbUpXL+9bB9p2zcpnMmo
         oquoP9zvL+gfN7EC2wTzICL7despxcuKvCZWP7QqHtbO7NXdGIW4S4RSGUwvvDLofWLU
         H8HzJJjujqBXbAnqNrZMH2StC295PKY+l14CcU9o1Es/2SKMjg5wZ+TBbEj/Lq+rI7Xg
         RbTbZa71KvdmsFoZnA+1iez3uZA2g6OYqWdCMwSFdYoXwCdOtvSHwkyQ8OVHK2vnsFSr
         9exA==
X-Gm-Message-State: AOJu0Yw2NMUyqMgYUKjTXnXrWDjgUIPvVMo0J2hoVvscIiUt8Z3eClBV
	3/KNdhfEJOQNCYVgS0Kx645V7erfe6p6jJyQ+LT1dZV121p4VV0EKl0oh94EEQw3HzQ=
X-Gm-Gg: ASbGncultGE+82iBd+ryZjcrAz1yWve649VPUOchqV/ZZU5z2js6d4/kwqjw8XKUDyU
	G2o7u2AHWU5CSNqS9IhULUJ6AkAZQHhWUKPtXPG2NssEKGCkAq54WcIuvycG97K5FxLSqjcFR7G
	bmOLrnguPdUPXmZMgieAc7krEwL/YLSw1GA/OkJEbAONvVwZh1gFin74UPcCDn2AQp6QlN+Yo82
	NyBqIkXcVT2qH9hCsf07O0lvxUSGR7IJRtZuQ+xkzUFvezEVLvr+rzV3vlmf0wKjxYIsle7H7fX
	NTKpQ2AvcYL2QpT0EHFAwacWDoLvz2SjwXfbPB9qH1bXH/KF/CGQs9w/Um6A/CxZ1uArOvMo2RP
	uysFxSOvIU8Xx33Bfbj5xv97HqsQIBPRzJP7dpUSeK1jx9py2xWqZ4pxccTXNo14DcCqFNGMKJ/
	LMsWksXCq4QDANV9BJcJHQXpQV89grC/PfOfAaslaJGows
X-Google-Smtp-Source: AGHT+IHi3BmUYCh3741mpD1Su20JkczrQlXK41iBHPdwgpntKvj2lW1yIly4HR8UxS2lx21rtb93Jw==
X-Received: by 2002:a05:6e02:218d:b0:425:94f5:5e3 with SMTP id e9e14a558f8ab-430b43ad88bmr24684815ab.10.1760563188455;
        Wed, 15 Oct 2025 14:19:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-430b50b6945sm3027575ab.7.2025.10.15.14.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 14:19:48 -0700 (PDT)
Date: Wed, 15 Oct 2025 17:19:47 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH 42/49] repack: move `find_pack_prefix()` out of the
 builtin
Message-ID: <aPAP82IZAzmqLHTR@nand.local>
References: <cover.1759097191.git.me@ttaylorr.com>
 <c50ffce0781d0fbb24eb72f437dab257694a6b99.1759097191.git.me@ttaylorr.com>
 <20251015103220.GD2250228@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251015103220.GD2250228@coredump.intra.peff.net>

On Wed, Oct 15, 2025 at 06:32:20AM -0400, Jeff King wrote:
> On Sun, Sep 28, 2025 at 06:10:02PM -0400, Taylor Blau wrote:
>
> > Both callers within the repack builtin which call functions that take a
> > 'write_pack_opts' structure have the following pattern:
> >
> >     struct write_pack_opts opts = {
> >         .packdir = packdir,
> >         .packtmp = packtmp,
> >         .pack_prefix = find_pack_prefix(packdir, packtmp),
> >         /* ... */
> >     };
> >     int ret = write_some_kind_of_pack(&opts, /* ... */);
> >
> > , but both "packdir" and "packtmp" are fields within the write_pack_opts
> > struct itself!
> >
> > Instead of also computing the pack_prefix ahead of time, let's have the
> > callees compute it themselves by moving `find_pack_prefix()` out of the
> > repack builtin, and have it take a write_pack_opts pointer instead of
> > the "packdir" and "packtmp" fields directly.
>
> Oh. You'd really think by now that I'd have learned to read ahead in the
> series before commenting.
>
> So you can ignore my responses to the previous two patches. This does
> what I propose, plus takes it further by using the opts struct itself.

;-).

Thanks,
Taylor
