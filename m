Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 669F5C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232348AbjFFFbY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:31:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232070AbjFFFbV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:31:21 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17BB71B1
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:31:20 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3FAB03200344;
        Tue,  6 Jun 2023 01:31:19 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 06 Jun 2023 01:31:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686029478; x=1686115878; bh=8Z
        PvF1EIzWE7EjFieSDqbzGnaTL98CLP2++ZVBH6els=; b=o/OOsVGbHmgGMr8abc
        E2c+243z5gB/F2LC7HS6008ME9h4CvKjl3wUaxDftYkv6PUN7pfEzADDO04MnzPb
        dCn8nUUAdOEQbeS3aURz9UGLDz5KO2HMHpV4eXsZDXkKqX+w+Wh2D1vkIb6Q/XT+
        G2pEumAaBGRI1Dqs9FpvIsoJf9vZIhRigyQuEDvRPtCoTPV/Xn1KPN+dLMhA6EdQ
        DUdr15tjDtezkQMqpGXznXjsxUB/RifG6ij2pVVyrzRtiWOqaPs5DM2My2jlootW
        xcai3nslaD9Dz4P/FxPKnTkiJCIipiA6HaD51fYyFtTS1WZtfpbFiBEnF73TD/Dd
        Hpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686029478; x=1686115878; bh=8ZPvF1EIzWE7E
        jFieSDqbzGnaTL98CLP2++ZVBH6els=; b=WY/TBhc2GbcLWzTAkri7ZRakJnPMj
        7ICrinuVe36ZMk/x6nF8j5NF14PWBNEkxWy7L4yci3I4TdyFTjGjITUcMqHAQb8J
        XUZuqqzDRmrywpTfudNXuziD6xvT8cGrFBOnuDD/AjgSMT7RbZkgIcOMMYQZxQhj
        G8abUlvIcYmwLmfaS9L7CLHEuryFoIgqQ0gwNLltkn1dcwWVKRqcg9ssdzKEhcPw
        UJH2Z4zGIDqM5QN+K96oQuvOe0Oc3g8Akd/AutlMEjrTgyZ8TXqW/6ZmD/PhQgF3
        emw5KHTXsT1xm1NCHZMmB6MRu8i+6jPpq8W7la4c+6JCCe/7NAMxfx41w==
X-ME-Sender: <xms:psR-ZNmEsj9CubNUufvyw08VlhgQlKVxob6u0akto2viC4mfj3s4Vw>
    <xme:psR-ZI2iX3CP7hFn1pJHnQXEL2vgGhVEwrjNMezHoYLs3SB4Zc4lEMEpsmGHqpB4q
    kmgztOHeQ1W3vC-0Q>
X-ME-Received: <xmr:psR-ZDo8H9w1qpQmFRBjqpMUop8my3o_IZOfcfhyyi9vHbB-yoMpK1kAONnAwL7Pft8_CESIbMxpqrzQZXDaQC3degjgiSEqLmSMXkCp8mw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:psR-ZNksxN-EXesCbCIdN_NJ7go65m4UOkX-chgB-W-7PN-DAzOgsg>
    <xmx:psR-ZL3SIUnohI-JD9ZLUTjK42Ka6NEw9q4D5knuXlW6oKaKq6OJBw>
    <xmx:psR-ZMsk3zMeq8MIATtngW3HbK59dH2U_cNU9ZvJs33QdSuhxsKWEw>
    <xmx:psR-ZMw4nZPslI-VU6z8dLI_4OqxjLLpSg4K2Fg8HoRmBhKuNMY2ag>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:31:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 85828f27 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:30:12 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:31:14 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH 5/5] cat-file: Introduce new option to delimit output
 with NUL characters
Message-ID: <ZH7Eoj_5oTzmSd4G@ncase>
References: <cover.1685710884.git.ps@pks.im>
 <07a7c34615ec68fa42c725fd34d6144b6b191f03.1685710884.git.ps@pks.im>
 <9900512f-b0da-2e47-f1ab-ed51ec2c78ff@gmail.com>
 <xmqq35355utz.fsf@gitster.g>
 <ZH67eBAtFxo95aBL@ncase>
 <xmqqsfb5np14.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="znZ1KOsWfUn3RjWI"
