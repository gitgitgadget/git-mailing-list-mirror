Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4191A9B32
	for <git@vger.kernel.org>; Mon,  2 Jun 2025 07:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748848659; cv=none; b=FdBKNhigskhGOn2mn7fkMgg3Dz6ywjkbrhAaORvEkVxeeJMtvquj7peBLiTgLHXS2OjDjeyGJu+FjU3d66MkVZtFR+1xlfMNe/trLW4aLadBthSVtdBnHA5WCtD93SSgguVyUC3DNaWppeyM3FVdato56qyTbAOLImBmzQG5V0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748848659; c=relaxed/simple;
	bh=GFWsG1UUCUuoy84O8y7Rl2h3eHbD9mDWtcmoCpPrmsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WZpWGaSKwp1xtHx+XZUwGTfOQZmu7m+ww8sdUIhpFum5NQ7T/NE+9qw2xxQ1SweCZGbQaInwinP58MlD7P1rPPOffDrGX98fxLituG7rq50KhmaWQGXWC01prz3kC1+1AumVXhfns2Fc/0/uVYyIBKOfvsfo7ln/om6MCtESBEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=YA59N9Rp; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ov1kLwKA; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="YA59N9Rp";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ov1kLwKA"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 79F04114010B;
	Mon,  2 Jun 2025 03:17:36 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Mon, 02 Jun 2025 03:17:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748848656;
	 x=1748935056; bh=Z5eGkM+6OjG6MdQohVAxETNiHWJ2jjvee26DiptQIkc=; b=
	YA59N9RpGi73NG5nNDozSuPiUswKXrwknfD5NHMHNWqDMsbsvDfVjfsC1qs2uilu
	va4G2TasuaXrTWbVhQewmm10sO5NeU/Z6FgLVCcggybyggNOifEuq29OfAVOOTr/
	A2CsqF9/OTg7ezHzudjL0p+LakWs60ZlCv7snMzxtVhh6aaMxp0U+suVNhaju0LY
	BJIVhlm6yAXetuC6iVQ++SsOMg1U11uFuIllK6e6MYpdRZ5MltklrVK+OAq/c20U
	otUFAwIailny87mgdC5apphHmNZYtX/3SsxPzUhLrhCj37tLbljzQYOFhQkXcdd+
	GSLjCy0Rkd9L41Q63roT4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748848656; x=
	1748935056; bh=Z5eGkM+6OjG6MdQohVAxETNiHWJ2jjvee26DiptQIkc=; b=o
	v1kLwKAnkCYWnIz7sZFAxH10QoU962y1x3wUfEXI8p37I4PXQWEb5PiCiz/oTiBz
	IO/+LpDAXm6JLG0w+5oTeogxAjgpuNAG04qOsHl/YvMJFdUq6d5lJgXqDsgPsA+O
	RRhvyeDNQClSAjfcm0o+cXRRcq0xArM6E9r/n+JPOL1jwjHwen9nXaCHGHEep1ta
	9mhyVwAg/cG4gK0tXtL9aakOI6uno7nhNvSL9OV32SzfxJO20/FIlQUGkAsZajWL
	u2a2mrU+OcXONwEDE/RAvINrXpZOpisDaY5onAPX7tckkW5acWULuzco4mbnxYW1
	7ObLYNDR6gzfvtfI1ILjA==
X-ME-Sender: <xms:EFA9aCpbgvA_dNT-7whcj6QJ91EJkxLaHVU6R0GO6J830bA6Sdhqvg>
    <xme:EFA9aAqpFkSQdbg-AYHahRhNmAYPZmrnlBHqGslJg_NPOC0d0YEwuBaXjGj1dwYi7
    hUOEKlrUAu1hTxs1g>
X-ME-Received: <xmr:EFA9aHNNHdKXF7PnOOypyqAzqfMnYYeUrgpMr2yFkiaH-GkSsJCFvO267Cm2J8O-PHC7DMBDVvVqX_UmORkBk8AYhNjAISiVSGX_3k5ZGDoGuw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefjedtgeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihse
    hrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgv
    rhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepuggrshhrrghfleesghhmrghilhdrtg
    homhdprhgtphhtthhopehnrghsrghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghp
    thhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihroh
    hthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:EFA9aB649i6q7YEzDJwpYiyTHilkeVCUcoiZoR2vf2VsLpjAiumZug>
    <xmx:EFA9aB4dY6QWFBgvIkH2jC0OcHFS_g1iXOqRHnLXfgz0XHj6_QTTow>
    <xmx:EFA9aBj26mZ125IZpvzFwOYrdUijfTG13YnzGzKhMQfZDupa7PjemQ>
    <xmx:EFA9aL7p4QuHzPCFxtTSaws3JCdIAskASNMaVj3OM8kslIygDknifg>
    <xmx:EFA9aDtyw5ET8NEhhVSPVhj0cURRvw7khxsl9OOkTGwPtKe53L3_1gEg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Jun 2025 03:17:34 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 7116bb86 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Mon, 2 Jun 2025 07:17:32 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Mon, 02 Jun 2025 09:17:30 +0200
Subject: [PATCH v3 04/12] builtin/maintenance: mark "--task=" and
 "--schedule=" as incompatible
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250602-b4-pks-maintenance-ref-lock-race-v3-4-587d44252dcb@pks.im>
References: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
In-Reply-To: <20250602-b4-pks-maintenance-ref-lock-race-v3-0-587d44252dcb@pks.im>
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
2.50.0.rc0.629.g846fc57c9e.dirty

