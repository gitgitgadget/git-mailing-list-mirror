Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F4D4A93C
	for <git@vger.kernel.org>; Tue,  7 May 2024 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715055127; cv=none; b=fxiLjxyRf5huZ2yULr9pugkMiCQzrCBxJaAUEeXbQZypqqC+CSdYMzOgX6qdmjF9Kt9eZEFLehabJV+gsJGOVQPRMCbhGgHRwoD1izxj6LOiQkMSja7KCFEGm4+kmBWiB8ZP4s5jUkISxaXjve7OoWmf9Od10eb/RVdbT+boKOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715055127; c=relaxed/simple;
	bh=OJuLikrjeA9ymjvUyIZygpymH7BI//avVo2g2bX1S3U=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hNjgSUeHDLS6i6AMkKSBGoDpNw9EjmmZgIZyRlf86oh8eqNhzvKa4DDoEkucZruFs3cxzP1tCxK2eSP5OjFzNfX6JziSse7B94RM4yGJnAbelgLBaemS5xcydY4awtdJ/uclnddqjP6FMPl2vJx5ZXgTpgy0UTBiulN03FcBfs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cuezvTBg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=a59+XZD6; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cuezvTBg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="a59+XZD6"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 7F19711400E9;
	Tue,  7 May 2024 00:12:04 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 07 May 2024 00:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715055124; x=1715141524; bh=ieQvhXai50
	IiWQ/BqPN/KS7L7xs3N21RN6j/dlfj540=; b=cuezvTBg37jzV0py6Ue/KwjCqq
	I4m95aaBTwpVfT3xrO6wRPCvWuyMk8ZFRlVg6S2OTVycmc+YJqC73GVEq+e+wX5W
	bGBRLM1bmeeFxY9MXGmN7KW7MvuHEI6ZojzLwxJ2Tofv0s4EIjajzLopiVnvriv/
	jzxXOZ3xFOm8tef9H4S9WbOYVAqtTS2GYBmwKbpy9DmHzuQBxyHAYYlvNFy3oyTx
	7IuhYRskiGdRO/tuWSCgT4PcbESU6G+956MYgx2XG+WOL6MZbueJpEfw//8Y2Jbq
	EfkZGoXzSYgsYwItcX7IFPztygogNJ3CV72qia7Eg1wfa7S3vrQlOc3As3jg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715055124; x=1715141524; bh=ieQvhXai50IiWQ/BqPN/KS7L7xs3
	N21RN6j/dlfj540=; b=a59+XZD6/8yXC+MSHfV24zVYRAnU2nS9IhlolwBRJETo
	jwC4U+W0Qi5XezIiIMnhbPcMacpQsOqfg1QYbDIt/JGXmKCjTeBxOZmlXkxMG09S
	TKVUCkjHQIM3WrLziHZFJU/rRp8GUR3zfQ5EgcCNFEvnQtidACcNyWVIxfZnaSu7
	oJcpyxNrJPfL/ytlb/ptq5O2JrR22ty926sIw4VuEaVl7bOqUDb0l7NYMYN+SxBF
	7wOmBfkkEjuVh8e0M76p3se3kssCLRdXUQzbB+zXAGB79H8A0mDfymNDnGice5T/
	iBV13t1/Gb1TSdABXRLekMKcy0EX29assL9cXlCOyA==
X-ME-Sender: <xms:FKo5ZnKLNElNTYnpGYvIGHQJAdhqRlYSOmSqL5SpB7tW3TBZ37Rvtw>
    <xme:FKo5ZrLntRET632L6g1AX8GB2MdHC2z3T4uvj20g94xcSEYUXu4i7qjnNQMfRt27w
    UMSVI31T-S_VdiU1A>
X-ME-Received: <xmr:FKo5ZvvqFeRAzwflVSdgB--th3U4g8rrc11a5I-5gXZYY0z5dVU1eE5JwQx5RfdzG1aUC8Uz6jU-0TAwXn7cDDUJtxx6D4pbiB7UfUhv9QMxhACs0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvjedgjeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:FKo5Zgb7uVwpchl6s2vqIlPCj2TrtD-nu9GF1DCly4vO-0cKpZN8AA>
    <xmx:FKo5ZuYJg2zV-fxMGs2wOVlaSHkfKYK3GLyQNeQ1BdaYc9Gessuqbg>
    <xmx:FKo5ZkB3ngMnUzITE_PZKOaIODmGoAOi9RvvbwjEqftIyfbILSDmSg>
    <xmx:FKo5ZsbXOctploSIgNu_Ranq3XA7boSw5rzAwVnriAYHC65Yw17YAA>
    <xmx:FKo5ZtktE2Vmlv0CWwtMXT4Z7jnyo-7fWKoefnuoa_yFCacLB7kJP8Qm>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 7 May 2024 00:12:03 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 33172bf6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 7 May 2024 04:11:55 +0000 (UTC)
