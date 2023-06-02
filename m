Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8213FC77B7A
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 13:02:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbjFBNCs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 09:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235525AbjFBNCp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 09:02:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24B51B3
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 06:02:43 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4E61A5C00CA;
        Fri,  2 Jun 2023 09:02:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 02 Jun 2023 09:02:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685710963; x=1685797363; bh=gS
        rqGwai2YoT4E5P+7bATvRnXf1bno75BnQgcusaOxk=; b=mV/ppVXmTvybOPrxfJ
        RyrpIVg4QjR1OYP8Ft8bE2vxBYdWA5oVeuK+K1oo1/XQmgMlfZES7Rnd5Zpq0mHd
        vLnounbyUVsW5wVz7VcM2BfzolkLZEkOn519LMbZNiwIr6b+Uds/raQPL3UwW0oC
        0FZO+t+2K4t/hfFt0pCFVnC/iYLECAq+QIO3AJwpkzeXHamdORVLxPxfYlox/Lut
        KGwqb/Wg2XE7hw83xgXyiHl2OXlpwYdGxZcUj8cEYmgL3VCms+tYbrNTBsPBCBFG
        0rzOWT2Ql1DKE12q8gxkgJVTMOlg/E/F+HnKNBMxprKkbLdf4l58ksqhXyvFgLHy
        LtyQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685710963; x=1685797363; bh=gSrqGwai2YoT4
        E5P+7bATvRnXf1bno75BnQgcusaOxk=; b=D/TDxl55LeBbrcw6h8jOX9kR+9dsc
        71A7eLbmL86UhAoM9kNgcLghNYDb5TzJQ/2Wel6SJIIcfa9lDvu+1zIbTJ0dCyl6
        AR8hZ8Oo5EII1yrUsxqMyb4g9/ZqG3GZDDgkRqPYG0+yZQJN3CxsUJjURFZhAaVw
        2G1VZ+ImQYCipEpeAii73bJaHbDQy0WQuP3/9p+YPwqY4rPrZP1KO251Cgmqi+Uk
        rYeTv3ZfgkeD5OMsxZVIv5LMDlTcdL6yTEVCgQUOTo5zRhhaPEpTkqjMhCpry7s9
        2Lt+YoUshv3Rq5+BD8IKaDh664hUWUOTDE0yxvHqQk6DrbrER58Dt2pdg==
X-ME-Sender: <xms:cuh5ZFOrcW0jnfqBC0blM0x3yJ-zc4h2q_cWkDcZVFlcX1KQT00k-A>
    <xme:cuh5ZH-gzOs5JuqSJ6JN6zlcG15HXvP_Q_1Vmix7Kmlh4hqz58Zs7Z0Rn6cZOHei_
    wq9odcT8Epw-qoBQw>
X-ME-Received: <xmr:cuh5ZETIxkwj2x08atFnPgKIOe9ADbwfJ5eS544G7Shkfl0rZ4bTSUlWN_CRWt7bDOKr39WydCCflge3H4CCqsB4ngRc-tZKBs-qEnB3_XN4sw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelfedgheejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:cuh5ZBvJIyRfZWxXLKEx3364ZozB4RPYEAhn6Hw07VUTQ1NB2xeb5w>
    <xmx:cuh5ZNemEpXGeoG9htqiIkg6RsdIAcCL50qVhpWFMY1lwDeqY7UAfA>
    <xmx:cuh5ZN3P8PsjwOfTAQwEXFSz_5wJx0aVbw9MWUuSOnAqWzg6L__SJQ>
    <xmx:c-h5ZB50vj4tzlfVy5xhZifUhzca8RbvF2IMxg-ACsTq5SLoYj3M5w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 Jun 2023 09:02:41 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id ba69e51e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 2 Jun 2023 13:01:45 +0000 (UTC)
Date:   Fri, 2 Jun 2023 15:02:38 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 3/5] strbuf: provide CRLF-aware helper to read until a
 specified delimiter
Message-ID: <8127eeac97200da9aafccdf16cb7ba06f68b0121.1685710884.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="8wL/FdWoJxk/YEcD"
Content-Disposition: inline
In-Reply-To: <cover.1685710884.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--8wL/FdWoJxk/YEcD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Many of our commands support reading input that is separated either via
newlines or via NUL characters. Furthermore, in order to be a better
cross platform citizen, these commands typically know to strip the CRLF
sequence so that we also support reading newline-separated inputs on
e.g. the Windows platform. This results in the following kind of awkward
pattern:

```
struct strbuf input =3D STRBUF_INIT;

while (1) {
	int ret;

	if (nul_terminated)
		ret =3D strbuf_getline_nul(&input, stdin);
	else
		ret =3D strbuf_getline(&input, stdin);
	if (ret)
		break;

	...
}
```

