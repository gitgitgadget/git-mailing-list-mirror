Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AF21A0732
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 09:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727775771; cv=none; b=kl4dijiLBS9piyWTp/J5pUqazhrbReifYhsqDHeEP4tJp9m0kSRmQcm64FizejOe7fO6NNK7u1NrwhOvCK3hVwVpcaL/stU1ju/akegZIwvnHTUcafWrMwINhW7QpxckxcHPBgar50pFg21gRXIrKg7C8I+BKCw2nFp1s+zxZ6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727775771; c=relaxed/simple;
	bh=ALtrWnXStKntMaN9I3VU7mDu/QueCoZ80iWZMqKMWPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MLh4nzbeb6R/ey+lA68AOP1lxegzLiKONlLQDKAB88YyGsPLJZbyxplS9gaZB5vB4ePsE12PbAilsedAAvGLIL460diNeQfaLwCCk0+GxZrr11RcRonfv7P2z+tgD8H3DpT3bWENWMQ9zKe4FLC54n0DINNTYhpAoQkL0wBO3zM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=M04/TN1F; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HkJ2OeBK; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="M04/TN1F";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HkJ2OeBK"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E8C091141101;
	Tue,  1 Oct 2024 05:42:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Oct 2024 05:42:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727775768; x=1727862168; bh=0LCa2vW0ow
	hrUoXxBmwAC7H/BVRaPf+WMa+mdj9hfjA=; b=M04/TN1FEhJUJMRU8YLiy3gBei
	zUI/WbnK8cU48Syb5hUnP98xxNlxAWHuqcmuPqNck4hgiDbJjjnCuWhpDzoymYIf
	K0021i0JkePOClrnYIHnOOQP9EigHcsfSwUw5LWSr8bhd7uvoUaeCaVX2f0lUIP2
	Y8ZSNcTEWYtRK5k/okNmYMuHo/XGUdwTvOXcbXXD1FGoqbwolR9+7pu0IwMzA2ws
	OSAsL8CNXUmSgnTNgimp7AWsM16bhTbODGogvjr1RMUJtwUwgHOtIp8KfVbtaDtv
	uGY5ADysNBF+sbM1MSoGmuPTCd04qmEHo//ZBKJg/PvouoYLf+MR2ziIBWxw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727775768; x=1727862168; bh=0LCa2vW0owhrUoXxBmwAC7H/BVRa
	Pf+WMa+mdj9hfjA=; b=HkJ2OeBKjD3gzSN10Yq3oPGgtA03okDbPdyR6zJ28RRE
	IbVRFjlloTpjwVFczSIl7nBe4vPjyMdzgmdYgulFdKXHZpl3Dw7Yz7aYyBWDpemk
	cU5Ua9yHbJxxWmTEFKSKqPIZ5f69Vs1P0ZQkGjSNDqyRzVGNc8EAk4pcjsKcrvYx
	m2BeVu+YSZg7ef/Hpf9haeMzno+X14SH2sRwwFHnw34TUU8PXzwIcZV1/IbHgbqw
	9bmArqDqBQeI650I13F5BcIjIjfD59FMqPKl7S8BxsA6nI3qBmFRrDuQJWWfANmq
	r+0I8Oylrvjo9dqsVuEY6FbDQoQtWLOfgryqs3cwIw==
X-ME-Sender: <xms:GMT7ZtnL2QrdYX3DsQg_t0qdCdFOWYhuDvjLRmnv3blAekhWm2QvgA>
    <xme:GMT7Zo3d4q0C8PTFJSIvR9Hm4y9jDPivTr6Mstm4_nBZMAtqeBFYp-PKcslxR3Sxo
    -rOnsEnpgxD4DXtpw>
X-ME-Received: <xmr:GMT7ZjpbAVjbLBaXuI1tipiSmoOX1WmL8QaC2ce8AJDY1w-TUZ2FtDzXEYgqcezhESpY60t1k6w9cr7FhoKyKRnpgsXo5cR6tdgz__23Fma3pQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopegvthhhohhmshhonhes
    vggufigrrhguthhhohhmshhonhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpoh
    gsohigrdgtohhm
X-ME-Proxy: <xmx:GMT7Ztlf5VpxiHBGnEXVsqh_ORv7ExYpwPlnAtrr8sbJgc2QRxr6hA>
    <xmx:GMT7Zr2JFo6gxqiaraarHSSpnew25jGWOyw9kYT7zHVWcKqWv7jicw>
    <xmx:GMT7ZssPeyDUaXsZ7k4vRvSyHrq0SEYXELuC3ifAWCeCHYMkL3OtQA>
    <xmx:GMT7ZvWsV3D6ztIcJiS0I7PIz5DJ8yILPNp1XzzqceMgSgrhG2Nl8w>
    <xmx:GMT7ZmQFFG8SvbB5npAJa_sEgVpMT5z5Z1JJEfKGkec_xS4MMsX6BQeP>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 05:42:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ff4d9f55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 1 Oct 2024 09:41:59 +0000 (UTC)
Date: Tue, 1 Oct 2024 11:42:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v4 20/25] reftable/pq: handle allocation failures when adding
 entries
Message-ID: <3416004e0d73ec46be616ca2809bb40d4d10c44a.1727774935.git.ps@pks.im>
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

Handle allocation failures when adding entries to the pqueue. Adapt its
only caller accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 5 ++++-
 reftable/pq.c     | 7 ++++++-
 reftable/pq.h     | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 69790c345c..8e202a8efd 100644
--- a/reftable/merged.c
+++ b/reftable/merged.c
@@ -54,7 +54,10 @@ static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
 	if (err)
 		return err;
 
-	merged_iter_pqueue_add(&mi->pq, &e);
+	err = merged_iter_pqueue_add(&mi->pq, &e);
+	if (err)
+		return err;
+
 	return 0;
 }
 
diff --git a/reftable/pq.c b/reftable/pq.c
index 2b5b7d1c0e..03b9912282 100644
--- a/reftable/pq.c
+++ b/reftable/pq.c
@@ -8,6 +8,7 @@ license that can be found in the LICENSE file or at
 
 #include "pq.h"
 
+#include "reftable-error.h"
 #include "reftable-record.h"
 #include "system.h"
 #include "basics.h"
@@ -44,11 +45,13 @@ struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
 	return e;
 }
 
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
+int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e)
 {
 	size_t i = 0;
 
 	REFTABLE_ALLOC_GROW(pq->heap, pq->len + 1, pq->cap);
+	if (!pq->heap)
+		return REFTABLE_OUT_OF_MEMORY_ERROR;
 	pq->heap[pq->len++] = *e;
 
 	i = pq->len - 1;
@@ -59,6 +62,8 @@ void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry
 		SWAP(pq->heap[j], pq->heap[i]);
 		i = j;
 	}
+
+	return 0;
 }
 
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
diff --git a/reftable/pq.h b/reftable/pq.h
index 707bd26767..83c062eeca 100644
--- a/reftable/pq.h
+++ b/reftable/pq.h
@@ -23,7 +23,7 @@ struct merged_iter_pqueue {
 };
 
 struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
-void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
+int merged_iter_pqueue_add(struct merged_iter_pqueue *pq, const struct pq_entry *e);
 void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
 int pq_less(struct pq_entry *a, struct pq_entry *b);
 
-- 
2.47.0.rc0.dirty

