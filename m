Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72CDF241136
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 10:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755770994; cv=none; b=kAAJr7RIlwLAfk+cAbGdLZrF+BAgFibjsRu0BBHx24u7H5K3pVVk/V13KRnVR5r6x2UbyOm/NV0qUp7dRFtJ6HKaKTtOpBzGkqkz5xa8pn68nj15AaBziEDeJlHaQJ+Agig3Z+7pCCWgBLF5Pw6X/Xrqe0tt/DraQ1+Sofn0Mp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755770994; c=relaxed/simple;
	bh=N63wfeMdJ3H/Eymhzwn/o7g7wkDNx9yjaLx2irYUJHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E+6CfitvqsZ0LU+FR9iMOnDPFjPOuwt1odUpuf7LV9RBL7cP3WvOGhksiJydeKYVlnarOXT+BpqylVjsjKGT9GuIoLAcRHHMhAohSA1UtK21lMreqKx/LCkpV1+Cej1s7HG0+WLWmfi5qINsZv3oPndVR1ySHrfUxKSUQ0l3CMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YyW+Am5W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jKgXnOgT; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YyW+Am5W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jKgXnOgT"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8ECCE140008C;
	Thu, 21 Aug 2025 06:09:51 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Thu, 21 Aug 2025 06:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1755770991; x=1755857391; bh=Ga0Pzosb97
	429Czso/EULHfDpSfE2dc+z6AYfcCl2ck=; b=YyW+Am5WbvRI+VrH2l+TIWqVxX
	CpEcjq8GNW9+MOB2WDl3Qc2jEWiSDxNIno9rWdoGWtyAfhLUuhqUTaSXmAwgL30F
	W95d3bl0Vw7O8HBp4bHyxFPY7iHoSUYX20LT1NWiA8X6d9PM8DNQPhVkqzk8KNKl
	ho1NvwNwwqj1sc2r6fNAOd1G2TqHRt/3VDQpDz89bCvg76jba84op5KtnfbINgOQ
	H9o0fH04u07oG9XgL6a0urAY3XJwfqFk+HPXhlVY7PBSxBrKvyLagk3uCJCta2wK
	hwAgYgLYalKlzBGWNwZ798MtfZiE9WLZ33bs8aGGjm5jVB86zF4MR4VT8LyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755770991; x=1755857391; bh=Ga0Pzosb97429Czso/EULHfDpSfE2dc+z6A
	YfcCl2ck=; b=jKgXnOgTYLKZPoYQA5EfNnTYMJv98xQxWf97G9nUe6OxwNFa+Sh
	3rggCFw/zaxEvXsDdTurPoypuriIv9D7ZnALXqi0piDyxQ+8R3EumbNUgwZ3lW5i
	2zEaIKFS8SGcw6wcEcwRjeKyqjNZ07+LyZeIGZgOk4K8bLdVkQYAEf9dwUfa99HG
	hFJzvVVxkXUzg7spW8mCHMzGUOJ9x9rRyEHJKwpeae9XcDRFLqKjGMVHdscE1dnC
	bQKLLP0IMLBWLVbTff2tVhaZmdBJHm//jLWTqgr9SjeAYBGWzC/EAjzO1HFxlLbL
	FSdjGuhr1JPNdbrdRjCVS1gAFwjBTJhQlbw==
X-ME-Sender: <xms:b_CmaLkvN7M0MXGa8fpgRODAYlQM14ozJjYZ1L9SCP4xvs2297AcHA>
    <xme:b_CmaJaV1b0PEQCsHKnP6rJ-sck3uENZqPdbOQbgibMoZ1QL2IEqWauAyMTe6ldad
    Q1eGBrqBkYbRt9wDw>
