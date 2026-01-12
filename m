Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57EA34A777
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208616; cv=none; b=S+AJzXnEzFbdjmoGTOiOrXjHxCQ3Cm+mVKyJfSMf0ZDkV6ZV2qNUgCSxEGNKPpeVTVF7G0mBP8RaofzQm7ZpEVSSoc6FQEXJuLM8gh0qV6fbDgGuxeiGREt3i0ArUFlY9QTi8c2FrgQHFk6bXsK6QoxmzcHWxhz49mAhCmpoebg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208616; c=relaxed/simple;
	bh=QbfSzr/fOGTwTWsa19Z4vLu/ltgaMjmZnkW84CDeljQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ccfrukPzTUP0XjwNDGImYX/BagFC+SAWBj/Et+d1gZssiw6CEmGgRHMOxjRGcNiLnowQKkfCPgsSdsacb+o/AKWyK2FWd9raTQpPI1oZpkxhzJBfBDx7cOk4fufh39uAYhjBCgOhq+5tTFobiHSi7UKD9ghPdGsaf8NmKlhfiu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IzA7i0tI; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=psAbm/TS; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IzA7i0tI";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="psAbm/TS"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E72B57A0040;
	Mon, 12 Jan 2026 04:03:33 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:03:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208613;
	 x=1768295013; bh=EQ79DEclZU1rhuN319HEmyFZDEP3tbPbs14w/psEWgk=; b=
	IzA7i0tIIvOOBO6EIeCvGnWOkVK0q/nr8HXU2nMBqfQLoY+rLwa9FbGLY7lkWMb/
	c1XIcSVMcvwIlMVOkYrcvqOE9T6CKeTv52MlZnWraKKmQx0mX7j2cAv4i/LaispN
	cpTTPg2V1VfAh838xYqKuNA7zhJYVw9VQEdDsieJeiY+ZKLSQVLSR2HGa4bZhRtH
	UIrPFseFT4abijFSnpBAZc+io86EjLujmUqUxCArL2WFiCVKDOlIdXgxcKdwSwnw
	DuhDZpt723Ah5gLj4kek1QrcFcuS06biarpCMY7LlY3je6DOkWGgqExhoQhZpBsB
	u8QDoNVAec354nVvboR7Xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208613; x=
	1768295013; bh=EQ79DEclZU1rhuN319HEmyFZDEP3tbPbs14w/psEWgk=; b=p
	sAbm/TScf8W65xPt0aq9TfOqPAAcCxBk5liVg8MmnDSaVPx7Dh05I00x2evUni6S
	s0Ju03Mt9LwpB9G8xtW3g7a4mJ8zUb9MXiZJgotzf+c7rX4ZZIu3dtlX1RGNAUDh
	w4jTKN44/fUiXWy2ISx83cgqnOS5O/L4QDmwpD0B1G7HkNHUUuLg3rw8l2i7CC6A
	D+RnmbHb9SUZriwRGt8OhfWHrPxaFj1YNUuaFWJQKBGBaPba15KulaV1/oQFyhBR
	JTaHbidEFiQ4ZfwnjQYvyu5DdYHLSFF5djJhb2InforD4o0wp07DFjdKSfG/1sKX
	/MYLXu3xx5UM+Am7SSGiw==
X-ME-Sender: <xms:5bhkabJmenXAkm6WXiy3oPRk7b7ouubyRPcdvSMPDBhVooljfgfRwQ>
    <xme:5bhkaWmdS7fb8hiTXxe5_kjIn8u2zY3HFxXGXme_SV9d_F93MbeHMaC0hixbjsC5K
    _PQOaecqSZU4_ZDn8RF6r3toZcW4ApobgYvb-npS8XHeVVnt7Hr5A>
X-ME-Received: <xmr:5bhkaRFk6Fnc7VXijAHSjH_CJRraWntZsXbs8X1mKcAo0AcGBH6QDSRyLApLnKlc0jfugFCBvBM86yQIx9bpykghzBR5vVatdg6-ooviVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeefnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:5bhkaeFkUPh5MiTVg2UYQhQM2Hr2HIQkUAawKHDtOcuyMc6nDVTnDQ>
    <xmx:5bhkaWOVqnyObrfJJHm48pj2N44vZM-TUKI3XLE60fG7JzQNKSw_ew>
    <xmx:5bhkaVEOrvLrdtWD_pYQAXPcBBVjZHM4bJbkUEz4ZZtX9bWgkoAbqw>
    <xmx:5bhkaVPod5Pz7Cl568NvTbn2zB3qTn5YJu4Ox-Aqukqw6Cy0k7oZ2g>
    <xmx:5bhkaUBk-fDHcBKISdp9jROe_e3-dHFLUVLyrXKnhKXIIglxnk525kmE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:33 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8c13b94b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:03 +0100
Subject: [PATCH v2 14/17] refs/reftable: introduce generic checks for refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-14-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

