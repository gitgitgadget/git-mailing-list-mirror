Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF8E7C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 05:07:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 687A264DCF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 05:07:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbhBPFFM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Feb 2021 00:05:12 -0500
Received: from mail.archlinux.org ([95.216.189.61]:48460 "EHLO
        mail.archlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhBPFFL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Feb 2021 00:05:11 -0500
Subject: Re: [PATCH 1/2] pretty: add %(describe)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-rsa; t=1613451868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlBa2rYCcZd60o1V2gyZHWhJSOKrPcwtEyEPDxGToIg=;
        b=TBEQZUw9pXnzeniLvUsmt8gwOwoCnfOKB4JioVENjCicqQSKuLxGGDmmTko4zYSb7JQKgn
        9iu/CbWXh+cFWKKfulwp6Vcsdia22QV+rEVBRGuH2HYBj364n1yOeImCX2u8pVZy7zmear
        TKiTzZEZybvwlTiCH6V/C9SMbP3PZHtU92LdmK+qDHuH1kVmjiRFFGn2xAv6u+jcrBnaOG
        VlkyZnHaWt18edSAwCzpeqrUsSYOv+UB3DBblQ0XwxVttsduaCwrdApIEdUGt/Nf7nslkb
        BJ9VmUkMQmWlA5FlPuHhQVM2iHQA/ZQQA8kUxGQ5OrelHCDBwOpR5cHJ8lrJNehgaCV5I+
        EeADjDwhVgHlFDPgSR91v54lreXyoLt+88i14zDLAsogUE04g05ZztGzvk74wEBlePGqll
        M4Y6+XmPNjo5/j/wJtuyy1T0FEIVfiZmnj2TR7dVVZDXU60FvrSxpr76EiUbv+UBf0q/vo
        5MzjYVF9gZIXZO/qCNSfGlTJKtecAVx1DbZjrFu6tdGm6j+FHbfA6XgQtSbEUjm7fssDIr
        y3ENLa3AyD1ez8uc7VH51b0IQuWXCvVJSFMZEHHfBpO79JvT9bZ2gWiRaTFYbwpZeYzPGi
        iX5H/Sklouky1WASiswBAIr+l5Ag9q5aG8puGtMMFKajb4+jiVuj0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=archlinux.org;
        s=dkim-ed25519; t=1613451868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JlBa2rYCcZd60o1V2gyZHWhJSOKrPcwtEyEPDxGToIg=;
        b=EeRsaOCxttImRvS8fKd5AJQ7WpMH31zqJyiDFWjI/gqnjgx+VILBhmDauuf++dHBefqSyd
        KGGR/NtXBdI8HhCg==
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
From:   Eli Schwartz <eschwartz@archlinux.org>
X-Clacks-Overhead:  GNU Terry Pratchett
Message-ID: <e11d8bec-8a78-5e00-014c-7904b9ffcb25@archlinux.org>
Date:   Tue, 16 Feb 2021 00:04:13 -0500
MIME-Version: 1.0
In-Reply-To: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pg0kI5jnhyiyRcGnVrXZdVdsLOB3bH7Ag"
Authentication-Results: mail.archlinux.org;
        auth=pass smtp.auth=eschwartz smtp.mailfrom=eschwartz@archlinux.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pg0kI5jnhyiyRcGnVrXZdVdsLOB3bH7Ag
Content-Type: multipart/mixed; boundary="qE1gZkLLtUPK5DeQhbMCreb3FaVZqw759";
 protected-headers="v1"
From: Eli Schwartz <eschwartz@archlinux.org>
To: =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>, git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Message-ID: <e11d8bec-8a78-5e00-014c-7904b9ffcb25@archlinux.org>
Subject: Re: [PATCH 1/2] pretty: add %(describe)
References: <7418f1d8-78c2-61a7-4f03-62360b986a41@archlinux.org>
 <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>
In-Reply-To: <5561d11b-08c3-bcf7-5d37-a7d6c6bfb715@web.de>

--qE1gZkLLtUPK5DeQhbMCreb3FaVZqw759
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: quoted-printable

On 2/14/21 5:04 AM, Ren=C3=A9 Scharfe wrote:
> Add a format placeholder for describe output.  Implement it by actually=

> calling git describe, which is simple and guarantees correctness.  It's=

> intended to be used with $Format:...$ in files with the attribute
> export-subst and git archive.  It can also be used with git log etc.,
> even though that's going to be slow due to the fork for each commit.

This patch works great for me.

In fact, it even works fast enough for git log to not noticeably slow
down unless I really stomp on the "Page Down" button. At least on Linux..=
=2E

Thanks for working on this!

> Suggested-by: Eli Schwartz <eschwartz@archlinux.org>
> Signed-off-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
> ---
>  Documentation/pretty-formats.txt |  2 ++
>  pretty.c                         | 17 +++++++++++++++++
>  t/t4205-log-pretty-formats.sh    | 10 ++++++++++
>  3 files changed, 29 insertions(+)
>=20
> diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-fo=
rmats.txt
> index 6b59e28d44..bb8c05bc21 100644
> --- a/Documentation/pretty-formats.txt
> +++ b/Documentation/pretty-formats.txt
> @@ -208,6 +208,8 @@ The placeholders are:
>  '%cs':: committer date, short format (`YYYY-MM-DD`)
>  '%d':: ref names, like the --decorate option of linkgit:git-log[1]
>  '%D':: ref names without the " (", ")" wrapping.
> +'%(describe)':: human-readable name, like linkgit:git-describe[1];
> +		empty string for undescribable commits
>  '%S':: ref name given on the command line by which the commit was reac=
hed
>         (like `git log --source`), only works with `git log`
>  '%e':: encoding
> diff --git a/pretty.c b/pretty.c
> index b4ff3f602f..a0c427fb61 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -12,6 +12,7 @@
>  #include "reflog-walk.h"
>  #include "gpg-interface.h"
>  #include "trailer.h"
> +#include "run-command.h"
>=20
>  static char *user_format;
>  static struct cmt_fmt_map {
> @@ -1214,6 +1215,22 @@ static size_t format_commit_one(struct strbuf *s=
b, /* in UTF-8 */
>  		return parse_padding_placeholder(placeholder, c);
>  	}
>=20
> +	if (skip_prefix(placeholder, "(describe)", &arg)) {
> +		struct child_process cmd =3D CHILD_PROCESS_INIT;
> +		struct strbuf out =3D STRBUF_INIT;
> +		struct strbuf err =3D STRBUF_INIT;
> +
> +		cmd.git_cmd =3D 1;
> +		strvec_push(&cmd.args, "describe");
> +		strvec_push(&cmd.args, oid_to_hex(&commit->object.oid));
> +		pipe_command(&cmd, NULL, 0, &out, 0, &err, 0);
> +		strbuf_rtrim(&out);
> +		strbuf_addbuf(sb, &out);
> +		strbuf_release(&out);
> +		strbuf_release(&err);
> +		return arg - placeholder;
> +	}
> +
>  	/* these depend on the commit */
>  	if (!commit->object.parsed)
>  		parse_object(the_repository, &commit->object.oid);
> diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats=
=2Esh
> index 749bc1431a..5a44fa447d 100755
> --- a/t/t4205-log-pretty-formats.sh
> +++ b/t/t4205-log-pretty-formats.sh
> @@ -962,4 +962,14 @@ test_expect_success 'log --pretty=3Dreference is c=
olored appropriately' '
>  	test_cmp expect actual
>  '
>=20
> +test_expect_success '%(describe) vs git describe' '
> +	git log --format=3D"%H" | while read hash
> +	do
> +		echo "$hash $(git describe $hash)"
> +	done >expect &&
> +	git log --format=3D"%H %(describe)" >actual 2>err &&
> +	test_cmp expect actual &&
> +	test_must_be_empty err
> +'
> +
>  test_done
> --
> 2.30.1
>=20


--=20
Eli Schwartz
Bug Wrangler and Trusted User


--qE1gZkLLtUPK5DeQhbMCreb3FaVZqw759--

--pg0kI5jnhyiyRcGnVrXZdVdsLOB3bH7Ag
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEYEETBMCdNmKDQO7/zrFn77VyK9YFAmArUk4ACgkQzrFn77Vy
K9bWxg//dZFA1S/39+Cbwd5zalSxhXj1CtfQcyyvLY/Fp/MVZgoJS8R9sf0AfBOh
I6koNRwkAUK9aI25EAN71kwfIbfa+OcH2rF+9zeSaeIY2OP2IKah5A+sKeNihS0h
1QUN2kgQX7tkWvCnltVHs98LzjocwXY6TKnSVxHavo1i6z8V4qR9m5/ja3t97vsZ
ZaFlY8SBErzSWKpJ05T3moYEHd7u1q6cBy3Wf8feXVgwbX4PkcFw1K2f1FscOtNV
/rTDqVZTRrPc5RrLj+8ZFfW6nY23JYQA2TdvadDgOeoYfPwX1gi3n4nMypeWGhUh
qvY4wvI7xt3edhTyjHPqgIj7LyqCx/Y8z2jZPNzArN8Bmn3EVLSdImlTE09Lj6DH
LnoYenkKP/zM+j0BTP+j5wfEkb3U/Tx9DC+yFarBW4uc1aSofO/CPce/6Z4ljpTu
J9RN2KIJ0RaoI6GSTwScQyfuFqeq8TxE44SZ2bfuDx7InDLQ3XKJW/Gs5RuoLBaB
NoI2V/AjutdGeKrVeUV3FlNf6T7JYZPOYTJxCDjt7oGQ9GnVPuVxOY2jun2mhFow
LIHMXfF0j9pLRa3Q4fLJmy/OAyhQEeC2BHknWm2u8Ht3NGr097IdrvMPsKi0UtqP
9c2miFM1jxHDIhk2K/uvIC35flfIAUTH8GiM7VXLtWSssGNOnJU=
=AobO
-----END PGP SIGNATURE-----

--pg0kI5jnhyiyRcGnVrXZdVdsLOB3bH7Ag--
