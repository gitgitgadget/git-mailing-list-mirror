Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2647D1AED58
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641779; cv=none; b=U3qBnrY5ZJyPIBg847E1OqS04BJpVhsDtqSIYrO2lF3hsYl/wdXywZW4PWD3E3bHBBa+n23tgDfTxGvrU3Qf9tYR+ISBK/w6nYszjie5Sf+XHZGg3XfySb4jJWMvvn51Z/xX32eLW3C7BlYnPwBqGtRGik2Br+GtwHbux6HBNB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641779; c=relaxed/simple;
	bh=/n1ONX+6Rl8Wxi2ERbWSYHCjKw1b17YJJeMkYdzohw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ddonvA5N3zwUjns7v0i0GM533qoQ1AE64scdVu/qm9Z52jWWGMj11qZp5lu9t/yAWGxRY+MotCgHxBscg7pl5fyP5NE+DSqUsHCwPjgY7PELnSrSo4wbwy2ortimxvcPaJ9CdkmqYH946RaDYpQXIo1vraFrktHvJE5UbtijTR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=JkhWy8V9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GLqIvI+4; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="JkhWy8V9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GLqIvI+4"
Received: from phl-compute-05.internal (phl-compute-05.nyi.internal [10.202.2.45])
	by mailfout.nyi.internal (Postfix) with ESMTP id 3F9E1138EFB6;
	Wed, 14 Aug 2024 09:22:57 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 14 Aug 2024 09:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641777; x=1723728177; bh=lSyf3bDsCR
	KY5WWxvlKmO3/3JrFUopcOcNf1JFBjfxs=; b=JkhWy8V9IAgFP0WDxYlfOHBA2O
	PukPkVrSx1Nv3hRENzxHwzOGFC2wkwBsba0gLGydWAujyXWJuD9iRgJ3aJnYk294
	ibQQBGslKOcFiTa47n1nrU//pTQ7Vhss0ZNsJekyYpSvhldb1X5ux3UwmHuffo+t
	f/riEJFOI6D2LQRVtfI7IZE9MPYiuSRmeZzGZjY9WsEzIVZwUPSqqm6KVwujjb+9
	MRUizgI3yMopdFMkvuz/9L8Txf58y62/e7bChbluvlzpJJvvS08tEUrZynIXii4/
	3sfL2U/JO3O1cKwL2/tc6SrTKR9awSGG0H65bwG+UdlnbPA/5aB0ZHcLP2+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641777; x=1723728177; bh=lSyf3bDsCRKY5WWxvlKmO3/3JrFU
	opcOcNf1JFBjfxs=; b=GLqIvI+4ATOAHEFxogXhw3DV3kgauLFmVmvYki8tI4UO
	AyXL8TI5GRjVjDSadeiZHGFSuKFR9tVMax8eGYs53tYY1/pxKutca7O4S8dBHfTz
	pdsiOAcp4hdcyXjvX8az9l/NU2BdIJ0A3EBhu0PSBMkTJUD/HDhr3uIPKFJVLyMz
	VVTF5P6zv8aiTf2CStwF6YbUWx6zfM15Ze848CKAB0b3YNdcj3bcVvfLMP4mvgDk
	Ih5DOczJBxq/m34fcXQsVmYs1SBuH8iAI/DUXLP3kLD2r3mRfDBJJVgDzcjHw2Cy
	91N2unclWJ5ly0kA9m6iSun78EAygdAsK1w2rWePTQ==
X-ME-Sender: <xms:sa-8ZopxPc3rkeYsIEEDoxKej70sybp_RZDHql2A5uD2-JCNTzP_lQ>
    <xme:sa-8ZupvWTZ1A8NHp3u9KrcV_24QNfreUG9hq12u-ZriLML8ePsRXdS35glQwtxy1
    1zFOglhAEnk5QUaCw>
X-ME-Received: <xmr:sa-8ZtM6uY2W2f7zG4BU4Sty9iyB7Qr9T0O3xYPf7b_mIheLVnWeP9vtcZ62m6arPgi3YikuFlERBeb9M49rLl36dZXQiv6Dnq8hUoSuYs4aSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:sa-8Zv4JHzzUEeeqZ_RE2EcddB_FYUcsckLBZaZH6_mLlGdKa_uN1Q>
    <xmx:sa-8Zn45nTICm9jfbu_5HIui8p60evCFER4iliGjwYrqvQjIGKhSZw>
    <xmx:sa-8ZvhKp5MHtjYJEh04UCk3IZxG0voqKfOlutqegOIhMOsLg2e2Sg>
    <xmx:sa-8Zh5N08qV6MogD-0Ln-dVuDbyFxg0-Pqo9fCjYdHpVWwk9C7WyA>
    <xmx:sa-8ZnG4-nox3XrnfbdFvK2c-XUVCzBfZVXqz7SLv7w02_wRQrA3AzcJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:22:56 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 34be6a6b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:37 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:22:54 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 04/15] reftable/stack: open-code reading refs
Message-ID: <6ba3fcee4115fbf4e46a6a2a31f0b3c01b0903dd.1723640107.git.ps@pks.im>
References: <cover.1723640107.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723640107.git.ps@pks.im>

To read a reference for the reftable stack, we first create a generic
`reftable_table` from the merged table and then read the reference via a
convenience function. We are about to remove these generic interfaces,
so let's instead open-code the logic to prepare for this removal.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 25 ++++++++++++++++++++++---
 1 file changed, 22 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7f4e267ea9..d08ec00959 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1468,9 +1468,28 @@ reftable_stack_compaction_stats(struct reftable_stack *st)
 int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
 			    struct reftable_ref_record *ref)
 {
-	struct reftable_table tab = { NULL };
-	reftable_table_from_merged_table(&tab, reftable_stack_merged_table(st));
-	return reftable_table_read_ref(&tab, refname, ref);
+	struct reftable_iterator it = { 0 };
+	int ret;
+
+	reftable_merged_table_init_ref_iterator(st->merged, &it);
+	ret = reftable_iterator_seek_ref(&it, refname);
+	if (ret)
+		goto out;
+
+	ret = reftable_iterator_next_ref(&it, ref);
+	if (ret)
+		goto out;
+
+	if (strcmp(ref->refname, refname) ||
+	    reftable_ref_record_is_deletion(ref)) {
+		reftable_ref_record_release(ref);
+		ret = 1;
+		goto out;
+	}
+
+out:
+	reftable_iterator_destroy(&it);
+	return ret;
 }
 
 int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
-- 
2.46.0.46.g406f326d27.dirty

