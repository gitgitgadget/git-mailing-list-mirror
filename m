Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EEC1C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:35:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1697364E5F
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 06:35:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230520AbhBRGdk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 01:33:40 -0500
Received: from wout3-smtp.messagingengine.com ([64.147.123.19]:58345 "EHLO
        wout3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231233AbhBRG3D (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 18 Feb 2021 01:29:03 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BDD15882;
        Thu, 18 Feb 2021 01:27:46 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 18 Feb 2021 01:27:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=3oaM4VhPwpCdeUpX2P4v2ug4jHM
        rfheoVRj0RyE8taE=; b=aEZ50Rqpub9U6edBnv4mMJk2DFkgrAT4wO5Ys3oekm9
        DgA8b+yxwYgXvq7sxxOOmRMTX9RUK7L1NdvjXceq71DgfxQFw4l9WZrdnENocSfo
        PsEay/GiaIFCClvV9Ua28oW45isy37A4/Y/3NuQvdKVf9mYBsf8/6Rswcjh1yoUe
        Gfe5GC/FolGFNYDLOH4caUe5Rmybh7UKVb4HzMYcsWIXIDWm5jXJpvru1uB7+vA4
        K7mL6ul3v4Cc+RRPc06K/Dom6Ve5BbuTXEFmsPbXsBWbyYYfYRWKAT96IoUM9egZ
        S6HakXKKylxVXMgoUfSTUdwkGjOoK2ERpOIqHPZlN/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3oaM4V
        hPwpCdeUpX2P4v2ug4jHMrfheoVRj0RyE8taE=; b=WFn1zwdoBQowrOmXd7SBax
        uAomb3jaLJ4LsEmDPTI7WLfW3omoGeIxDhs8CPaYgRek0dej6LKm3nYS6NOJfcY+
        epD+kkofw8Ez//M/EUdB4BoYgW+Y4ApfeiRQguKmoh4Oll58IHBimSSHZTm0qDpm
        lEoOtotTOZtfMIGhYUMBhfBwFt5hH3ONd9KsaXdr4fDjyeCQIzrP3NNStlIeLyy1
        I343c+f1Su8s6PHnRYlX/fomwfEBNiA98eKl9ocvZGFfWoNfrZdCbUfzQz0+Rh6r
        rfu4t4XW+CprTq7EXrAkl0AJDJDvzocK3kQUJgbEzEbIIYLwPXgI+zAHmYfwSzqg
        ==
X-ME-Sender: <xms:4QguYNdKwdMVsy4p5BnFymgpDFtqsmCnyjdWXOu7SfYnNsB-9iDxVA>
    <xme:4QguYLMjtIoCQgCrtCok8ZcElKFkB8NZ4HgjM-zKEitybPtSQmmwKE7sFXYaPqvjO
    OtyTgzq608i0btR5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrjeefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    ephefgjeeuveejteduhefgffefffdvjeefjeeivdekfffgkeeugfehveetueefleeknecu
    kfhppeejjedrudefrdegrddugeelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:4QguYGhdKgGADS_eIzfKUk2KybEiUTjgX7Ko6KyblsbJPwKZLzOr8g>
    <xmx:4QguYG-huB_SrqI5LC-wPhgbzbs6NsvjAhPEF_CVPPrlpZiHauK3Yw>
    <xmx:4QguYJs6PrPKQ9jou-TnKz5f0w0btH4jQLY4f5H1pxDp6ukrWOAIZA>
    <xmx:4gguYKXLciRXiC169pgjtSA5DHd0Uhlx_5OqVSXKsbEJaQ16h3OCUw>
Received: from vm-mail.pks.im (dynamic-077-013-004-149.77.13.pool.telefonica.de [77.13.4.149])
        by mail.messagingengine.com (Postfix) with ESMTPA id 171751080059;
        Thu, 18 Feb 2021 01:27:44 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 41a8d17e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 18 Feb 2021 06:27:40 +0000 (UTC)
Date:   Thu, 18 Feb 2021 07:27:39 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Martin =?iso-8859-1?Q?=C5gren?= <martin.agren@gmail.com>
Cc:     git@vger.kernel.org, Sergey Organov <sorganov@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 2/3] git.txt: fix monospace rendering
Message-ID: <YC4I20bQ0jeNLO+M@ncase>
References: <cover.1613590761.git.martin.agren@gmail.com>
 <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="PXyMZnxnBu7tKhOO"
Content-Disposition: inline
In-Reply-To: <97c686dd7ba1bbd1c0be6f7f61a3a033adf8adb6.1613590761.git.martin.agren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--PXyMZnxnBu7tKhOO
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 17, 2021 at 08:56:05PM +0100, Martin =C3=85gren wrote:
> When we write `<name>`s with the "s" tucked on to the closing backtick,
> we end up rendering the backticks literally. Rephrase this sentence
> slightly to render this as monospace.
>=20
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  doc-diff:
>  --- a/.../man/man1/git.1
>  +++ b/.../man/man1/git.1
>  @@ -77,8 +77,8 @@ OPTIONS
>              setting the value to an empty string, instead the environment
>              variable itself must be set to the empty string. It is an er=
ror if
>              the <envvar> does not exist in the environment.  <envvar> ma=
y not
>  -           contain an equals sign to avoid ambiguity with `<name>`s whi=
ch
>  -           contain one.
>  +           contain an equals sign to avoid ambiguity with <name> contai=
ning
>  +           one.

Over here you're also dropping the backticks, while...

>              This is useful for cases where you want to pass transitory
>              configuration options to git, but are doing so on OS=E2=80=
=99s where other
>  Documentation/git.txt | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index d36e6fd482..3a9c44987f 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -88,7 +88,7 @@ foo.bar=3D ...`) sets `foo.bar` to the empty string whi=
ch `git config
>  	empty string, instead the environment variable itself must be
>  	set to the empty string.  It is an error if the `<envvar>` does not exi=
st
>  	in the environment. `<envvar>` may not contain an equals sign
> -	to avoid ambiguity with `<name>`s which contain one.
> +	to avoid ambiguity with `<name>` containing one.

=2E.. here you don't. Is this on purpose?

Patrick

>  This is useful for cases where you want to pass transitory
>  configuration options to git, but are doing so on OS's where
> --=20
> 2.30.0.284.gd98b1dd5ea
>=20

--PXyMZnxnBu7tKhOO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmAuCNoACgkQVbJhu7ck
PpTxUA/9F1mfP1sflZyEYAxvBtwZ0DLYlB+L2FaGieQAIQ9GP8RFMyfZbNMIBkYo
m5qNr+XMVgp325nHxQ2cCSqaz7kWsaKtY+ilqNJzZ6JppEMvdANMB4rEFbQQhGDF
zb7B/DHdSG9RG78iPkdFJLnjMQ4BElcQtoMKvItTQ5xRCjUzRlhY0wgg7kXbeB1D
5llLT4P9mZTmSs8+xWM0ccv0+C7G+UiaU2ZPy2WHa51yi4XAhaX32ykXnTeV6poJ
DGq5Rh1ouo9U9ao/DqXCsCouXfBEmGf9t2yZaZK53ietKAcz8C0EPPPKr2BEWSLd
Hrv0/+4aJyBVwINLdME8YWy5azGk0fYuoI1V9Ek3PKNF79R8k876su4U3wOFrPxr
VKEABmJ7g/IGf04QMMG7islHoo0Ihr7NqfH9V6nTV/GcPyRrwVOABZ74AWIo9tI5
XoerpXWWF8+xMR5/+u2NGE5Q2+ctky+j2khLRnthiCSe/dVPs38LoW2DVJQ0bcrz
zXGxzLWfB1Eg0SwoHR7af6OgNmVv0oTT0jF5zXvBY8ieUd1niod3mU/J8ObWd23j
9fVvPnE+5KYeD8QKisiVC4pMBIF6apIJazB6so3VxulE76lnfbmql2UDG8vz89X4
DqXEd7wqXBdkNBEMoUbmdSLia82ED4QzSWWjYEs2VS1gWMA1dVE=
=L3V8
-----END PGP SIGNATURE-----

--PXyMZnxnBu7tKhOO--
