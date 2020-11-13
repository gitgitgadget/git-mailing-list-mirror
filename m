Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E770AC388F7
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89952217A0
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 08:12:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GK0LXHy9";
	dkim=temperror (0-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xo+9UQIq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726225AbgKMIMt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 03:12:49 -0500
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:45613 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725866AbgKMIMs (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 13 Nov 2020 03:12:48 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 094A05C00CD;
        Fri, 13 Nov 2020 03:12:48 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Fri, 13 Nov 2020 03:12:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=hEXYvDI0BT3JMpWB3CuSDeefXYK
        lpT6cIevo+74so4A=; b=GK0LXHy9GFZiqZLAz2mkj9LKplWsLObEa1RAKh+r6ES
        oeK33wabueM2QSnEsw9qkmbLD5vQvBMe2DB8ZQOlPkcdwIbIm9K8GfR9WW/VbbWt
        x0LzQ/CPXKyRYgG0h29017CoeSLUYElEy4x4XtrQgPUE839debn0oaBciAWZjKnL
        hO115mPT7lwf7+3JXu2/6X01MoRfEHeppmfoiJksQHjFbljXOhPLp4RmdoXUSVGL
        +mhNJtG55aaHqq21mTJ8zIx7Yq3lf4Ap9rhNAqJR6pcCF47PtuB1zFch+bYoOght
        NVSRHkQU5I84p+vNIs1f2aOWiQ/KGBpKmankRoWVI7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=hEXYvD
        I0BT3JMpWB3CuSDeefXYKlpT6cIevo+74so4A=; b=Xo+9UQIqLhL6fO1YNst0AY
        UxlIFxWSMlQSbv8vYrIe5SKQrKa4Mo162NPn2QqeQi++OaiNmvR0Xh2G/i/QL3f8
        NsYjbHY3R9njL/oovyvmoHRuvwA3f/6iSTkdIEIj/ppOMiF/JPKhrXoBgUkqepF4
        LOUdqX9DT+z/cV/jsloNm6rG8Ir6L94Vb7guEF4kEgMOCGWvY6dex33QVSaRz2Rp
        7oLMCIRdZ63uVfomP7U5aoJH6D+BQefmY+2lxra7nk3IKvzoznkq4tVBshN3vepV
        gzOqaMk88NmLZw18OoAEA9XpD7cxAAwLo5c46XDp9WJvb8r124gigPwdDqRrTDPA
        ==
X-ME-Sender: <xms:_z-uX94fJLgf_TLjhdsbDuUayXcx3LNkUznt8vLxqryeDTALm-w0LA>
    <xme:_z-uX64hoQhh0BwLkT71_m0MgmQIti5kRjeCh0jmRZk6XjfXQSka88IC2f9ta4i24
    8nnn8Q7mynbO8HIag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedruddvgedguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepkeelrdduvddrfedurddvfeehnecu
    vehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimh
X-ME-Proxy: <xmx:_z-uX0cDplhRGD2o1Lk9h-NcCjIRbkA-GtWwj2RmvsKA3FmFoeXKAw>
    <xmx:_z-uX2Kb-MFycAMG1ub-K5CfkUI3s63g0JVAfOKO8VBaSCJv0L_2aQ>
    <xmx:_z-uXxL5D2miPmyaAf-3NNF6DZjY8p7A69C_jgC4U1PP1ENlgvLpvQ>
    <xmx:AECuX_jwDtgDT9iRbJwHy3SgzsCnRSyPJGsTpOp1ZFazk1Hg_hzYHw>
Received: from vm-mail.pks.im (dynamic-089-012-031-235.89.12.pool.telefonica.de [89.12.31.235])
        by mail.messagingengine.com (Postfix) with ESMTPA id 3A13B3064AA7;
        Fri, 13 Nov 2020 03:12:47 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id eb129dba (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 13 Nov 2020 08:12:45 +0000 (UTC)
Date:   Fri, 13 Nov 2020 09:12:45 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, szeder.dev@gmail.com
Subject: [PATCH v4 4/4] update-ref: disallow "start" for ongoing transactions
Message-ID: <d50088345979abab14b7ab755866b78ef63f6d56.1605254957.git.ps@pks.im>
References: <cover.1604501265.git.ps@pks.im>
 <cover.1605254957.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="/utl0seplMDfUYlX"
Content-Disposition: inline
In-Reply-To: <cover.1605254957.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--/utl0seplMDfUYlX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It is currently possible to write multiple "start" commands into
git-update-ref(1) for a single session, but none of them except for the
first one actually have any effect.

Using such nested "start"s may eventually have a sensible effect. One
may imagine that it restarts the current transaction, effectively
emptying it and creating a new one. It may also allow for creation of
nested transactions. But currently, none of these are implemented.

Silently ignoring this misuse is making it hard to iterate in the future
if "start" is ever going to have meaningful semantics in such a context.
This commit thus makes sure to error out in case we see such use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/update-ref.c  |  2 ++
 t/t1400-update-ref.sh | 11 +++++++++++
 2 files changed, 13 insertions(+)

diff --git a/builtin/update-ref.c b/builtin/update-ref.c
index bb65129012..6029a80544 100644
--- a/builtin/update-ref.c
+++ b/builtin/update-ref.c
@@ -436,6 +436,8 @@ static void update_refs_stdin(void)
 		switch (state) {
 		case UPDATE_REFS_OPEN:
 		case UPDATE_REFS_STARTED:
+			if (state =3D=3D UPDATE_REFS_STARTED && cmd->state =3D=3D UPDATE_REFS_S=
TARTED)
+				die("cannot restart ongoing transaction");
 			/* Do not downgrade a transaction to a non-transaction. */
 			if (cmd->state >=3D state)
 				state =3D cmd->state;
diff --git a/t/t1400-update-ref.sh b/t/t1400-update-ref.sh
index 3144e98b31..31b64be521 100755
--- a/t/t1400-update-ref.sh
+++ b/t/t1400-update-ref.sh
@@ -1583,4 +1583,15 @@ test_expect_success 'transaction can commit after ab=
ort' '
 	test_cmp expect actual
 '
=20
+test_expect_success 'transaction cannot restart ongoing transaction' '
+	cat >stdin <<-EOF &&
+	start
+	create refs/heads/restart $A
+	start
+	commit
+	EOF
+	test_must_fail git update-ref --stdin <stdin >actual &&
+	test_must_fail git show-ref --verify refs/heads/restart
+'
+
 test_done
--=20
2.29.2


--/utl0seplMDfUYlX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl+uP/wACgkQVbJhu7ck
PpShnw/7BSgSYdWfmUAzC/OYxKmIclIgcwuYzp735BsyJvM6di8ITUSr8jrPF4sK
zYeoXu//rZGdIE3uETfAToLNYyzt6D1gGnjjc5O/vmZ2hEiJqXVHkiAdzZ+1f4/k
duqYw0fET2QUIPlhcTET5vbFHTgMC225qyvKPsgKATnsx60t2mCOUOdvjPGJfA3A
0gLYoVDkIYfL9N57Ucnr+B8zhzMMf1ESnSMKzZBAiefc5B8muQtnW2ET/IRrfA3Y
kX8cVoHdx68RlblvDedyylcJRn9Ri5kFPPNttF5JX5ZFIihCYtBNnAmYvZjC96SY
ikDzjMPwdh1+YktYWVoSqsQ57dt93Qmz0nGaYbbpWnQmo8hhnHBoWE7NEPm7a22r
myscMHR5G3hhqlno7nbZwfe3TKFzJs+1faqaa7r26p5IT9yYHydUBHjHRigiwhfN
wMJigWsPmpgAJRtoDqUImTv0kPKsYYDe4sckCLJTsyEJIXi1+Dv/BlKxz/Vonru5
u5Apid5BCaX+UGgx+hD+yKrwTBMB7Et7c5q8kdqlhgftrWfNiDi+0DOqnr8nGuuz
Tqpuzmn7a6SG5GvqCHZuP0EqewYSqvnHvt3xr0W+N1me+yUFkbJ4VncZV70U6IgQ
qsEybvjvczipy9xRXRKaU5S0I2zQW3+xthYF7XFceGoltjmXOhU=
=Rdvs
-----END PGP SIGNATURE-----

--/utl0seplMDfUYlX--
