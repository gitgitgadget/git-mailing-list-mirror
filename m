Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6215FC77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 09:31:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229764AbjDMJbt (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 05:31:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjDMJbs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 05:31:48 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 944AA49FE
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 02:31:47 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0BF755C00A1;
        Thu, 13 Apr 2023 05:31:47 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 13 Apr 2023 05:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681378307; x=1681464707; bh=0H
        P/JBiHrv7xiVQGf856ezHjCphFwrX0cqPxpMZeTX0=; b=rVyMAcfsWyrXhcZzbd
        qdibzg43EU2rrh+S9if/rV4ZXu/ZxA1gpgEld931Nf9wZHETsKATCdp3Z2nSC43Z
        57rrasODqBwFrLA5AL+0G5HcuR192B4Hz1ZY2i3ClTc0dfDJhfvRjqrV9swNuxVA
        0dKX3X/7QPxEquMjUJ4+fYWe5vN2p0vDongbJhIPBC2lnDSaxjZvpH7UsuHTgAMy
        Vn3cjRxigy93h4xjaFV5j7epfRfHY7vuH79eDwUOGO2WccWfjEyxe3Vm7lWNRmWn
        xjW98LS6qfqHDCTEYN2WYU393LhDHoZk0820MO/OUvKAAJYm+CgzMP3C0ih2dC5b
        +Luw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681378307; x=1681464707; bh=0HP/JBiHrv7xi
        VQGf856ezHjCphFwrX0cqPxpMZeTX0=; b=aqB8gi/BSxeUkwje/xff+FDLf5pFs
        +04PZE0b96FyagSdPr5vk1DklMXddgJZv/oY5ibS0ApCSaY2bRujrcBrMtM21N95
        m8+GcrYh+WUrx3tqEc/L1gPCIwktZtxFTCmqXjYp23AWMP2EQO1Y3wY+pcs7B8vf
        lZeEA/tngq8LkqJd6S9POeSLLF+vUwyHuOJO7JTq73uB/hHcDytvmjX2nZarN4KT
        P4j9KalzJOGGpTm+fCRu1YMVLJG///SxmEmN81RRd8GtmBbakvo/v5ntL4ysojxW
        twyosidNkcmVFUw2sm+A/mpeoa/0GBP62H6xSb+INHqOTJIhXvY32vB6g==
X-ME-Sender: <xms:Asw3ZIPm7JtVqEUbdMhcS_K_FaEXeTb5xQrIbIzuXnv0ZK6DBtP1Jg>
    <xme:Asw3ZO_zsZ3rP2bqpZAfxtmxO8rZVgawXxXezeecczUSmZPEoxUROHh7xXPgrPLyT
    NNBTQIdAu9PDmVU1g>
X-ME-Received: <xmr:Asw3ZPTuoR8Icxc_LETqAYGgm9ZkOMWEjSG4ZbPcTev3O_CjsDvEfAxncgucTLJ4pWkQQbwl_SZt6vfhMHVd7UfIyq1OtDgiNdhs_Au7dAfeCf0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Asw3ZAtidRqMG8Z_1T_RmgpeREiHpMpoOvyus4XPhxPcAwl5ehFMzg>
    <xmx:Asw3ZAdleOLUjL4cSo8AMOcM78Xc5j_ENJKJsGbDVweqElwoHMkmHA>
    <xmx:Asw3ZE3qYU3cVHnQCcK5CR2eno0afwwb-1ZQDjdjAIZZg9uLJGVg8w>
    <xmx:A8w3ZBpsEqgExK1leEUvwZboIAJui5ZvB2N52j_zTheVWho3ZxZtVA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 05:31:45 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 1ff52724 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 09:31:22 +0000 (UTC)
Date:   Thu, 13 Apr 2023 11:31:43 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 2/8] repack: fix trying to use preferred pack in
 alternates
Message-ID: <ZDfL_6G-ySm94Vla@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <011b08f3b64f264e3abbe8b49ee5338c221badb9.1681294715.git.ps@pks.im>
 <ZDb6gZycwTdsaB6o@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ZdB3bImJ//TPSDRf"
Content-Disposition: inline
In-Reply-To: <ZDb6gZycwTdsaB6o@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ZdB3bImJ//TPSDRf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 02:37:53PM -0400, Taylor Blau wrote:
> On Wed, Apr 12, 2023 at 12:22:35PM +0200, Patrick Steinhardt wrote:
> > When doing a geometric repack with multi-pack-indices, then we ask
> > git-multi-pack-index(1) to use the largest packfile as the preferred
> > pack. It can happen though that the largest packfile is not part of the
> > main object database, but instead part of an alternate object database.
> > The result is that git-multi-pack-index(1) will not be able to find the
> > preferred pack and print a warning. It then falls back to use the first
> > packfile that the multi-pack-index shall reference.
> >
> > Fix this bug by only considering packfiles as preferred pack that are
> > local. This is the right thing to do given that a multi-pack-index
> > should never reference packfiles borrowed from an alternate.
> >
> > While at it, rename the function `get_largest_active_packfile()` to
> > `get_preferred_pack()` to better document its intent.
> >
> > Signed-off-by: Patrick Steinhardt <ps@pks.im>
>=20
> > @@ -464,7 +466,16 @@ static struct packed_git *get_largest_active_pack(=
struct pack_geometry *geometry
> >  	}
> >  	if (geometry->split =3D=3D geometry->pack_nr)
> >  		return NULL;
> > -	return geometry->pack[geometry->pack_nr - 1];
> > +
> > +	for (i =3D geometry->pack_nr; i > 0; i--)
> > +		/*
> > +		 * A pack that is not local would never be included in a
> > +		 * multi-pack index. We thus skip over any non-local packs.
> > +		 */
> > +		if (geometry->pack[i - 1]->pack_local)
> > +			return geometry->pack[i - 1];
> > +
> > +	return NULL;
> >  }
>=20
> Looking good, we want to go through this list in reverse order, since
> the packs are ordered largest to smallest. I think that you could
> slightly rewrite the loop condition to avoid having to always access
> `geometry->pack` at `i-1` instead of `i`, like so:
>=20
> --- 8< ---
> diff --git a/builtin/repack.c b/builtin/repack.c
> index 9d36dc8b84..ba468ac44e 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -467,13 +467,15 @@ static struct packed_git *get_preferred_pack(struct=
 pack_geometry *geometry)
