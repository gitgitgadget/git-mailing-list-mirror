Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B54E7C77B6C
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 09:55:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229989AbjDMJzR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 05:55:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230063AbjDMJzO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 05:55:14 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C75493D8
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 02:55:01 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CC885C00F0;
        Thu, 13 Apr 2023 05:55:00 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 Apr 2023 05:55:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681379700; x=1681466100; bh=MI
        VFphgv54IccoVlr8RqNTJMBZJ2dM937jBi1JhnRSg=; b=UEZc929bqza6ymGSmX
        HD8zUyhXrldfPGlKhnlCSvWd/EROx2W0dUCUZU/tEF1o/+AfEf6dlls/bXmeVwPi
        iFT+omYqPbVyQT88+LqnVV14tA6HDKwL86/PNjjjDZ485l5erLPQjMbyH5PuJXYq
        PTnLZl5PM0AWimUDcd1K4ijurh4AZDY/YkdcOdEbtIrwo4G//8dWnRNldClfSq1h
        VvXlaU+uo8fEgwoUbFFNuF9iXKLx/5MjCp6j6OvAyM6pEKe54oXYwsunW0sVOyVT
        1sPTlrWCbCokyZ53jESoowGFj6e91aLWFLI7h9qsDEqQuHpIYnSlHM5ILn86ctE4
        xfRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681379700; x=1681466100; bh=MIVFphgv54Icc
        oVlr8RqNTJMBZJ2dM937jBi1JhnRSg=; b=ddV6VAs3Qlfmi1SJHKUqrAxT9fgRA
        GnvD2yWTQ6rR6DaW/6j30Pu+5ilR/JfZ6GONnX33OLkItWlfeFyRb9JpivCY4Wkq
        ZnrJX+cCSpxfXvntpfMD3EdgchK2I8d9Ziwh36oyA+41UQBr8CIFvWPJuK1tfM7d
        g9tWlJ8QmBTeJEJDDvdAMSY3gcbXv/hh+vFb0DgRbciCOZFJ2YhO6w4Cb8OfaWM/
        mQTCPFytGqYs4Z1STRBZNshxiZvuW009o1oXFlJshH4WrAECaY6kUXinyKMBLsIv
        Af4Ze3con6nBp4nXkL65wwLvB1rMr2gp6hroGNh0/nbXVOMMe4Y/QHR8A==
X-ME-Sender: <xms:dNE3ZO2k2Ho1oN9OhCFseVWTzZp_czhFysgHSE_KmuBOr3YQHSc3ng>
    <xme:dNE3ZBFD3cqqev8GtaUJVI5sFLEWNdW0XuwjWuuguabC6h7ROGYDkMmRreTOucGkQ
    v3Mh7zivNB2PRBgrw>
X-ME-Received: <xmr:dNE3ZG4sg7NW2qb2bNRNInMXfwbZsQFFPyfGwy3PHTW6QqTYCS-iH1zLAia4m3NaYJDYSJRIuADCo8RSoHsxUXkXCbZpz5MVGekDUaxjIFfJoPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgvddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:dNE3ZP0qEOcVlBo6GtXzn2lxhDjMWkyZ2IbOHDFIVVzF-K3CxMhs2g>
    <xmx:dNE3ZBFgASyp-Da9tv8QWJKbt3-nYHNu2WBWhQJfx2NA1YM7AP3y4Q>
    <xmx:dNE3ZI_Jd8f6uPKOw1fJgIkb8PRgNOIBf5LqlObl6fBG9FQCL28r3g>
    <xmx:dNE3ZGT-F7Xdz-C4w3Eo2peNsxurRLQ9FRVDsEXY8MLBB6gBOktoMw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 05:54:59 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id f3d94e1c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 09:54:34 +0000 (UTC)
Date:   Thu, 13 Apr 2023 11:54:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH v2 8/8] repack: disable writing bitmaps when doing a
 local geometric repack
Message-ID: <ZDfRb2PI-QJDavzm@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
 <b74d0a037b07706d07fad7b438fa0cb211726575.1681294715.git.ps@pks.im>
 <ZDcqIjSUMW4sKNXE@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/3hyayNANoOJN/Hm"
Content-Disposition: inline
In-Reply-To: <ZDcqIjSUMW4sKNXE@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/3hyayNANoOJN/Hm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 12, 2023 at 06:01:06PM -0400, Taylor Blau wrote:
> On Wed, Apr 12, 2023 at 12:23:01PM +0200, Patrick Steinhardt wrote:
> > Now there are two different ways to fix this. The first one would be to
> > amend git-multi-pack-index(1) to disable writing bitmaps when we notice
> > that we don't have full object coverage. But we ain't really got enough
> > information there, and seeing that it is a low-level plumbing command it
> > does not feel like the right place to fix this.
>=20
> I might actually advocate that we either fix this in both places, or fix
> it at the lower level only. I think that we would still be able to
> trigger this problem by invoking `git multi-pack-index write
> --bitmap --stdin-packs` directly.

The problem I see with implementing the fix is that we're just not in a
good position to judge whether we have full coverage of objects or not.
All we see is a set of packfiles, and those packfiles _could_ have full
coverage, but they may just as well not have full coverage. And whether
they do is not easy to figure out in git-multi-pack-index(1).

