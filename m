Return-Path: <SRS0=eX0j=BR=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC65C433DF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:49:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3633B22CAF
	for <git@archiver.kernel.org>; Fri,  7 Aug 2020 09:49:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c+nmsmU2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bOkCkb8R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727878AbgHGJtv (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Aug 2020 05:49:51 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:42161 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727081AbgHGJtu (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 7 Aug 2020 05:49:50 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 71B125C0199;
        Fri,  7 Aug 2020 05:49:49 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Fri, 07 Aug 2020 05:49:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=px9HIFS7MX5H+hZkMr0+jiY8uOM
        LuLkzxmmJK0Zj/Zw=; b=c+nmsmU2G5eBQ/270qmx3C+mMuu2woHLvuEMLyoi/ES
        +HSHeJ04xSJLsr0P3YRt03xjGMdGcvlSq8kX5imVlQMuE2G0IQ8vDBzWuNNgvUIL
        y8Y20Izy4MCtuXvlzQi9N6txurYUeSbHLtQcXY+7jTPcxjz+qUVPBHb0W32YuFrA
        Ly9tw2c9tnIzi2vnbvwObMbCJZZuEkxchx7mlJTUCMb1ejX+9ye5OEc6DubAHwZt
        hb7MJ1uAMjjkS6/UHHmj343pIqeCtJaTV+xTWPf33ZOUmLvKMq3dxPTkA5iKBSNl
        EYk5YelRhsW9qwMEiESv3Q0hW5M1Ghm90VWGVeWiFPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=px9HIF
        S7MX5H+hZkMr0+jiY8uOMLuLkzxmmJK0Zj/Zw=; b=bOkCkb8RFfqTrJSLkDTXne
        F9kie551i+8IXhVNL7xJ1sYBFfA1Y9qTWIDONbeZQCp2ivfT1H3LXLNhebPCuN6k
        mim+0BPysHuKh4LiD+3A3hFxG10g3RNMun4ytDquAURzfcGt58sxHO4srcsdm1EX
        PrNglPT055cs0W41A9Ryt3V3DyPA2kkxg8GVDNIH0vKV6k8YlozblKmwIfhRA96P
        xYUYnF1xXijMdrLOnGOIbRb4MvMy5K/R/PVNbS3mGHZsQ+6MI1+ltVdVmqDNum9F
        j3Dzv6T5BbU3xK/7ii1++/NMIWeye/y9TPtrvVjB0sfJ3tutTw2KdHJHyZfCO1iw
        ==
X-ME-Sender: <xms:vSMtX4IGNWjIQm-FjuaFRVLu0hdjWTZ7RSSnQqajfPLGGqwQN4fOwA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrkedvgddvvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrddviedrudegtdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:vSMtX4KtOgbkBIqYPKjTgieOZgkpG89qZe5_6OHwVTIBMuVM0tV2jA>
    <xmx:vSMtX4sEFwbNzizbXvyHcBLH8NpohR7U336hi0e2arAzS5orNJ-Jww>
    <xmx:vSMtX1Y96UQuzO74sSJyxuAETi-jLC9_wPwOOOhAv7X9YHvG9IFpfA>
    <xmx:vSMtX4n_-ph40SFwpwNRiH0ioskulDcPsJgXAO42jMFiKCj4oc0Sew>
Received: from vm-mail.pks.im (x4db71a8c.dyn.telefonica.de [77.183.26.140])
        by mail.messagingengine.com (Postfix) with ESMTPA id 6D5A0328005E;
        Fri,  7 Aug 2020 05:49:48 -0400 (EDT)
Received: from localhost (tanuki [10.192.0.23])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 55869c67 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 7 Aug 2020 09:49:47 +0000 (UTC)
Date:   Fri, 7 Aug 2020 11:49:46 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] refs: fix interleaving hook calls with
 reference-transaction hook
Message-ID: <20200807094946.GA1758126@tanuki.pks.im>
References: <63fb363375b515b903ed1269d10124b727c1d1cc.1596783732.git.ps@pks.im>
 <20200807075837.GA32344@coredump.intra.peff.net>
 <20200807090412.GA1407904@tanuki.pks.im>
 <20200807093239.GA1228157@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
In-Reply-To: <20200807093239.GA1228157@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 07, 2020 at 05:32:39AM -0400, Jeff King wrote:
> On Fri, Aug 07, 2020 at 11:04:12AM +0200, Patrick Steinhardt wrote:
>=20
> > > It's perhaps more justifiable when there isn't a hook (we're still ju=
st
> > > paying that one access(), but it's proportionally bigger). I kind of
> > > doubt it's measurable, though, since a ref write requires a bunch of
> > > syscalls anyway.
> >=20
> > Yeah, this really was done to not have to pay a performance penalty if
> > updating thousands of refs if no reference-transaction hook exists. E.g.
> > if doing a non-atomic push of n reference, we'd have n calls to
> > access(3P). See [1] for reference.
> >=20
> > I've just did another quick benchmark without the cache, and it still
> > consistently shows a non-zero performance hit without it:
> >=20
> > Test                         pks-reftx-hook-interleaving   no-cache
> > -----------------------------------------------------------------------=
---------
> > 1400.2: update-ref           2.82(2.13+0.81)               2.86(2.19+0.=
78) +1.4%
> > 1400.3: update-ref --stdin   0.22(0.07+0.15)               0.22(0.07+0.=
15) +0.0%
>=20
> I'm skeptical that those results are useful. In the first test, we're
> running update-ref 1000 times, so:
>=20
>   - the cache shouldn't be helping at all, since we only have one ref to
>     update (well, I guess once for "prepare" and once for "commit", so
>     really it's saving one syscall total per process).
>=20
>   - I'd expect a lot of noise because we're spending most of our time in
>     starting up the process
>=20
> In the second test, we run 1000 ref operations per update-ref process.
> So we should be cutting down on our hook-lookup overhead by a factor of
> 1000. Yet it shows no improvement.
>=20
> That implies you're just seeing noise. And indeed, with the patch below
> I get:
>=20
> Test                         HEAD^             HEAD
> --------------------------------------------------------------------
> 1400.2: update-ref           1.93(1.57+0.42)   1.91(1.55+0.42) -1.0%
> 1400.3: update-ref --stdin   0.07(0.02+0.05)   0.07(0.02+0.05) +0.0%
>=20
> Running it a second time gets me +0.5%. :)

Yeah, it's also been my take that OS-level overhead is probably going to
matter more than those access calls, and I argued such back when I
proposed the hook. So I'm perfectly happy to see this caching mechanism
go.

Should I re-post a v2 with your patch and my test?

Patrick

--GvXjxJ+pjyke8COw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl8tI7kACgkQVbJhu7ck
PpTZaxAAmRla9sYdXKbD+Vf05uptZUAYcQsGmdb5Ymvq7gvtpKf2AXdFKa2v63OF
nw+lzA9Au9jgKClA/VCe9608mFmh/26ezM+s8XHeU6Bj+DZEAiw3/4vjaF2FBXj0
/gI+pg07vBRwOL89aB2TPlu3/I0NT0iQ/TXcNuzhsiMY6y0KmksOPlkj4olQuklj
grhmk7Nwui60hmEo8HWC781SFEPQsiLVlBHXgsiWdA19VJGCmIqJ7DXxmt4J4DiL
gvYeQRzVgc4gW6gnAaVZcNs2SXjXNFx256GEdmQgsDdDMy2/TigVFAlD5jgHzwlL
z9GaD1o/G6nHBOy82aSjw973ptldczI1X68q3gQ4V2RZyE2C8GEkUJu/pCNEGfvA
1XmIX4/YCz5KPpCCr7hdOTsNtontmW8SA69RvhRQbxa8g+cKD5MMRSQi/sI3N5Mx
K8vrDsuhWoYeqQKLnIJrqpXW7vtO2ZUQj2zVMHjUU5H8i0eDxlcAxCaXVwacoBdy
md+wCaDSZ3kO99OVzPbEKyIgJP5h9elCIVa5p7fi4rIZq/Xfn99nK4CFuJ4skwj6
Az5nAZiDhWr7sNznDRvbsFDLPVA5ockshppazOhNd7FdgGtnk0LL/DF2ahbaXkXQ
GPytWvLCDGtgaEdUZyKXk/yphBGhXiomr0NQ65bVNIFSWvf4Dro=
=GYh8
-----END PGP SIGNATURE-----

--GvXjxJ+pjyke8COw--
