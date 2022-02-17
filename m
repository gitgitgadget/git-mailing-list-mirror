Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DCD8C433EF
	for <git@archiver.kernel.org>; Thu, 17 Feb 2022 11:18:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239675AbiBQLTH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Feb 2022 06:19:07 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiBQLTG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Feb 2022 06:19:06 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C271114FD8
        for <git@vger.kernel.org>; Thu, 17 Feb 2022 03:18:51 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 6EF143200E82;
        Thu, 17 Feb 2022 06:18:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 17 Feb 2022 06:18:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; bh=ajplbKvydvVxuSKcbIFWqRCCHqnDRNI8bZZ51W
        5WbOs=; b=ZnDcz9QTo98SPgM+Sxcwzmu03iIDFnJSS86W93yFDt1jDUyPqBNUkg
        WprL1pR6G4UuxJnHQCbVhvvAZrM5wEz1t0mwHihshnQJ+xNbITVBG2e+pdgbsPGn
        TkyofUkpGX/r2/OdWE+Asghtz2DwwZWa0+wtuxAlJH98DqauEz7Bf5kTgkodHUBr
        JS6YeOcnKU4ft8fNl4p8tgxOQxAT2OUfyv0bzZmCyXSq9j4bm380t+OXgQopT1Lm
        LNtL3mbNezJDt3IaGouEs3yXVBXLye6t9aqnTebNY2zPbeCQmxidG7dMhpnW0nis
        bAZ8XsD7rf2fSFgjEhN6DfCMn7UJsjXA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ajplbKvydvVxuSKcb
        IFWqRCCHqnDRNI8bZZ51W5WbOs=; b=nS+0Bkig3oA4yaFrVEqnRv0vApHehnPtt
        xYDxbunn/4lZirKKk7cCRwIsFtScsxXBMURCGvGji94gmd1mqyanuAqBHFcwRlau
        xKTcjIIUzioN2RXGJtBthctLVk+313Nxsn8Aw9NrK31sam1eSjqwMU1zinsOcSk1
        VRd8ZYnAGbuB+LHHnu5sr8dlMhwBr3UMVP4wJOjZ9U/XnkUlRuElPF1cGdiHbO7+
        bykoMEvoHfR61UhF0WtMIXl4N/SZiSSxAVVhOYddcWU7EzGVXF6mjHrsvK8Sncsk
        xAIT6HctJNMbNQNKV94Mwx8lc3FlLwy0r1joYbXHaL/tvEGxd5gJA==
X-ME-Sender: <xms:Gi8OYkbsLNzaiRfVAAsR6cYTEIbXjZgheIV6ns9yOP-NlB4PLKVhag>
    <xme:Gi8OYvaZ5edjhvzDIbWT-G6p8cXDpDFSDmS2o3WikOWAmUZGH8asauOg2DEa2big4
    6mUYodkwszVf4LxYQ>
X-ME-Received: <xmr:Gi8OYu_pPT89kKR1GxrETMgzpxQbhte_BLlh-AcAU3XYlJJDvcnfCvF6iMOeq7PWIjjp2_k3h-eJSSO_4mDR7LJbSgOO_fcMWAdX8SroOVOrkbMCVRSQuVc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrjeekgddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:Gi8OYurAwLxhGe7g6w-xkfnZHuks85T0CLqBaqpLATt4z5PV69NKcg>
    <xmx:Gi8OYvojYIsSmYqbibxRM4sgJt-C_5k_mlwe7XPcCU5lawHTkGRkSg>
    <xmx:Gi8OYsSJoC_btZsoVnRUZhwBfQmZH0t0WZVmg0wzqjyClm4hg-x_kA>
    <xmx:Gy8OYuS1HgQCiNoUZogtJYKhEdh2Xj7FAJlD4YUEF2PRaCtstQegAw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Feb 2022 06:18:50 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id d48f3615 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 17 Feb 2022 11:18:48 +0000 (UTC)
Date:   Thu, 17 Feb 2022 12:18:47 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: [PATCH 3/6] fetch: control lifecycle of FETCH_HEAD in a single
 place
Message-ID: <Yg4vF/ph9yQRTdMM@ncase>
References: <cover.1644565025.git.ps@pks.im>
 <4059d5034bd9137ffca4929ed5bd8b7ce75ea09c.1644565025.git.ps@pks.im>
 <CAP8UFD32MQSVQ2uUhmO29jFz=LfqvN8U7e-a=sDgQAxUh+Gadw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nzStJSFQyYrK8otP"
