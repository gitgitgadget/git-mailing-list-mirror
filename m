Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33F4245948
	for <git@vger.kernel.org>; Mon,  6 May 2024 06:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714977893; cv=none; b=Zy4/GfgaelbwYR+7+eLBz0/c9f+wCi2H1hpzIit1J9+iz2Z8ekhfWeEJioxy/GNml+ptrZls/Us9FdKSgS6+1CzuyHbYGv9bf+P6BKS81OOAIaXXFe0pNk0Ah/6r+uwaj7Hlufd1hFqCU9jglL8htTqAa3BHZHidNrVMmH/jdWw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714977893; c=relaxed/simple;
	bh=2IMcyx7Sp78ZvB8Q/TrSyXPxu30jtlyvMreeNzxrUTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GqIlMuXwv4zv6+pm8FIx+ClcXZWDhLDk+oHVZeVfc5mv5KFuowBdAMjQORY4PSUiUMK5JCVXOB/0X5BEa66zk43gADb/tLar7uv95DZlFmltNWMQqyWkPk9HwZZXzIFS4pWincT4wdjDW+zHoNtRR0DBd6GiWnplHxgGoS1HiFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KJYFXuTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TIeYEgjM; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KJYFXuTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TIeYEgjM"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2E4B018000B6;
	Mon,  6 May 2024 02:44:50 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 06 May 2024 02:44:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1714977889; x=1715064289; bh=rsgglUx92Q
	972ijQP3kj6slbnLe5tsvx8Gx5CAiXGm0=; b=KJYFXuTRAglI2ZsBINFH4LOSCj
	Eu7LMxMQuY7K8igaNaxvtJ6bP5sM23ru5Dw9tjDbli7Uytm0LcPTsTIA9oJYKrAG
	gCz6T+ZCe9CpZHhBf+wOiX56xG/DtiKgBQd5q+fon4GyCF+XF9TtD0UmARXkc/i1
	+AAIzr9BYVd3wX2b3cyKIqYukHQWrL7kWNuImkOosYHVW4KpTUKoT/2lWr2CIQj5
	cRzviuFrkqYZJEO9Jedk6pnPct4e6Z9BXkp/FgI4oQ60toqWqqjqDSRL7jDBcbRd
	FD+SW0gOlnguKXk1I/l5sPftuOInkW4TrzP0zxWqN8fGvBrYdCcDyTiek2Kw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714977889; x=1715064289; bh=rsgglUx92Q972ijQP3kj6slbnLe5
	tsvx8Gx5CAiXGm0=; b=TIeYEgjM7fhsFYeoOY1Ggs++nGe7Mcv3jwiBpcluyoz5
	5ey2cPGm7knEC0s1eipUmqcoVf7CzPl0FlN5OEeNAPiYRHxSxczgLjpwNrfMUZdY
	fNWrk4y2BgrySabCXTxKZDvAKKaFb2fm47jw4je+WXh0y3vGIXVb4j1LIcoV60Ak
	XZsnu5mp4A9kCvD7rkvCv+alOpOMolu6jZhyeyDvKhQKXz2amiFs+PBDJAA9/vZF
	69esBZ6RXg8lf+HDf1ok7Wu7J+uVwe2ujODlSuEa7UxOUN/SYHq8oFcbBttLHcyG
	yV+shGirPorQZZ5ZehrJR8Tet1SatvMXqiQkWzcu3A==
X-ME-Sender: <xms:YXw4ZimOdF2PqiM6ol0P6fwxpmLwsX8ENtTv4Lll4kK7-7NGzKqohA>
    <xme:YXw4Zp15G2Y9YiOSadM3xORVhoAXlaY9QlXObo-dzS-KPBElX5H4NwVdBvU8zd94-
    0F7OmC28B7PtUyM1w>
X-ME-Received: <xmr:YXw4ZgouEmM8uB7TGiWufws2KOJrk5e8n0Nnykrafn8WAZaVibNN9JxDjc7YLaJtYXktrzXE1dZonBC2yaHFiZUsa01tM-HMpiLDTdupUlaUHaC0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvhedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:YXw4ZmkCNubc2LPJffM163bHHL7CjequvxjSseS3dXYIgb4pu98eEg>
    <xmx:YXw4Zg0hOQ5gxcBi8p1wJ22lL7jjZ6peMo-y2okcWpWBLM91hUrFTw>
    <xmx:YXw4Zttc56Bqw49d72sAN_fZjjJWSpJaSa4QZk-vam92jRATqmeuJQ>
    <xmx:YXw4ZsXccFb-ju7B4zbqiLsH1fz-h13TVdabu7WE9wjnl_3zJSxLIA>
    <xmx:YXw4ZtxizsbABllLB8PdQv3ZFC1WQHBdCyzIkHWpsg8kC0ngG3zjuuvh>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 May 2024 02:44:48 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3d382027 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 6 May 2024 06:44:42 +0000 (UTC)
