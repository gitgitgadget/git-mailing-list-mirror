Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0231F9423
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 08:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738569829; cv=none; b=FG2z36bmXJIfOu1F6F3Lh35/CiKSqAnT96mk8qdEEq8nziUcosNvZfXRhf8g3bL0sfcl6dXpNCJAVuVm+DDYBju+Z9ASeyAsjduA23Z2JZAXae9XRqjEcKt1v1ATnW7KJgrUnRBNh24GyUW+z2Z/SLiJgOKsUAUdRIIfbNw6Xck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738569829; c=relaxed/simple;
	bh=aw7awK+FeMDBmkVCC68Wm6KnlbHBWmmZknDm0ef6nqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QwSjT8ky8Im4FfHXvIT+OrrNc449ha2AErMcz2YDUGCVfmtrd42tio8XYbywKKdBGGdUEOJAoQisCuiUyDDP2ievBhwWT8QpVyKsIrbiDk7K9O6qKPiJOtGTpae2rtLrRt8+COd+SuYbEo0gMUYZo8chtTCOYIsrFOwMW9GNYp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=N5ncCKd/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Prr/7gMO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="N5ncCKd/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Prr/7gMO"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 207831380848;
	Mon,  3 Feb 2025 03:03:47 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 03 Feb 2025 03:03:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738569827;
	 x=1738656227; bh=X+4hnS75rB3JlUbfmzElGd9YH4Ion0KA6mqd4Ke+ABY=; b=
	N5ncCKd/qsvUQH49zAaIGu6ajLD60cLQ9croEPwekW0YgcIBR6PFK0Yiy0nBpOlK
	65O7bdDQxUfoyuZzsKrHY1iW1esROJsC2qQoJnpSw2Q5WG3OyuGRHo4tD/YUwm9P
	X0IDVTUI1Ju4o2rJ0Ct1mdpQHX6IepaK3o73E+Igq31LXkuqixo9Kym3tcvFOudx
	I4jE4eoOw2OXgkt5by1pZ+isA5sPoAh4CrO0qBFA5Yx1opVNN5G/5vJ2y9YLSxXP
	yuUIDaQH1klrMWSp2rMxYmSeT5aF6RZot0VPt7rpB0DWLNR/Pc7/9d9GWpm+/QJ5
	v18b2/uI7x1NBIm+eR96UA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738569827; x=
	1738656227; bh=X+4hnS75rB3JlUbfmzElGd9YH4Ion0KA6mqd4Ke+ABY=; b=P
	rr/7gMO+UEwDBePyqJzbLs9yioXck3+y1oF6cxhNDZQTZrg6cwzGUweU7NBwo/VY
	KfVStKwdydKSeJT1LQJXeP6fLbbjkjxwk+LUgiANZKTwNxIiOi6GxfLWnYpjqvK1
	nXSialBOfGOTUI21fSl29eDixs3DX9i1xX1XhdumzH0xCV+MYSRoGe4+3XCQg604
	XLwCTV0LenZpo4YnBUd5VwnHx7A1kxtYVK9pQ298bBfor05gSjmwnuFMkNe7ydlV
	Jdua1SDeSp86Kzc/KbeXzj5NCOs/NEn4I5sjRbjNgNgDO4aR5o8jOj8oMmyvNv6a
	nrH/4XEyoB3QJAM2uybig==
X-ME-Sender: <xms:YnigZ4i-_RFe2lBNPy4Hztfh1ubY_-cT5ollDuHICVL8eiXseCDy1Q>
    <xme:YnigZxBsjn8eitKssqimnVD6UW2FFwHC-_NyJwibP5q3oj6twNDTcQtnGb4F1M5fN
    piWxDNfvc5IKWzhAQ>
X-ME-Received: <xmr:YnigZwG72rr04IOyDscibSrXM2M7Sv9e1BKSdfJPiq9jb5rbEwKzHnTFd0Xw51nNKOZHzQg2CLtMo0J9kMA17NLcDq6acaaCDOU5fFT_koBs5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdp
    rhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    htshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:YnigZ5Tx85q0juCzcjDc26V1GpSeCUPQBSvNojJraFXnv8nDJmXOOg>
    <xmx:YnigZ1yYnG0hph8D3i6KwDGJMXPMK7uM9xPu5c4wpCEqp5P8uAYvwQ>
    <xmx:YnigZ34jRhq4bxkrL8k91ptWc_9GOoBLhCmOGNWgoUBrcq39iELbcQ>
    <xmx:YnigZyzihaJk00cXQYdHgV7uXKnpnyltR0w-OWYVoXswfXazjkh20g>
    <xmx:Y3igZ3sKCXRL-PPpdjPAOQBOaAi9pn995ccmhWuX0Iuku0nxrhUtzz-G>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 03:03:45 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 9a89136d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 3 Feb 2025 08:03:44 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 03 Feb 2025 09:03:34 +0100
Subject: [PATCH v3 03/18] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250203-pks-reftable-drop-git-compat-util-v3-3-446c9ed4ee9e@pks.im>
References: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
In-Reply-To: <20250203-pks-reftable-drop-git-compat-util-v3-0-446c9ed4ee9e@pks.im>
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
2.48.1.502.g6dc24dfdaf.dirty

