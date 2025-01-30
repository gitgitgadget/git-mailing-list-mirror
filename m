Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA6A1EE01F
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 16:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738254274; cv=none; b=aWlMQfJLmMM49QPxoNzsWmpT5ZmY1XDeM3yYaE463AMdyCBtl2WKO/wu0sNiRaiR/dFVxSCnrXj8mkxE3iZH6zTQHjlosgZgbRF5HZ8tew5P5r84HuyzVQbfcogj77p3N1dcsAXEhNF8wDn5syeMK0R0jBK83+r2wmMu6sV2s9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738254274; c=relaxed/simple;
	bh=lIdIOdlBGb/8rrhbC1Ic8RgL3tYHQrycmTkRJ68wH6A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hVH5dxt3z/RxqXQoobRHIRnfT9ZTeLc1xeTEa3bBxvPObYkVt0CWRju3hgCmXxWW49OQTIkT/Qs7WbtSyuXTi5h2roX4GEtiVY1VPeqKJJ9xUTzaywxVfKiYqcs1Md99oWHukX3MLx1BiTuc51iKfr298dSQIaG5gRaNiIhvmBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=gfS6p43a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=KiJ41hVC; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="gfS6p43a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="KiJ41hVC"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B97781140121
	for <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:31 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-12.internal (MEProxy); Thu, 30 Jan 2025 11:24:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1738254271;
	 x=1738340671; bh=Gp8UTkRTHtukFkkI8zVAG/UTLc1yuOc/B2k0jK1Y+9k=; b=
	gfS6p43aek+NNcyOW1+lecbBCopAtWohFjfAO9/PMOIEz0cl2oAYnVALyHERSbqd
	auQhCiilQZMKwdPTVRqSj2oYDnPEpIyfs0oz+rICsvPq/Je4HZARXbHWC1uP1VuZ
	XRtIk5X5DY0mB7FdLIX6vui97o51pqr2H4LBj80A1wYhkoeKZdIUnarLoPb6Jza7
	LCE1uUiErDjCCYN/gomOSPOcsLFNUIxbuYX6rr5HpxMNgGtL5W6UfLC9cj+DF7l3
	m/GiM5o/pqSzSM3VMUxUdyi5LR7XuMryeUgD5Eo/0937sZzsfEYrVSRNpUpUcXyI
	q9TraOzeP8K9LqlymLhZ3w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1738254271; x=
	1738340671; bh=Gp8UTkRTHtukFkkI8zVAG/UTLc1yuOc/B2k0jK1Y+9k=; b=K
	iJ41hVCvsbUIe4wnCIt+fRiCCnWoK14zs6Ib0fldvEQXQV+JbXaub+AL3LJi5zZX
	cYcKJ6+XJMKrg5VTGbL8UkrOVo9Akjp1XvdXUpj6hClIvOhk3eVAi6XCo/keZc3h
	Wde9MsY/kChl/5pXKNlZxNlEqpzBK+YqkhTJgaZpukMWV6lamWL6N4lRn0CtDC21
	2kQXveQZwwgfGwBAtHgKluWHiMW6MxnZ7YA3KYdyxY+YSN4Agr5Oa9cBi6wCxCPa
	JOAQsoG60JveyxwOYLfNVbUN5aWZsYOk0HF5tX80WKS+7Ew3sYPd10pQ3zfHr0yK
	4lT1ZmF1LoeD+7D4/xzmg==
X-ME-Sender: <xms:v6ebZ2zvTOC9ChXERuk-ptttgNN9X9BLdvAhUfvl9-kwlJYjTZIxrg>
    <xme:v6ebZyQVY0f1LqfbXzFROKvpw3ZqM2WtRlm3Z3kotLnbHIbFgGOWJI6ww97VV5tWo
    HSRtNRco5azIu_Z0w>
