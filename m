Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5484EC433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 316056108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238859AbhDSLrL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:11 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:41689 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238606AbhDSLrI (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:08 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 2AF77B06;
        Mon, 19 Apr 2021 07:46:38 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:46:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=gvyjP4ykFM9HwnODyGFylaFNCBh
        3Mx9YGwQx1CoyPXc=; b=rJqhjNL9ofOQ5DfgQ9TEZEmeEVHdR4peEo0SNCHDiFB
        5784AFxkdiQuaLAHOPHb9chEHiLHNYH5GU6dbQSGcJJyGLl2wlCRaxZTBL0te5LT
        aFQcbkYROh9CmSfES2ri8BohOeLZwGivi0eZXMr8MoHttd13ohWCrL0A2TI6PT3H
        I9WUSX/aCIPbqUeo1xLh8rcXXI5nMNmNy+zvNqU3CupetRgcgtOyGYQapY2L8D20
        0RtqEHO6kC+eFkgmOk1OuXXfzI3ONRmXjFJOfsDD6NK9XdBY8jwiw+xe1CjOYFaT
        wUEtmVlYrOWBYbAXuzxho6KfnOejqmpa3kvV6Un9u8Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=gvyjP4
        ykFM9HwnODyGFylaFNCBh3Mx9YGwQx1CoyPXc=; b=AVvqmF5ZcBTUGA425N5omr
        qv91EJQSNtLMxb09lygSqWxPFW8awcDi7wBy8ZFk1MVDS/lcevq+T/e5BMAz61SZ
        gt+tgvrS3Q4bQL9NnA4atJtr0CzTQ6WmCU9MpR88n1YJlY7chU1GCE5RfSIqrjr4
        4Ukd0VnuQ8kunBpp0m5WVqYUwYaIcwzruMqFWevdlCuHjdDhY8Q5x3/8WkFruAH/
        8Rrt6J91eIRzry8gp50460+OVYZ32wQ+C4fmWUe3J00oBn4qCzTKyShRNP309VXj
        KcCHU57/4JkV7xf1pW/UCjsEeAKmrJDYXfi8ZQsQQdJgSDafGcvowM34p/526KUA
        ==
X-ME-Sender: <xms:nG19YPPJcfNJmShhZiA-kn5h3-EoPMv2HE_7foQSfJsR3un_lly51Q>
    <xme:nG19YJ9q3RBbcg5KXGAydUt010teyK3yQwbHgBfMBc1b_6KyJ6WFEcsnZaa59Po2g
    Xnw5TLBz0gkMjeHow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:nG19YOSXBUBdNWhuvTxL8TrJ3Px4ioAiptKPBgAg01vEKmqQrTcUxg>
    <xmx:nG19YDvw60tvGFhh82zA1CkvBuF1BKJmnO3GkCo93JJ9WnDMh8RzCQ>
    <xmx:nG19YHcP8imb1U5t1lqgwQHUAhm1ryl9jRtyvgSwJZQ1aIya56OXzA>
    <xmx:nW19YO7BXb5R8jAZdmMuaJPAE4_TaZrjakg53GDZLeMSJI4aO1Bnsg>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1CEA01080066;
        Mon, 19 Apr 2021 07:46:35 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b7415368 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:33 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 0/8] rev-list: implement object type filter
Message-ID: <cover.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6qrewkQwpl5rv/mq"
Content-Disposition: inline
In-Reply-To: <cover.1618234575.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--6qrewkQwpl5rv/mq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the fifth version of my patch series which implements a new
`object:type` filter for git-rev-list(1) and git-upload-pack(1) and
extends support for bitmap indices to work with combined filters.

Changes compared to v4:

    - I'm now explicitly passing `strlen(v0)` to
      `type_from_string_gently()` to be prepared for the future
      semantics change here.

    - The error message printed in case the user passes in invalid
      object type to `--filter=3Dobject:type=3D` now prints the wrong
      value passed by the user.

    - Fixed missing header in list-objects-filter-options.h.

    - Tests now use test_create_repo and test_commit.

    - Removed a needless subshell in the tests.

I hope that this catches all feedback and that I didn't misunderstand or
miss something. If I did, please give me a shout!

Patrick

Patrick Steinhardt (8):
  uploadpack.txt: document implication of `uploadpackfilter.allow`
  revision: mark commit parents as NOT_USER_GIVEN
  list-objects: move tag processing into its own function
  list-objects: support filtering by tag and commit
  list-objects: implement object type filter
  pack-bitmap: implement object type filter
  pack-bitmap: implement combined filter
  rev-list: allow filtering of provided items

 Documentation/config/uploadpack.txt |   9 ++-
 Documentation/rev-list-options.txt  |   8 ++
 builtin/pack-objects.c              |   2 +-
 builtin/rev-list.c                  |  36 ++++++---
 list-objects-filter-options.c       |  15 ++++
 list-objects-filter-options.h       |   3 +
 list-objects-filter.c               | 116 ++++++++++++++++++++++++++++
 list-objects-filter.h               |   2 +
 list-objects.c                      |  30 ++++++-
 pack-bitmap.c                       |  45 +++++++++--
 pack-bitmap.h                       |   3 +-
 reachable.c                         |   2 +-
 revision.c                          |   4 +-
 revision.h                          |   3 -
 t/t6112-rev-list-filters-objects.sh |  72 +++++++++++++++++
 t/t6113-rev-list-bitmap-filters.sh  |  68 +++++++++++++++-
 16 files changed, 388 insertions(+), 30 deletions(-)

