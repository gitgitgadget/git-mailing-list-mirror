Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB02328627
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208599; cv=none; b=OJen59btoNzCIE1/FfPqxvguSeEyWHpNUxYsPt6MYf/UCx5Dstv+J0CyjN/e+ULGzGBpWCMv96Sl6aAHpCDTi/h7947pURWRK+j9zeupGw3ryc6umia8gbN2phd9c4yq11Nn45z4T5vi7F7O0OpcxrkYldb7IkYHNpmD2jl2M5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208599; c=relaxed/simple;
	bh=o3H0UmBTXbRNhzF6de50c6a6Uk7cvZkBT5KryIz0OfM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dOmLov4TflFkJuvYf7R90jfB/XnBW332ApXvm+TxYHSMgJMHj/FdfiV0jsNxrvhaSwvfyxMRVn7QsPx/rnCL8ivvsdmwBhv/QkGFKUFx4LuqxJu03vd+m7b8iZ8Oxp+q3moKzvEkw4H2ZiBcdwVM2leZ5ELKzsivOY8HD+NiHJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Xb2kMy4K; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mA5G94TT; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Xb2kMy4K";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mA5G94TT"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C1F511D0009D;
	Mon, 12 Jan 2026 04:03:14 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 12 Jan 2026 04:03:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208594;
	 x=1768294994; bh=rZXzwn0BLGfTLw4htHnTVwc/syIhe4XThUrr8JAvHuo=; b=
	Xb2kMy4KsvlM5cpdJNdDo9Lp/6+CAqcMMXa7yY3Yo6yZ9gH9L0+pILjBpKMsA4W7
	3MimN8sk7L98IomO5mTh3L0caufwsNBG6UBLvWja/RSfxOMlo4kw6daUd4gHKlWy
	oVjgKvJ+go3Xku9XLOiOiZQtlnoHN3HsFDn/ZJ60ZCGec+DvcB8FNAilbp6bAemV
	3apn6zSiOc4GDOPLDez0vhRV/5ICMcZ11M9oO/wP7cfGsUIZ3otvhizEsrlcSHxc
	xhwgNTxERY4alBQwK+LHInOoPiCIUEqdmHIdIhoJX8ausGrd7JrpV9NJPqbzx37n
	oplQmbSMGO+5bB7kC7dABA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208594; x=
	1768294994; bh=rZXzwn0BLGfTLw4htHnTVwc/syIhe4XThUrr8JAvHuo=; b=m
	A5G94TT9NTrdgYgmDkoi5FjxdtpowqUIFTem4CfUERY90bXd5UPMz80Y/MfyXjM2
	6QawnzKugAEwnu/n7s4fvl9b0YZdv2Jtgcdg3A3fJqPtkBsAeQPZtbau5NyrivOX
	7MWcPbCGHxN+ttp2a9300/EGFfv2/F0osU7sG8JXC3mWpSZImvD5Prxz+6eGHKZY
	CoAtUSx/cqXag0WTMeOcgtr4XB9wlwyht8BdA5+4E0WNe22gKmamFJ+k2zQKJ05c
	KQjLMNFcqzh7MEE+pM5Rx1RbVTFqrhPIBeRui7QDLOgxMxM+bWrq7INflWQ+Zwjl
	OaUrluPGNBOokMC+3dOYw==
X-ME-Sender: <xms:0rhkaRb4Xsr7cgqTy8RIo_gbN1EbFPli3DSgz8qT8qvYXA9qHFN_vA>
    <xme:0rhkaf1cbffJ7xgGvg5LegU94lXtcjg8vTb1IM5LCYB0xIB4kk8DU24sMMnIl3AVk
    1tqbx96Xe7-KRTqCzqRBOHM-cMkW1lsGDb9BRy7GwcNDyzvR4yc3w>
X-ME-Received: <xmr:0rhkaRXu1e7hcTEp1fcmwfJf47FafjInG2RWYUKqoyWraLvxveZJN1e1eX7MW_2KFp3kf9yWju9aNaAf7m4LX6S8JCYxp9yInTnnKB0QGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:0rhkaZXAI3_4uT4yv9NJGcBNgoiakF_kO0vaX1h8mbRhNrw70zjETg>
    <xmx:0rhkaQdZ_GpyYdcKhXEfg0vXV9uVxoHQSnyNnPMZyb5LhR2pY2MSqg>
    <xmx:0rhkaSWzc3TJrm-uxsjbnmdjgbcsyIBkqoxgRAXXTcI0JimB9Nk_iQ>
    <xmx:0rhkaZeOJTKyDQLjBp-0L_jQzqVb1M7N66KXcWd1tO8AHa2FnkDWCQ>
    <xmx:0rhkaRT9sZMcwa6Hq7aslLkLKluQHle4tLaylNFY6WbT_TetHcwP-ibo>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:13 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2c8541a3 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:13 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:56 +0100
