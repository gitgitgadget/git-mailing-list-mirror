Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE4DEC4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A991123B77
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 11:53:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731078AbgLILxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 06:53:52 -0500
Received: from wout5-smtp.messagingengine.com ([64.147.123.21]:59577 "EHLO
        wout5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731058AbgLILxj (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 9 Dec 2020 06:53:39 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id B2C78B77;
        Wed,  9 Dec 2020 06:52:33 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Wed, 09 Dec 2020 06:52:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=1FgqTQMbV0qOQEF9NLkKlzpxKab
        eCCwbpa6g8gygXyw=; b=p2iBCCegnaIf3SNRwLy5m/sQtKqynaaWDzJcKiYi0yw
        GEkgkxdC1h5q6hnW9UFhhEm5Hn8S3IGpj1/C5Txec0zHZmwsjRHm+NAzxmhjr0KC
        mJ68YWNHzTs851+nUydxdou9VlRNCqUb9sCaTVD1WNRih5I9JDDyO2aqoIym+Sad
        gi0TR26D3vsMsNByUvLKGBMBLmMWdATu8qaePLRC4cUllmyimgq49qzbtjpgEVQp
        qeLHYf3o3jb50FjqwG5MXFtGkWMO8bZhb7y5lCHr4CwVZXHNmRWUTdYz62mi2NIk
        8h+ihC1XymNaE1UGIWVkpgJcyHZqgm4sgmFdAxWHDnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=1FgqTQ
        MbV0qOQEF9NLkKlzpxKabeCCwbpa6g8gygXyw=; b=IsrdZ0qI2k5+LUhx7wsKpk
        uDj/WMdsIOhbB5+GjJZ6vPEMs8DQfOkKFnvvwBz/4Q50y7dEYZomIbu1Zn0dGG/c
        w1utv7bRkUX0pYq+5VfteyqjuKdbeo2TXyXpTM3qSJvSvp87YUSPg/0tuP7b+roo
        ltXk/m1txeDgUZapZfi9QA4kEw4QXY/NUAgUa6dO/+l3Sh4AytXFj3or+3VYdpBR
        dXcYFiwYCwEQMhi0OZGTKaaP+GSytILyqXCPjUGObL24lDZ8hUL2pQesJfHTSD51
        YUE9TQbQeivdBwQFgMJQ4D1xghDMCtgQKVxqldDz+P4ISKAqJ1fj2lHIWn92yCfQ
        ==
X-ME-Sender: <xms:gbrQXx09CPc8ftEzOhOLShAyA2VVfVXB0Nm5RyYeh2idhJclBQ-I0A>
    <xme:gbrQX4EvHFrZ-rjXa9wO6SUF-pDnJWNFIjLUuqYvmsz0WgyuSwtmEHV56m0whZ2uB
    A_zNRRJVnaIv2R-Dw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudejkedgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeekrdehhedriedurdduvdeknecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:gbrQXx54-lDjbS-Gx7F1nroF7DjFvCF5jKdnK62xVqkBtEMhKlSEaw>
    <xmx:gbrQX-2EG4eUHtKKIHMNChvv0x8H5pcoZ-jSCRx9GIjf2HTouMtu_g>
    <xmx:gbrQX0FL5IzBmLmesKAVhFFxFnUrCc0u0AnlRVfHqEqqPoiRZiG3dw>
    <xmx:gbrQX4BzmrhnIJQWa2_3waiA-cGb3rs9hiVj4_R7bE0NhyZvRSDRAg>
Received: from vm-mail (dynamic-078-055-061-128.78.55.pool.telefonica.de [78.55.61.128])
        by mail.messagingengine.com (Postfix) with ESMTPA id 62D311080066;
        Wed,  9 Dec 2020 06:52:32 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail (OpenSMTPD) with ESMTPSA id fd7656f0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 9 Dec 2020 11:52:31 +0000 (UTC)
Date:   Wed, 9 Dec 2020 12:52:30 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v4 3/6] environment: make `getenv_safe()` non-static
Message-ID: <e6b110c3e3a0ec27802c4315c2431fa24f404551.1607514692.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1607514692.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="x4lXJmpJ6ht124iT"
Content-Disposition: inline
In-Reply-To: <cover.1607514692.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--x4lXJmpJ6ht124iT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The `getenv_safe()` helper function helps to safely retrieve multiple
environment values without the need to depend on platform-specific
behaviour for the return value's lifetime. We'll make use of this
function in a following patch, so let's make it available by making it
non-static and adding a declaration.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 environment.c |  7 ++-----
 environment.h | 12 ++++++++++++
 2 files changed, 14 insertions(+), 5 deletions(-)
 create mode 100644 environment.h

diff --git a/environment.c b/environment.c
index bb518c61cd..2234af462c 100644
--- a/environment.c
+++ b/environment.c
@@ -9,6 +9,7 @@
  */
 #include "cache.h"
 #include "branch.h"
+#include "environment.h"
 #include "repository.h"
 #include "config.h"
 #include "refs.h"
@@ -152,11 +153,7 @@ static char *expand_namespace(const char *raw_namespac=
e)
 	return strbuf_detach(&buf, NULL);
 }
