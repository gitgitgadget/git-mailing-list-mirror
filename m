Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC82A2EA759
	for <git@vger.kernel.org>; Tue, 12 Aug 2025 09:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992491; cv=none; b=rEJm4vFU6m0J4jMeQsv5KPhsvg7eU4Z1yT67crNXEiJn9C6Gxh/6/pL+EtSlcE2vEfs7a1Ert1xTTjcuIogr/NL5PLg87je412XkpZnKcyTGVYkHrIdmMSOTJIWaXOweKfwXYPdganWQjxBqUdsz/lasDmciI9DrVx9ujVuZKto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992491; c=relaxed/simple;
	bh=ns4ia9mTfosoSfqzaerlvGyaewOgo9fDLVou9LJ6Gm4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ERf8e8LSAYTRI0h0pzqrx3xYHFRVUx+o85CBIqTWV2zV9qtvdYk1i7dsfOOXwICnMKNzYbsKrZVHsKVSNfzdFJcsNix+1WwY8GIzLFnjGFo7sUOF5tnlW4vBF3aaDQQRnAqhKu7hMzuNYqFw1AyvI5FxKtvEgfrmAQyp41x/1JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=jmGnCd3v; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Gu0FV711; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="jmGnCd3v";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Gu0FV711"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FE6FEC01D1;
	Tue, 12 Aug 2025 05:54:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Tue, 12 Aug 2025 05:54:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1754992489;
	 x=1755078889; bh=CqfAcVrJqnGrqbAklyFcn5gonZJBxm8xwh5Jqwpgiyo=; b=
	jmGnCd3vMvTQYomAAuQHe5oGwxdI9nT1HABVrJmJ+U4qdhXLYqVexgYi1aUQYOHK
	GoUDlqKVafdL8RbTpwAgWIqMutfvXoX/qAw69Q5bKYYOO280kzyXxDyR7IGnn9aJ
	6JcbNOQ2wdXCQZnhvnhHs82+Fsy+XDQpRZMrf4mR+QoxSi76TBRNO/Q9fLI5hoV4
	5lSzY+WvDTBA3nuSjpg44MMmseE0y4mrDDIVG2aNOC6Nh1831UnBUuDD+gvHvB60
	fQeyVHkT162kMTMzLRG+W8WJnskwOY8+w2+EzQsQ5sO/xq5RoWSaOlBaP/h5lHyZ
	qG7ZjI+EII2Pst4jdY4KKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1754992489; x=
	1755078889; bh=CqfAcVrJqnGrqbAklyFcn5gonZJBxm8xwh5Jqwpgiyo=; b=G
	u0FV711se+PAnNARGxb2uqi1omXCKvdtzyQwsThDLF9yfCqbY7ETckrmZ9/R57vG
	LjCm7JFklRsUHylZ277+dNQUNHUKq2LnqrX16qvjF84pix2dzzoYqrZUoAk0Hgvi
	fdGA+puskfIT+TQV65D0lrGK6ND/Dd/rz7L2ITo8VCiAohDB4tiW2IM7jt84Zxjn
	7Acqift62N243AWnJR+a4vbm6oIVgHLX/lQgRImNSwcRm3MrfqBQYO9T2kcbtqDT
	tWlvRgQjG/kBIs9N4PF78GGQsnJ7a3i91Zwi8A4KCAVZVAcVu+F7V3cuEF8XzYCO
	5jBgZqxrhrXBAf6mJP+Gg==
X-ME-Sender: <xms:aA-baHfVkeqDzMy8IWw2sS3Ba88VSzc0twiOiqJeFq6rTLTBgiamWg>
    <xme:aA-baItgp4R-vmQczUK6RmOiRi1883MBxI5eaqDo8EMa3XaYLQLLhzR4_xLOyX_KT
    sr_cM4Q7AFXuhosaA>
X-ME-Received: <xmr:aA-baG8nxuuWCsr3BmtTEPdH0g6TSd-JL7lRIvYv4eZ_olHmZAV7hfCaHsDu4N4tTDi5vj06-3F7yzsvslFXaKtA0_e-swKbWIvSnDFF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufeehtddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopegtrghrvghnrg
    hssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoh
    epshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:aA-baD1BNjxsoK4X2lDPdKVTXQZ2mL7cfoI3b5ryXJkCVIsiR_BE2A>
    <xmx:aA-baLDu7m8mMsm0Wsc7IEVbym2SBIEecAzh5dgyyo71mjgNSra5gg>
    <xmx:aA-baPcIp1OQ3SHR5kD4hK-tUAqXexYyOE6upQe94wgaPhQ8G4KCHQ>
    <xmx:aA-baI78UR2YEpfphACL5T-_QBpoMlkn2y1-0Xp_WAWwtBOnZUzDkg>
    <xmx:aQ-baELBc7GyHYmt69rHXpU9RV3hR7m0-xCthl7jW7IH8iCkwniHTg8j>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 Aug 2025 05:54:47 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 3185f008 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 12 Aug 2025 09:54:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 12 Aug 2025 11:54:20 +0200
Subject: [PATCH v3 6/8] reftable/stack: handle outdated stacks when
 compacting
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250812-pks-reftable-fixes-for-libgit2-v3-6-cf3b2267867e@pks.im>
References: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
In-Reply-To: <20250812-pks-reftable-fixes-for-libgit2-v3-0-cf3b2267867e@pks.im>
To: git@vger.kernel.org
Cc: Eric Sunshine <sunshine@sunshineco.com>, 
 Justin Tobler <jltobler@gmail.com>, Junio C Hamano <gitster@pobox.com>, 
 Carlo Arenas <carenas@gmail.com>
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
index 1ce4d90cb8..af0f94d882 100644
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
@@ -850,10 +852,13 @@ int reftable_addition_commit(struct reftable_addition *add)
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
2.51.0.rc1.163.g2494970778.dirty