>  	if (geometry->split =3D=3D geometry->pack_nr)
>  		return NULL;
>=20
> -	for (i =3D geometry->pack_nr; i > 0; i--)
> +	for (i =3D geometry->pack_nr - 1; i >=3D 0; i--) {
>  		/*
>  		 * A pack that is not local would never be included in a
>  		 * multi-pack index. We thus skip over any non-local packs.
>  		 */
> -		if (geometry->pack[i - 1]->pack_local)
> -			return geometry->pack[i - 1];
> +		struct packed_git *p =3D geometry->pack[i];
> +		if (p->pack_local)
> +			return p;
> +	}
>=20
>  	return NULL;
>  }
> --- >8 ---

There's a gotcha: `i` is an `unit32_t`, so `i >=3D 0` would always be true
and thus we wrap around and would try to access the pack array at an
out-of-bound index.

> but I'm not sure that the loop condition is quite right to begin with.
> We don't want to iterate all the way down to the beginning of the pack
> list, since some of those packs may be below the "split" line, IOW their
> contents are going to be rolled up and the packs destroyed.
>=20
> So I think the right loop condition would be:
>=20
>     for (i =3D geometry->pack_nr - 1; i >=3D geometry->split; i--)
>=20
> which I think makes the "if (geometry->split =3D=3D geometry->pack_nr)"
> condition above redundant with this loop, so you could probably drop
> that.
>=20
> I would definitely appreciate a second set of eye here. The pack *at*
> the split line is considered frozen (IOW, we create a new pack
> consisting of the packs in range [0, geometry->split), and leave the
> packs in range [geometry->split, geometry->nr) alone).
>=20
> So it should be fine to enter that loop when "i =3D=3D geometry->split",
> because it's OK to return that as a potential preferred pack.

That makes sense indeed. Will amend.

[snip]
> > +	test $(wc -l <packs) =3D 1 &&
> > +
> > +	# We should also see a multi-pack-index. This multi-pack-index should
> > +	# never refer to any packfiles in the alternate object database.
> > +	# Consequentially, it should be valid even with the alternate ODB
> > +	# deleted.
> > +	rm -r shared &&
> > +	git -C member multi-pack-index verify
>=20
> To test this even more directly, I think that you could ensure that the
> set of packs (which should just be the single entry found in "packs"
> above) matches what we expect. That should look something like:
>=20
>     test-tool read-midx member/.git/objects >packs.midx &&
>     grep "^pack-.*\.idx$" packs.midx | sort >actual &&
>     xargs -n 1 basename <packs | sort >expect
>     test_cmp expect actual
>=20
> Note that the read-midx test helper outputs packs with the "*.idx"
> suffix, so you'd probably want to alter your find invocation a few lines
> above accordingly, or rewrite it before writing into "actual".
>=20
> Alternatively, since we expect there to be just a single pack here, I
> think we could just as easily write something like:
>=20
>     test-tool read-midx member/.git/objects >packs.midx &&
>     grep "^pack-.*\.idx$" packs.midx >actual &&
>     test_line_count =3D 1 actual &&
>     grep $(cat actual) packs
>=20
> though I slightly prefer the former since it is less brittle to changing
> this test. Either way, though.

Thanks, I've adopted that approach with a slight modification.

Patrick

--ZdB3bImJ//TPSDRf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ3y/4ACgkQVbJhu7ck
PpQ9qw//QwKPRJonoZ8tBeavL3i2p9uCdRSVAu9Q8Klua+qAte1l0SHT89aqqAyc
Q5Zdkf6fvsw6ltAqdrjQp+YwrRo0ITjdhQRDjE6lkrpAD1ZNiT71UJbz8c9IbcJZ
vme4G06xgRmMDotGyru00GwbY8lSwewxXsMBoUO3kuo/J6hOvHl90pPUsX1mM/JG
N+Z7KPzdZPHgOT80+78+5mclCJAMnKINASWzucwFLcEUZZas/1uaJPBmBAIEI5Uy
7Ry225i0sT6Ge761BIntZke9WE+ZYTVO2m/ITB5SfGlOMmGXgHb3eh0XNNcNU40v
Zk3EJ645CjTp1oGRB7NjJC2dy+62qmfP8HtNDBMbWgchUIy+c7pFabMe2qCMDYw7
u0ZBnpzfOzVCpvSSfXE8q1cr+5R7o+mPLnpA4Qx/4bO9T5TnKopI1oEimgLTAiBV
wZMcF20Qky+LGSDMxRk6ZZOb86b2GpDPPfkdawmJZfXilV7WrPQDARr5bd5/2EXK
A6GRqrwB0wuBcGgLig1cOn84P3k2DwVB9ZLi1RJQzhLEz/HgcVV8ZtFWKu7i0uHk
WI1nMaR7+6uAVeG0uHGH9Y2WZjLikyQ7vLMkTqbC+uzNdNwI7azEQLjn6vDGQgXt
F/75nlZq/ewR2VLim5E9iK+pNEocmjWHeaKRVIgA/+ZsojIRRAo=
=aShR
-----END PGP SIGNATURE-----

--ZdB3bImJ//TPSDRf--
