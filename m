Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9848F30B53C
	for <git@vger.kernel.org>; Thu, 25 Sep 2025 17:09:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758820153; cv=none; b=F1utIcKOiU8c6icbN5XaouS4QUUgovw0hPMd8561l6YizUW5l9fmez7E67C6eR87BpoT6M05W96fgejHbsvZdn54eZ2WibQ8/yxPfV+sb7itBi13gy4uixoiJ0uJkTrjsa9GppX3MXSnrnj/MTf17NBbxYduD/2k4xBxKikmGjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758820153; c=relaxed/simple;
	bh=7IvYpzNT4ZEJiiHQiV+/n9NhsWJsbDy+52TJimZmD5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oLhiv0QZBnx6WbvPnYAD7RJmiRW3Xu1IObhYiAIzOT23HsylUh+1lW/drAYDHWBfDwuo8yXd/SvZ/lbJzT8ynJbhNwGsxGIvmerIgjneF+zX+JQpXbWugG4LJtVUlqQtFQ3aAGUrL9KquWDE3BsCrFfn1tqGuw9bfWT3ljga5HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=nDLIqVcO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KkAQG6RV; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="nDLIqVcO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KkAQG6RV"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B251D14000DE;
	Thu, 25 Sep 2025 13:09:10 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Thu, 25 Sep 2025 13:09:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758820150;
	 x=1758906550; bh=tdu+/3WPOON80ws6W8p/7EfyaE+ZSIMKYdLY7KlAlK0=; b=
	nDLIqVcOrJrJ/rm7GaY5jDF7bgpJbkgbktBWILF8hrtzovsVNFvtl5H/+KcUFJoB
	9Lux/UyPkvsLZXj90aUjzsJxN/ZGYh5ONYbeQwPxSb49ijAGpLTkDH850kOvJrA5
	fGxIjk3svAofu1TRG+z4UGv3jcW2c68+okrN8yXN7Hb2Z/4tCTYpS5iL1aylqvFQ
	kIIxys4NzfCg3cFHADpa0bQTLJpWjEQy9p3P9k2O00GYnKkxXyk4Q/H2cl4e/XMP
	R1sURcu481S4XbYmt/PAqo2u0iQKI8ZlY/V33pv9j/eoCje3JP2YWmN3I7tDzHjH
	K6EO64BzHFZ5NNDMoJFwTA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758820150; x=
	1758906550; bh=tdu+/3WPOON80ws6W8p/7EfyaE+ZSIMKYdLY7KlAlK0=; b=K
	kAQG6RV7AKzrgq7GvHE7wrOGvckKQcCLqjaRF5FIf2Hf5aIcavJJe+CLebo+ZVYh
	1IBF4QubW2iWL2u4Ny5Mej9c298szQDij8lLzPH1JMG2OjlHWaXz6pkaEorJIdEM
	fgSPFhKCpJGArv4oLmltHXch6L+Q1u7lhQOWJ3O3kf4C4TKkuCYj7AxDOs1Ov5Xs
	bP+Zneu6BzbbvB5x4ipHjNCMu4zDpVTOLss4Irinfu2nppJm8vr8eUlbiBG7S/rs
	nNNIPQ24A5z7ojI1zIruAGSfJc8IMHkrbNLeHDhQJzxLi/SJ2BT3PeGAXlym1JSg
	PdQIxuqoFpkVTjibF1+yg==
X-ME-Sender: <xms:NnfVaE85Kw19tVSS-LjOwvLHy1g-Ewk604pAaqZ4O9fPTMHx11MlUq0>
    <xme:NnfVaEJYinmfXSKevxOh2Ga8VZQj6E9JRfm33i-HGY-rlZ0ELKcPBx0UfSmDvZig9
    ybWwTFY0Jp1AXUE8z3hqLNezO_oXnlFVGvBE39cJiEHB4leviJNLw>
