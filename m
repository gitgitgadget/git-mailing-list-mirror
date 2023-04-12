Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3CBEC7619A
	for <git@archiver.kernel.org>; Wed, 12 Apr 2023 10:23:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231473AbjDLKXW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Apr 2023 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231538AbjDLKXD (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Apr 2023 06:23:03 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA53F188
        for <git@vger.kernel.org>; Wed, 12 Apr 2023 03:22:57 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id DDDD93200985;
        Wed, 12 Apr 2023 06:22:56 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 12 Apr 2023 06:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681294975; x=1681381375; bh=3e
        zOkmRLBC+RPoRa9A7gr7+1JZYuo4xi/8eOeH9y89I=; b=SLS0IyenYGDvTfHrCo
        sKn3xDCvuvLb/2reDfhqscdfKEAqxGgYvjlHUjVPf99+xLcP6cmHtQnRqsXTg9tB
        1moQ9kx5tybQHxjJem82uTBsJU/+MM7MUUGLExEWBaxv7OAuzbYVNgiOZkJ9k5i7
        mhwG2/nPimWuehcPrIEB1iQ2Mah2haEKUGrMpXiBpGsFRKAqT1Ho6oes4GTRI4cH
        wBgopQ0RtvZLQnE+42DOmoPn3yx/2zjkOv1hm65kXS5vjGFL4s6lkNkS+FDWKyPR
        1vvUeN6Od+sSGQHKXpigr+u5vdU1X4sJ+EVPiEK1iY1hXJQv2FQh8RXImba0CEwD
        p8aQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681294975; x=1681381375; bh=3ezOkmRLBC+RP
        oRa9A7gr7+1JZYuo4xi/8eOeH9y89I=; b=kS6TvsrtcT273WVN6DJTCLflx1Xms
        zXDlSxAWhi4Ka9htbFjGrxcrVihyzHjbz8ih/xhLaGiCF567Kw5EiOCHLNVEo7cc
        Ua0E85KWEdrxuWyAr6LinFrd3R3vg1LPxovinW/jCKwgknNsqz+Y2UOaQ+ZBs4e8
        AIdVjKF2NqvyteZynCPZd5a3JMKpXtfkIckTdCjDezZrAl4Ht7EwVu57Fy97xLR5
        QOKlmPFO7rl8gKW8I0Q4SDGz4uYbF7eaJffhSAdBwc/8DcmNIOkS2d4szVuFBwBL
        GEkEHxluquNJWXvCqdgKQWFpMhoxaUkmQk2q+xUVbx32Y3ikZGGA1g+dg==
X-ME-Sender: <xms:f4Y2ZIKwPsIGHFprUJY_imU2Dqah6mDZRXJRkG98ddJGlvazDfb3eQ>
    <xme:f4Y2ZIIPFMMP97HC1Tt10ZmSVKSVWIoOwQcdUgcuMLpdcMdXpe4lAUbN4wGJanFtK
    _HfIlQs0oMaIfT71g>
X-ME-Received: <xmr:f4Y2ZIu-sRTAfEoYP59ZBbLd7Kta_PJUCCLyczwl_9EosW1VSl70YJVa0D6AaEIP7lFsz3CSN2JjXW3cVsxRyVfDTa8ndlE-oYwiFdOK9Sk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:f4Y2ZFZv5vfMri9IYJ4O99KExmcU4Iv6TYsQrhZKLqLWbNVVT0s4jA>
    <xmx:f4Y2ZPZvsAgob5j4Jdem3Yc5j2IdfHJcDk87AyvHGmq5cWYdzz-tVw>
    <xmx:f4Y2ZBBMZUOSbxMRzC_XppkYywkjsaITZJ8DREj8euWq2LLGiDDu0w>
    <xmx:f4Y2ZOlFoWmxbBeCdVgEUcSOJFzxl__WYVqnJRz0EiFbYeWgLdO0WQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 06:22:54 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id beea924c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 12 Apr 2023 10:22:33 +0000 (UTC)
Date:   Wed, 12 Apr 2023 12:22:52 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v2 6/8] pack-objects: extend test coverage of `--stdin-packs`
 with alternates
