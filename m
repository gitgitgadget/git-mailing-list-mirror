Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA35F278163
	for <git@vger.kernel.org>; Tue, 27 May 2025 14:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748354677; cv=none; b=PY0difDYfiZPMvaeUHMn8ClcdE20WTJA4u26RIGzFYdWOLvFFVjSwYuIrMyobVdb4ntFTiel1ToxFbu9Ffa/E12dl4pJ2lbUXAAzJuS2rHRA+UDE+DVFXT0PzEhRFyImw0X5iQjy5aoObENcE0qPxgjgVLdgikXayiz8hXHpdjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748354677; c=relaxed/simple;
	bh=0cx8bgd8pnga3Q6Wi7jG8+mpYaN5b7HislsJSdOdw2Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6ArvXdiJFbxq+vm7/Ghkvx5/Fjj6udcASCsPXuiy8MnP2skDGgKs7X9IdTw0QwxpvClH83eX7l2v6fEDQL//31fj66+qmL+YlyOvTBSCok4WPmkXVYkqR5mLcrJvnRIgMoFKHftS4nZxfE+i6ff3m2MSqxBdNC7o8Nd8sQROZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TR+T16eb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dJOCwRPx; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TR+T16eb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dJOCwRPx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 181551383AA9;
	Tue, 27 May 2025 10:04:35 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 27 May 2025 10:04:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748354675;
	 x=1748441075; bh=ddywd4mklQnwI87/gLQ0tLIDT23K7q2z3jwDMPtQO1w=; b=
	TR+T16ebf/Vsq1G9th/jZ4BcBT/HJGSona7QYaynSlijpiFSig81kaktVwXyFV6v
	Ze5ppJIviYRKdjxuwMMg5NNT+kSLDVh279k4COHAVh7+K3ygqaBsHfZAmM60wKb6
	eRxy/qzvbOD3YUjBh+HhOUQV25tj9Z9X8fSYvmWckpovOir91VnyKbW4iNdefEE1
	ytK/qBocPoxpXAy251yxy8soPYbxabkO8ObiiqDK5LTzWWF1kEfYGNPD5NjxUAmE
	RWkOb6aTzulT+aM64YlSG3dmpO4IL24JABPPdO/qF0Llkd9tnwuvBLdYPLI0IFcR
	NBEK6+s6LzrhliuD/zt0Ow==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748354675; x=
	1748441075; bh=ddywd4mklQnwI87/gLQ0tLIDT23K7q2z3jwDMPtQO1w=; b=d
	JOCwRPxrp2dfbVXnT9zU5jPhOUxZo0Qm+6/1IGj5fcW1G65BNTpDzO/PN5WpF16b
	FwptfPO0N1NXiFIVHeiR4vnrccjx9X9viY43ka45vCZLUWR5D5OhP3MCwPtPdLKE
	eHEgUSEo4Rt5sW4IcAC91nloxywyCh6BTiKhsX7lTtvzZvZhNfgFAlEYt/vSMlrE
	ACj4puUMYF1LFEPJKuN2EYmPrZRKJgNAxP8phu7vTrAqSXY+Q8G9uuZL4BYT7OV+
	Jcfc4FVZ89+Y6I0am9LNyoVj+WpHlSMSN/wClVj4qeHBHNu8YMEOBUXf34ZxZyIJ
	AIHGaYet7etev4ehir4RQ==
X-ME-Sender: <xms:csY1aEzO_-vXMgH-dl_Jq6ALIlaGXV2AiTV7Zl4N29DtVCnIHytiZA>
    <xme:csY1aIQ6Sa3yoz4rmAGydygGYdXA2UhoUTyq1iHPq4L8NPtxJoKvywQSN9AY_xVz_
    oLn9RbCu8jVm6b1GQ>
X-ME-Received: <xmr:csY1aGXa0POPn11vvDY2yDHiHcE8uV6o28Vcr5X4QIfe0WjX5M2Ph-TDXVyZtAU21TQBLDA6zJB2jVlrbLAG515hMvAca2Ycp-rZuuoRYQ-byg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvtdehjeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohephihrohhthhesph
    grlhhorghlthhonhgvthifohhrkhhsrdgtohhmpdhrtghpthhtohepuggrshhrrghflees
    ghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorh
    hg
X-ME-Proxy: <xmx:csY1aCgnI6SyIb7rcFZ_RZz8fQ7EUjTypqiYU5RVIA4AE0Hz0eg5xQ>
    <xmx:csY1aGBgSX18ic4e5tJT-jPu4tYrlKJyx_52wx0-ki874p0ofkgIoA>
    <xmx:csY1aDLlOt4NM9Xb1ZOJRmVEM8outCukG4CrKhAsWy2_7MtvWhU_jA>
    <xmx:csY1aNATtKGReVWRenPrSWwTICMZaE8AzCtDqwXHphnWU9DEev4wVA>
    <xmx:c8Y1aOfqZ37KrDTKBz0ihGX3CIEUTBDc4Gr-hloChOiUpQtqt-jDn8q0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 27 May 2025 10:04:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 238affd0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 27 May 2025 14:04:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 27 May 2025 16:04:30 +0200
Subject: [PATCH 04/11] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250527-b4-pks-maintenance-ref-lock-race-v1-4-e1ceb2dea66e@pks.im>
References: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
In-Reply-To: <20250527-b4-pks-maintenance-ref-lock-race-v1-0-e1ceb2dea66e@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>
X-Mailer: b4 0.14.2

The "--task=" option explicitly allows the user to say which maintenance
tasks should be run, whereas "--schedule=" only respects the maintenance
strategy configured for a specific repository. As such, it is sensible
to accept both options at the same time.

Mark them as incompatible with one another. While at it, also convert
the existing logic that marks "--auto" and "--schedule=" as incompatible
to use `die_for_incompatible_opt2()`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           | 6 ++++--
 t/t7900-maintenance.sh | 7 ++++++-
 2 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c4af9b11287..57d7602596a 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1785,8 +1785,10 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	if (opts.auto_flag && opts.schedule)
-		die(_("use at most one of --auto and --schedule=<frequency>"));
+	die_for_incompatible_opt2(opts.auto_flag, "--auto",
+				  opts.schedule, "--schedule=");
+	die_for_incompatible_opt2(selected_tasks.nr, "--task=",
+				  opts.schedule, "--schedule=");
 
 	gc_config(&cfg);
 	initialize_task_config(&selected_tasks, opts.schedule);
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8cf89e285f4..1ada5246606 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -610,7 +610,12 @@ test_expect_success 'rerere-gc task with --auto honors maintenance.rerere-gc.aut
 
 test_expect_success '--auto and --schedule incompatible' '
 	test_must_fail git maintenance run --auto --schedule=daily 2>err &&
-	test_grep "at most one" err
+	test_grep "cannot be used together" err
+'
+
+test_expect_success '--task and --schedule incompatible' '
+	test_must_fail git maintenance run --task=pack-refs --schedule=daily 2>err &&
+	test_grep "cannot be used together" err
 '
 
 test_expect_success 'invalid --schedule value' '

-- 
2.49.0.1266.g31b7d2e469.dirty

