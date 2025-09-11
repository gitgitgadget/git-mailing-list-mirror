Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1222DC77F
	for <git@vger.kernel.org>; Thu, 11 Sep 2025 23:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757633593; cv=none; b=ik1wKJCp4sJ2jSeFNl6uJ7Or2lTYebpJDF208CF91L1nR+vXGj5EWKCp6T90mJgKZy2YXWSBzDuvysWboKaS7scpHnUh+Qyj9CwfsmAqLz/teheGYNoKorHI9w6s9dszuRbMCGAJE88rrYP64pnhbrTIJ7njS8tT1ULI7JSTPRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757633593; c=relaxed/simple;
	bh=qrT6ZY1BgHk9noD2c1jnj2JQivetR3mPH5sNVBNWkSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lWXm94FcHw1B+2H4yFwQxhmWTNsDck/6B0kbINS0uxC+1Qjs3HmNeOPSU83RJH6gueLGJftP6mwTtlPnpM5fqZIZsbryxxR9H0gDS6D+yrwEBWqr0q+W9IT1WC4HFGen7AnHuMnjLbCHF0ErtgkdBQyy2uvLqQ+hNprq9GD2gR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=mFqQDv9a; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="mFqQDv9a"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e96c48e7101so1025690276.2
        for <git@vger.kernel.org>; Thu, 11 Sep 2025 16:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1757633591; x=1758238391; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LBUPYd750RCciz0x6Us77GZFq2qgkJALKdFyhjWD/9w=;
        b=mFqQDv9awYz41gbXAiv+WJZxeaPCI8AWXhVlvg1DwRm1wuEISMC/fe8lzSFkLKky7m
         dW2RkmWYwq7JIlSZZtIDcL5zPsIxkELIfwfTv6/BkFfrSLaK6wEU0sHO/P/JA+0Ee7uR
         xGgswcydTJg9Ry1HoysGX6NoNpeGJ0AMi44ZE+WNm/MUEedXnpVgHv4IEOyORJCsTx38
         CjRf77ehHDh3sozKGSvIuqUSbo1/VDUL+Axu6+omGnijpgrfDnQOhISdLjI4Pk8fh3MR
         WZeR0w4SxhQaVvZKnPDU2VxpGqPC6M1ruuc9WrBNf9VqiT3/WxCtksKg5toNlE7abYGR
         +ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757633591; x=1758238391;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBUPYd750RCciz0x6Us77GZFq2qgkJALKdFyhjWD/9w=;
        b=YvLKbUrqqySPamzKJDl2xPQrxIWVNNRqmkRre5VzKoUZexlXqTA+hUqTppDVLLn+pQ
         u3XYr7X9/TKGVLC06lzL/gvn+7RcQmgPtG2eoXUDVVk2V+zIziaWyBzaftHc9xG19ZUp
         fl9uQe0MoJxEh26hy4v9Po8mUzneuA9b2hXWIUGLMkhcTAyPSCc2eFb3xudNXzSvzYwU
         e6SXNvS6aRJN9uC+Kq85biopEHiK6/00291eKJTfcabCJF/f1drrDjLswnv9Wy4ASdS4
         kKjYZY/ZA/lFqui8J8epioFDGxy5A+BaWE0PPJpofMjztm+OlfpvouEwDwsKogKeynoq
         0Syg==
X-Gm-Message-State: AOJu0YzhkcIBRASN7gi9rWdMqBP0ZFiWLN9YdU1QRiRutsovB+V7O7cR
	dPkuWCZVUx2DGnIxUEM4FpUuI5X1V/bIiFVgnmEwyae9wpQaa/SCgCzQyMdsd3dfNNs=
X-Gm-Gg: ASbGncvcJDYLWvlrYOkNG+y+xJ2Lo2Xy8Nls+xVaLZvdfksNcRrFeRbBKT0KUXUNcr7
	5meiJ3mDZ4F4kA7XaE8MDnI3hovlIsx3ulxKMSEIEM0YTi/g7iF3zY3lgwg/8xWba9Yqxu66mVX
	Bpu60+yZa+8I3N9mao88B23Dkvh9D3XsVPLKHnJgpFTvo4w8FLUI9Iq0N0/ZniRVn2CkTZuzRzo
	U/DZRew4udPqF2B0sEt3e+tXv+slapLJYuKUD8Bv42TfxYi+yijIrltw0P2A0kUtadMaMHQ4paL
	KEtW3UT4YERi7QXJWHx3CCehfjSlWHkg0fRui8kpNN+QR7BwS1ykZaDe2F5YsNktUG05YtG1tqJ
	A9YWfevd0ZvoNuTkcukJ+rmBDWcSStbMyQYP4X3H7Cb9HnAf0rtTzFb9mT0FHbAYazb19+eULLb
	V7mOFNg0PpboMjSVoZYpxHw+PffqMhTwY3FS9odf5ljahOQHo=
