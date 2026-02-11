Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E20C8003D
	for <git@vger.kernel.org>; Wed, 11 Feb 2026 06:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770791591; cv=none; b=d2LYM73UjWhl02EJLEFfrEa0pSWEJXnyjEKBQhQbSKEfxEx0rTroup37oJK6a1uxpWFwLLUHwqH/aVfWkbS11y1no0WbSjN+Q2tUx8wKlKnFezzLpsuTMYNhsrBpftIyfhieLM2iyQnRbg1iBbtyVpUCEoNWudmYGLAXD/iZbCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770791591; c=relaxed/simple;
	bh=KtHT31/H6qD0Cc6n/ERsU9l24G13PbBN62G1RTY64W8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CI7vatYwVCrQ6AI3SGyUiHqDFlrYAhlQzxIpyPqEp6Y/NA8JyJfbA1x3HJrp6ui93gZM7rsz1GOyU/p3/PR3/r5XeJY1iC+o7dn7Lpt9d19xCFnBIy9Lhc7MrZJrQ0JD9XKYclSjTxUXeeNgEAHmeFfV1p/QwkRintLEtjaDlgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Q2ZMOq9d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DL3T8hlR; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Q2ZMOq9d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DL3T8hlR"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 775D51D00229;
	Wed, 11 Feb 2026 01:33:09 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 11 Feb 2026 01:33:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770791589;
	 x=1770877989; bh=R3bUsZDimPEXykN51BBogMez8dOjDsgP01mtjrOgX0w=; b=
	Q2ZMOq9dazOjUxr0FzGgxic27tR5m83JLJPxaO67o5fWi7tBDwVXM0jS9bQ55STI
	cOtE1YnmCQJCHoQm1QoHsxvuBuv9OnVtVusuPnMUbELg0sxvdwdaW99x9bYPb2qb
	oFZurhEpqHVizsR7r0fmIZCDxeqeyetBAiO0cI/9+ywrXq9Z7F5br0zbkRVUSyMo
	J/Ly89AfOM2xwsG5s6+rmYb1oGbMkg86y3aFaEZeB+M4K1QLnnkOA1QzBaYbAud8
	DiOFMfS4+G8SmLF42xtfFBceuz7Om3tZJ2UPehhXBZdvSt3/Zr7pddNOqlIw86h1
	OlgeShKUsWsB4wxCDucyoQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770791589; x=
	1770877989; bh=R3bUsZDimPEXykN51BBogMez8dOjDsgP01mtjrOgX0w=; b=D
	L3T8hlRkZvmNuPanZ1hykMePU0pyt49axTma1lpfC6pf2mDOmU6vZupPwYvZ1e8C
	kxiWvmt7glZ5pvTDAZEldrU0MUD0vS7QzD8wEldNPs+NLSE+UzGmmk7NeiLWr+2E
	UdOFLmg79qPB4dh0xtqiBS864mYPWr5brAps8097zUwJ5d1kVo/20PLIoEqO1PZ7
	fnQL+oQNkMxkXUKNxMUyVYIFONRmdIl3AFdHg4sl159X+DC/em24sKuf+XMqjnPu
	a+FGI9aJyRw3B0wRBhLLLG2e6w+R4gGwRk6sE8CNqFHrteN8lW76OvLIM1YhSLlp
	nXxLTVMTwKIcWEdMRmWkA==
X-ME-Sender: <xms:pCKMaQXymjTXFDKzKVVVpZgLPF9ug_l7QXZymoyPAjJzhXxJEHxNXw>
    <xme:pCKMacCB178nolM9xNVLAemtpdsC508ozGNq9MzeqpcVOr882TZWcVKXN8RPhH27x
    8bZEQn2_QDmXyUCgBrcI4SDQP9BelxnubcIR28daAq2bqvkkcjrexw>
