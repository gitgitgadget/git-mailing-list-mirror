Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4651535C191
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962395; cv=none; b=et3r2RfeHbfm/TGWSvHdfC7lE8l9R+eUrM94Up9UULoGGvF4NKWedH2ne3iZJwNnq4CG4WwH9enw/u5yQF/nYPCofSRB72otxkHz32dctPfhm2aw8zRvHIqXH3Z3wvQX76yiLL8auOhr9+UhrHeLjSG+dOPKgpCHfe/a+xgGfrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962395; c=relaxed/simple;
	bh=P1vpxPE3F1mftvX/QXbXkhUJNoV4SEG4z8I4gKQU0f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAepTVRLD/ni6HV13Diqo2knszzrWak/74giJK0rKIXSK+FUzl3gqVHNLnWuTN4SxeUn+dTSMVjuZ/b/SKhMDtR3UCKCSoYJ+U+DfSTbAsY/MBE29G8uppPolDurvoN1p2zzlVE4fQx1tx9iiZz1suRUTQRt9JPqG5Yox0JSy2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R1slfiHq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lrZm5Ae4; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R1slfiHq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lrZm5Ae4"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id AE53B1D00185;
	Fri,  9 Jan 2026 07:39:53 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Fri, 09 Jan 2026 07:39:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962393;
	 x=1768048793; bh=st6ZskDxVwrninnnETWF0tbEPv2K/LPLA1l9vfD+4Lo=; b=
	R1slfiHqvrxfT7CU12DFYxflZ8ML5p3nYDZu9jiYkrJHlexUGm7Yt81yDlY8xYtt
	gZy52jTejv+WM6XPaVn1jNd7I/4nNXk8egR+FO77kfNVcsuWMbify0h1x/spDyrI
	MOvrKFdtB8hd0ApoHuyB1IF4eHHqIBIfba7F//XH96Aq0eNdG4APLnca2/kYtFNR
	2XSPqVOh39man2oGe+AZBrU4M+fgOmH34WvS4heps86G4QayLAyMeGNIyYpGGSRd
	SpCDBT/PI2WVR87+HiqXyMcz3IeZWN/DhZH/LNn7exO3tJnxZYyyZe/N6JVbncAw
	caFBFaU2khH5El6ZRrSY6g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962393; x=
	1768048793; bh=st6ZskDxVwrninnnETWF0tbEPv2K/LPLA1l9vfD+4Lo=; b=l
	rZm5Ae48fj8HAnA/1RUQJI+HaQnfDH5+S623vNIzEXyKLJ3VAdwXh4YWy4lLYhlS
	vewodPb+8o7bfjlmcnXhcyOQe8+yZLfyzr2NEd4paPh1ZoiHUA6FpsQ/VEPw0B6C
	68lCjFAuouQ2vOtnTvMkgZOC8JgJGF9Xilx8b6xghPKWOQ7rCWuNk80pVoVUfDHv
	EIqyI3bfxgloL1bJz/VC1l/dWdlTRx9/s331nqY/BrUCVgPiR4YG6lhrVdcOYZQ7
	KLMT+S2m/QBOjnY2aMDRuCmyOzs7cmIQOdFub8kIEqemGhLGYoeQhzchrxXlmaN0
	MdxfMvKolgeinxK8FAFDA==
X-ME-Sender: <xms:GfdgaRYXj23BZFLuSysG8A0aaz9WrM5IFNqlCHcKQgqLR_g2W1ZpVw>
    <xme:Gfdgaf2PxEJPEQG9TW43Lonyd8moLz7kodD1uJjfJRJTEOPaP6XAIa61ZohpUmOzQ
    Loip7qBmJFcrhK_41nMFRLd1ILUj3wUCaFMDkmb2Res1P7XuPsLDQ>
X-ME-Received: <xmr:GfdgaRWlyF4-2c7irOwJBbkrCMUQdOzV2QCLv-nOsTMt_XJq6PZvVULQMA1Vsz1E-r9O4NtAbrFgBOJG5zRsovNf-u1SZjbYiWXs0SJMUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:GfdgaZWr5e11TzdztaEht6Tj6JODPegJG9d3HjjxbBYyAiL1wQEbCA>
    <xmx:GfdgaQdor3CvS__11QQepqqsR138LCiZdAyK9uyZ32JIf9_s5A47Hg>
    <xmx:GfdgaSUWK5U8nS-gQCHMxaJ5ADSOg04UPxWhTB0gNUbx7FJ6CyGvwg>
    <xmx:GfdgaZe1LCep97mve7EUgdirshesCxraMUcSgMwanKKV5_x6fj6hLg>
    <xmx:GfdgaRRgBKZzoAPlzd6JuPrlumnSWwpQT3QRUPvquZ3AVbL1SiPi3n1c>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:39:52 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4fb981c9 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:39:52 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:36 +0100
Subject: [PATCH 07/17] refs/files: perform consistency checks for root refs
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-7-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

While the "files" backend already knows to perform consistency checks
for the "refs/" hierarchy, it doesn't verify any of its root refs. Plug
this omission.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c     | 52 +++++++++++++++++++++++++++++++++++++++++++++---
 t/t0602-reffiles-fsck.sh | 30 ++++++++++++++++++++++++++++
 2 files changed, 79 insertions(+), 3 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index abc2165339..0ff047d0df 100644
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
 
@@ -3974,19 +3974,65 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	return ret;
 }
 
+struct files_fsck_root_ref_data {
+	struct files_ref_store *refs;
+	struct fsck_options *o;
+	struct worktree *wt;
+	struct strbuf refname;
+	struct strbuf path;
+	bool errors_found;
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
+	if (for_each_root_ref(refs, files_fsck_root_ref, &data) < 0 ||
+	    data.errors_found)
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
2.52.0.542.g9473a8513b.dirty

