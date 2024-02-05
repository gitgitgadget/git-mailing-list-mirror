Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72BD510A01
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 05:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.24
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707112080; cv=none; b=IshPCoPE4Sfs/5dX0NOw+rYObYxW6L1HJp1uobwfjlQeTB8uw5C7QolV03ffDG0r9JpvLtDDl+3vZXkmVga3d0Gb8+mAT7rv0IMe4gifGLT3/qc7sKhhTOkB0EX3xigjV5kgqOVCHtHVzy8iI0pYl6BkuxiDz4nZ1VHk47jPg28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707112080; c=relaxed/simple;
	bh=jybpjQaTxY6klMhcY5H/Gz14TN96fDWBv+a8njSVLss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BMaUyUaUyKhDXjzX28ufqX1rdX+V1ojDoP8b+FvOlqrQCSRufQRa2V3cM6QlBaRGdGmNXTcjYqhkRi1tQdfrI9uqfcJm/r6fw+e3+OQUpw7kuBouap8G6vGmWoklnH8GBmt67b1TF27XWtkqrvEAzwKz+VVrgpkTKiR3FehNZHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MwA2oLYe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DPVa9fJT; arc=none smtp.client-ip=64.147.123.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MwA2oLYe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DPVa9fJT"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.west.internal (Postfix) with ESMTP id 00B8232001AB;
	Mon,  5 Feb 2024 00:47:54 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Mon, 05 Feb 2024 00:47:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1707112074; x=1707198474; bh=S/kSQWlYLQ
	KDPbeHFecHV4jxY9MMGkvXxnKdmQ7Erdw=; b=MwA2oLYeG+DB6ymBE+HItX31Ag
	IkomqVePdxPq1zbZPaMMl+9ptJQrLUGBrI0xZWrRfYFvpHMTjqFKAWEtUDT+hr7c
	e1JMTwTCS7FxOO2P52UK4NM+XMzu9OquTFxp4083hzKQn6r0ipHharN9hiWUcCV3
	k1AVJXIibFHthCRDC+8B9tM5WVH11vZnCXaDkktTXt+mdMBBS/8Ptrx6gqKd+Op5
	4GRdfSP88a7AwcJoVdLUbfpeVaeSuOft7UgQLmlHke6i6BavM9fex2u1mSXXOPBL
	1Ko0saWXZJwtMPs1Rw2LzDUtJoZa6Yc5v3VtTQP8dIeTM/DpniY1n8OHFnhw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1707112074; x=1707198474; bh=S/kSQWlYLQKDPbeHFecHV4jxY9MM
	GkvXxnKdmQ7Erdw=; b=DPVa9fJT94mfRBuZx0T54tJrZyIrucKjJ3WmKKGZHBQp
	q7ndyJQde3Uuy/ulK5R26r6kz5i2xykbduR5/OHrHSZU4QBxJwkeZv6HJfXs6653
	4NhT6O/eZ50Ra8n1qDtdr2UY++ranV43Cj9ZGYy+xJ17DJ5LJI5O4ILAG718wYKN
	J8kmvD1O2ekx4RPtl3BtZ6oG7ntUcxoP5m1ZcxYjUAEBSvhq6FtbF3no4lVgPiLW
	o1tuhwiFVLsrkhEnfqQBuGqswvrTmt2r4XL14fdFWQHOuEIBio5FXFRlo6wgkIfy
	gvZNc92PWpVUuaLYb7hK3y9ITLNWV7dXrAXL5VBnKw==
X-ME-Sender: <xms:inbAZVFTOr-U9CYrWmZ2DadGyA55i0JYahISvL5DReCGiYwtRqkMgw>
    <xme:inbAZaVbUiefmddvu0n4ZilitQaJbB-QDEg2pK7BFk2DBzZIO61LFvbKgdEAYtKzt
    JrhOdUMSzy9dZGINA>
X-ME-Received: <xmr:inbAZXKb40X08DEuH5wek3JibaKHAAxsSZz8h1YTJozR3UlwPAtCajr1S7ZHQ4BG0705pL36WND9DPFDAdj9ZdsVFq-If52EOjzgwruVmOXMbvg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrfeduledgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeejhffgieeuffeltdekveduvdekfeeive
    evjeduueekvdejhfdtvdfglefhtdetgfenucffohhmrghinhepghhithhlrggsrdgtohhm
    pdhkvghrsggvrhhoshdrmhgupdhhthhtphgurdhshhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:inbAZbEHja2jRbZmcd6qo26eWv38T2Xf-G3dWmJAX3BYUCAgPn5gww>
    <xmx:inbAZbUQZWsjFOmRePrMQFZiynPzH_bTfp2hpx6i01Xnr4fPyfm04g>
    <xmx:inbAZWNXzWQDEraOe1mKMur_jEQF01Lw6qg-nehJ0eS10bk_15j1ag>
    <xmx:inbAZSf44B2Tjna1JlXpcz7vZy4KBAb7s6LzF55UKvhvZsPh3BK5sg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Feb 2024 00:47:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4e7b3ffe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 5 Feb 2024 05:44:23 +0000 (UTC)
