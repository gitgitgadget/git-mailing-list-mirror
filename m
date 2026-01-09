Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E374335BDA8
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962415; cv=none; b=fQk738mgjEDh/b1/fDpgso6WhCg0aLEar5K7369uBQNoqwbEdA0G2m3UhY8Q6zMOT9MTyJbFOiUnkEdWKce/A8N74r4VWDx+x+rKVpA3UqhdTyntsfjT7K5qo9h2TFdq+lQiXY/Qk4MFtw5Sy/LMGpvJrf8LHuC9PGPDPPK8ZBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962415; c=relaxed/simple;
	bh=73sxiOCKwiW0bByzZOzwj7GRly57HD25InpztsnFIS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=m+ZtvGcUStsO9pu/WSYR7dFjF2Oi5w6o4oqIB066H/FYd6ZiBuZYeyniXfzsPQp8jo5qRgV6Y5ZNFFthj/CMKLxSjXQcr4qggZLHtBU/yTGjg/Mu6olvwCPqUg6OjTscbLvOLD4dlQHG0wARjNY1Ucsx9qqiX3Zuh9RTUxtFsDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=I+AbrFfi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=F+wvLxAZ; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="I+AbrFfi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="F+wvLxAZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4367B7A0177;
	Fri,  9 Jan 2026 07:40:13 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 07:40:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962413;
	 x=1768048813; bh=L1/Mg8raXouTOiFfb42wygG3gL5G30NWKyD6pQvfcok=; b=
	I+AbrFfiU/FiYbUCKDLxKHvqXjGKCJ8PxwGJAlsrUClXvdYD9QXDKR5YzDGqHvSb
	aPrIG3zCsplGeOMbyRsyBI+63H++/ZKJmwleaqRUo9ABcr9pNaCWBCYPkM4CSv2T
	m0yhJdeGNX4XQLcQAnX7nttUQKqxq4DQeGWUCzjLKUYNEVzI8JGyvLjw84NPCdwc
	Ouu5dQwT6mM3KviqPfQjI8O9jFMIERcT4xNdkor6GCRjrguIUht+MdpPIL3K2SVU
	2LhS1Mr+e+yrCwewnIxBUlQjlru9v1uO+qyVREefViVKv/xz0lXz2Y3UcGejpy10
	3hCDonhCyAZ5rIiTWMSpuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962413; x=
	1768048813; bh=L1/Mg8raXouTOiFfb42wygG3gL5G30NWKyD6pQvfcok=; b=F
	+wvLxAZ9jOdMij849WG02LO4pclU5OzAIrKNbdUayHATzLRKgwD0ARRt/hW9ybnp
	DfjupmyaMrfBZH8CvWgm1fG3TDO6tAKdu6Ta6ui3wpiMss5ui1iFKUq3VaF7PRlv
	EF6n4+Qv1Z7Jw/YwiWYIvqx7zwC/ggVSL48vHktlUATRTTIJi/4H4ILQ+B2HDz92
	8UgUyI8nVVEZFzZHLTbaWrUJ1Z62m7xIvtxdY0FTYgYG0xC155lSKuj6aeUtohyv
	1iwgDxhZhtLI7CZDXGTr02FqhiLK9zOOFMRO58z1+Ibynx+FmIGIxHDYipDbMLlO
	83eImx5PerUOZAETSZ7dw==
X-ME-Sender: <xms:LfdgaUbTXss6-1YBjK9JvoNdNDfzSUOTfZ610TodENKsIcrMSag5gA>
    <xme:LfdgaW3QivPDXY9dOnk8vKTBPGLyUO6hq-x7C9MDGQwYuAeFr1Rlr4gzD1Xmullb0
    BFkgky5pq1LrEOhbmCfSutMk-Rn8LzlFN2A7d1DcwZqzVbwW6s1-A>
X-ME-Received: <xmr:LfdgacW0VkgSynCF46aiyGwD2dTwJVv1E3MsK-kNADzhd6n1pFyHj6lfJSau6ebntvc1GQ3fwmS2d8mm9zQM9CBkaqh66H7LuyUMwSNMOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvg
    hjihgrlhhuohesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:LfdgaYV5uhe_4xfPVInVmRUoAb5fWVzxGH305tzdB1jOadmAUeejlQ>
    <xmx:LfdgaTe3kGpehcqOA37n2fB5yqhJUdQXyt-CPKfNMKJ8E3-95SvZig>
    <xmx:LfdgaZXtfgcUmHBd98yUafzRoNt02R1f9aA2_msvYotor2siG9bErw>
    <xmx:LfdgaUcQruN2QRGYNNGng_0b1S486Rn-Gb8MG-29GI01QqpqztRerQ>
    <xmx:LfdgaUTzXFUL21Ih5TMbZZg90pKypXXlVDL4075h1JkgIQ3R4XB6Ev_w>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:12 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 414b7eb6 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:11 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:43 +0100
Subject: [PATCH 14/17] refs/reftable: introduce generic checks for refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-14-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
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
2.52.0.542.g9473a8513b.dirty

