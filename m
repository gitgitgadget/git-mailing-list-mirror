Received: from fhigh2-smtp.messagingengine.com (fhigh2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A59815665C
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 11:45:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726487147; cv=none; b=U7UX6rZ1hh5WaILKEv7fHso4gybUe0bNgmiJtSg9hzmIiG4daFg3AfWed6jUnfrZIn7e51GK4W6e+LuOkDUqmXxQ7CuWjMNQd0bRwbnmzsEEnRS2PqrJUtuc+G2nXnj40QdfMGY4ZS4ARJb7ANip9gzfOVtOnZmjsj4sraKxSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726487147; c=relaxed/simple;
	bh=0OurXaQMJ31rwUl5M2EHfVQuEy32asu/nKouKXTGlGk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DD4ZUzXBWOq86W9hD7T+7hJFfq3T2JZ4biIuMh7+Fh+x4pEgJqd5R+p3zVrOzAvdYeaGMwYmbSZ9Ye79cwVU9/VaYpthc4QjL7OED2kkYkmC9E1Xp+MRakd/q44CfQQg34w+maciVE84urf+fVVZBsDou2dMGgRGdq6Fnmb2hlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ks0l/BTR; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jJkbsz/D; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ks0l/BTR";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jJkbsz/D"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 7F5FB11401BA
	for <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:45 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Mon, 16 Sep 2024 07:45:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726487145; x=1726573545; bh=yXszzEAzbz
	Lh5WqgfJG7Gm3FqzZybYjKBbQaFH6Uo8A=; b=ks0l/BTRAlpuuZC0RrMowJItJO
	bc6uRP82HGRALKC5dnNjT4i03kX3ygdIKMp1u15xh6aJyZCNcFX5e0wyB/DuDH8o
	UeYJpEXe0LxooRtnMCeb+gs3+RUzv+ZCYcdsMYxuYxI0kIOSbPVGIO+VvRwomz6q
	0dMAKqelNWCY/SgAlzFfpovwLsLZWKFjtrRruyVGV+xjofbruIu6skeXj2rqJl+J
	YiCcwaErM3G2OEhCHcxDE1R2BVQi614HCSyJ8jyTfO0kjrn5/RoyZdDOmLhNq/kS
	i9Ap/B3Zd4Py2jdSf4iE5Uc/udQshhQ7pDGjbWq4TATrA7+duoqMlBZ1s7ng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726487145; x=1726573545; bh=yXszzEAzbzLh5WqgfJG7Gm3FqzZy
	bYjKBbQaFH6Uo8A=; b=jJkbsz/DNXhjj4kZ7KhrJheDsK9Zs21uqnPf7p+gvEfP
	d5cwXltS49tSk0IZ7oLYN1RB4o8Qpvg5KoTOWJWqzGK48ZjR1CckbG9YH2yVomrt
	vFVDB/ON/XKTUkxDgJqwnj/52z+KqkWlODavECsHOUiOCeyGhUrlukhgq38+Aamc
	APZZpyCqFNzbNEtsD38sfSCCkT+9u0paJk6e3MPjNWKQAfMhJWKQHUx4EMFjm1yB
	NvKdivSZ+AJDPm9qxBN+lTfhaiVUkYe7q2VbAGaY7OdbW7+vEHV5K048zEcbK9Vq
	Ba89UO+cU38tLoNJ4aHV/EkLmebqnxOKDHl9oylCxQ==
X-ME-Sender: <xms:aRroZiQIx7jaw8shBE8NtHKw-bgWPUApuNdg31mk9BU7OkDwLJna8Q>
    <xme:aRroZnzrNH8dPZS3APrq2MbAaXhKfKsI9RUizvwOc5X6Gtc7aLP2pHNqW_rl4djia
    iTj_V-GypHjKW02jg>
X-ME-Received: <xmr:aRroZv0DykoKW1XqQuX97aUIVXXGLknpj5kSVJyLFYaKjkoRfwyn6JeJ1WdnypfsjB36UX6kYGdNwT7pjc6SBZIhaZ6j0Oor2A9pcMZEfh-y5Qdp>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudekhedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuf
    fkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhh
    rghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepheekfeefgeegvd
    egvdeffeehtedttdffjeeuffelgffgheefleffleejvdefheeinecuvehluhhsthgvrhfu
    ihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspg
    hrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:aRroZuBsuK_ms8x3Lw-PTkfPGiKx5_tf2bqWSs93Jnaw-g4xvxPExQ>
    <xmx:aRroZrhfG17ZTzBvED_ML8iOPFdlml5nS7ZqiqaN6NgTzbXU4a6uhg>
    <xmx:aRroZqqtLfjpMuj1mDugGhZlKhq5aSkS6K-LO9t66LTplT0ddZgt8w>
    <xmx:aRroZug-z6w3m2LJc76oSuzsBFhvfjoZbwvOn6LmKFESuLX8SGYPkw>
    <xmx:aRroZjY0HCpfZJIZExvHLAsDdXGFCAB-H9XfKArlEQYyIKVJYr65YrWi>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Mon, 16 Sep 2024 07:45:44 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id a3b1debc (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Mon, 16 Sep 2024 11:45:27 +0000 (UTC)
Date: Mon, 16 Sep 2024 13:45:43 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Subject: [PATCH 07/23] t/helper: fix leaking subrepo in nested submodule
 config helper
Message-ID: <96bd7f01d5d1800a0d0520c0d790cc524e8b4c8c.1726484308.git.ps@pks.im>
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

In the "submodule-nested-repo-config" helper we create a submodule
repository and print its configuration. We do not clear the repo,
causing a memory leak. Plug it.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 t/helper/test-submodule-nested-repo-config.c | 2 +-
 t/t7411-submodule-config.sh                  | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/helper/test-submodule-nested-repo-config.c b/t/helper/test-submodule-nested-repo-config.c
index 6ca069ce633..6dce9571531 100644
--- a/t/helper/test-submodule-nested-repo-config.c
+++ b/t/helper/test-submodule-nested-repo-config.c
@@ -29,6 +29,6 @@ int cmd__submodule_nested_repo_config(int argc, const char **argv)
 	print_config_from_gitmodules(&subrepo, argv[2]);
 
 	submodule_free(the_repository);
-
+	repo_clear(&subrepo);
 	return 0;
 }
diff --git a/t/t7411-submodule-config.sh b/t/t7411-submodule-config.sh
index 31271f8e0a6..af0de496e07 100755
--- a/t/t7411-submodule-config.sh
+++ b/t/t7411-submodule-config.sh
@@ -10,6 +10,7 @@ from the database and from the worktree works.
 '
 
 TEST_NO_CREATE_REPO=1
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.46.0.551.gc5ee8f2d1c.dirty

