Return-Path: <SRS0=J6fK=EP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B83C2D0A3
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE58020663
	for <git@archiver.kernel.org>; Mon,  9 Nov 2020 10:06:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="drjA6KB4";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U5+GQXc6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728462AbgKIKGu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Nov 2020 05:06:50 -0500
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:59415 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727077AbgKIKGu (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 9 Nov 2020 05:06:50 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A3874455;
        Mon,  9 Nov 2020 05:06:49 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 09 Nov 2020 05:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=fpZ+3tIO5owrcCM0XRuIHDZ+3Yj
        8z5b1ji76WN8p9Pg=; b=drjA6KB4S9LrUz39D84Adl6u5UlFontZ2shiPsipstW
        hS6y2/LJEfgTe1UGV3vX3ELuwUULUjCC09Be+A7j73pwgqZ0089MyUphkrMIDIiu
        DHJLd2Kdyu+xsrekblBXWKx34Mj+povsOPKEH03UOHgc8uDbMjcsWEewEXSNtH9f
        pB1s9+NBVVASdrjwGAZEPZsqm0YBGelhMxow/mYxbAM5RDaZxGyFbI9tQF6KxUGr
        4ecdgtgUJimHkAcEbTSrEd1qXHgE6X+zs4TcsWHf0AUmENPxt9vDeiqVgK/5WOBK
        khpEzPxgplcO+qhJ98/ocG/ARrB6yYpx787EiIukicw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=fpZ+3t
        IO5owrcCM0XRuIHDZ+3Yj8z5b1ji76WN8p9Pg=; b=U5+GQXc6FilC1wi2yZSuPY
        UWHzx0OD2SotZR6VqV0NSelrSXy6KNkPuTn3oZSSmtrPlAS7rVTwBueN4tA9Mplo
        t975pr38NdZn1s/72PA4gDrownx/18Y1ZgbSUC82Iya3f71KEtrFW2qwi9e+O8gF
        ZZKYTpTtjRt70Xsf9IlAn8kmRQyGpzcjgTe81KF7vr9RZG+cAA/cn+hYEnZtsy4u
        PVgiZw3V/vD0Nu/yfr0f+1//V1dkdpXJcDhcoh4MAJEDmc7JxJ/iNGkP6r4OyItt
        Qnv8+ze3DVUsx0/bsBg4QIZU/SMWPCt2Ba46/0YspZAu/gimPDGVoLv8y+RvhWlA
        ==
X-ME-Sender: <xms:uBSpXw1wGuYyCOIRqKwA1prgLoifYp5oeA86SMQsinHvuKPYsXwARQ>
    <xme:uBSpX7F_35PqtYOv0onXYglTtoGgSYEyd4NTOTk2tDVHcdE7YhJCK4Rlf9gcTQuRM
    m2WYeKwNw7nkk6sOg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduhedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledruddvrdegledrvdduleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhm
X-ME-Proxy: <xmx:uBSpX468bu-5zNiD-wjCzBbU6kQ7ZCOS6oM9ER5oLIRDdYj8AMKJxQ>
    <xmx:uBSpX51IWavVKHWzbGVLGqCCQG2w1F8t4R5n2ZB6s3A99osWicHz2Q>
    <xmx:uBSpXzG9QH9FLY4CJyUPumgKrxWYjxS8wFP9iX2X2milItveoaZEJQ>
    <xmx:uRSpX2OdNT-RZ6EwDBRydjF5cBZLrUvZcF6z_f8u73TIGSjvWjdUkg>
Received: from vm-mail.pks.im (dynamic-089-012-049-219.89.12.pool.telefonica.de [89.12.49.219])
        by mail.messagingengine.com (Postfix) with ESMTPA id 34C21306307C;
        Mon,  9 Nov 2020 05:06:48 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 38366855 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 9 Nov 2020 10:06:44 +0000 (UTC)
Date:   Mon, 9 Nov 2020 11:06:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v2 0/4] update-ref: Allow creation of multiple transactions
Message-ID: <cover.1604908834.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdj2RfSjLxBAspz7"
Content-Disposition: inline
In-Reply-To: <cover.1604501265.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fdj2RfSjLxBAspz7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of this patch series implementing support for
creation of multiple reference transactions in a single git-update-ref
process.

There's two changes compared to v1:

    - A small refactoring of t1400, which refactors many tests to not
      touch references via the filesystem but instead to use
      git-update-ref and git-show-ref. There's still tests in there
      which do, but converting them is harder as they create and read
      broken references.

    - I've added another commit on top which disallows restarting of
      transactions. E.g. writing "start\nstart\n" to git-update-ref is
      now going to fail.

Patrick

Patrick Steinhardt (4):
  t1400: Avoid touching refs on filesystem
  update-ref: Allow creation of multiple transactions
  p1400: Use `git-update-ref --stdin` to test multiple transactions
  update-ref: Disallow restart of ongoing transactions

 Documentation/git-update-ref.txt |   3 +-
 builtin/update-ref.c             |  15 +++-
 t/perf/p1400-update-ref.sh       |  20 ++---
 t/t1400-update-ref.sh            | 124 ++++++++++++++++++++++++-------
 4 files changed, 119 insertions(+), 43 deletions(-)

--=20
2.29.2


--fdj2RfSjLxBAspz7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+pFLIACgkQVbJhu7ck
PpTcbg/+Iy7Gau4FKrDRkViiDq+5IecHMoac0sXJJuaqSU8AkGmOHCWv0MPiLNXw
VV3KhxxOoMqLmgBv0F9qw7lXglAgcUcLnGKVJ/J+qOI7WW5G4KnzArDPAiQTgDrL
w3tmoGsWF73vq0EBxmcP0JOKBGoT0V5Tg4kAOU1an4NEJUJYh5WFmRfcfAA0UEVF
wmdBm+JvRGFGyQXDbJGexa/+6D6bXLDiHG6wKELVnbV9rJ/i6Hhj4X9+vJGUU/ZQ
5QRWt25RwPo7eZ6Qyo6BD4WqicJTQob3thCVcOGk6/o7gT81f4jwr4Sqm3KB0Ond
ntvnPhQBR6qc/UYg1mKnbgu5xdboTqlH++HXwp7cptV4w2tnQ4wpeGX65WJb4L7w
F3n+21VYFkpOZhrz3sehM73p90D/ys8uAwFwYpCoARgqnq2HGSf+kmE/DmR9Rm8n
aKvBtCv/LudQMxMe5Hfsj1XqTsqzH44jgQgCCxrN12Gur7QIdgGPdYzOoisUQ++M
RSfI4KEcHSpmQRUio0uSJ172QsRtdWHI6iO5bpcKgBdzCCVwVNAw96h5jtqf4U5P
Av41PF2MxwR/2dH9ZQTG1YWvWXmd40NpFCZZQ6ZpntQDIAG+YbpUTWekaEtz7UMJ
N1yOonVaCvKmIQS8Wg8r25uHXMpU2Q5zbZWris79CjHyiM+UhaQ=
=0fp+
-----END PGP SIGNATURE-----

--fdj2RfSjLxBAspz7--
