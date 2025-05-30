Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438FD2367AB
	for <git@vger.kernel.org>; Fri, 30 May 2025 15:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748617732; cv=none; b=O7YeIaAF6C1XYGu+l7Xf+KFOVr3gxfJaTJCqC/InXjKQJ7Qyd9tSdEuJWZiS28Wd2PuVl9rfrxwY2uthe4Db3cyGpq94TUgfkhwa6ehUwX9KzLFzEaBsywGS9qa/dmlvTzOg1VPTQRCgAPisMMBFymuBTDme9Z2A9PqIcQ5ozew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748617732; c=relaxed/simple;
	bh=8zzBqnDAF18bFsqk9Ldp7FcXTkZoC1fdL+TssjmRkQo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U5xkROfnTV/UgnK91H0wPJIsQly9SiLdO9MEEqmSGkGeD3grgx3vckds4jgjq7UnPDUvryWjBWXdpVnsYq5fP2Ogy6bFK5aHP/kLKAQwfTPy4L0rdB1e99mjUS5uAxYtGPYDitThLUKdlqIENLGkCVcsXUeLvq5jT14aFxNVE/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fj72AfwZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J5WGumgU; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fj72AfwZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J5WGumgU"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 50F4A1380321;
	Fri, 30 May 2025 11:08:50 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Fri, 30 May 2025 11:08:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748617730;
	 x=1748704130; bh=6oge/U/aglP31+wSztce+CpNg0ULJg/INTFXEme3qdY=; b=
	fj72AfwZzDmTNsiMBsXJhv94Hbxlwni0ZI42dcdCVdqqMa3zyeTpgA8wXC0iMmg8
	2ZZr61rS1XDj376lvGudY+4qBAQcY2kyxyHfGpLv7D2LpIfmLX457OOxTXSe1xoV
	8Wh63rTsjR0dm9lvJ5E+sCvMMdcON5gPN8QCe7gIQvSOdmV9r7U5iCUiOtI7qwZY
	HiBtmDyv0F9aV/+5+t51VjeOVWTgLJbl+zYaYGNmZPrtDoG0GRTOLP42aME6rlnq
	jrK3EMmE6wocPM087bSnqDD+h70kKiI92aEBlst6ECtqlwuVL7ptk4bEOYvCdqVq
	T5wLIZvLgG8VZUtpskdbew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748617730; x=
	1748704130; bh=6oge/U/aglP31+wSztce+CpNg0ULJg/INTFXEme3qdY=; b=J
	5WGumgUajttQN2pMHYu+MQh4oJqFdLU95qtuqxQnaOrEQ4eCqx4CxhVG/oF1p2bC
	mzoX3TYxlxuZg8pDSWCWq7XS3CyqTZfsMOp9I+DZqewFYp3lC5l/Z/gUarrXFQ12
	76ocVAjdQOSARGkclxEbCUnkCU39muebMJNvdLAuTlO7df3nA+p5qdQZWyO8UO4P
	DYDY/0Tnc/T5RHsnt1rEBAnM0O+siV43ynanYWr2TyDqIS5gSqQugTa8p5usvF+3
	6dQbYfM3KUCMQuK2TgOvIDEpMvrG3zEUi/O5VLmKpc6VVYs+NtT1pIytwpzbSMhs
	PEfzhsGvOv1fk65PbgRAw==
X-ME-Sender: <xms:Aso5aCiFmqqiwVQhd28jUNWdWb7xfgw19-lY1-feikofAiZRJDvrXg>
    <xme:Aso5aDC-QjDI73nMxLgZ8xxPwyIMtOD_s6xlp4M_wZwosmbsN1yH2rdg02JHRfJoY
    O_Q3Ag-pMFwXia3Nw>
X-ME-Received: <xmr:Aso5aKFy6m7Z2Z1zCPIpRjfxyZDjARHi-JSin5SipRWcVX-cV0IMyIvDFgHWlPhvlSiHB4HRuZzGAQnanJGxET8caGGkYP2djV4-blcfTA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgddvleeffeculddtuddrgeefvddrtd
    dtmdcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggft
    fghnshhusghstghrihgsvgdpuffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftd
    dtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhfffugggtgffk
    fhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrg
    hrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuiedujedvkeeh
    uedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgvrhfuih
    iivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnoh
    gslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluh
    hsrdgtohhmpdhrtghpthhtohepnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdp
    rhgtphhtthhopegurghsrhgrfhelsehgmhgrihhlrdgtohhmpdhrtghpthhtohephihroh
    hthhesphgrlhhorghlthhonhgvthifohhrkhhsrdgtohhm
