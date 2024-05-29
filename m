Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436FC142E68
	for <git@vger.kernel.org>; Wed, 29 May 2024 12:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716986685; cv=none; b=uPKJFllnDbw76T4JkhrrNSo6zt15P2P7hWw1QO9IRzYxXiaDuTgsU7ICJM7DYf1ri2V8p70UvbMcX2ckDsnB0BQlKQMIWBE1JkRLk0u7GWwzPnqK3W50d5ZAUBGX9eGXrTODYs5sVeBY+jmMLHvpXsJ8FS5uxRvF3zUv/aFDXnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716986685; c=relaxed/simple;
	bh=LWysdPrqul4FEP4uujm1303OdwEcW9zTO43kk4Bsma0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7BQilURQEMvHsDIGZsrf+jG3W4N9jpQqP7roEMrrSglMyQOxu2ORrEaWi8qNGHsZ6wB+GolYyGOQ89LABFYjkQUbiGI8UOCMuYOeSpt93bajDBDK6HuYJS6a0ZlSqxzTWzsKAoBsNFSGhcO0V8fHLRoBt+ukcEgZFLXPmmPG+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TZrI0dQ/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Cg+jmoqk; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TZrI0dQ/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Cg+jmoqk"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.west.internal (Postfix) with ESMTP id B0DFE1C0012A;
	Wed, 29 May 2024 08:44:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 29 May 2024 08:44:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1716986683; x=1717073083; bh=LQCUNOKyiW
	3UeoGMH2D0OfhNBNI+svjMOYkeJnQEQuA=; b=TZrI0dQ/OzRuyyLF+az4Kt/r2o
	WoaAsjb2GeLZEA52tGQdjBystkoAUOxadrXE/jAI69uWffPFKp+IggQIoexvAEnf
	lGlYQG/JxGdHnTEqCCIHkK3KpNrNxoAORhBUtfWA+aVOjak71YycwZ7FC26QLT+R
	mhORacrWyTxNNBuecEplxDwK/y92OGEjwEHItAXmpHJF9USaFZIVdzSIeIYgMxv9
	E2TGmsGEEoMGLWMCvF9MICLBn3zJzy98fyNh6M4LnTG4mokbypPONApzVrT5Da6f
	YAheFBpCDTjbT8NVzWSzDiTFg0E0gX7a3b95WguOSwGisvLg8gLnAtZ7xzaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1716986683; x=1717073083; bh=LQCUNOKyiW3UeoGMH2D0OfhNBNI+
	svjMOYkeJnQEQuA=; b=Cg+jmoqkcPGcfHHDZEQfeGDWO2l+DT1c91nxFv9yqPDp
	vC9LCt+ZvfHFlaXVhGZf+8fmZShB22sCuZoDL28Ha0diAWTWngxLB0DxOn24oYlM
	X6XuBTCCma7V0jhERe/0Gh/A2gidJkIGCWlaDBCs4Sc5nuTpsA1k+q7P0elL8cZT
	6o6YldZgqCICd1cN/7I2r/nHlxaXs8XPlvKWrfOStkjbe9LIi/Eu8XaPGEa+UFmB
	7tAFV3VwJAnKuQJdEPu6rDV6mCQw5JWeKMvZHH/SL00euwGA8Yrvg/FWTUUwbNu2
	mz+tzgXfy9/otQRdL+eC++wVUuum68ktRxriWH8fPg==
X-ME-Sender: <xms:OyNXZho8c1NxuaHaDAf71y8BMElaVUUHjl7tdq7uCdjlwD7ruIdzBA>
    <xme:OyNXZjoP_kvc4kYap7fw9xJ3Vaw8PsWQXrZYAlj6EsXqG2_-mUAuDORqr7Ye4kCmC
    2LMOFzf7qCEVFvy6g>
X-ME-Received: <xmr:OyNXZuPvsunDy6wMaRbV8E14MXewwXTJT3_jWSv2f7bzXfhrT4wdChYkHbfnbnxJxHDDUZbAazyAFrW2Fv3OgDBOmP2gpSaoRitqHDNY5Pomvhzf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdekuddgheegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeeukedtvedtffevleejtefgheehieegke
    eluddvfeefgeehgfeltddtheejleffteenucevlhhushhtvghrufhiiigvpedunecurfgr
    rhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhm
X-ME-Proxy: <xmx:OyNXZs6B3YiOtmXnRz5U9LYtVlXE5GhnVSMEHkIukB1gUg-JKxY5rQ>
    <xmx:OyNXZg4dG9NbXHD3tBC6p7jQ95Bnc6ModY31tI_gheAZnfc4Dwfv9Q>
    <xmx:OyNXZkiPdKwjUlUNXCeCFWD8e721V6d0Qu4nfuy-EUJiLdpA_W8Txg>
    <xmx:OyNXZi5DWR_7zqo6H9IF23JA65dKMN3iLGz4TBstY5S8RVtV849efA>
    <xmx:OyNXZgF-W68aKlrvTU66DJEX9je1GYaBf8kJs1zwYOTWlx1oR2z5KhDG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 29 May 2024 08:44:42 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 61639a25 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 29 May 2024 12:44:27 +0000 (UTC)