Date: Tue, 7 May 2024 06:12:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Subject: Re: [PATCH v3 5/5] gitlab-ci: add whitespace error check
Message-ID: <ZjmqEEB2gXU_nKHz@tanuki>
References: <20240502193840.105355-1-jltobler@gmail.com>
 <20240503172110.181326-1-jltobler@gmail.com>
 <20240503172110.181326-6-jltobler@gmail.com>
 <Zjh-3dCL2-MnV-PE@tanuki>
 <xmqqle4mzwp8.fsf@gitster.g>
 <xjp247ji6zjyacniodws6jbdms7tr7726h6spsn7jvx3axqd4a@k6xhzf4v5akc>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="DPGtQmHwGd4tlKtp"
Content-Disposition: inline
In-Reply-To: <xjp247ji6zjyacniodws6jbdms7tr7726h6spsn7jvx3axqd4a@k6xhzf4v5akc>


--DPGtQmHwGd4tlKtp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 06, 2024 at 02:21:52PM -0500, Justin Tobler wrote:
> On 24/05/06 10:17AM, Junio C Hamano wrote:
> > Patrick Steinhardt <ps@pks.im> writes:
> >=20
> > >> +check-whitespace:
> > >> +  image: ubuntu:latest
> > >> +  before_script:
> > >> +    - ./ci/install-dependencies.sh
> > >
> > > Do we actually need to install dependencies? I imagine all that's nee=
ded
> > > would be Git.
> > >
> > > Other than this question the patch series looks good to me, thanks!
> >=20
> > I am a bit puzzled.  Is the proposal to check our sources with a
> > pre-built Git (which by definition would be a bit older than what is
> > being tested)?
>=20
> The GitLab `check-whitespace` CI job only needs Git to run and uses
> `ci/install-dependencies.sh` to download a pre-built Git package via
> `apt-get` since `ubuntu:latest` is the container image used. The=20
> `ci/install-dependencies.sh` script also fetches a bunch of other=20
> dependencies which are not needed.=20
>=20
> I think Patrick is proposing, to further simplify, we avoid using
> `ci/install-dependencies.sh` and only fetch Git. Patrick please correct
> me if I misunderstand :)

I just wondered how GitHub Workflows manages without installing any
dependencies at all. Is Git already part of the default images? If so,
there is no need to install anything and we can just execute the script
directly, which saves some time.

If there is a need to install Git we could either just manually install
it in the `before_script` or leave it as-is. I don't mind it much either
way.

Patrick

--DPGtQmHwGd4tlKtp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmY5qg8ACgkQVbJhu7ck
PpQnHw/+J9zNnEROC7YUUSkvAmaqWjxnmvV3X3mcwG+JtIgclU5Jj5ryPZ6Mysed
Y1+kVR+goOe/c8TOrJOCL75bKRIvJdq42/3fRvDl6P/pbcx7eP8tN2pItPQG/oRu
G9kuSBq89u4g6VLDtE5gEOyirByFoBOUrRQqvB9OqUGkbx3H6kfUCs6DhwNTJU3e
D7JP8vMxtjCqlpKYvofQ+EfipZPhUTps+9ODrtmO7X8HqKNABIuJluXtOqASVBAR
TqsoF3YGCjw5K8q+7klezEENETtuCcpVSxH4gApnpBKa/qu5kCX0oupn9CuleA7D
49/mfova4SRZl8JHWIJ296LzBq3vSGUsW+I0umWjeKRMtVYcx48vPVO3nNXv1XuX
4x5yey8rH5fypSN9s2Ue2bfijAYXcmz5DT0OdwVmgc2+/trgMcyre2HhPVuo5Lko
yJpDQut+4jVVKiHUwPDLdaUknLcgdatVsbUSK2fxqMPXCEv7bg/TEaXGqaxXkpue
qNpkG8a2a2vTdQq7wjvHO/uHCC7x1mz7+h3Ir8IJxRQPgKemzsP1iRbXsnWKa60L
cE0/f0rU8R/4ko6kKwocDWdXDpnBSMZSY8kcNW02o01pUO999bVVPMHz1dKOxIMN
bycT5JXre80Tt+7REY5QspXhRVU45TA2AWyqLeLJ5fh2vUViLBA=
=NTAb
-----END PGP SIGNATURE-----

--DPGtQmHwGd4tlKtp--
