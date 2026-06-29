Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C39B393DCA
	for <git@vger.kernel.org>; Mon, 29 Jun 2026 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782713335; cv=none; b=O1LFWOu3F6Cla7H01BeVCzYch6xe7PQuceA6wwKqpkG+/pUzbSdO1ibUlUgeMNPm/2sjTQyaf50GAqHV/TYtuTa8ggrBb6lHopeUgh2Q6C7Cv1G9PV3jVuxaGtv6P9four2wJHuGP0+QKpGlWpTOhwJNlzfvnp3zF0ZfacRerD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782713335; c=relaxed/simple;
	bh=7YzGjbobvEttJf7pByoUsjYiEqk3Mcmol9qoJkLzwqc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ONFgrinmcteLNsXM1PjTIpTh+SILtgcaPcFQAMVGPa179MLbfu+kEHQwD9S1lK5EOmdCTtFWB7S0LlmHaX808QSC+eBy3zoP6T4+bYCT1uCqUSUUSWrgG9JAe8sGl3muwzBNcfM94xJHzheo7YHbXnscjadavScjdG3iE6raFGY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=vhUGokk4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k+M+aB50; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="vhUGokk4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k+M+aB50"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 8E4831D00095;
	Mon, 29 Jun 2026 02:08:53 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Mon, 29 Jun 2026 02:08:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782713333; x=1782799733; bh=+9O7kqCTQQ
	xNvD/v7CtGC1zbjZK59MVi0bc8Vxvv7Vg=; b=vhUGokk4zWRvDLPDw6Fb9cGeQx
	dzFPVsq7804nh21NyG7/4YapOW2mG1qfLhMYknKVTpq1RgqH9PjuBEJRlv/mqrXo
	/J9+RLdmd4zVZGJHn2o4OjPVmLFe1k6LKHUBPKGc2/yx7psyqlU0smNaGaPTNk/M
	4IZFWlhTZw9NQKBkMn7pCx3zb5MEykQp5QxlQYqrSsGoFeYxihro6LNz6AnO1pqZ
	D8ck0iKHANAedJXmzT7OH7dlJRHJSGXNxYp2fiHY9cwm3yN8P27M84feSje/djW0
	/w543pylDeBsDaKrwwa9a1XEZgtLq2PtbgufY26V4N3qAvcmyXM9/qaXtmFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782713333; x=1782799733; bh=+9O7kqCTQQxNvD/v7CtGC1zbjZK59MVi0bc
	8Vxvv7Vg=; b=k+M+aB50aMFeT6L16CME/65FerM7cG5i6SQVgu5YDAGXLtPdYk6
	3alSg3wsVb7qSmG4OfTlzKrzFJi7YXEBwBJKtZT4tQ0Fr0OCwXgkhT7IpuUxiO9V
	H4XVOL/JsINNsB1tA1qddCXBz/QEHoqeCfGFVotJRMe9NkOmHhcJYSOtPvobihiU
	G7WALA/ocAQr+h3M8TrPsSsh3v+FT9o/igCaeLJrES/hl4Uu4hnUcIiCRlMA4q/X
	oW3a98n1GQDCYwIXIqanv7Mxe9V6baksbRHUA09kWw+Ef4vnr1ZSTZNuYxNhgnu4
	Jbd2CbVUsyJBO0KFukA88NXUmXRFHPKsMdQ==
X-ME-Sender: <xms:9AtCakeMt7P9f8YIhuucnUcz3m50T78xAVISCnav4EWyFPptx0pXvw>
    <xme:9AtCavjzjzT0qbhW4I9RhKPViTxzKA0wS_j3x9UJDWGOKTgQT9GvVe75I76KBpJj7
    cSzO6biU6du8D3Jv5capppqGT7dQbKiYgGhd0j947PU7zGcxZzvcg>
X-ME-Received: <xmr:9AtCasx_kRWB19pj0XXptZH3Hz5cRYP_xd0BbdXCx1GaKyOsQ0n9ts2x_PsVavJM1hvdzSBeXbVkApwUUDkWNkQ581SVYrHgHVyB8oev6LgF>
X-ME-Proxy-Cause: dmFkZTEEVfkx+0d8ep96CBi6ly4X+RAY3iyYF9FphVm+Ky/DkbWMPi0XgMz6I5ywlirW6Q
    nG7AqLdC1gB0MPk3AGuJXKzYVzvFRKjtvge+q9PsortSOik/n7efsEyYoeOxmoyOdRgkVk
    YQh71Fs17ZExcG0N7aJSrNerfn9c7cELjvHb/VHGpvSPPb4zeuVZsZwFXl85TPQ9JY642X
    ktNatxCCvKx5Uj5AKslCsdbub9UPL7ch+mmnO+8kJwIdgs1P9yzKJ2bybYhuwwVSD1I1bK
    Gy3qjmNW3h0alU58vB1U9NG2kaY/E52tg76Z/bYi3QIwy74r7pTELEI9HWvG8W9B5NuuZa
    faEgXt2Ta6XrQLVvilDQ1UTSg6lNtegodTE1vZpUf+smH/BNO5qb/Fw1Vfp2od5VRDLj76
    c3LoXbk+qez0CqCBix5xgXRO8hKLQEh6KgceRZ8FzcikCb1KNSmoP13gQbS/e5p3rXg+R1
    UpIdDwjE6MGtVCsCdNbVYvDjeQeHIe7vH8vhYeStCBVGgE4tdMJpzQHhvGCcR4ziiP7DHS
    M7pX5EQ/n4TMo5+37HKigcK40q9VM6h31WWTjHl/9e1dhCltQHwUjOY+rVwOJ2WRAQu15u
    uvKKtEwQ3I/fU5u9TLWnQAMqjaFVkWotkd5UD1cE7zGZ7ASRNp5p1lCthYKw
