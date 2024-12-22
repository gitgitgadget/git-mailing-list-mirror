Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89E7F1F95E
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 02:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734834640; cv=none; b=T7/d4WiTOU9B4i4VYla+4/ZDU30mgeJI+2MIQbdk78aqIwcg5UeRbXWdgdf7GqlmD8qV8lqCl5lUDGAHqnUN1A2CtY5Dg5ZDmuH/y54fECsabBuG91t6fnB3w/6dGQZyoC5r9t7jhlEGWRRJw+ZNphC9WaEDFhdAp05OiK21ljA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734834640; c=relaxed/simple;
	bh=HgqjiLhGJeRyUr21STU+luXzHUnUEHaN589puNgpM2M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qu2DgzoGOUMNWVkYNEfqYzY4tZYUg6HT/dm2dYzRnN2K1FjxcjoCnJW22wiJ29UILpt42O7Lim9VSo6SY9yvGEAKAZC4HlzKvgl0wVUisJXRWTRz4ciZAu0HNDO1r0MAIk0bNTTofEki4hYsoXu5Xx9PWqkXP4rNuHVvpfl+OaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=js/B1VCn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gggazo4n; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="js/B1VCn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gggazo4n"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 866CC25400CC;
	Sat, 21 Dec 2024 21:30:36 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Sat, 21 Dec 2024 21:30:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734834636; x=1734921036; bh=/97QSpx+Y9
	N/MDAxjWTjQZwNdoO9X/9QUaDCuu3E9c8=; b=js/B1VCndTz4OfdszkxiLEA6uF
	yGfP7JG9QCgH0tjtgTivZjv50RGcaUwcAh04CPpmRnYcWr9dvx49Feg8FK2cadkH
	uX0mz6uTCUTGsTABu+uNpzx7+VL7HxpImbbalb0c5WYAQvRSLNk53hpSOw2z8oxF
	ePC437FakZMgMfoIcy4xqBDmF+BO0b2wHrdAmSPx5Eot4b/vRvuhwPQ2BDP2ieFn
	x+HPEpi6zfUAeP20saQAlw41Ah/gtZvKrDguneXnPwu9NEdrnMsmIl+/SQEkqNl+
	56sO3j2d6dndedy6VLCG5cSpTJlNqXkbL7eVKEtr/M4ft425XijoYtrfW0rg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1734834636; x=1734921036; bh=/97QSpx+Y9N/MDAxjWTjQZwNdoO9X/9QUaD
	Cuu3E9c8=; b=Gggazo4n4O3yGtL9MIhxx8YdYEApybcSYDb4E4RyoyT9WcUWQrF
	plqBcwjMFRC64pFy/hurxuccte5wBfsDJDVJrgaFVb/gnlz8+KuZviJj3N6MRl3y
	PySytLqK7Y34caM7T3HP/Vygh+cJtiMqPH+fzbr9wgPkMEinej8iVzj5j+v9Xg3i
	R6vgWb0XJPowxFXMV6ijZ/wjDbEHyBd6ErmH/kc+aGYpDHbwUnqodhr5xzcst+V4
	2FuqvgeJdxiyHMyvrNNc7Xyhu75XtIcnxb8YvFD6KaTMWAHOMh2vzlT1TrnT29yA
	QIEDrALSdsFf/S5MGlkZyTX1EDS1BEqsOXw==
X-ME-Sender: <xms:zHlnZ_KNg_jHqLQ3MbPjVbfZEfcTaDfDlFn8tUo1IWEIgObt0Z4ALQ>
    <xme:zHlnZzL4mAD-3MMyhuQUoGViEDRqtsZ-JuUWx3lXPKR_Dq_TZS5QwSQB3Q0MRZV6K
    mFqIn2FuxvpZY6woA>
X-ME-Received: <xmr:zHlnZ3vxltHxcaPMm5VA_GqF6-ImlWvRnWuImEJaEAfs0OXLaEopHFNVpnCOV8K_UGid7lvilWFUpfz1dFdLF8wCIPeSn_stUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtiedggeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefve
    etteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrse
    hpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdp
    rhgtphhtthhopehprhholhhoghhitgesshhhohhrthgtihhrtghuihhtrdhnvghtrdgruh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:zHlnZ4a_gGZ0Gfxxtl5cYEsH3DbsClTSpX7jswb96TyEvQynjWFN1g>
    <xmx:zHlnZ2a0r1AFTbZkSenni1Bmt5_ctP7gUefamj9i7kbf_OaAkr4EIw>
    <xmx:zHlnZ8AP0nnRyk3sDigWoorirIyVAK3DacXbitEfYhYRhYQhi1lYbw>
    <xmx:zHlnZ0bGNBDd7x5ZHzkXvm5e8FyMs07rK4srrCm934CQCFzvg0Wf6A>
    <xmx:zHlnZ2GtRJhFQwa_ORPVXffgfA3_8N6d0KIfWPkQ4mkUGqpsKQZXYDTl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 21:30:35 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: James Mills <prologic@shortcircuit.net.au>
Cc: git@vger.kernel.org
Subject: Re: Git v2.46.0 and --allow-multiple-definition linker flag
In-Reply-To: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
	(James Mills's message of "Sun, 22 Dec 2024 09:23:19 +1000")
References: <CALGqR9+bH3nMrGqPQ18aqs-epSHRFQOtnd6Da55=KrtSu+Jrkg@mail.gmail.com>
Date: Sat, 21 Dec 2024 18:30:33 -0800
Message-ID: <xmqqbjx4bgae.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

James Mills <prologic@shortcircuit.net.au> writes:

> tcc: error: unsupported linker option '--allow-multiple-definition'
>
> I bisected the Git releases and traced the introduction of this new
> flag to v2.46.0
>
> I can't find any details of this flag really or when this was
> introduced in the GNU binutils and so far I haven't asked if the Tiny
> C devs intend to support this option (yet).

Would

    $ make LINK_FUZZ_PROGRAMS=""

help?

The platform-specific tweak defined in config.mak.uname file assumes
that you have glibc plus gcc or clang with usual binutils niceties
once you claim that you are Linux.  It lumps all different variants
of Linux into a single ball of wax and defines LINK_FUZZ_PROGRAMS
Makefile macro, which is a bit unfortunate.


