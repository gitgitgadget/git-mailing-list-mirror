Received: from fhigh8-smtp.messagingengine.com (fhigh8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD94191F93
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 14:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724162751; cv=none; b=GctIY9hrWecoaI2E42SNyQZRkpDd6tPAkdyISPVSiEyeVy3OP7gdIkdKepSsXehu7ihkbexiPOCCNTgyUytCcDVQLza2P7BVBA8vcfKdeK6nIfk6QwwCS9yWLhSWOYZMnP2NnjIRLxzo7bpEDZ7qoePEc7e8rDEME9duhYiWFG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724162751; c=relaxed/simple;
	bh=rYAzZils8BVEcOYEI0Ik86E9n8o0S6azlAkc8069t/A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PxMEvr8uWtHOgSBcpx1ahKDxz7oh/3rXP+7yRA4gf1RuM3H99nF78MeXNnkQ2OfeVre2PRsY7VQJG5Rsfo1O/itKOTHYfdpk7oiZRqA7ngU5otWbFRvfMyPiHMbgc0frhxsh7JNFEp0JGiKejU2TyEnvnLjox50WbB+xtB6FGL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lyamy9d4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PTbBZNkZ; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lyamy9d4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PTbBZNkZ"
Received: from phl-compute-03.internal (phl-compute-03.nyi.internal [10.202.2.43])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id A9BED11518E8
	for <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:48 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Tue, 20 Aug 2024 10:05:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724162748; x=1724249148; bh=o4P9rnbq2R
	/rUtNpkv2BX9WZhluxON/m5nDMV5n+KLY=; b=lyamy9d4GnFsJjBiYgiv6Qv4c3
	yt4kW2w6Ort/9Up2hMDhfAKTOLb+wUK3Gxe/JuFqP2JsSXb2eTSbJxK+ICis1X9j
	XuAc/Opt2rFcy2lv5gwPANG8XdpzVcOOfNgOyQ1fQ70nTFPVgdkJho2d/HV4ifI3
	1iJaut+jrO9L5ZEJidKOjHKs5DJ9r5ygjh4CS6It4G8+e0puWqSWI2e2FdBuoR/6
	IsM0FLENNYydPnjQT6cnJTa663Sq/4OGyqUEtzSaAxExyAoC+tVfYCsLRagT9Z32
	2GwRRLkhIlTMvUMKPZDyZlj+xoKyMxvgM8NsYhDY1XbSZWGMSa+bt4cmdVeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724162748; x=1724249148; bh=o4P9rnbq2R/rUtNpkv2BX9WZhlux
	ON/m5nDMV5n+KLY=; b=PTbBZNkZGkdYDyByd4V4md3SdiJUEGRj8vpLtXB/I24L
	fiVvtKRsyp+aHa3c84MmyyY72VcBT0zPn6/MTKeTLUB0HOkOJEFPZ/H26dT/qaOT
	p/qT1b/T4wBEr8hJtTTPdyg+vhlHn9YVyOdODJpEOwvSAWJH9u/644BoWlx/Nf4G
	ApYsmQUIdzbc1yMUqQgJYLI9RmmYEffaqAIdjKNzVYbnct/C04AhMCJMtuq16cFF
	xcmPWSIzUAo6xVlGjZAtUJjcswSKjlfk7daCoURnNX/FPFqBf+6bkmSYb+K8akp8
	wrcXqIBRonev9wuOkckMn4TPhrginUpBvE084T8/+w==
X-ME-Sender: <xms:vKLEZhthS5Ise8GqCg0tcKNPMw5F_apRrAq73cdlaa9X-fFQ1wWZBg>
    <xme:vKLEZqe2MDpIqqQqmG4eoKvaSDq4jnFKRJJexvtUaBZK3zcdGA0E5Cvtza7pBdf64
    TPoVyfkHZUdJfsh2w>
X-ME-Received: <xmr:vKLEZkwnLLYc6xMg4dzD2NZNSmi0OcO4OWUChdYwFPiCU_gSi2aFF-L0M4NsbFiTcz8Y7QsfevbVg8OXRrl-l9qk1b_2zLfImvD28HlrAvvEQdJE3w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudduiedgjedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepudenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:vKLEZoNvDqPPsR4YHdX534sX3wOL3CZQXMHonB_06-Jwp63zXsgQTg>
    <xmx:vKLEZh_xXAidC4-30GV4nWJH4YP1MOw8KhKQNtGLW2B3WkHnzjz8cw>
    <xmx:vKLEZoUgr7spz2U1QAwhxHgyMFaWpnK6_i5nx9NoIqTGQ8wsOrNLCg>
    <xmx:vKLEZifoAQQCNHIHjx7yfRV9b2c1XdGx40iK8euIv04DNTOiBq-ACg>
    <xmx:vKLEZjnIZJJlkE3xCaNeiPJMBLVHZXEyB4eZWq-HebvcupYC0ymTDA22>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Tue, 20 Aug 2024 10:05:47 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a49173a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Tue, 20 Aug 2024 14:05:17 +0000 (UTC)
Date: Tue, 20 Aug 2024 16:05:46 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 15/20] remote: fix leaking config strings
Message-ID: <97346d6f944e3587a08d96a5e1b4ead8df8a0bc0.1724159575.git.ps@pks.im>
References: <cover.1724159575.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724159575.git.ps@pks.im>

