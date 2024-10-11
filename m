Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A35E207A3B
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 05:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728624794; cv=none; b=I/y59KVUtqUxaVcW23Fd95dBDi7jk8rsDkwrne23He689WXm0ucwZtc38KDdJrQhCCcnpowfHb+bxt2bq5ASyQHNNkBK0QWbXV4xd7zwa79zmWfMyyX+dPMEcAON8t8KyY2szvxnsBaXLjvOARxBAY9SVCtOh2CliC4rFusaU6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728624794; c=relaxed/simple;
	bh=mWLISyo+j9VsKrbFx3SwsFKKiYfSgueM1Oabw3xYfD4=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F9AUWM3j0FVli7ABKVfJIjdg9NEXmFJOpNnhOQf3IsGHN2yC+kZD3i46OYGmB0z19Z3O93J4ZKHPSFFlcBxq4fnWHwCBmQZMZ+U4UiH0XXYO05FKvIs64jRsSzEJEWxMmI2OoDaSP7S6lbsb/643I/n7VNT5kh0Yy7V/J63Ix6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=SpGZcf90; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e9zCqhgE; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="SpGZcf90";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e9zCqhgE"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 848E113801AB
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Fri, 11 Oct 2024 01:33:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1728624792; x=1728711192; bh=/9ClUyhYxz
	ORLlAs03XNxeJ6b/pQLVmPIXGFMsjTfnE=; b=SpGZcf90GlEAABepITh0TyiYus
	0EQghQZhWKpW4bQzw0Bsh3KzptRV25AwapogzKtJymc3/mVL0jVXQGa6uazbLJyk
	QFnPmINvm9aj/TMD7B3OJDxZ6oTk6aG7ZQb0PweW6Pa+z+8SPr08dJNM7xe66PJB
	yU/nhzr7jlEG7Jvn3rGUepIO8w+xN1EFn8HWO6PlZqcub+ZP8ZOZSPM3bWcEdQsG
	nL43DMhZ4IGT+LAbS6rEy0Oi9WbhUMpGtryTKyQFOfIpRDQcbr+UKcUiGoDsiL4P
	q20csxvdSOuwKHGjF4IW4t5YfEAZEKwhqJGTMo2OSkOigmM44VXh8WS6bNGA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728624792; x=1728711192; bh=/9ClUyhYxzORLlAs03XNxeJ6b/pQ
	LVmPIXGFMsjTfnE=; b=e9zCqhgEsSsZcJqUITBb9rKVruc2KyQFls2JAKWyXoeO
	H2ou+s5kjqdI6wVn6ii8Q8nGGQ0w822qEVH+bpZHtT7XKp9qBoMV7tL6SdeXSsKV
	eigV7KIzaF73W5Wdmwtbqa/GxM3h+/BUlkv79OjO4oJnPLtvutQCGwUYkpMHy7x9
	bI4sAdZEuOPPbjZuw1E1cQrAxMjsFLe+nSGAQfkAUkoiLTL3HVsRh/RWTZFWiM9/
	awzfgUAEolTvbLF0+O2KoXV7MEME6rhJ2LL4NTW3kBAguh8IfUt8Ha60zjKvr4pq
	93Tl1BL6ny4F+N7fuV7kIDxgT9UKJ7NKlF70cmHqzg==
X-ME-Sender: <xms:mLgIZzAx-t4GvvsdKwMWojnfK0Vg3ui4cwPYfdWZut6s5N_SUbTK0w>
    <xme:mLgIZ5gt7vgLHkvMXHmUHdltOE2Ag7NL_9H3peOvFOzZf7OvV5UuaWHt-B6y_iyeS
    gWaZkv5Hxly8lowwg>
X-ME-Received: <xmr:mLgIZ-lR4MlC0EkGobraY2D4AFib7TZW8vuQITm42IsW_HgnMyJQjv00JGV6gU1SsBgBHGuFQ9rkC7rciHSqpyqcs33q6hnwDR19E4Mw26W0qAk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdefjedgleelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:mLgIZ1yiyVOjr7CK48qLvG_UoY_e2LnT_vNO-9Onl8VU8WdA2kQRcA>
    <xmx:mLgIZ4SNzIWi3nzWFl5ug9uFXcE9OmuC6ELeNccAkfWg4uaRqjluZg>
    <xmx:mLgIZ4Z10y3yIPJuFMzMmrZZYFrgxASpjuJw_toCJV9On6q4mo6T3g>
    <xmx:mLgIZ5T_xHxNDbWJ9vlfcS2snZ1fai4MrpagoPxrGTAC4yChRGEUqQ>
    <xmx:mLgIZzIdeL89F7I8fCDfqEIqfonQtQCfD9ulML42xqdjh3E2KitDKPt6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 11 Oct 2024 01:33:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id c86d3478 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Fri, 11 Oct 2024 05:32:06 +0000 (UTC)
Date: Fri, 11 Oct 2024 07:33:10 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/21] builtin/merge: release outbut buffer after performing
 merge
Message-ID: <bc2206aa47e7e8be0642bb4540e7ddec22fbac91.1728624670.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1728624670.git.ps@pks.im>

The `obuf` member of `struct merge_options` is used to buffer output in
some cases. In order to not discard its allocated memory we only release
its contents in `merge_finalize()` when we're not currently recursing
into a subtree.

This results in some situations where we seemingly do not release the
buffer reliably. We thus have calls to `strbuf_release()` for this
buffer scattered across the codebase. But we're missing one callsite in
git-merge(1), which causes a memory leak.

We should ideally refactor this interface so that callers don't have to
know about any such internals. But for now, paper over the issue by
adding one more `strbuf_release()` call.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/merge.c                          | 1 +
 t/t6424-merge-unrelated-index-changes.sh | 1 +
 2 files changed, 2 insertions(+)

diff --git a/builtin/merge.c b/builtin/merge.c
index 84d0f3604bc..51038eaca84 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -754,6 +754,7 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 			clean = merge_recursive(&o, head, remoteheads->item,
 						reversed, &result);
 		free_commit_list(reversed);
+		strbuf_release(&o.obuf);
 
 		if (clean < 0) {
 			rollback_lock_file(&lock);
diff --git a/t/t6424-merge-unrelated-index-changes.sh b/t/t6424-merge-unrelated-index-changes.sh
index 7677c5f08d0..a7ea8acb845 100755
--- a/t/t6424-merge-unrelated-index-changes.sh
+++ b/t/t6424-merge-unrelated-index-changes.sh
@@ -2,6 +2,7 @@
 
 test_description="merges with unrelated index changes"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Testcase for some simple merges
-- 
2.47.0.dirty