In a preceding commit we have extracted generic checks for both direct
and symbolic refs that apply for all backends. Wire up those checks for
the "reftable" backend.

Note that this is done by iterating through all refs manually with the
low-level reftable ref iterator. We explicitly don't want to use the
higher-level iterator that is exposed to users of the reftable backend
as that iterator may swallow for example broken refs.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c  | 82 ++++++++++++++++++++++++++++++++++++++++++++----
 t/t0614-reftable-fsck.sh | 12 +++++++
 2 files changed, 88 insertions(+), 6 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index 6361b27015..fe74af73af 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -2767,19 +2767,89 @@ static int reftable_be_fsck(struct ref_store *ref_store, struct fsck_options *o,
 {
 	struct reftable_ref_store *refs =
 		reftable_be_downcast(ref_store, REF_STORE_READ, "fsck");
+	struct reftable_ref_iterator *iter = NULL;
+	struct reftable_ref_record ref = { 0 };
+	struct fsck_ref_report report = { 0 };
+	struct strbuf refname = STRBUF_INIT;
 	struct reftable_backend *backend;
+	int ret, errors = 0;
 
 	if (is_main_worktree(wt)) {
 		backend = &refs->main_backend;
 	} else {
-		int ret = backend_for_worktree(&backend, refs, wt->id);
-		if (ret < 0)
-			return error(_("reftable stack for worktree '%s' is broken"),
-				     wt->id);
+		ret = backend_for_worktree(&backend, refs, wt->id);
+		if (ret < 0) {
+			ret = error(_("reftable stack for worktree '%s' is broken"),
+				    wt->id);
+			goto out;
+		}
+	}
+
+	errors |= reftable_fsck_check(backend->stack, reftable_fsck_error_handler,
+				      reftable_fsck_verbose_handler, o);
+
+	iter = ref_iterator_for_stack(refs, backend->stack, "", NULL, 0);
+	if (!iter) {
+		ret = error(_("could not create iterator for worktree '%s'"), wt->id);
+		goto out;
+	}
+
+	while (1) {
+		ret = reftable_iterator_next_ref(&iter->iter, &ref);
+		if (ret > 0)
+			break;
+		if (ret < 0) {
+			ret = error(_("could not read record for worktree '%s'"), wt->id);
+			goto out;
+		}
+
+		strbuf_reset(&refname);
+		if (!is_main_worktree(wt))
+			strbuf_addf(&refname, "worktrees/%s/", wt->id);
+		strbuf_addstr(&refname, ref.refname);
+		report.path = refname.buf;
+
+		switch (ref.value_type) {
+		case REFTABLE_REF_VAL1:
+		case REFTABLE_REF_VAL2: {
+			struct object_id oid;
+			unsigned hash_id;
+
+			switch (reftable_stack_hash_id(backend->stack)) {
+			case REFTABLE_HASH_SHA1:
+				hash_id = GIT_HASH_SHA1;
+				break;
+			case REFTABLE_HASH_SHA256:
+				hash_id = GIT_HASH_SHA256;
+				break;
+			default:
+				BUG("unhandled hash ID %d",
+				    reftable_stack_hash_id(backend->stack));
+			}
+
+			oidread(&oid, reftable_ref_record_val1(&ref),
+				&hash_algos[hash_id]);
+
+			errors |= refs_fsck_ref(ref_store, o, &report, ref.refname, &oid);
+			break;
+		}
+		case REFTABLE_REF_SYMREF:
+			errors |= refs_fsck_symref(ref_store, o, &report, ref.refname,
+						   ref.value.symref);
+			break;
+		default:
+			BUG("unhandled reference value type %d", ref.value_type);
+		}
 	}
 
-	return reftable_fsck_check(backend->stack, reftable_fsck_error_handler,
-				   reftable_fsck_verbose_handler, o);
+	ret = errors ? -1 : 0;
+
+out:
+	if (iter)
+		ref_iterator_free(&iter->base);
+	reftable_ref_record_release(&ref);
+	strbuf_release(&refname);
+	return ret;
 }
 
 struct ref_storage_be refs_be_reftable = {
diff --git a/t/t0614-reftable-fsck.sh b/t/t0614-reftable-fsck.sh
index 4757eb5931..d24b87f961 100755
--- a/t/t0614-reftable-fsck.sh
+++ b/t/t0614-reftable-fsck.sh
@@ -87,4 +87,16 @@ test_expect_success 'worktree stacks can be verified' '
 	done
 '
 
+test_expect_success 'invalid symref gets reported' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	test_commit -C repo initial &&
+	git -C repo symbolic-ref refs/heads/symref garbage &&
+	test_must_fail git -C repo refs verify 2>err &&
+	cat >expect <<-EOF &&
+	error: refs/heads/symref: badReferentName: points to invalid refname ${SQ}garbage${SQ}
+	EOF
+	test_cmp expect err
+'
+
 test_done

-- 
2.52.0.590.g1f87b77810.dirty

