Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 111C8175D47
	for <git@vger.kernel.org>; Wed, 16 Apr 2025 11:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744801222; cv=none; b=LNz+sTpIFjuRh5T+AplliR2Fl2GDYLkiQ5gcwiC9Gr6N5aa9k0wZLE+V4MDyFpVk50ahyy2D4ecq4jNoOkRcis+GgLB452ACs1DOpVkPxn9NKJy1L5W20gjKW0IBRHtfx2xVYXDk/+WebSm4e59Zn0MHwScMyYdHFZN7FU9SrP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744801222; c=relaxed/simple;
	bh=+y7aa9A6ILZ4iGU7ggNZuCxZYXxPA7ii/mQxSlbxIqE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DtS4eWNcuea9pF1n66rGQtNf2LTovNhbbmvCCRra0TMh8rsABz/9GN8uq/87NVrV6Wthcq8w8NA9jWXb2JlZZ3s8lzwjifXA6VX2Ih81/+fp37HxBif41aVf8gRdqRumtcsqqwrTeNNTPOUYxjymmP/bMd/yZPBydF3OkQll7ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qzh4A5io; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TvqbmBGJ; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qzh4A5io";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TvqbmBGJ"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id ECAA413801A8;
	Wed, 16 Apr 2025 07:00:18 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Wed, 16 Apr 2025 07:00:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1744801218; x=1744887618; bh=f6rhVPvROq
	OQ+ZReT9W+OzkRqL7wwsVtJD3OfgWoaTk=; b=qzh4A5iodTCSSK2kHqNJ83misZ
	MOSosk8eiRXkRoKPiLOrNuz7cfPxTYnM5D1WYXqZKpEUxx4dByG9QLEwNqx49g0v
	OHcR6WYoyPu0Sak2HnXdXwpgZvohXC0wpIu9ePrPgLg3knEOVd1dwu4YQTM0uNw6
	/cRqbvIRHh7htLBqGVa3H4Wet4WRBPDdf78zZADSBQCm+VCGeAPfdWlHgOQ7r+YL
	WJAC37En+IY997men0NvSZbwCt+mFbrJzk+yev+SF/oeujAx0iZGMbw5+N7IeNfF
	Til3bvSY1OxtdntgxB+G/loWY8m6jp7PK7jGelFANc1gqQYcEis4Tm4Fvb5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1744801218; x=1744887618; bh=f6rhVPvROqOQ+ZReT9W+OzkRqL7wwsVtJD3
	OfgWoaTk=; b=TvqbmBGJcCOlAbmrmCYPDYkW1krO5T0/gjKCS+Z6+lXT12RAwMu
	pQE9Wvf3iinwCqdPvSkvNbfbvIJTLv6j1NkEy1+D3paynm111iJGFT9EaY+aiQ0S
	FC8qYDYmNhX9DACMgFFJr29teeBLpyg/JEfQTTA4D3h5LAL/Rgvydv1Bmb3ufKkF
	Tru72kH50h9eqb+12CSR+d72sIYSDLsEq56ZXIWgL57WoMDUkeMZYR+CQhv1bKCj
	57G2Fp2zwtCUshzR0NuftNDjCxkUOdb8mi4O8oLnsCKvKdC7dZMYFloLfJvxm1+e
	odtB+gbLkG/itNtglu+eyFMGqDH6D9AQ+hA==
X-ME-Sender: <xms:wo3_Z1LuBUTXmnDqWhkq51yHB8jOvFOUGnXmVU5QpoXiV0TyaIzfVw>
    <xme:wo3_ZxJBMmJBe0MvdYxOYCO7Dvfuvu6WTCMflHvMm8td476EHOUxWwyax5FMgRIfK
    -kL2xMfmUH2ei-C4g>
