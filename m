Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05795C433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:11:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D3022482
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:11:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728511AbhAKLLe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:11:34 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:48493 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726753AbhAKLLd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:11:33 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 4FAF6209D;
        Mon, 11 Jan 2021 06:10:27 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 11 Jan 2021 06:10:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=GwJ7/AxZSIladaDUsVK+oHMRqJI
        6nLy/cYhWMXCgzus=; b=vjFO1+ZFF22jIuWMuH8LLt+yB8FRsY28lnfwRqOO0BO
        sXOV7ZV7T8VW0V3ZGxjHxL599Oop9o3QDcIkPFTon+L3Kiz38WJgal543WzzE2Mw
        KMEiJVyei/gC02mFUb18zoMnaRoDD9PWXcloHVPawy7tv2mwWyU1+89kuMqmDCfl
        fOiNlZo/cjcnq5by4MfDCIlihtJVWgieoLuB3jHc1BGc8icSSb3vtSe4VzIsiB5s
        CtN3y0nRTYsMsCwlofzReuXn60n0avazA3CwYLtyAUv0rWbxQ5OrADseFCOySyI7
        3tL0jrRXAeZjiKh2LQ5IxcuJt7lHeUENNUr+My4936g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=GwJ7/A
        xZSIladaDUsVK+oHMRqJI6nLy/cYhWMXCgzus=; b=dijBRhr5sC9XIapsnPDKVD
        W5aNmqMLxEUKG3h+x1Avs+4NA/ZZqVxuR1Qz+UtTUawggbLGekPSmnr4BIE9YiO5
        eMq6HBWWCf69kE3/Ez1yQAhxC1/y5SpaAdEShardCS4KYOOt/6lJql4YAmfh2xrH
        E4597Mzi6ZiFgpOUvvgMvj0BIuRMDEx/QwvrspXpPYPV9IAQS1QEL6KL7eF219Xj
        wAxmeDip8C/lx4g1oZ62evDeI8XMva3T6SRYIzqrUfYNK8bIuxfbjfs9DK77A4oX
        RFcq8bJAkmcI7+I9qkkoJNGqnSRle4Zkqm4rSlyqHdpQ3SfFUXKMUzRtYIBXDZAg
        ==
X-ME-Sender: <xms:IjL8X2t7HCRwektkeL-ohl_hfkCCqpH8Pk_tOjHCYqBcgQEAdjvg5A>
    <xme:IjL8X7YvHPDgywDNqZ00WUIC0EKqTvLEmXVPD7yxBokKw1Whz10IkSDe7asjcfMdN
    zqb8q1jDWMyjPnwbA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:IjL8X-rJyv-wmAY5NqT46m_J-4SlCUelqakdBXDckMfB37hvCs5IsQ>
    <xmx:IjL8X48hI-zoSfRdEWw2pBQVhjxAd0pFhFXy2ldWpv8_gUG4senojQ>
    <xmx:IjL8X1_N7hsFKEC1d-XiO1nvr_qMVx7b6BaxWEilrY05VRQVJVa-fA>
    <xmx:IjL8X9edwupUP4tVoDWZetSd97oGNEa7zioDY92GIx74rAr3d9F28Q>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id E37451080063;
        Mon, 11 Jan 2021 06:10:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id bd51dd57 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:10:24 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:10:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH v3 2/5] fetch: use strbuf to format FETCH_HEAD updates
Message-ID: <X/wyHxLcYtQb7icq@ncase>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
 <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jmQqVWXz98P4S4OJ"
Content-Disposition: inline
In-Reply-To: <a19762690eb7f9957ac31d73e110f0103aeb2307.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--jmQqVWXz98P4S4OJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 11, 2021 at 12:05:20PM +0100, Patrick Steinhardt wrote:
> This commit refactors `append_fetch_head()` to use a `struct strbuf` for
> formatting the update which we're about to append to the FETCH_HEAD
> file. While the refactoring doesn't have much of a benefit right now, it
> servers as a preparatory step to implement atomic fetches where we need
> to buffer all updates to FETCH_HEAD and only flush them out if all
> reference updates succeeded.
>=20
> No change in behaviour is expected from this commit.

Forgot to add my

Signed-off-by: Patrick Steinhardt <ps@pks.im>

