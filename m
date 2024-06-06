Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18D7B194C6F
	for <git@vger.kernel.org>; Thu,  6 Jun 2024 10:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717669685; cv=none; b=LVtAYRjsFA2arIwyRIaJTN8gF32UjT1c8BpBxLCmFdi3IhmT0JMexnoKKMt+9yjZW385uweSPDNtZhIy083lUB880gWao97/N54zC2ZvL61KNeu4PKLlM+7vqQyYuVRpqWtQ0qU2z1HjRMLY0zyRZOT9SGx7x7+PDxM+8/UZPEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717669685; c=relaxed/simple;
	bh=EwH9Kermm252vpbtwvlowIx6/+wPkE9Kgh5n4bG0/hs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hxJ2MtApSXfLzhIIddEn26Sc/Gz8kNHnlOxg5EvMQBHou0WDDN4CWrakg66Er/ue10TvPeJ10Ex5Ol46gHP2TlmmMbpWcZ08cOjLQJnxIAwVRhKA746lSRyW4XRm/1MY0sfDFxrXcJ4qeNZ5pyGjnGNahw5QMh7YugOp9PKicRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=o93U8Ntk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Tabtmbj/; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="o93U8Ntk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Tabtmbj/"
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 4032111401FB;
	Thu,  6 Jun 2024 06:28:03 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 06 Jun 2024 06:28:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717669683; x=1717756083; bh=yvqSfIcSv7
	xm8uEmCyjcNWC9llbcilvfLI7QDQskJa0=; b=o93U8NtktOTXQS6475RViqhziL
	QP+jENAug5+OFgXNlqTJrnG3wLW7pM1GpvRHmnm3nLjzisTj1GuISmW8iQXWeHqq
	X61MS+W3SLYcXId327nktPM/1DOz/Ke5TuxoY0qBmMStvAoA5NOS2j6ycQ22ofHW
	SH5N3i1wb8SPs9Bo8NTWJmE3cm+GN7w7GW8BO0p26pAy2tcnp+ACVrrv30GRd8tW
	NGbb7ORdSyPDGs8XshXwOGn22Saa+Xwowly1yl96feuoprotLYisM2V7iX7PVPQi
	z2UBYCRAvgP86cjI3h6TcqLmFCkA5SglJz/HQvxqF4HwIEe6IVgI2qCvi2dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717669683; x=1717756083; bh=yvqSfIcSv7xm8uEmCyjcNWC9llbc
	ilvfLI7QDQskJa0=; b=Tabtmbj/RGYtYnxYZ+p8NaOKh2KZHvivnroDCCyNlnzR
	kYP99mps/1kFl36LLXNbZI0aEQzPhYmJlaktNlfP13AIYPN5B/Q9lSqgJzCaMHCS
	XitkAVc29eA1o+v0hpwSO7pom554PrCyzH8LirA/9JcxPZEu83EE/dhlh7Dw77tt
	PbduN9SiuE5BgqREqdzghoDJLfil2UkqRql7K09Gmu1JCAynFvlkZV57Rv61yyOp
	KdKqPlitDo6hZVw7YHTx9cLjhJYAcf/WwLVw1FxoO3zvJI+2K4zMW8558KicnC9X
	oHJwJmqdcPYyABEy2xgX4wT33R4EI351EH9q3wy4cg==
X-ME-Sender: <xms:M49hZtNvjv3eCZuOHtD-giKUC81ijtMWxig3RU0URa9lrJ85aHQ-jw>
    <xme:M49hZv9Kl0b-IPBxZHhLpRuFfzxnji5rZXvHuXy9p6qox-ZnOJlTgEqzdlE8tBTAo
    CeXgWYkv9Z3lk37Dw>
X-ME-Received: <xmr:M49hZsRgQDhLuR_78WxFosX7j3ojzJWJGZKi34UidhyvVpcFA50gAwOVZuW9w4fRJU5ZxZD3ybOv-feh5eIqjEj4t6sGkt0GR3m9XgsDBF33e6i9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelkedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgfffteefgeduvdekfedtheffgeefteeugeejiefhkeeukedttdefgfduvddtheeu
    necuffhomhgrihhnpehuphgurghtvgdrnhgrmhgvpdhuphgurghtvgdrvghmrghilhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:M49hZpu37DvHpPmcjAWSK4bYAE4qJP-3qFHHvRv25MBESlfWovzcuw>
    <xmx:M49hZlcz5xkQ3ZKbpb5Jqbeg8Mn6O3pvLbe9G2Iiic8a7zXL22nmPQ>
    <xmx:M49hZl2iqwajrUI9M0QWiTskMSiEcAg6W0VkRYacyPAbaamGcNQOdA>
    <xmx:M49hZh9BTdF4a9LeHH052faesB7cDe8_QfWxy3Yv5Et_9rU1BbANfw>
    <xmx:M49hZs401PVQV5J_Fy7lXu9_ABEqipxYZa5t2ZzLOzsJoHgc1ApFRfEB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Jun 2024 06:28:02 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 0e4e9955 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Jun 2024 10:27:31 +0000 (UTC)
Date: Thu, 6 Jun 2024 12:27:59 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v5 03/27] refs/reftable: stop micro-optimizing refname
 allocations on copy
Message-ID: <379145478cbbf59387c799952a97abc16a528eab.1717667854.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717667854.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="6y2GsJs4nLloQmn/"
Content-Disposition: inline
In-Reply-To: <cover.1717667854.git.ps@pks.im>


--6y2GsJs4nLloQmn/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

When copying refs, we execute `write_copy_table()` to write the new
table. As the names are given to us via `arg->newname` and
`arg->oldname`, respectively, we optimize away some allocations by
assigning those fields to the reftable records we are about to write
directly, without duplicating them. This requires us to cast the input
to `char *` pointers as they are in fact constant strings. Later on, we
then unset the refname for all of the records before calling
`reftable_log_record_release()` on them.

