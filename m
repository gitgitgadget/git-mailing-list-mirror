Received: from fhigh6-smtp.messagingengine.com (fhigh6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D2B871753
	for <git@vger.kernel.org>; Mon,  8 Apr 2024 12:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712579057; cv=none; b=XjmbZMJYLTjRMkl1oajlFs25CSHeBk+vlBocHBT74A1t0KLkIakZSUuvC/eZWNTTtZKf0vLRaGkz58ERgDjPsfa/upzWe5DJ2K2EppeXyAFzijRoMj6rTLAchOPQBkFyNi1yYRyeH/OcrpwCQwovRGYk2RHqiEkY+XxGGuDKltM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712579057; c=relaxed/simple;
	bh=L2q72KL0Vi29cvlSAQQGLoE+STH3emnnsBLdYbgS+2M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YNVDVZDy0vlkJgMPD9cI/FfZg7LlCxhghMxHj9hyDa8+6i1xG0rJZxjEdR+aasgCRgp5M+R0rmT54Q8jGbvxV0QJbEpoIJQWIke4wlbbZSAwH0xAa5jTgeJM82ndcRrheO+xzlC8wjrKTF1hTNp0CuNssYjUrq/svFKYvw3cx24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TFFQRzz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oVCWU1+l; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TFFQRzz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oVCWU1+l"
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 8AF70114010A;
	Mon,  8 Apr 2024 08:24:14 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Mon, 08 Apr 2024 08:24:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712579054; x=1712665454; bh=a6sLCF3Fil
	PnNH7WT8y8pvBvc70+AlJq82Xu2HY6chI=; b=TFFQRzz+OHsOHiQFCrd2Pzabvp
	AlD5LZqPTW13O+ExYdfX4trlkvXXDltTOyP1aJx+GAhsRkjfBUmd2E6IiiYMUJpA
	pEPYiBS+ChFdoiF5rjNTG579D1u/maFK+cAjSGgsJUZqbKjM3ZqHG7DDs2nvtFZn
	lDUrvFzyPvDgLM3qqwcNsAOkRxk8VFQIqraW5NswoLFhu1MWxfS4+bIQte/TH6rt
	krltCmxyEVPGEtRO4kW3VKwDNV6KcRlHNo1Wp5HuQU5Hm7NfObNpCY4Ck4SubDrl
	ou0RXY4nNGksq+XmXaJUI0PsdQm7X6pMDJPSUEYoK0Bq/QanEeJZu08HgpFQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712579054; x=1712665454; bh=a6sLCF3FilPnNH7WT8y8pvBvc70+
	AlJq82Xu2HY6chI=; b=oVCWU1+lpdqyQsR/qKXkPud98I90NdgtekqVbrKn4E9A
	mMUIJQGEX9KB30a04cQyb8WESGAoduZQFTQspNVhqQZnKN4QPOZfpQX1EMl7XAe2
	yYp07+pyUu6y9jIjgCMWA/N0TflgyYjJZXjjP4xMuQ4nH7Ag8BthqXxc87tS72d/
	HWKIbaRuRaGEFQftSibGZDAxu0iIgHbMIKPNwmF1zBmVHJ6Ic3U7CGu7TZsZaIR9
	cde3YNyQjLYHqjHuMZE+dTh2Pja2ZthOKh9fnIgw+y+lxz1m5q4ZIhJIE7rm2kgh
	vFuSI92XigDlxvNZwCEglBYIHutT5qQg5yBmeM734A==
X-ME-Sender: <xms:7uETZvDAJ2thR1tQGWdR4tF4uZ70FSqsADZLKLmd5h_7-PCrDf1jTw>
    <xme:7uETZljiepx_MfZYIut4cBe188IgeNGtIRqJ4WZR4LHSjCoNJKOJWRWEwvAsDLech
    gc_gMVm8R_Xr8f2Mw>
X-ME-Received: <xmr:7uETZqnHLfjCZemZo9DQpZPuJHg6vuypCl3k5zpO8rdIyWsvJv0gCic5OCPUTyeo3eULoZpaGWo2XjN2GXRaRoRi590gTw_P8gvTa7Y0fveahL9_XA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudegiedghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpeejvedufedttdeigfeuiedugfetiefgve
    etleefgedvheefffdvtdfffefhhfegteenucffohhmrghinhepuhhpuggrthgvrdhnrghm
    vgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiipdhuphgurghtvgdrnhgvfi
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:7uETZhxFj6_OIOXiAmvMcvywKmeFwIQGGGnqC6EI3RPijaUkpgaQMw>
    <xmx:7uETZkRZK7LHwGLi81YfjQzij-gIz5QSSK9Mz5AUGg9DMcSZqsriqw>
    <xmx:7uETZka2PpLtMsYN-01f9NfEW1IbjHXU58JerkgSv3xIatiMInFqBA>
    <xmx:7uETZlQRnMs8HeeUGPTtJMmEWxhNX4iuGfitYBvTzr7dnfgDL4HnTQ>
    <xmx:7uETZqdeEYUM-4paIELrugYqMSXqCFocOZXOc8JFalrOg-w-VKRyJ24Q>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Apr 2024 08:24:13 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 6018bc4e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Apr 2024 12:24:07 +0000 (UTC)
Date: Mon, 8 Apr 2024 14:24:11 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v3 05/11] refs/reftable: don't recompute committer ident
Message-ID: <1ca7d9b6cff2eeceddf2dc1c8cb8f5d0216487cc.1712578837.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712578837.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/M7PlsQptEAiMPKD"
Content-Disposition: inline
In-Reply-To: <cover.1712578837.git.ps@pks.im>


