Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE10349B1D
	for <git@vger.kernel.org>; Fri, 13 Feb 2026 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973990; cv=none; b=g60c16TwT5VrU80KbLfezd9GZcWhLpkfjVT4S/Err3mt9T55g4jZufRUrT5TCtYbWRzPbLq4uvAVIfXDyvvvlVa0Og24wspgasB7Md/VWvW1Vqogc+7KFrzCAk4fFyxNYjYN97qiDAlldRXJ0DDt7VqsFkerUQ+r/0ZoAExJ6KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973990; c=relaxed/simple;
	bh=ULSLg1fRVb4gEfgModArehstwZZ0yQ1Ek45SOYgoNYA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NKEGWLHigr72ToeuouqAhNPULChdMNdJ1RAZwspZmWegaPuubtfm50e0kVl2XZscO4Xdp+GKyfH6rR7rKcc0VPvCTvNxCNxRYGk73o1BUpqzyqGLLoa4b07IlU86/qa+32WrTD7o/LW5+3Q3RlBiIFF2GRFtV84asX4Fe+Eksyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gq9q1Vf8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TQuZ5hnp; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gq9q1Vf8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TQuZ5hnp"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 2C893EC0121;
	Fri, 13 Feb 2026 04:13:08 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Fri, 13 Feb 2026 04:13:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1770973988;
	 x=1771060388; bh=JD8psSd9Q/bXqgPieDtUJvTFbp/X5kK8kvIb/MHeo6E=; b=
	gq9q1Vf8vj4zY1Pab6mKHQBoq5q09YWAxffoVT6QXAayXDtnwuhk4++4B2noFiCv
	ComHL/MX1fbuKYXneTa56kTqxSmpmk+ggiu59AInI8TxHdCvDoanZxwfHNG8h48z
	mzYcsWlb/KHFtA8VHjGtWJw3UwZsYRonZBAjqR+hrin5xHHyezBX18ruSRUvy63H
	pBqu/IlitjLFPjCJJXtDWBXfSVTMGBaRH96SdSg9Gd7dY3D10y84UQ4DUECllVNt
	nbxzAZB1FPPLU5sB5e46lOxdXUgwdvhgSFHG5hJcSv/H0w3TwcIFn3esOz+vkEJB
	RiDwGrdQ2aVCPxz61jPnnQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770973988; x=
	1771060388; bh=JD8psSd9Q/bXqgPieDtUJvTFbp/X5kK8kvIb/MHeo6E=; b=T
	QuZ5hnphduU263DnwAVegv1Gx9Kr1sNCez1xwMFIWPVDp+AEL8RBPbxn1lAXx0at
	JMz3fNK/pk2EwMt/2HiYknD8brtCUp9wUHXE7G2fuHBdBuIR3Ibq2qfGd4bzD4do
	2sr1kuZahAuGJ6e1iiRfDFmTYKzJs5Vs5sfXzcEut0uG02qOTxy24azRvDHw2emg
	X46mr23O2SnitxJntJFmezWuc1/8AUQ1jN9/qQva7p/WxwlwW88B6WO4WyhmljKu
	4P/TmLovB9xgVxoP7CryNx7S4ZmADg3ydsThcO924ht55z06fgoilrypOgMcSXZn
	Mdw60fCPYlYo6p/cjFX5g==
X-ME-Sender: <xms:JOuOabkP8eDWQ2tDF7uYvVa0HmxGJw4bLE7fdhR-EwvHKSGh9pUvzQ>
    <xme:JOuOaWTfIfnwz5yUG8GmnleRsCXjE3lgkiBYe0PsMT81H5qMC3oXnVvdeYM-zP2xK
    I8f3hopCgtekYd8vGmcln9qz0lB4T6uisYtqK1p1AATxzdpvRev>
X-ME-Received: <xmr:JOuOafD9zV4O96lK-v6dfRPRSNgmJ7cEx1iNO6qX1EMepfbBK6lS84Eg812Q7zdJxxLx8xBvjoNUtj-vUbkCxKJuwMgCaeqiBsK4wxw7Wpdc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvtdejkeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephfffufggtgfgkfhfjgfvvefosehtjeertdertdejnecuhfhrohhmpefrrghtrhhi
    tghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrh
    hnpeffueeiudejvdekheeuvdekfeffiedvueelteekudehjeetkeegvddugfdtgfeileen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesph
    hkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghi
    lhdrtghomh
X-ME-Proxy: <xmx:JOuOadRC5ZGyO_zsyFS9hW0JlkyLgtaw_qzBRsTvkfBtAnWahFoGLw>
    <xmx:JOuOadpnefZni9dKXaWkzHeGgVet8dHdpeAttN3hIgNtWrlbPDLD8Q>
    <xmx:JOuOafyUiNhhZbk1t3ByKdlw7iICK6ToPaXzZn-L9yDtfdlJAqegVw>
    <xmx:JOuOaSLhJDZUrr5e9pFURviUYMTjPB-eyfHW6IeF_QUy9agIggFScw>
    <xmx:JOuOaaQutw7TToYAAmLE2Y-XDfiJCuBXv5gpoNJws4NZF6moTpRtFQia>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Feb 2026 04:13:07 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7f46933b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Feb 2026 09:13:06 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 13 Feb 2026 10:12:50 +0100
