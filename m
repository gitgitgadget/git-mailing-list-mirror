Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED8137179
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550651; cv=none; b=bhByJfZa+XtGGypMN78IgU5LoaXikS48IZB7SGRI5PjEvBGjY8yhKwQIyd1gHmouLFnKt1wGtbILCPI2QkwNa791DVunu0fGDZTZ0Y1L1N8BVXxS8F/HfX3VcNJs7k32T0EO9ddsgZuy1491TKTktnfWtwV8GIvK8KwSm7sCJQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550651; c=relaxed/simple;
	bh=NZpvJQ4ohwnVFW3VV95NsRiKutRgvJc0Dc+RF1XErpc=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Il6Ie5dWym/XKMDDFY02ZFPL4Nqaqut+ugJVYVNmv8PwA3juEsyArL3tHFoJsmU9PS19K6ukricx3RuCroDW/IPvwOupktSPDiExGV4EOgHt39iV/dEcjOEv5r3xEn8tPX0fVpBIfzvNstdXvGNF7CzYVrpbBeORWC1SR3M/6Ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=D5SFk/WH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RfQnwQIk; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="D5SFk/WH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RfQnwQIk"
Received: from compute7.internal (compute7.nyi.internal [10.202.2.48])
	by mailfhigh.west.internal (Postfix) with ESMTP id A164E18000CB
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 06:10:48 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute7.internal (MEProxy); Mon, 04 Mar 2024 06:10:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1709550648; x=1709637048; bh=rMFmd8gHhc
	ml/ZrtHZOV59LEdgAMtl7tUQro5dcHmoo=; b=D5SFk/WHN+LOvm/4qZ0/nZVLKR
	2ERm1ETQUCRywdcnDemdQ779NVoQrKswwfaAnkHrc2LSXCxd8ZuzW0Gh8GxOu5FI
	KS7UubammhA7+iZeeGPMX2t6F5fXpBaDET7d+hK5E2rKnkdqFUgpuOI0A79etJor
	pyWrUuLPcMuM/LOQXYHZ2jPFOPaQt4j663+ko0OrGPrA8U8Cv55m/zV6+ZTAoqF3
	LdoP2K49Em9QOjlyqTfH93kLoMn/hSMD+BBpEEvKMjFA3kPYmNRWtUCS173oL6Q1
	FbehlYZ6rwM0piYSWUqi+V7f/7zg6HBfJeMvk8Acs8k0F9/6jUpE7R9Xf+tw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1709550648; x=1709637048; bh=rMFmd8gHhcml/ZrtHZOV59LEdgAM
	tl7tUQro5dcHmoo=; b=RfQnwQIkKfKN3fJ5F0cCD0+nVCiOdXZP/9OVDmsfHDfR
	x+BuyFzitqmQEWxjTXBmsPlgeCSS/yxzDbDiNtXcOsS8pvaMC2YVHB4x5womAZIa
	v3Fmko8ulOHJRjaff7qgO58XJob0pXkVhqtWo4GOZZzbRwTI5NtjHsfZ93Hv3UCR
	48K9op4w+3/plzEv57mcN2vJX8dqp0jgwmQZkCi69pfoJqNOoh/Ba4m/Rg6UQiJF
	4SL1UtR+nvN1b6I8OTJNF7d+eygBMwjZY1HHg1lknjThSxeQeMfAQOy22MnsWxKQ
	P5DDYy+o/0kpgjNyiCGzOipvqEDli7+UcX3+qkyNqQ==
X-ME-Sender: <xms:N6zlZdjr8EbPWEEuwVZwfDOY9JprmdbpFs_9yaTxDYFj9FGYzdlMfQ>
    <xme:N6zlZSCXjqtfxJgzLWTORbk6sQFZPGlFqRL3sDWwuNMbrbQ_lNInFerxdTPZpBFRx
    GOk3Mcb_-HTCfp9cA>
X-ME-Received: <xmr:N6zlZdFwXTDv5l0ll9UGJFhwMsKE8wh_uCnTAuqZi2KvwJ3nX-XtNMM6DPIRsUeU7HzNKrg_XilyDXUEdWT7XozMKC8IKSupf_pp5m-nDrQHY6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrheejgddvgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeehgefhtdefueffheekgfffudelffejtdfhvd
    ejkedthfehvdelgfetgfdvtedthfenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OKzlZSQ7tA6yxOJuQANCnuV2GZIBBdmLKfRj_SzEmuB_q_HzAvGWZQ>
    <xmx:OKzlZaxKUylqZNeW09nCLiBne7furMhN2FxUaV3zCypS7Sh9RffZGg>
    <xmx:OKzlZY7vA-0nLhSGrQPXoQ1KJLIGKJm1rAlz99tBxl3XzZGXoJuOLQ>
    <xmx:OKzlZfoGgtlj4xW_dMJChWKVvHXqVZQZIxMk2nwYZ2jTgnHda3KztHu-pPE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Mar 2024 06:10:47 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a10b4545 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Mar 2024 11:06:22 +0000 (UTC)
Date: Mon, 4 Mar 2024 12:10:45 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 1/4] lockfile: report when rollback fails
Message-ID: <1acaa9ca1a53e3d8e875fed7ce961d0b5426688f.1709549619.git.ps@pks.im>
References: <cover.1709549619.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WRxJXKvM9XCH2DJ+"
Content-Disposition: inline
In-Reply-To: <cover.1709549619.git.ps@pks.im>


