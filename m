Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D155303C97
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 13:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786110943; cv=none; b=onpuRPOse6l7IqVsYAPKXKzUh2z0mC9wn3lCcPjHRtmfo62orqv/BGZRatjYDSD097NBmEpdmaYlw7/jKbWqm5sluUC8H5Y1vyYf5dfD269m7GNQYOys95Msm+ajKIL8yrT7HW2eib0LtBobGQ3D/wDCHgeRrYnS7hEpNnU67wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786110943; c=relaxed/simple;
	bh=bX6VRjNup2SQEHmcCeX+ZGcsHRYRe5HHO7IdLz843Ig=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PNGTWg/aAhm5G2MY2BJuzOftbMry4RcvNfHzJeuYivDOTY4obTWoKwv9CDImMc/PLx4qbmlebzV+tetKQQ1idI0DmeHYmnOStxpEbCO5Jp5MlhsQIBgcjBZs3SAAYwWcdyBUqkixdYGO2mNT1ZkClGLtxHBA39WLcZ6nSmuVAy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PcLgWccb; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PcLgWccb"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-496b7622a83so28954005e9.2
        for <git@vger.kernel.org>; Fri, 07 Aug 2026 06:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786110934; x=1786715734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Eahx2ICGnr48myq3FdvaAXW+bSbAUfrR+q75MH4TL0=;
        b=PcLgWccbXF7hrU+XWEH3EiWd8HDz+XB62vM4HdIftH7VCBsKRafpk9gmAzy0B6gjUJ
         b6ECWi57dQTBdcg4W5AjQDfFmEuAzqxT+6p+vrrB7Hvxq6yZ8VsikXBkwfLSApMgpUUR
         yf1VoxP3aeg9bgdVWEHyRMJD5S609NmAUDNBackbMxVBfkwXrPhSXn29NbA7NsMIguWo
         oAVRM0jQyH5+XLemLKrbaT24kbMG9y+6LT63iwc7hSwqBwaj7bMA9NcoCB/rYbBfyQ5N
         SAjw41j7neNCcN5oOnj6dIR10djF1WsVwOxYJ08NzjVAwVDTEI8iIRXRsKPmblJbs570
         RJdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786110934; x=1786715734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Eahx2ICGnr48myq3FdvaAXW+bSbAUfrR+q75MH4TL0=;
        b=rVbVvta+OheBtiYuVXMP/PIkOhhxID1UjcK0kLYvxTapn7AAb23VliqMPT7yHuBqFB
         4gPdYhMtyZC93pEk2p1rb3W3PR62rxy6VSaZoEiWvUSpvp0ZA1jh35wTWYpJNX5DGQah
         fHSfTvzqilIU1xP7/srQDaMXvAYPiT0bIj+2Hm0rkw25eJh/gz1+ZW9SVb5mPrbwmyU/
         zkvXMWuSaJ47KkCqSCH7q8FtdgJ2Zrmqjy4OHsoqKyzTJfUpRWj+uHUqxZsSR4UQjXgn
         t0gMUT+oTcAmqx7emTzthv1DHapK/tisBj7DuAYHcHKH4nv03e/CGDoAECe23dzs70mJ
         crCw==
X-Gm-Message-State: AOJu0YwoVP8m0t9Ltuj2Nxg8GAXudcypM1kFgpBMi4cqy3i0mZf+Mw2u
	orRPZNTiKKfkyn/bRY93DHJxqnZvlogyHvcWACFvsFz8souUUGMOCXy7Bh7S/Q==
X-Gm-Gg: AR+sD12KYihHezt1yShraBHbHdSjrztUQNTzBifJL+TSUCgUnBPEZnpWaNa41Z4aDPw
	IqNNeDAhmVPbm6R5ljZNWYGaFZkfYD2BFIurg+Q2wyvaFRDeI2DbAjDCJ0TJ1su/wl8Ki9ZyiVb
	cm+om+hJxZ3W7Rsln6QkhFnB7GHU2ue9e/YvXCSqT80M+C30QFcqyOkUKP2DuSIr4oiQdSQ4VD3
	RMvdYKWJ67MImuYE6loexJm2E/tHQ/Hgtg9IgoyT9VhZIctQs/PUQinsk+2NP+FZggmdTHDzmcH
	E3VcnrWh+N5EsMDOgi4i3vH9zo3KdMROyVSGSGW6CnMhoCW0fpn4z8jDD9lNy2iBiRNTt1NYRgS
	0D7vZDozsiUgIRrcA1DdOgngyZOtBBGKm5P4xqZiB1uoRvoQzIN2ObQ2n8RAEj8KHM8SWCo5ZQK
	bUoZRhnzL6H/+HYeHLpPHHIPzRm5n/xPGyyN61qDu0BkzROFEdwyHuRauvZeChEjx0T5pioQeTY
	fX6VFwhq7oBD6Uhlobp0X1nOCztOscKV6iUCvIxU4iL8iofThfdJlnGCX35auCx3EHRmU2eig35
