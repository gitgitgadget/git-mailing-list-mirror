Received: from fhigh-a4-smtp.messagingengine.com (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE4A2EF665
	for <git@vger.kernel.org>; Wed, 23 Jul 2025 14:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753279744; cv=none; b=dCm6B7YgUbROo6SAS30cWeSBtV649wsF+tJr+OEkwyfHPNmyjUhSzZ4nAd0OXUfewJfpmtIxwquQYS6HDn8lMzUYzZHw2l+jGyNrrUcf/nlNSq7Xy4cHJllJ8PXKFJc7BdYUwRCsCsb08SFWFX8+X5nvW8cFWATZSO/3p+HyohQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753279744; c=relaxed/simple;
	bh=qtd82yWh5NHWIDulb7W5YIUP9wr8Dr2CeJ6zYLpKY8g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=daK485gHUdBaKhoj4tP8/pDP8vhiPG4BZvE5vJeDFm/v+PBg6BAf3Uu54coyFK0s5/+JpbX9Sq3kkmMrofXWZPcAK5zg6yNMukih362gZDTkltgVjnhtpPPlzBRC1tlvEh51w2p3OOBxYHuDrjJb9Q2ItCXGND25RxZyyOuSLZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZPmn1+Pz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vt990ljw; arc=none smtp.client-ip=103.168.172.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZPmn1+Pz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vt990ljw"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A2BB61401EFC;
	Wed, 23 Jul 2025 10:09:01 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Wed, 23 Jul 2025 10:09:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1753279741;
	 x=1753366141; bh=bDzN0/Z/Sp61aHQhqrcP8JFQ1vCA8sMGRzGozw7jn60=; b=
	ZPmn1+Pz9MJ7JhssBKS56R+9VHEyJ5MGW0QE63qp38/36X05YpGspCRJeFoXy6WP
	VlXdzY9PCrPesl3NiG96FD2rlJwK1gKgtsSWMBFkvP5SeCCWqZURQ/U3DNJlFvDO
	FyXWJLuMvg1wI/D9GwksO85KUPURz8maehtca2nK0Nv+v9kyCkiN17H5MysTBLgF
	sz5e/aEDpHpq+gXdtXv4e2NFVFCPpXDgYKZRF7MDjj6kY6sjKxgZLNlPsZrWu0PI
	l5n1Z2dcQbcTvhPPsHWAAuipXB/NQP5YLp68nsWpVikcZBWaWc9Le6KmNV8r/Ofn
	Ka4CuSBlYwVDdMxY5G4B/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1753279741; x=
	1753366141; bh=bDzN0/Z/Sp61aHQhqrcP8JFQ1vCA8sMGRzGozw7jn60=; b=V
	t990ljwawYCryj3iyh1myOrg7zXo8jnOg7p7hcpofX/eTigT/YHRD+/Hg6zkZk+x
	I0HAxd4LIxJdQBTsGrgtNPgKdLzz6qNF/wSehU+C5MFo9HlPcLDPC/6lAJ86s+6u
	KSTNQk5toySvIgMToTuRScNEDecW0m+7p+rqjGHHBuATsyMFxDzxSejLvmaqaavu
	/MF0fThbZKG55a1DyM2pHOqxLZsheLy3URv7Ljmq2E5bdYuoTSmUYY/gIEN5Lgph
	WWePGWno2/mRLT95EeqTKzEbMPIcbb8LiRB7wezqC2GCXDl2XavkYjLIAhfqy7Tq
	VpVhv37GTQQw1cOgVjanA==
X-ME-Sender: <xms:_eyAaCiUlE8OYpB33zVfYYXrqAao9qvJDaqFzZqFpF5HFNGp77lENw>
    <xme:_eyAaDP7h9jHpkGraEfyLX2QN0rx_F8hjzfKgjKybUvoD8tPDXLmN_AO-BnN0Xas0
    F6_Tilcn8wSwaWavw>
X-ME-Received: <xmr:_eyAaL4PdFIb50hc7WkTJKdQW53_CH1OsjCF06rS3D36UBuZtFSmjRQ4bSugzBle7VeP4OeNRmVwMWbpe2WD_UKuWkCflvDYK2KOxqeKp3I6>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdejjeeljecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhfffugggtgffkfhgjvfevofesthejredtredtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epffeuiedujedvkeehuedvkeefffeivdeuleetkeduheejteekgedvudfgtdfgieelnecu
    vehluhhsthgvrhfuihiivgepvdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehphhhilhhlih
    hprdifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:_eyAaJ3lfZKhwSC3rCfeExaa6uagQBbozNAD5Xiiiw5aYcG6xR4Jyg>
    <xmx:_eyAaEa9OeylUQaa-6-Lnx8ahB4VFjJNDFiuFy2nnUJ2gVZBa0Fs6A>
    <xmx:_eyAaJAtv4Bx-fJkRszTB1yWdpVPao_6z2N5I8Zm138rD14Nt-Lm-A>
    <xmx:_eyAaO-95yY-CkKnt52ppZ1MGj5btpH8nLVZp5hAJjqBHWXWc5VLUg>
    <xmx:_eyAaHwjLNzfTPxW4WNnHHL4IiJs_-C3KmEZBdFAzBP4OT2RBNIucP_I>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 23 Jul 2025 10:09:00 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 5b9cb797 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Wed, 23 Jul 2025 14:09:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Wed, 23 Jul 2025 16:08:31 +0200
Subject: [PATCH v2 10/21] config: drop `git_config_get_ulong()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250723-pks-config-wo-the-repository-v2-10-1502d60d3867@pks.im>
References: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
In-Reply-To: <20250723-pks-config-wo-the-repository-v2-0-1502d60d3867@pks.im>
To: git@vger.kernel.org
Cc: Phillip Wood <phillip.wood123@gmail.com>
X-Mailer: b4 0.14.2

In 036876a1067 (config: hide functions using `the_repository` by
default, 2024-08-13) we have moved around a bunch of functions in the
config subsystem that depend on `the_repository`. Those function have
been converted into mere wrappers around their equivalent function that
takes in a repository as parameter, and the intent was that we'll
eventually remove those wrappers to make the dependency on the global
repository variable explicit at the callsite.

Follow through with that intent and remove `git_config_get_ulong()`. All
callsites are adjusted so that they use
`repo_config_get_ulong(the_repository, ...)` instead. While some
callsites might already have a repository available, this mechanical
conversion is the exact same as the current situation and thus cannot
cause any regression. Those sites should eventually be cleaned up in a
later patch series.

Signed-off-by: Patrick Steinhardt <ps@pks.im>
---
 builtin/fast-import.c |  4 ++--
 builtin/gc.c          | 10 +++++-----
 config.h              |  5 -----
 http-backend.c        |  2 +-
 4 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 9b0ae437148..a3f7f14f4fe 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -3523,7 +3523,7 @@ static void git_pack_config(void)
 	int limit;
 	unsigned long packsizelimit_value;
 
-	if (!git_config_get_ulong("pack.depth", &max_depth)) {
+	if (!repo_config_get_ulong(the_repository, "pack.depth", &max_depth)) {
 		if (max_depth > MAX_DEPTH)
 			max_depth = MAX_DEPTH;
 	}
@@ -3533,7 +3533,7 @@ static void git_pack_config(void)
 			git_die_config(the_repository, "pack.indexversion",
 				       "bad pack.indexVersion=%"PRIu32, pack_idx_opts.version);
 	}
-	if (!git_config_get_ulong("pack.packsizelimit", &packsizelimit_value))
+	if (!repo_config_get_ulong(the_repository, "pack.packsizelimit", &packsizelimit_value))
 		max_packsize = packsizelimit_value;
 
 	if (!repo_config_get_int(the_repository, "fastimport.unpacklimit", &limit))
diff --git a/builtin/gc.c b/builtin/gc.c
index cf175b8f1b7..d15daf59625 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -195,7 +195,7 @@ static void gc_config(struct gc_config *cfg)
 	repo_config_get_int(the_repository, "gc.autopacklimit", &cfg->gc_auto_pack_limit);
 	git_config_get_bool("gc.autodetach", &cfg->detach_auto);
 	git_config_get_bool("gc.cruftpacks", &cfg->cruft_packs);
-	git_config_get_ulong("gc.maxcruftsize", &cfg->max_cruft_size);
+	repo_config_get_ulong(the_repository, "gc.maxcruftsize", &cfg->max_cruft_size);
 
 	if (!repo_config_get_expiry(the_repository, "gc.pruneexpire", &owned)) {
 		free(cfg->prune_expire);
@@ -212,10 +212,10 @@ static void gc_config(struct gc_config *cfg)
 		cfg->gc_log_expire = owned;
 	}
 
-	git_config_get_ulong("gc.bigpackthreshold", &cfg->big_pack_threshold);
-	git_config_get_ulong("pack.deltacachesize", &cfg->max_delta_cache_size);
+	repo_config_get_ulong(the_repository, "gc.bigpackthreshold", &cfg->big_pack_threshold);
+	repo_config_get_ulong(the_repository, "pack.deltacachesize", &cfg->max_delta_cache_size);
 
-	if (!git_config_get_ulong("core.deltabasecachelimit", &ulongval))
+	if (!repo_config_get_ulong(the_repository, "core.deltabasecachelimit", &ulongval))
 		cfg->delta_base_cache_limit = ulongval;
 
 	if (!repo_config_get_string(the_repository, "gc.repackfilter", &owned)) {
@@ -2344,7 +2344,7 @@ static int launchctl_schedule_plist(const char *exec_path, enum schedule_priorit
 		die(_("failed to create directories for '%s'"), filename);
 
 	if ((long)lock_file_timeout_ms < 0 &&
-	    git_config_get_ulong("gc.launchctlplistlocktimeoutms",
+	    repo_config_get_ulong(the_repository, "gc.launchctlplistlocktimeoutms",
 				 &lock_file_timeout_ms))
 		lock_file_timeout_ms = 150;
 
diff --git a/config.h b/config.h
index 2490c47daaf..e22c07a4488 100644
--- a/config.h
+++ b/config.h
@@ -719,11 +719,6 @@ NORETURN void git_die_config_linenr(const char *key, const char *filename, int l
 int lookup_config(const char **mapping, int nr_mapping, const char *var);
 
 # ifdef USE_THE_REPOSITORY_VARIABLE
-static inline int git_config_get_ulong(const char *key, unsigned long *dest)
-{
-	return repo_config_get_ulong(the_repository, key, dest);
-}
-
 static inline int git_config_get_bool(const char *key, int *dest)
 {
 	return repo_config_get_bool(the_repository, key, dest);
diff --git a/http-backend.c b/http-backend.c
index ad8c4037493..3d5d5a84646 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -247,7 +247,7 @@ static void http_config(void)
 	struct strbuf var = STRBUF_INIT;
 
 	git_config_get_bool("http.getanyfile", &getanyfile);
-	git_config_get_ulong("http.maxrequestbuffer", &max_request_buffer);
+	repo_config_get_ulong(the_repository, "http.maxrequestbuffer", &max_request_buffer);
 
 	for (i = 0; i < ARRAY_SIZE(rpc_service); i++) {
 		struct rpc_service *svc = &rpc_service[i];

-- 
2.50.1.552.g942d659e1b.dirty

