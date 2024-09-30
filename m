Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3F5A185942
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 08:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727683754; cv=none; b=TX7wZ3cqO/3L+nXfQ9G6BOMMdG7MOyZryGPNrsucO8c9E5YLx6vrsEpCgOFFa84yJswatXgi/Qutzn3V0vhBCsYQR2pBvQcMzNvPuuJ51vWFh04k88mB8kpz3evt7uiu3D9scsm0q9lWa5JT0PLabIIdI+Eil531d2jzxepnIzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727683754; c=relaxed/simple;
	bh=jyIZ73vAI1ZKl/2cMpEVDkUKyclCCSiJ9EyOfE+HP5A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eatik9/6HpQWN2cRxAV5EuiTRoi9RjdzxrFQT1+JEY++uW2jZpNJky4suRL5ZSZs2Wsb38dM2zDLtL48GnlyxcoRP0U5BUNupmh9uQvYFpoMeuHzEKsBjSWR7PuDzEkhyRYh/4vv9+bij/fptJn3ADMhgtf5Nk+w3zbII75xMrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Pup6T6w8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YtoQhTTa; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Pup6T6w8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YtoQhTTa"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 07A31114020E;
	Mon, 30 Sep 2024 04:09:12 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 30 Sep 2024 04:09:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1727683752; x=1727770152; bh=12iQhbhXGh
	FPA9rfY/4Fl8xjqxtLUu1G+pbNHIIA5Yc=; b=Pup6T6w89aj5otTY3BqpTzfl0p
	gpcDDzzMjb4t6vch+DXqzfAHiadfH6SGfAh2Dg4Wu6NidrM3tmTMIADZuYTDxDcz
	3MgNTOytq2oD73Lr2GPWmN765J/NtwqlsZiMWUnw0sMoPKZl8bQ98eHhxyQyAQqM
	bHTbC9s6nbL+Erevh3Bb3bL0K1+FbPdvsctgWUQ0TKYDMesEK5Nf+780dRy9aeFT
	Wt78rGjoneoTLskusqG71o5xFz4GVIFUI8QuWYPcN0B3WbT0hKQS1XBAPgQnvTvx
	/avqinbU8ySl4BBSrSao5K3aLd0eDKJsjXcamaG1ampNIZhCnujyz4P7iPgA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727683752; x=1727770152; bh=12iQhbhXGhFPA9rfY/4Fl8xjqxtL
	Uu1G+pbNHIIA5Yc=; b=YtoQhTTaUF0OTlbxb5VYO6aPaf8nj6Z3TitiAOVEGgR9
	B3bjqdIttTeD+p3IOuZbEsqP1GaL3bOGDCqXY2HMyfUvESunc/SKasBoLMUBtAp2
	XwdE654ab7VUV7WBlKFiM85QDrHw9ILTV7lJR4tvdj4IuaetxIrZAkN3N72yBHEw
	jxRzEMwFuhWXTIhe1EAqOwaAi0yfo/bkYQDkijRJMEvMXO7V0nISziEt/YcnuozX
	QAOElw1GpRE8SJe2HOPFKvVv7GJ4oQWdMyruLm8ris6CPoILBDIqx21lIH8XWDQR
	Xn+MGN0wDo2nsRLJ778Q0x8pT/1jxhDFGcX8xDGH+A==
X-ME-Sender: <xms:p1z6ZqYtNJuSMU6QCXqtzpfCQz08susJC6cp3SnOECh9zGK2A7Gnvw>
    <xme:p1z6ZtavOEcq32zI_QzQd3B_sNI4ex2PBWqyrZ5Y0pFK0edb95Tl8b8MhoxnYN8gm
    2vR7YpCd9C8TuOikA>
X-ME-Received: <xmr:p1z6Zk96xeWAiMbjYJ1owz7vezOCDEU4nazbSHknKy8ROJrnKhVLoya5tYmeGi4aL-3R_m438j3FlVzaLe4niQg1JG_-Na_GyaVuX0aCGVMl1ws>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhecutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhr
    ohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenuc
    ggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffh
    ueekhfejvdektdenucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhp
    ohhuthdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtg
    homhdprhgtphhtthhopehlrdhsrdhrseifvggsrdguvgdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:p1z6Zsp5r8jbrArkYHVH4ozDeHjgaGlxAG9dyjkDyu4x-5_qUipuLw>
    <xmx:p1z6ZlobnshfgKHfg3ZnEWY1wQP23gJgg9c404WAHL1HJ0FVY_N_Bw>
    <xmx:p1z6ZqQdwzvShhjjT6iKNDXxBmqD9d3R-nGq5cP9AJNNB8G2nBZ64A>
    <xmx:p1z6ZlqIgrz4s2ueb3EcyP9ZXO-TMSg5nPlrQYEUrrYqEPiQ_BEoDA>
    <xmx:qFz6ZmkId0-0RYg_8Y1d61pCOWlwVR5JvVjug_Bn46aAUT4jbOS8_nEd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 04:09:10 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 612be145 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 30 Sep 2024 08:08:25 +0000 (UTC)
Date: Mon, 30 Sep 2024 10:09:08 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>,
	Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH v3 20/22] reftable/pq: handle allocation failures when adding
 entries
Message-ID: <a66937b7afbdbf7eb33c099056a6a0117844cbd9.1727680272.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
 <cover.1727680272.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1727680272.git.ps@pks.im>

Handle allocation failures when adding entries to the pqueue. Adapt its
only caller accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 5 ++++-
 reftable/pq.c     | 7 ++++++-
 reftable/pq.h     | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 741f62ea63..2c20845d62 100644
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
2.46.2.852.g229c0bf0e5.dirty

