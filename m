Received: from wfout4-smtp.messagingengine.com (wfout4-smtp.messagingengine.com [64.147.123.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8A114AD3D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 17:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712079010; cv=none; b=Lyx514gTYm1oeJhkdSXkjDOjpMu+fmQSmaxvNZBDw2IMpkpmPRgkRHCCvt+pIX0zroLoxRbKZf6UjI/XP8ilHQ3Jn38bUa8rm2brxaxoi7PdzG+/XgSOI4IzOcZQJaMxkQUYjH2SawHhpH+2yEiWR273rV1wb/9kC/s6BcybL9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712079010; c=relaxed/simple;
	bh=kQr4a8pPlaaZdu5HihSqWA31A/nicsIKy3+CP/m7kmw=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OBvUHbEoxSrZYo4KZGKrb93AlFbLJuo6i8OYdVcJqHxd7G5jjjvinZlVybs+SSpmrk3GpSE0SNdZNP26kbKX3BYHeSwM7ZF0kDubh8q+yq7B/83o+iua8Guv8Bt1WMX2j/gMh2Fdad9IhlgMFeDe33yJzv4eNGbXKqDf5ZEQfKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fiYMRfxw; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xJcCy+oc; arc=none smtp.client-ip=64.147.123.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fiYMRfxw";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xJcCy+oc"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfout.west.internal (Postfix) with ESMTP id 947C21C000E1
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 13:30:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 02 Apr 2024 13:30:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712079007; x=1712165407; bh=puMETayh41
	b31LZ1MXFKgdioV0nfeYLsqpizsAbwo5w=; b=fiYMRfxwUtoPihDvXVP/pMp1Yv
	HJ+bPKJYMtox6n9A1Vl35krOis543nUyXqpcFd4UZS++MZHVI4GHqareVq7LTDVJ
	rzxXPuOU1yc0ruOshgWlf8UvYDM95IHQzXIeX7NUFyptYI58T2YT95yMVjApAVN6
	0Xp0qxKZnKXL2XCzn9YGoGfczHKaJyu/DDqYiXg6oAR04D44UYyeC+aa/ibUpgm0
	1kti6J3pIgO7/JAogM5xdBezBkkHP6IJqvS6AeCP/8PMG6Px4v02j1np5C/7a6Zo
	DoCrwtRNVG+woeZ45wIHKqomiTrYwsneiO8G8MjMozOlYa9lpQlxLZuDXLZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712079007; x=1712165407; bh=puMETayh41b31LZ1MXFKgdioV0nf
	eYLsqpizsAbwo5w=; b=xJcCy+oc2jutH0+qM+vcdcfgk42yfmaakFiNtF63xqOE
	ITkWj0qpYY/j74BU1no7x4Vnadesy5ej09VIDNVbAwy7CKBAzTGsfA8f0/XEwn6v
	unxcQF3Bp3w6NBOtJncb2aI5bkje4crgjP2oSJIcn2fWiOrhQZj4Pmp8b3v3lD3O
	BUM1hyJLPM8XuLOWpXkrzk2vwNHG9HY+T2Y2kcr3ijGqfnONd8KP5O40KxeYNjlx
	hIgjOrRGxkHuZORjKIJvqSVfzj3aV+DJKsrefh1prwtHCYk9xOIdYFVNMYmIOXYa
	ruQeYGJUb+jUYb5tDd0xwD0iuNWjL74pT2L2kT9ykg==
X-ME-Sender: <xms:nkAMZstjSkOcZF62o69ehK_Ru2dMyz5J99M_vlO-6pty_fG16j4AsA>
    <xme:nkAMZpf7bs2pMV9dqBCI8WEZAq-57umEIfo2oGazI7s4DNm47CXjXuhsPRbwdDEFT
    35PHwBNFVB7sQeX8g>
X-ME-Received: <xmr:nkAMZnwh3wa5DTwRxrPxXSbFUCpw3hi6zTpwAxhKGsLnCgvTPsHBFOIWK8HwFMM3wMpV-h3g-Cxftr285-EuGbOmL26_J32--rJrY5LK-S3H5Xw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefvddguddugecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtd
    erredttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshes
    phhkshdrihhmqeenucggtffrrghtthgvrhhnpefhhffgieejkedthffgjeeukeekhffgue
    eifeehteegkeeftdeviefffedvjeffleenucffohhmrghinhepuhhpuggrthgvrdhnrghm
    vgdpuhhpuggrthgvrdgvmhgrihhlpdhuphgurghtvgdrthiipdhuphgurghtvgdrnhgvfi
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshes
    phhkshdrihhm
X-ME-Proxy: <xmx:nkAMZvMVShAJ3lJd14hFyR2CB9EfJv5_GlFiGLTYEHMBSpxZWLyh_A>
    <xmx:nkAMZs9ui7FEbnFOkBBHcDk_0gXSNEtlng0ov0im4UcPJCNetoEtUA>
    <xmx:nkAMZnXEpgdYPW9A0d8Ezkqa7znZjaoqwm9BJnJjgGWJ8RxWlfhSag>
    <xmx:nkAMZldV_BpnZlGAAKMosrElg82KirjyZP2K7MJIXMK8hpcAI1xJcA>
    <xmx:n0AMZuLmgc4A3FVT9h5s5MUL6XDRuKGIbeU4thawMvO3PFzqMdpWcRzB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 2 Apr 2024 13:30:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 00ca721b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 2 Apr 2024 17:29:57 +0000 (UTC)
Date: Tue, 2 Apr 2024 19:30:04 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 4/9] refs/reftable: don't recompute committer ident
Message-ID: <a9a6795c025b23035bfdd3e23b0113df9f6c5e4b.1712078736.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/294pJHtroaRb82C"
Content-Disposition: inline
In-Reply-To: <cover.1712078736.git.ps@pks.im>


--/294pJHtroaRb82C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

In order to write reflog entries we need to compute the committer's
identity as it becomes encoded in the log record itself. In the reftable
backend, computing the identity is repeated for every single reflog
entry which we are about to write in a transaction. Needless to say,
this can be quite a waste of effort when writing many refs with reflog
entries in a single transaction.

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
index 7515dd3019..9e8967e82f 100644
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
@@ -1023,9 +1021,15 @@ static int write_transaction_table(struct reftable_w=
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
@@ -1091,7 +1095,7 @@ static int write_transaction_table(struct reftable_wr=
iter *writer, void *cb_data
 			log =3D &logs[logs_nr++];
 			memset(log, 0, sizeof(*log));
=20
-			fill_reftable_log_record(log);
+			fill_reftable_log_record(log, &committer_ident);
 			log->update_index =3D ts;
 			log->refname =3D xstrdup(u->refname);
 			memcpy(log->value.update.new_hash, u->new_oid.hash, GIT_MAX_RAWSZ);
@@ -1238,9 +1242,11 @@ static int write_create_symref_table(struct reftable=
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
@@ -1268,7 +1274,11 @@ static int write_create_symref_table(struct reftable=
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
@@ -1344,10 +1354,16 @@ static int write_copy_table(struct reftable_writer =
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
@@ -1422,7 +1438,7 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
=20
 		ALLOC_GROW(logs, logs_nr + 1, logs_alloc);
 		memset(&logs[logs_nr], 0, sizeof(logs[logs_nr]));
-		fill_reftable_log_record(&logs[logs_nr]);
+		fill_reftable_log_record(&logs[logs_nr], &committer_ident);
 		logs[logs_nr].refname =3D (char *)arg->newname;
 		logs[logs_nr].update_index =3D deletion_ts;
 		logs[logs_nr].value.update.message =3D
@@ -1454,7 +1470,7 @@ static int write_copy_table(struct reftable_writer *w=
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


--/294pJHtroaRb82C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYMQJsACgkQVbJhu7ck
PpS7wBAAi1mqFzwgkc7vLmT5mFvPfd8W9GZxswVCD82tUCsZ2X/hSukvhl6Ky/Ba
XLFaBBuBkqeq5DZru/MtKEcaGDeL6/oUl0bu8olCexnXs8H60ZQiu5rCFaOc6fGj
Dzs/Rpi8T5l1HHYwgrFIDTzX98QyxWLxUe5G8TjGcpivcD85WRuOEtvN3bLCbUSP
AEUNCPr71U2GchJpRCSD+2sX0snm7U3IlwBE4M9YD3OCE9vJf3A+i6UTkevqYq7h
TeyL+82Cm8IURWI31R9+pTJyo9DSRAUqlFuf69jWfmhGoEP0BZiKfcr/mg+TSWEt
0Fz9xK04gT9i3UE3tKVCls2JTLBkwAEa14ZMM/Qv2T6yhntrNj1BbBrU5N94mJH/
aqVRMSE/4DVaTJ5jBy4EB54NsSokmak8YTpBx33JO3rntXo0VExiFrBe3XFvTvcS
msmotC5l8xRIfqNhW+MTFPOfCXhZUPOvCZ4eL5FNOVEJf0IHCoQFnGM0km7spHJ+
NVdgXidoBtJEdgrqW9AtNpFTRIEplDUhFEA0kew4SXpn9Ug5B+1PvScBSNXx8c98
TEoeYZnLnF5YCqMO4tlLXiXRY/RyYP2zbDWSmcQa+s4ORbQGN+9SBdSFKilHgVKJ
t6Pp26Xgs6MMqtct8dP5Es/JaNR5yopkJb3dAcDDnH1iePcTVXI=
=88lY
-----END PGP SIGNATURE-----

--/294pJHtroaRb82C--
