Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2393F246784
	for <git@vger.kernel.org>; Mon,  4 Aug 2025 09:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754300457; cv=none; b=bH5yIeDEUJI118cqe79hcXkL7jdnJpzlEATdzc5RjF4En6RdZ5NY3a0LuyfBGWfL49nl8CUwRlPYbby2gdVy8X9SkyyaJ5wtSZ8tgV64uNqKH80gwogHcdRL469+fAa8m/aOcLrxrzX6vS4dMSvI6BFAJmOWsw7XAWs5yH6Ahmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754300457; c=relaxed/simple;
	bh=gbiiai0wol80jRymQ3AFSC/x5nwa8G8k2dv6H6aGDbQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=bis+J+g2RFzKpsbbFysRtGUq70FhGBQ1irbh9HVf+uv8mltuGYfKv6iGtUnmbQQi6CIy31xKmF3tfg5gbGePjDpg3MoJMt1z9MNUF0yftp2bXCInMUWl6NeQO/rHZLeghrPZ0nvyQiv3o6AmpwLyuErxuEdXYddiseVHH8W61jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=UtHiAuId; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TnEnu/mU; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="UtHiAuId";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TnEnu/mU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 3EBB77A0118;
	Mon,  4 Aug 2025 05:40:55 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 04 Aug 2025 05:40:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754300455;
	 x=1754386855; bh=GIB/J08aPbaYPSg/1msSqrMeJZKe9FPPF99ocRP4f0Y=; b=
	UtHiAuIdK1LhMJlCDRArwmWAHlTzc7ixder9Wrhx5nxckfkTNDPE/y3n3jyZItw/
	xQeFWkb2QWdCLO8D9v7qlzClP+hklNyycgCIAZci0XFbGVHR8A5DSlIfvzOdHZQP
	zwUJgCLKIj/NlpBsiee8E/XxkwwHtFmOpM0z6VJF+QBxD4XucVot8kzsSQn0riV5
	qE7UdJvMeezpn37IBakz2NY7Utfw9le8OgMwg+UCw8d2Fd72uYCZ972FNeyuTCio
	MgtPRImPgeXpvmzYKkdGG6memMxEpRI4loKsvgpB/jHGtnE2GZHEOC1k/Ait1ENG
	xc/fqWvT1H4T2TvGOHxi5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754300455; x=
	1754386855; bh=GIB/J08aPbaYPSg/1msSqrMeJZKe9FPPF99ocRP4f0Y=; b=T
	nEnu/mUHebfmkSBJ9kEvnKfiIiYj+z1b6ZjDhBm1SrBY3Ck1F4Cer6d1Q+nNbOBQ
	TXWncpMCiXfAOMjwJ3C8ZdFndWXzLTY2Z1HlPBCMMVKcOfMfo7kKnUY+n6UBdmoO
	B/vob+Y1Jhc8lgQMiNk2Y2SNKJCduA0e6OzDAZiPmKpG+90i8Aef4pbEHF5uTY5N
	bufiQPbkzH+UfGJ/YhGGmWB3yC5X/JD0lf+YNCAxAtWFTpM/m7Ipw5qkpxL0YEln
	EDrbJ4S+dmiUb6Lp3jCuCpIQui49pCskxM7GzgHpH7KbPDXf2+A4CCpTvWvT/BEw
	o890cTIpCm15B/d7BJAmg==
X-ME-Sender: <xms:JoCQaIVVuP6dMFz5EBrk2MTHMH47BJlCDSyT3ILp-bYcqKt7AL4rSA>
    <xme:JoCQaMzdNnI3-o27O9oRvj2eNDnLn6CuYmamQ505rUZmPBxS1UQDuqKZ2B3P7LKdT
    6JdM9O5dW8y3oLGWg>
