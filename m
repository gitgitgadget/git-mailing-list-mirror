Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D50238D32
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 14:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748959289; cv=none; b=WXmF25QwbaGbNSjuD4BntyCWtqEESTDT4P+jvmSUx5lfe4wblTSB+jpc9PKXbOOFMu1UrHomFDx+kZTFY4bI20VtMU0whCYSgszyvkMNRX5KyFoIL2IAEnCrd3g9G9cPL+mU1D13kEgmR8cMfxuJAWsgttGlC7GUfSNvRMOIHaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748959289; c=relaxed/simple;
	bh=WOlUFlEY5UxreIDxSL/97GNYpWyx8mITNHz223DfQsY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=PyH1XbbV0+m/9Xh0trVq2US+6jvNwiUd6IzN8rBJyEXPAMv10bv0wgvjR0i1ZrmV+76HIpmMFLPZPwR0iNIpWo7bX4DswtR71m2fem+lchE4HMS7TgerlgxQAUgp96ezlSQDlWesytP/3ZNyHHjIkOEsBou44F0yM6PEcSGWoPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=bsPeuqxY; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PASNCfj4; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="bsPeuqxY";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PASNCfj4"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E71E32540080;
	Tue,  3 Jun 2025 10:01:26 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 03 Jun 2025 10:01:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1748959286;
	 x=1749045686; bh=7Ha1FlH6QjZqe4c56hFunHnAz0DdpwiqBRT+P4Cotqo=; b=
	bsPeuqxYdgoD/uJrKpsXbl6sEwuRWeXFAVnVspB1JRtSgjm7rX2oWXy1T0c9fF4Y
	nFSOSz8hDw4E2wv5hJTbMuIMJRpgQWiSTxJwN9EwOg2G43QR4Td+XyFxZihTZhcf
	v3zRKcIJrcvEU+iuldzLZ2jnMRtcjbriTpEge2TJYzKJINJpjvLLKxfsvJKNBTU9
	narrMxKG5awHDM8b+nqZlzq0jUUZ0vRw13NPwWgJKOypWxifS50PGgTP3EV1WoCe
	cUFxoowhLAJfIh8msRUCBb1YqKg5Atf3pzAYpp/K7qdqsMwSsTeNExLXef+o9qJ2
	J/5ZP6t5/FHRmP8TRoNVLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748959286; x=
	1749045686; bh=7Ha1FlH6QjZqe4c56hFunHnAz0DdpwiqBRT+P4Cotqo=; b=P
	ASNCfj4cxcifzlUdqwKueUcfGW9aGjoKutUXFsH2Q7i/rLCzroPhStFxwo9tYAzQ
	9BUgF9V5X1SkI/2Gp0NkXcULb1iSpKbMIZySyNk7K/oMDGnzYpzGdyKTpUR0fmzh
	a7on6+L12mfytBAW/x+6GspkuLzfmjy3/AitgHD6AfZbsMEeiu+wepmu2hcoqXAe
	s1Zq01waW1XCoMcbst8+SD/yz3Hd+YGlFw0O8ou8rq+fTCFXNYTNJaLVSUmKDBG/
	FLe7jyF+1yUYzict5Zc3SNtMuPrJFIOCjbEGAaYeeqff9DUlESIFHOJOvWA9xgiU
	cg1NVWH+F+GX++0D38NLA==
X-ME-Sender: <xms:NgA_aMA0o8k-P6PJtsS6RAZ66NLed4ZN3fOyTTFJqSlFGt6bXKaz8w>
    <xme:NgA_aOgR2OQurS8aV6z8PkpPzgHL4IPLwdnod-D2gf9aBQeFFlEBF_GL-2IPVO_Tg
    rC35jbCGk4M4PxpMA>
X-ME-Received: <xmr:NgA_aPlnVjlGHTfT8wZItdVuygtEhOVUFT3NsPIa1apcnMe0RXMQR7GUAMIkMTE9Z5thwipFha0szda5oXCddblh3uoTGUcsdmymHQmrzw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdegvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhfffugggtgffkfhgjvfevofesthejredtredtjeen
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepffeuiedujedvkeehuedvkeefffeivdeuleetkeduheej
    teekgedvudfgtdfgieelnecuvehluhhsthgvrhfuihiivgepudenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihjohhnvghsrdhplh
    hushdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdp
    rhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehkrhhishhtohhf
    fhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopeihrh
    hothhhsehprghlohgrlhhtohhnvghtfihorhhkshdrtghomhdprhgtphhtthhopehnrghs
    rghmuhhffhhinhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepuggrshhrrghfleesgh
    hmrghilhdrtghomh
X-ME-Proxy: <xmx:NgA_aCxnoxfRcjFeQBNZVHZ9mxLpXCxP69ZdKohe133JGjm35Y9O2w>
    <xmx:NgA_aBQ6GGCJtXI-wH3TwQTc1eMtJFvU_7JTsg_E2L-5QaCsuhUSwA>
    <xmx:NgA_aNZO1RGzNzAm76BehhMqwoCQPUWOuZTJafZlDWIeAysguZ7r2A>
    <xmx:NgA_aKRmjPCWQcNomMYTa4u-NtWD5SweMHYvprDEVLnYgTj1ZuR_LA>
    <xmx:NgA_aITnMaVkFMccIb98UsFDH5ELaqzdCJQPhwR7WV6f4-gjCElDuayn>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 10:01:25 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8284c30d (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 3 Jun 2025 14:01:23 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Tue, 03 Jun 2025 16:01:15 +0200
Subject: [PATCH v4 07/12] builtin/maintenance: fix typedef for function
 pointers
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250603-b4-pks-maintenance-ref-lock-race-v4-7-52f5cf7b7e99@pks.im>
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

The typedefs for `maintenance_task_fn` and `maintenance_auto_fn` are
somewhat confusingly not true function pointers. As such, any user of
those typedefs needs to manually add the pointer to make use of them.

Fix this by making these true function pointers.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index cfbf9d8a2b9..447e5800846 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1533,20 +1533,20 @@ static int maintenance_task_incremental_repack(struct maintenance_run_opts *opts
 	return 0;
 }
 
-typedef int maintenance_task_fn(struct maintenance_run_opts *opts,
-				struct gc_config *cfg);
+typedef int (*maintenance_task_fn)(struct maintenance_run_opts *opts,
+				   struct gc_config *cfg);
 
 /*
  * An auto condition function returns 1 if the task should run
  * and 0 if the task should NOT run. See needs_to_gc() for an
  * example.
  */
-typedef int maintenance_auto_fn(struct gc_config *cfg);
+typedef int (*maintenance_auto_fn)(struct gc_config *cfg);
 
 struct maintenance_task {
 	const char *name;
-	maintenance_task_fn *fn;
-	maintenance_auto_fn *auto_condition;
+	maintenance_task_fn fn;
+	maintenance_auto_fn auto_condition;
 };
 
 static const struct maintenance_task tasks[] = {

-- 
2.50.0.rc0.629.g846fc57c9e.dirty

