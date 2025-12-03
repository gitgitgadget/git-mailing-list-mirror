Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D152F0C7D
	for <git@vger.kernel.org>; Wed,  3 Dec 2025 10:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764758924; cv=none; b=t7+514a495YBjJHKNxQr/8UGcOBccub8VX5DlrVFp64mtkrtpv83BxbgG5RaE3CptodIBH2p0D+4FnzmGWmjw++/9eJHoeIkPqHdXJAJ/3TA1luk4utBEPieTmR73v6cSiiWmUWRyAHmkzJeRRAbMjkj/ZddytZvmOLNWyMwlVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764758924; c=relaxed/simple;
	bh=k69bPpVz/K8kwVxmCu3QKtDrHIsWAMbJ7/72WkhPrSA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=mwJZvZ5l+Ste+jIWsmgdbCtF5Q1BT2JPkcScfv+dJFsxxWYgKK0PKyKmK+DvxRY9AfqU3y08gylNLhuRHhUxWIWCHMaKZWtdXmAVnajJF3nRANWC0dhhUqRRX0OATniaDsI6k7YJwatylgnBBGEe/PW0oVvdQ2iNgCOdjoHlMXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L4uuiprh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=OgYUWf4J; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L4uuiprh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="OgYUWf4J"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9F0A14001AF;
	Wed,  3 Dec 2025 05:48:41 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 03 Dec 2025 05:48:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1764758921;
	 x=1764845321; bh=zzK8+WsdHCMHZWjz/zief92ELtagDisQ1O0s2iyBODQ=; b=
	L4uuiprhbmcsuRK9/Hxhu2Xzoms+2xEiQumFbvLTNmBmib++TBxttT3rYlFLFvrV
	Ruzpb+9JIOKH5BhC6BHQKKgPTNC9VxrjBhker2hjzab988u/RhtmW/Ng8Zb23A8I
	K4EqgBDl+yxmN2YZ3KS98SxLeSnxPMD70235OTgEJcmEzIPnTRwU3n0F4ljyRzY2
	ee+Y1/9SL6N7X0sukXAIAUoM5COfBcnBcPC853nKcnUyiVYjNUdtSD2Dd+fG8RNW
	Pzrgp+FXYBr6twEFCmGs5Y6ADqmeHUsgoLIX2WWe2qDNF5FSHiyx3cqcR8+BOjFU
	iW8WdpsWBlHyxNUvX9XY5A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1764758921; x=
	1764845321; bh=zzK8+WsdHCMHZWjz/zief92ELtagDisQ1O0s2iyBODQ=; b=O
	gYUWf4J1bvM6KbxNc+8nCfXFCgyCjDd5aQCGXlJHCQSs7Nc0Ep9MrdmsNxBY/h3Z
	ytDMikMKVAVzR3RkVJHiOxZyk7A6pZNI1Fwf6aKVoeaLXZ354X2rZLfj7zMpXJxZ
	nsqZOYDGb+jIzHckfXzchfuAZ8mebFtQAFrQ5FPRgg3CLbEzbcf9BMqqb6z1smgK
	dZigPcYZUnjejPvsOqg7KJE8I4zDz+vYu51hR7eEnozLjcFxyjvk77xvwCwZc2U9
	QlcFJ7BqA0ui9dKLBPi8dMxUuuWWe4/xrpP9PgeUooy+dF2xZw4BIbAQEeA5IRPo
	X1gygz34yEnVZJElZi8xg==
X-ME-Sender: <xms:iRUwaZ3l0EfvbkwvOpNs_Mvx_3W9Bni1TjRatJLNbP5SqXMnAVAo5Q>
    <xme:iRUwaSqyrEe6cqOCSRMq-88_Ox-r0EXsi6ajulkIMZQ_EkfPQtCKvK9S7LVJXRpD5
    -qjJmYl34kh7suoG0urlM1JvzZF0nfOYEHWkHAjvi-86DomrFodeQ>
X-ME-Received: <xmr:iRUwadhsb969_fZrmNdShzcIm27k6KGJZ_DGWNDWo-LssJEnG_nN9_o0Xh_p6EaSahqdzyYltj9g4eIQ9rY-gFOxfb_piw4-HBZxKgw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    ffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdr
    ohhrghdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhhn
    rdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruh
    hgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:iRUwaW8d6IVeDICDPOz4O14IHhtDNH5ogtwL1NMP3DWhrF-bCjAgTg>
    <xmx:iRUwaRVyGnQPHK0tvaCGw9jxPVH9mH1cBgEMnsI4sel1tbLGabR7_g>
    <xmx:iRUwaSAnv6R6I5XYMJPbZb9oEXD1LtIwjJeYZWKMbqACoCJCROhxDQ>
    <xmx:iRUwaeFkEX0gMT_EHyBw-yRScZXnvt9_e5tA1wUg0hrcJj47OxYKQQ>
    <xmx:iRUwachRBOp6LRLNMv4VEU9SDgvbPAfZVUa13twEa2LvZQQThxoD68Ki>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Dec 2025 05:48:40 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c5b7852f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 3 Dec 2025 10:48:39 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 03 Dec 2025 11:48:28 +0100
Subject: [PATCH v7 01/12] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251203-b4-pks-history-builtin-v7-1-9e9f849bfd0e@pks.im>
References: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
In-Reply-To: <20251203-b4-pks-history-builtin-v7-0-9e9f849bfd0e@pks.im>
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
2.52.0.239.gd5f0c6e74e.dirty

