Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6880829ACD7
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 06:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770879593; cv=none; b=e75EhTlM3SZjetfVWXRyAXxrquFPXmpUmW2NBjnvvuI2yN71iFTEYe0DRVdhpI7xnaU2Hp/1dpIfZBAD6Ajy2OF68my7ZTiMYoNUwh6kMwIKsk9XxS0jJG9Qbm2Jzts7ZvrDmtR4CW3byvUtMW85HC+JPDqaGnXIzjp4D2f2y5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770879593; c=relaxed/simple;
	bh=ezMgcYVAqml2StU0k4fQ2sLwCJw3slnuL2+sMuGVMsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnlPUnIqc3HacJYQvzTQf+gGFWHsKRvkIVI+kz+Ij3bvJVjV7j+hmB/kLy77Kr49YJq2SzJr2lnvcy6RTQXy2VqZb9r2BPrK2Nz1zE1gq9Ui3L3EL67NeJksnU6mnQkGn5XGgB1pzzYgeqoxpPXw+PwlHWBhfnxSw8EkAOBa7BE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=AL4EDyyj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pRYFLC1h; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="AL4EDyyj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pRYFLC1h"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 83968EC05C0
	for <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:51 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 12 Feb 2026 01:59:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770879591;
	 x=1770965991; bh=ZK+FWtZfe6SlxX/Q4UEmoQ1Or1J6xrm/DG4JOTkluE8=; b=
	AL4EDyyjVnTO19o9h/VuLNlHA0/11aYwKurnHQD2K/mFTHo9F2ZPuXlZKvV6JOXf
	JhEDyYyoxA29wHNiY/c7mM8JxOSKkrCCUC8pjnzWS4Mxo2P087Kwyu9W0CTmnfNy
	mpy8i6zlEL9wMgtG4dmah3rabFfSzw2ENLhHQ/qBmMDqvnFoP1/suwyDbbwNuLJ2
	MOZn/7qiBFUzHEJHEu6iVi7E3YqX3CAb1Sn03hcbnOGMlo2B83SAI5aee+yTwKda
	1zXGN3cp7ZgNv3Rmkokm1iCEm/L/i2Wwf6qp68wEtub58gLZAgZx3D/+2GOLw6hu
	k3cabZKA2pZbG68+J7bBSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770879591; x=
	1770965991; bh=ZK+FWtZfe6SlxX/Q4UEmoQ1Or1J6xrm/DG4JOTkluE8=; b=p
	RYFLC1hWbhvY06nGyGtCcH9EYfHSA1ctCZPYbyI8Jiy+lgKTWm2Kkvv9DD/LK+if
	JPEk62U1QXICCvKVFyGP3GTLLde6lvXw+GybjV1LhdgbJqNwg+x7SAKeSAtqhQ47
	PhT1a/Htad8ZMzI32SgOoVXwzmai5cC5PIUf/2+Q0d69sYfpZjfU/iyeeeG3w5aY
	9ttgT49pFDdjxI0BWSq8rl5v6gKIdzh0jQzQne4rKiC9MtcmirzcRw1V6HQGHs/N
	ExFWfGEHpOcdmUzNqCOTzBC0H5PNVyUDpiJ7nKxXHhgLL1lawi2PZjBqR5kUk//Z
	WTf3wCjSnysb2U0PsbsAg==
X-ME-Sender: <xms:Z3qNaa9mYJy9-HVuPjYw8Xr74cgvuZbLfDWh0ObLdaBaE4k3hjZr-g>
    <xme:Z3qNaRoHQUOp9SOArxIE6zIXDveNiKXTAmC4heLOahd4g7CFcbE5gQ1LnZeh373Et
    FYnxE4PX3C7LYOwLMSAIBeMSGkMQ8T-r0w_LSswP5LZjzPJcdM7bA>
X-ME-Received: <xmr:Z3qNaVrNK6PVygLqpoXw_DnhgqDXyj3GlAVkvWfsJb5wLnY-ZEL-D24AFFcq-WAUh8TZoKBJ2zjw8YGOLMDsrwbfQamX8m8OH9GdPybz3WE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdegjeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:Z3qNaXnMkpfput9NCPFtQ-93XlfQtjjlQ-q3eB2fxK_-uVAmnmRMRQ>
    <xmx:Z3qNafG65nvWfK6mZnLwSrCyNv2-B80kLbXnem2PqXpu3L7Dt7H_NQ>
    <xmx:Z3qNaYoLCSOMA8SOFEdTM2hWMefDk7XNulSp3jduHLv72Qah8JV11g>
    <xmx:Z3qNaT7vbmmKrF8QmYuAfzF4ayDSjYObZZEcW2yp5wv7doVYeJwNjw>
    <xmx:Z3qNaSsspwplNEo0uO6gAtefu4ZSYqG5Ypz63kKYrKmx9VSpeJM8_fF6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 12 Feb 2026 01:59:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 87059fde (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 12 Feb 2026 06:59:50 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 12 Feb 2026 07:59:37 +0100
Subject: [PATCH v2 1/5] builtin/backfill: fix flags passed to
 `odb_has_object()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-b4-pks-read-object-info-flags-v2-1-3bfa9bb149ef@pks.im>
References: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
In-Reply-To: <20260212-b4-pks-read-object-info-flags-v2-0-3bfa9bb149ef@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.3

The function `fill_missing_blobs()` receives an array of object IDs and
verifies for each of them whether the corresponding object exists. If it
doesn't exist, we add it to a set of objects and then batch-fetch all of
the objects at once.

The check for whether or not we already have the object is broken
though: we pass `OBJECT_INFO_FOR_PREFETCH`, but `odb_has_object()`
expects us to pass `HAS_OBJECT_*` flags. The flag expands to:

  - `OBJECT_INFO_QUICK`, which asks the object database to not reprepare
    in case the object wasn't found. This makes sense, as we'd otherwise
    reprepare the object database as many times as we have missing
    objects.

  - `OBJECT_INFO_SKIP_FETCH_OBJECT`, which asks the object database to
    not fetch the object in case it's missing. Again, this makes sense,
    as we want to batch-fetch the objects.

This shows that we indeed want the equivalent of this flag, but of
course represented as `HAS_OBJECT_*` flags.

Luckily, the code is already working correctly. The `OBJECT_INFO` flag
expands to `(1 << 3) | (1 << 4)`, none of which are valid `HAS_OBJECT`
flags. And if no flags are passed, `odb_has_object()` ends up calling
`odb_read_object_info_extended()` with exactly the above two flags that
we wanted to set in the first place.

Of course, this is pure luck, and this can break any moment. So let's
fix this and correct the code to not pass any flags at all.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/backfill.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/builtin/backfill.c b/builtin/backfill.c
index e80fc1b694..d8cb3b0eba 100644
--- a/builtin/backfill.c
+++ b/builtin/backfill.c
@@ -67,8 +67,7 @@ static int fill_missing_blobs(const char *path UNUSED,
 		return 0;
 
 	for (size_t i = 0; i < list->nr; i++) {
-		if (!odb_has_object(ctx->repo->objects, &list->oid[i],
-				    OBJECT_INFO_FOR_PREFETCH))
+		if (!odb_has_object(ctx->repo->objects, &list->oid[i], 0))
 			oid_array_append(&ctx->current_batch, &list->oid[i]);
 	}
 

-- 
2.53.0.295.g64333814d3.dirty

