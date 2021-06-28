Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BB2FC49EAF
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34BE561C29
	for <git@archiver.kernel.org>; Mon, 28 Jun 2021 05:33:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232119AbhF1Ffm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Jun 2021 01:35:42 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:52853 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232108AbhF1Ffk (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 28 Jun 2021 01:35:40 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id DB8D95C00BC;
        Mon, 28 Jun 2021 01:33:14 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 28 Jun 2021 01:33:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm1; bh=zn+uMerVuuQkXaCrcow4DAa4iIC
        o/FcB46h+SWFoLrY=; b=C8c29wBPycCR+zBJSkR7YSFRoAu8SZwS7XF6mEKEuMk
        egJoZ1y7pm699ps2NsQdCMMAgopUh8TLCwOKB0V/6DUVWDwdnfo0wZ6imZM75Z3S
        9mHyc1J2+ih1F5+d1YFFYI+rH2wz4oKvASopalbvlRe6vlgjjgFs3Dezp/1iYDJI
        8GhWtN6pcriFFzyH3p1lJpPNQJAfhCbm1dmHJCyM+ea9uXhMHk0FyLzFxQz+6Awl
        fwUxx6PkCZ4Mz6TSUww+PTJwmItrteg7gYg74DtVOzw0VMPsAMfbzQU9QeY93Qml
        fw9tGn/wYEKFi2PSS9+tbQk5oClxj4wlbe/BPA2Ghpg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=zn+uMe
        rVuuQkXaCrcow4DAa4iICo/FcB46h+SWFoLrY=; b=gq5XZpz5MHAlJt+3lMPMQD
        VrNmOpSj839jwhVkXZyEgAsWSrMrdrBJ5Nq+JBn9cNrCjAF83gbVtEd/whzRMCe7
        xPYnGjUAiMrNrm79Sv1c9++QMgQYcwxv/K4DbcyCfkLUK1cbz+FRSQJkY8dK/18Q
        DFReFFahjMhvWf5+o+fwVGagg3VihOCbVhg2jLBUB8AyE/axrHfNExoymS+/9Wvv
        Vw8LaceLfVt22PzJ2E54VFyHKd33i5yhx5owyytMOf3aYGJvNJ67FFrutpB0DHgk
        D0eU9hoMxZHB+HS1qax8whe8vxoMpstOfoya4K2Am31O8AXoLF5pbpSbAgjVh/jg
        ==
X-ME-Sender: <xms:Gl_ZYIT2OtlWcWhLuME3nmKxzEL9MzdDS89YMvU3TxGhc0s4OKSlGQ>
    <xme:Gl_ZYFyqO3m4OgFllscL-cgcMJrnSiMaAR7qqOyulv-P2gbk7OLAXbJm2OV04tBrX
    2A7AkGLJSmo0w4KVw>
X-ME-Received: <xmr:Gl_ZYF2JpgV-8vQ990BmonAUW-Xwagntf1T8QKXzRK_IP_cfWJBPMMuZmXrSmZS__o4OxMMSDhCnAHhs9kJpbDQEfKQ0v7g_3PT8cjtz1k72UcRfK_Bcfp4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehfedgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:Gl_ZYMB28ZOMq0R4hFTxCABhxpffCnNWyDTGJL176kKGTteVAxVS0Q>
    <xmx:Gl_ZYBjUwyNIXIrbFcJAVWbA4veoBcJy7Dxi2DQtBrUb7_KXunykxA>
    <xmx:Gl_ZYIp69QHnBQ1q4prdeZNVArX96g-tP4JeI4YFD67CIVHQBYz1tA>
    <xmx:Gl_ZYPYrS3Xf-ZdR--mfELwyxgLJv8T8xY0VCJw7l8UgvtMHld9bBA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jun 2021 01:33:13 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id b2510573 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 28 Jun 2021 05:33:12 +0000 (UTC)
Date:   Mon, 28 Jun 2021 07:33:11 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder.dev@gmail.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] receive-pack: skip connectivity checks on delete-only
 commands