--/M7PlsQptEAiMPKD
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to write reflog entries we need to compute the committer's
identity as it gets encoded in the log record itself. The reftable
backend does this via `git_committer_info()` and `split_ident_line()` in
`fill_reftable_log_record()`, which use the Git config as well as
environment variables to figure out the identity.

While most callers would only call `fill_reftable_log_record()` once or
twice, `write_transaction_table()` will call it as many times as there
are queued ref updates. This can be quite a waste of effort when writing
many refs with reflog entries in a single transaction.

Refactor the code to pre-compute the committer information. This results
in a small speedup when writing 100000 refs in a single transaction:

  Benchmark 1: update-ref: create many refs (HEAD~)
    Time (mean =C2=B1 =CF=83):      2.895 s =C2=B1  0.020 s    [User: 1.516=
 s, System: 1.374 s]
    Range (min =E2=80=A6 max):    2.868 s =E2=80=A6  2.983 s    100 runs

  Benchmark 2: update-ref: create many refs (HEAD)
    Time (mean =C2=B1 =CF=83):      2.845 s =C2=B1  0.017 s    [User: 1.461=
 s, System: 1.379 s]
    Range (min =E2=80=A6 max):    2.803 s =E2=80=A6  2.913 s    100 runs

  Summary
    update-ref: create many refs (HEAD) ran
      1.02 =C2=B1 0.01 times faster than update-ref: create many refs (HEAD=
~)

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 52 +++++++++++++++++++++++++++--------------
 1 file changed, 34 insertions(+), 18 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 8a54b0d8b2..a5ef36ffa9 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -171,32 +171,30 @@ static int should_write_log(struct ref_store *refs, c=
onst char *refname)
 	}
 }
