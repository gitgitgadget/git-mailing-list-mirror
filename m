Received: from fout4-smtp.messagingengine.com (fout4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A2411879
	for <git@vger.kernel.org>; Wed, 14 Aug 2024 13:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723641794; cv=none; b=E2wOj+gcFoiI8TRnhfEM6lpUOUXf1lbPfFi4v7ZbIm4VqQHXwq4pMY/hDcqO47VQL1jNO+MopnjgJrxlVKXoOxlqIwQpeRLN2m+7MA1bE8MFzMhMA8vv6Y42xUKyXm5/7Hg9RUsGI5BaWcxNBFnTKoe08lIPwa2adyRgd0IJUWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723641794; c=relaxed/simple;
	bh=xD0jQ38JjcNLjtZIljLJm6kUnEvqVmKGTDAVDRomKyo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r9osHR8aNKJeCHpP6yXFDtNFC0olAKIN47ouaDHhiQImUXY4PaxMGOZexLDiRmuchyxDsROEynVdQvT6I32slFoiAlQWw5LbM45RjgQrLkUHevX3Fz1v+/O5tmcvgGzRgT+ceyQCBGwnYTyYhIMMuWskfjZ2zEy4ZZOrRWdKHr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZcC0NG11; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KR45VC1w; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZcC0NG11";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KR45VC1w"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfout.nyi.internal (Postfix) with ESMTP id 7CE8B138FC78;
	Wed, 14 Aug 2024 09:23:12 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 14 Aug 2024 09:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723641792; x=1723728192; bh=SsJ7h61wAL
	jxVoIMAPlWLzhW2yzu3ruwYDgY8k+KGaE=; b=ZcC0NG11w+uuqslmv8mJs6/taS
	7ldnneI5EOjMoNvXhHP+M2OC+oCn94rVkVD2PdL7a/XgrrPOp005I60//Bv4gcWY
	HPcZDeRmHQOgJAkzXBR9WYgYa+w+B3V5Q6GSusEaElLjcH0VfGo1HD+ppyUThu0K
	p5e/36MVNxAZ8E8ZYUcx98eeUfqHTvOcw0UTpkdWBAUyu+bjCsisYod2ZUjjNhdI
	qUld1Qb5UZABqjAT1pExtO7z/JDAhDrT+Whrsqz0IENi1vfMDZBIDrtd+vUKcxBu
	Qleq2UWiDnKJ5RoDm3+CnIVEZX9uPJEbVxxDBikEqCtAy73TB+7CgQ7NTFtQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723641792; x=1723728192; bh=SsJ7h61wALjxVoIMAPlWLzhW2yzu
	3ruwYDgY8k+KGaE=; b=KR45VC1wT9N5K4voHfdS2vd7X5bct88GKP1dLNiZCYrY
	GQm0IaG+Tq6peNvAkoaQFRigQ5t72ANgcj6WqCMitmHSZeKVX9ySALIL1j++ZUxc
	Ta7gHuXtk4jYHpLI7POBLo6xl1PPp0iB6nehfbw7r+r7kq7k8HSgzjGPX2t9eql7
	ICn660aUHZcq76EqNySf4o2Y7D4crfWBzek15OO5yKZsnSsCfeM4r9l75fTlw/1y
	aMsRvhQRNGGfPaKW4gm5fn7PmE2e2UVK4T8o7pC/ZPWa8DgasrATmmQxxUXC8J3n
	ER+CR6vZUFLUJL2Ys5Vh31YEURhYaValS7/n+3jFHg==
X-ME-Sender: <xms:wK-8ZiOMkKcgITZxisafY4f3fGL9FkKMZbwOKFX1Yyvtynbvw327mw>
    <xme:wK-8Zg85rQi_GtJVuj8Xjf0nkOz7i50rvXn2FUcZogUjW6Ix8s8XObav0MpDIcsc3
    yMjtZZf0NAiUWPU3g>
X-ME-Received: <xmr:wK-8ZpQdOeY39kRwZ0K_qxUCRK6TfeNSbZ2PyltJBAhdRW-3qqYKsLNLhUwZbMt7ifKQ2cMnGC8ruYNEWAroSzqEYRAM79_LMI-ts11MM5Xzkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtgedgieeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:wK-8Ziv8NziSQpyT6j9aBla7WepU7AEuaLrckswNT3f7ITU3ND1bNw>
    <xmx:wK-8ZqfETDprmlWWpHw2vpC7DD_ODF0Nw4_qUyXhDxl5QKumjZsoCg>
    <xmx:wK-8Zm1hOGhjfo6d1ZC9xoi4kuMIRMJ2KTM33CAKtIPu7pd5QZenZA>
    <xmx:wK-8Zu_6otB7I7JSvmTSKwvr2P_wiOYDRlBS7TPQy37wtY8I1Gi0YA>
    <xmx:wK-8Zrof9xNxsdmLiWhHODg9LEfS80HEs0Si34EaXK5khoaz2zdMw6Gv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 14 Aug 2024 09:23:11 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 37d67649 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 14 Aug 2024 13:22:52 +0000 (UTC)
Date: Wed, 14 Aug 2024 15:23:05 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v2 07/15] reftable/dump: drop unused `compact_stack()`
Message-ID: <4011fa65d81928348e2e4d107279d04ed9fd7324.1723640107.git.ps@pks.im>
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

