Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20E74C433EF
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 09:06:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2A3F6069E
	for <git@archiver.kernel.org>; Fri,  3 Sep 2021 09:06:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348636AbhICJHo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 05:07:44 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:58509 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234912AbhICJHn (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 3 Sep 2021 05:07:43 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D5CEA5C00DD
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 05:06:43 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 03 Sep 2021 05:06:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:mime-version:content-type; s=fm1;
         bh=d10QwWDRzPPCGXOqb1X8HCe6+RLEw1RizmTheqoTHfA=; b=JK8efNKSR5X6
        R5tGUM5WrY37rVwgVQvdpvwD9OFQS9rWcEBOi/qc26uO8fJCdGnMekGAHtNVSeYs
        uZLg8uziZEm0SafKElgOS4B4AHLd2Vn9z0LJHB3DsqUl6fbeK04eAlB/oT+oqSpZ
        A+taShDztv4XyuxRQboKPO3iQi6aKFjo0zBlZp870S8bONNvwK4qYyYZZWVwyTNN
        B0SCdQYFx6E9Cbun3Sx9FKkuPBcA2M+Ck/EUkdrn4vJUFry06XGO+R3z7YTs8/EA
        WkHRsWqxQr8QtQZnSHkfAfSMgsHPuhZVOAEifJcYSoyYoRt4C7a6vuQFL5Kzfy4T
        8ge35f2MgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=d10QwWDRzPPCGXOqb1X8HCe6+RLEw
        1RizmTheqoTHfA=; b=fyPUpFC7zr4EwslhNr3VyjscN6b1zhod8U4e33J40pTvM
        1MXK3YhZpte/QMx1yFyoQ6V94pb9lIzFdiwJ382SkYIBxERIA4kSPD2JaULDNKvy
        acT/f1m93uKs8DB/RK7cz44pGuJLCmXBoxLtpFMwPiNIrFdYOQiXp+uBULYOt0gw
        szSQR7Pk6XwzMKVliqZ3Svr6Y22cBiIr65JVILIbbc0eGS1O29tmOxsL9jcEVrId
        jIRLyqaNssX50lRZ0GkmhT0jvuJ6CVfh+VNdT0rgiyfpS9GWAeGnJq8CNN7/1RSd
        GruGr/VApf+yyQ4l3mFurP1e2eNCno4cTvki1jmrw==
X-ME-Sender: <xms:o-UxYdv7LSdBSNyva8WGJ3Ys4x0s-MDt5mZheLYsjlR4EjuuDzRMTA>
    <xme:o-UxYWcatV5ljMM6GKQc_cjynZjpjKiMtx553XJvanAbTSOp59ZY18vHytBiry05I
    mPkl2Pib6E3s2mPbg>
X-ME-Received: <xmr:o-UxYQwgKanNJxNdM2_F5I2n8I9CwTu6itZPO-4kIwQ6eCo30G064NLT4a9bABpEnaxbrgdjQYRsDaPqWVpyShdbVzOl1618Xu8Il8R81kXJttRawscxhtU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvtddruddvjedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkgggtugesghdtreertd
    dtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhs
    rdhimheqnecuggftrfgrthhtvghrnhepjeeifedvueelfffgjeduffdvgefhiefgjefgvd
    dvfeduvefffeevfffhgfekieffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:o-UxYUPZQDFhk39tcIYHWM5Xrt381z_vazPjWuIQAPRY-uTC9wHaxg>
    <xmx:o-UxYd931tuHOoOpPGXTtQTHBCySNWzt7Y5rBopXhO7NeYWuScjJrw>
    <xmx:o-UxYUUAfq6R4wRur3aVhrPyMde5lIm7ckwKMs2qwbTQXWRei_GAaw>
    <xmx:o-UxYSKTZer4WInnHuLZkPpE6Rq2fFPzidZYNaCtxj2yYv0PPzBAsg>
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 3 Sep 2021 05:06:42 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 6626fb2f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Fri, 3 Sep 2021 09:06:38 +0000 (UTC)
Date:   Fri, 3 Sep 2021 11:06:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH] update-ref: fix streaming of status updates
Message-ID: <1e9e62a2c5f74db91aaded83783076c28b757836.1630659922.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="N01QCmv1SxaJo9RA"
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--N01QCmv1SxaJo9RA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When executing git-update-ref(1) with the `--stdin` flag, then the user
can queue updates and, since e48cf33b61 (update-ref: implement
interactive transaction handling, 2020-04-02), interactively drive the
transaction's state via a set of transactional verbs. This interactivity
is somewhat broken though: while the caller can use these verbs to drive
the transaction's state, the status messages which confirm that a verb
has been processed is not flushed. The caller may thus be left hanging
waiting for the acknowledgement.

Fix the bug by flushing stdout after writing the status update. Add a
test which catches this bug.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c  | 14 ++++++++++----
 t/t1400-update-ref.sh | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index 6029a80544..a84e7b47a2 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -302,6 +302,12 @@ static void parse_cmd_verify(struct ref_transaction *t=
ransaction,
 	strbuf_release(&err);
 }
