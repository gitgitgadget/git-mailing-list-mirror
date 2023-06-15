Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55BA5EB64DB
	for <git@archiver.kernel.org>; Thu, 15 Jun 2023 14:40:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345074AbjFOOkP (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Jun 2023 10:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345111AbjFOOkE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Jun 2023 10:40:04 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B469FCD
        for <git@vger.kernel.org>; Thu, 15 Jun 2023 07:40:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 2E7675C01C0;
        Thu, 15 Jun 2023 10:40:02 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Thu, 15 Jun 2023 10:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686840002; x=1686926402; bh=l0
        TirewQAd44zrlpoJZ4blPqTKS8Lt9FqKXfF8BZ9s8=; b=F372rRbZFpIyqrpSzt
        IIsgpIx8aa3AAFmZ9EpYniid9VqXUWHpvrNq+AgkeFubHfB2atZkoflGPKUu3NL/
        Ber2YefsN0QhvDAxTYezVkWwjmMaBqUvyg9YE/toHRbcmYdcqdd0hK68yiFxtws1
        kfaeSQ7I5CTsODfi1qhQDCk+xXUQjz1wV2kmlvkL6HDDTI7bU7qm+biVYCtLEGqk
        +tqInaIIN2cZgn4ipvBvOTf5BBtZU2ZJzYuuCnjAoWC8vauWc15kBAnXRv7kxo1P
        TEnjXohBOne9Cd6Ta9FX6tgQj1PSJcZsXSj3rh4FRQB6hUbL+4ylCh7Ey2vthEav
        hS+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686840002; x=1686926402; bh=l0TirewQAd44z
        rlpoJZ4blPqTKS8Lt9FqKXfF8BZ9s8=; b=GrX4/+OQGJKs1W9riD7x+Bw7FWnsd
        TSujyhMvTV/CHvuofILCL/KMbRCgqjMnjCwqSM/aIZ/HQYHx3X2QFWA0QtnrCVR3
        iXZ/BCDgcGFGM3fKhDxMCh1F6JWa/1Bfeb9cL0DUaCYk4ajSIqTCOXLcTAxjGgod
        6iTACXG7E2NWBPPgsY0AiNUrFtDMt5yiAmAbCIp24/AiELqKbmsoXeJ7ek9vMojW
        /ckVW/bdJlGIQ2NzbFEafg2Yaf29POuxiVaWVuHtFGqG/gKf3cH4C/S95fSptGeC
        PtzH5hqCg+FGsfUBl29mmspbqwdosZ8VVf5Hlz73LpvqR5q9WpLsUanXg==
X-ME-Sender: <xms:wiKLZHhY1SbmQjmSVkLONteByohRn6pdm-rLsQANf57Nec5iqPHNxw>
    <xme:wiKLZECX6Bwq12SKKJqU2O6fh80a06fB0IjC_fX8D2TH8w6dAs0zXScV_JliSemwm
    5hiVKDxlQjDQ9xGWw>
X-ME-Received: <xmr:wiKLZHE-TC25JlEMrbVuJ41SE9yB7vpybYSY4iiXWalP19voypYRzh6H_hcoaPc7uWkl5kr4YTkVOeqvlJYECjrYzfkh93MdMd7pQJNV3vbV0A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvvddgjeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedtnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:wiKLZESIn5wvam0ZZIqWDDf1x5FACmrHXChqEBrp2JatLS6IIOR60A>
    <xmx:wiKLZEzhTdc9c13B0Wtav2o989t91cvRBle_z_31XYmzUYxHS8j4tg>
    <xmx:wiKLZK7Rib9iroReUwbAVyq0iSEd3YACNhfZFtTRNxzdbcRUwB9UQg>
    <xmx:wiKLZKZYPo_Iae3eQh-FsSe-Wfs00KN82d7S8YDBnCmOFhLtTU22Lw>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Jun 2023 10:40:01 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id caad6d47 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 15 Jun 2023 14:39:52 +0000 (UTC)
Date:   Thu, 15 Jun 2023 16:39:55 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] revision: small readability improvement for reading
 from stdin
Message-ID: <5c1a9a0d08b25ce94ba1498cd88051abd062369c.1686839572.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
 <cover.1686839572.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vrbkvwd6ej5fxf7n"
Content-Disposition: inline
In-Reply-To: <cover.1686839572.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vrbkvwd6ej5fxf7n
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code that reads lines from standard input manually compares whether
the read line matches "--", which is a bit awkward to read. Furthermore,
we're about to extend the code to also support reading pseudo-options
via standard input, requiring more elaborate handling of lines with a
leading dash.

Refactor the code by hoisting out the check for "--" outside of the
block that checks for a leading dash.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/revision.c b/revision.c
index cc22ccd76e..3a39f41bb8 100644
--- a/revision.c
+++ b/revision.c
@@ -2795,16 +2795,17 @@ static void read_revisions_from_stdin(struct rev_in=
fo *revs,
=20
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) !=3D EOF) {
-		int len =3D sb.len;
-		if (!len)
+		if (!sb.len)
+			break;
+
+		if (!strcmp(sb.buf, "--")) {
+			seen_dashdash =3D 1;
 			break;
-		if (sb.buf[0] =3D=3D '-') {
-			if (len =3D=3D 2 && sb.buf[1] =3D=3D '-') {
-				seen_dashdash =3D 1;
-				break;
-			}
-			die("options not supported in --stdin mode");
 		}
+
+		if (sb.buf[0] =3D=3D '-')
+			die("options not supported in --stdin mode");
+
 		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
--=20
2.41.0


--vrbkvwd6ej5fxf7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSLIroACgkQVbJhu7ck
PpTg9w//Z/YaXrlLhxSziWk9BhTSw7zeWSfu4v62N8FjR63NbxrI+k3F4EPhP3zN
YNg6y/9G9RWQIAw1gHrg2iI4pZzgIjKYSd9hFjTAUd6TA3Dk/CjMOJJxyJcwujf6
OH9lM4bBpXZAsx6pjFT/GMX9/lXEPBKbJnPXKL83l59o2bCSMLmQ/W2IxGaXyXnm
binj6R2bZjPQYHV2CESB9lBcRBjP9SUXLGhoxLSR1Y8eCFYVyNgwnkSXEEjJ09gz
+GVcAaPk9xwt/cbY1gP/rOYyQkKlb/2GCxUEOJSAoRruh8/qlLHeghfvytFoz7U4
yzSM6R5GzgjE9wML25s/9Ud8jx1s+EWevABm7ir7lR5VbwqCOZh6rlch2kPCc1p0
CWru44oiQj9lDUlJ+UHgFpTX26cNkecenOdd1347icHOsD9qmxBehDrc9XA9Kn9y
keoQxO+zSWO4BWt7zDGJ9LudR4DxMGYU7Jrdrg7wcmBJgmL7pdn4mk7T3fqWNcNZ
pCJOZHdbqpxvUWvV/0rpFeAgtpNPEy135dRftjUQtt3K6LupHFhdxf4MvHsey8tK
gD1gRa3KnkMspWzJ7anNZWCuh1vMVixqicqU7s10RV5FlRwbIBjgrkFd+W78S82p
SDHHXSMumlD2LIg1V5VGYgVTEhwN8VX46tRGUIb3DhlQyXsDqSs=
=a2U4
-----END PGP SIGNATURE-----

--vrbkvwd6ej5fxf7n--
