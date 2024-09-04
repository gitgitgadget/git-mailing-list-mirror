Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E081EC01C
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 07:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725433535; cv=none; b=hqjINlwxqFt3mCy0sIiClrGWy9GLYzPsa9bwfasZtJtJm/3waw3PyU6tn6KcTsLE2jV0JIMvUbeWDTYDHF9PvuNaBPv+Wt8HxxotTWcr6dMSdoLObOn/DKAleiYiVkn/0EgiVdme2+Bf8MlZJyTtyQ4xRiLVtK3UEXqd3gnlidY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725433535; c=relaxed/simple;
	bh=iH0ALxImkuRI+besvgPTJpwCWWIquylOB6ni1++1u/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zig6fsu472vRtzoOmZoGbT7zY9lyNiNhWVFufHZWWYoZKh+2A56EU0HUScaNKt7XvmbCp5ao9SnZkcwfLiaoWnLoyLx4o3edFPv9Lf65qqkfpiys9/7Kyxp+Z0Ix+9wK+rDys6Ig7YLhukS0ML2uieBMY2N0lqL3nm+vKnuHp2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=onmrnmmV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uPfPsIMf; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="onmrnmmV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uPfPsIMf"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A86EE11402ED;
	Wed,  4 Sep 2024 03:05:32 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 04 Sep 2024 03:05:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725433532; x=1725519932; bh=PA+6h3qxoA
	Al5HaeYALnCmuzj9m4q9pWUBkKoihuu7Y=; b=onmrnmmVknGn8MWQU4m470uXfE
	vdy+gYzDivHdaHnFe9Xbz0fdv5TJT4Dpp5GMbGZlZ+Zm8sdXut14oquGGgTv5U+T
	mkP9LRwaNXjprydcCIBDL/3hjHP2MiWTNI6xTk0gPYAmkHwWep2Oe/Nf4vQ/cRPU
	x39DBWtLFerD5p/wS64ZDJT7Sa/fF3reOLcGO8vWjBbOXzopVXLl1njKaEmdM6Fr
	ZrgbAhvSOsLIqvGXm3yiXQSUH3b/AtIGPBOGrd092GyYKtYSZgPpQpBew1UCiDwz
	kzJNLm4tnU8hSmahtS84I/v7EpwzjR2JZz67rrrrgAlbUp06Jn4R+inEUY5Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725433532; x=1725519932; bh=PA+6h3qxoAAl5HaeYALnCmuzj9m4
	q9pWUBkKoihuu7Y=; b=uPfPsIMf0AgPVO7EfIJ/XfyVAQgY5clxU0/jhzA0bL1a
	rh6QCF7hzjp7RVjCjqIUd2vRyp9C7LcApHuQrd2N7SLk00I8nbwXzlpJf47hudiv
	2Pah0jn/C4pMcbPkfVvDa385Siwki8aLtgjJf62YRa32KFxWTlBLSejZ7u30Abc6
	EqQ0ThPH5cEHSJ2Urzrjq8NchlNju2pVkA+lmfiDjEVM7aprl+ka7IYPiBgvU5UB
	+bQ0YSA5Ztqu5lAloIsBV36udsc40o7wH/cocuWrnqqSrbkDdO+N1F4gBC/VoKMg
	yQc0W3AuSEtTnLUfzYZIdR6UHapNa4p7ml8wFMTsqQ==
X-ME-Sender: <xms:vAbYZnl2i_j0hAfDOcSOUu-vmCdr9CrlUODbfJeN6QTl9Mx7tsh66A>
    <xme:vAbYZq1DVI3BGiovgcqE_EqpjRDcbk9vAHgkmjx-W5WCNWH1HoONaWemmhyYfmZ91
    JvhyCoq1qe6ZVW57w>
X-ME-Received: <xmr:vAbYZtqWikLdQbgdbFiwu5ioOKGTqYfaOvyBQq4LktUteodWVxKjBX_hagNUNytQTieXbnSEBqtzHdAe4hqgNXiLlBqauU1BLYEMv15iUGO2>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudehiedguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdortddttddv
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeejfefhfeelkeeuteduffeklefftdeuffeuhfeiudef
    tedtuefgveekffekvddtfeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehluh
    hsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhi
    mhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsh
    grnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepmhgvsehtthgrhihlohhrrh
    drtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:vAbYZvmCZTpi4sOlq3TegHtUBZNmrFSZJ9ONjG_G9DGCyB1gxK39-g>
    <xmx:vAbYZl0-tPjnn3ToV_S56J10h7s1GefBiGK6pwsclTovQTggdVYlLg>
    <xmx:vAbYZuu3aHnNGcfCnxAQST66yBh-dQmy9x3F1g-ZtX7w4hksPVAr6A>
    <xmx:vAbYZpUCFZB7e0sqcVcowty6Au6YcoYLR4DRWyLkN01N3fb1aGmJ2A>
    <xmx:vAbYZvprl-ww1A7teSiR0kjlfgeIXaV88gyrcLselSXr_4gqR9fUqozG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Sep 2024 03:05:31 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id df5c3c8f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 4 Sep 2024 07:05:21 +0000 (UTC)
Date: Wed, 4 Sep 2024 09:05:28 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Jeff King <peff@peff.net>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/4] hash.h: scaffolding for _fast hashing variants
Message-ID: <ZtgGsNVPRVezNyEp@pks.im>
References: <cover.1725206584.git.me@ttaylorr.com>
 <6ac6f934c32bdc600cdb8d2a08d4aa390c1f2994.1725206584.git.me@ttaylorr.com>
 <ZtXAhP69zu7cDnsA@tanuki>
 <xmqqh6awlkac.fsf@gitster.g>
 <ZtdpFWtWae2r4Lj4@nand.local>
 <xmqqy148h3ci.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqy148h3ci.fsf@gitster.g>

On Tue, Sep 03, 2024 at 01:47:09PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > I discussed this with brian in the sub-thread where I am talking to
> > them, but I think this is already the case. The pack is read in
> > index-pack and the checksum is verified without using the _fast hash
> > functions, so we would detect:
> >
> >   - either half of a colliding pair of objects, when reading individual
> >     objects' contents to determine their SHA-1s, or
> >
> >   - a colliding pack checksum, when computing the whole pack's checksum
> >     (which also does not use the _fast variants of these functions), and
> >
> >   - a mismatched pack checksum, when verifying the pack's checksum
> >     against the one stored in the pack.
> >
> >>  (2) devise a transition plan to use a hash function that computes a
> >>      value that is different from SHA-1 (or SHA-256 for that
> >>      matter); and
> >>
> >>  (3) pick a hash function that computes a lot faster but is insecure
> >>      and transition to it.
> >
> > So I do not think that either of these two steps are necessary.
> 
> I suspect that it is a wrong conclusion, as I meant (1) to be
> prerequisite for doing (2) and (3), that gives us the real benefit
> of being able to go faster than SHA1DC or even SHA-256.  If (1) is
> unnecessary (because it is already covered), that is great---we can
> directly jump to (2) and (3).

Ah, so the idea would be to not introduce SHA1_fast, but instead use a
hash function that is explicitly designed for fast hashing like xxHash
[1]? When you compare numbers I definitely think that this makes quite
some sense as XXH3 for example hashes at 31.5GB/s whereas SHA1 hashes at
0.8GB/s (if you believe the numbers on their site).

Doing this for data structures structur is almost a no-brainer if you
ask me. For packfiles it's a bit more complicated as we also have to
consider backwards compatibility -- a server of course cannot just start
to send packfiles that use xxHash.

Patrick

[1]: https://github.com/Cyan4973/xxHash