--WRxJXKvM9XCH2DJ+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

We do not report to the caller when rolling back a lockfile fails, which
will be needed by the reftable compaction logic in a subsequent commit.
It also cannot really report on all errors because the function calls
`delete_tempfile()`, which doesn't return an error either.

Refactor the code so that both `delete_tempfile()` and
`rollback_lock_file()` return an error code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 lockfile.h |  4 ++--
 tempfile.c | 21 +++++++++++++--------
 tempfile.h |  2 +-
 3 files changed, 16 insertions(+), 11 deletions(-)

diff --git a/lockfile.h b/lockfile.h
index 90af4e66b2..4ed570d3f7 100644
--- a/lockfile.h
+++ b/lockfile.h
@@ -323,9 +323,9 @@ static inline int commit_lock_file_to(struct lock_file =
*lk, const char *path)
  * for a `lock_file` object that has already been committed or rolled
  * back.
  */
-static inline void rollback_lock_file(struct lock_file *lk)
+static inline int rollback_lock_file(struct lock_file *lk)
 {
-	delete_tempfile(&lk->tempfile);
+	return delete_tempfile(&lk->tempfile);
 }
=20
 #endif /* LOCKFILE_H */
diff --git a/tempfile.c b/tempfile.c
index ecdebf1afb..ed88cf8431 100644
--- a/tempfile.c
+++ b/tempfile.c
@@ -50,15 +50,17 @@
=20
 static VOLATILE_LIST_HEAD(tempfile_list);
=20
-static void remove_template_directory(struct tempfile *tempfile,
+static int remove_template_directory(struct tempfile *tempfile,
 				      int in_signal_handler)
 {
 	if (tempfile->directory) {
 		if (in_signal_handler)
-			rmdir(tempfile->directory);
+			return rmdir(tempfile->directory);
 		else
-			rmdir_or_warn(tempfile->directory);
+			return rmdir_or_warn(tempfile->directory);
 	}
+
+	return 0;
 }
=20
 static void remove_tempfiles(int in_signal_handler)
@@ -353,16 +355,19 @@ int rename_tempfile(struct tempfile **tempfile_p, con=
st char *path)
 	return 0;
 }
=20
-void delete_tempfile(struct tempfile **tempfile_p)
+int delete_tempfile(struct tempfile **tempfile_p)
 {
 	struct tempfile *tempfile =3D *tempfile_p;
+	int err =3D 0;
=20
 	if (!is_tempfile_active(tempfile))
-		return;
+		return 0;
=20
-	close_tempfile_gently(tempfile);
-	unlink_or_warn(tempfile->filename.buf);
-	remove_template_directory(tempfile, 0);
+	err |=3D close_tempfile_gently(tempfile);
+	err |=3D unlink_or_warn(tempfile->filename.buf);
+	err |=3D remove_template_directory(tempfile, 0);
 	deactivate_tempfile(tempfile);
 	*tempfile_p =3D NULL;
+
+	return err ? -1 : 0;
 }
diff --git a/tempfile.h b/tempfile.h
index d0413af733..2d2ae5b657 100644
--- a/tempfile.h
+++ b/tempfile.h
@@ -269,7 +269,7 @@ int reopen_tempfile(struct tempfile *tempfile);
  * `delete_tempfile()` for a `tempfile` object that has already been
  * deleted or renamed.
  */
-void delete_tempfile(struct tempfile **tempfile_p);
+int delete_tempfile(struct tempfile **tempfile_p);
=20
 /*
  * Close the file descriptor and/or file pointer if they are still
--=20
2.44.0


--WRxJXKvM9XCH2DJ+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmXlrDQACgkQVbJhu7ck
PpS45Q/9F9TtnAL/I9tgXpMrqsaXJ5egtz4kNKVUW1c1yS0Gj9Cc1U/IWFTH+2ft
UmjlICMOnnAJGAeK7Jhk2CJ9jT2BKLnIccnCnIF7iVCsVgv9ifw2z273k1IZnJB9
aKm9GcdW0NEJ6xTPAYu5e1K5+VbMnsbf2efWX7GpJe7j/wvSrx+bbfOYN/wQOMPv
Lnbd1Dr9gWwSPnAkblbEnHxjE+d5HZOxB/gB8kFaEzmwCMe58MvT1b7AMDsH0SRM
XCjj/CTXoDwoBYDvzIBp+QmcBtHYt2rmIfctEzA4lmUHeRlPMpmeTG6ZCpn48ZoY
Jd8BPdu6Lx1N1Zj7pLSVxeB6zDkXKmpApKg4QMHO4l5FiupWS50syuFa8mdoyyPW
1sgCeLlV2/gwO6FOVDJi/h3IQ3RYz0Yj+oM7m7AX/BmaR31gVtyO/rlFQkbng8Ia
3zehcZJNBHbp1LR3Tnp8+8fXxr3+03Wgm2Fh05kLsRdNmQlHC+GDApOSkjBquDue
N7hVCG6Fe9AYDeXekwygELy6XjXvxcIzY3C6IHl9EeETFNRwS8hcqE2HO5sXGGIr
Ko2ZLRs4+OhSBw+ZwvzTo5x2Et8bStoGg+5wyZMrZDuJZmMwkifEIWDtRXiekk0W
4b8wzbsHews3GzZIkBvI+4iY57OrxiaFjRrLnTp6fdLj6rk5uGE=
=hcTM
-----END PGP SIGNATURE-----

--WRxJXKvM9XCH2DJ+--