Message-ID: <3a7a2015f7ced01dc738099f18b0fce6537af05c.1681294715.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681294715.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="F8wqnKNjFCiQ4RZM"
Content-Disposition: inline
In-Reply-To: <cover.1681294715.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--F8wqnKNjFCiQ4RZM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We don't have any tests that verify that git-pack-objects(1) works with
`--stdin-packs` when combined with alternate object directories. Add
some to make sure that the basic functionality works as expected.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/t5331-pack-objects-stdin.sh | 48 +++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t5331-pack-objects-stdin.sh b/t/t5331-pack-objects-stdin.sh
index f389a78b38..8bd1d26caf 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -52,4 +52,52 @@ test_expect_success 'pack-objects --stdin with same pack=
file excluded and includ
 	)
 '
=20
+test_expect_success 'pack-objects --stdin with packfiles from alternate ob=
ject database' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Set up a shared repository with a single packfile.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+	basename shared/.git/objects/pack/pack-*.pack >packfile &&
+
+	# Set up a repository that is connected to the shared repository. This
+	# repository has no objects on its own, but we still expect to be able
+	# to pack objects from its alternate.
+	git clone --shared shared member &&
+	git -C member pack-objects --stdin-packs generated-pack <packfile &&
+	test_cmp shared/.git/objects/pack/pack-*.pack member/generated-pack-*.pack
+'
+
+test_expect_success 'pack-objects --stdin with packfiles from main and alt=
ernate object database' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Set up a shared repository with a single packfile.
+	git init shared &&
+	test_commit -C shared "shared-commit" &&
+	git -C shared repack -ad &&
+
+	# Set up a repository that is connected to the shared repository. This
+	# repository has a second packfile so that we can verify that it is
+	# possible to write packs that include packfiles from different object
+	# databases.
+	git clone --shared shared member &&
+	test_commit -C member "local-commit" &&
+	git -C member repack -dl &&
+
+	(
+		basename shared/.git/objects/pack/pack-*.pack  &&
+		basename member/.git/objects/pack/pack-*.pack
+	) >packfiles &&
+
+	(
+		packed_objects shared/.git/objects/pack/pack-*.idx &&
+		packed_objects member/.git/objects/pack/pack-*.idx
+	) | sort >expected-objects &&
+
+	git -C member pack-objects --stdin-packs generated-pack <packfiles &&
+	packed_objects member/generated-pack-*.idx | sort >actual-objects &&
+	test_cmp expected-objects actual-objects
+'
+
 test_done
--=20
2.40.0


--F8wqnKNjFCiQ4RZM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ2hnsACgkQVbJhu7ck
PpQ+zw//bKAL0xe0310kR7Rp+YFSKXQNot5n6q3ebi4akW6LTdLGSUHKU3I+GwhU
WH4yP5eMgioT2JscP5KAQMIv/3Ux+c4TGFF28wP9KL/oWnDrapnjtRy2gzM/qfGr
dszdkVYn1VSsmFDSw5WXaObivDsts8V0v45FN/99QU0YfWwjUQfQGSV8lEEYt1US
PqSO5g6z9M6NPY+oAo0bRYDpB10NiFwnILHhhraS3oNURLrpBnFiCbkN/HMcWJW8
Ejt3nj6pZBmtjTrNtLE0jtTK/10p5j28G9JuW+dTTV1fwzLfulpxrbENxTrkxHpD
lpUhZp+b5oK3MqW5r67XmnXav7jxlln7+OGxaHCgg2ddyrE5bQfEJvU1V/jRqSqh
W5apT6vNNgAwlHsiwEcsBGeTaIPyrNRL7edAiRbd94VUmtFQHvwsq6XThpBfmrIL
B7RMHrZO0+runzPu97DFtqbiZKXNnFBiYha0a2J8Ow7xjoIQx3gTUtbtY9EUNG5i
UJ+23Xrce7zhurlzA+I1lGqFMCoJQHO1N5CFjkxHVqVcGwHsMVqn9+zfW6TtE/e9
g7lv14YAQcKXqItmL3RDAqO21CNStpmlFfc0v8gyRDJjXaDztPm1fA/MgfL0EvAK
WfS+m4W4EW5TBFWH0gqwCpHdlvUexMphDtQ4uvZ/8cK7VHah6p8=
=nneu
-----END PGP SIGNATURE-----

--F8wqnKNjFCiQ4RZM--
