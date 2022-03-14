Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF3BC433EF
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 07:19:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236258AbiCNHUo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:20:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232367AbiCNHUl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 03:20:41 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E79B3FDB7
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:19:32 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FEB15C012F;
        Mon, 14 Mar 2022 03:19:29 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 14 Mar 2022 03:19:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=ra2/mr8wrCm/5S9+DOmJvfnPM1oybeQzULGD2R
        qLUvs=; b=M6cJoDwahFkzBkZ/uRGUDGoACfWNEta1GgY5iePkGwcvy6FfJnwItm
        2DAt45Q3uAb0siS938D7BxRymfoA1EYSRg1nw7+EGplLZz0DnqXkkrEf8tA2HPXw
        T8k/vcrDLjjmkGVIzehFOIy3cLhVY/0SYEjpFkiY57fGkjPT7cmW2ERv4Jd+U2A4
        Mo+8jzqow+nfkgGa1z55eZfBp+euliyFCT0zyBFTKnyCaxrBYV2XPDZyqQw4GuGR
        X5AUqEo9W8WTAMELtbOwvFzSPrJ2bz2gOCUXxOFDakgLvApY8xo72+7F48C9uK1Q
        SwwB5sQk411a21FykRdlO7dskyNFl7XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=ra2/mr8wrCm/5S9+D
        OmJvfnPM1oybeQzULGD2RqLUvs=; b=PHgHJJnlnwsO0vMLosuPEiODNl9co9MoY
        4vd6xmOyWXH/1ET2vgiUlHmwkT9HH5hD7XxG/qJsZfsLTTm7oMi0iXvByAGVbbu4
        lS2xNp+iamuH/LTVHC31Uxkajr2S7M/wbfQ4lDZt7kfQ7pThpjnBVHO6ykFCxF4y
        bDBqyVyyKlCbUr8oGP+0DwiaS0LOJiecI5ozGScQShnNI/SakHxkyZ/YvMK+sfJ9
        Ot3MBuLzMttOJvYkRrgwFLS7o+XUA5MdYITsXx6BYkcho/uA27AJJ4LSCsyeBug7
        uKZaWxtX/4M5itZRwC/ltDQv2Rzqrjayzh3g6452GwHxGiqlSxWXA==
X-ME-Sender: <xms:gewuYhwzh6mMzAaGsNP_H0kVslxSqypP82vCCePne5wSIMDlmGUijg>
    <xme:gewuYhQHQlRuRbEwS1z8r7MapxJvSNJXXnFgjr6ue8UzbU0LxYT_Cn41zSYTLb4LH
    oJ32VDdnXQTu_kufw>
X-ME-Received: <xmr:gewuYrVTSQiNXUBOAhoVZY5tFY6don7MISaMNKfSDt6qlUm5lQWxif1XP4uqIjCaal7TpovUL-jZXYZL7v1O_uvrQDX2Jrmr6a_YYwLpClrESv62rNe3I9M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedguddtiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:gewuYjiuLM5mc9Bn9RIusbzcbQ-7pFobBklQLjDdDG_Yd9eNhJ7g_g>
    <xmx:gewuYjBCcFVoY2vEzGtS1y3z3PopNgPCA8XP0WRuIMPRxBF3tgcNEg>
    <xmx:gewuYsLqaWGkYciyity_e_Q6tMFkcmqR6Ye1drM-lGxAv6Re_opPZg>
    <xmx:gewuYmpS50ivLXuTLVVQ-mbIirJoEsrD_sbMLm3MDnXVNgUTJQ5pCQ>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Mar 2022 03:19:28 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 90805f66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Mar 2022 07:19:24 +0000 (UTC)
Date:   Mon, 14 Mar 2022 08:19:23 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] repack: add config to skip updating server info
Message-ID: <Yi7se2c03E4PNnsX@ncase>
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
 <Yit22Xcs6iF4MVB7@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QNTI5fCCL0CMr3EG"
