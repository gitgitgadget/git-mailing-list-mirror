Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55D7A23024C
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 09:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739870522; cv=none; b=t3QNZo75Vb4Ltk447ZA4uUlxxmU74lbIPKlzaNC995fLY2JVWoK9KNbkLN3RfVJ4BVgN2LUEPAaStq4Cr5hSHF+G0H2/U0SRoclJneSx9LR5Ce6dXgw/kIvbMpu8tQbAhrgt46C+LndxeUMY5M1+oaRxP+KV1sNLSCDXcKjMzrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739870522; c=relaxed/simple;
	bh=OKYLqiHpfGw566O2Asb37J7FtvxKidSPz7Oj8TTw91o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hjpN/RAZXgYnTgRI6Q37hVe8p61Ez2i1mwPUNwgVXbCLXNYTazrQ9IKqKhsDmONyJdSQqCcWub0gpqzffqKExiFPEvtIvBVTR38PacCAJozXQNE9ywDDu+FOrOIZncMOGDZEg/Zahi4l5KAhfeY3Bblty/MTof1l/Mcl8qm2PVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=XOIbSXWP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D/uLojFv; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="XOIbSXWP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D/uLojFv"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4BE481140277;
	Tue, 18 Feb 2025 04:21:59 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 18 Feb 2025 04:21:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1739870519;
	 x=1739956919; bh=jzUBPmqi9A8J79SwTpoWkRZxurMAR2TFf15CMu5PxTU=; b=
	XOIbSXWPokL3Dg+Aqc3evGuU6YN3GFJQb2LrAWHhPnQVID6gzJLNPV63He8ojJtp
	dkWv3uHP771kXlivKwxoqSSXW+wT3m1acAzKfN981qhOQwfpmHMF/qzMxtghfaWA
	Db46dSJUjYrnlw+6NymyedjPRWey351QOQEB0e2YP2ejDe/ejxmAAW5xZ5sRW1fq
	HYl3S8Xs9Kc45TzYP501giJjt7Ah5UrS2VdVljOae0w6ytGXZ5QaX/AN7S29jfRG
	M2o/HpEzbwpWwKL4FcJb1hGoruZkqsbfWXpeldFship2XKYuatp/FQUylofnB+Zl
	4Y9ZJCzXzPKXh8mUWec22Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1739870519; x=
	1739956919; bh=jzUBPmqi9A8J79SwTpoWkRZxurMAR2TFf15CMu5PxTU=; b=D
	/uLojFvw0+bI8YSVIX5K7RTmMFa8cGmDssWfOi8259gZYQLHZj++JussId4nIRdM
	K9IiVRS5UjqXUD7BWvrVz6Oa1JL9np+gUzrLbKBNEjTvkE+wBY9GP5zJnH97G0gt
	bYvt+zqZvjrymN4Uc4AtwikNQk8PYQS10uzMsk6HvJzmJk9/3QA7D1xg39s0gr4o
	Vgp91vL0NM/M9HKkVobf2r6yONouXIKYa2PAkMeFQE4MkeuyxG7vJeeD0hzJbhmk
	NQAwYbRbiTqTy8qXCgAqDQBuWifK5JmsfCTc2f4HFK36i2sA4vbayw8h2rHUkbtW
	tJ2/9Opa2ngnpsbb/uUKA==
X-ME-Sender: <xms:N1G0Z-7nDo4b3tAZ895_KbM2bYrFdfKM_hTGBqbWvvZdLLhQesi9Nw>
    <xme:N1G0Z36wFly3IZxqYVnGh_KAQcVTGvBrcP8gf7WrjiFfDHz9ne9wxLN7CUbozsE9z
    Ia-hc4BZSViMUG0SA>
X-ME-Received: <xmr:N1G0Z9exwofPwC8vtWtjM1gDzAf9HK_xGlTFrElAucG_O-bQh1y9OLGfJedM-H-tVR3fG7MO5IlhiSujaYAWACsdK_RtVa-SGNWOM6MW3Ml0UeLW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeitdelfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    jhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepjhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:N1G0Z7JOxGIJzTuy5d9EBIijZ06p-_-4pxELnVPPldFRs4UdSMhrKw>
    <xmx:N1G0ZyIypZDrxmNpW8EYiEbZ0TiTFgWTZcYVOGO7NpVupJjlNdFEog>
    <xmx:N1G0Z8yAnzW2lGrCQXhgVIWJjIs_5KOkijoVoRv2-sKLZqP5q1h_Cw>
    <xmx:N1G0Z2KwTjkyfwOQefgSVvzCjm4mXRbZeFPp2y-C-ORyef_UcivgmQ>
    <xmx:N1G0Z68k3jJxrsAdLMCP4TpG2-cGUDpeMqNKxkBYQAGSfFT56pL82LXH>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Feb 2025 04:21:57 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8e0ab86f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 18 Feb 2025 09:21:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 18 Feb 2025 10:20:39 +0100
Subject: [PATCH v6 03/18] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250218-pks-reftable-drop-git-compat-util-v6-3-8c1f39fb4c02@pks.im>
References: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
In-Reply-To: <20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>, 
 Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-Mailer: b4 0.14.2

We use `xmmap()` to map reftables into memory. This function has two
problems:

  - It causes us to die in case the mmap fails.

  - It ties us to the Git codebase.

Refactor the code to use mmap(3p) instead with manual error checking.
Note that this function may not be the system-provided mmap(3p), but may
point to our `git_mmap()` wrapper that emulates the syscall on systems
that do not have mmap(3p) available.

Fix `reftable_block_source_from_file()` to properly bubble up the error
code in case the map(3p) call fails.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/blocksource.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/reftable/blocksource.c b/reftable/blocksource.c
index bba4a45b98a..02972c46f4b 100644
--- a/reftable/blocksource.c
+++ b/reftable/blocksource.c
@@ -98,7 +98,7 @@ static struct reftable_block_source_vtable file_vtable = {
 int reftable_block_source_from_file(struct reftable_block_source *bs,
 				    const char *name)
 {
-	struct file_block_source *p;
+	struct file_block_source *p = NULL;
 	struct stat st;
 	int fd, err;
 
@@ -122,7 +122,12 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 	}
 
 	p->size = st.st_size;
-	p->data = xmmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	p->data = mmap(NULL, st.st_size, PROT_READ, MAP_PRIVATE, fd, 0);
+	if (p->data == MAP_FAILED) {
+		err = REFTABLE_IO_ERROR;
+		p->data = NULL;
+		goto out;
+	}
 
 	assert(!bs->ops);
 	bs->ops = &file_vtable;
@@ -135,5 +140,5 @@ int reftable_block_source_from_file(struct reftable_block_source *bs,
 		close(fd);
 	if (err < 0)
 		reftable_free(p);
-	return 0;
+	return err;
 }

-- 
2.48.1.666.gff9fcf71b7.dirty

