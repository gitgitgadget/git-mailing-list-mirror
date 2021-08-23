Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A61BDC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A340611EF
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 06:48:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234054AbhHWGsq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 02:48:46 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:58859 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231715AbhHWGsl (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 23 Aug 2021 02:48:41 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id DAE5E5C0160;
        Mon, 23 Aug 2021 02:47:58 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Mon, 23 Aug 2021 02:47:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=l2Xcb8WKjJvcu6nWOBRE+SHT8Ft
        tyx/59TnE7UtGmuA=; b=pcKryfhA+gpGQxrUORW3+PS10Ze6gNy4+3OXv2Tt5/F
        cJpfG4FKDXrKHNWC6s83Iy/LzS1/S1FJ/m4tsACa7hEPq1r6xsWV6PQBKhlGZlWw
        +JO7iNP4twjf6WXdPmNbUdtkA8v2WySF+PWV9KWCE8bdhtMudV+bEF0quMrV7L8E
        /5RNi7L7v3+t13XImk96qacLKH610Vicv0i38ib/cHL+drpJ7HkK9h1RS+OoHyFN
        J8u438H8A89wqMmmgqxi2CFZz3b0yU/T1eaVtaHyImwSt21tq1bvw/7GVE6e4PKe
        k40eCCl2l9uqM6bou8NGDEVc1MuQwF98tX/EFxejhvg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=l2Xcb8
        WKjJvcu6nWOBRE+SHT8Fttyx/59TnE7UtGmuA=; b=oNYTfxjCE0WwXe7ahQEa6A
        iVsvTVNBIAKo3vqyf1OysEhLW1n4n+4qmP8uq3ArlkdlojG9JLh3ulMVl+Oq6+Lw
        PmLYTrPZvqsQsNir5pLddFzBurZARltla/+VGlLqwyq/M70HN3IZRvdLPyJEKF7y
        O393YPvAhtoKYndsg/zjEZuI0KuxhrQbhocS2/Ooyp4B46OcwZ7U/k0FfP07ECkX
        3S+dlZeK1U3Ly/w9lpBC6Sv72kFOVoioTdjIb5L+I0bqUcnyF0bONtS69JnZD+IQ
        G+5FZDuFFvIOwT5GuhHfS7CVhEQ3XBLIJKwPtQ8UwwltfGOVWQlkfgPUe/IjRMUw
        ==
X-ME-Sender: <xms:nUQjYSAg0m4zQHbR78n-adyreukeKh-ZBry1tqmq3e7CPYYouznshQ>
    <xme:nUQjYciJyp3uZjDmksmTznTgmtlLRYEs2hZ9Mn4LIdeeSHvJUBhb-AohYwIT-if0W
    dFNSWLcJDPukHJR0g>
X-ME-Received: <xmr:nUQjYVmyxpKJbHA-1sKKKJOP3UHGX9WRREn9c-MGkDW8jj3h4xs5ihYxsKWOLrYto6unfpVX0E-sMidSER242SDo5DxS_9NkNRE6nyQG0xSGgk9lQUfHCYM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddtgedgudduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddunecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpedtffejieduudelhedvgfetieefleehje
    etvdetudeitdetvddtfffffefhvdfggfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:nUQjYQxSxd9BLaVZ_qAVmQOEHut3KMMudWy5Vha6XxUFdaYgfVfEsQ>
    <xmx:nUQjYXR7DtaF03BhbNM4YywS6rGtOuHY5nJDKYdpvnR2ZH7KVTGKwg>
    <xmx:nUQjYbZk6w4lbGGa-MyYbxzvgbSyUc-yAI7NJb5GT_Za8Zl4Waz8Mw>
    <xmx:nkQjYRdr251y1o4kO7W22hhPicxKBqxcVZ0hGZFT_jcXL-CXfuVz5Q>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 23 Aug 2021 02:47:56 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2a61589e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 23 Aug 2021 06:47:56 +0000 (UTC)
Date:   Mon, 23 Aug 2021 08:47:54 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/6] connected: refactor iterator to return next object
 ID directly