Content-Disposition: inline
In-Reply-To: <Yit22Xcs6iF4MVB7@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QNTI5fCCL0CMr3EG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 11, 2022 at 11:20:41AM -0500, Taylor Blau wrote:
> On Fri, Mar 11, 2022 at 12:09:30PM +0100, Patrick Steinhardt wrote:
> > diff --git a/Documentation/config/repack.txt b/Documentation/config/rep=
ack.txt
> > index 9c413e177e..22bfc26afc 100644
> > --- a/Documentation/config/repack.txt
> > +++ b/Documentation/config/repack.txt
> > @@ -25,3 +25,6 @@ repack.writeBitmaps::
> >  	space and extra time spent on the initial repack.  This has
> >  	no effect if multiple packfiles are created.
> >  	Defaults to true on bare repos, false otherwise.
> > +
> > +repack.updateServerInfo::
> > +	If set to false, git-repack will not run git-update-server-info.
>=20
> Can you clarify here what the default value of this config variable is,
> and how it interacts with repack's `-n` flag? E.g., something along the
> lines of:
>=20
>     repack.updateServerInfo::
>         If set to false, linkgit:git-repack[1] will not run
>         linkgit:git-update-serve-info[1]. Defaults to true. Can be
>         overridden when true by the `-n` option of
>         linkgit:git-repack[1].
>=20
> Perhaps a little verbose, but I think it leaves less ambiguity about
> what this new configuration variable is for.

Makes sense.

> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index da1e364a75..3baa993da2 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -22,6 +22,7 @@ static int delta_base_offset =3D 1;
> >  static int pack_kept_objects =3D -1;
> >  static int write_bitmaps =3D -1;
> >  static int use_delta_islands;
> > +static int no_update_server_info =3D 0;
>=20
> Not the fault of this patch, but I wonder if this would be less
> confusing if we stored `update_server_info` instead of
> `no_update_server_info`. If you have time, I think it may be worth a
> preparatory patch at the beginning to swap the two.
[snip]

I indeed first had a look at how to do this, but didn't find a negated
`OPT_BOOL()`. I had another look now though, and it seems like this is
typically solved via `OPT_NEGBIT()`.

Thanks!

Patrick

--QNTI5fCCL0CMr3EG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIu7HoACgkQVbJhu7ck
PpTlxBAAlLSwn9vQEEwtzbj+DhuVoh91D3HLgk80y0S62u8h6J4zdRNZ3iG5tttF
AtKqHRe6cVE3z1/PkdROY8oPmPZTwAmMLgt8+vigkpO1SrqgejHO10dS7D3r0QvK
F4Evpe3RFJ5EegB+8BxDMeBRHbby3qnZngtsePF9/ln4UHUQthh6wY6j55ro7lQ0
oeH9zO0kM4tPdWgNAltbxo6tQbjITvEqghVZP6hcDqS/xeJXPvaVKSDlOAHmPOGm
RwZh2Y9mxP/1icurYEU4HODguihsAxKTBuJjQPPiOSwNeOn4RsW9Wv8N9VzWg57W
zski2PcGuYurVUP5p52QoBWjJc9cYF5VVQyIPa18Op3rI0wXeP5grnR1JQ6Sv00k
e9n+DbJ7Y3ZyP5enVndf+L1KH6djjYJH35uXo1JgjFTO7afs8ED/jYjcVtUJEV6S
aC2yhMa7K6WML5i5P7oY0b5oc22Tq1rlmagoAAcBJomjykYQYx0gUzEqmdyIiiR1
VxvHgx7T/IX/HmysQ3ERSvQdJwhBjUPV0g9M/zt/nZCeeJs9vrQ2/pOR1YcudC0Z
ehfn8aBXkKa33rJLm6a2BR1flEAYDSm/C2ZsbuqqHE4T1j01nORo8Q+GSolYv6uA
3qNZtAsbE62mrSdR555mv6aqy65pON266T2XQG8jQ+cpOgmO0Jo=
=S5ng
-----END PGP SIGNATURE-----

--QNTI5fCCL0CMr3EG--
