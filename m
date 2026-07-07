Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6931B416122
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 15:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783438388; cv=none; b=VQoMHW6hDirMIl8wGuioMFUCqoEFM68FefTnoJgJ70N33YUfIU1PNI/e4DTtlVWuNppFIm5CTYn5wVjFnvSi1kYlxqsq9Ie/+7Ad0Enjs9NirBe7vcRrcMBJoU3rb90ffaRQGLyRmxxNWjReFayKFnQE9RnIoDxLmWhWJv467VM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783438388; c=relaxed/simple;
	bh=1wkoQaG+U6d1N3oOcYBzEWImnDTUUe96MCwdJ9FU4RM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvrK+819smVQhY42Rhn/MlY/NbdmqFd90lDITNxrvKLcnQhCNg3eJ9uq2rEf1ic6+51fIAO1bWiOs1Zh6P0iy+21Xz9583FJid2HPAg8tuJXTJybR1GCOL+BWt9I+EovAWGIN02RwZ1iftoLPAJrLBL1eIIKvXgsbtK0JkgAjco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=aHfz4M8w; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HaMiwm2O; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="aHfz4M8w";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HaMiwm2O"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A1AB3EC022C
	for <git@vger.kernel.org>; Tue,  7 Jul 2026 11:33:06 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Tue, 07 Jul 2026 11:33:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783438386;
	 x=1783524786; bh=gCiQbjWYhfyQ3eVKHoFZUliNSUoXrfi8rs9PKqb56nk=; b=
	aHfz4M8wgd1xraBwvAB+2lUL5ct8+6Pzjr5YDWP3YGJIh3EEIVtTK7PgDNlqRZGa
	JXllAi3Z2r07FFl+c4UjMCsibqDP/swHI9wAnnN2j6i+9uLjwUIHEVg6wxuFzl8Y
	kiQt+0ZTOw0LEZtc7+irDPVuKoMAD6qcVZ2oqUpyngQHeYh28Wgo8LuhCeBKY1kw
	gTIruPiVtuw99IRI8GZBeeU3V9MI2JNu1a+utFNzWivl89uI8yB/WWjjreL33UT0
	V5SWXQ9ayJ/QqQJlHmD1RArH+vA+Xe+74ddLlOWVcdWBq4rZtAGna6bw/OhTsoqn
	8vWDhkOYgtvhmQk8yPdUPg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783438386; x=
	1783524786; bh=gCiQbjWYhfyQ3eVKHoFZUliNSUoXrfi8rs9PKqb56nk=; b=H
	aMiwm2OyXXf9MlKuZpDIT4UlTXa8kFKapORmywd5YeGYp9+rj08vXLCpFq48krKs
	mC2+/8c69/y4YhcL1SAKPj3ujIdhjiLy1Vn+q6+4KljDuUhkHu3kiO8Zce0F9cfe
	0y6/z+TVaangdJd0LxTRAFAR7YX1xvuQvQwOeVQgZL6IuH/aVGOYoyjIlDAiGfP1
	AXa4MSf0vhRMWjwqJ276aqDkGg09mqj8RCR+B+bnV+BtiyKYkhU/qvpPcSaSaeNy
	6hDARJcZvNGcpSGLTAdivFnYyTEbYoabNDxhhu1DNNoGjh92Whi03e7n+YUb/kRy
	etG4PY7Va4pVk9NRtUDLQ==
X-ME-Sender: <xms:MhxNasIwmxXZaTfI70zEMa4y-gvxVP-bEH7UZK0dKr2FFNuIkxf6_A>
    <xme:MhxNajEjWnZTDEoupIXthgSxe-cRckuG4Y8muCcBgTR8DsIy2eGO89Y1CATIl5jj6
    rGnndcdL5EvxHl_9DrKRnNPxlwhSaFhwThmrQLOzXpTCudZOkH3QA>