Subject: [PATCH v2 07/17] refs/files: perform consistency checks for root
 refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-7-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

While the "files" backend already knows to perform consistency checks
for the "refs/" hierarchy, it doesn't verify any of its root refs. Plug
this omission.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c     | 50 +++++++++++++++++++++++++++++++++++++++++++++---
 t/t0602-reffiles-fsck.sh | 30 +++++++++++++++++++++++++++++
 2 files changed, 77 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index abc2165339..9ae80b700a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3877,9 +3877,9 @@ static int files_fsck_refs_name(struct ref_store *ref_store UNUSED,
 	if (filename[0] != '.' && ends_with(filename, ".lock"))
 		goto cleanup;
 
-	/*
-	 * This works right now because we never check the root refs.
-	 */
+	if (is_root_ref(refname))
+		goto cleanup;
+
 	if (check_refname_format(refname, 0)) {
 		struct fsck_ref_report report = { 0 };
 
@@ -3974,19 +3974,63 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	return ret;
 }
 
+struct files_fsck_root_ref_data {
+	struct files_ref_store *refs;
+	struct fsck_options *o;
+	struct worktree *wt;
+	struct strbuf refname;
+	struct strbuf path;
+};
+
+static int files_fsck_root_ref(const char *refname, void *cb_data)
+{
+	struct files_fsck_root_ref_data *data = cb_data;
+	struct stat st;
+
+	strbuf_reset(&data->refname);
+	if (!is_main_worktree(data->wt))
+		strbuf_addf(&data->refname, "worktrees/%s/", data->wt->id);
+	strbuf_addstr(&data->refname, refname);
+
+	strbuf_reset(&data->path);
+	strbuf_addf(&data->path, "%s/%s", data->refs->gitcommondir, data->refname.buf);
+
+	if (stat(data->path.buf, &st)) {
+		if (errno == ENOENT)
+			return 0;
+		return error_errno("failed to read ref: '%s'", data->path.buf);
+	}
+
+	return files_fsck_ref(&data->refs->base, data->o, data->refname.buf,
+			      data->path.buf, st.st_mode);
+}
+
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o,
 		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
+	struct files_fsck_root_ref_data data = {
+		.refs = refs,
+		.o = o,
+		.wt = wt,
+		.refname = STRBUF_INIT,
+		.path = STRBUF_INIT,
+	};
 	int ret = 0;
 
 	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
 		ret = -1;
+
+	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0)
+		ret = -1;
+
 	if (refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) < 0)
 		ret = -1;
 
+	strbuf_release(&data.refname);
+	strbuf_release(&data.path);
 	return ret;
 }
 
diff --git a/t/t0602-reffiles-fsck.sh b/t/t0602-reffiles-fsck.sh
index 0ef483659d..479f3d528e 100755
--- a/t/t0602-reffiles-fsck.sh
+++ b/t/t0602-reffiles-fsck.sh
@@ -905,4 +905,34 @@ test_expect_success '--[no-]references option should apply to fsck' '
 	)
 '
 
+test_expect_success 'complains about broken root ref' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+		echo "ref: refs/../HEAD" >.git/HEAD &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: HEAD: badReferentName: points to invalid refname ${SQ}refs/../HEAD${SQ}
+		EOF
+		test_cmp expect err
+	)
+'
+
+test_expect_success 'complains about broken root ref in worktree' '
+	test_when_finished "rm -rf repo worktree" &&
+	git init repo &&
+	(
+		cd repo &&
+		test_commit initial &&
+		git worktree add ../worktree &&
+		echo "ref: refs/../HEAD" >.git/worktrees/worktree/HEAD &&
+		test_must_fail git refs verify 2>err &&
+		cat >expect <<-EOF &&
+		error: worktrees/worktree/HEAD: badReferentName: points to invalid refname ${SQ}refs/../HEAD${SQ}
+		EOF
+		test_cmp expect err
+	)
+'
+
 test_done

-- 
2.52.0.590.g1f87b77810.dirty

