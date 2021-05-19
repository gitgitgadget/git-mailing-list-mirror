Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86059C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6464A6135A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbhESTO7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:14:59 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:46641 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230499AbhESTOx (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 19 May 2021 15:14:53 -0400
Received: from compute7.internal (compute7.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 12B9C5C0198
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:33 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute7.internal (MEProxy); Wed, 19 May 2021 15:13:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=fm1; bh=3w9UTEi5ughA1WPCjA7SpmfmOlIHVDVAYUWX2MEM
        hPE=; b=eA2zz1zT++Br51tUxbgsehwCbPzlfwsfFk69FckBkbmV0C5NJVdwCUFf
        TWET5GHkKpT80LP3oS8udf04KHEjdAR1qTqLhZoAI7JXuN+RzYnqfEhbdukGWhRJ
        WYx7kPlG45wB5FGCme+HkvQyX6ph5S0ZN+78uFyCMXXRVb2x8V7o+fzqjit8zJ5S
        RMyv/9lknY9xgsNlBmZUbo1VF14jjVUMWaOLYgQDp5aqERcONbMjYz1NTRqTql3V
        ElqUoFJvtQwJUVrSV8WOevah3BnxgIb/XBdB1RO4aVmu9u/hTs4Y086eGVTPFZlM
        52iyTufFWiN083vvFFRPtUliFTM9pg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=3w9UTE
        i5ughA1WPCjA7SpmfmOlIHVDVAYUWX2MEMhPE=; b=sVN6byB311SfBulFy9UltB
        gYReynn65OIbrBTWBl6cB5F9HHZ1XrXUYf6kmc9h6fsUi4pSTFyEPc2E7owL3k1P
        oO7B1t1QXncnfI5JmA0M3AMqVpU9+401EjyQxwCxpeyOfgZ2wuaZalGTXHOmAiB2
        Fo+hGyCuR3A7VEwPb5d3pB49ELKCnTPfs20kzIFGZMhjrot5GivE/G/8kfzBFetW
        9b//GMbIhWbUkwenV3U7QddfmJUiDzV9ihYlT35aJy0+Xq59NBYbWfO030qq0pBX
        SucSMaHCpm2vl32BYiTESbNC2kZTvKABAdHTydIiGQnMdgj4aiDJjiXGDsw29T4Q
        ==
X-ME-Sender: <xms:XGOlYFjZv_IURCBYl00Cf4F5DTTR0nbBiH4CJ0XZpbmMp87l533UHA>
    <xme:XGOlYKC2Cq7q-2uAB2AOYkxf22ur50ZJvh2AFbf1GjWwJGbLz1SIr9uXCfq69NNjq
    ssud2U3Bz80oX5nsA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdeiledgudefudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtd
    fhvdejkedthfehvdelgfetgfdvtedthfenucfkphepjeejrddukeefrdefjedrudehieen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhm
X-ME-Proxy: <xmx:XGOlYFHag81abXOjhuUQWQ2jMtn0WojBRW3iolWXdFMH0DM_gx0yjQ>
    <xmx:XGOlYKQm2Ly3GkzdP-CihDF7KBGBmUUsYJi0RiiZNsgsgz1CXpU55Q>
    <xmx:XGOlYCyQM67F5KPP4OAk6Gvwvn5FderIfnFqrMtWhXbS_6NI4WeATA>
    <xmx:XWOlYB8XwRDrjcKJ6IlXkN6W1qtAmjP-5F-P8_JHUAVZgMF-lEsfpQ>
Received: from vm-mail.pks.im (x4db7259c.dyn.telefonica.de [77.183.37.156])
        by mail.messagingengine.com (Postfix) with ESMTPA
        for <git@vger.kernel.org>; Wed, 19 May 2021 15:13:32 -0400 (EDT)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 61a9e053 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
        for <git@vger.kernel.org>;
        Wed, 19 May 2021 19:13:32 +0000 (UTC)
Date:   Wed, 19 May 2021 21:13:31 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Subject: [PATCH 3/8] tmp-objdir: expose function to retrieve path
Message-ID: <a5ca94e3f4df2abb38880385310e5cb02d7b5daa.1621451532.git.ps@pks.im>
References: <cover.1621451532.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="aRRY7fZlVTX5Jy8g"
Content-Disposition: inline
In-Reply-To: <cover.1621451532.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--aRRY7fZlVTX5Jy8g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

It's currently impossible to tell the path of a temporary object
directory for outside users of `struct tmp_objdir`. We'll soon need that
information though so that we can reuse information from the quarantine
environment in git-receive-pack(1).

Provide a new function `tmp_objdir_path()` which returns the path of a
temporary object directory to prepare for this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 tmp-objdir.c | 7 +++++++
 tmp-objdir.h | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/tmp-objdir.c b/tmp-objdir.c
index b8d880e362..6056917c63 100644
--- a/tmp-objdir.c
+++ b/tmp-objdir.c
@@ -288,6 +288,13 @@ const char **tmp_objdir_env(const struct tmp_objdir *t)
 	return t->env.v;
 }
=20
+const char *tmp_objdir_path(const struct tmp_objdir *t)
+{
+	if (!t)
+		return NULL;
+	return t->path.buf;
+}
+
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *t)
 {
 	add_to_alternates_memory(t->path.buf);
diff --git a/tmp-objdir.h b/tmp-objdir.h
index b1e45b4c75..da3ccb98bc 100644
--- a/tmp-objdir.h
+++ b/tmp-objdir.h
@@ -51,4 +51,9 @@ int tmp_objdir_destroy(struct tmp_objdir *);
  */
 void tmp_objdir_add_as_alternate(const struct tmp_objdir *);
=20
+/*
+ * Return the path of the temporary object directory.
+ */
+const char *tmp_objdir_path(const struct tmp_objdir *t);
+
 #endif /* TMP_OBJDIR_H */
--=20
2.31.1


--aRRY7fZlVTX5Jy8g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmClY1oACgkQVbJhu7ck
PpRI2w/9FE+qO0UBhQr9YMTV/23lU9QoXCIYcT2Oh3gXkezxBNjZ8LB2+DQ/YmUU
xsNlTLZhsEl1eqlYrds1mi7zL5MI8dLNuaIWNYfePpYtNk7oseqRgWuyKDJdI9fd
8gOHNAJPS0JPPAA0IYBIyxrxVF+xlIuZL2zisLRzdYmE+0ZX1tJtE1h2HtTzx8xI
4LLoyXopqD8YFD1smDV0vGSIXa7R9oMljQQJJMAEyM1Hqi6CaaE1x9VU/M4fVJFX
TjOLSKIwCQRlTdolH7rspxTOmmCu6DJSh9qLKmW5cJlSNgYcco1Vc0V3cxv4cfq9
guCXrN5AoKGUqxprGSbwP5h7QRdtyChNjutP9XDKmgk2uFiO+465K/3+TTMC9ndA
XLoOjd2u9be3ul74RHF3bTJ7MMMedJnrHH1C/c8bSDe8qEj7Q3AoWze8wOuY+I1C
DT7Yk1wpC4beIfZGgd3aIAbP24KWEHi542VItIvmgsjkqVuxBQleYhLCF20YGt52
CW64k9mAqU6tQwjI10jNCkMkZwTn9iE/FjvXaK+c0o/4zDqfy1N4Y11GGkE2XCoc
/jJnc2iSYTcmxmGFVeUkQv+1A5+tEP2pg3mH00eJ9CTKYgKl5T0MNVpm/3F/gNOE
74RjX+qJ+03td7Waz9+hZWjUD1BVsSZNZMXsYfJZVJAVsxiY410=
=nAhj
-----END PGP SIGNATURE-----

--aRRY7fZlVTX5Jy8g--
