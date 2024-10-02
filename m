Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA62F205E22
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866600; cv=none; b=ouJBoFc4bM7Ax+DjBm/LOznJDP2M6c9izbzjjSsLqo7i6DRY/cPIYsYQs4R0LHuOFhR19m9030k2PCofLL6oDlhtQ34loJDsWI/CIkm5+K51FKifrGgfjxsxYcOi9F2l9FYhgfDtz4IFV3hGJAelJsL2MmvFSWMUlQ/lCw5CTAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866600; c=relaxed/simple;
	bh=Aiu0TrPVIDSaLetFCGEd4M5+m2hAbO0TMUeO/vJWATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kl8BAyUmtqmRxU+GgSFX+7zMKkh3Ia4QjgVtADgccvbuAiEjSCTFHnQKAW6RBp0sMKSo0dJCuC3CCsJ5HuzJNKdrMC/L9NW8nBYsSAw5KH9Rx9DquV7ci1Dt6cXNOv1kLlcWQEgjZtgLI3/Nr5/QcqzRMbYmDHndzSz3QPo5U+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oS/yGl5J; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KVPx8gDr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oS/yGl5J";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KVPx8gDr"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F08E61140204;
	Wed,  2 Oct 2024 06:56:37 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Wed, 02 Oct 2024 06:56:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866597; x=1727952997; bh=/eTEYbDW8f
	ZGHJjkwfDGTD6sOrL9RoAUNxDfRjfK1as=; b=oS/yGl5J5GW0l2P5Tr1l3bjXv8
	mGgGQoud27WLr/OGhZ/YV2zU2CwQqhk3RvbGlnbBji/uHObvZ/rLlhFaVVjnGSlE
	8gyJ8Z23E8GSGUyqRb8Wd3lPK4edXihgrphMAWhhJMeT+sIcdvWk2qE4dMSPANhE
	jO8HbkCxs/7rBqVOYsFzTRhZzlEpUT03btzK8AK0u+DUJJB10DMJVrUfKpWARVch
	FdT7DVvc8PT4PTDRYfT9xkVfJrFNPz+kWnmv1lO5Z9jOm4rKMI7Zy/IFnQ93XSTk
	eOaRv8JgkWWo2ahOmhYHQlbb0VeVmuQr88Z4HS5yOSLPhyztz6dS0aefR4cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866597; x=1727952997; bh=/eTEYbDW8fZGHJjkwfDGTD6sOrL9
	RoAUNxDfRjfK1as=; b=KVPx8gDruzsmIS8ACGJIdyvena7guEItV+ExnfwsDuQ7
	CZAc2Gvai5HhOCEcJqjOfr9gmOSml4nliDLeArjspCXXiFHtGQoJ6BTUroSbQ7k6
	LJsm9rYfJF654h6Z2wwpY6wEBN2dFwoD3hWGCg/7imPu4ndqrDRyvs0dAR3sC9yZ
	y8WQGQKseeN7014md5ImQjmJY3Dyv2T0RsdVnOjAYlu5S8wPXuR7gG8WvK4bqUNP
	ux7xPncGM3pSmwW2GBlEmrMnBYh6TO6MtbknVpPL9ioR7ysFN94GKClAxoMfdBO4
	3estF9iMfPzM/jLbx6dUjegbYDGEZSgrQNGliTjwKw==
X-ME-Sender: <xms:5Sb9Zk5Tkf3_qV96fLQmfkJI8viytArJJjxrs5ysircPFt_ytZRKAg>
    <xme:5Sb9Zl6olj9ij2o-pJDp9GhWGpn0PJ2rhQL5nYIrS4-lfQ0rBBRDfEnLxUx3bPk1J
    77DQIot-NwuSAcdLA>
X-ME-Received: <xmr:5Sb9Zjd8ciBFhlhOU9kdpjyqh_pH7-_qpMPoptj5WRQYMONBB2U6DCu7qqpflc2we-ToWrwzFll4g_OKQsmBSMFxwjCe5-1XS8CjC4B-tKvtXNf8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheplhdrshdr
    rhesfigvsgdruggvpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomh
    hsohhnrdgtohhm
X-ME-Proxy: <xmx:5Sb9ZpK57yWWmM0V2Vw6fmlrsZFLZIopF4vKVQ3v-UDiMnxeuxKPqw>
    <xmx:5Sb9ZoLzpnJMN0248pvz--BzBU_QFsvbBfYBYVk9uy_5GD8YvYDslA>
    <xmx:5Sb9ZqwWm4g-NfIEQLhcMRODYwjbGwb5-bKN7zm8-n_DZlHHPQ9wXg>
    <xmx:5Sb9ZsLAlAGKsgSK79ptgp9ntZq1xiij8-42g07mp2war_gHL6VO0A>
    <xmx:5Sb9ZtHl4EY9xV2Wnclvop5jS9RhsHqLM6zcJEfSa_E1G9ef_wnCDpX4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:36 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 42ff9cac (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:46 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:33 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 23/25] reftable: fix calls to free(3P)
Message-ID: <228cc812632d3c310d9b4f02cacc06fe60f6c23c.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

There are a small set of calls to free(3P) in the reftable library. As
the reftable allocators are pluggable we should rather call the reftable
specific function, which is `reftable_free()`.

Convert the code accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c                    | 2 +-
 t/unit-tests/t-reftable-readwrite.c | 4 ++--
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index 7df28ab343..b2babe8e3d 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1421,7 +1421,7 @@ static int stack_compact_range(struct reftable_stack *st,
 		struct lock_file *table_lock = &table_locks[i];
 		char *table_path = get_locked_file_path(table_lock);
 		unlink(table_path);
-		free(table_path);
+		reftable_free(table_path);
 	}
 
 done:
diff --git a/t/unit-tests/t-reftable-readwrite.c b/t/unit-tests/t-reftable-readwrite.c
index bfa069caff..27ce84445e 100644
--- a/t/unit-tests/t-reftable-readwrite.c
+++ b/t/unit-tests/t-reftable-readwrite.c
@@ -76,8 +76,8 @@ static void write_table(char ***names, struct strbuf *buf, int N,
 
 	t_reftable_write_to_buf(buf, refs, N, logs, N, &opts);
 
-	free(refs);
-	free(logs);
+	reftable_free(refs);
+	reftable_free(logs);
 }
 
 static void t_log_buffer_size(void)
-- 
2.47.0.rc0.dirty

