Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3FE8C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7D576135A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbhESTPK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:15:10 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:51613 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230298AbhESTPJ (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:15:09 -0400
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 43A925C018D
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:49 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 19 May 2021 15:13:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=oohEfvtXETt+4nTgvdIMbiItD4RoxGuP+HUtYoAI
        Sxc=; b=NDMgJSfhTDsfmAHJW1Hps/CFoyCxn/baf5X8FSr/Q1WdKcCayUebfIKX
        J5woE3qbL+fSz0UgTvWYMhmWct046HOIyYLqELbcPE7moh/RU/Hq/WNTzFsIk0GD
        S71DSFzG8Hfdpcc0P9d/HDGcMZ5DkUAKGQEUaq82reZvKV6BAYk8l5cF6s46K0fQ
        0Y9oEFoaKd7CgLpkLB7jM6oyMAUz+nDzPlQ7rVvcGwexuaYZL45M/A5rlUnTJtHA
        M9uLbXcnNYUTLUtL1Nf2l901k8XDUqjPhrvpVkPtnyR7RustZk0k8dS0N2lcHRe8
        IrQ+IHS84TpjAQVWQkbl81oNT+wXcQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=oohEfv
        tXETt+4nTgvdIMbiItD4RoxGuP+HUtYoAISxc=; b=h7muzR8oBZoiLUh8bKc9yO
        BmrP+BcqwYxl2S6EB00mpGapNpuSxSL483j/+Ngv5tfc/hdzLWNWvAi+75C8E5IA
        GIJfi9X3dagCv60V5xGialUyKgLQghwI8MFNAge9jG4+a/0gA+TmomyLgFm0BYF2
        QQhoPTd+8LaJD2I22stzIMkOf6vEpQilyoV1uwgyK/pjYcrgU0Kd93jx85CfUmsZ
        hKHF1hLirjC6mI59K5jKGT4pPexOoXmwMgHMY/hAjDll6enwM/guyM/mklnSZlN5
        lQb5ghv90dHwhulIztUU0B5gimZ3WruEltWtLUEuIjJMH7n5FUtizXlBNpbLl9kg
        ==
X-ME-Sender: <xms:bWOlYFEssU0QYVbTA7tfZUQlyz7tLp-dMzpg9E7lBA7okiTP7JvmZA>
    <xme:bWOlYKXA4qLVkj9OhtPHza4wnprSK6U2I4ooVvgVuv-v0Yvwyzl4feB8NVkw-DJMa
    O98vzIx1WLj1Fcjrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:bWOlYHKcHLnC8Uemz9_PKzAWKsYZfm8G4mg5EVOnzeaO491wEDwBjQ>
    <xmx:bWOlYLF0uN9plNjVezYzUAxX7RIoWg2M8wNakXLLRdcSYSdQ6BQCEw>
    <xmx:bWOlYLV50EecUsxfNHAqKC_rJ7eA5m_0FJ_ksMFovspgwdJ-ZpkYlA>
    <xmx:bWOlYDhwYlFCmP_r49mbvPn3lrYlvCtqt_uWDks9J93Up3sY3ZoSuw>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:48 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9bd5f0ea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:48 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:47 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 7/8] receive-pack: skip connectivity checks on delete-only
 commands
Message-ID: <68c60aff0c77c562aba5613ccbb9ab33ad8e0e08.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5TQG8HV8k0CeH0O0"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--5TQG8HV8k0CeH0O0
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

Test                                     v2.32.0-rc0             HEAD
---------------------------------------------------------------------------=
-----------------
5400.3: receive-pack clone create        1.27(1.11+0.16)         1.26(1.12+=
0.14) -0.8%
5400.5: receive-pack clone update        1.27(1.13+0.13)         1.27(1.11+=
0.16) +0.0%
5400.7: receive-pack clone reset         0.13(0.11+0.02)         0.14(0.11+=
0.02) +7.7%
5400.9: receive-pack clone delete        0.02(0.01+0.01)         0.02(0.00+=
0.01) +0.0%
5400.11: receive-pack extrarefs create   33.01(18.80+14.43)      32.63(18.5=
2+14.24) -1.2%
5400.13: receive-pack extrarefs update   33.13(18.85+14.50)      32.82(18.8=
5+14.29) -0.9%
5400.15: receive-pack extrarefs reset    32.90(18.82+14.32)      32.70(18.7=
6+14.20) -0.6%
5400.17: receive-pack extrarefs delete   9.13(4.35+4.77)         8.99(4.28+=
4.70) -1.5%
5400.19: receive-pack empty create       223.35(640.63+127.74)   226.96(655=
=2E16+131.93) +1.6%

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
2.31.1


--5TQG8HV8k0CeH0O0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY2oACgkQVbJhu7ck
PpRVgg/7BgTv8AmE4jzkUuP6Jnph1U8RrxOhDEuEQAGY5kow2emFMVjcS2ORfUiZ
JyOMXdjlpd8wdcS/ZBpUJtAWYL7LGsjPBLJGv3sJnNyZaioGfJtc/F+eUXW8o5tZ
EP/XK17A3bJfY/9qv+41hmkqZxFXg1M3CuazFLf7eWuPI/P0eDPlVfRnR3WtAPF3
tamtvlELQoRnRTrLprAjdRVhxSrq4TnX07jodOd9JvSE2DnnO+sJ6bdri0rbkHJP
wQMSKbWhZZp3asGXYVYVLfvmNLjFHkO/5PYHcjjZn8CsofogTlyfdFL2VBlbLCxn
B9I3ZmK70rXe+3ev6ffxJOGrYMUKh5cgAsAzSG+4BXliL/rGVHe/r0kkxk94IW49
NiOuqux64A0LxcpXtiEqh2xfmGSFFOdSI+i2iaLWT+ltRDObWP/4wjv4hWxQT1xB
bcklnosnZ2LxEWPhvVkhaFQ4bfsSlIleQLFcy0eiIpKvOK7oEDYCXcxztBjIyJNE
fsmmYAL2+3Tj1VUEPQMeoXUreI30HI8LIDyMugBXmOlZ54xN8MwVM18yR1IRlAWM
V3q7KtqlhaMbrVNarqA1sa2YupLJSh4szXdmLlPySIBKXjqAn+BrH4KW8mgR0poa
fuqnUeR17/yG7XFbW2TAkebJcTcH3dW5kkLhi/jMy57fZQfOL+c=
=X3wk
-----END PGP SIGNATURE-----

--5TQG8HV8k0CeH0O0--
