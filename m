Received: from fout5-smtp.messagingengine.com (fout5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BBFB1581F3
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487184; cv=none; b=dI5sTYlwBfVsM/3FLbVXquoUBF3lAYty3U3Q9kNB7j/8lpkgnctf0++C2wFYzsRs5QKzU7TB/Z6gTmCjoS2HUkICWOjcvva8nBCx3DUoNgxxAKVpgOaOL5nQfbsC0a5dHdWHpJbDuTopXdpmRcjMFFf965F0PJjfDPve3lS+URs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487184; c=relaxed/simple;
	bh=VasDHImpGrQnO0IE/PwOS8bPlpZC9i1IZTDB+9Lz88A=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Aath3OhIyUdPxnrqlNdkBAsTicbHwGg7V1VKgbz8vLD3cIooDEipKbAiKA3sdVPfUo6o+5+d834e40CjuRmSUXS6EhMMexk2JuVNiuKiJy8oypu6mTxjgFRsY3uBeayetvRG8m8Qcca+TUJzM6WrLn7xPo0cPSZ/yrZtIhsJBsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=DJ9Wa8Tl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ExUhM+Lb; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="DJ9Wa8Tl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ExUhM+Lb"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 41A2A13802E4
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Mon, 16 Sep 2024 07:46:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487182; x=1726573582; bh=3D5zyi2OUZ
	YhTCl1DSWT6mkVlwu2IQkuIaiEs7vZI0Q=; b=DJ9Wa8TlooW24mrNGEF0uzjOPt
	F/xXz7zWncKXNi2t6TKlX4nFbu3Ye3jUc5XQXSKwgbHy/95ehOk0ERZrnjiLGbxW
	R/naeg7OfNCJfW8xESQXodDf2AYOi1b8VE6Js09x6Z9bdVSR4HyJWrBEH8DDqEim
	HkDlmd1yHLfWNwrQCbTh3Ha/PTPOdwad9JCq/s5jvHR366LoyntePGc+ng94f5GY
	OOFkXx2MM0VPm0Nw8NB6feshFoD63uOaY64om+v5Gdx64VAHls1wgWsYybbTLxc/
	/xr0wm4lYtHtX5+0dqNziM6PmYICtFTy6rtvXs46wY8esT1OY0NGpYhotr0Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487182; x=1726573582; bh=3D5zyi2OUZYhTCl1DSWT6mkVlwu2
	IQkuIaiEs7vZI0Q=; b=ExUhM+LbRFtGazSK9eWNAY5rvxQlZrr5XiBDkCRdaGtx
	l3q0W8dYAKDTeHmEcNaYp3eiOql/cKdY/IIgRFGOqgMz/KgPBiyFSfbbeO0NzIdw
	DGpB1TjGXMNqZPPCTY47+OOYDXPRnMebZ+WhJ2b6h2dhbC9rPYg9aMmd6kLErx0J
	K1gzds3h+8C2ZcGYXxuQhMZxcqDQHD2LIvh5cxHSlM/jVBYGB/W4O1CX/JZCMYfP
	OnS5gQo02EmEV8zi1cLcG+U3edBNWA3+oJhreNzDvHNiUHwIk4uQst/lsaKBU+Zy
	VwpqwmpasmeF6tcVJeJrb1Q/d/kdE2T6Y7YU+zbEcQ==
X-ME-Sender: <xms:jhroZux20mE4syCdaM-BG4kTHJac6dSSVMOZYJ4TNyz7PuwoeH8fGg>
    <xme:jhroZqTG-k5GU5Y_QwxB4qMxNtEUf6AmJJQ1TRjN2mDqEUJ0l7A3VoylBzPldfoom
    SSfqWnkLwK04AOgWA>
X-ME-Received: <xmr:jhroZgVEzj2NAJylhUJIKY37spKvdioUgy8sTIudvHraNTjiApILjfk-QlvZvQ1I-sr6P9rN3WQ_LKa8rKI0JoQLDN65xAEp8VGim3UatdT0-xQi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgepheenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:jhroZkjgbvHRgpiQETPhMSwvBKwQAmHEQ62enek3ZS7XLfCtStYTsw>
    <xmx:jhroZgDzWdjd5Vxw9R_G9lZDfh7dP3ufKjvZDWtn7XACoy8VIMv7yQ>
    <xmx:jhroZlIThXNECHzpzLfsiGFuraf0qtEkikLtZu4AfOxvr82lZDHRig>
    <xmx:jhroZnB3Oh0G6JEKaN3Q70FxTu7z2Q-ochvfS1RyBhUzwP_vxdtApQ>
    <xmx:jhroZp6sVjplyxxvsaFeB-mas6V8WQFNnKVKQPUBRk_ilPOpdLCm9_ss>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:46:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 88b80036 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:46:04 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:46:20 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 19/23] promisor-remote: fix leaking partial clone filter
Message-ID: <690de28bef8c4c7608aaf5c1f92ee24525dcb987.1726484308.git.ps@pks.im>
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

The partial clone filter of a promisor remote is never free'd, causing
memory leaks. Furthermore, in case multiple partial clone filters are
defined for the same remote, we'd overwrite previous values without
freeing them.

Fix these leaks.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 promisor-remote.c                  | 2 ++
 t/t7814-grep-recurse-submodules.sh | 1 +
 2 files changed, 3 insertions(+)

diff --git a/promisor-remote.c b/promisor-remote.c
index 317e1b127fe..9345ae3db23 100644
--- a/promisor-remote.c
+++ b/promisor-remote.c
@@ -154,6 +154,7 @@ static int promisor_remote_config(const char *var, const char *value,
 		if (!r)
 			return 0;
 
+		FREE_AND_NULL(r->partial_clone_filter);
 		return git_config_string(&r->partial_clone_filter, var, value);
 	}
 
@@ -189,6 +190,7 @@ void promisor_remote_clear(struct promisor_remote_config *config)
 {
 	while (config->promisors) {
 		struct promisor_remote *r = config->promisors;
+		free(r->partial_clone_filter);
 		config->promisors = config->promisors->next;
 		free(r);
 	}
diff --git a/t/t7814-grep-recurse-submodules.sh b/t/t7814-grep-recurse-submodules.sh
index 167fe661504..55ed630e77e 100755
--- a/t/t7814-grep-recurse-submodules.sh
+++ b/t/t7814-grep-recurse-submodules.sh
@@ -7,6 +7,7 @@ submodules.
 '
 
 TEST_CREATE_REPO_NO_TEMPLATE=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 GIT_TEST_FATAL_REGISTER_SUBMODULE_ODB=1
-- 
2.46.0.551.gc5ee8f2d1c.dirty

