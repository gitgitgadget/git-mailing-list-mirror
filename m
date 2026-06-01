Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D45387369
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 07:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780300576; cv=none; b=XciIlylRgA9ouZQty90ZxwGPJi4LJS7D4+6gJCZFlQLC/lAxup1PQLSxnVBDp594XU8XPSZcjiOTQH2RoBVhIUiT00PMvCWrTJBjxZSHFJ9G8WZqy3F0uKp8/pOpDZvH4cOul8Ve3tlny/d89Ge6whsmL709qMWFT2zSZuoUPuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780300576; c=relaxed/simple;
	bh=bHzF8yUshnj8KXv4UPfPv+si7gkzZFw8sqqMC/GmwIo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f/hIOIxPkPT2p0ftjGEaGJKsCouglVEuN4lv05GQPPdh50ZqELAgwbl3u17XamgxHkuwP7XEGHjBKqlX2IsHWRiyFMcLUOvUpiCRWiHyJFyaN9/IMd0wEcvd768nKaUejLwTPvzgijhwnoR/hggFGGUIBGj8erlT37a8IPPpvbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MDMNsGeW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=cO1YkVs2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MDMNsGeW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="cO1YkVs2"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DD4C4140000E
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 03:56:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Mon, 01 Jun 2026 03:56:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1780300574;
	 x=1780386974; bh=JTV0oLw/79SAstHiee3apFENtD4ftqDm6BVjSbMKIB8=; b=
	MDMNsGeWaKZ3wiisble+IsqBIXgnyvjDXZVW5/eo+qxUfAY2H8acN1NY6aylpfXl
	vRUKEDtgJRd+Z8Z61ASPOTQOLMX1UH7vX1LKgumDU4BjehRgfrrZR0fTHMLgU77E
	njguVbkEVCyhFh6/ZEjd9/LRIw5ZTiSQSkYybXMYXHVKkMrbRdGkz7y/iP5AOyzI
	TjtE0nN5FUCEKQ6reYXO803Gu2mUzglcImX1PnN9j7qff49ki9IGUPwAt6nAV0Ni
	7VJXTyfFFPlBrAkR5cfly4pfW2EHiSBYG2enltIzzmigqt/jG9GDo4Q5vCtER22f
	aFH2V3QRDvTUamYQHNkx/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1780300574; x=
	1780386974; bh=JTV0oLw/79SAstHiee3apFENtD4ftqDm6BVjSbMKIB8=; b=c
	O1YkVs2p2J3zCQSc04MgxIrvZr59ygBVSnstiKaafEi5QyME2zUoJhKkQMRCmmtP
	abT9wZ6YYIHb0x9iQWXY+UMIwg2sB3I4K8+zdRh8j42YimkMEqMR6pRzIaiQ6BTB
	36m3m1HXHcIl7lZPnqY9BGJG6OQWlILyqmPxFALQUItatmf1u9dcoQDCFULNnl9w
	rAmWZQReAMgKKSnC128W4qQl7SaUsWjKM0IHXVd7gdordz4I6kRp/2N4trpGikLJ
	zoQgE+IwnGoooN7g0on+WDWiMGpHElYWBGOBSC4jEsb08iwZuWpPZJuR3RpAcv9T
	l0/LYXex2JWgOvNISkmvQ==
X-ME-Sender: <xms:Hjsdak54LQrqo-qnqForp9RyzRMVX06OsyHAfvflfn7FgdrP12iTpA>
    <xme:Hjsdas1h-mGjC4kgaGo6prxJkpMvzcCi7nKf64Aw9SmA-V_Jjls8SsiDHtYkfFR6c
    k8dduhmkWcPTqmUaQQmxEBh3al6O_E3IB_q4FinLWJGwAFER84AmA>
