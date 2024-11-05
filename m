Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E0F1FEFD8
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 06:17:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787477; cv=none; b=ut6RQcptf2dpTxugYNoFLRRpYpaChiv5XejtqXjMfEQtS4Px4ECHXdDphBhiio1VxXVgjzYilTjL+VVdSaZX8EKRwUGiOzJczaSt1k6qnyG/5XhfmXWaxoVP6ojv24T2wwhwTVlv/yX0MuIRoP/zCKm2aUrsNC+Fdd3ntxII4E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787477; c=relaxed/simple;
	bh=A0SZLAqdki/rAYZrLvUeU4q5usOSsZLvs+lux8pEUB0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eLDczuXsHbdI8ZPqTTIsb6eOEftrQvpc/Vu8kDBXdcNJHA9nue0yIzndpp2dmbtixwboEOzUk9rgsORW0JLpyJk7TzBif9QrSnAVWylBVufUf9dxXu57eBN/FKgA5mAMKs2nulES75l/1Zz1LY5Y0Y+XdGIacSZvInetYSUVTY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ORB0Z9Pf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iVNE9QOi; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ORB0Z9Pf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iVNE9QOi"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.stl.internal (Postfix) with ESMTP id 0ED19114018C;
	Tue,  5 Nov 2024 01:17:55 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-08.internal (MEProxy); Tue, 05 Nov 2024 01:17:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1730787474; x=1730873874; bh=znr72vC7qW
	4uhoGtCgyCkuytqAkVC4l+Zx6cG6ciiBY=; b=ORB0Z9Pf15fwps8fQDo8lvtllt
	yUfq9mwVDYRjm6YqjZKvIByggkX1dLh8aNe3SzKVWYG3PSZ4hkRvs6WJdLmF2tJE
	oPN21NRzjDrb/UMwGnzUsVXpbYfj6WH+y5YevRkZH3Ymy9pUO9/cniwPeajOHclU
	5taSht5f4CmLdycXBaoEvkPkvAvNZUXDUvwGbrGXmLjOick4I3OOf2AYc95XKmXs
	dd9WDtYdqDJNPBlKy6H0pZu6uudry/9p4gYB87LYTsQ/fh29BcGcNc3os0XOCaTO
	5+IqinVmYm38lxqGjUooUq62KC/q1rei8dqzDnuV4LXXdwcNoy3yw9l1TESQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1730787474; x=1730873874; bh=znr72vC7qW4uhoGtCgyCkuytqAkVC4l+Zx6
	cG6ciiBY=; b=iVNE9QOiCWIDvsKlG3Vcpqdh0Fyn74qn31M8EdqTsrbER7Ii5OX
	oLvwhPH5+ROLevYFDT3w9EDC1ISVkmmaHlaPlIjYaWWMIVCpYR0qjFfOuHTlpmFj
	j4kQ9UzK9lMcKS9we9k2oRzkoVNYTlis9ell2MHjbFpVYLa3WbYTyWFugy3ARH0J
	YrCMlUsVw10k7Jg3vCd0NKo67j5cIvj3B8WHiQXMYwJwPJvdbu4tc4Y/wW1pwks9
	BdqR738K1T40ReAnUXBIUzsGTnC722QbjxWhRVe3DgMGMP6xSIuJXG+lxQJyZxPm
	W0JPHFGMgs2TTRNA/Jk6b49NftzenW8em6w==
X-ME-Sender: <xms:krgpZyjG7Lyt3vOGPEW2CfuBrb8mT7oXHg_ep-wsKGd9ftJjpAzCnA>
    <xme:krgpZzBrrs_mK-t1kNpBa0vbxsxcZ314ZIkp9kEw4G1eazM2L9VHVIY2agCpUYEga
    1p8QDACcKml5gvMOw>
X-ME-Received: <xmr:krgpZ6EbMYnq1aTcmiqe9GHTQVra7fkyqMjoCe2hMDmWWwIeuDV82gqO5BfxYO4qjsMNyoVju5sLi6OluqKuOGWzogbFTJlCS6OjrLjyU9qzNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdeljedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepgeenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtoh
    epkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvg
    esthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhl
    rdgtohhm
X-ME-Proxy: <xmx:krgpZ7TVCuQCR-AxjCPVdn5WouftDFkTY53Nrea95J2dWQQbJV0aFQ>
    <xmx:krgpZ_x50CqJYJ_Hp4BmfRy0b0gwkbIIXDDzlj83gkQG2KxKA2eEnA>
    <xmx:krgpZ570kgUDaR9ZiYrg5-4nbXVLHNtT6L_NdWaxKRotmbeo620sjQ>
    <xmx:krgpZ8ysnV-CydylntbItyZwmzv0jvV_iUtE79hMc0itngcNxiwERg>
    <xmx:krgpZ6qYrIy4tgW6CFG7qv8bI2t9RufrwOQscKuUmzMNtGOx8xrfx8Tx>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 5 Nov 2024 01:17:53 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id ba0e01c4 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 5 Nov 2024 06:17:32 +0000 (UTC)
Date: Tue, 5 Nov 2024 07:17:46 +0100
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Justin Tobler <jltobler@gmail.com>
Subject: [PATCH v3 20/22] dir: fix leak when parsing
 "status.showUntrackedFiles"
Message-ID: <714c9286e7a466f5693cb9ab70177f46d51afe04.1730786196.git.ps@pks.im>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1730786195.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1730786195.git.ps@pks.im>

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
2.47.0.229.g8f8d6eee53.dirty

