Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFADC19004E
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 05:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722316991; cv=none; b=cV15pKZQNwW0jG4V/2XUYGWVQp3rc3gjKZ2jcliOgil/J/5QhYHe1AtLH9FYupXvnObIY+rOT7Dbe7kn2zVDNoJq566KIqrDS5+wbHEy+7a4II5Lw7t4hMh4mftlBTP/aD4gjv62DgbGe+X6jnjFJDhgJlmLXLN2mnHPL+eE6u0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722316991; c=relaxed/simple;
	bh=cl4JFjkpTzFrD8Iu7gwZSNtDdbchvCHhy2MFUdtBaOA=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CncYqiA04mFy++rWKIm8/3zqPZryXu6510NL2ZWLGKnpqRdIeiJ37lZ9jTYmPnbOGlw84nAg6pxdkw2f/0xcq1TJgqLHtDuzs1Jt6M6G24VnTk9JY70khYIMTyMRKLEstju+XGemYhl1y0WUja9+LpzP7u5sc4CLcy3uJRkllAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Abl7vQZf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QXNaJoHB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Abl7vQZf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QXNaJoHB"
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 1B7AC1140446
	for <git@vger.kernel.org>; Tue, 30 Jul 2024 01:23:09 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 30 Jul 2024 01:23:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1722316989; x=1722403389; bh=d+zddLIBMN
	zz8W8iJXlCreGDSdwqj8M+yMQrhqQI2tk=; b=Abl7vQZfer3JLOLs2Hg1TwSAmg
	7nEzpDNmfp3tVlmbZNJje9ED4T19WrFYqz7EgmnVc55Tngg0eV/lME1xDmUo6/TL
	07l0920vJE/cPj+lNsNtX92HPuvjhsqBrcE6GzZznFP29aVVVhOndBhiuIOK+8cm
	rC4XqtGyTypNqLLlsdMLl1m/dCeCagd9sZyNiwBqI4A6UueKDyH9y21atAs2TB0r
	JEBscN+WXZCrefzj93GtIzh1cub+NZhs6iTaLSGMZkktiK3g28sxkkHZ+V4aaFVx
	0Chu5eC8ysa8M/gDianChnwhkEWh5Wn3FxCd5/eYcAVVo/WXx1dkuxwl7U1A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1722316989; x=1722403389; bh=d+zddLIBMNzz8W8iJXlCreGDSdwq
	j8M+yMQrhqQI2tk=; b=QXNaJoHBDz8GTwE64lF4e6JtPx64T/1S4i3syQH9MtbP
	mnvAXiPcwQNi9hisZo+nxR9xufrjV+WxkwwcxI8ksr3YIkVSHqO5CYm9PBUaaoBp
	xjPPJ2dwnRDoiMCUg2LaHdTAOgwmWdeTAY0FyISvV/VRSeVvZWwvGIcc99DJEvWE
	2SVy9S7DUTKFTOIMaCz+qkJ2C4ygooP2ZfT6aOgpnIY1i1p5rLT19LSXSMNiPHNe
	mpBMmOrzk+/FOos/S4scfasidQyQ03h53hkxBLWU5HUr4CuUHUkq5shBSbLAUOup
	xZxQQeLfoFvvPWfvhc6L8Dk6pau3PLyA3mTZlYtTsg==
X-ME-Sender: <xms:vHioZs_TkUhVFq9sk7P7MqOicBcBXdFfS6anzMCDQWhrcF2BMW2pPg>
    <xme:vHioZktFLfeHb9TVexYnSZ6CW4YB8FSUvYLFa-TS9xyzvO9xU1UGuRPZ9zTAMMG-f
    _uRxkr_-TMCfOl-YA>
X-ME-Received: <xmr:vHioZiA7DM3Dhv5Ki80PXKFdhA3lyDr8cZJ5Cx1JDkbYqcl_g7pK6BDYnAK3oxNe3EvmvJTpI5ieDvAzeU7yAb84IG20XDQ8hExP1y0XsThpONY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrjeefgdeljecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfffhvffukfhfgggtuggjsehgtderre
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeelhffffeethefhteeigfetgeehhffhudduhf
    eiieehhfevkedthfdugfejhefftdenucffohhmrghinhepuhhpuggrthgvrdhtiidpvhgr
    lhdvrdhtrghrghgvthdpuhhpuggrthgvrdhnvgifpdhuphgurghtvgdrvghmrghilhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhk
    shdrihhmpdhnsggprhgtphhtthhopedt
