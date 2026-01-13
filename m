Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C43B38A29D
	for <git@vger.kernel.org>; Tue, 13 Jan 2026 09:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298099; cv=none; b=tS+K7YRUnbUKyQwrQaMwzm8gF8bmzEFiqVso0oqzVFLG4MvpkZIyYs09iyn5jZzlns8Leodc6G1501dEZxhePSO4PBktrbC/WAUJG3T/+woJlNJ6oGn36ZzADz5r4UDlv+lJcIAfbAOWxYFOYmUGsqwKGjfGzWEywTN6LalHb4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298099; c=relaxed/simple;
	bh=jwvT8wUzq+TTcJgO+aXsI+w3tzpagITrYJSlbbzYXQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vGJym4qdsHZvRW4+Yym74q4SOE7fQkDap2asg1rV/rnJw8jOtXDlaJoGagR1/a49YIxpv2XGm2yIDG8o4/tw+ESreTxuPWt6MH1NLjJuu7fW65Zc9Jx1mtrU870n6ELDCESQ0myNsYnUIz75C6d1xexKQ8feZDMQz3zpI1SD8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ToukkuaE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xA8DtofF; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ToukkuaE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xA8DtofF"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 436E61400169;
	Tue, 13 Jan 2026 04:54:55 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-02.internal (MEProxy); Tue, 13 Jan 2026 04:54:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768298095;
	 x=1768384495; bh=tfO7nnCv8CCt359m1gccIzSw4aWv2tRWbVPH86EndRY=; b=
	ToukkuaEL9QfKl7T889TorguITa6B0P2oB93Z9wBQTlASjjAwkUqWZ2QvvlPTMl5
	fXPOvCxtjEO1gj/P480tI9kSKpplEZ9OQ31axDZobC2DPt6GOSKvGox0J+W6oEjH
	2db9u4/rQw/OL340JxiovaRcujDG8EXbdlDybGDfc50DdJB1aqEuAfLQ0UM3XhNQ
	smdOnlhpivbQweBlXQo4wpWu6F943hvx91ZL6t8JZ7O5Jubtkx4vwJ93ouYj61/1
	6aqcAcfK34qfPwE8sY3iT3RHzM2xrNopBMekTf8K9DD7SEwLnqqSLiOeCMlfyTEM
	V5GNNM4KTk53F9SiLxStUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768298095; x=
	1768384495; bh=tfO7nnCv8CCt359m1gccIzSw4aWv2tRWbVPH86EndRY=; b=x
	A8DtofFkCCPOEh7G2X8W9IOmKigQMNuD3tMYLIRiWVia+2taZgx5fg44FLbN2ggJ
	1pDrDTEKX9NIzqLCTaWG+1eGB1eDr2kjIT+j6ZIQ8HEGjZFU7VShgSyv5eaubZ75
	m9td728bshqgw2exfkiEG1BUoKEG4NNty7f/X5QrI1Qi0Ed1Kpg3An5W1lDmGIhp
	d1W4gSDWig1s1Q409+yt5UmC9NnHDMLGRRwlQrlgB+lqkSlr0d1OYADtODFu8UsO
	wJt3S09xwRFmGC3b9T9mgUXhSiK4RH633L34ZK8QHSBvmjahYlTfnXLMeYmfDIAF
	08JYJLbTCsSJRrE3SvSBQ==
X-ME-Sender: <xms:bxZmaYcDV71KskyKEj6KA7IkFklkt8Bb4JU3RApX6-ohRlMZbor-Zw>
    <xme:bxZmaWA13dpI_ajkDaThYc5oAgAHiz9FqFClEiRM0zuN-Itv5DwhGVOQCV6q0BZus
    Wl983erYJ_cBO-uyJmyxT45YzsyAFX2Rtul2CPUdH1g48cQnO1dbg>
X-ME-Received: <xmr:bxZmaU4z9SqNHm5YF7Zdmluw0qoHjTA3QNDyDqHxPnYmWnUolz7SU82gdcQQwkq5-xJ7XDitaWvyS0vXfchs-VBUgelHeTao21ZR-WAUfA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddttdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepshhorhhgrghnohhv
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrg
    hkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehg
    mhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtg
    homhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepsggvnhdrkhhnohgslh
    gvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:bxZmaXcpFblzQYLJpbLDXyTpHpTOp8jHucgoMRn8nxnkLAlE5Kk5OQ>
    <xmx:bxZmaSsogoOoKtR1hbrPd2Uvk-HTDRsWgJcu3Air0iikDH-N_2JfFg>
    <xmx:bxZmafmNJGstTRyNR-CXO-LkNBLHWAXYgxWcNsGuLarrgbbYKZ0TTA>
    <xmx:bxZmadQ2Qw_XE_q1MIWzfAV6S278rzUDZk9mcT3a9d44GX6LYjx-Mw>
    <xmx:bxZmadckB9TV5FUxEPpmEt01WYt5S4rJrMQ5h2IwioTUMwKfBQRMzTZN>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 04:54:53 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c2aa8f09 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 13 Jan 2026 09:54:53 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 13 Jan 2026 10:54:37 +0100
Subject: [PATCH v11 6/8] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260113-b4-pks-history-builtin-v11-6-e74ebfa2652d@pks.im>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
In-Reply-To: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
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
2.52.0.590.g1f87b77810.dirty

