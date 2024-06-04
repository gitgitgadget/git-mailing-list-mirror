Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55C78145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504625; cv=none; b=tgMnFGmG1p3EBde67hHqzHtiHxDPfQcgJgkjnLK9ngLXa5lSToTdJPjHNF+Ib9GMYEnHtnoxDQiK91q4B4tPq+Pj3wXx/X6kQeoiS3wLaiaVkJQFzLFAyKrzKqHv2fZnlmAEn/hKdclmxqFAtxXiOhMVzkQSfjvDYhb8eQ7c0sY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504625; c=relaxed/simple;
	bh=ualDKyphwEzfOUMZnaTYlFFUpi9YVwUAsj0XHEHkDlw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8Jo6yXB7jQk7VICIW4STFIUBQSJ675FnvMFqdkmDK9cd0ijBrhyfLs8pdDZOzKj5WlMk0o+mgezeCJ230dUWKJh46fQ5OY56ISsqf4Qg8eb0ZkWzvetRn0r0asr45ig0YWHKZDc6KcOlvYn7rdIxa4wzs6Lr4QLL43X9Q5p0H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bclETh6a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gqJ0QhMX; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bclETh6a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gqJ0QhMX"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7008D1380153;
	Tue,  4 Jun 2024 08:37:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Tue, 04 Jun 2024 08:37:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504623; x=1717591023; bh=dTVd4EkA7P
	ogpV+O6bKYT/T/QVKt2+5dQsFBLuHiCa4=; b=bclETh6a6G9woyeP3uddW0DqUT
	dayOZ6iAoWE4m+8LI0V2ra8NN8apyJyTI4+6ky5rxgO2zQk/k3mmV75J6t5GrZ4k
	YGcKHZUXO1oDUvsjDteybfeULu+O4xCz7eNSOU271nHGhHHEa5i8UegPZtX0RePK
	MxJ1ekBEwmKsYnQZyVMkM5CoE+wrLXMAT9iYTyE08YcWK+xF8fwINheJta7r8wae
	5lI/RDA6+aXhmY3SAGGiQuTMgmU5Y/jNFTTTMoA+JeXEAqU3/czEf/rELrRWNf29
	Zc6RqGDgsG6uXbsxHr14I7QC8ATiGz0txhRuFunCfvgh40p2KoXvt73O2agQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504623; x=1717591023; bh=dTVd4EkA7PogpV+O6bKYT/T/QVKt
	2+5dQsFBLuHiCa4=; b=gqJ0QhMXkY8P32sgNdcD/da2gryDEo3UpNgHiZU14Xle
	Dd/4XTiQVaI4AHeUaTabBCJN7jaFtII11pyMfun9fFqVNXR1jhfa1j/W4ZKU8/Q5
	HjOk55cbqOrxa3ZpHXXoyYYWNMlUzjmTzz4xG2x2k12HHzhkLvrHEbZAgKflfGvv
	uUy0LaTF2pKjYChTFtkcl5Obvjuj25WsopYE+AEOLO9sZ/pQ/VUm4FU2VxVL9N8o
	1PJZ1Mb0ergsVTm/Ctpv/AEjzPsYjECdVL6XeBMRWnaTS68PZgPLR2lr05ci0jNe
	kzB/bv+4H62BCwJLn7l4a/WpXWlrDTXN7y8cI28JZQ==
X-ME-Sender: <xms:bwpfZosoj_DvSOPhIdNNlF4JkJQ8LGKqrldMkiSSJsO9ClpgPOvqlg>
    <xme:bwpfZldBez0LRg9AFT92v5xzgH0qpxhWIlhIbaN3ycAedkgJVPQ60qnj5A2igQ-Xe
    myhZDLaXZuIX96D-w>
X-ME-Received: <xmr:bwpfZjxUw48duJxS7kgAeK1UuNmFDxmZb9Gn5XVwBuBRvs4GRNKUD2so2D3jfpFjaExbaZdk5nCItj1DJqr96iNtuhptl4ypbvrggqmzkA60pGjg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepueektdevtdffveeljeetgfehheeigeekleduvdeffeeghefgledttdehjeelffet
    necuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhsse
    hpkhhsrdhimh
