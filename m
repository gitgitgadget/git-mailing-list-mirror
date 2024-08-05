Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755A6158DC0
	for <git@vger.kernel.org>; Mon,  5 Aug 2024 12:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722862720; cv=none; b=GO8cs15pRTgmcCuCzRJXVzN6dTozbhkQSltu1wePtth580gxgEJNp6FUJIfSSpa3XDSVxygtBr9nk9lI67LQxmLsA6z17PK20zUP0kg8uUJjTeS1DbrWZZ5+DR7r9HUeVsZ9jZiD+ykMrODcy/GfyQTqXnSRZ2Mw4sxjLUslen8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722862720; c=relaxed/simple;
	bh=urBajA5Ui25/ZXnOsSwOnR8z0CU9LciiAKFJ5alDRA0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qVbXv6lGeh2QO5zfOt8OQqQmX6huN+J9uJ+cDtk/KK73gYVNKzs9eEShIsdugP3hc8/0CNbFt6lCPvl4xPWJuVL7Cfb8qmJTTWP2hh8HnZeBzBOjP5uMPsedM4QMwnRgBazKE5w+UQNzyWnvttyzHMDjWrzpECK98pCB9/TF/TY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OcCjw98R; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kk3U82sK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OcCjw98R";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kk3U82sK"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 6EB0F1151B76;
	Mon,  5 Aug 2024 08:58:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 05 Aug 2024 08:58:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722862718; x=1722949118; bh=JxlndK32ld
	bezHnQ9OomGrhSLIYpEgkGXUoBXN3vrXA=; b=OcCjw98RtGv4zDY71gRyqTia9J
	dJGTpoalS8Kc79jwLb6XumZpbnhsFWxyPXKo2x3xiqrBqKb8dLJ1oMiSH0Nsyns1
	g5qgblNJZlW8oYtR+bOwztZ5Cxa4uQHwokhuzLVl0wN09TA5V8DiP9c9MznJjP6H
	V+Xo9jYSCLFJMr3k78f5QhSpy3Ej6wmX7yFv8yKj4nt5wmRUO8/RuaQWCp3YNYZg
	l62CXMvH99KoagTZavaNnxVLeabV57L7YbSjKSz9QY5VEeDuHswdbFAse1y0RWWo
	GIegS5nFQkutFI/6m1UE4S6ZNT18P6zuYmabQHoua9jy1pYrq+TAH6tAaU1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722862718; x=1722949118; bh=JxlndK32ldbezHnQ9OomGrhSLIYp
	EgkGXUoBXN3vrXA=; b=kk3U82sKjU/0DyK5DnAC9gO5a6qx2M3slG2Xe/S2AIyr
	aOAYdfEhQc0Vy71KBOfXndLC0v5CkYhvMtzi+43fO4Y8OFgGvcPN/fZx2caljLLm
	Wgdov5b8/+5iCDHBuD0x6d2OyX7I4vuLY3bbYZRfTSukiNG5xUbPVbSuKm7B7dar
	xpT+TSCNrkNviKJRTF+3LY9ROzk0MtCHfHlPVwS/D5BNK6nQeILHe5MwWW0VtgMT
	BoTAU4U5KYiqkUgSvhdcIxyKBp8Szvh3/0AxVqjv5p99NtNKhPHZjKiOvCgUeimh
	LWaPRG3sose1WO9hVxzz+dn/sFtW1ApOduaVm85CUA==
X-ME-Sender: <xms:fsywZsvd4NPFnE1qKDD86hYR8Dit9ykL5-adsD3z7gbduT3gL3rEDw>
    <xme:fsywZpftHAc_5OswBfTXwyX1Ch1spIt1mb2MJsSDuP9r2YEUXqfdpMAQzHxjZKMDk
    bBRz6CuhSj-ayRUsg>
