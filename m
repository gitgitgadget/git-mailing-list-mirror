Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7649E15AE0
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709538308; cv=none; b=ZbT1b9kbytaS/m689kC/yA5GyrBWKb2GnuM/Ma26IkISrrubKnjheuEBl6bjhPDwhXnnioSYWZtT5CE3MQNYXDWtvXJVjIylaSGI4PJNoO0cIh5Bvfoi9KL4OvHpX2l8SfgRyXiPxIaNcJSUEu68NmTUzpyyVuLImIDjqmwAhAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709538308; c=relaxed/simple;
	bh=Z54KN40SY5MMSzoM0oCpT1/2LGjpPAiIYnVWtm8u2EY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHZyWSYZlH+tV/IxuAxdiWepcF934QkjLFDOGEfaL9PlUoz90EHCmEkEdFAKx22mxDIfl41CaQH/Pf1qR+FQFQBGU5KLfIekMO8b9dlaQrO6RcD11yzgDm4obMBjs0Y1MhQ2+4x/H05cgOIPD5spL3jy5d+Hk2GOMnBEs19r4Do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D322TyFv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HC5FjAgA; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D322TyFv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HC5FjAgA"
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfhigh.west.internal (Postfix) with ESMTP id 8298318000D5;
	Mon,  4 Mar 2024 02:45:05 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 04 Mar 2024 02:45:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709538305; x=1709624705; bh=f3CMpYg/Hl
	+HWkNBpg1OlHIuPS9TLrU3L7F4GQs2feQ=; b=D322TyFvwldEkWrItVVrYSyyJr
	swkHgZxDIcctZLI4vpYTyvRXCkb4FWtSokGa31PlSekXRYm940vzkMBE0YCioDJc
	ex98NHxybGF5lM3DV/TgYiHz8995CvRe4y1Jk8/lJF2CcuT5VRKPjI3enoB3X5Ge
	kA2re5lxpcaZUMxQrMLMrrjY1pxt5/7TIKgXBFL6iQP05Wu3xnqMaJTKuLpfaneH
	DkhxtQ7tYCgHknGB64Ld2wfxAPycVR4GuZKT6+mkLL8pm07+hdOFVbsj1BjFyjgE
	k5kG8MPhJK+BEBJ4V95MNdRhvt8MHNNQYZjqPUmRXgPDeAaGcJqUaqNYHDYA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709538305; x=1709624705; bh=f3CMpYg/Hl+HWkNBpg1OlHIuPS9T
	LrU3L7F4GQs2feQ=; b=HC5FjAgAbKqX/cCVWvs4OvTJVHy6E2Jfn0/CUaugF8qU
	Gc772RfulAjn8bX+DYZbQEGyMsRCgiiAq9NPplVwQRm0+LkM5wchq6cuZ/HICBsB
	uZBBUIw/qJXdElgKqIHkxeNFYq4zplSJdbcRTCIQYhoDW5J4h51ZQxVRD8O8U0+l
	ABRkQk9gt6E44+AJ+vEHiG5h6V//AUN0olbLREzLujDYP78GHB1VruQc2PrdNpbj
	b2XRzrM0G1FXRjjb/v2MonuJWX5zzy3M9G3HsVbTIrwD1THLCNbAlvE10qRuRXCg
	EJgrYVsB7nPA76X2SDA/sSOMTolf9glmoPm7ZH/JAg==
X-ME-Sender: <xms:AHzlZVP2oIOPyM9H5wTa5fVdHBbB2uSjcJrBS3eQ2Zr0SNuwtehWCA>
    <xme:AHzlZX-PUf_x7j1zpG-Kd5-hIiGInkYZkMGIAKW8qCVvRUrVlSH2bBNOa0Gp7J2pX
    v6hr9WyJfZ8Zdr8Gg>
X-ME-Received: <xmr:AHzlZUSLGl_i84rkHl4hLD1ctb3ynQyRZu5GdnreaI7D63mrz08h3ye-KNd5qYazZyyvza-Y4X5wRv_vvqCiHAYnAeqEH5G1F-oYw2MP3h_ezKQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheeigddutdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:AHzlZRvQ__aD64gxE6XYW4A3aHhZfCnjKxgbIaHvcn9hDz3d0IFS3Q>
    <xmx:AHzlZdehC3_mphp7GkDegIxiLmlbzeW4zYqETDO3i7yrY1_HhVdsTA>
    <xmx:AHzlZd2udbBtZR_bjsaYxbCWAdOuOCVNOf9H76_jHis_cp75rja4ig>
    <xmx:AXzlZepy4kMYngJictXycMjTyO_W_2GRCsCndV_Lv8b5XDyr7WmhqLNEdO4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Mar 2024 02:45:04 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8195f543 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 4 Mar 2024 07:40:39 +0000 (UTC)
Date: Mon, 4 Mar 2024 08:45:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/4] upload-pack: use repository struct to get config
Message-ID: <ZeV7_obKou-jtyA-@tanuki>
References: <20240228224625.GA1158651@coredump.intra.peff.net>
 <20240228224647.GA1158898@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7QBx/WgkVZmWq9xi"
