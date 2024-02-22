Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EE12134F
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 08:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708590370; cv=none; b=PZoDI4eUUxBEKcAGTqGc0epB9+W4mwZ5LkE5yAzfa46EgfsjBjIxmtemjicbDAYb7/igCzKapqMJwjn6yXktrU42/xJRE6ymvXqzjCQuOTHNd+GbdkBqHxPqqFM1e3WGMRyI4PEyyy5fhLTlbDW2Ntj6z4czydTIOczATh6JZnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708590370; c=relaxed/simple;
	bh=fm51E6l7UFbBQ4fQU8GbvB59h7kasIuu4AXYQtODWwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D66PJeRxzT5j4ok3EaIqsK0BZE8OdX3KG4Bo4TOj3Cyhwu3ZP8k3KzAHHYKZUOzRTOFu6/0v0V5y5Ev2/l0bIHvIapL7AtRrN2/RRQCr9yStH8QGmQjK4QpaAH/hXym49gGJF6jvAWgRhLMCxIwEr8lYRWWdo9wRKEanttLgh9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SVcTVX5S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hU5IYWiE; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SVcTVX5S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hU5IYWiE"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 33FF811400D3;
	Thu, 22 Feb 2024 03:25:54 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 22 Feb 2024 03:25:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1708590354; x=1708676754; bh=ad0/phl8se
	nLyTP3yVkjUFKyRFLWQm7Aj6XnUTcPPbM=; b=SVcTVX5Se+Vc1aE8RR6HzIjx+p
	TChFrasWGJPRiJyR0N2cWULVt1xMXjQvp/kdyU6XLCZPW+5WSNxbo/jc+TXz39mO
	W15Y5ukciFjNscZZXlCjsy4D2X0bYavflOjvV50UycdqsfbciIQ6b+0/XYtU1ZFY
	3QK6C+XmlF7xhty/HM9c/P3sc2Z1aUL+3dOyAf+OO/mRvNc7gpcCXzyzLea7cliF
	+afNxH7fA0OxhLX5+7ZL9JQBmt4COf2utq60Mb1Rp4Q/6M7dlsoaR5AIH18ugFlW
	8PgMZICigHD+EiJlGB8KbK2/NmPse/Em3A6qHZbq25rsTNfv2hunjH939Rig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1708590354; x=1708676754; bh=ad0/phl8senLyTP3yVkjUFKyRFLW
	Qm7Aj6XnUTcPPbM=; b=hU5IYWiEPP/e6qqyBXc1xWtynRd8U6ahh9X/oG8mAuJJ
	2hWBcKyTp9RJxaOFh1XaVbXzGwIKwvgjzagheKOTF37FCHvPvS7xazxupMqeVBq9
	709RQB+47TwMbm9fFbhQApg0/dWdKXe2jmFVhJ0SoHd7WRANnjrjZYcMLBpwDURq
	SXYpdlzqxyOiNc15XAi6gNU0g6wyGiTlrS6Waw335V7TayYPshTCKuvjGxUKJibL
	fROvPSm/ag+FWPF1gYsOigjBDLJh9HzBwjLs9mmSDz+BWqUk7L2c8HJRKTYlSlQt
	zMClaM8wcobom4zKtjV4/f6pYb0qVCBJ96/41znERg==
X-ME-Sender: <xms:EgXXZagjgICuZXCeGFPBByfmXztPxc4cz_HHwGOAEHgzm334Oe-94g>
    <xme:EgXXZbA6bq34MbWPEHEliDOz3WpcJU-3cA7SfwTZRwbGcy53MEsELRex6TpQG9j0N
    5xw7h7YosjytxM6vA>
X-ME-Received: <xmr:EgXXZSF1SZIjPW1zZVqWE6CzUrILQlM0C1fMPMPr-gfTE2s7hmx_KfN-bsRsWYUbsm1dvDhwFDoOtQJFAp_8G_TsX_PHZJHLZFVaj0JiYFHLzqBt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrfeefgdduudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:EgXXZTTx0SWZYPlZlTK8lbFZc2s47Ft_ne0wjBlHuK8EmAF-2EdUbg>
    <xmx:EgXXZXwvTGmsXqhG0b2Yi6ZEtzcnUN4qaJUSl73UEEDtJVobwpehaA>
    <xmx:EgXXZR48UBfInwGeI7tD1IDrr0R01WHIMsN84ZXcFpUGqO4Ckebong>
    <xmx:EgXXZX_HrA4Youibty5-Bi5B9n_ReuFcPKTQ-J8RQ5_xQ1sPpzmHpw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 22 Feb 2024 03:25:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id d99d8944 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 22 Feb 2024 08:21:44 +0000 (UTC)
