Received: from wfhigh3-smtp.messagingengine.com (wfhigh3-smtp.messagingengine.com [64.147.123.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 997C716936A
	for <git@vger.kernel.org>; Wed, 29 May 2024 07:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716968906; cv=none; b=Ku+QA2jNWRPWIiA+PpvIeJmAyeJg+WOUTch/KQHJIfdBy1byU4sfCWQBuf1pkDIbO2g8u49b4iWPrlLOrmdsi2dX8YWsN+g8Y7E5dGrvcgDO51U4TKLZds+4t1MYxkrp7wC4Gt4nNguvP01/Xp8a3uMc2m94+M+yulzg6NeRcH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716968906; c=relaxed/simple;
	bh=D8GaAJE6WKC846VWgbUrSYr5OZq8eJdfkF9mTeWJekQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/SIDpXIcnMvsZaAVt5KTXzgrgDo8PXsrEDy7LBTsMp33b+7mCi9BJmrdZPqp2iLPZWmHe+MMGSxhaf9kvWG7xDoqsFM2V0nbxBQGhlMBRo2QNNElG9ig4YRv3TupXlw/y1V2wB0kV23dNmAUb2gx1y5ZMlcFVuZwh0zM/3OVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UnPo+IQ8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKJ+lwnw; arc=none smtp.client-ip=64.147.123.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UnPo+IQ8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKJ+lwnw"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.west.internal (Postfix) with ESMTP id C6F8E1800169;
	Wed, 29 May 2024 03:48:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 03:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716968903; x=1717055303; bh=cYmkdSd+PD
	fnoo8lTIYrQNYnDq/wFMnzqT67e2KVz1E=; b=UnPo+IQ8pmWlgwZQFf3hyqLIJh
	bMsHiYXiTWvxBPy/5Mc0RjNpfIIRH31VrAE628uY/499E8zr+abqHmtmZLVWIvOg
	JEvczDFK+uFe9eVit8hnwM+bwxTRFmemi+b/S3UReptmsI471d0f0SR/PlObQI25
	imsHLRkxarI3i2KV3dfaNYX2np2vqSwD83jO5SWJjZGyNjPRZo3z8LMI/7NshqZz
	iLo0F4LeBjfFq0BwEXuAb5DcRJCqyntNIEaqSUboyvoSA+IenyO9BY5OS4fXs5BN
	yfmCr9P/Fwd6RaO7d7kvh4wo0t4V69G1uAwT50LSZX+w+ar9PS4IowR55PZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716968903; x=1717055303; bh=cYmkdSd+PDfnoo8lTIYrQNYnDq/w
	FMnzqT67e2KVz1E=; b=iKJ+lwnwcPPVgXoOeUCLZeqzrIDRXibgvmo6tJ8j3vQ7
	Cm8pvuTzhS2pIxZtgiY/0KTNBm9PFYk7MJnyTkyA2nvrExzPdLmLKfNa57YXwWxr
	ny9OtMR8Er6H1GfqwKlvn+zIvtIp6pIb18QhG1Qwt2NhKDJ0at49Y+a9pMqGCs3c
	WfnKL/S39Ynk9AjQAUHwIb7ug5dO+ZZCGI8W6DXZIwCzSOzUbnVmG0+hxz9pewHr
	SHom5cy6wlkBEC50t/dmwid2kyguUGwadQdZeD1+Uobw8YWyw1/7DuOclH02Cfyq
	tGN+aTTGGGbGVw8SVNQavU98Rhr8ySzfVnr0OO2F/w==
X-ME-Sender: <xms:x91WZuOBC3mtS28DV6MtlCiBE4TsX7WMqOCtUWeJzeitG-51SeWiXQ>
    <xme:x91WZs9b0r93bnAqs2GWkkhlbj-CGrVIo_tWrOGBmvsSUaeGOcBiswUqh5TNHrA5Z
    kaX5U5EY9XWZJ98wQ>
X-ME-Received: <xmr:x91WZlRpQcc9f78LcbnUawAud7P2LI1adm35PB4Wx_X8foj-I8dcOZ3qytdRWIFqopzHasVX09vKmRA2m38Nbif-kOzskRnNemZ1wWnFkoYxGSdb>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdektddgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedvnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:x91WZuu8ztEd_UGZCJhKfY3Wy9x5Huf94CngiYFGx75XpQutZDJ8eA>
    <xmx:x91WZmdWqUHJFsy67njKC5xIQXRCTCf6jjMB3ruwm0XhayT0QAUrKw>
    <xmx:x91WZi3wlJJ_nYz9ZdznFWQ7GORH80CRsszTw6uXw1rHXtSO25KT1A>
    <xmx:x91WZq9CTBs5AlFugJwmrf7Zr8_FjB6pBVOLehEF2GhgLc5l6y_sXw>
    <xmx:x91WZnopLNbjq5qgJRRFhOG37qWmEjqPXI4C6pmqqU5j8E7cZFhmT7zB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 03:48:22 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a8804a8d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 07:48:08 +0000 (UTC)
Date: Wed, 29 May 2024 09:48:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] midx-write.c: support reading an existing MIDX with
 `packs_to_include`
Message-ID: <ZlbdxJmIBvgV_VIF@tanuki>
References: <cover.1716482279.git.me@ttaylorr.com>
 <61268114c6562ba882210fd94b3f336efcb5c486.1716482279.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Jc+DiWYLnRk7tM8w"
Content-Disposition: inline
In-Reply-To: <61268114c6562ba882210fd94b3f336efcb5c486.1716482279.git.me@ttaylorr.com>


--Jc+DiWYLnRk7tM8w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 12:38:19PM -0400, Taylor Blau wrote:
> Avoid unconditionally copying all packs from an existing MIDX into a new
> MIDX by checking that packs added via `fill_packs_from_midx()` don't
> appear in the `to_include` set, if one was provided.
>=20
> Do so by calling `should_include_pack()` from both `add_pack_to_midx()`
> and `fill_packs_from_midx()`.

This is missing an explanation why exactly we want that. Is the current
behaviour a bug? Is it a preparation for a future change? Is this change
expected to modify any existing behaviour?

Reading through the patch we now unconditionally load the existing MIDX
when writing a new one, but I'm not exactly sure what the effect of that
is going to be.

[snip]
> diff --git a/midx-write.c b/midx-write.c
> index 9712ac044f..36ac4ab65b 100644
> --- a/midx-write.c
> +++ b/midx-write.c
> @@ -101,27 +101,13 @@ struct write_midx_context {
>  };
> =20
>  static int should_include_pack(const struct write_midx_context *ctx,
> -			       const char *file_name)
> +			       const char *file_name,
> +			       int exclude_from_midx)
>  {
> -	/*
> -	 * Note that at most one of ctx->m and ctx->to_include are set,
> -	 * so we are testing midx_contains_pack() and
> -	 * string_list_has_string() independently (guarded by the
> -	 * appropriate NULL checks).
> -	 *
> -	 * We could support passing to_include while reusing an existing
> -	 * MIDX, but don't currently since the reuse process drags
> -	 * forward all packs from an existing MIDX (without checking
> -	 * whether or not they appear in the to_include list).
> -	 *
> -	 * If we added support for that, these next two conditional
> -	 * should be performed independently (likely checking
> -	 * to_include before the existing MIDX).
> -	 */
> -	if (ctx->m && midx_contains_pack(ctx->m, file_name))
> +	if (exclude_from_midx && ctx->m && midx_contains_pack(ctx->m, file_name=
))
>  		return 0;
> -	else if (ctx->to_include &&
> -		 !string_list_has_string(ctx->to_include, file_name))
> +	if (ctx->to_include && !string_list_has_string(ctx->to_include,
> +						       file_name))

The second branch is a no-op change, right? The only change was that you
converted from `else if` to `if`. I'd propose to either keep this as-is,
or to do this change in the preceding patch already that introduces this
function.

Patrick

--Jc+DiWYLnRk7tM8w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZW3cMACgkQVbJhu7ck
PpQViw//X5a7GG78VUianZRTw2qTHPmRWnOuvhtjgLlexf6DLOiPjJ+AMo0HfKVU
bGmLLS2Yz7xGUVetYjXhWFbv7GuGzGkowkhuSQBQAs9c92Ej6mqNigxBj84vEQN7
bmqIZJpUlyzIWpqp5ejaNfJ6VS/27XJaNcMJ81aW4XZW3TTLD3+f24mRCvFs2gTP
0qvH9Jz2erfPjfnniVHm2xVwS7BjhKi+0OmKI3upZ141cbGexHTbBmpeI4k6syAz
my/1EvQ8dwDkMCNyo3voOyV0Obl9eA5QGo4mlq2FivIKSxeVo9z19kk+bBGUoErt
ROesk0tXK9MgxBhoX36fDp2V10GumL51hxrNAU1m5wI+ZFoTAqMv0C3xFa7h+rU7
u9q+uSuSQwIAKHsK4qyN8bJotf3WlhUwPlSXQUWobrOFHCfWQPMcGKLjEZ2BJT2j
XtHkQ8tUox1Lgir3yn4o74uOrXBuWj6xnAhzX4i6LjGR89S8RD+xiRUgbT0alJ9V
0kGaIGU40ENHFAPMzl1ocRsaZ260CU5QVtTyEeK6U+oIIvS4KP0ENZrYXV5RpHnW
PdiX+kiwik+DOcQUBw0UlwcF1mJGmjRcZ8MYANkyjnN10v4X7aa1nxDUXjiEWxBg
SNZvQOQcijuM2qlkmWUvRaRgbz+zOO5Q8s8ohGPRq4l73zbxMO8=
=lOrx
-----END PGP SIGNATURE-----

--Jc+DiWYLnRk7tM8w--