X-ME-Proxy: <xmx:vXioZsdYt9HatxTFR1w-XzMAppkaVtMCL8c_ahguCVdIRl5isEWKaA>
    <xmx:vXioZhNbi6oV1RceiYB_NkGHeejv7OeZGroeqyDe54n4gFnpkCsT_Q>
    <xmx:vXioZml1k8EVwC4-_1jdeT3BpNDENMQoN9WXbYctlT0lQ9ZkHjz5bA>
    <xmx:vXioZjvlrqRWKIfcZRGdd9KfnGSAyhidXYoK_WEK2VdNQrArsw-5lA>
    <xmx:vXioZv0V4HFBC3UhiWc6o-1lVCgSGlNOS9nwtCNw0DeBgV-PS9BNYlNP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 30 Jul 2024 01:23:08 -0400 (EDT)
Received: 
	by localhost (OpenSMTPD) with ESMTPSA id 3885ed2b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 30 Jul 2024 05:21:40 +0000 (UTC)
Date: Tue, 30 Jul 2024 07:23:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 5/5] refs/reftable: stop using `the_repository`
Message-ID: <0e440360a83a02afd2d247a5ae9d2a250ff6a10b.1722316795.git.ps@pks.im>
References: <cover.1722316795.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="zgHgorSb2XZI5BPP"
Content-Disposition: inline
In-Reply-To: <cover.1722316795.git.ps@pks.im>


--zgHgorSb2XZI5BPP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Convert the reftable ref backend to stop using `the_repository` in favor
of the repo that gets passed in via `struct ref_store`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 51 +++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 25 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index fbe74c239d..bf4446afd3 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -1,5 +1,3 @@
-#define USE_THE_REPOSITORY_VARIABLE
-
 #include "../git-compat-util.h"
 #include "../abspath.h"
 #include "../chdir-notify.h"
@@ -201,7 +199,8 @@ static void fill_reftable_log_record(struct reftable_lo=
g_record *log, const stru
 	log->value.update.tz_offset =3D sign * atoi(tz_begin);
 }
