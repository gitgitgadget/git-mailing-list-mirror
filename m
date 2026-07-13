Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A085A356749
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 05:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783921947; cv=none; b=SESW/6usdzYUpSB5bJW4Cow6kcWHPUyyQRML5rpVrAjcfakaR6n39TRN57KplnAnPg8m7J4EVsDxIK2S7mS2lyAem5azVs4YylyK1iijh+r2i4+pbWOhe74lNu3I/JNTWIdkGlEDHa+pjFuFvf0zabhVW1LKuDTJNt6oiuu2Axk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783921947; c=relaxed/simple;
	bh=Sj9TqtrjLlLMq2y4nSXnn9wLTpxtESS33E79caCAg20=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=AI8qnme2/YK6NmUbnuj+uipJ0LAljq1NylBHW1wMMPlDLFWYkDRPal7/c/BvHL0GHXmvULIOTyqeliT2v1DgGd5ET1h0iuzumL+vCgcT5YJ2gTI9hCcqpxIxUk8qmYGaPXtjol6ADKRoHRhBdkU1ZZgBhIAqZ+Pt3UyNNNomo2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=MpJyIMxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=DeXiMUi1; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="MpJyIMxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="DeXiMUi1"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 5A3A5EC013B;
	Mon, 13 Jul 2026 01:52:23 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Mon, 13 Jul 2026 01:52:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1783921943;
	 x=1784008343; bh=uIgCOo8Si7LrYMqsLR8/1c/cMI2l6ShkbozzZ7Xo+FQ=; b=
	MpJyIMxYzNW/2fnco0sXN6sJ88Aen3/kHR5Exm8cYMcs1G1PzgyKH9g6lPaX4ja/
	CY/SJ8kbwkJlEFSJG7EOB2fllWakRra1s7e5X21D5AUgqojQ5/GfL1CRLocpxBF6
	DSrXXihq9MQmyZutmK9akeYFlSyZLpXcB9fThc9Valr6itWtmjPO/5anYD41ThxJ
	2NzK9SaDJD7Ag5TxybcnF2PsZlUC2FFjjFZMiIzvs44tT11ch1fVh4pFVvS9xg6H
	mC+YHPWTmHI1IrP6pFWg5vR0zq+Tav6qLAFpTR4Hl456EVnV5KJt5cS0pL0tPuSZ
	uXArvL0wQxTy/+z43D6HoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1783921943; x=
	1784008343; bh=uIgCOo8Si7LrYMqsLR8/1c/cMI2l6ShkbozzZ7Xo+FQ=; b=D
	eXiMUi1C8izre6aiO/FJJ7QbGG3FLgbBWC+kBjQbEnx2IATb6tJxw3hooRPX9XWT
	gPGfJy36fPR2Ds+LNmnauAIBDMwnMC0fNLFjnELaSRXEpVn5kCpXt8TJtzzRSCLK
	GDQeZ2jBiHf9whodzXXDx60LZzs2nNf07642vR0yl9AUBVMDN10f8hUHJsHAGiNU
	zIU9hTYXgr4wRgxGsMXZDpZ42fa0Lr3kRbbkHlAqVmmwVJZFpUqZzaCtLwOtG4+S
	Daowu4zqoHKr5nD37rgIeMCYkT5r3yTkWQy81a8ex83oEjKZWec4lv9JApJjiz2m
	xDxgzwv6mr4Zq6aFWCsMA==
X-ME-Sender: <xms:F31UavIK7KS0Zn5Se7vE76zWFY6-MTcGzA_c8bKIjuLolhnHgSDWhQ>
    <xme:F31UapK0ARaEx2Gmj3xvLpdZKlIVyCCwNbmfegEShy53aOkUUnR_v4zxaFDOJX71R
    _xYoCWw3fmIlowPEM8jdig1SXgVWT1yjXIHqhBRV0h9uN_0qv-hdQ>
X-ME-Received: <xmr:F31UalUE1i1ZazVqAl4Jhf6R3V63BObbXGRzwJWs5-7el2mEXXGV4YkjXZhZ5dcemZ4lme-3MDEzWWoUDuKOVRgEFqYe0Mo-FiJeIaup>
X-ME-Proxy-Cause: dmFkZTE2DwhiZeVd7s4BnOPVbBPXP1kZFTu6+TvJ2QfwCaPIfyeEJyQFod28bhJlHOLJFP
    nAxQLb9PyOO9WVRa0i1G4bQ7dN8ngY1INL+0iXLC5+UJ0NuVeK2EeEXubgho5kIiQKgwPD
    JabziqXomO03uQOEO12TgFiGlVlkIpLppS8snC/PmmXtFgM/sab6L7D5RPZS6GbJ1No3/6
    buMEU3X2Y9352yqKjFjBzD1THQoyUyJS+xnXCQzTukbErdh0mTxzV0KhTGfuuFWgqPqU6c
    0XJGk/CB1ffydb4y2My9Bbz//9Ylvn5KE8OIP3L7iVlloga1alcLHwg7BNDbyp1ynMoOE3
    c2r1CehU4fqwxUd5kVB5qRpveLI6lXGXELQAXSNM7SXEx3c/BvS3Bwflxuyf8GsIcneTC/
    LupJxYJ8oTMdAN52EiMjQ1P1QXSpeyu3PMpsFvlIOu7BPSwlQreNJ8KFUWfVamWAbYOt27
    V73ZMaQz2TRWDeo2xQ8082xkRD18+1gFtDjyLeqC1oFZai/CZm+gM1S4z2gffEOIEj2Q/F
    05IvwTE5StgYvy6GdwvIeTABssj8EIskDbDgbxoZiXLPZFbFZUH9wr/35MFOSOow56Gr3/
    6s09fEHPv0mKYlFXcM682Sj0V2DVPRVGr7MUiJRLm+Fx2ToS9GX7QJBw8Vag
X-ME-Proxy: <xmx:F31Uajh_Oqh1fbMPdQ4acVxuPjanE44_wAcJx_9wLe78VNJHaM0rBg>
    <xmx:F31Uao_4mvCRGxY1spQIt9f0pyGxoGtuLM6sQx1P6re8jElMc1wbcg>
    <xmx:F31UalA6uHBhLW7F9prGQ-sJNmCiGRJKWnSlv5mpJcWtTgXnAJOVPw>
    <xmx:F31UatJmKYBZtR9pId1-FageztZUm7dJi1teXogYw1Pcq_R_AEYneQ>
    <xmx:F31Uaih6K0jztd514nKuXywwJjemvCxNFolUTUhDCGzpv6ehADQQzRHB>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 01:52:22 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 9704b924 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 13 Jul 2026 05:52:21 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 13 Jul 2026 07:52:06 +0200
Subject: [PATCH v2 03/12] builtin/gc: move worktree and rerere tasks before
 object optimizations
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260713-b4-pks-odb-optimize-v2-3-9c2c3ee94b38@pks.im>
References: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
In-Reply-To: <20260713-b4-pks-odb-optimize-v2-0-9c2c3ee94b38@pks.im>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
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
2.55.0.313.g8d093f411d.dirty