X-Received: by 2002:a7b:c442:0:b0:496:c93d:35d9 with SMTP id 5b1f17b1804b1-4994e733689mr239917495e9.6.1786110934327;
        Fri, 07 Aug 2026 06:55:34 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021ec565sm6094207f8f.22.2026.08.07.06.55.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 06:55:33 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>,
	Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
Date: Fri,  7 Aug 2026 15:55:11 +0200
Message-ID: <20260807135511.1818458-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.530.gdb3615d990.dirty
In-Reply-To: <20260807135511.1818458-1-christian.couder@gmail.com>
References: <20260710085137.4171240-1-christian.couder@gmail.com>
 <20260807135511.1818458-1-christian.couder@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A previous commit added a new "uploadpack.lazyFetchTrusted" protected
config variable that can contain an allowlist of repos, as well as
functions to check if the current repo is in that list. But when the
current repo is in that list, we currently do nothing.

Let's instead set `GIT_NO_LAZY_FETCH` to `0`, which allows
`upload-pack` and its `pack-objects` child process to lazily fetch the
objects they need to serve a client, for example when the filter used
by the client and the one used by the server don't match.

This allows server operators to properly control lazy fetching. It is
their responsibility, not the client's, to decide if the served repo is
trusted, as the main security issue is that lazily fetching runs `git
fetch`, which may execute arbitrary commands specified in the
configuration and hooks of the served repo.

As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
environment, this works for `pack-objects`, which performs the lazy
fetch when serving a client, without any further plumbing.

Now that "uploadpack.lazyFetchTrusted" is actually doing something,
let's document it and reference it from GIT_NO_LAZY_FETCH's docs.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 Documentation/config/uploadpack.adoc  | 42 ++++++++++++++++
 Documentation/git-upload-pack.adoc    |  5 ++
 Documentation/git.adoc                |  4 +-
 builtin/upload-pack.c                 | 11 +++++
 t/t5710-promisor-remote-capability.sh | 70 +++++++++++++++++++++++++++
 5 files changed, 131 insertions(+), 1 deletion(-)

diff --git a/Documentation/config/uploadpack.adoc b/Documentation/config/uploadpack.adoc
index 0e1dda944a..e960879c16 100644
--- a/Documentation/config/uploadpack.adoc
+++ b/Documentation/config/uploadpack.adoc
@@ -86,3 +86,45 @@ uploadpack.allowRefInWant::
 	is intended for the benefit of load-balanced servers which may
 	not have the same view of what OIDs their refs point to due to
 	replication delay.
