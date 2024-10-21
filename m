Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB6A1E32D6
	for <git@vger.kernel.org>; Mon, 21 Oct 2024 09:29:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729502950; cv=none; b=fqH/i/7t4FF7jgmJJMjNXgjeh2fsNivM8Fi+dbuAn9nOGoZ9/zCppemRMd4eAK2Gmxp5TTaxescH0DNrihuhCXrjtS12TSyK7TXKb6bDeo/qCV1aYYwOKgbv50tgpg6dV4lszEBHbvnVoATDZIxEmux12jybsEoPBUp3WjKy+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729502950; c=relaxed/simple;
	bh=3U4sz1CHCWB0UIebhkHpDUe482hKK6FSRy6IxVO4ky8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kuwGUusmj9cMyLJ7OaD6+azcmmbgSwGwfD2qWOxsZQLhVlCwPWAQV76nW4rKWi5p/HQ64EdQm+/vClh4TtWQnfoVDX0T4WHq/UKscRuC1uWS3OSr39OPxUN0uL/0FFr/36uCGr01ikYqrXOi/lqvXJE8Y6k7sC0kSNxZ2AX0Ft4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=4eIdH99B; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mpTsmv7f; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="4eIdH99B";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mpTsmv7f"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id DA27C1140227;
	Mon, 21 Oct 2024 05:29:07 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 21 Oct 2024 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1729502947; x=1729589347; bh=jeF21Y5V1h
	lZSiJPMXn3RDJJd/W9lMwXhALyxDg6bFU=; b=4eIdH99BduK2BxqhyJ5/V0U4aH
	oxLsaLTqKSo/mTJULbvoA/Qw/9c43l3faeqeKAU/gr9BEFJTDyImkdBkAr+i60mp
	xS8AovNsnoSzlYzZQuniIIxoQDGLJjdGXIwcB/aC6sr947UEt4YFY79ZQSY1uTX2
	PJCQbIEnr1C92Qk1ThG6bAICVVUi/YJxBmnUcxfgy4HCZ2aJmtkusWAtuYzqYhk3
	OIXYZWTLXQcR26BinaIqIuNbr0eNp0YLH8py3LKiGj0hFY/T4kMGJxa1DGOh36jP
	0LxxaO977w8hNTVaQ7/wH0lI6enp+Sfuy1xhuzjFaw9sWp1Sf+0kAcJaEX+w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1729502947; x=1729589347; bh=jeF21Y5V1hlZSiJPMXn3RDJJd/W9
	lMwXhALyxDg6bFU=; b=mpTsmv7fY+TzOZCiuBFC7GzMdVWx4nz2KvOiRWqAxn0f
	UhZ1iQ9/EGgdHhiRLA0vHKZVIpGk0eLaEuH62NiqGhBm38jJtPncgNgikL7ks+22
	U6lKYqfO6Z6NOwCFoVHiIb3xBhztw6aF/Kt8msV8x7qZinnkxkOKWneF3bWbo13l
	5vSf7IfzzAhdCVLSk87MpnPfDo+JCOkY8mKqZCBD636sisrlOqBwcRPI8d7TJGJ3
	t6hFGaCJCC+CntGxZ5dzR2IL90HOEi7MtbSWXH8QV55iT5dBNIgHbipdTDoCMAuF
	bqL/b0H9UmwqSGNh4uJqngx+iIJcBazbi9+6Q1mF9Q==
X-ME-Sender: <xms:4x4WZ4tuGgd-wj3zpE10H6lYZJ_94FD_ho1EJF_u9m2CFE3gLC8WBw>
    <xme:4x4WZ1cPrH_uzgFs2o2bGUdLKxCHIqDDZvF_IKYkWi8NPlcWh8CEDkYNocvrWOx32
    NWh4PveFNZxYIDZWQ>
X-ME-Received: <xmr:4x4WZzwKn3_Lv70Y0xeRAFu6JOzXj8lz6FGBb1N23VsA_EwQ0Fg8khHMA51l90giOHMHNa9AfBDgfO0S82aovQ4cN_HpDKG-7xo4LdqzrbuA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdehledgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepfeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgih
    lhhorhhrrdgtohhm
X-ME-Proxy: <xmx:4x4WZ7OvHPZZDvjglUh4s8YFhzptxOXxFnlpHpMywRDhUwiYRgceyg>
    <xmx:4x4WZ49lWf_Q4PFbdwBB3MfuWXWzFGBVNiBOSxAZ2zEPfll_CUhhkg>
    <xmx:4x4WZzVUCS26Lx-d7nc-SJDXWndHdOp1ReXQzoK29CzzQs6HawWnIg>
    <xmx:4x4WZxcKGpivgyXuVy1bh-OHtC_ZPEbavtj4_d6uyqGT3JzOVJKL1g>
    <xmx:4x4WZ3Yr0pU6HUlV3BYxINAS0DOPWAvmYDk9SwvYaVPyBVSyipV2ZrDt>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 21 Oct 2024 05:29:06 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 911b0ecd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 21 Oct 2024 09:27:39 +0000 (UTC)
Date: Mon, 21 Oct 2024 11:29:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Subject: [PATCH v2 20/22] dir: fix leak when parsing
 "status.showUntrackedFiles"
Message-ID: <ad309ac1b372f72c775390adaf0706df7d39b320.1729502824.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729502823.git.ps@pks.im>

We use `repo_config_get_string()` to read "status.showUntrackedFiles"
from the config subsystem. This function allocates the result, but we
never free the result after parsing it.

The value never leaves the scope of the calling function, so refactor it
to instead use `repo_config_get_string_tmp()`, which does not hand over
ownership to the caller.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 dir.c                             | 4 ++--
 t/t7063-status-untracked-cache.sh | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index cb9782fa11f..7f35a3e3175 100644
--- a/dir.c
+++ b/dir.c
@@ -2872,14 +2872,14 @@ static void set_untracked_ident(struct untracked_cache *uc)
 static unsigned new_untracked_cache_flags(struct index_state *istate)
 {
 	struct repository *repo = istate->repo;
-	char *val;
+	const char *val;
 
 	/*
 	 * This logic is coordinated with the setting of these flags in
 	 * wt-status.c#wt_status_collect_untracked(), and the evaluation
 	 * of the config setting in commit.c#git_status_config()
 	 */
-	if (!repo_config_get_string(repo, "status.showuntrackedfiles", &val) &&
+	if (!repo_config_get_string_tmp(repo, "status.showuntrackedfiles", &val) &&
 	    !strcmp(val, "all"))
 		return 0;
 
diff --git a/t/t7063-status-untracked-cache.sh b/t/t7063-status-untracked-cache.sh
index 8929ef481f9..13fea7931cd 100755
--- a/t/t7063-status-untracked-cache.sh
+++ b/t/t7063-status-untracked-cache.sh
@@ -5,6 +5,7 @@ test_description='test untracked cache'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # On some filesystems (e.g. FreeBSD's ext2 and ufs) directory mtime
-- 
2.47.0.72.gef8ce8f3d4.dirty

