Received: from wfhigh8-smtp.messagingengine.com (wfhigh8-smtp.messagingengine.com [64.147.123.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1402D1B59C
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 08:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541276; cv=none; b=FFFmUyMXdrLIoIlPxCy6KXG1pOQjIK7vBdDDqJJni/cWRIc2P2zkAlJYA8gcgu08Qxzf40HGbqdf93z1yer+jB9ZTflMwbF4uRlMps3p0t/Mq3A/oMfJ2f/YQJft3nr2pGYGX7SGeUgmXqfc+5w5ALw1WxfzKkYm9FvIVHa2diM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541276; c=relaxed/simple;
	bh=Cb6rHdUdv64jFaDoThBVfbLTZLk8ybH6m/+1z/Iv0k0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NJ2uP3Y6nWAzFb5VsI1/LbpOtND0yof3vRNDtm5JtwJvMabmL4/dC/49SecF9BlBX0oOLMzIEWgDa4tSVhUh5zErpK2TXExDhI282OPhR2+O1VRm4335BpMsDR0wu4SvkCqa1aE5D5MoRQ/8QzVTn+/TLaVgvA6CYtirWgZ1t/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=KfYmz+CN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bhwuCGdO; arc=none smtp.client-ip=64.147.123.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="KfYmz+CN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bhwuCGdO"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id 2EA7218000BB;
	Mon,  4 Mar 2024 03:34:34 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 04 Mar 2024 03:34:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709541273; x=1709627673; bh=4VmdQZ7VvC
	3x8bC6ekHfNfeAftDD9JsSiZRpYT/udA4=; b=KfYmz+CNveq1u4I+kx3Hf5uc8X
	tE6fSB7VaLeZQ0cyPIX/LbxFBgY49po96wWpAOZOJjBH9oo1jrOPag8mLcxPV4M3
	pAz7gb2j7W6U78IRKwkxH997XAPbqWctK93/y8rAz6sthMGS3JxYXCDYOY5egNl8
	vHrKZhNMGoeOl4nC7LPXK9IZXU3IuNu1S47IVReTSlXa9nGLYyDo27EPIMARwQTU
	DK2LuIz6NUOUg3+5o5fUB/ymKCK8ffHGbOjPXoCFkpLc+mmTyN2t6Cy/9pzVDVba
	g7KULg69UoH7/+KSfFe+i516qCGH1OFZDdD5JxMsfcWq7qUqYe4zcK1TUBUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709541273; x=1709627673; bh=4VmdQZ7VvC3x8bC6ekHfNfeAftDD
	9JsSiZRpYT/udA4=; b=bhwuCGdOM+NvqYv4sGIobMCbNIzrBWfT++H3w5Oy1tEv
	MJR/xzWf0V0TaKL3B0rfK7s6AF3+nEbWn2wvjCUWOnlSEI6Nkq1udkTB6TPkLB5j
	3nxScbZOwKX9DLq5P/gkwKJ0huKiQY0Yqtk30izIoAJy5AZFbKaLm2DiazWyPrmG
	DhhiQxB4k6awED58zRyThiz/cMdCCb6e36z1s53voFnbQzs+DXF51RC+EJB7q9Th
	wY9KNgzpMfNAv/kMDiRkIlB4CZ3IwzoxovPiSdUMu22IkXnGt6Jzu80UZmpAeuj+
	cDJjNFWYyC0QVn9624oUGbjJ8MRZ9W5dRFqCaNZWWg==
X-ME-Sender: <xms:mYflZbJFlPPYBNzhTp3PKRWHinmIQUKD1OUytkWI_BXYUYyYpLWTzw>
    <xme:mYflZfK0zdAUC-7h1QBGrFhUPWz-xyzVzXwV7T8vJLNMtsZlgELgZZZhXErERrXNB
    H3umU4M3-rb1xNSKQ>
X-ME-Received: <xmr:mYflZTvPn1p9Ps5F6Vtcl99hInHMGm0DA9N-sTk_MjSQOjFXBq1HKky9pvujTH3P10Sa6EPLwR2WMfA7cEnI2C0-jVMlKZ4fseUUwNkyhvjdIl8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigdduudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtroertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepkedvhefgteeiffetjeffkeekgfejjeduleetudevvdefteejuedvjeehkeeluddv
    necuffhomhgrihhnpehkvghrnhgvlhdrohhrghdphhhtthhpqdhsmhgrrhhtqdgtohhmmh
    honhdrshhhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:mYflZUaqgaO2ry0w5pnyKFarPOF94-p87rDFwTElbMqQ1DUSSbAIHw>
    <xmx:mYflZSYo_AUfEHYw2ml7DNuSD7GHtlUByFjfDVbvAa4N7RAQBEX46A>
    <xmx:mYflZYDYXZBTG9Sm0HMFsuhtO9nayVQAmV96i49ksBpcvcjc-gjWQg>
    <xmx:mYflZSHOuJVFpqWJpvUwDwXNZfWATc4MIbfCClS8Yf8TAGBzB4f81lh-4Sg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 03:34:32 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 066560af (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 08:30:07 +0000 (UTC)
Date: Mon, 4 Mar 2024 09:34:30 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Benjamin Flesch <benjaminflesch@icloud.com>
Subject: Re: [PATCH 6/9] upload-pack: disallow object-info capability by
 default
Message-ID: <ZeWHlknuWMvRiFtC@tanuki>
References: <20240228223700.GA1157826@coredump.intra.peff.net>
 <20240228223858.GF1158131@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="W3fFL69Ogcm/ANFP"
Content-Disposition: inline
In-Reply-To: <20240228223858.GF1158131@coredump.intra.peff.net>


--W3fFL69Ogcm/ANFP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:38:58PM -0500, Jeff King wrote:
> From: Taylor Blau <me@ttaylorr.com>
>=20
> We added an "object-info" capability to the v2 upload-pack protocol in
> a2ba162cda (object-info: support for retrieving object info,
> 2021-04-20). In the almost 3 years since, we have not added any
> client-side support, and it does not appear to exist in other
> implementations either (JGit understands the verb on the server side,
> but not on the client side).
>=20
> Since this largely unused code is accessible over the network by
> default, it increases the attack surface of upload-pack. I don't know of
> any particularly severe problem, but one issue is that because of the
> request/response nature of the v2 protocol, it will happily read an
> unbounded number of packets, adding each one to a string list (without
> regard to whether they are objects we know about, duplicates, etc).
>=20
> This may be something we want to improve in the long run, but in the
> short term it makes sense to disable the feature entirely. We'll add a
> config option as an escape hatch for anybody who wants to develop the
> feature further.
>=20
> A more gentle option would be to add the config option to let people
> disable it manually, but leave it enabled by default. But given that
> there's no client side support, that seems like the wrong balance with
> security.
>=20
> Disabling by default will slow adoption a bit once client-side support
> does become available (there were some patches[1] in 2022, but nothing
> got merged and there's been nothing since). But clients have to deal
> with older servers that do not understand the option anyway (and the
> capability system handles that), so it will just be a matter of servers
> flipping their config at that point (and hopefully once any unbounded
> allocations have been addressed).
>=20
> [jk: this is a patch that GitHub has been running for several years, but
>      rebased forward and with a new commit message for upstream]
>=20
> [1] https://lore.kernel.org/git/20220208231911.725273-1-calvinwan@google.=
com/
>=20
> Signed-off-by: Taylor Blau <me@ttaylorr.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/config/transfer.txt |  4 ++++
>  serve.c                           | 14 +++++++++++++-
>  t/t5555-http-smart-common.sh      |  1 -
>  t/t5701-git-serve.sh              | 24 +++++++++++++++++++++++-
>  4 files changed, 40 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/config/transfer.txt b/Documentation/config/tra=
nsfer.txt
> index a9cbdb88a1..f1ce50f4a6 100644
> --- a/Documentation/config/transfer.txt
> +++ b/Documentation/config/transfer.txt
> @@ -121,3 +121,7 @@ transfer.bundleURI::
>  	information from the remote server (if advertised) and download
>  	bundles before continuing the clone through the Git protocol.
>  	Defaults to `false`.
> +
> +transfer.advertiseObjectInfo::
> +	When `true`, the `object-info` capability is advertised by
> +	servers. Defaults to false.
> diff --git a/serve.c b/serve.c
> index a1d71134d4..aa651b73e9 100644
> --- a/serve.c
> +++ b/serve.c
> @@ -12,6 +12,7 @@
>  #include "trace2.h"
> =20
>  static int advertise_sid =3D -1;
> +static int advertise_object_info =3D -1;
>  static int client_hash_algo =3D GIT_HASH_SHA1;
> =20
>  static int always_advertise(struct repository *r UNUSED,
> @@ -67,6 +68,17 @@ static void session_id_receive(struct repository *r UN=
USED,
>  	trace2_data_string("transfer", NULL, "client-sid", client_sid);
>  }
> =20
> +static int object_info_advertise(struct repository *r, struct strbuf *va=
lue UNUSED)
> +{
> +	if (advertise_object_info =3D=3D -1 &&
> +	    repo_config_get_bool(r, "transfer.advertiseobjectinfo",
> +				 &advertise_object_info)) {
> +		/* disabled by default */
> +		advertise_object_info =3D 0;
> +	}
> +	return advertise_object_info;
> +}
> +
>  struct protocol_capability {
>  	/*
>  	 * The name of the capability.  The server uses this name when
> @@ -135,7 +147,7 @@ static struct protocol_capability capabilities[] =3D {
>  	},
>  	{
>  		.name =3D "object-info",
> -		.advertise =3D always_advertise,
> +		.advertise =3D object_info_advertise,
>  		.command =3D cap_object_info,
>  	},
>  	{
> diff --git a/t/t5555-http-smart-common.sh b/t/t5555-http-smart-common.sh
> index b1cfe8b7db..3dcb3340a3 100755
> --- a/t/t5555-http-smart-common.sh
> +++ b/t/t5555-http-smart-common.sh
> @@ -131,7 +131,6 @@ test_expect_success 'git upload-pack --advertise-refs=
: v2' '
>  	fetch=3Dshallow wait-for-done
>  	server-option
>  	object-format=3D$(test_oid algo)
> -	object-info
>  	0000
>  	EOF
> =20
> diff --git a/t/t5701-git-serve.sh b/t/t5701-git-serve.sh
> index 3591bc2417..c48830de8f 100755
> --- a/t/t5701-git-serve.sh
> +++ b/t/t5701-git-serve.sh
> @@ -20,7 +20,6 @@ test_expect_success 'test capability advertisement' '
>  	fetch=3Dshallow wait-for-done
>  	server-option
>  	object-format=3D$(test_oid algo)
> -	object-info
>  	EOF
>  	cat >expect.trailer <<-EOF &&
>  	0000
> @@ -323,6 +322,8 @@ test_expect_success 'unexpected lines are not allowed=
 in fetch request' '
>  # Test the basics of object-info
>  #
>  test_expect_success 'basics of object-info' '
> +	test_config transfer.advertiseObjectInfo true &&
> +
>  	test-tool pkt-line pack >in <<-EOF &&
>  	command=3Dobject-info
>  	object-format=3D$(test_oid algo)
> @@ -380,4 +381,25 @@ test_expect_success 'basics of bundle-uri: dies if n=
ot enabled' '
>  	test_must_be_empty out
>  '
> =20
> +test_expect_success 'object-info missing from capabilities when disabled=
' '
> +	test_config transfer.advertiseObjectInfo false &&
> +
> +	GIT_TEST_SIDEBAND_ALL=3D0 test-tool serve-v2 \
> +		--advertise-capabilities >out &&
> +	test-tool pkt-line unpack <out >actual &&
> +
> +	! grep object.info actual
> +'

Is it intentional that you grep for "object.info" instead of
"object-info"?

Patrick

> +test_expect_success 'object-info commands rejected when disabled' '
> +	test_config transfer.advertiseObjectInfo false &&
> +
> +	test-tool pkt-line pack >in <<-EOF &&
> +	command=3Dobject-info
> +	EOF
> +
> +	test_must_fail test-tool serve-v2 --stateless-rpc <in 2>err &&
> +	grep invalid.command err
> +'
> +
>  test_done
> --=20
> 2.44.0.rc2.424.gbdbf4d014b
>=20
>=20

--W3fFL69Ogcm/ANFP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlh5UACgkQVbJhu7ck
PpREExAAnyMhCRFXnfCqjuGnKDKdfgcJc51Go1EmehOV/gsPOpWyqTqiryh9RP4J
9nSTuH5Ekm7plgbbfLbZmcnU6Qa9TY43cj/OjPdsOCJS5rOK2ZvAPcc+LZlIjvdr
KVHu1k/45yPrMGhbbfdOsJhO6d68tlxlj762ymc9+LjzveMIsrEeDUP9N7uVfKgd
tQUsxjzTHwq1EGlYn1iRaAMKZYXtL4CvNVgqcJae+YQodma3J6rM4Oy3lxczHOKO
fCm8jJBTsRPUgVgSKKalLK0v1yZildewQ7PgIqtin50VtxC26gxnlSTgqPxoGvLa
uUH3ozwR8B+PSY2VEnsE9woXG8/Ndd8dnFBm+5ygaOBnUqrFXkvB3ndWQ5NQxqg6
nRlvTFxzfH+783uVhSNh/wDgcFOGHGwcCUcgERQU83f2BV78mLoTkzMAPMPOJZbq
0LGWCSFt6Al/GUpzw//j6RlpaS3mBzn77pRHtItw4qiBVsxsVK4by8alHxE0N76P
ha4l0yCZqsrV2cOfY1hzGqVp2tWb4z2LEM1+77N16MAHYfcA0N3WniuWfQBg55uG
J4XJfvdhsAkVumamUhNkcBNLlba5hs7PKA5ckhJl04Lo/RrLMJGr09C0RFigYVr2
rmP3tqXsmHZPx+CVo67ueRhkx4BgwQaDc7APMrsHTvPkwejn+bg=
=k+ow
-----END PGP SIGNATURE-----

--W3fFL69Ogcm/ANFP--
