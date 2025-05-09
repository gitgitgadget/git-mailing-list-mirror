Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3702F28DF4D
	for <git@vger.kernel.org>; Fri,  9 May 2025 11:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746789939; cv=none; b=gRF0iXXDsmh4A7cIXpLnm0xIRZKOzKROHeZZiM4Ts7R5KJ50MsPVl3Llf9mfHi4ALZVtCJya1+UZ4Xo25FoPtfIJO2zS5ZUarS16+x7GI1oM2FIoE7qb+XGiRF9gVnES6vRPQDFRYSHXlSkdurEBWzge6YO+EYaC5uJJRSJgKbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746789939; c=relaxed/simple;
	bh=WD36nMoNHxgYIPIj7YO6ZsX9Uv4GdLZv4IbYYPFK/Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh/YYWDZuYt2CtTlBMOn8X5YEitFL04aixSrvYibp3cR0IRz2EwfjQQmrmhZqzooeX7KqDaG0gV+VnL1RVP2fQKatevyx+eRlUO+0fWF7QTEau5sN8Fr2CB8vPpA72/PWALFfmz6VuQw1iHY99S5qzfnUY9tT2D5lcrxd+rYToU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=FzdeVsde; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=P8uIN5yB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="FzdeVsde";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="P8uIN5yB"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 50EBA1380229;
	Fri,  9 May 2025 07:25:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 09 May 2025 07:25:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1746789937; x=1746876337; bh=g3WOZEybJP
	xQfZNWgj9kCgMN1Z7W/D3dnDG8wUU1kBU=; b=FzdeVsdecP+9Eu24QhGc5PD9Z6
	HXydJC1csTTZ0msVSa6onFCHRM/ucalZq48CyHre5SqQ6zDZ5r4RylbS6DVKtJkz
	IRE++VCaYkRJRqkpohnoz6JzAbWlvAOXkzLPyPiVCw/zMGwLJwRBA+gPw2K3bf1g
	664mmS1owWMcjJfNsEPP9TCCsiddpYzW6GvKl49+7Vilgsqrp6X6r9LZODw3zI5T
	eSev/FHlKqH8neYCLDJ5ZHnRcUWw7xP7HO62P1shQjBG/g02UMrMvnueRBmrj2yg
	rulvDycPuWsQKwMHqIgQKguuyF+6OCaTRxvOFMXM7/0s4bpG/PeJvD9T9Chw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746789937; x=1746876337; bh=g3WOZEybJPxQfZNWgj9kCgMN1Z7W/D3dnDG
	8wUU1kBU=; b=P8uIN5yB9Oe4YcjoQEW0xCgkzHCsoUZTOFV9ld7zj5TkX4bLUm/
	9r04hHnN7P0kUooMi6+9yEm9EFNnrifF04j3clPh50XENQnezGu758NBb/qKhTaP
	bFNepc3F4llLG/mQ78msJmBrRijYxKr9f4MaM8dSpi1ojAvvEa/09bmuKjecAeS9
	/vdCibfKqksrMBfJYM7gvLRrtkX8T0muQK35QHLqkd0SGTldszLenU2quBhcBewq
	rNr8TxHfst/hfMardnkRwDzI8S/VLqVqGQEuiacGFT8ayAkh+zLfK0jnjO+Jt2Pt
	UYFn0NJzILRIC57DBzQXDk3uam62aLbr6GA==
X-ME-Sender: <xms:MeYdaNFQ-YZpc_os3UqXrrC7zJ4kH2f1PSaL1SpGS23OSHUOsHC5gQ>
    <xme:MeYdaCVLZX0S5RxkC4a7p_kiP-I27_iQfKAmQJSVjI3gDpFxYWv4rlFc7qT8sgVsf
    tqfgetT9gK3mhcLpg>
X-ME-Received: <xmr:MeYdaPKUILnNz3Rs4eKOriaj8I_jGdKdIWi5DFYq7sEuQ2wMzKE_zm7kOp14WrC-MJHPX0koQnme4pN0AVvZG5LLksfbs9dVhLYmb3jhag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvledvhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:MeYdaDFDrIiloNOapQvCXkeIum4xJY2cxnIth0fhhb70tdS2rDhpYA>
    <xmx:MeYdaDVmJqE6lcEjS5aYsdCRdGETSPwaIkPew6loZbINl4P-if5iDQ>
    <xmx:MeYdaOO-78wL16aypSUVmEDzwYTwYSOEIIqbZ81mHhOxCnvrPu9ahw>
    <xmx:MeYdaC3Kde2RVGOK9TUkva6LkMvtCp4YS4empjfNcEq1mzlLJOh6kQ>
    <xmx:MeYdaCA3S0ZTaNz6eW39lgjNGM2yKV4CDRMFjzkMkTkS5phGawJjnMk7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 07:25:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e21065d8 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 9 May 2025 11:25:35 +0000 (UTC)
Date: Fri, 9 May 2025 13:25:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Derrick Stolee <stolee@gmail.com>, git@vger.kernel.org
Subject: Re: [PATCH 12/17] odb: trivial refactorings to get rid of
 `the_repository`
Message-ID: <aB3mLhsG8UhgfhmO@pks.im>
References: <20250506-pks-object-store-wo-the-repository-v1-0-c05b82e7b126@pks.im>
 <20250506-pks-object-store-wo-the-repository-v1-12-c05b82e7b126@pks.im>
 <728e13e3-b563-4d66-bc00-b3320b76ec9f@gmail.com>
 <xmqqecx0e5pf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqecx0e5pf.fsf@gitster.g>

On Wed, May 07, 2025 at 09:38:52AM -0700, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
> > On 5/6/25 7:09 AM, Patrick Steinhardt wrote:
> >> All of the external functions provided by the object database subsystem
> >> don't depend on `the_repository` anymore, but some internal functions
> >> still do. Refactor those cases by plumbing through the repository that
> >> owns the object database.
> >> This change allows us to get rid of the
> >> `USE_THE_REPOSITORY_VARIABLE`
> >> preprocessor define.
> >
> >> --- a/odb.c
> >> +++ b/odb.c
> >> @@ -1,5 +1,3 @@
> >> -#define USE_THE_REPOSITORY_VARIABLE
> >> -
> >
> > Very satisfying! Thanks,
> 
> Yes, nice outcome.  I looked at the resulting odb.c and was a bit
> unhappy to see that we still need to pass "struct repository *"
> (instead of "struct object_database *") around.  But that is not
> because we assume we can get to an odb via repo, but primarily
> because repo has many things like config access and hash-algo that
> we rely on, so it is perfectly OK.
> 
> At some places, where we pass odb around, we can and do go from it
> to its repository (e.g. odb->repo->hash_algo), which was what I am
> expecting to see more of in the future.

Yup. Over time I very much have the intent to reduce the reliance on
`odb->repo` even further. Ideally, the object database should have all
info, or at least almost all of it, to function correctly.

Patrick
