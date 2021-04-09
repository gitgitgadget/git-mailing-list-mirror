Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79CA6C433ED
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53A9C610F7
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 11:28:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233633AbhDIL2i (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 07:28:38 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:41925 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233603AbhDIL2g (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 07:28:36 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5ADF75C0097;
        Fri,  9 Apr 2021 07:28:23 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Fri, 09 Apr 2021 07:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=7QVbyRXVMdH4GypcTjyJOGafoQr
        l6wqozT3DJiP2AIU=; b=x3f8aRCklopQpoHKUTfR1m+9vpsMqv9YYi9npiqYF45
        wCz1JZALbH4pjBl2UGSj9c7gqX3YuMbAc+fNUJVnTQ0UYbk+s/qbHJ7r7RIbkp5T
        K2VNQrnNBEwpTWJ/r613QIHUQ5QLAm8G7CEz3PmM0R35m4eOcMOBOJYIYtPpmYe0
        mdMqVdX/dKAljUcRyp4CAT5xU3+MrK0E/vPdDo6IqPhW3JgsKQ8PsaOfGFsaNZ4N
        ExwMGt0n6k2qTqJ6stPdvoF4e9Y6Lznu3rGbp6dJULaVq7wDFhG+iaqvo+xyGTF3
        H2nn+VBPfuWv1M/e7fgufzu7rUEwSHsHr7gh1wPFDsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7QVbyR
        XVMdH4GypcTjyJOGafoQrl6wqozT3DJiP2AIU=; b=GKjMkVcWQ9EM/cKPoapQYS
        jSs96t0mF/JNnx4eREeN9O9oVJEN4PVOUdTc3n1qLpME6Qcd0rsjvTO5/ZOWMPqB
        G58kJzw14vd5YQAcCPSl3xElMcXr40QziuhCtgoyfO4/pXge+5AeWl8xYF9U2cNg
        0OPpKU66L8+dcI5/rnH7DY7eG05kH97n4WtVF28Z4tgA5cU2kHw96G3M8+RODILC
        id9pyja6jg7LIfUrjG7LGTXkLqAua65xpTPrUOpwCAQTFktbC8Bk7DLOaww2W96f
        aEvPEDkN9MSoOBBtaQRGshgVaVheSn1QEVwYi6IKDzt3dcSfHTXO3jpllyTiId0A
        ==
X-ME-Sender: <xms:VzpwYMPl9OulS3KCt1dZdV7qKZFybcYt4LMi2g7GOkPFaD5bK0S19A>
    <xme:VzpwYFjmKprQZQaWJWesrpAfLD26p8C_l6jenyAOZO6oSuYBvW3hYKMSe9l5CL72z
    9tzfGjcluO8zgaZdg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddggeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgepvdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:VzpwYG74dF83OttSQfnYHCIjeUDm8lKeQ-Y1l0N4utqQDozubMBpVg>
    <xmx:VzpwYE1Q9TLTlvrsOtgP5l4po20qoo9n67OnGa_G8eIrYmlPZaHsWg>
    <xmx:VzpwYJuOFGd3pgQAF_ZKFk_HZ_4ujvVwcO9lIgML1f7XfyE_DAvonw>
    <xmx:VzpwYOqt_CscCN4jllQ2BMQsB6ZLwuV-j7ybb6TfOYkIjYk250IpDg>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id A629C240068;
        Fri,  9 Apr 2021 07:28:22 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id f1f23e66 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 11:28:22 +0000 (UTC)
Date:   Fri, 9 Apr 2021 13:28:21 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v3 7/8] pack-bitmap: implement combined filter
Message-ID: <06a376399bcce0caed993fd2e1a9cff5a57ce502.1617967252.git.ps@pks.im>
References: <cover.1615813673.git.ps@pks.im>
 <cover.1617967252.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JYOczBxH3wosdRbL"
Content-Disposition: inline
In-Reply-To: <cover.1617967252.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--JYOczBxH3wosdRbL
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
 pack-bitmap.c                      | 41 +++++++++++++++++++++++++++---
 t/t6113-rev-list-bitmap-filters.sh |  7 +++++
 2 files changed, 44 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index cd3f5c433e..4385f15828 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -926,6 +926,29 @@ static void filter_bitmap_object_type(struct bitmap_in=
dex *bitmap_git,
 		filter_bitmap_exclude_type(bitmap_git, tip_objects, to_filter, OBJ_BLOB);
 }
=20
+static int filter_supported(struct list_objects_filter_options *filter)
+{
+	int i;
+
+	switch (filter->choice) {
+	case LOFC_BLOB_NONE:
+	case LOFC_BLOB_LIMIT:
+	case LOFC_OBJECT_TYPE:
+		return 1;
+	case LOFC_TREE_DEPTH:
+		if (filter->tree_exclude_depth =3D=3D 0)
+			return 1;
+		return 0;
+	case LOFC_COMBINE:
+		for (i =3D 0; i < filter->sub_nr; i++)
+			if (!filter_supported(&filter->sub[i]))
+				return 0;
+		return 1;
+	default:
+		return 0;
+	}
+}
+
 static int filter_bitmap(struct bitmap_index *bitmap_git,
 			 struct object_list *tip_objects,
 			 struct bitmap *to_filter,
@@ -933,6 +956,8 @@ static int filter_bitmap(struct bitmap_index *bitmap_gi=
t,
 {
 	if (!filter || filter->choice =3D=3D LOFC_DISABLED)
 		return 0;
+	if (!filter_supported(filter))
+		return -1;
=20
 	if (filter->choice =3D=3D LOFC_BLOB_NONE) {
 		if (bitmap_git)
@@ -949,8 +974,7 @@ static int filter_bitmap(struct bitmap_index *bitmap_gi=
t,
 		return 0;
 	}
=20
-	if (filter->choice =3D=3D LOFC_TREE_DEPTH &&
-	    filter->tree_exclude_depth =3D=3D 0) {
+	if (filter->choice =3D=3D LOFC_TREE_DEPTH) {
 		if (bitmap_git)
 			filter_bitmap_tree_depth(bitmap_git, tip_objects,
 						 to_filter,
@@ -966,8 +990,17 @@ static int filter_bitmap(struct bitmap_index *bitmap_g=
it,
 		return 0;
 	}
=20
-	/* filter choice not handled */
-	return -1;
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
+	BUG("unsupported filter choice");
 }
=20
 static int can_filter_bitmap(struct list_objects_filter_options *filter)
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


--JYOczBxH3wosdRbL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwOlQACgkQVbJhu7ck
PpQsgQ//ZATYnUPsd1skS9e2MsYnrpOtumH4YASkv7qcRXIeHq6yGllrbZ72VRuL
6XvFrowgQw64VT9cUXv6NRYndnAgVDZEcLQVpzdqhIIKtq2QxjAIVvAoaDYeMrqy
1XR9Fqc+o6Nl9VFRnFe5ODuVMGiukz0zeBCGHKat90BiDjCGiJ0VlsH9NfP+m3ph
UiOiKYaZX2ItfeFykdZk+pkz6Etuwspm925X26UlgSVuW4oBtkjzjBDjpPErFaTZ
FP/pe0SWkdaheBVp8eIf3Rb3Eq3QUZjGtRr1jp+5wYE8XDIkKFAxcWCAK8ZK1q5v
koTM4lmKyY+Qr2gdGucqA+6MvPzzzD5efIkmw2EnZdP6qYheeC2AnFeYONR/uT22
9JsVkfk709SJjJPj1sEQ01BwkEXglq/jJF9UzRwez52AoBg0S5OHGs5XO2mbqzvz
zubUSx3WHPRdTAE6xCrJGgsFMUAoZAg+uhCx60c6rEVEaGkgjMfFzHVgHigeX8nz
6lkYG5wUALQXxVHTSyiGy+ufWGp78PrPOPVtT/bx3gcjZm7J/HArRnvJVSFDfSLa
J8AUHegAS5VNxUx4G0SO145X9bV4Nrg1x99QyItAtuVsBgE7vPhuviJ8AJcEgdpx
EOe0zcSPJBon3lez/bebVuq6xaairn0+Cic+xvRimA8yqBO40SY=
=R4/r
-----END PGP SIGNATURE-----

--JYOczBxH3wosdRbL--
