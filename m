Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DBECC77B7A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 05:20:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234580AbjFFFTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 01:19:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjFFFTm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 01:19:42 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A822819C
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 22:19:41 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id E0FC232009B1;
        Tue,  6 Jun 2023 01:19:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 06 Jun 2023 01:19:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
        :content-type:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1686028780; x=1686115180; bh=K2
        PN3MpDnK55j7CUgeae+piI8EtMmNMlkf9ukebI/zA=; b=gOx+MltpyZjt4HubEQ
        A+FB+ZUAHRuhyRuUhtLF4+vfa1IXtNHnUXh7Ce9rt4KAeHFSPHl8mQe5RL5EtJyK
        jFhnFBOT6Z3WZRoNAxO48jyXBP3+nZLfXbya/HTNJgqxzfS8CCx5LYpPgtERfw5i
        XqVL83UlbZLimQfTPTFfW8TVkK5nRih30msmqDoBvrgca+FDgezROjRpCKYc0Wwj
        RKQvmDY0G5Rtj9UkywlR78RqHoSAF6mVCExP6cbCvN12ZoOUPyMncmQfQxM1YIpC
        mVi08UXsWAedrs0afqCfoKGtldK5DVTqLBDx7np88cwC2eMqVPCCtohI0Zl+5ChK
        6TJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:content-type:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1686028780; x=1686115180; bh=K2PN3MpDnK55j
        7CUgeae+piI8EtMmNMlkf9ukebI/zA=; b=hCeFkDsKN3Dwl11CDpJZXtawz0XYX
        MSV4sVxaQet5eCap8HIMP5wb1BA7G/Xnuj4UPBdO31syltlDQZVow94/hwjrpLxz
        CaQdfGzHVLnKugckD328vL8XUWjM7K3UDAmPweUL2l+rtnDLznwIghB65Q2/bxfb
        uYYThQnh2M/qTcSXOTBucn7jOlNGBtrJQwaMLO+Qqi2aBoC8k1KPEepvRDndgdgS
        Gcx32PvYq7zKltBmeJPkAiKMqpCAXO3E76s48n2E9bdlz5Gy/el7bf+0nx9SqnlU
        n01X7xnw9bKdAdtDz5U6YOMYZ0QxQnMQSLsvkFziREPfXf7XCbJ8SbHLA==
X-ME-Sender: <xms:7MF-ZMILL1vXxqnA2-WR2fo_2oXoC_0c6IAbKSiE6gJTZICw8v7Jsw>
    <xme:7MF-ZMJpZnIEEOxuAhpBOMIxC9XgcbNuntndVLCCgENbbm65363HiFExtaoPBkXtn
    lHOTtEZhbohDSRFhg>
X-ME-Received: <xmr:7MF-ZMur12ogc1PRs__5Yl5OuClZ8iBH4HZZYKJDG0asPJjXJr18SvgJjYj0pd52npo11Vy8uHsV2lqr8-9hZsKB26QefGf2OQdW6ouvVYw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedttddgledvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:7MF-ZJbzM_DNldFMO70BSKCFpyJrFE0LUCyX-yNcQuHnf9gEFkCVDQ>
    <xmx:7MF-ZDY_g9EnNbkH9EBkZ_GrjsjWYxjINv4_vN5DEaREn3Ro6l-L-w>
    <xmx:7MF-ZFAKW7rV1Sp4rgOA6FMMZyhsT-b8foyuW0DYkfSc7iCbwtu-yg>
    <xmx:7MF-ZPFpXKSLb5eKUBRUd4U815ien9QPRji6HrGT698yhQph9jaY7w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 01:19:39 -0400 (EDT)
Received: by pks.im (OpenSMTPD) with ESMTPSA id e7fd1dbe (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 6 Jun 2023 05:18:35 +0000 (UTC)
Date:   Tue, 6 Jun 2023 07:19:37 +0200
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 3/5] strbuf: provide CRLF-aware helper to read until a
 specified delimiter
Message-ID: <8127eeac97200da9aafccdf16cb7ba06f68b0121.1686028409.git.ps@pks.im>
References: <cover.1685710884.git.ps@pks.im>
 <cover.1686028409.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="4jIIPAM3B3ltboGn"
Content-Disposition: inline
In-Reply-To: <cover.1686028409.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--4jIIPAM3B3ltboGn
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
2.41.0


--4jIIPAM3B3ltboGn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmR+wegACgkQVbJhu7ck
PpTAIA/9EcOvuO39ubnlzNYZXNbIfq34YJu9kdflCOtAp+6yJsVr3on4Ke37EdMv
2WO+oVT88rt4dMh9Kbj6sUsMVbQ0amp8kvMOZmZFmpKXZRh8KOv/mrcyz1j6D/sM
wFJIphZVxUskZLOFbDDlz5vplSurPQLqcHfqKItbU9s+GYASjy05HvjzvCSAUEAP
X043zATN7FPaLuso/mSMe3V99CokWrCuVSL589vm4EOJCZfWqmRojSjpQvtimPAB
PCppw9/AI3oZrasOyjQaTpJFo9roFRnIlp7WN4gPEdsTUmXTH+XWvJyT9CSJJe63
dqcW6LqCxUGxdzTaqKKj7+et6/etXBhbBj5F3a3bHFRXOUvycqgat2p+83bxn9Bx
jjotf7dNoXmPGXQ2s3DYz/xqk+RNj+I/+YXxo9cVKzLt4bre4kNMIhf/3TpYEAhU
6GLittRkG9FEwHkzOyah3acOESgCBLG3oFdxAwuoWG23MkB3yLGeQ9xcmKF//Sbw
9dwSp8E1JqYDnkcAnhiBGySIiDD0ipXpw8hra8u2mmN3Bziy09ING4tNN1Ogc5rK
3uElpEQORUd8B/7FAYMX43sbHUHLtKHm0bG2AIzSL0+KNNMK1ZhvZAoRf+wABdo0
cg5NdaAGB5Atw5JJHtQwEzJw8IvLZzEQ8CKOFnubd6IC8kiK8M4=
=eaGi
-----END PGP SIGNATURE-----

--4jIIPAM3B3ltboGn--
