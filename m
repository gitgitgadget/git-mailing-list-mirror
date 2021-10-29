Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A8F4C433F5
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:07:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E9656044F
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 21:07:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231390AbhJ2VJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 17:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230215AbhJ2VJb (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 17:09:31 -0400
Received: from mail.archlinux.org (mail.archlinux.org [IPv6:2a01:4f9:c010:3052::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B128C061570
        for <git@vger.kernel.org>; Fri, 29 Oct 2021 14:07:02 -0700 (PDT)
Message-ID: <aef5409c-384e-1010-9f33-e3bfe1aa0685@archlinux.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1635541620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vewy8g3S34I5M8pe60MmsmtHk4fM5RvpGoMw4bk1G3E=;
        b=gC8RZyfqakEKWMT4BUtpuUJslPevMgknbiot+zmwlHlHZ9mMyL8aLhH4Fcz2PJdIG37hlq
        SJqCBzYUkmXfE2xny9RjGOLSTvL0w+pkIu6mATeBR1yQMUbCZ/XPsxyY4GMqH0z574sych
        AtKd8cNBgJZxPf2cxhW0mmTfu1jRaTV8m8z+fWM1yJgdkUlNcj4XKSmxOPo0JPMpjKy/d9
        xM8kqlLftq/pEFnUgFBUwEr7LcUCzUoVK5O37Q4MMTBp/OEiK2VpPUfoKPjst30IPSsyBz
        b3UQ5SLRt1DJmpqI857W2Js/PiDzhoIB42mfT8DOKF/dmFYt6nUm9BP0y1JhZuPO0fQpxg
        MDTxDpdbz7c5oa0+V7lE0FR/2LIRSWE3xPFE5R4RFsJOU4KEeBQl9LJTm/kRYp0Q117vV9
        g0FfdyIHkgIqwAGBb6dM3m9yWmAvRwzGJuzpehZVyNLU2gkteAFcrCkJyBgbjKbrniyte1
        Te0M3FSfJ7Ebvsj25E4Ty5aC6Vx8zrnPhYl3a4+sE9UjF5M71vNTqTvL3nrv1S60vaNgLh
        Whia3FmAL5mIAwtHo58dea0JvjENxTJV/CUxMI+TWKEHBHpRtAT1MaycKNtEevHkgsuTM9
        87xj9zwpbUVbAUrD/UsCFEHsU3gPUPEGEHVADxxPsn5R5UdWv1nSg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1635541620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=vewy8g3S34I5M8pe60MmsmtHk4fM5RvpGoMw4bk1G3E=;
        b=oLjZYLhvfk9z52BWgnXV1BZiNlml1FHUdWseFZBb3cJb7wkZzLyTduNX2/61M2IW/Mp8G4
        9xSQuDG+C1+h7QAg==
Date:   Fri, 29 Oct 2021 17:06:56 -0400
MIME-Version: 1.0
Subject: Re: [PATCH v3 1/3] pretty.c: rework describe options parsing for
 better extensibility
Content-Language: en-US-large
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-2-eschwartz@archlinux.org>
 <xmqq35ojlhg6.fsf@gitster.g>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead: GNU Terry Pratchett
In-Reply-To: <xmqq35ojlhg6.fsf@gitster.g>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------oNDmCSgFMpyYH0ccw6jEQstT"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------oNDmCSgFMpyYH0ccw6jEQstT
Content-Type: multipart/mixed; boundary="------------nrXM0RasDhLEHvEIzDq7qjc8";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Message-ID: <aef5409c-384e-1010-9f33-e3bfe1aa0685@archlinux.org>
Subject: Re: [PATCH v3 1/3] pretty.c: rework describe options parsing for
 better extensibility
References: <20211026013452.1372122-1-eschwartz@archlinux.org>
 <20211029184512.1568017-1-eschwartz@archlinux.org>
 <20211029184512.1568017-2-eschwartz@archlinux.org>
 <xmqq35ojlhg6.fsf@gitster.g>
In-Reply-To: <xmqq35ojlhg6.fsf@gitster.g>

--------------nrXM0RasDhLEHvEIzDq7qjc8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 10/29/21 4:11 PM, Junio C Hamano wrote:
> Eli Schwartz <eschwartz@archlinux.org> writes:
>=20
>> +	struct {
>> +		char *name;
>> +		enum { OPT_STRING } type;
>> +	}  option[] =3D {
>> +		{ "exclude", OPT_STRING },
>> +		{ "match", OPT_STRING },
>> +	};
>=20
> I floated OPT_<TYPE> in my earlier illustration as "something like
> this", not "literally use these tokens".  We have CPP macros of the
> same name in parse-options.h API---we may not see troubles from the
> name clashes today, but let's not leave it to chances.
>=20
> Perhaps call it like DESCRBE_ARG_STRING or something that ensures
> uniqueness like that?


Ah. That alternative seems a bit long though. :( Without breaking enum
type into one per line, it will quickly overflow line lengths... though
maybe it should be one per line anyway?

Will try to put some thought into naming.

--=20
Eli Schwartz
Arch Linux Bug Wrangler and Trusted User

--------------nrXM0RasDhLEHvEIzDq7qjc8--

--------------oNDmCSgFMpyYH0ccw6jEQstT
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmF8YnEACgkQzrFn77Vy
K9aN8hAApqBv7nx0YXSIEEWfvm580RBi6zebJgtkaQpg01T8LivyQGD/wejQpFaD
0tw5qKSPmPTg8rvIGAK+DdNJuBYIP/mkVLAiUH/wvlaJJWwRhMF9dVVMrq9GATH/
x2UuroHLcXOF+k+iDT9d0arX0BZmzk+Y3u9ACZvV9z4I03nWioGEIUePvEDcddei
yW/jFeNzRGNSaY/hOQDOr+yQSBUVGp04YDeMqWp8lviCVFuro4+muapGnjOPIXgo
iNWlVeezprIcqHAtAN+/O6sDSePMK/h1dLToGY6O6/u/hBsGLtzjDTsunTnN/dOK
zKRrUNhTZ5qfGZJlTk1X9STEVNSovGuPgvM5DzvfE8RzCEAEkDGVNR6PDxYsa4TR
tinz8nvvA1X0VxtBCayFQX8vJmEW1iVyP+/fCG5MMkGCw+lxERcSJqGk7Yu8wqjF
nvVzBLxEJGFmPB0Fb2z0+L2MQL6PnxLdjIjOUev83cIz8FUWQozISB0DQgh5mVSn
Nt/wJTPDTRaXpA6YBZsUZo8+C75HakCAsUmmtAqncxj6Y5Xs7ygLgcMJxBXt5IOM
PkCEHzOHj8sMLzP8faOrVQshC+Y8ltIYgzmzw1mahtVVcE4pbSGGkY70+PIwKH4q
yfgUzpgwBdBI3Q6s1ZEXMl8KkL60nn+Kyo8NNIp0QNr/xObRgUc=
=OpU6
-----END PGP SIGNATURE-----

--------------oNDmCSgFMpyYH0ccw6jEQstT--
