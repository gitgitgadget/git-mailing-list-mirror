Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2F0E2F3C1A
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 11:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761564846; cv=none; b=fkMvvFg7HShfUe/oiCS148nscwZIE2h2+4lV8xOZxIZBC7iolS74FvsSMsFMa5LOrK/jJyTPpiS5b0sKNnZKznlb2nrAznOKgRltyyOD9pGnTtiUVWi5Ud1Pkzwd229RAIzKP3lDwEmfiQRmJsR25OZ/RC8sdR5bRXUtZheDWjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761564846; c=relaxed/simple;
	bh=d7xV2QzcYf3VSea7KGHsHDDj2jt9vIGFSCS4KQ7ie/U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WG9JyKzEND6c+K3YQ7HsFei+ZyQBkSQavkeE2Pe0qzkOcENTaXidp+Mpw8Q4QPdmAKP3ZTJDe3pE7j0u2mH9KpgR25DlJCIZIPATTSnXu16rGhvAaSL72P93FQA45/JiReybDsLZBq+PdbI4c0ta2cvA9oyvxdn80fa0Q4GnuTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=POx8kHrk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tAgA7DNW; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="POx8kHrk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tAgA7DNW"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 325B114002EA;
	Mon, 27 Oct 2025 07:34:04 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 27 Oct 2025 07:34:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1761564844;
	 x=1761651244; bh=/zhpl1pMzW5zNHJYUtlnHKVMYMJreXqoEBClN4l4BaQ=; b=
	POx8kHrkbR9VCPa8A8ejJFwP4AodThQky3gOR/NAsy4MzxGCO2tOnUVYN1gFnVuq
	+MZA7eyRHwMRImA2D/yIYjOeBVeq6Sg/MWyunh04SOT7UkMYdhW2yxXOVghCosi0
	wW5JV7UHHR0Uth43r1WCo9xuQA4GoNPCXGyRUTwtqq75fW2rMq6+hUrb34tmIsj4
	0W8OBNJqu+EBrSqTcR0HlM4euMW7sLl6NgUJFitKg6pbEOvtYRY+mRA9wr2wwE1H
	bEkiORXIMwik+e2uf0+u9T8lbkfi+eX+vkTSzVGvR9zPftGWMMh11Ut7WHDHaqCt
	S480GKtkJrNdEqns28NaRw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1761564844; x=
	1761651244; bh=/zhpl1pMzW5zNHJYUtlnHKVMYMJreXqoEBClN4l4BaQ=; b=t
	AgA7DNWDpwWCTpfzA7J8tmjfHegnnhe2/rAQpzFtn8mBEhqYkJLQB3HLCNXUQG8G
	DM8EoHHYNa6Ooavs8IzahiICObVQY60uksaKzQ36rRb7pOTUNnpTqBYCZfRXJH5s
	poL+mZajetQhdiA07bCvv6HR69MEt77OILPjlk5oXmisoF26u1j/TL4kiDs9MONo
	y4Y8Kpm4bfKovZ90KeDI301MHazFpfR9TSeeJ3NO5kUxdPaGPcYVo5UhAHaZXjio
	ECZ5AsvxANyCKB07DcKN8dmFuCKBi2tolFlSUhvmx4brtvkWg/iC8O7c2DNICMVn
	+dwffT/6890uCBBX9ByFQ==
X-ME-Sender: <xms:q1j_aMLpnIefiFAjyJp9AUOCn9KJbGE1AMkGaFeKuv92vZi4n9cd3w>
    <xme:q1j_aOuzX6U4ga21k0NiCUE2qMFWP6W8c4AHk2bybqqxXf5Tjp4JkJS9iDjqTN1L3
    dhI7IC7jQulSNep0cG4CMZpOjYG7x371rCIehtoaM4jMM4vJqhf8Q>
X-ME-Received: <xmr:q1j_aAWSJpM4j8_MiwehT6VKJwc9ZVbEq8TYKWFM40lavTG3yGcYnLZydYfkHa6aSnIuC1EUxCIHCq61P7OMz4vNEvHEJ0ynUuf2dMm0MQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduheejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnh
    hovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtth
    hopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihr
    vghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfh
    hr
X-ME-Proxy: <xmx:rFj_aJhfxU7xxf3GS1w43HE5QZlrRjXUfO7rFVa6D4lugm5tgA1jUw>
    <xmx:rFj_aIpzjE-5_0wcRE8Scdl92Uso_YQ4Mip3N-CEiyDFuW68bEzeaQ>
    <xmx:rFj_aPHjdE-EII_28tvu-Rfq2Og_PP_g4xsj1_V24YSAraT9bJUTuw>
    <xmx:rFj_aN6PwsLNsX9OA76hGAi0cnooNNc4cJIrhZcdrGMIAK8-j2gtuQ>
    <xmx:rFj_aHEtsLYSFFM3Ja6E2m-g-_-hPixmEemGlY0nWLxf1uxFRtR37Hj9>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Oct 2025 07:34:02 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id b9cf0aa1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 27 Oct 2025 11:34:02 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 27 Oct 2025 12:33:49 +0100
Subject: [PATCH v6 01/11] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251027-b4-pks-history-builtin-v6-1-407dd3f57ad3@pks.im>
References: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
In-Reply-To: <20251027-b4-pks-history-builtin-v6-0-407dd3f57ad3@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>
X-Mailer: b4 0.14.3

The "wt-status" subsystem is responsible for printing status information
around the current state of the working tree. This most importantly
includes information around whether the working tree or the index have
any changes.

We're about to introduce a new command where the changes in neither of
them are actually relevant to us. Instead, what we want is to format the
changes between two different trees. While it is a little bit of a
stretch to add this as functionality to _working tree_ status, it
doesn't make any sense to open-code this functionality, either.

Implement a new function `wt_status_collect_changes_trees()` that diffs
two trees and formats the status accordingly. This function is not yet
used, but will be in a subsequent commit.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 wt-status.c | 24 ++++++++++++++++++++++++
 wt-status.h |  9 +++++++++
 2 files changed, 33 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index e12adb26b9f..95942399f8c 100644
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
index e40a27214a7..e9fe32e98cc 100644
--- a/wt-status.h
+++ b/wt-status.h
@@ -153,6 +153,15 @@ void wt_status_add_cut_line(struct wt_status *s);
 void wt_status_prepare(struct repository *r, struct wt_status *s);
 void wt_status_print(struct wt_status *s);
 void wt_status_collect(struct wt_status *s);
+
+/*
+ * Collect all changes between the two trees. Changes will be displayed as if
+ * they were staged into the index.
+ */
+void wt_status_collect_changes_trees(struct wt_status *s,
+				     const struct object_id *old_treeish,
+				     const struct object_id *new_treeish);
+
 /*
  * Frees the buffers allocated by wt_status_collect.
  */

-- 
2.51.1.930.gacf6e81ea2.dirty

