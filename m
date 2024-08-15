Received: from fhigh4-smtp.messagingengine.com (fhigh4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 796491714CF
	for <git@vger.kernel.org>; Thu, 15 Aug 2024 11:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723720927; cv=none; b=OTR8gBX1rSAUfvJ1BV1ovJZquFy56HEIyc2aMFxHFEz8I1fJOWk+lrtFnwFGfgy+LMWe6C3dxzzaWqdCHE2NYEyk9sRUF+19a4sLEPL/DwQgLTt5pAdzyXyo7yK9JZhSs5u1cA7PgZKozVj3xdhBjA323Y8rJeTnqFqa+3GA0GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723720927; c=relaxed/simple;
	bh=KSWsfajIcUFRTvw5OXCvMJXWv8lmrp53J2EwVytGMyI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nfm+XJhjI7XRlGzbEraHPhou6QqtnFllRjRd4xIJRmYDwaNZXrz+ca9N4xytfZvXG+oY1gIHnDzByuPVf3W/P5geTUxnOea19NPehJ+mGNo5sI/KhEUgBe3PkW8JrfkAafE/ZPL8i55ubN8NBN2+eqRROkhiz3PG4xvOoBG92RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=R7l0uC59; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=beFYQBtE; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="R7l0uC59";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="beFYQBtE"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 5CE3E114EAB6;
	Thu, 15 Aug 2024 05:12:49 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 15 Aug 2024 05:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1723713169; x=1723799569; bh=KgsNH8wJ5B
	XMfgoqLPY8FcTf3d+ImoI1XBkyOliaKJQ=; b=R7l0uC59lnbYvYpMTLnufYMaRi
	VOjEV7XeQcMwASJMSTa2gmxTke6XxIGwhlL4dPZ59c33rHdJslXEe2IH2IjuJstj
	rQzX3fV9i6YR4AMEbu4mHzZSlQj/LbwJ0UaEJQ9hogWfHqmRRcsOHtesodNtpsye
	P+AMULL9Dt/FBoVbkeiiCRGgAMhex1k7U/2UhNdyjOqCWOQtr30FhCKONXSG8Qdd
	rOv34u+Ms7Z1mkPqeYUeutUqNCTA2Awv/HNmcrriCHOi8oZZrGJdTlHZ6JhgSmvp
	3LdBkgL11v0AKKWxXbbONsLJQzKOaF8m2he00x5LD33YGmlx8PY9uvBelfRQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1723713169; x=1723799569; bh=KgsNH8wJ5BXMfgoqLPY8FcTf3d+I
	moI1XBkyOliaKJQ=; b=beFYQBtERuU9eRGn/GxDPXBrFK2MuTKcfIaf4CthjXY3
	YYibG2UzkSuqBRlb6UcEkf/MmKEGp3peAMIoORIAi4rACRiew+sDbRk+kGD5r64I
	jj/W3QHjQLgFfRa9cVZNYR7kQG2yzGD4W+QeKyajKt53J4mZnmJR5lwldDdUnVms
	9RUSl6zsIi/C804g7n2WFe2tuWh9ADeEokuejry41f6ed8L+B0yqaAhfBs/3bu57
	8gTeeNyvlICR9nSLsgeUi30FuNvgSAuY69gB1EsSKvTZBdPtRfSWfd3XO2fZiEOi
	k1F+q0l/pdDCbpwyNJIsqgr6Ui2LhPCiWTuTbrwtfA==
X-ME-Sender: <xms:kca9ZlRz5PDwLCZhrTYB1U-iUGW8oXLBtDob3E-3vOX7GkJ3BUWXGA>
    <xme:kca9ZuyuSELo_BGUmOYveKFgvW-1glf3Sh4vCw3_HuQ4jlmDGZFFbUOsBomdxoG_f
    HS89g8Wvmcvv_PJ8A>
X-ME-Received: <xmr:kca9Zq3aCmcMBKiB4xtHNDl_7nQ8APmaILefsSpH1byUDXYAPaFR64Ya_-W8wXv0iB4CHeZX07E-GvDtkiPT3Qj7HC8kgeCuxohlz3LhkHZk8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddruddtiedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepleeuffeggeehvedtteekiefftddtheetkeeutdekgeei
    tddvhfeuveduleekgefhnecuffhomhgrihhnpehlohhoshgvqdhosghjvggtthhsrdgruh
    htohenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehp
    shesphhkshdrihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhh
    ihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilh
    hlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehjrghmvghs
    sehjrghmvghslhhiuhdrihho
X-ME-Proxy: <xmx:kca9ZtD1dYL3UDDZo0Gv-ZeThlSwKLGa0vH1nhJnHOXHD1Z2zx6FWQ>
    <xmx:kca9ZuhNFr9faHhCYRSQ0Ki3OLefcYRKhRKd66VphjugQw74Mrry6g>
    <xmx:kca9Zho4ROlFoYq_GzrpTou4i3NNT1YgN6n5nQRBWjfcPeuv90np5Q>
    <xmx:kca9ZpjQCFPytbYABsl2chBJapsUqHk3yVnyQxOUVCm06-mBPWBYZQ>
    <xmx:kca9ZmfamhDxws0WUD9b-E5a4gUUGzlo3k0bFOvQJg4ZOb0e8cTi2xFv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Aug 2024 05:12:48 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 4972c5ff (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 15 Aug 2024 09:12:27 +0000 (UTC)
Date: Thu, 15 Aug 2024 11:12:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>, phillip.wood@dunelm.org.uk,
	James Liu <james@jamesliu.io>
Subject: [PATCH v2 6/7] builtin/maintenance: add a `--detach` flag
Message-ID: <06dbb73425f7df038dfdd9bc0d2b9a49edfe064e.1723712608.git.ps@pks.im>
References: <cover.1723533091.git.ps@pks.im>
 <cover.1723712608.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1723712608.git.ps@pks.im>

Same as the preceding commit, add a `--[no-]detach` flag to the
git-maintenance(1) command. This will be used in a subsequent commit to
fix backgrounding of that command when configured with a non-standard
set of tasks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c           |  6 ++++++
 t/t7900-maintenance.sh | 39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 269a77960f..63106e2028 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1426,6 +1426,10 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 	}
 	free(lock_path);
 
+	/* Failure to daemonize is ok, we'll continue in foreground. */
+	if (opts->detach > 0)
+		daemonize();
+
 	for (i = 0; !found_selected && i < TASK__COUNT; i++)
 		found_selected = tasks[i].selected_order >= 0;
 
@@ -1552,6 +1556,8 @@ static int maintenance_run(int argc, const char **argv, const char *prefix)
 	struct option builtin_maintenance_run_options[] = {
 		OPT_BOOL(0, "auto", &opts.auto_flag,
 			 N_("run tasks based on the state of the repository")),
+		OPT_BOOL(0, "detach", &opts.detach,
+			 N_("perform maintenance in the background")),
 		OPT_CALLBACK(0, "schedule", &opts.schedule, N_("frequency"),
 			     N_("run tasks based on frequency"),
 			     maintenance_opt_schedule),
diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
index 8595489ceb..771525aa4b 100755
--- a/t/t7900-maintenance.sh
+++ b/t/t7900-maintenance.sh
@@ -908,4 +908,43 @@ test_expect_success 'failed schedule prevents config change' '
 	done
 '
 
+test_expect_success '--no-detach causes maintenance to not run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		# Prepare the repository such that git-maintenance(1) ends up
+		# outputting something.
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		# We have no better way to check whether or not the task ran in
+		# the background than to verify whether it output anything. The
+		# next testcase checks the reverse, making this somewhat safer.
+		git maintenance run --no-detach >out 2>&1 &&
+		test_line_count = 1 out
+	)
+'
+
+test_expect_success '--detach causes maintenance to run in background' '
+	test_when_finished "rm -rf repo" &&
+	git init repo &&
+	(
+		cd repo &&
+
+		test_commit something &&
+		git config set maintenance.gc.enabled false &&
+		git config set maintenance.loose-objects.enabled true &&
+		git config set maintenance.loose-objects.auto 1 &&
+		git config set maintenance.incremental-repack.enabled true &&
+
+		git maintenance run --detach >out 2>&1 &&
+		test_must_be_empty out
+	)
+'
+
 test_done
-- 
2.46.0.46.g406f326d27.dirty