We also do this when assigning the "HEAD" constant, but here we do not
cast because its type is `char[]` by default. It's about to be turned
into `const char *` though once we enable `-Wwrite-strings` and will
thus cause another warning.

It's quite dubious whether this micro-optimization really helps. We're
about to write to disk anyway, which is going to be way slower than a
small handful of allocations. Let's drop the optimization altogther and
instead copy arguments to simplify the code and avoid the future warning
with `-Wwrite-strings`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 28 ++++++++++++++++------------
 1 file changed, 16 insertions(+), 12 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 1af86bbdec..e77faa2b9d 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1340,10 +1340,10 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	 * old reference.
 	 */
 	refs[0] =3D old_ref;
-	refs[0].refname =3D (char *)arg->newname;
+	refs[0].refname =3D xstrdup(arg->newname);
 	refs[0].update_index =3D creation_ts;
 	if (arg->delete_old) {
-		refs[1].refname =3D (char *)arg->oldname;
+		refs[1].refname =3D xstrdup(arg->oldname);
 		refs[1].value_type =3D REFTABLE_REF_DELETION;
 		refs[1].update_index =3D deletion_ts;
 	}
@@ -1366,7 +1366,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
 			xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1387,7 +1387,13 @@ static int write_copy_table(struct reftable_writer *=
writer, void *cb_data)
 		if (append_head_reflog) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			logs[logs_nr] =3D logs[logs_nr - 1];
-			logs[logs_nr].refname =3D "HEAD";
+			logs[logs_nr].refname =3D xstrdup("HEAD");
+			logs[logs_nr].value.update.name =3D
+				xstrdup(logs[logs_nr].value.update.name);
+			logs[logs_nr].value.update.email =3D
+				xstrdup(logs[logs_nr].value.update.email);
+			logs[logs_nr].value.update.message =3D
+				xstrdup(logs[logs_nr].value.update.message);
 			logs_nr++;
 		}
 	}
@@ -1398,7 +1404,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
 	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
-	logs[logs_nr].refname =3D (char *)arg->newname;
+	logs[logs_nr].refname =3D xstrdup(arg->newname);
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
 		xstrndup(arg->logmsg, arg->refs->write_options.block_size / 2);
@@ -1430,7 +1436,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		 */
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		logs[logs_nr] =3D old_log;
-		logs[logs_nr].refname =3D (char *)arg->newname;
+		logs[logs_nr].refname =3D xstrdup(arg->newname);
 		logs_nr++;
=20
 		/*
@@ -1439,7 +1445,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		if (arg->delete_old) {
 			ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 			memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-			logs[logs_nr].refname =3D (char *)arg->oldname;
+			logs[logs_nr].refname =3D xstrdup(arg->oldname);
 			logs[logs_nr].value_type =3D REFTABLE_LOG_DELETION;
 			logs[logs_nr].update_index =3D old_log.update_index;
 			logs_nr++;
@@ -1462,13 +1468,11 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	reftable_iterator_destroy(&it);
 	string_list_clear(&skip, 0);
 	strbuf_release(&errbuf);
-	for (i =3D 0; i < logs_nr; i++) {
-		if (!strcmp(logs[i].refname, "HEAD"))
-			continue;
-		logs[i].refname =3D NULL;
+	for (i =3D 0; i < logs_nr; i++)
 		reftable_log_record_release(&logs[i]);
-	}
 	free(logs);
+	for (i =3D 0; i < ARRAY_SIZE(refs); i++)
+		reftable_ref_record_release(&refs[i]);
 	reftable_ref_record_release(&old_ref);
 	reftable_log_record_release(&old_log);
 	return ret;
--=20
2.45.2.409.g7b0defb391.dirty


--6y2GsJs4nLloQmn/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZhjy4ACgkQVbJhu7ck
PpS4lA//YZ9R2g1pUpU98Gh0umaymFE11+q1SeYrZRxXRDVu6+I+XWCgGDJbjDtI
84WUtKL3YhypofzpLqlGyxasJ9Gqz+n0k96AsTTumibBU8QCm97+5FUySAyWJUvj
bVDjDmJU7xcJmCAPk/x595RUhIHxU3hW2vMvH7qmufqnxMeecDTg8vDxtqpTaNzd
po0DespxQ1ZqDjxJtWaL+mLyRztk4hh9ajXcNlBFXwQwSlRGJd8FxCEEsde68/zY
9Dipmd/iDNS5/yvNwe4sBw3XrvDTOh2fahSc1WMRjhnawmd1OJv+I8iN6rAS1qYy
AJYn38hIMoX60ydT2/HGMDzxOn0v1A0ataaxz8PPaUOWHs3+uCzaoGefNhiRECZi
HOIVqGRuZDFGppB+0bC//S7Cvd70O5Aui+ADYhiw1S/2020hjV8aFeOcMH7xMt9w
zRAtlr8zzJLaTVoih4FUiK1EBONMZxUFjJ0BNe9Nt6GYpUFnOw8E5t1/+gFSl0qn
Tj0pn19wkHQrh+uFWwQt2e0hUY9rCk+wEY0/B6xQ4s+iRbwB5Yd+wwE7HKA918wR
+Gg5K5H0TjoBMiunJK/GgNn+D/nZjV9A6XqYw3uYiRiCbaOnahEnd5uS2imQY/+Q
OrDwdqK+Bzv69lLwhMINL45LPV7loZFdpRVO3I7/xu+UA0YqhY8=
=35uQ
-----END PGP SIGNATURE-----

--6y2GsJs4nLloQmn/--
