Received: from fhigh3-smtp.messagingengine.com (fhigh3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D88145352
	for <git@vger.kernel.org>; Thu, 16 May 2024 11:09:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715857768; cv=none; b=GeVDQpclHXxjjdV4NobP4ytETadwEn30iLQ5keWPyLWKx5AsrEovA5M89Q823ZMHoKvtvp4/nfQg1HjcUihCyfaysiXI+uCg1y8LAEtfDGcpUFcH33sFFPNakQZ55QsOblPpXbWoscY5m2BDXOzqsfbewZltjupZoK2eBcfkMsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715857768; c=relaxed/simple;
	bh=rnYCUC5fwGxGpxmEoFhEPCPSEUSHHH+egVdVJWqH5Fc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k83OgPwPr0h0X7dQy8ol5CMwCS2xYRdm0gTbiVaOq34txKOX1DbXWIabU1qnvg1SJ6Fp8uyNFqfhQNUKSnv/t/hT0NwXcJ4sm5QSw5HglFbbYYnuG4n4al0E4MQ6ItjebsWw+Asnd7Ywo6NXx4GeU8jgS8jG/DflQ92W9NxgfZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=QtsIsSMS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TUVhGVmh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="QtsIsSMS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TUVhGVmh"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 57906114016C;
	Thu, 16 May 2024 07:09:24 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 16 May 2024 07:09:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1715857764; x=1715944164; bh=veFArLsjt6
	B8TY2b2ZOjaOqfCDdDuWYUIefvGwy2QyM=; b=QtsIsSMS41gCsatGT9YkPFg/iw
	DAtpVALRQJ5t2cuhkPdmLBnNIixY0W36/v4ebnyy9RQ4ahWEtgXQapHCp7HLCIpN
	iKpeZnjowdF0rJfNiBxT6OYIAs/r64C3tBQUStBpXEl0jX+bfQkga29aKGN/g/Dh
	zslJ7Ws+KuoyCpFMPGerAbCRotUJ8t7RNE9jKrzl/Nx3FHTDrZd5T8aoYCx3+0UB
	CUvUVUfCsy9vWO/6sp69w5kmSmtxIxZzoe2l8PQPiESg8g5zAZW/PxLZg7lcsm6f
	fPQSFPfaWthe9/sGwcqQ4yi5GVz1UDk4sbG+aIYkvjWsXYLLUmPbE0mw07PQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1715857764; x=1715944164; bh=veFArLsjt6B8TY2b2ZOjaOqfCDdD
	uWYUIefvGwy2QyM=; b=TUVhGVmhi/lQ2QOZkhouaH15uwiibcR6+2RymUMocLPv
	9Cf/SAkdUHviWn6Z1CLCeCLYM+XRiNAjiJHGi8cdhr8+IZ1lyjhdRgKeOKPJmTr2
	3Ec1ArahvnhWam1YHO0C6BpP2H93SZFS0X5soXNQKPX+r8INY8Q65oxF8wm8P6t2
	+OBZfLhLiSkQ5TYU8sWPWAJjuIH0zFX3ui0zpncwfxQjOfkc5p05zMJeC/rH98Cb
	yAOn1dmUUgngZ4wUjMHwG2ystvcJVVdGqa21TqCCrOv78etZX0u8cJ3Pd8atW/Zj
	jAk8xjrvz/huQAr43uY86N7Q/PR74bwLBC2Q3Bm2SA==
X-ME-Sender: <xms:ZOlFZk8tu8MdDE8U7wYDI0qO5p_v0juyhYkVjOwJ97QShptCGwtcQw>
    <xme:ZOlFZstgMRC6ypr79wUqtyde5Wz--btNA8MH8ilxwlBOg1bUqRTjjBRHgZ1jnNc8f
    Oz7A555sd4VUVwnng>
X-ME-Received: <xmr:ZOlFZqDwgH4KOeW1Ai5omvrFZYjM-_OcZv4rW8ouIAPtazOz9vcP0s9dA1O25e4X5uf_eRNo98779pJwDNVP1XnvWn7r604zxKxtQICjtRZdh3Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdehuddgfeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:ZOlFZkegeY1xm-axtaePYAtCjZaDcmTkbXgsuNFxJnkVv9Y1x-xp8Q>
    <xmx:ZOlFZpPMgBJph57TdUkIkWx7Q56OjVrRGVqu1SgdnW8OQt8pwwkpNg>
    <xmx:ZOlFZunIDSvt5gy1fOiT4u5rfjNG-mMzIAGZDdaadR6W5-klxxAtgA>
    <xmx:ZOlFZrtyyW6x6Y7YeW_9xw-eK_zuucz2Uv5R-QVAxtRLsEDg89rndg>
    <xmx:ZOlFZqoC5cIth5zHsvNSBHPA3UaBDjgbiDfRcCsLKlcttR5n4edM0UvI>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 16 May 2024 07:09:23 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id c5c7d851 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 16 May 2024 11:08:58 +0000 (UTC)
Date: Thu, 16 May 2024 13:09:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH 2/6] update-ref: add support for 'symref-verify' command
Message-ID: <ZkXpYep2MKdsyNyV@tanuki>
References: <20240514124411.1037019-1-knayak@gitlab.com>
 <20240514124411.1037019-3-knayak@gitlab.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="LdM+SrZqoluXeN7T"
Content-Disposition: inline
In-Reply-To: <20240514124411.1037019-3-knayak@gitlab.com>


