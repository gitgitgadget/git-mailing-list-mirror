Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7D21F76C1
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 12:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729515550; cv=none; b=MpgPvdccOyhvrfWYhVXAQ7ngbQIeqvpIc4Q8B3EnTXDoeB15G80Bvx3ElLne27TU7z1oBsYInJjz7eQhG+JpxhoNYHxgbkZf2GAbIRqVqU5BIOd4yoPwD4oqK0ASqHFC+boy0ymhdHz2wCeh2kvxuJqRn2tjuMXWTiB8J8R8zo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729515550; c=relaxed/simple;
	bh=8kX8gInElELtwfEnzO8RcqA9kaORA75hSkkMp1tygiQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=odz6cXDihDraGf7KZ7LB2muZgzvDkm36SvNnHAkbzAQ1uFhYRD6H7qwTs4Sqy9/MRYQvqXK3c6VFZSwWHgspBFAJGdVSuxm/NJqJ3TTb1+CoDMfPXk4rP8xIPLm5KF/PrR2z8Y7VDaDsQombZE5xWlhTsKVuSvV+bDAE0yDvKGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ofCF/HHi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lxa478o6; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ofCF/HHi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lxa478o6"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C85E21140259;
	Mon, 21 Oct 2024 08:59:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Mon, 21 Oct 2024 08:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729515547; x=1729601947; bh=BU6OaMzc4N
	tTWq3jvRAI942Dv3z9rOeY7WyPnkcB1xE=; b=ofCF/HHi9XFsYVmyau0ZFzJs/w
	F3dqyxNqbWV+fiO40hj6hyDiRRfmbeImZncgfC21cboc1Qk1Rh/9e1vm9zlPRYFC
	/+Xxe9iTuA7xjU8kI4TNRb6nkdcFYV0sIo81K/hmeNNeEgKp+/FHXPPAmIB6U8He
	qmFCYxdsHql+WeISuNerPE9cPNA7l+1NgqZAk4hZwM6/8bFimLA7YNRHdPDNCm96
	LSki97n48Pe5qirCUJqxIV3/5XqedbaaXY2SpwXJddPXAE2bpWuCFR+VS44KywLK
	+bBbBC0V5i7KjVFS/pvaphUVd8VEddJTOai53phy5DIoDUMx8Huefv6DiXhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729515547; x=1729601947; bh=BU6OaMzc4NtTWq3jvRAI942Dv3z9
	rOeY7WyPnkcB1xE=; b=Lxa478o6p4BoKfkJQTRujh8fd7MBreqNnPHNLjJsYAfq
	WGZ7y7uNSfXytysdqL3ufpANfp/3Edxx3wA2sf5HUI5qCl3+wGl4G8sD15Gojc9q
	pCP/JZpH8l23e/PNLebnibDJjZgUpSpYVX+frvHtjXHMSLmpzyKJJFIcnRSvvDIA
	+PZ+Kj3BQLNXPTNUUN6fShGmufGL5z9F4O3RDB/uWsi3X/vdM0/l9J4UAS/nuHKA
	etlZZxUpSs5DJJOkbb8M/Htl76775Fs3sx3TrxTuDQui6oUGB+h23I3UQX4wcvIt
	+E+94xStNUgdmjBVjQztD7dJ2avjr+HHtacg1mW5Dw==
X-ME-Sender: <xms:G1AWZ0LfMDpN6i3gnwTeQDjI3i2S3vyh8HIekazIzkQ8MLxbFhpR0A>
    <xme:G1AWZ0J3MgTqXCBomjQdnuuOrLjylmYHXPNYp56vmTCcb0gHXGN-o_Zd2Fy0MowoN
    9rFUCXuXibEV00pvw>
X-ME-Received: <xmr:G1AWZ0tr2kShY0SNldE2X0crMGxG8OELa5tAqZrC2MKfRktYjt07LHr4ubZhu_SALjiMxyIJeXvcs9E1TxmDBRObAnDcencaTESOmZCYxww9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgheelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:G1AWZxZ9bMUQBJw4wQh-smP99YEcrpUdGKRgsrZzuPJpd34v-vxmDg>
    <xmx:G1AWZ7bKHihoVjNsc36IRsRhlPzl0dm9NjTRDDnVxtlbTGMDcKqqEQ>
    <xmx:G1AWZ9Bv6vPqpfC3fEXaV5aY657Ef9_Z1ff7l3hLRhQkQzElK2uC-w>
    <xmx:G1AWZxYNpGEh83XMfAeDvS_bfdSSKN73htcP8ubFtXgj_mNc-owXHg>
    <xmx:G1AWZ6k4-F6LBobvT05lvEv2oJWvoTsgzXcQoBpLDZkKki6GROx8l8F->
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 08:59:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1f9d5354 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 12:57:36 +0000 (UTC)
Date: Mon, 21 Oct 2024 14:59:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] CodingGuidelines: discourage arbitrary suffixes in
 function names
Message-ID: <ZxZP01C-9RngukZy@pks.im>
References: <20241021124145.636561-1-karthik.188@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021124145.636561-1-karthik.188@gmail.com>

On Mon, Oct 21, 2024 at 02:41:45PM +0200, Karthik Nayak wrote:
> We often name functions with arbitrary suffixes like `_1` as an
> extension of another existing function. This created confusion and

Micro-nit: s/created/creates/

[snip]
> diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
> index 30fda4142c..b8e2d30567 100644
> --- a/Documentation/CodingGuidelines
> +++ b/Documentation/CodingGuidelines
> @@ -621,6 +621,11 @@ For C programs:
>      - `S_free()` releases a structure's contents and frees the
>        structure.
>  
> + - Function names should be self-explanatory, clearly reflecting their
> +   purpose or behavior. To maintain clarity and avoid confusion,
> +   arbitrary suffixes such as _1 are discouraged, as they provide no
> +   meaningful insight into the function's role.

Names being self-explanatory is certainly a worthwhile goal, even though
I guess that it's a bit more on the idealized side of things. Functions
will often not be fully self-explanatory, which is likely just a matter
of reality. I mostly just don't want us to end on the other side of the
spectrum where we go militant on "Every function must be no longer than
2 lines of code such that it can be self-explanatory".

And yes, I'm of course stretching what you are saying quite a bit, I
know that this is not what you want to say. I'm merely writing down my
own thoughts while thinking it through.

So, that being said, I agree that we shouldn't use arbitrary suffixes,
as these are quite hard to understand indeed and typically don't really
provide any context. So as long as we interpret this rule leniently I'm
happy with it.

Patrick
