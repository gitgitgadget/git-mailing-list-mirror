Received: from complex.crustytoothpaste.net (complex.crustytoothpaste.net [172.105.7.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45FB2BEFEB
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=172.105.7.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788830916; cv=none; b=VOhGnpuNtvBk4MCxKRuDx8V5/qG/aGWub5DxK99TDbz1G+76jnnTzB+RteJhcmmTsWCDLGnip/AoNM1mGBMi8kTtDHAYuMzyFT5P1uP71ZtUbp7xMChhlZeyp+DGWpvx+T1Ql8uHOn0ImSM4vN6E5t9EwA3m7qruJnwQ7KM+MWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788830916; c=relaxed/simple;
	bh=n38P7GNyYV/mdMGjRrRgDN4NQOe77HouDLWYtQuZLKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CccOc8VYqHqkP6K8z42rWtfNYZEmUURMCKv3umYY214zmFjbUvFt4gCeJpFk7e+55PDTUs5xSywqRBw0hHbI2tyANOTi1m0A+r31yFBgJNUMFELQn8RZboixDTd3vq6BXglNA+otVaYQDQpXw2neegLg9YWxzahk5fsjmEhkO2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net; spf=pass smtp.mailfrom=crustytoothpaste.net; dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b=NSJgUBtL; arc=none smtp.client-ip=172.105.7.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crustytoothpaste.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=crustytoothpaste.net header.i=@crustytoothpaste.net header.b="NSJgUBtL"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
	s=default; t=1788830913;
	bh=n38P7GNyYV/mdMGjRrRgDN4NQOe77HouDLWYtQuZLKQ=;
	h=Date:From:To:Cc:Subject:References:Content-Type:
	 Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
	 Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
	 Content-Type:Content-Disposition;
	b=NSJgUBtLA/sAPIwOAoCcQDFFpLc1XnQRBGJ/RozHbTyQGMlECdQW33KfxIjyt33bJ
	 68YUBsPHQHOB/eSDZRKGl8/zfbZrC8qU1LgHWNcYGJc/Q1AhosCOJvkFwfxWQrdryC
	 a5zsrhzfN2upFXACIAEkiXUT3ubaOukzN3ngicWh8BYlzIbk5bD2FU4GC0F4LoCMGp
	 eUWkMJxx8UFJKJEOjmznto54qTwkpfaSzzbyNvnsSpwFUXwqtvXp1dZQoC5EYcL6EV
	 t5lUx1M4OIBgefD+o71bAaN8s1S/eY9+xluQD9AGk4FZSnAcK4JowS1f2EV7FsB+z+
	 FXNxEHK0+ZE74b2g6Mdh1NARnwbS4h9gfWLib5DOR0kg5WKE+4sWJxlW4c7MUJT0iw
	 R9V2yFE9DmzX5i2GkTp5NDk5WFCtu9cOY12EJ7tgUrFMma6M1A5/Y+mkGh1rAwPac5
	 tq6y32ADy2jQA7y/D4Qwdxik3ltHV/DpaD54rfl5VxdZxzop2vp
Received: from fruit.crustytoothpaste.net (unknown [IPv6:2607:f2c0:f00f:f901:7b23:2dc:c9d2:f0e4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by complex.crustytoothpaste.net (Postfix) with ESMTPSA id 7099720037;
	Tue,  8 Sep 2026 01:28:33 +0000 (UTC)
Date: Tue, 8 Sep 2026 01:28:32 +0000
From: "brian m. carlson" <sandals@crustytoothpaste.net>
To: Beat Bolli <dev+git@drbeat.li>
Cc: git@vger.kernel.org, Oswald Buddenhagen <ossi@kde.org>
Subject: Re: [PATCH 3/3] imap-send: only check the CN if no SAN DNS names are
 present
Message-ID: <ap9kv-ORyzzeUiqb@fruit.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Beat Bolli <dev+git@drbeat.li>, git@vger.kernel.org,
	Oswald Buddenhagen <ossi@kde.org>
References: <20260907211210.2621693-1-dev+git@drbeat.li>
 <20260907211210.2621693-4-dev+git@drbeat.li>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/Qx8fCN6nyO8c0cZ"
Content-Disposition: inline
In-Reply-To: <20260907211210.2621693-4-dev+git@drbeat.li>
User-Agent: Mutt/2.4.1 (2026-07-04)

--/Qx8fCN6nyO8c0cZ
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2026-09-07 at 21:12:10, Beat Bolli wrote:
> Checking the certificate subject's common name may only be done if the
> subjectAltNames extension contains no DNS entries. If no SAN DNS name
> matches, there's no match.
>=20
> Per RFC 6125 section 6.4.4[1]:
>=20
>     As noted, a client MUST NOT seek a match for a reference identifier
>     of CN-ID if the presented identifiers include a DNS-ID, SRV-ID,
>     URI-ID, or any application-specific identifier types supported by the
>     client.
>=20
> This change was inspired by a similar commit in the HAProxy project[2].

TLS is not supposed to use the CN at all these days and Go's
implementation completely ignores it.  subjectAltName is supposed to be
used in all cases.

> diff --git a/imap-send.c b/imap-send.c
> index 9a807cdde8..66d3dbfaa5 100644
> --- a/imap-send.c
> +++ b/imap-send.c
> @@ -256,11 +256,11 @@ static int verify_hostname(X509 *cert, const char *=
hostname)
>  #endif
>  	const X509_NAME_ENTRY *cname_entry;
>  	const ASN1_STRING *cname;
> -	int i, found;
> +	int i, found, has_san_dns;
>  	STACK_OF(GENERAL_NAME) *subj_alt_names;
> =20
>  	/* try the DNS subjectAltNames */
> -	found =3D 0;
> +	found =3D has_san_dns =3D 0;
>  	if ((subj_alt_names =3D X509_get_ext_d2i(cert, NID_subject_alt_name, NU=
LL, NULL))) {
>  		int num_subj_alt_names =3D sk_GENERAL_NAME_num(subj_alt_names);
>  		for (i =3D 0; !found && i < num_subj_alt_names; i++) {
> @@ -268,13 +268,18 @@ static int verify_hostname(X509 *cert, const char *=
hostname)
>  			GENERAL_NAME *subj_alt_name =3D sk_GENERAL_NAME_value(subj_alt_names,=
 i);
>  			ASN1_STRING *subj_alt_str =3D GENERAL_NAME_get0_value(subj_alt_name, =
&ntype);
> =20
> -			if (ntype =3D=3D GEN_DNS && host_matches(hostname, subj_alt_str))
> -				found =3D 1;
> +			if (ntype =3D=3D GEN_DNS) {
> +				has_san_dns =3D 1;
> +				if (host_matches(hostname, subj_alt_str))
> +					found =3D 1;
> +			}

This handles certificates with DNS names but not IP addresses.  So, for
instance, this match wouldn't work for the certificates for 1.1.1.1
(assuming they had public IMAP service).

>  		}
>  		sk_GENERAL_NAME_pop_free(subj_alt_names, GENERAL_NAME_free);
>  	}
>  	if (found)
>  		return 0;
> +	if (has_san_dns)
> +		return error("none of the subjectAltNames matches hostname '%s'", host=
name);

I know OpenSSL has built-in hostname verification that can be used as of
OpenSSL 1.0.2[0].  Is there a reason we're still doing this by hand?

Relying on OpenSSL's verification would mean that (a) we would not have
to worry about getting verification wrong in a security-sensitive way
and (b) OpenSSL would handle the policy and standards compliance
functionality.

[0] https://wiki.openssl.org/index.php/Hostname_validation
--=20
brian m. carlson (they/them)
Toronto, Ontario, CA

--/Qx8fCN6nyO8c0cZ
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

wr0EABYKAG8FgmqfZL8JEHwMSWKIh6KBRxQAAAAAAB4AIHNhbHRAbm90YXRpb25z
LnNlcXVvaWEtcGdwLm9yZ+lEWDFikIH6jq8rMCXT3Z53ctguYHY1wbXSYKegzW8S
FiEECCzmip28ZfuD0cORfAxJYoiHooEAANhDAQD0Xz3F3dQEHjwxE5Lg2DhTNphN
0wJQXEtC2olofgHh4gEA7RP62wnM37Lk7fmPlA17l5YhhQdPit41aZPL6DJfhwo=
=FYD6
-----END PGP SIGNATURE-----

--/Qx8fCN6nyO8c0cZ--
