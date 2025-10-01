Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BAD1459FA
	for <git@vger.kernel.org>; Wed,  1 Oct 2025 15:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759334273; cv=none; b=A28olrg9s35R/S/BBG5UuFycYZvn6G1aPGtezgo8Fo7ZmhD7l1nuuNpYHarAb9mxHb48v4AyqC+DcubeSOhgKm5cdy/uQgqKh+gW00MsY6KOqYAkBY2+vVByLVyBSJ7pJ8mv5D8K3FMlTA2oGyfbYavQx6eB2itQHtbLhdpJ7qQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759334273; c=relaxed/simple;
	bh=1M/DKxhdE3o+a2DIBraR+3sJgRxEjQ/p6QFM4O0Z5uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FBnGVXLtiALSkX+xJv3azd+5IuZxq7Mvs/NSXZxvqt8cw9L74ySz2YIZr4GS1xlISvvif6WPE9NfO/8tkRBOhXemeVAzhKM2Kn4kH2QYd7SsgSjUBcQMxHQJkIKDopeuQIcASnRDcd0OqEMQLYjJ1p+O6dXCn8EsWneMa8nBsqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R26WZlhf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CkPCDdhl; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R26WZlhf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CkPCDdhl"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id AA95B7A0316;
	Wed,  1 Oct 2025 11:57:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Wed, 01 Oct 2025 11:57:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1759334269;
	 x=1759420669; bh=Mn2pX34Bl2RZC0j5f3qP2Xo3z22o3mAXlGPbWgUSJ0Y=; b=
	R26WZlhfgxbZTDaSt5M4KxNMsXsTDUODTi+Yl3pXwGmTtU2tYACagqOsTn/zVqsz
	m5mH4PnueVNFTdDydsk991PiybdaHwNiifooLxf9oCtoxc6QocH3A9nsDVWajhE9
	hem3F2hQ/ueZ6+xp3ixIf9rh7vNivC3tHbrei6oqHiNwD0x11COLHC/OMF1PLg7M
	T4c/kEMCeSaTV8i3Psk2goYbI1EeqzOiX8jGJxPxUypT52+PMfrvU4+V1ODX3KHk
	527NWkYjWz9+8Rr3Dw4G8ozIrhyDCkD+7p/b1l43fB7EwsEOX5kljNIK8VMJR+zC
	ClJ82f8dCrKPyCBiCgx2gA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759334269; x=
	1759420669; bh=Mn2pX34Bl2RZC0j5f3qP2Xo3z22o3mAXlGPbWgUSJ0Y=; b=C
	kPCDdhlNiNZTapd8Oot+3manAH3jwnvqF0r5kUTgKeiieZle5htMrrTAv5vmV8nd
	Ihfi7HLz49myF0XXZb18lUu8Jwe3zjh1zbfyP8WxsKChB7k7jFzrFMsqibps81Kj
	J277rRC6vZyZohsogSth5QtdJJ1OuY6CdjJDCOeRAOGD7eKrZ5IKBP8uE0gnLT6O
	ZUku2PCw+6CGGIjTXLuvm2tES/xvK9CpZaMQ0FIBU1+papiXosdA2dMwmq9By0rH
	+WAlUfB2DeSFuOx97SYO+K/NSsV64PXF6RHBykn9fdQsbcl08++QTtxO5cXQ/u0X
	j0v+IbVCV8oqec3e1scJg==
X-ME-Sender: <xms:fU_daIox16y3Qv2dyPabVqhdoxHevoeB-CeFKd1lvtLQdqFhfMCkKw>
    <xme:fU_daNsOw9MiUD8RADlfQuU5YTvNkJrB2xYz1EvKbHbi45Dix2DyS_e4udtOa6jtX
    FhvGU72TazqrN_0qI_nMe8qUapf6a7l_suYLtbm4NARdnorrifm>
