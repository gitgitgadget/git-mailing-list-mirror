Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF9535CB85
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 12:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767962422; cv=none; b=FrHT2q+nH66GZlpqL9jGfqKYgOcnDEsW/bntnJYPWQIw1bh2emc8UNksvl82T3CJg2LqLoT444ltsKPkLXeC+9KDHrdBEbV9M3Wbg+W0HObvam2krAXFNtC+Z131ErVPClbb84Jc2LaovOCv1ZRUEDBucCjOUom4H0SRBGmIxJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767962422; c=relaxed/simple;
	bh=nOzwnQPYAiymKeOBwa+jiU/wDl1mdbVKEZx1A8ZNFqs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zn3Ki7JBaXKRVwSgQlELsrW6/vbVZI9nzJYbhYkg7wx2D0erShG6OfxUdyPrUAFfciK/cmwryz1qioYDqohcjFlwcpOwlFi/p/8rE628J5UUGk+25yb1CNNppQdOzTbbcS697bvIYVi/va94TRF6PAGlnZp8gUeahTEk34LrTLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Drpb3VTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZdMcYZ7w; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Drpb3VTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZdMcYZ7w"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C26437A0177;
	Fri,  9 Jan 2026 07:40:20 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Fri, 09 Jan 2026 07:40:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767962420;
	 x=1768048820; bh=1FQ8WoSoF6FPlT0bnlcjW12wZyQBycVJQSMLMLXjmNk=; b=
	Drpb3VTBoXyMU5s2aMxeJqay358T+K3TD1b2BF2x27XN4EVVX5Z2CZSHDy1sgi9u
	0hf2ztI/kmXuKmbfXUzLjzJYxRp3f6vlOYEPIAyZFi9UzCpE6FYhzm3Y/rdi+O7l
	/Gv7D6nsHHeD6pVjYeOSlVKvomg0/b3ihZvzvqt3P1mHeIHY/JNdyWSv+2pL8AyE
	Ec6bt6XkIcXbZKtsQuo9h4UC5beQZPJtCLMGV9e9NyIqsHsTd7OXb4SSo36lQWhC
	ZRBQQFSiyHwFouJ1aIl0MPFjpuhHmLynqw9IpLLUBi9IOM93r571NPnr70pko22i
	LgiRUWjSymr6KStk85LJyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767962420; x=
	1768048820; bh=1FQ8WoSoF6FPlT0bnlcjW12wZyQBycVJQSMLMLXjmNk=; b=Z
	dMcYZ7wj1uIRWRkVTfR/kw0TTVZj0eenrpSNxZe6gfWC3gnfv9fsTBXFyMIQC/Dz
	Hmxxpkt7tMoEIwYJ1e7/U1NoRLkP/snseTDRDRgDY0T2F4/p56hBaN2/Ei0y747n
	PAvXjFV5aJgWITE3aB1/yG/gIJrjaKPjgiCoq86VmLI4YLDNcspTQ1eLSzD965oA
	Ub3nWlS8pkckQJXOcCbkDdL9s7LCu2lhbX81a/ddDmKCcKg0Rb+BC1nyZZ47gr1f
	PQKKww+TbD3V19RPO+NF2jYjjbWPXLrDvIe7BB/SeaLDj2DBJCbFOYHaZg1tlgTQ
	3KtB50pJxL3Onife9FgeA==
X-ME-Sender: <xms:NPdgaU-1GqEKEOJG0tF6rby8FFw9ze4NXaZQyOd7YQZy3hdy0rz9_g>
    <xme:NPdgaUIk6u9OVrGAnXS-D3c7K9e5u8kx1vfFaTxWTqkCu05Fl4jmlB9Mm7VAaIHUj
    sBKfjKBjB_T0QmJoHzOGB3941n9bmRhcRVdl3GZ5bmstnlyGybRIwY>
X-ME-Received: <xmr:NPdgaXbEmmDSlbmsqBGxAIZZOK8l6ADQ1G22ZMj8u9Pv8l9hKvOcwsn5IBJx59wmeNxR15viLoV2Y9FlTe0BK_-QFQG8A_KWzmHh1u01Ew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekkeegucetufdoteggodetrf
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
X-ME-Proxy: <xmx:NPdgaeIt-ofcqB7pJAt_syq2VlPTwR_FHPfeYChWliLV13_g3ETDgA>
    <xmx:NPdgadAQeF3MeamdYIRDaY69xbJcXeO7d92ETHEKnOU9mN3m5PSetg>
    <xmx:NPdgabqJi5X9U5tp_Bn0TCfOrADIv99LWCqiRMSv3vgFEquS3I4bYA>
    <xmx:NPdgaQjKcbt0emprNPi5XyTBipnd1fKyDkCYHc_AzEJVf4XgeXBJlw>
    <xmx:NPdgaanwIpX2xdB55GVG2OSxos2RpwmmRq39iMSQdLlSwj4K2rj6J-qG>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 07:40:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c9803ad0 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 12:40:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 13:39:46 +0100
Subject: [PATCH 17/17] builtin/fsck: drop `fsck_head_link()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-pks-refs-verify-fixes-v1-17-3587dba18294@pks.im>
References: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
In-Reply-To: <20260109-pks-refs-verify-fixes-v1-0-3587dba18294@pks.im>
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
2.52.0.542.g9473a8513b.dirty

