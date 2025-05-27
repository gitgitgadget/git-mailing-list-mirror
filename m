Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD4A278E40
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354679; cv=none; b=oNisBIQ7pVoXn+uvUdWTc0hO39P00M24G10fmQBaxu1l8OukJzZU9OTNcT34MBc6f4ngclEQ2QUJ59Fyc1r2vG1f7U+3HDlaA/F/7iXUIn0FOP1dFz4JhNy7V4MNSgUyKv6X7n2woiLQ5AogEf4eiG9iV/Hw2wiVVM2XaGnAoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354679; c=relaxed/simple;
	bh=ujBLkIT1e7DQqramaxrYMNNQ9eHXnF03dHgtcN+ddGM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=S87+5t/mDvdnPLXMQCN7/ZHDVEOmmm+h8zbFW0rT7J/Ze4aSBvZl/TgvXM/Rr6gV+Uu55xVgyPBfQkiaX59tvP3kddkFIAKnA66VGL30DAiTp2jZ/qS2mWJoFCVp/QPMjJt0tSbWvIV04u4KrP8JaTNrXdQAE+3QgqiwNw/95Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iPamxmYW; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JEiA2HfG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iPamxmYW";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JEiA2HfG"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 305471383AB3;
	Tue, 27 May 2025 10:04:37 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 27 May 2025 10:04:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354677;
	 x=1748441077; bh=5WT9f/wYH5Lo/snnqPIfbPbt+oQAJAGYfRQggpoT7oI=; b=
	iPamxmYWxesGAMlD9XzHZsikMJsuGlYpveMOk4ZRT9Bxg7m3up2csa7DnJN5KAR3
	4E25/1YS+xx/eEHk4J7NPNpvTRwJwnGOy3cTt5r3po0CSESph6nu50yJDceQ1Esh
	qxPUA6sdCgjB6JmhTT/QUCsvaStTvEmA/Ss0nQoyELCGA67TfN8R2gNH99lwRsU8
	7XMq2IWDWb9kd3YOU4mrMqYBJoweam8eFcT/8l+NU4R2lIixgp1SSVxnTyDQ85bs
	1y9HXCxq0ETtWpFRvfuiTFSAtgcUimcYh8sKQLu7Nfs5/XpU7/VrV8GHS9IBS0S3
	VJdjtBXleQdOmvAXJcoFSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354677; x=
	1748441077; bh=5WT9f/wYH5Lo/snnqPIfbPbt+oQAJAGYfRQggpoT7oI=; b=J
	EiA2HfGDftmCLdKrAMuYl4x1G6jOjvVV7zdDiHn77lN+nkykVphlj4VgAf1vG1Y5
	7430HfxKKbxz9sAbiZK7ZRUKS8tYMoml5veiJkrU6C20xf8OHZYnwlz9/2M2gabU
	SU+ayOBnn8esKKhMwaBiBCJSnAY4BKeD86g1WrRy1BU6JFTJ0m1c9P9BFp7NZvR7
	5xEYOGp15iXq2Rmh0yGEBm7UQ83fF/PgoFxOG820meFRNw9LNJyhOIRqcqnZ69ex
	G+EftMsDhMSBOCERpyS/A55yMclGa2EsZhjOadvWfFG/BGxNBoUJtSa7yvF+e6Q+
	NvFgTf9w2lVD6bb6TAEew==
X-ME-Sender: <xms:dcY1aAh6g5BgvNT79fCyMDOpczhTpM7CP9mVI2XzgLSfVXp-Begn2g>
    <xme:dcY1aJBB9F6UimfrVJCxq4sMpAR1sNptwtb53263Pg_gHKrVCoD6tiupcB6BCY8pd
    wcBK_AVcLP8s78sWA>
X-ME-Received: <xmr:dcY1aIGiBynTMxbcNyDZ1weiWlSD96qQk7_rRK_QTCLkMEFipl2B-Z3e1k2W2MNfTEbKQCbg00RK6lAC4on6O34k8vmdi01AKflOmiYuQlwAVQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohephihrohhthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtoh
    hm
X-ME-Proxy: <xmx:dcY1aBSDD0Zdn5rhb0BXfBlEDoKJfaTdJIMOdBSj2MKwVnCsZiijOA>
    <xmx:dcY1aNyLEi9y03aPUQWnsdsnVZyYzsT7npFNoCcM13q7MsSyNl4ciw>
    <xmx:dcY1aP7QQ-zHxa1bgP10AEcmVHhz2Cobkl7J3KZZiui69CAgLgPn9Q>
    <xmx:dcY1aKzBaefltJE1BREUlJ0fvTYpElQI1LLlowpTClUOIJuUgcSWUg>
    <xmx:dcY1aLMNFbX0KIVJnIm3G70oRDzPArcM64LyFWNab6elmXhOUhdG404m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:36 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cc228ddc (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:34 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:32 +0200
Subject: [PATCH 06/11] builtin/maintenance: extract function to run tasks
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-6-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
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
2.49.0.1266.g31b7d2e469.dirty

