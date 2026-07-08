Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1593C0617
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783490402; cv=none; b=t/Jx3szP1Jl3sMj/kRrOyACbThisrRj7tW/lQHOwCdORNH8aHx5COSJwG2IA1Ze1TmpMyq/+mB6OQHIUC/tx8QpYcszrN/iWnKeh+FupRv+r75AIJnZpAQ/kpbUCaBiYGtSQwd171GNgwUXiOhuw5l1FSUsjz+FKvqQ2yE69CIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783490402; c=relaxed/simple;
	bh=2be5CkyyEjp5qF4JKMdJmk5iOe0VUs3dKQ8kvx9QCnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fj1ezEsUT4rpNA/hjRqPYbi+T1eQ+r3hlxhBOKKDCxId2Mhy9yrjUW4FwEVPD1xMYp4PWBvQ2C35uFVdZwZ1YJf59kdm/80Bw5yY56PeSci+tKbXrHnyBDuY4elLD3fzc3YiBieBY7SwcvW8vJPVncpKBGjL2/I76/5Wx3MXa8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AnB0xbGp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fch7+d1z; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AnB0xbGp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fch7+d1z"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CBB9B7A0065;
	Wed,  8 Jul 2026 01:59:59 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 01:59:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783490399; x=1783576799; bh=lJeFKZhKR1
	a21tGSts1c1z+moglHe2/xSnIQpluUHOs=; b=AnB0xbGpsLsnIbEbg4Atauujxa
	c5TmJniqHgBWF/IgYmoJQtKVwi9e46NrZqQBFufs0mCvry96U7ze61iHf3UboiCw
	CbhDxa4Y2fyxrb+eNbIm0iwJZzEoiNStbjlEZvYnHsEMlFg0exBCSEjjaFl1L/yq
	jcroUJV75QiKcszA9UYvdziC5C6sIeXJ1EWC+Q5lozczNOMOPI/kALP9yPw82fJs
	xC3qteDOwDNuOU0iGjUCeSAhCJ7tGQ14zeFjS2YZHmMHYmLaH6fZ2huJDn2VlALy
	uSa/zbWPBa6KCJwaGduOwEJRnIbIp7CoWt+/0YY6l+JvY8ve0ZHlQJ8GF+yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783490399; x=1783576799; bh=lJeFKZhKR1a21tGSts1c1z+moglHe2/xSnI
	QpluUHOs=; b=Fch7+d1zc9c3apObZpitQhge0nFdC79TBjSqmvkRrIxCSXAf148
	QtrLXrGydLPjLcdGQsSYehxW489eCSJbFXvssRyW/awvpj7i/ZOl6G08plolftWK
	3ZMaqqLnkYO6xXSwMRK/Qy/uOAqNs84rde+1hyY+reSJ6hPS/vrdJvr5RTvV2c+m
	INlkEUmNsatBrfpOnS4rjuWXdqm3VmQeLHG/moRXAy1pxdFDxEM/eSmQwD+J4bgJ
	oYYtFNknRQiTpYxbbmioFOrQ59M6zAreCjbicbJllWTea+HZXbdwL/6GkDof8hPn
	mWNEUQ55lQIKU+9WJyxy3FPPCWitDDUKPGA==
X-ME-Sender: <xms:X-dNaisGmYis8MnbuK6GFauFaU3SX7FHYjSR281CpKWaB4z6YXDPkw>
    <xme:X-dNau45KFD4hAhgoZnpoE31yxufMMEVy05k6jDLuIcSZg-Y7BYYlNiQ7ksEwAZxp
    FYjdYbrh3MtiU7o3a2dAHd7DAYb2MpP1RpjWX5hbNr5HHhHJa8l>
