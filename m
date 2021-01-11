Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44ACDC433E0
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09ADC224D3
	for <git@archiver.kernel.org>; Mon, 11 Jan 2021 11:06:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729601AbhAKLGS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Jan 2021 06:06:18 -0500
Received: from wout4-smtp.messagingengine.com ([64.147.123.20]:49069 "EHLO
        wout4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728413AbhAKLGS (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 Jan 2021 06:06:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id 562B128D9;
        Mon, 11 Jan 2021 06:05:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 11 Jan 2021 06:05:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=date
        :from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=edlYxcDXIH8o91FSVN6fXcK2GDF
        QyO7ScrawBjJdph0=; b=skcpAmWLWCOMvOD+xnnngacVFWr2Lmc9a0O2IFbNUsf
        e3BatomYwXKcjKWTyqf4h4Wouyr6TQy9mW938Jhb/qKHk1ZMfVyM7nFp6/3uuWzW
        6wGLKdGSTAlHwdKV241hCZsmeQbgzFRfM/pWUoP5n/GktLnqjkPIczWmmJDIlXWn
        3oZOr6FLy1vdpfmGs6I6yHew4egaD33MC5hlDMYr1ppKioegoUARW6yMvZAoiHZl
        DbgLzTeesp2LUOrASxC6tllthsyXrEKcn0AUCGt7/dztJKZpjPj6JpprfCkXfU/K
        K+YwxSng6AwU65RuUF3PJEOg3Iw4GTqjf7R4RqpIV3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=edlYxc
        DXIH8o91FSVN6fXcK2GDFQyO7ScrawBjJdph0=; b=JqBDhbbatU0HN81CPD1/iE
        TlAz5BBP6fc2UuPXSmSqU9KVHthopx3H0EKGYQyHbmFIBeBbld5pNk0smBZER2BZ
        WH9ciRUDyDSd+/cBB9JC7/IBh9PLM5Zn7QPfyd2NkmqKGniXowZE/6MWU1B5qFBE
        od+zlHZls/ArG6w6RdD0rlct5fY9NnD6k0i5OyQp0DzXKRc5kmd+8xwsKdP/i5bh
        SLgcvrdX8KD7Xh+tqhOpAK56Zcg22taQZkb/7gjDOc/jwWMWqh0NxA0Y64EaGerL
        o66O+6ECRqorQ7uNJScx3ViyhMnDvbeqQFIrmQrdBW8QThOxHQUAzzNPg/+7YyrQ
        ==
X-ME-Sender: <xms:-zD8X5JPjJxC3cDa55Y78MorUaBtoYIKF0CjFJ56__tSo3Zr2p5VJw>
    <xme:-zD8X1IpyfXrh1Sg9-VqBvkZH8-OmFk2J3gBT_aSf5DHWs-KIEhsKIjhwhkAtW8WG
    QrxZLmaD3KgLw3Bfw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdehuddgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehgtderredttddvnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeehgefhtdefueffheekgfffudelffejtdfhvdejkedthfehvdelgfetgfdvtedthfen
    ucfkphepkeelrddugedrgeehrddujedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrg
    hrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
X-ME-Proxy: <xmx:-zD8XxucvoxP6FUQxLSPbglTIsUQ_5xMOtD7ChC86sFBva82802aAQ>
    <xmx:-zD8X6YlMMXluOm_3vxsglKjeLCf4RUA62gDOeXQR96rxIvIVHKBuA>
    <xmx:-zD8Xwbwnhz0oTqr6Vx11OpELSIOXP7LszhIWlgDJm0O4s4dwBMqog>
    <xmx:-zD8X5ABuwRGP51au7pQi7WoceWpNKKqcRo3myhE6852eW7cN3gEvQ>
Received: from vm-mail.pks.im (dynamic-089-014-045-170.89.14.pool.telefonica.de [89.14.45.170])
        by mail.messagingengine.com (Postfix) with ESMTPA id 570B81080059;
        Mon, 11 Jan 2021 06:05:31 -0500 (EST)
Received: from localhost (ncase [10.192.0.11])
        by vm-mail.pks.im (OpenSMTPD) with ESMTPSA id 9cfb5b94 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Mon, 11 Jan 2021 11:05:30 +0000 (UTC)
Date:   Mon, 11 Jan 2021 12:05:29 +0100
From:   Patrick Steinhardt <ps@pks.im>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 4/5] fetch: allow passing a transaction to `s_update_ref()`
Message-ID: <865d357ba7436ccd3de3573dc45e2647b09478e0.1610362744.git.ps@pks.im>
References: <cover.1610027375.git.ps@pks.im>
 <cover.1610362744.git.ps@pks.im>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="2XFeuMBVrwS7IhHN"
Content-Disposition: inline
In-Reply-To: <cover.1610362744.git.ps@pks.im>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--2XFeuMBVrwS7IhHN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The handling of ref updates is completely handled by `s_update_ref()`,
which will manage the complete lifecycle of the reference transaction.
This is fine right now given that git-fetch(1) does not support atomic
fetches, so each reference gets its own transaction. It is quite
inflexible though, as `s_update_ref()` only knows about a single
reference update at a time, so it doesn't allow us to alter the
strategy.

This commit prepares `s_update_ref()` and its only caller
`update_local_ref()` to allow passing an external transaction. If none
is given, then the existing behaviour is triggered which creates a new
transaction and directly commits it. Otherwise, if the caller provides a
transaction, then we only queue the update but don't commit it. This
optionally allows the caller to manage when a transaction will be
committed.

Given that `update_local_ref()` is always called with a `NULL`
transaction for now, no change in behaviour is expected from this
change.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fetch.c | 51 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 991771f8eb..654c7a7eed 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -583,11 +583,12 @@ static struct ref *get_ref_map(struct remote *remote,
=20
 static int s_update_ref(const char *action,
 			struct ref *ref,
+			struct ref_transaction *transaction,
 			int check_old)
 {
 	char *msg;
 	char *rla =3D getenv("GIT_REFLOG_ACTION");
-	struct ref_transaction *transaction;
+	struct ref_transaction *our_transaction =3D NULL;
 	struct strbuf err =3D STRBUF_INIT;
 	int ret;
=20
@@ -597,10 +598,17 @@ static int s_update_ref(const char *action,
 		rla =3D default_rla.buf;
 	msg =3D xstrfmt("%s: %s", rla, action);
=20
-	transaction =3D ref_transaction_begin(&err);
+	/*
+	 * If no transaction was passed to us, we manage the transaction
+	 * ourselves. Otherwise, we trust the caller to handle the transaction
+	 * lifecycle.
+	 */
 	if (!transaction) {
-		ret =3D STORE_REF_ERROR_OTHER;
-		goto out;
+		transaction =3D our_transaction =3D ref_transaction_begin(&err);
+		if (!transaction) {
+			ret =3D STORE_REF_ERROR_OTHER;
+			goto out;
+		}
 	}
=20
 	ret =3D ref_transaction_update(transaction, ref->name, &ref->new_oid,
@@ -611,19 +619,21 @@ static int s_update_ref(const char *action,
 		goto out;
 	}
=20
-	switch (ref_transaction_commit(transaction, &err)) {
-	case 0:
-		break;
-	case TRANSACTION_NAME_CONFLICT:
-		ret =3D STORE_REF_ERROR_DF_CONFLICT;
-		goto out;
-	default:
-		ret =3D STORE_REF_ERROR_OTHER;
-		goto out;
+	if (our_transaction) {
+		switch (ref_transaction_commit(our_transaction, &err)) {
+		case 0:
+			break;
+		case TRANSACTION_NAME_CONFLICT:
+			ret =3D STORE_REF_ERROR_DF_CONFLICT;
+			goto out;
+		default:
+			ret =3D STORE_REF_ERROR_OTHER;
+			goto out;
+		}
 	}
=20
 out:
-	ref_transaction_free(transaction);
+	ref_transaction_free(our_transaction);
 	if (ret)
 		error("%s", err.buf);
 	strbuf_release(&err);
@@ -766,6 +776,7 @@ static void format_display(struct strbuf *display, char=
 code,
 }
=20
 static int update_local_ref(struct ref *ref,
+			    struct ref_transaction *transaction,
 			    const char *remote,
 			    const struct ref *remote_ref,
 			    struct strbuf *display,
@@ -806,7 +817,7 @@ static int update_local_ref(struct ref *ref,
 	    starts_with(ref->name, "refs/tags/")) {
 		if (force || ref->force) {
 			int r;
-			r =3D s_update_ref("updating tag", ref, 0);
+			r =3D s_update_ref("updating tag", ref, transaction, 0);
 			format_display(display, r ? '!' : 't', _("[tag update]"),
 				       r ? _("unable to update local ref") : NULL,
 				       remote, pretty_ref, summary_width);
@@ -843,7 +854,7 @@ static int update_local_ref(struct ref *ref,
 			what =3D _("[new ref]");
 		}
=20
-		r =3D s_update_ref(msg, ref, 0);
+		r =3D s_update_ref(msg, ref, transaction, 0);
 		format_display(display, r ? '!' : '*', what,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -865,7 +876,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "..");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("fast-forward", ref, 1);
+		r =3D s_update_ref("fast-forward", ref, transaction, 1);
 		format_display(display, r ? '!' : ' ', quickref.buf,
 			       r ? _("unable to update local ref") : NULL,
 			       remote, pretty_ref, summary_width);
@@ -877,7 +888,7 @@ static int update_local_ref(struct ref *ref,
 		strbuf_add_unique_abbrev(&quickref, &current->object.oid, DEFAULT_ABBREV=
);
 		strbuf_addstr(&quickref, "...");
 		strbuf_add_unique_abbrev(&quickref, &ref->new_oid, DEFAULT_ABBREV);
-		r =3D s_update_ref("forced-update", ref, 1);
+		r =3D s_update_ref("forced-update", ref, transaction, 1);
 		format_display(display, r ? '!' : '+', quickref.buf,
 			       r ? _("unable to update local ref") : _("forced update"),
 			       remote, pretty_ref, summary_width);
@@ -1094,8 +1105,8 @@ static int store_updated_refs(const char *raw_url, co=
nst char *remote_name,
=20
 			strbuf_reset(&note);
 			if (ref) {
-				rc |=3D update_local_ref(ref, what, rm, &note,
-						       summary_width);
+				rc |=3D update_local_ref(ref, NULL, what,
+						       rm, &note, summary_width);
 				free(ref);
 			} else if (write_fetch_head || dry_run) {
 				/*
--=20
2.30.0


--2XFeuMBVrwS7IhHN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAl/8MPgACgkQVbJhu7ck
PpT04xAArm7c3RERFr9XOBgulUcUXyT3CKDN2Yl4TaEWJj9lUueicvbY86NX4oig
wZLZTRIiRqF060NL50dwkVe3hyMeakcN51zsntt+1xcjLxS9TH70a3M988FHC3KV
KjjCgJM3iEdPmkHsM4CNaBL1WDOwmHM7ie/GG+OKTiGzmCPLL5PD7X6t0rdLlEop
T8IcCLjWdcmrl5Q95YTOQl388s2novF1X+rRzbs8NvN4PHDF96IFnIeuIKLYvYZu
VXugGOFSpZFf70tBE5+fbcq/cjfoq+zIkjWoLDHksPYPg6fCK82d5f3cPNf+Rf6m
bloxsnw/a2GVmW2qSUTLO/Q6CqTFmkFndHIUQMNEy/rRabcEWrKrrSjTVQqN4s+2
AGsaUW7sLoGXtnlM0iobXEljEiaxzLjqe4q0c3lCUtVuZqq+/uhGiJdI2tR9mKkw
GfxvlE6z/ou9i9H6jXUipo2L0OEaXdP0otQPSyFfD06BCQcv/7x+49kXSlQA7PyE
299r3KZdCJ5j0tRC0fh1vYzRaqdi2MHeB8pqGx1JwfuwROJ27M+1qQVi/94BrX/n
loIHJ7MDTXShYgKgPcGD8VYCSA0DNbf2ksb+VzVu1RxefxmnIfZ9mhDGONt+eXfq
8kj/N0Xs17cswtrRrlTfGg+LdMUqfgjw6wij+qjvhk90SRmnt1M=
=IWXm
-----END PGP SIGNATURE-----

--2XFeuMBVrwS7IhHN--
