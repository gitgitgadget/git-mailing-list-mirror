Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15AB1EB64D9
	for <git@archiver.kernel.org>; Wed, 14 Jun 2023 12:18:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244341AbjFNMSw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jun 2023 08:18:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233887AbjFNMSn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jun 2023 08:18:43 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B05E19BC
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 05:18:40 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id C9FEF32009A6
        for <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:39 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 14 Jun 2023 08:18:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1686745119; x=1686831519; bh=oz
        0a7ELfbOSuWlT7nk1zA2p4uJRNNqC5TJuf3tm+Kx0=; b=RREcBtE7u86Q4nCM+S
        2JPINMnzmpHu0NtpvRgzmkqTGtl8+gl4zkFxmOS3ZIdVi6lKYkWLpnXoRpqsx+91
        KcxJzJX36INEnotHwiT9wDpSTBWlzvnDbJnHDTsSaou7S8a28dvXWu2iHjUk+wXS
        kfIFk7CEaa8NkEs8VOpMSUTFKkSvrbCPHhwpl82rocp/Ue3wMpBZLg3cJzOSgIXP
        fv4AGjNhSfcpI7CISJSXVRU/WgpAEfKzmiTGIarT7lUxTIgpbYxG994mLM1lC3qz
        hWjhl+kcrb6/FvZg8lxmVthBFeU+JVAB17cyZD/yK0hzvlTsZ5BpUHFPYp76zVW/
        TUkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1686745119; x=1686831519; bh=oz0a7ELfbOSuW
        lT7nk1zA2p4uJRNNqC5TJuf3tm+Kx0=; b=NugIxsGUSk/LVJtMUUIoHSMHCJWyM
        Kqc2l8BL7AMb9puxzFzJvQv/L6G7FlzRqAKCm9mpr9D6v6Vg6oqv1Fr2cdy6+0Dq
        D2gGv9jEZCvO0mPCVLJ5ajBfnrkDbDYEQ7tk0LhWYZ4ehSIAZhMdEE//OPM0kyz+
        sFTfWiFcA4bQl5rTvNSW+lOZInXLJ1NjlnpK2JkzwOsjg45Pzu6RRQYQdT2UFVzg
        PIJ+FpBfnr1CMGqHQuTdvKOgyrLhiCp0wie/yseezdcD/hiWdxmVRDqqKNMyfG99
        UZuKkchiYXfrjwzc8vUA6fLDx4uNoPsfDERAInX9QulpBJg3S9+c93FOg==
X-ME-Sender: <xms:H7CJZFysmmUnrjeKmWAviIOu_vNUdlLwqXFtcbcVvlaJ5j2ioi2QJA>
    <xme:H7CJZFQnfC4pF5huIhkzxKUF-DLGJgbhObVbkRBWHN_s_TIgZI9499-dlsHVYCh6q
    N4InCrPINNV5-F1AA>
X-ME-Received: <xmr:H7CJZPWOAmeU-kPktqqrtDwzulooM6ao6peMR_XK8JFzkMCGYFZ0mwmHq5aF97H7QnGSdjT_G0GmSlseBBvdOcH1242CbYolKPnsPukhDP0laQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedvtddgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesghdtre
    ertddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepheeghfdtfeeuffehkefgffduleffjedthf
    dvjeektdfhhedvlefgtefgvdettdfhnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:H7CJZHhoRq33YnqmlkdCOrg_IXNEzJdxJHXoryVs2_FUfhwWRH77DQ>
    <xmx:H7CJZHAPuqMheMSTErmIT3UMPILEX10Vgqvl_XJfxppMBTnUW3Fzpw>
    <xmx:H7CJZALPPbzbShcQfvfufI3Lb9fHft1a5_zoE4QREIt90XRUCjko1A>
    <xmx:H7CJZK9wVmUbEyE7xAN3AdDDFkShoWBWAm4oCKrQqt991AeOlLubuQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Wed, 14 Jun 2023 08:18:38 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id 75a7ed4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 14 Jun 2023 12:18:36 +0000 (UTC)
Date:   Wed, 14 Jun 2023 14:18:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 2/3] revision: small readability improvement for reading from
 stdin
Message-ID: <38c0415ee9074276e9832bbbafdee8833cd7ddb9.1686744685.git.ps@pks.im>
References: <cover.1686744685.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="54gxnxbcoct2u6hk"
Content-Disposition: inline
In-Reply-To: <cover.1686744685.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--54gxnxbcoct2u6hk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The code that reads lines from standard input manually compares whether
the read line matches "--", which is a bit awkward to read. Refactor it
to instead use strcmp(3P) for a small code style improvement.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 revision.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/revision.c b/revision.c
index cc22ccd76e..dcb7951b4e 100644
--- a/revision.c
+++ b/revision.c
@@ -2795,16 +2795,18 @@ static void read_revisions_from_stdin(struct rev_in=
fo *revs,
=20
 	strbuf_init(&sb, 1000);
 	while (strbuf_getline(&sb, stdin) !=3D EOF) {
-		int len =3D sb.len;
-		if (!len)
+		if (!sb.len)
 			break;
+
 		if (sb.buf[0] =3D=3D '-') {
-			if (len =3D=3D 2 && sb.buf[1] =3D=3D '-') {
+			if (!strcmp(sb.buf, "--")) {
 				seen_dashdash =3D 1;
 				break;
 			}
+
 			die("options not supported in --stdin mode");
 		}
+
 		if (handle_revision_arg(sb.buf, revs, 0,
 					REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", sb.buf);
--=20
2.41.0


--54gxnxbcoct2u6hk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmSJsBwACgkQVbJhu7ck
PpShyg/8D9NDHE0VQBB86GLuGVKSh6JFKC+bRlE3pFA9I8cbPC7qtlBG0kf6ZhCb
ZlPKYnud5YY7JW+aQZEANa5MX7aiDXffxfPmJBDq+J43Jeyi4CpmsGVc+Q3wsnlQ
dw259hnxEmp2acFBK+1s/pZ3m+x9zbraKlodfgprpHdZs2rYMZusAvGd1fYWDD54
X+Vw5Bg3seTaRAFnFoTh5KPILK3ngn76bOZ1NXZEOH9oCwkI2vk6NF9cxMmJxEpx
XteM8Yj7y2kw1CDW4zn+C2IrNSiLRBHIsPzvrqp+aGguZXsLpgv2cZvaVcdCZiup
QcLWDMEJnNRizty4Isej9cgmrFHhW38DXbQ8EV85ntpJWAAJzvwlwXu7zWVd2Uo1
LGQi0tHqKVJrIoo3Bxr23hc7DDFHfUGdugaXrAKUEA4XiX8K1PdDp2dn1XIXx7DV
fq6maiKWlwKHfS+Zdz8SWj7WBerKCouFaIbfyESu5MVWBH2E0a1NjDr7kGBL2gdq
1OCjzOhsl1dTEY6RklP2+wrYEdMjJzKG4UDt125XbUb3Q/QiF0G2Das0FxLipgIY
NmWzsJIhbFpaECU8l6Gab3vsqG1VTWFYm7JcEyisNY+qMOAj9lyyfLKUD0iO3AC5
T5ptghh26W4ZqupJ3Q1GHwynAoT3Btbw6d76PFYJlrpHzochT2I=
=JnLz
-----END PGP SIGNATURE-----

--54gxnxbcoct2u6hk--