X-Google-Smtp-Source: AGHT+IERg3gDTHGQxUmlOeJAb+jlHdb/wu6VfoaRdEKnfY9YfCJvAsfiUmYOXb3hiYwcf80sOQ5hQg==
X-Received: by 2002:a05:6902:2b0e:b0:e9c:f19b:4112 with SMTP id 3f1490d57ef6-ea3d9b361e8mr1022592276.33.1757633590940;
        Thu, 11 Sep 2025 16:33:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 3f1490d57ef6-ea3cf0047aasm887503276.8.2025.09.11.16.33.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Sep 2025 16:33:10 -0700 (PDT)
Date: Thu, 11 Sep 2025 19:33:09 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 15/16] packfile: refactor `get_all_packs()` to work on
 packfile store
Message-ID: <aMNcNTfcg1Jn+oeU@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-15-d10623355e9f@pks.im>
 <aK5jK2Q3McLnJ9Uw@nand.local>
 <aLawAalFhp9j0qVz@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLawAalFhp9j0qVz@pks.im>

On Tue, Sep 02, 2025 at 10:51:13AM +0200, Patrick Steinhardt wrote:
> On Tue, Aug 26, 2025 at 09:45:15PM -0400, Taylor Blau wrote:
> > On Thu, Aug 21, 2025 at 09:39:13AM +0200, Patrick Steinhardt wrote:
> > > The `get_all_packs()` function prepares the packfile store and then
> > > returns its packfiles. Refactor it to accept a packfile store instead of
> > > a repository to clarify its scope.
> >
> > I think that clarifying the scope here is a good idea. But I am a little
> > sad to see this patch proposing that we drop get_all_packs(), which IMHO
> > is a useful convenience function.
> >
> > In effect this is pushing out the implementation details of the
> > packfile_store out to every caller that wants to use get_all_packs(),
> > which I am not sure is a win. Should those callers care where the array
> > of packs is found, or have to write
> >
> >     packfile_store_get_packs(the_repository->objects->packfiles)
> >
> > each time they want to get the set of packs in a repository?
> >
> > I could see an argument in the future where we have object stores that
> > aren't packfile-based and thus calling "get_all_packs()" is not
> > meaningful. But I don't think we are there yet, so I think that this
> > patch is pushing the burden of that future hypothetical on all existing
> > callers of get_all_packs().
>
> We aren't there yet indeed, but the entire goal of this patch series is
> to prepare for that future. So we have to do some steps into that
> direction that might not yet be entirely sensible by themselves, but
> that are necessary prerequisites.

I understand what you're saying, but I think this is the wrong place to
be applying that trade-off.

Yes, we will eventually want to have callers handle object lookups
differently depending on what ODB is in use. When that happens, yes, we
should be pushing callers to go through the ODB abstraction layer. But
we are not there yet, and I do not see a compelling reason to force this
burden on *all* callers of get_all_packs() today.

> In the end there ideally shouldn't be that many callers that want to
> access packfiles directly, but it should be the case that most of them
> go via the ODB. But many of the callers that we're adapting in this
> patch are callers that are deeply tied to the actual ODB on-disk layout,
> and we'll have to tear down the abstraction layer between ODB and the
> actual backend used to store objects. It's unfortunate, but we cannot
> really avoid that in a bunch of situations.

Maybe at some point, but that is definitely not the case today. I count
nearly 50 mentions of either "get_all_packs()" or "get_packed_git()".

I am fine with evolving those callers one at a time, and think that the
"the_repository" conversion has a good model for us to follow here.
Replacing, say, get_oid() with repo_get_oid() over time instead for
forcing all callers to do so at once was a good idea for a number of
reasons, and I think we should follow the same model here.

Thanks,
Taylor
