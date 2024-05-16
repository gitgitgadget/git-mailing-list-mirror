Received: from fout6-smtp.messagingengine.com (fout6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3285614534A
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857764; cv=none; b=X9oaCbu6EwjT9k0wSx/lyu7crdW4PNUVM5YYCeZeRGUlXHbpjOhJo/YuuKmLzNvqAwMO4H/rjtZZDzYISE+uvw5WbRq4vx7PX5qnJ1vEwSY3ohph6oSmnvh8x/2LYaMU7rR4Zh+6waChJxTzsfBxKXs9oij9AfVbd4F3rEgkHt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857764; c=relaxed/simple;
	bh=7eoUFB3KX6vyiq0dNQnjdcMbEtEnyxdLpyMwAf+FPjg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYgC8z5pf3uokU/ee5mhMkQM3plFoN2o61thXI2MTcnzJPsEftFHcN/DmZFkLI0LjRUpxTzPeuMT+or1/jvF9lP8ycJId58b4CAPQ35Vo2gRSjmMOkA9J5O07u0o0/daL02J7ytniEVLsQY+DVvFzw2tPop29qWAQp8dOK023go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Awd1mEps; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PuEjKwBt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Awd1mEps";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PuEjKwBt"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 12DFC13803A8;
	Thu, 16 May 2024 07:09:21 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 16 May 2024 07:09:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715857761; x=1715944161; bh=e/t39qdDgB
	BICJSXyqHKIlsXurX9Ft+JM8dOhCndNYo=; b=Awd1mEpstsn8+Un2oHCBEDazvi
	zMDFXkTJBzgo3SuneYXSJ2c8GwEYdTaW7EohgtHnoP2HlJY+0Mc0IBRqbOVFe4V9
	9sC4McpbdeKKFK6lXfNXINZKyvHvQXNuJzV2m4ODqy72B1sjLVEmMJPCaAYKCgXB
	lsZAdPMHuHTIpMW4AK8HCOXPpC3Bpjn/eYnknR8uZnX2ZrsjJQ/uMetZM4z98S45
	U3QFJxLiidQ8OfYhocYmWazWCc1oxiqZqg4/mZwq61e6eJ7VToJfUH9IwkYXRkxA
	C6pmhQ+Z/AEaf2jKSaPmhcQ1fhgYlHd9Zy/VRBSwCA5laTDhS+YFzMYu3Mow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715857761; x=1715944161; bh=e/t39qdDgBBICJSXyqHKIlsXurX9
	Ft+JM8dOhCndNYo=; b=PuEjKwBt3BHmB8HtL8WWWh8ijO8fBEPjAWdKWtpftvML
	DLF39JDC1pcuZ0FdHlVQIvTIEd2Qd1GaT2yA0QwuYQSSLkwh1fHb0AOOXdOQaGCB
	feFm9BsYI7EGhaM4VERq9gWfzZ3mGm1G3ISxZEmAxsHxAWvS/kHVBHThblbroqk2
	o4IBrZ4oi7NMgeCIGwo3vkK1o8OcVkUVPdkSU7zZXt/HNhrmnV+Y966904GqPP2D
	GtV+4c08VkwVABQEh6NU0692WG7bEGhtTciT6BHlVWhRb3IYixHO+prZ7A9Bjy/w
	pDT+SAbJPV6pmeavnm3f3TlaFb62ORvdEMuLI/hDmw==
X-ME-Sender: <xms:YOlFZvgMdyHNH-hpXxClUuRHHDXdIZO-4bJfuLasCQLLPe5BmN6f3w>
    <xme:YOlFZsBx7YH7gUXZk5XiBTcmDh3GdPmkdSujlM6EwIUvN46IJugnYespQAwFKY8DZ
    7YnfAKJ9cM7cUJ0EA>
X-ME-Received: <xmr:YOlFZvFGrPpmn0ReHgY0DMmbzC6k1cOMukr1-QDvaCwZxGr4pdeEDMY097OLxobcsCHtbu-NHeeGv4o6blUm28Myay0ScdgM44L4RcM_gnLbQ-8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:YOlFZsQmJixj6IuwCvypZD6hWED_Klc28LJ0rhpeN6Yzu_6rmrJEDw>
    <xmx:YOlFZsxdBgR7RFwJ_uM8zYGxwNKVXo9TbtctBrzznFrtSDC7qchL8g>
    <xmx:YOlFZi7U8U-Emod9r-kpQbt2aNjTY0LKnKgtFAFFH8sohFTShp-wHQ>
    <xmx:YOlFZhw9nj9EYD9sO5fXiQMScV5X0KvXpgSYmSr6LU1_lqIArfxJdA>
    <xmx:YelFZo9RQ6P72XGw6PiO8aV6E3BPOMmFSdlBdqinjaU6u7ltRQtAQ-Qi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:09:19 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id f416a240 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 11:08:52 +0000 (UTC)
Date: Thu, 16 May 2024 13:09:15 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 1/6] refs: create and use `ref_update_ref_must_exist()`
Message-ID: <ZkXpW0BPvR3vr2jx@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-2-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mI8/+vCVf6zaEcKV"
Content-Disposition: inline
In-Reply-To: <20240514124411.1037019-2-knayak@gitlab.com>


