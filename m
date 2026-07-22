Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9B82416857
	for <git@vger.kernel.org>; Wed, 22 Jul 2026 17:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784739800; cv=none; b=JnYixl/f86DhWd9H9RQxjlPsqZFEYqWU0iLFBQYA3/BIGdux72SsvVYSzo4rQonOjAlzMHCFRQxdTBgwYb6GALbBhwyjANShbswj+fIe4kl+tZBF6VnV+QMDl1tciS+Uo36Wo4f7OUUGB9TElYl5scQ7D8GxDlM4fwKdUe76cb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784739800; c=relaxed/simple;
	bh=qOmbaGkswMg0NSXk/0hWDc++bqSxfumxHzaeSpBjU6I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fGH8jVKd0HWDlgT+7S+mcgnJb/8JlPanDjYNaEZoZGaFYh2dXRGSgPnfaOm2TiJJvtWKPEYSbcPxuXcf7SpsOn3OMYblhw0Q14tZDJicMBdOQSI5MEz2SdHiQ5kJrUbDFRsbQw/ZEhkgcUU4SZIpQN/W84gF0n0xkB3XyVqNzzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=RFYsqG9Y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GoPwJp01; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="RFYsqG9Y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GoPwJp01"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 5D680EC021C;
	Wed, 22 Jul 2026 13:03:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 22 Jul 2026 13:03:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm1;
	 t=1784739796; x=1784826196; bh=9Jm++pfU9gP9r4WinCe90rilHaLihlnd
	YmlKAk6yb2s=; b=RFYsqG9Yj06Vl2qcLOUaqg0Oep85EBkxc/lsSexOPwrQGYZM
	KUFFzCupRHgYyQ6kmSKIKd3XSBFcwYDe4etXpskOkgdX8l1bdB7aN+YRAPIVXYOp
	TI0tIgmUoKniYPqhuhyPvLsNBjNX+F8A8oNJzPjefP/2V5xxqy8/FNUY0NVWYGd6
	XC171A5Yvht5MbZllHMoYpzNLRjCFFO7bm6gafJw4pae/Qm2f68BxNU9HRZn9ZP0
	T+PXIDHX2RjzNPFvBgyQWLt5IYMBUD00yMyFtSRr6SvVOSNi97OR0omDB/0W0RMO
	/vghkZBBGTHfIBEliKMElBu8ZqQEooHjxhBYgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784739796; x=
	1784826196; bh=9Jm++pfU9gP9r4WinCe90rilHaLihlndYmlKAk6yb2s=; b=G
	oPwJp01mBuTzD5+uWb0HiPDiVnPQn0tbDUT99lyPtoyP/vbHDpma0H027xv3w/Ac
	UICIE9R7YKdokpIeXZ/Hb9ciZsi+69wu0Zz1VAuvWweqyxTEH6ckmv4JBF1RNCOx
	4KKcn+emmEJAvFwyhyASvynNuHsMrJV58STL1e41cmvsT78Jjy56UsdViNDhaIID
	pcpIiyq5c8CW+8sqF+5pxliY5+hSLy1jB82JYUaQIE+uYQGEMeadEi3F/fVGMYN/
	zLsLqpAWNviANViBvWOHzFKFqa2nml3JAi0FV8IXzmx8ssenGB1njpghGnK37w5L
	U+3adkoKyTx5pdigSjFCQ==
X-ME-Sender: <xms:0_dgarF1ftQ4AE-WWrUkFI3t6n1DRQVpqgpEZQPG1LtUhS2ib5kxRw>
    <xme:0_dgamIw4e1F-xWPyC8CY4n35DqPaICLHlUj3RripnLitPz1_cx7Fehp94SYhHZPY
    wyZv-SwPcyxRgzKJvvhyetHso880fQaRM4JqVmRV7qrxeXoNtN7Mw>
X-ME-Received: <xmr:0_dgannb8t3MOTClNOgH3y0WNoq7LMfUI0gZ2Ymfq1lL34z4KEQ_HaHxVJpma-fZsDXmkMELBFLI4XV-ySJNV1grnj-StpzAig>
X-ME-Proxy-Cause: dmFkZTFm9lHYnd/KfAin4HzDdS6HE0C+spY0hN4hS9a2O+Ggu1p5WQ4zAwuZ8g4z+DYlCE
    qOjVrXJt913h/sk5Utgu1lzyj6uPUIlUvczTRsLFBpqz6ADIodYpNaybGaajzOroOEGWEE
    DwjS3bMvCXD9waQLyfr2wdvNRH/30cVlr99GHzzfOIKFsDiuaLTGLEMa8JRXs2cVUI3qP7
    9h2zmaxsQ4kk/GdFzyrRg4UfiftxO6NRBAiVsgKfYyqhDN/2sQ8g7AFWma0d4O18pqvmus
    YBh4Q4649VI9kXCZ3/MaQcoDKHV7gYaTwEi4zqKmzQ0PH8GTOTC9dQ0hiUUsGbebCOqpi1
    jLdTctGS8ZGXun1yaHWdDyhfS9qRRSvEj2MxoHjl4jS79BeIqYzH6+8hpW5gP9jJhkYgI4
    0xo14GvLvW77v9c7RJQeMkWMawzJU439FmH/bf8/KcAIZFEEhNDbMgZzavue0RwiEkQJ1V
    vGUg90yqIUHlXRtvWZtafjtvTPKV0jpvBHAB7EClXEIoCYpI8gE8WTbVm0HdxfmbtkJcJ1
    1/bp1W71MHwpDktcqm2qs0TOCKcSkgKY313SjrWUT98D7J/byeYgloZ11dH9of2cGDzBZ/
    SCsVkHmCaWlvqAp3Yxo5dzKAHFCdjtWnMVx+SptVZO3lgvzqpAF+KDN4roEQ