X-ME-Received: <xmr:pCKMaRzH0p6FgmF8dtaM2FV-HLPxRvOH_joPbj7z0aIcXkfKtcrrozq2WqBqYK12YxcLcBIE41WcOiE6QtDNQleJIWilFMRwnMkvbuAWdowB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtddukeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtugfgjgesthekre
    dttddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepfeehffegfeelgfeiudelheeuuefgieefve
    ejjeevleehtedvgeejgfekgeeugfdtnecuffhomhgrihhnpehgihhthhhusgdrtghomhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvg
    hffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:pCKMaZByPL3ZkQ5TR1pZ-Uxpd71iNv3RXvVBx2XdNA-deUsN7MQbHg>
    <xmx:pCKMaeaiy8jaB7HlxLsgbxng0UhHaXBsAbkZEV_RFqMvJYUf7BF5iQ>
    <xmx:pCKMaRiBqB1jc8VStQBocf2U-7av0Q_S2Wt32jOaKQ97Z1rDqjVqNw>
    <xmx:pCKMaQ6RrUQGCbNY8Zx2KULsTam3R3J8W-cOSM5JPAkTPZUpsPfZzQ>
    <xmx:pSKMaQyaVJLIl5s0LdDpDAOA82xjTt87uayWag81rOsTVywySZW3TDva>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Feb 2026 01:33:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a1d62e78 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 11 Feb 2026 06:33:06 +0000 (UTC)
Date: Wed, 11 Feb 2026 07:33:03 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH 3/5] ci: make test slicing consistent across Meson/Make
Message-ID: <aYwin2chSoz1RBFw@pks.im>
References: <20260209-b4-pks-ci-meson-improvements-v1-0-38444dec4874@pks.im>
 <20260209-b4-pks-ci-meson-improvements-v1-3-38444dec4874@pks.im>
 <xmqqa4xgxn2m.fsf@gitster.g>
 <20260210225401.GA1837188@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260210225401.GA1837188@coredump.intra.peff.net>

On Tue, Feb 10, 2026 at 05:54:01PM -0500, Jeff King wrote:
> On Tue, Feb 10, 2026 at 02:15:13PM -0800, Junio C Hamano wrote:
> 
> > > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > > index 2b175dc5c6..1b7a16e1f1 100644
> > > --- a/.github/workflows/main.yml
> > > +++ b/.github/workflows/main.yml
> > > @@ -298,7 +298,7 @@ jobs:
> > >          path: build
> > >      - name: Test
> > >        shell: pwsh
> > > -      run: ci/run-test-slice-meson.sh build ${{matrix.nr}} 10
> > > +      run: ci/run-test-slice-meson.sh build ${{matrix.nr + 1}} 10
> > >      - name: print test failures
> > >        if: failure() && env.FAILED_TEST_ARTIFACTS != ''
> > >        shell: bash
> > 
> > Have we successfully run this one?

I haven't kicked off a GitHub workflow for this patch series. Guess I
should've done that. I've created https://github.com/git/git/pull/2195
now to give v2 a test run first.

> > I am getting
> > 
> > Invalid workflow file: .github/workflows/main.yml#L1
> > (Line: 153, Col: 12): Unexpected symbol: '+'. Located at position 11
> > within expression: matrix.nr + 1, (Line: 301, Col: 12): Unexpected
> > symbol: '+'. Located at position 11 within expression: matrix.nr + 1
> > 
> > https://github.com/orgs/community/discussions/25386 is a 6-year old
> > discussion so things may have changed quite a lot, but at least back
> > then the claim was
> > 
> >     Github actions doesn’t support math operations in expressions
> >     inside ${{ }}. You could add up these two numbers in bash script and
> >     then use set-env command to give its value to an environment
> >     variable ...
> > 
> > though.
> 
> Right, that's why we used pwsh syntax to do it before, in d3d6493dcf
> (ci: use Meson's new `--slice` option, 2025-07-09).
> 
> That went away in 17bd1108ea (ci(windows-meson-test): handle options and
> output like other test jobs, 2025-11-18), because the "+1" was added
> into the script itself there. It looks like the patch under discussion
> removes the +1 from the script, so we'd need to go back to the pwsh
> syntax.

Indeed, will fix. Thanks!

Patrick
