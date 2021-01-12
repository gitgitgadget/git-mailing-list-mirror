Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C943C433E0
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CFE8122BE9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 12:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729301AbhALM2A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 07:28:00 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:51241 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbhALM17 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 12 Jan 2021 07:27:59 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 576BA1B58;
        Tue, 12 Jan 2021 07:26:53 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 12 Jan 2021 07:26:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=xgbFHpLhJsUiGBhQ4u/GLhHevvf
        U+ADpnaT/fOqcdao=; b=Qpu6XdO/2KDulT8zUWvAsku6hM3RRkuYy2+hYwew2w7
        amfgsIaQq2upv9Zb56kmoJjFIw+ifATnPVSJVVAA+33PSd38wwrDPcrhWYPUhYTe
        D7EYAUC+FBXEg57Dave+ojxMqICybDipKoEA4ueMU6ITI1G0wbrXAQcjnuSK7u39
        jgrJV5Dk21HTWiFpZ7o20pBFu+CrmVn4PsEsJ0aO6i3U4O8A3FBMqEP5ZbVouiUe
        P4P4w7N+/6K2LVDTciY4RldKInBumvzPJA0rlShMde3aG3YKwe+S0xh5/Fo8W6/J
        60v16Z+oOlQvzHte7BbvuSPerlRkYXZ62SHjII5lQ2A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=xgbFHp
        LhJsUiGBhQ4u/GLhHevvfU+ADpnaT/fOqcdao=; b=ieIhcjvAMFc1XzREy8ufFB
        I2BgOJbjnzMTNQChKJ8kdGTw6SJypIWCycm9Uo/JITTyNTd6Y800xe+GDSBqhArl
        T1PQVhMVzt2vfKRIZd7koB6EzZCq8nL2TKaWYsJOcd9qgOdGUu78hVzlXoOcvv9v
        WhT7wkxT9wPzCt+iQO9PZr29z5aoaRIEXgBYWo9gkaxis91iXRgS10cT8AvDBWiV
        bHRdzbNk7VixPwyzJ10CnRP4BwQnLMK0rZ+38AXufI+Gs+WbE4A0orx5gllAH42B
        kulE/WnUPfVikAWZ9G/fBhqoyLrH2gywyKNpZtrtlquGwrUBe/Rvv5EBoQYZ5YsA
        ==
X-ME-Sender: <xms:jJX9X7lESO2g8l2oaKTUnNEHssmnIoNtlO2VeBCA_ObNa_WkLBvw4A>
    <xme:jJX9X-2UBQaNNtP_BJbryH82lkh5dunrGmbCN7r9jF5RomBsFd7uBIhQ_A46JQ95r
    77I3Ugs8RROqo-EAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedukedrtddtgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfhnecu
    kfhppeejjedrudefrdehvddrleefnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrg
    hmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:jJX9XxqvCVxgHlWcgnt2TIoQ8_5f3DefZlvm6bha3eiQIXW8O3AgxA>
    <xmx:jJX9XzlWTCCM-avwCcmIUrgWnT3RdiMfF_WTqWNAfHkWBdQq6byzyQ>
    <xmx:jJX9X52wx3zilh_7ci96NMXoneVQPInsfl8VO1wqJgueIG3RkvguMg>
    <xmx:jJX9X0QT0lEUzXO87Z0rXcBL0dTY9sTT4lx4dz5EuBx0RHjvHhx3PQ>
Received: from vm-mail.pks.im (dynamic-077-013-052-093.77.13.pool.telefonica.de [77.13.52.93])
        by mail.messagingengine.com (Postfix) with ESMTPA id E8275108005C;
        Tue, 12 Jan 2021 07:26:51 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id ade4ca2e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 12 Jan 2021 12:26:50 +0000 (UTC)
Date:   Tue, 12 Jan 2021 13:26:49 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v8 3/8] quote: make sq_dequote_step() a public function
Message-ID: <7a7a4ae234d30c56e04c19a5e5b47afaa8680c72.1610453228.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610453228.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="Sd6kZEpNELvvLYpa"
Content-Disposition: inline
In-Reply-To: <cover.1610453228.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--Sd6kZEpNELvvLYpa
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


--Sd6kZEpNELvvLYpa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/9lYgACgkQVbJhu7ck
PpSbhRAAgtzI7j/sTf5MhYONTJXWK+YJJzQEeeWN5hHDHl7COmXxwdXPpSh+Ec/U
Gig6fBdbtKeI6gSjDCCGbWXPuGWebprX4ycgVUP+xX6utuZG0ijuB9+UbU+/6O/n
RiBUStZOdX/ivaQfSMRCQY+gNSHblMZIEX7Kxfe/BAsaA0AqP5SsIlD7/x95WOnd
PMOHDXlU3XWVBNT3Sh9NR4KiVsE7VI3Dw/PvlgrC2+pHSRxgseBkhWcmqLmuK7kK
ECQvjwtBy50Mc21hUz+Yswe5TFCTlWjKxT0nr70op9T1oD9WMsLzVWNkEcHctU7j
srEq4hL4m/6ggvEynUNnaVFc9IoVz9E6BtLYAbZP4MO5t4cZBRYolRTA0KndxiYT
+NNQ4ITr83VJ/d9mL1DJynvblmHqOMPrbjebTUhq4R8LZNXFbbV4Dpjc+jKKlJbb
C6+1GTP5tU1XrVhA0G1kF3yIcYAYsWql92Ww3VJgxuZaxRWsoPrZa6uN8jYnOzyK
bTYhR36hxWHtLtQwZJmy/cDlv0+8ZDOEKHHZYqkVS4mOC8M7zblUbHitx76xXbdm
/9c+FvKgQ2RPsrGp+R8w0T/nM1GgrrrpotCEVuTdmO62Y7cGkOwKVeFRHSsypCF5
DboZTN0oETD8CfleEZnyROxwnSfzCxiKZgmJtcszOQkF92a4GKk=
=BZbJ
-----END PGP SIGNATURE-----

--Sd6kZEpNELvvLYpa--