X-ME-Received: <xmr:b_CmaOOCvYszbYiqxcZYIXVbKmn_N4xlFdVXbK9FmZyDx-cN_rN33BmQ2vjrW4yY3fLQJLtIm_0OyUu50sv9vxbUEHVASCodOuVE3J3B9Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduiedtleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtrodttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epjedttdegffekudejjeegudehgfehtdfgtdeiudelueelgfeuteehledugeeuueevnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhovgdrughrvgifsehinhguvgigvgigtghhrghnghgvrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhk
    rddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:b_CmaGbizfOgPKVFrr7K0J2pcCF2LNBH07_bw5eU28DSlTlsNqQa8A>
    <xmx:b_CmaE1Xr0CsGXC3Dip7W_DPgsJnITv_G0UESOytm0ydGTXQYYtPhw>
    <xmx:b_CmaEdt_tup9gNQZ8ytg3auRW0fjdTbFPfjueI7h5wAmheX0XWTuw>
    <xmx:b_CmaNE3I6zmVxX3waaa02D6b1viS38dPmgPN5_1_iag41GQTthp-g>
    <xmx:b_CmaM1tHaugOzPXGT_HA9JgypVvVqFZ5c96GzXUgnX52aBrl6bImYO8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 06:09:50 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3865af22 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 21 Aug 2025 10:09:48 +0000 (UTC)
Date: Thu, 21 Aug 2025 12:09:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: Joe Drew <joe.drew@indexexchange.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
Message-ID: <aKbwabLZiWasYoBC@pks.im>
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
 <20250820213323.GA1667633@coredump.intra.peff.net>
 <aKbHozlmDIqfgkg4@pks.im>
 <20250821072706.GA2390046@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250821072706.GA2390046@coredump.intra.peff.net>

On Thu, Aug 21, 2025 at 03:27:06AM -0400, Jeff King wrote:
> On Thu, Aug 21, 2025 at 09:15:47AM +0200, Patrick Steinhardt wrote:
> 
> > > > This error _does not_ happen in the Apple-supplied version of git:
> > > > `git version 2.39.5 (Apple Git-154)`, but does in 2.51.0, which I
> > > > installed with homebrew. (If this is a packaging error, I'll happily
> > > > report to homebrew.)
> > > 
> > > That is definitely weird, and not something I'd expect if it's just a
> > > case collision. Is it possible for you to build Git from source? If so,
> > > and the problem happens with your build of 2.51.0 but not v2.39.5, it
> > > would be very enlightening to see the results of "git bisect". We can
> > > provide more guidance if you need with that process.
> > 
> > Curious indeed. Another relevant part could be the new batched mode that
> > we have recently introduced in git-fetch(1). Previously we would've
> > updated refs one by one, and potentially that led to us writing the same
> > ref multiple times due to case-insensitivity? The result would be quite
> > broken in that case, but at least the fetch would've finished. Does make
> > me wonder though what subsequent fetches did, and whether we always tend
> > to flip-flop the value of such a ref.
> 
> Ah, good catch. That would explain the behavior change perfectly. My money is
> on a case collision, then. :)
> 
> > But with batched transactions that's not possible anymore, as we would
> > indeed try to lock the same ref twice. Assuming that this really is the
> > case, I wonder whether we should detect this case, tell the user that
> > it's impossible to store all refs on their system, and then continue
> > regardless while ejecting that specific ref from the transaction.
> 
> Maybe it is too optimistic to think that they will just start using
> reftable in Git 3.0, and we can avoid extra code to detect this?

Probably, yeah. I also think it shouldn't be too involved to have the
logic in Git. We can mark transactions as allowing for failures now, so
in the best case we'd just do that and then check whether we have any
errors.

We could also think about generating a hint that tells the user exactly
what's going on. E.g. something like this:

    You're on a case-insensitive filesystem, and the remote you are
    trying to fetch from has references that only differ in casing. It
    is impossible to store such references with the "files" backend. You
    can either accept this as-is, in which case you won't be able to
    store all remote references on disk. Or you can alternatively
    migrate your repository to use the "reftable" backend with the
    following command:

        git refs migrate --ref-format=reftable

    Please keep in mind that not all implementations of Git support this
    new format yet. So if you use tools other than Git to access this
    repository it may not be an option to migrate to reftables.

The last part is what I'm working on right now. libgit2 is fully
functional now, but what is still lacking is reviews.

Patrick
