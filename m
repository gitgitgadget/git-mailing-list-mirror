Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2D43242D6E
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 08:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754553901; cv=none; b=XRQNx+rx233FSz4TesPJ1k3giYbuU04LmkOasUdvW4dQx4YtoCqwTbJS+2GYwaIbtzJy1OFaWmgCFM1v/eAWjAXkUlt4E+kYkr0bOzfTjiyd9tLWLDMKJFmSDnxL7bQm3fVjqro3z7JFra4RNJkVsNoNlokSfLwTNgVbW8T4LFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754553901; c=relaxed/simple;
	bh=x7kyJx8vasTwyeW4Jns0Zz54KEwbp42wwRzh6L4dEv8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PH8Bk98Mw7M9HLLeVg0ROOxjIj6Vnua0KXzTCAMr4pDsw8S6WCuplDQXsR2Yp/3om75X2VnZ+vamEdWF5ZgcOYzE1kiR6XOk7muQyceuxU3H7XcE39yQvH8VuRbnQsi0D/bxdsSZekDaCU7QBFVOG0xvryTYkOp/uyWtTTb+IMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YAKqFdKU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TACuVNyg; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YAKqFdKU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TACuVNyg"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3D49814000BA;
	Thu,  7 Aug 2025 04:04:59 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-08.internal (MEProxy); Thu, 07 Aug 2025 04:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754553899;
	 x=1754640299; bh=TGPHApPU0qOS4YRPyw4o3qsM2LLSBEZ14+P4LBU2oQw=; b=
	YAKqFdKUqRlW8I2kKaki/G+OzN4TI8enTpLqUfZndjx/XjNz8Sq7UVdiONvIHpuN
	3Q3H9kOL0QJVHctEypt3tdFZgIC9oflbLYksKg7a0zG8Kpi8PI+Eb45apOUsGSbZ
	n3oD9qpKJE1ZiIPaDhmbi0cgwNLJYdOw/TAvbVoD3OLHj89JgbA4pE/kjgFKmL6x
	mpWU1egLCpHJloSi4bWcX8wETh7vBtNV4LbI0fmSQfUa0ODUtaMa8lFQcRT1TXmP
	AnXVZY2QBaiUzThMbRKs2jqPiwKEQ+h0yN6o0egmaHq9SSylHNz1KrVV4lJD3Y4F
	BdM5aw5M7yY5+xMnXTKKkw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754553899; x=
	1754640299; bh=TGPHApPU0qOS4YRPyw4o3qsM2LLSBEZ14+P4LBU2oQw=; b=T
	ACuVNyg3Bt4Aw6MZLsimCTNBO5eRuWiX/wEwOByR/0L3KpqX+qYbUpZYLFG7gyNV
	osfV3A+bPgJLtm6mMIbxwzIMUUBHHigV2piiM0Uc7kFnL3DXiinpHFEhM7B5Ha3g
	KscZaCVmgE3PLKIjAqVEp2ygzXUEIO78f4hwfxGJSBzCF/LjKUms308KDy9WyNmG
	rhRflxl0/x6KStr6dQ7NQGIXix3puXdTokzgrgtnqW8H/E2KwEMs5fOh9BpA6mbU
	zaxTYkFou+edZsjaYIc85/q0OhilytPdcjnmTLSMqE7blISovGEdm9wCkEFmUimu
	vgyNC04gbtWxXVkw952hA==
X-ME-Sender: <xms:Kl6UaJ0EcSfm9hHghwIEClc2_DsoikwTmz2XfhD4EM74I_uT1ibN8Q>
    <xme:Kl6UaLmXEl85GNxofYD3RZ0lt0YKqAeZRs0d4aj-QVZo21WGYeyHQQKjcujOay9N_
    3TMRhpHKVPkhfX9hw>
X-ME-Received: <xmr:Kl6UaAX6ZwFoT54MzYSVtHlzaJiE3dsdHvO0kCNpEG-2n-Ii55QoGboCoM1xUNyol_zlBylooKWT0s5l1m_sPfK-V0n4FFr44t2tKVAlUw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduvddtgedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtthhopehmvgesthhtrgihlh
    horhhrrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgrghgvnhesghhmgidruggvpdhrtg
    hpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:K16UaBuvlws-ZQ5yfpl2i13X6NT0-8NNM1Yyuqzs6quEhB3HG8dNpg>
    <xmx:K16UaDYqyBHLvvd055t5Vk8FrUrbS5Ng38-mLlli6d2F52MkhCyTxw>
    <xmx:K16UaAXFJ3yJ-kFIE1k6kjBAJJ1EsxHZfNFHw-OYTRRX8O6zzofl9Q>
    <xmx:K16UaISi_oVv_PAXqtbW_Py6TwHRVuvvc-HO8occuogspofp-l2-9A>
    <xmx:K16UaOhdlJvcLhXovhDrS4D6MLwNqL0cvwxZ3_XCA3LpJC-iy9C3iPDX>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 Aug 2025 04:04:58 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a4e9144a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 7 Aug 2025 08:04:57 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 07 Aug 2025 10:04:45 +0200
Subject: [PATCH v3 03/10] commit-graph: fix type for some write options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250807-b4-pks-commit-graph-wo-the-repository-v3-3-82edef830a1e@pks.im>
References: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
In-Reply-To: <20250807-b4-pks-commit-graph-wo-the-repository-v3-0-82edef830a1e@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>, 
 Oswald Buddenhagen <oswald.buddenhagen@gmx.de>, 
 Junio C Hamano <gitster@pobox.com>
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
index 3fc1273ba5..53bf83f7b5 100644
--- a/commit-graph.c
+++ b/commit-graph.c
@@ -2235,9 +2235,8 @@ static void split_graph_merge_strategy(struct write_commit_graph_context *ctx)
 	uint32_t num_commits;
 	enum commit_graph_split_flags flags = COMMIT_GRAPH_SPLIT_UNSPECIFIED;
 	uint32_t i;
-
-	int max_commits = 0;
-	int size_mult = 2;
+	unsigned max_commits = 0;
+	unsigned size_mult = 2;
 
 	if (ctx->opts) {
 		max_commits = ctx->opts->max_commits;
diff --git a/commit-graph.h b/commit-graph.h
index 78ab7b875b..f5b032e982 100644
--- a/commit-graph.h
+++ b/commit-graph.h
@@ -160,8 +160,8 @@ enum commit_graph_split_flags {
 };
 
 struct commit_graph_opts {
-	int size_multiple;
-	int max_commits;
+	unsigned size_multiple;
+	unsigned max_commits;
 	timestamp_t expire_time;
 	enum commit_graph_split_flags split_flags;
 	int max_new_filters;

-- 
2.51.0.rc0.215.g125493bb4a.dirty

