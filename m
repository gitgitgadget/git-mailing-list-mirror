Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148962BCF68
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 10:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752749405; cv=none; b=hJkE0o8NEywq6LgIWpH5nMhIXOFxDjOvrRTWo2GoGOj+L7SnPsahltA6HzCEa/E62sdvo6F14moh+O1ykBlYCjIlkmrYtIJJsDqneJkjCSh6ksqLUL7tipt26Ma5Czv/QmDzrQpX+VHHJB+eKqhzY9QlIqTBBj0mL99+8vmOTys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752749405; c=relaxed/simple;
	bh=oVgl8m6VVg4A+1tO641c271gv8LitDECIPgvlrRxOWs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lfhndef4lwvMAsFq0QGy+gIGO/Mzk0gpzmBEcYm9QExlvdxKYCaz7JWR7pbUA/hQgQx3oJmkdTxXmEaS4UJS1wy27e/FNmXbgcX8JlfaLmB3XWXYpKmf7xdZNYyJxbPsuBitEjXWgmqfwJVqqzljBJRuED0LDh2wn/xb2xxVWbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=ZJTORGFg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oOAEyBN3; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="ZJTORGFg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oOAEyBN3"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 351361D00166
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:03 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Thu, 17 Jul 2025 06:50:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1752749403;
	 x=1752835803; bh=ro24YYeJ/H6v8hYdRgaEtSRs50EQG6N/B/mOUL7W4Oo=; b=
	ZJTORGFgTtXojMZt56i50eab5vGY/hHw3hLJjRitI0aGB40onj8KLYxHKwrGy+1c
	W2hWur7bB6ho1dbN0j45V5/+xvlrHBDvz6m4h+OsxdcFNQogGjR0FAZUuMSKVsMZ
	hRZBLfS5dj9afNGHaahlEhcfUpOq/WwdiTgXhseqRLzLdVxvAW8i3hyw6f2AkZld
	eCHhK9Ys7l5h1rTTJQQY4f5TMgJTnQDAO+3D2n/B+/CEHBmmPSAGddwuNjmRLThO
	jRoivaaipyd7tzfwvqXC3HJGhcVzak/FHpKpkSWw4HppYk0sP141mHnirVg0uw/G
	Kd6tMCLGPfnYhfoMiU9Bww==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1752749403; x=
	1752835803; bh=ro24YYeJ/H6v8hYdRgaEtSRs50EQG6N/B/mOUL7W4Oo=; b=o
	OAEyBN3xTbYn8pH3a8z+vg9Ca6kJ6N0tey1PQTxcJ9Mr80XLM2hgYnZcLUYcwMXI
	so4pm3a+/onPWu1w3mbUg8Ztl4eIg3IkP+xXY4JSZp9bsxUQT2DygkuWyflErG/g
	deS5pMlrCGQpKB+TDMAueyF7gdodLuAq4f77Alo+eTD5j3cqv9ax2+EU6zlXSGYN
	LkYBqvm5UcrpmtPmokodKqr5i5n/RWOZKB+sBy1qZkAVp+ZOy084rb0BITawh9cr
	7QSzPma664Q8dETur0t57Dtll/9xIKtsgJ7FzW5bPKgYu+NTkVj/C3OPT8gI4jUZ
	kS/BxranhEU/iqnEQoG/w==
X-ME-Sender: <xms:WtV4aD8qzkj4YCXKRVp2enRX1YGVvdh0TU0PVcc0aKhAO7Jxi5l9Iw>
    <xme:WtV4aBsC80njF1mCps7FpA8ZEck0szdNTzZ4JqwvICYPkiWw746xAkmHu2NYc03cC
    _WpaRaYr6zkwDwcEg>
X-ME-Received: <xmr:WtV4aKaotZN-0e2BK8nR94Nk3oysC9rRUTjY4RiGJ8b5flt728Z7rpc7ZtdYLcCj0nQLNzdO--0kF3LgWj5iPYKVSDKmLEsdahgu5HGCVYzf>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeitdeflecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephfffufggtgfgkfhfjgfvvefosehtjeertd
    ertdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeffueeiudejvdekheeuvdekfeffiedvueelte
    ekudehjeetkeegvddugfdtgfeileenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedupdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhg
X-ME-Proxy: <xmx:WtV4aBroCijcaxrHXjZ1bbMVGnSnhjWTIJ-lUGNicFlGooGic6CCjA>
    <xmx:WtV4aP8bzx70xg362iOEC8ChCOuOdnXJ7zfQk5zifRH_t1siBouBew>
    <xmx:WtV4aA8PaTHh5RcM-NJyX-MDODiJm7BWAbv-Azn_w9P4kr4N8wM6jQ>
    <xmx:WtV4aOuCqikT-vQm82eGAMZJ0Yq6hYvmBC39XM5dp3WWsXWEBWTnXA>
    <xmx:W9V4aIlHiP6twlPMIib9aZFHPddTzjXBzqmHrZT3BFLQL_ntsklW03DR>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Thu, 17 Jul 2025 06:50:01 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 58164efb (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO)
	for <git@vger.kernel.org>;
	Thu, 17 Jul 2025 10:50:00 +0000 (UTC)
From: Patrick Steinhardt <ps@pks.im>
Date: Thu, 17 Jul 2025 12:49:30 +0200
Subject: [PATCH 10/21] config: drop `git_config_get_ulong()` wrapper
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250717-pks-config-wo-the-repository-v1-10-d888e4a17de1@pks.im>
References: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
In-Reply-To: <20250717-pks-config-wo-the-repository-v1-0-d888e4a17de1@pks.im>
To: git@vger.kernel.org
Cc: 
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
2.50.1.465.gcb3da1c9e6.dirty

