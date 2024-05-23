Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555AE17C77
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486700; cv=none; b=ehxSykQMNs37ZnfTNQW90nqZb03cRf02uPLS3vHj9PxdcvfSELRKz3jKU/JOd90ySslLMZ9KeF0ZrW/zul48Ehnzh0nuVKp3wvvsGHFgk1stmV3zNyx1y86RmnmOjf7Uao8faNOqIpGwTftzKe4yhI2lDPFBbhXVP8niW6XIQD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486700; c=relaxed/simple;
	bh=4DstZGA4Hw19VyA0wdWHmhukeHoJThiczFxsl4EM+Cg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j5FHwGR+C8nl4nqbAE4qEuBmWmENa9LDS5UHD2/Rh/ubxfyZtIc2o8KZHg7F+BD8lQSLsr1GYmqeXPM0PMapq1C+PkDTdFWbrZ26VZlolhkA6jUrelahuYQlzVvR99dswimoF0ss6rhFRMmYoMwAeFiUT6pjHCkFdOzdpnXiuKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=none smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Ww5TIRDe; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Ww5TIRDe"
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-6ab9d9c34faso134026d6.3
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:51:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1716486698; x=1717091498; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=4DstZGA4Hw19VyA0wdWHmhukeHoJThiczFxsl4EM+Cg=;
        b=Ww5TIRDeYrRoxktQH36F+4Toy7wywbnvkRSE4BQbJcxlNWFZY8ypEKlRtNuFY8Hb08
         oOzAcdumtdQds+fOuuxuZJhNAIuCfqdn1jIYUwWqtayGOsU/u6Kkbh6J0OXXDXBuUNcK
         FxWgCIMMDe3B8HBAujYUVEWhK+p9Bg7qhR/pRVWUOcul/7dGiKRDMtpSj4Q/BQGUcjkb
         k7ayu2a10WFJ0IdEj4aJHouBXQsJLEYjgPDxePbfLVwrru7ct+6f0UkHUV9e4TV8BNES
         jHLS7HSdUq3DZLT/j/x96sef2R+bmDhfw29XnoL12c7oRrm2+KLQj9xatp7m+4mGrVnV
         N0hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716486698; x=1717091498;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4DstZGA4Hw19VyA0wdWHmhukeHoJThiczFxsl4EM+Cg=;
        b=SBBhk1CTB1bUf1Lh02X7HJm1k3mpMfp2ebQTcyYy1qyH7zHFXiU3cncYX9U0UEFMU+
         FtK04R4o31Gi2N0LZOIQHDZ6yjUhod0CjzMlpFP8FJilfIjQtWpxZW980Nh1rPUmNGtm
         xpWHsyyPk6OlNzIlxxAgp8/kQ3J3+EzovFjy6qLxHtxKP5sC1XmNQd0kqF1Eqa2jEht7
         mamlEsGE6FQ47vxwCBwWzxHxjeTCiRrr1NKvetbIBkzwFr3dythpPcvvYQL0rYdbK7qf
         qaK98D6kirK0JgqtsMJTHfD4uHQw4RpEfLmOGLEe1qrq2Qh80KExIcxJyJ0feSSlsv1X
         3J6Q==
X-Gm-Message-State: AOJu0YyJQuao3LoeCSLl6ROHxd3YJ6UTUqJLhDv60xzTEduJzr92/Vy0
	g/GTKAN59/2EgSKy34n/4laAw+vHkTlCnBGzQ/nLzrUQfxW/jntRRGLUmn0qpnU=
X-Google-Smtp-Source: AGHT+IETH6hCQaG3Mv0Q+b5PvUyK8z3x6dAJXScbEfcAvf/3BrkfH8OLRuV/kBSuJ5hwURHp4JK8fg==
X-Received: by 2002:a05:6214:5a02:b0:6ab:8c71:1fb1 with SMTP id 6a1803df08f44-6ab8c712244mr52120006d6.12.1716486698133;
        Thu, 23 May 2024 10:51:38 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6ab8a52bec8sm13957376d6.143.2024.05.23.10.51.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 May 2024 10:51:37 -0700 (PDT)
Date: Thu, 23 May 2024 13:51:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 16/30] config: introduce git_config_float()
Message-ID: <Zk+CIoMaF/fT3ejo@nand.local>
References: <cover.1710972293.git.me@ttaylorr.com>
 <cover.1716318088.git.me@ttaylorr.com>
 <3070135eb4b9bd16117e82f1817c112c56a24b55.1716318089.git.me@ttaylorr.com>
 <20240523100225.GA1308330@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240523100225.GA1308330@coredump.intra.peff.net>

On Thu, May 23, 2024 at 06:02:25AM -0400, Jeff King wrote:
> On Tue, May 21, 2024 at 03:02:29PM -0400, Taylor Blau wrote:
>
> > Future commits will want to parse a floating point value from
> > configuration, but we have no way to parse such a value prior to this
> > patch.
> >
> > The core of the routine is implemented in git_parse_float(). Unlike
> > git_parse_unsigned() and git_parse_signed(), however, the function
> > implemented here only works on type "float", and not related types like
> > "double", or "long double".
> >
> > This is because "double" and "long double" use different functions to
> > convert from ASCII strings to floating point values (strtod() and
> > strtold(), respectively). Likewise, there is no pointer type that can
> > assign to any of these values (except for "void *"), so the only way to
> > define this trio of functions would be with a macro expansion that is
> > parameterized over the floating point type and conversion function.
>
> I agree it doesn't make sense to support both. But if we have to choose
> between the two, should we just use "double"?

Yeah, I share your feeling that there is no great need to support
double-precision floats here, but there's also no reason to artificially
limit ourselves to single-precision ones, either.

> Regarding using non-integers at all, I do wonder how much we need them.
> We've usually stuck to integers in other spots, even if it means a sort
> of pseudo-fixed-point (e.g., rename scores). Looking ahead, you're using
> these for the power-series knobs. I guess it would be pretty confusing
> to try to force integers there. I dunno. Not really an objection, but I
> just wonder if it was something you considered.

I had originally written the series that way, but Patrick suggested that
I use floating point numbers instead ;-).

Thanks,
Taylor