X-ME-Received: <xmr:MhxNaiVtTcvXckPCIwcI667q-2ZwrJ9Qw-w9UfybSEPXzIuD4BOZ5RRD0gTflsnIUMGhKVi75YCX2Z2V-ry2itpVKbmVCxLnVBb6NZZCpQ>
X-ME-Proxy-Cause: dmFkZTEJsHBfpO0PYEe5AorOfHcazVp/tBbkPBeEyBKukAxlTkshoZ2/gbuXJescdgLEDk
    2G/3VKtvJlc5njlYrPCxkg9j00cHK7EbceH5LxXeH6PWEH2F+oepzAb9SewsjRo/KIW0lU
    1lQE5NNhIb7f+4g+C5KCZPv4MqEkNsifUe5QUQNQKxPxqlLS2wxm0+oRvJw1AQX0T0+0UM
    M9QSGRn0kaVEjf9V7cMY2jYCFqjaWroOsmMwIqvkSpUhAyQDxnLPwdCWG3jz/2YPCd808h
    PkY/4hDSR4JLrxsPxxXC41eGPaToRv5DPX2LX50SXBrynI5VER33qWb84HYOTOnZBOy4GS
    AaMf+RJTXriMYaJi2zhxeuecCqlzL1+pzcY9KoBCV0n6bskrszWXqbtX+lh+3QTn73oKjt
    ngi3gauff1RE6GfT1knonDphyj0ZaR5wVw64SGrKmNTKSSvLOlXrdQiFbnsNh2aYk4ktVO
    VAGwAjuEiivOAS1OuQ6M+97ia7YtpxdNfd6VWrrVrc3J8XUp1htBiWtpYG9gvqVlBWfy+m
    MCRGVELrLNsOxvTK5Yo4z7u8jfZxQeZmg4Ic714/hcs7o7Nq8TN1G1Cpg+05aA8fQeIPiq
    I8M+fPmAVx4NRnlTSlsyrydE9v1dEeddwSqt1x7gNYsXsMOkUaMH9UJsgXXg
X-ME-Proxy: <xmx:MhxNaug3mDxG-yh3iLN3lWuCJkxu_lUu7gCaSVNAxXoykGTlYoodqA>
    <xmx:MhxNajQzD-qv3DgwPO6SSVOY5v57-X0fOU6y5-nBIvD6xvX70ksKjA>
    <xmx:MhxNahFyFF6doLbzTPZn8GTvtLPp0t85lv0Af0qip_vq4Hc0mrF_Fw>
    <xmx:MhxNarng2mGahzggdoQ-Xsv-AnQX1x5I6p5J6UHdZK3BEzAQV0J63w>
    <xmx:MhxNalpRKkrmKC0fPqX158R4cO8abi5-4i5gzI9o7bBmVL6jM-YpFWmO>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 7 Jul 2026 11:33:06 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 256da7aa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 7 Jul 2026 15:32:58 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 07 Jul 2026 17:32:34 +0200
Subject: [PATCH 02/11] builtin/gc: move worktree and rerere tasks before
 object optimizations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260707-b4-pks-odb-optimize-v1-2-aae607667be4@pks.im>
References: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
In-Reply-To: <20260707-b4-pks-odb-optimize-v1-0-aae607667be4@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.15.2

In subsequent patches we'll consolidate all tasks that relate to
maintenance of the object database and move it into the "files" backend.
The relevant code is somewhat scattered though, as several other tasks
are interspersed between.

Refactor the code so that all object database optimizations are grouped
together, which requires us to move worktree pruning and rerere garbage
collection around. In theory, rearranging this code can have an effect
on the object database optimizations:

  - Rerere entries really shouldn't impact garbage collection at all, as
    these entries are not stored in the object database.

  - The index and HEAD reference of pruned worktrees may reference
    objects that become unreachable.

That being said, the impact should be overall rather negligible. If the
user was asking us to prune objects with immediate expiration time then
we might now prune objects that were previously still kept alive by the
worktree. But besides being a very specific edge case, it's arguably not
even the wrong thing to also prune any potentially-unreachable objects
immediately.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 77d0a5c948..8f568003ee 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1011,6 +1011,13 @@ int cmd_gc(int argc,
 	if (opts.detach <= 0 && !skip_foreground_tasks)
 		gc_foreground_tasks(&opts, &cfg);
 
+	if (cfg.prune_worktrees_expire &&
+	    maintenance_task_worktree_prune(&opts, &cfg))
+		die(FAILED_RUN, "worktree");
+
+	if (maintenance_task_rerere_gc(&opts, &cfg))
+		die(FAILED_RUN, "rerere");
+
 	if (!the_repository->repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;
 
@@ -1038,13 +1045,6 @@ int cmd_gc(int argc,
 		}
 	}
 
-	if (cfg.prune_worktrees_expire &&
-	    maintenance_task_worktree_prune(&opts, &cfg))
-		die(FAILED_RUN, "worktree");
-
-	if (maintenance_task_rerere_gc(&opts, &cfg))
-		die(FAILED_RUN, "rerere");
-
 	report_garbage = report_pack_garbage;
 	odb_reprepare(the_repository->objects);
 	if (pack_garbage.nr > 0) {

-- 
2.55.0.141.g00534a21ce.dirty

