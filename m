Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B881624C0
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 14:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761056163; cv=none; b=eccsRiBunc2gj2qpPrPcACWUZp3z+t4tJxO7wCIxxm/eYrh4bjBb8hEY/rFEqd6WiGgT/9FqJ7VWeIZVLsN6xvn0gHrrNjDPfe4aN4DttH6qRu5+MEEaLbpJvG0+m94EDOlcDiUOi+ifAqoSx13TZ5aKKF7eR+8r+VwOtLiPxjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761056163; c=relaxed/simple;
	bh=X7Ln6pkaIYyDP/1lCGE07h/Ybx+rvG3ebtTzHXnqPM4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mkeXPkW1V8ONQqTCsBExqEAspJvb0G/7V0K/e9jlFEIuvN1cdPm6f+wTxrinKGTcb57ZjfNFnl8AyYP5nOYdP41JSO6RbKRIOUQ0u8UQZJJSwoU+ls8yNenLVa8sG2qw7Ctgw/8kZRMTKJZGzpDfroz7Rq9UvV16qK8l6hOK5rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=e0jgtkdQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RAFFB9z3; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="e0jgtkdQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RAFFB9z3"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 343F3140018F;
	Tue, 21 Oct 2025 10:16:01 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Tue, 21 Oct 2025 10:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1761056161;
	 x=1761142561; bh=+8jLgDIeS9BzjcL7hTC9BGLPcCKfyvk32ziKDf/933M=; b=
	e0jgtkdQv8aJMsXbkzeXuiwWbW6kKLkPCcptCTwZqREbyLwCQsIRtrnrKapy0XpM
	5amA0PLC/UbCPl7JW7kakPpKDIHyWGMaC1jyiVgOkifjqgkLeEaIaQ0lpc4Rx5et
	xjfS1lcPyaS5dOn1AaUfrcGbOHF8qP0H4GcKyX3ZlQlnW9rmHjh66fmNkCkGRDc4
	KNM3/7cjQDrZfh1JnQildI+L16GLUil27tE7tdvgABArAWn2hjW03xrGukvlADAI
	ZXGCrNghE0GOlK6V4q3z1lwyl0zHOI81vDYjLbDOxPcUkzMkwrO6URxbKigLLvDj
	mi0NuRODMsvko584neMpcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1761056161; x=
	1761142561; bh=+8jLgDIeS9BzjcL7hTC9BGLPcCKfyvk32ziKDf/933M=; b=R
	AFFB9z3bJbFwbJ8xJiwfLZ5lSI7IPbizKdZU+KoHukMsghWBrBLfq9Y7uMYpaUtx
	xbBjAX1LE6DsfxNGBFFmNvL8V4DuA8/wyZ/hnl8Xddq523YpTy8XF/OVHt+4gL29
	dc2zXt4cr6tSKLy8gkHhTkOT9Vo/1eDUywoIrV524qtPUyIWVcXnqbTilXop/amr
	eAy1q6FbAre0rirI5pxO4NKqpIPfC55X0MrMycoD+d6Hkm+uEh9zSoPQwyMgOLLH
	G26vLKBJHAeN5z/bVMVJ9JFuf2kWm40ddnbo1anfMWHCgcRa2jqxsp8bfw/fGGG3
	t7sNRmkWlSRMqYEiAXOiw==
X-ME-Sender: <xms:oJX3aBsfxQARwX6be-cJZp2QzA_nD55M1U1v6bAWCsTFK0ZDCxsicg>
    <xme:oJX3aNBgeLe_Ue38mpD5fGQ7-7W8J7kyEdFuqZDquoMjzgG2knEHLO2RUz9Y1cQm4
    yrktH6ooBqb3TegFYNOfgNrbJdP2-38YfqRCTrLLnFMZoCAqjh7QgU>
X-ME-Received: <xmr:oJX3aIbtGWzZ-21MBVyO1cuKZg0HSC1yvpqKgNKzCl4f3JLvI5sKXm4f6n-kYfEm5fut6MQr2Bpmg_R9rMSE1rjLZ8BXxKDVGWNuXhroM6AJBQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtledvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhorh
    hgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgr
    uhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhnrdgr
    vhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtoh
    hm
X-ME-Proxy: <xmx:oJX3aIU7hYuyBcw1dyr6rtxUYLK6PwaHVhak6V_xRJ5sWKbqoZQ2Pw>
    <xmx:oJX3aHMFUNFdJNpnDQemsgFfXEPD0Z74YFgE7iwNYjltPF9ePf9rdw>
    <xmx:oJX3aCZandX36vavjdcNBas-IJQoM_VFvKrKtJgU6zf74XefoRYwFw>
    <xmx:oJX3aG-CDCtYPq2DkfpMouM-RR6Utwhxfbe8lCyXRKW43haY4YDHpA>
    <xmx:oZX3aDH9lVMlJC_eYDvsQqyA8tWI1fX3xG6YKybkW1VvtMBnxpTWpYMM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 10:15:59 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 595ddfff (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 14:15:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 21 Oct 2025 16:15:49 +0200
Subject: [PATCH v5 01/12] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251021-b4-pks-history-builtin-v5-1-78d23f578fe6@pks.im>
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
In-Reply-To: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
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
 wt-status.h |  3 +++
 2 files changed, 27 insertions(+)

diff --git a/wt-status.c b/wt-status.c
index 8ffe6d3988f..b66edbfca6c 100644
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
index e40a27214a7..924d7a5fa99 100644
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
2.51.1.851.g4ebd6896fd.dirty