X-ME-Received: <xmr:fU_daDbT1picprwxynlxDxnj392O2GgrX8g1WnTvYDtJDCL5RFOiF65Y3esx-994aikFvtL3WwCUGx7e40ts7yVZ9EkWtYhwhsp3FcrW1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdekfeehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrg
    hilhdrtghomhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnh
    gvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgr
    ihhlrdgtohhm
X-ME-Proxy: <xmx:fU_daMaP6xMcbGA-Ews4kzc3fVpjLie7PVFH7CsRLzMtrwR752vpog>
    <xmx:fU_daMmpPoUM7vnrPgFf7yLlNTQa1rTWejdUoAYnbGAD1F8DByQo2g>
    <xmx:fU_daH3ePLxorVOq787Rcs5DLJ2fI_5T0C_DlIFRaiwGxykrPc2GXg>
    <xmx:fU_daM1ZztnSrrZKsbwdGFYOUF-xsc7epW8_uIT4kfkq_heOQC0FCA>
    <xmx:fU_daHEY8sCeQqO62Dd1PJjiXywnM09DG5npmFDZklJvx1ElHRBnB-Fy>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Oct 2025 11:57:48 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 0cc56038 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 1 Oct 2025 15:57:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 01 Oct 2025 17:57:27 +0200
Subject: [PATCH v4 01/12] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251001-b4-pks-history-builtin-v4-1-8e61ddb86317@pks.im>
References: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
In-Reply-To: <20251001-b4-pks-history-builtin-v4-0-8e61ddb86317@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>
X-Mailer: b4 0.14.2

The "wt-status" subsystem is responsible for printing status information
around the current state of the working tree. This most importantly
includes information around whether the working tree or the index have
any changes.

We're about to introduce a new command though where the changes in
neither of them are actually relevant to us. Instead, what we want is to
format the changes between two different trees. While it is a little bit
of a stretch to add this as functionality to _working tree_ status, it
doesn't make any sense to open-code this functionality, either.

Implement a new function `wt_status_collect_changes_trees()` that diffs
two trees and formats the status accordingly. This function is not yet
used, but will be in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wt-status.c | 24 ++++++++++++++++++++++++
 wt-status.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988..b66edbfca6 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -612,6 +612,30 @@ static void wt_status_collect_updated_cb(struct diff_queue_struct *q,
 	}
 }
 
+void wt_status_collect_changes_trees(struct wt_status *s,
+				     const struct object_id *old_treeish,
+				     const struct object_id *new_treeish)
+{
+	struct diff_options opts = { 0 };
+
+	repo_diff_setup(s->repo, &opts);
+	opts.output_format = DIFF_FORMAT_CALLBACK;
+	opts.format_callback = wt_status_collect_updated_cb;
+	opts.format_callback_data = s;
+	opts.detect_rename = s->detect_rename >= 0 ? s->detect_rename : opts.detect_rename;
+	opts.rename_limit = s->rename_limit >= 0 ? s->rename_limit : opts.rename_limit;
+	opts.rename_score = s->rename_score >= 0 ? s->rename_score : opts.rename_score;
+	opts.flags.recursive = 1;
+	diff_setup_done(&opts);
+
+	diff_tree_oid(old_treeish, new_treeish, "", &opts);
+	diffcore_std(&opts);
+	diff_flush(&opts);
+	wt_status_get_state(s->repo, &s->state, 0);
+
+	diff_free(&opts);
+}
+
 static void wt_status_collect_changes_worktree(struct wt_status *s)
 {
 	struct rev_info rev;
diff --git a/wt-status.h b/wt-status.h
index e40a27214a..924d7a5fa9 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -153,6 +153,9 @@ void wt_status_add_cut_line(struct wt_status *s);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+void wt_status_collect_changes_trees(struct wt_status *s,
+				     const struct object_id *old_treeish,
+				     const struct object_id *new_treeish);
 /*
  * Frees the buffers allocated by wt_status_collect.
  */

-- 
2.51.0.700.g236ee7b076.dirty

