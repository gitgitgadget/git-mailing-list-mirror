Received: from wfhigh7-smtp.messagingengine.com (wfhigh7-smtp.messagingengine.com [64.147.123.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17CA13A242
	for <git@vger.kernel.org>; Tue, 28 May 2024 12:03:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716897806; cv=none; b=MukSUYO1m8rVnKacJAH6LydPxawz3NNpaoEI1TjItEgm6f4BJHkZz/Wn4DiunB5miZb1G4XyVtr/NVnwEHHrvgn80MlBMDx2Lm6jPqsTvAMlBdKPs/Ui+1vbiWXyteceW04g4ByAn6N32j1QgWGqBIYzJc6mmjNsSuMkhc7ERb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716897806; c=relaxed/simple;
	bh=QrLHtP/atwbdOt6GOgqwmnkDZuPch2CczBB2pSJTUAA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=o17DKy8dx2LIvADlKS3zogX65oLM7PCJ3QKaSoglhOlL4G/fdqnAF/IddQDctxXZPnw8zG4+Sj3nEms1dV1abATa38SN1GUd2Y9bjwMzRVxRDB7tf5AmNSvV8GWvuDB8PhBj5bTFtSrgmAmlg3K07YglQf5qfKpjv0GMd8nA8Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TW2sID9H; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DNtvcWru; arc=none smtp.client-ip=64.147.123.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TW2sID9H";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DNtvcWru"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.west.internal (Postfix) with ESMTP id A816618000E9;
	Tue, 28 May 2024 08:03:23 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 28 May 2024 08:03:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716897803; x=1716984203; bh=BbZ/m4ZMp/
	ewzixACB/wCZORt+mZmBcwG0nJt4R3QSg=; b=TW2sID9H/RLfMbV5NvmCVSNTt0
	ddpakLmqDYll3wGT0qFx3toVMp/8crw7hTVVc9nZX67TZURuINiDna4sNMDiUSsQ
	Atl/07SKAJ9IoyQvbiaG5XriRS6mL9Y2onb6LHVhOmhtDrIWeB7JyyTp8foXxBmy
	Wm2hA/aV0fLn5G7drCum3Si6DwQZzi9GFVFn2VZkiePqdDVTMEvIrYT3N+ODUjNh
	pkVsz/z+1lbMkt0CpXAvMPsstkDavn72RZNCGC3QAWaBOKhlP/kes8eanL4k8IUE
	kiiQz6Apfs1BX8kYVB9r1MyVcWaHYAWSnKfYviQxdx54vYMNoGXVhSZS2sVA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716897803; x=1716984203; bh=BbZ/m4ZMp/ewzixACB/wCZORt+mZ
	mBcwG0nJt4R3QSg=; b=DNtvcWrugZ4U1iLb6n1hxQi1w79PBayiiTE6PEbdZpsM
	U7Yhv9uehQ2CbhalGoQq5vaI4xFF0F5JcOp01RrvC5vz/JPOPFq2HRqD/BS6rQ32
	W/JS20FOKwxCFRaFfo7yN3K81rcD1BZaTpPhwGGz2qasa8oMEk8cIkOfWaK2KPQR
	PWCC/CMcpZaWwzTKQLeXmsidT+xXro6Qba8VH10nvkOAdAUruKiaURzkwd3qZPmZ
	UdCUvVIX3/9QrD4lWYwxUXumM+M/fRMeB+z4hDDbRQcZIUPm/+rVEveGUwsylFAb
	elOEjNuOg6aJK700cd/2MS4ylwWU7eAHr8ke0SYtvA==
X-ME-Sender: <xms:C8hVZmYMMho9FUEP-6fCjpbfzA8oI63UrukpxKnTzCgEmuDHJoPccg>
    <xme:C8hVZpYHcUgT91HmRDXH8rakAzAnpY7YXbXoQzI4lmCoPbcL-3zJOXBvLzcUO23vG
    YOLkJW_-7maWbMAFg>
X-ME-Received: <xmr:C8hVZg9XmW68ShpGeqjVWdZcEVBi2nN6sKro50gas1a7W31PIiXpCEbgHbNaQ07wYGBzGgfiYtUKGGrOqTXm59MFBk1b_DdALFhOZQbh5mn7mUfK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdejkedgvddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:C8hVZor3OGQBkLOZhwzlQnBYi3InFxRLb2a7yUC8mSjlA6S9M3V6uw>
    <xmx:C8hVZhomI_ZMxK7HZuSMnE3lkIzLO6q_FvDc1lMUi1trcKtrT1AUZA>
    <xmx:C8hVZmQxEY63CW5LJRJYWH44ZjC6FD_jL2n-5bfQR6KM9M6FqM0RBw>
    <xmx:C8hVZhpxf6JF7ko5P6TfOhGouC2BrwKfTCvdbJrpwl6KK3I1vfiIaA>
    <xmx:C8hVZqDyzsc4JExLCRsNbokEuvK4U1gJsOMI7Q4bPyiFEKp-RjztBWgx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 May 2024 08:03:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3c35e0e7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 May 2024 12:03:08 +0000 (UTC)
Date: Tue, 28 May 2024 14:03:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Xing Xin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	blanet <bupt_xingxin@163.com>, Xing Xin <xingxin.xx@bytedance.com>
Subject: Re: [PATCH v3 3/4] fetch-pack: expose fsckObjects configuration logic
Message-ID: <ZlXIBrs5Q91r_-qU@tanuki>
References: <pull.1730.v2.git.1716208605926.gitgitgadget@gmail.com>
 <pull.1730.v3.git.1716824518.gitgitgadget@gmail.com>
 <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="BRY8BTX4PIgMQWs/"
Content-Disposition: inline
In-Reply-To: <67401d4fbcb3f07d31589bb8ec10060dcb77545e.1716824518.git.gitgitgadget@gmail.com>


--BRY8BTX4PIgMQWs/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 27, 2024 at 03:41:56PM +0000, Xing Xin via GitGitGadget wrote:
> From: Xing Xin <xingxin.xx@bytedance.com>
>=20
> Currently we can use "transfer.fsckObjects" or "fetch.fsckObjects" to
> control whether to enable checks for broken objects during fetching. But
> these configs are only acknowledged by `fetch-pack.c:get_pack` and do
> not make sense when fetching from bundles or using bundle-uris.

Do they not make sense, or are they not effective? I assume you mean the
latter, right?

> This commit exposed the fetch-then-transfer configuration logic by

s/exposed/exposes/

> adding a new function `fetch_pack_fsck_objects` in fetch-pack.h. In next
> commit, this new function will be used by `unbundle` in fetching
> scenarios.
>=20
> Signed-off-by: Xing Xin <xingxin.xx@bytedance.com>
> ---
>  fetch-pack.c | 18 ++++++++++++------
>  fetch-pack.h |  2 ++
>  2 files changed, 14 insertions(+), 6 deletions(-)
>=20
> diff --git a/fetch-pack.c b/fetch-pack.c
> index 7d2aef21add..81a64be6951 100644
> --- a/fetch-pack.c
> +++ b/fetch-pack.c
> @@ -954,12 +954,7 @@ static int get_pack(struct fetch_pack_args *args,
>  		strvec_push(&cmd.args, alternate_shallow_file);
>  	}
> =20
> -	if (fetch_fsck_objects >=3D 0
> -	    ? fetch_fsck_objects
> -	    : transfer_fsck_objects >=3D 0
> -	    ? transfer_fsck_objects
> -	    : 0)
> -		fsck_objects =3D 1;

This statement is really weird to read, but that is certainly not the
fault of this patch, but...

> +	fsck_objects =3D fetch_pack_fsck_objects();
> =20
>  	if (do_keep || args->from_promisor || index_pack_args || fsck_objects) {
>  		if (pack_lockfiles || fsck_objects)
> @@ -2046,6 +2041,17 @@ static const struct object_id *iterate_ref_map(voi=
d *cb_data)
>  	return &ref->old_oid;
>  }
> =20
> +int fetch_pack_fsck_objects(void)
> +{
> +	fetch_pack_setup();
> +
> +	return fetch_fsck_objects >=3D 0
> +	       ? fetch_fsck_objects
> +	       : transfer_fsck_objects >=3D 0
> +	       ? transfer_fsck_objects
> +	       : 0;
> +}

=2E.. can we maybe rewrite it to something more customary here? The
following is way easier to read, at least for me.

	int fetch_pack_fsck_objects(void)
	{
		fetch_pack_setup();
		if (fetch_fsck_objects >=3D 0 ||
		    transfer_fsck_objects >=3D 0)
			return 1;
		return 0;
	}

>  struct ref *fetch_pack(struct fetch_pack_args *args,
>  		       int fd[],
>  		       const struct ref *ref,
> diff --git a/fetch-pack.h b/fetch-pack.h
> index 6775d265175..38956d9b748 100644
> --- a/fetch-pack.h
> +++ b/fetch-pack.h
> @@ -101,4 +101,6 @@ void negotiate_using_fetch(const struct oid_array *ne=
gotiation_tips,
>   */
>  int report_unmatched_refs(struct ref **sought, int nr_sought);
> =20
> +int fetch_pack_fsck_objects(void);

Let's add a comment here saying what this function does.

Patrick

--BRY8BTX4PIgMQWs/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZVyAUACgkQVbJhu7ck
PpSupA/+JldWSNdgNHIQRaTeej3anoyvLwnW6PCRuHba7WftmG+pyustXEnYBuac
dLRASWKHQwtNYObbcZMMYGnCOc6QJSfiOdhyutJa3qQ9hO16XzAkEw8SLFF2Rjmf
2tWYOqLQE1rFI8vgoAmTQLBTgz9+Vh9+AtBaWwwBTGxzuQU0GK6PdMevFhCRfwqa
kzZ0GURu/tyNaq9eD7UHPcehdUvs6m5aZpP5fqmAtUunuhjzoLe8JwXVepSVvbHq
jH3b+qn58lpxqLehcQkNl25tsSOnf12+CLicnFOPSjUkjVQHpgRJnwBZFydp8gai
dWxHtLlAlhWUTqo0ng1hz3IGkXjOGEesyOadwgV2Jjgd5WpsUW/BCB71hZt/Q++n
C3zoMsNafoFjXQx8RQcyJ8lpyhXGFaU2pDf02g5AJOzmfWuZwFDHDZrkA4k2mLb7
rk3kBEe2hW6mDhCFppCGCFDF+iMtiFMWBI/2AF0Jiqkrgg2zk4EXecispEk8NfLi
G5J5RYe66OQzokquRVEKHMs1UTUGFPpjVn05FPOkleCb55D87uzwxJlFyBzc+Gad
PDdj29IktSqw09wRJWy6Bf9Fk0wFyCEWSx5lhgEYIMoUv+41NuECFL+fYgm/xcNh
ARs5EBjvy9wa0h3c6SRnGQuR4EXpzQG2uA9NqtHekfi6OvNBgdw=
=+usH
-----END PGP SIGNATURE-----

--BRY8BTX4PIgMQWs/--
