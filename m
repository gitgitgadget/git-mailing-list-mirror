Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E6832857FA
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782077650; cv=none; b=TI5aeFlPv7GPwOlhcyII3WO0NDofbUaVHQ1r9re6XVvsaNrAS1z6VF0RllA0YYQwtki7FSve82c5mCw/2Cx8hr/wFpaMHmpBFeu/+BxBq740Hjm8W0xKvi4Il+vOiVgUSyFbRy16WcfXasZU7HqOA7H7/SGVyjxpr9uy+pkfz1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782077650; c=relaxed/simple;
	bh=9sZ+bvsnV3Lk3x1wzXf3NdpNCX9uMxARnPdyGp7Fn04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i0AwPKn4vPko8m9efR3hJYGA2fCi8SDxa+FOiuprDNlEsWESA2DB26LjCC4g78y26nVuJVcDi/TiZmCB+imQPlTJfDJwaKeuOlYOPRaQbY3ych4VTHJThiBaJChs09yHLNMMFqF7kj4dq4TaYD8H9axF5FL7w1VWRcVeObBFMIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=GZ05ifH1; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="GZ05ifH1"
Received: (qmail 208639 invoked by uid 106); 21 Jun 2026 21:34:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=9sZ+bvsnV3Lk3x1wzXf3NdpNCX9uMxARnPdyGp7Fn04=; b=GZ05ifH1vMk+iTYICfmmi4JGYG3EWcL0DKPNaoH3i4BfXrf3xpTBxP6AnwLlVrtAay53OgAGhgtPGLyTVDPVpeosgS+pHCyxa6qi0JbvzJl8z1dmHDJ0ZqkA4DzoIUhm7zGOsO85Yy+i/hA+zefpF8mRO8JY0EKaF1PWWqR4HsumzcAffpbGOn/s/2knA6/Fq33uYRuRhw+Xh3sI95FzjA8FwIfu6TqvAXS7l94gkkez5s9bmDrDy+Fs4b6UQyipkRkV8AkbGsh3yGFnd+dA3kxuPFHKe5gK3m4ImuoPnwBpZJJj1B94Ag+Jeebu33+ikTCmsO4wpVaVtjUQIM+bfQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 21 Jun 2026 21:34:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 526569 invoked by uid 111); 21 Jun 2026 21:34:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 21 Jun 2026 17:34:10 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 21 Jun 2026 17:34:07 -0400
From: Jeff King <peff@peff.net>
To: Michael Montalbo <mmontalbo@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFH] Why do osx CI jobs so unreliable?
Message-ID: <20260621213407.GC2297179@coredump.intra.peff.net>
References: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAC2Qwm+9sh=ks1fuux415JGdDJ38Jq6eZrSH7-qzQxYCoy+Aug@mail.gmail.com>

On Sat, Jun 20, 2026 at 08:33:13AM -0700, Michael Montalbo wrote:

> Patrick Steinhardt <ps@pks.im> writes:
> > So I strongly suspect that it most be one of the t555* tests.
> > [...]
> > Maybe this is something that's specific to GitHub's environment...
> 
> I think you're right it's t5551/t5559. The runs Junio linked:
> 
>   osx-clang     cancelled  360min
>   osx-gcc       cancelled  360min
>   osx-reftable  success     35min
>   osx-meson     success     61min
> 
> All four run the same t5551/t5559 under EXPENSIVE. The two that
> finished differ in just two ways, which look like the levers:
> osx-reftable generates the 100k-ref advertisement in ~24ms vs ~1.2s
> for loose refs on macOS (so much less time mid-response), and
> osx-meson runs tests at nproc while the prove jobs hardcode --jobs=10
> on a 3-core runner (over recent master/next the prove jobs hang ~40%,
> meson ~10%).

If the problem is a racy deadlock, there is a reasonable chance that
some jobs may simply be lucky. Even if things like packing refs help, I
suspect the problem may still be lurking. Maybe I'm just a pessimist,
though. ;)

> When it is wedged the whole chain sits at 0% CPU. upload-pack is
> blocked in write() on the ls-refs advertisement, curl blocked in
> select(). So it looks like an HTTP/2 flow-control stall on the
> response side. The same stall resets itself after ~60-85s on my Linux
> box and on a bare-metal Mac, but not on the GitHub runner; I haven't
> pinned down why yet.

We had some HTTP/2 stalls/deadlocks in the past, and they were dependent
on libcurl and apache (actually h2_mod) versions. IIRC some of the
non-TLS code paths for HTTP/2 were not well tested, which led to
8f2146dbf1 (t5559: make SSL/TLS the default, 2023-02-23). Of course
after that commit those cleartext code paths should not be a problem, so
that is probably not exactly the issue now.

But it might be worth checking the versions you're running locally
versus what's in the GitHub runner.

-Peff