We're leaking several config strings when assembling remotes, either
because we do not free preceding values in case a config was set
multiple times, or because we do not free them when releasing the remote
state. Plug those leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 remote.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/remote.c b/remote.c
index 7d5b8f750d8..3087437bc61 100644
--- a/remote.c
+++ b/remote.c
@@ -373,8 +373,10 @@ static int handle_config(const char *key, const char *value,
 			return -1;
 		branch = make_branch(remote_state, name, namelen);
 		if (!strcmp(subkey, "remote")) {
+			FREE_AND_NULL(branch->remote_name);
 			return git_config_string(&branch->remote_name, key, value);
 		} else if (!strcmp(subkey, "pushremote")) {
+			FREE_AND_NULL(branch->pushremote_name);
 			return git_config_string(&branch->pushremote_name, key, value);
 		} else if (!strcmp(subkey, "merge")) {
 			if (!value)
@@ -406,9 +408,11 @@ static int handle_config(const char *key, const char *value,
 		return 0;
 
 	/* Handle remote.* variables */
-	if (!name && !strcmp(subkey, "pushdefault"))
+	if (!name && !strcmp(subkey, "pushdefault")) {
+		FREE_AND_NULL(remote_state->pushremote_name);
 		return git_config_string(&remote_state->pushremote_name, key,
 					 value);
+	}
 
 	if (!name)
 		return 0;
@@ -475,12 +479,15 @@ static int handle_config(const char *key, const char *value,
 		else if (!strcmp(value, "--tags"))
 			remote->fetch_tags = 2;
 	} else if (!strcmp(subkey, "proxy")) {
+		FREE_AND_NULL(remote->http_proxy);
 		return git_config_string(&remote->http_proxy,
 					 key, value);
 	} else if (!strcmp(subkey, "proxyauthmethod")) {
+		FREE_AND_NULL(remote->http_proxy_authmethod);
 		return git_config_string(&remote->http_proxy_authmethod,
 					 key, value);
 	} else if (!strcmp(subkey, "vcs")) {
+		FREE_AND_NULL(remote->foreign_vcs);
 		return git_config_string(&remote->foreign_vcs, key, value);
 	}
 	return 0;
@@ -2802,6 +2809,7 @@ void remote_state_clear(struct remote_state *remote_state)
 	for (i = 0; i < remote_state->remotes_nr; i++)
 		remote_clear(remote_state->remotes[i]);
 	FREE_AND_NULL(remote_state->remotes);
+	FREE_AND_NULL(remote_state->pushremote_name);
 	remote_state->remotes_alloc = 0;
 	remote_state->remotes_nr = 0;
 
-- 
2.46.0.164.g477ce5ccd6.dirty

