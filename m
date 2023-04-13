Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3D40C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:17:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231322AbjDMLRQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:17:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231232AbjDMLQ5 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:57 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 979D976AD
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:36 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 0F8E45C00A7;
        Thu, 13 Apr 2023 07:16:36 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 13 Apr 2023 07:16:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384596; x=1681470996; bh=m8
        uCdIrVFWBb08sQaxzQA0rAW3FwHkL4jFTfYVo8NYU=; b=A6FSuem9NRkzfeayBz
        DY78Z78tLfWWJCHTZfoj+EfV3sE0eHv2Lu78RUiFwvF1AfhhYL2u8LbeVhUb42oo
        nyFMFqzPq1yru1pV7dLTd4+gmwC5Do+uvJ1USELiHvyNZUWSogM+bqTkxVHrZabV
        O5F9n1w7VqJAgzEqbb8MWwRsQZyQ0xmkaHsEkc7Exe/pn0bD0vvL1TlYQvOsBpuy
        MVqAkOlpvMaqzkJtYDqU9ac9y1m6Z+CWX4AWcfpMawD4Ly9rSlHe101cpEabKs3d
        U7T/qh7o/xWDrX0boPYA8NlzHmGjFic8u/0h/TUIE869NDEMxlwLFKwzlxWzaHpE
        9xMg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384596; x=1681470996; bh=m8uCdIrVFWBb0
        8sQaxzQA0rAW3FwHkL4jFTfYVo8NYU=; b=SIA+k55OaEFBul7esZcugTOTpymJq
        Q7/OQTTaObh5G2AuylbJCMOm2+rO0YELp043TtEY2BSmySmO4cyLJIqTqvDa40xZ
        WdS+w0RUwT6qwALG3MullYLEwCJmfWEhk5PUdcMyNn/I2jvdAjljWai5DGUM/6ej
        a3MD8oCcmyUcbRWbRvTlDLtXMqlc1VtnOEsCtHrAHNmK33c9jUcluC+i/5st05ex
        Q+D21stI6jfoZ1VYIt16l8qKjjHQCGGVrLYtfbNIQOdxh+8oyC3pOgQBQ5Rq4LwO
        Q4wcI9b6KEKzR5kEzcBzxMm71BXY1zfRUl5xFxbijOB4bYzRsBTFsCO6A==
X-ME-Sender: <xms:k-Q3ZOc-9HAXqSPizURjq1MB0ymC12eJG70AGjbVNOIQqEEvudNmrA>
    <xme:k-Q3ZINubB8Dkezx7BDF_OFL37WrO4xrHrUtwW2wDs9c19b3Z-YdpPxC9xa8T3h4n
    kFyTjWlAnixjoKJaw>
X-ME-Received: <xmr:k-Q3ZPgXmT6wWowinEt0esB3Oxjm6ce5sWR6ehPbK2sdemcfvU-pF2lIeYk6qvLVQU2DWFgnUwIofC_0t46mTjDeM8SUCkOR5Yvd7DHwmJMdg14>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:k-Q3ZL9wO6D1EA7UNIzjrYsMc4MnF-dmuvYCrvNEZzihccWIhW8i2g>
    <xmx:k-Q3ZKtf8m7HJREAfdVoso1u3_nkHdMXPfXAJGLGB5A0NUoUlZkO0w>
    <xmx:k-Q3ZCH6sPvnR23eS85xsft--nWeqDtSDT2vEP75KvwiPpLMo3uNIA>
    <xmx:lOQ3ZD6XK5wchWeRARFWAdsvV4ZVojQAnVz-B3dO7PmjVgNAL22pdw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:34 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id b692c1da (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:16:11 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:32 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 07/10] pack-objects: extend test coverage of
 `--stdin-packs` with alternates
Message-ID: <cd135439ae9708bb9d2a97ceb78d905e1b125007.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="NJrSwRn2oTcJLaR6"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--NJrSwRn2oTcJLaR6
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
index 1e23cc2e61..45e24fa94a 100755
--- a/t/t5331-pack-objects-stdin.sh
+++ b/t/t5331-pack-objects-stdin.sh
@@ -189,4 +189,52 @@ test_expect_success 'pack-objects --stdin with same pa=
ckfile excluded and includ
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
+	{
+		basename shared/.git/objects/pack/pack-*.pack &&
+		basename member/.git/objects/pack/pack-*.pack
+	} >packfiles &&
+
+	{
+		packed_objects shared/.git/objects/pack/pack-*.idx &&
+		packed_objects member/.git/objects/pack/pack-*.idx
+	} | sort >expected-objects &&
+
+	git -C member pack-objects --stdin-packs generated-pack <packfiles &&
+	packed_objects member/generated-pack-*.idx >actual-objects &&
+	test_cmp expected-objects actual-objects
+'
+
 test_done
--=20
2.40.0


--NJrSwRn2oTcJLaR6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35JAACgkQVbJhu7ck
PpQSyw//c6ued/MJ9IiS0JacOkzZNzzk8pyG4brFfnXASxnlmv04i0c7KlZlcrUE
6fN2+GGCq4IlGF1jC6ahO4+fnM/NNNiavOsDlAEthaGsNzPDtSW6YVBSPoOVaf9/
u1wu42n+YLgib9zeP/dXLsbySWHfNWwIcsQRK5Vz0PrAPazxCy7cz75RltQ/MPkw
MINbAIPS3UfiF03yRMuo5rFMvjj6g43zCASd0JHZ6d8ds9MlXPZP8/od2xvCX0Ry
MPmHPcZRDt8jKRzLCkGfxLCNoYPvnIB0wtS3v+AvzXhthrMfG6XmboUVgS7Ld8zF
eRbJwpx3x7hh9sH3IsblaYptRJ/JVxmitZulLBUn6u45aoSHPrAs3AAzE6RTegwY
FtNaNfNnsAlKQhXVMxJyYRHmJCicq+zQQC9bM/JtsQHckwmjW5XyFwdIKvU3U5u7
vYop8mwxlscOhoUQUSJJs1Ha9Vbeo7SEep+MDpcF+lLfx7Jovd227+PS/nL3VhOH
QztYheN9JJm+rBJRnkIK+IRTERxEOiuO1FIl01PqRfE8dYs0N8QJbxWnFuv2zQds
t/BermERP+G8VBmEWqVQAhHK/lMrdoMZcE0iwPo4T1ufp4j8dcrHzXl/MbVWjNae
KWCYPlzALWRTfh1DaopVWgZn32znOUv19t6S3hqQsesrQku59b8=
=FWwJ
-----END PGP SIGNATURE-----

--NJrSwRn2oTcJLaR6--
