Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A5241BC08F
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 23:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768348070; cv=none; b=hTnBnVtY6D6EShOdXEHjiC07roywLqGpA/TNwLYFe8YouULXtsf2sUWtt0tsPTI9DWHlNYeWOlzYzxisBUrYDlRbDNjfypUIB4SrguF+75rROU82baQbPV6pIkoxs29zF+4/mUXIJto6P3HJPdb4Mk90m0GFMKh6ZfSJVrfF2hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768348070; c=relaxed/simple;
	bh=UtVTyyrjWMHbBOlhTW6OJcHXduotB/566JaHuJm04sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oqQhyyoQDKrk+devrbMw/w7gY0bzN07d+y7hX0/aOWn8eCg4IRXfZQ4uX9ncpf6+TzxDWo0amcR4PVu1kKg+8YCpueddY8B9/UYk4i6PUREFacaJTESRVUGKYO08jz8f0yh/anqYnJ/xYE8Sxjk4KvHU9eJX5qx8sV63wLDlOD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ZlhoZKHw; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ZlhoZKHw"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-7926d5dbdf7so37834907b3.2
        for <git@vger.kernel.org>; Tue, 13 Jan 2026 15:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1768348068; x=1768952868; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=5P0Y+i3WhmJjkjLF/ZamGQF7kl0VF3Wuk/CDO/oFyOk=;
        b=ZlhoZKHw/1FNGvt6o+nEFPFrXJb+wsvXiL8jjoi+cGUgmODvPD/WMuqDv7F+pm32Ou
         gfjxlx4UHIscXZA4eTWM6g4oLY1WZG5NP6MO3bs8EunYWY62drPpubc87Y/C/G3dxZWy
         BXYNi+o3M/mlmCQVPjD4m/GiGSdzw324I7n5sd02LhEs261MHCnZ9WcJv8RMnYPdIrA3
         BklzzzZbOyWod57orIywMpvfD39Gwi+47nxa+W9I4oo70RU0pjSnfBSQ/pBkTirP38iI
         TijybZlManHu/k8QB6KOUBkl8Lm26QuPfUKPoj4Cg5d+gxdCXfXsqiB3K909fGx1YtLg
         kDBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768348068; x=1768952868;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5P0Y+i3WhmJjkjLF/ZamGQF7kl0VF3Wuk/CDO/oFyOk=;
        b=XAB+Exfh6k22iRHGdb5TyWNBjeUcW92eu0aCRDLY94POTOf/jYQOdG2oyxJuVLKphi
         UJPFZR3FiT1ePERK0yQTonsapeYPAzN9TCUQasHidlEKDhWwQEKl5C3g/Gj+7QGGUNO/
         TJxuFPHqPlPYW86rdcAH6rykoQHNATLIlYS3oqRQdKFyHstRopAf1fx91igkbO6soAFM
         MxtxZKvzcbs6cvdgK/p6jQTE0jfcMD0+WeMFXG0yfHVFS4FxtPeOlae2pwxFK47sgOKQ
         OHZG6iyjc6xS15ePD134dxY2Jv/pFwe3YFNI4p/1cBz0ZBNtYEAIDPRh31esKJavRviW
         B8oQ==
X-Gm-Message-State: AOJu0YyvaECOdJuuBaru96NV9RB+SShR2PAwVRbCdMqFs1uezC3wUL1C
	muVTBeZEOHg2I4nigiCcAQjuuePxXHSQXvSKNbhTZDbbpvseNExIKoUU1K9gqamRUbayalzPoN0
	/6l5V6iiLOF0w
X-Gm-Gg: AY/fxX6Aa4CwlMnBtkjZQt8ZY5D7MLrYlKwArxi4HYFZw9T97UR//mHHx8YBj5XF1SL
	RV5ei4M3+7l52QQoc27zr0yAaH5Hcnuyba4uTnU13WX3pmlTAMWFUO03kTgjLDCe3TBXuAx4WtX
	49AawOMTtm4gQxj+Zl+iWCu45UP5g22R8jhd1txXn/whIfX+dn1btNXcCFsdkYfEphH+yM1USc3
	8X2Pk2oNfKIKLL2JWBz6ZqHEYn5n+N+7R4IRJUB5TELgkmxUnIH1b8pbobHuJW3jhUpJWDpVmp3
	Ki7NTSzPedQUrM64Z8+c0oF3QMJnb2ygGgOAytXE/vFKWgWUtbO5dpVXGMr7L2qBsyIzVlKL6yP
	skUZbqlIDci2nBMXvsajBweKwLAg8BhwGjGv7YYsJ4r16qLHYyXZvAfFKKlXsXmXIJHlkZZ1onU
	KjmRbwr6wXP1zt5i+F+9CxvwVttS8DJovcc5UwoQd53YN77JMRAqWgdYqe/HsGg7kT2Ago8+BjM
	V40lpYaeWq4eLvdSw==