=20
-static int read_ref_without_reload(struct reftable_stack *stack,
+static int read_ref_without_reload(struct reftable_ref_store *refs,
+				   struct reftable_stack *stack,
 				   const char *refname,
 				   struct object_id *oid,
 				   struct strbuf *referent,
@@ -220,7 +219,7 @@ static int read_ref_without_reload(struct reftable_stac=
k *stack,
 		*type |=3D REF_ISSYMREF;
 	} else if (reftable_ref_record_val1(&ref)) {
 		oidread(oid, reftable_ref_record_val1(&ref),
-			the_repository->hash_algo);
+			refs->base.repo->hash_algo);
 	} else {
 		/* We got a tombstone, which should not happen. */
 		BUG("unhandled reference value type %d", ref.value_type);
@@ -487,16 +486,16 @@ static int reftable_ref_iterator_advance(struct ref_i=
terator *ref_iterator)
 		switch (iter->ref.value_type) {
 		case REFTABLE_REF_VAL1:
 			oidread(&iter->oid, iter->ref.value.val1,
-				the_repository->hash_algo);
+				refs->base.repo->hash_algo);
 			break;
 		case REFTABLE_REF_VAL2:
 			oidread(&iter->oid, iter->ref.value.val2.value,
-				the_repository->hash_algo);
+				refs->base.repo->hash_algo);
 			break;
 		case REFTABLE_REF_SYMREF:
 			if (!refs_resolve_ref_unsafe(&iter->refs->base, iter->ref.refname,
 						     RESOLVE_REF_READING, &iter->oid, &flags))
-				oidclr(&iter->oid, the_repository->hash_algo);
+				oidclr(&iter->oid, refs->base.repo->hash_algo);
 			break;
 		default:
 			BUG("unhandled reference value type %d", iter->ref.value_type);
@@ -508,7 +507,7 @@ static int reftable_ref_iterator_advance(struct ref_ite=
rator *ref_iterator)
 		if (check_refname_format(iter->ref.refname, REFNAME_ALLOW_ONELEVEL)) {
 			if (!refname_is_safe(iter->ref.refname))
 				die(_("refname is dangerous: %s"), iter->ref.refname);
-			oidclr(&iter->oid, the_repository->hash_algo);
+			oidclr(&iter->oid, refs->base.repo->hash_algo);
 			flags |=3D REF_BAD_NAME | REF_ISBROKEN;
 		}
=20
@@ -551,7 +550,7 @@ static int reftable_ref_iterator_peel(struct ref_iterat=
or *ref_iterator,
=20
 	if (iter->ref.value_type =3D=3D REFTABLE_REF_VAL2) {
 		oidread(peeled, iter->ref.value.val2.target_value,
-			the_repository->hash_algo);
+			iter->refs->base.repo->hash_algo);
 		return 0;
 	}
=20
@@ -659,7 +658,7 @@ static int reftable_be_read_raw_ref(struct ref_store *r=
ef_store,
 	if (ret)
 		return ret;
=20
-	ret =3D read_ref_without_reload(stack, refname, oid, referent, type);
+	ret =3D read_ref_without_reload(refs, stack, refname, oid, referent, type=
);
 	if (ret < 0)
 		return ret;
 	if (ret > 0) {
@@ -868,8 +867,8 @@ static int reftable_be_transaction_prepare(struct ref_s=
tore *ref_store,
 		goto done;
 	}
=20
-	ret =3D read_ref_without_reload(stack_for(refs, "HEAD", NULL), "HEAD", &h=
ead_oid,
-				      &head_referent, &head_type);
+	ret =3D read_ref_without_reload(refs, stack_for(refs, "HEAD", NULL), "HEA=
D",
+				      &head_oid, &head_referent, &head_type);
 	if (ret < 0)
 		goto done;
 	ret =3D 0;
@@ -936,7 +935,7 @@ static int reftable_be_transaction_prepare(struct ref_s=
tore *ref_store,
 			string_list_insert(&affected_refnames, new_update->refname);
 		}
=20
-		ret =3D read_ref_without_reload(stack, rewritten_ref,
+		ret =3D read_ref_without_reload(refs, stack, rewritten_ref,
 					      &current_oid, &referent, &u->type);
 		if (ret < 0)
 			goto done;
@@ -1500,7 +1499,8 @@ static int write_copy_table(struct reftable_writer *w=
riter, void *cb_data)
 		memcpy(logs[logs_nr].value.update.old_hash, old_ref.value.val1, GIT_MAX_=
RAWSZ);
 		logs_nr++;
=20
-		ret =3D read_ref_without_reload(arg->stack, "HEAD", &head_oid, &head_ref=
erent, &head_type);
+		ret =3D read_ref_without_reload(arg->refs, arg->stack, "HEAD", &head_oid,
+					      &head_referent, &head_type);
 		if (ret < 0)
 			goto done;
 		append_head_reflog =3D (head_type & REF_ISSYMREF) && !strcmp(head_refere=
nt.buf, arg->oldname);
@@ -1790,15 +1790,16 @@ static struct ref_iterator *reftable_be_reflog_iter=
ator_begin(struct ref_store *
 					ref_iterator_select, NULL);
 }
=20
-static int yield_log_record(struct reftable_log_record *log,
+static int yield_log_record(struct reftable_ref_store *refs,
+			    struct reftable_log_record *log,
 			    each_reflog_ent_fn fn,
 			    void *cb_data)
 {
 	struct object_id old_oid, new_oid;
 	const char *full_committer;
=20
-	oidread(&old_oid, log->value.update.old_hash, the_repository->hash_algo);
-	oidread(&new_oid, log->value.update.new_hash, the_repository->hash_algo);
+	oidread(&old_oid, log->value.update.old_hash, refs->base.repo->hash_algo);
+	oidread(&new_oid, log->value.update.new_hash, refs->base.repo->hash_algo);
=20
 	/*
 	 * When both the old object ID and the new object ID are null
@@ -1841,7 +1842,7 @@ static int reftable_be_for_each_reflog_ent_reverse(st=
ruct ref_store *ref_store,
 			break;
 		}
=20
-		ret =3D yield_log_record(&log, fn, cb_data);
+		ret =3D yield_log_record(refs, &log, fn, cb_data);
 		if (ret)
 			break;
 	}
@@ -1886,7 +1887,7 @@ static int reftable_be_for_each_reflog_ent(struct ref=
_store *ref_store,
 	}
=20
 	for (i =3D logs_nr; i--;) {
-		ret =3D yield_log_record(&logs[i], fn, cb_data);
+		ret =3D yield_log_record(refs, &logs[i], fn, cb_data);
 		if (ret)
 			goto done;
 	}
@@ -2200,7 +2201,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 		goto done;
 	if (reftable_ref_record_val1(&ref_record))
 		oidread(&oid, reftable_ref_record_val1(&ref_record),
-			the_repository->hash_algo);
+			ref_store->repo->hash_algo);
 	prepare_fn(refname, &oid, policy_cb_data);
=20
 	while (1) {
@@ -2216,9 +2217,9 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
 		}
=20
 		oidread(&old_oid, log.value.update.old_hash,
-			the_repository->hash_algo);
+			ref_store->repo->hash_algo);
 		oidread(&new_oid, log.value.update.new_hash,
-			the_repository->hash_algo);
+			ref_store->repo->hash_algo);
=20
 		/*
 		 * Skip over the reflog existence marker. We will add it back
@@ -2250,9 +2251,9 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
=20
 		*dest =3D logs[i];
 		oidread(&old_oid, logs[i].value.update.old_hash,
-			the_repository->hash_algo);
+			ref_store->repo->hash_algo);
 		oidread(&new_oid, logs[i].value.update.new_hash,
-			the_repository->hash_algo);
+			ref_store->repo->hash_algo);
=20
 		if (should_prune_fn(&old_oid, &new_oid, logs[i].value.update.email,
 				    (timestamp_t)logs[i].value.update.time,
@@ -2269,7 +2270,7 @@ static int reftable_be_reflog_expire(struct ref_store=
 *ref_store,
=20
 	if (flags & EXPIRE_REFLOGS_UPDATE_REF && last_hash &&
 	    reftable_ref_record_val1(&ref_record))
-		oidread(&arg.update_oid, last_hash, the_repository->hash_algo);
+		oidread(&arg.update_oid, last_hash, ref_store->repo->hash_algo);
=20
 	arg.refs =3D refs;
 	arg.records =3D rewritten;
--=20
2.46.0.rc1.dirty


--zgHgorSb2XZI5BPP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEF9hrgiFbCdvenl/rVbJhu7ckPpQFAmaoeLgACgkQVbJhu7ck
PpTqjQ//UpirB4mQ4yKnI+npr6H5DE/53fRv/DvnLMA4Y4bjll0MhCmlAD+TPCe7
j3/mo9LvYSlPjB9rdPgM26rWTOB++7Hu4HGl3H71DoTyUDrsYJetkY7FIq7fvpKl
ICiC6IhFA5IGJOhSJ1RFZX4AteLv39Aaa3lId232MXGXqu2hs5By0NjeYO0yBP7F
l5zcxSaVV0UQkZSHx2jcjmf53ElymEV120BGiNTttVlUW5riOCqNGYLLPPmv875s
pPA3aQoRUDPyQD1OcOEEkRpeH/ywDm5YlbgLUsadWD/ODs37B3LkzTYrNVRhbG0w
pms9uiav0Fq0tQkTCx72liNQBwsuXzQ0WJ67McGVldx9xG0W7wjrplhJ3lFA23QC
/NvM6MaJ6G2tTq/rFStqwG2IO6TnYvdpBDO38aXQV4pmzlNF3uz9R25PlpeFskeR
ierOs8lXaQovqUMdGOaZ/wsrMq8EEFYz6LltI3/hKMGoRctUi3iDb/EwOoGaDnlf
YUKhHZDfHH6E8Pq+nnFIds4reg/aMYFE70H1bv8EMOuuIKc6OG/nMunYTIA6Sieb
uo622+vluD/OOXpZymC6w2OSYC6RF+kguyRHDOKlf6VeWu7bj5AfvCXop03r/1iG
gT88w7vGlSUOH1alTvL2025dHdMZZeB5KWZEyrW/v0cocVZzimo=
=rIKg
-----END PGP SIGNATURE-----

--zgHgorSb2XZI5BPP--
