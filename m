Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E90EC433C1
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6609561931
	for <git@archiver.kernel.org>; Mon, 22 Mar 2021 12:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230239AbhCVMTp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Mar 2021 08:19:45 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:36249 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230031AbhCVMTK (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 22 Mar 2021 08:19:10 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9FF375C0167;
        Mon, 22 Mar 2021 08:19:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 22 Mar 2021 08:19:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=R5XmHvx8khR4PmB6HOAv8UO6wp3
        AuuegHqjKFyRn4zY=; b=LzskTc436nfGnKMEXQ/H+OVAW/V+WpwfvKV0Q63XzSF
        i+xILJSAWCBI3bRVK9Ajk5NVA4N60WXnUWIZ5aVMNFjpRaAe1VmTpFHHr6io4vZv
        Ev7A6FNfsQmODwZrXWtpAwxdJh8lngV9FP3pKmOlTojRAiR4d8A4TkE+eYEystsQ
        ynllscjSlFr7SzoF6ZRLKK+HTH7USlXKYPpLhfCwKMjzi/HZ0IdUlWIvZPnE240i
        AFaOgouvl+fAGhy8nbzgjbw4goswUehUr3y/ohrwT6P/x4aae6PYcxNKGu7Sg+yd
        OV2gKlgVv3vnT82ih2SjkCn/KN0gBJb/iYJzKf+3zyg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=R5XmHv
        x8khR4PmB6HOAv8UO6wp3AuuegHqjKFyRn4zY=; b=ggMJ/0EXdpO02o+HJPifsp
        xmuh0gj3l2ua3GXAtHFRUOZa7MS0TMYsZsydFDZSBvDl9SNhAVWqmh6GtHRt/IGQ
        GkeBCo1dzzVpF0zp8ycvo4tui43ZivkhyS7i233epHFwz8r1+RnGXqZ1jCnW+UMX
        MSqNUq4W1T1+x8twT9RbDufONUSYnPGkT/uVTqbpPoWY8BUZeNUV74OqhO3YocP1
        xEvzE1uAp9McBwfvUEWJdpRzyE0oX/wRAhO64pLAsbLjVoxbreFgY4vEuixFgLVw
        LeX6ADaM6a2qXAcn+BF8vvrQ9xgsaoLCDJjB/TOLYoCQQCcHNZofOJgmOSo/aUxg
        ==
X-ME-Sender: <xms:PYtYYJfyRyxruOPQMp8ZWBJpwNmc5KMcSw6WUwWa-hYeLXEvRFBbeQ>
    <xme:PYtYYHMQwFt9aT1QjKwp-Gfvs-SGXiC-kIHlQWWFLZp7BTqtknFrXNSIAkCIKYu0l
    L4O4DXJMZEoDLrNRg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudeggedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeejjedrudefrdduheekrddufeejnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:PYtYYCir8nqsvWZ6vzuU1BkJXRUFiWsH4k1mEp7VHCkzEkhH5cvmog>
    <xmx:PYtYYC883Bx9koBWuGdmK-Wryk1jPmwaB11plxQZtnV-AsXs9kYFpw>
    <xmx:PYtYYFueb6GHP6XZzlM81PDGBiyHTRqWGcT4RYZBwM5lsLkF7ykxRg>
    <xmx:PYtYYK6-XFtq1haL0y0l7dGtGYmxfJzlQONBxNl6lwBECwzn9E1VFw>
Received: from vm-mail.pks.im (dynamic-077-013-158-137.77.13.pool.telefonica.de [77.13.158.137])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8D176108005C;
        Mon, 22 Mar 2021 08:19:08 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b4f58da6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 22 Mar 2021 12:19:07 +0000 (UTC)
Date:   Mon, 22 Mar 2021 13:19:06 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2] pack-bitmap: avoid traversal of objects referenced by
 uninteresting tag
Message-ID: <f9aae7a54ec5bb957cb1882f3da465bc8b09388b.1616415462.git.ps@pks.im>
References: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="a3ReVs8uC/uPbA+y"
Content-Disposition: inline
In-Reply-To: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--a3ReVs8uC/uPbA+y
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When preparing the bitmap walk, we first establish the set of of have
and want objects by iterating over the set of pending objects: if an
object is marked as uninteresting, it's declared as an object we already
have, otherwise as an object we want. These two sets are then used to
compute which transitively referenced objects we need to obtain.

One special case here are tag objects: when a tag is requested, we
resolve it to its first not-tag object and add both resolved objects as
well as the tag itself into either the have or want set. Given that the
uninteresting-property always propagates to referenced objects, it is
clear that if the tag is uninteresting, so are its children and vice
versa. But we fail to propagate the flag, which effectively means that
referenced objects will always be interesting except for the case where
they have already been marked as uninteresting explicitly.

This mislabeling does not impact correctness: we now have it in our
"wants" set, and given that we later do an `AND NOT` of the bitmaps of
"wants" and "haves" sets it is clear that the result must be the same.
But we now start to needlessly traverse the tag's referenced objects in
case it is uninteresting, even though we know that each referenced
object will be uninteresting anyway. In the worst case, this can lead to
a complete graph walk just to establish that we do not care for any
object.

Fix the issue by propagating the `UNINTERESTING` flag to pointees of tag
objects and add a benchmark with negative revisions to p5310. This shows
some nice performance benefits, tested with linux.git:

Test                                                          HEAD~        =
          HEAD