X-Received: by 2002:a05:690e:14c9:b0:641:f5bc:6977 with SMTP id 956f58d0204a3-64901b1b651mr838881d50.83.1768348068036;
        Tue, 13 Jan 2026 15:47:48 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7938d86d175sm14722047b3.34.2026.01.13.15.47.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jan 2026 15:47:47 -0800 (PST)
Date: Tue, 13 Jan 2026 18:47:46 -0500
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 17/17] midx: enable reachability bitmaps during MIDX
 compaction
Message-ID: <aWbZopq71ZUXvUsr@nand.local>
References: <cover.1765053054.git.me@ttaylorr.com>
 <d6a4e6b69552d8626e6df2d7cd042b9fe151914a.1765053054.git.me@ttaylorr.com>
 <aTfOBz3ElQYi6j8i@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aTfOBz3ElQYi6j8i@pks.im>

On Tue, Dec 09, 2025 at 08:21:43AM +0100, Patrick Steinhardt wrote:
> On Sat, Dec 06, 2025 at 03:31:50PM -0500, Taylor Blau wrote:
> > Enable callers to generate reachability bitmaps when performing MIDX
> > layer compaction by combining all existing bitmaps from the compacted
> > layers.
> >
> > Note that the because of the object/pack ordering described by the
>
> s/that the because/that because/

;-) great catch!

> > previous commit, the pseudo-pack order for the compacted MIDX is the
> > same as concatenating the individual pseudo-pack orderings for each
> > layer in the compaction range.
> >
> > As a result, the only non-test or documentation change necessary is to
> > treat all objects as non-preferred during compaction so as not to
> > disturb the object ordering.
> >
> > In the future, we may want to adjust which commit(s) receive
> > reachability bitmaps when compacting multiple .bitmap files into one, or
> > even generate new bitmaps (e.g., if the references have moved
> > significantly since the .bitmap was generated). This commit only
> > implements combining all existing bitmaps in range together in order to
> > demonstrate and lay the groundwork for more exotic strategies.
>
> Will there also be a follow-up patch series that introduces geometric
> repacking for multi-pack indices?

That's the plan, though I have been calling it "incremental MIDX/bitmap"
repacking. The idea is roughly what I presented on slides 80-90 of my
Git Merge talk from last year[1].

The gist is the following:

 1. Perform a geometric repack of all non-MIDX'd packs, optionally
    including any packs in the top-most MIDX layer if it has more than M
    packs.

 2. Generate a new MIDX layer containing the result of that geometric
    repack.

 3. Perform layer compaction on the new chain in order to ensure that
    each layer has no more than 2x the number of packs as the layer
    above it.

This is a conceptual overview, so there are a few white lies here.
Namely, we do not write out a MIDX containing the result of the
geometric repack from the first step in all cases. If it would be
compacted in the following step, we'll optimize out that write and
instead write a layer whose contents is the result of the geometric
repack and the contents of the layer(s) below.

Compaction is also done in a single pass, so we don't compact the same
layer multiple times during a single repack.

The result is that we end up with a MIDX chain with two properties (see
slide 131 for more details):

 - Newer layers contain a greater number of packs which tend to be
   smaller by object count than older layers.

 - Older layers contain a smaller number of packs which tend to be
   larger by object count than newer layers.

I have that working in a WIP-quality branch[2], which I have been using
as a base to pull patches out of (which has yielded parts 3.1 and 3.2
thus far).

> > @@ -216,6 +216,8 @@ static int cmd_multi_pack_index_compact(int argc, const char **argv,
> >
> >  	struct option *options;
> >  	static struct option builtin_multi_pack_index_compact_options[] = {
> > +		OPT_BIT(0, "bitmap", &opts.flags, N_("write multi-pack bitmap"),
> > +			MIDX_WRITE_BITMAP | MIDX_WRITE_REV_INDEX),
> >  		OPT_BIT(0, "incremental", &opts.flags,
> >  			N_("write a new incremental MIDX"), MIDX_WRITE_INCREMENTAL),
> >  		OPT_END(),
>
> Is this new flag actually incompatible with the incremental flag like
> you claimed in the preceding commit? I had the impression that it should
> be possible to write incremental bitmaps now.
>
> If that's not the case, we should probably have a call to
> `die_for_imcopatible_opt2()` somewhere.

It's not incompatible, the comment is just stale, thanks for pointing it
out!

Thanks,
Taylor

[1]: https://ttaylorr.com/presentations/git-merge-2025.pdf

[2]: 'tb/incremental-midx-part-3.wip' from my 'ttaylorr/git' fork on
     GitHub.
