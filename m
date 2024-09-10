Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D169A143875
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725948545; cv=none; b=OwTkOFis6nTvRJQgn2YRdfgtNCOuvEF0AfM9glaVhc2/PXTDxge2d3G827n/0quLBo/2SZtaChNReGeiBXqMU2a9ovcWKHw8gaQd1ZjyBqAy3eXqzUG8FkEfUSNeSRaCpCJnKWtZ9VJPlys27oEuRSRPz6271GB/aR5NXyqCHMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725948545; c=relaxed/simple;
	bh=TZM+1kUkb9X1yjc473pcsTVhT72GVZiiu7a4mzBYrzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B/yxvOLw/kl8RpeT+6odvzMG3/on2yaecqCCeFGmMh3utHwHPvEhSk8cnS3goimKRKizf53mOriTkBx2HCg27LUs9T2GLk59KRpcN9Oo/ongUzhgLo1atr7/i924L5KRvjVeakm7TLy+fB3CVmlLtowHnuRiuvAbrcQrhyoU930=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QzTgSF95; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EfzW0Z6z; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QzTgSF95";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EfzW0Z6z"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C5D1511402F6;
	Tue, 10 Sep 2024 02:09:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Tue, 10 Sep 2024 02:09:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725948542; x=1726034942; bh=MZuQfqwOqr
	OGPPTsnkKzF20rqVrhmV45AwRiGH0gMJw=; b=QzTgSF95rK5V7D3okb/IMAglYF
	xjLjwT+CkanrDFrbqE4zyxEAfCqX1CqiVixbWKIHW9kjclN+ZTuorUdNtT0QN/OL
	t1FuCM6jcfPqoplDXUJ+faj9b/qKpA2uxoeajOHoxJhWBhD+i7XoAa14IDivugO9
	N23BJvhk3DV4LNdpZEXa2aWcOkn+1RlAcuIChSMA9k4HrutQ0kgHwIod6nI55EOe
	O6OzrRBfpbbTDRqNB4euRkiOZDB1wrpYDjFbHl1UAyaoGQv0baA5XeJNa0dsmScl
	+oPrq6KDwPKZsEip4xAZrTmAzd3A/TWXE0qk+KQlQLyNjFVgYsmJuav66pvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725948542; x=1726034942; bh=MZuQfqwOqrOGPPTsnkKzF20rqVrh
	mV45AwRiGH0gMJw=; b=EfzW0Z6zMqiqyoIuQnCg8SVt1kLgPgElPO21Fz+SLDOT
	1vsS/xZO261gVkVTLH/DmTAq6Ms0y4aqH72xK0M5k6t8KBj1W6X5Bo5KuegpTNwW
	WQreH7Yn843Q4NfSnz3vJPBFO7LAYl3jBNpYabuR0JHq6DBqD135ABSIOJBx5uGY
	ps/of23UriIuJ8BpM5u2VLV0PeFOtSJ7D/LQVPWuhO/9NZ9c8ewXXTJKFpKXq+8P
	AcMXy2MLd5m6yU4B02U3OL1E1mBVzPDl+HNbxWIXRyhpHYpWx0fHnXBFZr1Ci43o
	bHEoGUBfq4RYIfdIkUuGHOQfuosLazggibfPBdEslQ==
X-ME-Sender: <xms:fuLfZtwwOSCzvcHzUzOz5WQBIAd1JEFoyBDuTFDq13pHqoaCPJ9JZA>
    <xme:fuLfZtSRBTV2kvQLL0rmwO5Z8-7GMwfmBWLqPg-TgUM1wG8KdGakgdqiHCYzWa9rN
    PYipWOGJMqq9Ajkvg>
X-ME-Received: <xmr:fuLfZnXnM9P9xWrBb1s1hV4gyZ18EiW3sUVF1i3cx6TC17ry0LXLM8ect3mxHak0DIjpLsg303m8yH-oy5R1tNzxQ2NGvW4J94jtul_PX638aMI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudeikedgkeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsghrohhokhgvsegrlhgthhgvmhhishhtshdrihhopd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehp
    vghffhesphgvfhhfrdhnvght
X-ME-Proxy: <xmx:fuLfZvgWzKn1rJlapkpraTtphbzOuJbus-HpThihqRo_s1kqqvMoHA>
    <xmx:fuLfZvBbbCEKT0eBjZ-hKDiOdG37F3RDHF9w0HkWDPcjojiLKYPCXQ>
    <xmx:fuLfZoJh4_f25te2I-afEszDsOnTZpdd08oiWt4CgvlLO6zOM-j_9A>
    <xmx:fuLfZuDh4OdyOc14qMW6KfcegAZnddVgCfARfA3M0P6MSFTGR_7w2g>
    <xmx:fuLfZmO1UemiQv5OiAgIc0d_-NE91KHMRV_oQt6BvftU6fb7Ydns8PgM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Sep 2024 02:09:01 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 6a335618 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 10 Sep 2024 06:08:57 +0000 (UTC)
Date: Tue, 10 Sep 2024 08:08:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Brooke Kuhlmann <brooke@alchemists.io>
Subject: Re: [PATCH 5/9] ref-filter: store ref_trailer_buf data per-atom
Message-ID: <Zt_ie4o3x8l6P64u@pks.im>
References: <20240909230758.GA921697@coredump.intra.peff.net>
 <20240909231653.GE921834@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240909231653.GE921834@coredump.intra.peff.net>

On Mon, Sep 09, 2024 at 07:16:53PM -0400, Jeff King wrote:
> @@ -2988,6 +3001,17 @@ void ref_array_clear(struct ref_array *array)
>  		struct used_atom *atom = &used_atom[i];
>  		if (atom->atom_type == ATOM_HEAD)
>  			free(atom->u.head);

Nit: this branch should grow some braces now, too.

Patrick
