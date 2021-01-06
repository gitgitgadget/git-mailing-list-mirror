Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07F9C433DB
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 608872310D
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 10:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726324AbhAFK3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 05:29:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:54447 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726231AbhAFK3S (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 6 Jan 2021 05:29:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D0125C017C;
        Wed,  6 Jan 2021 05:28:06 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 06 Jan 2021 05:28:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=O1b3VFxLppYVqrCT71KjI7vDTqf
        Cmoo6chhh+17p7h0=; b=fxlqfhRWBG/m0FvKWOtuM5CmsrK3JsFnKmYSyNWLWMJ
        TGGbeT0WOyRSevBrLGvEYfhYUfp5LsQ9RUmx/pVCuaZFyuutLONePe0rXRAqOo0N
        1zm34iB8IykKOwibZCzG6mOe5AnAW5lHxMoxRS0GIpkZZ8KhFzyNMcGUbPvOCI7h
        F/DsQJ12WMikDBZZwu8DrZ87Muk6F/OsGCeRR86zay5CCHpaglbh5gL/526Ht0Y+
        WFDbA4SJxlT5XNlH4m9vAoVN9AQsPR6z+o4ghpmemM/sxdTknwr7ugh1H/HTa3YG
        fDCE1rFmalGJKjsRQxbyhmq2dTFZWA1SRZlPbQgSrKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=O1b3VF
        xLppYVqrCT71KjI7vDTqfCmoo6chhh+17p7h0=; b=dv2PGB4UCFXnjvXpkks1DB
        sTs2QTWv0os8CNHIwQy8Y1zVmMrIl81TLlz3noVdo22tx90P21HnchNEDZQ5j20G
        HasurdKjOgeb0YTb8oV4oEUpf+6o8gG92WcdxlcYVtqyCtpRTjY6xq25fFk4hWjI
        O1rKnNAIHeKdXRvip4A+ZZZdT75HuPhwt5iI2QAXsXdjTRcM4C6OGQd6W/cAnNhm
        I9SK40FPGevZn+FFgH2hGUwmE4koWb/A/uDWSqDcMwQCzCxQC/rYLI2xU6JMazr2
        2B9o7AGyXJiqiZGMsjEViEsPzEDDA0nQYCxRJkSYRNKxnwFgArQ6V+6P+JGRL+Lg
        ==
X-ME-Sender: <xms:tZD1X_Fp_-JY1mWD3d5rhoogfVEhFwUoWYMO_U_RSTzsN7f5K0D7Zg>
    <xme:tZD1X8W9EBDzN2Vm4UpEhl1PuqI40w5Dra0fSmX-tzrDkOW1IQcBch_HCb9EoiET6
    VOeeCdjM1YvDF4a0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdefledgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeiuddrvdefheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:tZD1XxIjnKDNYvyYPGcXnKFNnHSXpeNzvTaKq5Up53EHbwGF8dgCAw>
    <xmx:tZD1X9GGeN_qxUv1J24woSD0fJJs6RoHoOR1RnwxuvuIWz5o4Hh4jw>
    <xmx:tZD1X1XxYDK0Aw3rA0DbN6jclY1blDAiFSdBS9zZcbhoSnFkTUET0A>
    <xmx:tpD1X4Tu4D5OLR4l8nKaSpqSn5la5FY60qRla1qS8N3YXiJu9Iw-IQ>
Received: from vm-mail.pks.im (x4dbf3deb.dyn.telefonica.de [77.191.61.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id B14E11080063;
        Wed,  6 Jan 2021 05:28:04 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 198fc643 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 6 Jan 2021 10:28:01 +0000 (UTC)
Date:   Wed, 6 Jan 2021 11:28:00 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: Re: [PATCH v5 8/8] config: allow specifying config entries via
 envvar pairs
Message-ID: <X/WQsO47uhgvrcaS@ncase>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
 <dfceffd8d4fbc3c99cfa7c5d838e4c3a2db6598a.1608104755.git.ps@pks.im>
 <xmqqczz06x83.fsf@gitster.c.googlers.com>
 <xmqq1rfg6vcz.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="pB0JwAqS6/Rwe6Ve"
Content-Disposition: inline
In-Reply-To: <xmqq1rfg6vcz.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--pB0JwAqS6/Rwe6Ve
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 23, 2020 at 01:55:08PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>=20
> > The same problem may exist in new paragraphs in git.txt that
> > describes the "--config-env" stuff.
>=20
> Here is what I tentatively queued on top of these 8 patches as a fixup.
>=20
> Thanks.

Your changes look good to me, thanks!

Patrick

>=20
>  Documentation/git-config.txt |  8 ++++----
>  Documentation/git.txt        | 29 +++++++++++++++--------------
>  2 files changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/Documentation/git-config.txt b/Documentation/git-config.txt
> index b71c1ac7b8..67eb40f506 100644
> --- a/Documentation/git-config.txt
> +++ b/Documentation/git-config.txt
> @@ -348,10 +348,10 @@ GIT_CONFIG_VALUE_<n>::
>  	pairs are processed. These environment variables will override values
>  	in configuration files, but will be overridden by any explicit options
>  	passed via `git -c`.
> -
> -	This is useful for cases where you want to spawn multiple git commands
> -	with a common configuration but cannot depend on a configuration file,
> -	for example when writing scripts.
> ++
> +This is useful for cases where you want to spawn multiple git commands
> +with a common configuration but cannot depend on a configuration file,
> +for example when writing scripts.
> =20
> =20
>  [[EXAMPLES]]
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 80fb8fab11..3b0f87a71b 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -81,25 +81,26 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string w=
hich `git config
>  --type=3Dbool` will convert to `false`.
> =20
>  --config-env=3D<name>=3D<envvar>::
> -	Like `-c <name>=3D<var>` except the value is the name of an
> +	Like `-c <name>=3D<value>`, give configuration variable
> +	'<name>' a value, where <envvar> is the name of an
>  	environment variable from which to retrieve the value. Unlike
>  	`-c` there is no shortcut for directly setting the value to an
>  	empty string, instead the environment variable itself must be
> -	set to the empty strin. Errors if the `<envvar>` does not exist
> +	set to the empty string.  It is an error if the `<envvar>` does not exi=
st
>  	in the environment. `<envvar>` may not contain an equals sign
>  	to avoid ambiguity with `<name>`s which contain one.
> -
> -	This is useful for cases where you want to pass transitory
> -	configuration options to git, but are doing so on OS's where
> -	other processes might be able to read your cmdline
> -	(e.g. `/proc/self/cmdline`), but not your environ
> -	(e.g. `/proc/self/environ`). That behavior is the default on
> -	Linux, but may not be on your system.
> -
> -	Note that this might add security for variables such as
> -	`http.extraHeader` where the sensitive information is part of
> -	the value, but not e.g. `url.<base.insteadOf` where the
> -	sensitive information can be part of the key.
> ++
> +This is useful for cases where you want to pass transitory
> +configuration options to git, but are doing so on OS's where
> +other processes might be able to read your cmdline
> +(e.g. `/proc/self/cmdline`), but not your environ
> +(e.g. `/proc/self/environ`). That behavior is the default on
> +Linux, but may not be on your system.
> ++
> +Note that this might add security for variables such as
> +`http.extraHeader` where the sensitive information is part of
> +the value, but not e.g. `url.<base>.insteadOf` where the
> +sensitive information can be part of the key.
> =20
>  --exec-path[=3D<path>]::
>  	Path to wherever your core Git programs are installed.
> --=20
> 2.30.0-rc1-197-ga312a798fc
>=20

--pB0JwAqS6/Rwe6Ve
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/1kK8ACgkQVbJhu7ck
PpSXyw//cKCkkW1ip7b1az4w6Ues6FwXCvTHXjBlsqOtJu2ZO2W9mEJgoJI8qsTB
9hfO/eevqo/zP76IDZpiVRfTKBdq99V9pvUSK6PEUsX56oKfp5rPy/IIUsnFgYJW
TkOhcFELzJqo9BrJf1WzjgFCO5e4XAlIcJlvwO0qXJu2hIEqvDuBOt2vbijWJSGc
cCe8qYShvRbHmoFiWC+Cv6FJlLfaXhupO6SNu3QcpZQjWlA7bdw/fVVky1jkASP6
peBGaW6dhJlWQxRt1bQZ2ZyVmezuApzd/EG8zk3nypqMJglrL+wOc3wfv9uN+I4g
IHDpICqpNBwnrBUEzzfYn9twyx9N98tCZ4befif1I3GbClyQnGrYvoWkMEpqWS90
9Br6keZOjrQrbXJi+zWUm30ArjbYsyIubE7Z0kwQpvLEQS6WVcgoeKkf1KIVTZIM
e2iX7DweSID4VTH44OgJc5ykGDSFYirVeyq2CS+usc6SuIAoQrlJjeo59kqA46s1
xksPM4nR/Kfj6hmkJvCVtMrYHtsUCc63iBGW+jo1EHEc5C7xujlZZEQviHZ5arR5
xCqRYoScHx97JicqhR6bLn+SwwJiVW/YvFhKWGq0Vx23DWJOe9pMhK+BoVzGkLb1
Y9FlD+tlKDBhOnpvBcm4L61xCP+16gkrK3nti+mBuJd5OcOsgms=
=C1Dn
-----END PGP SIGNATURE-----

--pB0JwAqS6/Rwe6Ve--
