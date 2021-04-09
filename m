Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4384EC433B4
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 299B261104
	for <git@archiver.kernel.org>; Fri,  9 Apr 2021 13:43:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233786AbhDINnn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 9 Apr 2021 09:43:43 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53695 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233730AbhDINnl (ORCPT
        <rfc822;git@vger.kernel.org>); Fri, 9 Apr 2021 09:43:41 -0400
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C18F35C0097;
        Fri,  9 Apr 2021 09:43:27 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 09 Apr 2021 09:43:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=a+47hYLsodK5DtZt5QOXfpNh2p7
        NpFt37HvZQjxf19Q=; b=U+lwCFgdEskF2sxlKLp5wONLkd89m1r5EOMO+0nuBdv
        5yUiavAADLrj5g9+TOb5UI9T1fUJYUc6JmgK3Ma1Ltj3ysx8sV9cNyb+ItqL81uH
        jqjdmWssKq8sUH20uNoDbIg5ylWy0q2NiiwGg0FdSC7u1tsYnQECLm1wK5/3/CWZ
        dGtPctM82GGBIM8p0cvCo6Yn6Jf8OwnFoDBAhqj1qz6vWQPUHUCjhRMoQvw6eI26
        IQFAVqJXjK83Hzpei3DoV/3o33W28C6f+VE+uKU0h1LsxnzioyDuzIBN+1HL8GDV
        RkCEvhvMwim7YEeHsl/jRfLLnn+KaxwYGteCcqv8B7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=a+47hY
        LsodK5DtZt5QOXfpNh2p7NpFt37HvZQjxf19Q=; b=lGU2vxBODHP3U1Egzk9EOX
        Iz7kdvVXYiv8kk2sKT84WBiDHdAaWrlO0wjpjxwdLnOn4Ec/klYaOJDqzjb5s0H1
        SWVKRTwHAD9V8JT1xMWIDTIeV9tDqe2+YmXePB5DcHORhvt3jaltEB4qMPJt8NAi
        873Mbms+PPHL6mFpPjfixJ9N9z46FNv8brc+JRZZejqMQ8DHYEpWCYyptR5XBsye
        B57gk6/T6wWb+THRA8Zptru6sbyxPwjXIbcXumierXtVs72mySR/66s7RRJ7Jjcz
        XTWtqb9eZFy2d5MuQI1uaFEucUe/qshl0GM6nY3xzW3b0+I9Z9uWndfLFjXZV+Lg
        ==
X-ME-Sender: <xms:_1lwYPdsbhPDUJlp_-GsuT3NPfTROkd3iiF8LRZT_XGT6sKNqg5xAw>
    <xme:_1lwYHO6wJ2WonKXV5geRljvB9NwS6Oh46KQs0fa6NfHo9zvcbRkYhDEYnTn1Mrp9
    BHUqY8GAdKpBBqYdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrudekuddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrdduledurdekrdduieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:_1lwYB42DFdTJXzRz4xEWGJc-jC7J9IZJow_uPLoYJgVr8cArubJrQ>
    <xmx:_1lwYDL0npGuWwwIWcJ-4mu27HxAfGWWdElvh4E-Vx-A_61C3VOkHQ>
    <xmx:_1lwYDfS1QsaGyzwOIQAb4giRlEQkC_uw1P1vaz5eD4PRvR3TdFx_Q>
    <xmx:_1lwYNJzu2Y7R27LtVTt_LTYpcIU6OWYEHXACyI2NKPuPUzttD8_Ig>
Received: from vm-mail.pks.im (x4dbf08a9.dyn.telefonica.de [77.191.8.169])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8909D24005A;
        Fri,  9 Apr 2021 09:43:26 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 30ccdafe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 9 Apr 2021 13:43:17 +0000 (UTC)
Date:   Fri, 9 Apr 2021 15:43:16 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2 0/3] config: allow overriding global/system config
Message-ID: <cover.1617975637.git.ps@pks.im>
References: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="USiXtFagnLiWEPLR"
Content-Disposition: inline
In-Reply-To: <a23382059bb57022dd1e40d1c2c9a11307b0ff3b.1617891426.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--USiXtFagnLiWEPLR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

this is the second version of my patch series to provide a way of
overriding the global system configuration.

Instead of going for GIT_CONFIG_NOGLOBAL, I've adopted Junio's proposal
of going with GIT_CONFIG_GLOBAL and GIT_CONFIG_SYSTEM, which allow a
user to modify the locations of those files. Thanks for the discussion,
this solution feels a lot nicer to me!

Patrick

Patrick Steinhardt (3):
  config: rename `git_etc_config()`
  config: unify code paths to get global config paths
  config: allow overriding of global and system configuration

 Documentation/git-config.txt |  5 +++
 Documentation/git.txt        | 10 +++++
 builtin/config.c             |  8 ++--
 config.c                     | 56 ++++++++++++++++++++++-----
 config.h                     |  4 +-
 t/t1300-config.sh            | 75 ++++++++++++++++++++++++++++++++++++
 6 files changed, 143 insertions(+), 15 deletions(-)

--=20
2.31.1


--USiXtFagnLiWEPLR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmBwWfMACgkQVbJhu7ck
PpRZsA//YXYIzaAer0GQR01SUAJBqJTivk+b/ZdeQY55PjBu8zvEEBj0rZJcTM3c
+vBiZ8tHwemL5irEGXLKW6OOyPKvVmuWlvAVFNybWcu8rnEF+hJ/ITSNDDAgwMg0
9qLaBhvDy9RmmRiBbBPy/b0Qp80pQLZtH/IXq/uNmZz+w24+g0dVMWGvKNWEj4T7
0yiKnxMpaZco2xO99ftlJECCup7PRpRpbUGMKaAEbMbE1nCi0aBPwivKp7EJvn0j
jyTVao6WtrAaNtBTr5dfI3ga34EL0HGdiVR1c/BfHEC94my4MIbF8EN7L2P9g1sF
EuvTWBkYXD4HW7dq6NLYJ3vA/oXPD9hHsrVKv4cBIOHZ9SCHuYs5GsaPK2qjYD5L
Iep2rCQbun9lBJITQ1WKa2f8B7zNKpvRsWAe5D9J5KEwU0JeNovfk1j8UCkhorWU
RFTyLDFKj+m2rqh/A5vQA44+JzbpSFbLIykrleVGlcTisYKEvJOUo8mWi+QBWdHJ
cPrYOvv1RPXdOh1B1LUxaR0U2lt7Yef/lK4H12bRNdTq6GRF9dclHiuRjbci3/lV
k7s5M6YwY64A4xebLYUjRRjj05ruQB854nPq9l5u6n6e2uXuEiMOR47XqYHZEsm5
WA5wUayScEFQIi3Fibj24IrIcya7JIz/xQE7iMQsW1Licxbya3Y=
=KJBK
-----END PGP SIGNATURE-----

--USiXtFagnLiWEPLR--
