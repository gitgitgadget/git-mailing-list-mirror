Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27762773F4
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 16:04:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334684; cv=none; b=AS06N2cYRwu2zddmxZM1+Z43xUrPseEr34lfLoW5lF9Eyovww+jMgLbCzVf5rqd8o7hOZOBvNtuuUIU5yBvdTPexjUdD2LUHjmFgTz674FIdTOoTnlWb1jw6dzP1bv0GeREMBfuL2mp8w1PsyIdFf2YmtLaXV4Gkr1NYam/j9do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334684; c=relaxed/simple;
	bh=PLJzk8jTeM544IYf/SDj5ou/cWys9q/FfFrD6QOSyOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h3Vr894LmYFa5uGNtEn5Ger5+kO/NBEYdi/sN2p08FtijQHIw22ITbB0NmUU0OLyPIkxX0uXYXXCl4oiS9njAGZ8vxabRgn2Z5ISmLZ5TUN1w1yc5xC0Iz3klqx2vyfzz65SWujuyOoEyXyyipHd9RARN8XRNW/N7BUa2j5Buc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=V5imqmQ2; arc=none smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="V5imqmQ2"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-71d71bcab69so692247b3.0
        for <git@vger.kernel.org>; Wed, 01 Oct 2025 09:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1759334682; x=1759939482; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PLJzk8jTeM544IYf/SDj5ou/cWys9q/FfFrD6QOSyOU=;
        b=V5imqmQ2Bf7d+bYAIsCHRi4F+FYqThmYKQZ4aZfzHLKxkVkg3rixsxAq/vdZ4x3u8h
         r61naRjgP5mXxVsUAzTOvl71C7bUjVhykP0ps1dZLNx9jZqfK1EBYVd7qDsxmuYHPjMn
         BLA1oeqaaaeFjIZdzNxcPMI65kV+4XhwM53RozUV7PuYcEA3eh2wBPx1qkXOaCLOhCVX
         gWBp5CIzbgeZroC8PIpsYbgQBFGfkJDmMmu/GmQ4ReNZK3vLRL8NyBluqtRKnNXz1NwC
         R9MZ7wRb1u1VWVF8NOlTVgyYr60DyNGsAgbhuChDYMR7N0Wos+aVjEZwKtlBe5VsNrQl
         Q1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759334682; x=1759939482;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PLJzk8jTeM544IYf/SDj5ou/cWys9q/FfFrD6QOSyOU=;
        b=HQL+ryr+f48W/lHE1UBmvp1bppdwXyzGyw5EhpXd0ceCTLjFY2f9eurQhcFzExnQf5
         5B87nbTcFu0exJ0bM4f0njRA6Dg/fuGMzrL19sbAbUZOUfM6FFhUDoutehqxrBB+1nfh
         4KbSI8EwMyN+kKHq6lgTihASCt63RS6Lo82weOa2N7fZBWSD7bzPpZHZU3PlFUTyAszp
         He+dSNSGyK8AABkyun2tMTLhWdimRxx9iHq+0oaOrcBYA7dz8zMEirE7kUx3PtYqHFXk
         Pjz99GgEUmRs9BI8bIWo1vW86EbAsP7A9SSA74VFaWSpJ0qE8unhlTpFISU54lDTLSct
         C8UA==
X-Gm-Message-State: AOJu0Yxpx04kTXblctilGkUjrrqoqsQUSPkaFEMmn3yKwlUes8kaj8SV
	cTiLgDFxPfdtwx4Mo7qd8y+C7rMozoR4VA2uR0H8JdANh3Oqt9dhe5IgqLVEO7N1rJZYeGCqkH+
	+osVwtu3Mlw==
X-Gm-Gg: ASbGnct5ULBW1yL4rPk43OwWHMfVHa8cIuXRBf2HS/aGebkfTxAlOH6PI3qsa+hVm2r
	60rS1OqjJQ37A2I1OA6GOwhSVq1h2hVYgq3PqOoVkDWSDKHVXLOx+WZ/xCXpQImX97ca/MGHroV
	Bv0GfdL23R8LwLPv7f+uPTuUjTkKos0PYDJJqfhV6XbEwCbGMEgnWBh8GOTDR6SXEoSRWcse4Ja
	JoYJEOPsseOC4bVJPLJLg18G3aVqHWVm050FMwKHokR27CBMmh0CHgNHhjXhBIEW9DqoHgse0dB
	Z+bb7DofUcVW5iRVrPuxXQiWyfnBIRDg1b79Y8ucgkJR3P3xQdBNUWwmVieXtgtZIFF5a9xaUTr
	GkGy2H5+k3Yg6o0uEEgHTwe/g6R824TxeRho++7gVCT3eH0W4JwVnY9lBer6G2h6zAd5FSkwxJP
	Es3imloux4R/LJmBaO9zo//qdYty21kXq2KklXwGSpWQ2EbjKqRg==
X-Google-Smtp-Source: AGHT+IFCsDypDhv9IdMB95ag1VkZyGclHAwSlElVYc778b6Crz0miGFDXZvTsJzqCaUS4bIrNQI7HQ==
X-Received: by 2002:a05:690c:8311:10b0:775:c1ef:cfed with SMTP id 00721157ae682-77f6f3994fcmr50627527b3.30.1759334681499;
        Wed, 01 Oct 2025 09:04:41 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-77f81e3bf45sm104077b3.56.2025.10.01.09.04.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 09:04:40 -0700 (PDT)
Date: Wed, 1 Oct 2025 12:04:38 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Luca Milanesio <luca.milanesio@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: When should we release Git 3.0?
Message-ID: <aN1RFvz7uGPnepxe@nand.local>
References: <aNxivuJEnSHbQNdr@fruit.crustytoothpaste.net>
 <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <E03F997F-1738-4CF6-B7D5-206183FA5BD1@gmail.com>

On Wed, Oct 01, 2025 at 08:13:12AM +0100, Luca Milanesio wrote:
> I am worried that if we rush into Git 3.0 with breaking changes that
> would make other “forges” (e.g. JGit) incompatible, we would be in a
> difficult situation with the other Git ecosystem that isn’t based on
> the C-Git implementation.

That's a good point. I am not familiar enough with JGit (or really any
non-standard Git implementations) to know where SHA-256 support is in
those respective implementations.

But regardless of whether we're talking about a forge that is based on
git.git or some other implementation, there is very likely lots of other
work to be done to support SHA-256 outside of flipping the hash function
within Git.

(I'm thinking here about database migrations for columns that may store
40-character SHA-1 hashes, for example, which can take a potentially
significant amount of time to migrate depending on the size of the
database, etc.)

So my feeling here is that we should take into account not just the
readiness of the underlying Git implementation used by hosting providers
in the Git ecosystem, but also the readiness of the hosting providers
themselves to do the work necessary to facilitate that transition
outside of their Git implementation.

Thanks,
Taylor
