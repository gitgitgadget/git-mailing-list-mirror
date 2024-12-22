Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50CCE8472
	for <git@vger.kernel.org>; Sun, 22 Dec 2024 07:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734852293; cv=none; b=U/5S0LB3kiOKNmHFauTethAmDmdHC/atuvwGS5qh6zfaynt1vM/R+OUXseKE8ICipT/TTw0Sd0NafH12PvbDyBSFeD+BDJ3TeDxmfiHDq2P+rLjwXc0L0IAl7UYBt946e+gekp82H5OiUr/xgbRNPagw3Zk0cTAFrbofyYdRZHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734852293; c=relaxed/simple;
	bh=c8MaOICLpqY6eV1Un5D2TVh0n76bgKGymqF8tvvqhv4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CdgxtNVsfdaL1QIzM3Am8Qhaivy/qJBNntRV9aqmywKT5zRqIZTCM/9gQGIh+2Ym8nzqQH4C7WT706JaJEXHws5jbE4JoNdPFXgFZb7P+WHtm1eUX6zEoWH+YhtycmouunQxZzTbQg456bcJQJc6OQ+tvY0wC3MmHvMbtyxeIME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=nPb9/C2u; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xVYiDOAW; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="nPb9/C2u";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xVYiDOAW"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 5EC661140072;
	Sun, 22 Dec 2024 02:24:51 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sun, 22 Dec 2024 02:24:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734852291;
	 x=1734938691; bh=jnPp2/o2ZxHQ1n3s/c/vQTCvNOw1NHKySaFamODYs18=; b=
	nPb9/C2u/zEzAJDTabEsWkHYA0JzvDsorgeH5P9ASYXXgOh72eBipEqKi2BFqZRf
	ytY12+OwWjCeoaToOYV/XiG69EIZc7Vqd9AqwyXHiMsNsNv8iHI46G1RvDAXFlup
	yyDxaL5WLZyF/ze4q9FGmlkguqBXQdJvM9H20fYfIKkVaYLtP2SLmd3y3RhVJGzY
	seaySeMb8AW4BE2Kp0ovse3FmJcwSHTf9efDQjRkP52BR5OSVFqjfcj6xaP0Z+RP
	IWRNN1f/D7IydGlSU5BFnzp9NxdSIGuxEqXh7ljz2BvCLRVfsfk8M5ErcKo6K/B+
	8SWL0lTwpMYNXmZ+EyU/lg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734852291; x=
	1734938691; bh=jnPp2/o2ZxHQ1n3s/c/vQTCvNOw1NHKySaFamODYs18=; b=x
	VYiDOAWRmTUtRB5U5LM3hD0wzi8RojY6SKmFxft5lqRWSunaXI/l3WAIHenftvfH
	8YPqQOpCnv2BVZnF8cAkrjOGTQa38MzttD/jE+o2y6XbkHoGdjqoTc8ovIc4tPMV
	aerEaNnDRCTzoImiW8R2uV46flgwOvXylk/u0lsQ/9AGRrYemOtDkFd4+AUw12ch
	NyauZG1AyKmlNxf+x4xI6xQSN4ieiED6KRy7IEk4aSK71hS9r/Tl5hqLLNBLzwzo
	NUHw7By73SdFByDbid2zsM4iKnZ/QKo75NZc5ErXhsmmcr2L5UBK9X5rVpNPa84R
	HITVCX6y5z/7bkANXBARg==
X-ME-Sender: <xms:w75nZ2VKpWjf0ZAvBOXXXbvV3e1NXja1BEZXNst30wmuVZOoNQ0qgw>
    <xme:w75nZymHSYL1BqLIhcfefNLytzdBxR5yyVCbNShiVC_GSvEbZOSRcJbHIfE64STER
    QaSh9GsfakDkvRixg>
X-ME-Received: <xmr:w75nZ6a66aeTgS5OaXW_F-DqJfYKoaJWbzmkHo-TYLB4SNwjxIC4FUxY4Z6VvpzxFePTqJEPn8j7R5QxJz1taFvGtMVcn1vrc_aQL1brBzUgZQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddtjedgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtg
    hpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehrrghnuggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:w75nZ9UIIcZVbgo9_itjQEDeFFdWIO9IBqcY254kuacjq5_AXbKnMQ>
    <xmx:w75nZwnlnyDOazf4ZR8jgMkgl4ST_p-zn2h2FXChIyrjIyRg6oudRw>
    <xmx:w75nZyc3Df-lWl9OlUU4fqy_QEwNpmhDrnlUfNS4_1ztNh6YvG5Tog>
    <xmx:w75nZyEXv5RS4BkpLCe8yDJoHCTWLtOLu_tHRAhpA7gKbnciefDQAg>
    <xmx:w75nZxAJtgd2Cmgi9oAejVdfZV_94iGlgziAOVKAdHS3liA1n9ZYXa91>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 22 Dec 2024 02:24:50 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e2225c99 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sun, 22 Dec 2024 07:22:51 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 22 Dec 2024 08:24:28 +0100
Subject: [PATCH v2 1/4] reftable/stack: don't perform auto-compaction with
 less than two tables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-1-19550090d15a@pks.im>
References: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
In-Reply-To: <20241222-b4-pks-reftable-oom-fix-without-readers-v2-0-19550090d15a@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

In order to compact tables we need at least two tables. Bail out early
from `reftable_stack_auto_compact()` in case we have less than two
tables.

In the original, `stack_table_sizes_for_compaction()` yields an array
that has the same length as the number of tables. This array is then
passed on to `suggest_compaction_segment()`, which returns an empty
segment in case we have less than two tables. The segment is then passed
to `segment_size()`, which will return `0` because both start and end of
the segment are `0`. And because we only call `stack_compact_range()` in
case we have a positive segment size we don't perform auto-compaction at
all. Consequently, this change does not result in a user-visible change
in behaviour when called with a single table.

But when called with no tables this protects us against a potential
out-of-memory error: `stack_table_sizes_for_compaction()` would try to
allocate a zero-byte object when there aren't any tables, and that may
lead to a `NULL` pointer on some platforms like NonStop which causes us
to bail out with an out-of-memory error.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/reftable/stack.c b/reftable/stack.c
index 59fd695a12c2033ed589a21ef1c9155eeecc4641..6ca21965d8e1135d986043113d465abd14cd532c 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -1627,6 +1627,9 @@ int reftable_stack_auto_compact(struct reftable_stack *st)
 	struct segment seg;
 	uint64_t *sizes;
 
+	if (st->merged->readers_len < 2)
+		return 0;
+
 	sizes = stack_table_sizes_for_compaction(st);
 	if (!sizes)
 		return REFTABLE_OUT_OF_MEMORY_ERROR;

-- 
2.48.0.rc0.184.g0fc57dec57.dirty