Date: Wed, 29 May 2024 14:44:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>
Subject: [PATCH 08/19] line-log: always allocate the output prefix
Message-ID: <699eeae92c0f58032fc76af68521d8cc60f12031.1716983704.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/jCDD9BvjmoeR7j9"
Content-Disposition: inline
In-Reply-To: <cover.1716983704.git.ps@pks.im>


--/jCDD9BvjmoeR7j9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

The returned string by `output_prefix()` is sometimes a string constant
and sometimes an allocated string. This has been fine until now because
we always leak the allocated strings, and thus we never tried to free
the string constant.

Fix the code to always return an allocated string and free the returned
value at all callsites.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 line-log.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/line-log.c b/line-log.c
index d9bf2c8120..9a298209d0 100644
--- a/line-log.c
+++ b/line-log.c
@@ -899,14 +899,12 @@ static void print_line(const char *prefix, char first,
=20
 static char *output_prefix(struct diff_options *opt)
 {
-	char *prefix =3D "";
-
 	if (opt->output_prefix) {
 		struct strbuf *sb =3D opt->output_prefix(opt, opt->output_prefix_data);
-		prefix =3D sb->buf;
+		return sb->buf;
+	} else {
+		return xstrdup("");
 	}
-
-	return prefix;
 }
=20
 static void dump_diff_hacky_one(struct rev_info *rev, struct line_log_data=
 *range)
@@ -927,7 +925,7 @@ static void dump_diff_hacky_one(struct rev_info *rev, s=
truct line_log_data *rang
 	const char *c_context =3D diff_get_color(opt->use_color, DIFF_CONTEXT);
=20
 	if (!pair || !diff)
-		return;
+		goto out;
=20
 	if (pair->one->oid_valid)
 		fill_line_ends(rev->diffopt.repo, pair->one, &p_lines, &p_ends);
@@ -1002,8 +1000,10 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
 				   c_context, c_reset, opt->file);
 	}
=20
+out:
 	free(p_ends);
 	free(t_ends);
+	free(prefix);
 }
=20
 /*
@@ -1012,7 +1012,11 @@ static void dump_diff_hacky_one(struct rev_info *rev=
, struct line_log_data *rang
  */
 static void dump_diff_hacky(struct rev_info *rev, struct line_log_data *ra=
nge)
 {
-	fprintf(rev->diffopt.file, "%s\n", output_prefix(&rev->diffopt));
+	char *prefix =3D output_prefix(&rev->diffopt);
+
+	fprintf(rev->diffopt.file, "%s\n", prefix);
+	free(prefix);
+
 	while (range) {
 		dump_diff_hacky_one(rev, range);
 		range =3D range->next;
--=20
2.45.1.313.g3a57aa566a.dirty


--/jCDD9BvjmoeR7j9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZXIzYACgkQVbJhu7ck
PpTqlhAArgfeLPC1zP75aXTSlUoHoubMAg1kws9dqrvao96nYmnssMrMFmVF5uTX
M0BKpi4IAdto0pirss2eqAI/nFsPOSD5TyLlIGSmm8q7hmjwF5emQORDNW8qXPuj
BtkLLixQspdv+RlttST31lzwvJVwCLyt9GGUn/zBitRXSBDtrXl7GVWOtbovjojI
Z50KEStMplp8vE18oVQA3pA9czz19zikU4sn8r7Ru7cf5pTO7cHn2IbVYGZHFZEk
Sbm/B/9YeH4KP2lzUjgfpOyZChEhY9i6tDD9xJiCA/EEu8VtqVEkocTbKVFoupfq
+SyuBnfT8HpTZ9mZ4e0XMLP9gGgIBh+obPkrE9Gj1pLhProNEGQh822aOj1Csaxo
RFnTbhS7m7QflzUzrSo0t3QgRWFfBjPQChZLqca1FbKsngYJ0THm49sfiRwJdjgf
vv//LA7dsQdeIjXcHNnFa9ZITZdS7p1GtoPp3YGjV1V+XGBQnxUehf2VZgll1ows
nCz7Y/Ry8Ske5WdipGkEz6AikvP3i07/nfrQTM/R1fExJngj0COEoNYwxW+XBR2a
NwZgVAEJkO6aMU50CZ/A2kYMq6NFXoP2uLIVU+If9sa1YNwXKhbWsYmyspEUdMNT
u0t5jhZSQNKYbwa/O9oVEkr1/Ow+0bPS54UMGEL0grp6nYHh6p4=
=9fFH
-----END PGP SIGNATURE-----

--/jCDD9BvjmoeR7j9--
