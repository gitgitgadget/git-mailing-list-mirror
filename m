Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFF31A08B5
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775780; cv=none; b=NJQMznemSOqCXXx68q21DyBDfJgxmzycenguC50fch8JYceCi/emnRIPeqtU7kwjLBxvfr05c4k0cYFhMXd/tmaqId4RM7nxYwtenk8/+VrXF/S3eW7WLluBrpJRpru4hmvt1O+KPPr7SZpCKvZtYgNGy+6JF9J4rFnq6PuZ2Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775780; c=relaxed/simple;
	bh=Aiu0TrPVIDSaLetFCGEd4M5+m2hAbO0TMUeO/vJWATk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u5MyH4PnwXe6J7jV5odRU7a9GLQakZ3kqoWkiOQ5Rp2Yi2xHQrK5u1MsWs6AeJ2lcN1znI/aukgC2xjfMm/yW4JjkrcnspMVo2J2TJ5zTgMOggC2KScpdkGu+NcgLqpTwH0kpaiAdfg1ar9fzGw5C6CQ0vzD7qEHSjqIjHUgUhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mp6Bvr2N; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jbnZBWbr; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mp6Bvr2N";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jbnZBWbr"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id EA44C1141249;
	Tue,  1 Oct 2024 05:42:58 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 01 Oct 2024 05:42:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775778; x=1727862178; bh=/eTEYbDW8f
	ZGHJjkwfDGTD6sOrL9RoAUNxDfRjfK1as=; b=Mp6Bvr2N1qwfnNXDWjkRj47s/L
	bOt8gGNzTs4LP1dFxlOiKM3aHnLHBgHozqh88kyow1WgZNHC1VCmnslV3XA7NxGl
	PgppMSxoqRX4YcihNxu0D2XvVMIsky2pvcTeReiiF+r6CenKuCDQtXSXN0NmPSu8
	CqKUqKeL6p8frludnCV0l1mYup3FUDw5jw35rCZ36AWbVkdaGi7VLhrz41Op1hHr
	GLccIiKomqY8PDhXfVmpFbqvjlIAEwN+vdEjhko/ClmqrX9p+kgDAC0ijFBE/+ko
	SinkmVoE7B48URKhuYreT4UUyA0aYt6V1SchMWZeVxQp2Fs1qxLynVkoELuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775778; x=1727862178; bh=/eTEYbDW8fZGHJjkwfDGTD6sOrL9
	RoAUNxDfRjfK1as=; b=jbnZBWbr0G1NLdeaMsgOBdt95G6Dec8urb9+YJFVP+k6
	HQEGJoXHsj5DCH4jFff8lNPQZdVuTzOVfvoyfYD+TwJbuq5qD4SBGymsKqpfKH/c
	wpAmSUlAZsjr+QwrGLWWGkhXvQVSP4Cma3+ELoNXRyE2gblLs07KerFhfJtDa8ac
	/XEuaOLPEJx1kCS/njIoW1z6niK9KGZudKuYArL8JRhnrIwKXHkMccq8zGZ7qmVs
	aOwlXKc0wZoqORZ362jeSSAurXpX9jl25fOAp7W3NSkra0RE0qxKDDxWNQGa/5ey
	VmEPxIx435Tj8m46a67MR2w2EL6wi4jqSFyfgUf6jQ==
X-ME-Sender: <xms:IsT7ZqgwvqsJRLZ6M8AL-2PGya_71NOaHqkyeUiOmYimgu3y8Krusg>
    <xme:IsT7ZrDDh9LcezWOc0ozmNzkkDIqdQw3Jxg94f52FCjLApIiVd4XDh_QpJGkCiiaj
    CLs16BtEHuiZtGsYQ>
X-ME-Received: <xmr:IsT7ZiHKPpu4Bum1glFdBQDi82nsh9f15PYOhVUTx8UQ7O50WdTV1Cntg0Z6SpV5_uS7jJ1C9IMsUvqPMCcfGmUPMImpOtqXHhFWv_pRzcXUog>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrghrughthhhomhhsoh
    hnrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:IsT7ZjQipbwUPOw-zPn9RUHTgSjlqlTFBGnGBgEPWXFJxcBHjHlczw>
    <xmx:IsT7ZnwMPouo7lxNNpzLuS8vMkQ2xJfDcRfrlWAUS4K9J4Xw7kWYEA>
    <xmx:IsT7Zh5V2ZOrr0HPrEHoUgQxs3j2ZHNfakttmuzL6sEZMqL0ysUdHA>
    <xmx:IsT7ZkzDRyQV0VVciceOryoP9hToP0P6fEQFJWlXEw1MZ_rvQsRVmg>
    <xmx:IsT7ZpvveQJd9TUER2r6XHpzPlEj9qPlCmSGHPVV4jZUKIV5YJrNc3s6>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:57 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3793b05e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:42:10 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:55 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 23/25] reftable: fix calls to free(3P)
Message-ID: <228cc812632d3c310d9b4f02cacc06fe60f6c23c.1727774935.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727774935.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727774935.git.ps@pks.im>

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

