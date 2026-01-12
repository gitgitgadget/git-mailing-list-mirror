Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBA7347FEE
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208610; cv=none; b=RxWIjl8Qr5p3+2VEf+rD6uAK0WYazfm6vCmJescrTYF1b+Zn0zo+MPwETs4rA29qNoVlR75evfWRFyqVqA4jAur0c7/HFMSwmKbEQKGZKdHdqL7ootKw5TUd2Nv3pXjmr4UYxyh8rsi4hgGg6ciEEhTAyvaIAgQBZQ99OQFnJnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208610; c=relaxed/simple;
	bh=FfTNdrQAex3f87TfKLNh+kQF2p2Eu4hFQR2jBPnb8w0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=d7YMjrKgdTD2x33omLjnylZrE3dHflvKwwuonaNN9tzMp+KAxuqKbpb+azo3a0LIMoSp8Ok+k/g3gFci7ahTqqlS6+jy5p5zEjHmhyn4Prn/0MTFsgGjru4MCXTmpEEgw+X/vqA700j1jM6weEDwQ+CQ6bji4AlqsUkaBKA0yVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=esBjggW1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VwfhPirK; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="esBjggW1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VwfhPirK"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D5ED1D00045;
	Mon, 12 Jan 2026 04:03:28 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Mon, 12 Jan 2026 04:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208608;
	 x=1768295008; bh=nfu9JcSQ3bM6Y07y9V8dxZx1glFe4LK9QG929p7RhqA=; b=
	esBjggW1xomlsCK/BYApaR73MFotYII5NReFa2FzcDc+dVci0IjLRW3sEE02xqHN
	QeAEPCRA0naBOY9imms4vKZP50UgUb28UmeXR/r7J9Vr2I5l/+9Isl5TQ+vSpxH3
	tV7Qi4NRqCxfrSVpCpFaEma5+qRtECOowJz8T8W0TkwWNs5unD7wQ4jbpXrhrK1R
	RTzWChleAajD7xIdwzVgCHWXuYVz71QiNpFcunHtsdX/ClWvLYZM1l+eexuqY7Ug
	DTRNnK1KsG559z2WrCeNI/ZTu25A/TPBih/zdS9SxlHIh+u6aYA1T+8gi1Z+jmcX
	SzKdfCEmehReZYDYLJmmFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208608; x=
	1768295008; bh=nfu9JcSQ3bM6Y07y9V8dxZx1glFe4LK9QG929p7RhqA=; b=V
	wfhPirKihj1xw9R28QLHx3Rn14NVaUGKCcxGaRk2KOQCniwv1Ujnhr26WPvDPxeM
	1M6OFzyDDT56xx9CRK+K54RRcY0pqGc/XJWg/c+5f3jZ8MAtQY7Y6FL3/pv6eWPq
	iu4yJg8aOCsQ/budGabZtm3GzE52tJHzC9UQ/V+DNVsmTv05OdEoseo9ZOzWrmUB
	T9MC48d37n+mFltR4hA2Fd8KZq9gweEAXSHFUcaTwxCI2PMZ86wlt/gf6Xo9GPn3
	na/gXDr81mx4MSXWRQ1XrFDIkRJ0yxbZpfLDNx773smEMLs9/Tp5bE8Zq8+pkIT+
	tcErUA9n4A8oINURQeENQ==
X-ME-Sender: <xms:4Lhkabs64WjYDKJA-GAoPnwC_pCGu82MHGce_uFsGC9XeGy8qg0KLg>
    <xme:4LhkaT773wJ1D61p_VR3QZef90HbIEghBAUXTpsF4kZlh1cG7iT9ANCjFIM2EXay0
    C4GkT4H9stJ7bnJ7RgeaPqKoLq0DaY-M19UjyOCv2l1AIWqxRG1Cw>
X-ME-Received: <xmr:4LhkacK1vQrniTiGgye0WGsKHj_QdlBVykR_KWe8Pxye-5l7uf9iFuSudl1NEpVFBag9BgUG_xJv2GIXeU9F-8AEzqbK8vNCTgviQYwJkA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpeehnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehshhgvjhhirghluhhosehg
    mhgrihhlrdgtohhm
X-ME-Proxy: <xmx:4LhkaT4ztberjbbq-gDLva8DpHGMkybxzgP8bTiluVH6RQWkSHS-rQ>
    <xmx:4LhkafwAum-VulPeoxG90l-q0mN1HCem2eFy_jiLxcJhYV5cvH7jbg>
    <xmx:4LhkaXZU9ilvId64zroKwPwO7SYFKdjB-JiExC6Z_hqTAG-nG6YMSA>
    <xmx:4LhkaRQEX8zUr0UFLVLzX3_K28HNgMuj9MR9x5HeCnpWuz_H1KVZlg>
    <xmx:4LhkaWXXPI8cS9eqwpeqYVIFbqwk3mNn-R-AeTEjL1O-iBWH3-s3tgnb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:27 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 25da6a9d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:26 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:01 +0100
Subject: [PATCH v2 12/17] refs/reftable: extract function to retrieve
 backend for worktree
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-12-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
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
2.52.0.590.g1f87b77810.dirty

