Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6894E1B27D
	for <git@vger.kernel.org>; Thu, 15 Feb 2024 09:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989535; cv=none; b=K/ONrffDu5u8JypDmvAjDUaJPycEQf0iMv6OZ8G2m/yUVgzVpCDbUMbuDU0f0o5QBAWH4XnRrUlGVkSKAtg7EoJEdl1wo1T1Ox3JrmYN5eTEk299hGSsGU+OV0HSsG8mJkinLfN8ZN/lyAIwzdlouHWr4uP+8MC15Fm1n9cm2wE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989535; c=relaxed/simple;
	bh=Rhp9u/JzicllYCnjT8jI7Ov9yM9mLP04oSeiMWKRcXA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mrSPQ+So/Lq2l4RY3nEE+V8MgNKtwcgzpJ6DYkNjpE429oZVPp2RfI0c/MHx7XKTKSSd+WCxB5pbpacvaM4daFMIEIQmufkAJ9FMIfeciq8laS37WdtR0YjzKRndZP7XnEC2zV4XQyQIwE6Y2wMFV1KkZC7j3Ofz6U3LZq78jVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LERZSBB/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jtx2ni/f; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LERZSBB/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jtx2ni/f"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 527AD11400E7;
	Thu, 15 Feb 2024 04:32:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Feb 2024 04:32:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1707989532; x=1708075932; bh=4kwo4elE1m
	+mN5WM4MhlA6lOPFYe3rlAZRe6OvQtJrg=; b=LERZSBB/7PjnlOO3Xq9AxuUxTX
	ypwG07Y8YKZSm37yaxqR3AMzr6XkG4yKlwFx6nksC49zjM8kSn4rMUFj9zKmSLtv
	rFiNiSIsHnXEZhjy1fr6ckp6rglecfdFUCZpi6brjLO284JJCNIfDJiznh0c71yP
	mXjxKTKXypJEGll39qB9yyUpbfH+xskCrFrgNoy4Z/1zSNMtNC6N94wypO5em2AU
	yVcDIXOVkj8roD6t8bnOzjNLuXLhulL7oHC1yfAHyM2WbgfkieWApw8zyLReBl17
	HdgtT0HFHYpa40VoHuf1qtzwHi2okzUFhpbtlsrv5G2KNLvk3XcTWCbvcqtw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1707989532; x=1708075932; bh=4kwo4elE1m+mN5WM4MhlA6lOPFYe
	3rlAZRe6OvQtJrg=; b=jtx2ni/f80hF7qce9ZXPeF1HgWajcJ7pR4yQ79i/E1Da
	mdbyU5GFB+ybr/fJRNNo7cGOOy9R0gpg9edfPy1kaFvL7TBPwi0yVA/c4H4S8vDE
	BUk0mA8yEbTp7B72UelTzyKRN5a7+2jFXkF/p+uV0vqzr8hlFafmU+9PFauq2alK
	dR6N6Q35EI2j0pS8VDXlPL1bEM0xsCkr0kFHVK6cyH9aDX8SHINOks9Cl12S+7cC
	p/TBwxEu+Ezfl/yBVG2lhT6DZOF85AfVvYIZXtzaeBSuEsFwB0/0+7uRs45LRuTp
	ji8RT4VDymQTZiPmEvkJlpDoDktGNxRH4bCGDrtMvw==
X-ME-Sender: <xms:HNrNZeHSjIzWFg4YNT-F2LV5OVHcFFdCPYTm0xsPXtiwD-Eg7GBfKg>
    <xme:HNrNZfULziqfQ69BuYJE_YWHxlqva8gy8K6Y_f8CG3MVjHa1FC0fCcBK9AaXRFad0
    BTnoeyx_7pgjdZswg>
X-ME-Received: <xmr:HNrNZYKNtcsz2ri8hMu1mj8rgEzu8JNsfbwXwDnYlUvyIsAsnmo0yLtYwRwb0C7dsHhRdwnSlG06tr-Rg7sMNieLSwAK3ajO0dTCC8nmfzis>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddtgddtgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleffteen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:HNrNZYF4K06eF9RMMlzcxMGGvTZkAFrS8ktF3jzDMSAtcuJco0xPRQ>
    <xmx:HNrNZUX59YdLqO0hge0Dus93Nv9-sEZQV4k-Lbg275aPt7OczVjwuA>
    <xmx:HNrNZbO8MQTDJOUvKkW48kWqWG1RiZyYB4dufTXu4250WcjvwBzSRQ>
    <xmx:HNrNZbTlI8f35WpMD6vevh2qDCu8VwQybN1T6JuwHmioJAkmzwYDvg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Feb 2024 04:32:11 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 308cd6e4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Feb 2024 09:28:19 +0000 (UTC)
Date: Thu, 15 Feb 2024 10:32:09 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Jeff Hostetler <jeffhostetler@github.com>
Subject: Re: [PATCH 04/12] fsmonitor: refactor refresh callback on directory
 events
Message-ID: <Zc3aGSbEIFVClRd_@tanuki>
References: <pull.1662.git.1707857541.gitgitgadget@gmail.com>
 <3fb8e0d0a7c0455cc7a5ba28c12736fd4bbbd44e.1707857541.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="meOtMPZ4lTNikIhK"
Content-Disposition: inline
In-Reply-To: <3fb8e0d0a7c0455cc7a5ba28c12736fd4bbbd44e.1707857541.git.gitgitgadget@gmail.com>


