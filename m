Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31653320CCC
	for <git@vger.kernel.org>; Thu,  4 Sep 2025 14:28:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756996107; cv=none; b=YMp9hU8IN9hTTVbcjXnxf+9VdvkG3iGhCrv3+EeQSxHHW3txp26y4fbRLMUCDgzkluU3Yqufxs7RIwI759ZXp1/ZPStmg0kPLVz7l6ktg8nrUyz+0gjacg9HtTCWHXY8SubrTfhR2MiRYYp8u0CwVZIo55tdI1c63jLOiWKWiSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756996107; c=relaxed/simple;
	bh=Zftlwzm1xn8SlrcQlbmiO42LzeMfdz+Vqr+UA097o+w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nZkd+UbNYXsZXUlWEo0jLUlnBw7BNyv4cbtuVmhRPE87P93Q9KQSarOXYhR0xmqmYAGIeXBPWwV2o3imNXqC1FyiUdFsxt8l1vc3mIFs0kXFNCMdQDOzoHsibpcNk2fxrLQaae9sK39PLrgt7ThNR8Hyb4ajdg7yvht21DXqBEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=V+/J7zMU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Mb895AmI; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="V+/J7zMU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Mb895AmI"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 581A01D00294;
	Thu,  4 Sep 2025 10:28:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 04 Sep 2025 10:28:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1756996105;
	 x=1757082505; bh=oI/GFmZT8TemxeUot4QmTXFhZ2AwPVKOkTEEnNOorBw=; b=
	V+/J7zMUXYemYHMqQP3uzi8bbOSDEqWQ0UgKVbZrqUqme+fyyc9wcJnyWw9ToGaY
	tBPrcwCAfhRGK54GQjLiX7bAwOHU3fOIGIuNLCl1tFAjYbcZpKE160QadR1S7DVa
	N31sdp8xOoz+rOHRozWC9XK0nBTOqJQ+glsCI3xsba04l+5zgz6Se0mDuxvOx0Wb
	YyxHYDxMyx7CSXRdw/4Ez1d8N1Qrd2G19gTP9JGgSFFLvexdTlJXQtR8hCQjTTyc
	qVGk6l8GYmWIAETfBo3v0oo3QW9KH78AUvCBX75AeIrN6tiGt+1ruAsQcXCg4CBG
	h0tHbOgyMdf8PJIDeCmzMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1756996105; x=
	1757082505; bh=oI/GFmZT8TemxeUot4QmTXFhZ2AwPVKOkTEEnNOorBw=; b=M
	b895AmIoF7hLTMUiBkZ3ort0uO2g4xNwIBO345TBuYs5K1NhsEDDqc09XJhs+7bh
	11SBhIDaTjMO4DQ12jaYaLQDRBR34gByJiW90KFqwEWgP2u2G47mOVBy9LicJY9P
	lVwv+Obz2DpVDUYt206dG+p2ZYem9tsdMBnw+AjzmHfgD28Oz9S2wXvjOwJI9J1o
	YD5EMyytuljAde3goQnM9wjDrOPEsa9D2LW7EE/RhO/j7Nity6wyP6NWcmfNzkRu
	1tS0Uw4O7urGbU+FCKvr/xg6djc+SH4lAn74qGRxmV37oGik24WSYzOn9uMD3Yl6
	BrXOL3A8QkKz7cNBJAtVg==
X-ME-Sender: <xms:CaK5aEtb6X2F2VfL4dU5kKBwaapgEgunhqhF_G-doL4P4M_g74DbHA>
    <xme:CaK5aPAcyWLVhSwxPvJH9F1rZaeD5OL0gymaUnjwUky-6uiHWy7bxCmWMyTeRCmop
    in6hQEBja5x9AGrBw>
X-ME-Received: <xmr:CaK5aGNgkBvsK4VWWfm7nFPes6B8JYGyDSxu08r5i6gh-2lEK4URjHzuM8upKj9IVBR7TeWhaSvWOyeaTZISQSfi4iiqIQ9zY7-wrnx3d6C7VA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeivdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpeejnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprh
    gtphhtthhopehsohhrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehgihht
    sehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnvhhonhiise
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepgh
    hithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CaK5aIzQCnDb_pLLdtnbi1NHtncj0UbGkOVhOrDP9__qsK4fsrJkOA>
    <xmx:CaK5aGXzVWc8_EZ5FxUmFG2dQFmOBRuBNkXHny4Ve6Bz3OO2KV0Kyg>
    <xmx:CaK5aKO7O6NwBV7c_qQPxe7xKkq0RwwxLy2U4ma87gL8rls2pjVjmQ>
    <xmx:CaK5aIBRsA08AlIeC-EoRvggtjQwFKPlD6iEeXH_j1Y31ht6CKcmKA>
    <xmx:CaK5aM7JOx3QaukmDjn-WGE5UB_BvJWspE6wlGKou5kTSRUIJYKqS-sa>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Sep 2025 10:28:23 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 76b84cd6 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Thu, 4 Sep 2025 14:28:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 04 Sep 2025 16:27:45 +0200
Subject: [PATCH RFC v3 15/18] wt-status: provide function to expose status
 for trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250904-b4-pks-history-builtin-v3-15-509053514755@pks.im>
References: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
In-Reply-To: <20250904-b4-pks-history-builtin-v3-0-509053514755@pks.im>
To: git@vger.kernel.org
Cc: "D. Ben Knoble" <ben.knoble@gmail.com>, 
 Junio C Hamano <gitster@pobox.com>, Sergey Organov <sorganov@gmail.com>, 
 =?utf-8?q?Jean-No=C3=ABl_AVILA?= <jn.avila@free.fr>, 
 Martin von Zweigbergk <martinvonz@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
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
index 454601afa15..f09309d12e3 100644
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
index 4e377ce62b8..b262e345f79 100644
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
2.51.0.417.g1ba7204a04.dirty

