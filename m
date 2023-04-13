Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C094FC77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjDMJ2b (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 05:28:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjDMJ23 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 05:28:29 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750832708
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 02:28:28 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4F58A5C00F0;
        Thu, 13 Apr 2023 05:28:25 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 13 Apr 2023 05:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681378105; x=1681464505; bh=Wu
        HwCJ2pT5qRKdHzlJZ5CM5+KMHeh/vXC6Jl2XTlop8=; b=TjJN4u6pQ2oEKckwfs
        TiznKFQzF1dsBOXUKRL9tcZoIEnOCpxPn9qXKsWS64rVs90QgXncTfHrTHsH+3j3
        fBobfKK80n++ROrBcQFJaD5OtKbjOIKw798+NuaYvDH+JQBlUTVgRGOuPlK8mzLU
        vOPKwk6PxD6WBRunWOWUvsYpnS4WI0P3hGARRpOG5CB1JdK7JldP1Vc7wMpJq0Su
        404NxPuBYhogRXwXUdEKZ1vxAApwPhws6FnlB75FnB/wVgqpUWi66+VQcwaQSU2O
        uNkzdtUF0sUTxlQfy/3Pk6hT3kzkH0mEB2uhBpL09A1cgvONHO9js4T14iDol45m
        3gfQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681378105; x=1681464505; bh=WuHwCJ2pT5qRK
        dHzlJZ5CM5+KMHeh/vXC6Jl2XTlop8=; b=YzkeaxnKzyk/73PlxJa2hvOwYHII1
        DzRaY0aUaLgR2heWb36mRy72adJZ394aGbsYZNN9ScoM1bPwgt/Vs+2FAC4y4tAV
        pTqRZSzLgOsAhVnZmnbEorfUgrI9T0oPetkASX6xEV1wRxNtPbtwqJh90CVgGopC
        b8TDIN3sf3BI1veq19gUw6YSUsLoBukuQr8CPq8MTRpflA72lg6U+9fZIBLTauDQ
        3Zqf7ZL/jagt+Q/VeW57qGM5rjHCxDV9xJfTwdvRsEDH7wtDWDVj8HGTeCO5WMZw
        ak6bNSInRxz82dvbS7nzTEdCh7OwD4F6phRZt0DRZ7aJN+wmsr+nWm+aw==
X-ME-Sender: <xms:OMs3ZHeWXp1lJiRVOYHQh0P-QyeOqQWkQTlYzSCofvz6bW5MsTxfAQ>
    <xme:OMs3ZNMWHyzF7zyvogSHU_htpptA22cViKIBkn-1OJmbEg2QkGHFvO9jtyZ-QtUba
    44HTr8M-aCTxiDrJA>
X-ME-Received: <xmr:OMs3ZAiiorNFaqGRg8i2yntMKFQG8O34k3ojuVy0X72mhnjsAixg0K3PN4c4z48XmQ1T1GKn9Rf9H4IyAtW_OjbNzUi7pGb0Yd4s42NeKDUyKus>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OMs3ZI-ZFS5yQ20rMIBRWgdch-hPotK1R5gfEOLNoWp84bTtfGnmjQ>
    <xmx:OMs3ZDugQNUxlhzBFG8UuA8XMeq8xnalebth-rxyhU2vbbcKSayTOA>
    <xmx:OMs3ZHHXwz2P-RjRBr3jo92KP-PfAmWroDg1a7amViX2D_iKBVRSzw>
    <xmx:Ocs3ZM5ZKyu7Wtp3Jx89RR-3RL0rnPX4P1dbBKI4PYXr2uZ7MtkcUg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 05:28:23 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f0eca76f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 09:27:57 +0000 (UTC)
Date:   Thu, 13 Apr 2023 11:28:18 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 1/8] midx: fix segfault with no packs and invalid
 preferred pack
Message-ID: <ZDfLMm-AoXkt-4zj@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <5ecad306b42441fa7d4f50bdfb9c09ccce22b6c9.1681294715.git.ps@pks.im>
 <ZDbw6v8r89zciE3q@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="trLt3v51xgWJfbVw"