--meOtMPZ4lTNikIhK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 13, 2024 at 08:52:13PM +0000, Jeff Hostetler via GitGitGadget w=
rote:
> From: Jeff Hostetler <jeffhostetler@github.com>
>=20
> Signed-off-by: Jeff Hostetler <jeffhostetler@github.com>
> ---
>  fsmonitor.c | 52 ++++++++++++++++++++++++++++++----------------------
>  1 file changed, 30 insertions(+), 22 deletions(-)
>=20
> diff --git a/fsmonitor.c b/fsmonitor.c
> index f670c509378..b1ef01bf3cd 100644
> --- a/fsmonitor.c
> +++ b/fsmonitor.c
> @@ -183,6 +183,35 @@ static int query_fsmonitor_hook(struct repository *r,
>  	return result;
>  }
> =20
> +static void fsmonitor_refresh_callback_slash(
> +	struct index_state *istate, const char *name, int len, int pos)

`len` should be `size_t` as it tracks the length of the name. This is
a preexisting issue already because `fsmonitor_refresh_callback()`
assigns `int len =3D strlen(name)`, which is wrong.

> +{
> +	int i;

`i` is used to iterate through `istate->cache_nr`, which is an `unsigned
int` and not an `int`. I really wish we would compile the Git code base
with `-Wconversion`, but that's a rather big undertaking.

Anyway, none of these issues are new as you merely move the code into a
new function.

Patrick

> +	/*
> +	 * The daemon can decorate directory events, such as
> +	 * moves or renames, with a trailing slash if the OS
> +	 * FS Event contains sufficient information, such as
> +	 * MacOS.
> +	 *
> +	 * Use this to invalidate the entire cone under that
> +	 * directory.
> +	 *
> +	 * We do not expect an exact match because the index
> +	 * does not normally contain directory entries, so we
> +	 * start at the insertion point and scan.
> +	 */
> +	if (pos < 0)
> +		pos =3D -pos - 1;
> +
> +	/* Mark all entries for the folder invalid */
> +	for (i =3D pos; i < istate->cache_nr; i++) {
> +		if (!starts_with(istate->cache[i]->name, name))
> +			break;
> +		istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> +	}
> +}
> +
>  static void fsmonitor_refresh_callback(struct index_state *istate, char =
*name)
>  {
>  	int i, len =3D strlen(name);
> @@ -193,28 +222,7 @@ static void fsmonitor_refresh_callback(struct index_=
state *istate, char *name)
>  			 name, pos);
> =20
>  	if (name[len - 1] =3D=3D '/') {
> -		/*
> -		 * The daemon can decorate directory events, such as
> -		 * moves or renames, with a trailing slash if the OS
> -		 * FS Event contains sufficient information, such as
> -		 * MacOS.
> -		 *
> -		 * Use this to invalidate the entire cone under that
> -		 * directory.
> -		 *
> -		 * We do not expect an exact match because the index
> -		 * does not normally contain directory entries, so we
> -		 * start at the insertion point and scan.
> -		 */
> -		if (pos < 0)
> -			pos =3D -pos - 1;
> -
> -		/* Mark all entries for the folder invalid */
> -		for (i =3D pos; i < istate->cache_nr; i++) {
> -			if (!starts_with(istate->cache[i]->name, name))
> -				break;
> -			istate->cache[i]->ce_flags &=3D ~CE_FSMONITOR_VALID;
> -		}
> +		fsmonitor_refresh_callback_slash(istate, name, len, pos);
> =20
>  		/*
>  		 * We need to remove the traling "/" from the path
> --=20
> gitgitgadget
>=20
>=20

--meOtMPZ4lTNikIhK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXN2hgACgkQVbJhu7ck
PpQM5A/8Cp+S2aTkrl/Xp2Q1yimAN2SfyTCQDsL3fC3ZVCF1V3gP4cy50G98EKjU
PE5VPbIdn7CWwhSU2uPlnNfNvaNacUI1LPPH4B8miMp8QZnpy+rDHLljYjoTO3by
nhW7UjsnTnSkn/ApgbG3vSXot66p8dd8sUHTJlIAfCFNmdv0uGGsNyYFp4i12eeh
zzWroYUTv02fMsWCcA6ihGGkfd/3A6FVU3iLeGEZVntOg0KPksj5o7cc8jzW+5Lf
+YyFBT0E3CVVVoa1BzHNnhTL+FhpnWwxK7ISB5Ei52wJXq3t2VKPe3XhJh2vBcPR
x2OnnpWh2f/0UeONgpiwAjTBtb5F4pFdholAwJ+zpYDGv9mbNTDeaSAClZFllMR6
oQ8vOZv707qG4+l957lI7eWnXUcCwXVUD0hoWJMtnStNxPopwGXvPAN0eErJ1njj
2XFFpeRw/FZ6YKY9Wcr2inY4SdEeVbqSSg1s5a8UnD2PGucac6WO5bUR0YTc8YR8
sqzrwMdBBJmW6+AOwrcsP62PULzi6MRL2htGmZ+nVQ6VuiUNk3w0PwOnhdEzxx0z
8oYEO72y/dV2cjAuCz7gGmKo7Vt1+n4bQHmkqa7Xf0Eopi/SokHctvKgFFTSCOqf
raTAnVS73R9FGsJjamWcvpUuJejnTXaThd/x7FK1Tlu01R9FBrA=
=e0ix
-----END PGP SIGNATURE-----

--meOtMPZ4lTNikIhK--
