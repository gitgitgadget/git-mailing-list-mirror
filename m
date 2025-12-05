Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6705726F467
	for <git@vger.kernel.org>; Fri,  5 Dec 2025 12:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764937024; cv=none; b=d0HrO03LnOjZLIjiSsbfBodssG/U9JbJFutf5qkF9/gEyqF9MlTnxIb41IjkEmF6qfahIS6fNyDE9cXsogxpgwneZZ+Q9PjontkM49lIQPTTLhu5Id8yMTAZTP0Co25pBa721MkzRM3pC10Ed9Oow2FPMlpTOD2yHSjEQeulzp4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764937024; c=relaxed/simple;
	bh=zS5oJn4hydlQ7Dn6RDghwxHjhjyjFyI1PbgP7zqHLU8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tIAQnrSMlNs0qKD7Q/3yQgNzGQfek36+SZkkUwlO9nlw82p+UlizBrPXRNWUJFFdCSqbs5TkdJwa8he54FA0DcuJRbY6foNTzjHGe954ecGHN0tiQH+sYZwSBD1HB8HTJ2K8kB0NjY8SQNMFqsSTfTBQ4D/zEpw5cTWhrEsBihU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Ok54AWzr; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TU1w9jrw; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Ok54AWzr";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TU1w9jrw"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id E3257EC05A8;
	Fri,  5 Dec 2025 07:16:58 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Fri, 05 Dec 2025 07:16:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1764937018; x=1765023418; bh=Ja8lr02lgT
	UUB0EVYh3eu0POQnqjO9KzZ6nuPjfuIGw=; b=Ok54AWzrgqVdzx28+YuaY9FRaN
	mcWJJfBjoUYiGDkuoUUbTV1rj+Qs7zbdbaav1dt+6wR+nIVFFvJAh1VvFrafDUd1
	QDSxpl1hDI2VeJ+aRjgp59HbJCh6xtQPPL3CZnIqkv/iwi2USiJTbpGIKre1NRo4
	MbUjkIFybA9Ap7Sa7zsQPY+VvVZojVOIBpLt7AW0ZZ/PwfR+Geb4ECleMi9tgWWl
	Qb5k4R70NRfxgCrnyXc7SmYKRfNyTW4XjC/ddK11q77tcUdNfg2U4Jv81PVthMYv
	Ysjm0UBkDZ3rBygbDSJHyqbwHxLZxZ17+8cMn92AkOElBFs0rYmKAXnSlo7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1764937018; x=1765023418; bh=Ja8lr02lgTUUB0EVYh3eu0POQnqjO9KzZ6n
	uPjfuIGw=; b=TU1w9jrwopH7hfkyUc0ZmVhEBpq/osjeRZ/RDUyuEbBYqqUDL15
	qCdZczKGb9US5mkBZtzo3hlYpMoEMYJymxwrQzFqhxhDIz7UTSKsybAMYAlrBtqG
	8SzNDbGoRn6KE4bIUiEz/+AeUUAMKv3ZKNjXK8DbuQntP0hUw3BjmFQMG0iJ9xHv
	16qUJEnMtKuY9e0xoUSRlo6eThbUgkpGFP9Vu/GZA6utknAPA2J4+olwD/KepdEE
	rSzXXURnVWlqin5g5OsEVBri5nJgkb2Uq4TeP5fxiecADKX8otI69Rka21XP3I2F
	5+ztbobeBCNLevInPkszomJimMzC32j0LDQ==
X-ME-Sender: <xms:Os0yacyridfuync-SPzlXu-fzAxkMZZhaEklbXtoVtUq8wD37YKLkQ>
    <xme:Os0yaYd-eYCNBmN-qa3H90HWuejFk_Fx5pJC2iXFpI1HKs-2HWfYsilJagDQ05KRv
    vS3ULU3LCqSlB5i8_xIc67We7p7XzJ41X3EBebo072X6CPHnKN8AQ>
X-ME-Received: <xmr:Os0yaZ7rVhuscyAODaL2ObCmCx9lQ4PEYJJAzKDF1DlhqghN3I1WHpLLdUdsMg4fUzregf1vhR1mTsq_VozSYTWtZ_FOySYb8fWqhuvZzJM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdekfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    epfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepve
    ekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himhdpnhgspghrtghpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegvmhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnhdrrhgrthhi
    uhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesgh
    hmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumhhonhesghhoohhglhgvrdgtohhm
    pdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhope
    hphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhr
    nhhivgguvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprggrrhhonhesshgthhhrrg
    gsrdgtohhm
X-ME-Proxy: <xmx:Os0yaVLM0lf8joSZwRp3ny7EXNjwlE_xt8Ybtanzly3mtogkN2nmKQ>
    <xmx:Os0yaZzuODfAnNQgG-w5IKoy_uqfTTiw7z7W5m5wcPDRwTmsQpb5-g>
    <xmx:Os0yaVKTUuDWortnZsCE0OGvgYCNKyUZRsAII_GF1ObtfVGNT-3dFA>
    <xmx:Os0yaQWB525LPwjGnRB2cS0OzIsQ3yVgHl6MXHDZ8yRV77EnHKx2Pw>
    <xmx:Os0yaYgnLGP4N-k3TDvzIz1Oq3_bHNObyt-4cyl4yReDUQj7g0DDGqqe>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Dec 2025 07:16:56 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9ff6831 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 5 Dec 2025 12:16:55 +0000 (UTC)
Date: Fri, 5 Dec 2025 13:16:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Aaron Schrab <aaron@schrab.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v5 2/7] builtin/credential-store: move
 is_rfc3986_unreserved to url.[ch]
Message-ID: <aTLNLnF_ZLpMnso-@pks.im>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-1-adrian.ratiu@collabora.com>
 <20251119211030.2008441-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251119211030.2008441-3-adrian.ratiu@collabora.com>

On Wed, Nov 19, 2025 at 11:10:25PM +0200, Adrian Ratiu wrote:
> is_rfc3986_unreserved() was moved to credential-store.c and was made
> static by f89854362c (credential-store: move related functions to
> credential-store file, 2023-06-06) under a correct assumption, at the
> time, that it was the only place using it.
> 
> However now we need it to apply URL-encoding to submodule names when
> constructing gitdir paths, to avoid conflicts, so bring it back as a
> public function exposed via url.h, instead of the old helper path
> (strbuf), which has nothing to do with 3986 encoding/decoding anymore.
> 
> This function will be used by submodule.c in the next commit.

Nit: this statement isn't true anymore :)

> diff --git a/url.c b/url.c
> index 282b12495a..0fb1859b28 100644
> --- a/url.c
> +++ b/url.c
> @@ -3,6 +3,17 @@
>  #include "strbuf.h"
>  #include "url.h"
>  
> +/*
> + * The set of unreserved characters as per STD66 (RFC3986) is
> + * '[A-Za-z0-9-._~]'. These characters are safe to appear in URI
> + * components without percent-encoding.
> + */
> +int is_rfc3986_unreserved(char ch)
> +{
> +	return isalnum(ch) ||
> +		ch == '-' || ch == '_' || ch == '.' || ch == '~';
> +}
> +
>  int is_urlschemechar(int first_flag, int ch)
>  {
>  	/*

Nit: the function documentation should rather live in the header file.

Patrick