Range-diff against v4:
1:  f80b9570d4 =3D 1:  bcc81336b1 uploadpack.txt: document implication of `=
uploadpackfilter.allow`
2:  46c1952405 =3D 2:  ffe8e2bf73 revision: mark commit parents as NOT_USER=
_GIVEN
3:  3d792f6339 =3D 3:  21d7f06d0a list-objects: move tag processing into it=
s own function
4:  674da0f9ac =3D 4:  b5d6ab6b4a list-objects: support filtering by tag an=
d commit
5:  d22a5fd37d ! 5:  f462745290 list-objects: implement object type filter
    @@ list-objects-filter-options.c: static int gently_parse_list_objects_=
filter(
      		return 1;
     =20
     +	} else if (skip_prefix(arg, "object:type=3D", &v0)) {
    -+		int type =3D type_from_string_gently(v0, -1, 1);
    ++		int type =3D type_from_string_gently(v0, strlen(v0), 1);
     +		if (type < 0) {
    -+			strbuf_addstr(errbuf, _("expected 'object:type=3D<type>'"));
    ++			strbuf_addf(errbuf, _("'%s' for 'object:type=3D<type>' is"
    ++					      "not a valid object type"), v0);
     +			return 1;
     +		}
     +
    @@ list-objects-filter-options.c: static int gently_parse_list_objects_=
filter(
     =20
    =20
      ## list-objects-filter-options.h ##
    +@@
    + #ifndef LIST_OBJECTS_FILTER_OPTIONS_H
    + #define LIST_OBJECTS_FILTER_OPTIONS_H
    +=20
    ++#include "cache.h"
    + #include "parse-options.h"
    + #include "string-list.h"
    +=20
     @@ list-objects-filter-options.h: enum list_objects_filter_choice {
      	LOFC_BLOB_LIMIT,
      	LOFC_TREE_DEPTH,
    @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'verify blo=
b:limit=3D1m'
     +# Test object:type=3D<type> filter.
     +
     +test_expect_success 'setup object-type' '
    -+	git init object-type &&
    -+	echo contents >object-type/blob &&
    -+	git -C object-type add blob &&
    -+	git -C object-type commit -m commit-message &&
    ++	test_create_repo object-type &&
    ++	test_commit --no-tag -C object-type message blob &&
     +	git -C object-type tag tag -m tag-message
     +'
     +
    @@ t/t6112-rev-list-filters-objects.sh: test_expect_success 'verify blo=
b:limit=3D1m'
     +'
     +
     +test_expect_success 'verify object:type=3Dblob prints blob and commit=
' '
    -+	(
    -+		git -C object-type rev-parse HEAD &&
    -+		printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob)
    -+	) >expected &&
    ++	git -C object-type rev-parse HEAD >expected &&
    ++	printf "%s blob\n" $(git -C object-type rev-parse HEAD:blob) >>expec=
ted &&
     +	git -C object-type rev-list --objects --filter=3Dobject:type=3Dblob =
HEAD >actual &&
     +	test_cmp expected actual
     +'
6:  17c9f66bbc =3D 6:  90c80c1efa pack-bitmap: implement object type filter
7:  759ac54bb2 =3D 7:  9726e69861 pack-bitmap: implement combined filter
8:  c779d222cf ! 8:  fce3551e48 rev-list: allow filtering of provided items
    @@ pack-bitmap.c: struct bitmap_index *prepare_bitmap_walk(struct rev_i=
nfo *revs,
    =20
      ## pack-bitmap.h ##
     @@ pack-bitmap.h: void traverse_bitmap_commit_list(struct bitmap_index=
 *,
    - 				 show_reachable_fn show_reachable);
      void test_bitmap_walk(struct rev_info *revs);
    + int test_bitmap_commits(struct repository *r);
      struct bitmap_index *prepare_bitmap_walk(struct rev_info *revs,
     -					 struct list_objects_filter_options *filter);
     +					 struct list_objects_filter_options *filter,
--=20
2.31.1


--6qrewkQwpl5rv/mq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bZcACgkQVbJhu7ck
PpQVERAAraNJIBMY+bWSZvzFMuBV1+GT/kB/4mE8DSev78bAnjfJwUlf71sZC0Yq
CUXZ1PGitDWOoXPVdUSL2c/QnQ1iGe8nQuFmBovbuM0viVOU+NquaGdlYAwJ1N4t
TzWzH/iTApdMPh9uNk/N0MdVrJylvORATvG07PMrA+UlQmYj31wTLk1a0wqjUnt3
5gU0/2R+Zzh03i0ov5+E02ld7OasDfiZu2WJBzXWpePe86gKnXpaM2hrQF7svE0c
29wkfofHXNLmc02ml9+SqgTTCV8B9Kb5elB6k3zhyZu4wFCSjqBupj7yF2NqJL25
9+mz5m2lXBvTI2em65EYjnfNO6SijgH0ZAb4X5hC8mH2zmMChXRO8ZTjKjUyYLvN
pze07D7/Bm7HwbY3/6gfuunmBuJ0bXqGlfO8rZgYbJL+a6ejaauLnYF1jhmKjpbi
rOQtNobyCabLZnVXzCxUez1atBq1DUmZbZm26EhOd/3f4VCXMYdl0yTNAArdJwaA
iL4Qeet1qJ09To0WzfxfYP1aPlV71luWy9RNGqxFpxmbCKfaJlj7Aq8kQbXVxz6N
A43s2kcvLi3HTMry5lx68DJgtbH6ebGKBmbsg7u6USeg19+sy//Y5vaNkUMYaomf
4y1ZyL95vQzyhbS/CFK0c/E1n/Ccr0OirQE99j2VPtKcAxbJCy0=
=VdzL
-----END PGP SIGNATURE-----

--6qrewkQwpl5rv/mq--
