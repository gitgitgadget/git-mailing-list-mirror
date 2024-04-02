Received: from wfhigh2-smtp.messagingengine.com (wfhigh2-smtp.messagingengine.com [64.147.123.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804A7A158
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712060430; cv=none; b=mboUkiXjusFuLjBoN8qmD9L8b+TN/wPZZkWcPJNpMqcw641wKbjTMD2FHzv26KeufuAC2x2XuOcbRyG+O3E7xnyOwW/EtFFmwUGw6x1Mw0Q1y5z5l8IVs9VDb1T5W6ly48m0Pk666uls2Hna4SEwxDbmqGuI+7mw8zyEL1n9Chc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712060430; c=relaxed/simple;
	bh=L9NrzkDds43Jo5+j+f+O2rFzidGLBObLVHekATdvw9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R1ABDy7Ww3da0o9tASzezITc5a49ohMKAQZF2Gt9lv4Tyrp6BN23zb0ID1b1fZh4ZpqJTrzKORcLVQ7POtw/mmSWIhxuYx37J3k/rdt0DhY1KjkHf0NpyloSLq06Hutcu7Mc+RJGB0cr2YdmLOA2H0mO1v1Qm3ov5SWTooqRMgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=qcidqkxo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d0hME4i+; arc=none smtp.client-ip=64.147.123.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qcidqkxo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d0hME4i+"
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailfhigh.west.internal (Postfix) with ESMTP id 06C1018000EA;
	Tue,  2 Apr 2024 08:20:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 02 Apr 2024 08:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712060425; x=1712146825; bh=SRKib10Bh8
	2WbL6O/18Lyq7pDMG7lmMeCoyfui9QIf4=; b=qcidqkxo0Tt3ds1YYv/PEXU7Hh
	ABriQ6OFRfIdXSat9WoeaC0R46+o5a+T5ZVoWWvnjgKNcph2VZrSWPq1nQVqo0jM
	0WhPKT1qJHiboynscMVLpM73nEK4Y+Y0KRnvG4LPa+SCpEwoC9qWYsJ37bUMNALG
	XNhoI03pbCu4Mnn8xWM2nulkXu7v8i2dsrqlnd7lik1ziMLhTvOKikfvS+faQ5n+
	LhwYON1jsGNTqa56iILd9IKrrBFNKxwskQ857wLxoVG9O9Tw1MO31ReqJ61Jfb6k
	vfz42yHTyWuq9AvRYxYw/UMjUHN7qmorkXdeR4Am31bJ90C7qLizUyp58z5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712060425; x=1712146825; bh=SRKib10Bh82WbL6O/18Lyq7pDMG7
	lmMeCoyfui9QIf4=; b=d0hME4i+E3Sa1S8lu5UfESZpzZrjVONQn+EimEwaKY2r
	nvqLw8k1xNhg43koFjsIvD6meHglJjc5cr1pF/eVeO+8EJfJ20m85KOASeypZSGv
	Mohtri0Wof9WYWVuLMQSxKuwt9t1fDHqTwbjVgdI4VHmLhsi+Ak13lx7vFqi+OcA
	9vTpJ3BUsuaypFnKHxjKaCl3jujdPCQBAyJ9XyIaWhySh99EjYJbQmS7MyduXAGo
	4NQgCVK4MdWdKfYGlO8OPKIfR4lW/5VqYq9PTHC4r0Y5twgo3Stvw6djF63MJOfw
	apvdPuzuI0teMu5mnQFhY9P8PVeF2qBPgy5VPZ9KSg==
X-ME-Sender: <xms:CfgLZutRy3v5HvFjtbDs3u9kwRDMYyf604YzE9xHM2UvFjj5eu0x9Q>
    <xme:CfgLZjcfxffyv0QoBetAQ8shOnrenFufIr2psRR0T7OHZKtztB5oL5ikMUs2hcNIX
    KsLFbtuo7t9proomw>
X-ME-Received: <xmr:CfgLZpwMDglJIk9vZlrnZm7w5pRwQvRXEjSiKrjS2h8gRYKf1MKuEvxb--_M1SrFFIo8DhcRxG16GwdmtSqeBI8jfif0hUyJb9f-8kLc618VDRI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgeevtdffhedvheehgeeuuefffeetiedtfeehjeehteevieehkeekieefhfdvveeh
    necuffhomhgrihhnpehuphgurghtvgdrnhgvfienucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:CfgLZpPyAqf7RpoBwARkV1_n2HxZPITuRnj__i2fChg26x1ldLvn5w>
    <xmx:CfgLZu8e-RcNEBZIp_f1mvOFaUDfJAjxnS2iiLLyvEXqtSfmBPSd0A>
    <xmx:CfgLZhWCF066y8pDrFLwcL6iWKTvCeoPUWZQa4GdxwwRsb8Uq8R_FA>
    <xmx:CfgLZnfS2vKlcFx1tG63O2rNvoB5QLXB4ClvlF-0QjHOK1bR8VCOFA>
    <xmx:CfgLZlY1hGijJxcqkse1mZFyNxLwRP8G26N2sqwFvGuxtLfOwKoxJnUw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Apr 2024 08:20:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 678aeb4b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 2 Apr 2024 12:20:16 +0000 (UTC)
Date: Tue, 2 Apr 2024 14:20:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] reftable-backend: extract out `write_symref_with_log`
Message-ID: <Zgv4B7DI9g0vmxea@tanuki>
References: <20240330224623.579457-1-knayak@gitlab.com>
 <20240330224623.579457-3-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="3nGXwZRS8haVz0W7"
Content-Disposition: inline
In-Reply-To: <20240330224623.579457-3-knayak@gitlab.com>


--3nGXwZRS8haVz0W7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 30, 2024 at 11:46:17PM +0100, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The function `write_create_symref_table`, creates a
> `reftable_ref_record` for a symref and adds it to the writer. Then it
> also creates a log entry for the symref. It does all of this while also
> obtaining and using a new update index.
>=20
> We extract out `write_symref_with_log` from this to provide the
> functionality of creating a symref without making changes to the update
> index. This will be used to add `update-symref` option to the
> `git-update-ref` command.
>=20
> Rename the `create` field to `arg` while we're here, as `create` is a
> bit misleading.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs/reftable-backend.c | 41 +++++++++++++++++++++++++----------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>=20
> diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
> index e206d5a073..282a08e3cb 100644
> --- a/refs/reftable-backend.c
> +++ b/refs/reftable-backend.c
> @@ -1222,23 +1222,22 @@ struct write_create_symref_arg {
>  	const char *logmsg;
>  };
> =20
> -static int write_create_symref_table(struct reftable_writer *writer, voi=
d *cb_data)
> +static int write_symref_with_log(struct reftable_writer *writer,
> +				 struct write_create_symref_arg *arg,
> +				 uint64_t update_index)
>  {
> -	struct write_create_symref_arg *create =3D cb_data;
> -	uint64_t ts =3D reftable_stack_next_update_index(create->stack);
>  	struct reftable_ref_record ref =3D {
> -		.refname =3D (char *)create->refname,
> +		.refname =3D (char *)arg->refname,
>  		.value_type =3D REFTABLE_REF_SYMREF,
> -		.value.symref =3D (char *)create->target,
> -		.update_index =3D ts,
> +		.value.symref =3D (char *)arg->target,
> +		.update_index =3D update_index,
>  	};
> +

Nit: let's remove this superfluous newline.

Patrick

>  	struct reftable_log_record log =3D {0};
>  	struct object_id new_oid;
>  	struct object_id old_oid;
>  	int ret;
> =20
> -	reftable_writer_set_limits(writer, ts, ts);
> -
>  	ret =3D reftable_writer_add_ref(writer, &ref);
>  	if (ret)
>  		return ret;
> @@ -1251,25 +1250,35 @@ static int write_create_symref_table(struct refta=
ble_writer *writer, void *cb_da
>  	 * not resolve for new repositories this ordering will ensure that this
>  	 * never happens.
>  	 */
> -	if (!create->logmsg ||
> -	    !refs_resolve_ref_unsafe(&create->refs->base, create->target,
> +	if (!arg->logmsg ||
> +	    !refs_resolve_ref_unsafe(&arg->refs->base, arg->target,
>  				     RESOLVE_REF_READING, &new_oid, NULL) ||
> -	    !should_write_log(&create->refs->base, create->refname))
> +	    !should_write_log(&arg->refs->base, arg->refname))
>  		return 0;
> =20
>  	fill_reftable_log_record(&log);
> -	log.refname =3D xstrdup(create->refname);
> -	log.update_index =3D ts;
> -	log.value.update.message =3D xstrndup(create->logmsg,
> -					    create->refs->write_options.block_size / 2);
> +	log.refname =3D xstrdup(arg->refname);
> +	log.update_index =3D update_index;
> +	log.value.update.message =3D xstrndup(arg->logmsg,
> +					    arg->refs->write_options.block_size / 2);
>  	memcpy(log.value.update.new_hash, new_oid.hash, GIT_MAX_RAWSZ);
> -	if (refs_resolve_ref_unsafe(&create->refs->base, create->refname,
> +	if (refs_resolve_ref_unsafe(&arg->refs->base, arg->refname,
>  				    RESOLVE_REF_READING, &old_oid, NULL))
>  		memcpy(log.value.update.old_hash, old_oid.hash, GIT_MAX_RAWSZ);
> =20
>  	ret =3D reftable_writer_add_log(writer, &log);
>  	reftable_log_record_release(&log);
>  	return ret;
> +
> +}
> +
> +static int write_create_symref_table(struct reftable_writer *writer, voi=
d *cb_data)
> +{
> +	struct write_create_symref_arg *arg =3D cb_data;
> +	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
> +	reftable_writer_set_limits(writer, ts, ts);
> +
> +	return write_symref_with_log(writer, arg, ts);
>  }
> =20
>  static int reftable_be_create_symref(struct ref_store *ref_store,
> --=20
> 2.43.GIT
>=20

--3nGXwZRS8haVz0W7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYL+AYACgkQVbJhu7ck
PpTowRAAjGHFXbOR5qnmDWE0FPqyFsbFuAz7hUktm6WPJ1ohBXAL7XrvB8CXwOsM
LnoiihCaf3qXwkp5GE0gc5sy5/obHJe9YjE/LbxQWyRNnjolOsEZZ+5H8PbqrPes
5EJWAtUEXZ5BcQD34XKLD9ic8Gv9H4v12A3sn+Kf0WwA1ZPtcU4WurR3wiZLnynR
CaJX0St0oM/QMqX2ucQH4mcp3vOD/pz4MaHfxmh1nSmyzBsn7YNa79J4J2bFe1pq
z0tMXJ1uWrUJlZHQ1tg96kLkqbz+Y1bLFhll3jnMPvMgIAVdZ3G/dp14Yjtfna6c
hW0y08A7vknG+e793VwSj50M4IZLqxJSdnV065YjTXttGQDSTgHniACIORxBDk6i
VyglHgc0m05WiV7XHDmWb6fVKx2d+/QBd5DdprM6wks3AoQnGN4DqFaMfFKjk88S
VVVpHRCjsQ2E66Bw+/oEZ9SmCo8idmw4z4z2QMm3jYlpPJ3AgZy33KL0rf1bE+K2
uRbr1YqzmsOphFruNcdFMQq0CoMXE4QIX/dDbhaFIWAJMDc4EqjPVuhA9KZJ/WDj
6gIiYO7Cb6OYTdttMLp8eYEsozDh76iUQZ0RqsAusglhgPzMCwu4wfUEdstDHV5K
z++YbChn7ANfx23vN+St1+wOMSwjNyi+AUU6ml3anFaxaceeFvA=
=gPsY
-----END PGP SIGNATURE-----

--3nGXwZRS8haVz0W7--
