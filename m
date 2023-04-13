Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 759B5C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 11:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbjDMLQj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 07:16:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231207AbjDMLQZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 07:16:25 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C7B39EE1
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 04:16:19 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 93D265C00F7;
        Thu, 13 Apr 2023 07:16:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Thu, 13 Apr 2023 07:16:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1681384578; x=1681470978; bh=j9
        ybEYk24bL/jiuMo1i6Zntu7VgoT8tZFMME5+blZ2E=; b=RwWfUuB6oEPIlNKzqN
        YsgcalYsZTuWx4hiClzdevFM3UAfqvOfCWArvzcSc90E5GMCmAWEr2zBZ8ro2Mkw
        gRGtf6GL1D1ski0ZRHnCs7O8I99f4iv6gEBTLlIS/Jk6Ipk7XYTy+G2W1DEsLf9J
        sXkOTFAMR4RqYN08fiPcPcrMw0p3D7DwGVDrILf1kOrynZL8WmRmCJyw6Rw1YYHH
        qlq9UrtaeAlN0I71XXcqeUJOEkwPufG1KydHCF/NqHcfro30GdxYtxiPAp69kjUp
        g/OkY0QtXcC/dwdg1ClMceGTCwYTmBSR7UomWTYt4ogpnDvkLT2YP1Uk/E2tzZPF
        hvKw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; t=1681384578; x=1681470978; bh=j9ybEYk24bL/j
        iuMo1i6Zntu7VgoT8tZFMME5+blZ2E=; b=QDeYgv8W293Dg/G3PdqySdYBm3IkJ
        aGZqQKa6kEFc9OIptruzFHcZSMa+vp1+zA2MqnYXS+A6yXTc1cLqStx0gedN4Hf2
        qNyllRX/7uvu8AIQhAbP+t7Fs/mSrMKiZVfG5Nu9hPpWeWc/gBO4qLuri8wTDfUo
        EMv4E+o17tdvbl0xfoIJJ86My0p0Z3OIWXRKdT21cXHMWydfD97m5SeQl5PnVzH9
        IgFMzU1aLiJGLgEbo2PxvTs1lUeNkA0HKPYjI52fOR4K/+zM+kFP8RPdvkRiQ3Ke
        M9jeNLYsx3iHc3DotjrI60MiSpNjNvBd/9/ZgHMVbr1rW7CCJXIK8n89A==
X-ME-Sender: <xms:guQ3ZM2xs8DSjYLPWXio88AxJe-PmY_CSmrjoZG0AJA1g-9rmZpiIQ>
    <xme:guQ3ZHH-MnUTJC7di0PFefBwEwCEzyAv3PUk755NGYCKO7igg9UO7NoVRb6tAIEQu
    FJ7R1iyXDubqO-EHw>
X-ME-Received: <xmr:guQ3ZE403DxLFpf9DdeJ0RUhKjWCVu9Aqbqxzsx3ao9IZlLJhC8xWMmvvJ-QAiHJSF8lIuHSnGUMdhNRZasRzu2Dd79f3G1zFRtGuDoccdDcugk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekkedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:guQ3ZF3Fi-HPK6vMaNhkFjv8GDtMg4yAtJALqZJtgkSzwsNL-eTqHQ>
    <xmx:guQ3ZPFa1G-JIpGyI0870JxYy1dJIRy4aLgxojuHd93OXicvbSXhrg>
    <xmx:guQ3ZO_aMbwZMprBpoI7b0X3qiC1wqHu71L3dHoIPujSMXavdvhQLQ>
    <xmx:guQ3ZER1e9_QG2haOqJc1FmwIhenTcSQ5k7qvKboqDzBXcXtpk1hAQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Apr 2023 07:16:17 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 0ac6559f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 13 Apr 2023 11:15:54 +0000 (UTC)
Date:   Thu, 13 Apr 2023 13:16:15 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, peff@peff.net, dstolee@microsoft.com
Subject: [PATCH v3 03/10] repack: fix generating multi-pack-index with only
 non-local packs
Message-ID: <8c3193268fd5938ebf85bd43a551d0c50d2e8336.1681384405.git.ps@pks.im>
References: <a07ed50feeec4bfc3e9736bf493b9876896bcdd2.1680606445.git.ps@pks.im>
 <cover.1681384405.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="fdOK4MtmPzDQ/X1i"
Content-Disposition: inline
In-Reply-To: <cover.1681384405.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--fdOK4MtmPzDQ/X1i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When writing the multi-pack-index with geometric repacking we will add
all packfiles to the index that are part of the geometric sequence. This
can potentially also include packfiles borrowed from an alternate object
directory. But given that a multi-pack-index can only ever include packs
that are part of the main object database this does not make much sense
whatsoever.

