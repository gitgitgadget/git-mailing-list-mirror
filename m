Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC782253F0
	for <git@vger.kernel.org>; Thu,  6 Feb 2025 07:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738828345; cv=none; b=kTRx4UEhk+eDMvrpXAAdpcerZoYS3zy+T1lBHOjg2gvPeQZDJj42Z7c5honcAjSUbVvkK8Xa04h7zXtOS65NLFVoIowchlg1kWbMBITrh1p4iGtxRa3E9Ky7JSXOsB4hpfc0ml3hy3ZKcw43MuBtZaqAw18qWRUuV//K+xBmmhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738828345; c=relaxed/simple;
	bh=Lb6B1HNb1RFqbdcwYW/aT4a9hLJ862UJnyNuvrlc2kM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vv642PC+kogIjPts5aYbKb6XLmBQruUePPTB5v+BHe0VAN5d2lUBlnekM1KHySxf4pAqDxVnv7Ecw8mwrDTm0s+BeK7oFud8wJygbcgjet5JvjVPLb1KmNS5z3dY1Shsm8R8BCozqVsc7VUv0QBqUpX+U4vKvU+Lghs0nUa9Xus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=C6dn4rZV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUExny9p; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="C6dn4rZV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUExny9p"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id 7A9D513801F6;
	Thu,  6 Feb 2025 02:52:22 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 06 Feb 2025 02:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738828342;
	 x=1738914742; bh=Hn3nnoVMXPt9SS+UntNoPYSlAzfDwFyx/kqG2hw1lr4=; b=
	C6dn4rZVAnJZVBq0jrW0Vx5Wvuyg/N80ISNrW4sVsqnRHdkZIySLtH3/4k9BLOn1
	hy19iWCal0kkWtquwH6qZItmiZDJAzXIJTZZO+/o0b2GeICk5+uAr3+Id/s+QE9C
	VpcudzkR1kMvrzmYCG1kCg8UKQ/MVtm9uAY9Wo//f8NgRn4OvSHJW9P8nAMwqXQV
	rRnGkf6w+jI3hFrkAB+FGD/Wk1I0i829Z157mNjfzy2O4Q739XlCwFwRj8SKkvGx
	WnxewQ3EoBfScWSS5Lzbg26739dH4lYXyhLR8xvtJXrJ5Qx8r5HsgqRvtmqdMIGL
	2EeZnVGWPK4iWH3h9COKig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738828342; x=
	1738914742; bh=Hn3nnoVMXPt9SS+UntNoPYSlAzfDwFyx/kqG2hw1lr4=; b=C
	UExny9pi00E3qsz9LZh08mdYhk4G/kHyPfz+gjJaUJfREPERhOo8UV8WcmqkVusc
	tCnuLwBmGEoSSAMMlqs1oZ4OpxjK7vOLxhU4lj6yYOMV142RzP+s4cwIIA1uwkMx
	LeG3+gKuYgGLOE4ehgGgZRlgXQyK6lzfqF5pDgBRUTEsYjoX1FKEKcy1NGj4SI0C
	NQ10W00hnSRVwmMojyRCEJ+K8TOfMvYnap0qrByqE28OIq9iwyRu9e8rYH/xkM38
	5V9V9/v2G9XXzGFmTUWjfrX+RgXB3ABpkKXWWg8YuRwUW+30fdRpEVmF20aFKbfn
	IDDxCZg/za8X3FjbSb6xQ==
X-ME-Sender: <xms:NmqkZ_uivlKmZZ2l7-SJVr6L9JLrZpyrLOMwol78PXbvx-eTvVwXuA>
    <xme:NmqkZwcD87Kpw0qMKGvuICzXpFp4z3eFI_6I8TEfzYXt6wRC1iq04LAaIScBjvHlT
    goxmRXUIx7cgyjOAQ>
X-ME-Received: <xmr:NmqkZyzsBFrQgJHDS2Xc_i9u0-rlE6ZJOP_Wt763AkbW4adH8feDyQuS8iOhcEnE1huI7WrLn48LrhEskP2Uci39JDOAbQpw6SZSPb9UcZfC>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvheekfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkedu
    heejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrdhorhhgpdhrtghpthhtoh
    epvghthhhomhhsohhnsegvugifrghrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:NmqkZ-OCu-UpKYOx27E_aYCO_SglW_Fgkn9OSJ0yr5XmhkRmEwuZRQ>
    <xmx:NmqkZ_9w9gcYxnW_shbpSYrTs_vvIGyKMUkkzJYBsUYx8obLdzUugg>
    <xmx:NmqkZ-XSbZuqDC8h0uraP9q7SECltZumWiYSLVu--gqc282Ak6ZWjw>
    <xmx:NmqkZwcb9kzzQ-tniirzkZNtgYh8mpSIiKmS4f67sw_r0TYX8VHs1Q>
    <xmx:NmqkZ6nue5Z4fICQRbxmAtdFh-Az8uBYsTC4fc44AQz2COUZRIvIyWDX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 6 Feb 2025 02:52:21 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 18e7d470 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 6 Feb 2025 07:52:17 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 06 Feb 2025 08:52:05 +0100
Subject: [PATCH v4 03/18] reftable/blocksource: stop using `xmmap()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250206-pks-reftable-drop-git-compat-util-v4-3-603d276d5f95@pks.im>
References: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
In-Reply-To: <20250206-pks-reftable-drop-git-compat-util-v4-0-603d276d5f95@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Johannes Sixt <j6t@kdbg.org>
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
2.48.1.538.gc4cfc42d60.dirty

