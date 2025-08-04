Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 682D52405F5
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 08:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754295453; cv=none; b=ECAIb5SLCQ8837ekVZ6gcKn1uynxbjkwa0r0hUNMN/x8WsUxFlKY/MDBSy4Fa0UfN4h8GyIJyqkK4/e0v/z/icLG9kjclXn+yNS0oQxkWHyVqnRezje+OGorvxePLgDC2pidbF3PJ9X9lnbJvPnrIWDXolejpA31kpuJbqztJSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754295453; c=relaxed/simple;
	bh=SkM4s2mnb9+rt4nNSYIpVwg7J4trBU73l0sOxhUi4ck=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oFCCaph61YZZyt6XA1UPd//ICJsHdObkWM/b03fLRJqbCHmZstbo/+BdmNjD5yHGTYmcqW2THF/WF673gK6HkyCAxA8x7j/FPAOysYEkhpB8mRVhOH7+jzaFAxaS+/h08eUtaAxRSkcJ07vErZG1jzh43Om+OYaGAjwwGcFAYUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=g1WvYsiT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gPHoIknS; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="g1WvYsiT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gPHoIknS"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 9D1931D00134
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 04:17:31 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 04 Aug 2025 04:17:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754295451;
	 x=1754381851; bh=mYJVwv3OdnVZFPKzfLU4J59x2OC4h9pAfVO+eOe296k=; b=
	g1WvYsiT6NHp2ooDOJDkZk4Y23q+nVBwJg4ApWxTReZMSHvPe/L0s8/i/7v72d+c
	wbDWWbFKyfN6LGnMtGUN4K7D4h+6yzKLNLkosUfN82cREV3vL+GoK9q2EuKIobSb
	yS7oAXf2s22cTYe2T/ZBStZoExsUPIhCuwF2eammE9v+sclWa8Rtdl46o9oNyXu3
	pRPFlRN0xaJJWIfC2EMr+H1SV7duLNkwbUs9CRXl1c87cMnqSxhDHOSf97HU6Say
	dsdPCTlIFLxJ+3vS67nSCiYsiH9CAIoN5oorVut6gJoBD+k9lvHmfGu2UrY2i0JX
	Ttq9popST+CaUiXzjM93dw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754295451; x=
	1754381851; bh=mYJVwv3OdnVZFPKzfLU4J59x2OC4h9pAfVO+eOe296k=; b=g
	PHoIknShWB/cm9eQ+ObOAa7+GnD69eBQB2mZ6Sel7ZCDYS/b5wy4ZMELXSE+0dqP
	T5j53GjyVPHf1JuXgvP7juzBQTflKjiOW9BSV74h16PwfB2Maq371QXnCh5AhOSO
	Wl1KqbfkiMgnJhc2KhdikRRb1W4+1fFl5GepSusbJoTVA5R5P25aaNpSSL4FIvRv
	Wd8kzVXnjLUBqdI+Zhjb/BsJE7RkAuzoJOlz03W6gRG0Z0MdtdDuwg0HtjzU7Fz7
	k0IJDwGhJ86deJykcA42ENoEdGhwpRYPY2L27Br1MsEJQAYXgOAF1pRugVWvyWje
	ICEamqWRap4S2AAImtnCw==
X-ME-Sender: <xms:m2yQaEZcfcVcnbph3X7qPgGlev8MkSjoG0Pk9uejev-08V3_wEMmaQ>
    <xme:m2yQaBaZ8fe44O9trfC3XCqNI4vbJmm8Xy_vjBi-zSVKAO_uaPbCfzg79HOAU8czl
    l1GxVhTFugLe1ACsA>
X-ME-Received: <xmr:m2yQaIVzJT67GGQ9nePw8NroYzcXpjgegqg21QDTgcPK8WsRecza1WILoRrklPWLWCPPuhRwcJ3nFKbX9TeMIECRkaHDKPM9ooilP5-B3dI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduuddujeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhfffugggtgffkfhgjvfevofesthejre
    dtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehp
    khhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeule
    etkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghr
    rghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepuddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrgh
X-ME-Proxy: <xmx:m2yQaA2jfJGS-RuHf0ZueGZOBOOcu77FpsSqChOhA8FSyzySkM-b-A>
    <xmx:m2yQaHYHNkTWxlaNaXtGoX2_hr0u2I1nSrxHshS3MH8wY6PIqWiFBw>
    <xmx:m2yQaLo6fNm2pJzFZG7M2fZby13GQ4RmA4C6q1c740SOmYcs-zOcvw>
    <xmx:m2yQaLq8s36YTC2gfOOomYLDFsMjHCCX9RI9NYnqYlrvuuAMzltx5Q>
    <xmx:m2yQaDyl-n09QOsVRufEwZHc1sF2S7Zg0322VimxB7oHY2pLxuL-UfRn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 4 Aug 2025 04:17:30 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f328ce11 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Mon, 4 Aug 2025 08:17:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 10:17:19 +0200
Subject: [PATCH 3/9] commit-graph: fix type for some write options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-b4-pks-commit-graph-wo-the-repository-v1-3-850d626eb2e8@pks.im>
References: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
In-Reply-To: <20250804-b4-pks-commit-graph-wo-the-repository-v1-0-850d626eb2e8@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The options "max-commits" and "size-multiple" are both supposed to be
positive integers and are documented as such, but we use a signed
integer field to store them. This causes sign comparison warnings in
`split_graph_merge_strategy()` because we end up comparing the option
values with the observed number of commits.

Fix the issue by converting the fields to be unsigned and convert the
options to use `OPT_UNSIGNED()` accordingly. This macro has only been
introduced recently, which might explain why the option values were
signed in the first place.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/commit-graph.c | 4 ++--
 commit-graph.c         | 5 ++---
 commit-graph.h         | 4 ++--
 3 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/builtin/commit-graph.c b/builtin/commit-graph.c
index 25018a0b9d..145802afb7 100644
--- a/builtin/commit-graph.c
+++ b/builtin/commit-graph.c
@@ -241,9 +241,9 @@ static int graph_write(int argc, const char **argv, const char *prefix,
 			N_("allow writing an incremental commit-graph file"),
 			PARSE_OPT_OPTARG | PARSE_OPT_NONEG,
 			write_option_parse_split),
-		OPT_INTEGER(0, "max-commits", &write_opts.max_commits,
+		OPT_UNSIGNED(0, "max-commits", &write_opts.max_commits,
 			N_("maximum number of commits in a non-base split commit-graph")),
-		OPT_INTEGER(0, "size-multiple", &write_opts.size_multiple,
+		OPT_UNSIGNED(0, "size-multiple", &write_opts.size_multiple,
 			N_("maximum ratio between two levels of a split commit-graph")),
 		OPT_EXPIRY_DATE(0, "expire-time", &write_opts.expire_time,
 			N_("only expire files older than a given date-time")),
diff --git a/commit-graph.c b/commit-graph.c
index a7a1a761bc..ad3f084dd4 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2235,9 +2235,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	uint32_t num_commits;
 	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 	uint32_t i;
-
-	int max_commits = 0;
-	int size_mult = 2;
+	size_t max_commits = 0;
+	size_t size_mult = 2;
 
 	if (ctx->opts) {
 		max_commits = ctx->opts->max_commits;
diff --git a/commit-graph.h b/commit-graph.h
index 78ab7b875b..b71cb55697 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -160,8 +160,8 @@ enum commit_graph_split_flags {
 };
 
 struct commit_graph_opts {
-	int size_multiple;
-	int max_commits;
+	size_t size_multiple;
+	size_t max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags split_flags;
 	int max_new_filters;

-- 
2.50.1.723.g3e08bea96f.dirty