+
+uploadpack.lazyFetchTrusted::
+	These config entries specify repositories that `upload-pack` is
+	allowed to lazily fetch missing objects for. By default,
+	`upload-pack` refuses to lazily fetch (see the description of the
+	`GIT_NO_LAZY_FETCH` environment variable in
+	linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
+	which may execute arbitrary commands specified in the configuration
+	and hooks of the served repository. Listing a repository here tells
+	`upload-pack` that it is trusted, so lazy fetching from the promisor
+	remotes configured in it is allowed. This is equivalent to setting
+	`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
+	explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this
+	setting.
++
+Note that this allows lazy fetching from any promisor remote
+configured in the served repository, not only from the promisor
+remotes that the client accepted using the "promisor-remote" protocol
+v2 capability (see linkgit:gitprotocol-v2[5]). The served repository
+is trusted as a whole, including its configuration, so the promisor
+remotes it configures are trusted too. It is the server operator's
+responsibility to make sure that the promisor remotes of a trusted
+repository are also trustworthy.
++
+This is a multi-valued setting, i.e. you can add more than one
+repository via `git config (--global|--system) --add`. To reset the
+list of trusted repositories (e.g. to override any such repositories
+specified in the system config), add a `uploadpack.lazyFetchTrusted`
+entry with an empty value.
++
+A repository is identified by its worktree, or its git directory for a bare
+repository, and the value must be an absolute path. Giving a path with `/*`
+appended to it will trust all repositories under the named directory. To trust
+all served repositories, set `uploadpack.lazyFetchTrusted` to the string `*`.
++
+The value of this setting is interpolated, i.e. `~/<path>` expands to a
+path relative to the home directory and `%(prefix)/<path>` expands to a
+path relative to Git's (runtime) prefix.
++
+Note that this configuration variable is only respected when it is specified
+in protected configuration (see <<SCOPES>>). This prevents untrusted
+repositories from tampering with this value.
diff --git a/Documentation/git-upload-pack.adoc b/Documentation/git-upload-pack.adoc
index 9167a321d0..90c2ba1194 100644
--- a/Documentation/git-upload-pack.adoc
+++ b/Documentation/git-upload-pack.adoc
@@ -71,6 +71,11 @@ This is implemented by having `upload-pack` internally set the
 (because you are fetching from a partial clone, and you are sure
 you trust it), you can explicitly set `GIT_NO_LAZY_FETCH` to
 `0`.
++
+Instead of setting `GIT_NO_LAZY_FETCH` to `0` in the environment, a
+server operator can allow lazy fetching on a per-repository basis by
+listing trusted repositories in the `uploadpack.lazyFetchTrusted`
+configuration variable. See linkgit:git-config[1].
 
 SECURITY
 --------
diff --git a/Documentation/git.adoc b/Documentation/git.adoc
index 8a5cdd3b3d..2e763d1f93 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -949,7 +949,9 @@ for full details.
 `GIT_NO_LAZY_FETCH`::
 	Setting this Boolean environment variable to true tells Git
 	not to lazily fetch missing objects from the promisor remote
-	on demand.
+	on demand. On the server side, the `uploadpack.lazyFetchTrusted`
+	configuration variable can control this per-repository. See
+	linkgit:git-upload-pack[1].
 
 `GIT_REFLOG_ACTION`::
 	When a ref is updated, reflog entries are created to keep
diff --git a/builtin/upload-pack.c b/builtin/upload-pack.c
index 32831fb879..8b531ca724 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -42,10 +42,13 @@ int cmd_upload_pack(int argc,
 		OPT_END()
 	};
 	unsigned enter_repo_flags = ENTER_REPO_ANY_OWNER_OK;
+	bool no_lazy_fetch_set;
 
 	packet_trace_identity("upload-pack");
 	disable_replace_refs();
 	save_commit_buffer = 0;
+
+	no_lazy_fetch_set = !!getenv(NO_LAZY_FETCH_ENVIRONMENT);
 	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
 
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
@@ -62,6 +65,14 @@ int cmd_upload_pack(int argc,
 	if (!enter_repo(the_repository, dir, enter_repo_flags))
 		die("'%s' does not appear to be a git repository", dir);
 
+	/*
+	 * Relax the GIT_NO_LAZY_FETCH=1 default if the served repo is in
+	 * the "uploadpack.lazyFetchTrusted" protected allowlist and
+	 * GIT_NO_LAZY_FETCH was not already set explicitly.
+	 */
+	if (!no_lazy_fetch_set && upload_pack_lazy_fetch_trusted(the_repository))
+		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "0", 1);
+
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		if (advertise_refs)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 549acff23f..e6993f2761 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -173,6 +173,76 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
 	initialize_server 1 "$oid"
 '
 
+test_expect_success "clone with uploadpack.lazyFetchTrusted" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
+
+	# The served repo is trusted for lazy fetching
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
+
+	# Clone without GIT_NO_LAZY_FETCH=0
+	git clone --no-local --filter="blob:limit=5k" server client &&
+
+	# Check that the largest object is not missing on the server
+	# This means the server lazy fetched it
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
+test_expect_success "clone without uploadpack.lazyFetchTrusted fails" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
+
+	# Note: no uploadpack.lazyFetchTrusted config is set here, so
+	# the served repo is NOT trusted for lazy fetching.
+
+	# Clone without GIT_NO_LAZY_FETCH=0 fails
+	test_must_fail git clone --no-local --filter="blob:limit=5k" server client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "uploadpack.lazyFetchTrusted is ignored in repo config" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
+
+	# The served repo is trusted for lazy fetching, but this is
+	# done in the repo config, not in protected config, so this is
+	# ignored.
+	test_config -C server uploadpack.lazyFetchTrusted "$(pwd)/server" &&
+
+	# Clone without GIT_NO_LAZY_FETCH=0 fails
+	test_must_fail git clone --no-local --filter="blob:limit=5k" server client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "explicit GIT_NO_LAZY_FETCH overrides uploadpack.lazyFetchTrusted" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
+
+	# The served repo is trusted for lazy fetching
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
+
+	# But GIT_NO_LAZY_FETCH=1 disables lazy fetching, so clone fails
+	test_must_fail env GIT_NO_LAZY_FETCH=1 git clone --no-local \
+		--filter="blob:limit=5k" server client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
 test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.55.0.530.gdb3615d990.dirty

