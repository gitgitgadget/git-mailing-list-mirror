Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 618B2158525
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726489764; cv=none; b=RJMRQM02EDMpAszGGaZ/cMCoey/qcVmEwykKWpnAfH04qQecQsxOMgPi6rBpy0eCYmrl4tIQVgkRmBWrF8rBeGE4W9LTiYJ9IXDKK6D/NQ2FPQMgZZfgZPDAWSE3K47knpuVu88Dnsgfg/R00sxUKpDfkEo59DYLHTugkqBA4EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726489764; c=relaxed/simple;
	bh=iiei/XYewOEuB6UqcZJPhGhEil7VsuSUTckifB/BgrY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mxJbzbb5xnYqgegW/Y5HcbVb3w8l7ovVS075UzULjemN52nK1wk5IX5K8bKE2dkjBOl17v9GlEfi+A1us4uZHWIjV8Sd1Pj+HQCSJxuQCTwwsLzVu8SmgQ//QB31GZYMC2qp3fwOuoKD/JWPVGT8Ny6uYweY8dmCXT+HN3eK5xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=U+DLRfjV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iaAimOO6; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="U+DLRfjV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iaAimOO6"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C1BD31140125;
	Mon, 16 Sep 2024 08:29:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 16 Sep 2024 08:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726489762; x=1726576162; bh=6QGbLLApFc
	3EWXwVj6NlyTxyhsPEYyPuZ3jUs2aFrmA=; b=U+DLRfjVjZhgfeldV9kJWXperk
	8wxo5UCbCTvU5sPI6G8TOEIYLVDO83p0qRr/FEtK6KSJoKdKGVkIch2edy0ZOVEE
	amNNJn635f9ToZKU8It3YmFFKo6BP1drMVvH2QLsSFVdFkTBtMelTb7KdwMjsQWs
	WkI7sFaOFq01tHU6Cu1+Fg+nx/qN+3UXSZhrD4Lm3bOWFqExYbpTitYVJSNpigDm
	Tf1FXhWpFnWVsaA8HVceHxP8Mmk/kvAYDxmgwEJpaeCOYCZav00Socj93+ZQ7TeV
	cuk2ZZXLuzwLSCkOL12KNJXWU0aKfVodp1jJDPQQrZaOuladIGC2AhwwDzsw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726489762; x=1726576162; bh=6QGbLLApFc3EWXwVj6NlyTxyhsPE
	YyPuZ3jUs2aFrmA=; b=iaAimOO6Xd41+lR3xy+A2jYcT0eaRdlUpS4SFyzdYsbR
	6XgfVa8fulZckoFtH/j/VSpQQEzNjmIEC/mtZsR0hb1wssVNNNUNtz2tqOa1BuOs
	EQJ/Kz2j7hPCjm8nS6d1ip+2JkLk+7DdmwRSGbXFxC7nOYb4VcdXZXNwtL64od+m
	Lasv5aY58LuskWI/sqYwyZJ62k409MvOWXMbW+eWGTA4hIgTdFkevvLwOzv6fd9F
	r7jqIq6k+GbzG+BdARhPLwJLl+9C0nVStvsZYvPdQVIQdEuyrqEVkbO53XbFzCSY
	IAdPmepbGO343mxQ7ARjIoHKLAXkostzZZj1iAfcIg==
X-ME-Sender: <xms:oiToZiZ6QTG2gY6gdRGZ8823EgRodK_7PPB9N7Ly8gqeb43eSkaIUw>
    <xme:oiToZlZCnaPGOBw5mS_0-5NKd1xb1CrdIjcJIYNwJr-D2jlNxwk3BhFuH5nc-sx1G
    4YfKveYb7HLMzpBSQ>
X-ME-Received: <xmr:oiToZs_aNqarDb4QvtxaX8NqYU2ljBPdTbfGueUvxnxDfSbJTRFvF5-isVo4QhB6zz7KjK--6WDLVd3O_rV6vQFsMWQqkTDe4UrdmRPMjr1F_BLK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedgheduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegvthhhohhmshhonhesvggufigrrhguthhhohhmshhonhdrtghomh
X-ME-Proxy: <xmx:oiToZkqQqIsNoplIkhQZ7-ZR4cv9ZPmRBtO0uMML2R6ZvvjlEYJy2A>
    <xmx:oiToZtqv41QRoqsNCHVEb_qgAogU40nY3baRDjyUqVcPX9fj0Q-J6Q>
    <xmx:oiToZiRYzl4mgcu6t6QyKZgSK5EwwhIlqCvM9jMVqO_eVHCaF1ybpQ>
    <xmx:oiToZtpw2axK_sUEQWSokigoj96J3FFw36GTJcJRrTucfrfceHAMBQ>
    <xmx:oiToZk0e3-imlX3PAh0G3i5tH3bmg74K-D_4t5uS7jfEWNe9wEKPG6ey>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 16 Sep 2024 08:29:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0767b900 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 16 Sep 2024 12:29:04 +0000 (UTC)
Date: Mon, 16 Sep 2024 14:29:21 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Edward Thomson <ethomson@edwardthomson.com>
Subject: [PATCH 20/22] reftable/pq: handle allocation failures when adding
 entries
Message-ID: <a569c39fd8e663cca78dcb6025b36ab9366ab995.1726489647.git.ps@pks.im>
References: <cover.1726489647.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726489647.git.ps@pks.im>

Handle allocation failures when adding entries to the pqueue. Adapt its
only caller accordingly.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 reftable/merged.c | 5 ++++-
 reftable/pq.c     | 7 ++++++-
 reftable/pq.h     | 2 +-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/reftable/merged.c b/reftable/merged.c
index 741f62ea638..2c20845d624 100644
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
index 2b5b7d1c0e2..03b99122829 100644
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
index 707bd26767b..83c062eecac 100644
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
2.46.0.551.gc5ee8f2d1c.dirty