Message-ID: <YSNEmsO1ZIQXHs6X@ncase>
References: <cover.1629452412.git.ps@pks.im>
 <3bdad7bc8b0debd44138a4d3df5744d5a245475d.1629452412.git.ps@pks.im>
 <5f9e7a4f-d95b-4242-1add-7b20057293a3@web.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bCdYvg5s3XclfFJA"
Content-Disposition: inline
In-Reply-To: <5f9e7a4f-d95b-4242-1add-7b20057293a3@web.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--bCdYvg5s3XclfFJA
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 20, 2021 at 07:43:06PM +0200, Ren=E9 Scharfe wrote:
> Am 20.08.21 um 12:08 schrieb Patrick Steinhardt:
> > The object ID iterator used by the connectivity checks returns the next
> > object ID via an out-parameter and then uses a return code to indicate
> > whether an item was found. This is a bit roundabout: instead of a
> > separate error code, we can just retrun the next object ID directly and
>=20
> s/retrun/return/
>=20
> > use `NULL` pointers as indicator that the iterator got no items left.
> > Furthermore, this avoids a copy of the object ID.
> >
> > Refactor the iterator and all its implementations to return object IDs
> > directly. While I was honestly hoping for a small speedup given that we
> > can now avoid a copy, both versions perform the same. Still, the end
> > result is easier to understand and thus it makes sense to keep this
> > refactoring regardless.
>=20
> check_connected() calls find_pack_entry_one() on the object ID hash,
> which copies it anyway.  Perhaps that and caching prevent the expected
> speedup?
>=20
> The private copy made sure check_connected() could not modify the
> object IDs.  It still only reads them with this patch, but the compiler
> no longer prevents writes.  The iterators could return const pointers
> to restore that guarantee.

Right, will change the signature and re-benchmark. I'd be surprised if
it significantly changed the picture, but let's see.

Patrick

--bCdYvg5s3XclfFJA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEjRJkACgkQVbJhu7ck
PpR7ug//TzHPnmlTy3vKM7kB+HW2LMSXlOx+rw80MTTUKurbjR9mESpxLoE3wDQJ
wk+bm69q9WYLAwlpgruJ+GGV3/Qcu/b24VxOP2wlEmWBuGpjhdG7irMBXfdT6R2a
ovnVB8iDGY0Qc3JAg4Hjy/MeJUmcPfVg9vi9/BhJHqZGXwWeYtXy+3A4Up7+SVd/
KX7DCok0GKZalju1SVE4k8q2yydKSOetzAAr8l+HUhuetKXLwLEZCt9yn93qkVIE
ZSXIgGk8HTqFytLCOZdn048dYdbMMSDhZmY1vwCWs2NwVQXL1FSKo6Jk+LtAEb2m
13HZxYuj6l9JadgNVrH8TEIY8zLoy4q9w+edCnSjgsbGpKkc4laeDjsyeggPTLra
sV/BlzT3LVriCxl9i8nzv/5QwoR1ijYLys/F5SOIlW5j9sC3+GobLVp24TRGuqFI
keNLHMIwL/xdlPxh3hztJ+Ar5fmrgCRnH75ZAKZSRMGEGL/HcyGTSv4r/ogexHha
cAS9KD2LqutcJFow8idoDiPHN8vUkWR9kRaIAoUuMz8AEisUJ69Q4eKhCVPTED4C
PUkY9JxEeZ/XFU5MYpGhqKkne1KtOnFyK0wKgqMQF1mEZVrFdPjbDYKvHcx444L0
bSyJ5Ety9GbhOV+PsJF1zZwHVqXMbZ1hr/nwy0EQ5xRRiFeDtzQ=
=fsU3
-----END PGP SIGNATURE-----

--bCdYvg5s3XclfFJA--
