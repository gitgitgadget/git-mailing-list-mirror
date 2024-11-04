Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B478918BC37
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 18:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730745285; cv=none; b=lA9qlDyFucJnpXbTTdmt2knGaJtipWWz7+bhVFr5cEKCUDGjzglsUSnsp1vuWwTxf8bLFavwtUB0L8lczr6YfLRIfeZvaFmuAEdtiEAR3jFssSg0MMZub+eCKBwzPStJk8RJwy+UMlZUPTAkC0Pcsw4uveNqTIZ1fI5BP56t0SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730745285; c=relaxed/simple;
	bh=7SKsA7hgXbXclgvo1qSuQa7ffpGVR9lSC5RxepPuX8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cewVL6DSYSIl03oME/GfYBzRL8zqX6DBjgxJipYTW6P0AOcUuvv5HoiLgOMhnT3u8ynLrzhdHMUVSyKYxBx52ga0SMqBzhErQ0QDARsA30i1PVu0YgVVWbmyg4jsTGGdcQxxUkB3bYh/ucDSzXJAYQKBG41lcxJovsT9mVeSk9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=z/chXNr0; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="z/chXNr0"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6ea5f68e17aso43026487b3.3
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 10:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730745283; x=1731350083; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7SKsA7hgXbXclgvo1qSuQa7ffpGVR9lSC5RxepPuX8k=;
        b=z/chXNr0jck48+RLcedRLZTVkFvexGHWvjRKjdD2dLqF690jmSIgjpk0+4nsrsthsr
         t9s5u8zfa7KgcTpufWOdn0JU1TBcG5v5Z2y6prq9ZRbwBxwwHfuVITKZk+SSPAjNaVBS
         eQC8gq+TiaVzqvEnw+86QRR33h6+/rXll2n4Fk/88bgOk4Ya2D3fBAK6thFTm5CM8yH3
         Ltpt5p1Q8dEVTxb967IuyqjXmrdrjjvckwweGYJPkqJdwLYSWoVykFtIKhgIHKjwuotZ
         08w56MPpVRlZ4wfPNAmfem/WSbjwRrvf9vr+GDnuRPe2I/ddFri52Qf/4taGJ17CcYTs
         lXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730745283; x=1731350083;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7SKsA7hgXbXclgvo1qSuQa7ffpGVR9lSC5RxepPuX8k=;
        b=tbZ7GRS7VT9Zgqd3npwK9s8FRYe+yYpdbVC6Nur1Vw3luRMC+LjxTIlA9+D04GJGyx
         zsthxZgstTlLd5q69QYf0AB2wmTI/0gNOh1PE40oYIYvbnWopZWML4rzFO8Gx0UysPXY
         16neZNvkQYLPMw2ELzDQW8BfViQcHO9CEtUOm0CzTL5ewGLQ8q2hrtD/QEYYeWSlnHPa
         sj+a7It+LQEnFCPusFnPnuwMtuzDKfPEwm/SNR9lgpaT7m8BfCNGVhqpnB+/UObDZaBC
         siDGxVRMisV9i4/TCSH/atkuhfpsSLojIMb5EX5v9BFVu23jnmLm5KNBiXHj/JbcMUKe
         F5Nw==
X-Gm-Message-State: AOJu0YzUpQlJNd33XWyprEMCSm2ZBhxkjEkScoLoeHUo0FgjNMISTYFo
	kvJJPz8CV1W+OWPESTKnMzn4wEgTZqHKmOkU+hReSGlQOB9PFVDrP0UJdPvLo3k=
X-Google-Smtp-Source: AGHT+IHzLongQg6IMWx+59RZ8spHbOtPMfRwxqxwL09jGf28YCtCy6526VKIWXjzzo3LrDejKFX7Rg==
X-Received: by 2002:a05:690c:a:b0:6e2:b537:3085 with SMTP id 00721157ae682-6e9d8aa410bmr316028817b3.34.1730745282691;
        Mon, 04 Nov 2024 10:34:42 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6ea7c26d7dcsm11422947b3.54.2024.11.04.10.34.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 10:34:42 -0800 (PST)
Date: Mon, 4 Nov 2024 13:34:41 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] rev-list: skip bitmap traversal for --left-right
Message-ID: <ZykTwaWaveGGvapw@nand.local>
References: <20241101121606.GA2327410@coredump.intra.peff.net>
 <ZyToaRxR7upLg0IE@nand.local>
 <20241104174126.GB2985568@coredump.intra.peff.net>
 <20241104174628.GA2990236@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241104174628.GA2990236@coredump.intra.peff.net>

On Mon, Nov 04, 2024 at 12:46:28PM -0500, Jeff King wrote:
> On Mon, Nov 04, 2024 at 12:41:27PM -0500, Jeff King wrote:
>
> > On Fri, Nov 01, 2024 at 10:40:41AM -0400, Taylor Blau wrote:
> >
> > > Nice find, and well explained (not just why it doesn't work today but
> > > could in the future, but why making it work in the future with bitmaps
> > > does not necessarily a clear performance improvement).
> > >
> > > Probably you and I should think more about other rev-list options that
> > > *don't* work with --use-bitmap-index. I share your feeling there that
> > > there probably exist such options which silently do nothing (or the
> > > wrong thing) in the presence of '--use-bitmap-index'.
> >
> > I'm pretty sure --cherry-pick and --cherry-mark are examples, but I
> > suspect it's the tip of the iceberg. I don't know if it's worth spending
> > much effort on this. It's certainly a wart, but there's a certain amount
> > of "if it hurts, don't do it". The --left-right one bugged me so much
> > just because I thought it _would_ work. ;)
>
> Actually, I wonder if this could be an interesting #leftoverbits or
> intern mini-project:

I agree; that would be a good project for interns. Great idea!

Thanks,
Taylor
