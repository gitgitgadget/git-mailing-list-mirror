Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E120235348
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617729; cv=none; b=OIwjdIXchixdr4XSMHl5BAriYawxLnuu1l5XVriQ0vla9xTMSOx+aot/JhPlcXfyhIw7N8iWg2rovtmxkvUPwD+XzuCdpZWNOef568/a4Kta5xws9VZy4g2md29cG+a6NgoVkY0nz6c/zLcCG/v1p+93gJMzocKXHtzjjUA210c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617729; c=relaxed/simple;
	bh=iIrhT75rOfFXVBw7ZKZNT4e4XXsLXfpa0Tt92HOQxA8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=CsP+kcofJ3icz9WM5tCQf7qkqj3uU3vCG8y5o4uNH5eneREuiGxVnn5qURVTopKXIK2TOgnwklFpdS2i4zvBGShJUe2UDcv766vvd+1BNTigDh0S6HNehKobl0oVwJyewcRKLIoWqLbLpC3q+qWu9eG1MbZa9sYktMQEEV5kMo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ET39jb5B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JcPcynzH; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ET39jb5B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JcPcynzH"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A527D1140188;
	Fri, 30 May 2025 11:08:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 May 2025 11:08:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617725;
	 x=1748704125; bh=dmUElJW3kNILATejcE5W5Z10QcajvUuA7RaoO3NVRiE=; b=
	ET39jb5B0Y+L8Uoj/dIlE5+whlgr6vSWwTq+eE7n+C1lblqwxH0WDXRSEyTpqd3a
	l7khpvZy4aRSJ4EH3GCe1buisJ1aZuCdgQx58SQ92HGZnAHLT+f8ftVhdBhi0/xb
	2u/yoavVI7Q3l1cDWiPntlXW1KcaVPog+GaekTxgQEeSQwSFNY80UjzlBCM18DIS
	Km7/wnRlug1jHIFIyE9VMr6lbhIZIRHFFA+Nafo1vvM+hkzljQM+SZlCLY1hFjbF
	fvpcfu01vOPdA9RKaXwGL5ETgQcepXXfZdnSnXK0ABQrVeKY6XYbCyHLDNiZwML5
	cAcQpbkhPTeZa1MTR/BTzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617725; x=
	1748704125; bh=dmUElJW3kNILATejcE5W5Z10QcajvUuA7RaoO3NVRiE=; b=J
	cPcynzHcYixqS8CPBwymFcLbphimelcJ9DoOPb4F2L+ucqaOIWTd19DvPxiiTT7r
	zt3b2GPfxkgWbIzPjkCZyKThII9oy86JMKfFnRMk4nlL09PXkMaRKcVlTztdZRHS
	kE0vgAIQsDwUbT9XUp2xjTAxIQN+GYzVwGZroQDU07M/6xL+hrIJi5wBekzN+nHe
	FEBzln0ipf0rn1yyTo/7M0svyteZOT+pesFwUHZv8qxKpd0iHOU3+DyUsghtRvjj
	d/T4XRXuKaJhMspcEZ/yugGSlesEHfVQL8HMM+fJfvCo3hym8uLFouOc91CWKwV2
	nU+fpabnM7WD4BfVm2Fdw==
X-ME-Sender: <xms:_ck5aBXhvr0ZQS1aNzkbL7nItEB_2GcND0vj9vPDU_gFF3ivqTFOhw>
    <xme:_ck5aBnQ0EXKuzUdUTC0NDAjzYH3l3wtVF7g-puPQR8NKxJaNk9RIBc6tBc-CNL8l
    FSV4Lefyli0mYT_6g>
X-ME-Received: <xmr:_ck5aNZoS9GVvS7g49tLU5wDaFbnGEUy8Y5tXthUMWB8xp35hp2oIgSDZuGB3qTBdKC_lbhIXZkOKsPsqtzrQPcJfVgXlJrTZJw1Wg3ilQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopegsvghnrdhknhho
    sghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhs
    rdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprh
    gtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_ck5aEVTd1s0dlsNGiWKevXsGlcJxtvJVylckcG6_wc26Lj6xUSuoA>
    <xmx:_ck5aLk2fvyPc758OYBeQbdlpF91VbNqKzLNWyVGR_dd7IhBAIkjQA>
    <xmx:_ck5aBcfWkgdi0wce0LlSd-IOuYVgJuLwyMrU2_nahbKvbhzPvUbTQ>
    <xmx:_ck5aFF4H9QJ-VK0NhA-K7aMBhNWQtR1jZgkk5YR4q8l2o3isfB85Q>
    <xmx:_ck5aE6R2AJ-g-e0LaCn2LYTdwOaDxIAydRAeFR6IUeHyP4HPKPPcBpS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:44 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 4196c34a (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:43 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:32 +0200
Subject: [PATCH v2 06/12] builtin/maintenance: extract function to run
 tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-6-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
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
2.50.0.rc0.604.gd4ff7b7c86.dirty

