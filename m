Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB8B9C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 06:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232154AbiKOG24 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 01:28:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232151AbiKOG2w (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 01:28:52 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B379FF5
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 22:28:51 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 525D65C00DC;
        Tue, 15 Nov 2022 01:28:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Tue, 15 Nov 2022 01:28:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668493730; x=1668580130; bh=Il2jkQEyg4
        y/DUGwxTor5mTHjAQ/XidlfC4rz3QgWnE=; b=wjEkeIgfM6jPFluhCW8SGWAFv3
        XJ6aqUfxzhh9Ug2PoQ0o7eGa/oQ+8Swm2pG+sceeCY3i+QWeXjA8iKEXPXVu8t1S
        rb0Ei6oNPiTAGjkyFgVpWFfBuM0M3ZWt68v1HPw4f33Q7BT3+LLN7JEMBdFSZ0aE
        kz9dDC6k5R7u0vHWTz0NDV5IOtOxVpjnCrYY5769cuRakAKb8Pcah3BFjkOeY36d
        lJpjC1HSvtbb2Kszl9yTBdZTxe7uec4VGeGtClICLrrfn4Be7frG/b8c0UyeJux0
        A4xdZt/iwqkQ8IZnF6JM7B5Qb7teImv1ARM8tshDZEFViq8oshixFMQaMMrg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1668493730; x=1668580130; bh=Il2jkQEyg4y/DUGwxTor5mTHjAQ/
        XidlfC4rz3QgWnE=; b=ZiOIy/+ShZjvMPiN3gnNGB7ipCQ8Sd3m/7+u5LOEgBWg
        DwxeeHoSYr5IyZNOFlj2LsNdfS/UMxunbbwYwt57lW9RKnGbsQzrYtm8B+Bw86gr
        qasGrfoUvaT5aAUA0TEPWqJx61rni0jlwnPqVBxP1d2O5xnplXVybdIc45hG0zqo
        Jnl9+/1PyEvH1VYXNBcGLubPiyIY87a6QpTX5q38IVA613rl8WquU6keCbTL+Gzl
        sGOf34kVUNPlt//U9DXeVI+y+DuenOwcJmTG4rDAHmQe0gn2eTI8RMZ7gnHi+Gxl
        W74MIZ+YQTbf5Y+YMmYl1jZCMbZUotlV9TO5sU2/jQ==
X-ME-Sender: <xms:oTFzY7g3Kx3JqqThldbCkY0KXwPkJm17pGhix2d8PQ-njI8hp_29Xg>
    <xme:oTFzY4AlDHULW5gnxhlYwt_lihZbcN3YY7MDv-rUZ375ab2s1ysX8V4ytenrIqSbU
    DhYzq7fTFSSnRcKHw>
X-ME-Received: <xmr:oTFzY7FPPUm_9g4jWnFXychWGPv4o8CT_sy9g6ek_kIOL8EvXgEoIZkasXXGjtoUPvK1GTNSH65X80FHgOcZ06EFf7CnMdCutLb2ljQppYDV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgeefgdelhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnheptdeiteevvedukeekheeiueevtdeigffgte
    fhkeelgeevtdejueelleffteeuieeunecuffhomhgrihhnpehpkhhsrdhimhenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:oTFzY4Rgw3583G4pQXyxcMbL2d4cNDc_UyQCBhoaWDLc7oLvGg1--Q>
    <xmx:oTFzY4x02i_SCx7YvTVU-szO_6BUfhVP25_dWogz69u7-bQDKOdl_g>
    <xmx:oTFzY-4DsP5zAOkkruLwndlIcWpPqfXE2T0Pxu67XVYYsk-CoT8NOg>
    <xmx:ojFzY-ZRSCH4v85P345E34VcvBA89p6N0q9Y1wTvCi08dFfpKQyUXg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 15 Nov 2022 01:28:49 -0500 (EST)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 9cf9d366 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 15 Nov 2022 06:28:35 +0000 (UTC)
Date:   Tue, 15 Nov 2022 07:28:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org
Subject: Re: ps/receive-use-only-advertised
Message-ID: <Y3MxmzestKm9iMTU@ncase>
References: <Y3Mag8qG2D3qjlmg@nand.local>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="xd9d+SmodxnwkWdW"
Content-Disposition: inline
In-Reply-To: <Y3Mag8qG2D3qjlmg@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--xd9d+SmodxnwkWdW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 14, 2022 at 11:50:11PM -0500, Taylor Blau wrote:
[snip]
> * ps/receive-use-only-advertised (2022-11-11) 7 commits
>  - receive-pack: only use visible refs for connectivity check
>  - rev-parse: add `--exclude-hidden=3D` option
>  - revision: add new parameter to exclude hidden refs
>  - revision: introduce struct to handle exclusions
>  - revision: move together exclusion-related functions
>  - refs: get rid of global list of hidden refs
>  - refs: fix memory leak when parsing hideRefs config
>=20
>  "git receive-pack" used to use all the local refs as the boundary
>  for checking connectivity of the data "git push" sent, but now it
>  uses only the refs that it advertised to the pusher.  In a
>  repository with the .hideRefs configuration, this reduces the
>  resource needed to perform the check, and also forces the pusher to
>  prove they have all objects that are necessary to complete the
>  history on top of only the history available to them.

We have at a later point established that this is not true: the pusher
does not have to prove they have all objects. As the `--not --all` part
in git-rev-list(1) is merely an optimization the semantics aren't
changed at all

>  Expecting a (final?) reroll.

I think this is stale, right? There was no further feedback until now,
and in your [1] you say that things look good to you, but that you
intend to wait a few days for further feedback.

Thanks!

Patrick

[1]: <Y27KL0Yg7nzdQ+HC@nand.local>

>  cf. <221028.86bkpw805n.gmgdl@evledraar.gmail.com>
>  cf. <xmqqr0yrizqm.fsf@gitster.g>
>  source: <cover.1668149149.git.ps@pks.im>

--xd9d+SmodxnwkWdW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmNzMZoACgkQVbJhu7ck
PpRGQw/+PgEEllfTdZFy1C/djeKdndYOeFd4FuMskwmtRrSPI7lJPR2X3HAU44GZ
M9YZ4AURBwEbeUHacHn9CpO5REr/GCY66xgajlJbpWhc9pJOnTMsPL+OiwAHK9Gc
cNTXgK4o8zXbDwBo3VKBm4cpVo1vyggkmT+n9nbfrqXkqqdKAZkMw2Lc5xM3eOCB
4ARgknfNj0oaTfQpYtGdai3jmxHQfLG3mvQApNskAbSRCf/dkbNPJdqTfy1ERYyC
Xp0lBjo7omsnJ+jYs5mr2vlmihBfwuDLw5DdV5gXCLkRyl+iBaTL7XUY9jvTjpEN
XJvn9vZ5mem+gToLtrx+szhet1AZQXWuW6VWu3zlEJbwYELTkgnIpjxSBbg/00yW
2AfbBh4bzP/dkmIy7+gjlC1vpOhUrdPzG8KsOqXl9oleLvRm2fZgx3T9jhu1CeuO
+oNrN8YBsNpbw9wYEzqldQsBNvmOE62h9idIfFQfbLSmkhfrgFeSgrJHz8Z7xUKJ
4kJq6JYDs7FSMK8PmAEZEEyi38nOIl2NSFx8nPkNh3BR42VSOLTNqzvkQLwmd8zH
K1ZY99SnXygr6xKYYgTY2piP5avyo4m2G67XkgZ+WBhysavQBmt1pKtYYoCEr+5x
0w/2tjFShzPOzxcshOII7ykBw4e+pypaihQuD5wJyZoIhRXw5vE=
=X7uy
-----END PGP SIGNATURE-----

--xd9d+SmodxnwkWdW--
