Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB8B128B3EB
	for <git@vger.kernel.org>; Wed,  6 Aug 2025 12:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754481633; cv=none; b=OX7RhyVdeS8AHhDfhwAKv4TwuX+e78NER4NQhJreMn6XO5LkkVytDo9lsfl6O/gRsHdkNqY3aEc/FOf++EQqVpQkhYoV0mmsqI5sJ7XnBLJxYyMlP1dz2iI/gDw2WlukkN83zzDv42S67Cfk5fC64GmNFfLf3ZIr+Reccnzwvkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754481633; c=relaxed/simple;
	bh=mPFF1XKopIDZqfU2x8kogde7HciaBr60YgzVh+66MG4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kBtXGNOZIcPadKq3bTzLtgfXRlhkMoerNFhnIQ4/PfqcsrQIpUz5HhdnixIKzV11sN6ot85mBZOrxbDASeY4CdrnB8YunkDIL21NefPRu8G1XTvh1mLYMttWJmzwNZhQXmDg31dFFn8SwVdY/0C1kyDLbR2WSdJJo5DvjLXmQL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IIL/M2IL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO6opIgn; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IIL/M2IL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO6opIgn"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 4B02814000E4;
	Wed,  6 Aug 2025 08:00:29 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 06 Aug 2025 08:00:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754481629;
	 x=1754568029; bh=Kn3QUuEP0WLzqDu1t6GnOOQ1AXSrsao/JcggoE4G4VU=; b=
	IIL/M2IL2arhQEDdnz1kqllVxKcw4bnWDZIiWVWKS68LmfkCGx8apiNQG4yZuNlD
	u3l7yF6tmU+aus0SXYki8cBOx2lJCqJ3yt7YIEKS29Jb+cY4uEtWB1wlxBsTrdGr
	+ZU5qntysxnqe6sRkUIpDABlKv/3T4meRoDsQyKoBNh8dhNbmi26A18iVv77QXOD
	dbeMoTpCNQEymfQa0SPiXk89u0ZWyINChqm/n92vc9ZFu6mKTVNs2n3E1XizhuGW
	Nch412adERtiQ9LCKM+MoKcjvK4P0wXBhEIxwNrh11QSjPNUXAnPurcEI4waeElb
	HjN6CLgqqWmodXbOMaTCTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754481629; x=
	1754568029; bh=Kn3QUuEP0WLzqDu1t6GnOOQ1AXSrsao/JcggoE4G4VU=; b=c
	O6opIgnuTVdgzUJG0V2JM9OYrhxh9brdizjUjaW7Wh0c9yWS4RK8RI16qcnGLWbE
	Phcmj01RnN/8V2vUhL+m8ajF9ax/gmfxxqCWqhNQ6cQSdOIvM74oCsdha0kvNXPW
	xc06jU2EZ3I7GN5K7e/RzqKI3IwrXg2GLAm9vdCb6uUcsxYZvyAcACl61e5YlHnR
	b9uAkvf7Xz4XebOV1T8yDpLYDjIJQj2YCimGNTvAUrNkhgNR405bqFkYXmP17ILO
	ljb1pwVwON8R/i7dbyvkylv5BVA0lElSDsLBxpKOkmZpbk8gX0u7s//csDgC3ldu
	ZEg34D4Ewc7Wih1qeOdBw==
X-ME-Sender: <xms:3UOTaOqaeJuHX9bLj9eC8z_nOYFk_Ug_YKsw0HfaqilEiRcPFOEWug>
    <xme:3UOTaILEUuyyMQoqQWaRYhtVLi-M3trM1o1ZgCzbd1ZcCGGGtzt9rICOqdF9WW24Q
    5-8Nm6WPoZjV63HOw>
X-ME-Received: <xmr:3UOTaJqhQ2WKGB-VHuit5aCA37jzbQrh6ryH9NczoBpONdMaEz5x8Iu7qZ-G8vMrhksZGp0nsfirR53hoeVnLAg8oFWx66dKxaJk6vyhuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudektddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsth
    gvrhesphhosghogidrtghomhdprhgtphhtthhopehoshifrghlugdrsghuugguvghnhhgr
    ghgvnhesghhmgidruggvpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepmhgvsehtthgrhihlohhrrhdrtghomh
X-ME-Proxy: <xmx:3UOTaIznCZyVMpl53BUmZh30fVmhqi_hiuAyWJlBiyVsSnwG_Qwp9g>
    <xmx:3UOTaFO4SzcaFNdLygUWK1yrCdpBjHj6b7tRTS5UTsDo3ayyOZNi4Q>
    <xmx:3UOTaF5Vlc9s6sFqqEfXL-gQbWOYpCqK2QwGT1fDtCe2PVJf2ItkVw>
    <xmx:3UOTaGkOYbsXhK7KXiEGdb0QarBTBVFCK0i5gUxY3EIQ9im1L6Zf6A>
    <xmx:3UOTaHnFfnMd4fJqd9u57Eltd6lm1AILpLMyVQTWqfNAu6ohcx5QP2_n>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 6 Aug 2025 08:00:28 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ccf55784 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 6 Aug 2025 12:00:27 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 06 Aug 2025 14:00:08 +0200
Subject: [PATCH v2 03/10] commit-graph: fix type for some write options
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250806-b4-pks-commit-graph-wo-the-repository-v2-3-911bae638e61@pks.im>
References: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
In-Reply-To: <20250806-b4-pks-commit-graph-wo-the-repository-v2-0-911bae638e61@pks.im>
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
index 3fc1273ba5..ba04fe75db 100644
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
2.51.0.rc0.215.g125493bb4a.dirty

