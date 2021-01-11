Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE7AC433DB
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F02D22527
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 08:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbhAKIhq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 03:37:46 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:38499 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727739AbhAKIhq (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 03:37:46 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 52C952522;
        Mon, 11 Jan 2021 03:36:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 11 Jan 2021 03:36:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=nC/e5601YAFxN7fZLeZyyQ4sGEB
        ZtWKhD7YYLzF8BL0=; b=OoZMCcDC4h5KziLgNzZKASCwyG18hAMvob95luQSZiQ
        piaQiGzf80hjtu5WtXhmnt0ajSuMk3+psq9TMd1hTQbhEs71ILBQvQcq61YlEopq
        lH1oL6ulz6m7QJug4smj+zZZnDy/zzPVntLXxJcOwxItbjawwqQdp+eRcOXx8BzI
        0YluzmBfZWImemhKdxxotj0Damrx8DT9URdt4+3kjWE37jA8ReEFH5W9Vp26dfdt
        zxC740aj7hcE931NK+FRnAslsG6i4UdB3VF3g/rz2pwAVqLeEmCIjQ40yNrc7gaY
        9Rb9IsmPj1eHZ1C97uxrjWA/7YCJGx56NyEqj7610SA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=nC/e56
        01YAFxN7fZLeZyyQ4sGEBZtWKhD7YYLzF8BL0=; b=RR/Dk46JjJXNTRDkwfO0n9
        ERsB/zMFBUf9d3Of1R8QqRlczQqyzPn5g57dGo7PXH6dSYO1zVgu4rYQoPNxumof
        9AUvagEFeCsnj2iyPvW3vZxCU1Gusvy1zLV85laDa7dnhQ2lS1EkqpsnVOAtWUyG
        arpHNH7xLTa1UU0wm3OkHRRezITX63bh3Bdv4Lke6cF0OGY+GKKrrrUJrDGzCap7
        jFojvtaExlAjYIP8dPD8e/3B4a+mEifDEppLkFuYGoJFqbbDRiCzBOCuZFseY3nd
        bpCnLeVZpzdU5i7noNmi4rn6QQRBZRdmTY7WUOjv/MyCfDUTHDT63vuhLvCACMaw
        ==
X-ME-Sender: <xms:KQ78X1DKrFkOkAfpvNtIf6WmTBrAfCwEmxcXIplxnIglobHENXlw2Q>
    <xme:KQ78XxUSNic4UI8AaMTwzZmM1Ejtfin1MTFXderXepHKwt8te4zFxfJp6T7WgH9V4
    RM5LU7Hvx2uTlfuvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehtddguddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepheeghfdtfeeuffehkefgffduleffjedthfdvjeektdfhhedvlefgtefgvdettdfh
    necukfhppeekledrudegrdeghedrudejtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:KQ78X7DG4dSKbqz91cNCrz6xIZOA-6y1MkkqdcvqY6VLVaQw4WXCfQ>
    <xmx:KQ78X88GepXS0WyxSOheOb_F5bJYexHH0ACEGTURCiz7TLmyU9Cz9Q>
    <xmx:KQ78X6Hz0Zc_93qAIFjGdCsl_RLbC-K7OHKF8Wtcw82jFDplkKA__A>
    <xmx:KQ78X5aHWM4auCkxvqTf7l2OKRkKNPs2xzzPX4DL3Tu_QxBfGrku7g>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 52D0624005D;
        Mon, 11 Jan 2021 03:36:56 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 3735a225 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 08:36:55 +0000 (UTC)
Date:   Mon, 11 Jan 2021 09:36:53 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Simon Ruderich <simon@ruderich.org>,
        =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Philip Oakley <philipoakley@iee.email>
Subject: [PATCH v7 3/8] quote: make sq_dequote_step() a public function
Message-ID: <1b47f0db98a4453e4d30815753a57e654fd1aa52.1610353895.git.ps@pks.im>
References: <cover.1606214397.git.ps@pks.im>
 <cover.1610353895.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FsZmBGv5faZ24fzr"
Content-Disposition: inline
In-Reply-To: <cover.1610353895.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--FsZmBGv5faZ24fzr
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


--FsZmBGv5faZ24fzr
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8DiUACgkQVbJhu7ck
PpRRIQ/+KNa4dR06Im68RM7i0fZhYQESaygdCikFNVa+K1LzcboVQcBZabn4mm1s
UgXtQvd8TlFE4tY+elM7xK9J9zjfMTIP90TVJCNqu6Hexs/k6kqLJdEv92PvlyzJ
MMOhHTMoihCDqYcIbCrXfs8Hx0jGPlRg9Gr/kXjMmCmWGqz5hMz8bsagK7bfshVe
VIV016VrdOvAwsoMw0VXVR9VveqVS13HlOraGZlmJgZry59Tjd4f7laHXJFHNPsD
ogU/4kOHV00AnQG81bxGvTlevvx/7JJ0jpUjG3urlyK2IDxHbf7nJ/EjFQ1SKV41
uLWgwzCFDWktTOsT7BmwbtF8wq5nqIug3YTuAkn9dnq8kJo0v+7xWHGoYSaxcLVF
QF13kg1+n/d5ORniGiTvlNerFWS1/k+gAT/Pzh2yGG7ujOXk2ShVplhyfWLFHAj+
mrUIhqnOakbdgFHVQaZEBQ0pLBSSc1mfBaFhprpGOduTRp8HtX4Qwpu2loHH8BOI
vbgv3HoUKZRZyAMr0C9vOuAisQh8fSPvstvj9k2OrfGbzxereySZm+hZOLilWtT0
xsefhctaliK+183D3losR8jzG/4oQW+ORoZEfdpCimqa/rtOHZ07ZSIgvi5al90i
552mIpT5YwwmYMBP5mU0Y6+lQ90WeP1C9cDu7sxaibwSu0DZpS0=
=4ZTD
-----END PGP SIGNATURE-----

--FsZmBGv5faZ24fzr--
