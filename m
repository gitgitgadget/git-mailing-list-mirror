Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A32E4C433E0
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:07:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6707A64E27
	for <git@archiver.kernel.org>; Wed, 17 Mar 2021 16:07:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232256AbhCQQHB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Mar 2021 12:07:01 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:49247 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231954AbhCQQGh (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 17 Mar 2021 12:06:37 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id A61A05C0306
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:11:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 Mar 2021 11:11:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm3;
         bh=28uTUgw6oAd1oHVWZsBez8ceBjvCMihgRuTe29vTmJ8=; b=ASyzdsCJznMn
        dX1gN6hI3UaWs1cwI2JuNoem4WyPXQJP361PCS4+TuxXKJ+0rpg7770rt6MqTZWv
        EuHA1JNpfFf8r++uao3/VJK+FpTwWySrp9JJwYvWRJHdmLcCNKesf6Z9Wfj/riP7
        M4dyPE7EXAKdR/H/un/o5vN+mPReekMt/xGOLfp/PA1nmQub/a4qjlKM3Imjf4Ud
        Kgnok6y//1/pcIxUq6xU84Foak2TvVgh55EvUEj/z/h7YQXAmkCkCIVfr4VUkGWu
        kFsthpDkDkdaaXIcEOS84TfJlksHCpBXiTvYFLwzgD2RP9abZvAf2UgTHh028mWb
        797tpZyvPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=28uTUgw6oAd1oHVWZsBez8ceBjvCM
        ihgRuTe29vTmJ8=; b=EQ4aRiq8aaQdQBjWOK1NryquUtg/yQHM97MN05ND+RaMV
        bsgpQf3QWp1CYuHtXsJ7UU4wr+Y89ml6z4nrzxvplpsefwl7JzBT8scv3OAA5H2T
        FH99x1bSKVA9wVqLmdF4bMheX3zN31+FxjLRMTAcnm0qZ1PT9Kn0nt3gYFxGEwmN
        xUnLSHYcrVHetfEaHhZCYSIT8VOWrfjIdVnJEXQlKYQg9HuxDLbdtaPC67nWa/PV
        gGLebnRPKTwTBlAT0+Ce37K3wve1H6xRxthKHtqcbc7ijV0i4DrXvOTylQvfa5Jw
        rRm85qC78e0Vt/OooLr5Wy6Wzqs7g8ItY8G3Khmsg==
X-ME-Sender: <xms:FxxSYDwUdECyT8sDkB5fgh6WInejeiMCYDwr13C8VpwgdRv0nbkvLA>
    <xme:FxxSYOiNaJ_2TAp2MEOzPpdOBHS_5vwF4h8Fkb5SDf7MN7fuzECf_PKDZHWHKzM0c
    4iPZcOeaPMN3fqVJw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudefgedgjeeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecukfhppeekledruddvrddufedrvddvgeenucevlhhu
    shhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrih
    hm
X-ME-Proxy: <xmx:FxxSYGxfrbl0kSJHfV0vt1fxmpCXp4fQ8W11flRttlImHx9Fj11ReA>
    <xmx:FxxSYJIkftz6pehd6QKCrpat0dVCI7v-KDQdR_ux_luKPHwpFl2ykw>
    <xmx:FxxSYFQ_upMUEl4kfcQh24fZdrcLUVOtfD1O9oycxSLBZEMbUWlvzw>
    <xmx:FxxSYDzR-Pi6mWTTbc47qr1K5_ydffiDtXtPI7M58ixEbrYZSoYkmg>
Received: from vm-mail.pks.im (dynamic-089-012-013-224.89.12.pool.telefonica.de [89.12.13.224])
        by mail.messagingengine.com (Postfix) with ESMTPA id B41DE240065
        for <git@vger.kernel.org>; Wed, 17 Mar 2021 11:11:18 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id abc6d4ee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 17 Mar 2021 15:11:15 +0000 (UTC)
Date:   Wed, 17 Mar 2021 16:11:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] pack-bitmap: avoid traversal of objects referenced by
 uninteresting tag
Message-ID: <e342077ed116fb47c6a0fa645abd5558310efb09.1615993858.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="MQsI0raoLtpkEC3i"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--MQsI0raoLtpkEC3i
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

Test                                                  HEAD                 =
  HEAD~
---------------------------------------------------------------------------=
-----------------------------
5310.2: repack to disk                                194.96(183.59+16.01) =
  195.98(184.04+16.67) +0.5%
