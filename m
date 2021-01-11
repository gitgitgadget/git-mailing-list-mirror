Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B9DAC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D01BE22527
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728037AbhAKIic (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:38:32 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:47479 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727785AbhAKIib (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:38:31 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 3FA4C2524;
        Mon, 11 Jan 2021 03:37:15 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 03:37:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=/nuzo7NbhJ76GGnAlH7CcXehW74
        KrjrjkhP+b0OrHCo=; b=QDxg2y7YXqmyPslWRq//7Ys0gSAVT1xKVag40AZiCvD
        3dqFxELF2AYAF8cE+GOY8bOQ3YReyIQpTrLQGXhWCb7l98HZRJZqbiTq3CZQnju9
        3gcNSSftiWWUSb1FoFB/c+KVD9Ilg4SuUNjUeouQ+bwMeUtqHMxKzdVOGVznuilr
        c5Jefegz0FCv95QkUjQQ9sXAn376FHKy5O52UXNJb3SAEhqSK/1TV8FN+EOxIIgc
        +qxS5UtMdYM/5TIC1ryp3RZ9Ta3PbFmCIgS5JzB2U0ePairqDFaa1Hb7AmarPx58
        yvqpCMM7DIw8QhKg0LuvVqrvoIO+YqF5LhYnfSBuU9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=/nuzo7
        NbhJ76GGnAlH7CcXehW74KrjrjkhP+b0OrHCo=; b=ZKna7SoG9zHi9wv0PWMZfU
        vGhvDRz9HUmMrdKTYpHOaPdutJfPjZSunOGV3sEMZaMCIvajzdqQe4Xq01k47vpi
        lDIW0XRF09um28zUrbifUAlW70rFyAj7aYHR6kVLhv4DZ8vGbIx/3tfHXVRI3y/G
        gVD0NpUforR4Jp5oG7AfMJTVlqfUAlPJAUKFWKb5oJkMERUu7KBzqZLD4Q5SYC5c
        q7t1pk2CGRB4B2vxKYNoPFWXdXRA++paOjcZ+viyML4g5jIsPyQgnW5LI9fCp4Qz
        RlM8GPoKo859RDqMZ1i4MVYQkeOc3NOFELf1AQy2xJZJBwsqbDk3fBIv7g6Aspdw
        ==
X-ME-Sender: <xms:Og78X9mfJANa6RltMHpI7VBBsWpOsOY_x_mFzNW3QRwhOOMKdUJ_MQ>
    <xme:Og78X40hNxDNUhlkD8cqmTnGboxcbzxG3ooAm80I0r92WYU5-y992KqUvOMJbYkyq
    W2hD81HiMYeEJa1hQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpeehnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Og78XzpP-poyXnZutO7gg-6y0gMwwM3Bm9P2FiAXQ6ci9sBURW7JTQ>
    <xmx:Og78X9lDHXouzOUN2gkADimtZxlq6f2GCevWSTlhw-dQMNHG9qAY0A>
    <xmx:Og78X72duj-pSG7JUilR9623lr8Kk1r98zTXCsNg-fQ_W4_DLS1Jiw>
    <xmx:Og78X2S5-uZHCqzvpDG_GT7UWrCm5bKQ3G3ZuClhK9vMG-nfW9ij9Q>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id D701D24005D;
        Mon, 11 Jan 2021 03:37:13 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id c8ad9ca4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:37:13 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:37:11 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 7/8] environment: make `getenv_safe()` a public function
Message-ID: <6c1800a18f3216541c79fd7809f8f6a6338ae317.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="25sm+XsfeIxY80uN"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--25sm+XsfeIxY80uN
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


--25sm+XsfeIxY80uN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DjcACgkQVbJhu7ck
PpQQOg//d8CCuwiQewxzFw58pu9KfrMX6vqlYL/BDNJVlwsVG2MwPQNeEbHw2oHw
hmVEzAXMhIYCs9yfdj9Wnx+jWFnWDvi2yD7K1Tn4IEM1fETog8WCJ0+4+X8Esp4u
/8f6rY+E+zLjZ25AxhXJFZI00iTbZpUn1fCHuemv8X25uX1O0IqTeqYpHV6JkYCW
Y7t29kdFTE0e9qPmffO7hgMSZRZhz6LKDAfF4n0TeZ1j+dR3UGpXk0fe8F+iD46M
txF/INW2YIib7yoSykOJb4dyWaF4NUKU5v6AakHYpup8KvXAbBZPVPmzbgDsgkQx
6pm1ZGXoakM32uzXkWZEQjbDRTv+lOECUIM0ux2eoxqldG5EOs00ThIckSS98LPd
VzgRDLC+tCU7X3rk1m1qRvsr9m5aUmqnlDcNupt2PZnQE/+l4iKSnkCaV6H/6/MP
Pfk3eP+RYwnYIOCfSXVrWZqfKvcDt65bwI1uRfEicknvPXmBnppDvL8uuYbQxXWK
eyKLMHgvWxnbdCm45+V/eJ8mB8TdZg2GRnzJaxEnIFlh+dgCpm4Z7NO5IXHKS6QT
7/dj1rJgteH6fZuQ1j1gD5NaDiKgJBds9kHjMnZTXJaATaLdjectTNApcwBhAuqK
1ALVCxIW9WtPSsihlNzJkSgjtC7OW3R1ZQUV9zpwNNLnkUYuRwo=
=Lup0
-----END PGP SIGNATURE-----

--25sm+XsfeIxY80uN--
