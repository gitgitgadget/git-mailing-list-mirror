Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DAF97C433E0
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A844A208A9
	for <git@archiver.kernel.org>; Thu,  7 Jan 2021 06:38:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbhAGGiF (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 Jan 2021 01:38:05 -0500
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:51153 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726581AbhAGGiF (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 Jan 2021 01:38:05 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 1C85A5C0160;
        Thu,  7 Jan 2021 01:36:59 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 07 Jan 2021 01:36:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=acycrAqaDWKRJUGa4bI/EvvKSUo
        OGk7AnHY+BQHj2Cg=; b=OqYc9S1kZ6cHdAnaqF/HZYHrQnbT5FQcm8JPTH6ioxy
        MsZ0EPy9t2B63zQwzA9XQ3Moz5Nk+Z8Z5RkdYnR5LEmts2iri0d4rTcYjY9pYC1g
        MtRWDFHG/Rnml7tMASfeIJO2iVrpNkntJLv1N6zOCsaoGbsF8yuN4JcHh22eh+EH
        PK2gyPUNe2LBnrC/8obN6O7IUApM02Xnj6bHz/0sXvv0SGjoBuKNEQNLRARFZwDP
        okWKdYrbssKfI7KxVeuIbzhSujqKQ778VrX7I8UzOAxPZSFm0IZU9R9raQ2hLbyM
        fsvRYWMokQ0GjI31a9ZmmRwJDDXVUL1EXWtdkrxyM4w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=acycrA
        qaDWKRJUGa4bI/EvvKSUoOGk7AnHY+BQHj2Cg=; b=Z0kFgOMYpEapU/4oVuHBCw
        p4p7mLJYc2vckH26zJ4OKBn4cStp/eBOHuoioJYSKPescZjnE/LSI4t7ed1VL69s
        wW2/lLcTYw30n0aPu1DMtUj+wA2Fa9tc7DXAB2xeAFQyp/v7bn569ur/5pn2mgL2
        wxLy6Wi1w7qr5mQJIM59XSacjuESdzKnTX98iDwXnAAzTbD9U//MM9tovj3BO0mm
        4lFVMRLMrLT7yzm8kmuiD2W4w56xm/pRS7nqxPVEGALHhPtI4Dq+cK4vy25rDjzM
        9tHKsQarcO/BKM8ynvgqC0uhQa2OsQ1qQUKXkSh/aBXNGYCbyYGQqLLtTsdClmmA
        ==
X-ME-Sender: <xms:Cqz2X_9N0ku3TQ6cscRUjTmn4zelhrSCTJWQTznPfZ9RaLj3E_SyyA>
    <xme:Cqz2X7trqIsJ-Sk4Ik1lV1_LDT9FcP4hcM9NgjDoH83rg6qpWeYxxQfTZAY9vvZrl
    omfmqSYONWVNmAX0Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdeguddgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepjeejrddufedrfeegrddvfedvnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:C6z2X9A4RDnZKMst3Z-c68N7OTivWsfWonMqZs3qgA6fmyb-2LOqLA>
    <xmx:C6z2X7d8urHUDZexu9WII7rw4j6iMTlgAHVqYsauOoU-WuIH-9ZqPw>
    <xmx:C6z2X0NIax-juq5LCnal4xfqJSkF8fVJ_FoMS2bLheV-nMcDyO-F8w>
    <xmx:C6z2X5oaEQLVc2EH3XlW3KSmHDG-60lGnYG6GpRydxmW06ivZVIoXw>
Received: from vm-mail.pks.im (dynamic-077-013-034-232.77.13.pool.telefonica.de [77.13.34.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2965D24005B;
        Thu,  7 Jan 2021 01:36:58 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 5a3b1efd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 7 Jan 2021 06:36:57 +0000 (UTC)
Date:   Thu, 7 Jan 2021 07:36:56 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v6 3/8] quote: make sq_dequote_step() a public function
Message-ID: <9d4c8d7be9e8d358c7b342760034fa90676ed524.1610001187.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610001187.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="QLiMAED3dXP+EOzv"
Content-Disposition: inline
In-Reply-To: <cover.1610001187.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--QLiMAED3dXP+EOzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

=46rom: Jeff King <peff@peff.net>

We provide a function for dequoting an entire string, as well as one for
handling a space-separated list of quoted strings. But there's no way
for a caller to parse a string like 'foo'=3D'bar', even though it is easy
to generate one using sq_quote_buf() or similar.

Let's make the single-step function available to callers outside of
quote.c. Note that we do need to adjust its implementation slightly: it
insists on seeing whitespace between items, and we'd like to be more
flexible than that. Since it only has a single caller, we can move that
check (and slurping up any extra whitespace) into that caller.

Signed-off-by: Jeff King <peff@peff.net>
---
 quote.c | 15 ++++++++++-----
 quote.h | 18 ++++++++++++++++--
 2 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/quote.c b/quote.c
index 69f4ca45da..8a3a5e39eb 100644
--- a/quote.c
+++ b/quote.c
@@ -116,7 +116,7 @@ void sq_append_quote_argv_pretty(struct strbuf *dst, co=
nst char **argv)
 	}
 }
=20
-static char *sq_dequote_step(char *arg, char **next)
+char *sq_dequote_step(char *arg, char **next)
 {
 	char *dst =3D arg;
 	char *src =3D arg;
@@ -153,11 +153,8 @@ static char *sq_dequote_step(char *arg, char **next)
 			}
 		/* Fallthrough */
 		default:
-			if (!next || !isspace(*src))
+			if (!next)
 				return NULL;
-			do {
-				c =3D *++src;
-			} while (isspace(c));
 			*dst =3D 0;
 			*next =3D src;
 			return arg;
@@ -182,6 +179,14 @@ static int sq_dequote_to_argv_internal(char *arg,
 		char *dequoted =3D sq_dequote_step(next, &next);
 		if (!dequoted)
 			return -1;
+		if (next) {
+			char c;
+			if (!isspace(*next))
+				return -1;
+			do {
+				c =3D *++next;
+			} while (isspace(c));
+		}
 		if (argv) {
 			ALLOC_GROW(*argv, *nr + 1, *alloc);
 			(*argv)[(*nr)++] =3D dequoted;
diff --git a/quote.h b/quote.h
index 4b72a583cf..768cc6338e 100644
--- a/quote.h
+++ b/quote.h
@@ -42,12 +42,26 @@ void sq_quote_buf_pretty(struct strbuf *, const char *s=
rc);
 void sq_quote_argv_pretty(struct strbuf *, const char **argv);
 void sq_append_quote_argv_pretty(struct strbuf *dst, const char **argv);
=20
-/* This unwraps what sq_quote() produces in place, but returns
+/*
+ * This unwraps what sq_quote() produces in place, but returns
  * NULL if the input does not look like what sq_quote would have
- * produced.
+ * produced (the full string must be a single quoted item).
  */
 char *sq_dequote(char *);
=20
+/*
+ * Like sq_dequote(), but dequote a single item, and leave "next" pointing=
 to
+ * the next character. E.g., in the string:
+ *
+ *   'one' 'two' 'three'
+ *
+ * after the first call, the return value would be the unquoted string "on=
e",
+ * with "next" pointing to the space between "one" and "two"). The caller =
is
+ * responsible for advancing the pointer to the start of the next item bef=
ore
+ * calling sq_dequote_step() again.
+ */
+char *sq_dequote_step(char *src, char **next);
+
 /*
  * Same as the above, but can be used to unwrap many arguments in the
  * same string separated by space. Like sq_quote, it works in place,
--=20
2.30.0


--QLiMAED3dXP+EOzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/2rAcACgkQVbJhu7ck
PpT7NRAAoT/UmhkLcosBVa75JYP/JQqEWb/3MHC6w3gw5aDyWKVp8CJWtin+xBV+
jUA8d4yoPd7qhubRe+rTOOgiLO8+4YW50bpDLuoipG+ima663fXoSVmUgw5Antrr
dM9WuCg/FcQUbQ8Xnl+9FbUTgFL1XtQmFVTv6y7KGmIpucbSoP63lms75Owg3ms9
nLpNtlbB1e7QxQPMqgmJMI9iovMLvcBiCK41vp2apaQpKhQfOi5k+3HPsoicNH3g
mEDo/Yox7sR/9N9TDnB7/s2DXkFETeKZ6oP7moUiULGmiz19XG4vyk60Z73l/Ljb
qzuv0Tb8e/6rE0YVAt4WD/V/ctKWF2OzufsiQSk0uByrs1C9Gw0q5tJ2U+Ylf7M0
ktYKOrDKjc81ZZPED355BDClU4bwmJmE1jFQhx6vqaPeDSMkokNnpmKh0pKgcg0t
SjhOB4jDxufE4pvj84AIvi/8H6tx/dCIRIkDT+bruzkhfVyHJYR2Z6t1aKZrp76W
bA1p9h4dUPkttLUGduaGC/FFQViiLnOpVh0NeVBsrroxMeGaCp9X6O+WS27Ft5HZ
SsnDZzdOgf3jMdQUlMsjzK07UxXfCfStLiM0CKb9cRNByflfqmD9VcFLMbCp7GW9
Nv//SakiHi4M2RAE/hYCv2U6yhmKvIE1L0ngjRAKVc7LokV2tOI=
=wTqZ
-----END PGP SIGNATURE-----

--QLiMAED3dXP+EOzv--