Will amend in v4.

Patrick

> ---
>  builtin/fetch.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>=20
> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 50f0306a92..1252f37493 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -899,6 +899,7 @@ static int iterate_ref_map(void *cb_data, struct obje=
ct_id *oid)
> =20
>  struct fetch_head {
>  	FILE *fp;
> +	struct strbuf buf;
>  };
> =20
>  static int open_fetch_head(struct fetch_head *fetch_head)
> @@ -909,6 +910,7 @@ static int open_fetch_head(struct fetch_head *fetch_h=
ead)
>  		fetch_head->fp =3D fopen(filename, "a");
>  		if (!fetch_head->fp)
>  			return error_errno(_("cannot open %s"), filename);
> +		strbuf_init(&fetch_head->buf, 0);
>  	} else {
>  		fetch_head->fp =3D NULL;
>  	}
> @@ -941,14 +943,17 @@ static void append_fetch_head(struct fetch_head *fe=
tch_head,
>  			return;
>  	}
> =20
> -	fprintf(fetch_head->fp, "%s\t%s\t%s",
> -		oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
> +	strbuf_addf(&fetch_head->buf, "%s\t%s\t%s",
> +		    oid_to_hex_r(old_oid_hex, old_oid), merge_status_marker, note);
>  	for (i =3D 0; i < url_len; ++i)
>  		if ('\n' =3D=3D url[i])
> -			fputs("\\n", fetch_head->fp);
> +			strbuf_addstr(&fetch_head->buf, "\\n");
>  		else
> -			fputc(url[i], fetch_head->fp);
> -	fputc('\n', fetch_head->fp);
> +			strbuf_addch(&fetch_head->buf, url[i]);
> +	strbuf_addch(&fetch_head->buf, '\n');
> +
> +	strbuf_write(&fetch_head->buf, fetch_head->fp);
> +	strbuf_reset(&fetch_head->buf);
>  }
> =20
>  static void commit_fetch_head(struct fetch_head *fetch_head)
> @@ -962,6 +967,7 @@ static void close_fetch_head(struct fetch_head *fetch=
_head)
>  		return;
> =20
>  	fclose(fetch_head->fp);
> +	strbuf_release(&fetch_head->buf);
>  }
> =20
>  static const char warn_show_forced_updates[] =3D
> --=20
> 2.30.0
>=20



--jmQqVWXz98P4S4OJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8Mh4ACgkQVbJhu7ck
PpTsKg/+MyoaiynQ1Kx5Xde9OPiUjUGNJypnVWGRmk+jZEBWm7/EmLJ8YII77ngi
pvi8oZ9DXjuoYFP5hQDb+TzDBzJqJnqfy8JbWy4J8fkDai0gEKr6b6IMxZ7411E3
3gqFxoJuCkQ6L6HV6qlka2/+Ilo0A2x1wD9lg+GmA+YyEQfG8EbBvzkOnKMvnq5e
MrPvH+BC6z5VrxsYCbklMHjKvlNx8e8MFXLJXLDCnt3mw1F2mTDTm2DP0m5aQNh5
f8KZufgd0ZWgKZeGY6Rf3Fmw8jk1i/r3xfA4QhyPxgs+Y/KSviqJnONRyQnvWlGY
SLS6VMMIKmQmiBowi7cTvEU/CAyGKpuwMUytXILAC/ypxSDs63XxHuhdIIecCuCL
+jkQoOgu0NlCRpEIbx5O3TFH4GVGeFXwhcwYTfJySBkBoteI9adXKuabgtCfq30F
aiYCdkpHS+tenz/eUVBrd2QFbH+GXUCnvHvQs9YXphShogGiJgQ505x+986kVN2U
YKE7TYcafYl2MgeMUGBDkL1h3JJvNDli2uHw9ec24ArJwgaNhEcxyf1kyU8cKcm+
nMvl4ltkRANOikvhbzuP3orNHWSoadLVhtnq91qjFRhE3r7rqSX1KdPlhzhzebt4
CbQfU08ae9bELdQffS0EiwgS44IBAv/yhYdTiD9wfvAF3hSzxNE=
=cdAY
-----END PGP SIGNATURE-----

--jmQqVWXz98P4S4OJ--
