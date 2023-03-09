Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8497C64EC4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:51:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCIKvN (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:51:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCIKvL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:51:11 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3931E190E
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:51:07 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id e13so1384397wro.10
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359066;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=haZIQxmnrMBQobbabaYTp38OkQQJ+yBY/HDijLxVLYM=;
        b=W5N5nqansTbY7L7AYplZVAIYNn+43DRe7CxIJIpRlxviBEzA/lkbHNCsUiVRWQvTVJ
         rj49CYyD9wMVxIbLjWFiLodafjkGzQ35pNJoT2LrIbXZIte/AxVNa2Fe/xNHnM6VkHOC
         3XOwYjlkL+K3750VnRK/LCMpssDRvacT8SepJt0nnvwTfy4YJzBqNVRTdHC7UbH5NgDS
         SIKkHLJS2+wyTJh/Ap9lYbFDmho4OGJ/Tl+eHx7AxyfYPi4YzSWLNpX95yLdYZ/GR841
         QpJfbndlaZDrbPJ62ol5pDyIIXV54xet1DSfzLUxc8YfyzVh97+RMzCS7T4aN9JvCpFF
         8lRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359066;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=haZIQxmnrMBQobbabaYTp38OkQQJ+yBY/HDijLxVLYM=;
        b=XrOFz+aFmGFjEUztA7yNl2eFNZ40VfNJofwctZpPk56NrIQyWWfqw+JROQuOoJ7wrn
         Tv8Yb3xKa7+MvgdBkVOnIL8LCHdGiFtC0rJZNPiIGdwoweDcO+srdswBdY0TwL/9tbLv
         p/8KNilmiWZQ6QvDurT8+xmEd5VNltaN6P6by73NRq676mq+RmcSCPU2ls+w6h3MVGhQ
         I8T89U/+b28z0T/+fOuVMfKaeNaQWb35zcO+kuxGXx0w0kcZCSca+u6DZv1hmyIxxXj4
         uqgjtqUlFiPLPodBnKJQGXe4geIiSj3/NZZyxnBMRnVPIwN2J++GQ8lePNqRR9N8foEI
         li6g==
X-Gm-Message-State: AO0yUKXRHW2ZzdWbyxW0MPGj0bx05ENvVP7W+lQIosWK58H5mattrzMS
        X6EcOBzOVpWawwh/rpLH+O+0hGHxQ+E=
X-Google-Smtp-Source: AK7set/jZmBU7OgG0m8B4ou1wIj+EK6xljWt4ZRNODFu50BEWO9T2mQv0SDOG7yRQNyOg1Irq2Nwkw==
X-Received: by 2002:adf:ee86:0:b0:2c5:3fcb:681e with SMTP id b6-20020adfee86000000b002c53fcb681emr14213625wro.4.1678359066428;
        Thu, 09 Mar 2023 02:51:06 -0800 (PST)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d654b000000b002c70f5627d5sm17375381wrv.63.2023.03.09.02.51.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:51:06 -0800 (PST)
Message-ID: <33be045b-0ac7-ba88-bec7-d805a90580d6@gmail.com>
Date:   Thu, 9 Mar 2023 11:51:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
Content-Language: en-US
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------hkmEGL7C41FDIFeuIYRbrLmH"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------hkmEGL7C41FDIFeuIYRbrLmH
Content-Type: multipart/mixed; boundary="------------7L2ncFAkwLx6bc0IqmsAq2ah";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <33be045b-0ac7-ba88-bec7-d805a90580d6@gmail.com>
Subject: Re: [PATCH 3/5] diff: add --default-prefix option
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>
In-Reply-To: <ZAl4MkWVV8fr+3fO@coredump.intra.peff.net>

--------------7L2ncFAkwLx6bc0IqmsAq2ah
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 3/9/23 07:09, Jeff King wrote:
> You can change the output of prefixes with diff.noprefix and
> diff.mnemonicprefix, but there's no easy way to override them from the
> command-line. We do have "--no-prefix", but there's no way to get back
> to the default prefix. So let's add an option to do that.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Alejandro Colomar <alx@kernel.org>

> ---
> This isn't strictly necessary for the series, but it seemed like a gap.=

> You can always do:
>=20
>   git -c diff.noprefix=3Dfalse -c diff.mnemonicprefix=3Dfalse ...
>=20
> but that's rather a mouthful.
>=20
> Note that there isn't a command-line equivalent for mnemonicprefix,
> either. I don't think it's worth adding unless somebody really wants it=
=2E
>=20
>  Documentation/diff-options.txt |  5 +++++
>  diff.c                         | 14 ++++++++++++++
>  t/t4013-diff-various.sh        | 10 ++++++++++
>  3 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/diff-options.txt b/Documentation/diff-option=
s.txt
> index 7d73e976d99..08ab86189a7 100644
> --- a/Documentation/diff-options.txt
> +++ b/Documentation/diff-options.txt
> @@ -852,6 +852,11 @@ endif::git-format-patch[]
>  --no-prefix::
>  	Do not show any source or destination prefix.
> =20
> +--default-prefix::
> +	Use the default source and destination prefixes ("a/" and "b/").
> +	This is usually the default already, but may be used to override
> +	config such as `diff.noprefix`.
> +
>  --line-prefix=3D<prefix>::
>  	Prepend an additional prefix to every line of output.
> =20
> diff --git a/diff.c b/diff.c
> index 750d1b1a6c3..b322e319ff3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -5275,6 +5275,17 @@ static int diff_opt_no_prefix(const struct optio=
n *opt,
>  	return 0;
>  }
> =20
> +static int diff_opt_default_prefix(const struct option *opt,
> +				   const char *optarg, int unset)
> +{
> +	struct diff_options *options =3D opt->value;
> +
> +	BUG_ON_OPT_NEG(unset);
> +	BUG_ON_OPT_ARG(optarg);
> +	diff_set_default_prefix(options);
> +	return 0;
> +}
> +
>  static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *c=
tx,
>  					     const struct option *opt,
>  					     const char *arg, int unset)
> @@ -5564,6 +5575,9 @@ struct option *add_diff_options(const struct opti=
on *opts,
>  		OPT_CALLBACK_F(0, "no-prefix", options, NULL,
>  			       N_("do not show any source or destination prefix"),
>  			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_no_prefix),
> +		OPT_CALLBACK_F(0, "default-prefix", options, NULL,
> +			       N_("use default prefixes a/ and b/"),
> +			       PARSE_OPT_NONEG | PARSE_OPT_NOARG, diff_opt_default_prefix),=

>  		OPT_INTEGER_F(0, "inter-hunk-context", &options->interhunkcontext,
>  			      N_("show context between diff hunks up to the specified numbe=
r of lines"),
>  			      PARSE_OPT_NONEG),
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 0bc69579898..5de1d190759 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -643,9 +643,19 @@ test_expect_success 'diff respects diff.noprefix' =
'
>  	check_prefix actual file0 file0
>  '
> =20
> +test_expect_success 'diff --default-prefix overrides diff.noprefix' '
> +	git -c diff.noprefix diff --default-prefix >actual &&
> +	check_prefix actual a/file0 b/file0
> +'
> +
>  test_expect_success 'diff respects diff.mnemonicprefix' '
>  	git -c diff.mnemonicprefix diff >actual &&
>  	check_prefix actual i/file0 w/file0
>  '
> =20
> +test_expect_success 'diff --default-prefix overrides diff.mnemonicpref=
ix' '
> +	git -c diff.mnemonicprefix diff --default-prefix >actual &&
> +	check_prefix actual a/file0 b/file0
> +'
> +
>  test_done

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------7L2ncFAkwLx6bc0IqmsAq2ah--

--------------hkmEGL7C41FDIFeuIYRbrLmH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQJuhkACgkQnowa+77/
2zJz5A//WqBFwyK29qb0poCVplk49d2qn7qeiMkRTWqTPmK2UR2TWRRMyQe3cetk
tlBlryork+4mYaw5apEmQtoIRlwFZWdkoANCjYWosb0qamlbq6ogphbrJhKL12zj
7kSPpcZ8AuMFbQGD/lIhPfgUVsiGpVv8kMse/lno6p1goiaGI41WEY+DAixwpqD8
Igb/5A1G6nuEyhp1JpO/ZGQmKaWt+mpTdfr79AJ0u4NgwLtj7+4mo8IrwhHGaWiU
z5cCMlQz5c3pICU0WHHS6YzNncK/d0pUzH4oxlzhDZLEYd+gb1DWwULicYyefQQR
5Jcs94+q9e9H5S05rZ/9EniCUmcnKsALgYm9wmBYo8mfvjhf8bygX9amlsfREHvs
EMMp0K98Lc7NHsTJds9cwZ+z6v1aEqC1FMXjBnTqMGJpSEBsNAQYcQPDAA4G50Zk
pQH0hM5DOUjag7udCzziBz6sKVJ6qidxt3vsnOxHpcpyByHqb5+YtrADO5TKh6uG
YslY85ACZgZLzK/GQJBf3EaYobZYq1Kq9TMnU/wGXs9MmETE/IG1vg6OIZlvAFRS
CZz7x7jI9qhTKsropKfr6P2hS4kRjD1ecasiTGr/U7D0bbH0yBzP3fQhvNLKG5/C
j/D+94mqLLo+78wizWKz6WmxETlYjvbmZrFJAZCRVa9pmmHBLEQ=
=AClN
-----END PGP SIGNATURE-----

--------------hkmEGL7C41FDIFeuIYRbrLmH--