Subject: [PATCH v2 4/5] builtin/history: rename "--ref-action=" to
 "--update-refs="
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-b4-pks-history-dry-run-v2-4-756ac376e9e5@pks.im>
References: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
In-Reply-To: <20260213-b4-pks-history-dry-run-v2-0-756ac376e9e5@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, 
 "D. Ben Knoble" <ben.knoble@gmail.com>
X-Mailer: b4 0.14.3

With the preceding commit we have changed "--ref-action=" to only
control which refs are supposed to be updated, not what happens with
them. As a consequence, the option is now somewhat misnamed, as we don't
control the action itself anymore.

Rename it to "--update-refs=" to better align it with its new use.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/git-history.adoc | 4 ++--
 builtin/history.c              | 8 ++++----
 t/t3451-history-reword.sh      | 8 ++++----
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-history.adoc b/Documentation/git-history.adoc
index df2900ac2f..4dbe665ec4 100644
--- a/Documentation/git-history.adoc
+++ b/Documentation/git-history.adoc
@@ -8,7 +8,7 @@ git-history - EXPERIMENTAL: Rewrite history
 SYNOPSIS
 --------
 [synopsis]
-git history reword <commit> [--dry-run] [--ref-action=(branches|head)]
+git history reword <commit> [--dry-run] [--update-refs=(branches|head)]
 
 DESCRIPTION
 -----------
@@ -66,7 +66,7 @@ OPTIONS
 	objects will be written into the repository, so applying these printed
 	ref updates is generally safe.
 
-`--ref-action=(branches|head)`::
+`--update-refs=(branches|head)`::
 	Control which references will be updated by the command, if any. With
 	`branches`, all local branches that point to commits which are
 	descendants of the original commit will be rewritten. With `head`, only
diff --git a/builtin/history.c b/builtin/history.c
index c135361c67..1cf6c668cf 100644
--- a/builtin/history.c
+++ b/builtin/history.c
@@ -18,7 +18,7 @@
 #include "wt-status.h"
 
 #define GIT_HISTORY_REWORD_USAGE \
-	N_("git history reword <commit> [--dry-run] [--ref-action=(branches|head)]")
+	N_("git history reword <commit> [--dry-run] [--update-refs=(branches|head)]")
 
 static void change_data_free(void *util, const char *str UNUSED)
 {
@@ -258,7 +258,7 @@ static int setup_revwalk(struct repository *repo,
 			goto out;
 		} else if (!ret) {
 			ret = error(_("rewritten commit must be an ancestor "
-				      "of HEAD when using --ref-action=head"));
+				      "of HEAD when using --update-refs=head"));
 			goto out;
 		}
 
@@ -416,8 +416,8 @@ static int cmd_history_reword(int argc,
 	enum ref_action action = REF_ACTION_DEFAULT;
 	int dry_run = 0;
 	struct option options[] = {
-		OPT_CALLBACK_F(0, "ref-action", &action, N_("<action>"),
-			       N_("control ref update behavior (branches|head)"),
+		OPT_CALLBACK_F(0, "update-refs", &action, N_("<action>"),
+			       N_("control which refs should be updated (branches|head)"),
 			       PARSE_OPT_NONEG, parse_ref_action),
 		OPT_BOOL('n', "dry-run", &dry_run,
 			 N_("perform a dry-run without updating any refs")),
diff --git a/t/t3451-history-reword.sh b/t/t3451-history-reword.sh
index 702d40dc06..de7b357685 100755
--- a/t/t3451-history-reword.sh
+++ b/t/t3451-history-reword.sh
@@ -233,7 +233,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 		test_commit theirs &&
 
 		git refs list >refs-expect &&
-		reword_with_message --dry-run --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --dry-run --update-refs=head base >updates <<-\EOF &&
 		reworded commit
 		EOF
 		git refs list >refs-actual &&
@@ -258,7 +258,7 @@ test_expect_success '--dry-run prints ref updates without modifying repo' '
 	)
 '
 
-test_expect_success '--ref-action=head updates only HEAD' '
+test_expect_success '--update-refs=head updates only HEAD' '
 	test_when_finished "rm -rf repo" &&
 	git init repo --initial-branch=main &&
 	(
@@ -271,10 +271,10 @@ test_expect_success '--ref-action=head updates only HEAD' '
 
 		# When told to update HEAD, only, the command will refuse to
 		# rewrite commits that are not an ancestor of HEAD.
-		test_must_fail git -c core.editor=false history reword --ref-action=head theirs 2>err &&
+		test_must_fail git -c core.editor=false history reword --update-refs=head theirs 2>err &&
 		test_grep "rewritten commit must be an ancestor of HEAD" err &&
 
-		reword_with_message --ref-action=head base >updates <<-\EOF &&
+		reword_with_message --update-refs=head base >updates <<-\EOF &&
 		reworded base
 		EOF
 		expect_log HEAD <<-\EOF &&

-- 
2.53.0.352.gd1286b26eb.dirty

