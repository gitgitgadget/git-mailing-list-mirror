Received: from fout7-smtp.messagingengine.com (fout7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAD8D17A5B2
	for <git@vger.kernel.org>; Fri, 30 Aug 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725008984; cv=none; b=APG0iWocKCxG1xIWMZH29ivLIcn8SWtikUnlpKjGkb1BeiTs1xHI19ur+sUxlT3T9fK6a1kvR5RJ6FtX5z4OE7QUOOr9ysGDDeUQHNJEDGtsoTcuxokkni4pDGxnlAIMGA0XKpN+62fwAEdDGGUuY5ro7ZSUC0OfBSXE5SJGpyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725008984; c=relaxed/simple;
	bh=3ORkFRBuyqXdandtYNYozwyVNu2Dw12MhAZRjPyW4eU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HWzMvx2nnicTSIq+F6WcejGXWVkEZ58e3vMeUVKEP+k0GviMJXne9RIpfu5Ed0EWmFczSbMf1hrZWjxeArN7W0CAofvuXJz3Px+op/5W/iWwvwmccpcfTYWqOUU1RvPVS+ajvSUUFuaMr+7+vfTUix8kEK4auIcc2DLRqsYpw0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=BjVcshvX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jGdFqC4S; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="BjVcshvX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jGdFqC4S"
Received: from phl-compute-06.internal (phl-compute-06.nyi.internal [10.202.2.46])
	by mailfout.nyi.internal (Postfix) with ESMTP id 5320D138024B;
	Fri, 30 Aug 2024 05:09:42 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Fri, 30 Aug 2024 05:09:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1725008982; x=1725095382; bh=7Aphy95ykn
	Ym+jWCcE7WBSqseCmbbp062X5g/uxMJZ0=; b=BjVcshvX0VPA4AtpR5U5Tmxwaz
	hqD/59Jjg59g8G+8luhbD7lPmlPRC5MKqNxXs0G0xvxI06FDUpXyeYGFFym7sq4C
	HyMs/JL5c4ElvGMaCgry4gO+zNFpwAhKn6d9xkrjyxVgnxETCYoZG84CFyeTrMFg
	5JXyPi2lpk3DxAjEdQUtvy5ESw5qRWxQL7t7cLGqK6Mn0lCIuENmORrtWzVc1BDw
	TxFIxgq6usdI44DKO88ZkozNX8lJrOO+6l+H3L7CWo6c8kBFc3riI5ZvENCmme0+
	Da6snL+Y4dQ7q1d37EVFebqSC1RSy/mtT0RVUnAIbbtKHQlp7cjxfIMxshxQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1725008982; x=1725095382; bh=7Aphy95yknYm+jWCcE7WBSqseCmb
	bp062X5g/uxMJZ0=; b=jGdFqC4SbPytkYOPMFA29FlBbCWmDTKCfSqVIuZvErP2
	yDzwFuMSjljddA3/T3r6ytRbIKm/MpxAMgfzSvcMg3jOhrQWilgqT8/K/xWhQ72z
	WCGYMs/Hzv904BNnqI/vC7WFP3+pxqOJTnw2uHrEYwY4S2szz/yvJxlE+12G2EEc
	u0D7CVTaO7O30gum9rK6iSh24Z3RCBX3vyUg/2+FBPG03CcQve1WvEXHCVooLSvi
	KF3C0T07uv7z2egTRflirDgSEftS24w7g8o/ys87yHTAmhzguGP/Cpfg328Wi+Lg
	L/l3hK1GVdOiQO+tX08LpTQK0oS68d2aFToo2pcNwA==
X-ME-Sender: <xms:VozRZm20JgAO2WYmWmyXH7y1kVpbnbCE0DNZpfxWxiGJqeoBX_2i9w>
    <xme:VozRZpHcBvnky802JBIasOTnrWxuCyTok16ojd7_ub1VnNG52P1i0dQRTZf_lC-Xs
    svrxS9nH-L1XLxehQ>
X-ME-Received: <xmr:VozRZu6HIj3fdrJtlM1XXBvDGms2wnU8ccUaXoMmLIZYauooyr0p31NMtLQDze72kp1GKGiCM27Gk7ye_UaSwi7Q0bUbaxgMNWckbH2ke648cu03Mg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefiedgudefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomhdprhgtph
    htthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptggrlhhvihhnfigrnhesghhooh
    hglhgvrdgtohhm
X-ME-Proxy: <xmx:VozRZn0gHwYc-ME07d7g2b3_dJFOHWEo6NtW68lAV6am_jf3rikJ4w>
    <xmx:VozRZpHn8Ccu-m_YbsnVqGXKJlPIy4pHEMNY4DS_z_l_cMTzL2hp0w>
    <xmx:VozRZg97MSrBxocA4xjcX5mc1nb2vVU0mIstWM6v2qCoZ5qqGhbEKw>
    <xmx:VozRZulwElIRJTooDX63RwNT6VhlYY4rwiFLaSYZcKoN4wwWjz45WQ>
    <xmx:VozRZtjTH2Y3VFdm16dIywbqNAtd4QZDBUjExX7V-D1eML4tBzzQS3w7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Aug 2024 05:09:41 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3a439cee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 30 Aug 2024 09:09:30 +0000 (UTC)
Date: Fri, 30 Aug 2024 11:09:39 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 15/21] repo-settings: track defaults close to `struct
 repo_settings`
Message-ID: <231c52ce82f8339f4e27b59bdc76e402572e91f8.1725008898.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1725008897.git.ps@pks.im>

The default values for `struct repo_settings` are set up in
`prepare_repo_settings()`. This is somewhat different from how we
typically do this, namely by providing an `INIT` macro that sets up the
default values for us.

Refactor the code to do the same.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 repo-settings.c | 9 ++++-----
 repo-settings.h | 5 +++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/repo-settings.c b/repo-settings.c
index 6165546e80a..3a76ba276c9 100644
--- a/repo-settings.c
+++ b/repo-settings.c
@@ -20,6 +20,7 @@ static void repo_cfg_int(struct repository *r, const char *key, int *dest,
 
 void prepare_repo_settings(struct repository *r)
 {
+	const struct repo_settings defaults = REPO_SETTINGS_INIT;
 	int experimental;
 	int value;
 	const char *strval;
@@ -29,13 +30,11 @@ void prepare_repo_settings(struct repository *r)
 	if (!r->gitdir)
 		BUG("Cannot add settings for uninitialized repository");
 
-	if (r->settings.initialized++)
+	if (r->settings.initialized)
 		return;
 
-	/* Defaults */
-	r->settings.index_version = -1;
-	r->settings.core_untracked_cache = UNTRACKED_CACHE_KEEP;
-	r->settings.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE;
+	memcpy(&r->settings, &defaults, sizeof(defaults));
+	r->settings.initialized++;
 
 	/* Booleans config or default, cascades to other settings */
 	repo_cfg_bool(r, "feature.manyfiles", &manyfiles, 0);
diff --git a/repo-settings.h b/repo-settings.h
index ff20a965373..28f95695b3a 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -50,6 +50,11 @@ struct repo_settings {
 
 	int core_multi_pack_index;
 };
+#define REPO_SETTINGS_INIT { \
+	.index_version = -1, \
+	.core_untracked_cache = UNTRACKED_CACHE_KEEP, \
+	.fetch_negotiation_algorithm = FETCH_NEGOTIATION_CONSECUTIVE, \
+}
 
 void prepare_repo_settings(struct repository *r);
 
-- 
2.46.0.421.g159f2d50e7.dirty

