Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 652C03B961B
	for <git@vger.kernel.org>; Thu, 13 Aug 2026 09:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786611801; cv=none; b=QC1fx7SXpIZ6HfEYPSKtYXPqkiP2vqaseQu4FowyNDmapXWzED/h8Q9iUJlCAtfIDQ6Kkfe69JepcxyapKOqiqIQ8WocS06nhcTo1zpHJvsD7ThDvSaJV+0IvWrp02ft7oscUUyLZexD4fwYog5wy0Or9BzmbC4djrawvO9d900=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786611801; c=relaxed/simple;
	bh=h6f/2swyEod9Pbi9k+WXOdlau4rr+V5CswrxhoE3pWs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sca+6nF+8TdtSAcde3nx6WGNE8z4H31bQr35OOH43L3RTQcF+7//yyFHBFk3W92NDAHcckgUxw4JAEWTA7nRbA3FDPRwTj6PM42URdv7hHn11boh6riaPA77CkgDIzl3sDyQgpfv9zVBIAMKYnY4xv0++R5J2/eV8saV21oivK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bvXFkjty; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=R0uzkcP7; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bvXFkjty";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="R0uzkcP7"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 747A17A0110;
	Thu, 13 Aug 2026 05:03:18 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Thu, 13 Aug 2026 05:03:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1786611798;
	 x=1786698198; bh=h6f/2swyEod9Pbi9k+WXOdlau4rr+V5CswrxhoE3pWs=; b=
	bvXFkjtyyAQtLU0DL7a0JBe0eVT91qBMrWiy/zFwTTkhKECiN8P2jPQutGk/G5qn
	MDkY0xzXK79q1zs5t23SRXzCyzOfHLNlFB3nglj1yd8UXqfrv8sIgLq79nDuZ7zN
	aUAyX9Y7K3FGCc6SRHBAtXhF31kVqvoGCY0ZWWqM+uE502RuNMjdNrWO6ITrMB4X
	Q9mz6JrsPkt7KIEqOyoEjHCqo7WDzEPCZMoXXAy/t/QkluSob089VxfAJVpqJ4RG
	r3FTPRy0hWocHB1bUAQxECz4k1INH1Qt2prsYmiRSIwWm3hEvcv6QIm5NTZCtQKX
	g+WM36soltir4Akb2SpM6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786611798; x=
	1786698198; bh=h6f/2swyEod9Pbi9k+WXOdlau4rr+V5CswrxhoE3pWs=; b=R
	0uzkcP78YLc9WAnDnotXdBN2vjuNCF6QBT0Pf7zIUev79Wh3dn+1FRrPNkeR/SpO
	Wd+btbhaWszFuKpY/8Nuq6Swp9TPCFxJuJ6bBG+UUOxutYOH1auhho9E/5gZ5U/q
	Ikzw1IGonC4pnmyNZtLMoNDKwoX0OVfiEafYSaZ8dwwbCRr+DeKOfKUnSaqoj8AQ
	PC2WKpQOforFUkJyY9JHyz8clVLSddtraRN8hpThkdAwTTv6ClcT8sa2y0wVmCg7
	CH19utsGhsz03yUFuQ5FT79ab19XDihNo1XQZxwkQEF6V6QOoCpe/TZzjHDoZ9ge
	6P4SVv1aEGcKKItCtDMGg==
X-ME-Sender: <xms:Voh9assyD7d7bV7OgDaDFBIY1XSq4zhIHlI29HOGOQnD6gOTOeTPaw>
    <xme:Voh9aoj9pwQU7z0q_8X57-Uqs7buGtVBMxirokikGPuTns7KWbKhCDkEkQQ3CAEJ_
    Calt_StBIg7vbZSrSOrhTJmDNXcJ39Thr5Q-jt2dMg5hQir_-J9lQ>
