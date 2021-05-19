Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A4F1C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:12:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E92C6100A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 00:12:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234330AbhESAOR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 20:14:17 -0400
Received: from injection.crustytoothpaste.net ([192.241.140.119]:47288 "EHLO
        injection.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233554AbhESAOR (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 18 May 2021 20:14:17 -0400
Received: from camp.crustytoothpaste.net (unknown [IPv6:2001:470:b978:101:b610:a2f0:36c1:12e3])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by injection.crustytoothpaste.net (Postfix) with ESMTPSA id 6DD4F60479;
        Wed, 19 May 2021 00:12:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=crustytoothpaste.net;
        s=default; t=1621383177;
        bh=hKNSxPG7K+FUjn/jMAvoHWgW5YHpZK/esl7dT1k0RQ4=;
        h=Date:From:To:Cc:Subject:References:Content-Type:
         Content-Disposition:In-Reply-To:From:Reply-To:Subject:Date:To:CC:
         Resent-Date:Resent-From:Resent-To:Resent-Cc:In-Reply-To:References:
         Content-Type:Content-Disposition;
        b=KI4vOTOZr5mH7vd750yI+vlUQ5QKHu3nzIc95mmoeJRK8Oxa9/7CZM/TCD7vCiCV/
         GwmeKiQJxIcPkcAqRsWfFo+n1ajEi7Acqvsv7uYUjfc9KyGCx3LpUDyTS6PpRbtQ6T
         klU5tTR484Km3IiJ7b36ApWxepd1uRNadgSJ4Pt4h9f2xYu7/0oruIhUjFvnazLrxe
         XMdMXmO6RDl0YaZKtZ0Y24IDiztgwoRX1iU7gv3JrT0HiXKSUzRdh4C8J+SCr3P3Ai
         Py4kE7T1PgA9ET6utVp7Daj4fsUkTn9umI3qa/UhzA/DYOsfVwoUopRAnPmydntRBl
         kFjaQt8nsMx5yPv3LRzBTA1+09aMk/tyaCU9+cLzoF1/N7qvV6SN1j85MiiDWnj8Zj
         Bv7JVXPX6iM5hA/3kzStRwZZUBQd/KqvHnjlS5PrMAGwKxq0CfXqGs4xZ+MgKm3+Tk
         SpcE4DB7AEbwc7lviv5JHB091jIjNuYci4f24ZfVDhVogFt67TL
Date:   Wed, 19 May 2021 00:12:52 +0000
From:   "brian m. carlson" <sandals@crustytoothpaste.net>
To:     Jeff King <peff@peff.net>
Cc:     Ben Humphreys <behumphreys@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>,
        git@vger.kernel.org
Subject: Re: Git 2.23.0-rc0 HTTP authentication failure - error message change
Message-ID: <YKRYBLeIlgILfHFj@camp.crustytoothpaste.net>
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>,
        Ben Humphreys <behumphreys@atlassian.com>,
        Junio C Hamano <gitster@pobox.com>,
        Christopher Schenk <christopher@cschenk.net>, git@vger.kernel.org
References: <YKMvePOPqjwiXeQ+@C02WD045HTDG>
 <YKNVop80H8xSTCjz@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5/ZT8EriNMNS/JgT"
Content-Disposition: inline
In-Reply-To: <YKNVop80H8xSTCjz@coredump.intra.peff.net>
User-Agent: Mutt/2.0.5 (2021-01-21)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5/ZT8EriNMNS/JgT
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 2021-05-18 at 05:50:26, Jeff King wrote:
> So it is focused on the case when the credentials came in the URL,
> before the first contact with the server (where we'd get an HTTP 401).
> And the diff moves the negotiate check earlier in the function, before
> we see if we already have credentials:
>=20
> diff --git a/http.c b/http.c
> index 0e31fc21bc..19c203d0ca 100644
> --- a/http.c
> +++ b/http.c
> @@ -1641,17 +1641,18 @@ static int handle_curl_result(struct slot_results=
 *results)
>  	} else if (missing_target(results))
>  		return HTTP_MISSING_TARGET;
>  	else if (results->http_code =3D=3D 401) {
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +		http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
> +		if (results->auth_avail) {
> +			http_auth_methods &=3D results->auth_avail;
> +			http_auth_methods_restricted =3D 1;
> +			return HTTP_REAUTH;
> +		}
> +#endif
>  		if (http_auth.username && http_auth.password) {
>  			credential_reject(&http_auth);
>  			return HTTP_NOAUTH;
>  		} else {
> -#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> -			http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
> -			if (results->auth_avail) {
> -				http_auth_methods &=3D results->auth_avail;
> -				http_auth_methods_restricted =3D 1;
> -			}
> -#endif
>  			return HTTP_REAUTH;
>  		}
>  	} else {
>=20
> So in that case, we'd clear the GSSNEGOTIATE bit and return HTTP_REAUTH,
> and the caller will try again. Makes sense for the use case described.
>=20
> But imagine we didn't get a username/password in the URL. The first
> request will return REAUTH because of this moved code path (just as it
> would have before, because http.auth.{username,password} are not set).
> And then we'll get a credential from the user or from a helper and try
> again. But this time, if we fail, we'll return HTTP_REAUTH again! We
> never hit the "if (http_auth.username && http_auth.password)" check at
> all. And hence we never return HTTP_NOAUTH (which gives us the more
> useful "authentication failed" message), nor the credential_reject()
> line (which informs helpers to stop caching a known-bad password).

I think what we'd want to do in this case is to only call HTTP_REAUTH if
we actually cleared CURLAUTH_GSSNEGOTIATE.  Maybe something like this:

diff --git a/http.c b/http.c
index c83bc33a5f..e9fead8cd8 100644
--- a/http.c
+++ b/http.c
@@ -1650,18 +1650,18 @@ static int handle_curl_result(struct slot_results *=
results)
 	} else if (missing_target(results))
 		return HTTP_MISSING_TARGET;
 	else if (results->http_code =3D=3D 401) {
+		int used_negotiate =3D 0;
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
+		if (http_auth_methods & CURLAUTH_GSSNEGOTIATE)
+			used_negotiate =3D 1;
 		http_auth_methods &=3D ~CURLAUTH_GSSNEGOTIATE;
-		if (results->auth_avail) {
-			http_auth_methods &=3D results->auth_avail;
-			http_auth_methods_restricted =3D 1;
-			return HTTP_REAUTH;
-		}
 #endif
-		if (http_auth.username && http_auth.password) {
+		if (!used_negotiate && http_auth.username && http_auth.password) {
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
+			http_auth_methods &=3D results->auth_avail;
+			http_auth_methods_restricted =3D 1;
 			return HTTP_REAUTH;
 		}
 	} else {

That, of course, is totally untested, and I don't have Basic auth
fallback set up on my server with Kerberos, so I can't test it.

> I suspect we could hack around it by pessimistically guessing that
> GSSNEGOTIATE was the problem. But I'm worried that making that work
> would require up to three requests (one to find out we need auth, one to
> remove the GSSNEGOTIATE bit, and one to retry with a username/password).
> That seems like punishing people with servers that don't even care about
> Negotiate for no reason.

I think my proposal above does that, but I'm not sure.  If Negotiate
wasn't set, we won't need to make a third request, since we'll have
known the supported mechanisms as part of the original 401.  If they do
support both, then three requests will be required if they have to fall
back to Basic auth, but then they're only paying the price for the
environment they have.

If we aren't already reading the supported mechanisms out of the initial
401, then we'll need the third request, but that would be silly and we
should just avoid doing that.

> So perhaps somebody can come up with something clever, but I suspect we
> may need to just revert this for the v2.32 release, and re-break the
> case that 1b0d9545bb8 was trying to solve.

Yeah, I think this is the right solution for the problem until somebody
with a suitable mixed auth environment shows up and can test.  Your
patches seemed reasonable and, as always, well explained.
--=20
brian m. carlson (he/him or they/them)
Houston, Texas, US

--5/ZT8EriNMNS/JgT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.3.1 (GNU/Linux)

iHUEABYKAB0WIQQILOaKnbxl+4PRw5F8DEliiIeigQUCYKRYAwAKCRB8DEliiIei
gVTvAP9EAjN5rWP89sIvKU15YwsXu52UhBTYkFt6YfStAGc41gEAry84ucsHvxWw
ebXPOlxnQsAD/o8FE3RnB9Bsn/u9pA8=
=BG/7
-----END PGP SIGNATURE-----

--5/ZT8EriNMNS/JgT--