Date: Thu, 22 Feb 2024 09:25:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Karthik Nayak <karthik.188@gmail.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #07; Tue, 20)
Message-ID: <ZdcFDEg4Gl8YpCQi@tanuki>
References: <xmqqplwrqbd2.fsf@gitster.g>
 <CAOLa=ZQOtDgyWxmV+C9r_wfqo-KdJ5uqW4KwJKD8WdT9qM0t2Q@mail.gmail.com>
 <xmqqle7drcm5.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="vEwX8tn7rAaG2Rhh"
Content-Disposition: inline
In-Reply-To: <xmqqle7drcm5.fsf@gitster.g>


--vEwX8tn7rAaG2Rhh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 08:44:18AM -0800, Junio C Hamano wrote:
> Karthik Nayak <karthik.188@gmail.com> writes:
>=20
> >> * kn/for-all-refs (2024-02-12) 6 commits
> >>  - for-each-ref: add new option to include root refs
> >>  - ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
> >>  - refs: introduce `refs_for_each_include_root_refs()`
> >>  - refs: extract out `loose_fill_ref_dir_regular_file()`
> >>  - refs: introduce `is_pseudoref()` and `is_headref()`
> >>  - Merge branch 'ps/reftable-backend' into kn/for-all-refs
> >>  (this branch uses ps/reftable-backend.)
> >>
> >>  "git for-each-ref" filters its output with prefixes given from the
> >>  command line, but it did not honor an empty string to mean "pass
> >>  everything", which has been corrected.
> >>
> >>  Will merge to 'next'?
> >>  source: <20240211183923.131278-1-karthik.188@gmail.com>
> >
> > Let me know if there's something more I could do here.
>=20
> Hmph, I do not recall what the plan for this thing was.  Wasn't it
> ejected from 'next' so that its UI can be rethought?  Or did that
> happen already and what is in 'seen' already with a new UI?
>=20
> Thanks.

This version already has the updated UI with `--include-root-refs`.
There has been some discussion around whether we want to refactor the
refname checking interfaces so that we do not have to introduce the two
new helper functions `is_pseudoref()` and `is_headref()`. But that would
result in a lot of churn, and we thus agreed that it is fine to do that
in a follow up patch series.

I then forgot to have a look at the remaining patches. I can do that
today.

Patrick

--vEwX8tn7rAaG2Rhh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXXBQwACgkQVbJhu7ck
PpQ0DRAAmHpoiEoHtbZumFlUs0sbCjRq9vZrD2YEgwTFsvQs2JYZ+hpYQYe9V1N3
pMndyJgsLOGd++DgzsE9vBxS+AuGusKmgeHqDk9uHNpIS1aJNSCQZ8bGxsN+YlAU
lXOL/FzLYAN/8RZqYgIgMUGsJ2DDCpcXcJXRUufVkf46Sc/9lFEmrIzF8gouhWhw
WUgtH0oH8Gq0V4FLL/Pcr3TCol+GdO3EnCTgF9vF8nYgKoBXL2Rc5Nw+pWT8fUfU
/CV42EUl36umshvcJMELwz1y/30F0HCL720YmIzRJKw55bohAT+JslAIbW4g6sE3
Z26EN/sxfdXvVg57ngifvmLiuqy8/ts8uHis7RdsGY+yJqshXcQAzS42f41BbHzu
zyA2mmiQqDfD+C8wO+Y8SLoVlBopM+EZBPOwRj14zbZbJV7tpAsHf/k/o9UF9LA3
ID2hykMYdX3OkVXlbHLK/s9JJH6NfuEWMYeVfeSVZ2Fa2vCTVEQHu7Zqr6d6VVMA
98Tu5sHvKSsjp/EdN7SMjTnT9x630UwbT+hWBFyQpmPxJ+KEdL9uiXde37WGzfa1
ErC/0QE5YQfIjgS09J4GUiGTfJqfVObI33IEX39XYesou/lqH2NSWqzVIsCxif6A
SYx3ePeZXJlmjv+wQzT31FD0Vy/l5dp/mtFJavcEZS2XoFofCkk=
=Rgyi
-----END PGP SIGNATURE-----

--vEwX8tn7rAaG2Rhh--
