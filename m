Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00588C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D055F60FC0
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 13:09:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344354AbhIANKy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 09:10:54 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:44391 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244182AbhIANKx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 1 Sep 2021 09:10:53 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E6F555C01FE;
        Wed,  1 Sep 2021 09:09:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Wed, 01 Sep 2021 09:09:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=Rxc/f3vvs3P5vlcJsmH6D9aAmB3
        28+ifM6da3gvaezo=; b=sCmzTKRsUARqgLvSzA5HnLI+B5Usx6wetWCQZ3KXWxy
        nElqiBePHu9P6Q1Dp4uy1JfNrLBjD/udLjLbGtsEgw2ved62+H1sRiuKom8OXPET
        1DwKB/0HIlmcZntGvUzx1PpQmyvtHdHwYxY9u1eiS44lvZ33cyc31oWu+aA7SXjG
        I5EaFils9whwy487WSbVWdqICG7A0nj6WkhhNFvTTpwp2HLO5WMfjR4i5o82gjKK
        X9KK4C3PzORP0CiXfxJuEuM00X2Ump8HSBdzcIFqzY2LIANtztn6q9vkaq44VwTK
        pVfbXMmEf3uBatX9uE0UIZonM1rYkXFgqL1KYlUfvDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Rxc/f3
        vvs3P5vlcJsmH6D9aAmB328+ifM6da3gvaezo=; b=fQtJQbQ6MT9jRNk/SiOliq
        An2aE9zJUIx12ODvh2BY0LgogY+9ShbbIu6Ysa1jvg0UpZ7LnIXBQRV91fj9Mb+k
        hsNxAkrwGks4Nl6pZG9s7htyT3Mta6JG2zuc46LzlUokkxRpt25GZfX8DTaLRbAX
        6pCuvXdziYLdzS+oa+eDvOwGBWMhjhuSViqRcnjFw3HZTHV+EI1jizYO2g+3rt/I
        j58RdjEDlOLrYnT4Xgg7oO0lQzZ5mx6jZ80FiTwwXKENpKEPdw/r7B/OVl8yEzcK
        BQ7GnvFwbdkxQ+LwlGo8ykw2Ol1rIWaRDftqsHQHLX+3Ze6GviEg61jKmlwPkGXA
        ==
X-ME-Sender: <xms:pHsvYdTs1lWIB_3kBxwNEQ0Msz7gXejPq-Z6ytABVfs1xqyckgu7AQ>
    <xme:pHsvYWxqrxiPqlgBQENA0mIlsEcgdBIm2hvn3GkeU8R5LJiL_AOsF-iHIvVT0nc2T
    YgVwABOd4ROgiVz8g>
X-ME-Received: <xmr:pHsvYS2wPdeH0hKFqQZyWVfj-QtK-I6ti43jpkit70_X2hkWcw9CtJVEt4pG0ArRNQTc4a948PtoNNXtmgJ6td7f4os>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvfedgieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgfejueevjeetudehgffffeffvdejfeejiedvkeffgfekuefgheevteeufeelkeen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:pHsvYVDd68W7-6Y7-AJzG46At0gRf4bTqEJMxWx6FzXl4KiJS67Zhg>
    <xmx:pHsvYWjfRtAcayODNXZlfX34hACPbmrIx2X6867y9n9X_TmtpVQ3QQ>
    <xmx:pHsvYZorq_9Q97Fd5zYWdNlJVzH7gpLuTQmTCETR7NAIxwptH5L1-w>
    <xmx:pHsvYee3zYuG5pfTfmBzomwIPWqis7ywiwFrs8N9AW11JISazcxiCw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Sep 2021 09:09:55 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 02a0b292 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 1 Sep 2021 13:09:55 +0000 (UTC)
Date:   Wed, 1 Sep 2021 15:09:54 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?iso-8859-1?Q?Ren=E9?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 4/7] fetch-pack: optimize loading of refs via commit graph
Message-ID: <99d3316d48162a318b1ac0473eb9c837c60e3833.1630501732.git.ps@pks.im>
References: <cover.1629452412.git.ps@pks.im>
 <cover.1630501732.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="WV0wT1q5TacQccKs"