So in order to fix this we'd likely have to use heuristics, like whether
or not there are alternates or alternate packfiles. But unconditionally
disabling bitmaps when there are feels overly restrictive to me as it
would break perfectly-valid usecases.

I'm thus still not convinced we should implement it at the lowest level
possible. While it would be nice to deduplicate the logic around this,
I wouldn't want to close doors we don't necessarily have to.

> > ---
> >  builtin/repack.c            | 20 ++++++++++++++++++++
> >  t/t7703-repack-geometric.sh | 27 +++++++++++++++++++++++++++
> >  2 files changed, 47 insertions(+)
> >
> > diff --git a/builtin/repack.c b/builtin/repack.c
> > index f57869f14a..07d92fdf87 100644
> > --- a/builtin/repack.c
> > +++ b/builtin/repack.c
> > @@ -881,6 +881,26 @@ int cmd_repack(int argc, const char **argv, const =
char *prefix)
> >  	if (pack_kept_objects < 0)
> >  		pack_kept_objects =3D write_bitmaps > 0 && !write_midx;
> >
> > +	if (write_midx && write_bitmaps && geometric_factor && po_args.local)=
 {
> > +		struct packed_git *p;
> > +
> > +		for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
> > +			if (p->pack_local)
> > +				continue;
> > +
> > +			/*
> > +			 * When asked to do a local repack, but we have
> > +			 * packfiles that are inherited from an alternate, then
> > +			 * we cannot guarantee that the multi-pack-index would
> > +			 * have full coverage of all objects. We thus disable
> > +			 * writing bitmaps in that case.
> > +			 */
> > +			warning(_("disabling bitmap writing, as some objects are not being =
packed"));
> > +			write_bitmaps =3D 0;
> > +			break;
> > +		}
> > +	}
> > +
>=20
> In terms of the higher-level fix here, though, I think that you could
> reasonably assume that the alternate repository has at least one pack,
> and that the combination of "write_midx && write_bitmaps &&
> po.args_local" and "has any alternate(s)" is banned (or, at least, emits
> the above warning and disables writing bitmaps).
>=20
> But certainly ensuring that there are indeed packs in at least one of
> the alternate(s) doesn't hurt either, so I don't mind this approach at
> all.

It's an edge case for sure. I don't quite mind which way we go either.
For now I'll just keep the current way of doing things, but am happy to
change it.

> One thing that I don't quite follow with this logic is why we need to
> have geometric_factor set. You could (somewhat unreasonably) write a
> MIDX containing a single pack (git repack -[A|a] --write-midx
> --write-bitmap-index), or a MIDX containing just the new pack along with
> all of the existing (local) packs, (git repack --write-midx
> --write-bitmap-index).
>=20
> So I think we'd want to drop the geometric_factor from the above
> conditional. (And in the future, I think we typically refer to whether
> or not the "geometry" pointer is NULL or not to indicate whether or not
> we are doing a geometric repack, though the diff context doesn't give me
> enough to know whether we have even attempted to set up that instance
> yet, so this is fine, too).

Mh. Yeah, I think you're right. I'll change it.

Patrick

--/3hyayNANoOJN/Hm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ30W4ACgkQVbJhu7ck
PpTctQ//d8Yv6e3Wotna+Y8RRAHmVbL3W+aZ013XcwHsZMaW445WPYjoXpyXHQc9
9Mn3hpSlMWjFnFXDwrnOITwcGQlrNWGL0M/pZBKukRfACdP1JkqC2vBLQ+nnrdfL
YL2r8c/5spHFejrCOfg3SBi1vrRgxod/WHgwkWHFXn6etqPKnZ8oeYaOWtFjQAkK
th82kIBKsuV2muBrCJDXIp5w8/Yv0Q3ywFCLcaLkMhTXp8d3eQfXMHISXdq8maef
XoPPr/ZQuNxA1zGucRiqkrGRAVmQhWTAOMlD+VvJnDdbK9QaEP8+XH/K0tHX2S+6
4Crie1/R7dbDRm6Tr5ARleTxL0Uwru37mg4BgrLcX+ne6mBZ4AJxAbIc7uFutrkO
xIrWPLByC6bcJxzfzxjc4rSI2uBNdzb//shgIhnykEyRxLCHPSqEgJ+JHLKJFJ35
Am9OAFkPpG9LE5qrfoSWnoZ2pt0I4f8ar19EpSDDjuKE4KXcvA0R9ABa4pTVTf3k
kpKdaNyMVLLFVc9pfn7uBVLBrRBry+ga53Kk+0i6qZ0KDkKnbpCu7B3pAEylU66t
kVGxB9Y9fVn/aI5SMNYWFOWM5Dm27hK7yxtGV/td6SbD7OIf3DUbHYNEyQYXzwuC
YKAsmNRVYXe6vrPmRXm4g9C2m6sEIw26KuX8lyy/5ZHaDuK4DeI=
=J7VQ
-----END PGP SIGNATURE-----

--/3hyayNANoOJN/Hm--
