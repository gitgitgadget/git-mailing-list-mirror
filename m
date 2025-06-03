Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1989A238D2B
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959288; cv=none; b=Kg8O/trZ4aIknaIVsukCamSg3n41q7eTCPdf3KCOW9zKe7bBchdBb9p+njPp3rzjhQsdzZ4P4XC7CBFkyNvZ5pQ/qhRvpiMF9w+o3mlpi0rYrQ0AgtqjNogs7aUg5Zxb1vr4xWdbDQVMAsmKR30KMNnA07kJCERRz7mnMbToHb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959288; c=relaxed/simple;
	bh=Go9TKoyLyB1dzAVvlNCSdXm7CImfEWA+RreQVRamF+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UO8ozzWoqGtkCE0aki7DDwlk+fJ4L+X5sezqyGjVBlND3uZ/gwKrNqHvFuNEjYQwwPDOryew031aBz3HaP4u21INuqAIgj3FQlb94d82R222RACU9kBl+c+X9GyuHhEJOANy+icIJL5jtZIZsoD+xaw7aqfyy2ImjxmHVFUjC+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DCPnlXSG; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MXZHuzb1; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DCPnlXSG";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MXZHuzb1"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 109CA2540103;
	Tue,  3 Jun 2025 10:01:26 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 10:01:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959285;
	 x=1749045685; bh=oJBJxfKMVu697ro8zGeBlH2pBesh5cld1rOnE4TEuLU=; b=
	DCPnlXSG6qWWtVYoMy8VoU9j1qQvwNezRPzhhMYpqE52L8ZW24WL1bGHZDsalqVr
	tq7eH8qz2wCu8mjQ2uJQeEVEj1X5IbnWwKI4dIy/OCyeacZjHpQZSE5Vkhg35O/A
	epRWHvntsiDM4gxpJyH4Z7vhpuQTeaTSxxNc0uOBlbBBLj6JA0eL7qj3LglM6qS6
	Bve+OO9rkKGakhUt20uqUWJVhLgOdYHv6bVR0a8CKIa/ZZRW6oRqQD+yyfWADgaw
	HHi31/knOZAdgdsKrJ0osrca4Bnl2ZORllq60FfTzcdwjMkxLTvfLjoJThxpe9IW
	Togku6pRMx6WJUG1ej+yUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959285; x=
	1749045685; bh=oJBJxfKMVu697ro8zGeBlH2pBesh5cld1rOnE4TEuLU=; b=M
	XZHuzb1XZj6eWJKGYd2ZdrmdNGFxgtclW/tPHeVv+yZ8v51PDVKrobFe9xjwuYnJ
	OVjo1Fdd9HD1yUn7rmVhrTZbfgrSkYHhpXxz/hflmDsyYA3jBDcUxyPhg9yExB1d
	BD3DXmQPP9Jt3LARug5hMbzHIooJjO6ndWyCZ2LekY6Cxs/ArxL6a4Ark5UYGZYp
	WSryNum4cbpCf/ZX9l4++XhF4BnVkX8GANLIsqnrGnpo5rytMe1ybLTOtiQNw5H2
	mKKzpw8MapZ6NnmzYjYKECW41diAT+L4CSDjh7+isdDKxqOakwNjkWFZUJ+Ixxn9
	bfZyKYAT4BwEiCu4gdgrw==
X-ME-Sender: <xms:NQA_aGQT4EThMZRtq9BYshd4MR7hhUM7jbE56sOaM6MPP-AX_8h7aQ>
    <xme:NQA_aLw1-oSMwxAFrUb9JvLVoOa4XJsdDgSiA1qlOpSjRGcVYZW7yBvsx7Q2gTBXK
    kcriA6sj64vDTBjFg>
X-ME-Received: <xmr:NQA_aD0hgPPU8rofOMuGwdlU4yeFgqlV3mpNlOVQZdSAhNEakn3VX8HsOA0Q8yrTiUppchwp7QhPNJ2pKKeE3sSgbi3hIKKXWwto0pGasg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopeihrhhothhhsehprghlohgrlhhtohhnvghtfihorhhk
    shdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohep
    ghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghsrhgrfhelse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghk
    khesfhgrshhtmhgrihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:NQA_aCBhipqGUCUN5M9uBRQLH_hj5Ukw-_PSC8kBPDOVAk8LOGhnkA>
    <xmx:NQA_aPje8aVmd_fDSJQjbyEgr3yYb3BBx0IjxVvRwHFfL9taBUGURA>
    <xmx:NQA_aOpb1RMGv96Eqh9U509LTylvaLBkv-3uZC7RK6hoXborgRJBEw>
    <xmx:NQA_aCjwwTwaZ1m6Xnfv29K-f9k7vOantcQeU_58Ow9zkQSoyZis6A>
    <xmx:NQA_aGjTP9GV6y6AWSBpCklqgPQK3WeUVx80d56OEPbs8E-vrZ28FfBd>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:24 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id ac60c39e (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:22 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:14 +0200
Subject: [PATCH v4 06/12] builtin/maintenance: extract function to run
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-6-52f5cf7b7e99@pks.im>
References: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
In-Reply-To: <20250603-b4-pks-maintenance-ref-lock-race-v4-0-52f5cf7b7e99@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>, 
 Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
 Karthik Nayak <karthik.188@gmail.com>
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

