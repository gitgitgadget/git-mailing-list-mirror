Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 895EF6026A
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 04:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723611000; cv=none; b=dmOSw5DHEH1Ow5NJV0PbHpwnX4EDNPxQIPpEdXopqr8aSRaD4tw5wEXycz7AeTUvo898FjghwNBtDI71VmPf1AfTgL1hdfPfQhDfwuvBJE51ZDwe1LWQWWHCI4My4UIrBfVATDg9PfI2Cog57DeteMpFGHLgVeDEY8AlIonhccY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723611000; c=relaxed/simple;
	bh=T3Yt9MMDznF+vtjRaqTJlZW63If4AF7Jm+UFnk9KsLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJCnwTtV/XfQA+Ss2LtlAkz1fYmKosQ75NwJa332V6W+hac2mHBt8MPty90Zpb40yT9zBJMCXEm1L3gFKZrOHexgxvH1pDSHwH8K3vqtIuU121zhPtgbM6elA2a6ZSfGrDLFdIazNN8oAT6j9ipdd2D6UDxa2wEp0Elfw8CHFZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VFZP/v63; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=E+iHcCxz; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VFZP/v63";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="E+iHcCxz"
Received: from phl-compute-01.internal (phl-compute-01.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 62DAE138FC64;
	Wed, 14 Aug 2024 00:49:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 14 Aug 2024 00:49:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723610997; x=1723697397; bh=wSWQ6FYf0b
	OivduqhyXoZcJBM5zsXmug7o8+V3r4Q7Q=; b=VFZP/v63VxzKzZecGEHI2FmWV6
	ldFryuaxaAxwXc9nJ9AmCuGHDKUCx84g33k0B5N0bLmxJm3a7vjZ2IhJf5pngCGf
	2t6xBhC+dQXdocqG5uKIiGG7+SIQXksE9XojhxfYTah9mXsYNnx1mcHE+EtMKaQE
	fzX11vrZq/SkPg68wcEb8Eih9InNfsO1ai/KeLs3qXPKzZ6vNt0fmv+ZvN7uuD3l
	kN23byqJlAgJM1REafCUiFTvfuORtFO/y4ChiwV7FCn3DqYmTwn6phkb+DBTIWi7
	61Yyvl7LD+15sZqV6co6/JmeO5k71BLJVHzl2BimMC44GDnYu3RIIy8cvSFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723610997; x=1723697397; bh=wSWQ6FYf0bOivduqhyXoZcJBM5zs
	Xmug7o8+V3r4Q7Q=; b=E+iHcCxzmcgTgLXW8XYQc0+Aw6zVQUxTaubcPue0qQnE
	v9HlW62wqto/b+TzE/vG2Kivi9s72kogjqACo9dMC+ZcwBT2KKfu0QXPnhQYYrfm
	ZS+1ikCOp7ObyNvLpPH16jDSnFNPF8gDya6MN77wJK2qNJ1DP1vHYCmmXVI1D9sE
	10CYSm9voDX0hQoAutgNWID8SFu8g+5e95e/RrsLIML+YxQO4FiES3/r9NcNv08x
	gRNsje5c+1VzaiR5vZh2lPoyzOjpo8fWX44ozwJvc20nYeEdrcq+UMdZX+ZCVs0T
	l2dUnodvPMEKFMv7kRUglgwV0heh2vycQdOrziLwDQ==
X-ME-Sender: <xms:dTe8ZsSD6gkkNlhVgpQp1P7gFSuYQ6dIh-1GC76vaUTnqtFWCcxVgA>
    <xme:dTe8ZpxO4qOCl_KM_JKbHa6A2tIv2vp8QYZHFFKeDDcvu6CpkxrYO0wY2qdY8tXnD
    -v1kfhBXDJZ14mUtA>
X-ME-Received: <xmr:dTe8Zp34K9HoL8PRR5gQRQpeWnUAs9fQX22BgN_JwjDHpUKWCDJ1imAkTukeuWSiiNk97dWTA5GUwuJE-QPoVJW_TMYsfPImbmtlgGcbtKpJ-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtfedgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrmhgvshesjhgrmhgvshhlihhurdhiohdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepmhgvsehtthgr
    hihlohhrrhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:dTe8ZgBVtSwoFiOqDho267pW1WkOKAL_akjLTUJ5RxZ1gmjXMQ1nFw>
    <xmx:dTe8Zlj11ot0cFREUW1R-z4f8hvAU7LdQW-OICpQmrsk6bZOtwPd2Q>
    <xmx:dTe8Zsoi-qjiAYBhZrrJScSueirEt1jBaeNrlumDjS7YNHz_6uKHjQ>
    <xmx:dTe8Zojdl17F8yDvCnso2sTRRaVP9V8FmoanYN0UYYa4A-VfDujFIA>
    <xmx:dTe8ZgVi0DlcZFI0M8yfost_XCwYCL1aZLoEel5qEXVkqpwJLS7mZNTU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 00:49:55 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id f097fade (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 04:49:36 +0000 (UTC)
Date: Wed, 14 Aug 2024 06:49:52 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, James Liu <james@jamesliu.io>,
	karthik nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 12/22] builtin/fast-export: fix leaking diff options
Message-ID: <Zrw3Z-HyrwynS11X@tanuki>
References: <cover.1722933642.git.ps@pks.im>
 <cover.1723540931.git.ps@pks.im>
 <9591fb7b5e1dac2f989bd10ef2c13a191571a060.1723540931.git.ps@pks.im>
 <xmqqplqc755r.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqplqc755r.fsf@gitster.g>

On Tue, Aug 13, 2024 at 09:34:40AM -0700, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
> 
> > Before calling `handle_commit()` in a loop, we set `diffopt.no_free`
> > such that its contents aren't getting freed inside of `handle_commit()`.
> > We never unset that flag though, which means that it'll ultimately leak
> > when calling `release_revisions()`.
> >
> > Fix this by unsetting the flag after the loop.
> 
> If I grep for 
> 
>     $ git grep -nH -E -e '(\.|->)no_free' \*.c
> 
> I notice that in a lot of places there is a pattern of doing
> 
>     set .no_free to 1
>     cause a bunch of diff using the same set of options
>     set .no_free to 0
>     call diff_free().
> 
> I am curious why we do not need any diff_free() here?

Because it's already being called via `release_revisions()`.

Patrick