X-ME-Received: <xmr:HjsdapE9mBad8wKIE2G5EOpCYJW-qWJFD2oM-bbe4c3l1umumVAOA-F_pE4xRo0bf6cuPBmosN6sOAjtFuJZg6Ns4RyFrcmk4YIUoJVz26Mc>
X-ME-Proxy-Cause: dmFkZTE5ylrvFdAJ0rXHBYTGB4IVmoQ1O2RcTl8O0Xqp8R89XIkDEWG+QlurkiiaWHH//Z
    5ikJ05xI88fcm6s3+tYPeDqksjLfFdJ5cfnfMzT/b0e2C8pGec0qbTOW0bTNPT8VJEVoWm
    g5pu6mVK6nz5IVaozfp9MbqarLgJ9WIbBsA0YNo2eRsNxohYGTH6ESNl/6n+hFmzKvwtPO
    m5CKCGOb8iP5UglyNhLRslvNr8N4vXuWM13vEYapAP9pDg7iendkSe1uQcZOcDgh7FtAkJ
    SG1GEEDSrrr3B+BRrEWNgZeDYrKGeap5/OYqzkR/XjkCutuQIS12dX0ilbqzobKjY+oeGw
    5adsvpow7FYN4p7ovj491iZbIyh6SLQmMKw8obbGnOBTA8RUWZFT36vSNq0qrvSIBjVWFO
    qh27yOtIToycjfE3r3j/eRMq70vGx09kYRlcvnU1OCf0hmRvo5/Bu6G2Ock1mDQRgS/GkM
    3qVA/5XXZHu5SL3n/5qjytUB958aw+73+OY1CGblA6kEIbdASMDYbgUjCGE2ldyaMjdmsm
    D4+he6uOziAAk3ghIBVPcjh44OBVvDiWmG3nV945Hn4O7RLTwjUQxEiYcK356jjM0zIwIV
    8okk7MOLT1jdgcSK54+UBWl7k34L4QKNzI+ickGZ4O8D+kC1uWvrQ+i0tASQ
X-ME-Proxy: <xmx:HjsdauT9Q05qn7kvvO7LeFUWBsEOlt18iUQkYnvdFF7Bk4y8srATDQ>
    <xmx:HjsdaoDnYtB4XPw1HmMPh4Q28dTx0WAiRCHiArcNrN4TU6Cgn9CC-g>
    <xmx:Hjsdam1-xMHZdtvkgjfnF5ySesehyFFjYI3zQzp888YszXiY8ZrQ7A>
    <xmx:HjsdauXLuit6LaWFU3o71wO5t4GLcKYngbb9TXBD_VdPAFq-gKO1Jg>
    <xmx:HjsdalaOg1QekrDjH5Eanu_b6lYa5rs0b4xfJtolIn8fuY35j6z-pFaV>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 1 Jun 2026 03:56:14 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7222c02e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 1 Jun 2026 07:56:07 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 01 Jun 2026 09:56:00 +0200
Subject: [PATCH 2/2] builtin/init-db: deprecate alias for git-init(1)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260601-pks-deprecate-git-init-db-v1-2-ea3e6eebe674@pks.im>
References: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
In-Reply-To: <20260601-pks-deprecate-git-init-db-v1-0-ea3e6eebe674@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

The git-init-db(1) command was initially only initializing the object
database of a Git repository. This has changed over time so that the
command also initializes all the other data structures, which is why we
have eventually introduced git-init(1) as a more aptly named replacement
for it.

This has all happened in 2007 already, and with 5c94f87e6b (use 'init'
instead of 'init-db' for shipped docs and tools, 2007-01-12) we have
also adapted all user-facing documentation to mention the replacement.
It is thus safe to assume that (almost) nobody uses git-init-db(1)
nowadays anymore.

Deprecate the command in favor of git-init(1) and wire up the removal
when compiling Git with breaking changes enabled.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 Documentation/BreakingChanges.adoc | 3 +++
 Documentation/Makefile             | 1 +
 Documentation/git-init-db.adoc     | 5 +++++
 Documentation/meson.build          | 2 +-
 Makefile                           | 2 +-
 git.c                              | 2 ++
 t/t5502-quickfetch.sh              | 4 ++--
 t/t5503-tagfollow.sh               | 2 +-
 8 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/Documentation/BreakingChanges.adoc b/Documentation/BreakingChanges.adoc
index 73bb939359..89b7482f54 100644
--- a/Documentation/BreakingChanges.adoc
+++ b/Documentation/BreakingChanges.adoc
@@ -300,6 +300,9 @@ references.
 +
 These features will be removed.
 
+* The git-init-db(1) command is an alias for its modern drop-in replacement
+  git-init(1). The alias will be removed.
+
 * Support for "--stdin" option in the "name-rev" command was
   deprecated (and hidden from the documentation) in the Git 2.40
   timeframe, in preference to its synonym "--annotate-stdin".  Git 3.0
diff --git a/Documentation/Makefile b/Documentation/Makefile
index 2699f0b24a..3769856b58 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -541,6 +541,7 @@ lint-docs-meson:
 		sort >tmp-meson-diff/meson.adoc && \
 	ls git*.adoc scalar.adoc | \
 		grep -v -e git-bisect-lk2009.adoc \
