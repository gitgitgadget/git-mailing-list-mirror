Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5950259CB6
	for <git@vger.kernel.org>; Wed,  7 Jan 2026 10:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767780633; cv=none; b=mgQL6jE/rALe+9NQ53Q9GPfyva3k8mgSxi48Q+n2rQosTT5SMR1v4nFTR3VfOp3+3Y3B03MsAK44UVoiII9q7Hoxm2CfVulnou2e9eoAQxwmUVHwbDhVTTbQ/79rFGLsG6a0sm3K+L2s3gfGG2ItePQVvtvqiHp43omUqVLSQZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767780633; c=relaxed/simple;
	bh=gsx3J7OxduvHoSrp8UypKKxdyIHo+YBb3gRsfO9kcPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RrqMfyrxdNxffGY/kFAr2AVRDSXk9SLSvKswqnhsTIp5x+l19PEBQREKoU4yJloMsOLNioqYY11Pi/BVBRDjc/BWCFkIVM69/R8H6zWCC7ptWQKGXaInVLMrh5bOQY5hWouA0n3YJs0L/HPzGbvil7ZsRi6+fDuG49Vihzgd/go=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MvEwp0RE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p6ZkPRnJ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MvEwp0RE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p6ZkPRnJ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 02ACB1400172;
	Wed,  7 Jan 2026 05:10:31 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 07 Jan 2026 05:10:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767780631;
	 x=1767867031; bh=PdHZ4sVjeC4zy04QfGRr4BEFPoQZ23lRRMzf+EkteN4=; b=
	MvEwp0RENZ6n1j2d3y93dy7iJw7BleYERtvs9pLLd1rXK3ZdF+p7WOFvM/bt8iEm
	YfYiy2vsrIiHd6fe5EzQA8kEEMdiZgBdjDRgUaoAfJzms0pb0pP1VBlpvytXyRK9
	ZdY0kNmsHM2nqBT8ryYzlcIZdg8e0jTZk26KEGrB8NldCT7mYmuwI1Rw1sThmoOf
	AwgnhdifEEwDe9vjxMrnKZkLN+z75+GwD3QAwzqM4h/kIc85i03S++vq21oOT20V
	aQS8x5wWbeA5WcPHT9suTDPxs7R5tahNOyRfzZkYw9dEmQI5h/DhkE3kqXWB2qKF
	nUacwR6fTjxxcXo0OtzZMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767780631; x=
	1767867031; bh=PdHZ4sVjeC4zy04QfGRr4BEFPoQZ23lRRMzf+EkteN4=; b=p
	6ZkPRnJCG06RZWyY87NvuNxiulWIjeCuthqG/hYsEcJ8DAfbV8cQkKNTu+yajMfI
	ZzaK5Sbq1hfrekRW+UHgQWG3aB9Dc+pZvZsBuiD0pdgMj4k3fyJipy5p9GJemJWE
	8aFrxnh+1ZZ41j1tx+AKwleKNpcaJGYe/9sNpRzOPcKJcUM33xU6WDM5AbPU0Z67
	3IQKv+OtboVUaaEvxFAMwUr+FpbK+NDIosEjSQ3E2wPt8W3tJfdTYFFGkpI7C6zg
	/ewgQxS3NTp9r48pTqUT0x9mtRE0yItk1l3VEI+/3s9oP1TjEEWMW9SI0WDrG+xx
	KALwVwX6dgtcxoV0bCLYw==
X-ME-Sender: <xms:FjFeaRo0uVZfSNy9m80p7KJJXObKBMtqTSyajZz5u3VKByeOBoXAaA>
    <xme:FjFeaff106IM7HBWjoUSwdM_9nyIZdT3qnsY4MY_EKFnbC9kc_UuFY8n8pUHHH1v2
    T0OTB1raRfRFIvuBYQP15wuS739t9KyJPxCiPgpahomf822lz41iA>
X-ME-Received: <xmr:FjFeaZndQH1wpfhd2rhZX-879EMlbJ3EA_BJEIxI6bv4jPU7JtbT4qcjn2_kaMLSBZTcdUuRZgTOQRGRIEiwm-tIdHZRGK04P4p29numFYg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutddvjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdr
    udekkeesghhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphht
    thhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomh
    dprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtthho
    pehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:FjFeaWYNcMVOAqXAr6_DoSg7wKPE907Z38mr4tHYqLbrrqFoTfRNWA>
    <xmx:FjFeae7uUdE3tyOFNqUgD_dczW1m3-6IAaheBBP6FJrTWpPqJAxIMA>
    <xmx:FjFeaQBh847qQeXt-3gAIY2pK9uGwse_ehdbFeZQHdpkVCtbBZEz3A>
    <xmx:FjFeac9aX7xJO1pYbUGkwKtHONGGN8aKzaW3qjm16xaoWhgcgdiRRQ>
    <xmx:FzFeabSozCQDNKi6sSVTM7yym7nHVEUeCbtbAxLFbUq1XZYnnlIZEDsb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 Jan 2026 05:10:29 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2940e3b1 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 7 Jan 2026 10:10:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 07 Jan 2026 11:10:13 +0100
Subject: [PATCH v8 5/7] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260107-b4-pks-history-builtin-v8-5-18e9779e3a26@pks.im>
References: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
In-Reply-To: <20260107-b4-pks-history-builtin-v8-0-18e9779e3a26@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Elijah Newren <newren@gmail.com>, Karthik Nayak <karthik.188@gmail.com>, 
 Phillip Wood <phillip.wood123@gmail.com>, 
 =?utf-8?q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
 Matthias Beyer <mail@beyermatthias.de>
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
index e12adb26b9..95942399f8 100644
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
index e40a27214a..e9fe32e98c 100644
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
2.52.0.542.g9473a8513b.dirty