Message-ID: <b3272f499e51cfc53345f9f09f8762db1a4cf0a6.1624858240.git.ps@pks.im>
References: <cover.1624858240.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="U4nlkKMm3GAwkLQP"
Content-Disposition: inline
In-Reply-To: <cover.1624858240.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--U4nlkKMm3GAwkLQP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In the case where git-receive-pack(1) receives only commands which
delete references, then per technical specification the client MUST NOT
send a packfile. As a result, we know that no new objects have been
received, which makes it a moot point to check whether all received
objects are fully connected.

Fix this by not doing a connectivity check in case there were no pushed
objects. Given that git-rev-walk(1) with only negative references will
not do any graph walk, no performance improvements are to be expected.
Conceptionally, it is still the right thing to do though.

The following tests were executed on linux.git and back up above
expectation:

Test                                                  origin/master        =
   HEAD
---------------------------------------------------------------------------=
------------------------------
5400.4: empty receive-pack updated:new                178.36(428.22+164.36)=
   177.62(421.33+164.48) -0.4%
5400.7: clone receive-pack updated:new                0.10(0.08+0.02)      =
   0.10(0.08+0.02) +0.0%
5400.9: clone receive-pack updated:main               0.10(0.08+0.02)      =
   0.11(0.08+0.02) +10.0%
5400.11: clone receive-pack main~10:main              0.15(0.11+0.04)      =
   0.15(0.10+0.05) +0.0%
5400.13: clone receive-pack :main                     0.01(0.00+0.01)      =
   0.01(0.01+0.00) +0.0%
5400.16: clone_bitmap receive-pack updated:new        0.10(0.07+0.02)      =
   0.09(0.06+0.02) -10.0%
5400.18: clone_bitmap receive-pack updated:main       0.10(0.07+0.02)      =
   0.10(0.08+0.02) +0.0%
5400.20: clone_bitmap receive-pack main~10:main       0.15(0.11+0.03)      =
   0.15(0.12+0.03) +0.0%
5400.22: clone_bitmap receive-pack :main              0.02(0.01+0.01)      =
   0.01(0.00+0.00) -50.0%
5400.25: extrarefs receive-pack updated:new           32.34(20.72+11.86)   =
   32.56(20.82+11.95) +0.7%
5400.27: extrarefs receive-pack updated:main          32.42(21.02+11.61)   =
   32.52(20.64+12.10) +0.3%
5400.29: extrarefs receive-pack main~10:main          32.53(20.74+12.01)   =
   32.39(20.63+11.97) -0.4%
5400.31: extrarefs receive-pack :main                 7.13(3.53+3.59)      =
   7.15(3.80+3.34) +0.3%
5400.34: extrarefs_bitmap receive-pack updated:new    32.55(20.72+12.04)   =
   32.65(20.68+12.18) +0.3%
5400.36: extrarefs_bitmap receive-pack updated:main   32.50(20.90+11.86)   =
   32.67(20.93+11.94) +0.5%
5400.38: extrarefs_bitmap receive-pack main~10:main   32.43(20.88+11.75)   =
   32.35(20.68+11.89) -0.2%
