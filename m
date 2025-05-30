Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23782235067
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617726; cv=none; b=OPchs4gVYvCtd74dSvxHT1dpeAKtNpaxgm44WHv/lCYpB6nxfO35QxkEaLQt8gAcwDuJeTB+YNa7te7LT7KT8J1ygeRqoNwbxJcK/RI19WGKpgR5mZpuxgud9kap3TbsOaeKUjvhZBXHbH7AULFMGK4d6IfnWKfZhUl9C4E8tEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617726; c=relaxed/simple;
	bh=XZEno5JfWuIsAeNXyJ5ZNuJzpnEKZYj6D+/J9EUGZCw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gHYufXt50OI49plrPLNXnTTjNl/+ibtQ2ClyJju8aZOm6Kg6p+yjN2VMcwUW92SbNQ9sucj5gDP53Z03k07MMWvkrTVqUt4DMetDlptGC/YsWyP2BiFH43jRZxm79Pcv+nNmqr17PdQ8rhmfCYWBaVRSN20ntD4/QtTdFBuIcZY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=TDyhEO/l; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=S+5YwVAZ; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="TDyhEO/l";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="S+5YwVAZ"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 435521140178;
	Fri, 30 May 2025 11:08:44 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 11:08:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617724;
	 x=1748704124; bh=mi6FSO7keyKDMM7wFN9HocCCB8X2TzamPploDqvVwIo=; b=
	TDyhEO/l8iEEg5k04viSoGhxSHxVlWRyroHlwuWokun0p+EJ3rS3LXwimnHj+mY3
	trTlmDLnHW78aEiNjY8NolLeuQxbXUzZk8ZmLmig7oMasIu3jThJkL5q1T2zIPzL
	3GsfQcyT/yU29mcRA/And2KpNkm1uSKIpc0ERGaAphIa6SUZuyB28ghXdRIbdlaz
	AofO+ctgohJ/QWqhoo8d66+HP4+8pUJCY67nmVdJzyfg+qIEPE9DqzLiXefNAr9m
	F9Sh/kGVIgx2zwVcBSZzeNWIgvo4bReKPBQZ+0HulhKN14fmDYZkMCsGAbzImH/G
	QYxqEekrq0Zg9kWfy347yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617724; x=
	1748704124; bh=mi6FSO7keyKDMM7wFN9HocCCB8X2TzamPploDqvVwIo=; b=S
	+5YwVAZ3GTdpQe+9AIyQPjgGxVg1OPddZyRVtJ8drg0n72LXtAnGGgS81sVEj1pt
	PIxnW8aUtazq2O3bkciB/aSomfuX/Stq1id/35lHSyQQ6C/bSINpviuvpWDLi3Z/
	wAtql1XXhiFY3CM+y6X/i6p+J35saVZa70sMoqI/b4UUE3oskreJwvbhM0D3GFbw
	DEyyxd33l2BxPSgg5scjKmVIIeyrPI/yD705iLMhWd1bNiSUXjCHsor8QrnP3ZtM
	NGOw3p3hvmIhosH/8LXb2UdVyxPW+bV0Rk9TUBKhDB9VFZzHDNIJJFrA5g5k8fad
	BipKaFfsA9BIa+5NRjeJA==
X-ME-Sender: <xms:-8k5aH2YLNb9r0okIc8p0fRZU2C5puzc27KQiYVefmo7jyojjDLfKA>
    <xme:-8k5aGFXL4Ph_fjRWm2gZjX9Q6gyBkZ_mGHr9uz-4Lwvx5ACUgyBJEJ10cY_o8YPY
    ZCCYe5x4_DB6p4w0A>
X-ME-Received: <xmr:-8k5aH6ydQYb0OuTySOkL9krTzztjnrjKmg3ckHTj2WlOb8gaWCX1ewqUn8cTKfBZPYgbkY0WugrUYOlQHCWXoHQWCy-IXXfsnEqM8neRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihj
    ohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhooh
    hglhgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihroh
    hthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:_Mk5aM2fhZN-mbWeRmuZREt6VKmiyD4utSvMrpRONnRRNaVxmGClGg>
    <xmx:_Mk5aKH8tjDZeOTTvioBkErfYMaDgmwR4z8NL1-PrOymw_gcbqNS0g>
    <xmx:_Mk5aN_SNCjblTsvzE3xbtIjCs5sbGYP9sl4Ue7Yfrs6hL3Irxy9iw>
    <xmx:_Mk5aHm0I84Uxkd8kxCe5quL3dvreGY8chiKswW6WU3Cm7Aos05r0Q>
    <xmx:_Mk5aHZpZnsP8MmKSnmk3aF6U2hVx9wUda5XourjuTIzotP1OW9Vggm0>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:42 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id eff42278 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:41 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:30 +0200
Subject: [PATCH v2 04/12] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-4-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The "--task=" option explicitly allows the user to say which maintenance
tasks should be run, whereas "--schedule=" only respects the maintenance
strategy configured for a specific repository. As such, it is not
sensible to accept both options at the same time.

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
2.50.0.rc0.604.gd4ff7b7c86.dirty