Date: Mon, 5 Feb 2024 06:47:48 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Quentin Bouget <ypsah@devyard.org>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 1/2] http: only reject basic auth credentials once they
 have been tried
Message-ID: <ZcB2hHBoyiBdOw81@tanuki>
References: <20240204185427.39664-1-ypsah@devyard.org>
 <20240204185427.39664-2-ypsah@devyard.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="Yak+8sEG4MAmBW6t"
Content-Disposition: inline
In-Reply-To: <20240204185427.39664-2-ypsah@devyard.org>


--Yak+8sEG4MAmBW6t
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 04, 2024 at 07:54:26PM +0100, Quentin Bouget wrote:
> When CURLAUTH_GSSNEGOTIATE is enabled, it is currently assumed that
> the provided username/password relate to a GSSAPI auth attempt.
> In practice, forges such as gitlab can be deployed with HTTP basic auth
> and GSSAPI auth both listening on the same port, meaning just because
> the server supports GSSAPI and failed an authentication attempt using
> the provided credentials, it does not mean the credentials are not valid
> HTTP basic auth credentials.
>=20
> This is documented as a long running bug here [1] and breaks token-based
> authentication when the token is provided in the remote's URL itself.
>=20
> This commit makes it so credentials are only dropped once they have been
> tried both as GSSAPI credentials and HTTP basic auth credentials.
>=20
> [1] https://gitlab.com/gitlab-org/gitlab/-/blob/b0e0d25646d1992fefda863fe=
bdcba8d4c7a1bbf/doc/integration/kerberos.md#L250

Do you think it's feasible to add a test for this? We already have a
bunch of tests for authentication with Apache's httpd in t5563, so if we
could extend t/lib-httpd.sh to set up `mod_auth_gssapi` that would be
great.

I didn't try though, and it could just as well be that this would
require a full-fledged Kerberos setup, which would be a deal breaker I
guess. I ain't got enough familiarity with `mod_auth_gssapi` to tell.

Patrick

> Signed-off-by: Quentin Bouget <ypsah@devyard.org>
> ---
>  http.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/http.c b/http.c
> index e73b136e58..ccea19ac47 100644
> --- a/http.c
> +++ b/http.c
> @@ -1758,10 +1758,7 @@ static int handle_curl_result(struct slot_results =
*results)
>  	} else if (missing_target(results))
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code =3D=3D 401) {
> -		if (http_auth.username && http_auth.password) {
> -			credential_reject(&http_auth);
> -			return HTTP_NOAUTH;
> -		} else {
> +		if ((http_auth_methods & CURLAUTH_GSSNEGOTIATE) =3D=3D CURLAUTH_GSSNEG=
OTIATE) {
>  			http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
>  			if (results->auth_avail) {
>  				http_auth_methods &=3D results->auth_avail;
> @@ -1769,6 +1766,9 @@ static int handle_curl_result(struct slot_results *=
results)
>  			}
>  			return HTTP_REAUTH;
>  		}
> +		if (http_auth.username && http_auth.password)
> +			credential_reject(&http_auth);
> +		return HTTP_NOAUTH;
>  	} else {
>  		if (results->http_connectcode =3D=3D 407)
>  			credential_reject(&proxy_auth);
> --=20
> 2.43.0
>=20
>=20

--Yak+8sEG4MAmBW6t
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXAdn8ACgkQVbJhu7ck
PpTPNg//RjnvvLY1jvzvofj1oiKoAPjn0OHuU37NpECL6sGBWXtQQhhTUS4aDMpd
w4zYGIKpBrE7J8bJk8QjYy0wQeDxZS6xk9KDICjM5JZ0kdOQRae/98kcBOZxxc4R
cAIXXlwaIoN4nRLXboYhnVkaltgM7URP90DhX/2IGh62BdA0ffSY8XEYcIQd3dH7
WSAuGpHyQb7+VOnL3ej/z/U4py3NsBETGNxD7k+Ka05iRWfqvlVy9xMmN4MDtWzc
lykaf2PwK8PTbzOjfL+y4m7KeLrUCqt/SHar3EtYQkp/4gwUl5hRsTMFwxbLl2HR
NTqEafC2YvGYyiT++5MNvF+79bugWf0wpm1vax5W0/2n+mildMXMhDv2C/vhYPab
kj+BC+YKc/8g260KaWvG1/CWUUDjOTYcm0zzONVw8Oz6jR7HarER+zEV7E+QTzZM
mnLLs/qoMdUep+a2i2SAje5f3Lsn2r32jEa8Q9lrawz12ELVgA6+IMuqdOVtOE36
3DW16cCjmYjVkr/H6J+YRaIMabG3ZRTdasACkd5I0uDGq8ORTdeqw6fbwPkxQl5C
BwCI5j/6HAKaDfa5i/qoyIxGsUjnHk1RVrhBdhJJN4qll90mdAGOiOGqh3BH65fU
jJihJb5kCzuOpQrhyBg+Oi97lj8QjUJtMu1Mo+WDc7YMoKDVKQI=
=nWVz
-----END PGP SIGNATURE-----

--Yak+8sEG4MAmBW6t--
