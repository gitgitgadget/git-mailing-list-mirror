Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA68A188587
	for <git@vger.kernel.org>; Mon, 25 Nov 2024 06:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732516055; cv=none; b=C2Dy6fezLoAiE07hDwx2ckdlyVcM/1t6TP74elTkuOhMfe2lfzIA/3mTTPUxW7FkBQX6Ut/2UwuNOx8+gWOh0jiCm4ySFSfbuLC30BftXr1hcWlJSUgOQ0GGXNtZyIeKcB881KAPFp8hals5U1VG0sD14pYxXUG2dHwFPbDZkhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732516055; c=relaxed/simple;
	bh=VV148vlfMTQ/EmX3CGHtxYkN4mGgX8aZFNBcWrfD7Ys=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kijUFSkRWkHB1PwJZq/Mmnkpnxr0vkCCxiAq24QiOiT4yE8JboYFgVQ2K0ak2fpR6EX6hg7IPd1uSgccTA/VFxQ2q+LHKkZYS2EbtG5af8zXMwgXJiBHClptNGVB06Q4Gntse3rMgDgborH0MbZWkzKBvgVali8u273IHi/9QOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M/EvQW1/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=yvhDSATe; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M/EvQW1/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="yvhDSATe"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id C03A41140126;
	Mon, 25 Nov 2024 01:27:32 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 25 Nov 2024 01:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732516052;
	 x=1732602452; bh=jnPZWp18Rrjm180KlncZYYFbvUyyq2H2sSSiPz1WxOc=; b=
	M/EvQW1/R4BOXzQwrgxuMzZ+Jb5fl+Uvf4T6Q2CGC3jhLjvk5aM8ccMPV9VxIhNI
	Iqrxchz/uPoL/gH0DPssDzGmpHy1PjjkeBs5TsgqP8Fv8jYzTpVuEOz+t9Uoz3Q1
	k7rkFK9CymtrZnw0c3SHE8RTY1tq5M042IPaE5FDjemH1K0x2n5DIW9BgxE0M1SH
	x3uHHC33X2OWONTRzd/luKjNCWBgT3iDWyzMp9V2SlWU4+Pczwo62X5EoH6SV2OL
	4WPFx7exW2PTsRPMD/eNkMHikMHN4Bfc+agzRR6QrymR8XX32sYC9X+L7RCbiWVA
	0nEmapMqbIoW37Xc1vWQ0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732516052; x=
	1732602452; bh=jnPZWp18Rrjm180KlncZYYFbvUyyq2H2sSSiPz1WxOc=; b=y
	vhDSATec+TAJJuLWZU5sMhDmCkIEzLBOd74g6YiWByHTrWmfpWsv6qaRG+gSW74X
	o95YtSACGjnLSFDZEZQeOHE9qFmFM/ny5iIs5qRd70gJL6knlHtyzhJkCXhQuQZM
	PkRuaVVr1kl2dxHz/QLrswU54oxOMv+Vx1s+9IYULmcps89rrRPYueeK0sfevkFF
	6Bjhc2AFV8Gkk+MwxcpeCal8H/fePMh6WqXHv6WOWDNSTcpzgilkDlYK9SnAQrF1
	lu3eiybr6IMpFOmODnXh72CwSRbP09+n5x52YGdguDbIqzX6IcaeSpeLnY6Yw71O
	cd8C1hv/hbDGwlzPyiMIw==
X-ME-Sender: <xms:1BhEZ8YkWRZ0Vz2u1cQMs7RT4iQS4hY-9eK5HWaf2T4TPr70fkBTYQ>
    <xme:1BhEZ3aofH3hzY3yVvdQRvQSkQDfVqIqjlUMvVg8zFxcPwjbK7THnW0TQBH3UWarM
    t49gmUbAJ6SA8Kh1Q>
X-ME-Received: <xmr:1BhEZ28WlgU59QGPx6xbtkIUAJqQIfTSqQjmyQatn84Q9kQRxwDimI4BNyuSV6bY1l27-kxaXZTAbV9GP4fd0LdVAAuZ4nt3pZzUtB2xVXYVKw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrgeeggdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhr
    ihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegthhhrihhs
    tghoohhlsehtuhigfhgrmhhilhihrdhorhhg
