Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0548E34BA44
	for <git@vger.kernel.org>; Wed,  8 Oct 2025 13:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759931070; cv=none; b=uwvXr0vQkzNKU9IfYI/PCLlD36jrta7rA9eLZ/Q6/Tl1Hh/RDEA8UTIgl0h/yxSA6UGCwxFRAWK4YAQVd+RHfz5ILKn59lRo0FOIenNQl8a0UTonjEBBmDHe5VEr8p4Lk8cJ21EdrKjPTiImg7LVQg1rlUGmeMy1lxDoG21CK54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759931070; c=relaxed/simple;
	bh=MjbQaro6Hw79Ns7UuSe3y7drysr9GME4GDXyNGh7IdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=puUBGOiYBHism/OmbsCc06epi6rXnFTnsisFKMyuySvLt4PU7FtuM3f+s0L/sAornl37RkEkFmu1LRFZZUJ3Vn6hN8YcboWnOgRfK3GN6cQfPuh/YIxBdGhz2STPvlTZNMGBRJG34t9IXkyrOPt0HiXyiQTtp/VDr7o11oOLvdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZhKOCQ13; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oSG8FnIn; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZhKOCQ13";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oSG8FnIn"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3B48E7A0152;
	Wed,  8 Oct 2025 09:44:28 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-11.internal (MEProxy); Wed, 08 Oct 2025 09:44:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1759931068; x=1760017468; bh=5IaMhP3jUA
	StbuyTgT5vL56mYxxnS+XaK9TGGC2ULuQ=; b=ZhKOCQ13yPykph9x9N4SALPhLn
	ti6XJHzjMSGYokcGZ1xsGjyydfh16Z+q+pIC2hKIKRpsYfNXw1kNL/nOANrIbyJe
	BzR3JPV7QVmW+uA6AloN0p84j196MdWs/c8LtF5UnXExAOv+sGDgXy4OQRHjkJXs
	lYJdXYHmv9QAeB2i51e4V4raY+vbyycDAjnGqh1Ya+LHUgS0sEvU3jH+xwcWNZwi
	+VWEHWUpyJNN7HIde86asEQ6sF+VzwykXjBeSEeKd8cpRzVS0T+AWTPkb6eveL0+
	HEaVdM5hq9dRsFOHj3lO0MSvzJjLl5eKv0yDwWgr7arusrWZp8kjLq3rgOTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1759931068; x=1760017468; bh=5IaMhP3jUAStbuyTgT5vL56mYxxnS+XaK9T
	GGC2ULuQ=; b=oSG8FnInBVVXYmX95JGB9oqyW//FlBGwYnu9ugOCDpp9n47+2IU
	AIjwoggoJSq3vEzqwwj5KXIaencW7/MZEWjHLxYF+B+F+lJuPPOWeG6YD3bol5VE
	U6HI3GiamG0LKnlqGz+Zl5k1LfvVIj5CAdFet6akYo9yzfUw/cTR55LNHDC30a1x
	Lp5uZCcgrm3dQHjNS8Fl2gh6F58cgCIcm5Ti13nPWF+YUNIDaOI0x+1sz/5Xp64j
	YpBBg8XKyppz3N5bo8SJbub1/6CWN4mv/Q3sP/vl3M69VB6EuYz4n9J98eraUdww
	VwWI4Egy/CmHHknO4axlEYYQLY7T7OGijBg==
X-ME-Sender: <xms:u2rmaHs0DjSh6oCxcYUtY7J6H7Qg6C5r3K-AUSs2Gu0tsZ37uopX8g>
    <xme:u2rmaOd5KtHCE00B6BalLdtocZi6GK85aZhGA0IFQjK18qRugXv8l38ZBIDyLi8L6
    4UzHJRZ34QBPd_lV41pnTvDVtyIbx9fZOnjAnozW-nj-1BejZfk>
X-ME-Received: <xmr:u2rmaIZn2B_uZr37U_m5c_zZCZncighNR09DrkOojT64kpMSMl5eptshazHIUNE3gW9FoIBZNA1JgynHakGHSnyjsFNMnj_N-qpAHvNH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddutdefgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhih
    hkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:u2rmaBXBiMfYTAn-VWFBgImmG5dgIJ3hTEHZJlITrzopj-3eJqcAww>
    <xmx:u2rmaKiR1fHSgwjLIqYzWasEObRvxtKr9rnTikgAuQwGzbheT6LBog>
    <xmx:u2rmaPXfQ20zeij-B4ysSbBoRarJm_Xx0RCEqMQ5ZwyEfIENvKpwJA>
    <xmx:u2rmaBMsjUiDkX6kKJtQ8FnZP5BnWbpgRE1Z7ASx_pjmMaaE73SP-g>
    <xmx:vGrmaCe_aoMXeBQqMcsEN_ZYz8rRJiDCfxDhiaCi1_i8VRsDr3y0JZI_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Oct 2025 09:44:27 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0098d4cd (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 8 Oct 2025 13:44:26 +0000 (UTC)
Date: Wed, 8 Oct 2025 15:44:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 03/13] refs: refactor reference status flags
Message-ID: <aOZqt7s3wWtIK8ev@pks.im>
References: <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-0-916cc7c6886b@pks.im>
 <20251007-b4-pks-ref-filter-skip-parsing-objects-v1-3-916cc7c6886b@pks.im>
 <CAOLa=ZTL7kY6_2AqjYJGrjnKgwWVBbjrtgha-dBR-ijL7C87tg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZTL7kY6_2AqjYJGrjnKgwWVBbjrtgha-dBR-ijL7C87tg@mail.gmail.com>

On Tue, Oct 07, 2025 at 07:27:55AM -0700, Karthik Nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> > diff --git a/refs.h b/refs.h
> > index 2b24a3d997..8f484e2ffc 100644
> > --- a/refs.h
> > +++ b/refs.h
> > @@ -333,27 +333,28 @@ struct ref_transaction;
> >   * stored in ref_iterator::flags. Other bits are for internal use
> >   * only:
> >   */
> > +enum reference_status {
> > +	/* Reference is a symbolic reference. */
> > +	REF_ISSYMREF = (1 << 0),
> >
> 
> Nit: It would also be nice to rename these flags to
> 'REFERENCE_STATUS_*', since that seems to be the pattern we generally
> follow. Doesn't have to be in your series though :)

Yeah, let's rather punt this to another series. There's hundreds of uses
of these, and I feel like the series is already quite big.

Patrick
