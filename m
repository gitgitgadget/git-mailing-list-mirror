Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07B15854D
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487187; cv=none; b=Okxi/0wHTTCcnSYY0B/bFrgtRYWgFbCkd08xBcbgTQgPZnOd5PHfV4bFbVVM1HY5Uf+7wqLKaQdtBXdB0CN7Ctkq89exIBgmwTdVtg/+2TekUrOagg17yR+7bDBOO5D21QzwlWRF0DIUbqIDAMcjFVmqYu0YnOm0sUIIbkbtRuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487187; c=relaxed/simple;
	bh=j5lWjvJ5VTUIh4rJjdlmLupm3LVCaUviF05OKR1224A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EHSVtECzBEZ0yjWSSV70VNZKVHuZjt3wbTMX71vnr2zOOfWDQpCnXYjpsXCvbsu79gQD+Yw99+YLJVkuZ09z/hmvtYVbOtzEwu7XAOTcBu0yvrchnj6B/0gTZq9+OiJxXRudLgTAaBi5AucbVlLXiVQsfmTnK0lMsUUWKkuTnF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=dqO06MVC; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VvcmtUZB; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="dqO06MVC";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VvcmtUZB"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 1270C13802BF
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:25 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-09.internal (MEProxy); Mon, 16 Sep 2024 07:46:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487185; x=1726573585; bh=2OaP9T77wt
	6vivXJHwvT5KlMC5XETTEQEgjghBHbVuE=; b=dqO06MVCE7Mzy+X3Oqo77SUqXI
	gtuGwCaEhAOyYPMjZ5s2jyAjYJD2Ooe780RBZcqsPZKB9JH2RDm7qmSDAOsWRgbT
	5UHAZRn7yYKF3MSSuytTDTht9Ukg+wed23r8aKnbVe5Sx5LJtqgYLFfXSyfAI1jP
	9bfmzSbvTFW0MwoGh3M5fkxbsZjA4kOr0/PYL0D6xVXlAyjvRHoL/m2fE+MlyWnF
	MR6NSKSciVrRZuVUZgccyQQL8m8zFnPERTrGwmIlpBZMM8j6shib5K7SeZNt1XVS
	zoFe0Jbmr8AgmZnPtEMXZuncz7ThiaGirDSUl1eRvmUJ0sye4/6+Y8Kdd9yQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487185; x=1726573585; bh=2OaP9T77wt6vivXJHwvT5KlMC5XE
	TTEQEgjghBHbVuE=; b=VvcmtUZBJv69tW8p662q2gZPRuBLigkryt5bVi9ITRuO
	mUdmZe8MOPvZhOP99h2hpWgMchL9op7BYoDYF3EDXlNEfHX31e00H34CuCbq3aCz
	FpG8pAyYnQBeO5mfPZ/sReuMtNxVhwq9PkIyLCB38XoSXYZat8zDR1hoP8zdKWOl
	+HQGbUsRvh8Fe7JGDIzLzmJNQVxVuFARRI/BcOC0SMZ/mLnjJw9YZ2IbMOMZ0WTV
	ySSnFfiz3sKzsqcDwsJZ62MJC5OuOsDbmxxtP5h0mJJNQfyhjUIcwEMJpSKv09iU
	rsdto+NKHKSqGEET4gSbLBTJovEgAqIv7hQ9S8IQfg==
X-ME-Sender: <xms:kBroZk3DQi9TJ1skcYC9Sk2ur1p2CoZ1TMSATp7WHOAi1GG4XKSuRQ>
    <xme:kBroZvFx1jPMU0_PidgBVSvHkebmK3fES3lyqZwFgkG1RPFthTnH-DhYaMnhrlbfQ
    rasXUHYNcw_z5hq3g>
X-ME-Received: <xmr:kBroZs5hObwG0jDb_hdPR6Pj_Mnio_0Z2glBQ9b2P11gVZz4dMlKDrjnqjwuT4uGUzvgjQbUHfq7O2QNmG9ng8_rhUMpAfWPWCXYECeG2Xs2aocI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:kBroZt0kGcWmFgUgECr0K_zvRdWsPN4hPYb0BJcpc9FzI4F6_t37uw>
    <xmx:kBroZnEE02Bt_TrVXDnDlUVZhawZLUoYp2ZEQT31z4oEgXCt8Lsu7g>
    <xmx:kBroZm8G6WZCB66zF0lSJm2PfzUZUAwUUT-L0FYiRUswluzZtXEsYQ>
    <xmx:kBroZskI8c9xQm1mRDqdEgESoSfd2PLwwxtyhGkGaG_fkXMS1tktmA>
    <xmx:kRroZtMOa7ihXCxHF-_0llv1T8qwDnGtU4UmpVOK7HAwTiAVgKIdiCgq>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:24 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1b807034 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:07 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:23 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 20/23] builtin/maintenance: fix leaking config string
Message-ID: <ed4091255cd25e82db01cb05df63b8c6804b6449.1726484308.git.ps@pks.im>
References: <cover.1726484308.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726484308.git.ps@pks.im>

When parsing the maintenance strategy from config we allocate a config
string, but do not free it after parsing it. Plug this leak by instead
using `git_config_get_string_tmp()`, which does not allocate any memory.

This leak is exposed by t7900, but plugging it alone does not make the
test suite pass.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/gc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index 7dac9714054..3acfa367ad1 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1476,9 +1476,9 @@ static int maintenance_run_tasks(struct maintenance_run_opts *opts,
 
 static void initialize_maintenance_strategy(void)
 {
-	char *config_str;
+	const char *config_str;
 
-	if (git_config_get_string("maintenance.strategy", &config_str))
+	if (git_config_get_string_tmp("maintenance.strategy", &config_str))
 		return;
 
 	if (!strcasecmp(config_str, "incremental")) {
-- 
2.46.0.551.gc5ee8f2d1c.dirty