X-ME-Proxy: <xmx:Aso5aLTgHmxxWQh9zzLhpgFFexSZQJi9ToP4wMXJiCxzBeAY3sMx2g>
    <xmx:Aso5aPwoO0EUOOm3HndNIlwebl0O_7UeRh888VcbUB3H5v7nlTsYVg>
    <xmx:Aso5aJ53Ob6Q7b-EuXgMqa5n7PKcAwQqE9_GhEI2YI5tydimKqleew>
    <xmx:Aso5aMxzNVxGyLOjFtS7S-7zRRI3rUK0_42MNEoSyjl6E_SZTagRuw>
    <xmx:Aso5aEnZ1b5vB8aSWksokEDvfcOaRhWHKxYb3dvhxnY_DxCkL6kjSpWg>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 May 2025 11:08:49 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id aeb53118 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Fri, 30 May 2025 15:08:47 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Fri, 30 May 2025 17:08:37 +0200
Subject: [PATCH v2 11/12] builtin/gc: avoid global state in
 `gc_before_repack()`
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250530-b4-pks-maintenance-ref-lock-race-v2-11-d04e2f93e51f@pks.im>
References: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
In-Reply-To: <20250530-b4-pks-maintenance-ref-lock-race-v2-0-d04e2f93e51f@pks.im>
To: git@vger.kernel.org
Cc: Yonatan Roth <yroth@paloaltonetworks.com>, 
 david asraf <dasraf9@gmail.com>, Emily Shaffer <nasamuffin@google.com>, 
 Ramsay Jones <ramsay@ramsayjones.plus.com>, 
 Ben Knoble <ben.knoble@gmail.com>
X-Mailer: b4 0.14.2

The `gc_before_repack()` should only ever run once in git-gc(1), but we
may end up calling it twice when the "--detach" flag is passed. The
duplicated call is avoided though via a static flag in this function.

This pattern is somewhat unintuitive though. Refactor it to drop the
static flag and instead guard the second call of `gc_before_repack()`
via `opts.detach`.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 24 +++++++++---------------
 1 file changed, 9 insertions(+), 15 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index e92015887a7..e910a99e033 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -816,22 +816,14 @@ static int report_last_gc_error(void)
 	return ret;
 }
 
-static void gc_before_repack(struct maintenance_run_opts *opts,
-			     struct gc_config *cfg)
+static int gc_before_repack(struct maintenance_run_opts *opts,
+			    struct gc_config *cfg)
 {
-	/*
-	 * We may be called twice, as both the pre- and
-	 * post-daemonized phases will call us, but running these
-	 * commands more than once is pointless and wasteful.
-	 */
-	static int done = 0;
-	if (done++)
-		return;
-
 	if (cfg->pack_refs && maintenance_task_pack_refs(opts, cfg))
-		die(FAILED_RUN, "pack-refs");
+		return error(FAILED_RUN, "pack-refs");
 	if (cfg->prune_reflogs && maintenance_task_reflog_expire(opts, cfg))
-		die(FAILED_RUN, "reflog");
+		return error(FAILED_RUN, "reflog");
+	return 0;
 }
 
 int cmd_gc(int argc,
@@ -965,7 +957,8 @@ int cmd_gc(int argc,
 			goto out;
 		}
 
-		gc_before_repack(&opts, &cfg); /* dies on failure */
+		if (gc_before_repack(&opts, &cfg) < 0)
+			die(NULL);
 		delete_tempfile(&pidfile);
 
 		/*
@@ -995,7 +988,8 @@ int cmd_gc(int argc,
 		free(path);
 	}
 
-	gc_before_repack(&opts, &cfg);
+	if (opts.detach <= 0)
+		gc_before_repack(&opts, &cfg);
 
 	if (!repository_format_precious_objects) {
 		struct child_process repack_cmd = CHILD_PROCESS_INIT;

-- 
2.50.0.rc0.604.gd4ff7b7c86.dirty

