Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A95FAC61DA4
	for <git@archiver.kernel.org>; Thu,  9 Mar 2023 10:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229772AbjCIKuv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Mar 2023 05:50:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229685AbjCIKut (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Mar 2023 05:50:49 -0500
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DA7DF701
        for <git@vger.kernel.org>; Thu,  9 Mar 2023 02:50:48 -0800 (PST)
Received: by mail-wm1-x335.google.com with SMTP id l7-20020a05600c4f0700b003e79fa98ce1so935953wmq.2
        for <git@vger.kernel.org>; Thu, 09 Mar 2023 02:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678359047;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YMaVGgn/Jb0SPevIePkVSuLFg6ciQxzBa+HvVTI2wOg=;
        b=Lv9cCAoLx4Imk1ByzU/EPbR/MnLGhNSJjjWYXlHSMEDD0B/zVv1MkJ9TYg05LK0+mO
         wP2OJKsPptrxS/rjJwQ1Y7g/RyOoBvebY+MozjMPqYYj+r2vr6A09zBtSw9aajYCRtbx
         aActPJnKMCEhwuHHPnFF/s70Hv+6Yn8jWLpnAuHb9nDRCCaQbGv7zQLAFlvUaPwulXOG
         OCAOyMsm4LJvtpQEzHhwrxHmBh3DsreEJLpXqRzy4aGGBt1/RzXER3wrzzMnxKBRkgsW
         PQM1JoRTWmN0trXviDw2n/qV+/Afwxxnk6epDu4YlMaA+eBfRT/gmKLcDbWLCx1r1/lT
         cnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678359047;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YMaVGgn/Jb0SPevIePkVSuLFg6ciQxzBa+HvVTI2wOg=;
        b=emnsO6yKWAovrrBTNoqYpwhJ+vOUs11t292EmR7T6WNOj/8xJ6Ma5T4OiyyjmphwQE
         5YC2iVMgbl90fFM1uUuYptSeLPkArmllzArb3ZCeZK2fJxGUDZYjxSYhWrFFnrA5NVwI
         /JnRYsP2QHXsMBDv+nPoxCzuVEt2cI+BgdqkU0knckRDnv0z+TLNPnDVx51Qkcmpk5Y8
         tFw0dnFvNIEsIx0zCRSmNLJNjtAnARQWAY95CNv6oNUgkBpbyxpP8HgUTqvMTnueic7A
         4Lsp4BvJTCsbEN4Q4GrQeWLAEf+vF6Sz0ijmUZiqwDLRf+Kezzio2c+M1evvEvN7RXi5
         WIDg==
X-Gm-Message-State: AO0yUKVIErqQT8+H5WdjpkUnuYnWj+PnGHgdz0l66BJ6cH7bcigNmK8E
        dIQMTjuTfBQOKz2tiTjXGYOzbit0SEg=
X-Google-Smtp-Source: AK7set+/4uGGIYydznU2eNQFEJf6OfWeCtpoXOrPuKZE0CM87NXv2DPjwiFzeO9BrhzuHghq4EN82g==
X-Received: by 2002:a05:600c:a04:b0:3e0:1a9:b1d7 with SMTP id z4-20020a05600c0a0400b003e001a9b1d7mr19446358wmp.19.1678359047041;
        Thu, 09 Mar 2023 02:50:47 -0800 (PST)
Received: from [192.168.0.160] ([170.253.51.134])
        by smtp.gmail.com with ESMTPSA id h19-20020a05600c315300b003db0bb81b6asm2397058wmo.1.2023.03.09.02.50.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 02:50:46 -0800 (PST)
Message-ID: <62c59063-e168-57b0-43d5-be7f007c2d37@gmail.com>
Date:   Thu, 9 Mar 2023 11:50:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/5] diff: factor out src/dst prefix setup
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl3iqcSL4PODx01@coredump.intra.peff.net>
Content-Language: en-US
From:   Alejandro Colomar <alx.manpages@gmail.com>
In-Reply-To: <ZAl3iqcSL4PODx01@coredump.intra.peff.net>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------rtomisz8rlt92ruzACsUZDcO"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------rtomisz8rlt92ruzACsUZDcO
Content-Type: multipart/mixed; boundary="------------SMcGL1pqXlKw4RMp0Kn8vSif";
 protected-headers="v1"
From: Alejandro Colomar <alx.manpages@gmail.com>
To: Jeff King <peff@peff.net>
Cc: Git Mailing List <git@vger.kernel.org>
Message-ID: <62c59063-e168-57b0-43d5-be7f007c2d37@gmail.com>
Subject: Re: [PATCH 1/5] diff: factor out src/dst prefix setup
References: <ZAl3bHB9zxjLITgf@coredump.intra.peff.net>
 <ZAl3iqcSL4PODx01@coredump.intra.peff.net>
In-Reply-To: <ZAl3iqcSL4PODx01@coredump.intra.peff.net>

--------------SMcGL1pqXlKw4RMp0Kn8vSif
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 3/9/23 07:07, Jeff King wrote:
> We directly manipulate diffopt's a_prefix and b_prefix to set up either=