=20
+static void report_ok(const char *command)
+{
+	fprintf(stdout, "%s: ok\n", command);
+	fflush(stdout);
+}
+
 static void parse_cmd_option(struct ref_transaction *transaction,
 			     const char *next, const char *end)
 {
@@ -317,7 +323,7 @@ static void parse_cmd_start(struct ref_transaction *tra=
nsaction,
 {
 	if (*next !=3D line_termination)
 		die("start: extra input: %s", next);
-	puts("start: ok");
+	report_ok("start");
 }
=20
 static void parse_cmd_prepare(struct ref_transaction *transaction,
@@ -328,7 +334,7 @@ static void parse_cmd_prepare(struct ref_transaction *t=
ransaction,
 		die("prepare: extra input: %s", next);
 	if (ref_transaction_prepare(transaction, &error))
 		die("prepare: %s", error.buf);
-	puts("prepare: ok");
+	report_ok("prepare");
 }
=20
 static void parse_cmd_abort(struct ref_transaction *transaction,
@@ -339,7 +345,7 @@ static void parse_cmd_abort(struct ref_transaction *tra=
nsaction,
 		die("abort: extra input: %s", next);
 	if (ref_transaction_abort(transaction, &error))
 		die("abort: %s", error.buf);
-	puts("abort: ok");
+	report_ok("abort");
 }
=20
 static void parse_cmd_commit(struct ref_transaction *transaction,
@@ -350,7 +356,7 @@ static void parse_cmd_commit(struct ref_transaction *tr=
ansaction,
 		die("commit: extra input: %s", next);
 	if (ref_transaction_commit(transaction, &error))
 		die("commit: %s", error.buf);
-	puts("commit: ok");
+	report_ok("commit");
 	ref_transaction_free(transaction);
 }
=20
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 4506cd435b..1e754e258f 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1598,6 +1598,38 @@ test_expect_success 'transaction cannot restart ongo=
ing transaction' '
 	test_must_fail git show-ref --verify refs/heads/restart
 '
=20
+test_expect_success PIPE 'transaction flushes status updates' '
+	mkfifo in out &&
+	(git update-ref --stdin <in >out &) &&
+
+	exec 9>in &&
+	test_when_finished "exec 9>&-" &&
+
+	echo "start" >&9 &&
+	echo "start: ok" >expected &&
+	read line <out &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
+
+	echo "create refs/heads/flush $A" >&9 &&
+
+	echo prepare >&9 &&
+	echo "prepare: ok" >expected &&
+	read line <out &&
+	echo "$line" >actual &&
+	test_cmp expected actual &&
+
+	# This must now fail given that we have locked the ref.
+	test_must_fail git update-ref refs/heads/flush $B 2>stderr &&
+	grep "fatal: update_ref failed for ref ${SQ}refs/heads/flush${SQ}: cannot=
 lock ref" stderr &&
+
+	echo commit >&9 &&
+	echo "commit: ok" >expected &&
+	read line <out &&
+	echo "$line" >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'directory not created deleting packed ref' '
 	git branch d1/d2/r1 HEAD &&
 	git pack-refs --all &&
--=20
2.33.0


--N01QCmv1SxaJo9RA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmEx5ZwACgkQVbJhu7ck
PpTbcxAAmu5wSzcspfXXnEEqdnrk7NwNuKAKxpVVfJ+UmSepwK6vk3MUZ4KpVKId
X7qoMxarP91Iq0Pl7RHtApq9koElYsUp9UNagNm7uWE+T/MUN5jCB5J9a3uAp+H1
g40JroKTWMULhQ55RKo8zKEO7FZagnuMbPWK5rbWY/YxfZKbpSOuGK7GR85PfQTG
j99eq83kzY8JcuqMxxgeeKNTjSfvDWJQk+UgBl9PYkV8Vb+xhNmKBZKGnd99w5u3
O8rV/Rl8G269khwZ/gkCfQG03k6B2Qd1NVD5emdZGTSn8zUj3TLCoBKSAqJ8Ajue
68Var/PVl1L9XFTeS0PRmTRsG5NBCvQUsPcZ7Bk4dRYPaUhtQK/SKIU8aNx/lPu8
aHNHmD+NT1ZpTST1getyuIxZu/878E0/HnVLQPwVXMzh3AJAedA4Gl14AWb6zKXd
5QRaUcmVSrrK7rVDe5I5SQFTYfu9BBZGEwSntz0a79bR6JJT/D+rBfHXKsJ7sJnh
mgHtOkBvVVBZIAe9Bo9q/1JKrZ4UuOy9GIJFNtXACbCKaXKrOeOl7HGPXbmq7UcL
x0aMYabrylRaDxEJvGd9mUkfP+wGuHFgyW8Nu9IrE3CdweFiaWm6/mDApVMXkEha
qNcLBYBC41KzDxU37E/58x62DEdprxVC1KXfw+hSWyHJBJ0IiRE=
=dgXi
-----END PGP SIGNATURE-----

--N01QCmv1SxaJo9RA--