X-ME-Proxy: <xmx:1BhEZ2qzRm7cBzx74QshrQxGzsJoSk9WZnTNXjshB09uIdUbWYY40w>
    <xmx:1BhEZ3pkRwdvnWJFmsDOsm3dJa1NkflPVh3DIBlvbQGm1gtL-5lzEw>
    <xmx:1BhEZ0QACityFVs-bjaBbGnrbFRNtKndsjLRrTBPs3bEZg9jSneitw>
    <xmx:1BhEZ3rGzPhXdI4vEHhwLo-SFdQCtHMnA6f9txpUkzFzUB_XlqyqaQ>
    <xmx:1BhEZ4DoFfamtdglrvhU0Eaat_pS-oC7Jg2_KGsgLEMRKlYKUCoCjjZ4>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 25 Nov 2024 01:27:31 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 40226fa5 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 25 Nov 2024 06:26:29 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 25 Nov 2024 07:27:15 +0100
Subject: [PATCH v3 10/10] reftable/block: optimize allocations by using
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241125-pks-refs-optimize-migrations-v3-10-17bc85e33ad7@pks.im>
References: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
In-Reply-To: <20241125-pks-refs-optimize-migrations-v3-0-17bc85e33ad7@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Christian Couder <chriscool@tuxfamily.org>
X-Mailer: b4 0.14.2

The block writer needs to compute the key for every record that one adds
to the writer. The buffer for this key is stored on the stack and thus
reallocated on every call to `block_writer_add()`, which is inefficient.

Refactor the code so that we store the buffer in the `block_writer`
struct itself so that we can reuse it. This reduces the number of
allocations when writing many refs, e.g. when migrating one million refs
from the "files" backend to the "reftable backend. Before this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 3,025,864 allocs, 3,025,815 frees, 372,746,291 bytes allocated

After this change:

    HEAP SUMMARY:
        in use at exit: 80,048 bytes in 49 blocks
      total heap usage: 2,013,250 allocs, 2,013,201 frees, 347,543,583 bytes allocated

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/block.c | 13 +++++--------
 reftable/block.h |  2 ++
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 3fa36c002a0c1852790780e74a6e055161f857d9..01980784854cc454938bd2278b94047ff62c20d4 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -110,24 +110,21 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 		.buf = w->block + w->next,
 		.len = w->block_size - w->next,
 	};
-
 	struct string_view start = out;
-
 	int is_restart = 0;
-	struct reftable_buf key = REFTABLE_BUF_INIT;
 	int n = 0;
 	int err;
 
-	err = reftable_record_key(rec, &key);
+	err = reftable_record_key(rec, &w->scratch);
 	if (err < 0)
 		goto done;
 
-	if (!key.len) {
+	if (!w->scratch.len) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
-	n = reftable_encode_key(&is_restart, out, last, key,
+	n = reftable_encode_key(&is_restart, out, last, w->scratch,
 				reftable_record_val_type(rec));
 	if (n < 0) {
 		err = -1;
@@ -143,9 +140,8 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	string_view_consume(&out, n);
 
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
-					    &key);
+					    &w->scratch);
 done:
-	reftable_buf_release(&key);
 	return err;
 }
 
@@ -569,6 +565,7 @@ void block_writer_release(struct block_writer *bw)
 	REFTABLE_FREE_AND_NULL(bw->zstream);
 	REFTABLE_FREE_AND_NULL(bw->restarts);
 	REFTABLE_FREE_AND_NULL(bw->compressed);
+	reftable_buf_release(&bw->scratch);
 	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/block.h b/reftable/block.h
index b3f837d612a8f0fbe98430b04e2dddaa975a15ab..0431e8591f41dedfb96eef304ea63ef2e9e5f5dd 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -39,6 +39,8 @@ struct block_writer {
 	uint32_t restart_cap;
 
 	struct reftable_buf last_key;
+	/* Scratch buffer used to avoid allocations. */
+	struct reftable_buf scratch;
 	int entries;
 };
 

-- 
2.47.0.274.g962d0b743d.dirty

