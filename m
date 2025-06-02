Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5092A1514E4
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848657; cv=none; b=StwpF4bateLDprD7Oi1OrpBy1qDOe0uyoecXW14OvgveMgA5bkLguJBX71/Co4CtEnCuucTsf9Z+BWFyEPgIwc84GA28RaZGyK3lOusUP6L3YF+DtZqdc973qgf3oyT56W9WGSWEAkb8O5SDdA8Z6bcAHCk0Ic3r1z4A2iMfxuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848657; c=relaxed/simple;
	bh=ZxAdrZxoinaIGXPBJuU36AMgf2T5J4e0LWz/vCBimAI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PUFX5t7jmnkJdKlp3qOlN/EkRZiTzEtlj4lLu3xHSnN05NuI3oPLTVrcTYB/Tw1T/tkHoGo91C3WGc65Hn/p+MVtXP0OftVngGcQLAsqJm0WIfN0V9IxEmd6u3MyLU02m19smzgYfqJ2bUjfPqzTPUWVoSnSxXbTboY6rm4R9sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=LJQmSnxy; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MnKVfwaH; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="LJQmSnxy";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MnKVfwaH"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5697D25400F0;
	Mon,  2 Jun 2025 03:17:34 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 02 Jun 2025 03:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848654;
	 x=1748935054; bh=pzTZ2yQNnqPm4SaT0MFL7MMCYU6InVZTCVDRTpNvJ7g=; b=
	LJQmSnxyGgxoudqmO3DStqWkFbRtp/amAISyyrSV1oESeCglu4xbEhCOCnQZPWZA
	ErpAG7EN0Q3PwZQNFeE8iq+nxr2hmzVBW/NYzH6WqZCIkYlHMx5FNWGqZ0gzd/oC
	ezMGGABvX05UlsgyAlTEKgVN2J2Rr9qfwWmH8kqYU6LDwlspDpA7oxVJGhCqwkji
	/3kEnvBrf6AtstC+cBpYXZfjFn5zKfHaBd0T5T9FwFTeHNEiQD4DVJxTHcbbY8Vt
	/9WYgoeulrYTQ6oS52F8eamIGABG4DFzwJOJJS3BLaghzAVQ6+z0/uQxM13lHC0P
	zyrHGjtC6F5GTLC4o37zIw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848654; x=
	1748935054; bh=pzTZ2yQNnqPm4SaT0MFL7MMCYU6InVZTCVDRTpNvJ7g=; b=M
	nKVfwaHtxbOq+CI8GqfkZG+7HN8k7g63NfZK1z/59Z6ok786bI6V2ScNpBr2EvFp
	D5mgZgxAsISEJ/MERBmETADlUMpm7XwK5aChemdc8G220lmi+lFH/CnpfHontTED
	Sl3ClL/NFAIAXCTcr8rqtE0fd16TKJuDabmdvC/UK+6k4gBWhl99h3dkHCJMOwsK
	XmlJ30f0DKFTRLwvv8isYKrXE96tm9jD+gOkwNAhC39rRtCHhJMZx7X6jhCJrZNZ
	w+hjZ6GG8cVknXvq4Wjp8jdwrWF7SRSFhWgcyq4ZgVMGpL5PPGsBvjDcTm6eEWA8
	MReZabNymLJdccSoHe2+A==
X-ME-Sender: <xms:DVA9aLNTdj2sYTv2nz7NQjsDSJ2Nm9U5KaKAUiLD01bOt3gc60udng>
    <xme:DVA9aF-RjiVpLnFIaPqkjcT-Sb39ScHNfw4OsgDkJ8g9_lFoyKi6AGhdja4sEDUub
    cFjzqGK5OnQ41KVlw>