Content-Disposition: inline
In-Reply-To: <20240228224647.GA1158898@coredump.intra.peff.net>


--7QBx/WgkVZmWq9xi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 28, 2024 at 05:46:47PM -0500, Jeff King wrote:
> Our upload_pack_v2() function gets a repository struct, but we ignore it
> totally.  In practice this doesn't cause any problems, as it will never
> differ from the_repository. But in the spirit of taking a small step
> towards getting rid of the_repository, let's at least starting using it

Nit: s/starting/start

Patrick

> to grab config. There are probably other spots that could benefit, but
> it's a start.
>=20
> Note that we don't need to pass the repo for protected_config(); the
> whole point there is that we are not looking at repo config, so there is
> no repo-specific version of the function.
>=20
> For the v0 version of the protocol, we're not passed a repository
> struct, so we'll continue to use the_repository there.
>=20
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  upload-pack.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>=20
> diff --git a/upload-pack.c b/upload-pack.c
> index 2537affa90..e156c1e472 100644
> --- a/upload-pack.c
> +++ b/upload-pack.c
> @@ -1385,9 +1385,10 @@ static int upload_pack_protected_config(const char=
 *var, const char *value,
>  	return 0;
>  }
> =20
> -static void get_upload_pack_config(struct upload_pack_data *data)
> +static void get_upload_pack_config(struct repository *r,
> +				   struct upload_pack_data *data)
>  {
> -	git_config(upload_pack_config, data);
> +	repo_config(r, upload_pack_config, data);
>  	git_protected_config(upload_pack_protected_config, data);
>  }
> =20
> @@ -1398,7 +1399,7 @@ void upload_pack(const int advertise_refs, const in=
t stateless_rpc,
>  	struct upload_pack_data data;
> =20
>  	upload_pack_data_init(&data);
> -	get_upload_pack_config(&data);
> +	get_upload_pack_config(the_repository, &data);
> =20
>  	data.stateless_rpc =3D stateless_rpc;
>  	data.timeout =3D timeout;
> @@ -1771,7 +1772,7 @@ enum fetch_state {
>  	FETCH_DONE,
>  };
> =20
> -int upload_pack_v2(struct repository *r UNUSED, struct packet_reader *re=
quest)
> +int upload_pack_v2(struct repository *r, struct packet_reader *request)
>  {
>  	enum fetch_state state =3D FETCH_PROCESS_ARGS;
>  	struct upload_pack_data data;
> @@ -1780,7 +1781,7 @@ int upload_pack_v2(struct repository *r UNUSED, str=
uct packet_reader *request)
> =20
>  	upload_pack_data_init(&data);
>  	data.use_sideband =3D LARGE_PACKET_MAX;
> -	get_upload_pack_config(&data);
> +	get_upload_pack_config(r, &data);
> =20
>  	while (state !=3D FETCH_DONE) {
>  		switch (state) {
> --=20
> 2.44.0.rc2.424.gbdbf4d014b
>=20
>=20

--7QBx/WgkVZmWq9xi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXle/0ACgkQVbJhu7ck
PpQp9xAAksgWPCpFKQC53hrul7NeN516x702C06oKgzZVQDF4ys8rElgdehy2IPb
3GR8OPKaFhUEr0Lm1DW3OJ6Ug6sn+51OlNi6S84zHv8kzEA5pTA+tfO/yi3ciIp3
1VKRdN1cd97Pld0euUv8ZsjCe+YGZxCxc1+50CIHruBGfAa+5wFFwM7+QrP11PvD
CAOOxRazRHrN3VwFxEaHCf0oXSREGHhTc1rdfuKtQb3nubS7zyIX5Ti37Ysla8Nz
DHUafcFoGywlIc4fBtCMIsQ5W34tCga1sxJfqBW48di8RQmJLclhGP06EKKRJmrp
hsrpCYQ5VVen1KJUpJIzj0E7dauUuBLuDvq8bMWZUqTgvurE3pO2XKcXKP7r9C1o
Kf7vyk4t3ytBdxbcZ3N5C1vRyNvivQuwSTN5H8hqVD+AfttI0HXGkKN1ulKycDaL
pEAu6u1iB+dcVwPn4BFU/EW+0PM5u59+CGKeM9KcNqfRctBESa/2Cbz+3UlrrDfL
/2Nv0VoSanf5OtRzvGGB2Yb96w1DmoHIekdejvNHA2HxQPKUK88HOCSUNkx963QN
J+mydDVe+H2TSZt97VmfrfYTBNvsBxfryMXU0jQue0OJx7Vq2phNvg5nwI/P+P+T
yphQQkQ07ejj2+0MWELUT3tElHuMqFotPX0HBJKH2zr9A1Tcvho=
=DGol
-----END PGP SIGNATURE-----

--7QBx/WgkVZmWq9xi--
