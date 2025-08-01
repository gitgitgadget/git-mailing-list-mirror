Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3889726FA60
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 14:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754059684; cv=none; b=LpF+zhIYrI2hYfJCqm2s5Ou44LnD31vDQKuUh6StigXlNXGmUgQkXPoctNOYA/74dEPAl73qhL3bh6DEiOYeSvpdxv40nZTh5ysHsho2rlMJlNIjRrez0JjJKgD7IPnYK28R0QPd8aXFmWPh2cnflmhtuu7frvnNuHOl30NU6+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754059684; c=relaxed/simple;
	bh=LXM0jqDn+7ATNoMNFekslFZ5Eg9wyDqHzV06exBoKUs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=meTc+Kf4XwFZWyYZW+YnGq5J8n16/4Tp5Di3rh/UCaZiffHSrW9EuwdAcHcCXgXj/Mo31YJIUryT3G1Zmn9n9IwoMHnjXKFDnQBcMLqaUYTUIDssmx5+OpV87nrRMG7DpmBqNIUFRoShhavXDuLQh6xB8apGm5MKrlZwyJolEAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=EwUgDTa9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iA2BlWTi; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="EwUgDTa9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iA2BlWTi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 61E521D004EA
	for <git@vger.kernel.org>; Fri,  1 Aug 2025 10:48:02 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Fri, 01 Aug 2025 10:48:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754059682;
	 x=1754146082; bh=zAMhaNDGnr6soQhLQcUtkZBrITGQbtPJyRO3KV+DVEQ=; b=
	EwUgDTa9r8C7cizbRU57kHRtoi/vOEtI0gt05l/XeaNrpSdYYoCqE19qfvN37Rpi
	wF70uE2Z2pivQWXfpaoW4j426vMiJxTPeUPnKUZcH8hCt4FwuM/sR/E4q3oIwozC
	3Z5nfvVVr+MQsd/LvBBKdkxiAyG+VxCBe3kHGFMaP7GtEOGOaCfRi7keU+WO0edG
	sRRGCft+0LrjK5e6TVpLQz8iKcwVk0JpdtsaMgjuMG+A2IfC69fwsl/sohpQiLSr
	hU/DBcUA/sJzSRNY1Yen2AGfIVdyYvkpLMmdsewxFA++GDML4Hz7pIkBFv7GwCRF
	8fAzMucEuP+AThDYj+jpjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754059682; x=
	1754146082; bh=zAMhaNDGnr6soQhLQcUtkZBrITGQbtPJyRO3KV+DVEQ=; b=i
	A2BlWTi5UCME0MRHQ612wYuxYo7+74t3qt8VYyNN1bdUK57yekITdWvNs/+02fbJ
	je2KcyaOLd8LzlpdjLV62I2Ox0UxbP61qwgVI8SSHQzKn92qG/B4BoehLO7RE+fS
	mLm/6r+ecnCTAV25c0QdjCtp6wVJLzrFLxPD0sWEBVpH+Q06zoB8L8q4TJx5YnvF
	56spP/2PJZtJ+M+enczRo1bod49DhTLAxN9Mqa1hHwP/jWLVgYf5c0xnuOedAo0t
	QBqofBGIKVF/ilKLk7bB7z6CDobxA0G2wyAVYMfKVP90wrwUaFghKASJfyEzjPSM
	R5ChlURi3GPurrESfpKLQ==
X-ME-Sender: <xms:odOMaAW2lHKog92rp09OI5Cws1-aGOXapFuPjlQqfvApvkxivWMblg>
    <xme:odOMaGlpmAOJPSBakzXXnDvCQKTLay6xAZE5ICaVSJC-I5BchDbsM3lUadffLxqLB
    dwUSS_3bZ3DHGjQIQ>
X-ME-Received: <xmr:odOMaNy42hlVAYSZQDlykcvoUNZj6CGyDOQYmyshPm2f-FpBGFdUlJyHBFm9EX2zIkpAGp8ziVHZtJAIML3FpNQMKVzcgqkPWv3pEgmJDx7x>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddutdefleejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:otOMaBhTK1gAhbkWaRW0RIK6ZJ8qu1Aph6s1QHMTAnabo2o0dGhXAQ>
    <xmx:otOMaCXe5KJBApuUy1IY7bsbeaArypPE4KnSV7sgZuB6sy6Fgcm31A>
    <xmx:otOMaD3dIuqLZgGxpr-CyQvlL3km9LPl3XXipSyFkbMwajBDp-hf3g>
    <xmx:otOMaIGgbLZ3GJamWlfr1mzkoHWgZHWlBiibY_IFtcQP_kY1MqR1VA>
    <xmx:otOMaAdusTJUbhMPyHE-Fw_0YnaorO4sdhuGGJwJRhXvhoK3DP03DQr5>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Fri, 1 Aug 2025 10:48:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ad6ef066 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Fri, 1 Aug 2025 14:48:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 01 Aug 2025 16:47:48 +0200
Subject: [PATCH 2/5] reftable/writer: drop Git-specific `QSORT()` macro
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250801-pks-reftable-fixes-for-libgit2-v1-2-f446e1c33cb9@pks.im>
References: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
In-Reply-To: <20250801-pks-reftable-fixes-for-libgit2-v1-0-f446e1c33cb9@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The reftable writer accidentally uses the Git-specific `QSORT()` macro.
This macro removes the need for the caller to provide the element size,
but other than that it's mostly equivalent to `qsort()`.

Replace the macro accordingly to make the library usable outside of Git.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/writer.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/reftable/writer.c b/reftable/writer.c
index 5bad130c7e..0133b64975 100644
--- a/reftable/writer.c
+++ b/reftable/writer.c
@@ -399,7 +399,8 @@ int reftable_writer_add_refs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(refs, n, reftable_ref_record_compare_name);
+	if (n)
+		qsort(refs, n, sizeof(*refs), reftable_ref_record_compare_name);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_ref(w, &refs[i]);
@@ -491,7 +492,8 @@ int reftable_writer_add_logs(struct reftable_writer *w,
 {
 	int err = 0;
 
-	QSORT(logs, n, reftable_log_record_compare_key);
+	if (n)
+		qsort(logs, n, sizeof(*logs), reftable_log_record_compare_key);
 
 	for (size_t i = 0; err == 0 && i < n; i++)
 		err = reftable_writer_add_log(w, &logs[i]);

-- 
2.50.1