X-ME-Received: <xmr:v6ebZ4WwvhYsf5DQwPYUI4JJkqBXXSOsqqxm7rvx4Th2cBssjJfBkrE4XekXFMDlkH_vHhqin3ZVcaPZenwJWqzmfI5E4pFHghCwRvjvsEzg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeivdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhfffugg
    gtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgtkhcuufhtvghi
    nhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepffeuieduje
    dvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnh
    gspghrtghpthhtohepuddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:v6ebZ8gSSFcPc6o3L85vee-nurKnUFuxmde-_a99Qry4r3zeuXAFoA>
    <xmx:v6ebZ4BzM-coA2YByMqxUZiWpBY4_1wljmF7XjEkcZrrpzsbD0J8HA>
    <xmx:v6ebZ9LJk6WCkKgIRfOAW-2CArTtfGzpWjucjezG9rGg7ojCgcrPiQ>
    <xmx:v6ebZ_ArdeNzercasMmoJa91A7TJGL3HmjAQnsPYPy0Kd-l8-Ushkg>
    <xmx:v6ebZx6vMw4yf0JVmpACazajV24nfnIS_6GN33tWMPm4K0RaV3Rd-qgf>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 30 Jan 2025 11:24:30 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id e63dbb55 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO)
	for <git@vger.kernel.org>;
	Thu, 30 Jan 2025 16:24:28 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 30 Jan 2025 17:24:19 +0100
Subject: [PATCH 3/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_HASH
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250130-b4-pks-reinit-default-ref-format-v1-3-d2769ca01207@pks.im>
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
In-Reply-To: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
To: git@vger.kernel.org
Cc: 
X-Mailer: b4 0.14.2

The exact same issue as described in the preceding commit also exists
for GIT_DEFAULT_HASH. Thus, reinitializing a repository that e.g. uses
SHA1 with `GIT_DEFAULT_HASH=sha256 git init` will cause the object
format of that repository to change to SHA256. This is of course bogus
as any existing objects and refs will not be converted, thus causing
repository corruption:

    $ git init repo
    Initialized empty Git repository in /tmp/repo/.git/
    $ cd repo/
    $ git commit --allow-empty -m message
    [main (root-commit) 35a7344] message
    $ GIT_DEFAULT_HASH=sha256 git init
    Reinitialized existing Git repository in /tmp/repo/.git/
    $ git show
    fatal: your current branch appears to be broken

Fix the issue by ignoring the environment variable in case the repo has
already been initialized with an object hash.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 setup.c         |  4 +++-
 t/t0001-init.sh | 12 ++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/setup.c b/setup.c
index 53ffeabc5b..7da7aa8984 100644
--- a/setup.c
+++ b/setup.c
@@ -2517,7 +2517,9 @@ static void repository_format_configure(struct repository_format *repo_fmt,
 		int env_algo = hash_algo_by_name(env);
 		if (env_algo == GIT_HASH_UNKNOWN)
 			die(_("unknown hash algorithm '%s'"), env);
-		repo_fmt->hash_algo = env_algo;
+		if (repo_fmt->version < 0 ||
+		    repo_fmt->hash_algo == GIT_HASH_UNKNOWN)
+			repo_fmt->hash_algo = env_algo;
 	} else if (cfg.hash != GIT_HASH_UNKNOWN) {
 		repo_fmt->hash_algo = cfg.hash;
 	}
diff --git a/t/t0001-init.sh b/t/t0001-init.sh
index 6dff8b75f1..c49d9e0d38 100755
--- a/t/t0001-init.sh
+++ b/t/t0001-init.sh
@@ -586,6 +586,18 @@ test_expect_success 'GIT_DEFAULT_HASH overrides init.defaultObjectFormat' '
 	echo sha256 >expected
 '
 
+for hash in sha1 sha256
+do
+	test_expect_success "reinit repository with GIT_DEFAULT_HASH=$hash does not change format" '
+		test_when_finished "rm -rf repo" &&
+		git init repo &&
+		git -C repo rev-parse --show-object-format >expect &&
+		GIT_DEFAULT_HASH=$hash git init repo &&
+		git -C repo rev-parse --show-object-format >actual &&
+		test_cmp expect actual
+	'
+done
+
 test_expect_success 'extensions.objectFormat is not allowed with repo version 0' '
 	test_when_finished "rm -rf explicit-v0" &&
 	git init --object-format=sha256 explicit-v0 &&

-- 
2.48.1.468.gbf5f394be8.dirty