X-ME-Received: <xmr:JoCQaOMAjHQtXogLTmx3v885dgejWSqwrE_b4Urf8GVrJwo8FcFjatPRZZ54CdiLfLrEKLGtRdxrOBgiHEVgYg0gpZYzFu9iiJyAYMa-03s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduudduleeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepgh
    hithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:J4CQaF7Qcv1oobPEOCrbcwNnOxhRX8rzT3McTrIETnhelo4rODO3Gw>
    <xmx:J4CQaHMXV0mUsBcwVokXprfFRP_G0GGU8CgtSteQGML3IcXxZY-s0A>
    <xmx:J4CQaLkAv6wAkK1Z7k66pZrod6Qgy-ot3m_O1WJmIAGOoRd_oXYnHA>
    <xmx:J4CQaGR8V_LK-dU6AiVA3fv91QU43i0Df5YAfHcIvw-Nyiy4hzuVSw>
    <xmx:J4CQaK53Y-2YWMl8cNoiglz4dx7yYSk2K3xebO1dvEU1IKwRIgIIUYrJ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 4 Aug 2025 05:40:54 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 075e5de1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 4 Aug 2025 09:40:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 04 Aug 2025 11:40:27 +0200
Subject: [PATCH v2 6/6] reftable/stack: handle outdated stacks when
 compacting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250804-pks-reftable-fixes-for-libgit2-v2-6-fef06209a984@pks.im>
References: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
In-Reply-To: <20250804-pks-reftable-fixes-for-libgit2-v2-0-fef06209a984@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>
X-Mailer: b4 0.14.2

When we compact the reftable stack we first acquire the lock for the
"tables.list" file and then reload the stack to check that it is still
up-to-date. This is done by calling `stack_uptodate()`, which knows to
return zero in case the stack is up-to-date, a positive value if it is
not and a negative error code on unexpected conditions.

We don't do proper error checking though, but instead we only check
whether the returned error code is non-zero. If so, we simply bubble it
up the calling stack, which means that callers may see an unexpected
positive value.

Fix this issue by translating to `REFTABLE_OUTDATED_ERROR` instead.
Handle this situation in `reftable_addition_commit()`, where we perform
a best-effort auto-compaction.

All other callsites of `stack_uptodate()` know to handle a positive
return value and thus don't need to be fixed.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/stack.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/reftable/stack.c b/reftable/stack.c
index f77d7f58e8..effa2fc8cb 100644
--- a/reftable/stack.c
+++ b/reftable/stack.c
@@ -579,9 +579,11 @@ int reftable_new_stack(struct reftable_stack **dest, const char *dir,
 	return err;
 }
 
-/* -1 = error
- 0 = up to date
- 1 = changed. */
+/*
+ * Check whether the given stack is up-to-date with what we have in memory.
+ * Returns 0 if so, 1 if the stack is out-of-date or a negative error code
+ * otherwise.
+ */
 static int stack_uptodate(struct reftable_stack *st)
 {
 	char **names = NULL;
@@ -849,10 +851,13 @@ int reftable_addition_commit(struct reftable_addition *add)
 		 * control. It is possible that a concurrent writer is already
 		 * trying to compact parts of the stack, which would lead to a
 		 * `REFTABLE_LOCK_ERROR` because parts of the stack are locked
-		 * already. This is a benign error though, so we ignore it.
+		 * already. Similarly, the stack may have been rewritten by a
+		 * concurrent writer, which causes `REFTABLE_OUTDATED_ERROR`.
+		 * Both of these errors are benign, so we simply ignore them.
 		 */
 		err = reftable_stack_auto_compact(add->stack);
-		if (err < 0 && err != REFTABLE_LOCK_ERROR)
+		if (err < 0 && err != REFTABLE_LOCK_ERROR &&
+		    err != REFTABLE_OUTDATED_ERROR)
 			goto done;
 		err = 0;
 	}
@@ -1215,9 +1220,24 @@ static int stack_compact_range(struct reftable_stack *st,
 		goto done;
 	}
 
+	/*
+	 * Check whether the stack is up-to-date. We unfortunately cannot
+	 * handle the situation gracefully in case it's _not_ up-to-date
+	 * because the range of tables that the user has requested us to
+	 * compact may have been changed. So instead we abort.
+	 *
+	 * We could in theory improve the situation by having the caller not
+	 * pass in a range, but instead the list of tables to compact. If so,
+	 * we could check that relevant tables still exist. But for now it's
+	 * good enough to just abort.
+	 */
 	err = stack_uptodate(st);
-	if (err)
+	if (err < 0)
 		goto done;
+	if (err > 0) {
+		err = REFTABLE_OUTDATED_ERROR;
+		goto done;
+	}
 
 	/*
 	 * Lock all tables in the user-provided range. This is the slice of our

-- 
2.50.1.723.g3e08bea96f.dirty