The `compact_stack()` function is exposed via `reftable_dump_main()`,
which ultimately ends up being wired into "test-tool reftable". It is
never used by our tests though, and nowadays we have wired up support
for stack compaction into git-pack-refs(1).

Remove the code.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/dump.c | 27 +--------------------------
 1 file changed, 1 insertion(+), 26 deletions(-)

diff --git a/reftable/dump.c b/reftable/dump.c
index dd65d9e8bb..391d93de6a 100644
--- a/reftable/dump.c
+++ b/reftable/dump.c
@@ -24,30 +24,10 @@ license that can be found in the LICENSE file or at
 #include <unistd.h>
 #include <string.h>
 
-static int compact_stack(const char *stackdir)
-{
-	struct reftable_stack *stack = NULL;
-	struct reftable_write_options opts = { 0 };
-
-	int err = reftable_new_stack(&stack, stackdir, &opts);
-	if (err < 0)
-		goto done;
-
-	err = reftable_stack_compact_all(stack, NULL);
-	if (err < 0)
-		goto done;
-done:
-	if (stack) {
-		reftable_stack_destroy(stack);
-	}
-	return err;
-}
-
 static void print_help(void)
 {
-	printf("usage: dump [-cst] arg\n\n"
+	printf("usage: dump [-st] arg\n\n"
 	       "options: \n"
-	       "  -c compact\n"
 	       "  -b dump blocks\n"
 	       "  -t dump table\n"
 	       "  -s dump stack\n"
@@ -62,7 +42,6 @@ int reftable_dump_main(int argc, char *const *argv)
 	int opt_dump_blocks = 0;
 	int opt_dump_table = 0;
 	int opt_dump_stack = 0;
-	int opt_compact = 0;
 	uint32_t opt_hash_id = GIT_SHA1_FORMAT_ID;
 	const char *arg = NULL, *argv0 = argv[0];
 
@@ -77,8 +56,6 @@ int reftable_dump_main(int argc, char *const *argv)
 			opt_hash_id = GIT_SHA256_FORMAT_ID;
 		else if (!strcmp("-s", argv[1]))
 			opt_dump_stack = 1;
-		else if (!strcmp("-c", argv[1]))
-			opt_compact = 1;
 		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
 			print_help();
 			return 2;
@@ -98,8 +75,6 @@ int reftable_dump_main(int argc, char *const *argv)
 		err = reftable_reader_print_file(arg);
 	} else if (opt_dump_stack) {
 		err = reftable_stack_print_directory(arg, opt_hash_id);
-	} else if (opt_compact) {
-		err = compact_stack(arg);
 	}
 
 	if (err < 0) {
-- 
2.46.0.46.g406f326d27.dirty

