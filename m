Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCF0B22FE08
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 07:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566166; cv=none; b=WqlphQdZqtgjQ6ZygHMksNve9J8+XljjdzgO+wcWVFzvLi0Mh6kqWkN+RdC/W1obltiqI/apjDBvJfNtOaw3lmezjrI/Bhf2pATGsSk8ZKkCcDIecu5ar+QNSKlpMhzPWEcrHaMK/O47Ya93UxuEsOhSv2uOCOAlSDC6eBg7D9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566166; c=relaxed/simple;
	bh=K4MjspIIKsx2CeoOmHY7/oQouU2k+6xrD9uiMyKyzDk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DUYCMut96cb3TjJSCChyCTbrz5c2Q41kchVhZbfUvIBSNfDKPSqJMzgChcaIQIMgXsj6VQb6gORcgXnjrX6SlNZ5QebiKrQVNViM21lH7OJi1DwgDt0pBKIjWbfXwttA2IvC48+QwKtR/5bCeiDMf2fdzT2pTkJPHC2ru3URb1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=1DwtCY5v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tuKxD+eB; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="1DwtCY5v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tuKxD+eB"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4492C114022C
	for <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:24 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Fri, 25 Apr 2025 03:29:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1745566164;
	 x=1745652564; bh=P9l6tmqaxW44jKVQaFoL0Sd8cqA8CKDVwiaiq/s2LkY=; b=
	1DwtCY5vTc/H4+LO7nNxwZsAnkkVpPewpAphlmGcciyHDjKdhayrkgGhJ+ITo9vb
	dW87kApxZLJKRilmfH3qgeuRJ5exyNkeUUz8/1hVLXhfvy07fVaLCPUKmDLyWZFU
	5y2421D676M6KwEdrpeBAF56MsCeEMnmqbk0vaPjmp1UtJdMFliJyXlDNxkC7pYX
	PkX2puB+omF2gEUuxVic+OCrsTyXSeoyL7gmJJiWQtsPlcXQ/I4KNlOM/w6+Z+w5
	RbBSi1yV1jtcN4hjA5TAzw1KbisbMr7GPFKh4rENj/KXOoCvrgq+MnAlAVW4cKPE
	IW2S+2IbPGKjDLbGOPpZ7g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1745566164; x=
	1745652564; bh=P9l6tmqaxW44jKVQaFoL0Sd8cqA8CKDVwiaiq/s2LkY=; b=t
	uKxD+eBSvXAL0JOZr/TuBmazs/WeGUikFKztJEl7PmRvMh+T6T3Lkl6QyFLoB8RG
	ZOy+8+w5RGLd1/ne8JNaFvXsUEgmRwEV/XE5xG3JCozzgeyyWPPpROVVA9Acy6KG
	lHCy1FQn17toOp+BEZPLhic20t4Ol7VvaV3DFqISxQ/KSJ5wIsZTgJtKXOINA4LZ
	XelZpCDhwMzs2slfS0CMTOBcBitnU9+aqO54c4UsB8Ncz2x1ZK0lkyZtq3E6jR23
	5VNuTbVZB0Z4yARa84KdiW4OVjVlRERWXR1xEUd3Ya4gvXcZpq2Z4CD0vBg2H+D4
	WiiumcR082lV8+QtgcIZA==
X-ME-Sender: <xms:1DkLaEz_lD6RrwcV-eoWl8HcymVC08mrC85aPgKu1GWUl2K8qg7ujQ>
    <xme:1DkLaIQX1QypexCm5lfVfD4qnacRmGnbodVa3KgfONBesmyudEpFi-3kmQ5TRUcbd
    avL2256eDStl7LMkQ>
X-ME-Received: <xmr:1DkLaGXz6wbdK5vgxl3-csoI-r6RhTuySwSJbQVJdBm1hsmJa6KJF2U8bmOjE1I3iOd2zI6PqfVrUoN5xspVHKLZV7Xu1Cu8bxwU6fnc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvhedujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhff
    fugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuie
    dujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhs
    thgvrhfuihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhi
    thesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:1DkLaCjMIiuAH6kdQ-6K3La3t4eRWyWtBPbXL607kYitEoW3nVoT4g>
    <xmx:1DkLaGChYMILvXFbs-ugD0Ybu_sftXskX0u6grgpAShF_Bc_Gte5bA>
    <xmx:1DkLaDKShxlc6KdeeMQbH18emqnheLMMey2h2HuUIcuQRpur0oCiow>
    <xmx:1DkLaNC8x0C3gkKErTzqmKy4H4Q7H_yCE--qCDCQHb5-qdrB4nJRiQ>
    <xmx:1DkLaOtGo9hvrhJUpWyP5ALZXXQiCu_R8eqX8sw37GYfuw_VAIE2M6XE>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 25 Apr 2025 03:29:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 943f85f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 25 Apr 2025 07:29:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 25 Apr 2025 09:29:17 +0200
Subject: [PATCH 1/7] builtin/gc: fix indentation of `cmd_gc()` parameters
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250425-pks-maintenance-missing-tasks-v1-1-972ed6ab2c0d@pks.im>
References: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
In-Reply-To: <20250425-pks-maintenance-missing-tasks-v1-0-972ed6ab2c0d@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The parameters of `cmd_gc()` aren't indented properly. Fix this.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index d5c75be2522..a73ec22fb18 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -724,9 +724,9 @@ static void gc_before_repack(struct maintenance_run_opts *opts,
 }
 
 int cmd_gc(int argc,
-const char **argv,
-const char *prefix,
-struct repository *repo UNUSED)
+	   const char **argv,
+	   const char *prefix,
+	   struct repository *repo UNUSED)
 {
 	int aggressive = 0;
 	int quiet = 0;

-- 
2.49.0.901.g37484f566f.dirty

