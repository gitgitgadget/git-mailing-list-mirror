Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F8FFC433F5
	for <git@archiver.kernel.org>; Mon, 14 Mar 2022 07:42:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236778AbiCNHoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Mar 2022 03:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233826AbiCNHn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Mar 2022 03:43:59 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4F3833A
        for <git@vger.kernel.org>; Mon, 14 Mar 2022 00:42:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E9DE05C017C;
        Mon, 14 Mar 2022 03:42:46 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 14 Mar 2022 03:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=thf0OgCyiikyv6yLnY0Fr2I5n4Qf0Mc0uu0jHR
        hSOZU=; b=NR/fDEWupc8OL52mV7YWs0TQeW2YnsFfXYnr92e5qT6opuCgvPIl0l
        ZGPZZdlLKPEzWP2mBwJlbORk0M27mXElCxBvrhuWX80xkdloZ5xoR9S5N2r/c4EF
        Iiiq6YqCA4q7wZPvlQzYcbRnBZwlNTJqRRWY0GNodUx37f86472Z27lAw36qtLO3
        lTBu43XNJLqxqCwOuKHLq76CpT4Q4YFweDoEtj/rHq+XnqKst6+gaAG+n9UOV89i
        1TOEeCD2PrVOAqHpBjlDUAYSY3mLZkOU4VnLMTtzXXc31CGIJwYxKU101beSufJn
        j97jNq17SC9wNzBHf4so/dYpGyER1kxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=thf0OgCyiikyv6yLn
        Y0Fr2I5n4Qf0Mc0uu0jHRhSOZU=; b=ZpnCkaW2zjKIRM08w4v9F2UeQMoFKpZmu
        zEOQ0HqC9lOnBf/HgM6cS9ppcBxcrvlSZ1JhzSF7Y+2mWJ/lz+0YpaIs7yjfOHVj
        WM+HPtbSm7lOv13uC251bDUeuxKpRvDTtx4dlhHD45qmnNrSMGct9GZnAz5pRF3I
        /x/kCWLWmLBayG4P11d2YDkvTO80Z1mkL3+iGgnSbNMshkN7GS7ALPf+OBz1WeUL
        7g9jWtUxgywOP+46XGfJJJkYm6adY4WSoWKRpkrpnqN3TXaVZFS+jIOhqaOYzAXr
        x+ImsfeJlTEDkXlbSBJvwXu+uR1nEkdHCZ3N0v8xO3tZDPUGoc72w==
X-ME-Sender: <xms:9vEuYuThq4r4_0x7BktnehrSyG1AZ3l12CfDSFZizPszp8lB_AqPpQ>
    <xme:9vEuYjwiSLbZljrCVb3QpKDKopgNJImqhYehZ9wUIFb1DSjn5sTr7l4LjW4R5MQqv
    yku8BggGG0gaIeEew>
X-ME-Received: <xmr:9vEuYr3TKPpHfW19BLRCja3azojZc_-HBn_Vxu1FBKEfXS-rJjCgV6Vpd5CHWezuEuNMuEfRnHKrbIDfdmwDn1emygX33P5kcwx1_GJmX7QpZcBP38cbNeU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvjedguddutdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:9vEuYqBhvY5cYN7bQqw--Gtag4oR_7tM-FzG7qpJtfYhuHLx0-DH-w>
    <xmx:9vEuYngVHOj1Y9QMIeObR2JrQXNoF-E318UTF3_zvLOSAkj6r1E3ZA>
    <xmx:9vEuYmqQxWqf04l0wslO_LLdKUFotxg9zQXai_EOxPrV_jofnLFzIQ>
    <xmx:9vEuYnLLY8BXLXUgA0j7I5JDtk_YCgg0DY6bQuhE--aTR_VPaObc5w>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Mar 2022 03:42:46 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 37aa16ba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 14 Mar 2022 07:42:43 +0000 (UTC)
Date:   Mon, 14 Mar 2022 08:42:42 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 0/2] repack: add config to skip updating server info
Message-ID: <cover.1647243508.git.ps@pks.im>
References: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="rwicN6sbIUgzMXcj"
Content-Disposition: inline
In-Reply-To: <659d5528df56f6b9aece6b1f3c4e2e5a4ae04e1e.1646996936.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--rwicN6sbIUgzMXcj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series which adds a new config to
allow users and admins to permanently skip updating server info required
for the dumb HTTP protocol in git-repack(1).

The following things changed in comparison to v1:

    - I've split out a preparatory patch which refactors the logic to
      avoid double-negation of the `no_update_server_info` field.

    - I've updated documentation to be more explicit with regards to the
      default of the new config and to mention that the `-n` flag
      overrides it.

    - I've refactored tests to be less verbose.

Thanks for your feedback, Taylor!

Patrick

Patrick Steinhardt (2):
  repack: refactor to avoid double-negation of update-server-info
  repack: add config to skip updating server info

 Documentation/config/repack.txt |  5 ++++
 builtin/repack.c                | 12 +++++---
 t/t7700-repack.sh               | 50 +++++++++++++++++++++++++++++++++
 3 files changed, 63 insertions(+), 4 deletions(-)

--=20
2.35.1


--rwicN6sbIUgzMXcj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIu8fEACgkQVbJhu7ck
PpQhWxAAgxJh4Lie+um0NiC3s2CeYutzAbW7+Nu66XId3qn2L96nDp3SyHa3Hwqu
2/FCqV5fKjYMrtfoSt4EEsAvToABo6yogUdVJt0YlanxGCGNpoTOeM1/Rz19YAbV
RYvYInZrEcZEZ5F/2fjzIOpEEa/jEiIS/fpGbMvZxk5PqddfYbPbYSnc52/dsjQd
6Xv3eLnfVX9PGnuAV487VW1jHN7k490zV/sP5SBzZzg9moRVZVd3SRXZpCq3f989
WeRPaLvW7JfNzJMLKsNDyy5EFN0MzEMq5iffv4NsMR9LKFHnHHOFjmvcZY/KfTs+
pQ4J52xk1tKMH+vw/+qT6DswEj1aHpJ4+teSkK9kWqSe7vhksvGPeHG7SoSP09dx
EZRQK9PSLnC38Ww4xvWd6x2YQsUve2jBILCTZT6mYedKu7Uf7v7geHy0PMMmbouj
+RyG+kxYb4OLwLubJAfGwp7cwzHybDMOIzMWxVTVkArut5sUQjo+hge3WlA13DE7
ejb4XilRY4HrgXlHM+fXqDHJBHag7oakrl8oCoVe5MgwH2Zhq/dAoSP1h2gzE5xr
Ri4qh5lZ9wkHPEbgnafMimLnZ8bX3ZB/ixmd6KdDlHRCLpZD17cRunOELOfk6JQs
Ps3z9PkKOyaki7ICIWxkxE4DKyRC7+ZM436AJ/7QWzm2/CLDzYY=
=w1um
-----END PGP SIGNATURE-----

--rwicN6sbIUgzMXcj--
