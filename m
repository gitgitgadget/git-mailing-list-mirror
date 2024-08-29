Received: from fout1-smtp.messagingengine.com (fout1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4CD818E341
	for <git@vger.kernel.org>; Thu, 29 Aug 2024 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724924332; cv=none; b=W0IAjXQyfOlcPc3Fw5cuSMANfGYq+ut1y5t55HZl+Q0pJgOh8FnIG8B8QGy4Fd3R+8KWeoK8rQCWDIYGqmveUpeOcYvh1D83ldYnqiElWXzzeC9y49OjKZ6y/5SEdT9Q+pGb1/Tnx73ECmkdLWEP24qSL/bmnjxF2D/LVhJjv+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724924332; c=relaxed/simple;
	bh=JoD51J+JOJqwnkiD/LyF2hQOEb4TAbVQzeoNTbQX55A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bD+fdFnQd2yv4JBlXaLctNi6EIDF4ufyCfyJZhIongpxtCyyWl/8D/7Gol4wBzCowe4gJ4ibrgKNCLysFcni0fOolS/C70ltovZzZ5GRN+TH4CkkeyKYCbT8KEeW44Zd5AAEAVEgFhuo1KdvUJDQYHR9ctDP9/X1S/N2v2eGjvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=k0dwmd5o; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=d/UE44NF; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="k0dwmd5o";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="d/UE44NF"
Received: from phl-compute-04.internal (phl-compute-04.nyi.internal [10.202.2.44])
	by mailfout.nyi.internal (Postfix) with ESMTP id F392A138FC3A;
	Thu, 29 Aug 2024 05:38:49 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 29 Aug 2024 05:38:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1724924329; x=1725010729; bh=OTItF557so
	uhcXA4J1+3V/q03k7S7/YyyAAQEVNCS4U=; b=k0dwmd5ofYkHS4uSxRXDqzGfbd
	yl+1KJUiQEwObCd+9GfEPcJvJZgZfPESEOM/ljGbwYUjk8a/cOtOyanJYPSLUxKQ
	nCbJRXLEdl/PUHvPejbrtK30x7dxsb4bnNh7r0Txv0KM5V+NWZw27nruGNJKdHke
	GF4OuWI1e5UbEDCaQbnlFCmrQlWERT6rBuK86T3ciMoqCfcgIiYHC1MBfAEae8Y4
	5Go31ZWuywMOAqMAGf17Kovi0gr1b1wlwW2in3LEHNdBHlkZ0Fn+XVcqPcLn20iw
	5vo94+kaMSoEF2qGDicAf90d7597ava2303A6Jb0S5NJdNYdlCJwYB2CpY9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1724924329; x=1725010729; bh=OTItF557souhcXA4J1+3V/q03k7S
	7/YyyAAQEVNCS4U=; b=d/UE44NFXWzldCWY1hf+d7WZyr096t3oACCzXv2l75vS
	9g0VyMKRhAshpXePbyjXBl9+N62ddHxKrkSk4SoC1vKU5sVFv3CrLdtyJTq9H8o4
	iTHVzwI8NdCYyRwA0E51CR0erxsEkIqQYsl81ex/DaCDpT/GwIwX3fb3a0I9DRGO
	kvHbxLSHHHgHCU8sxFaZT3Bf9jFVXD0auIp+Dhg2FAWPYA0cdTOSSO2ZG5UjBl5T
	axiVDJAIgbUWhdJGB4j58ps0VEm/zZcRQVqU2WmbmyCvpqgGCqw0fupq8+COYV37
	8FXWEHBWGt5KpqdEl2jjJScB+KMxBXqBapNTK9GNuQ==
X-ME-Sender: <xms:qUHQZppYfNvW2c-zaMkdNSDy5ujlegO8gyNmGN2POOZG3MkaD23nLw>
    <xme:qUHQZroxeq2xgLOpahrZMaf6BvYlU_HZ3-nbao6iaS9YZcLW8MPFUJWIeKFuUiTwm
    7JO7UmV0mGKl3607w>
X-ME-Received: <xmr:qUHQZmOgjMCW8kamE9l9Izx_zzoP5nwUMvUom5nyOjJObmtR6PaXHI78FIoFdWOGkNg5nvgovZJULY64Hk69WWvQ3rHbj_pj2Q8vFAO7FMySbdQ>
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
X-ME-Proxy: <xmx:qUHQZk6oIE5KO83TCH2VsqRLtEvgC1jnE65XUtqI3-TYxQ-nQ9GjJA>
    <xmx:qUHQZo6BSaPxYradHoRCHjUYeRCeza1bXCQZyevFIijI3AXKWmIthA>
    <xmx:qUHQZshZgKTL0ZX9SHb0GfxjDs_Dkbm3HKcKbgjw1eSZjewWUxhBbQ>
    <xmx:qUHQZq57TQKjr8mJXvrUJVnk6fhwbJEzaKKSMAM3aBocKBNj1RMmbg>
    <xmx:qUHQZoHyQVzQf6KhIZ3kVV-TX4Z89cX91mb1jYIr4ILo1X1fAy-5yCCk>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Aug 2024 05:38:49 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 1985bb1e (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 29 Aug 2024 09:38:40 +0000 (UTC)
Date: Thu, 29 Aug 2024 11:38:44 +0200
From: Patrick Steinhardt <ps@pks.im>
To: git@vger.kernel.org
Cc: Calvin Wan <calvinwan@google.com>
Subject: [PATCH 07/21] config: document `read_early_config()` and
 `read_very_early_config()`
Message-ID: <d2f81a540a28fd7944c40d9afd8da5eaa90d4c87.1724923648.git.ps@pks.im>
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

It's not clear what `read_early_config()` and `read_very_early_config()`
do differently compared to `repo_read_config()` from just looking at
their names. Document both of these in the header file to clarify their
intent.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 config.c |  4 ----
 config.h | 11 +++++++++++
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/config.c b/config.c
index 0b87f0f9050..a8357ea9544 100644
--- a/config.c
+++ b/config.c
@@ -2234,10 +2234,6 @@ void read_early_config(config_fn_t cb, void *data)
 	strbuf_release(&gitdir);
 }
 
-/*
- * Read config but only enumerate system and global settings.
- * Omit any repo-local, worktree-local, or command-line settings.
- */
 void read_very_early_config(config_fn_t cb, void *data)
 {
 	struct config_options opts = { 0 };
diff --git a/config.h b/config.h
index d0497157c52..f5fa833cb98 100644
--- a/config.h
+++ b/config.h
@@ -192,7 +192,18 @@ int git_config_from_blob_oid(config_fn_t fn, const char *name,
 void git_config_push_parameter(const char *text);
 void git_config_push_env(const char *spec);
 int git_config_from_parameters(config_fn_t fn, void *data);
+
+/*
+ * Read config when the Git directory has not yet been set up. In case
+ * `the_repository` has not yet been set up, try to discover the Git
+ * directory to read the configuration from.
+ */
 void read_early_config(config_fn_t cb, void *data);
+
+/*
+ * Read config but only enumerate system and global settings.
+ * Omit any repo-local, worktree-local, or command-line settings.
+ */
 void read_very_early_config(config_fn_t cb, void *data);
 
 /**
-- 
2.46.0.421.g159f2d50e7.dirty

