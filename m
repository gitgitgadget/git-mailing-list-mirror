Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C92719D890
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749663347; cv=none; b=YiR4OK0aPmoRT5XZeQf2wNdTO3h8LPMHPOF/IKIGyIoKZOBZNd0G42+5LaRwd6jkgcJSoghHO5lm/c5ElVsHqTpgRPvRo1KXNobq5BrydjhrdlO/RA5rXO/bxDvHMz3V4uMapHRqxqcQ3t6FzCCvILzD7wpNBEqDzqsPvSsjI0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749663347; c=relaxed/simple;
	bh=25pdv4zCXGR0NlRBMI8/R2rJOjv1iPnTuMdQBnUMOF0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YzD3d1oL+Nyi0yJhDbl2RXoYMOWmnUN2jhWWhuCe9l79T/f2d1gOfyfAqf9CIOBw7rQXVta40DL02EplRQmzZM9Iyv/PWs4hGrBXn3xccp4b3uTk6d9H5imzEbakwXPLwAZ6jZZ+urvWYhZcHTV7XNyD6PzTVIZFfFM62LMpbSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=YmEv+xo3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=objbdxbs; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="YmEv+xo3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="objbdxbs"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9F55B2540205;
	Wed, 11 Jun 2025 13:35:43 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 11 Jun 2025 13:35:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1749663343; x=1749749743; bh=yU
	sPQFC41qhMgc3h6lZQaTJquX87wjezHEHDeXP0v4o=; b=YmEv+xo3h96MCORC8T
	IRlu4jRFi0GWrOePleIWBSl1AzRZokg4CWQ8DvjE04ncaO1GyLMY4oJY9dlrz4UD
	LRLEKmRDVWO78lQTiRMbTXneTGOAt9nDpY/pTyedrgFrpTYTsZ6Ex3mtyO6k+rxB
	YLvR3TtHhF7/HwS+CciM+XFddsexAgA7E6QofGCSWD42jwuIwIvIJFtpLtx5zDGq
	IygZLPvsXx2XvuleOpUf8P7283xfeu0XBjJK5x9VhlkIJWyQarwvTXlbPXcAli63
	Iwg+7F8VpJvKAhjWSU475pOQEvpQhWQf04wYGw6L6gUIVGCfmydhLzWVlp/Ap0Im
	nQsQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1749663343; x=1749749743; bh=yUsPQFC41qhMgc3h6lZQaTJquX87
	wjezHEHDeXP0v4o=; b=objbdxbsjR8ztA1/hUiXu3+wZRrnV8iaxmNmnMjICca4
	j0GKgugD9T3nk/m1J815PwMfK3xgU+U25eoZMeGrbFNUOnC7tSOAlm7RFSQJtoKI
	cuFh/j+4SATHlgwN+E8U+ABcX+vkJA37EW5Ub+apFtExvxeguHSKVOOx0ZLEIGoY
	9e4+sLwQnRDYRTBl9CkOfwWqTmIy329WcpHViD5ChOxKODEknqqt8DSb5RE3w7rv
	IRn6jzhlTwyGhvPOBlWlqNajIv19pK7tJyLZz8+P7Wv0cptqEB3C+5Yk1ErA7tjd
	aUOfWND+yWpqCzZFjA06oOC477yStckH6ehrhig9pA==
X-ME-Sender: <xms:b75JaKi6ATxQTM5MBf_tg85ysJZnysJ21zabH2f3-MTSrhtTopW_Ubc>
    <xme:b75JaLCFRSU0fd5SJ7vA5y-rzw4_NS_UpREOlobjB13fx9koXUsgdC23q3QetYuZ6
    0C8uqqw3GjWMuma7A>
X-ME-Received: <xmr:b75JaCFkVirPboTybgz98UtFjrT5yaRVCdNq5pLXBGUJY26gxCTHxYn1TrdAinPysy04UBFEADKNZSpF2Fg-lynmOMQqmYrZfyQ0PCs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduvdektdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhephffvve
    fufffkofggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpeetgfekje
    ffudeffeffgeekvefgvedvgeffueejjeelgeduhfdtffeikeelfefhgfenucevlhhushht
    vghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrh
    hhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepvddp
    mhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:b75JaDS0DdadzaQX2zu6Tvm_-HxozQfwoReYvGKCLCE_WCox7S2w9g>
    <xmx:b75JaHw28Oei8YTpM26FuYBYjARWTRl3WTYQ5-66fDCxL66Ar3UQ7g>
    <xmx:b75JaB43cdUBfE6DLxZdufBQycNsoVxtDLEG642dm3pI3t_nuOdw8Q>
    <xmx:b75JaEz9_t5n-slVp80f7eGWkhqt_LPWE7NKeTix88gwP5JRWpcTaQ>
    <xmx:b75JaOhI8Ugmdcc6hpNf9lZdLXbP-NpvBGGqvi2_5pTVClA1AcwC1fEB>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Jun 2025 13:35:42 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: [PATCH] RelNotes/2.50.0: fix typos & other improvements