X-ME-Proxy: <xmx:bwpfZrMxDKhCVV0QqDI-GYWGvf8NR6TvAiCCZLM_NyUmkp8qbU3kBQ>
    <xmx:bwpfZo-_H8l1QCDaw3QVpDIDp4WuEzbmBm8vFKkPgkk2RgryAREm_Q>
    <xmx:bwpfZjWmWUOr1fUciX5gpoHTaWAfI7eLGXufievMpdC9xW0NcyJR5A>
    <xmx:bwpfZhf0-NmRrAYcEUoFDzOCXL8mGVrA9kn44oSN0Vyka_bOKIvNbw>
    <xmx:bwpfZsZO9p3jYbuBS77BrJTiQDllj_A6xZNWIJJTOBJJiJbe2ch64jsV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id d5fdc23b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:35 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:00 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 02/27] global: convert intentionally-leaking config
 strings to consts
Message-ID: <92cb0b28c65bed0f3cd10e6c4c57b98f199536a9.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="WemnOJwW6BzdjRjT"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--WemnOJwW6BzdjRjT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

There are multiple cases where we intentionally leak config strings:

  - `struct gpg_format` is used to track programs that can be used for
    signing commits, either via gpg(1), gpgsm(1) or ssh-keygen(1). The
    user can override the commands via several config variables. As the
    array is populated once, only, and the struct memers are never
    written to or free'd.

  - `struct ll_merge_driver` is used to track merge drivers. Same as
    with the GPG format, these drivers are populated once and then
    reused. Its data is never written to or free'd, either.

  - `struct userdiff_funcname` and `struct userdiff_driver` can be
    configured via `diff.<driver>.*` to add additional drivers. Again,
    these have a global lifetime and are never written to or free'd.

All of these are intentionally kept alive and are never written to.
Furthermore, all of these are being assigned both string constants in
some places, and allocated strings in other places. This will cause
warnings once we enable `-Wwrite-strings`, so let's mark the respective
fields as `const char *` and cast away the constness when assigning
those values.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 gpg-interface.c |  4 ++--
 merge-ll.c      | 11 ++++++++---
 userdiff.c      | 10 +++++-----
 userdiff.h      | 12 ++++++------
 4 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 71a9382a61..5c824aeb25 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -34,7 +34,7 @@ static enum signature_trust_level configured_min_trust_le=
