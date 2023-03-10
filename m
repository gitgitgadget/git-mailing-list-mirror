Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 663E6C64EC4
	for <git@archiver.kernel.org>; Fri, 10 Mar 2023 11:49:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjCJLtR (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Mar 2023 06:49:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjCJLtP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2023 06:49:15 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 478E0898CD
        for <git@vger.kernel.org>; Fri, 10 Mar 2023 03:49:14 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CD46D32005D8;
        Fri, 10 Mar 2023 06:49:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 10 Mar 2023 06:49:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1678448951; x=1678535351; bh=wG
        Z0aOteu6b7DgndX8Fjz1G4Yu6+/+AqFk5TFJVM8R8=; b=lmRlQubZXH4wri7Idj
        KATQau2sCoxxmgeNfLyPGjO+RHVF3uk7GxVZEhdI+hIwt5YZUDbXp+RBdsHrNe4c
        ciA+iqaaMaslCsgxnic7EOG8ygo8RwIF/vHqRYrtFHKiPZcqw9a0k6xk8oIvJJ9T
        4fbO2kqoqIKC1YtjIf/8L9nxOfH/HBOzbjTtIvXi8+0PKTuQMnUOYdQJB4ZLc9g7
        BMaQTz1n2+yEF563zTT7+jjYigZ6b4yLhWV1VUivzAn15kGhu440apFd2Uug0vnk
        Tpkj2WzlYim4p2gV69SWt4UKC0gWR3LogcjJLWU04U6uAX8xwFPge5K4elpBaZIk
        DzLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1678448951; x=1678535351; bh=wGZ0aOteu6b7D
        gndX8Fjz1G4Yu6+/+AqFk5TFJVM8R8=; b=ppaWvuwpowV7QUwXhBUJ33V+JxW9M
        vQbRbByRYWj07Uylgrx9ks+2NSVUcpK8zLRJmOaz87St+DTEXsHfb8aYILwbntEz
        1dMyyq83MrAQyDOqCB0xBeyYs0uqSmcg7ZP0ps2toIaregNWCtN633aJakf4250w
        50RiMiBWVCMcsUiYTBCgVR3UzLhlP7ZoMyXr8wMiXE76AQdBcY+TfQhUj0snO+B8
        m2/lDAs7NXOyopghFRrrR30WmWTDxbA09/7aWjepFb7HB8yy7b2xcDsu+b/tb2GA
        XZpmwM0cQComtK4YpGwLTlY1yobFHZkYHW0Ecgem2hhxWB139mmQmxf1w==
X-ME-Sender: <xms:NxkLZDkCSaP0yC3xRIKj25Lw2QXm4WOZ0ibD-bLU-Tu9IVbSzPQlbw>
    <xme:NxkLZG1El-BfmZkh9MUrMTEDOziRbsKvoV9aLq83K54IAj4QLZQhlk5DAasuNL9an
    fCyr1s5W0B0QFaNSA>
X-ME-Received: <xmr:NxkLZJpovhncuB0izP9wBh-wpaaY_5OoZaLUm4U8GdytuDqxCyU97SUI3ZV_7IFNlS7mi7dDcJtVBXqkPzfBp9GqWkBUERZYVmE8b4MESRSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddukedgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:NxkLZLlR6EYnWOB8qxn3edhTjjb_KGXgxTqoXT3ozrrV5oEAW1icoA>
    <xmx:NxkLZB3GJusUjY1oBj24fth1Lm3IOnQ4D2NE4MtOcv0pCWFd_AgMmg>
    <xmx:NxkLZKsEIz-XNKKDxhFzGznY3h3iybWCuZjg70Ug3_baC3F9XHyzOA>
    <xmx:NxkLZPCZB8eX8pouczWqqye2C-bbR3ZDQQTFxM543n03KSnatKZ33Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Mar 2023 06:49:10 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 39ced06e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 10 Mar 2023 11:48:55 +0000 (UTC)
Date:   Fri, 10 Mar 2023 12:49:04 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] receive-pack: fix stale packfile locks when dying
Message-ID: <ZAsZMAhgag1iBSK5@ncase>
References: <e16bd81bf9e251aa6959fbe10a3fbc215a4a1c12.1678367338.git.ps@pks.im>
 <e1ee1d8026a361bc58d16bc741e2b347ada7a53e.1678431076.git.ps@pks.im>
 <ZArvkVPhF4Th424Z@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ebIoBB6Cye5pTT8I"
Content-Disposition: inline
In-Reply-To: <ZArvkVPhF4Th424Z@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--ebIoBB6Cye5pTT8I
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 10, 2023 at 03:51:29AM -0500, Jeff King wrote:
> On Fri, Mar 10, 2023 at 07:52:10AM +0100, Patrick Steinhardt wrote:
[snip]
> >  builtin/receive-pack.c | 14 ++++++++++----
> >  1 file changed, 10 insertions(+), 4 deletions(-)
>=20
> There's no test here, and I think we _could_ make a reliable one with
> something like:
>=20
>   1. Have a proc-receive hook that signals via fifo that it's running,
>      then pauses indefinitely.
>=20
>   2. Start a push in the background, then wait on the fifo signal.
>=20
>   3. Kill receive-pack.
>=20
> But it's awfully complicated for little gain. I'm fine with not worrying
> about it (and I did something similar manually to make to sure it works
> as we expect).

I actually tried doing exactly what you're proposing here yesterday. It
caused hangs, lingering processes, you had to play games to not trigger
the &&-chain linter due to the backgrounding via &, and ultimately it
somehow just didn't work.

So at some point I came to the same conclusion as you did, that it's
just too complicated for little gain.

Thanks.

Patrick

--ebIoBB6Cye5pTT8I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQLGS8ACgkQVbJhu7ck
PpSNRg/9FWzukSxjRMsL6RjIxwvymPfVi3VLHx7FV4DUYCQ5d3U63JuyOp4C+T7J
Mx8lpEC6xBWWqN/0zGhMMP/y9pewXy7DrwhBL24OL/mbhztrL9LUrsX75KZI2QTw
sTHl/GPBp/G9Sa2mKzxhOMUf6hgopGgxE1eUBBRIEjRxfQpfAwohPvFPtJQ5WdO8
eYVe35F6uQmOzSUQJyrrQr48sbcLk3dtF2m6AxcicoKBciBgu3VzI7dm9ydPX2U2
YrZpDnDWHFxA22CJUNHQj20oApKhqUJE2UomIn+TUYE+JusHGH39ZApL0Ib3Nkei
9je5VpGhEtLw5ryfojEMVqnTgZ4YuAVFOCqtBb2M8/myjTF9f1Kgm4MF/m5yXYbf
asZhh71MOM8Dkv82rKabj7wNJJwLhgJLguRIWQlA3Oomh2UzLnhqo6TrhmwFjZL7
o6/w2jVQ8A9M/Yu190bhuJWLmrZQevg6NqZrqCRFSyb/+9dogu1W69SJ+IPwPstm
bhIsKnkCgf/nfPoILXneG06oL8N6WC92Gg0/HIP+iCHReIdCCjrBRCacCL2DXnie
RN1xiv1Ov9Or8NlvOXi81g+JzJaEPfIjlBIPa7Wn5KpVLwJhbgkCOUO6l/S51HGN
wgi7FTF3+VY4KYk/oqoFeYyYXcnmdL9/MN3TGRbwv7/oraIgPvM=
=d6jB
-----END PGP SIGNATURE-----

--ebIoBB6Cye5pTT8I--
