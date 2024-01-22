Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E9D47F61
	for <git@vger.kernel.org>; Mon, 22 Jan 2024 11:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705923081; cv=none; b=YrnXQ4dCezIiPSDhLJoyAfkv+bNRfHogmbZ2RYutmFQ2A0lCruavyACE9OwgzTaMr3FjvQ0HAdk5LjCSdiWUkExp25XJPkAKypBjqIdn3dHhT2SGhD2y3w/L6GwRTlLE8Q60adiWbFm5eL9qBP5tCdqdbk508eHUwX4KQ4zL4GM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705923081; c=relaxed/simple;
	bh=uPtBuermHCnK/AW7EGlEO1Bz9A1HVW3cRkliff7pqxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R8WbvCPO9RFoc58Orwvif2MhM/+CfzgPZHkKywZUAmPqH3cMeH5zA/qQfUI6dsri5tgSvfhpSpiQGMszIWnqvUvhECYz8H142Pn5jR6mKNN3gYffz0V405Tw6ZH/L1lYkTj6RPzYILN6EpYV/k3YFiOzC7rNAWAJUQABqcNz/YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iw+4I79p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gyVu0gpo; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iw+4I79p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gyVu0gpo"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.west.internal (Postfix) with ESMTP id CFE7D3200A57;
	Mon, 22 Jan 2024 06:31:17 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 22 Jan 2024 06:31:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1705923077; x=1706009477; bh=M5fDJOkqOY
	g/QSVcGqAPzUZO+DhEmeU81VbdUgRxMaY=; b=iw+4I79pp8cV0IV0BeldGAkdb+
	bOH+opLiLLQdhCxKzVnuC/IRroUjx8QpzYWDUgHVl4f0Me7q/mcMrq4hMwO7T1vF
	G3H80wF4JKu7fL0KIhoF74FY8iH3mYWWI0iHhNBHWj16MV8OqsKn0dqU6G//lkVK
	AY5qX/ScQp9cjiA8VheiYQi5EjBWPRbaaR9Jt+/AIO7eHCUdRfSBFCLmiIJRodlS
	fduEbIkXIy8az9mfe7k495GkdYocpuLrkA6OKXBxv+dDefbRu1X8Z8J1QwK0zQ1a
	LjnVi+IUS96F2nv6sq5t4Q8fivCuZPtWu5jG84GMmGDefYJKPBeQNl2NW/qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1705923077; x=1706009477; bh=M5fDJOkqOYg/QSVcGqAPzUZO+DhE
	meU81VbdUgRxMaY=; b=gyVu0gpokPzTpsCjDav1OLGvq1mHUBtx0/wN0qgJe2G0
	3nvoJKBBEMl9nEcCfbhUpctl307CtWqqEWT/plrrqNGaLmC75Kl5qcE3fHO57LnP
	CMc/xtNduiarZQoNPd+g/iV3hXYYDwvyBdYObO5SS23n73hiw3fHQf+/vB4sCP7x
	ru31ZL/IluHDF0gR7aEBIPSyePYKTJXuWRJvMeVR/5EsLQRDl9n8oIN6CqE3OHHB
	6rPVMNx9kfB0fACGoGZJuhleUotqk7lsk7Jjv63OeacUJcFgqh7V4/MFCuO5aQ3g
	0+gUeWrlR5V1o5sLP8NgFawqc31U7GFph/+mf8CYCg==
X-ME-Sender: <xms:BVKuZfnr9XO3akQXnkaicADyITOVf4bXNHZDXtQ1U_YiYdjyZQNAUw>
    <xme:BVKuZS1LORHhWzSv3eZuIGG5oV91oPU5a640C8jymCr4HzgEy53GWIOpxOe5onBW-
    1EWDhlJviGqhJmZMQ>
X-ME-Received: <xmr:BVKuZVrIyxk-F-C8MsqzfuLW6HsJpPKp_CJY8MWWV6lj2iaDg0y10Uiphw4H8_HmoqwzmLZ9m0REwav6U_7cE6HkM4jN7kmgzetHwumbrpd6St0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdekiedgvdejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:BVKuZXmWoBXyc08t6tV1phV9yn2LYlcowXmWUcOuhRbCBjhQ4Hurzw>
    <xmx:BVKuZd2LYF6cKqrIUbtAiCAv5MKQOxwWV0b5b8dL1_f02BMI-KCbRw>
    <xmx:BVKuZWu3ZgNcLOgSJvnH7YvZscrh3b7Shw1lS6leABxMveeNnSSAYw>
    <xmx:BVKuZe-X_Ih0NmG3oR1WoQdSGj9xVOKxVM5WyLSeEk-vC5lJclEbQA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Jan 2024 06:31:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 73e40aa2 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 22 Jan 2024 11:28:14 +0000 (UTC)
