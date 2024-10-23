Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F6B11CFEC8
	for <git@vger.kernel.org>; Wed, 23 Oct 2024 17:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729704334; cv=none; b=tNv/JyS/hITjyiZoqKmCgFZGzd19quyredAKAWSNDzfVxXF2XjXwmPhoqhxb0itYNTDzK2gqI1UjDy6MRGLL1U4X7Tphaen6X66CyKk8GD/Izd0r6AKpFvi8ewn6Y9Mim03WpfY8B4b6A7QEXuRUWu8+m08XyI5Vtpo5/wWBbVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729704334; c=relaxed/simple;
	bh=nh1KNuKPDxslJtVAwn3tFwzn8fD88o583n/j3WIjffQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODPi5ovfFweveG1xK9A4QjYBUiPXExPG758GIPEaFw2ipxNHMhFwj96T1K4fmsqxe1MfAvBe6kNgdzTkOpjhDL3uFYpHKO8UBEQdCJWhN1N+rXxgS6GWWxZAMlKQd5BvH8U8SNgouo5WIrUUPd6Js6kwqNgi2UKphprJokVZGe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=FTpp9SxE; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="FTpp9SxE"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6e59a9496f9so80722527b3.0
        for <git@vger.kernel.org>; Wed, 23 Oct 2024 10:25:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729704332; x=1730309132; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=up7XKql8ZwsAQtY2RqazWBJZN1tem8z8P5qdn6RqMFc=;
        b=FTpp9SxEqaRGtwAKtKGcDG4bui5p5Gxb/7LfiTjq+nC+r4RDXRWjBDK0Mi/yD8pOUO
         KYawAfEti60XdUuYZOURIBoaCSVkck95Urx7JPP6c+XfdvoZN4LsKCQagpCcTIR5mYIo
         BaALfZ6j2UJjK69fTpdD82l8lnVmnpMZNNd4JRZrtOxWtI/3AVA/u8qf3MVM+C3iyEy8
         6Dt4qrZDx3P4iWX6z4c7U3wBH7xRogBEgflVg4igSG9sotH4uYqX0WNJDkTrQAqBHLs1
         9Lz2gQwIgfEsGFPLpxSHKCKB5+BAuN26QD7wHSnjUL6MkkiiARrrShLyYMai/I0yjFwB
         1Qug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729704332; x=1730309132;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=up7XKql8ZwsAQtY2RqazWBJZN1tem8z8P5qdn6RqMFc=;
        b=lWDLMj9kSGfIfp/hmxvAL64YHPqxU6U/RI+wNiS93ggmYlbhS+Fc9uo76nV1ILNYfM
         2zVrrZO4+Hnwi2IJxyq1WkkTEKAU/gUt4VsZkhrAKyBhrgyBvxxUZ7uRFMGmDWhHVbw1
         RNLDsNujSzO0vHyC04fxQontpVI7ub9x51KbaMf4nunMJ6OFd/rrcvXi+Fpk/PQIdPQU
         NVNtHLbzdALD0W/azt9yzQKBpiUMg3G/qJzTmJ4VRrtsnlLypz9fk7/TzzvezRVXGKJf
         yWw/HyrUejMEm24BzzWPdxd/wyqo7SAl7wiB2DUeSqPB+2AxFoPVBFW7mmPKv4UPLVSt
         PLHA==
X-Forwarded-Encrypted: i=1; AJvYcCVXumBPQNdpALlvg4qdyMevonWpUYRVUhoPOQ40HaWa9IMsJ1+dN+/nRII1PZwx91s4Pfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq9CLw0s8sM60fpsPDJZQhWsl8LoVPKy/Lb9z+qBwdbDCbIv+I
	wQRSnUFO9qOb6t2rdvXtgqctFJ/Njm/gRxI7dVo1eAn7hul+I0U+2PvQCef0oL525K4C0/rUfto
	/MRQ=
X-Google-Smtp-Source: AGHT+IE5sCSzCHZ/0aQ5wNlT94TMohLo0FGRiOuELDUU+f5FYUm5OxIXIEnpTkQ8RgbSX0j3SbEAiQ==
X-Received: by 2002:a05:690c:7090:b0:6e2:b263:104a with SMTP id 00721157ae682-6e7f0e30c6amr40518957b3.23.1729704332079;
        Wed, 23 Oct 2024 10:25:32 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e5f5d2e823sm16162617b3.114.2024.10.23.10.25.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Oct 2024 10:25:31 -0700 (PDT)
Date: Wed, 23 Oct 2024 13:25:30 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] compat/mingw: share file handles created via
 `CreateFileW()`
Message-ID: <Zxkxij1FThn7QoOg@nand.local>
References: <cover.1729695349.git.ps@pks.im>
 <907576d23d1dc39b679a323e74b6bfb227d6c17d.1729695349.git.ps@pks.im>
 <b106fb4d-3488-4fef-aca8-32e49efd0124@app.fastmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b106fb4d-3488-4fef-aca8-32e49efd0124@app.fastmail.com>

On Wed, Oct 23, 2024 at 06:18:58PM +0200, Kristoffer Haugsbakk wrote:
> On Wed, Oct 23, 2024, at 17:04, Patrick Steinhardt wrote:
> > Unless told otherwise, Windows will keep other processes from reading,
> > writing and deleting files when one has an open handle that was created
> > via `CreateFileW()`. This behaviour can be altered via `FILE_SHARE_*`
> > flags such that other processes _can_ read and/or modify such a file.
> > This sharing mechanism is quite important in the context of Git, as we
> > assume POSIX semantics all over the place.
> >
> > There are two calls where we don't set up those flags though:
> >
> >   - We don't set `FILE_SHARE_DELETE` when creating a file for appending
> >     via `mingw_open_append()`. This makes it impossible to delete the
> >     file from another process or to replace it via an atomic rename.
> >
> >   - When opening a file such that we can change its access/modification
> >     times. This makes it impossible to perform any kind of operation
> >     on this file at all from another process. While we only open the
> >     file for a short amount of time to update its timestamps, this still
> >     opens us up for a race condition with another process.
> >
> > Adapt both of these callsites to pass all three sharing flags.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>
> (Reading back) By default Windows restricts other processes (so these
> files could be in use by other procesess) from reading, writing, and
> deleting them (presumably doing anything it looks like).  But it does
> provide flags if you need these permissions.
>
> There are two calls/places where you need to expand the permissions:
>
> 1. “Delete” for appending: need for deletion or replace via
>    atomic rename
> 2. When opening a file to modify the access/modification metadata.  The
>    current permissions are *likely* to work but you could run into race
>    conditions, so the current set of permissions are buggy.
>
> The commit seems well-explained to this naïve reader.

Thanks for thinking aloud and summarizing your thoughts here. I found
the read-back to be quite useful indeed.

Thanks,
Taylor
