Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2C205E10
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 10:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727866588; cv=none; b=YDg0whZiGfipiFIk9jLrhbuKsyjltPKsQGGN/0O4BqKWq6UuV9P4jD81IaPApXZnhe3HBz/yfoV+thRCzrsqi+7rmQIqvZphUaO2eYPufpQLDaQZ2aHf/iw0HYFSlUZSg2oglWOLiR17jvQKL9PaCXmvAH6YQbvdrphGyXfMocs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727866588; c=relaxed/simple;
	bh=ALtrWnXStKntMaN9I3VU7mDu/QueCoZ80iWZMqKMWPs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X90OoaCh/78VzhMU3vQKJTjpJzo5fc3cPVMQzrvbgYd9N8e25VjzwGiqzvyRUhOaD03FSmvO7R2A6T9TerFXTOOAx/QdtZXZDeIXQpDQd92xEwmZKPzbAyIki/g2MSgRhPiNELn1ol5p5bofLR9as9tJAj3V3UEZMzie7TeK0fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hD6b9lzR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JiNu973F; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hD6b9lzR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JiNu973F"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 90E5B11400F9;
	Wed,  2 Oct 2024 06:56:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Wed, 02 Oct 2024 06:56:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727866586; x=1727952986; bh=0LCa2vW0ow
	hrUoXxBmwAC7H/BVRaPf+WMa+mdj9hfjA=; b=hD6b9lzRwholC0RbpkBGnyOEXf
	c4ouRM7Haas4HliLiW8YfzeT63ua28MVIO/Qw339oRAZN6LfoyxfQCvubKRSyXyD
	XVGNHqSiUyP0TzqE+7R2g/eshAjkTTWKBtFIPllQWE8UzOLXok5n8OWJn3legeLj
	gW1s3U/uIaORePB+w08OIRWhtGwuEqWQ77yDhvcdfcdT8Ugtoq7XPegJ/vHLXfNc
	L+7a+/wnI4NAoblAvF+dO1EJ/pQjzy4FENzn+NtD9Y/37b/myDJrs29JTFvdS/hN
	6JdXxlR4tOvk8cuGJyFuPOj7TDGZObzlN2w416zxmz9gyQhCZUYwFX6zqh9A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727866586; x=1727952986; bh=0LCa2vW0owhrUoXxBmwAC7H/BVRa
	Pf+WMa+mdj9hfjA=; b=JiNu973FSBEE1EVmCaqn6GMaoBkk9Uz5xrCglCsddJ6F
	HcZVXOowUQnIGLGBIhL2abo2gALUFTfS4/bOZ4noRV2JUatbkKzgCJctPCoCVKg0
	Aj307vTV7PS7Y05B7PIuVzC0IGFq40pJLJz37HPhREV4dgE8ChFVusYIeQ0QfN4T
	6JMetTIsPmW+iRubtwRO+qxXjhfUJAsAWkUAo8aX2bgESPpu1AKC++qEyIV+IeQq
	hqqpNJbDvz2Gczl3k2Xb+7WBdNs7SNpu7xK7FckuJra/ChWIPtyD4CMhhCogTmBN
	0OJixr4HSkCFYgb8fdtpR3FaIkc35NES5MCrPoPYbw==
X-ME-Sender: <xms:2ib9ZoMt9UWljimk7mYQpxtFqByCNJDCSrUAyxNZPkRHobaab2sW1A>
    <xme:2ib9Zu8uAueWTXmHJiHyTT_cOZ2zw3SnzQDtFIO4iKvgL3GU4NdUcfRqSVJIu-nYo
    7_bS28YeBS3vNDc1w>
X-ME-Received: <xmr:2ib9ZvQNzc8Cxp1wqohqvBvAb0HsEKNVHYKUlU1yC7GpObrYlkclgp8xw_5HmsCWM1A3IO6LArQNvjT7RLOehvLScLG0lp9oNTKSv5iKIz0PWoQ1>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduledgfeduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomhdprhgtphht
    thhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrh
    hnvghlrdhorhhg
X-ME-Proxy: <xmx:2ib9ZguVq26PrNO3pF06FacLcWuJ5J2y_Jm23HEv89T4jfhnxDFQmA>
    <xmx:2ib9ZgccXnMnrBUyFwAstEqgPJ2sYZh1ng44MLwpwuSnodFLk7cBaQ>
    <xmx:2ib9Zk3VmhWUXqLVCwVUcZCgV90xTsDJioXvaFb21cINbI4oCV5xyA>
    <xmx:2ib9Zk-RKSpXSzRsNBxQaAaoRsYT9MaLdeUZfmiegAi1OlVNq_CGNQ>
    <xmx:2ib9Zv5a-KYjmRzox__aLUZcoaHVvPH6ItKsvBXhvR7i-fyMpk0P394d>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 2 Oct 2024 06:56:25 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01d7eeae (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 2 Oct 2024 10:55:35 +0000 (UTC)
Date: Wed, 2 Oct 2024 12:56:22 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v5 20/25] reftable/pq: handle allocation failures when adding
 entries
Message-ID: <3416004e0d73ec46be616ca2809bb40d4d10c44a.1727866394.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727866394.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727866394.git.ps@pks.im>

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