Content-Disposition: inline
In-Reply-To: <cover.1630501732.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--WV0wT1q5TacQccKs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to negotiate a packfile, we need to dereference refs to see
which commits we have in common with the remote. To do so, we first look
up the object's type -- if it's a tag, we peel until we hit a non-tag
object. If we hit a commit eventually, then we return that commit.

In case the object ID points to a commit directly, we can avoid the
initial lookup of the object type by opportunistically looking up the
commit via the commit-graph, if available, which gives us a slight speed
bump of about 2% in a huge repository with about 2.3M refs:

    Benchmark #1: HEAD~: git-fetch
      Time (mean =C2=B1 =CF=83):     31.634 s =C2=B1  0.258 s    [User: 28.=
400 s, System: 5.090 s]
      Range (min =E2=80=A6 max):   31.280 s =E2=80=A6 31.896 s    5 runs

    Benchmark #2: HEAD: git-fetch
      Time (mean =C2=B1 =CF=83):     31.129 s =C2=B1  0.543 s    [User: 27.=
976 s, System: 5.056 s]
      Range (min =E2=80=A6 max):   30.172 s =E2=80=A6 31.479 s    5 runs

    Summary
      'HEAD: git-fetch' ran
        1.02 =C2=B1 0.02 times faster than 'HEAD~: git-fetch'

In case this fails, we fall back to the old code which peels the
objects to a commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 fetch-pack.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fetch-pack.c b/fetch-pack.c
index 7b0e69884d..da92a5e474 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -119,6 +119,11 @@ static struct commit *deref_without_lazy_fetch(const s=
truct object_id *oid,
 {
 	enum object_type type;
 	struct object_info info =3D { .typep =3D &type };
+	struct commit *commit;
+
+	commit =3D lookup_commit_in_graph(the_repository, oid);
+	if (commit)
+		return commit;
=20
 	while (1) {
 		if (oid_object_info_extended(the_repository, oid, &info,
--=20
2.33.0


--WV0wT1q5TacQccKs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEve6EACgkQVbJhu7ck
PpRB+Q/9EoXFXX3vlCqcrqp9ZjyiQoRNMHZULi7SajCykp+3jzQIJ7x05yvvyJqX
1dGxg5ROrWgu8Gbi+GuORziqglB1i6i4DxZ4703VertIcLH8l7xfqMEssBDeBy4+
3XWh918J8KiccHkmUosDZb7KNXu3NMikDoU1a4+pvU+wSsa0t9KijotKgqwI20Rj
3Z+02/vhjD+eIdZIs8XV9n5M2UMDI3zc4/rvwJu7DrEh9RFlTrxlqhd0wDvReM+Y
G3uz5Prv5pKTAGG9639xYFJhmJNyN5bMX6GAw+klcONSIaZT9M0uzvDo+lYE8RuP
ZFZd2qS9i/sb/9F7Lki/pdD8DLKGsIXUfMlYF2+hddoouBEjVvvIm2NR7MKbCeq9
fMPLevDLeiHDvSFiv64c9mLsJQlceM+HDwjYJ5YT2GVVynG/AgYzM2qj3yMydrvx
AbqXr0Akj3tGvtR3AUqfxRMxQNDbx7/WGcyxSanr07RQRI2akCK5OhGi7yn+Hi3W
sAoqYNpWrzTTA53N4YyEcQxO2dDZiquWtlLeLrFM13FHZ1u0J5ni+BxdmPzBkJHn
Kcg43x+SOTv8K4L+5n9YX5GqLnRSsHlW4OLmzjaIRs1AwktmzKYRyDWQ3YjEwBrw
UhEaEYzHTYt7BYaO/fCnuQT05e5msFLu4iowclkb3KwyY/HAVVY=
=XSd1
-----END PGP SIGNATURE-----

--WV0wT1q5TacQccKs--