Date: Wed, 11 Jun 2025 19:35:24 +0200
Message-ID: <d809e4bfdad2bedff66acaad81b3ea2290ae20ac.1749663244.git.code@khaugsbakk.name>
X-Mailer: git-send-email 2.50.0.rc1.593.g32ee0d3380b
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

• Replace with phrases that are more standard (“all-or-nothing”
  instead of “-none”)
• Add coordinating words that make it less likely for you to trip
  over the sentence (“*that* "gc" can do”)
• Use “SMTP” instead of both SMTP and smtp
• Don’t mention `git fsck --reference` since the previous release
  was not affected by this minor bug.  Also say “errored out” since
  the git-refs(1) bug was there in v2.48.0 as well
• Use the more widespread “linked” instead of “secondary worktree”

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---
 Documentation/RelNotes/2.50.0.adoc | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/Documentation/RelNotes/2.50.0.adoc b/Documentation/RelNotes/2.50.0.adoc
index 99acf814875..2a1463644b4 100644
--- a/Documentation/RelNotes/2.50.0.adoc
+++ b/Documentation/RelNotes/2.50.0.adoc
@@ -36,7 +36,7 @@ UI, Workflows & Features
  * Auth-related (and unrelated) error handling in send-email has been
    made more robust.
 
- * Updating multiple references have only been possible in all-or-none
+ * Updating multiple references have only been possible in an all-or-nothing
    fashion with transactions, but it can be more efficient to batch
    multiple updates even when some of them are allowed to fail in a
    best-effort manner.  A new "best effort batches of updates" mode
@@ -53,7 +53,7 @@ UI, Workflows & Features
 
  * The build procedure installs bash (but not zsh) completion script.
 
- * send-email has been updated to work better with Outlook's smtp server.
+ * send-email has been updated to work better with Outlook's SMTP server.
 
  * "git diff --minimal" used to give non-minimal output when its
    optimization kicked in, which has been disabled.
@@ -62,7 +62,7 @@ UI, Workflows & Features
    delta chains from forming in a corner case even when there is no
    such cycle.
 
- * Make repository clean-up tasks "gc" can do available to "git
+ * Make repository clean-up tasks that "gc" can do available to "git
    maintenance" front-end.
 
  * Bundle-URI feature did not use refs recorded in the bundle other
@@ -188,7 +188,7 @@ Performance, Internal Implementation, Development Support etc.
    been dropped.
 
  * The code path to access the "packed-refs" file while "fsck" is
-   taught to mmap the file, instead of reading the whole file in the
+   taught to mmap the file, instead of reading the whole file into
    memory.
 
  * Assorted fixes for issues found with CodeQL.
@@ -391,14 +391,13 @@ Fixes since v2.49
    reverse failed to give the mode bits of the path "removed" by the
    patch to the file it creates, which has been corrected.
 
- * "git verify-refs" (and hence "git fsck --reference") started
-   erroring out in a repository in which secondary worktrees were
-   prepared with Git 2.43 or lower.
+ * "git verify-refs" errored out in a repository in which
+   linked worktrees were prepared with Git 2.43 or lower.
    (merge d5b3c38b8a sj/ref-contents-check-fix later to maint).
 
- * Update total_ram() functrion on BSD variants.
+ * Update total_ram() function on BSD variants.
 
- * Update online_cpus() functrion on BSD variants.
+ * Update online_cpus() function on BSD variants.
 
  * Other code cleanup, docfix, build fix, etc.
    (merge 227c4f33a0 ja/doc-block-delimiter-markup-fix later to maint).

base-commit: 4c0e625c091d4c648cec7319bafaed3cc81658e5
-- 
2.50.0.rc1.593.g32ee0d3380b

