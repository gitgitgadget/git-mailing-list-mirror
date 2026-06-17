Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D12648B39A
	for <git@vger.kernel.org>; Wed, 17 Jun 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781715119; cv=none; b=TYVs06ECPBNrB9dLjAXtQGK3DuPnnMZVIeZOJwCnUcOBNqOvW4nyGsRuAsMKr63D9iGfMJ98smCrI+E1D7AUbzTeZnMty2kIpMqquhpYEH2gacBLaskW+BItM0Jh6Fotio4LVZsEE3PUs+sqcnbLgq8ydMgS3K2wVIrBwXlD6tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781715119; c=relaxed/simple;
	bh=jOuhxG8dWuanBFc9InpS3NTklAUJD52OBqdCJVxVsl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gI4B3WIEW2Fc5OrK7QZD3NdjFci3SK6e5M6xXmN6ox06CN3XPs6SO6PlwBgxLYxKNQrx3XgWXghHh+iI2oISpCvLjKQ2ixS8h2wFDE0xiZbr8KN+2GHXs2t0HVQE+JiTq7ezFT9i8kHj+vhQJZU4eG6x0WmYFiFm2EL+l3xBzQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org; spf=pass smtp.mailfrom=wyuan.org; dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b=PM4nT2t4; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wyuan.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wyuan.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wyuan.org header.i=@wyuan.org header.b="PM4nT2t4"
Date: Thu, 18 Jun 2026 00:51:34 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wyuan.org; s=key1;
	t=1781715111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MfAfpCIepdA8BYIcDsRyvjw6MZaKmIdWnM1AweW6gYY=;
	b=PM4nT2t4jQStDFgDflRFS0e6Y2932Ka5cDh+SOVdE0L36FDbsmWcF5BdqXvPsb7VErybl6
	2Zb+gjxcOnBlvD0euhjTdODpzdWyKjaVQN49vj0xMhiNHgz5hyiobFI+MOvBIElB+4KUZM
	lt/zFSTc11hB/9dUg3oyTYZtEkrrQ7+YvqGaWkS2FdsOaTfW2s5CMO2LtIJLaB381/9Z45
	EmERh4vlJHZuDML8Dvn8eqf+sYPc1JvXrC587l1sfOVUxrb/B6XaY9cle2q/qr0gO8kGYr
	s46rX3Yev1nJFeym7Hy7mEiHb2dhAVHug7EUzV5AhgFD6BXivfDt1URDAWBj5g==
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Weijie Yuan <wy@wyuan.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com, ps@pks.im
Subject: [PATCH v2 2/2] doc: advise batching patch rerolls
Message-ID: <496a08c74ddd9368587d032da7117520af1478ae.1781714757.git.wy@wyuan.org>
References: <cover.1781358364.git.wy@wyuan.org>
 <cover.1781714757.git.wy@wyuan.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1781714757.git.wy@wyuan.org>
X-Migadu-Flow: FLOW_OUT

Contributors often need guidance on how quickly to send later iterations
of a patch series. Add a rough default of no more than one new version
of the same series per day so feedback can be batched and reviewers have
time to comment regardless of their time zones.

Mention factors that can affect the timing, such as series size, review
depth, substantial rework, and how close the topic is to being accepted.
Also point out that avoiding rapid rerolls encourages authors to polish
each version before sending it, so reviewers can focus on substantial
issues.

Helped-by: Patrick Steinhardt <ps@pks.im>
Signed-off-by: Weijie Yuan <wy@wyuan.org>
---
 Documentation/MyFirstContribution.adoc | 20 ++++++++++++++++++++
 Documentation/SubmittingPatches        | 12 ++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 00704ab91e..f8f5f4e320 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1330,6 +1330,26 @@ previous one" patches over 2 days), reviewers would strongly prefer if a
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
+still coming. If the comments require substantial rework, sending a new version
+sooner may save reviewers from spending time on a version you already know will
+change significantly. If the topic is close to being accepted and the remaining
+comments are small, a quicker new version may also be fine.
+
 
 [[reviewing]]
 === Responding to Reviews
diff --git a/Documentation/SubmittingPatches b/Documentation/SubmittingPatches
index 6c1e1f6423..13f180a8bd 100644
--- a/Documentation/SubmittingPatches
+++ b/Documentation/SubmittingPatches
@@ -58,7 +58,14 @@ area.
 It is often beneficial to allow some time for reviewers to provide
 feedback before sending a new version, rather than sending an updated
 series immediately after receiving a review. This helps collect broader
-input and avoids unnecessary churn from many rapid iterations.
+input, gives reviewers in different time zones a fair chance to comment,
+and avoids unnecessary churn from many rapid iterations.  Waiting also
+encourages you to polish each version before sending it, so reviewers can
+focus on substantial issues rather than typos or other small mistakes.
++
+As a rough default, avoid sending more than one new version of the same
+series per day, while considering the size of the series, the depth of
+review, and how close the topic is to being accepted.
 
 . These early update iterations are expected to be full replacements,
   not incremental updates on top of what you posted already.  If you
@@ -619,7 +626,8 @@ letter" message (see below), the first patch, or the respective preceding patch.
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

