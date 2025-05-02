Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7989F22D791
	for <git@vger.kernel.org>; Fri,  2 May 2025 08:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746175460; cv=none; b=qKiPFYQpoejmxczmU2yDsaiPoXRNKOqQvDVaKE83asckWWUhw/Bda3GOzd2denYLX6jwHajylKA1X75dNUGldiO/ZamspV7Bw3g3tzNui4ulaMUUQ3FptuPcfG2p2KCqhVdMEJ9ZU61dVTDo7lt3A6xcNvMQAfYNQ3GhI5HUdyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746175460; c=relaxed/simple;
	bh=ZCE37KZIKfwqDy1+ewJJRE0wpy0DfGKIVSBYRyZoQuc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=C2RY2GsxRIYCcxEFcS20w/cnbdE6kFkaGu0TUQXmOm/+wWR2ZPncx2ZfshKeMVRRLHh0LGgtBH3xzKq5FahCi6lFvUB3iZ9ycwTozwxuyHjUdo0Dus6On+GFOjLRZTe8ipCdKlZViEvuU2g4RkFVbHt1aibPIOopQiySc619HHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=L9iPCYYo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rQGRkQ+Y; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="L9iPCYYo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rQGRkQ+Y"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 9B3A211401CA;
	Fri,  2 May 2025 04:44:17 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Fri, 02 May 2025 04:44:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1746175457;
	 x=1746261857; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=
	L9iPCYYorv41YZdJc3SI5tGW7mfRfKiM0CdXeqFA1mAeUW3cgQezd0jCzEQnHcCB
	mHxygKf+vINWexro8CGYUYwv7li5ZypCWrEnkWfM7l7zLJKWCtU2KQT7tiTvVw9p
	+zwridk6j8hCQEITaZmDk9h1PMhoOQ4DEaf/2BHS+vAx2n3wdT2doNinhtqAg15b
	lLk8+zjpDL52vYnLOW/WZfGP84Gz4Cd9YclwtANmqAc6u1vjHrQsuFjNeie73yNt
	eBVWE5x4i25fl/jioyj87c/HV/TyYm1B6UaqptBU3SvzYZVzg9Wcj2NeAYyCHDzd
	KuDyJ/zGA8vr5GkVUa4UVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746175457; x=
	1746261857; bh=X8kv3tFVyHvQxEtGxGzjtiGoIk3mQdY5oT69IcWZPHc=; b=r
	QGRkQ+YHfQjevvD9j5NrvoXYOgHMF+Jm191GhKWDVwM/pat/gFDl8hANxkWSnlOj
	S7hCn0lat/lqOS2Nq3Q/2Gkl/7odhlET/x62nFVwg+yydZd4ruqQAIBeD7DK2AUk
	7hFyfaHS4/6D20Sav1x3axo9FeDsmSt2bPcQdwAe93A//P15tQf7k8htceUwExXH
	NRyW0QDIAJPIII4WTMk3MCSi5jhJET01Ew22v9nWb6UzYiWiPocQrhvFTFXbmc2r
	sqoFfpWz7ddGdFgNFz9N5BJZTFmK4e4ipZVckZm+QO488fCBsSg8w0KDQJNT197+
	3qhsNPxYX5fQZwRAtT7dA==
X-ME-Sender: <xms:4YUUaGk4BgYEuNU2KwQUan6ptwQJix-CdUwlWmpMFHb6CfmiLfwKwg>
    <xme:4YUUaN12Fn6tIW2jlKXhGGP6-Ujlk3CMQ1TMB-05iUjUGy-H4DtOtkBdHQMuRuZ5-
    zkEeA89yeywV_8zpQ>
X-ME-Received: <xmr:4YUUaEqCdw-93_0xrM03CMqoeCYXioTaooA94eKOk066udbr4rTwOrRlZ9NRkD8zxAzQpPNEs1DYAB7U9JcFxBxei1NNeSpyA_l3eTwilCI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedvtddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertder
    tdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhksh
    drihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelteek
    udehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:4YUUaKlhDIKdEHi80Fn_Kdvz8SThs-M_5SmYbsZY6ZUdwKcZQgxhAA>
    <xmx:4YUUaE0vE1G7sCosWFFtqPCxD71v4h4HB525JaKv2uc2afM70IN4lw>
    <xmx:4YUUaBvujKMtoOCqXxu_cKrSMKDWwx72rM7YKzPqTn0Ce-IdJqiDNQ>
    <xmx:4YUUaAU1b55mdcyQZd9-QftU-NDBmX3I4dveykGTqzIwQjqWaqUCmQ>
    <xmx:4YUUaNg4C7GZ7vJYwrjLPNprLv1jCdrEfF8fHWRCfjDIzBmolbEtvzYv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 2 May 2025 04:44:16 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e420c0f7 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 2 May 2025 08:44:15 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 02 May 2025 10:44:03 +0200
Subject: [PATCH v3 6/7] builtin/gc: move rerere garbage collection into
 separate function
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250502-pks-maintenance-missing-tasks-v3-6-13e130d36640@pks.im>
References: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
In-Reply-To: <20250502-pks-maintenance-missing-tasks-v3-0-13e130d36640@pks.im>
To: git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>, Junio C Hamano <gitster@pobox.com>
X-Mailer: b4 0.14.2

Move garbage collection of cached rerere entries into a separate
function. This prepares us for a subsequent commit where we introduce a
new "rerere-gc" task for git-maintenance(1).

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 93a8c856dbc..3dd1d07cca4 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -386,6 +386,15 @@ static int worktree_prune_condition(struct gc_config *cfg)
 	return should_prune;
 }
 
+static int maintenance_task_rerere_gc(struct maintenance_run_opts *opts UNUSED,
+				      struct gc_config *cfg UNUSED)
+{
+	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
+	rerere_cmd.git_cmd = 1;
+	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
+	return run_command(&rerere_cmd);
+}
+
 static int too_many_loose_objects(struct gc_config *cfg)
 {
 	/*
@@ -782,7 +791,6 @@ int cmd_gc(int argc,
 	int daemonized = 0;
 	int keep_largest_pack = -1;
 	timestamp_t dummy;
-	struct child_process rerere_cmd = CHILD_PROCESS_INIT;
 	struct maintenance_run_opts opts = MAINTENANCE_RUN_OPTS_INIT;
 	struct gc_config cfg = GC_CONFIG_INIT;
 	const char *prune_expire_sentinel = "sentinel";
@@ -959,10 +967,8 @@ int cmd_gc(int argc,
 	    maintenance_task_worktree_prune(&opts, &cfg))
 		die(FAILED_RUN, "worktree");
 
-	rerere_cmd.git_cmd = 1;
-	strvec_pushl(&rerere_cmd.args, "rerere", "gc", NULL);
-	if (run_command(&rerere_cmd))
-		die(FAILED_RUN, rerere_cmd.args.v[0]);
+	if (maintenance_task_rerere_gc(&opts, &cfg))
+		die(FAILED_RUN, "rerere");
 
 	report_garbage = report_pack_garbage;
 	reprepare_packed_git(the_repository);

-- 
2.49.0.987.g0cc8ee98dc.dirty