X-ME-Received: <xmr:Voh9at_gOybujLF3V7n9fF0TNWNJMzu1qFwCaDp244pBGmR-BvB4eGk9WWGmCfFBH6_7ejcD6cXkXj5aD82Fc3YDn8V-sjzV-Dxwuqigz6vF>
X-ME-Proxy-Cause: dmFkZTEePzzUD/fVWF/I4lC2PTgGGgKzOIOfeSo8BKR4Dh/oa9z4KGqpQ6w59+NcNtBzJ0
    M3PepDTthE5ajvLxG+HggzLC2lRU+glxA2LRu5bQ6M02imKJ3pn2dNy+DByfiw/I7BiGHq
    fsOkMfycXncvXjJLhSX/FoNX1FSShAzx5kwD18IriT9hsakfcvJ6kbCKwkfGFAV9/nPFz9
    31iMu/goGsm4DS62ALFtopNENUYbGNrI51yHDBJsEf+FYUV3EBdPzn3PoujxxnxJMGAoyr
    Zed0kIfrYtVYPmazqDQpP9AvSPWudn4M1d2mE5nW78BgMswpkHW7ymDQELQG6NHHVFNtHU
    Ytt83mC7N6YjfGH/cIOhyZVVx+QuITHNhtTUTCHFDTDWsHmvNK5uH4EVtzU4x1224oNTug
    ux6qVtPEFlVWbbQq01xmACGWvjLUruhNWZAi/T3Va8n/PPTa+SkhmK4XfAshwBXqCREh3u
    vaD/TIJEPiuJiou5ulM64wpwWAHj/3LRBRtKm755740oRU7aJx8s1e/SdbiCG3sFLJsLDP
    puma4jb8EFPxHizvKaQjuMfL+lXwLuKDVuPUbEvPO0yHUdUJXEObtoiLdYrcDyDCnwYfGI
    3/f6h4vHRm4bj6wxrPk/9ppczOeeU8o7ox8RiqNX7jTNtXTgnHJ/kXOLPueA
X-ME-Proxy: <xmx:Voh9ars2BDiow-eEZHP-IoJ7bhI9rbevvsMbcZTwXbqJ2iDoEm0tVg>
    <xmx:Voh9ahremWlK-8Mkn024e4Yoga-tjoBV6v3CvUT8W_9KuYf7TKTfTw>
    <xmx:Voh9avrqvmCvYeJWTtBpwSQVrEtkP65XW9T9DZEmE3WrnwacYam5Bg>
    <xmx:Voh9agb5oaXShXqOrGJRtbRQJIqz29m4TjUgsOYsEAMi2FLV51FNTA>
    <xmx:Voh9ar2scMcFvNk0GwZrv3FB8hHOCdNuz-rwLaSz2X3bQGD1N2b7RIja>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Aug 2026 05:03:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6aff80f4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 13 Aug 2026 09:03:14 +0000 (UTC)
Date: Thu, 13 Aug 2026 11:03:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org, Paul Tarjan <github@paulisageek.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Taylor Blau <me@ttaylorr.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Koji Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH] fsmonitor: flush pending FSEvents before cookie wait
Message-ID: <an2IT78KDS94JqUt@pks.im>
References: <20260721-fsmonitor-darwin-cookie-flush-v1-1-357dc5e32040@gmail.com>
 <anLtSOKqgcCrrNHo@pks.im>
 <CAJ-ks9=+4rxxx8+7fOF1aLFW67=hdxjhQsHqse1GGBLwZUh2BQ@mail.gmail.com>
 <antMfAYVSPX9QAk1@pks.im>
 <CAJ-ks9=oV4SQSjTHNEOGBaQb8Rb4xBqVSp4wYum6yzU-zx3YtQ@mail.gmail.com>
 <CAJ-ks9kQR77vH-56eS9tT-iXEnih+Z7SPRMs1gD_wTyg_6gZ_w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ-ks9kQR77vH-56eS9tT-iXEnih+Z7SPRMs1gD_wTyg_6gZ_w@mail.gmail.com>

On Wed, Aug 12, 2026 at 09:19:08PM -0400, Tamir Duberstein wrote:
> On Tue, Aug 11, 2026 at 12:45 PM Tamir Duberstein <tamird@gmail.com> wrote:
[snip]
> > Got it. I agree with you that the flush call feels unnecessary under
> > the interpretation that passing 1ms to FSEventStreamCreate is the
> > equivalent of asking it to flush every 1ms. Empirically, though,
> > that's not the case, as described in the commit message.
> >
> > There's more precedent for this technique (found by agent, sorry):
> > watchman fixed a similar issue here:
> > https://github.com/facebook/watchman/commit/d1795de4ecab33672a89802318fe6f0122462194
> > and the documented it here:
> > https://github.com/facebook/watchman/commit/2f80886991ce81585ac0679c2b019fa0e4d9e9dd
> >
> > I agree this is unsatisfying.
> >
> > Does that help?

Those links definitely help to provide some more context, thanks!

> I did a bunch more digging and I'm withdrawing this patch. I haven't
> succeeded in proving that this fixes the performance issue. I'll
> resend in case this changes.

One major difference I notice there is that your patch uses
`FsEventStreamFlushAsync()`, whereas Watchman uses the `Sync()` variant.
That could help explain why it works for their use case, as the can now
guarantee that the cookie was indeed processed once that call finishes.
But with our `Async()` variant that's a guarantee that we cannot uphold,
and consequently we're essentially still racing with the timout.

Now we could of course try to use the synchronous variant ourselves. But
I'm a bit concerned that this may create new problems that we don't
really understand yet. Quite unfortunate indeed :/

Thanks!

Patrick
