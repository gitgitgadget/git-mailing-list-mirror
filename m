Received: from wfhigh5-smtp.messagingengine.com (wfhigh5-smtp.messagingengine.com [64.147.123.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4674F8BB
	for <git@vger.kernel.org>; Mon,  3 Jun 2024 07:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717399361; cv=none; b=tR+PHv7XBIYZPAbAmKa1FwDyCQgNlnp9iX31ZrZyLJrwSYBNn2xGATWQCmhO4NE19BknyH9CHZ0O6Kj88ZajgmIzgsnxQWxlb4Ww2kLNHHRNFnaXVYTQKvn1a6L/NqkbbdYUye0gYO/MzxTgGMokYypAgRi3DpQLYEDg0mx/gTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717399361; c=relaxed/simple;
	bh=lT63Cr7QtaKq6Nel4i87foNgY6Y+kXcBCIA6/1umfaA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p4DhpMqHX4PIM+2/GOtGWRubbCK54Y/qNBJ7wyoj65YwX2dIhtLsVFOF25jl/rC0UnYfzaM08FbYtcoaLmwuUZbLqGB4cEcHeXAFHg96gp5mwr7fwdcEDw0HMvxAZQad8itTGZws3ReXIKQJav+5Ah2cJxIz9M8NiFhUCHbQ14g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hJTtXYob; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iAMtwZQe; arc=none smtp.client-ip=64.147.123.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hJTtXYob";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iAMtwZQe"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.west.internal (Postfix) with ESMTP id 43FB118000B8;
	Mon,  3 Jun 2024 03:22:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Jun 2024 03:22:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717399358; x=1717485758; bh=GmL5NmiaB8
	JAcZnLKYyb1uGFTXNKQ+uw/IPAu4cypKs=; b=hJTtXYobxfivVzOTigRI3C6tU5
	T8m4CymuAerZqXodiCfR7jdJU84eX47y7dUIGeAIQCDuNZq9YHPBMU/5Eo4R7t1e
	uCR9qLPKn8Umy08poQg/ZvBT+OgTLkITX+pNM+3CJ14/f9VJjZv1P/ajXlFlQqGK
	BB3Y57IAwj+cmnyXwz1D4wQA7SGT3BEUNw9IKN499Eb6bgkqIbl26Y91kSr0Krnm
	HOvsbG9p2MuANLIu1f4VDw8/Jj35SMC4dFaQRLrZZGqJD2FxUCscYkFmX1+DhIRE
	0kgilOnPCmu+NqAEovxmOGexcY0qwgSCK/xulME5Nlznt1EEowOqwkPoE7eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717399358; x=1717485758; bh=GmL5NmiaB8JAcZnLKYyb1uGFTXNK
	Q+uw/IPAu4cypKs=; b=iAMtwZQeui3qdfWizl2ANPzBM3F24rdR5Dd95mWIrHUm
	jN1G1CZfRLwbXBRUIuwxM1pTHCOL766UvTqFIjBtRBZOeh+8ha2d7wiamN0SFUsb
	BJyH1vQyjpT8ARSVpJm6QBQHzrFrVnEJ7G/Sh4gP4asKKV05WWzlEPVmTenNokxE
	Re8HQJbI4HWOdiqgyZcvmheY2MZQRBRUEr4bcwiSs3oWuopeNYj6MJYSEkoVH2Y6
	bSqW55d7TBBr9MnbwYFQdYwNKvMc0PkDfutp616ZnmRy/GRMf0SF1tOOjlNdOTCK
	LTeIglhbzeiwHtw/8kfpW6Vrq6iV5cao5uY1R7e2gA==
X-ME-Sender: <xms:Pm9dZoQN2MtKuQ6sHd3vc0VBgX4xyhlYPmebREtT1zozGBHJ26t9lA>
    <xme:Pm9dZlx1yBxtpSXy5bzDv7Fyq90Hwb44f_kQanXHx2J3t_z1JBeLjM299gWO78GX7
    fK9LFCUfttLhhyLDw>
X-ME-Received: <xmr:Pm9dZl34-koFDH5tltvBF-k4-G6igI92Gr1HLfAFpmf1DY46Jdyo0dC0h3Crb-XDqDM1ChwmLABpTOY1Nm-tSEr3c-oD4bqf1fzB_9M5bTkuKna4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdeluddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:Pm9dZsC5nkglojzIdX-37JubDNgYnoLbMQ1Y7eV7u9PD_F-idI7HKw>
    <xmx:Pm9dZhhbu39ZW5e1C67COFc3hCFOxOElL3i6Xj_fiIPudE_w1QYRjg>
    <xmx:Pm9dZor1owEAb3apuI1BGcjjG54V7cgD6lG-6PdUvWjgkSQ05YiSNw>
    <xmx:Pm9dZkgZP3vTr41DxMc7XUcy7KRlSJ32P5XxpjZ9FtQVk894vTa7ig>
    <xmx:Pm9dZmvCPSRSWBCi-nz4KD4VUrFnB5q_jJFmmnth8YPU9neNvpOYvLa_>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Jun 2024 03:22:37 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 5b8a4c47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Jun 2024 07:22:13 +0000 (UTC)
Date: Mon, 3 Jun 2024 09:22:35 +0200
From: Patrick Steinhardt <ps@pks.im>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [GSoC][PATCH 1/2] refs: setup ref consistency check
 infrastructure
Message-ID: <Zl1vO7RPL0rUEvzX@framework>
References: <20240530122753.1114818-1-shejialuo@gmail.com>
 <20240530122753.1114818-2-shejialuo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6fHZTO7mtC/WFaah"
Content-Disposition: inline
In-Reply-To: <20240530122753.1114818-2-shejialuo@gmail.com>


--6fHZTO7mtC/WFaah
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 30, 2024 at 08:27:52PM +0800, shejialuo wrote:
> Add a new interface `fsck_refs_fn` for the `ref_storage_be`. Implement
> dummy method for files and reftable backends.
>=20
> Mentored-by: Patrick Steinhardt <ps@pks.im>
> Mentored-by: Karthik Nayak <karthik.188@gmail.com>
> Signed-off-by: shejialuo <shejialuo@gmail.com>
> ---
>  builtin/fsck.c          | 5 +++++
>  refs.c                  | 5 +++++
>  refs.h                  | 5 +++++
>  refs/files-backend.c    | 9 ++++++++-
>  refs/packed-backend.c   | 7 +++++++
>  refs/refs-internal.h    | 4 ++++
>  refs/reftable-backend.c | 7 +++++++
>  7 files changed, 41 insertions(+), 1 deletion(-)
>=20
> diff --git a/builtin/fsck.c b/builtin/fsck.c
> index d13a226c2e..65a26e2d1b 100644
> --- a/builtin/fsck.c
> +++ b/builtin/fsck.c
> @@ -1065,6 +1065,11 @@ int cmd_fsck(int argc, const char **argv, const ch=
ar *prefix)
> =20
>  	check_connectivity();
> =20
> +	if (refs_fsck(get_main_ref_store(the_repository))) {
> +		error("ref database is corrupt");
> +		errors_found |=3D ERROR_REFS;
> +	}

One thing I was wondering is whether we want to make the infrastructure
part of the new git-refs(1) command, which is about to land via my
series that introduces ref backend migrations. We already make it a
habit that we spawn new processes here, as you can see in two lines
below for example. It would also make it trivial to execute ref checks
standalone, by saying e.g. `git refs verify`.

>  	if (the_repository->settings.core_commit_graph) {
>  		struct child_process commit_graph_verify =3D CHILD_PROCESS_INIT;
> =20
[snip]
> diff --git a/refs.h b/refs.h
> index 34568ee1fb..2799820c40 100644
> --- a/refs.h
> +++ b/refs.h
> @@ -544,6 +544,11 @@ int refs_for_each_reflog(struct ref_store *refs, eac=
h_reflog_fn fn, void *cb_dat
>   */
>  int check_refname_format(const char *refname, int flags);
> =20
> +/*
> +  * Return 0 iff all refs in filesystem are consistent.
> +*/
> +int refs_fsck(struct ref_store *refs);

We should probably also mention that errors will be written to `stderr`?

Also, I noticed that you are missing the implementation for the debug
backend in "refs/debug.c".

>  /*
>   * Apply the rules from check_refname_format, but mutate the result unti=
l it
>   * is acceptable, and place the result in "out".
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 5f3089d947..b6147c588b 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3299,6 +3299,11 @@ static int files_init_db(struct ref_store *ref_sto=
re,
>  	return 0;
>  }
> =20
> +static int files_fsck(struct ref_store *ref_store)
> +{
> +	return 0;
> +}

We can already wire up the call to the embedded packed-refs ref store
here. We always want to call that from the files backend.

Patrick

--6fHZTO7mtC/WFaah
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZdbzoACgkQVbJhu7ck
PpQ91Q//cFbA0NHBqVqH4aDNCzeNtK5dhNB2WaXePYh6HhYNNQHPVBTYnU9XoVw3
lP/r4U1nYyi6bSEcYy8IbySa6ElW9HkFqXnS8kW9EhLzYr0tTTma9RBOV0j79BRH
n3dCaEweiSlrKvi3I6d3cC6rXhhTUUjpZ/j9mpcYPdNnk6U6kK+iL/OcuUeMq/sH
fmiLHisRFvz+NaQME3UGDInnhbGmZ9bkfLrxfW+Z21dUNFnl5ZdXHxufJuhWrPco
4q4tmBMC6RpMANRnPji4YRaSvuE/B07TJ0kJoOjjbwqftyfGc5Ws7YsJRqG/d8YG
MCLF0NfPXzCa0Cshyg0ax1dsf7ieTq7hKV/hK4QqVD/4sThlMxpDwNHK4nECrwcn
YDXb35JmDCCd4WESdugd5W5GKfa0dMJHjkKEAxtxBBbjvkRBpGKRK07bsyNY7iED
EwjwQgk8sPgSOpxuW1M57wKxhKaJtdtgN8goFIvfgpYY+KSU6PWxX+IP8hUcrhSL
c9V9ly+p3i2L8H9QmKe3OSa7UaqKvd2eyxdEoyoYPtnMoBca74alOHMYdkfeAe48
BaKghp6ExDdEHMVkMnLdseM8yEtczuLeNvPE2RzYOS0lyAaAtNNzj7+D6CXogGNr
Fo/NKBT8QfAePi9n9w7pZgSxvWF6vG3aS+ZQlupkmuJWnK4xBGM=
=ROjL
-----END PGP SIGNATURE-----

--6fHZTO7mtC/WFaah--
