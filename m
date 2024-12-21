Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9CD1F0E4A
	for <git@vger.kernel.org>; Sat, 21 Dec 2024 11:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734781844; cv=none; b=J5866wKGPMWlhJ0s/FloKVFbKPrUGlVtmvnBgZZMS1BNnrhrZypi3loFSnSbQ0GuEfa4SrCqCMjBUIb03kqM8PiC2fBGsYfAF//SvQilJcUuoXMbF0I5IIeEZHepUL7ZdYGUcRKyeGKyDWapR8laXgryAZdsBygdbRQZrbHC/6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734781844; c=relaxed/simple;
	bh=bMP9ToLgT5yXeWHVPrNKrU2XFDRxt8rKjoPU9dMYexo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=iDeWE7AmrDQfY8590QP+meZeX6q4/x5NH4eMUB+juJHI/SrmqNO3/szEfU0kQ6Z2iosudfZvDLy/pXoaigydz5HH5YDBHbfpvNXa7+c80je2wDXUctnz9ruP7YuVDhKPVXaRk+xNuOtxtSE7zbpOU11+IqL7hbPYuQMOidNV798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=alGxp3Kl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pnp1NuXH; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="alGxp3Kl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pnp1NuXH"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 682621380208;
	Sat, 21 Dec 2024 06:50:41 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Sat, 21 Dec 2024 06:50:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1734781841;
	 x=1734868241; bh=Jtir8l3DbJOGTyXexSGb+KQTeSps0SquyKUOP7L3bBs=; b=
	alGxp3KlpSBORJ2aw7suVMWWkD+n0Aso0FicHYv7F0Pn9oPRdR/Y1pylOlc2b9KY
	RmuttqvkwVnWg1+So3l7eKZ9cD0tEBDDy4z8V/gbUmFpjNgIqWy5PzbADeK2ynOp
	t1hhMYt7ULQqP+m+T7t8kOpNcHSvsCGpAqMXPZyMyd5s11swD/R6obn5J2PwE1ac
	SYAT6HdknrwrbWVKylraC4UhWRxEpBt2dXjRn1JNGBItiZL1aj8wo8w8LwEyy8ld
	79v3m6aUvjaOEHNi4w0Uut7e8FB3meblb9NsSYe9npg8naOCOxupJY+fdyjBZg1Q
	zNDhwl5HKbgb2q1JUuHw+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1734781841; x=
	1734868241; bh=Jtir8l3DbJOGTyXexSGb+KQTeSps0SquyKUOP7L3bBs=; b=p
	np1NuXHl1MH26Mo1dxF3G/kfS6pDZp+POELqMb7+AfDM0cX+FGGG84vPNwpjj1Ng
	Z5Rws6V4BB61etdkzd41tRgHGTSQCp2KDr3Fy62yz8Wp0p9u+W5jV4qhE1eXkYo+
	pQQUs14sXEi+fq/xBWolTWmiUZlr/C+6fDwKglxbDaVpsbh43UWu/s96v4v0rFMt
	kZN3ILjU4knoKW9CQYCh48JgYG7yQ+ZBknab5xj4MhT9ulxHnil12IO7O4S+E5+s
	6qnVA3oQKiPdlsX1+38zEsMZkHAKGjmObm/rVMqTA4O/w/2K2N6cqTZ2qdL9Cdm8
	oPwhtEGA0SRnrJRKxawRA==
X-ME-Sender: <xms:katmZ2aWHPjpYc_0tP3osPE2XHFgw7Jpojexu4H3NQ31et7iHnT3MA>
    <xme:katmZ5bJSbVqk3PpCJ45L17yaSjyFnUaYz4Qg4DqmObJRm5NyMYKedCHF7uTRe0vg
    MiGka-ZZxzMHh5Rqg>
X-ME-Received: <xmr:katmZw_xL10DVfwJ0hU5Vz-RYZsby3PKo6kj435luJPXovuFWbmUdE2WYMMntc2m56oHbbXd4vPI0rDwhuvNtdDtXrdBVGsNMdwbpH-fK-A9jingSA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddruddthedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpd
    hrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehrrghn
    uggrlhhlrdgsvggtkhgvrhesnhgvgigsrhhiughgvgdrtggr
X-ME-Proxy: <xmx:katmZ4qJtEAKoaVR-8qFgMEE-T_MSOz4p85Hk6ZID238r3leKGN3cA>
    <xmx:katmZxpQ7HOa9TSGkxJfdz89gRXERm8aDsn3u4oLZGeYA0G7S_MQdg>
    <xmx:katmZ2QTdJB8m5deYeCM43HfL2Jsy1bxN0cMV2kI7VOchIfJiXo_wQ>
    <xmx:katmZxqrpdXwOwodGOh5jQ5SSYZMnx5LHkHQd251eMRrNvJ7tmf5qg>
    <xmx:katmZ4UBHoYg0m1rYTQ22cN290SrP9XkKInzIcvRZ_Dr7YZ0WcRn3jZg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 21 Dec 2024 06:50:40 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 36ead942 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 21 Dec 2024 11:48:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sat, 21 Dec 2024 12:50:07 +0100
Subject: [PATCH 1/4] reftable/stack: don't perform auto-compaction with
 less than two tables
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-1-12db83a3267c@pks.im>
References: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
In-Reply-To: <20241221-b4-pks-reftable-oom-fix-without-readers-v1-0-12db83a3267c@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "Randall S. Becker" <randall.becker@nexbridge.ca>
X-Mailer: b4 0.14.2

In order to compact tables we need at least two tables. Bail out early
from `reftable_stack_auto_compact()` in case we have less than two
tables.

This is mostly defense in depth: `stack_table_sizes_for_compaction()`
may try to allocate a zero-byte object when there aren't any readers,
and that may lead to a `NULL` pointer on some platforms like NonStop
which causes us to bail out with an out-of-memory error.

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

