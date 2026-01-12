Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 850B0225A35
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 14:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768227448; cv=none; b=K2XRgWmLkt7XRFDvMShJ8YP8s3/V0YxintFxS4asRSCR+B4L3Ot2ZdquTUlLLovdKMfnOpGfWZl9kzlChrxHQVkVBe7kuUWLiYEt2GvDNWn0FQLPPvPV0PhlSHQHS1wv4YYnnsqxxS1utwOBFrGuy6ziVyD9NS9MlX3bRiFjD8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768227448; c=relaxed/simple;
	bh=jwvT8wUzq+TTcJgO+aXsI+w3tzpagITrYJSlbbzYXQA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KBNwYDGSVipRunjdxEp9ZJfKJyUiUXuy4w47ciLpc97JBsCIAKmSy2DF3fHdu87SV88at+FOm1cNuxEMIJSt40gyNryCPgbm+zNA2GIlqYAjUlEi73idouCSraANYd1Pn/LNAgbBxj944Td6QdcZ4CNt6Tu6hBDbi3NByimqHZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=HuxVNAmR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=EN8uP8wJ; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="HuxVNAmR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="EN8uP8wJ"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id C36A4EC0598;
	Mon, 12 Jan 2026 09:17:21 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 12 Jan 2026 09:17:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1768227441;
	 x=1768313841; bh=tfO7nnCv8CCt359m1gccIzSw4aWv2tRWbVPH86EndRY=; b=
	HuxVNAmRdYgBETbOrSYszDYIbgOwNI8l+scEtmNroAMGThJnk7e45X8dpqIlgfSQ
	OoVdEZGdVpbgUZl50oHS4MALSzYJcxzpl0QVYPzL+ku4HzBaMe/GT1UH6MJOsgJf
	b63nD5QJeW0ahRM5w11ul8UAB3ge42+17f9Y/4NLtbuXZ5GYMVFN6+h7JBAr0/le
	frR1xXGwDWdZYGkvl4fRYyYl5cJ41MSHo+YVP/5VtDZQIZ2OFbeDrdqEZy1cSHIn
	4Su08vgaSafhyzXP6gcpiouFZhRdnQtk1vN4v26NP/6XD9NkHZvrD16tSSt6nkyS
	6Gwinb32s+6LXpXWoyWzvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1768227441; x=
	1768313841; bh=tfO7nnCv8CCt359m1gccIzSw4aWv2tRWbVPH86EndRY=; b=E
	N8uP8wJ1rlvdTrSTZDDGyN4FDtMla8KzulkojcQcq8JL3heoaUEP9TKY/TB0bwwa
	bq542tJS4NV042MrxZmNE2u5xsc/0PEI95AsNjxRFfdXqr2iCG1AegSdkCj92YSw
	2a6Q879Fahk4AhB9JvG/uiQy21PC6TLImURTlgTXHytXUqXxrrercHOmb7vwjwTF
	Px3HUpDVIQyiZCNplm69dlIEpAkCCSFzTDn3ePzI6B4hntGf6E32UrsxVAGw0w6z
	nqVoxdPphXZ7mAljcQXqTk59AK8/gr5M4t+KbnGjpuMmv1VzNSERVSsG4zQM8pdk
	YbiblphAglZKvUVXRiW+A==
X-ME-Sender: <xms:cQJlaV2yy7Q16ytAnPlldW4ePdMx9AShmi5-tggughBxRfyEGD1YOQ>
    <xme:cQJlaX7q583sTAPfviOWXlJ7YBtvNh98PtVoo4mgxkExIhiJ3ogEv5WU1CjMb4CuM
    jsnbs9go6rZMEDwfsjTmSuET3lPSs04YtfpuckNJ9hPStmyiRIp>
X-ME-Received: <xmr:cQJlaRRF5UDwskydtU5bKW8r84lkxzd6v8isAW-FqIPIv6BkXHa79XRObJlfF1Z4xtefACXL98TjaOlflW7xZxMQzF5UurdOu0_ZopPZ1Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduudejieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdr
    fhhrpdhrtghpthhtohepmhgrrhhtihhnvhhonhiisehgmhgrihhlrdgtohhmpdhrtghpth
    htohepshhorhhgrghnohhvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhi
    khdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehmrghilhessggvhigvrhhmrg
    htthhhihgrshdruggvpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrd
    gtohhm
X-ME-Proxy: <xmx:cQJlacWezNbFcnhPpltUT3iEHDdc3QvPz1T8cyGj2fRldG1vHYAuRA>
    <xmx:cQJlaWEu68U-5prOulAmO8VZqooQJOWjB2-da9rtxlNwYcQC7C70-Q>
    <xmx:cQJlafe2OJtLlnd0SIO3QKZazl2eKtMbeC9gS86DewSAGaPMwWUwSA>
    <xmx:cQJlafre1LI7fRtc-nlv24ON_0EVFOXHQuC69XYFLnBbwzczOfa5Sg>
    <xmx:cQJlac0UmePSTaj3gr5UnZYT3TZvtH-BGXW50dpouq3tYcmMwuZj5aTt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Jan 2026 09:17:19 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 98dbc604 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 12 Jan 2026 14:17:19 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 12 Jan 2026 15:15:18 +0100
Subject: [PATCH v10 6/8] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260112-b4-pks-history-builtin-v10-6-e3c6aa5b4cec@pks.im>
References: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
In-Reply-To: <20260112-b4-pks-history-builtin-v10-0-e3c6aa5b4cec@pks.im>
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