--mI8/+vCVf6zaEcKV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:44:06PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The files and reftable backend, need to check if a ref must exist, so
> that the required validation can be done. A ref must exist only when the
> `old_oid` value of the update has been explicitly set and it is not the
> `null_oid` value.
>=20
> Since we also support symrefs now, we need to ensure that even when
> `old_target` is set a ref must exist. While this was missed when we
> added symref support in transactions, there are no active users of this
> path. As we introduce the 'symref-verify' command in the upcoming
> commits, it is important to fix this.
>=20
> So let's export this to a function called `ref_update_ref_must_exist()`
> and expose it internally via 'refs-internal.h'.
>=20
> Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
> ---
>  refs.c                  | 6 ++++++
>  refs/files-backend.c    | 3 +--
>  refs/refs-internal.h    | 6 ++++++
>  refs/reftable-backend.c | 2 +-
>  4 files changed, 14 insertions(+), 3 deletions(-)
>=20
> diff --git a/refs.c b/refs.c
> index fa5471d219..59858fafdb 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -2863,3 +2863,9 @@ int ref_update_check_old_target(const char *referen=
t, struct ref_update *update,
>  			    referent, update->old_target);
>  	return -1;
>  }
> +
> +int ref_update_ref_must_exist(struct ref_update *update)
> +{
> +	return (update->flags & REF_HAVE_OLD) &&
> +		(!is_null_oid(&update->old_oid) || update->old_target);
> +}
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 3957bfa579..2df204f891 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -2411,8 +2411,7 @@ static int lock_ref_for_update(struct files_ref_sto=
re *refs,
>  			       struct strbuf *err)
>  {
>  	struct strbuf referent =3D STRBUF_INIT;
> -	int mustexist =3D (update->flags & REF_HAVE_OLD) &&
> -		!is_null_oid(&update->old_oid);
> +	int mustexist =3D ref_update_ref_must_exist(update);

Okay. So we didn't notice this was broken because even though we started
writing symrefs via transactions now, none of the calles ever assert
that the old ref exists?

>  	int ret =3D 0;
>  	struct ref_lock *lock;
> =20
> diff --git a/refs/refs-internal.h b/refs/refs-internal.h
> index 53a6c5d842..5da3029e6c 100644
> --- a/refs/refs-internal.h
> +++ b/refs/refs-internal.h
> @@ -765,4 +765,10 @@ int ref_update_has_null_new_value(struct ref_update =
*update);
>  int ref_update_check_old_target(const char *referent, struct ref_update =
*update,
>  				struct strbuf *err);
> =20
> +/*
> + * Check if the ref must exist, this means that the old_oid or
> + * old_target is non NULL.
> + */
> +int ref_update_ref_must_exist(struct ref_update *update);

Seeing `ref_update_ref_must_exist()` as a standalone function wouldn't
quite tell me what it really does. It sounds a bit like this would
already assert the ref exists at the time of calling it.

We could call this `ref_upate_expects_existing_old_ref()`, which might
clarify the intent a bit.

Patrick

--mI8/+vCVf6zaEcKV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF6VoACgkQVbJhu7ck
PpSViw/7B+cAq6NArlHByBBxEHXmnID9UHI6+wFCaQgSW3/pMRlFRl6fLevkx8PW
07N8typ+3hfQnJ6QnGdy7fn1ZPCx0CvGVOnlQIpkIjeEeXGBJchuIPK/5Uis3S+f
mZeuOdDO52jvWG8vysjK2T0l/eP5JAYNIGHswDdipLaULjyocR0YSt+6g7cXRhNb
Mbp3ldV5BlEgSffd0OlQNf81ClJ5xiVwIvi/BIuQ6nsSbPu9QGUxN6VKBwOw0xYF
17mpzbh6sdB/NmetuUv6bEIV+TWV8Gh6m42cB0tfMkc7RHRyAsHMHRbbeEXlqOGE
qN5RD8MgjQTPgZLNbi3kIrOAwhh0Kq57CJXqDaZCyatBhIk8TfICJd5YnZrcEVuJ
XXmR9+tlN0Dg5ZWbSlMadJCpCuEPCoV/iHu9j1l/Q1xaKr4hJ8xhDQvLHGXN0+lp
OYyFURAZWPAOql7rrkl8ikBaY2jgeadk+pB1X5Je/9DQuxHDOV+PeujP4qpRuQno
RLmpkDyMVwOQ+RQfaqqG6LCPss6V0AiaYkN4l75acV8kdn/SHcnb6giUw5rk0dnL
UT2oWn5IqO6e703iNZc48oNMGXw/jmxi96QVsqGtYXM3lDUa+NqgzSQjqfmdxdJ9
uDt4eVa91C29Npe4zNcMAOkSJe3UmlLppirjZQqALLysYxtgO3Y=
=hqqR
-----END PGP SIGNATURE-----

--mI8/+vCVf6zaEcKV--
