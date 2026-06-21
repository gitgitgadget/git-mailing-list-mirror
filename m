Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A25E238C1A
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 08:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782029153; cv=none; b=B1tO4kkwKrOzyz6ZCuxmun6s2hQ5yRsHqsk1gLKH863YvwPASA1AYznY1uzwwBYmieGf8nzgy/BrxbAqTnzRoIZPV/eDRT2xtYR9Bo/z4cyJMhRCcLa18UIDbhzbr8xoqXLIN5ONgYRJ0UKAa1eY1suADpu+qZVmrRRZ7cJoG6g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782029153; c=relaxed/simple;
	bh=FMsr11SHb57afqOxi9TyausTQP12tvVyRtOExIgAu0M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AyH2YZc+f8mIkWr9RQi4NWleyv/Xmxc+xeKarg3wYblHaT2jnM9HbjdbTF5QL8Tyv/oKQ3P9foBxF7auvH00ubn9kHP3WLlOfClWThWRltLCoIf++2E8uySD4VUYpkfy1vHWtWsiOW7O/8is8jbR4zNZgxbTBMj2Ynzj7b+D3GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=HAmJ+yMr; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="HAmJ+yMr"
Date: Sun, 21 Jun 2026 16:05:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1782029149;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=QG+Tf0F8YDGIa22gk1uftQbNy9c2ZbAR61lUyba6A4g=;
	b=HAmJ+yMryfe3009kuCkrj3v+ncCmzLL05AjQKZr32k2HUNojb5TXhKOuwPs83ReCZnF6Vf
	iiC5zDGaLzq+uQnxCDc1/2QpnQ4MiTkgyeD0pip43B8KqK3HvOsSbF3gWyDh3OIRPQqJE1
	+N9OyL+6gqLurBy2hV7q1VNFCQhqRpkXYWTzEbhhK7u4CNc1OMz5Hj8t9czgD1vmASa6ru
	7EeKMLeZXd5qnTaXPA9KzOI0YPtE0d15DbUM5NwgNL8Icf5TtO8bmoo3HVHW+d+5QtgvfB
	ireMJ84RxOWr0ZVCmVFNUth9OAKFk1AmG3zpRzwKM4ZHCXVXjrgJvEIdqOBXaQ==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [PATCH v3 2/2] doc: advise batching patch rerolls
Message-ID: <e1050a6ef5e26299b2c6d9743067fe3d7f4f8071.1782028813.git.wy@wyuan.org>
References: <cover.1781714757.git.wy@wyuan.org>
 <cover.1782028813.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1782028813.git.wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Contributors often need guidance on how quickly to send later iterations
of a patch series. Add a rough default of no more than one new version
of the same series per day so feedback can be batched and reviewers have
time to comment regardless of their time zones.

Mention factors that can affect the timing, such as series size, review
depth, and substantial rework. Also point out that avoiding rapid
rerolls encourages authors to polish each version before sending it, so
reviewers can focus on substantial issues.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 22 ++++++++++++++++++++++
 Documentation/SubmittingPatches        | 13 +++++++++++--
 2 files changed, 33 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 00704ab91e..35105bc3b4 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1330,6 +1330,28 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
 single polished version came 2 days later instead, and that version with
 fewer mistakes were the only one they would need to review.
 
+This consideration applies not only when going from the initial patch to v2,
+but also to later iterations of the same series. There is no fixed rule for how
+long to wait before sending a new version. A useful default is to send at most
+one new version of the same patch series per day. This gives multiple reviewers
+time to comment, gives reviewers across time zones a fair chance to
+participate, lets you batch feedback together, and gives you time to think
+through the comments you received. Knowing that you should not immediately send
+another version also encourages you to review the patches more carefully before
+sending them, catch small mistakes such as typos and off-by-one errors
+yourself, and let reviewers spend more of their attention on design,
+algorithms, and other substantial issues.
+
+The right timing depends on the topic and the feedback. Larger series usually
+need more review time. If the only comments so far are minor, such as typo
+fixes, it often makes sense to wait a little longer in case deeper reviews are
+still coming. If the comments call for substantial rework, do not rush out an
+updated version before you have reviewed the larger changes carefully. Instead,
+reply to the review that prompted the rewrite, say that you are preparing a
+substantial rework, and mention which parts of the current series will become
+obsolete so reviewers can avoid spending time on them until the updated series
+is ready.
+
 
 [[reviewing]]
 === Responding to Reviews
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6c1e1f6423..d89efe0707 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -58,7 +58,15 @@ area.
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
-input and avoids unnecessary churn from many rapid iterations.
+input, gives reviewers in different time zones a fair chance to comment,
+and avoids unnecessary churn from many rapid iterations.  Waiting also
+encourages you to polish each version before sending it, so reviewers
+can focus on substantial issues rather than typos or other small
+mistakes.
++
+As a rough default, avoid sending more than one new version of the same
+series per day, while considering the size of the series and the depth
+of review.
 
 . These early update iterations are expected to be full replacements,
   not incremental updates on top of what you posted already.  If you
@@ -619,7 +627,8 @@ letter" message (see below), the first patch, or the respective preceding patch.
 Here is a link:MyFirstContribution.html#v2-git-send-email[step-by-step guide] on
 how to submit updated versions of a patch series.  Before sending another
 version, make sure you have answered meaningful review comments in the existing
-discussion.
+discussion.  Also give reviewers enough time to comment before sending another
+version.
 
 If your log message (including your name on the
 `Signed-off-by` trailer) is not writable in ASCII, make sure that
-- 
2.54.0

