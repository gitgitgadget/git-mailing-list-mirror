Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E544DC77B74
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 17:13:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjDKRN4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 13:13:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbjDKRNy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 13:13:54 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA5A24228
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 10:13:53 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 1F40632008FD;
        Tue, 11 Apr 2023 13:13:53 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 11 Apr 2023 13:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681233232; x=1681319632; bh=8b
        gxFSm/RfowwNXyZC+LUPFjiG1ewqsdmDMuYBSOY2Y=; b=UtUp5ZO/S0L3EDZ7vn
        uT2OTJTtbocyFk2D5bgB2QYOSO/uQxdr35736Sjsg+C7EQCwGXccy7G9uUK5t5/x
        QOr1L7TwlxgnTtMWTSm2nByub6rAD2L0hdeBhYleeId+jWs367xLnGfEV/tWLtD5
        aTtiDVNTYwOISuy9AMAZsUYyyq1xRFnwAjCf5OF39RTRD5XhttBDXpTJERV6gpra
        uRS2rJzu/Xi2WfmPfyiQYmhgEuVLijOGSQDFaVOHbWGdBzJOjy0eGR0UeVUbB+oa
        3dubi5bA/sERXaU5svI1Vp+eCQYJ2z2RazAL1R7tGqfCqcn8QX0rLOtHFyst8yqY
        tj0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681233232; x=1681319632; bh=8bgxFSm/Rfoww
        NXyZC+LUPFjiG1ewqsdmDMuYBSOY2Y=; b=aK8QlxOdHIxJF/bQvlAHyeJZ7yoYA
        Xed86i8GYYl/mgy2xgyr+TBmXTBJbo13F3rxEgT8y7V/sLXf6L5HmiU7URGEHK7W
        lmOQBRg2AcMia2ssyaZwGhy6JoO/ySzdzCn7gLBJlQcEb7xEL2ER2ZGHN0ACRd1i
        XKSG75X+sH4EKztqNEY93bJGnLgFICCJdz91IJeYNtLL8XFRlgxXft3rmwtm+YPn
        1pUsHIMG0gL8Qz+Z03V+JWxoU/YV9KOSZfujTvD6AWI0Dn6PXf2rcZ5YhNnBkJX1
        ItEY0Wu6gEImBKIDjyhsr8a3ivbWSXdIsmj8TlxP5dk6Bm5z9nnffGgMw==
X-ME-Sender: <xms:UJU1ZNrN6BdNuNoUIRYe_mnOt2xMu5vS8ADZmWJ0d-Hg2VrQ9vgq8g>
    <xme:UJU1ZPqd_28mEZdo4K_ctV3XmBNsXXsJq7KcLZhZE4AUfQAK0GeZSbRDrVBkxT6_3
    zJdVCJx89ts8skTVw>
X-ME-Received: <xmr:UJU1ZKM3nb0Z0WbOSUDPZFhZog_Ln_a5qG5vxMl8rGrb-i4sARHLZP0Xzl2vG-5oLxntgnc_-sJMk3gPkrGztGCKviQz62NRqo_FfCCx9HRmsQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrght
    rhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtth
    gvrhhnpeeukedtvedtffevleejtefgheehieegkeeluddvfeefgeehgfeltddtheejleff
    teenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpsh
    esphhkshdrihhm
X-ME-Proxy: <xmx:UJU1ZI6OFOV4Mjt9qPCGL342fIX2x-oNEKudR0M0Eq-g1vuxtTIaSg>
    <xmx:UJU1ZM4KAM2ViPC0SgkpWc2fYl11KH1Yqa-n9_Sj3cXd4c06UtNWmA>
    <xmx:UJU1ZAhKiG1L_bQZ3xwAW18sInGs9uCO_jxYIClDe5dNdupQsuuqFA>
    <xmx:UJU1ZKnoXFXU0iBYdIunpqln_MXviFKUEyiSGSCeA8XJ8b_wBc9kpA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 13:13:51 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id d0e02ab7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 11 Apr 2023 17:13:30 +0000 (UTC)
Date:   Tue, 11 Apr 2023 19:13:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        peff@peff.net, dstolee@microsoft.com
Subject: Re: [PATCH] repack: fix geometric repacking with gitalternates
Message-ID: <ZDWVSuFJLU54txwc@ncase>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <ZCxytq1esQWvjIz/@nand.local>
 <ZC0eY8q6ushpfkrQ@ncase>
 <4c7b95e1-9d3c-e253-98ca-ac6c201babb3@github.com>
 <ZDSgbYa+j/5c5t8j@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="qzGvPAKTNqUYDl3/"
