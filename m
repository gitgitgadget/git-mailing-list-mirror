Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EEEC77B6E
	for <git@archiver.kernel.org>; Fri, 14 Apr 2023 06:02:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjDNGCN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Apr 2023 02:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230096AbjDNGCA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Apr 2023 02:02:00 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E71E4200
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 23:01:58 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 7B9945C0150;
        Fri, 14 Apr 2023 02:01:57 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Fri, 14 Apr 2023 02:01:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681452117; x=1681538517; bh=i1
        3MXuNK53D3G4NYXDEFD4FFhgelAS5edVN0wECqYMo=; b=NfrcMXJ991/t/UGWYs
        cin/fwkTL4SjQXPpKN7YikrisHsocRuBJgqMlRfx1kfeB7KjGsRj6joES4g5w/aI
        xsp7as7NYeohnLh54oNG+Njy4waBaQmZssqqbA5aSAhbwa3nCOVDPlHeo6N/8LBr
        a/0gbbfYoimxjxXN8h8xwWgRvdUXfw4LrbmXNzbcvmXbj7FI7TRpZPdYMtblRNN5
        KbtQlt/gxnhEuGR6hxmlXlviww+1GrabMWFufHwuCZ2uxnQwDtpdvAafFhwJ7zFT
        nJwl8oxmZ33FmeLgf7E7VN2Eoo/pdo6g+Jm4/UScbLDNuret1T3qDMfDm0SqqZzQ
        5M7A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681452117; x=1681538517; bh=i13MXuNK53D3G
        4NYXDEFD4FFhgelAS5edVN0wECqYMo=; b=f2vfJuMv9E3GInjtERSwp+S5HqIdk
        X0lTkmq91sNmmC3dVHR+Ev/i7T/+uiEkkjioOwlZM38dIbUeMMxBtFUCIF7VS09l
        dxfEVBqs2vIOpA5dglsQEWmSB0auLkYeBe1GdR5lrq+ymCb/7jgAP3G+G002SlU2
        M0zAwk0Hq5puij3CN0/Uy20hrVWhkIvQPoKw9hVpKvSDYE/+QVMXRGrORaY9x87r
        7QU8BGuS2O6C1zds40UnQtw/6Itap72YnuUArTF8miYSzOgYncJeiKhE+ExKcgXh
        OwRjiuS/qbMENfu2jUd//nl4c/RNP8Vir0PwCeCpK7rbFJSNNl3vfV60g==
X-ME-Sender: <xms:Vew4ZLmrhtozkIxR5n6BI61ry-HCH974Irb5iE1Z6dwu9ujC9yCTzQ>
    <xme:Vew4ZO1vIQ4E78ndqVrPeyJ6tZ9CvxccU5tcAed0Tx9W3Aw_PBZKAE-Xl7Od0qUEs
    cXWTfr-jbE9W8YcUw>
X-ME-Received: <xmr:Vew4ZBrup7pmIwO0DJs8Jf8cw4nkPIIbetF5Rk4uLr7SeaQCBlkqg8Zra10PGAkXtBBSe7qzXp5kFkrJ-RMj2Dt02n1UEhzlT1-TsiHctLgV3CY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekledguddtgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepueektdevtdffveeljeetgfehheeige
    ekleduvdeffeeghefgledttdehjeelffetnecuvehluhhsthgvrhfuihiivgepudenucfr
    rghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Vew4ZDkpR6qQqGgXODe75oNSxIBrx1Xo5DzXjoWaiv6yE1Ts0TTCgA>
    <xmx:Vew4ZJ2HJRo9K3u9elyYJyjb8ng8RR4W9EIIEp-MDVXuHC2lKIRlzA>
    <xmx:Vew4ZCtodIW9RqkuV0_tXh-gztOW8Hs_B8YDmO_cjynX1rgChl91_Q>
    <xmx:Vew4ZCyIkykRqNnnu3RXuBOOZ168DEI9p7y1pUyGYM1yzuWYlLhRZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 02:01:55 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id abc99d09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 14 Apr 2023 06:01:53 +0000 (UTC)
Date:   Fri, 14 Apr 2023 08:01:54 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net,
        dstolee@microsoft.com, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v4 06/10] pack-objects: fix error when same packfile is
 included and excluded
