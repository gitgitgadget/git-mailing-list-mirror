Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DB361B0F2C
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848660; cv=none; b=hG65vfDIVd8uzqUtZAlbuM0sWTICrpwJJPVztPbWY3NSJovGA9gcC35CgHlVwo8EwjMAs/qmvC1V1bCqa+6DnrE5uobwqJROxY997fQCMrinKezR3kELI5U/cJ4dyHv2ZJn6CjOCV6dBF2jdg1+XjwYybSJ26Gr03wdHZVElMno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848660; c=relaxed/simple;
	bh=Go9TKoyLyB1dzAVvlNCSdXm7CImfEWA+RreQVRamF+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jlaIK19ce59gRj5U+C9z8pVGBhfm5RnPrL51n3+ZSBSSOIt8ZsXalfEFAHvYOw3to+yuCTUUx4BOPNI622vxBoRQrFvNhblV+grQxOlMcFv0De96/xnQkhBZh16rcEy9dLtCSZlfAoLTzIM2CLvYxsiv3FoIWbb83jLzVs0WFZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=hWe9TSfP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LYyo0EDK; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="hWe9TSfP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LYyo0EDK"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 587C025400D8;
	Mon,  2 Jun 2025 03:17:38 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 02 Jun 2025 03:17:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848658;
	 x=1748935058; bh=oJBJxfKMVu697ro8zGeBlH2pBesh5cld1rOnE4TEuLU=; b=
	hWe9TSfP90UyD64mWx5BKR3FXqBGztTyMpZdYxuQ4p6Cgz5F3tCAZwMCH7GE3y1Y
	vkR6M6qvDKNFf9TkEYIJPaXXVftduRQfBEOS5bjkBprTr91cCa84/x5kYqgB4skw
	0i8wqe1ao8YIWhlVkyNBC6dHSIO0z3D7jUsJqnHtljg+K6PkUtcxMAutVIoUZpY/
	G9FL1jPhoKu7zNn7lJZf65t0izwjpaI7MvJgu5VSwpPtPO65BPmajGhQze+MS772
	HoNIr2IPzV6acCxJGDqwqyS8+aE/1FZ0L9ch8sISiVGeSPz3hd07sGdKOi5TfoYP
	AKUpCLLCBbhWtEiGLWPHOw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848658; x=
	1748935058; bh=oJBJxfKMVu697ro8zGeBlH2pBesh5cld1rOnE4TEuLU=; b=L
	Yyo0EDKs6ggZCo+gf6YCatoWkHGAiXvIf5TDD7Cr/Ir8fVmYw4lZWE5zjagT8IQk
	GGp+ORGN8kpLeGoqBhX/AtsrbC2bmvcO7JyAhlRuh5YKvXzox62USO1nYoiDc7ob
	+BUCJkCUjVS5O07vnZqWQQPc4A0BDaieJE8Aey9ZazqQ35QuAMAS2KvkdvILsMu6
	TNmg87S8B7dlilS634xFbOKwG9AM38M25t8gJTIPma5nAb4B29iRq+dT/w48SCAT
	KaEZSEQxBz0sFcGqjV2GUI2Z3kIcU3xubPmPm1g1Fs7u74J0R3jeJmwFXQh9TAM/
	WBINJbgcmmmB0m0J47XxQ==
X-ME-Sender: <xms:EVA9aF-Iuv8P_Psyrk21gMHQwZ27-oVE_b5XZ0R530vPrhM_dUFBmA>
    <xme:EVA9aJuGe9rKpBw3vd6cMMAimZhBfKjVRwoUs0PSAMzhrO9Jq5ZDGgBCexfM17lK7
    r3tJOjB7kt5nb4yMQ>
X-ME-Received: <xmr:EVA9aDDqy3k5hsFb7IX6N0ZKwR6HIYWC8yLqdJnmzqp3e9CXA3Wgz790-2CrlsidQ8KJUn-TREsFlqiZOzpwglOn-34CWNYhjBJf7KHVj5kHSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtheculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhg
    lhgvrdgtohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkh
    hsrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprh
    gtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:EVA9aJdCXdmhvonO1WlKCe3ORfPry_6FlUjNmdefp3udI8M0G34ScA>
    <xmx:ElA9aKPIAOiVwmTiqEFYvpM6MjU0xNOlUSaxYfJGvGyTWsU8ulwv4g>
    <xmx:ElA9aLl7wk01IVZTE_fdFyIGMwwoWNJACzyb2UAVB_hOxNpSzxyASQ>
    <xmx:ElA9aEt1IMb5n3PD3Po7xudmGPTu65bPpLI1iEt9KlwCtPOhBaFy8g>
    <xmx:ElA9aEgdaW_Ss5WUH0XV1NZ6qYn-tkytVu3oSqAhV7bJng4kRB1Rmh0u>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 71451599 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:32 +0200
Subject: [PATCH v3 06/12] builtin/maintenance: extract function to run
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-6-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

Extract the function to run maintenance tasks. This function will be
reused in a subsequent commit where we introduce a split between
maintenance tasks that run before and after daemonizing the process.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 35 +++++++++++++++++++++++------------
 1 file changed, 23 insertions(+), 12 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 4d636237cac..cfbf9d8a2b9 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1596,6 +1596,27 @@ static const struct maintenance_task tasks[] = {
 	},
 };
 
+static int maybe_run_task(const struct maintenance_task *task,
+			  struct repository *repo,
+			  struct maintenance_run_opts *opts,
+			  struct gc_config *cfg)
+{
+	int ret = 0;
+
+	if (opts->auto_flag &&
+	    (!task->auto_condition || !task->auto_condition(cfg)))
+		return 0;
+
+	trace2_region_enter("maintenance", task->name, repo);
+	if (task->fn(opts, cfg)) {
+		error(_("task '%s' failed"), task->name);
+		ret = 1;
+	}
+	trace2_region_leave("maintenance", task->name, repo);
+
+	return ret;
+}
+
 static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 				 struct gc_config *cfg)
 {
@@ -1627,19 +1648,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 		trace2_region_leave("maintenance", "detach", the_repository);
 	}
 
-	for (size_t i = 0; i < opts->tasks_nr; i++) {
-		if (opts->auto_flag &&
-		    (!tasks[opts->tasks[i]].auto_condition ||
-		     !tasks[opts->tasks[i]].auto_condition(cfg)))
-			continue;
-
-		trace2_region_enter("maintenance", tasks[opts->tasks[i]].name, r);
-		if (tasks[opts->tasks[i]].fn(opts, cfg)) {
-			error(_("task '%s' failed"), tasks[opts->tasks[i]].name);
+	for (size_t i = 0; i < opts->tasks_nr; i++)
+		if (maybe_run_task(&tasks[opts->tasks[i]], r, opts, cfg))
 			result = 1;
-		}
-		trace2_region_leave("maintenance", tasks[opts->tasks[i]].name, r);
-	}
 
 	rollback_lock_file(&lk);
 	return result;

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

