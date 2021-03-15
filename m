Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2C1BC43381
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FF2264EF2
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:15:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhCONOx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:14:53 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:52337 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229933AbhCONOe (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 15 Mar 2021 09:14:34 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id E66B85C0181;
        Mon, 15 Mar 2021 09:14:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 15 Mar 2021 09:14:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/+jiUPbs495isgCRZn2Y3WR6/bP
        Ft/z94SXdT6KzY1w=; b=Jb2BbjI+vn+2ujrwtJV8J3KTlSeRBUGTItIrmjZ/sbK
        6F0bToPLyc/xCLXg8zUOJHwmAbKHGVx9LGWOdOBMqtuT03oU33LdI+M0bzHv7oQF
        4XDtcOa2rvTiEXxhE3naaZVzZTTmE/oxCqcX+U0yQMGYvpUqMB4ieWlJCSLHD0jc
        /gpvnLolcnIhYDdQobcGSABSdlH+czgdWxnpRziRSMzLAgHuBhaZj8DQ/e+FtbX/
        YPZtyx05HSoTe7f3aIXrz8KgDIeM3LKVSbCUoSKYZiQKgsj/7D+EDxYeowCXY+EF
        zm9M+madT8Z9XHQXF5kC5Ze+5IIVLa1Ifqd3M8cq0QQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=/+jiUP
        bs495isgCRZn2Y3WR6/bPFt/z94SXdT6KzY1w=; b=lHg/8TAMFTNlv3Hp0M3ftI
        feK9FgtrRD1c1l0okwsdDuHghhffJAgX20icxfVlBp2V2YFEXzYgOymrr3czda7z
        6jzZavBfYD8Wy2YJ1doMDpgk/Ucm6E21hZfbcYox9kWn7pcCgcJD8RERdebVclsF
        CS/5GyanhLD27HVJhuUniu0IJLpwaHiv/skyAMASeXsRf8ZmYiirq9nGl4pPNFak
        1FEdNAIgyfxoKytgHWaU1G9lsC23tbCLYUmX2V97pMG9Wzms2tQPnXmECAJjetke
        Ss0itAQ/URmNDQ5Ml0F56GcjeezVcG/Bk/YO//hmcDzTu3cR/LgOv77BdqPYcvUg
        ==
X-ME-Sender: <xms:uV1PYF5nmx5B2PWrOShq6ev-fNKzI5tSHmZBhh8Tol7DERlUtSd6JA>
    <xme:uV1PYC6Tp73lfec34ExhIfgdPR2H3t00qAtQ0kShePk_RusZRV3Mj81lNRt9x6IUl
    T5WYZeCDm0ZFdsS1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledruddvledggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrleeirddvgedunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:uV1PYMdWXdiRKRB96fzQZDMleVPoEkd6ksSxvazN1K_CC2DhxTU-CA>
    <xmx:uV1PYOIoDNJeQI6zTUODtr8Z8xAxigkXeDH2N37rkqtEsKd-v7HpOA>
    <xmx:uV1PYJI4hES5Dx-vzDuWtJXS9JZPW6W0fV41Aa8mbKoaZLQ9ZfEBGw>
    <xmx:uV1PYHiu9gKrlI4oqZhIZOHXElpmSS4w2ucf236U1avR13VAigN0AA>
Received: from vm-mail.pks.im (dynamic-089-014-096-241.89.14.pool.telefonica.de [89.14.96.241])
        by mail.messagingengine.com (Postfix) with ESMTPA id 42F981080067;
        Mon, 15 Mar 2021 09:14:33 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 2e00912c (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 15 Mar 2021 13:14:32 +0000 (UTC)
Date:   Mon, 15 Mar 2021 14:14:31 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>
Subject: [PATCH v2 1/8] uploadpack.txt: document implication of
 `uploadpackfilter.allow`
Message-ID: <270ff80dacff96f441e12954b059a68300157f2d.1615813673.git.ps@pks.im>
References: <cover.1614600555.git.ps@pks.im>
 <cover.1615813673.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="7eujyKOHjW3CKIGq"
Content-Disposition: inline
In-Reply-To: <cover.1615813673.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--7eujyKOHjW3CKIGq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When `uploadpackfilter.allow` is set to `true`, it means that filters
are enabled by default except in the case where a filter is explicitly
disabled via `uploadpackilter.<filter>.allow`. This option will not only
enable the currently supported set of filters, but also any filters
which get added in the future. As such, an admin which wants to have
tight control over which filters are allowed and which aren't probably
shouldn't ever set `uploadpackfilter.allow=3Dtrue`.

Amend the documentation to make the ramifications more explicit so that
admins are aware of this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/config/uploadpack.txt | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.txt b/Documentation/config/upl=
oadpack.txt
index b0d761282c..6729a072ea 100644
--- a/Documentation/config/uploadpack.txt
+++ b/Documentation/config/uploadpack.txt
@@ -59,7 +59,8 @@ uploadpack.allowFilter::
=20
 uploadpackfilter.allow::
 	Provides a default value for unspecified object filters (see: the
-	below configuration variable).
+	below configuration variable). If set to `true`, this will also
+	enable all filters which get added in the future.
 	Defaults to `true`.
=20
 uploadpackfilter.<filter>.allow::
--=20
2.30.2


--7eujyKOHjW3CKIGq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBPXbYACgkQVbJhu7ck
PpQLBA//dnDInA7U8oX28TuojZ8CxPPaMv1fLRDoe5+OgWLV9Ocyu4jBBFmcUUU3
VykiCebVln9UAH/pO0VOBlSsCDqJ85fqexC24EDqDRr0dklALIBnJghnkvuZzldN
T2+aYUmBEVclHxEJAfQ2VS2VaqO65JuC0FukTAoOiS9KNVjA0tll5aEJs8qntcBh
Yy9eSP+JmJ4x8JxMWHiVQH1/MpLAgKWJGxwV9ubdMOSzQIVl18DQpGfV4iir/tGc
ncbIA70ya7ccbWXxmhcCSzwRGwjUCLNKWfRdSKj1ySbPaUcUYypCpIeLKr0410Wt
LDJueiTIzQv26a5DAkUXSOap5VMlnlDzKj5IKVs7pvv+kQd7aUVNlLUrcVa/Jpai
Bs09AxmW26q4LgqOw3/xfVFgaYGL49FEAqKFUDNTW1KepymSC9OxeXFWYxoy8ZTr
6kYWRoOGa4nRe0BEhG9M26lF6SMdo7AVJlG3rKQo8j5x1VoJMM/0coptIt/dO3ha
YO7ane+rQxDQ/5dZmpoBY8NfGYAnKDbS3IugDHGeLduWvp7q0qpJBW4aSMyYlZP7
bk6n386GSjpPv66atvUf9w6+CtIAoMhCX0TgTYERXTxjF8yoGSA5GY79y6M4w7rI
CKfNvfDsO85i0tU44fdcAKfzbYlv9EiHrPpxZ1nvK1ZRUmuspYc=
=rQcD
-----END PGP SIGNATURE-----

--7eujyKOHjW3CKIGq--