X-ME-Proxy: <xmx:0_dgamR2uEGxf3H_bD73rnhTjtoPwTkKV0-3_xIRi6GduW7tf1G6iw>
    <xmx:0_dgahJUAxrglsQcUZqxCX9J_eXWF3-iuajikLMPAUEKys3JXisXZw>
    <xmx:0_dgakDet0gGuQ7F0qrv3kPF-KtAjDu0hwTf-eKfrjwBFFhv2Ddxcg>
    <xmx:0_dgaiC0CS6nvUM-YXW7trbv0i6O-QGe5MDjiQHYsUpabMhJK4reJA>
    <xmx:1PdgavTc6RCc9rqOPASaCyK8QGkPcoywlYupsi2b86FkNRZP3lpjYJVS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jul 2026 13:03:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Cc: Jerry Zhang <jerry@skydio.com>, Michael Hore <Michael.Hore@asic.gov.au>
Subject: [PATCH] revision: honor --exclude-first-parent-only with SEEN first
 parent
Date: Wed, 22 Jul 2026 10:03:13 -0700
Message-ID: <xmqqbjbzq7n2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The '--exclude-first-parent-only' option instructs the revision
walker to follow only the first parent of a merge commit to
propagate down the UNINTERESTING bit.

However, if the first parent has already been marked SEEN (for
example, because it was explicitly specified on the command line),
process_parents() skips it with a 'continue' statement.  But the
loop then continues on to process the second parent, because the
check for the '--exclude-first-parent-only' option is near the end
of the loop, which the 'continue' statement skips.  Consequently, we
end up marking the second parent as UNINTERESTING.

Break out of the loop instead of continuing when the first parent is
already SEEN or fails to parse.  This ensures that we do not process
subsequent parents and mark them as UNINTERESTING.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
Reviewed-by: Jerry Zhang <jerry@skydio.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * This time with a commit log message.

 revision.c                   | 10 ++++++++--
 t/t6012-rev-list-simplify.sh | 18 ++++++++++++++++++
 2 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/revision.c b/revision.c
index 599b3a66c3..9b30663669 100644
--- a/revision.c
+++ b/revision.c
@@ -1152,12 +1152,18 @@ static int process_parents(struct rev_info *revs, struct commit *commit,
 			if (p)
 				p->object.flags |= UNINTERESTING |
 						   CHILD_VISITED;
-			if (repo_parse_commit_gently(revs->repo, p, 1) < 0)
+			if (repo_parse_commit_gently(revs->repo, p, 1) < 0) {
+				if (revs->exclude_first_parent_only)
+					break;
 				continue;
+			}
 			if (p->parents)
 				mark_parents_uninteresting(revs, p);
-			if (p->object.flags & SEEN)
+			if (p->object.flags & SEEN) {
+				if (revs->exclude_first_parent_only)
+					break;
 				continue;
+			}
 			p->object.flags |= (SEEN | NOT_USER_GIVEN);
 			if (list)
 				commit_list_insert_by_date(p, list);
diff --git a/t/t6012-rev-list-simplify.sh b/t/t6012-rev-list-simplify.sh
index 4cecb6224c..2284bbba12 100755
--- a/t/t6012-rev-list-simplify.sh
+++ b/t/t6012-rev-list-simplify.sh
@@ -285,4 +285,22 @@ test_expect_success 'log --graph --simplify-merges --show-pulls' '
 	test_cmp expect actual
 '
 
+test_expect_success 'exclude-first-parent-only with parent already seen' '
+	git checkout --orphan test-seen &&
+	git rm -rf . &&
+	test_commit r1 &&
+	git checkout -b branch-f &&
+	test_commit f &&
+	git checkout test-seen &&
+	git merge --no-ff --no-edit -m r2 branch-f &&
+	git tag r2 &&
+
+	git rev-list --exclude-first-parent-only f ^r2 >actual &&
+	git rev-parse f >expect &&
+	test_cmp expect actual &&
+
+	git rev-list --exclude-first-parent-only f r1 ^r2 >actual2 &&
+	test_cmp expect actual2
+'
+
 test_done
-- 
2.55.0-496-g61638ae030

