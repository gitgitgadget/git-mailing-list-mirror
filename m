Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F121AC42B
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 12:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640219; cv=none; b=AYzjRaPGuAGPPIz3aiymWEscP0m2LPgsQbwTR3rJ4qSA9dtp2VZcQaPB8hx2YKV14Y7axbWPNbPPTFD5M3zF4NCcibeP6HBGWjXgB5X1WLmCHrfCDETjOP1uPSwSTv/E4VmygMvI0ekaMJSImBzT1xXY0s/zcJiyb7EfJ2JfZG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640219; c=relaxed/simple;
	bh=Y9dquzlWdEgBLeGhKeV4GG7Ob8I5Ewiiu5U34ZdPXSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KCS1PHlmKj4zyWb6JKs/dMKipPr+7LTvc4q1JzUuwxhVRLKlJ0uEGfLz0P7kf+OL1MYDnpPAlmuYcudS/6lewCZTnSQO+SdUFQrNWlPcKwOJefti/v1ObmcxhT3EmaThn2Ula7KcX4y8E4rYAEWcT3ko/R09Mrqigobc7+yu/Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=a69IPYPa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U+01ahDP; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="a69IPYPa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U+01ahDP"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id D48BC138FC41;
	Wed, 14 Aug 2024 08:56:55 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 08:56:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723640215; x=1723726615; bh=uhFVIld24p
	jksF0kjfrPGVaNsGPXPVhhK3SEYyT2Znc=; b=a69IPYPaP2N5LSGAunyl1kK0xe
	sbzXNXd1DBkAAGmjx727nh7K9Mt7QT/CK5ewLPAY8hr+xiVHKI5Sa4/bqwliR7mi
	t70et9F3pG311XbFRCfS14wjoW/ayn/3Qrv2K/lSAiMBTufIhjxbSe6fr9of71Tn
	x9Tuq2PBaKh0nDxScmsWqCkOr64idoXFFmwAeZesjrsqdV58QsJ0LphsAXkpDnuZ
	dV7aIX8aIgpb0kujeQYpMNIbJ3ihgeYkjJSg8hYpztNV6+Z9vEGYKL68U1rihYfz
	B0k9QvDhRY6uTBgnxwi+631fkktn6NzEukw6erOD/EWDIx6Wom5sv/yPCQsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723640215; x=1723726615; bh=uhFVIld24pjksF0kjfrPGVaNsGPX
	PVhhK3SEYyT2Znc=; b=U+01ahDPxEZ/KiZ8jSJ6pT4k4VgVYqK/d8b6fqcFeLVP
	NGoTF4sJDvztskA/qzsu1+/lu6+kSOvTdsm0OxEkgHl2bfjIBCE1G0jeBdNSuvwP
	//zqfeC2UUZ19uYvhbOby8CfM+QII4Wh5aqeGUcZOtt+OrvVTR0UAYgIEZZPAi8D
	BvAmgFfhBmKk1PSwA6H6VOsMr6QLYMtP0Bya1ml0ZxI2qH33ahjQMTsP27hE/JZc
	VJVadFmZpad88f/OH/AbGipAjwMHc8GNKDaHXAam8h0yX3OQZZb9MgF/ZbON/bIC
	HjOeamfs5/qWJvT2+bA02bfQeLp1OO6sSdHSFqAIpQ==
X-ME-Sender: <xms:l6m8ZgfW7uw8-dIgvH042QUcGmLvM_scojCqX4YSDCxZEriteNIUmA>
    <xme:l6m8ZiOHZR6RGgDFjmB2jcJLz1jx48bTirr3gtq1b5wj4Kajt_EFJkHyxe18g1RPM
    DNoL_eiGIOevJz_HQ>
X-ME-Received: <xmr:l6m8ZhhUSA7atXSRGujFOPMowjHx12Ebum3jq8QelUDgLFEeiRqdkrDtlpimO8eJypssFS8qMEv5oVJ95e0BTW0ibj-l7EMeVU-HTp-INVqXHg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgheekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:l6m8Zl_KXKvtNOKgl08Iu7dzlneN70p4_ehu1bEuMydxw6Nm0MUC5w>
    <xmx:l6m8ZstIK4KlEoJ1q5x13lSqX_RUtZghclTtXfKOzXmOPliV66L1zg>
    <xmx:l6m8ZsH83vV5q54Zly08Zj6n4oQp0dASN__qwSowZfWBo2R3DQ4DKA>
    <xmx:l6m8ZrOVkNkldTobvju1Hob4GPi-NiGJghnrqrZaz0H12y6CFSQlnw>
    <xmx:l6m8Zl6E7AAc8NLWCKdEr5OseFXEvZSWxHwysfZvRJiwXHlrAVEFJe3u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 08:56:54 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e73c9366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 12:56:35 +0000 (UTC)
Date: Wed, 14 Aug 2024 14:56:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: karthik nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/10] reftable/generic: move generic iterator code into
 iterator interface
Message-ID: <ZryplD3NsINRMxY1@tanuki>
References: <cover.1723528765.git.ps@pks.im>
 <14924604cebe20ac30d291399b0200016fa8b4e3.1723528765.git.ps@pks.im>
 <CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOLa=ZQ15h8bFRGGhzJUPNwkCrRmc2Y26n-0x+L_V_06xWgd7g@mail.gmail.com>

On Tue, Aug 13, 2024 at 06:04:30AM -0400, karthik nayak wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> [snip]
> 
> > +
> > +void reftable_iterator_destroy(struct reftable_iterator *it)
> > +{
> > +	if (!it->ops) {
> > +		return;
> > +	}
> >
> 
> I know this commit is to move, but I couldn't help noticing that we
> should remove the curly braces here.
> 
> Seems like the CI caught it too [1].

Fair enough, let's remove them.

Patrick