Content-Disposition: inline
In-Reply-To: <ZDbw6v8r89zciE3q@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--trLt3v51xgWJfbVw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 01:56:58PM -0400, Taylor Blau wrote:
> On Wed, Apr 12, 2023 at 12:22:31PM +0200, Patrick Steinhardt wrote:
> > Fix this bug by exiting early in case we have determined that the MIDX
> > wouldn't have any packfiles to index. While the request itself does not
> > make much sense anyway, it is still preferable to exit gracefully than
> > to abort.
>=20
> Interesting. This reminded me quite a bit of eb57277ba3 (midx: prevent
> writing a .bitmap without any objects, 2022-02-09) which tackled a
> similar problem of trying to write a MIDX bitmap without any objects.
>=20
> We may want to consider moving that conditional further up, since this
> makes the conditional added in eb57277ba3 dead code AFAICT. Here's a
> patch on top of this one that I think would do the trick.
>=20
> It has the added benefit of sticking a:
>=20
>     warning: unknown preferred pack: 'does-not-exist'
>=20
> in the output before dying, which might be nice (though I doubt anybody
> will ever see it ;-)). The main difference is that we unset the bitmap
> related bits from `flags`, which avoids us trying to compute a preferred
> pack in the first place.
>=20
> For it to work, though, we need to make sure that ctx.preferred_pack_idx
> is set to -1, and not zero-initialized, since we'll segfault otherwise
> when trying to read into an empty array.

Indeed, that is a good point. I think we can simplify your patch even
further in that case:

diff --git a/midx.c b/midx.c
index 47989f7ea7..67eb617591 100644
--- a/midx.c
+++ b/midx.c
@@ -1328,17 +1328,17 @@ static int write_midx_internal(const char *object_d=
ir,
        }

        if (preferred_pack_name) {
-               int found =3D 0;
+               ctx.preferred_pack_idx =3D -1;
+
                for (i =3D 0; i < ctx.nr; i++) {
                        if (!cmp_idx_or_pack_name(preferred_pack_name,
                                                  ctx.info[i].pack_name)) {
                                ctx.preferred_pack_idx =3D i;
-                               found =3D 1;
                                break;
                        }
                }

-               if (!found)
+               if (ctx.preferred_pack_idx =3D=3D -1)
                        warning(_("unknown preferred pack: '%s'"),
                                preferred_pack_name);
        } else if (ctx.nr &&

The other cases already set `preferred_pack_idx =3D -1`, so this is really
all we need to do to fix the segfault.

Patrick

--trLt3v51xgWJfbVw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ3yzEACgkQVbJhu7ck
PpSHjxAAhJwp3hJdPxynVPqpf50zIv7nPbAeLbVN66d7oW9HrcLQ8bItUdGr054L
b/uo5n+gdDTIIPPab7YSbRkBlEXRamRc7VSKS69eNdY5KACNjv7XyFuWe/DPSRsm
Tl7wgxGLnG2qsjUm3kQQ2Xp6DSpqYSMLAJl/xiwUI1rT3mpi0kh8VXskRueq4fXI
vrq0r44P3dod2MYRAwt6QOBPkcA2alTnIVNOk3rrobfZU/vK9hPQW9EbZcg8FCsz
mGOXI0nHcM+Pw97EM9T9MIMedgecsZmEgq1ARK5C7v7CM5KD3C/7EEeck0J/hOtE
pTjwryJyEi4FPEPnAsIovfT/zt2MzwSZrW2T8Yc58w3G080LyGur225VJnMF1aaT
CQ2Rqe2X8hOQ9kx3vrdZPFWW2bJhb93ABu0XtcT4F3ignj+VhQYqIq0EsdvB4cd+
0bBp+gX4J1B+vSIAG399IULdQF0gPMuXLayPLG/soKWl4YA6YFWQrD3D/DvfjAEQ
nwkAZwQDJy6INDlzX09hOUeEwtHux21JjQAQvP39kujrFEHgLkheMS5dq+jRYt7z
GQR15xHcuLPS2Hswr1cAu6Iar10JqIKZD9/p+tDkIcM3vtAIP0d3sKmDRSrr2NkC
OEap7L1gFQdVBJg9oKFX2P1mHir4Z/+x7bZ7miWDQ+ZJB5eIxGY=
=Vbtd
-----END PGP SIGNATURE-----

--trLt3v51xgWJfbVw--
