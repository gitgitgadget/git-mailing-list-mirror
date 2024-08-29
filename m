Received: from fhigh5-smtp.messagingengine.com (fhigh5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC8318DF88
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924364; cv=none; b=sLh062M4a8R1FIWodWktL8CcLpQuATf5MtVpg+HH/Mx/phnY94cRrqWvp/sqvfhS22D1S9RTTz9EWKbnwRAvNixz2AMkcSHrOkCIRt9Cfhgcwy3tU2fxZBh6QgUI6Xm3Jvx9uoFN0MPrUKp+SProhdG/gADhzkZdGCbpByD8qow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924364; c=relaxed/simple;
	bh=QhOmx/aIXGPfrHSFpaXz6bF1jBsWQW2M4ag8Rwp1bkg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eUo84muSe+5XExZgth42vRgZCft/G6CH4oShLq5p4Z9VkQx5s2Dg2tD4XcD/8VU7fAO5rbBmBsG0CNDejLPgOZIbbFutH+2qfGcZOvlhFX8muchxC4feQkiFFERg9WZE9SQPVDc9Yt2MbTOSyzDGztHAo/2fmAbl+Fsfbk0egfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Mgi8fiUj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=miAXi8HY; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Mgi8fiUj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="miAXi8HY"
Received: from phl-compute-02.internal (phl-compute-02.nyi.internal [10.202.2.42])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 23756114AB22;
	Thu, 29 Aug 2024 05:39:22 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 29 Aug 2024 05:39:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924362; x=1725010762; bh=7DhmpHsQgE
	H8ppZupZ/aV81ATaprt7JBx1niZUk91U8=; b=Mgi8fiUjjrTzokqwMtvwX5IEBa
	ua17sF5rpc1NHn0EU4m80E+qSGOGavJuzDR3gcPekt7oOt7FvrGF7juEcTFmLzW6
	XoNaOHZF2BB6l7Y4hvL0QCtE/RQ3lJV/lg1sSN6y5aaGU6oTc1WztsQb0kUIwnZM
	c+jQwlk1F0rmuEFJVQwROVM9qLdAXqN0SiXdFBM/+z1Evl8djPdqftiJRQ4VYl8X
	UKBKahowJuUDCWCmbNvp1LbLiJ6twQTyWGXH8fR5ETB7nIXnC8IRd2WWvBnLi/O3
	pzWxxTiNuWhehb077KWGy1IAN8JT0ozVYzcHtV428+KPlpm1BH+rztHJWCwg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924362; x=1725010762; bh=7DhmpHsQgEH8ppZupZ/aV81ATapr
	t7JBx1niZUk91U8=; b=miAXi8HYUNV/HRNn8+igeukoAnrq2WV8AuP0NdeGTUQ/
	zM7Xs2+lLiUBXEZbHz0u4SbIsbzKmFyEpTu90I9cPgUHi+GJ/KPmlKBRKhnGqhrO
	YefFRO/BUJsvpBqjz6UvtBGMgm0HfmndSi8un7S1xtQ5uILKiNrO9qnTpIdvJSii
	jbCU7/DKxxfkWpLmJq2lBOzFIZ5/ljLwhh3XAn8rB+rpokG2P3JPGzaWP71F43Fh
	+gNY8Wh8tn90Cup3tuEQl+VBlx53Ht/B+RDi6APHJ4BgoojlF851yXnw5stJExeS
	7MHtHcRyw/dOoGb7OjSqDFeMgOatuD9tFKdt6dgE1A==
X-ME-Sender: <xms:ykHQZnKXPM8iabqHMbMieIzyRjcB7gKaZknX_8ooe_y-sqKU71ip_g>
    <xme:ykHQZrID620YGfHRV1zQfaBYF22NfPOae3EPnF-fYPvPF6alskMTw1KiFQjUlcIce
    oLmjcTePPUZ18F0UQ>
X-ME-Received: <xmr:ykHQZvvW2q1FMV6xL3aQJRPIjTUUG7NiUb-StECFlww7I6A_b2jboXYeGV5WUwRSmZ6QO9Z64-ZbwLKOibRZIe7mEcoUtl1v5EQDoXdT-zpVCoY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudefgedgudekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegtrghlvhhinhifrghnsehgohhoghhlvgdrtghomh
X-ME-Proxy: <xmx:ykHQZgZ3msFaQhrZIegBQWXAhBICG-P7z_laOmyrcup-mXu-baW6YA>
    <xmx:ykHQZubVf18FLkMJioa7-6m-P02fkGvV0jiMetRe2IPROryLvbQOAQ>
    <xmx:ykHQZkBTiahMKvABM0p7eWkvieHYlh3yADWschd78ujU1ZsRLtzENQ>
    <xmx:ykHQZsaD4dQyxc1H4l1ahBmjtFM9jM1boLhxnqpJSeGeWzr_Ecou9w>
    <xmx:ykHQZtl5XTZUTrHIhU43tVhozCUwMlCuUvIWqJPTYQrR2aApXnF-zrqv>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:39:21 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 01e51b30 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:39:12 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:39:18 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 17/21] repo-settings: track defaults close to `struct
 repo_settings`
Message-ID: <d22209121ceaa192dc80260838c77343c2d6f124.1724923648.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1724923648.git.ps@pks.im>

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
index 736968490a3..d03b6e57f0c 100644
--- a/repo-settings.h
+++ b/repo-settings.h
@@ -57,6 +57,11 @@ struct repo_settings {
 
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

