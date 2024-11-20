Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1084198E91
	for <git@vger.kernel.org>; Wed, 20 Nov 2024 07:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732089117; cv=none; b=Th6P7Ahrj/zp9SkG11OFAC5NY5hI0eaZus626coywnjmuCJ3/rA8AcwFS8m4QslkWZHrwbIGAKk8xERPxnJ9NGcSx/cXeq5L5velxkQGU3Qq14UlEQGVdRYf2fhjrdwCxQyHyKsrd4MAfyy3Ix7OElORtZ6sQpEaU0s93j47lfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732089117; c=relaxed/simple;
	bh=tn582ioRCogYiEb1f9uOOA21OYTqJN96I1lBT11PJcw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DN7Dm3BDVhSVw4u6oquUvR0HK4+wrPpse/7yCfOoZQdVUBznS1OmpOl0nJ6c417kXEwm+epJjOvRc126K5aTFUKKE54ERpiTjase+3TJb6KiV9eA0YIVQv5VrmiU/FODkwSlyNIgY2cqKFIn+pm3ZeXpYWMFd7fVtPYiqJ2kArU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=OIJdo7F4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=U80dN/3N; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="OIJdo7F4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="U80dN/3N"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id CBE6A1140127;
	Wed, 20 Nov 2024 02:51:54 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Wed, 20 Nov 2024 02:51:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1732089114;
	 x=1732175514; bh=k7YfkDyybmZ4+LPx4SOpeB1b8h+NlOa1eufUUsj/JHo=; b=
	OIJdo7F44Ay+ssHAl87iUWA0OOEbPudog7PyJrVg2eQAQAFzwDzREKTByE5t0blj
	2gD4o4SKZacM92IwgPniru9S+u0JKu9sFI8W/bGpBacANjiEubR2XhPvxF3Fwx3u
	8htUQhkMPD3aDCMcELqkSv5gWNLZpJpoihIVmJeqsSdCDFBS8tBobt1EQbk+iEhQ
	LtwB6MmT1wQReZBNsX01stJD56kFnxPsw5FlOhOr1X9hy2KA1CR/7J5j6P2Rz4tm
	jsRID8yiEsJMRA/56n0/SdpvlmuZgcu3obRLG1xXon9S+8y8HsIpJRhCy044GhWA
	z+GXhhFfztSI35uM4SzH/g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1732089114; x=
	1732175514; bh=k7YfkDyybmZ4+LPx4SOpeB1b8h+NlOa1eufUUsj/JHo=; b=U
	80dN/3Nndcoz6U2htPrq1i1xTnPSdtzazX3w2xV4uUNbRNM/tmhBTeiXFCanSsMO
	2Byk8J9sQxtTz1VuYpkt8r8gQNY7yHnez4U6dYXwjnFEOJk2KIuIuPLeZXpr5FYW
	315xVYlY/8iTDl0xGefjhe+DiTeNX7Oq7sFU33QszNDIJJ5bGQ282QtfcZHgKXlx
	FQFDVms4MjDzXdnKxWiXJmrfx8nI9yaaSypS5p3VMjENRIuLi1+s6QslOi+cPcBn
	BmopApZ2moqfGPDnfIhaiao9dac/xm1eZUNH5s0Uav7quVm8QCvXlFfevFqCXf2L
	GZJk++0lS4VM7ag5dAiGQ==
X-ME-Sender: <xms:GpU9Z0XuF_Ch0cBobhacFRHnS-MS1oT0gOy74IRpta0zmSkyAwKCkQ>
    <xme:GpU9Z4mN1H90VWGbqHJ_9MVSvJoExQ8hsiyZPOX3q85L6ZDkiPj4w2P72ACGQ8JTA
    _Qfs2OGuLFzKrb3kw>
X-ME-Received: <xmr:GpU9Z4axVaTPv0OjttcjsLDlaY_qVWzB-dMouXaoi__0FJqClGatur8DyAZVWxWxWpgnnnmjb9_02boqOvL9JyGdSSoYTtyZQad9Wwoz2e7-Jw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrfeefgdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdej
    necuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrih
    hmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteekudeh
    jeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:GpU9ZzVmZhapyWdKCwWrde97P2Md73SXd7h9cRjenBF0QFh4iTejgg>
    <xmx:GpU9Z-nmjPTzH_W3rGs-39zIsMMcWdQ3v7k5CCs4dC6yGO6dxLM8oQ>
    <xmx:GpU9Z4dDJiWHAXGzxPVEjOQ1T9sisOVO04RXW-FljP0dPhuWAIb_cQ>
    <xmx:GpU9ZwGcB_d394NtjEyIksZhIYr6xr7FldwsfMU12OP2zR4YnUW2Ew>
    <xmx:GpU9ZwjzCg844bheMsF3BAN2nD8V7v7GdFK6Z8eZTYuiP7t5oNjBrbhg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 20 Nov 2024 02:51:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 21266bb4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 20 Nov 2024 07:50:59 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 20 Nov 2024 08:51:39 +0100
Subject: [PATCH v2 10/10] reftable/block: optimize allocations by using
 scratch buffer
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241120-pks-refs-optimize-migrations-v2-10-a233374b7452@pks.im>
References: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
In-Reply-To: <20241120-pks-refs-optimize-migrations-v2-0-a233374b7452@pks.im>
To: git@vger.kernel.org
Cc: karthik nayak <karthik.188@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>
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
 reftable/block.h |  1 +
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/reftable/block.c b/reftable/block.c
index 3fa36c002a0c1852790780e74a6e055161f857d9..1aa7e8cd3cbf0980f6bc20262be89e755d0a4b4b 100644
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
+	err = reftable_record_key(rec, &w->buf);
 	if (err < 0)
 		goto done;
 
-	if (!key.len) {
+	if (!w->buf.len) {
 		err = REFTABLE_API_ERROR;
 		goto done;
 	}
 
-	n = reftable_encode_key(&is_restart, out, last, key,
+	n = reftable_encode_key(&is_restart, out, last, w->buf,
 				reftable_record_val_type(rec));
 	if (n < 0) {
 		err = -1;
@@ -143,9 +140,8 @@ int block_writer_add(struct block_writer *w, struct reftable_record *rec)
 	string_view_consume(&out, n);
 
 	err = block_writer_register_restart(w, start.len - out.len, is_restart,
-					    &key);
+					    &w->buf);
 done:
-	reftable_buf_release(&key);
 	return err;
 }
 
@@ -569,6 +565,7 @@ void block_writer_release(struct block_writer *bw)
 	REFTABLE_FREE_AND_NULL(bw->zstream);
 	REFTABLE_FREE_AND_NULL(bw->restarts);
 	REFTABLE_FREE_AND_NULL(bw->compressed);
+	reftable_buf_release(&bw->buf);
 	reftable_buf_release(&bw->last_key);
 	/* the block is not owned. */
 }
diff --git a/reftable/block.h b/reftable/block.h
index b3f837d612a8f0fbe98430b04e2dddaa975a15ab..d76f00553073c10185e716e71e2f415ce5dcf7e2 100644
--- a/reftable/block.h
+++ b/reftable/block.h
@@ -39,6 +39,7 @@ struct block_writer {
 	uint32_t restart_cap;
 
 	struct reftable_buf last_key;
+	struct reftable_buf buf;
 	int entries;
 };
 

-- 
2.47.0.274.g962d0b743d.dirty