vel =3D TRUST_UNDEFINED;
=20
 struct gpg_format {
 	const char *name;
-	char *program;
+	const char *program;
 	const char **verify_args;
 	const char **sigs;
 	int (*verify_signed_buffer)(struct signature_check *sigc,
@@ -783,7 +783,7 @@ static int git_gpg_config(const char *var, const char *=
value,
=20
 	if (fmtname) {
 		fmt =3D get_format_by_name(fmtname);
-		return git_config_string(&fmt->program, var, value);
+		return git_config_string((char **) &fmt->program, var, value);
 	}
=20
 	return 0;
diff --git a/merge-ll.c b/merge-ll.c
index e29b15fa4a..180c19df67 100644
--- a/merge-ll.c
+++ b/merge-ll.c
@@ -27,7 +27,7 @@ typedef enum ll_merge_result (*ll_merge_fn)(const struct =
ll_merge_driver *,
=20
 struct ll_merge_driver {
 	const char *name;
-	char *description;
+	const char *description;
 	ll_merge_fn fn;
 	char *recursive;
 	struct ll_merge_driver *next;
@@ -304,8 +304,13 @@ static int read_merge_config(const char *var, const ch=
ar *value,
 		ll_user_merge_tail =3D &(fn->next);
 	}
=20
-	if (!strcmp("name", key))
-		return git_config_string(&fn->description, var, value);
+	if (!strcmp("name", key)) {
+		/*
+		 * The description is leaking, but that's okay as we want to
+		 * keep around the merge drivers anyway.
+		 */
+		return git_config_string((char **) &fn->description, var, value);
+	}
=20
 	if (!strcmp("driver", key)) {
 		if (!value)
diff --git a/userdiff.c b/userdiff.c
index 82bc76b910..371032a413 100644
--- a/userdiff.c
+++ b/userdiff.c
@@ -399,7 +399,7 @@ static struct userdiff_driver *userdiff_find_by_namelen=
(const char *name, size_t
 static int parse_funcname(struct userdiff_funcname *f, const char *k,
 		const char *v, int cflags)
 {
-	if (git_config_string(&f->pattern, k, v) < 0)
+	if (git_config_string((char **) &f->pattern, k, v) < 0)
 		return -1;
 	f->cflags =3D cflags;
 	return 0;
@@ -445,15 +445,15 @@ int userdiff_config(const char *k, const char *v)
 	if (!strcmp(type, "binary"))
 		return parse_tristate(&drv->binary, k, v);
 	if (!strcmp(type, "command"))
-		return git_config_string(&drv->external, k, v);
+		return git_config_string((char **) &drv->external, k, v);
 	if (!strcmp(type, "textconv"))
-		return git_config_string(&drv->textconv, k, v);
+		return git_config_string((char **) &drv->textconv, k, v);
 	if (!strcmp(type, "cachetextconv"))
 		return parse_bool(&drv->textconv_want_cache, k, v);
 	if (!strcmp(type, "wordregex"))
-		return git_config_string(&drv->word_regex, k, v);
+		return git_config_string((char **) &drv->word_regex, k, v);
 	if (!strcmp(type, "algorithm"))
-		return git_config_string(&drv->algorithm, k, v);
+		return git_config_string((char **) &drv->algorithm, k, v);
=20
 	return 0;
 }
diff --git a/userdiff.h b/userdiff.h
index cc8e5abfef..d726804c3e 100644
--- a/userdiff.h
+++ b/userdiff.h
@@ -7,19 +7,19 @@ struct index_state;
 struct repository;
=20
 struct userdiff_funcname {
-	char *pattern;
+	const char *pattern;
 	int cflags;
 };
=20
 struct userdiff_driver {
 	const char *name;
-	char *external;
-	char *algorithm;
+	const char *external;
+	const char *algorithm;
 	int binary;
 	struct userdiff_funcname funcname;
-	char *word_regex;
-	char *word_regex_multi_byte;
-	char *textconv;
+	const char *word_regex;
+	const char *word_regex_multi_byte;
+	const char *textconv;
 	struct notes_cache *textconv_cache;
 	int textconv_want_cache;
 };
--=20
2.45.1.410.g58bac47f8e.dirty


--WemnOJwW6BzdjRjT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCmsACgkQVbJhu7ck
PpQw9g//YQr3p2to/fB08LxVOu68Bj3qgAUW7bX2k80Gy1cmuIPqmhK4tktkXCro
hp7gIzMpmrbd6O3bUrLfP5hYCvNYgRJb6RuNAz4gbDpLsRDx0uZ13fmIzk4CskJC
kIMA9XDeUcNn7UKmBLeEwlsDJ6A0S+FPXF6tkm4Y7y19PH/8RbBoW7BHhowUWzBw
mOFwvmL/Ny1VyhaM+zPaSULjmQ3JxaMT+eSYAkr/DaELoBsm8TIIauO6wJcKccfD
01oMz01YaCowFf1QYcxhFL+/B006JvPmRyZHCp2YFYNYUDJ6PykudqujnOp87jkK
VlzCTQI6Rwus2lIzA/W6NgXTRLMSkdzgOQhii6nLCS2pRp3g3eiaO4H5gIQLxpM4
qJRIVXRk+a0A0iwf6xV54BrQa/5Q1m0JCb2e4hJwDk5/PA1S/LdzC/TvlFI1e5dR
kDAfSDJp2Z69LtNFuysND/5xIcpqdhgYSvEeJkomhgoU0P33G+8ZV0nMZwOaX91I
kIo4a1/QcBz4kLpsz30NUHO2YLIXi5UWlXgUZ5tmAhMqVVr4QYzgHeWeCegOJwNj
c96Uzv3OgRLD8hlCHC0UBjvkZEOHJiM1PXB2R65bgcYrP6W2YTooaZXzxsRTqm2d
0cMhnsaZbvhpBN4+5UE74JN3Pliabz6F405NMzTmEuxc7auT+Fc=
=ZSDS
-----END PGP SIGNATURE-----

--WemnOJwW6BzdjRjT--
