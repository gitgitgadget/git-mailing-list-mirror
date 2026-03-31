Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADC1A376BD0
	for <git@vger.kernel.org>; Tue, 31 Mar 2026 06:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774937091; cv=none; b=Ml/N0+lCUXqcLBUBqpjlsHR9Ao0ax+gyFP8ed03l1Yf1cCn+9k2Rg0+uEEksShQ+KPZZKpyV7WVxvyfMXJ64Qe0TaDogHocLHYPcGtbXgM6vSn1a/xnh9Sr3Nqhg1m8YOd71mi7iMWVnqAmrDsLMSfh0xU+HICq88hKCa6R+R28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774937091; c=relaxed/simple;
	bh=6uWPPXtZXwRKq5UgdZRhOAOd+wcdzt1mOybZ2O8wXmU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nvxk5VhLJnxJEO+f/o0VkLZQ7PP6HmrLrjxxSyJ4zMMRPbDDjqbV2zohUndNLb+VQbHJbV+KafVUiXT6LdoSrvDcV1ZgOqZNB0u00d4zmj3t8pYy56UVWBW5YjW9U3W0bR/OjhzryweHXal/1heBRypyvzWltTNAEKfnRDh5SLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HHhmb4vC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fNc8K0uk; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HHhmb4vC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fNc8K0uk"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id AC6EEEC00D2;
	Tue, 31 Mar 2026 02:04:47 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 31 Mar 2026 02:04:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1774937087; x=1775023487; bh=VH0EoxiMNi
	yNugRVoe/gR5gqHwc+5Md2U6wJ3QKjsIs=; b=HHhmb4vC8C3Pc0ynDuyEjY6u5i
	3oAKZB0om+bkmUIOtd3LFbOnyCA7B6OMYEy/bcqrcnDhzjK7+ev37vaPV4ST5w3C
	iDBmFVGbQJ12WZLAgwfn6ipgv90hcjeWnv/zz7kzQbnU8fMc8/Gc5L0QB40Fg3pD
	GpL3bpJOYgSV2Jte+IriXTDZT/ElnMsOWC0XBL8V5cGwu0CAVItBMCUmfgzdxs0L
	Oe+vMLdL+UGWl5QXkVbpInLPJfwmMIkTjVjqCcQ0sGokYTn0FC1GmOn9DFRu6Yoc
	VfFmC7Uf5ux0RQuN5G4LgdDo6yRsSYmRcI/YJJUOMuKIOl2WQUkmCJOsUnPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1774937087; x=1775023487; bh=VH0EoxiMNiyNugRVoe/gR5gqHwc+5Md2U6w
	J3QKjsIs=; b=fNc8K0ukzPDGsMntYzQLuDlKlJd3GRsdqJNa46YyMvi2SUHdRrZ
	6B7wkH5vX4sldAx90EeX3vNGGDfz6YANx/qaNFzLqZ+dLSP2oDyIBa0R3e5+LyLu
	mERq0FuR0QLUu6vJU3ohntzOoBDNjDJ3R+3YjD7cAh2g7K8v3YYVm+MDtm8Kp3o7
	5FRuDSmzZg1qJRCPd0oZfkhIvE6/ZYkHMqzbKcQy2xT43cFFlBMFneeUkIfejvnj
	ydGJE4fyYC6LvS0MoF+LhElD6O0uKPoT0bxeQMwv423MSVMOa8+knbjdQkpjlSVE
	gvIP3ub4Mm2E87u1lJ8VyhNlWwqEoRnx9iw==
X-ME-Sender: <xms:_2PLaQVAFU95mXwHzmvFUYx63LTKtfMJmfUzKJYVQ-PtqtzUE53mfw>
    <xme:_2PLabmAW4Hky_tpfhNfCVoVlytz9qFBv0iLt9N1NuuEA3ipTiPP3R8ZfgghdH14g
    12bf7yFtKHCx1WUKmBrW14kac_8UOM23AWAiilLtkDNHGBogDcS>
X-ME-Received: <xmr:_2PLaZYSEtCs17XBwMcL829WmehBFCdt6RU_Jpq_v0kOIoZDvXPTHgmfu9b2YUQZDe8bO5y2zPlV0AaLVUWkEdk1SALY4dCWlcQczv5Giz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefgeduuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekke
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_2PLaeO7zOOZxvpunEBMu6EdSOpqwkBmNCp_TPcdO1-qR3y-cn5Igw>
    <xmx:_2PLaWYnf6s0SXuHVjyoQXRQQuc1WUgCiXPATOMJ0YBWEWy-iTIJCw>
    <xmx:_2PLaU24J1devhJk3trEe9ri2fEPLB5XSsnZ2I6TRfAN0gle79menA>
    <xmx:_2PLaUe6ZQB5nRYkTtUtYRPRuq-pRi_G6hlEU24ya9kSpXOz0svLMA>
    <xmx:_2PLafZU2gtWNi2aHTv_xnwHiDMhOaddGObOANJvCt2Q_Kt1WdQ09Yf9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 31 Mar 2026 02:04:46 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 52f15126 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 31 Mar 2026 06:04:45 +0000 (UTC)
Date: Tue, 31 Mar 2026 08:04:42 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Toon Claes <toon@iotcl.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 00/14] odb: generic object name handling
Message-ID: <actj-nfq_PR863ag@pks.im>
References: <20260319-b4-pks-odb-source-abbrev-v1-0-5ddebad292b0@pks.im>
 <20260320-b4-pks-odb-source-abbrev-v2-0-fe65dcd8c735@pks.im>
 <CAOLa=ZSeMS2iKzgMUWix_Sx+e24863PsOazRLrqHtS5hYSUk3A@mail.gmail.com>
 <ab0hy6AitZFMf3RO@pks.im>
 <874ilxm4wp.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <874ilxm4wp.fsf@toon--20250203-5JQV3.mail-host-address-is-not-set>

On Mon, Mar 30, 2026 at 10:35:50PM +0200, Toon Claes wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > On Fri, Mar 20, 2026 at 03:04:02AM -0700, Karthik Nayak wrote:
> >> 
> >> I only got around to reviewing v1 now, but the range-diff here looks
> >> good.
> >
> > Thanks for your review!
> 
> I did a full review of v2 and only got one comment about a stale code
> comment. Not worth a reroll if you ask me. Looks good to me.

Thanks for your review!

Patrick