In the edge case where all packfiles are contained in the alternate
object database and the local repository has none itself this bug can
cause us to invoke git-multi-pack-index(1) with only non-local packfiles
that it ultimately cannot find. This causes it to return an error and
thus causes the geometric repack to fail.

Fix the code to skip non-local packfiles.

Co-authored-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/repack.c            | 11 +++++++++++
 t/t7703-repack-geometric.sh | 23 +++++++++++++++++++++++
 2 files changed, 34 insertions(+)

diff --git a/builtin/repack.c b/builtin/repack.c
index 687419776d..80fc860613 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -572,6 +572,17 @@ static void midx_included_packs(struct string_list *in=
clude,
 		for (i =3D geometry->split; i < geometry->pack_nr; i++) {
 			struct packed_git *p =3D geometry->pack[i];
=20
+			/*
+			 * The multi-pack index never refers to packfiles part
+			 * of an alternate object database, so we skip these.
+			 * While git-multi-pack-index(1) would silently ignore
+			 * them anyway, this allows us to skip executing the
+			 * command completely when we have only non-local
+			 * packfiles.
+			 */
+			if (!p->pack_local)
+				continue;
+
 			strbuf_addstr(&buf, pack_basename(p));
 			strbuf_strip_suffix(&buf, ".pack");
 			strbuf_addstr(&buf, ".idx");
diff --git a/t/t7703-repack-geometric.sh b/t/t7703-repack-geometric.sh
index d6db362541..7027676977 100755
--- a/t/t7703-repack-geometric.sh
+++ b/t/t7703-repack-geometric.sh
@@ -313,4 +313,27 @@ test_expect_success '--geometric --write-midx with pac=
kfiles in main and alterna
 	test_cmp expect actual
 '
=20
+test_expect_success '--geometric --with-midx with no local objects' '
+	test_when_finished "rm -fr shared member" &&
+
+	# Create a repository with a single packfile that acts as alternate
+	# object database.
+	git init shared &&
+	test_commit -C shared "shared-objects" &&
+	git -C shared repack -ad &&
+
+	# Create a second repository linked to the first one and perform a
+	# geometric repack on it.
+	git clone --shared shared member &&
+	git -C member repack --geometric 2 --write-midx 2>err &&
+	test_must_be_empty err &&
+
+	# Assert that we wrote neither a new packfile nor a multi-pack-index.
+	# We should not have a packfile because the single packfile in the
+	# alternate object database does not invalidate the geometric sequence.
+	# And we should not have a multi-pack-index because these only index
+	# local packfiles, and there are none.
+	test_dir_is_empty member/$packdir
+'
+
 test_done
--=20
2.40.0


--fdOK4MtmPzDQ/X1i
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmQ35H4ACgkQVbJhu7ck
PpSmfQ/+MNbopBEXTeSuhsVPdz6h/WEUkBKdV+rUeoaAdtwPXMumLtFf7VJTSY39
P9HAnaap9Y5v8rasJ83tEOn+yfKIctMLEc+/i1dmeW6Yj4QO5v4SdQwfsGXJYY/d
v5CsQzTjuuAB9JNEIk5pXhxYyklkHoYDntCu6QCeo2+B2A2LwDS3OZ4fpMibNMjO
0t1VjBLc2GR5zGFr+lE2NG4szG7GXoHo+XO/yHZt/yWTcE985lCFGE07Rln6pwUH
Y77sYbdwiMVDToiHyNYKDAc5eIEwhdULh4yWm5x05Sr+bQvSgX1fx5Lv90U3FT0O
uo7SFWqYZ6FiIJHCrlNsnK/tXkSBKkOOgPV+Hli4+rlXTvIWkVtAbEo2u1hNZYEN
oqFF0qEN66icjPSbLzoVngh44S/FOQBuz1YsBU64ZxLyYX0nPigmbj+gO/2jvsnO
MFseke4EOdqycrC8EvchLq+OtsKZ0cN/9EYDFrGrNHGZojFKlckal1+p6jX1V9JA
D3TxnDyod7PBpH0lYKEQmKWYpBjzQMZrUXCCgJRWSmLicguYELts/waco3R0lQ4R
Dk5x7oiy3KF+iFi5618YvOc7soEXmtKZHTnNCH6TRQxrCrxcEYC2qOi/hIUWfBpU
DjwLXyxCV+FdK0IpjQcbBV3ZzIBrCqTG43bHV8Rz0krk8tjM0RM=
=WAlE
-----END PGP SIGNATURE-----

--fdOK4MtmPzDQ/X1i--