Content-Disposition: inline
In-Reply-To: <CAP8UFD32MQSVQ2uUhmO29jFz=LfqvN8U7e-a=sDgQAxUh+Gadw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--nzStJSFQyYrK8otP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 15, 2022 at 08:32:56AM +0100, Christian Couder wrote:
> On Sat, Feb 12, 2022 at 5:49 PM Patrick Steinhardt <ps@pks.im> wrote:
> >
> > There are two different locations where we're appending to FETCH_HEAD:
> > first when storing updated references, and second when backfilling tags.
> > Both times we open the file, append to it and then commit it into place,
> > which is essentially duplicate work.
> >
> > Improve the lifecycle of updating FETCH_HEAD by opening and committing
> > it once in `do_fetch()`, where we pass the structure down to code which
>=20
> s/down to code/down to the code/
>=20
> > wants to append to it.
>=20
> > @@ -1601,6 +1596,10 @@ static int do_fetch(struct transport *transport,
> >         if (!update_head_ok)
> >                 check_not_current_branch(ref_map, worktrees);
> >
> > +       retcode =3D open_fetch_head(&fetch_head);
> > +       if (retcode)
> > +               goto cleanup;
> > +
> >         if (tags =3D=3D TAGS_DEFAULT && autotags)
> >                 transport_set_option(transport, TRANS_OPT_FOLLOWTAGS, "=
1");
> >         if (prune) {
> > @@ -1617,7 +1616,8 @@ static int do_fetch(struct transport *transport,
> >                                    transport->url);
> >                 }
> >         }
> > -       if (fetch_and_consume_refs(transport, ref_map, worktrees)) {
> > +
> > +       if (fetch_and_consume_refs(transport, ref_map, &fetch_head, wor=
ktrees)) {
> >                 retcode =3D 1;
> >                 goto cleanup;
> >         }
>=20
> I think the following (if it works) would be more consistent with
> what's done for open_fetch_head() above:
>=20
> retcode =3D fetch_and_consume_refs(transport, ref_map, &fetch_head, workt=
rees)
> if (retcode)
>       goto cleanup;

The code here is really quite fragile, and I'm not much of a fan how we
need to retain `retcode` across the calls. But we can't change it like
you propose because the preceding call to `prune_refs()` may have
already set `retcode =3D 1`, and we must not clobber that value in case
the fetch succeeds. The effect is thus that we have `retcode =3D=3D 1` if
either `prune_refs()` or `fetch_and_consume_refs()` fails.

Patrick

--nzStJSFQyYrK8otP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIOLxYACgkQVbJhu7ck
PpTfEg/8C0olbY2vM+HyOIC9+/uHR7boqtB5Yj6nQnCb74xJyp5HnRnb5RCnK7y2
T+v1V5/DIKOphcqLVfR81HFkZ/EP2z4QhGkjqW15bBxfqybczVA7v+Bc+4bIFnCk
Eo56GXCjYlr6IsUjqlxQjY9297wgWNg2glJJeWGtvo40Qz6iSPLVGpAyzj6TUkk9
1TewosGGohucOfMRtoIr8VBPJkFDfSiVnC/qosBpzeqHhKhkBxX3xEXeTUpmXF+P
t4Vepjr9RBLk0YK/gIBZlBVhJaimA6s4r69TOK8+yp75JaryxaZ3ntGAJ5VnXTMS
EFLknfaDD5oLs2RlEQjb9ZK/Gld2X7n//fKF/RekO6CNj6kMditvezMN6Cgj7Q0q
1/VyUu5kaToA0EUqte7/d+CXj6BPKFKmwqBjyy+dvAUfEy4gTdLX7vDG8YbXmgCS
Ep58Vt35wbWA5hk3djz/rbLtaKw8OLUl+IZ+Xduf4vjwKeL/M0nR4aywYH1RswoY
GPQ4765fkrQV4O6DiRlgeJdYMejnirDK+paoV6Maoc+zpwR/QfkhWpga+q3uNIM8
ILmZyILcI+hxK3wVVufQ2sMYrGTJQ7xNdOM94RUwn5LTldgTbHZgwINCdPsiDRh0
VHN8wn0aUh1ZUksZ0N/PxjLtunXe23a6v1iXGiK2K209wJlSRm8=
=eVge
-----END PGP SIGNATURE-----

--nzStJSFQyYrK8otP--
