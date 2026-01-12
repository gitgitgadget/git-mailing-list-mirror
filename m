Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 207D1346E61
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 09:03:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768208591; cv=none; b=qWc+WYlFl7VbxeUdt1g/UnPP/Rj2nfuPKo4g8OTMLFRPIjdvtyuf/k/CqRegdMRDq15qoPwvn8Hg1L6HW0jvCsClk5XICoWVQDj13tignGTFk4N4sb8tIz8MQ7fXfNoZMW37BTHsyIzO5l3F+8JlHv8yBU7aQ/u2tTuRdDGxw/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768208591; c=relaxed/simple;
	bh=2C2sKD+JIiwYkFhITAsZWOGLWp5+aJZ+ExKNBBCw5Gs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=MHyB+HqN9ue5k0ngN+q6ku1Y9idCBZzvBCcx1fIOVoWkjHP3LtHoxbXw9J6sUaKcBf/VPAdrcdNQXrG39jmdlGKqA5OEeNduGc9ausisAcMKH9vXUOdIiU/vIgb2eps4ENeD8+g1XNor9nvFYuNfpKVMqr4IBeLzKJZJDbU1l0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ASAL7u9S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=SgMBjJ94; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ASAL7u9S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="SgMBjJ94"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 439F07A00B2;
	Mon, 12 Jan 2026 04:03:06 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 12 Jan 2026 04:03:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768208586;
	 x=1768294986; bh=c+c9HlnxIQHsc1edUmsSgJMm9id/kBLf2yMjqohXU34=; b=
	ASAL7u9SIbXXilr2lmqLQViDhGoK7ehWHx1klJ+9dMyQvsLC27VzLSC0ZMrPZgct
	FBaM0YkCrsSHLxfSPoRsECbFCXTZBp5cz3W83PpvNgDB5sKMk1K9PeHs/ywsrPba
	NF7AYU9XiOa8GpnumJ7O9925enGDdT3kl8B9MA68DbKP7pO9RkE3GnBzB2PQAxvX
	OdEfpL7BiHE8v3pWl8foOxCWk/YiGE5URGLqEs+XnS6VlmXE4IbdoiIu34EEMojj
	jn7noVwEmq4+evMgPezQCByJ3NaDEfqWZmGplfhBu+XWVtFfo4THOvkS9ltm5Y07
	oLE70O5PjYWBnq3OUzv75w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768208586; x=
	1768294986; bh=c+c9HlnxIQHsc1edUmsSgJMm9id/kBLf2yMjqohXU34=; b=S
	gMBjJ949+6Co9bOtrt2Eo+nJaAQJSY2OxlWr65+heWv3Ue4XgxjNFa8o3MmoCooO
	l0LfCMcwsy0FezSb57cQFz7mADfze+CGwLz7IXN8BNvxRBHMPuoIdgMYfj/b1VKS
	Yju2tmZP6P/bYqD9Cjc08R5XXlS2eBWPSjsFzUTjBBWNifbusR6e9Eq1B9lHZzCi
	POIXPFNm0xBOmm3imXiC7SqV3UhtPVVhe/xfcwPy8z56HCZSMcXQuXNUdJLPKv7B
	FN0fJkOykBf3aZJSP4AjsM2pgz1zRyiMh4s5Z0aqaYnyzWGTfiJU/ePZQp8pPvMs
	m6P44Q5pmj1t0dxtrUB7w==
X-ME-Sender: <xms:yrhkaUsDIHXf1x5QrXXnz1SXDk49kJ3IOmWkuQWyxprUEivbUPqvOg>
    <xme:yrhkaY7AjGYTiBFqub1V0_KPelKEWkZ5p9fR1QGfRCgQG_vO0k2lFybuk7mezR9oB
    HpE4XObQ1IXkuBLYcyD-YCr5vKqti_v_sX2i5r2su9incn_OcYbeQ>
X-ME-Received: <xmr:yrhkadKYU_qiCveWIie-uHLQkDo2zpS_gQiuNH6YRmhb-EVbd2niLFTfhxp7XAuoaPjUea_JlorOgzMeP9ysRN1I6-pJOr5j-1xt8bqi4w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejtdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthh
    hikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhg
X-ME-Proxy: <xmx:yrhkaQ5BR5d8LJGkHbycbFSKuRNFHPyJ1mtozubPu_wBluXwxyeJJQ>
    <xmx:yrhkaYzCEvVWuwqTOVcW_ZNQ1ZAkaTQh46UpLF2CiDUqeVqB7rT4kg>
    <xmx:yrhkacYeaP-ZRh_cY61rCJMEJcH1RGK3elyK0QpJEOWZlO42hM3Ijw>
    <xmx:yrhkaSQIVssIEEvWJeCblKzAt_efjNqohKyWCFB2Rva-uYQWY0VN7w>
    <xmx:yrhkabVxCWReBTIQVW3GcT693aFsDvOpOYblfVmJ8QfR0itPKD5CMmsS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 04:03:05 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 262ec0b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 09:03:05 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 10:02:53 +0100
Subject: [PATCH v2 04/17] refs/files: remove useless indirection
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-pks-refs-verify-fixes-v2-4-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>
To: git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The function `files_fsck_refs()` only has a single callsite and forwards
all of its arguments as-is, so it's basically a useless indirection.
Inline the function call.

While at it, also remove the bitwise or that we have for return values.
We don't really want to or them at all, but rather just want to return
an error in case either of the functions has failed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 refs/files-backend.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 0a104c7bf6..4cbee23dad 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -3954,22 +3954,20 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
 	return ret;
 }
 
-static int files_fsck_refs(struct ref_store *ref_store,
-			   struct fsck_options *o,
-			   struct worktree *wt)
-{
-	return files_fsck_refs_dir(ref_store, o, wt);
-}
-
 static int files_fsck(struct ref_store *ref_store,
 		      struct fsck_options *o,
 		      struct worktree *wt)
 {
 	struct files_ref_store *refs =
 		files_downcast(ref_store, REF_STORE_READ, "fsck");
+	int ret = 0;
 
-	return files_fsck_refs(ref_store, o, wt) |
-	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
+	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
+		ret = -1;
+	if (refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) < 0)
+		ret = -1;
+
+	return ret;
 }
 
 struct ref_storage_be refs_be_files = {

-- 
2.52.0.590.g1f87b77810.dirty

