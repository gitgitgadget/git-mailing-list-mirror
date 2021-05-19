Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9D7C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CEF76108D
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231880AbhESTPP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:15:15 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:60011 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231972AbhESTPO (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:15:14 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 0625D5C0040
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 19 May 2021 15:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=QIdEtu1foRS4unYtCGZyYi595Z5wNCOF3DHhYN5j
        2MM=; b=h9fNqZX8G16GSh9bx6tPPMhp7y30VPG2+qlLszc/xgI6wUOgp2iqBXlV
        plGWJb6lRSoRWfPvKVGoapwdbHut34Qq+MR1khkWxebkiYFCkf5JxstkSpom2Zuu
        Lq5KkST+yEAzBIuEveyzGfkrcxO63lKSbxIuFHKPSrbTqEkBqIutRtTl64H87Ber
        Dae4B7Fkxjn8p77Xi5+vocsyy1tazX1AdMtG3O+jSGwUvNnl1wetfuTQDyIVBTuA
        QzhedBNRLlpTI9dq/f91G87/sbAUhqTllepvtcrzgpOl/OhiKgh+FKg/iW6AKsVv
        XpScVYoIjX93j+Sl5lI90P/5fMJltw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=QIdEtu
        1foRS4unYtCGZyYi595Z5wNCOF3DHhYN5j2MM=; b=cHEiQrVZUKtyp4WiIEGwFP
        Fa5Z9DtZc8vjNHNZKnfHUswcDjm3+48ZoxL/ZcvjgbZDD/igWNJhV6kjhF4vrIH3
        xFN0SLcVLyhKyyb7XhLV4M8UGdHwFkK4XvLFgJHVmx+Diym63fnOEUFODMz8NTCB
        6bRIwpUx/EmOdpzooIE6M9s2M9OzDIs40idmAV6/MfmlzKftR3/dUSwQIZw/JKKy
        e7bfrrtVY08bL8AN+z31iedeOz2TfifxnBlVqNBIOtD8yW8vxaXkock0RJ/xoFfW
        cQXKdSpwVFDLCjZGx80ggOlKdycCsDfM1sDSamVN96Kps4hPWwTjtntaCfhwgXLw
        ==
X-ME-Sender: <xms:cWOlYOmwEAUfYBWzLWtAfOleXUmBR_WceZQfgDAsfHWA4BN23Gs0Cw>
    <xme:cWOlYF3FzpO_geBG1tmPEp_Vdrc48MOVz_LlBLMlRyvP7jJtNdH9TjiGx1Lsovfgw
    hbft8ofWapRbpupEA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:cWOlYMrud0P19GqxgMWPsh-EEH16ul77TY8a6OrgOMCTyy-f61_ljQ>
    <xmx:cWOlYCmUtQ2DNiuiAEwd2eJ1s2yKDj8vQVbu5NkUJUIyiliEiiYhbw>
    <xmx:cWOlYM2vfFkrjSmtN9C0aYqQcZoUgKkx7j8-ZM0OP2XtaPdr0D0NvA>
    <xmx:cmOlYNDvBNp9E2jDA9oB-L1B_vwL77Zg8kQ2afD-Z2P7miNzMr9Azw>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:53 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6f06a1a9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:52 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:51 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 8/8] receive-pack: check connectivity via quarantined objects
Message-ID: <010974639c66c8f15d4dc9e4feb69eed92b52d13.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5Gbh1w4v2kMXnESY"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5Gbh1w4v2kMXnESY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert git-receive-pack(1) to use the new connectivity check which
uses the quarantine directory to enumerate new objects instead of using
references. This change significantly decreases the time required to
accept reference updates due to the fact that we don't need to do a
graph walk anymore. The following measurements have been executed on
linux.git:

Test                                     v2.32.0-rc0             HEAD
---------------------------------------------------------------------------=
-----------------
5400.3: receive-pack clone create        1.27(1.11+0.16)         0.02(0.01+=
0.01) -98.4%
5400.5: receive-pack clone update        1.27(1.13+0.13)         0.02(0.02+=
0.00) -98.4%
5400.7: receive-pack clone reset         0.13(0.11+0.02)         0.02(0.01+=
0.01) -84.6%
5400.9: receive-pack clone delete        0.02(0.01+0.01)         0.03(0.02+=
0.01) +50.0%
5400.11: receive-pack extrarefs create   33.01(18.80+14.43)      9.00(4.30+=
4.65) -72.7%
5400.13: receive-pack extrarefs update   33.13(18.85+14.50)      9.01(4.28+=
4.67) -72.8%
5400.15: receive-pack extrarefs reset    32.90(18.82+14.32)      9.04(4.26+=
4.77) -72.5%
5400.17: receive-pack extrarefs delete   9.13(4.35+4.77)         8.94(4.29+=
4.64) -2.1%
5400.19: receive-pack empty create       223.35(640.63+127.74)   227.55(651=
=2E75+130.94) +1.9%

Interestingly enough, the normal "clone" repository shows a more extreme
improvement compared to the "extrarefs" repository, which has one
reference per commit. While I haven't yet dived into the root cause, I
expect that there is another location besides the connectivity check
which does scale with the number of references.

Notably, the connectivity check when pushing into an empty repository
shows comparable performance with the previous implementation. This is
because in both cases we're actually performing a complete graph walk to
determine whether there are any unreachable commits.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index b9263cec15..23087acad0 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1937,8 +1937,12 @@ static void execute_commands(struct command *command=
s,
 	 * first place. As a result, we do not set up a quarantine environment
 	 * because we know no new objects will be received. And that in turn
 	 * means that we can skip connectivity checks here.
+	 *
+	 * Using the quarantine directory to determine connectivity may not
+	 * work with shallow clones, so let's let's play it safe for now and
+	 * fall back to the old connectivity check.
 	 */
-	if (tmp_objdir) {
+	if (tmp_objdir && (si->nr_ours || si->nr_theirs)) {
 		struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
 		struct async muxer;
 		int err_fd =3D 0;
@@ -1960,6 +1964,10 @@ static void execute_commands(struct command *command=
s,
=20
 		if (use_sideband)
 			finish_async(&muxer);
+	} else if (tmp_objdir) {
+		if (check_connected_quarantine(the_repository, tmp_objdir,
+					       iterate_receive_command_list, &data))
+			set_connectivity_errors(commands, si);
 	}
=20
 	reject_updates_to_hidden(commands);
--=20
2.31.1


--5Gbh1w4v2kMXnESY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY24ACgkQVbJhu7ck
PpQeQg/+JZUDufWX95yqzXi/hQSQTH9SdmQ+6Sm5MuvCOfXafk+D4Vpk2t7yKQVW
t8n5PcKJxApI7MLpdyD8sqBU16yHITi1enl28Hd8ewQwMvUz+3Qd1Ic02fudIfBL
7aLP+o1PMA/xhsbEdagpIJv9fHpTl25t77MyDB7oFBSyPUn1uVL0GD87bzkCGbjX
DKHNF8K9ubi14UdFIWaNN5Ww/2N+oUyjdq+Uzr1hvM01l3pJ5ZtO55VE71HlNR07
8HDMW7FoAKk4WEbKKUkQmUfCR8tOPdIvXSgonDmGx3fCm+oRDgMNyXC5K0G7ILC1
GoWH0Krgut4NCbUmo+Z8oV0j99U5olqEFT3DKCwFYLIyCzfEhVTxDBTorUbnA1jf
hTY9UVXXjTcat9b3r5b/9KbuVUgwNoHdPkvMIHEEmJzJeWqWJmrGDfA13cQx5X6E
VL3S5DudcAQRfAbcjgBTgTQQJ8W/RGlQP3LOD+SzaQOc/GwFVb9hURJdjzCuWxr8
pSA3P5GXQ83dlcHEl/IZCLOkPomTNaYZSRoloVtXfA4ChaXdeH2DwYW4WjKsYA46
xMCEBwcwG4uzueeQwbQ6AA3GrIovDOrDDJg6mF830wcJjVNSlvqd3tDKiVSx2vjq
dnRNi2HQDgrfuX2bAwgVYQijYEJfX64fZMzkoO01Ugp/RtIKSPs=
=kw3B
-----END PGP SIGNATURE-----

--5Gbh1w4v2kMXnESY--