X-ME-Received: <xmr:wo3_Z9s41IUo61aupmLoiWH8iHEzHr9UmLhGflQV6dc3pRZnTzY5onIijHuE4O8Ezz3zMRMzVxubTrpRXYl8A4_6CX9uIfXFGNuUL7B-uKcwAQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdeiudelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepiedvheelheeuhfelveegvdekgedtueefhffgheev
    lefghfduueegudfhgfehhfeinecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdpghhith
    hhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikh
    drudekkeesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:wo3_Z2ZjOD_Yz1TQAg14Dydw5pqik3y060yLDuSr1g9CghikaIPgdg>
    <xmx:wo3_Z8a6m-bJ1GYbpFOvvpjkOjYUv356JS6qC-ST-Z1gDbeeDg2p6Q>
    <xmx:wo3_Z6AGi33Y8ICMlssWRFDwv1NPWgIUfgUjcH6_mCMl0NV0xZxtVw>
    <xmx:wo3_Z6YjQ6oFu1G-o0P6IckdOaFuXgepcmMkL7pdh4Tme-3P1afJhQ>
    <xmx:wo3_Z1kZIoXiBpLLosnZWHitCu4VTDqWITa3Lf-Ka8aPQbCkDrD0Xk_3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 16 Apr 2025 07:00:17 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3de33e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 16 Apr 2025 11:00:16 +0000 (UTC)
Date: Wed, 16 Apr 2025 13:00:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v2 0/5] meson: wire up support for benchmarks
Message-ID: <Z_-Nu27GeW0o2E0f@pks.im>
References: <20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im>
 <20250414-pks-meson-benchmarks-v2-0-04377080a167@pks.im>
 <xmqqplhdo5ji.fsf@gitster.g>
 <xmqq34e9mgot.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq34e9mgot.fsf@gitster.g>

On Tue, Apr 15, 2025 at 11:18:42AM -0700, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > Patrick Steinhardt <ps@pks.im> writes:
> >
> >> this small patch series implements support for running our benchmarks in
> >> "t/perf" via Meson. The series does not aim to replace "t/perf/run",
> >> which is more fully-featured and allows running benchmarks against
> >> multiple different trees. Instead, this series only allows running the
> >> benchmarks against the current tree. Users are thus expected to continue
> >> using "t/perf/run" for more advanced usecases.
> >>
> >> Changes in v2:
> >>   - Adapt "aggregate.perl" to use a "/usr/bin/env perl" shebang.
> >>   - Link to v1: https://lore.kernel.org/r/20250331-pks-meson-benchmarks-v1-0-b2ace85616a3@pks.im
> >>
> >> Thanks!
> >
> >
> > The previous iteration of this series has been kept out of 'seen'
> > for some time and I didn't recall why I did so.  With this iteration
> > merged, all GitHub Actions CI tasks with "meson" in the name are
> > failing, so does "documentation" jobs (which recently acquired
> > "let's make sure meson-based build does the docs fine" substep).
> >
> > Can you help seeing where the merge went wrong (yes, I am suspecting
> > that there is some stupid merge mistake there)?
> 
> 
> Just a few test CI runs.
> 
>     https://github.com/git/git/actions/runs/14457387669
> 
> is with this topic mergecd in (with alleged mismerge).
> 
> This one
> 
>     https://github.com/git/git/actions/runs/14406901394
> 
> is from last week without the earlier iteration of this topic, which
> fails a few meson jobs.
> 
> linux-meson job that fails with
> 
> meson.build:689:19: ERROR: Command `/usr/bin/git -C /__w/git/git ls-files --deduplicate '*.h' ':!contrib' ':!compat/inet_ntop.c' ':!compat/inet_pton.c' ':!compat/nedmalloc' ':!compat/obstack.*' ':!compat/poll' ':!compat/regex' ':!sha1collisiondetection' ':!sha1dc' ':!t/unit-tests/clar' ':!t/unit-tests/clar' ':!t/t[0-9][0-9][0-9][0-9]*'` failed with status 128.

Hm, curious. These lines have been moved here by kn/meson-hdr-check, but
the logic already existed beforehand. I've Cc'd Karthik -- it would
probably make sense to investigate (and ideally also fix) the issue as
part of that series.

> and
> 
> win+Meson test(3) that dies inside Python asyncio both look
> problematic.

Yeah, this is a result of cancellation of the job. Johannes already
mentioned this issue to me in the past, and it's known that Python's
asyncio is a bit wonky in Windows. The problem here is mostly that
Windows does not have proper signals.

It's not a huge problem given that this only happens when the job is
being cancelled, but it's not great, either. I've already invested some
time into improving this on Windows [1], but there are a couple of
uncertainties still. Anyway, this should hopefully be fixed soonish.

Patrick

[1]: https://github.com/mesonbuild/meson/pull/14311
