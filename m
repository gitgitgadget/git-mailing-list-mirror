Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A95C1862A
	for <git@vger.kernel.org>; Tue, 13 May 2025 07:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747119984; cv=none; b=SeyUmn6LLOH54/FP6rjVpmb2rr0czP9gw/JguqZd5Y0313izSz1sHcnmQbNV/8uryPhr/DU8PEtyH8Noq+0IPBMePiey7t/S9bj3yTy3hxxaurxb6duvLOhckn2Clz171DSWEECqHvcp0QHQ+MBo5dymxR2K5SAgNmaHvOzLz6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747119984; c=relaxed/simple;
	bh=Q09oIjQIUDMeTvSNCjO6h7fR/CRQ6MhFhZ/LHqHlnl4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ryWqZcRACxsb+GZx7jhwS+sCPaACLt1XD3/27E7nK+9e4KkehTkg+Si014LTN9NU1GaDMzUtpBkw95LU4zugPgUK6Pt553GpcG+U3ic9mekipWH6OjTZnzqkAZnKpGAsPyIPgBSo5zCwTVDndoj1tHHTn0d7FuY7+nojU3D61kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFrFfnZp; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFrFfnZp"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-22e4db05fe8so48507395ad.0
        for <git@vger.kernel.org>; Tue, 13 May 2025 00:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747119982; x=1747724782; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GVwzM7AH0goZzku3KIXErQeiWMlnha3odZsjIQlNTmE=;
        b=LFrFfnZppD0eHixJ/IyJR91nMwPKctq0CGPOjja2kJJ+QIHxNpixAME5LchIY7YjxR
         9jXHi7wOdekpfnJZxkyy4kMQOiUAzWRaYYOVB7EbT1tUXdbYx8r3NyLhwfx+1I46tA90
         8pEU4ClIA5m4sLnqsT639+V00gd55NgqIJOk+KlLhZJD5vkH7hf39gKlsfZCJOOD9LP/
         dyn23hKAY3T6bUdOAdBgzqUCfk0BBhHiFIoszRb8aSzWJ+ftgFqrSLZ07oiuy+wSso5M
         nEx2EYqotF42Bhr+XemccfB08C3TSlB0Rb0bIy7aXfCGcgMBkjqadotlVkm/PoKs1Kpj
         fryQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747119982; x=1747724782;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GVwzM7AH0goZzku3KIXErQeiWMlnha3odZsjIQlNTmE=;
        b=tTVdInhf1rmJWxcHu4zbgG6/sbSYjaWiakGeNnG5Ov0sq7iMNt5y0J37Ygu3IpjTeK
         OCrdeJ7QJoRovOQ1V5ScpzuG0zia4OMb6YwPvm9AjB0P+cCGBZ8szwQEgJwg2wI8gAf3
         jf55L12Ob1N6ut3VKFzcbbaSH1TVJv5kJV3REjkLe9l8bNNOAdaFHAvBwelw2K8TJCdH
         9uuUqMk1sSHcrG2LfzC48BSzwfibmkzjMwMqpF+TpW/OmNVzQ8DZWEItsnN1vtplKLmc
         PwuUTcmr+9zAzxNkCkZLH7gwXn4KSfOCQuiwzgXd3FkDkhsipNjcqEdPLkGNUIkDckct
         sYMg==
X-Forwarded-Encrypted: i=1; AJvYcCWVkS0NR4oeuD0I9HT0Ny7GgiA/cLzp417asbbdEHVR12tt1Vlnvm3gzKGbzqZXQXReCEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXwzeUGaDtwmXOElyN94Liqcai7yUdCblaOH+qeiEVKwLEYKKt
	TaiRVJ6mu1GlcyP2MPuOGFgwvz3ukto+UiwYuWjPF4z7ZgfERuQK
X-Gm-Gg: ASbGnctm85ZN3hvzmsV3rTBV6m5IE/YR6upC6FpbYk2KE7H0ZRLJ6tFPSNWEka5HwsC
	dZnOEdQ1SAO3rfqjLVWCwzYSfSxgDyEmoHi7vm1rmaFfH8tfFxBFERTfdI89qPK4rsrPAUZ7twN
	Odt6YqBqd1lGwiUycD1k3QQA453i35MdM1sHrDvl24J0GmeGPBMcRKCzYu0pc2K8bBcjkJZ0+P3
	GGQbB0HLypKCXsoHX8GbsnnbFb06lgeP6jj5lALZhZpRQV927RHZi1b3ga/ANHgx1fSK6d+qVht
	vNTOQYCvNcLj869qkG8BFfyDNx9lwUjMlZ47vBLljlF4J7A=
X-Google-Smtp-Source: AGHT+IEe4RrcMirG/sZEzBTH1bw038vDzeKpzJfn6wof5c2SF5ymgaVwdoirSZ+qvbm8okaVlBLs1Q==
X-Received: by 2002:a17:903:3bc5:b0:22e:4cae:5965 with SMTP id d9443c01a7336-22fc8b597edmr220535345ad.29.1747119982242;
        Tue, 13 May 2025 00:06:22 -0700 (PDT)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-22fc82a4c41sm75108555ad.237.2025.05.13.00.06.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 May 2025 00:06:21 -0700 (PDT)
Date: Tue, 13 May 2025 15:06:52 +0800
From: shejialuo <shejialuo@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
Subject: Re: [PATCH v3 1/3] packed-backend: fsck should allow an empty
 "packed-refs" file
Message-ID: <aCLvjNrZYYROlIm3@ArchLinux>
References: <aCCtQDnWII-knmEc@ArchLinux>
 <aCCtx2mqihlc0M7H@ArchLinux>
 <aCGzIlLH_ESNg6-v@pks.im>
 <aCHoovrKiSUemBCL@ArchLinux>
 <aCIIL6IWiiWiGbFd@pks.im>
 <20250512155654.GA1219668@coredump.intra.peff.net>
 <xmqqh61pu4r9.fsf@gitster.g>
 <aCLTsqZSWklaEOq6@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aCLTsqZSWklaEOq6@pks.im>

On Tue, May 13, 2025 at 07:08:02AM +0200, Patrick Steinhardt wrote:
> On Mon, May 12, 2025 at 10:18:34AM -0700, Junio C Hamano wrote:
> > Jeff King <peff@peff.net> writes:
> > 
> > > It may be useful for fsck to detect this, though, even if the default
> > > message severity is set to "info" or even "ignore. That would allow
> > > people who know they are using modern Git to increase it themselves (I
> > > don't expect normal users to do this, but it would probably be useful
> > > for forges which run automated "fsck" across a lot of repos).
> > >
> > > And then the backwards-incompatible Git 3.0 thing would just be tweaking
> > > the severity of the config (and in the meantime, it would help flush out
> > > any unexpected instances people run into).
> > 
> > I came to make a same comment but the above has everything I wanted
> > to say (and more).
> 
> Yup, agreed, that sounds like a reasonable approach indeed.
> 

Agree, I will use a "info" to report an empty "packed-refs" file. Thank
everyone.

> Patrick

Jialuo
