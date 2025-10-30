Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3991F2BE7CD
	for <git@vger.kernel.org>; Thu, 30 Oct 2025 06:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761805605; cv=none; b=ZNgD5FjZ4VKRmHY8Tnyqsai12SLlFj+b7HbLjWU4hrhr0loHx9swyFGBy0mqNZQ75mLsRHsRKZDRbDYkLg/AA0Ni2m8NqqtEe7Oo7o6d3vU5pG2yg1AgcCdKzcT9Uu5CRgFHUKeTYg5qy3MkFB9PR9V4QalmlDy5Kuxioeq+sDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761805605; c=relaxed/simple;
	bh=REaYYByeJ65iKLQ2K+GrpOTNM5QqHjoF2BS0TqbQTv8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aw26ce4dQzp+FMZVPxq0ANqm1jEbeBv+uF61H8SXRrR8ScIaN3pIQLJKEeD9bd+F6ovJZ/I7PGiGpY069tYUx1qNJ090l9T8lJqwHH+2bsXG++h6Evbh3/YzPOKJMIpDxbhYPhb1Fbzpoary1di8qJOG6QTbxCDjWaFZY45mQ68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QxjVwLce; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GxGteMer; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QxjVwLce";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GxGteMer"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 2CC13EC00DD;
	Thu, 30 Oct 2025 02:26:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 30 Oct 2025 02:26:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1761805602; x=1761892002; bh=Sh/y+wLShj
	jwe34tYEL/XEf5rY5d4Wfvh0jZoaEAXLw=; b=QxjVwLceo45L2pLxK19gjtWtAq
	HhnR5a7w4sCSFnmiHObgWMtj85AYyi3eyGE8orLsMNcDGjLJ+WrgrE+llLnrvdWR
	Rt0l38VbTWdO+nE0JLQnQz2KEUFhBU+EzssZvd6hOs1JcnFaZVXvkXbK9wfX1FOx
	xIPU+GHP9E1aohJS2D9R55EzHfDaO4T7N1Scva1c/7SMHy9KNdxU8HMA3/tx6x+Y
	k0QmXOoVNl+VuRu9NbXz7WYbUnZSFOlhFMSoofkGnoJIynw9t6oDmh+kKhK9NJT2
	NCDaR/smzKlQreOW05IB2/1LwD5pMSaf0gRctGEuZzx/WjRCwPnOiTWR6g1g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1761805602; x=1761892002; bh=Sh/y+wLShjjwe34tYEL/XEf5rY5d4Wfvh0j
	ZoaEAXLw=; b=GxGteMeroz4B33FVpRNa/vtFc7T7H7GpjHZoJsBTc21+BJmy6TC
	NNU3IdxMDjowFzSTaoHEp4UMZisO6OntJHQo2oTvUJ435f0ya8YU/u75VqddZ3vn
	UVBqg8ls5D6eBEx/kAEmZZviKS/HEzYqU3qeeWPrvk1O+T9h+SArMdon2cvMag99
	Hl8YYv+C+XtH3hMUW/uOjo39xYDc/V81XyNfpknLYvF8Imz9hxfVkVI8NI88bHcZ
	JzBvYpPjF5doFT9tFN3k9JO9gJG97DYNSPQ9H2w4jR5++J/qHKX47Ldvdo11mZjX
	nlJVD+6c14LvK4J4ka11VQY+EwLzGs/1xag==
X-ME-Sender: <xms:IQUDab1JS898IK2NfBAdKbTN7WcWf54yquP72in-QBD9kpKpsEUiBQ>
    <xme:IQUDaRH0uCrhN03gQwCx5V_yHctZTW0qS6iX8t-mK95922KYQjatBLIZvjlAUX-CH
    0Fvd_NWQlMJz5L6GYz7ZJJhMY_w2cn_UTEgNGyOqxf3VU4rSkLz9g>
X-ME-Received: <xmr:IQUDaQ4_nYcwl5Z_MGXENtLbLZD24NqLjoMPCxLtlH0NSoO5MKhtJ2JlW8mEU9o8lW3AhKGQCutt9QDUDnTZCsGt5Mj3-fxoTp-EHbyS8g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduieehkeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:IQUDaft6oiKMWMwYqfl4w5wXuotSyPH_GWjXYQ2vuu3_iB1F4xzKKg>
    <xmx:IQUDaZ4UUXAJc_PFGOlxS-mrZS66baCPpIDqUVOTiKroKcq92QJ4zA>
    <xmx:IQUDaSUJSv9q6e10mJlzVFeVxBa3Py7QpCAE7lTDNa7jxThOoMMRnA>
    <xmx:IQUDaT82xELhLdtu23BuJqLBHTu2xBl9ZXpIHQ7XDyfX40D3d8inIQ>
    <xmx:IgUDaVrIJPwOiMMmkYk9TXPq_roxxqlgr_08adJ5hotgEf-8m8luMz4c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 30 Oct 2025 02:26:41 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 6626c2ae (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 30 Oct 2025 06:26:39 +0000 (UTC)
Date: Thu, 30 Oct 2025 07:26:29 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ezekiel Newren <ezekielnewren@gmail.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org
Subject: Re: [PATCH 10/14] rust: add a build.rs script for tests
Message-ID: <aQMFFZ_uDZxHvExW@pks.im>
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
 <20251027004404.2152927-11-sandals@crustytoothpaste.net>
 <xmqqms59acak.fsf@gitster.g>
 <CAH=ZcbBYRiceXQ-9FNq0aK0WzN4nDhqonaoafweStC37mx7JBA@mail.gmail.com>
 <xmqqwm4d716i.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqwm4d716i.fsf@gitster.g>

On Wed, Oct 29, 2025 at 04:12:05PM -0700, Junio C Hamano wrote:
> Ezekiel Newren <ezekielnewren@gmail.com> writes:
> 
> >> Hmm, I recall Ezekiel earlier arguing to roll reftable and xdiff
> >> libraries into libgit.a as it is a lot more cumbersome to have to
> >> link with multiple libraries (sorry, I may be misremembering and do
> >> not have reference handy), but if the above is all it takes to link
> >> with these, perhaps it is not such a huge deal?
> >
> > I think Brian might have written this before my series was merged in.
> > ...
> >> I am a bit confused.
> >>
> >> XDIFF_LIB and REFTABLE_LIB are gone from Makefile on 'master'
> >> already.  Perhaps we should revert earlier series from him?
> > ...
> > I don't think we should revert my series.
> 
> The order of events does not really matter, does it?
> 
> If we can happily link with more than one libraries [*], it would
> give us a much more pleasant developer experience than having to
> roll everything into a single library archive, no?  Or are you
> saying that the way this series links these multiple libraries
> somehow does not work?
> 
> You somehow manged to confuse me even more ... X-<.

Simplification was only one of the reasons we had. The other reason was
to unify how Meson and Makefiles build libgit.a, where the former wasn't
ever building separate xdiff and reftable libraries.

The question I have here is what the benefit would be to have separate
libraries. I don't really see the "more pleasant developer experience",
and I'm not really aware of any other benefits. So personally, I'm all
for the build system simplification that Ezekiel introduced.

Patrick