> the default "a/foo" prefix or the "--no-prefix" variant. Although this
> is only a few lines, it's worth pulling these into their own functions.=

> That lets us avoid one repetition already in this patch, but will also
> give us a cleaner interface for callers which want to tweak this
> setting.
>=20
> Signed-off-by: Jeff King <peff@peff.net>

Acked-by: Alejandro Colomar <alx@kernel.org>

> ---
>  diff.c | 19 ++++++++++++++-----
>  diff.h |  2 ++
>  2 files changed, 16 insertions(+), 5 deletions(-)
>=20
> diff --git a/diff.c b/diff.c
> index 469e18aed20..750d1b1a6c3 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -3374,6 +3374,17 @@ void diff_set_mnemonic_prefix(struct diff_option=
s *options, const char *a, const
>  		options->b_prefix =3D b;
>  }
> =20
> +void diff_set_noprefix(struct diff_options *options)
> +{
> +	options->a_prefix =3D options->b_prefix =3D "";
> +}
> +
> +void diff_set_default_prefix(struct diff_options *options)
> +{
> +	options->a_prefix =3D "a/";
> +	options->b_prefix =3D "b/";
> +}
> +
>  struct userdiff_driver *get_textconv(struct repository *r,
>  				     struct diff_filespec *one)
>  {
> @@ -4674,10 +4685,9 @@ void repo_diff_setup(struct repository *r, struc=
t diff_options *options)
>  		options->flags.ignore_untracked_in_submodules =3D 1;
> =20
>  	if (diff_no_prefix) {
> -		options->a_prefix =3D options->b_prefix =3D "";
> +		diff_set_noprefix(options);
>  	} else if (!diff_mnemonic_prefix) {
> -		options->a_prefix =3D "a/";
> -		options->b_prefix =3D "b/";
> +		diff_set_default_prefix(options);
>  	}
> =20
>  	options->color_moved =3D diff_color_moved_default;
> @@ -5261,8 +5271,7 @@ static int diff_opt_no_prefix(const struct option=
 *opt,
> =20
>  	BUG_ON_OPT_NEG(unset);
>  	BUG_ON_OPT_ARG(optarg);
> -	options->a_prefix =3D "";
> -	options->b_prefix =3D "";
> +	diff_set_noprefix(options);
>  	return 0;
>  }
> =20
> diff --git a/diff.h b/diff.h
> index 8d770b1d579..2af10bc5851 100644
> --- a/diff.h
> +++ b/diff.h
> @@ -497,6 +497,8 @@ void diff_tree_combined(const struct object_id *oid=
, const struct oid_array *par
>  void diff_tree_combined_merge(const struct commit *commit, struct rev_=
info *rev);
> =20
>  void diff_set_mnemonic_prefix(struct diff_options *options, const char=
 *a, const char *b);
> +void diff_set_noprefix(struct diff_options *options);
> +void diff_set_default_prefix(struct diff_options *options);
> =20
>  int diff_can_quit_early(struct diff_options *);
> =20

--=20
<http://www.alejandro-colomar.es/>
GPG key fingerprint: A9348594CE31283A826FBDD8D57633D441E25BB5

--------------SMcGL1pqXlKw4RMp0Kn8vSif--

--------------rtomisz8rlt92ruzACsUZDcO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE6jqH8KTroDDkXfJAnowa+77/2zIFAmQJuf0ACgkQnowa+77/
2zL56Q//d20mCbbY+eKAzB2qezu/bzND8g9T3M4Qiq4UVXfD3TbHkb6Z5cxA3SHJ
cWqE+HFIRs/T8wr/OwKaxhhCA53Qwr6Wlu3hwud7NmRhSESV7n8uqdgt9kyZeVOf
Sql9ACjdMIXNFYnmF1M4VnHxx8y8N16r78A88RkSA/rIctNXNuw3Xd0G9T5GDvzI
zj9Yo8wu5CgrZTZVALUsHzyjgIdP6F8sRRixlMXGfyfoBL/G1rej/5Osz9o5SCQj
wxnNxRPErQnEwrqg1cXj16n1phFQ9W4aBSOfq0+MvfGa0PB0A2VLtSY34avkGDrV
QjGuiMOj7h4+n2dlMKl42IkqfOJyA7vWLHjkmB5q2vdrZezQw/iAK0mzAb73gq5U
EFBVAsCdmk6MQWEvA5+zHHU0Zjw1NWSu6uPn85ldAgTUC/Z3oC0/3Kre4BDuFSK8
ywtOHJfT503fR2hiBgTFtLCzAaP1IOsxIrsZE438dstYk9EdAQX9G41h70KbyOoT
grFfB5VpMhHsylSuu8d9k6bMK31n1sXxpVQD1Xj2MS1db3je7f6+6Of4TdYgnV1B
IvX8s8gUUsnABxXKqSGG2gw/Z7g/hr7rjQGpOBjMszReS6yLNCvLIUlkJG9WHNjw
+jQutb89PDYG7H8KGpYCSr8buNgDVr1q8OrdKlwMcBEJSdsK0Vc=
=kUyT
-----END PGP SIGNATURE-----

--------------rtomisz8rlt92ruzACsUZDcO--