=20
-static void fill_reftable_log_record(struct reftable_log_record *log)
+static void fill_reftable_log_record(struct reftable_log_record *log, cons=
t struct ident_split *split)
 {
-	const char *info =3D git_committer_info(0);
-	struct ident_split split =3D {0};
+	const char *tz_begin;
 	int sign =3D 1;
=20
-	if (split_ident_line(&split, info, strlen(info)))
-		BUG("failed splitting committer info");
-
 	reftable_log_record_release(log);
 	log->value_type =3D REFTABLE_LOG_UPDATE;
 	log->value.update.name =3D
-		xstrndup(split.name_begin, split.name_end - split.name_begin);
+		xstrndup(split->name_begin, split->name_end - split->name_begin);
 	log->value.update.email =3D
-		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
-	log->value.update.time =3D atol(split.date_begin);
-	if (*split.tz_begin =3D=3D '-') {
+		xstrndup(split->mail_begin, split->mail_end - split->mail_begin);
+	log->value.update.time =3D atol(split->date_begin);
+
+	tz_begin =3D split->tz_begin;
+	if (*tz_begin =3D=3D '-') {
 		sign =3D -1;
-		split.tz_begin++;
+		tz_begin++;
 	}
-	if (*split.tz_begin =3D=3D '+') {
+	if (*tz_begin =3D=3D '+') {
 		sign =3D 1;
-		split.tz_begin++;
+		tz_begin++;
 	}
=20
-	log->value.update.tz_offset =3D sign * atoi(split.tz_begin);
+	log->value.update.tz_offset =3D sign * atoi(tz_begin);
 }
=20
 static int read_ref_without_reload(struct reftable_stack *stack,
@@ -1018,9 +1016,15 @@ static int write_transaction_table(struct reftable_w=
riter *writer, void *cb_data
 		reftable_stack_merged_table(arg->stack);
 	uint64_t ts =3D reftable_stack_next_update_index(arg->stack);
 	struct reftable_log_record *logs =3D NULL;
+	struct ident_split committer_ident =3D {0};
 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
+	const char *committer_info;
 	int ret =3D 0;
=20
+	committer_info =3D git_committer_info(0);
+	if (split_ident_line(&committer_ident, committer_info, strlen(committer_i=
nfo)))
+		BUG("failed splitting committer info");
+
 	QSORT(arg->updates, arg->updates_nr, transaction_update_cmp);
=20
 	reftable_writer_set_limits(writer, ts, ts);
@@ -1086,7 +1090,7 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			log =3D &logs[logs_nr++];
 			memset(log, 0, sizeof(*log));
=20
-			fill_reftable_log_record(log);
+			fill_reftable_log_record(log, &committer_ident);
 			log->update_index =3D ts;
 			log->refname =3D xstrdup(u->refname);
 			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1233,9 +1237,11 @@ static int write_create_symref_table(struct reftable=
_writer *writer, void *cb_da
 		.value.symref =3D (char *)create->target,
 		.update_index =3D ts,
 	};
+	struct ident_split committer_ident =3D {0};
 	struct reftable_log_record log =3D {0};
 	struct object_id new_oid;
 	struct object_id old_oid;
+	const char *committer_info;
 	int ret;
=20
 	reftable_writer_set_limits(writer, ts, ts);
@@ -1263,7 +1269,11 @@ static int write_create_symref_table(struct reftable=
_writer *writer, void *cb_da
 	    !should_write_log(&create->refs->base, create->refname))
 		return 0;
=20
-	fill_reftable_log_record(&log);
+	committer_info =3D git_committer_info(0);
+	if (split_ident_line(&committer_ident, committer_info, strlen(committer_i=
nfo)))
+		BUG("failed splitting committer info");
+
+	fill_reftable_log_record(&log, &committer_ident);
 	log.refname =3D xstrdup(create->refname);
 	log.update_index =3D ts;
 	log.value.update.message =3D xstrndup(create->logmsg,
@@ -1339,10 +1349,16 @@ static int write_copy_table(struct reftable_writer =
*writer, void *cb_data)
 	struct reftable_log_record old_log =3D {0}, *logs =3D NULL;
 	struct reftable_iterator it =3D {0};
 	struct string_list skip =3D STRING_LIST_INIT_NODUP;
+	struct ident_split committer_ident =3D {0};
 	struct strbuf errbuf =3D STRBUF_INIT;
 	size_t logs_nr =3D 0, logs_alloc =3D 0, i;
+	const char *committer_info;
 	int ret;
=20
+	committer_info =3D git_committer_info(0);
+	if (split_ident_line(&committer_ident, committer_info, strlen(committer_i=
nfo)))
+		BUG("failed splitting committer info");
+
 	if (reftable_stack_read_ref(arg->stack, arg->oldname, &old_ref)) {
 		ret =3D error(_("refname %s not found"), arg->oldname);
 		goto done;
@@ -1417,7 +1433,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
=20
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-		fill_reftable_log_record(&logs[logs_nr]);
+		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
 		logs[logs_nr].refname =3D (char *)arg->newname;
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
@@ -1449,7 +1465,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 	 */
 	ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 	memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-	fill_reftable_log_record(&logs[logs_nr]);
+	fill_reftable_log_record(&logs[logs_nr], &committer_ident);
 	logs[logs_nr].refname =3D (char *)arg->newname;
 	logs[logs_nr].update_index =3D creation_ts;
 	logs[logs_nr].value.update.message =3D
--=20
2.44.GIT


--/M7PlsQptEAiMPKD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYT4eoACgkQVbJhu7ck
PpRJZg//eJn0cnuMbkx21Y4LuLCVU1Si60yTHhOs0yETye0TR8Kk/zjU3HT3/Mgx
cxKCHc/UrcNlwub6PlaZRj/W0eowx8x3ub8FdOAhULwoNAJqAl/ezDF1ZpqnAMf8
4CeWQ78Fofujkl+J2Up8NxJx4nSASTNBP/RrX1+1lYyQ+W9w5XbTYoIMCdFYt+Mi
3el3NOsfLEU5YoJAcTBEAEya+aQNfQt0UYTmZgO0QWVNUN5j06wvA1Nmh6CV02xs
pWFnQDG93/7A3NZ0xRm8Sm3ab6WsxriJS8IEKfpcXByurAuHFy2cRHzeQMIUzUS6
SMxTvrx5jPCmaBfdGXcQMWhU2+k7iDvHyu4EMkYS1MXoGGNm4nKJDA46+D10cfc/
EcuIrCqlhBww2697lV+nJKllUNYoV+27s8264yBrqoeo9qhklPhl4LIy65eA/xnx
6QmgugjOM50jBBZSBMzTEKSgYcrk6Oivhe6M8Lx/pZaULYJwU/sW0A4hag84mG9T
0MpUEeXwgjUrj0M5u892b5O9fCuVCXzqGQyvozHloIVDdhozxBrOTQmI2DB4HMmA
vHcsy7ETZAx8X+V7fZPB5VLnQkQqIqyj55idRZ0ZK2/nIjpT6Wcq8rqTU/wCkYtN
3IPMrjbvP1bo6XKmLOgLJSJq/ISt6/CqShuiYdJ2iMmF8b0seUg=
=cJ4d
-----END PGP SIGNATURE-----

--/M7PlsQptEAiMPKD--
