Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E502C433E6
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6A8A64E37
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 12:21:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbhCAMVl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 07:21:41 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:52371 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234226AbhCAMVj (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 07:21:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id C61239CA;
        Mon,  1 Mar 2021 07:20:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 01 Mar 2021 07:20:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:mime-version:content-type; s=fm3;
         bh=pGp49/72aPAhCixZ/q29albxJtUzzLGglXa74XwW4eg=; b=UmU2fkuXJ90Z
        9IyRSl/2bXB4ULV2gKCQXMBzeUqvBUgjE/8ClvSmP6dh/74MAI9bHN65W0EdiU6Q
        7kOCcwo52HdrDK/ciQ+YhuV/MlJwDX+/8KGNhipJEJQdXu2BFCtGpur7/eTkDwNs
        ycD4uIvBD4oNF99HU7WH+kdX4MpyF82evOp4vmb1v5oHwsIuctgcGUAkvnM1wEw7
        qJ6e+ikIhxCGtKy9bi0nBJ/OdiFsfdweJRe7x+CnNr7gi+AdAngQ345C/y2qEBUx
        LEcgCk7O+4ox2P6OYoQeMzAemwgP98gzPxipJTk9yAgntHOXc1zFIGmdkBSAGTqv
        TrOvrI+gxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=pGp49/72aPAhCixZ/q29albxJtUzz
        LGglXa74XwW4eg=; b=a/wV1ny5AZAUL/t0TsVDVqjKcmpH3EWb0HhSJ0DU42G16
        wNRGXbQccLgrP/xJnGmVEl+iAuN6O7Ny39PNaKaYmlujrfgvjMjGN2VZbggstUPb
        hl/bpGT3Dd4QdSXtrn8eZAPrOjt6WJ+OtdpA34zA61xFD0ZanKfzLEQvUWNuj+ff
        6SmDdstm46x7FF9fBPn5oUDyqfb/e5N3EGoxF4sicK6QdZ2uwdpBbrs1ry7ij6vP
        94esMcTbKRHzaXmYttVbdU7jGhN0dse4JkQfgXRUNeTtaaodvJeD7YRnvANs4joZ
        FO8YV5mIvZnaSrDiCUxjA+EyQku4Fb5+2SeaoW2Ew==
X-ME-Sender: <xms:ENw8YE8FYXE14Uk9g_EAfL77RQ0RRd6MltK0apDL0XuN5TmlrjuGnQ>
    <xme:ENw8YMtY3h9ra7XVJ46EjwZgebtU1JQSqD95VbJWDlkKiNFrLIjvTC7z0uabs_Swa
    SlyGREQtO_T8dXcCA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesghdtreertddtvdenucfhrhhomheprfgrthhrihgtkhcu
    ufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepje
    eifedvueelfffgjeduffdvgefhiefgjefgvddvfeduvefffeevfffhgfekieffnecukfhp
    peejjedrudeluddrvdejrddufedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:ENw8YKCI9jFa3WcWHwKA6B4SUdD7kimL5StUL3m_Rjwzwti1zoJpNg>
    <xmx:ENw8YEdYG72zZyQXfJvpnWgaM7WOqx1SZKCKILuUvU4nYEz3uNIY-Q>
    <xmx:ENw8YJMkrEX2NyTqbQakFnZLqss48cJDlXsQuQar6wUnRRL0UVhKGQ>
    <xmx:Edw8YAa66o7BWPoW-a-T_zLEOOhCQxYvp-YKk70NLeAxKrRg-lV4nA>
Received: from vm-mail.pks.im (x4dbf1b84.dyn.telefonica.de [77.191.27.132])
        by mail.messagingengine.com (Postfix) with ESMTPA id 766B71080063;
        Mon,  1 Mar 2021 07:20:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id addd9240 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 1 Mar 2021 12:20:29 +0000 (UTC)
Date:   Mon, 1 Mar 2021 13:20:26 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>
Subject: [PATCH 0/7] rev-parse: implement object type filter
Message-ID: <cover.1614600555.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WixB0Y6vj/+u7QPH"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WixB0Y6vj/+u7QPH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I've recently had the usecase to retrieve all blobs introduces between
two versions which have a limit smaller than 200 bytes in order to find
all potential candidates for LFS pointers. This is currently done with
`git rev-list --objects --filter=3Dblob:limit=3D200 <newrev> ^<oldrev>`, but
this is kind of inefficient: the resulting list is way too long as it
also potentially includes tags, commits and trees.

To be able to more efficiently answer this query, I've implemented
multiple things:

- A new object type filter `--filter=3Dobject:type=3D<type>` for
  git-rev-list(1), which is implemented both for normal graph walks and
  for the packfile bitmap index.

- Given that above usecase requires two filters (the object type
  and blob size filters), bitmap filters were extended to support
  combined filters.

- git-rev-list(1) doesn't filter user-provided objects and always prints
  them. I don't want the listed commits though and only their referenced
  potential LFS blobs. So I've added a new flag `--filter-provided`
  which marks all provided objects as not-user-provided such that they
  get filtered the same as all the other objects.

Altogether, this ends up with the following queries, both of which have
been executed in a well-packed linux.git repository:

    # Previous query which uses object names as a heuristic to filter
    # non-blob objects, which bars us from using bitmap indices because
    # they cannot print paths.
    $ time git rev-list --objects --filter=3Dblob:limit=3D200 \
        --object-names --all | sed -r '/^.{,41}$/d' | wc -l
    4502300

    real 1m23.872s
    user 1m30.076s
    sys  0m6.002s

    # New query.
    $ time git rev-list --objects --filter-provided \
        --filter=3Dobject:type=3Dblob --filter=3Dblob:limit=3D200 \
        --use-bitmap-index --all | wc -l
    22585

    real 0m19.216s
    user 0m16.768s
    sys  0m2.450s

So with the new optimized query, we can both significantly reduce the
list of candidate LFS pointers and execution time.

Patrick

Patrick Steinhardt (7):
  revision: mark commit parents as NOT_USER_GIVEN
  list-objects: move tag processing into its own function
  list-objects: support filtering by tag and commit
  list-objects: implement object type filter
  pack-bitmap: implement object type filter
  pack-bitmap: implement combined filter
  rev-list: allow filtering of provided items

 Documentation/rev-list-options.txt  |   3 +
 builtin/rev-list.c                  |  14 ++++
 list-objects-filter-options.c       |  14 ++++
 list-objects-filter-options.h       |   8 ++
 list-objects-filter.c               | 116 ++++++++++++++++++++++++++++
 list-objects-filter.h               |   2 +
 list-objects.c                      |  32 +++++++-
 pack-bitmap.c                       |  71 +++++++++++++++--
 revision.c                          |   4 +-
 revision.h                          |   3 -
 t/t6112-rev-list-filters-objects.sh |  76 ++++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  |  54 ++++++++++++-
 12 files changed, 380 insertions(+), 17 deletions(-)

--=20
2.30.1


--WixB0Y6vj/+u7QPH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmA83AkACgkQVbJhu7ck
PpQ9Lg/+PqFMWPhH0/3086Em3ZIResa+xyn5+iKUluvJAVFp7LTT2RlXpit95l2g
uOyZzw6aOkRxvQ+CZL4IZNCEgKlJ+rNj8cv9cp0ZQFdtvHdehGdKT97LqbVeifLQ
ZpuqrtoYDdIbj/tfyUGbeLFMh7bVWG1r1FCPaf1TV5dmNYa5HjCy3bid1iaowyGE
9IMaUQIcVzgCYi5/KWhM+W6zxF1yipVTPP6TQF1h+XZDnrTNijLvYYSnGW7mk6/d
56R/GX4UW8JvNMXlsI4Wp5rPjlyGcl/5z6+NQ5Uxn9jU6oekGN9cA/u3Rm6LBkGV
b58eVmFqUQKMd4+J3+fxRKzmZnFJbKwQ4t5o3HMF/YVNtj5Fq5HK8fEpV6I3RWIc
1n6jCoiuxThOnpjX/N3mvdlY6UriXUgVtEdIgbSVrNdtv22KyTgcI1mLMSQUpx4v
dwW5tYo54bBwRkFY4PkJQXW9Z1eWQrdE05geG1wzLd5Xn3Ctwcr7AVOUh13kM8DK
TjSDCK3FCEgzPvltZwVMkaHlELWhP9Z4wz69u1w2nwp3RabuVnF4U8bstOwLVjxK
gpD6bzkqx9IULwgZ02HD+FtTFGMYD0DU/3PmMTiAPxwM5YVStIpJ3WkGo7dSYakD
d26H+WVtWVVkw4otINi0YssSZ72y/vrpjkJDckTFH88bDF6Fze4=
=CH4m
-----END PGP SIGNATURE-----

--WixB0Y6vj/+u7QPH--