---------------------------------------------------------------------------=
------------------------------------
5310.3: repack to disk                                        193.18(181.46=
+16.42)   194.61(183.41+15.83) +0.7%
5310.4: simulated clone                                       25.93(24.88+1=
=2E05)      25.81(24.73+1.08) -0.5%
5310.5: simulated fetch                                       2.64(5.30+0.6=
9)        2.59(5.16+0.65) -1.9%
5310.6: pack to file (bitmap)                                 58.75(57.56+6=
=2E30)      58.29(57.61+5.73) -0.8%
5310.7: rev-list (commits)                                    1.45(1.18+0.2=
6)        1.46(1.22+0.24) +0.7%
5310.8: rev-list (objects)                                    15.35(14.22+1=
=2E13)      15.30(14.23+1.07) -0.3%
5310.9: rev-list with tag negated via --not --all (objects)   22.49(20.93+1=
=2E56)      0.11(0.09+0.01) -99.5%
5310.10: rev-list with negative tag (objects)                 0.61(0.44+0.1=
6)        0.51(0.35+0.16) -16.4%
5310.11: rev-list count with blob:none                        12.15(11.19+0=
=2E96)      12.18(11.19+0.99) +0.2%
5310.12: rev-list count with blob:limit=3D1k                    17.77(15.71=
+2.06)      17.75(15.63+2.12) -0.1%
5310.13: rev-list count with tree:0                           1.69(1.31+0.3=
8)        1.68(1.28+0.39) -0.6%
5310.14: simulated partial clone                              20.14(19.15+0=
=2E98)      19.98(18.93+1.05) -0.8%
5310.16: clone (partial bitmap)                               12.78(13.89+1=
=2E07)      12.72(13.99+1.01) -0.5%
5310.17: pack to file (partial bitmap)                        42.07(45.44+2=
=2E72)      41.44(44.66+2.80) -1.5%
5310.18: rev-list with tree filter (partial bitmap)           0.44(0.29+0.1=
5)        0.46(0.32+0.14) +4.5%

While most benchmarks are probably in the range of noise, the newly
added 5310.9 and 5310.10 benchmarks consistenly perform better.

Signed-off-by: Patrick Steinhardt <ps@pks.im>.
---

Version two of this patch modifies the benchmark to be a bit more
realistic by also adding a positive query (previously, all queries were
negative so it's clear that it can't ever show anything). I've also
added a second benchmark.

 pack-bitmap.c                |  1 +
 t/perf/p5310-pack-bitmaps.sh | 14 ++++++++++++++
 2 files changed, 15 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 1f69b5fa85..11118a92e8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -997,6 +997,7 @@ struct bitmap_index *prepare_bitmap_walk(struct rev_inf=
o *revs,
 				object_list_insert(object, &wants);
=20
 			object =3D parse_object_or_die(get_tagged_oid(tag), NULL);
+			object->flags |=3D (tag->object.flags & UNINTERESTING);
 		}
=20
 		if (object->flags & UNINTERESTING)
diff --git a/t/perf/p5310-pack-bitmaps.sh b/t/perf/p5310-pack-bitmaps.sh
index b3e725f031..452be01056 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -15,6 +15,12 @@ test_expect_success 'setup bitmap config' '
 	git config pack.writebitmaps true
 '
=20
+# we need to create the tag up front such that it is covered by the repack=
 and
+# thus by generated bitmaps.
+test_expect_success 'create tags' '
+	git tag --message=3D"tag pointing to HEAD" perf-tag HEAD
+'
+
 test_perf 'repack to disk' '
 	git repack -ad
 '
@@ -43,6 +49,14 @@ test_perf 'rev-list (objects)' '
 	git rev-list --all --use-bitmap-index --objects >/dev/null
 '
=20
+test_perf 'rev-list with tag negated via --not --all (objects)' '
+	git rev-list perf-tag --not --all --use-bitmap-index --objects >/dev/null
+'
+
+test_perf 'rev-list with negative tag (objects)' '
+	git rev-list HEAD --not perf-tag --use-bitmap-index --objects >/dev/null
+'
+
 test_perf 'rev-list count with blob:none' '
 	git rev-list --use-bitmap-index --count --objects --all \
 		--filter=3Dblob:none >/dev/null
--=20
2.31.0


--a3ReVs8uC/uPbA+y
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBYizkACgkQVbJhu7ck
PpTOFg//Ut3BzlF+9nPrOKpOmayYafO35o3vlcXsRjtbWGPUaNW0K0cubW4VxKqO
zFz2QKv3GDoHI06MPMZG3va8lhsHArBPeVunH298eWG9E187mzjJpRnsajvQSzs8
+NLhukgEEjvY8HhOXbrL2gQZqBg27R/W9pFUHoizDBPRuOS7ZxEO7/bj1b9xTbUv
hLCZySg1EEJ21GWVOdPjxr2+Hzmu2NZ+mFnub4Wsesdc5X7zzV+Dn4V/Bka/0kc4
coE5nZc5ysAOc2b01PsQ9SM/499U3yYlFToz2Y7cJ6wZLrm/sqlk138Ba123755Q
jgZP0Z64LU5Z8ZaQmUzhmce126BNyo6cVca96bZzHpZG9qE3Y/5haZC3v2voi+ew
4xepa84m1Tlss7ryee2yp8q0yqNraNrgRTUQhtE0fId0DvPf6KRX3gEoBhlexX5u
YFLbH3NCid/ho/OY+dyVDpZV2enoP2RPL9iZ846GbhLsaWBQW0/EyKykvkCCYIXj
/cYqgVqR/zo2onZFOT7J0YGITAWMnANvZmhLDIDKMwGJDr9teMn852gj1HjzbmW6
zJSbTNR/2m5kI7dpXaIkytDjSEbyd79B+aBkORDTR5dYLSHEinZojLmc3GMb832p
PD9fBEYkLsKHUDUW9bhWyTw31kO1sRJOy7vzZ2nUocliugGG+e8=
=/j6G
-----END PGP SIGNATURE-----

--a3ReVs8uC/uPbA+y--
