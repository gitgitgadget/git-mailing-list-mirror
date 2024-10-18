Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F3018D625
	for <git@vger.kernel.org>; Fri, 18 Oct 2024 20:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729284658; cv=none; b=L7rTxfheUhxc/OEyaJ1hhcxf7SanrCiCkD0Nss4Gc4aWxMrpFjpbzHnoHjVgjucfjvSTWuRllvKteYEUU/8Wo4OmPnOwB7ooe1JwKZ7NndQqRDodJrQUtEvAKq4scVanPgY45W4fO4KGGGmRvMfzKhIR2EOZDLLeAMJwnw+c8dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729284658; c=relaxed/simple;
	bh=eA+Wf8Fw5TKRYLY/APlFY8AQjb2VlpZHkgqCFo4Ei4w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M0+8/LvWRwSzyn+l2InV7J6TuOsB5zmtHVH9Gi3kWJy13C+amuF5aT3/iBepERzfvU7/2gLTKAOT/g54v/VvstKjUbwx7eYqKfzMKFjRAyWxhSl9siYGXQzTw8HYwQDhqCjFkUgE1aumqSYJawRk2Zex9CAvSA61zWiF3Kox+60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=ypWEgW7o; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="ypWEgW7o"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e2903a48ef7so2620183276.2
        for <git@vger.kernel.org>; Fri, 18 Oct 2024 13:50:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729284655; x=1729889455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA+Wf8Fw5TKRYLY/APlFY8AQjb2VlpZHkgqCFo4Ei4w=;
        b=ypWEgW7oA/LJnW+9VYWApXX+3tPkAejRmuuv4VPI+0Swm+XyJh7p8qh05bolytqnbn
         O9fq9+oi2MtaInbliAK/+vd3LY5LXvdiWfrRZQ9EAkU4kTVdOMX5p5vfZcqjlj35FPZ0
         TcIHplOvxZIkOg9RPjB/chhbgajCIuDHW5SYqbMmByTgLH0TRI8M6OVVsPe8j/B4/diz
         +L/mmPHArjzBWvphyPd5I9D9ryd6Xx/I0yB6570loSNCiInRTvVQ/h7V80eJX3P4UNho
         AicUDuddHfXMWbB+tmVh+LfrfNWvWW4c47fZLtHpl3AWtAmQRZTMeiHmFSfFkOMi80Ch
         bwjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729284655; x=1729889455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA+Wf8Fw5TKRYLY/APlFY8AQjb2VlpZHkgqCFo4Ei4w=;
        b=NufEjtA74jFMIJvVeQ7b7+VP1MNUZPW8UGeTrf6Bj5jNctjT26LfrKwX73hBgggiDY
         jsoj+GTk5YwajZvUAgrGmH2tZg0GPsG1yVA07cLcb5QKGjieAraDY/mLgZlevZ4Vx2cf
         Kn5+YxwpJ+tmcIsuf6cOKYFNkYyvGJerOlcS1gmeOFsZueTq240jBeVhoZHTq4JIbLuy
         ayVh+YVpWv/X7LaIbfPXTVC9Arxkn6msSf/l3BfkRCztrZTCw2W0Ale8M+gulXtzpXwL
         3F5yWE6Fl7Iriv4tEGT0NHXX/DqIpbO4EV7zFija9qcLr/Y+Meeg9fUV+91s+e2qWLLh
         NWGA==
X-Forwarded-Encrypted: i=1; AJvYcCWTVM2K1hfruwWRrclsWyCaJLfZ/C9ZEyqZnyvjBw5XtCXfxwGslPNGBkvpEDug24NZz4g=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRmSR0+diCu5QQEX//+ubGnxkbwwRjLAzCUGgucTlRgCDOd6bf
	zeFZvhiz8L8Cn9kWRlh27j5NWjXGFApMJxYPDsMEfolv+7hDCMcHasIC/V3bYGA=
X-Google-Smtp-Source: AGHT+IEw/7PSNj/+BwBs5sgXz31wZxXB6kkrzuMde72NbW6ZS1QIybWDV6icxobz2ArbngcaAPqJyw==
X-Received: by 2002:a05:6902:705:b0:e26:afc:7af4 with SMTP id 3f1490d57ef6-e2bb143591amr3490881276.28.1729284654980;
        Fri, 18 Oct 2024 13:50:54 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e2bb022d9c1sm450301276.35.2024.10.18.13.50.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Oct 2024 13:50:54 -0700 (PDT)
Date: Fri, 18 Oct 2024 16:50:52 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Bagas Sanjaya <bagasdotme@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: clar unit testing framework FTBFS on uclibc systems (wchar_t
 unsupported)
Message-ID: <ZxLKLJCgiA3oY4Nr@nand.local>
References: <ZxCJqe4-rsRo1yHg@archie.me>
 <ZxESP0xHV4cK64i0@pks.im>
 <ZxEXFI80i4Q_4NJT@pks.im>
 <ZxGN9zzt55GcL4Qj@tapette.crustytoothpaste.net>
 <20241018045155.GC2408674@coredump.intra.peff.net>
 <ZxHrIBCdnwdRdXAv@pks.im>
 <20241018052448.GD2408674@coredump.intra.peff.net>
 <ZxHylOLHaxP8crom@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZxHylOLHaxP8crom@pks.im>

On Fri, Oct 18, 2024 at 07:31:00AM +0200, Patrick Steinhardt wrote:
> > Overall, I'm a little sad to see all of the #includes in clar.c. We have
> > spent 20 years building up git-compat-util.h to meet our needs for
> > portability, and there are lots of subtle bits in there about what is
> > included and when, along with various wrappers. And now we have a new
> > subsystem which doesn't use _any_ of that, and has its own set of
> > includes and wrappers. It seems inevitable that we are going to run into
> > cases where a platform we support isn't handled by clar, or that we'll
> > have to duplicate our solution in both places. I wish it were just using
> > git-compat-util.h. I know that means essentially forking, but I think I
> > may prefer that to inheriting some other project's portability problems.
>
> Well, I'm of a different mind here. It sure is more work for now, and I
> have been chipping away at the issues. But in the end, it's not only us
> who benefit, but the overall ecosystem because others can use clar on
> more or less esoteric platforms, too. It's part of the reason why I have
> been advocating for clar in the first place: we have a good relationship
> to its maintainers, so it is easy to upstream changes.
>
> So yes, right now we feel a bit of pain there. But that's going to go
> away, and from thereon everyone benefits.

I'm not sure I agree wholly here. In particular, I think saying "a bit"
of pain may not be capturing the full picture.

Will it take us another 20 years to resolve all of the portability
issues which Clar suffers from (but git-compat-util.h doesn't)?
Probably not 20 years, but I don't think that it's on the complete other
end of the spectrum, either.

TBH, I would not at all be sad to see us "fork" Clar into our own tree
or have a new repository upstream that we track with submodules, etc.

Thanks,
Taylor
