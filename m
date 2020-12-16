Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C6CC4361B
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:56:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 842AA23343
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 07:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726124AbgLPHzu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 02:55:50 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:33567 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726111AbgLPHzu (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Dec 2020 02:55:50 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E2D25C00CB;
        Wed, 16 Dec 2020 02:54:44 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 16 Dec 2020 02:54:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm2; bh=SasF7DXemqhWwtoSG4fnpd0ZgKW
        mszrzsZcnYW7E7SI=; b=T8S5kmzHoEOgWs6ShC0SocWICVQfek+8pj1fmaz+k9D
        WU4EdGI0pwUXADh9V9wOUAjI5gYAfYkrAzDYzm4BctRAwjnlFRN3+E/9Fq5bhRGf
        Z14YGg3QS1bwwFbsvtuxlDXaJqGDijl1Ude9+BZP7Y9cMtYlBO6WyZrmBvBQmIwu
        nlwZJMEuJ+vZOlSvYgdTOGlSlZUaMjayIQvXBlPafL4Q2QEgR/JLTnpyXg0GqJra
        DciyE1z5yisBscEBfK2P5zgsO+PeCyHI8Lm7h4rZG77PVe/bIKKJSshW/mbdY7Eh
        Qan4q6bWl9EkowGrMkiv7R+mnLNrBix0A660XcmHeOg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=SasF7D
        XemqhWwtoSG4fnpd0ZgKWmszrzsZcnYW7E7SI=; b=oJHgNtHtEr6KNvr1uIkt70
        K8zc8FZXJ3lVMglcpv97BUm/den1RecJWS6948zW+d/Vz/3ixPsDU61vo2lvMyMm
        CtYhvf8SkjSvZYeB0wnG1ZzAJYEW3td+JCrOk6sqoysLZSow7hxvkNtPMDZJvQB4
        eVsrozne70/bPznJAsVcZx6VetSIIfGmn6wF9ZCJ7MvRZDa6sNuWa/aLw6miskwf
        LDMVfhizVO7MIx68xiPwNNkcxS2msE5UTWfT3j7hz7J/8XU/m5NijPnrARVmSDby
        edNd0kJuXpuh3Nf3sk72yzvRSYDOtHPqQnJuuFdGjDq0fPDKbupkk8gBlOYX8gxA
        ==
X-ME-Sender: <xms:Q73ZX9nq0S_DDk9HuwHJ76wVILtESVJToEujx6DYXrcPOmyaBzCe-Q>
    <xme:Q73ZX4x14QtmmnhBfZI1DNWsxfBBgmOHJJaH-m69Xyq-eCGQRkMrj_iYUvrphY0D2
    QS81FtyOJqzFy5MPA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrudeluddgudduvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeejkedrheehrddugedrudejheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:Q73ZXwjKzwS4y9pSwolnFn4UByERRdonHeVQoJEu8TzPcaZwZNyo4w>
    <xmx:Q73ZX1UiB60tInzRtt1qLoc6o_sF9ZxNiDZs1RpsI31qmYC95mtLww>
    <xmx:Q73ZX60FPYDdQsUG715kpm7UlR5XIeFFQzAqlWMHsCbyxv10nPkTvg>
    <xmx:RL3ZXwD0WVeJWS1doHQq0aEVjKARRB4VFi7I-xioWA7qhPoEYNIFuA>
Received: from vm-mail.pks.im (dynamic-078-055-014-175.78.55.pool.telefonica.de [78.55.14.175])
        by mail.messagingengine.com (Postfix) with ESMTPA id 9996D108005C;
        Wed, 16 Dec 2020 02:54:42 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id eb65c6ef (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Wed, 16 Dec 2020 07:54:41 +0000 (UTC)
Date:   Wed, 16 Dec 2020 08:54:40 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v5 7/8] environment: make `getenv_safe()` a public function
Message-ID: <2f51a0c5fca7da1a6d563da6c9747f862ba0700a.1608104755.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1608104755.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vXvBj3O8zedHkncV"
Content-Disposition: inline
In-Reply-To: <cover.1608104755.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--vXvBj3O8zedHkncV
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


--vXvBj3O8zedHkncV
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/ZvT8ACgkQVbJhu7ck
PpSXZg/7Bxcy8Hrp2yJJJnqu+88qVXqDFGZKDil/WyJjzqRjm565xd7WCiXEGKqV
bXDclaMRAVpSVkOa0hAok7JvO4hxWOzBohVSMeM2r6sg7DgtuABhUZU+YygXoYPl
m4XzNHRrC8/Viu9A9xLGw5k6R7OWx04Jex+Pts49TxZ3V4uZxF+GzPj+5J1bs4BF
oNlskpfDaGekajEpEKimTYKbfoZDd+3FHwZd9svhNfhSKb0Ybg6N7UDrlUp3YJNi
wzkVcA+l4y/+SHH/E1msW1hbBxkznMA0gXRBHET2dypXpbICMpmI7oc18F8JYQSy
rt7Jg+y2kTiAz/x7lOWpI2adcqR+fZj4IpTjWW48+fsgSq/lPMI/W8i8/UlkBY+E
FfZ83G9QudBFZ1Vb7gHMPNnemGjE/5mWjeKuscHNOO6G86EwgQWoslKf+dDofV/T
k1JV2T6YBQ4XpnAhV+gNRL2lRMhQKRR0MpsKUiZaOly6I3Wgq5PJNgTJXCm9xeJ6
/raK1bsSzS07nfRHr9fAsxav/8xyIVu9aPwjHjgqPAmVktaQq9b1vwpwvRWtxw0F
4hCuQS23eISZdSgNawtG2Tf9P+CeL3BdGHEcNiya4p+8s4b7t8hGecR/dZiyNAH7
Tt7k5DEsbvTVA6vd5Ju2BUHmZOgmqVeQOK96UNt+iPSDKovykuY=
=Cz9F
-----END PGP SIGNATURE-----

--vXvBj3O8zedHkncV--
