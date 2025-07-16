Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60611A76BB
	for <git@vger.kernel.org>; Wed, 16 Jul 2025 14:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752675026; cv=none; b=hPZ8h3WcdTPfhtNc3364bOg6ZyEwG2RGinUNpoBqj27fOinBbIwap4kbvB0YMLCStedr720Uy5WlGWUS1w9nYagSDMZedwf2stnOzBVMYFG1k0qwIS+kJSiMXnW5w9wYhZdBclk4XZC1hst/hW+z6Fbvj0RanIEojEJmnlDHIC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752675026; c=relaxed/simple;
	bh=c0SbriQnLxTTlfGKnpZqKHZDZ0aM89D7mN2IyW4FUdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgSkVSj/e6UTc+4BfjnA28r9wRqrV0VEPEKuVp+RcbL237hg5pL5ZAreFu3dkAdZu6s7u4PJuGAvCMedAyUVcKDWFwqRUeSk8Dou1VvecONpRTWX7YM8QI9jxUl2hH6gh5UdMhBMQOMW9iVW6HABQJsG2rEGwyu6cisOj1PpyJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KjGiLcar; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KjGiLcar"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-2eb6c422828so701613fac.1
        for <git@vger.kernel.org>; Wed, 16 Jul 2025 07:10:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752675024; x=1753279824; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=U6Ekw2xfWvOGPd7nq2NYdWj2538GO0NZNuw3ZLTJDdU=;
        b=KjGiLcarZA3cmYV157arPi4X1u4tZS4lDUwr0IKoqe8EM/cuZjAiVjVC50UYo9ZR0P
         VTNEAA/LsksmbU+Gkkyg2ZWxo/X+ib6mIawoQfsJlsqQadatT6ZTfcs2UPz5247SGkKW
         DbBKHKhE01yfxWi9nBPJsyTYcIl5s9W/dpVTAZEzB6WdLZChYtPkLqznlEM8bYTn47+K
         iiLwN27ja9kb06/6dnVeszK4EtxmTt8vwvt58rfZEFx3fwP1qSz2biy+W1veCTc7ZTjl
         OtFx2/txkV5QTaWMUdtgml0tX48zMD3NCBfpx7rN47B4XVlw6oMffWV+P5vzb5olFfKh
         DvLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752675024; x=1753279824;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U6Ekw2xfWvOGPd7nq2NYdWj2538GO0NZNuw3ZLTJDdU=;
        b=w5Hm5XsVWLbt/uUT6yUIWpuxhuhPso5CdVgbzJwZDu/e44Uoln6dUeNT2kzbVsrSut
         57Q8TqLdZ0aUjaaEtn7MjQpoO+SR2/BMIJaxaRYcsK1D5F15FCDc33p/yr/ubYS4oVpJ
         fiARREnJHBbBr6dP7eImKfrlEe5NNEp6Qry6iY4Fnly2VAIe9eIhLwYx1w3slDglGHFM
         UGJLG462en1JEdcTM0gXr8hGawqv2SlbCKgxbYmBrMGRHZl9CIyeyUA7P8Udzqg4cah2
         8LboSuA7bYjp2qhHYEYI0CJRQ6uQMbD0L8zkUsiqAQPrGiqIRP6Eu7gUVpBzDLgcCvsQ
         EcSw==
X-Forwarded-Encrypted: i=1; AJvYcCVqnJImu8sbFL1UK/CV11sdMcL2Isq0M8leMQUpjgawmyRjtA1WnNn59J8B2XOCGigV1mg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8OfIRa/SyBeYQYp0GsS2MYHVY0n/3CclokgddEt/fDwjdiOLs
	m6bhVT7UdsCWKqEJ6MZngO1/SrpQiyiB7Rfx6RXXyvzigFWICTVq1ioU7qYASEXu
X-Gm-Gg: ASbGncsl8eCTksuCK4J18Teb+pRc4StDe6FNoMcCYYHxvrn4Me0lWWqtW7PA4feTzE4
	N7kf8Huk7GcrPeR98QcKuxWj/PTt01srjt4k6sON/x88kRoOeALXLz3sywefXbpxwKF/qkja7sA
	qWT1FSqpVC52xhePVjh3/dIUfxkszeZ/LvfHif0t+EEXwRU7mrLCSh8dv+br0B0DdvKdeaJDnhp
	uCgkU/OiJNM4biHUAGpSTw/tOINAWiQzkzuOjwfjIz3NmRDJl+tXMYFp4DxDbwt3LrF0JpLR3d5
	Hu1//PT0vlw2JsfzbPVHnZ6wgQKTitxvLxNMmuaR8glUmAAYVHgPl7A0N8NNna0VNppcgBfImmw
	cf7lQ8fL8N9k7Pe24rv1qcOULnw==
X-Google-Smtp-Source: AGHT+IEE8iakcob77m31ETXKEPk/MMfI5bQhYLHHHOrbWBHpdvgmhtHrVnRIScR7Ki9nVGnc5xAa9A==
X-Received: by 2002:a05:6870:7d1b:b0:2eb:a2ef:901b with SMTP id 586e51a60fabf-2ffb0c58007mr2402286fac.14.1752675023796;
        Wed, 16 Jul 2025 07:10:23 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff1123ad71sm3490708fac.14.2025.07.16.07.10.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 07:10:23 -0700 (PDT)
Date: Wed, 16 Jul 2025 09:04:40 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org, 
	karthik.188@gmail.com, ben.knoble@gmail.com, gitster@pobox.com, 
	phillip.wood@dunelm.org.uk
Subject: Re: [GSoC RFC PATCH v4 2/4] repo: add the field references.format
Message-ID: <2v7b6mpufnn6cj7u7tactgu2ibggn4xpuezl2bsfjxv62afrsa@chfrii6vkrx3>
References: <20250610152117.14826-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-1-lucasseikioshiro@gmail.com>
 <20250714235231.10137-3-lucasseikioshiro@gmail.com>
 <mgdervgp34m6ipfbodsfn7cztcl7gdeggzemfgivzvuyk7qtba@wdijebkuioxg>
 <aHc6y9FGFXjowkU1@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aHc6y9FGFXjowkU1@pks.im>

On 25/07/16 07:38AM, Patrick Steinhardt wrote:
> On Tue, Jul 15, 2025 at 02:15:07PM -0500, Justin Tobler wrote:
> > Also, as mentioned in a comment for the previous patch, maybe we should
> > support printing two output modes. For the default output, maybe a
> > simple `<key>=<value>\n` where the any value containing special
> > characters is quoted via `quote_c_style()`.
> > 
> > A null-terminated output, such as the one proposed in this patch, could
> > be enabled via a `-z` flag similar to how its done in other commands.
> 
> Agreed in general, but instead of using `-z` I wonder whether it would
> make sense to use something like `--format=key-value` and `--format=nul`
> instead. This gives us more room to introduce additional formats in the
> future, like for example the JSON format that was scrapped for now.

If we already plan to support additional output formats, they I agree we
should probably a `--format=<output-type>` flag from the start. I still
think it would be nice to have a `-z` flag that is shorthand for
`--format=nul` though as that is fairly common across other commands to
have such an option.

Out of curiousity, is there a reason we are interested in supporting a
JSON output format in addition to what is already proposed? From an
earlier conversation I had with Lucas, it didn't seem like there was any
particular reason for JSON.

-Justin