X-ME-Received: <xmr:X-dNarKGEkUpMtdvWuB924uBN2ko5u6aofenYES5pMbczDp74hn53PXH58bNRqNajLHJBPjN9SHYELEkIOYDBaIWvaMDgvtYXNH9SzDi>
X-ME-Proxy-Cause: dmFkZTE7Uj6NqTs7XUx73DbPuo/cxdAry9rJmUG2omM17mECPuDfNIXZezR0SerKwyXYed
    +IQ7aSqvOsxi3ujn5aBpQTuq87/uZl+eT7HWqzBPOyQvokwflZv9VZK0CaQ9qnrIrTuBDH
    rJsKpTuMNsW+j09A/tbyu72VG8qvAe8P5LhdKJVxBvLj4vxUmHWgJqDaFu9+J33MqihpCV
    2R61JuO6uHcovC/I9HGch2wIe9/C1wV8NoKSyz6pLzjrBlmEV84WkGQN+fEWmVKgwGMOI6
    aPYWggBaFMNtQg3STjszmWiE+/cL2wpdCHmJl9ASol5NCHgDCINhoU89/PWfS2H9+gktmV
    Lkwmk3s+jfnXhPZczBP+BTPnm3TxPDuuO3owWtuH9z3nQk4E8r9y8rorRTEZkK3FZJK/ML
    snio6PksOBxtcFFTHf0n1TUxl3nFGC5MahYA8sKwt5iXdioQ/3ELzKXuYCeK5xRw0BQzm8
    pTCC3jz+87VCqZ4iBZOf0VT1C8Iqom2Yn20KYdkRLQfzadcdZW0jn4GbC6OCcBS9pWRS46
    faPCpcCJr/A3eg5DXgZQKdlxQEp0O1xs70RG7JEoJ42s+Glhl/FjoQBN1Mt04r+OeL6J0F
    VHvUcdMlzgjAKRmxCcdBKC3ttHHGkPpb/QWQJ91qgPyLek0iKsq00RE1EZ/g
X-ME-Proxy: <xmx:X-dNam7JyX4AWJnVwNKuTmi1waxGDa3ymgxOKkdYtFA3oChOu8nPoQ>
    <xmx:X-dNamwTrcaZqB7dd7YbMv_5iRIKTw8XqmrKIBtH_PtV0O7lRheVbQ>
    <xmx:X-dNaibORbGQnBAoDO_gw3Z7jnZxeJeKsowL4gAnIQ5KHyXJjuWY-w>
    <xmx:X-dNagT0yZ7bT_jj9jTpICOmT1GfNWAGKYcXCtArgtrBWpMZyX9X2Q>
    <xmx:X-dNamf3BpiVequHZc3M6EqQjTd-lG3i0nOw3G1PuVKJL_Dy6EcndEFw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 01:59:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b1b283e1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 05:59:57 +0000 (UTC)
Date: Wed, 8 Jul 2026 07:59:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Kristofer Karlsson <krka@spotify.com>
Cc: Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH 1/2] t: add tests for ref tombstone scenarios
Message-ID: <ak3nWvyX4E9qB4T1@pks.im>
References: <pull.2166.git.1783344957.gitgitgadget@gmail.com>
 <d8ffdcb4f8c1988c109761ddb9daff8c07caa2b1.1783344957.git.gitgitgadget@gmail.com>
 <ak0aNrBpuo7ZwZ2k@pks.im>
 <CAL71e4ORdJXsz58SH71VjDNAWZ39T3+TrWN+gScAFx=Gt0CTkQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAL71e4ORdJXsz58SH71VjDNAWZ39T3+TrWN+gScAFx=Gt0CTkQ@mail.gmail.com>

On Tue, Jul 07, 2026 at 06:12:31PM +0200, Kristofer Karlsson wrote:
> On Tue, 7 Jul 2026 at 17:24, Patrick Steinhardt <ps@pks.im> wrote:
> > On Mon, Jul 06, 2026 at 01:35:55PM +0000, Kristofer Karlsson via GitGitGadget wrote:
> > > diff --git a/t/t0610-reftable-basics.sh b/t/t0610-reftable-basics.sh
> > > +test_expect_success 'delete and re-create refs with tombstones' '
> >
> > I wonder whether this test really adds any value. We probably have lots
> > of tests already that test creation/deletion of references.
> 
> I could not find an existing test that covers the delete-then-recreate
> flow (where tombstones are present when the new refs are created).
> The existing tests cover creation and deletion separately but not the
> interaction with tombstones.
> (But perhaps such a test exists and I just can't find it.)

In t1400 we definitely have some tests where we exercise this
implicitly. In any case, if we want to retain this test I'd rather add
it to t1400 itself, as the functionality that we're testing is itself
not specific to the backend.

Patrick