--LdM+SrZqoluXeN7T
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 14, 2024 at 02:44:07PM +0200, Karthik Nayak wrote:
> From: Karthik Nayak <karthik.188@gmail.com>
>=20
> The 'symref-verify' command allows users to verify if a provided <ref>
> contains the provided <old-target> without changing the <ref>. If
> <old-target> is not provided, the command will verify that the <ref>
> doesn't exist.
>=20
> The command allows users to verify symbolic refs within a transaction,
> and this means users can perform a set of changes in a transaction only
> when the verification holds good.
>=20
> Since we're checking for symbolic refs, this command will only work with
> the 'no-deref' mode. This is because any dereferenced symbolic ref will
> point to an object and not a ref and the regular 'verify' command can be
> used in such situations.
>=20
> Add required tests for symref support in 'verify' while also adding
> reflog checks for the pre-existing 'verify' tests.

I'm a bit surprised that you add reflog-related tests, and you don't
really explain why you do it. Do we change any behaviour relating to
reflogs here? If there is a particular reason that is independent of the
new "symref-verify" command, then I'd expect this to be part of a
separate commit.

[snip]
> diff --git a/refs.c b/refs.c
> index 59858fafdb..ee4c6ed99c 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -1331,14 +1331,17 @@ int ref_transaction_delete(struct ref_transaction=
 *transaction,
>  int ref_transaction_verify(struct ref_transaction *transaction,
>  			   const char *refname,
>  			   const struct object_id *old_oid,
> +			   const char *old_target,
>  			   unsigned int flags,
>  			   struct strbuf *err)
>  {
> -	if (!old_oid)
> -		BUG("verify called with old_oid set to NULL");
> +	if (!old_target && !old_oid)
> +		BUG("verify called with old_oid and old_target set to NULL");
> +	if (old_target && !(flags & REF_NO_DEREF))
> +		BUG("verify cannot operate on symrefs with deref mode");

Should we also BUG on `old_target && old_oid`?

> @@ -1641,4 +1647,88 @@ test_expect_success PIPE 'transaction flushes stat=
us updates' '
>  	test_cmp expected actual
>  '
> =20
> +create_stdin_buf () {
> +	if test "$1" =3D "-z"
> +	then
> +		shift
> +		printf "$F" "$@" >stdin
> +	else
> +		echo "$@" >stdin
> +	fi
> +}

I think this would be easier to use if you didn't handle the redirect to
"stdin" over here, but at the calling site. Otherwise, the caller needs
to be aware of the inner workings.

> +for type in "" "-z"
> +do
> +
> +	test_expect_success "stdin ${type} symref-verify fails without --no-der=
ef" '

We typically avoid curly braces unless required.

[snip]
> diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-h=
ooks.sh
> index 067fd57290..fd58b902f4 100755
> --- a/t/t1416-ref-transaction-hooks.sh
> +++ b/t/t1416-ref-transaction-hooks.sh
> @@ -157,4 +157,34 @@ test_expect_success 'hook captures git-symbolic-ref =
updates' '
>  	test_cmp expect actual
>  '
> =20
> +test_expect_success 'hook gets all queued symref updates' '
> +	test_when_finished "rm actual" &&
> +
> +	git update-ref refs/heads/branch $POST_OID &&
> +	git symbolic-ref refs/heads/symref refs/heads/main &&
> +
> +	test_hook reference-transaction <<-\EOF &&
> +	echo "$*" >>actual
> +	while read -r line
> +	do
> +		printf "%s\n" "$line"
> +	done >>actual
> +	EOF
> +
> +	cat >expect <<-EOF &&
> +	prepared
> +	ref:refs/heads/main $ZERO_OID refs/heads/symref
> +	committed
> +	ref:refs/heads/main $ZERO_OID refs/heads/symref
> +	EOF
> +
> +	git update-ref --no-deref --stdin <<-EOF &&
> +	start
> +	symref-verify refs/heads/symref refs/heads/main
> +	prepare
> +	commit
> +	EOF
> +	test_cmp expect actual
> +'
> +
>  test_done

So the reference-transaction hook executes even for "symref-verify"?
This feels quite unexpected to me. Do we do the same for "verify"?

Patrick

--LdM+SrZqoluXeN7T
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZF6WAACgkQVbJhu7ck
PpR0WBAAruRJmqsXA3NRxvo+cj4tYyR4NOpF6twCVa8/Y7DEqIbR0xBpjzMVOn6K
Jjv39SHokFi9FK0JxTGU9AqKucFFFlTMJd31N6PO8lH+1ItQIqcn+1EKthJbcVSc
bTUuxsBkgJYjmBWO3G7H+0Fxd/SfukM742avaZRqqvXJ7qlLzV603NTn+5DUqtYv
q0jcT9Bsr+7PxVMmBFdjAnoHETrhf6plJfKOVkLb8Ac7tx1k4hp6Dzm8htbDdRlP
b5CLGeVqVwJ5hkJWxxN9i0+8PceETMYVh4N7/qZlz+ummAjOudF9WDu6J/nyeVtb
9VrC1g4RDKs/dYFUvpUuz7Ngn9KyoKf0EmXjze1ZdbJ+oEiQMPETduzWKnEvCcUQ
weNRLSn10tftQ/ntc9HujXQXuovmX8M27bmZ26q2a8bWyHSOqGHRdfk8puXwgvS7
tQ4uHkcVMHqM3i4DHPnJ68Sk1MMms7Ok9xc2Buwwu5GN6NeEzgDSPAv4WolKhGm1
EClPxF+shJD/wT+lJ1g64CdLilFM7DK6t6cEdvpdTLGBKgI6qtZ1kAArs5yuerQ9
tvrqyqH/r1y1AlDRXwW4ws2/kp2Pwu5K0vaaks/TMuIIzgEooT9dLn4ya+tf+jBo
1YpSYNmS4A6dRcIEu8y75U+MwNi/gHz+ru7Lg7oRCpzgiPuQgxo=
=79mh
-----END PGP SIGNATURE-----

--LdM+SrZqoluXeN7T--