5400.40: extrarefs_bitmap receive-pack :main          7.21(3.58+3.63)      =
   7.18(3.61+3.57) -0.4%

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/receive-pack.c | 49 ++++++++++++++++++++++++++----------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
index a34742513a..b9263cec15 100644
--- a/builtin/receive-pack.c
+++ b/builtin/receive-pack.c
@@ -1918,11 +1918,8 @@ static void execute_commands(struct command *command=
s,
 			     struct shallow_info *si,
 			     const struct string_list *push_options)
 {
-	struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
 	struct command *cmd;
 	struct iterate_data data;
-	struct async muxer;
-	int err_fd =3D 0;
 	int run_proc_receive =3D 0;
=20
 	if (unpacker_error) {
@@ -1931,25 +1928,39 @@ static void execute_commands(struct command *comman=
ds,
 		return;
 	}
=20
-	if (use_sideband) {
-		memset(&muxer, 0, sizeof(muxer));
-		muxer.proc =3D copy_to_sideband;
-		muxer.in =3D -1;
-		if (!start_async(&muxer))
-			err_fd =3D muxer.in;
-		/* ...else, continue without relaying sideband */
-	}
-
 	data.cmds =3D commands;
 	data.si =3D si;
-	opt.err_fd =3D err_fd;
-	opt.progress =3D err_fd && !quiet;
-	opt.env =3D tmp_objdir_env(tmp_objdir);
-	if (check_connected(iterate_receive_command_list, &data, &opt))
-		set_connectivity_errors(commands, si);
=20
-	if (use_sideband)
-		finish_async(&muxer);
+	/*
+	 * If received commands only consist of deletions, then the client MUST
+	 * NOT send a packfile because there cannot be any new objects in the
+	 * first place. As a result, we do not set up a quarantine environment
+	 * because we know no new objects will be received. And that in turn
+	 * means that we can skip connectivity checks here.
+	 */
+	if (tmp_objdir) {
+		struct check_connected_options opt =3D CHECK_CONNECTED_INIT;
+		struct async muxer;
+		int err_fd =3D 0;
+
+		if (use_sideband) {
+			memset(&muxer, 0, sizeof(muxer));
+			muxer.proc =3D copy_to_sideband;
+			muxer.in =3D -1;
+			if (!start_async(&muxer))
+				err_fd =3D muxer.in;
+			/* ...else, continue without relaying sideband */
+		}
+
+		opt.err_fd =3D err_fd;
+		opt.progress =3D err_fd && !quiet;
+		opt.env =3D tmp_objdir_env(tmp_objdir);
+		if (check_connected(iterate_receive_command_list, &data, &opt))
+			set_connectivity_errors(commands, si);
+
+		if (use_sideband)
+			finish_async(&muxer);
+	}
=20
 	reject_updates_to_hidden(commands);
=20
--=20
2.32.0


--U4nlkKMm3GAwkLQP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmDZXxYACgkQVbJhu7ck
PpRTMw//ZX4vPc2kWq3HRzpoiLV8nXizmXjgWueKsSkJnXyx4UgsoirLtsPsjFZH
/n1If8zLzIBG2eFw8DcLBGrUj6YlCzbW3c+iyvYISzOT+i8oTEA/a3mh6unHbruv
vvo3kaTU2LAHQw4JruGeiyMzz/PDlRctfjTOpmhGo/cw7kAERanJKwVfeKTJaj5r
xm+ZTL8+djOjfbUwcC+lWzN7hQQBBTcDDs6j5VvfZB8q4WH8SVBiMEAgjZzMiabg
/9w0UpNlnNeHccTjSn/RHbv4urQdaqTp6HpEWwW3ljIZeL2P4jlcEnHN0UieN/xx
buL6bdJlM900cRtxB+9sHAZYjW2YH2IVq40pDe2Sdid6eX1Y0zJI5eDmOmSjEQfo
z5g/tudPRXZHG7zF4Qk+YuembvwzEKSwtavlKIZ25bhB9rzk/ja/r540uZn7JWFp
faqWdpKz/CbBRvt/g+3M1+UkBjcU4beNrcfxTFf/Is5SJqnEer0BBMeSlLAlFyZ6
/ia2rSaqNOxRyxmPq8nGvfBZBFlpaLFwSy+CXVOtsP2B76JC4Ds1djwod5soT6oZ
ZfXP2RHB1aM8MQX9OkGt2MAghVbZCbPYEg5TOzWiwaP2BbKHuinqy7eQcSmM7ui7
OCU3uJ2m3vfiTn7ZB78Gvfvty0dSKqWUF+gJZ9jXmpacs5P+Hbo=
=eUSR
-----END PGP SIGNATURE-----

--U4nlkKMm3GAwkLQP--