=20
-/*
- * Wrapper of getenv() that returns a strdup value. This value is kept
- * in argv to be freed later.
- */
-static const char *getenv_safe(struct strvec *argv, const char *name)
+const char *getenv_safe(struct strvec *argv, const char *name)
 {
 	const char *value =3D getenv(name);
=20
diff --git a/environment.h b/environment.h
new file mode 100644
index 0000000000..d438b5c8f3
--- /dev/null
+++ b/environment.h
@@ -0,0 +1,12 @@
+#ifndef ENVIRONMENT_H
+#define ENVIRONMENT_H
+
+#include "strvec.h"
+
+/*
+ * Wrapper of getenv() that returns a strdup value. This value is kept
+ * in argv to be freed later.
+ */
+const char *getenv_safe(struct strvec *argv, const char *name);
+
+#endif
--=20
2.29.2


--x4lXJmpJ6ht124iT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/Qun0ACgkQVbJhu7ck
PpQaCxAAmHmzrUJVIHDs6WCqXG5XdOGdCTthL827DZobq8reiGthI9ezqK9V/DYb
fyRhPwZNXF9P/LnZcl/MbY9hqBFLg1hPY2EO7MWt81EfSI62vXJvmC5iJCar+hfw
X+aL7jeiKJEFSMbSFz01l+b4VWLUmvt8D6UVu5/VslAzjg9poBXn8au8D0aIDw3s
Kkpdvgz1fKrnzVbDYgIDT54eNf5jNsFGYKY4VIM507fNBB56R+y74hl6hCJU5g2j
XJTVT7/iiPHGerePFzYLlU4rWTQoRtPMy46+oMjrBDSqPjQ8+sjD4R7WCXB6zWid
wXuI9qqeqthsMzHMdaOE1GmkTboFyTS8gvF8lMoH6h9hnBqZq+j1AcDP0FBZFpCx
8jzkU0yjUCk1WcfatM3HBIzz6Fc+BLzGnLxnIwHFu73qfVpcL/uO8B5u01BhaOZW
3EKuvRj7LN8QqfMBWy9UUYjdQq5xXrEO0xD2pYGTwZfq3H7dC7gz9g4OoSyBffPJ
BTHkQwQt0MWWDpOypLx4ZebyFFhJwCC2GO0SUzKiLm2+qneHUczdlNl1t98od2Ci
fZsAgrVntOE800JlhF19rPaRHTBhirehZcIi0OLU0gSQ3TfigRZqsp5fvWfHr46s
sS0OiJJ/OLH8/ZYjDpF0+MzKiNXXSCblVrOFMk5fhCiaV6nSBD0=
=VQL2
-----END PGP SIGNATURE-----

--x4lXJmpJ6ht124iT--
