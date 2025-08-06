Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F0931F9F73
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 06:23:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754461426; cv=none; b=uLL6fX8ujOwVVrjsZNPXODj63DUAlcZGJxEB0WktldeAXaaE5qPRYyKjeRb1E3xwyc9EIy6b1BA5kuh1mDXlVh9FtkGjzYgWMlfloWpB3qWhy/m0dcuJgPLfycU/qWynDnP/9/gNEWiItdcrXh5txMnmPLa+PTMvjjAaaLsvPsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754461426; c=relaxed/simple;
	bh=yhWHSfzCOcfWp4i1l4rC5JS/x/Cgc3GVrxXZxwoNaYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WwlkEoZFVQPVB3xS/3M1ZMFiUkjqPA4OfwgVqbPS/+/2PTwSy6hYc9s0on6MY38sV1a6pMi9w4uuCzlcGfPfg+RCkSrDQfNFD4TkVNHGNAWpcL7a4LqlO2N2Aijpi+qjoB6a3Wrt5GxhjySaYbHFiXX62mHX2jkTibiw2pKQWrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hTxLtzlX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lh+YM5+6; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hTxLtzlX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lh+YM5+6"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 484477A0178;
	Wed,  6 Aug 2025 02:23:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 06 Aug 2025 02:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1754461423; x=1754547823; bh=UYoA2ghVx1
	L6/NPEpaBT2YhmbnP0sEXq/z3+hiwbW2c=; b=hTxLtzlXc+gTRqNv4P25ShybgH
	8dFTCNfxp5lmOFGfP+p0fEljid1dYUYa0UIBllLYLUw/yiMYeiGwqar/EixCa7I6
	yWMZbS20kdL9ZM9vn53hOoHSRWczpJ1r6vcf/9I447qWXSF3/Pdc7YUV+O0YNbpk
	Y7H5+kCccqEDsmrZkP1f7thtNuXJWT3Y/r1xeaxbaYJxTFc+bEthRyW7mJ1k/5L7
	gl3tdC6DkkcTuu0WVGCm2AKWcw/AD/u1kl9JcIKReA9JakQy4JceItDTCG0bXrLG
	4xwW+76LGbBn3sp7yvTktvAz9pwufpchmONEEWyIWcMmYM/ndWFjQtd8kblg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754461423; x=1754547823; bh=UYoA2ghVx1L6/NPEpaBT2YhmbnP0sEXq/z3
	+hiwbW2c=; b=lh+YM5+6WrpSualueZSjs7UY7eaczPnzgDSEWY1RdfPCs6/L0G/
	7Jr7Z0E8HRfYM3CuMO+uEVyKyyaW/HA6DiHhhPYPrWHGRafOu+ph0dEUNdq+yHqm
	WX7olTpaQLdNs3SDC4sDuARk1LbHlLSjFPJcWHsaNRSEzHU+yQQCEJ0BorlAIPHM
	lSvOn3WgO71VQk5L8csA+ch5K02prCkQ9QytGRNMouLv+MgKb/LQAP9HpNStmB3+
	oS1BElYYzT8v6tinvb/p7gNsCkz70na8lrWGHoiXhNOrS1I1n4JzM5WHFPFJx+4N
	Mau00N59gfE/F0JcShyOEls4Tsm/ewyNbIA==
X-ME-Sender: <xms:7vSSaEH9b2y-dgorvdA8KCkFnwUkC2_SKm0W6J0-kVbmPWoeCwliQQ>
    <xme:7vSSaH5IDQ30QApVeKoBc7GILfaQ9otd0ma9_DLIDBKbiOofFY-G_Br0_eWGjKbUW
    SJ0sGfjzmVw5MVYCQ>
X-ME-Received: <xmr:7vSSaKsfEW9ESLb3ze6gqBxQn9gGlXoRgA6u_Yk5TTP8pDugceqkNIs88vdR5YwiPs21BFJCs-cSLz3b580OuVsHkuq3DmhtPV-sbjdlRA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudejfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepmhgvsehtthgrhihlohhrrhdrtghomhdprhgtphhtthhopehoshifrghlugdrsghuug
    guvghnhhgrghgvnhesghhmgidruggvpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:7vSSaI5To9WTzCFT8nH5RBVhqAWXxOk2DKmnj6Dat-1383m2ZkYZCw>
    <xmx:7vSSaFV1Gi3z1jP4AZh3oOe7q_LbPFEHfDxLlTaqWsGxqm1pCDIYtA>
    <xmx:7vSSaK9m9WHxwXuHv5rZ6GQW5n09zyei_G_Q2kWKQJyYMGcVCr29fQ>
    <xmx:7vSSaBnZPrbY1mtsMYIEjkBXtuNPKL4saJbaxSExmyODcIq0a6pYFw>
    <xmx:7_SSaOm2bijvy75QJ-NJ0K9bLck_CsKtu6ghhtUYRh3pHzKLIceCngIw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 02:23:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id bd5eeec0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 06:23:40 +0000 (UTC)
Date: Wed, 6 Aug 2025 08:23:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, git@vger.kernel.org
Subject: Re: [PATCH 2/9] commit-graph: stop using signed integers to count
 bloom filters
Message-ID: <aJL06Nlee6CR-KK0@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
 <20250804-b4-pks-commit-graph-wo-the-repository-v1-2-850d626eb2e8@pks.im>
 <aJB5uKFdGybf-IbN@ugly>
 <aJCW7aYqJB20LDNg@pks.im>
 <xmqq5xf35429.fsf@gitster.g>
 <aJEppnTkY+66IEza@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aJEppnTkY+66IEza@nand.local>

On Mon, Aug 04, 2025 at 05:44:06PM -0400, Taylor Blau wrote:
> On Mon, Aug 04, 2025 at 11:34:22AM -0700, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > Aren't you saying that a platform natural integer is a much better
> > fit?
> >
> > As to signedness, it sometimes is better for a struct member that is
> > used to record the number of "stuff" you have to be a signed integer
> > that is initialized to -1 to signal "we haven't counted so we do not
> > yet know how many there are".  So
> >
> >     These counters naturally count from zero and are only ever
> >     incremented.
> >
> > is not always a valid excuse to insist that such a variable must be
> > unsigned.
> 
> I wrote these counters in 312cff5207 (bloom: split 'get_bloom_filter()'
> in two, 2020-09-16) and 59f0d5073f (bloom: encode out-of-bounds filters
> as non-empty, 2020-09-17), and I don't see a compelling reason that
> these should be unsigned.

I think that is going backwards though: the question to ask is why
should these be signed if they cannot ever be negative?

> It's true that we don't have any need for negative values here since we
> are counting from zero, but I don't think that alone justifies changing
> the signed-ness here.
> 
> Is there a reason beyond "these are always non-negative" that changing
> the signed-ness is warranted? If so, let's discuss that and make sure
> that it is documented in the commit message. If not, I think we could
> drop this patch (and optionally the patch before it as well).

Yes, there is: it makes code easier to reason about for the reader, and
it means that we don't have to guard ourselves against negative values.

If I see a counting variable that is signed I immediately jump to the
question of whether or not it can ever be a negative value. I assume
that the author of this code _intentfully_ made it signed to cater to a
specific edge case.

Whether or not we should be using `size_t`... I don't mind that one too
much, and I'm fine to use `unsigned` instead. But I really think that we
should do our best and help readers by using the proper type for the
task at hand and not let them figure out whether or not they have to
care about edge cases where the counting value could be negative.

Patrick