+			-e git-init-db.adoc \
 			-e git-pack-redundant.adoc \
 			-e git-tools.adoc \
 			-e git-whatchanged.adoc \
diff --git a/Documentation/git-init-db.adoc b/Documentation/git-init-db.adoc
index 18bf1a3c8c..9802fc9f3d 100644
--- a/Documentation/git-init-db.adoc
+++ b/Documentation/git-init-db.adoc
@@ -11,6 +11,11 @@ SYNOPSIS
 [verse]
 'git init-db' [-q | --quiet] [--bare] [--template=<template-directory>] [--separate-git-dir <git-dir>] [--shared[=<permissions>]]
 
+WARNING
+-------
+
+`git init-db` has been deprecated in favor of `git init`, which is a drop-in
+replacement for `git init-db`.
 
 DESCRIPTION
 -----------
diff --git a/Documentation/meson.build b/Documentation/meson.build
index f4854f802d..0f127d752d 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -72,7 +72,6 @@ manpages = {
   'git-http-push.adoc' : 1,
   'git-imap-send.adoc' : 1,
   'git-index-pack.adoc' : 1,
-  'git-init-db.adoc' : 1,
   'git-init.adoc' : 1,
   'git-instaweb.adoc' : 1,
   'git-interpret-trailers.adoc' : 1,
@@ -212,6 +211,7 @@ manpages = {
 }
 
 manpages_breaking_changes = {
+  'git-init-db.adoc' : 1,
   'git-pack-redundant.adoc' : 1,
   'git-whatchanged.adoc' : 1,
 }
diff --git a/Makefile b/Makefile
index b03f74ee8c..4420231753 100644
--- a/Makefile
+++ b/Makefile
@@ -894,7 +894,6 @@ BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
 BUILT_INS += git-format-rev$X
 BUILT_INS += git-fsck-objects$X
-BUILT_INS += git-init-db$X
 BUILT_INS += git-maintenance$X
 BUILT_INS += git-merge-subtree$X
 BUILT_INS += git-restore$X
@@ -904,6 +903,7 @@ BUILT_INS += git-status$X
 BUILT_INS += git-switch$X
 BUILT_INS += git-version$X
 ifndef WITH_BREAKING_CHANGES
+BUILT_INS += git-init-db$X
 BUILT_INS += git-whatchanged$X
 endif
 
diff --git a/git.c b/git.c
index a72394b599..6bf6a60360 100644
--- a/git.c
+++ b/git.c
@@ -591,7 +591,9 @@ static struct cmd_struct commands[] = {
 	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
 	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
 	{ "init", cmd_init },
+#ifndef WITH_BREAKING_CHANGES
 	{ "init-db", cmd_init },
+#endif
 	{ "interpret-trailers", cmd_interpret_trailers, RUN_SETUP_GENTLY },
 	{ "last-modified", cmd_last_modified, RUN_SETUP },
 	{ "log", cmd_log, RUN_SETUP },
diff --git a/t/t5502-quickfetch.sh b/t/t5502-quickfetch.sh
index b160f8b7fb..a2b62f551a 100755
--- a/t/t5502-quickfetch.sh
+++ b/t/t5502-quickfetch.sh
@@ -25,7 +25,7 @@ test_expect_success 'clone without alternate' '
 	(
 		mkdir cloned &&
 		cd cloned &&
-		git init-db &&
+		git init &&
 		git remote add -f origin ..
 	) &&
 	cnt=$( (
@@ -94,7 +94,7 @@ test_expect_success 'quickfetch should not copy from alternate' '
 	(
 		mkdir quickclone &&
 		cd quickclone &&
-		git init-db &&
+		git init &&
 		(cd ../.git/objects && pwd) >.git/objects/info/alternates &&
 		git remote add origin .. &&
 		git fetch -k -k
diff --git a/t/t5503-tagfollow.sh b/t/t5503-tagfollow.sh
index febe441041..31ec352c5c 100755
--- a/t/t5503-tagfollow.sh
+++ b/t/t5503-tagfollow.sh
@@ -32,7 +32,7 @@ test_expect_success setup '
 	(
 		mkdir cloned &&
 		cd cloned &&
-		git init-db &&
+		git init &&
 		git remote add -f origin ..
 	) &&
 

-- 
2.54.0.926.g75ba10bac6.dirty

