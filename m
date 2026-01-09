Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C0350A17
	for <git@vger.kernel.org>; Fri,  9 Jan 2026 08:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767947758; cv=none; b=tumm99Ws5tJVIL5gtBFMkroMKyritHNhlS2sODs3Ri4C4Bp7VZzWLWjpcner3yuB23EO/v5NtaXWWlyv1OW7dnakiMiX8WNJomFm4mVI7gKYwnI6LmC6tuAQR3MPUnZpO/694Pr+DK4HWA066CPbDwY2JWgijD36YUSJrL18IGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767947758; c=relaxed/simple;
	bh=gsx3J7OxduvHoSrp8UypKKxdyIHo+YBb3gRsfO9kcPc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f4DtmLb1SsSVQ93M0y7GmZEav7j9MqobG1t0Z6UoDF7ILUy27dGkQIVXRr1qXKYg9TLwyoQAZCZqEtuoyYiGGFZVHDYQ1QE/tPpHJoSk8QzDF8hc1RidJUmy6rXeo+08vGPOSd/JrJgPv27f64PWs2Gv4tmbO66NL4yWk4ba914=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=VtgetoUk; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kE6sjRcH; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="VtgetoUk";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kE6sjRcH"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A414D14000D0;
	Fri,  9 Jan 2026 03:35:56 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 09 Jan 2026 03:35:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1767947756;
	 x=1768034156; bh=PdHZ4sVjeC4zy04QfGRr4BEFPoQZ23lRRMzf+EkteN4=; b=
	VtgetoUkT5bbXNBHMwHiLyadnye1QCwlleNqnjDEohGOZJ8WmLCkaLJd1BkbIJ6i
	sZUV/xsjxpJxZVYj1TIsBx2e7hn90iml0uqwit5EYlr3bubnXDoxqn6aAngSzDr3
	LDnIGneE6kIN6qM4tdCKbiu/V5/P9S91nlEL1PMhlUF3TUqvbz7HDydC38M944cq
	LIM6vgWBGGhwyEd18BsKa8Z1VBFnTJLimPrsEWfhpLXgOCzVYdzBzdH5jcQMmaut
	WX0p4nlT4A1a/OADsvm9NIfzI25pcheQemDXEjVqRstYo+uhNLInb0VVQHfCoLx/
	iUEshBgI7ukWnUjvn9sYrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1767947756; x=
	1768034156; bh=PdHZ4sVjeC4zy04QfGRr4BEFPoQZ23lRRMzf+EkteN4=; b=k
	E6sjRcHDQIy1pzc2xLVx26r9cpE8pbcsSsNHxWk4roGpPF+0LwhIIwqMgKEzaZOk
	2qPmTLRaH27D5CvOPgt8k+qSOAHl5HDQ6eH9g25q2LUGTnI9Xy6dFMaKe7Rj0J88
	5RWsLgvqOmBIXd6jo8yYybvf3l6TMmCCJ+GRZzisvHpbINLqSzkYxnrixQk4zIbg
	LiYrKiG3QXgNvkXe+PHIOQ/OxshaHOzn6vd6sk4tIAKLfRMWE8Umg68ywMivJvBJ
	Om0ahaXSqDisEIlAEY5d4xkEx0gW3vN0zaCcDCQfUouXRVxyeJyX2o81fX6Tv5uJ
	oqJ0ZfpQI2GJtbpNshPkQ==
X-ME-Sender: <xms:7L1gaV16Kx7CUrcKXg5tEQA-MO8i1ilahQU3pe8i_8Ck7mth9j3gEg>
    <xme:7L1gaX4SYBlaIYH_RpthZQUWE-3RN66iUSZZUwVPhWWTNR31TUlqsIWL_zFXcnIqZ
    AzbCHCxUHCHQFrBsqWDc3Ww6yTIDB3B-flsnBpy0patU1H2O6TPMw>
X-ME-Received: <xmr:7L1gaRRN_jazDsPTpSDwyY040GmnIVh6XUyq5maM4A12mR_Eq84WDTkuhOIEzRY_sY6ZwWN7nIwKxTkU1ge2idtTAV1jCxY7Z20nLpbqrw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddutdekfeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedvnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeduvddpmhhouggvpehsmhhtphhouhhtpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehsohhrghgrnhhovhesghhmrghilhdr
    tghomhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohepsggv
    nhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomhdprhgtphhtthhopehmrghilhessggvhigvrhhmrghtthhhihgrshdr
    uggvpdhrtghpthhtohepshiivgguvghrrdguvghvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:7L1gacUGpXxLgEfc_M5Bql66o5o-nwlzDpTjSWsIyFBy-3uYsX6C7A>
    <xmx:7L1gaWF2f7BQdVShYH6WTNjK8wr5AHYfyv_DZ6e1FmCJV-MjOuzkgQ>
    <xmx:7L1gafdeCxVdzzEYp6qeFCAnQIKe042J8TApg3MTDREo2V1Ajcs6yQ>
    <xmx:7L1gafpmdrRjsYOIMaigxqFGMBj2nMLuqzvOELhaOi9hWO--pWmwaw>
    <xmx:7L1gac1cOqyuC-rBiwE5gqo8zf3iNDZ_DOuyZNtx-G01EK90OH0jMJ77>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Jan 2026 03:35:54 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2fcdc9fc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 9 Jan 2026 08:35:54 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 09 Jan 2026 09:35:40 +0100
Subject: [PATCH v9 5/7] wt-status: provide function to expose status for
 trees
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260109-b4-pks-history-builtin-v9-5-8766101814c6@pks.im>
References: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
In-Reply-To: <20260109-b4-pks-history-builtin-v9-0-8766101814c6@pks.im>
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