X-ME-Received: <xmr:DVA9aKSXQ3EDDEskOAyAiRlMURmlBXdPphq7OHmv6hMoXfjAZF9vjy44Q-Eu8ypOkA9VxnkO__cIKX5e_Q2Ok6oEOZBAWJeqgBsX0G1D1naHZw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegurghsrhgrfhel
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvth
    ifohhrkhhsrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:DlA9aPtUGDzAiFGyDg5AkgyV3CIj2vsG1bCLY0WFCt_vhC017bMSoA>
    <xmx:DlA9aDd1XbD3XJzxBh3k3Aqf8IAZ8mqqvEvdtw94-GXtYUPc1YBS1w>
    <xmx:DlA9aL3utFAEWHwxPJ-yQtxkwDTf5_ckyJcGTjRZrdyv499S0nInSA>
    <xmx:DlA9aP8FYVoq8eHXpsgrXoju-Wcbih_c0ZqiWfflCMFKl0-M0PgZJw>
    <xmx:DlA9aPzrT3OVTRzDPolPZDwn8Hvkb7wx5butq8uPSdNy3BLA_kkjLdTQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:32 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id f9b50529 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:30 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:27 +0200
Subject: [PATCH v3 01/12] builtin/gc: use designated field initializers for
 maintenance tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-1-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Convert the array of maintenance tasks to use designated field
initializers. This makes it easier to add more fields to the struct
without having to modify all tasks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 54 +++++++++++++++++++++++++++---------------------------
 1 file changed, 27 insertions(+), 27 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e33ba946e43..54fc7f299a9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1550,49 +1550,49 @@ enum maintenance_task_label {
 
 static struct maintenance_task tasks[] = {
 	[TASK_PREFETCH] = {
-		"prefetch",
-		maintenance_task_prefetch,
+		.name = "prefetch",
+		.fn = maintenance_task_prefetch,
 	},
 	[TASK_LOOSE_OBJECTS] = {
-		"loose-objects",
-		maintenance_task_loose_objects,
-		loose_object_auto_condition,
+		.name = "loose-objects",
+		.fn = maintenance_task_loose_objects,
+		.auto_condition = loose_object_auto_condition,
 	},
 	[TASK_INCREMENTAL_REPACK] = {
-		"incremental-repack",
-		maintenance_task_incremental_repack,
-		incremental_repack_auto_condition,
+		.name = "incremental-repack",
+		.fn = maintenance_task_incremental_repack,
+		.auto_condition = incremental_repack_auto_condition,
 	},
 	[TASK_GC] = {
-		"gc",
-		maintenance_task_gc,
-		need_to_gc,
-		1,
+		.name = "gc",
+		.fn = maintenance_task_gc,
+		.auto_condition = need_to_gc,
+		.enabled = 1,
 	},
 	[TASK_COMMIT_GRAPH] = {
-		"commit-graph",
-		maintenance_task_commit_graph,
-		should_write_commit_graph,
+		.name = "commit-graph",
+		.fn = maintenance_task_commit_graph,
+		.auto_condition = should_write_commit_graph,
 	},
 	[TASK_PACK_REFS] = {
-		"pack-refs",
-		maintenance_task_pack_refs,
-		pack_refs_condition,
+		.name = "pack-refs",
+		.fn = maintenance_task_pack_refs,
+		.auto_condition = pack_refs_condition,
 	},
 	[TASK_REFLOG_EXPIRE] = {
-		"reflog-expire",
-		maintenance_task_reflog_expire,
-		reflog_expire_condition,
+		.name = "reflog-expire",
+		.fn = maintenance_task_reflog_expire,
+		.auto_condition = reflog_expire_condition,
 	},
 	[TASK_WORKTREE_PRUNE] = {
-		"worktree-prune",
-		maintenance_task_worktree_prune,
-		worktree_prune_condition,
+		.name = "worktree-prune",
+		.fn = maintenance_task_worktree_prune,
+		.auto_condition = worktree_prune_condition,
 	},
 	[TASK_RERERE_GC] = {
-		"rerere-gc",
-		maintenance_task_rerere_gc,
-		rerere_gc_condition,
+		.name = "rerere-gc",
+		.fn = maintenance_task_rerere_gc,
+		.auto_condition = rerere_gc_condition,
 	},
 };
 

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