Date: Mon, 6 May 2024 08:44:45 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
Subject: Re: [PATCH 0/5] refs: remove functions without ref store
Message-ID: <Zjh8XWwJKp_I1dwE@tanuki>
References: <cover.1714717057.git.ps@pks.im>
 <xmqqikzu95cf.fsf@gitster.g>
 <20240503173553.GC3631237@coredump.intra.peff.net>
 <xmqq7cga7nzo.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BkzE5/6sCRpCwmpI"
Content-Disposition: inline
In-Reply-To: <xmqq7cga7nzo.fsf@gitster.g>


--BkzE5/6sCRpCwmpI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 03, 2024 at 11:24:11AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
>=20
> > Though maybe an even more radical proposal: now that read_ref_full(),
> > etc, are gone, and we have only refs_read_ref_full(), could/should we
> > shorten the latter to drop the "refs_" prefix?
>=20
> I view it as a good longer-term goal.  But I also view it as an
> orthogonal issue to the transition.

Personally, I'd prefer to keep the `refs_` prefix. This may be personal
preference, but I find it way easier to reason about code when there are
prefixes for our functions that clearly indicate the subsystem they
belong to.

It's also in line with how other subsystems behave. Everything relating
to strbufs has a `strbuf_` prefix, attr-related code has `attr_` or
`git_attr_`, mem-pool has `mem_pool_`. So ref-related code having a
`ref_` prefix just feels natural to me.

> We need a smooth migration path for remaining callers of these older
> functions.  We could do the USE_THE_INDEX_MACROS like compatibility
> layer during transition period.

Wouldn't this be overengineered? We already have all the required
functions. So my take would be to drop the last patch for now, wait a
release cycle, and then remove it in the next one.

The only problem is that this allows in-flight patch series to introduce
_new_ callers. So we're basically working against a moving target in
that case. That is something that would be addressed by having something
like your proposed `USE_THE_INDEX_MACROS` macro. But honestly, I doubt
that it would be faster for any author of a patch series to figure out
that they now need to a define something compared to just adding the
`refs_` prefix to their functions.

Patrick

--BkzE5/6sCRpCwmpI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY4fFwACgkQVbJhu7ck
PpQyaA/+I/HMDLW+EeUNVx0+RDjNMiK2CUPv3tccFJW8jNw8EIZGgUi33mpxk2SN
L/1tmnCzmMjf/njD3R4LQnuhjzqaXf0WZkAvsB6riJyYuS/7CDQ5YUJP/MinY+5N
o5fsjumzdeM3OfKYIJXImAcAozasp5DvLCpOyWK0UpzSPPLykcCQAZqf5LlSAofk
iJzQj40nQ3Pn3GOlG2vCx+oyRzk3IOPcyWL+a/pzZ9i54MjTurcKsH8yeQGER89U
bP6cKV5NfvHCW4UNErU/siAJlUOU2CAlTDvRxEVQM68jGIMaPo6BShjACxDvQKNh
RkV66N2/tHJAu08EqEa3w6bULAA8sqWjnqV4NuriI3vyfrjiBgsFhfvqHlRwNe8x
TaTfgmTJ2bGSlNH9HtwABfTQENSU6/fa5mnw9lyYuiDLZy28iO6hRnslClTYkUnv
AhK+lYSlp/bfew4r28am/sZS3aD7XceZ8jsDWmWxJNBGrHI51PnQ5YNQKIljSkMo
ZYBelgAQihRwjLq9aA08+Pv2FMeMBYl+pSdltZf1EnoRl5fxeVm6e1GclqrkcJ34
8g/XV5Hw8QZtNVpRxffFbCC3UlzZLracN+YM5f/DE/A5HBZpbMaVpqx7WvH17skL
hcrSSQYhXaJZ00LA9gJEdfMJ/fp7uNVLmtrdl4fWF1+v9JGZYUY=
=d9Qn
-----END PGP SIGNATURE-----

--BkzE5/6sCRpCwmpI--
