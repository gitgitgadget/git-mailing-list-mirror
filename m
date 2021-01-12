Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6649C433E6
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95CD023110
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:29:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387401AbhALM3A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:29:00 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:45487 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733015AbhALM2t (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:28:49 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id BE4511B61;
        Tue, 12 Jan 2021 07:27:13 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:27:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=U1+40+UHQIsPAMpciXrArYnK6oH
        PN8/WXzdZUfgKp68=; b=ciBlEONcOl4nj6nJTyvtA/LpQ987Euguzd5p5tRBSW9
        niVKIu+pSZHE/BC7R8G8ixWtCeIp28R5LMTrg6LQ3Bv2w8mXFA6NsLja433cP+8G
        WB0ecPSJ0dsDhYQ48UwdehSweLLKu8bh/O8ZNoSKHybRCBWRtB5lNiuXh19gxEcO
        x9GKbVWAY/79O8nazHRF7wP4f66rwdVVWBOuBL9Db3KRPYziRpQ9nDleCZeeAjp0
        AqcwT0uwtIreDMRq9d7PPHuUvU9na/2AgfNJFO4owFevNWGzLauD0mi84yCn0Emq
        KAaP0HOH0Dhi+jQf7lWI6USupSa6HdSFtHC8Gocys4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=U1+40+
        UHQIsPAMpciXrArYnK6oHPN8/WXzdZUfgKp68=; b=cavIvhQTrmLQKoSlGLsmtb
        7keBtuBWfALQsczzbifeRM0lkey93ia+fR/Gv1dkSXWMO7cggm0AZDC/EyvCJCI4
        SSdLO0A0YBWFRTzjwK32XZP/p5IRQuN2J/BQlNijK6iQuxwyg8+/2WSdoXfN+8HR
        2lj1mjc7VnxmnLgfFcEZVDKZHGe+BA8u5FWFP5oa2beZzNthzojA25FlC5L7fvtA
        HRqo1EgtSZA+jiiDEPWdWYMnpXxJVpscxNmIhIUi1I10z38fy7MrbwUV8LSUpNeN
        55VWto4HAtPg10kSKddoBtNDBOWSWb5Vc3ex5F79zs5LYC9sqx+j9F1Ez1CvjzCg
        ==
X-ME-Sender: <xms:oZX9X61LIDI7h2nU8XYWGqv0JHeHNc6LW9Ng7YtqZCw22uem_3Oryg>
    <xme:oZX9X9HCL22VY86GY3S_Sx-R6wGXFBwL__INfWIxjLhvmnf-QJYcElOrgQO479GEW
    0d4ZXBaYc5jE1BuMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepjeenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:oZX9Xy4RajQWTV6KE8hcTlbgs7ZTqiRPWeTuWSEeeYnhYCIKO6OU_A>
    <xmx:oZX9X70Q5Jta_n-lFTIOTXTGBQk5EMVd67J2jJWMSHK0ApehaMUPcw>
    <xmx:oZX9X9GypNdBiqeqLhMOmF1ivk58lQd6RFSD5oroLNfr6fHrijqWgg>
    <xmx:oZX9XxgZVeA5g3L5OVevnGNOYN4z7GlVlVpay19DjLEfwwx84q7NjA>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id 8577E1080057;
        Tue, 12 Jan 2021 07:27:12 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3d164d5e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:27:11 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:27:10 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 7/8] environment: make `getenv_safe()` a public function
Message-ID: <28cc229adeb4eaf8994821f0312ba7b84a6d618e.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="DrmLjoQvWRL6bnSG"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--DrmLjoQvWRL6bnSG
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


--DrmLjoQvWRL6bnSG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lZ0ACgkQVbJhu7ck
PpT4cxAAojjOflWdzqtWX/oo+Q5/NNmJiV+1SpcQyeJkRqvyKPpL4GrfLw30W+/l
dKACsdCCGKSn4ASCKs+hQje1n5AeMwOWCG0y11xJThO7uDbU2J1AQwL6qPu1ZO10
pW2klP84vJ1ON+5svR1Clz07JWJb5mLqnubPPccnYbMoSPi5OjI9xIL1mu0J85zM
ytQVGqFSk9tMzl1XnCzka6gmIimG6f5xSjPIw4U3FCHjKmrgIO9Iet9vIt7FFDZL
vM9lYefqZ831k9cUeGArMBWtR0rXNe6Z7Ey6XY96bg12a7Az9+4QX/rdC3XLGmc8
ukIrzoK3Q7h+4W/ugnRIS2Va6F0hk4Q21CakEkVB4FSltRg9VX/Px8XG1TpeOisy
e/CtCl5ipCxHhBlkXsGMU6OjEmB/mohhmVn/s5jnfYVum4ga7nyjmZ6iwQSf6cTq
wT9rlstaiZeYdeh6Psv7r5dsCq2/XlTVyv8ds4Hypi8tjC+jX3iqnCkpdv1Gd9Dm
N8mr7q5kqiXxJacBnLHrM2hibg1ILUZxM39kPfFWCxdaNFJdfftc8slACFoXN1ky
bKp7ZAV+MtJe7Gp4H5LnEdSw+F7axP8LxX/dmevSI03VqHbUtgFbaGLoKtqq+X8C
N1onUFnXzclD5styo5pwd3RUrwtgD5TDHaXF3U5U2EwJevy9QeM=
=aW5g
-----END PGP SIGNATURE-----

--DrmLjoQvWRL6bnSG--
