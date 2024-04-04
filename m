Received: from fhigh7-smtp.messagingengine.com (fhigh7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCB2487B5
	for <git@vger.kernel.org>; Thu,  4 Apr 2024 05:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712209711; cv=none; b=JiSbZnZ8dKaor9pVUKG2HI9APJUFl1FWNDlsX6uGPFU5dRPnxfj94htct+GQcaGIZ5xHy948hVOlAa4Vh853UdCPmm8b8eSk+aPIPSWD/aL0p5SVdns/AljyEWk93BQd3teEhJR1z3KfWO4zZ9gEXqLU78Run0hBtKoJ64PzuM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712209711; c=relaxed/simple;
	bh=p4WkA86d7QCxhpZJybnSZDz2G3ez8kZurRR4ZbiXPVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uKVeq2IDpsw7tmz3wGj69SvT/Oxofvg/0Tdpi0MIdP43YR1aOk/QofnQYmLyKjmNZhL6WmYDImN/vDpKerQN+JTm2AF0tYBUDcjF+XUKuw883RS73Jc6x3CphpWNlhbee5fPbrcfn4N40YT5F9rMBRZAjpb6ZE5SlP8ytcJXcYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oJna+jWI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nGZX7Lnj; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oJna+jWI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nGZX7Lnj"
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id EF45D11400D9;
	Thu,  4 Apr 2024 01:48:28 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Thu, 04 Apr 2024 01:48:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1712209708; x=1712296108; bh=pstoC2MCoZ
	momRsmSnd+ansImk0sZzRUpdGexlXxatI=; b=oJna+jWItc2gpPRMY6dkYfOKBE
	8Ju9s5dNVqpQFYYOjItr06TKEEyiiM1w8mV2K9t4+2DGJ1luWyu/2Ez6GjQDuXMr
	KbNk2a64SjWbD8xAAF8QB18a36dGSY+n1e0PxitHo8P9ZjzLTqJ2a+TbQhpas6Pz
	gjtwNEsUag/VgNvDTU1oEneC3uf0rouBocPQv/sUI2aLbZDI6sJMGz01avxr8c+1
	+z9oaxD77k7yBC6WyTsR6VHvuTLtrxd/xNqg/xug/OrG/D5SH7hHclPkRORYAD2C
	kBQ3JqEUFICfS36SKH/hBWVGq356vmfw54pWRmnHzYh4v1+m3Z1BSO6fbWZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1712209708; x=1712296108; bh=pstoC2MCoZmomRsmSnd+ansImk0s
	ZzRUpdGexlXxatI=; b=nGZX7LnjQDVQJ0Mgvl4sKDUC62OlM4bOpad+Kb//K4mD
	+y638daD4sQDGxDZSVIgbSLdhWGLenxk6GGnLEkJBDaRb1WxE1CqUzCvxPYMpmyc
	E1fYLHWxNSFfpDUvBOHvWEsBgSVsauHkiCYqGSa8lyDeRTvwJSjupUh9fNMGHDXc
	ne8IAEillRWkZpnClvvTcKjxfk0c8bmNmggT0civhzX3971I+lXsmeYEzq0dp2kn
	E5ejCP1KWHNM7PO97lWr+5VQ4Ap7tKsnU1IVWrbCrBTHnEy7lEIO+6xp45hQpuaK
	8i1bt8t+4AO1cbMuGVyEfb5O/+W0HEo7GYGciGywBQ==
X-ME-Sender: <xms:LD8OZlRPOI6mg_OEYIcZno3wMu2CRXrDlpm0OMpZzQ1HBGQrvVxg1A>
    <xme:LD8OZuxapWYaB0rHP9ivByh6-b8oT7ZuYnn3VS6sywxd3SBcE5MvhJ7PRHNBycbNq
    JR72A29ZCOdQPO2UA>
X-ME-Received: <xmr:LD8OZq0WCLVFr3KnLJIEPPQnlIlMINtUg0Zkd1kA04EUHbkBLWK7fY2SWF62Ephe7ZiS5LQhbCXNUQYFBQ8cLI8hoESNbD9c2Z8_ztTfrEwsbctI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrudefjedguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesgh
    dtreertddtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhs
    sehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepjeevudeftddtiefgueeiudfgteeigf
    evteelfeegvdehfeffvddtffefhffhgeetnecuffhomhgrihhnpehuphgurghtvgdrnhgr
    mhgvpdhuphgurghtvgdrvghmrghilhdpuhhpuggrthgvrdhtiidpuhhpuggrthgvrdhnvg
    ifnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhs
    sehpkhhsrdhimh
X-ME-Proxy: <xmx:LD8OZtCBMIsxYfm6B2V_9aSR19V4c_ShcJ86kZFnTbYBZWF6yAC9kw>
    <xmx:LD8OZujpSyAKldksZlRYzgG8pMrjtGdMkXXeNh8OKQ7uZhJgLf62Xw>
    <xmx:LD8OZhqkP0ckuQkVrOzrvvZeqUxf4DMqyba3XcSlrlH3-mKNsu5-cA>
    <xmx:LD8OZpjMHcrqEnrTanOr6toT56ft7nY5fUmACaSm7jqw0wDjzXtOpw>
    <xmx:LD8OZmdW095ue38lfKnrfsGMRFPFvCCw5MRyF9LN1nuKYrkdEuol73AA>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Apr 2024 01:48:28 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id a4d6a22b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 4 Apr 2024 05:48:25 +0000 (UTC)
Date: Thu, 4 Apr 2024 07:48:25 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: [PATCH v2 05/11] refs/reftable: don't recompute committer ident
Message-ID: <f892a3007bbbd7ee5060a5205005db6339ce7206.1712209149.git.ps@pks.im>
References: <cover.1712078736.git.ps@pks.im>
 <cover.1712209149.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="isYJezYiRHeXDW9e"
Content-Disposition: inline
In-Reply-To: <cover.1712209149.git.ps@pks.im>


--isYJezYiRHeXDW9e
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


--isYJezYiRHeXDW9e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmYOPygACgkQVbJhu7ck
PpQvSA//ZFJ89ZwPtNw3aRRul/+kI4F3GCfunN+yZADR1YCzWBRCQ4Q3rrzkO0sc
MX2KeTp/byVHHF7KNzI6DaWhRR18iywjgUssNad5WSbnNX8sdsRQmJscx21h5uvQ
2sRxxdh6N0iLiyPW8BzqJ7DSnHIdJdFIycFE1fWl0FaeAIz+n11hlsyYnbYPVFbW
37mbzuXh65umNrbPPHeElWnVGSf8bGIeVEXNMGt0yMRliSNXcV2OFw6uxaNVeoU3
VSJbwlDcf4Vn9EtsS6M1fnKzPYcEKWo3IMy4WUFbi1K8KJjYkZpU8lg091OR/K3F
nqKdgx6klooG63atbwpnTAvvSQMjtx+b7iB3Ol+DgKzgpXw4vDyhzT16z3zkAxUU
/dkEWZas8ytvbaPqRK7sdSNeEJ42YS5ua+tjCxxI+gDL7JuGUuEQg5q4C1u/TLj1
3le83ddIK9LXdBlWxnBMvwcclB39AedEI/9oX2VOXpFHZCd/8RD3yrXAKfgks7TW
9d5ZJgHo8f5h2CEK6vvXzx2/PrtdWI6BZxMlBzr9co8UFQhEx+oVZmqoXbqOs1gj
ZfjE8e6j/QjwtsIOBFd8mWyuM3Rro1Lrq9ca8AzxHrhqQ+HtpU7OC+gkloWDC+27
q7SGwMiMbRFygUVnNReBUjigJyoBIccv+YPWA1uoRPxFRHCof48=
=mWl8
-----END PGP SIGNATURE-----

--isYJezYiRHeXDW9e--