X-ME-Received: <xmr:fsywZnwrW_VvL8UIhK3KG3ekMTqkqPwEIR-vS2Gz9azkNT0vw55R1w72wKAINpvnZvff2L8oVOgsSGKaynRXS1ubnXd5VUWL2csQivbtPDGGUWMlrA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrkeeigdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:fsywZvNXFkShkewZ9Djt0UTLnq9FkDfJhemaO1Y8aO0IxmbMwqj4mw>
    <xmx:fsywZs-IzxqejXua9VKDyYYR3QAjCRiz3X15J6xKASI_6hBQ6Pv7ew>
    <xmx:fsywZnXWAQHNjr8GThIxSScQrIu4i3S7eJBUnMAA8MUQnuZ_E0in3g>
    <xmx:fsywZlf_7rCjZCAFnMUQxp7WqkcMPCzNmavAYPc7-UPHMut6PGPH5A>
    <xmx:fsywZsxLPdkQ3t47fwBDP76dVa0gfxaWHkGg7tQS0MqM5K4Dp7fwfLz_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Aug 2024 08:58:37 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9c8a8f9b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Aug 2024 12:58:36 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:58:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: Re: [GSoC][PATCH v14 10/11] files-backend: add unified interface for
 refs scanning
Message-ID: <ZrDMeumizT-xKLrF@tanuki>
References: <ZqulmWVBaeyP4blf@ArchLinux>
 <ZqumgrIo7pJ--reA@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cAOAHiw19DrybVYL"
Content-Disposition: inline
In-Reply-To: <ZqumgrIo7pJ--reA@ArchLinux>


--cAOAHiw19DrybVYL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 01, 2024 at 11:15:14PM +0800, shejialuo wrote:
> +static int files_fsck_refs(struct ref_store *ref_store,
> +			   struct fsck_options *o)
> +{
> +	files_fsck_refs_fn fsck_refs_fn[]= {
> +		NULL,
> +	};
> +
> +	if (o->verbose)
> +		fprintf_ln(stderr, "Checking references consistency");

This string should be marked for translation.

Patrick

--cAOAHiw19DrybVYL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmawzHkACgkQVbJhu7ck
PpRk4Q//dTPce0DmPHzjPY99p/EEqZ6CFPZpIodHEaXibFnh/wrtSrB6Dpj68EMM
mLqpvofvbhvg3CNBqjPfpJwpSuh4oda9oz6p9PPV4UnHHU6XQQfBP7md/qfZ/R3s
bm23YmcKdvtZyk0btYg8HpZMU5f0XyRqlqC6tOF9I0/hU2s5SwFmm/0upCdZAukf
LVrqQf+GAVfGK95rQqS/lhf5oJHYxteVBRY3rDvfBKktb6V8yT/MB1Ijtcu3RMfY
mZ2iGJ9zf39Za7XbUACn4tY4e1v9QcrC2SviEl79tFfaAkLQbXP/QAc0rIr9oS/5
rvakWgbr+B7FOIjH4D+uMYTzOjy9ELbjHJda7cBylWbAiRfT0By/HHEIIX0J4Bf/
nBz3xcTEQRrUdh1+UWPkOXDnTRyqV78AfsQPhjcpH7UEbIumogVXEKFvYwJXqWph
yHz48u4cAsGS7bnNN89Gf7HKE4ohlyQbx/jpv+thqTh7XT6cJdfZk/K+qY5qMgC1
4kUih4jzIPgAT7N/9A3o/lA5mLbLDALSGi/j6HitRw6ciZVjD/VrPjyFYkejs/+i
3gf4ccWf7JV0MWvjRB653kHIY0ygBOW81EVWQYAXZe/1uthcGNvxREHFQlvF2bA1
EsAzHIjeXvv00ig8a5/IOeyiIrM8q4ODiqjVFLyDJaaOjvY8WoE=
=2nxq
-----END PGP SIGNATURE-----

--cAOAHiw19DrybVYL--