Message-ID: <33aea4c71edf60094e01ef245429befe1142c0ea.1681452028.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681452028.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Umg/SX/jGYfcC9eZ"
Content-Disposition: inline
In-Reply-To: <cover.1681452028.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Umg/SX/jGYfcC9eZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When passing the same packfile both as included and excluded via the
`--stdin-packs` option, then we will return an error because the
excluded packfile cannot be found. This is because we will only set the
`util` pointer for the included packfile list if it was found, so that
we later die when we notice that it's in fact not set for the excluded
packfile list.

Fix this bug by always setting the `util` pointer for both the included
and excluded list entries.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/pack-objects.c        |  8 +++-----
 t/t5331-pack-objects-stdin.sh | 20 ++++++++++++++++++++
 2 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 7d0e864c35..c5147d392f 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -3355,11 +3355,9 @@ static void read_packs_list_from_stdin(void)
 	for (p =3D get_all_packs(the_repository); p; p =3D p->next) {
 		const char *pack_name =3D pack_basename(p);
=20
-		item =3D string_list_lookup(&include_packs, pack_name);
-		if (!item)
-			item =3D string_list_lookup(&exclude_packs, pack_name);
-
-		if (item)
+		if ((item =3D string_list_lookup(&include_packs, pack_name)))
+			item->util =3D p;
+		if ((item =3D string_list_lookup(&exclude_packs, pack_name)))
 			item->util =3D p;
 	}
=20
diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index 71c8a4a635..3ef736ec05 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -169,4 +169,24 @@ test_expect_success 'pack-objects --stdin with duplica=
te packfile' '
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with same packfile excluded and =
included' '
+	test_when_finished "rm -fr repo" &&
+
+	git init repo &&
+	(
+		cd repo &&
+		test_commit "commit" &&
+		git repack -ad &&
+
+		{
+			basename .git/objects/pack/pack-*.pack &&
+			printf "^%s\n" "$(basename .git/objects/pack/pack-*.pack)"
+		} >packfiles &&
+
+		git pack-objects --stdin-packs generated-pack <packfiles &&
+		packed_objects generated-pack-*.idx >packed-objects &&
+		test_must_be_empty packed-objects
+	)
+'
+
 test_done
--=20
2.40.0


--Umg/SX/jGYfcC9eZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ47FEACgkQVbJhu7ck
PpSjow/+PFp+IFgg5FPJymrow2VKVRryXAbv1UmBcLH0rHqkqqMsFRfjqApESwqq
pNYRigKp3PjfhuNzRYzns9yNyPcMEdTpGzTllNBkzBMSmXytjSS86+F+yaCLtq/A
WZ0tWycTcxg8oYDix84Z0H0ykcD0eRSzevD7qalEEqyCuSP8bFQPmwguSXLd8CZC
dkMIgk+pjoHj5MR1CzYZLW1jhVFJsbNzGBMFnnFBVEHY2sv9+cGv7evclMTdBcjF
ZGQwFF7YVWqYWc+ZKjF9SqaP1+jg4HuPUmJK1NIsic3EWCNQViu3qpg7Q975/Det
ylZ9XXVbEHWbHIkGaxrXjNHo2QKewWBbh1THbJd1unwhrYanl0J1X0IJafki4EZk
UAmgUhLUpMdmlXxqy7FmUF1kYP0hQHIaq8V+6gKTmjrx1FzDtLLtXEdGWNA6sOH1
RJwTDdreGY/FI7LLRRfB1tJeF79bZkHAnc7Y6mL1Fpfvm6mBghG2Y/H1+A2omDdn
2NiSn0sEat0dH7ZsPXXtvTQOKGo0yMxAmRiikZUUL6rPqjz9FR6HaxRoCQexQM33
auon9ljQ6YifqtuYRONquGXsTXTdVHWHRxjkaGA5li20iP/YFSiwmriVAQqKKfIG
hNzLeDVPqohCXEickWKfmiAH2EQzYXe7Zbv3WlfgZUSvTCSKY48=
=WwCo
-----END PGP SIGNATURE-----

--Umg/SX/jGYfcC9eZ--