X-ME-Received: <xmr:NnfVaHboiNi2AhUFlZIkUfChZ3MBN2fmw5gItnAxJZN9Vm7GBtqC4_-zt534nfVmWQ8M7LdfGlOOZHi8pHiSx_1K7wdxYTyuC4ET3jQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeijedthecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufffkffojghfgggtgfesthekgidtredtjeenucfhrhhomhepkhhrihhsthho
    fhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmnecuggftrfgrthhtvg
    hrnhepteffleeijefgueeilefhgeduffevgfdvveejvedukeekhfffjeevffeftdfftdef
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepkhhrih
    hsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrh
    drkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtoheplhhiuhdruggvnhhtohhnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:NnfVaOKBt7xoJf5AkgoWixXbky2Pe2oiAcqHXsuAjn1rIdM11rAoEQ>
    <xmx:NnfVaNDUjFtrGWBz8DuLTyZTPtfrxf5q8QIgx3azqV7RTiXwlq_dlA>
    <xmx:NnfVaLr9ehxi47tB2ZLDAYprkek8NsOAud3avBLNayBz0s9oA36z9Q>
    <xmx:NnfVaAgunkHMSNQPuFLj9zLMWqjrOMPUUbly6RcSO6sjMAt7lWFe7w>
    <xmx:NnfVaIBMEjibDhIWCllJslB-4j4QUYd0pNkyyqLUA9XtHrxeh6i6h2gP>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 Sep 2025 13:09:09 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Denton Liu <liu.denton@gmail.com>
Subject: [PATCH v2 3/3] format-patch: handle range-diff on notes correctly for single patches
Date: Thu, 25 Sep 2025 19:07:36 +0200
Message-ID: <2be637081d4.1758819879.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.51.0.311.g9b2318464ce
In-Reply-To: <v2-cover.1758819879.git.code@khaugsbakk.name>
References: <cover.1758574974.git.code@khaugsbakk.name> <v2-cover.1758819879.git.code@khaugsbakk.name>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(The two next paragraphs are taken from the previous commit.)

git-format-patch(1) supports Git notes by showing them beneath the
patch/commit message, similar to git-log(1). The command also supports
showing those same notes ref names in the range diff output.

Note *the same* ref names; any Git notes options or configuration
variables need to be handed off to the range-diff machinery. This works
correctly in the case when the range diff is on the cover letter. But it
does not work correctly when the output is a single patch with an
embedded range diff.

Concretely, git-format-patch(1) needs to pass `--[no-]notes` options on
to the range-diff subprocess in `range-diff.c`. Range diffs for single-
commit series are handled in `log-tree.c`. But `log-tree.c` had no
access to any `log_arg` variable before we added it to `rev_info` in the
previous commit.

Use that new struct member to fix this inconsistency.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v1:
    
    I’ve tried to conform to 6caa96c2 (t3206: test_when_finished before
    dirtying operations, not after, 2024-08-06) in the test here.

 log-tree.c            |  3 ++-
 t/t3206-range-diff.sh | 16 +++++++++++++++-
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/log-tree.c b/log-tree.c
index 73d21f71764..3d38c748e45 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -718,7 +718,8 @@ static void show_diff_of_diff(struct rev_info *opt)
 			.creation_factor = opt->creation_factor,
 			.dual_color = 1,
 			.max_memory = RANGE_DIFF_MAX_MEMORY_DEFAULT,
-			.diffopt = &opts
+			.diffopt = &opts,
+			.log_arg = &opt->rdiff_log_arg
 		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e091df6d01d..1e812df806b 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -707,7 +707,7 @@ test_expect_success 'format-patch --range-diff does not compare notes by default
 	! grep "note" 0000-*
 '
 
-test_expect_success 'format-patch --notes=custom --range-diff only compares custom notes' '
+test_expect_success 'format-patch --notes=custom --range-diff --cover-letter only compares custom notes' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
 	git notes add -m "unmodified note" unmodified &&
@@ -721,6 +721,20 @@ test_expect_success 'format-patch --notes=custom --range-diff only compares cust
 	! grep "## Notes ##" 0000-*
 '
 
+# --range-diff on a single commit requires --no-cover-letter
+test_expect_success 'format-patch --notes=custom --range-diff on single commit only compares custom notes' '
+	test_when_finished "git notes remove HEAD unmodified || :" &&
+	git notes add -m "topic note" HEAD &&
+	test_when_finished "git notes --ref=custom remove HEAD unmodified || :" &&
+	git notes add -m "unmodified note" unmodified &&
+	git notes --ref=custom add -m "topic note (custom)" HEAD &&
+	git notes --ref=custom add -m "unmodified note (custom)" unmodified &&
+	git format-patch --notes=custom --range-diff=$prev \
+		-1 --stdout >actual &&
+	test_grep "## Notes (custom) ##" actual &&
+	test_grep ! "## Notes ##" actual
+'
+
 test_expect_success 'format-patch --range-diff with --no-notes' '
 	test_when_finished "git notes remove topic unmodified || :" &&
 	git notes add -m "topic note" topic &&
-- 
2.51.0.311.g9b2318464ce

