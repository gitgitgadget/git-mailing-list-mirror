Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0065722DC24
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 09:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736846035; cv=none; b=PDMkl63wxwzqS/LNKegF7gXPYftSXOS37r5z5YD1FsUfrA6DYGvToBVJeBHRjjFQEcTocJgJggBJbAbqtS/ts04sLowiqbLk2MaN1Sh0sDgvKFmYMn1AFBqWUIf3pdxww6tr+TFkmFmqIsgBdIlmUwrbFFiyqIErg/WWGVykRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736846035; c=relaxed/simple;
	bh=NCrkXnyb6AUVXTyrBYFLLjB/lqUqhb7pIvVnZ05IB6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VChqRycfSy01NkraijSH3aTte5lRWWShBI1pDEaGtWCzBqaZrjoUEiYFWd9UYNPTfBDVHOzombu71Jg8sFR3xNRtyLP1a+LoYZVGBG2nPJhiYVVzAgiSvNUru3pFo4v9go/IP7EQfhZLoHEugt9HgRouddxHMt2RBVMdxtMKAI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M06tvD0k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jIHARgbW; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M06tvD0k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jIHARgbW"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 35DFA1380205;
	Tue, 14 Jan 2025 04:13:53 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jan 2025 04:13:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1736846033; x=1736932433; bh=wjmXNy2WaO
	QMyC0UCZnT17FF8RrvGJa223dv+tac4NQ=; b=M06tvD0kYB9K0q6APrMdFIrZfp
	QZvYiDQj88KptfS9wuLUAXVfyxreK8+Y0uvK9sgKVcPBxaJjtlOGjbio4SPFVGZv
	z5JyT/8ytrchuZLmfRLCsl190yvVD72jVaoON2Uyr1QXYRXbnQly2VtGtJLLXjHV
	MdaTytHGBU0SoPVUdIwEFpw2Hi0hl6RJ7gZlBWxWcQrzqhd0MzKf5aq2ytpjiReB
	RpCZnj59DbZjkDYs5apDpiuQZoDBI2TBGlghLENxiHM/Q+X4M6W+VIzdIsLcAbOf
	JE3MsdkAyIkqaIlOtDYTfZCH5AZZ65DBCo9hpUyr3hv1VZ+ecXjrTNNb1s0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736846033; x=1736932433; bh=wjmXNy2WaOQMyC0UCZnT17FF8RrvGJa223d
	v+tac4NQ=; b=jIHARgbWJ7IEDY4cfro5yg3O1p5YuI3NDfN81iPlREro8xGZjkz
	TbTgii8fbsHMX0Ajue7OXl2c70NlUi9G4cE/wxLkeJUkT/0xfRMrYzm6Jc/iMifK
	x/IQlWGDBnCmqQ4tHSTfRcoydPaUsUN+rBEf/O0ojnafWaTXze3ctT4Zh0JhrmKV
	fv1TEp5z9UZwWBDGiYL/jUyi+c9aISFKnJVz2zspEWViR1OqODcSo0wwusjSzkGF
	/IyhcmYXzZnq8FQnpGl2ODKZ75MlHulMzMMEae4mH7DnfuZTdKIb3ga6WpkvYunu
	MeF0KysWUWKVsQGltbGvXx5U3mksk6IOK5A==
X-ME-Sender: <xms:0SqGZ3yU8_7mKyxxnxHdmGhLkZrrdHQywcuDyqjKMi0xF3t2S5K9Ag>
    <xme:0SqGZ_S8Yxce-vXB9TJAWtcyPmp_2akPHY9dJ8m8XNrLHF83Xifqmy0ZkZizm2Ipu
    BJS0wsbYAnlM-o12w>
X-ME-Received: <xmr:0SqGZxUEi1FzTakMrT3rYGQvM1aA89nBSm4sbwv7YF-3Yhw5KRKyUcGqOzPlUPB7IiFiJ_Qrq0eRjMGfsK4PWdQ96MguHIu0VbYq-pmut61VTw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudehiedgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvvhgrnhdrmhgrrhhtihhnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvghs
    tghhfigrrhhtiiesghgvnhhtohhordhorhhgpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:0SqGZxgHG9xpbmLyYoK2zT0s8hgfiayopsf1RChJA7WEkk76xFEpFA>
    <xmx:0SqGZ5BZRZYg5C1EE-vTjmTRNkoyEMUa0qKfnzASYNqKPt19XtzuTQ>
    <xmx:0SqGZ6IepTsnXOjwvsYpn1Z4bRniZ3186QCHJrGrkM0OJ32uuuw66g>
    <xmx:0SqGZ4Aoyeq-trqT5qE7nBB9Lxs1jULMNwiA7hcSBkPVIp4J6t4G1A>
    <xmx:0SqGZ09Hh-PYw0SPI8k8_PuzM1Ux1yz7_v7v4QW5a2GC7smYh05PxDAb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jan 2025 04:13:52 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f04c22ca (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 14 Jan 2025 09:13:50 +0000 (UTC)
Date: Tue, 14 Jan 2025 10:13:50 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Evan Martin <evan.martin@gmail.com>
Subject: Re: [PATCH 2/9] GIT-VERSION-GEN: move default version into a
 separate file
Message-ID: <Z4YqzsP7yJ1OcmZ-@pks.im>
References: <20250113-b4-pks-meson-additions-v1-0-97f6a93f691d@pks.im>
 <20250113-b4-pks-meson-additions-v1-2-97f6a93f691d@pks.im>
 <xmqqa5bua9vy.fsf@gitster.g>
 <c36dc170-2792-41e2-b128-04c7c5e7ab55@gentoo.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c36dc170-2792-41e2-b128-04c7c5e7ab55@gentoo.org>

On Mon, Jan 13, 2025 at 12:51:59PM -0500, Eli Schwartz wrote:
> On 1/13/25 12:42 PM, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> > 
> >>   - We can pull the default version out of GIT-VERSION-GEN and move it
> >>     into its own file. This likely requires some adjustments for scripts
> >>     that bump the version, but allows Meson to read the version from
> >>     that file trivially.
> >>
> >> The last option is a proper solution and quite trivial to implement, and
> >> adapting scripts should be a one-time event. Refactor GIT-VERSION-GEN
> >> accordingly.
> > 
> > It is not clear what "proper" is.  It smells like we are bending an
> > established work flow element to placate a tool that is not willing
> > to cooperate, which is very much unwelcome.
> 
> 
> If I understand correctly, the constraint is that it should work on
> Windows, which means there is a bootstrap issue regarding detection of
> an "sh" command for running ./GIT-VERSION-GEN
> 
> Proper simply means it works reliably on all supported targets.

Yeah, exactly, that's the issue. We could of course try to use
GIT-VERSION-GEN anyway and just fall back to an empty string if the
command wasn't found. We don't use the project version anyway, so it's
only a cosmetic problem. And it's more accurate than extracting DEF_VER,
too.

> > Compared to that, grepping for "^DEF_VER=" in the file may be less
> > yucky.
> 
> Or for the sake of Windows portability, grep_version.py?

I don't want to make Python an explicit dependency for building Git, and
due to Muon it isn't even with the Meson build infra.

Patrick
