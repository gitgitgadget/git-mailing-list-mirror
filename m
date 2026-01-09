Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D73335BDCA
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962409; cv=none; b=H+MuP+YX7qzEM/OqaKSWWkAq6A4Ra3TeZfh1Tk0N/in5dkViYfcar4xOX2KpOtuoJKDCiHDtJjf3lkpG6j5Hn5z0aGcKDT4acIMWfYaWaf4EQa174RK3uABLfTIv9AsvSg4wcyOy56t96Tm6tXUDko7+mPCT7XRFpsPmD3qfJUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962409; c=relaxed/simple;
	bh=Hlyuu8akpoSoktlHeKhtI3rgQzitCTPylUd7JKQWgwA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VSm/5PzKCTxaAYxWnrfpAex/5j7Evfa4MPll/4BMhR5rqr/aUiQXDmqldTmLDq6j0Tmrrb3oyJW7DU2nt6gxuPfDtAW50dPP5WnkXm9dcch22BSwK86Y3WfKEgd+ZyMzsX7lInTnitDlbfUOlBrWx3ouEudC7pu0gnn2Sl/uYJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UUNDfecB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eR9dTWe4; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UUNDfecB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eR9dTWe4"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id EFA017A0177;
	Fri,  9 Jan 2026 07:40:07 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:40:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962407;
	 x=1768048807; bh=0t3QfXNixybcrQLzYzn89e3CFkeyeHTB4oytPrj0sPU=; b=
	UUNDfecBtGNL//gp4Ng0RIbEqfNxD6FOv69Ta8kFfUP6slFkbchwMQqZLH0boWAZ
	UhaFsLzjEkQvxl9xFc/WEfr41nR79/A3actknpJG4ld0UFiwjuGtslXgm61F5TxS
	bn5PMlmzPjsVOFv7DPVFGF5d9UwQX+9z0nqwcIVLk+w6fDbQkaIbinp1Nm6NSNK/
	a8TTvrUWSw+NCZXweVrOqffryO9ULvq/AbTFyDtKzL9sCzw292LP9aH+DettME9n
	6TqxO++VjTU6l+YupCQAG9Mmt0LqNtA/uuN7wftENmaVg+rBxfnDXc0NsY6kJvKu
	GvDKvvci9kIjilQ/oJjJJw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962407; x=
	1768048807; bh=0t3QfXNixybcrQLzYzn89e3CFkeyeHTB4oytPrj0sPU=; b=e
	R9dTWe4WSOUMNSVo8jBe/4u/lsW0L7Whsh4pYNcnYvxJWT5/mzFon7V+h8sKttJm
	1QOhAJEW3jd/pr+p45FXhyLuhr3Ti/tmy6NMVQk3tD9BoF6PNuGX3GqJ0uNlV7OZ
	ZytN9ywBJcoW6a+yVmPRQSEKuFLTWHmKDcPoDi5zD839hdEFHo2TXA4ZNMYWzADL
	CGYoRuFN+d3E5pdDaFxynEVaZA7v35FFy9VpruaoT/3UMwO7HDorU724vLR2MEDd
	Y0s0UcFb44MMgkCouorJP5OzHEwpTel65eTuYTW/vBxcaRyls7MrPQCQrJeUS6Z6
	rD3bMGuyNJJ3jwrJDhByQ==
X-ME-Sender: <xms:J_dgaertz-GIZ4rtOC0R8vAhVCHBkrE4i0oouQ0GfwAj4pBOKdFgMQ>
    <xme:J_dgaUGA0uappsa3TmF8Nv12lvlixFgdDQQmXqODI-uVUtFExWCfLcUvDf_-Ly1HV
    z5kjWIDKiI_qxTYLHspUy1vzu2yuSTrA0nSoLz3rth2s3jZDSeRf58>
X-ME-Received: <xmr:J_dgaQkKRTVOh-WNnwGhWPDnbqBBPrFL4wRH1d4jl2KLQwEfhqEbSl-7OmohOfHA7Ht2LZnxXwP5VkJd7E3ERsgjZoU6u8DzX4C-fTQ_Ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:J_dgaXnff6zX-2kNGRe5awYpLjqe0D1vxUcaZRP2F_u-ePjVxAxpVQ>
    <xmx:J_dgaRtYJrFp6mUgXIV3KMsciBQWhJ2ydXM8tF_bQMur-kvH7ZMJHg>
    <xmx:J_dgaalG8Y39RqsuTLVXSNsNBThtjXMIuouCb7tHGLnuXYHWoqPKbA>
    <xmx:J_dgacv11VTAB3ufWPJnViM1gYIvbiDekH9ilHyGHkQwT-EM_h_Phg>
    <xmx:J_dgacj8n0pwIDLDaavWNBwo98E6gRQuK4n5m2b0km82DybqNkks3DoW>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e20cb4c7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:41 +0100
