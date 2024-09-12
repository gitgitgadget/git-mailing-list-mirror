Received: from fout2-smtp.messagingengine.com (fout2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF911A4B83
	for <git@vger.kernel.org>; Thu, 12 Sep 2024 11:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726140611; cv=none; b=C7eWb7xX+hgriDnHkBXsgBTijKHhk/tGsN45gxpUDMLtnelOjMSpLb2I3xwuQyZMPsiZl2eD4FU+9qBMHneIvjBeOmuItLO1a/ugnxkCsnOFdeBK94JFHWtwlbS3bJCtLvCnf2UhGTprUynDBuzYtMZhhd9hfB0V7Cuo146gFqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726140611; c=relaxed/simple;
	bh=xTJp0r2uyp7kQmtAtR+uPlL9gzrRdRCdM7TW5oVBjkY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=npY+ABy9TrZTzdk8uH/TvpAJcrmCObOP8jRd3RIHqrhUaBikvfgHwxZ64e0zsNVzRXc2vWkrf42KQJGHEC1z5u2Ivy7bbez2nXu98UCBjcEX5eIW/4GccBEf5a3TeouO0H9Xq8M49d7A74EhoqwHWljuy1J7H+PLX+SZ76yl+MY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=IAnJUK/s; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H1jqtInL; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="IAnJUK/s";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H1jqtInL"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 7CEE61380651;
	Thu, 12 Sep 2024 07:30:09 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Thu, 12 Sep 2024 07:30:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1726140609; x=1726227009; bh=ZSnv6vhaZX
	8OQCDnGZ5JhPacEt+WfvRjvxW3Mx61PXs=; b=IAnJUK/sXf3nRN/q9SJbZSaD9w
	oOd9gXY20gX0KuW+KWgDNcZUU3xQ+/bV1cQw7KH2rcM0GOVEcyYGNyDS2isappMl
	OnsJyxbBx9wjrfOJHCwznGQXqFxu9syEgtJLeIxFSOEXo3dyNKPRvFhXePOc2FN4
	XHdOAP78AHcEjbGlqqnK/hsSXjqR/QiAs7W5kltlyzXy9hK7AZ7vqDh8cMrxXc9P
	KuPcjW0ZP+XPIBEkvIWXJoQArGCf39ewZLFj1F1kDN9h3HKOV2Kc9dwdc+Url6Or
	UhdfEQE1D+6N1KSA9dHO4K62XSCu1HJ3naNt03mOWcwJwh0lImezp8orC3sQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1726140609; x=1726227009; bh=ZSnv6vhaZX8OQCDnGZ5JhPacEt+W
	fvRjvxW3Mx61PXs=; b=H1jqtInLPjLlkFT1uVVxZmdRV3nay0fLP8IETCosK9gV
	9njCp2qXR1UqmGoxKF6MYSj6QZayGxFa45n119REIHccLp+6BUqEUcuYnYrL4lOj
	EEAgESrHVZ9vtDCgzX4tftbslCOF0pce5oQ0QBhVj5mywPFl9eU3XOtZfbJGmCo1
	rGYpDccTZNF6BS3ClTqKvewwoMoYaGgHxixJHIxqbrO3PDI/lemVTyIdg0pMkTYT
	wJ8kcBb0wz8oDxBRz3V9DeuvSIlyUKPcYHfxXkGODiQo2Khzf9bb0LV3PFPoFnAI
	QU4FY1SEW1FSzTOrCJGRHOC+cbeZDdGjGwo4I1A02Q==
X-ME-Sender: <xms:wdDiZtLrLbccQGZVF54X1Ah5KGi_5i_89c0UWi4xopXaDGsMc2EEvw>
    <xme:wdDiZpIw-glh9myqO8APRTZKz27PWAYUZexfTMfi_u71muiH5JGQNKuoIw7DwcQpS
    jpCpiaJ-VuqGzOICw>
X-ME-Received: <xmr:wdDiZlsyImFNTPoECY6TsWYEnoQkZqnf4XVCS--eaMkJAVhL6B43jOv-X1xeYfLmnYqu_Vf2NhZPsFTw-3heLUA-noXo1Pla4bUgh5M5-JDO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrudejfedggedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvden
    ucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimh
    eqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefgueeg
    udfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptggrlhhv
    ihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtgho
    mh
X-ME-Proxy: <xmx:wdDiZuaelK_CL_HX6UbJUKNwsZ_7FqLvNXkHDSYWNyV_mQYJxu67ig>
    <xmx:wdDiZkYQVnU3KHiTar3w9vFVgFbV2TRcwVMLFxJOd52mgmUj6tTiXw>
    <xmx:wdDiZiBusn1usMD3pAB-d1HBiwbpUHFKxA1p7ymkc1AllJ4yJZC2Qw>
    <xmx:wdDiZiY1B4z4e_39rmOsYxZ38AWJ3uOLEXY1VerblnFA6FroDgtNzw>
    <xmx:wdDiZjy7dGgJ03697ygjUG8zBcmrR_Bd7ssNg-KOUbNiGkOoqCDbk99Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Sep 2024 07:30:08 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 3caa263e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 12 Sep 2024 11:29:59 +0000 (UTC)
Date: Thu, 12 Sep 2024 13:30:07 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>, Justin Tobler <jltobler@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	karthik nayak <karthik.188@gmail.com>
Subject: [PATCH v3 15/21] repo-settings: track defaults close to `struct
 repo_settings`
Message-ID: <7a74c8d8a8d640c2f0784984da93813c34fe3982.1726139990.git.ps@pks.im>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1726139990.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1726139990.git.ps@pks.im>

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
2.46.0.551.gc5ee8f2d1c.dirty

