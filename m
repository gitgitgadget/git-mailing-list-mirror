Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FCF013D297
	for <git@vger.kernel.org>; Sun, 27 Oct 2024 23:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730073415; cv=none; b=GcR9/6/wXAg6tW3apizr0RXRZZNKDOB8RX6lLfctoqXZl5Pb3PqVCVPPL56MKHAqJ0r2DcUjOTTYzq0ZLjW0npaF4WvOkMW9j0Qf6ISODjURPqnwzSvJXf5vSCDP4TmcScrlb/ucVCujdTitPq4oPJVd2Yj7A6jvDDdvoMMbZyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730073415; c=relaxed/simple;
	bh=KBdTlTX7jR44QRw7YMYoAJ4oM5/lbqoHCMltNq2Lkt8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c+6rtgMDqP87VHuWG0+3Ko8EWIJIgijtpxuyjtXcQ56anOQO2Rj3frn/Wmn7cPD+IEcQ4X4IdG1yEfEFzwHGXwWCSdTESIcq31dzQvsJT7C5Xj44JI0Y1DR6Nl5lj9F0yWKFiiXrjXNzg3B0qd/WakmPcS7yEQMTUfGUGg30UMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=Bth3lshT; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="Bth3lshT"
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-e28fd83b5bbso3912474276.0
        for <git@vger.kernel.org>; Sun, 27 Oct 2024 16:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1730073412; x=1730678212; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zoa1tjPTLq/RrW0aDF+T0uzjjjqH45576AWL9aRYYGM=;
        b=Bth3lshTuIj7TV5N+wWdYC3r5qpm6kY3FgCrpRQpPgdCZrEqMfMBV5gxaC0vJOzu4e
         MBdp6n6a/odPqNOkVtvCyIZ46SXiHKmhOwB3ku0UTlnpJcS0Uv6qKQuJKxjh15NSFrJW
         WZH7ayixUB/momT32avTh5hxrX/Fqo1DpWZBmc+tWyvSw4Dhx29feo7CSpo7WPI0kHop
         hbPqqWKEGYrBthnZdefk9lXZhqKQbBbuX07nU/df8Ag5/WkuQCieTV4mre1dQ6Bpv/qA
         ZcM+gQdjS2H9jo3FC1QOWJLAm7fRvNZD06/htGEX3d01ZO3zUC67AsniOXRlXziDaVtD
         xJ/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730073412; x=1730678212;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zoa1tjPTLq/RrW0aDF+T0uzjjjqH45576AWL9aRYYGM=;
        b=FNpR7AeUH/5iQW4TU9ZKTCnNco90f7NuOsilHXePVSK5RnxW4QzdjKwxC7zPo7AH9Z
         4yiAha9QaRoEzmhZLZ8Czhej88PQqP4zJ/spULZi/xg5eYEYv+pGxNrn+qCZgMhsBBQC
         fRxQIWDZL/OtXdK8tiaFWBT3uUm2tbtKLMShXZ+HeYC7VPAXQc9nQ2b825T/CHUBRwzh
         UhCsvg4xC0CRbsrWigBqGDHjRURmgw/lrcXNzF0LF5XokEXG7HMFVmQbGWurvbxqhcgJ
         4YMIMBe08R6uFWyk8XzBBqKkuFCnT8S/ZDPIYQviqvN0jscNxN5XLx3CCtNOPiklcbVB
         bB5Q==
X-Forwarded-Encrypted: i=1; AJvYcCUEr9TilaW/TGpCKxPwP3sBjgN+VjDXApskJxbaObEHk441gCSI6mTn4VbPC8GOZpcaeHs=@vger.kernel.org
X-Gm-Message-State: AOJu0YybfaGMGuKgsnli19qwYIMMlKw9Zh4uINQcbFVVpPwCZb9aZddq
	2CUJOGnrVfbUH3VjUrVLR5qFMufHQhSBhqvSrk6KvfcoBco8Wrb9bGqp4igRARE=
X-Google-Smtp-Source: AGHT+IGMdhp/5PZRHFOkXujGk4KKmlNHhivQoAHFGYcoEpOVjXmGLtiVRRVFTgvD/W4YxeFUf2Bq4g==
X-Received: by 2002:a05:6902:1a47:b0:e2b:c732:345b with SMTP id 3f1490d57ef6-e3087b82c24mr4960806276.14.1730073412469;
        Sun, 27 Oct 2024 16:56:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e3079d9c643sm1108779276.34.2024.10.27.16.56.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Oct 2024 16:56:51 -0700 (PDT)
Date: Sun, 27 Oct 2024 19:56:49 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org,
	Alejandro =?utf-8?Q?R=2E_Sede=C3=B1o?= <asedeno@mit.edu>,
	Toon Claes <toon@iotcl.com>, Ed Reel <edreel@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Edgar Bonet <bonet@grenoble.cnrs.fr>, Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v2 0/5] t/unit-tests: improve clar platform compatibility
Message-ID: <Zx7TQXoOq38S5gPL@nand.local>
References: <CAOO-Oz3KsyeSjxbRpU-SdPgU5K+mPDcntT6Y4s46Mg_0ko9e_w@mail.gmail.com>
 <cover.1729506329.git.ps@pks.im>
 <Zxx3nmfp61DR6vvB@archie.me>
 <Zx45nXPWdFIqVPTo@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Zx45nXPWdFIqVPTo@pks.im>

On Sun, Oct 27, 2024 at 02:01:17PM +0100, Patrick Steinhardt wrote:
> On Sat, Oct 26, 2024 at 12:01:18PM +0700, Bagas Sanjaya wrote:
> > On Mon, Oct 21, 2024 at 12:56:30PM +0200, Patrick Steinhardt wrote:
> > > Hi,
> > >
> > > this is the second version of my patch series that addresses some
> > > platform compatibility issues with clar. Changes compared to v1:
> > >
> > >   - I've merged the CMake fixes at [1] into this patch series to avoid
> > >     conflicts. @Taylor, please drop that other series, which is
> > >     "ps/cmake-clar".
> > >
> > >   - I've fixed up the "generate-clar-decls.h" script.
> > >
> > >   - I've updated the clar such that it includes upstreamed changes for
> > >     improved uClibc support when we lack support for `wchar_t`.
> > >
> >
> > Git builds successfully on Buildroot (aarch64 uClibc with and without wchar,
> > aarch64 glibc).
> >
> > Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>
>
> Great, thanks a lot for verifying whether this fixes your issues!

Thanks, both. Let's start merging this one down.

Thanks,
Taylor
