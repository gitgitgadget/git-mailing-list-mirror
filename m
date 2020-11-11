Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5D2C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0649220786
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 07:05:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="q1wJ2mPT";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QcbQ0/Ra"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726081AbgKKHF2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 02:05:28 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46821 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725882AbgKKHF1 (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 11 Nov 2020 02:05:27 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E23E45C045A;
        Wed, 11 Nov 2020 02:05:25 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 11 Nov 2020 02:05:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=XQaJqllg7GbEBkjmzHN8KpWDXvZ
        QR2acQ3P2XHjgIm8=; b=q1wJ2mPTrSKAqhzg9Xj1h8wwMBN8hh8JgQqEn0/Kf/T
        aMv1z8IOkM3/FS/LLpBBigMl5C/5bA2OcDwhlW4m4+rlhgDLtQgV2dvjh60zRnTT
        Tj9mxUjYxmy5DT1ln9ifGtHp1uHZYpN2UmHr/cose9iCuxcvTeOVRofmG8+XXL5I
        2PV3RiCK/mRaF+Bjaaww+True3VeAyJfYu3ZwxTODk9a1zwwnBFHV9dK98LQn8Gm
        i0RbnD522xMHKQI/7jHdXb0JxRg6KRCn6OX9smceAsDkwPjN4TksDynE2REnqZS4
        93635O6ofKQ8dCKI1J8OUz3m4r3ost8Ou0G7i5KikXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=XQaJql
        lg7GbEBkjmzHN8KpWDXvZQR2acQ3P2XHjgIm8=; b=QcbQ0/Ra09n8tK6TA0wkBV
        fGKA9acOW7ne984xYa+8J9dYKGdGQkfbBTCfvClgq7us+7P71X0w8wlBc5bdfPrS
        Cnf3XFcd/y63RVRC24tz317fuMWg4Xd9opfNKDETUDJ1VfaeN8JH2MCPTgBhzlxf
        9SIoCzYMWB1UzPa2EFP5TtgrscormsGCJh06qCssbIqtyW5Cea5JScBA4m4MJ/Cl
        zOOWt0pPDwKfqLQQJhBG0rWMmK9ZS7Okn7dEWwkfqKuW+2HIduH0HFsE1vwPthBd
        OhN4SQTpPlV8gncwsmY+hS1qHHu0oBQth37AJa7AQmClaicS2viqXOzd8qkpDPlA
        ==
X-ME-Sender: <xms:NY2rX31lWLkb1ndk-E_LF5tpwd2OJYWIGwiSCvfdsdRN4bZJUNWGZQ>
    <xme:NY2rX2GgA5Oggp-Q0ZroCZCaeco56WCJlNj08x6bClyp43JfugqNSF5GqUzakZ-Lk
    al-jbM-8iYk_TtLtg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudduledgkeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecukfhppeekledrudegrdeivddrkeeknecuvehl
    uhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrd
    himh
X-ME-Proxy: <xmx:NY2rX37HbslqSwkCUvM9RoJuXlvRvxmQg95iTLZ7vPxPhovmzv_uCg>
    <xmx:NY2rX82Qcbw6ApURZ07cfbaso08PSLKOTQ7MLMHDYsrZnJStUd6Q6g>
    <xmx:NY2rX6GZssPD0AfnExk6u8S7izgVzcqQpCqaHCMfvCIDhgY91mwbwQ>
    <xmx:NY2rX1MWsgSCKuzJ_YsOPD3s7CGIjYz9eVK69X1TtmzbIVmr_qBmSw>
Received: from vm-mail.pks.im (dynamic-089-014-062-088.89.14.pool.telefonica.de [89.14.62.88])
        by mail.messagingengine.com (Postfix) with ESMTPA id 364803280059;
        Wed, 11 Nov 2020 02:05:25 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 11636625 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 11 Nov 2020 06:58:43 +0000 (UTC)
Date:   Wed, 11 Nov 2020 07:58:43 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com
Subject: [PATCH v3 2/4] update-ref: allow creation of multiple transactions
Message-ID: <f19917483362569de132c9d81070f2c3e8e365b3.1605077740.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605077740.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mjfVsAhgqZ9CUFps"
Content-Disposition: inline
In-Reply-To: <cover.1605077740.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--mjfVsAhgqZ9CUFps
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While git-update-ref has recently grown commands which allow interactive
control of transactions in e48cf33b61 (update-ref: implement interactive
transaction handling, 2020-04-02), it is not yet possible to create
multiple transactions in a single session. To do so, one currently still
needs to invoke the executable multiple times.

