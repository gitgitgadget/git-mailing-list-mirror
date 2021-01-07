Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62E0C433E9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C468622E03
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:39:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbhAGGih (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:37 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:57561 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726712AbhAGGig (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:38:36 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 4662C5C0174;
        Thu,  7 Jan 2021 01:37:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:37:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=RZTxXbhaK4gCsG7tzYUxxdlUHj4
        CtFOBipNoLebr//c=; b=L3Uyd/p4OiqgaZmA4BUGiKeV9t20KLVN1rlCxcr7v/G
        rnaQyE4hu5dI4E2AcIKWJVDWmEigdkOWtlRx0+L6yprsMHkdRE6zbul3GcT1bdYY
        /0Lk2jrD2+ZhX650ZqOqAehH8N1adRQJlVIwm4+ozzbzgQWIdk2YmU/d4Vcx+Kig
        TZmhxgb8ZIqGJehMkyAKG3xL16SrNe3EIkQJVJtM4Z/ZaRbf+hVvbOgZluGpjBoV
        /5D/f2d4pomMBALoMVpsO/JSLMxPww565HXCtSuzHjPPEgRFCEup3npE1E+EN5qV
        RiKcyKh48p4oPal62u17x2m8ssr9NKWU46p+honkBmA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=RZTxXb
        haK4gCsG7tzYUxxdlUHj4CtFOBipNoLebr//c=; b=RobJ2m18CX4oCGw6jSKw4R
        pdn0z1iWopXKTJBPQmESFy7MdUPgcyjySYCQBSkWMMOtanWN2zUrypLKv4bjxWUw
        /c7WRa6gE+Bx7Xzjpf16tYGaFhWl/SiEHFF+f5SXDFNwDrqjNIK2ITJAjBpFzbS1
        hwuySs9HwVk+rsAc1jzcvkPBUc/wUJBjNZvMECn8AA/zOYdA4uKY2thFSTP/bsMr
        Tf+2R+qDjkaFM6LgaLLRjlX681esm2Sdhz7Za4AD1i7apOS9GJQwYzNppZ8COkz4
        f+7plq4RUgbYOlbb+dVChbGDxMrNPNEWDDeh11+iOz2KC45PzmAmpNj8JBVDW/vA
        ==
X-ME-Sender: <xms:Haz2X9J-TRONhR7RH1sFVFiJQb5T8dq_38_UrM_oORKyO_8u6KdMJw>
    <xme:Haz2X5LHfSUATycD0CzM31xfn0Bi8u_tNG4XuFtqeJtUPmX5mhcSBxCQtG9YH_V1n
    wObmVYo7_rYhWnkXQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepjeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:Haz2X1t904We9RLo8l3lQLhCQ7qCMstN16aojWeXQNOiocTuBbbE0A>
    <xmx:Haz2X-aNc7yulUaK4CMxCQVINvN5mxqx1wYiD_HaJ_68v0ZPUVTi_g>
    <xmx:Haz2X0bT-45UBlX7CptoJkuPjA_v-oEFeF-LeBrtLgpnmqeq_3Edsg>
    <xmx:Haz2X8Feju0K4xiXIJj30jUh8cpd3CavZLdex5ALyg6eKrG_OVOt0g>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 5332624005A;
        Thu,  7 Jan 2021 01:37:16 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 184fa0ab (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:37:15 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:37:14 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 7/8] environment: make `getenv_safe()` a public function
Message-ID: <cade8fb12f125ac8c17c448b4db2d4a6197cdc29.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="RKx0ypCJJxW1NTTZ"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--RKx0ypCJJxW1NTTZ
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
2.30.0


--RKx0ypCJJxW1NTTZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rBkACgkQVbJhu7ck
PpR3IA/+Kltkm5dDOTfqp6A23CGmmhyRMOg1EbG/ioCtelP3033XR9UsD3lczTFv
wraLAhiSOoGLMYmFjQ9Nwp9GztzQAkHTNScl3XKGUApa9soluiPrOW0UUOOk5Trg
yWUhaW87KKuyIuvZn8ZvWrsvSpQEpuVGj8CfiuWp7SxARexFPXv0BwPd9DhpSOOX
tbAEZLrfJYY8GjCZKBo7neFNOE4oxrXQuHoFOuaNDuAZ3vAmmo+FNRVV4n6vEATT
/FbJjQwjasxXoxsnZb4+g5ao1IdZHKUn80RT9KhtuObaJBLBtbAttqXWX/Nk0ZRS
JA9DE0r6PV09guZqfnfWQoLF0RQo9a3H408mTWsc8/GKSMhKr2kjczNjO4g3GKlh
1R/lgbHJ9xfeckEpJmmLmwz+U/7VU48gHqQkiSYvcneRf7dg5E8a4UEqQUOitiD4
SY1LLfAOnu7lpA9UxwmCxEOHnGBpNq1VxKEJgutLcvIFUCGYyS2nVBnTwrfX3lRy
gsqUkE8AxBFuA+bJWx+IFkxF0QIn9xe2BnLShqICu1REDKvQl5yDibpDLYk6VQ0c
hXlFEMO3RPyyegRS5bAe6uv1Ka9A4MFrtjIZUPIciJ9nTDBxvdScBGVuMVN+rktz
/UyVo96KvmpnRYwNeUHDdVvVwoegYoEJiNp8vd+dojW4ss6KNGg=
=Yv5L
-----END PGP SIGNATURE-----

--RKx0ypCJJxW1NTTZ--
