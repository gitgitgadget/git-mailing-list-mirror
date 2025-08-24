Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792182D661D
	for <git@vger.kernel.org>; Sun, 24 Aug 2025 17:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756057454; cv=none; b=TI13UrjDrJaPiGRa/fmPYHHt6CE6efBs4rZmAxoxK/0kxUrP+DD3orkbZRS5LXEDVARcr2vC76oC9+NCzkGhIBlvlAZxl1udq3Teb/ODSnv5cvIVyKEny+AYWNoTZidAys2QdUWsDF4pk272nJE1auqR4yj5QOiwDZ2BdsF7L3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756057454; c=relaxed/simple;
	bh=8ffJpPoQ4rfDjVCywrQQC3oM5iBnv9lGf00L1P41efk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hABhTGKa7C+ddxhKuRTbhyYP22dK6BKJw5DNPzrEd3+YdejZ/7JG47X6b3xllkIy3J0YEgbgf/4gv9W51BKYtjVb0yPyzBzI1/v5P8aPkbFiSmKfbakPRjw+w9seoJPm1iEs8ch+woHl3Ui+b+cm5aQ5usfVGw6w7gvv1hNw1Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gQoXpAT1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZeIQNDX6; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gQoXpAT1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZeIQNDX6"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B3D281D000BD;
	Sun, 24 Aug 2025 13:44:11 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Sun, 24 Aug 2025 13:44:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1756057451;
	 x=1756143851; bh=ew1PPjv93oZJf36zi9HESU2HHANQVXeCOJTs1tnkqWA=; b=
	gQoXpAT10+qG99bpBt/Owyg7w1+Slw8aSpmeunE7GZrl3xrywqBNzk0BtGrJLpLk
	IC1qsCxvU4cN6zq3W8F3142Uog0OsyDvFQ5iIp9Sx8ROPjhzrUb3BWCly4H+AYnW
	2+6TN6A4vMqog0nUx8lmgv8iGdx8lwXe80LQ/ScHqXypEYDwdPlGjVpSRo86VWO5
	4Li+44lAbaCq7BzKM1PwxL9M1ZGaxA9cuXl6feCygp+rvS7OEPZjnUl7/yl15ku5
	l2JDfIs08315oeBRLaz9H7cIJhxd7u4QWRUP4FARzUXwwcE2pQpHoMwTs1dHU1SL
	NxodcLtVcVk4ZM5M6C4b7w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1756057451; x=
	1756143851; bh=ew1PPjv93oZJf36zi9HESU2HHANQVXeCOJTs1tnkqWA=; b=Z
	eIQNDX6/a/hfpxN7NFBeu6/kW18IsVvqdFymEVQGptdbisV5LEubvT0BE2nTvX8Y
	36r8VN5ukstY0RuVAXwxKKzH6jAkr0DpcG9SYQDNEfMDbkFleZdX0I/02mBr9JcS
	xeUGrobk4FBlfv71hdQZ3QWGbaOX41BJl2FtK1El4saXbLIsPYuMq4zLl3X+R2ZX
	UgZXEwAD77XiSVJm4uWrlhKHlJ8EA+hfn6yHodoyi4uINIMqmKtpk/8E1n8KZU2R
	LFfWPuGosHfmg+X2dPSXm+9DQUFdSh+Wmpf5oEHeY1lkKL4dmmbqJIAQCv7nnJPF
	9EithHrxmwPp+TNQt6CCg==
X-ME-Sender: <xms:a0-raBM6cJKB7-V3CykxrDHBECp9iVQXiOt5awcN8X3xZXnx98ysUw>
    <xme:a0-raBiovRywmFEv5hJZ6AsWhzhkrhzSe54lbkkMZ4ZVrdMr0GxzNXPlqXvvpSJct
    0tUxMHjEcdmCUBDfQ>
X-ME-Received: <xmr:a0-raGuQlfbpKANFRdOkxISHjt-uDIIJcn6XgZnqWr1H4qs1OvPfUzZYLljje3jsMiqAmGBqdDbzPrH2VEs6yYQBZQLYsMctUJ0un5KK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddujedtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehjnhdrrghvihhlrgesfhhrvggvrdhfrhdprhgtphhtthhopehkrhhishhtohhffh
    gvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehmrghr
    thhinhhvohhniiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhm
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:a0-raPRzx5E35xeunpcm29nhlHD_2I9IbxRGMPgIlDHNueIoKMkRDw>
    <xmx:a0-raK32VhOhGrj-ZGFezlLOb65VvIrsbfz87ESBlDmQLGNoJmEJxw>
    <xmx:a0-raEvR_D7ABU-ZpM8YsrX6lROPflcYD4jjdF-sONyT1-X5ZstyTA>
    <xmx:a0-raAh6O3_6D6YaToSOmhRHxbiQ_cfZA4ws9DAKhN0HXkQy14JZcQ>
    <xmx:a0-raPZw9OhJGB9lK4UmL_7QgaWpcEw2smtxKdkMh2NYsBNQeA9k-R6a>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 24 Aug 2025 13:44:10 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 48040c90 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Sun, 24 Aug 2025 17:44:09 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Sun, 24 Aug 2025 19:42:27 +0200
Subject: [PATCH RFC v2 14/16] wt-status: provide function to expose status
 for trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250824-b4-pks-history-builtin-v2-14-964ac12f65bd@pks.im>
References: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
In-Reply-To: <20250824-b4-pks-history-builtin-v2-0-964ac12f65bd@pks.im>
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
2.51.0.308.g032396e0da.dirty