X-ME-Proxy: <xmx:9AtCarPQBC8nwPGFKx4AxqGYntF5eKjDcj-lK-wH3GnNgWGIxJ7onQ>
    <xmx:9AtCatUkmgW9yTIYN6EXfhadiGZMR047uyjIf6L1VGCEaxbXPIIavQ>
    <xmx:9AtCav0Q44hhj1WnJ6V4CsCw-3iNVtH7Jlo9ZkE3PB0TEr_iKHjZMA>
    <xmx:9AtCarplcUT0PHCQ-OXcyNT2FGNLbQcS-mJVSp84EIvIOD3bV8j0Lg>
    <xmx:9QtCatlyrlKQCTzEp3oTeQ0GtJwBjtlSPtD4_9VDrl3V6cQH4YRROtjL>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 Jun 2026 02:08:51 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id d18d7363 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 29 Jun 2026 06:08:49 +0000 (UTC)
Date: Mon, 29 Jun 2026 08:08:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: "D. Ben Knoble" <ben.knoble+github@gmail.com>, git@vger.kernel.org,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH] meson: wire up USE_NSEC build knob
Message-ID: <akIL6oJgUv8J8SB2@pks.im>
References: <c4c5ade901ff95b0f95939ea818870e4f3d59da1.1781971201.git.ben.knoble+github@gmail.com>
 <20260621174934.GC2206349@coredump.intra.peff.net>
 <ajjuoS5Qc3K0nCRl@pks.im>
 <20260628081806.GA3594700@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260628081806.GA3594700@coredump.intra.peff.net>

On Sun, Jun 28, 2026 at 04:18:06AM -0400, Jeff King wrote:
> On Mon, Jun 22, 2026 at 10:13:21AM +0200, Patrick Steinhardt wrote:
> 
> > > So I guess if we wanted to go further it would take some digging as to
> > > how each platform behaves, and then flipping the config.make.uname knob
> > > for ones where it can be argued that the behavior is always reasonable.
> > 
> > Yeah, it would be nice indeed to figure out whether these concerns still
> > apply. If they do, I would argue that it might even make sense to remove
> > the build option completely. It doesn't really make sense in my opinion
> > to have a build option that nobody uses and that is subtly broken when
> > enabled.
> 
> I suspect it works just fine on some platforms and some filesystems
> (i.e., those that actually store nanoseconds on disk). So probably Linux
> with ext4 is OK. That's just guessing, though.
> 
> If I understand the original problem correctly, then doing this:
> 
>   touch foo
>   ls --full-time foo
>   echo 3 | sudo tee /proc/sys/vm/drop_caches
>   ls --full-time foo
> 
> should be instructive. If it shows the same time for both "ls" calls,
> then USE_NSEC would be fine. If it doesn't, then the system is losing
> the nanosecond information when it drops the cache and has to reload
> from disk (and thus USE_NSEC would cause spurious stat mismatches).
> 
> On my ext4 system, I get the same answers. So far so good.
> 
> I get the same answers with a loopback-mounted ext2 system. Which
> surprised me a bit, but even unmounting and remounting the filesystem,
> the nanosecond times are still there. So...I guess ext2 supports
> nanoseconds.
> 
> I tried with a vfat mount, and it also works: we don't have nanoseconds
> either before or after. That makes sense, and implies that modern Linux
> will always be OK (because it limits the cached VFS response to what the
> underlying filesystem can handle).
> 
> So...maybe this is just a non-issue these days, at least on Linux?
> 
> > > But that's all outside the scope of your patch here.
> > 
> > Kind of, I guess. If we figure that this mechanism is still subtly broken
> > then I'd argue that it doesn't make sense to expose the option via
> > Meson.
> 
> True, but AFAICT it probably is safe these days, at least one some
> platforms.

Hm. That makes me wonder whether it is the completely wrong approach to
make this a build option then. If it works on some systems and only on
some filesystems, then a build option is just too coarse-grained. A
distro wouldn't really be able to ever enable the option, unless it knew
that repositories will only ever exist on a filesystem that works. Which
I guess is an assumption that no distro can make.

So instead, I wonder whether we should treat this the same as for
example "core.ignoreCase", where we only use nanosecond resolution when
opted in by the user. Ideally, if we had a way to detect brokenness, we
could even make git-init(1) set it automatically.

If so, we could unconditionally enable nanoseconds on platforms that
support them, but still have a runtime toggle for filesystems that
don't.

Patrick
