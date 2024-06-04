Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F568145358
	for <git@vger.kernel.org>; Tue,  4 Jun 2024 12:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717504631; cv=none; b=WTKNlUbZ7o96BUcdUKqf1UrLl5nJJWk0eBJ6mjGAYgwvCfy7NxlYaeqVHlHcJepPYzGxewDzMxj0vjp5YRA+QlqVSrzQ9tDREx63l8tQaMu/geRYr3cAq+Vdb13JT7PsrTa9qUCWEwMeJOkWgNEttTxArRm0DTDft8J9rppAkG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717504631; c=relaxed/simple;
	bh=lbi5wr0zHsn04kYVYgaP1e/qvWsoNcDNJSb7k/rl8Oc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GtfRz0IQFZZuu/hD8WrnDLpsliYa9TMAZZtakhmsuDYXqq8gf+KjMSuyD4CnslOhB93DrAE6NV3vO3oaWc2NQ5YRyuxvPUv2RAbgGsdQ1S2/86wIaD2b3Fyu8mbduGvszGlcIoAds0BGbgBZL01okM6amYXMm02aQS9yozoaUM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=cbea6R2F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wv61xkqY; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="cbea6R2F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wv61xkqY"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id DB86911400C2;
	Tue,  4 Jun 2024 08:37:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 04 Jun 2024 08:37:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1717504628; x=1717591028; bh=J4ibQ7qQUR
	af9UzmFendo09VM8PT0GswMpr0TwrjdF0=; b=cbea6R2FXbwls3ixBw9Dn3sbZ5
	heQgDW14J8KhKL53mrq8UJENLCxToSMnSjEVMXXjHHl/7zLazC1mRhJfexmCML3e
	Eu40jQYqWDNj92NrIIZIWmYYPF9wUipq05EKEYdTikT1AnsqzqnjLTGFqlOkF5LG
	hm3lT7MSvWFAg4kRkKRhzDKE0jP29ywTLUxHRStyPv4zDVj6H14R3rx0f8aGTMsy
	KblB1OPnbTG2aX/abCmxVNy6LjtQ/+iNKuAPttXHdXxhaowjDEpyM/w8pVh/cG/7
	m0SD65QcaNMjryMyP9JS5yd+Izks8VjT4HqJ3roz+V4l+L0/7FAqthg0yYbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1717504628; x=1717591028; bh=J4ibQ7qQURaf9UzmFendo09VM8PT
	0GswMpr0TwrjdF0=; b=Wv61xkqYNwcofV0HeZIHA4MBQcNzgHf5B8COOp1Ip+vg
	4gAxmwaKW5CyfMKQ3fo48FHcXAiQDWtgIrF8/2papCNtHH704my6AMfVb656tbgA
	cu5POrT8P5aaiirquD75m//90rlheLJebbcyohfjRSeobzYD6xaY5n9w6JwY+ISu
	TusOz4gXuXSZrouOOYd3eFKWXdaHwu2Ux+CwegRRlfJqQ0RApbOvJmWgeZboHBLX
	SMu3oNOnrrGpAWNzh2BofmNbITLRQOK2KWI4jsmpfMTba1IPQtBQZdWqBO0Cx8R6
	AIfem7ZBYRTW+QrntG2H94YS036gxRHwDdR+69XAug==
X-ME-Sender: <xms:dApfZnp2EJBaIfiZ3Hhc6b-FppLrYIAixrzN3n74fA91Svuih1SVlg>
    <xme:dApfZhoq4m2I1c5qUYyXCzrsCVSoqurl33qLp7LdQ47AZbbPn2YAgntpDBZ0Kw1jn
    5X__dYdSd-DTe0Z5A>
X-ME-Received: <xmr:dApfZkOhd05k-Ki_QmWeGeDJ0dpU_9kqSqCpJrYXPv94xttr1cmX5xi5sE6uKbvSBsf5KulW4BW82vM542-dEszYotofsuRVJCsn_RInTg4seyk4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvdelgedghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesghdtreertddtvdenucfhrhhomheprfgrthhr
    ihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvg
    hrnhepgfffteefgeduvdekfedtheffgeefteeugeejiefhkeeukedttdefgfduvddtheeu
    necuffhomhgrihhnpehuphgurghtvgdrnhgrmhgvpdhuphgurghtvgdrvghmrghilhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhm
X-ME-Proxy: <xmx:dApfZq5HeexinsqpE1lAYdpNH3o0LlH_ETDQv0cp_sJGacbvrmeTGw>
    <xmx:dApfZm6dtdpFKb7gMYjyjrSKQuuKO5q5P3Eg_U9NkztjE0wybTlNtA>
    <xmx:dApfZih4E1EjI2eK3llFlDAj29ztddNqeFqgz522i2XqGaJnSIvRJA>
    <xmx:dApfZo6qu-r8Ic1tX8LrsWpuw6hyj5sSI2Dfz_K-_TUkqfMS9ysdpQ>
    <xmx:dApfZh29lv78WCO63fbxZgsyjXTnhfYP8CIEAlwnT8SyyHwTqRSzV2i8>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Jun 2024 08:37:07 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 63e280a5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 4 Jun 2024 12:36:40 +0000 (UTC)
Date: Tue, 4 Jun 2024 14:37:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v4 03/27] refs/reftable: stop micro-optimizing refname
 allocations on copy
Message-ID: <379145478cbbf59387c799952a97abc16a528eab.1717504517.git.ps@pks.im>
References: <cover.1716983704.git.ps@pks.im>
 <cover.1717504517.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="V8lP1NVa7W/pGWjO"
Content-Disposition: inline
In-Reply-To: <cover.1717504517.git.ps@pks.im>


--V8lP1NVa7W/pGWjO
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
2.45.1.410.g58bac47f8e.dirty


--V8lP1NVa7W/pGWjO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmZfCm8ACgkQVbJhu7ck
PpSuaRAAlHodVo0MDMtnon2Zzp3MK68EOrBqYa9JhI4VUw5jGD5GmZvWebqN8x/5
dei73z3eiOZapPQK6B2QArXFGPNz+20bDx+1+/P4aWm0liHLK0D8MSgLeUbxzy2W
2h+fezvDAg0MYfqrNQZFeVNjvDphZoFjh4uKOqHhtLdEMhxTtzKjRbKJdzZP2s/r
q/3JsGeFpbByFTNASvjVwQ6ZpIEPNnAKQ+eYl0B27JXVH7Zx+uV2IVRNTuiX5TdW
oWTqooXXIhpw1nU65C0LJU4utMRdBjxDwFGmKZcaPkYzTjTwsPmfQ7fdn5MeNxvU
NHOOsmAIYcs/E413YBjm008swUC/rQCrom+aYBFfnAXj7OCLyCD15PsFnDzyxD8z
rlXyKlXYg0mn4UXD/2NR4heQOvQKCW+l/Pg8BMf8us304QZnN885v+iOg+TQuEKL
fKLcW9GfXiSqJpqjygFlkCU+y/gc0g4blj8CWJGq46xI7e6nQgIO8z3HZns2hn0O
cjS7vEovLUg14eiG0LZ9K0CfcNPcZkkOGVdp/WgcnpkSPUef8JGnVPu59mGUBAhK
SA+wYrZ/mbL+fqi5lz4vN1u9FSDXSvGmqLRGQg2UKbmnjktOEQB5oWHPaQc4jq8E
j+TFr1qEvFc4HFQC5l0IfFAJRoWLkl7Xnjs3oWmRFvSyo4S1XMU=
=XJrl
-----END PGP SIGNATURE-----

--V8lP1NVa7W/pGWjO--