Content-Disposition: inline
In-Reply-To: <xmqqsfb5np14.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--znZ1KOsWfUn3RjWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 06, 2023 at 02:22:15PM +0900, Junio C Hamano wrote:
> Patrick Steinhardt <ps@pks.im> writes:
>=20
> >> Hmph, I expected "-z" and "-Z" to be orthogonal, the former
> >> controlling how input records are delimited, the latter controlling
> >> how output records are delimited, as it usually is a good idea to
> >> keep things that could be orthogonal to be orthogonal to avoid
> >> unnecessarily robbing users flexibility.  "-Z is a new way that is
> >> preferred over -z" was something I did not expect, actually.
> >>=20
> >> I am not outright rejecting such a deliberately limiting design, but
> >> I'll have to think about it a bit.
> >
> > Well, the way I see it we shouldn't have ever decoupled the input and
> > output format, and I consider it a bug that `-z` did as it makes it
> > unusable with arbitrary input. So I'd rather be helping the user of
> > these modes to do the right thing and NUL-delimit both input and output
> > than running into these edge cases later down the road.
>=20
> If that is the direction we want to go in, then the title of this
> step must be updated to say "-Z" does both output and input.  Also
> with the same number of bytes it takes to say "new option", you can
> say what that new option is, so do that.

Sorry, my v2 and your mail crossed, so the new title doesn't yet mention
`-Z`. I agree it would make sense to do so, and if there's a v3 I'll
change it accordingly. Otherwise, please feel free to change:

    cat-file: introduce option to delimit input and output with NUL

to

    cat-file: introduce `-Z` to delimit input and output with NUL

> > That being said I'd be fine to change this series to mean "-Z changes
> > stdout" if you insist. In that case we should be pointing out in our
> > documentation that "You should never use `-z` without `-Z` when you
> > process arbitrary input".
>=20
> You are not making sense.  If we were to leave them orthogonal to
> keep flexibility, it is because there can be cases where using '-Z'
> without using '-z' (and vice versa) makes sense; "you should never"
> has no place to live in such a world.

Well, that's exactly what I'm arguing: I don't think it does make sense
to keep them orthogonal. I cannot think of usecases where you'd want to
only change either of those options once you start processing arbitrary
input. If you exactly know that your input doesn't contain newlines then
you don't need either `-z` nor `-Z`. On the other hand, if it does, then
you must be using both.

I only proposed the alternative with the intent of being diplomatic and
not fully close the door on your remark in case you felt strongly about
it.

I've thus sent v2 to double down on my current approach where `-Z`
changes both stdin and stdout and tried to make a better case for it in
the commit message.

Patrick

--znZ1KOsWfUn3RjWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+xKEACgkQVbJhu7ck
PpRV+w//fnq5R69Ms05RcB9Tlu63BGxH4YzPgk9er/F2WGepIXZ1jolCTUzujULy
hUjgBQaNsxEkxRDT5+35PXTlIRpncJVto17ghC5V/IF4zzjzpARJS7nbOZI02HjX
gJmGT+bI7AFY96gxWD+2/3LbS7KWwQR3kcswllrYW5E00XUZGv8Fwp4/stobniGy
gb6/qrhHzUb/kWoHa1n36KDUBhg/UUuTy2HP7XxlEQoQLpSMxReahvpFxbX4J24M
2VdQoVNo7jobR64qlfIoByMz7qtN26i3JSG9s2PxHNie05LPTticRqWC4jMcc3su
03HcGmAa6WZa9crTc8k4jur5G+itDsErRYUfmrht4Svbce4BOznB2dWoxSGzw3sK
8wKf2JnA3jFluBLn6nSo92NuRygj3T1OX4jWuwnBD/qQYSqDWjFNXFaPtFj0JZlZ
QcFeuEZ2SlgF82tsI7nMJTZpFvz9YPZgiiHnk6RIR32lalJuZsEwuSv3t7zk6xcp
Nkm55+zfWIfHQTASSJha1r1koYhtyt5/Y3fEmOUAOAY6S1eK57/d/SAfkPBip7ZY
/XluxbQ273llA08QioeTDFlrkJFrvqF0OWpckaGEHa/Bz49QEAWEjGZGQF2MibWQ
VPOo9tG2e/51qsyNFvI6FWcYoTTqpOGnIa5IQSUlvKILXdjStF8=
=snv9
-----END PGP SIGNATURE-----

--znZ1KOsWfUn3RjWI--
