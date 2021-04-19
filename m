Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FB78C433ED
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57E6361090
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 11:46:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238751AbhDSLrO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 07:47:14 -0400
Received: from wout1-smtp.messagingengine.com ([64.147.123.24]:39387 "EHLO
        wout1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238856AbhDSLrJ (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 19 Apr 2021 07:47:09 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id A8505B01;
        Mon, 19 Apr 2021 07:46:39 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 19 Apr 2021 07:46:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=K4JgZnJdYfycPHrP9xfCggxiDsh
        7q22Nb6DqqR/ypmA=; b=nqlR5KcRcFvE2H0O5hXlQ17J0Z0KQ2S0HxYWFIl/rAA
        8D+QXVlSrD0hie0j7Mp2nvuvNQ5YBS1/iaSFHX4ofUnUlzOB+r/z1oF6Esyh1XdD
        glRO5QH6diETHPMAx0WODW6vRHTKtUwMtvI2/E22VA+rTAIOvA8S2OSpFGfHWJmq
        ZsgYqWLe2AntPAxFxNdLSUmsWvqeOwXpm4yQLKzQg+d+RxA/jLdT5JlQtTPGwvPP
        ZvLrXUvq8wlnmciSiTTHPSU5i49iREWP7eRVe81aRdEpo94CqVb4+IL2gXu2Xi78
        WwtCfgLdoNQGL1nxdiBz4qsQhHg5Vn5TcOwF2BoaL9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=K4JgZn
        JdYfycPHrP9xfCggxiDsh7q22Nb6DqqR/ypmA=; b=Ad6eqbep6gkyi8zDYJO/xJ
        hFb5Av0s0HD4cd3wlgpnNIZnixX5uA0de2tDAzsC/pdPtfT/HJ0IVxLPBY6Aljj2
        W4x7UpJKWH89LXXP6PFw56b+OjavXamVPqHtbv4QJbTYW8tTurjaFV8zj20g9hY+
        7NBQqpsZustTg+SQOmP9ivbLCtXpmGRaM7I+GOrhvyy9oJxuOc60ifJ+B2Nlb2/Q
        yh3toQn6GHMqJFokvANMSiXa+b9EbcM08abUbz1idGULN+6ybt7jjrLwEDo5kTnN
        Bn6E3kS/IhfupEkJRpVf+9hQe+Yol10KEjtLejGbQnQ8z5Kvw3vPrynrmGVkg7cQ
        ==
X-ME-Sender: <xms:n219YIi-f6p3bQgMywLIVzcBBN_XPjq-oa3m3IbsooKo5coladvHoA>
    <xme:n219YBBs6DrEFl1K1TTTSKyscNJhGkt4ZkIqEszIEkfAFT28tTmBXSPD3Xea1DblG
    OPA_d0amigRrPfmiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvddtgedggeehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdeikedrkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:n219YAG7LFxzePTkJzSUcHrKd_h501HYYhSUvfKn9uBYonuTdgHcVg>
    <xmx:n219YJTx3fYpj14wittXkcKbbuS7EmJ3zXgC7rcPRG7hMByXlEgrjg>
    <xmx:n219YFyYPszkNu-ujBi8JmY2MNQJWINqWFpvypB4Yctl5-v6SBCZPg>
    <xmx:n219YHsKu_TFTYEtQGWFbj1hQP6YsCuYV3nZmmhSa4A7qtPwXXL8gA>
Received: from vm-mail.pks.im (x4dbf4450.dyn.telefonica.de [77.191.68.80])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5E213108006B;
        Mon, 19 Apr 2021 07:46:38 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 7887ba6d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 19 Apr 2021 11:46:37 +0000 (UTC)
Date:   Mon, 19 Apr 2021 13:46:36 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Philip Oakley <philipoakley@iee.email>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: [PATCH v5 1/8] uploadpack.txt: document implication of
 `uploadpackfilter.allow`
Message-ID: <bcc81336b10ff22f0844fdd7f7fe7e2c3807cec6.1618832437.git.ps@pks.im>
References: <cover.1618234575.git.ps@pks.im>
 <cover.1618832437.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="LLH+Znd9Sj+msq5D"
Content-Disposition: inline
In-Reply-To: <cover.1618832437.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--LLH+Znd9Sj+msq5D
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
2.31.1


--LLH+Znd9Sj+msq5D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmB9bZsACgkQVbJhu7ck
PpQSnQ//YC4/wDAeJIpHaCcG3g0wwXk1psFyQ3/7GeOokzZrb7IjCsZi/jJxCxfg
FPeQNyuGGY5gOHs93OYE01FyfCb+W2EwGfGUzsOT3hwilS5F/15LLhjTFffvW50L
x9OFs+HGS19I0UotTuLfoTat/Qx3EH/1LTA6jcu/HdEQFoNCu8kWiNACn8iXy4Ze
6cppGQztpSi8SmrNao2GWJcaj2UUXmlAIOG7eVzvVSBV+euZjIQPm/4fcwsQvR6X
cBpPGc4FCL2FKP+YN8zVW/+yMyfHINul0Y7lr4j5IwsY2cqQIZQpFAjEx0dCl6P6
razo6nyBwMAd10i/au8gk8xnwvtqM5d4dEFU8TeMv7Qdtz3bO4dQouPaxX5r4/iY
5GXzV6ECcSlhaSsmHdGHDYKXtx82fzK9J1YlrjgKlMrDq1lT8qV4PTv/k+HiHxip
+HYgXyoC0eCIjS0FK7ryUy8kEdESIm9Tdz5fw+BfCGkytx7AL9lEX0+2F+NWe4WV
av2oKvRI74PUCaxlc2ETe7T/m89+70/8+UYVTZrA5nUxJx4FKfpwTSQX3PWiwiEG
7JhI1pAH5pfOPc8OkYyDQYJhYSDIipqr4e9vED8CqU6Ry7YM1IBr5gjGFl5Yktse
DaaTe1BHs7L3WWtjONMqE66KdGcCfkTMq4L9Vd/5T9T86MfBnt0=
=ulZM
-----END PGP SIGNATURE-----

--LLH+Znd9Sj+msq5D--