Subject: [PATCH 12/17] refs/reftable: extract function to retrieve backend
 for worktree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-12-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

Pull out the logic to retrieve a backend for a given worktree. This
function will be used in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/reftable-backend.c | 70 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 43 insertions(+), 27 deletions(-)

diff --git a/refs/reftable-backend.c b/refs/reftable-backend.c
index d61790cf65..dda961a32b 100644
--- a/refs/reftable-backend.c
+++ b/refs/reftable-backend.c
@@ -172,6 +172,37 @@ static struct reftable_ref_store *reftable_be_downcast(struct ref_store *ref_sto
 	return refs;
 }
 
+static int backend_for_worktree(struct reftable_backend **out,
+				struct reftable_ref_store *store,
+				const char *worktree_name)
+{
+	struct strbuf worktree_dir = STRBUF_INIT;
+	int ret;
+
+	*out = strmap_get(&store->worktree_backends, worktree_name);
+	if (*out) {
+		ret = 0;
+		goto out;
+	}
+
+	strbuf_addf(&worktree_dir, "%s/worktrees/%s/reftable",
+		    store->base.repo->commondir, worktree_name);
+
+	CALLOC_ARRAY(*out, 1);
+	store->err = ret = reftable_backend_init(*out, worktree_dir.buf,
+						 &store->write_options);
+	if (ret < 0) {
+		free(*out);
+		goto out;
+	}
+
+	strmap_put(&store->worktree_backends, worktree_name, *out);
+
+out:
+	strbuf_release(&worktree_dir);
+	return ret;
+}
+
 /*
  * Some refs are global to the repository (refs/heads/{*}), while others are
  * local to the worktree (eg. HEAD, refs/bisect/{*}). We solve this by having
@@ -191,19 +222,19 @@ static int backend_for(struct reftable_backend **out,
 		       const char **rewritten_ref,
 		       int reload)
 {
-	struct reftable_backend *be;
 	const char *wtname;
 	int wtname_len;
+	int ret;
 
 	if (!refname) {
-		be = &store->main_backend;
+		*out = &store->main_backend;
+		ret = 0;
 		goto out;
 	}
 
 	switch (parse_worktree_ref(refname, &wtname, &wtname_len, rewritten_ref)) {
 	case REF_WORKTREE_OTHER: {
 		static struct strbuf wtname_buf = STRBUF_INIT;
-		struct strbuf wt_dir = STRBUF_INIT;
 
 		/*
 		 * We're using a static buffer here so that we don't need to
@@ -223,20 +254,8 @@ static int backend_for(struct reftable_backend **out,
 		 * already and error out when trying to write a reference via
 		 * both stacks.
 		 */
-		be = strmap_get(&store->worktree_backends, wtname_buf.buf);
-		if (!be) {
-			strbuf_addf(&wt_dir, "%s/worktrees/%s/reftable",
-				    store->base.repo->commondir, wtname_buf.buf);
+		ret = backend_for_worktree(out, store, wtname_buf.buf);
 
-			CALLOC_ARRAY(be, 1);
-			store->err = reftable_backend_init(be, wt_dir.buf,
-							   &store->write_options);
-			assert(store->err != REFTABLE_API_ERROR);
-
-			strmap_put(&store->worktree_backends, wtname_buf.buf, be);
-		}
-
-		strbuf_release(&wt_dir);
 		goto out;
 	}
 	case REF_WORKTREE_CURRENT:
@@ -245,27 +264,24 @@ static int backend_for(struct reftable_backend **out,
 		 * main worktree. We thus return the main stack in that case.
 		 */
 		if (!store->worktree_backend.stack)
-			be = &store->main_backend;
+			*out = &store->main_backend;
 		else
-			be = &store->worktree_backend;
+			*out = &store->worktree_backend;
+		ret = 0;
 		goto out;
 	case REF_WORKTREE_MAIN:
 	case REF_WORKTREE_SHARED:
-		be = &store->main_backend;
+		*out = &store->main_backend;
+		ret = 0;
 		goto out;
 	default:
 		BUG("unhandled worktree reference type");
 	}
 
 out:
-	if (reload) {
-		int ret = reftable_stack_reload(be->stack);
-		if (ret)
-			return ret;
-	}
-	*out = be;
-
-	return 0;
+	if (reload && !ret)
+		ret = reftable_stack_reload((*out)->stack);
+	return ret;
 }
 
 static int should_write_log(struct reftable_ref_store *refs, const char *refname)

-- 
2.52.0.542.g9473a8513b.dirty