5310.3: simulated clone                               26.09(25.04+1.05)    =
  26.11(24.95+1.16) +0.1%
5310.4: simulated fetch                               2.64(5.25+0.72)      =
  2.59(4.99+0.72) -1.9%
5310.5: pack to file (bitmap)                         58.70(58.19+5.66)    =
  58.99(58.66+5.52) +0.5%
5310.6: rev-list (commits)                            1.46(1.19+0.27)      =
  1.47(1.21+0.25) +0.7%
5310.7: rev-list (objects)                            15.54(14.48+1.06)    =
  16.17(15.06+1.11) +4.1%
5310.8: rev-list with negation (objects)              0.09(0.07+0.02)      =
  23.13(21.53+1.60) +25600.0%
5310.9: rev-list count with blob:none                 12.40(11.43+0.97)    =
  12.38(11.33+1.04) -0.2%
5310.10: rev-list count with blob:limit=3D1k            18.14(16.09+2.05)  =
    18.26(16.18+2.07) +0.7%
5310.11: rev-list count with tree:0                   1.71(1.32+0.39)      =
  1.67(1.31+0.36) -2.3%
5310.12: simulated partial clone                      20.20(19.15+1.04)    =
  20.45(19.34+1.10) +1.2%
5310.14: clone (partial bitmap)                       12.68(13.89+1.03)    =
  12.84(13.91+1.03) +1.3%
5310.15: pack to file (partial bitmap)                42.10(45.33+2.76)    =
  42.30(45.41+2.76) +0.5%
5310.16: rev-list with tree filter (partial bitmap)   0.47(0.30+0.16)      =
  0.45(0.30+0.14) -4.3%

While most benchmarks are probably in the range of noise, the newly
added 5310.8 benchmark shows a performance improvement of 25600%.

Signed-off-by: Patrick Steinhardt <ps@pks.im>.
---
 pack-bitmap.c                | 1 +
 t/perf/p5310-pack-bitmaps.sh | 4 ++++
 2 files changed, 5 insertions(+)

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
index b3e725f031..2910c818ac 100755
--- a/t/perf/p5310-pack-bitmaps.sh
+++ b/t/perf/p5310-pack-bitmaps.sh
@@ -43,6 +43,10 @@ test_perf 'rev-list (objects)' '
 	git rev-list --all --use-bitmap-index --objects >/dev/null
 '
=20
+test_perf 'rev-list with negation (objects)' '
+	git rev-list --not --all --use-bitmap-index --objects >/dev/null
+'
+
 test_perf 'rev-list count with blob:none' '
 	git rev-list --use-bitmap-index --count --objects --all \
 		--filter=3Dblob:none >/dev/null
--=20
2.31.0


--MQsI0raoLtpkEC3i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBSHBEACgkQVbJhu7ck
PpTXMg/8DWjcXF4boUYIlo31e/YF4IocImmaKX5JL3NkcLO6LZfFS0VH8tx0TwEK
Ty2j3KNtftgOgRPKcoo9giUOVBrxkPAKBmUVMAO4+TyVZcSoeIblfsRdWOjquckq
0P18rJn8oo5MPoHfuJjamX8pwamsng8nvszgMykG3OGjVe8A28N6M0tpCeEwxavZ
1kJNiyNpij7oRKT/UHOxmyTJRuxD91EFPvDvPGOk/lo7bphmOQt27OzV+pTL11Ew
ZuOy2Hz6Hqbd3ussev/hYs2wOjWoLUQzxsTPywVDdT9mAgk2xQgVYAzp8PzBNamB
WzG9sej9HPCfFd5rDpmLh06OImbWcAUnvzBlM87shi+5TP18yjDxH1oB1A9OOONZ
Ho9cGMBmAaxZqBqmesP/RfcYQamGe4Hmn0G/GkTki/lxvVWgEQjl/zZdrUW0OsD1
dicqz49z4Rasf3imvO1K7CJvfEe6plgGZu7rFtTyDMFSYFfEDbIntQ4yRnKiz84d
PkA5x00AdLigyqhVVobgnRp4lzUzWacRh4NJHXs57tb5NTA4HcM+4TbvCRjNQVwc
d1eaVL6/1BLgal8ifLdlNGjU0lr94gIPHo227pX2dIbRkkvhyYjl/WadsBiZa9zQ
D4dPllEj7eZDxNvKjQm9bu9egl7cdCxjc2nTW5GWcXmpsfJ4fWc=
=mftv
-----END PGP SIGNATURE-----

--MQsI0raoLtpkEC3i--
