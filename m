Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28661DEFDD
	for <git@vger.kernel.org>; Tue, 28 Jan 2025 08:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738052901; cv=none; b=knCz8w3759yo3Vs1mV2z0h69S3lkCILFID5vV9bHoPSD9vB/G0Q3nVPFSCGBEp9fPaiejt8jyvaTW2O/9M21AhYu/XolLCtR3YUBiOpzKjAqAb5XtfhtQO+FGOnrvKPOCQEPWjSbAwQigJQfB/DLCKG55hP51ZCPpFHYGS5Ayh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738052901; c=relaxed/simple;
	bh=PmJRt6fXmGoAwu59QosLn0Idv1b0404jbmWLyYpzdS8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=E9rjInCiWj/hze45XL3AF4O5NXgACPpMfw1dm5/ymbGbNhiNOzBxIRZoto/nFchv3d8XZgKmXz+fB8CuluEnwP81Iq5uAww8jbbAUQ7LD5FgPsS3WWYX0DrWue9jNVkg1EtsZEcfJeSzQFV1LiG4i1sp3CCG+p/HOBNCDap7RpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bF0Anvl1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GVeJOWPS; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bF0Anvl1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GVeJOWPS"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id C41E52540246;
	Tue, 28 Jan 2025 03:28:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Tue, 28 Jan 2025 03:28:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738052898;
	 x=1738139298; bh=PKAhJl6MulJ8BREkwp1+4UxGCBsYnhbC1wjnWaXA8NQ=; b=
	bF0Anvl19vL/U2CTLxxTO2lILTje6hHJCvLJcH0ed6vwoGeDA1iRTt/BfIIcvbS8
	q+pwjkKaZmL+ufdwNZef/hIzPcAq1WkrDYtGV0wFoeKMoj+uNUNYcO2ALKZVGIX1
	LiCfS04tiw6R6EAFXSJRGGOzStTK4r5UAbGkWw2pVjW7a/mCasC834piOsQm0CHj
	fyHV+sf7JaeTmhGbLNVQBwUEMZTj3S2CVMZs6J3anicfWJ+yeY6/SBXzJnEqtXJV
	gW8XfVsxr0b3UbnUZ1COaXbwgx3whvOGY/fM6/ih4zBkJJxyCNP0wkVjKB5Zw9NX
	4b8TF3XIS0JcvGrAD9dTMA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738052898; x=
	1738139298; bh=PKAhJl6MulJ8BREkwp1+4UxGCBsYnhbC1wjnWaXA8NQ=; b=G
	VeJOWPSpfgQrutbhwOt/Glb8i9Zfj1CvjBmAAFWgcc+bofuEV9A70RJ+Bfs4pVDl
	DhC/PbXoWEqKsR1MDfpvDKxSaj/GWzofI4bzSjLLzvrO/FEjSnqyzfliVCopsXFY
	DYhAoaoPACl/Db6LMAx38KfSaqXNVc6B0j4rgIUsgNOlQTotEBRKMqEx270vFZn5
	GrEJbnk/3dCz0/x7bAPJu9fM0SPXEqEM4DjjUykyhps7LV14COaDscmlP1yFGanb
	RaNoECDR336+pIRmBwcxGfGIPODUjEEKs4SkO9VxxEXXvXAIdm1T0vS1FQrGWX4t
	3iNT/N+FBZAx5HzA5DM4A==
X-ME-Sender: <xms:IpWYZ1a8LoO9AlY43tadduJeiZaK1LMiLAtdfVtghtkoBHPxWB056g>
    <xme:IpWYZ8aQWVNesxRTrmuImEBnLB8EXljEdLI9d9QDo7vcTv4MMAlicg2alVTtngzhs
    R1HA1ZyVbchohdY0Q>
X-ME-Received: <xmr:IpWYZ3_gHBfxCuprKd2Qs157EwRS85mB4MmYiPUuH2ae593XBNhlyMbPzEQMpCQdIeIdqQwV7Q5PdURvODfGQMnETNTEnGpwMEHFvkxXO_c>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgudehiedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlh
    htohgslhgvrhesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:IpWYZzoc9SSd5sb-gV5sQXdjeG7ysNMUid0ianp5UukRaeFa7C31RQ>
    <xmx:IpWYZwrldIG44ACUJuwMrPsR4RZoQqG9_SQNGt0g0LU7V9bkXI6-_Q>
    <xmx:IpWYZ5Qdq3ZnYPuIURAdr51Piz9gEzcACwKoJlBB8uzvYIlGtRcqlA>
    <xmx:IpWYZ4ohfFIMiaeoAZI58yv0gTD0Ihvho-ALsaCn1Tus-jZyvldVHQ>
    <xmx:IpWYZ5mXuJ5Ioi6uNrwtacJSxT5eslKiplRDajegcQNpsx5NSxFeOoOF>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Jan 2025 03:28:17 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 2cc85466 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 28 Jan 2025 08:28:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 28 Jan 2025 09:28:04 +0100
Subject: [PATCH v2 03/20] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250128-pks-reftable-drop-git-compat-util-v2-3-c85c20336317@pks.im>
References: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
In-Reply-To: <20250128-pks-reftable-drop-git-compat-util-v2-0-c85c20336317@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>
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
index bba4a45b98..02972c46f4 100644
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
2.48.1.362.g079036d154.dirty