Introduce a new CRLF-aware helper function that can read up to a user
specified delimiter. If the delimiter is `\n` the function knows to also
strip CRLF, otherwise it will only strip the specified delimiter. This
results in the following, much more readable code pattern:

```
struct strbuf input =3D STRBUF_INIT;

while (strbuf_getdelim_strip_crlf(&input, stdin, delim) !=3D EOF) {
	...
}
```

The new function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 strbuf.c | 11 ++++++++---
 strbuf.h | 12 ++++++++++++
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index 08eec8f1d8..31dc48c0ab 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -721,11 +721,11 @@ static int strbuf_getdelim(struct strbuf *sb, FILE *f=
p, int term)
 	return 0;
 }
=20
-int strbuf_getline(struct strbuf *sb, FILE *fp)
+int strbuf_getdelim_strip_crlf(struct strbuf *sb, FILE *fp, int term)
 {
-	if (strbuf_getwholeline(sb, fp, '\n'))
+	if (strbuf_getwholeline(sb, fp, term))
 		return EOF;
-	if (sb->buf[sb->len - 1] =3D=3D '\n') {
+	if (term =3D=3D '\n' && sb->buf[sb->len - 1] =3D=3D '\n') {
 		strbuf_setlen(sb, sb->len - 1);
 		if (sb->len && sb->buf[sb->len - 1] =3D=3D '\r')
 			strbuf_setlen(sb, sb->len - 1);
@@ -733,6 +733,11 @@ int strbuf_getline(struct strbuf *sb, FILE *fp)
 	return 0;
 }
=20
+int strbuf_getline(struct strbuf *sb, FILE *fp)
+{
+	return strbuf_getdelim_strip_crlf(sb, fp, '\n');
+}
+
 int strbuf_getline_lf(struct strbuf *sb, FILE *fp)
 {
 	return strbuf_getdelim(sb, fp, '\n');
diff --git a/strbuf.h b/strbuf.h
index 3dfeadb44c..0e69b656bc 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -475,6 +475,18 @@ int strbuf_readlink(struct strbuf *sb, const char *pat=
h, size_t hint);
  */
 ssize_t strbuf_write(struct strbuf *sb, FILE *stream);
=20
+/**
+ * Read from a FILE * until the specified terminator is encountered,
+ * overwriting the existing contents of the strbuf.
+ *
+ * Reading stops after the terminator or at EOF.  The terminator is
+ * removed from the buffer before returning.  If the terminator is LF
+ * and if it is preceded by a CR, then the whole CRLF is stripped.
+ * Returns 0 unless there was nothing left before EOF, in which case
+ * it returns `EOF`.
+ */
+int strbuf_getdelim_strip_crlf(struct strbuf *sb, FILE *fp, int term);
+
 /**
  * Read a line from a FILE *, overwriting the existing contents of
  * the strbuf.  The strbuf_getline*() family of functions share
--=20
2.40.1


--8wL/FdWoJxk/YEcD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR56G0ACgkQVbJhu7ck
PpTNmA//WVTuHhee9de2+cE2Wv5TVc6SrjuTzbJSradqVsQJLfmUE+bmm9oxwKtV
ZY7+1xZhUlDzOFFVVzjz3D7bRUfGpMtPtdCksHv8QIJ8PnFuYGr8HTkqmF/0bWTT
6XyKOs7qm7dwZJWAFEFYuufxFl8911t+Fky6EkXbygtrA0VdZ4xqhWYlxjApi8qv
0RP/aV/WAe2afEP1whMt2zs5E+2jdaXx7eInY/StZjZvZeCf0Q0joQf73xewGSTr
7FPfkhTouCngyy3I09nQhK90ENOf6Wxow4jkJHM1lFLGFrhErv2x3isoCDpc5mW7
2zEGzgS8rfNVMi1mwyjwl1vPZ9EKJdq4neKqXoi7QA+/+JHiIsToVqAvl0AZHbWm
rmpkHpfn9yPoMqRZllO21RC/dzxmCMOP3oYaYDISdNtc5NpDxAASlylIlmNFQCfa
oCA0tUGhR3uc+es1cfcVHnkuGAOPL9Ht++AkR2/dg9t4Jouhr0tcm24KIMvxuk4w
gZ9hjhcBW4G2RegrJuYkcEMtPuyTSbo0M5DwjOUXgwuWPGz7WCu4CB7lVZnOYV7v
uui5jVcL7G/jDQtFMDPKPifQekvqBHaI8oY3TOJQ5Q/XVyES9Tp1/UY+NwiCsH11
J4TdTOqjg3eENvApeePBMC66ngk+61TvzZ8R/QXegbqnuEsByu4=
=WpY9
-----END PGP SIGNATURE-----

--8wL/FdWoJxk/YEcD--