This commit addresses this shortcoming by allowing the "start" command
to create a new transaction if the current transaction has already been
either committed or aborted.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt |  3 +-
 builtin/update-ref.c             | 13 ++++++++-
 t/t1400-update-ref.sh            | 50 ++++++++++++++++++++++++++++++++
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index d401234b03..48b6683071 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -125,7 +125,8 @@ option::
 start::
 	Start a transaction. In contrast to a non-transactional session, a
 	transaction will automatically abort if the session ends without an
-	explicit commit.
+	explicit commit. This command may create a new empty transaction when
+	the current one has been committed or aborted already.
=20
 prepare::
 	Prepare to commit the transaction. This will create lock files for all
diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 8a2df4459c..bb65129012 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -446,7 +446,18 @@ static void update_refs_stdin(void)
 			state =3D cmd->state;
 			break;
 		case UPDATE_REFS_CLOSED:
-			die("transaction is closed");
+			if (cmd->state !=3D UPDATE_REFS_STARTED)
+				die("transaction is closed");
+
+			/*
+			 * Open a new transaction if we're currently closed and
+			 * get a "start".
+			 */
+			state =3D cmd->state;
+			transaction =3D ref_transaction_begin(&err);
+			if (!transaction)
+				die("%s", err.buf);
+
 			break;
 		}
=20
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index d7a57488ed..2890504edd 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1532,4 +1532,54 @@ test_expect_success 'transaction with prepare aborts=
 by default' '
 	test_must_fail git show-ref --verify -q $b
 '
=20
+test_expect_success 'transaction can commit multiple times' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/branch-1 $A
+	commit
+	start
+	create refs/heads/branch-2 $B
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_cmp expect actual &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/branch-1 >actual &&
+	test_cmp expect actual &&
+	echo "$B" >expect &&
+	git rev-parse refs/heads/branch-2 >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'transaction can create and delete' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/create-and-delete $A
+	commit
+	start
+	delete refs/heads/create-and-delete $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start commit start commit >expect &&
+	test_must_fail git show-ref --verify refs/heads/create-and-delete
+'
+
+test_expect_success 'transaction can commit after abort' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/abort $A
+	abort
+	start
+	create refs/heads/abort $A
+	commit
+	EOF
+	git update-ref --stdin <stdin >actual &&
+	printf "%s: ok\n" start abort start commit >expect &&
+	echo "$A" >expect &&
+	git rev-parse refs/heads/abort >actual &&
+	test_cmp expect actual
+'
+
 test_done
--=20
2.29.2


--mjfVsAhgqZ9CUFps
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+ri6IACgkQVbJhu7ck
PpQdJA//cFpena/n10Cxqk1MkRyo/AnI8PLffSSg7Yt24ABW7qJRg33X/mZ4BIg3
+CTz9X+UrQ2oHYGtRciisbC3bQHBh4Mqt+sQYDG4BfYicn9267EhZVmpMYTxlZPz
7tzisdNE3x9xakao6MKVOH9gXZlo04lH7QtlsVaFEYMtNH/fnNyfjv03QfU9X4rw
UDRkL48OF1gWAr9ZLrl7NRNpByamyt9jGDBuXNi0oG+TxuwcdSXF3ACi8byIBjlh
QweoHB5zY1hnjLoW8q0ZNnBZbtC2cP1BQdr85d4LjLJb2ve2DGjpF4CJ9XDMPM7J
EggpjhWDOSQ1Kq4DItkuECPiyBEOWf4QD9NA5ruVZLg/s9xO5uQLb/m1Tig4cbYK
9GlOl9Mp9bAbb890IIA7k8kUm4gYVbfaN9aut9M9assS9iAON9jaOoKASKIQ+gbS
tYHWMnFc/Kr1Kge0s2gvamnspBrAgnbTn0xQ6vQ714bpO8SqMxNG8DXUCGb6fYx8
VAVuL4DW1/SvZM25WXFPsDMkeDy1jSJ3ll3qi/iD57BCdQzaOa6xkTJ6AuZRdwII
XQnSDbFskPYmA7Ri0WKZfjkcbmkjXzDf7s7b5f9FbJBSbYW+Aw0BYXoOhkmJ2AaN
p8PYvZ0GYTzYdIBNrwRBl1jJEGa332Lj8QtJY02+Rpt2u3WKDDY=
=RW3u
-----END PGP SIGNATURE-----

--mjfVsAhgqZ9CUFps--
