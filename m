Return-Path: <SRS0=sJPh=5P=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8FE3C43331
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE95020780
	for <git@archiver.kernel.org>; Mon, 30 Mar 2020 13:46:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="qFjaPHhi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4MznmEux"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728481AbgC3NqV (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Mar 2020 09:46:21 -0400
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45589 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728129AbgC3NqU (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 30 Mar 2020 09:46:20 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 6D96B6E6;
        Mon, 30 Mar 2020 09:46:19 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 30 Mar 2020 09:46:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=WwD6Mox/y9Q6/fDAXt1lViLUbJH
        EfB7d0Dyskob1DH0=; b=qFjaPHhiMgDx0pannIysVbRtsXPQu6+lNE3HHLDRPt7
        NCwhB4cK719Yf2ATpS39gwGt/Mo11IeRKqp3wMOQ5yh6vqHKcQ9ZPY6BADUBwBMv
        jTlm7uhfny/jfxkOhtE/S6iitCjLSDJGZ7IbxwFnNUXmTBHwIozyQCAYGIyFycLx
        F+UfkIdg24jznj3ssrYuLh5oa7xRnVV03+0TjZZuPNlBdovfOaGXZGM5AFPcc4E/
        L0yEHy7mwxfQ1VMl/o+Zl8gS/+ua7S6A8ELR97PgQk8ZVDd4FL3/4bXnNr4tfJ9P
        166JOfESXVU1tBp79LQq2D1iZjw4hStSS/ptro11Yxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=WwD6Mo
        x/y9Q6/fDAXt1lViLUbJHEfB7d0Dyskob1DH0=; b=4MznmEux0zHm8+gP6KwABi
        NZOO4+sYs1slpohhezrlULOf138Z7UvtMvJQc9Jq5IMtVAF4p7MHATXDsrwtHXMU
        9IqQIMkam2/z/RPslPEctvoNTaCso2fiZQV5AnZDxp3INSDx2nb7pENgokvskTnC
        YYgvHaYv0ON/lTLCep8cmKEJyhzGykcY7gr7DJ5+NnAE0QRyls1lktjQ+w1nyV23
        rMRZxM21WQcrSafOKKO0DXbYeRlxpfPogqotlLdo+ueAgBtwGOhufM5pjSHRpGOH
        aCqNdJUWgu4PUR0FbGLhlVnzp3q4sjuv2r/jNnUQt8Yxh/ahknhT/tm46CKYNuPg
        ==
X-ME-Sender: <xms:KviBXhkCowJUOKJI51-peOXAnN3CM_Eq43Ed11gMuWVvtoEf9uH2iA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrudeihedgieekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucfkphepjeekrdehge
    drvddvtddruddtvdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KviBXhFQe9HEyMcFZMFE1qUzt03LV2h3dwGEcf1mQ-OYITs8SQ6RFQ>
    <xmx:KviBXipKx0qtM5TlUh31GX8POWzKJNk3lLoNNG4GjzxXpfUc_gccgA>
    <xmx:KviBXl5ZM73hEmxfV_gJ4-pONEeRFT3pcGgQ-egdIxgZwLTCowOlzA>
    <xmx:K_iBXt4heTKLYBUAt4vRlJIqYw24SQ-MgnA-_8mwY9cA7vb3KjX33A>
Received: from vm-mail.pks.im (x4e36dc66.dyn.telefonica.de [78.54.220.102])
        by mail.messagingengine.com (Postfix) with ESMTPA id 601573280064;
        Mon, 30 Mar 2020 09:46:18 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id e8906590 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 30 Mar 2020 13:46:16 +0000 (UTC)
Date:   Mon, 30 Mar 2020 15:46:20 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git <git@vger.kernel.org>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/9] git-update-ref.txt: add missing word
Message-ID: <15857e1b8ca800a92fa96fee818a54456bfbd330.1585575749.git.ps@pks.im>
References: <cover.1585129842.git.ps@pks.im>
 <cover.1585575749.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="y0ulUmNC+osPPQO6"
Content-Disposition: inline
In-Reply-To: <cover.1585575749.git.ps@pks.im>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--y0ulUmNC+osPPQO6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The description for the "verify" command is lacking a single word "is",
which this commit corrects.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-update-ref.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git-update-ref.txt b/Documentation/git-update-re=
f.txt
index 9671423117..9bd039ce08 100644
--- a/Documentation/git-update-ref.txt
+++ b/Documentation/git-update-ref.txt
@@ -107,7 +107,7 @@ delete::
=20
 verify::
 	Verify <ref> against <oldvalue> but do not change it.  If
-	<oldvalue> zero or missing, the ref must not exist.
+	<oldvalue> is zero or missing, the ref must not exist.
=20
 option::
 	Modify behavior of the next command naming a <ref>.
--=20
2.26.0


--y0ulUmNC+osPPQO6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl6B+CoACgkQVbJhu7ck
PpS0ow//Uw9dfqt54Yw3/ykNvcPDQjygqCQf1Iw6M8MxrHkuEiBYzxvUpx6yzhjm
V3pzMOHQsOBqkrKNVWEqhqMS3kydP1NjbWNLhYYmrUATNrDRImMFmYAa4l1FJieR
jJpoLQlc332JEpD8VtLXGCmLAf5GfG3AE1TeVrlMlEEGryn/NinBDVJ5wXfsO4jo
vBZEpfR3VZMR/wxnP746zDZJ51VSAWprn0Xw8hlUpC15w7uEtSOeMfgEnzHGqxgC
FZN54AtbuT8v+pIbe7vq3q7SqKAjMACGX5WFFhUCyTf3Ewal+Zxk/NFZk5H/QIkW
IWwdkOyVeRB92fIC658xg1m+cldSbQW6xlK5zsBCNTe3NgBrJjDpw13NaazcdmLt
R1rvM1Yl1PqlqZnvN9MfgaKRD1e46u711tz4yqrU6oXPkiRaMbsKOr97SS8Xu0zS
gO2HK4UTOYlp+EGAoRo1gEOK4uIDCOylfaeuqmBIdT2jL84TJW3UUNQvPnOeyIWV
tfYoIx8/bXlVwJWp9rDFc0ief1kla1qx6dxeIHbIembxuySStF1yWv0nRlbPMUjJ
gPFH/1Iu9ilb4hYMvFXyR6+5HZVKjHqfiT1xS37Tpi4rsIx9c70u72p+Q/OvRu62
vAtnAY08O5A0oKZXeFxx9JV0y7XBWDQ6NOkOS9Z/sUPAzFqt/uc=
=KM5T
-----END PGP SIGNATURE-----

--y0ulUmNC+osPPQO6--
