Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C444EC433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A48336108B
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:47:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238567AbhDSLru (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:50 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:53653 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238896AbhDSLrf (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:35 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 68606B3B;
        Mon, 19 Apr 2021 07:47:05 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=D4pdkB7ro/GuZ3+Lm7yBiYSpBDg
        Lu4sKUkYFh6OGCyc=; b=yZw0pAMEQOirDzzquLGrxBjThXnAQ2hG3kJt70mKi5N
        65Gs4oBDRFPWKDg3434c4cHll4m+z+AJwTLT536Fs4mEC+Czis79W37Op61Twv9F
        NGJFqeV0GIFHMrhdsXt7GNZ4oHGRwUHLaVk2+4vsZSsaazHUiFTURZNswpJrMqxz
        bYZmK1YRbB5aju7Xue14Pbj4tcbcIoRqinan3uro/iUqahw/UL9t0fv4d4HXwxNY
        6ktgtDcS70aEom4lnFy1KEU8sTLA+f4aRdK2zCFJZ+xfDOSBO/o7xPVjI/gZeZen
        NZjBxTkXlhLMltP7fyfiItqBl6BR6lQcWhtOA47hOPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=D4pdkB
        7ro/GuZ3+Lm7yBiYSpBDgLu4sKUkYFh6OGCyc=; b=FlN3uC8ptzsnjervNvGt7g
        GEICDWewJrw7MSWBQrHQzr0QBg/CV748XkKhpc69OQIfb/+2gLXpin+eo/9raCDn
        lGA/wojBCyycPrd+wObQJWOzsLyNjaOOON/1xsvrMVTZakdIihY9SW0MAaK606md
        Z0U69RlQEAUopVKsXGjH/bXO330dyWxRRO/X/F+o15K8AS8NqS6/LcDXPKab4mIK
        mGMn7YMsgAzDpVSis4zk0yFoMRkFydqAjw5EEwvNLjSqfpKHQI8ZqBUBLPlNl9w9
        YlLoYllsY2X33Q8shcmLJNPxeycQCHOmw69bv6wVIsO9B566wjC9SG5Gw5zdYbKw
        ==
X-ME-Sender: <xms:uG19YPoqVntArzvzZnjC14PSFZUDTUKoN2bn0GC13P1RE66ij30ZoA>
    <xme:uG19YJoEu6B70uF9l_2FF5-lkRkutlcakSg4O8ODpnRFilkKHwiBHbeyrbxRrmBjV
    iHTElyiTEu4eaREZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgepheenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uW19YMOpGzeATf3fCVi3u2L-JLucTJIrftLy59vUsW5SlZNyv52OPw>
    <xmx:uW19YC7m8y_LbzTJKqLVNFcAAt8IbaKTWQd3PJPOrfZsBXKA9TLYrw>
    <xmx:uW19YO4ZUt77sUhx5m5UGXfmEGnbQlDQ-5kRqMrr5ROMPdK_7yJdbw>
    <xmx:uW19YJ1d5KjDuq-ctQ_ajAG9NW_waaE7qwM3ZQ_GhJTVcY16wbFFgw>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1461D108005B;
        Mon, 19 Apr 2021 07:47:03 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id dc7c0fad (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:47:03 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:47:02 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 7/8] pack-bitmap: implement combined filter
Message-ID: <9726e698617fa6a5a4d41283400e6a72e08baefb.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="TH3s/NdJ51vE7itR"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--TH3s/NdJ51vE7itR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When the user has multiple objects filters specified, then this is
internally represented by having a "combined" filter. These combined
filters aren't yet supported by bitmap indices and can thus not be
accelerated.

Fix this by implementing support for these combined filters. The
implementation is quite trivial: when there's a combined filter, we
simply recurse into `filter_bitmap()` for all of the sub-filters.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 pack-bitmap.c                      | 10 ++++++++++
 t/t6113-rev-list-bitmap-filters.sh |  7 +++++++
 2 files changed, 17 insertions(+)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index e419f4206b..53f35d41c6 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -967,6 +967,16 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
it,
 		return 0;
 	}
=20
+	if (filter->choice =3D=3D LOFC_COMBINE) {
+		int i;
+		for (i =3D 0; i < filter->sub_nr; i++) {
+			if (filter_bitmap(bitmap_git, tip_objects, to_filter,
+					  &filter->sub[i]) < 0)
+				return -1;
+		}
+		return 0;
+	}
+
 	/* filter choice not handled */
 	return -1;
 }
diff --git a/t/t6113-rev-list-bitmap-filters.sh b/t/t6113-rev-list-bitmap-f=
ilters.sh
index fb66735ac8..cb9db7df6f 100755
--- a/t/t6113-rev-list-bitmap-filters.sh
+++ b/t/t6113-rev-list-bitmap-filters.sh
@@ -98,4 +98,11 @@ test_expect_success 'object:type filter' '
 	test_bitmap_traversal expect actual
 '
=20
+test_expect_success 'combine filter' '
+	git rev-list --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:typ=
e=3Dblob tag >expect &&
+	git rev-list --use-bitmap-index \
+		     --objects --filter=3Dblob:limit=3D1000 --filter=3Dobject:type=3Dblo=
b tag >actual &&
+	test_bitmap_traversal expect actual
+'
+
 test_done
--=20
2.31.1


--TH3s/NdJ51vE7itR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bbUACgkQVbJhu7ck
PpSnmhAAkjTat/gAxAEQFsfwEYRJaAMfVbIKr2fUgctjN5njbNhWUrKdb+ULg4Ad
d58yFazp6BmIvaUydAfV8LgGNEy1Jv+K0WsqkJLvDQyQcJMLMYGu7f3t9LnqZqQQ
2p2sRhUMdP1YB49URQgspZFSqNqR+SLYVpYvNeBy22GeTR4LSS5dyOoZWoyKyqni
S7l6QUd0PEj1qqDCeVLvpPIw/n3fkRwVVAizraPkh+etvVZG2iCEWdnaKhpPTglt
eGRBE/LmmGhtzKvyEAvRKxgjDheKz0ceGPsk9I8zsSDAhqqptjZzkWPPtjjmsRRx
+jye7DHsySpqFpuOIBMzpgvS3BtsMTs1fAydarhyR/th76NP58/MMJScPpw+8OCJ
Gb4MY77u+b719765p1odtSSdqIOgjzGecJ3lP6m7q5UYB6/vnswsNHpFLiLSMW6+
FjpOk8TWi3BkfoS8/JROgKgffuZHob09JGkvnUTe80rxhyLOnhGYP0bMA9781u85
wcezgPjhfnjhEaZP6g4XISrx3AppPesxTL/i119UkmnfZR/T3aKxc2tRNXZ18TAt
4HP9YT4Ranz5ew+4oJJusGFdaC0CRXSAFHgP8aRyKLRM+Jj5Ti9L/SE67i/7JZN1
wBtGsNtiMRxTmSgSLThSM2DLnkXZX8oD4xIupPM5LvUkozcGOKc=
=n3uA
-----END PGP SIGNATURE-----

--TH3s/NdJ51vE7itR--
