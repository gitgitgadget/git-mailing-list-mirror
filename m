Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5318C433EF
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 09:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241222AbiCJJyy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 04:54:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241118AbiCJJyc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 04:54:32 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B82E34CD5F
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 01:53:21 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id ECE8B5C02CE;
        Thu, 10 Mar 2022 04:53:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 10 Mar 2022 04:53:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; bh=VUnEtOsurVn4T1BwAoTbvd39hIP+HlDCiJdWxk
        t7CG0=; b=wxDKXm4lgrQtL2Ac3mKkHI7uX3KoFgK4nIJhQy0Y/SowAsouvOrbL7
        0xWmVOnT3M46Ebg6uB9PENcmbDUbhNyiQV7I/vNuD0dsX312lz/ZysPreNND6U1H
        colD0+JsOR1aRUrkApIcnFhFXE7N2T8aDL/K+j2HxR37Srsp1Ef+x5afJJYZ5j02
        YJNADBXTAAGisQYUU6x86qRhnrZ3zR7jU7pZ3SEMJJT3ixWBdN/UAkghQgt6y7cc
        XZYCBuZgq5BQKroLRmdDlPGdrAqATJmO2ZYQ8xCxF8yUyysoaieYY8NVyCVwxVX5
        hhyay9QS/+dcBvfQvRhig1DGlzGzinOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=VUnEtOsurVn4T1BwA
        oTbvd39hIP+HlDCiJdWxkt7CG0=; b=Hi4FbNyI2tpIdkOULyJa3QUw2ubNm68rq
        DXgHzXP4sgA21QYCbmv33MaM5E2SKKOBYHDZpSVq9sVL3EzvCkDk6L/UbGGYB3mM
        VV6J60rfBFnr2csj27mG+lYxwfXwxlK8UZqa/qRhXtBq/GXvq0/odU+Uj7/lbLEG
        djWKMg287eIpdU5AYLiZJ+B3YKbmm5aUi/JPhda4odgvoeQKcEqJZ4gwtQSsmCpT
        zJ/E/ZYsF98JPhqoBQLWjAy2mmJxc4Yo26k+HAR3E0d+4DgWbK77pb6kOngfhWf/
        6aCY5g62K50rJowV8XQRXKk35EkmatbZRFtxwf/5/7DPEZQnNOMsw==
X-ME-Sender: <xms:jsopYrwXUkRE6Ui9uSGeisuxfs4kckjEU-0Ah6gxMHQe1LxvQVsKzQ>
    <xme:jsopYjQfjQlcUJFJMWRJcDLIKwIQApO1skME62_6AG1WIqatevx1HN2qPUVMhYTkJ
    alRCD00cXCOchXvNw>
X-ME-Received: <xmr:jsopYlVZb67N1HsSjWvSexq2QLVxuaNxlUUFu0XXrwYvXdXnCzYsjoTwBAvxueJGFRnKYkPWo50oygxfytPVQMK-22mapUKgmV1TpJr7y3bRKDynEgbYmCfnna0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddvtddgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:jsopYljT6qSd6iKwOY1mmmVXoPkoVOHEiimw7BFE7Uf-LaoRvYxSJw>
    <xmx:jsopYtDQQJPTttXHixi9CjWrWGIFA3b9Q1ghp9HaQIdOo2rqRBftgg>
    <xmx:jsopYuJk2k4Ol-jgrrueYJBsqtqD0V2-e_vKelXQeOpxuVLDJ1q3wA>
    <xmx:jsopYnDeDB1e2CGodV_fvCPRcHB4gY0y_EYrpfsC7wWApxp1O_f6nA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 10 Mar 2022 04:53:17 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 1b39078c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 10 Mar 2022 09:53:14 +0000 (UTC)
Date:   Thu, 10 Mar 2022 10:53:13 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     rsbecker@nexbridge.com, bagasdotme@gmail.com, newren@gmail.com,
        avarab@gmail.com, nksingh85@gmail.com,
        sandals@crustytoothpaste.net,
        "Neeraj K. Singh" <neerajsi@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Future-proofed syncing of refs
Message-ID: <cover.1646905589.git.ps@pks.im>
References: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fWURwiJhzIfTKbvW"
Content-Disposition: inline
In-Reply-To: <pull.1093.v5.git.1646866998.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fWURwiJhzIfTKbvW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

these three patches apply on top of Neeraj's v5 of his "A design for
future-proofing fsync() configuration". I'm sending this as a reply to
his v5 to keep the discussion in one place -- I think ultimately, we may
want to merge both series into a single one anyway. But please shout at
me if this is considered bad style and I'll split it out into a separate
thread.

In any case, these three patches implement fsyncing for loose and packed
references using the proposed `core.fsync` option, with three additional
knobs:

    - "loose-ref" will fsync loose references.
    - "packed-refs" will fsync packed references.
    - "refs" will fsync all references, which should ideally also
      include all new backends like the reftable backend.

I think this extension demonstrates that the design proposed by Neeraj
is quite easy to extend without too much boilerplate.

Patrick

Patrick Steinhardt (3):
  core.fsync: add `fsync_component()` wrapper which doesn't die
  core.fsync: new option to harden loose references
  core.fsync: new option to harden packed references

 Documentation/config/core.txt |  3 +++
 cache.h                       | 22 ++++++++++++++++++----
 config.c                      |  3 +++
 refs/files-backend.c          | 29 +++++++++++++++++++++++++++++
 refs/packed-backend.c         |  3 ++-
 write-or-die.c                | 10 ++++++----
 6 files changed, 61 insertions(+), 9 deletions(-)

--=20
2.35.1


--fWURwiJhzIfTKbvW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmIpyogACgkQVbJhu7ck
PpRVHQ/9ErR8Mbnj3MVR9/NbJdbp0ieogE9oIWl9IA7Eu9U3AM1IB3zhncNk/2GX
+peodHYbgPbKf06VsT6ozgLebFy1Naom2XhNxAY6f/ec288hAaTtGHwkD0tv6ijQ
J/P24g4JZJDTTFDgLirENWxw4NazwzaHnsVg6qwPxHbru3u40aro/K/HByyZesR+
/YjGFoEkkbC6Em7RoeFydU8gL7tsyJrrRTocAHyVtO5HGI+AXC3EfFqvMpB59XBa
R+PDQpEXDcjBntXsqzjrkyBribHH/zbGrTkB4KTKWFj6q23QtGrcGoj9z5cqtEdY
XOSebNEyEktGDAgFx+ShccbPdwupoF+SsfVn1qqHoQX4RDozyH/piKuDfxLqa1SR
qa90bUVkjcYc0zXo1kR8epRkXF9ahOYEsoaGV9OKQ0/n3gouMI2DtFDTXyckO1pQ
rEc9VNkuFs9AZupK+vxuDecdp22T728D5/3BsHG/c50PqQxGXXqkuMGlNo0nutoR
tGoPip/2ZruWQChdU3PMecM0Ar3wNKh8SJx0Pjdbfr0N3HAa2pBC66DyiKGznshn
TqV8CdqHyqjDdD2bdbZE3Lsau7dAaUHKClg6ySseKnM0yMPNDuZt4FJ3FBEKjw8t
Lb2Lv7OjumVcYwzr6jhP8KA7znJPjpOk2SlgBmMiB5mkWfY+Qu0=
=35vd
-----END PGP SIGNATURE-----

--fWURwiJhzIfTKbvW--