Date: Mon, 22 Jan 2024 12:31:14 +0100
From: Patrick Steinhardt <ps@pks.im>
To: John Cai via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 04/12] t1404: move reffiles specific tests to t0600
Message-ID: <Za5SAovUdWCdsNaN@tanuki>
References: <pull.1647.git.git.1705521155.gitgitgadget@gmail.com>
 <pull.1647.v2.git.git.1705695540.gitgitgadget@gmail.com>
 <c3f0b81200cb9199de96737745345ad93061a8d0.1705695540.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hc88vsMbg4fc8bmr"
Content-Disposition: inline
In-Reply-To: <c3f0b81200cb9199de96737745345ad93061a8d0.1705695540.git.gitgitgadget@gmail.com>


--hc88vsMbg4fc8bmr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 19, 2024 at 08:18:52PM +0000, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
>=20
> These tests modify loose refs manually and are specific to the reffiles
> backend. Move these to t0600 to be part of a test suite of reffiles
> specific tests.
>=20
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  t/t0600-reffiles-backend.sh  | 263 +++++++++++++++++++++++++++++++++++
>  t/t1404-update-ref-errors.sh | 237 -------------------------------
>  2 files changed, 263 insertions(+), 237 deletions(-)
>  create mode 100755 t/t0600-reffiles-backend.sh
>=20
> diff --git a/t/t0600-reffiles-backend.sh b/t/t0600-reffiles-backend.sh
> new file mode 100755
> index 00000000000..2f910bd76ad
> --- /dev/null
> +++ b/t/t0600-reffiles-backend.sh
> @@ -0,0 +1,263 @@
> +#!/bin/sh
> +
> +test_description=3D'Test reffiles backend'
> +
> +GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=3Dmain
> +export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
> +
> +TEST_PASSES_SANITIZE_LEAK=3Dtrue
> +. ./test-lib.sh
> +
> +if ! test_have_prereq REFFILES
> +	then
> +		skip_all=3D'skipping reffiles specific tests'
> +		test_done
> +fi

Same issue here, indentation is off.

Patrick

--hc88vsMbg4fc8bmr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmWuUgEACgkQVbJhu7ck
PpROaQ//fshfYKsspfj/hq5sLK9eU0GMKOnGoZh3lL+fTpvckvRMziSG7SpCdpGH
LWmoD4lAmcRnnYjEzD/O4OkPOUMKP7vRAbxpd+sFnbCEopu5EBHpIiZBpIapOJ1s
5bUgPcHqKPkagbTto4lZfRjCVa/JWWqqqQEW9XfYjF1LEcLP4YbUFSk7gI94+nW6
xzrplCSkBp4zo2K/Q7pHRCIKNjPNH9R6WJrN34wBvfZ68yH8Mv+EZnDcjR2KB9TK
5fif0f8Mri0sgVWNhGyJw6qagC18ZK3Ej++Sg41IF2t6t6xUO6MwctvzcvnqqLcH
3j7I58xNXCuwNCs2MLgOmM0GGbim/S1JHF5XL3RSiiLzKkFllwv2CM3b5hay3BnF
gZTUSYKcuWWqd09f00/qTi3PucG3yt38XD98tuI5xKb0+eaU5sNVz5XDkkwXpSmf
eF3S2gD/FdJiRKoOvmHyVAW1RzYttRMq+B/2mVEafKW4rWSpA3sb5prqsBDthi8V
t/imJn0JJtE9KypVpuIY5SdtDetM/B2KScaFJid0nnADo7UVoy/VSocL+SnvFn29
8nJwshSqOTlWD4Y3GSBVRugtIMHC8/T3OaAYQsYw0QEtJIbfwU21T8gmcrmhPQmp
a03sUbk+jtJIj36RktdB6vxIB4DyhePE4Q8iPpsc3Pgl93s/85A=
=Ky7M
-----END PGP SIGNATURE-----

--hc88vsMbg4fc8bmr--
