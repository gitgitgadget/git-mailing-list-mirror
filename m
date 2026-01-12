Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC4434A785
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208626; cv=none; b=WVjeFL6ydM8g9xfR1NN70RjDRmOdDtNqqAbAgjmTF8LivAEONLAuX5HKFo4NO7PFRolMYNiYXWn3vGR6NV5s0Qi1MF+/aaWySJS3fXgOGwA1l5+hjCwpMQb2hSiSDdhrZZd63GjjSDos7r7Pix/eIYFTE+Zz7KJk0I/ToPzDb3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208626; c=relaxed/simple;
	bh=/fV1lz91pc4VpxiU0KucpJnsjvHmHYQsTaOZIPSUx30=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TqXSeBQ3fR+0K5ZZOvL2qtNyjyFQgBeyrB1JF/F0cUXG///AMEUApt5kZaHLNvkJCZWzC8qqFvDAJQtZkm730K46uJOKEccDHwb8ezHrP0O6m5xLvbeBflNRDP4CnyzBzfeGjUb/ciYDPs1lwdMT8BuHV5kIsR67bixVgjcaJ5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fdIKa1MB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ovR18dEX; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fdIKa1MB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ovR18dEX"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 772E37A007B;
	Mon, 12 Jan 2026 04:03:41 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 12 Jan 2026 04:03:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208621;
	 x=1768295021; bh=5WvwfDHOJ+Hd9KLC5cCnEFnDyWc+5rcDKei2ishPr1k=; b=
	fdIKa1MBvzaPOIv9xOsideDGqplFCCds+d0G9O+etqOeQKevs79AaqJupqaZOQVQ
	OpjULBUnpbexKwyCxoa9jxbioP/3qKDIZcCuMaIq2mtuQ1L1sGNz8UBJvABicp88
	BHvNaAsVls3xaHZ90uXRFPBsYEJUvAPaVqHquNf6vM2BvjKqCeS8iX0hY61wienZ
	U6zXYTztjUlL3kCzPXhAnTFPsHVce/OHDjteUHuDy0/ISTuMEJk5e55H419aCoJe
	W003P6DUUJ7RaBvYWMDxjbNz3/2bMzXKK8NCy3iOGcJXQXh19u0oB3TZOCQwOyJB
	hbSxQuw+OClvu2b50sgNTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208621; x=
	1768295021; bh=5WvwfDHOJ+Hd9KLC5cCnEFnDyWc+5rcDKei2ishPr1k=; b=o
	vR18dEXs2JdcN1wSqfRg/5FUgInRosgdD6bu5dFfwAKdArjYLLVLE4nqsaRX0Sdv
	FCov055cTdN7hnNZchIrmEbEVgdXW2lm2m3epAhy3ucualeQz+fuikLR95nJNfvc
	2KRD2lxrYolQcCiPJQ74yGAkMMg3ioMHwi1j775QQS94MkbLkgO+iUJGI7FzfGA9
	ypjy0OaptOIs24PVL3i+ZU/pm8nBrPd6egB5gtAZCqckyI3QFPsZT06+MtPM9bWj
	8HlC/+q1I5Nxf0nQScH46mo/ruQhUP0++Ul7ti6VgY0EwqG7XUo85J7Mk/hrYNC2
	zBE9rbZhM/+dTLmMV3D6A==
X-ME-Sender: <xms:7bhkadcByaRJKCbSRZutIya1FNMuCcPhw1iPx_yc5Y4v8h1fF9yRrA>
    <xme:7bhkaSrqQpdpYysIFumQRQhtDeFGMJ_BXqDkWKFkG_3U79Ln3mylreGPK9XaNPARs
    HevH9vRCzgiISBzFvxjTqFwfTDmFW2x2ihKss0lDYZ_keNWK4ry>
X-ME-Received: <xmr:7bhkaT54FQUsYdv1oRA7NfWNcJ3mKtDZ_cGlNAWF5LR-S95wbXqI0EC-NDeJnHcnNV3HjXAfL6U-9MUYarESFiLjSwGeIrUlMVMSj37IUQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:7bhkaQpqHvoLSMjTi7DO3qbJau8OVMszp_SRaed0FjAqMvYZhtx5og>
    <xmx:7bhkadid0an_mqwaryN-77sCnSxZvaUghIYENEaU4okHWcR1KQwtYQ>
    <xmx:7bhkaSLGwX9g1S3cHmYZzjtpALdUYCH6VaGdP1t7q14aLQiw288AMQ>
    <xmx:7bhkaVDyrg7BYTBMtF--zbvLSKAsChe44ZKlJ0nqXJRPAiE6rnYt4A>
    <xmx:7bhkaU2GgQmUUoHYrYz-Je28pnhFR3oDuHvSmpTZ5L42EKir2AZc1Zip>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4e04b362 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:40 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:03:06 +0100
Subject: [PATCH v2 17/17] builtin/fsck: drop `fsck_head_link()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-17-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `fsck_head_link()` was historically used to perform a
couple of consistency checks for refs. (Almost) all of these checks have
now been moved into the refs subsystem. There's only a single check
remaining that verifies whether `refs_resolve_ref_unsafe()` returns a
`NULL` pointer. This may happen in a couple of cases:

  - When `refs_is_safe()` declares the ref to be unsafe. We already have
    checks for this as we verify refnames with `check_refname_format()`.

  - When the ref doesn't exist. A repository without "HEAD" is
    completely broken though, and we would notice this error ahead of
    time already.

  - In case the caller passes `RESOLVE_REF_READING` and the ref is a
    symref that doesn't resolve. We don't pass this flag though.

As such, this check doesn't cover anything anymore that isn't already
covered by `refs_fsck()`. Drop it, which also allows us to inline the
call to `refs_resolve_ref_unsafe()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fsck.c | 28 ++++------------------------
 1 file changed, 4 insertions(+), 24 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 5dda441f45..f104b7af0e 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -564,10 +564,6 @@ static int fsck_handle_ref(const struct reference *ref, void *cb_data UNUSED)
 	return 0;
 }
 
-static void fsck_head_link(const char *head_ref_name,
-			   const char **head_points_at,
-			   struct object_id *head_oid);
-
 static void get_default_heads(void)
 {
 	struct worktree **worktrees, **p;
@@ -583,7 +579,10 @@ static void get_default_heads(void)
 		struct strbuf refname = STRBUF_INIT;
 
 		strbuf_worktree_ref(wt, &refname, "HEAD");
-		fsck_head_link(refname.buf, &head_points_at, &head_oid);
+
+		head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
+							 refname.buf, 0, &head_oid, NULL);
+
 		if (head_points_at && !is_null_oid(&head_oid)) {
 			struct reference ref = {
 				.name = refname.buf,
@@ -713,25 +712,6 @@ static void fsck_source(struct odb_source *source)
 	stop_progress(&progress);
 }
 
-static void fsck_head_link(const char *head_ref_name,
-			   const char **head_points_at,
-			   struct object_id *head_oid)
-{
-	if (verbose)
-		fprintf_ln(stderr, _("Checking %s link"), head_ref_name);
-
-	*head_points_at = refs_resolve_ref_unsafe(get_main_ref_store(the_repository),
-						  head_ref_name, 0, head_oid,
-						  NULL);
-	if (!*head_points_at) {
-		errors_found |= ERROR_REFS;
-		error(_("invalid %s"), head_ref_name);
-		return;
-	}
-
-	return;
-}
-
 static int fsck_cache_tree(struct cache_tree *it, const char *index_path)
 {
 	int i;

-- 
2.52.0.590.g1f87b77810.dirty