Content-Disposition: inline
In-Reply-To: <ZDSgbYa+j/5c5t8j@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--qzGvPAKTNqUYDl3/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 10, 2023 at 07:49:01PM -0400, Taylor Blau wrote:
> On Mon, Apr 10, 2023 at 11:06:49AM -0400, Derrick Stolee wrote:
[snip]
> > Perhaps this method could include a step to create a new, "local"
> > geometry containing only the packs within the local object dir. We can
> > then skip the --preferred-pack option and bitmap if this is different
> > than the original geometry (perhaps with a warning message to help
> > users who did this accidentally).
>=20
> It would be nice to not have to juggle multiple pack geometry structs,
> since the logic of what gets repacked, what gets thrown away, and what
> gets kept is already fairly complicated (at least to me) and pretty
> fragile.
>=20
> I think if I were sketching this out, I'd start out by doing something
> like:
>=20
> --- 8< ---
> diff --git a/builtin/repack.c b/builtin/repack.c
> index df4d8e0f0b..eab5f58444 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -558,6 +558,10 @@ static void midx_included_packs(struct string_list *=
include,
>  		for (i =3D geometry->split; i < geometry->pack_nr; i++) {
>  			struct packed_git *p =3D geometry->pack[i];
>=20
> +			/* MIDXs cannot refer to non-local packs */
> +			if (!p->pack_local)
> +				continue;
> +
>  			strbuf_addstr(&buf, pack_basename(p));
>  			strbuf_strip_suffix(&buf, ".pack");
>  			strbuf_addstr(&buf, ".idx");
> --- >8 ---
>=20
> ...and I actually think that might do it, since:
>=20
> 	- existing_nonkept_packs is populated by calling readdir() on the local
> 		repository's $GIT_DIR/objects/pack directory, so it will never contain
> 		any non-local packs.
>=20
> 	- existing_kept_packs is also OK for the same reason
>=20
> 	- names (which tracks the packs that we just wrote) will never contain a
> 		non-local pack, since we never write packs outside of our local pack
> 		directory
>=20
> So that would cause you to write a MIDX containing only local packs (as
> desired) regardless of whether or not the caller passed --[no]-local or
> not.

I think this doesn't actually do anything. The reason is that the
`--stdin-packs` option in git-multi-pack-index(1) does not actually
treat the provided packs as packs that are to be included in the
multi-pack-index. Instead, it uses it as a filter for `get_all_packs()`.
And as `get_all_packs()` returns packfiles paths prefixed with the
alternate directory's name, but we pass in basenames only, we would
already be filtering out any non-local packfiles.

So ultimately, we would only ever write an MIDX containing only local
packs already. It rather feels like this is only by chance though, so I
think it is good to include your patch regardless of whether it actually
does something or not. Better be explicit here, also as documentation to
the reader.

I'll include it as part of my patch series that I'm to send out later
this week.

Patrick

--qzGvPAKTNqUYDl3/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ1lUkACgkQVbJhu7ck
PpRtLg//RRCjupHlVSesi0GitqynsHIdv/yh/4CdGVwluSQIOepOohEVzi4fg2A4
Mt4EyHKE1rHz5WPbmSM3INvCfdrjdMBbhf2eNZdUdENZKKqwQfqUCJnzxAPjUWBa
NiuVXjStyYHnpjzU0qXyURqQivDWjzvw+8/01KTHh1otpJ1z4J+kzSwx38x8Gnb8
b2BZFicWrjWV3cqlEKDorODPNkstJmNQB/DENL6qgtIZe3VdOKYGlMmBEWvyhCdW
12uUNXTBQrb94mA5WjvBSxvGt/KDE7K7L7jIEcIC3ZgZ52JnMBBTxt0xiWuerK35
/HRisKvWddrYhbieHFN5u3gz4R3rciGItrIJTonHpE9oLhIYuiiCqondn1xIFCwp
Q/vVTVZxzO5Z+eYzYpGurZIwZT2rqEoeIDWqm5t7gtqEgvovGg1HQurYKrIFgOc+
W0rR8Lx2Ri8elH+i3Y4g36L2YIuXEmworm41HGgtAUjy0NlPThxmdBi33N98/DUC
4EeFXu548X4uw4LnkrS2cIfp1k0Jjst7cb5f7sTfoPVcIkfKD/r78S4H3ERI9lmd
PaJvIg5FDOlXzHTRCwXLkn1cuhHA9URujjI0SKzRb5SJp0Y4LHqfS9VKnl//yooi
10jVfihDuMUn3ZdMAd7ZED/zS5Itv3JnR1vIuZnLf1r3VP6uq4Q=
=nX9l
-----END PGP SIGNATURE-----

--qzGvPAKTNqUYDl3/--
