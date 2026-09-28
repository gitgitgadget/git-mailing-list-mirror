Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9117F4C900D
	for <git@vger.kernel.org>; Mon, 28 Sep 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790602759; cv=none; b=avzjlrXDyapW2L5Hu50MmCok3IOyUXdJ5dmBbp67h30M4bZ/2G7Pv9FCdRlQ+C8caJTiD4O9H/9a4MhS7WOATgIMvY4T1s3vLYDrZPPgU6uNRbVjOeVfLIazxhwZ2JIM8xdtIlgsO10VzZzzvcY3i77T4Dhx2+Yl+AW1TXhqEKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790602759; c=relaxed/simple;
	bh=sMytx2KAP/v/p2gFHKgLr4zxNxD+7zIkNQRL1dASNuo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLXdm1BUozRPdXYPzTir37X9FJuc1FAJ7QPbC2GkvN4o6pCmNmABeAixv48X82IucE8t/COSncMKJR6qVr41D8Lk1fh7lA5+RvU5vLCc1IWWDxwma1SJjvoESDL8x+v/Br6UGgCKE7rV1EQqi4COonKXVYkeL2VtdLBVCOW9Xms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VXVgbf9T; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VXVgbf9T"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-482f6350f91so1777037f8f.1
        for <git@vger.kernel.org>; Mon, 28 Sep 2026 06:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790602754; x=1791207554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vRcf0NJMlMkf2pP0xUrXSbWRIwJw9cBOOhRXJEvqAP0=;
        b=VXVgbf9TJSN1MQ6/wrfIms8JcqmBU1V+CISlbBgpJV690iTGTnyAjcUDYVoqSRC3BF
         NzMatGRx50Lz5KUjwBJBkj10c4jqvB97uJ9YuwJVnYfVq7DboSkTNgEW7yZmOIDveRbL
         yrQo/DZ91hqyYYTLLUiAok6ZBQFXPoJGwHfQpCmnZaSBq2PJcUPUKajudCW5r/TYVXjl
         HFP8CfcdEnSqblmeWYEwGbEkFJ9xHf+BSnSIqrmuz8r7opCqeKGrjoxWd91zCRMs/TjI
         fkofq13IZ+2l5xBhJxaEMUm52hg3p8UyOGSMdH8WnVOq10bYo/reC+hPjy0/MtX1SsYM
         FivQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790602754; x=1791207554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vRcf0NJMlMkf2pP0xUrXSbWRIwJw9cBOOhRXJEvqAP0=;
        b=iQcxV2LQdbnIJJew2myZ2Z8W8BOyn3Mql0hNrOZPipDzG5GGafrKnxbbCn+5LUXeNd
         vTciJYhkPT4eaHoGyWblMk5QZixPdGpRh/FkEZjcvElUK1cJTZR1toVmNu0CaPtPisbB
         2jijPrAvBWkr0NIb16U2qbl+BHO2dgCS73nsrALZ37klEfw7tkCWrM80XhWHgOBPiGhy
         BvVJdqHLM9TIBK9LOdtQiuTHt3QSWys8xQjUoxB2Rt/Vn9eQA0dJjyZv2PYjDk6w7BKG
         vqSuThbjKXQcs3HY9ZZlLtNROufw9ApU9oHkz9sBr052pycZPG308TTNd/dDiNnnzMi0
         Sjzg==
X-Gm-Message-State: AFuF++nR8BJD42BqvkasliqpF+sPcxsyMRyc4J1JaZCns5v1KQVeppI9
	B/EDuWMR4KEG4BE8bNV5bDgLVBCZZNJ9xwdHOLs9BxwMirhrJpD5iF4D8w7WFg==
X-Gm-Gg: AYBFou1ZveT1suwzux6kMEpa7eApasRu/FmO2S025+nUSpRrz0UoV8VjcU4w7NOPpJ5
	qoOjTq8BtVQHzw242lAotXZsl19BB/crS+jePBiMGEq0NpWGLD+avzPxyjpw78I3PL2GxeS+k7Y
	jU2yS6EaQW8WxDZAdCIIuFtL2NlkXTOmCaa2jWw0yk+XzDGtBL/DleiCCpdgkDcsZUPw1VPzVsK
	fLy35+vtXHMoOVAgP4oVEeANMH/4wfNjDN3Xo76S4Ke910RNJJOS961Lb0h11FslC033JnOUIqq
	bOh6wsLZFt0pgAAg/5zfQGl1NC+Iul9eR0rW4Uc2ktWzqv+gsbhDXHzGHXrDBsDDYqFWllue7zw
	58sMkd5EpnISy31x4xPf5Aklbtk7VfDgM4c87q4v07zlyhbmN/I2YeEkxniasK84K1tJJpQQvR8
	y8iFia92eXREt4bv37If5EQj+ky27VskzT/KcdUBx02VlzejBHtB2tMNb+me2H17Xf5XVfRhFCj
	Az/KvCIaWVocutDRNliA93iE4TPh447k3JLncH3nBNgvEWWvGLkMPKCmmdmRyrkmE2E9KK3VWXu
	u1DA9Lw7SetZcd0AcO42stoQYNWb+mufvSd72tToTYHS58PCJCTLvZdA3345FecLgDm8zGcCl0r
	ghaorsggW
X-Received: by 2002:a05:600d:15a:20b0:49f:f963:7093 with SMTP id 5b1f17b1804b1-49ff9637122mr86013905e9.23.1790602754338;
        Mon, 28 Sep 2026 06:39:14 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00c0730a8sm5554505e9.0.2026.09.28.06.39.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 06:39:13 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 5/5] builtin/upload-pack: don't disable lazy fetching on trusted repo
Date: Mon, 28 Sep 2026 15:38:46 +0200
Message-ID: <20260928133846.2094261-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20260928133846.2094261-1-christian.couder@gmail.com>
References: <20260908164129.560396-1-christian.couder@gmail.com>
 <20260928133846.2094261-1-christian.couder@gmail.com>
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

Since 7b70e9efb1 (upload-pack: disable lazy-fetching by default,
2024-04-16), `upload-pack` sets `GIT_NO_LAZY_FETCH` to 1 itself,
unconditionally, because by default it shouldn't trust the repositories
it serves. Lazily fetching runs `git fetch`, which may execute
arbitrary commands specified in the configuration and hooks of the
served repo.

The new "uploadpack.lazyFetchTrusted" protected config variable is not
about overriding an environment variable. It's rather about teaching
the code that automatically sets `GIT_NO_LAZY_FETCH` (because it had no
way to know if the served repo could be trusted) to look at the new
config variable to find out if a server operator actually vouched for
that repo.

Let's implement that, so we now have the following cases:

  - if `GIT_NO_LAZY_FETCH` is already set, we honor it and leave it
    alone, as it comes from the server operator,

  - otherwise, if the served repo is in the
    "uploadpack.lazyFetchTrusted" allowlist, we don't disable lazy
    fetching,

  - otherwise, we disable lazy fetching, as we used to.

This allows `upload-pack` and its `pack-objects` child process to
lazily fetch the objects they need to serve a client, for example when
the filter used by the client and the one used by the server don't
match.

Note that what a server operator vouches for by listing a repo there
is that the promisor remotes this repo is configured to lazily fetch
from, as well as its configuration and hooks, are trustworthy. Whether
a client trusts the repo it fetches from is a separate matter, and up
to the client.

As `GIT_NO_LAZY_FETCH` is passed down to child processes through the
environment, this works for `pack-objects`, which performs the lazy
fetch when serving a client, without any further plumbing.

Now that "uploadpack.lazyFetchTrusted" is actually doing something,
let's document it and reference it from GIT_NO_LAZY_FETCH's docs.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/config/uploadpack.adoc  |  49 +++++++++
 Documentation/git-upload-pack.adoc    |   5 +
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  19 +++-
 t/t5710-promisor-remote-capability.sh | 142 ++++++++++++++++++++++++++
 5 files changed, 217 insertions(+), 2 deletions(-)

diff --git a/Documentation/config/uploadpack.adoc b/Documentation/config/uploadpack.adoc
index 0e1dda944a..e143de93aa 100644
--- a/Documentation/config/uploadpack.adoc
+++ b/Documentation/config/uploadpack.adoc
@@ -86,3 +86,52 @@ uploadpack.allowRefInWant::
 	is intended for the benefit of load-balanced servers which may
 	not have the same view of what OIDs their refs point to due to
 	replication delay.
+
+uploadpack.lazyFetchTrusted::
+	A multi-valued configuration variable, each of which contains the
+	absolute local path of a repository that `upload-pack` is allowed to
+	lazily fetch missing objects for.
++
+A repository is identified by its git directory, i.e. the `.git`
+directory of a repository that has a worktree, or the repository itself
+if it is bare. So a non-bare repository served as `/srv/repo` has to be
+allowlisted as `/srv/repo/.git`. Giving a path with `/*` appended to it
+will trust all repositories under the named directory. To trust all
+served repositories, set `uploadpack.lazyFetchTrusted` to the string
+`*`.
++
+The value of this setting is interpolated, i.e. `~/<path>` expands to a
+path relative to the home directory and `%(prefix)/<path>` expands to a
+path relative to Git's (runtime) prefix.
++
+By default, `upload-pack` refuses to lazily fetch (see the description
+of the `GIT_NO_LAZY_FETCH` environment variable in
+linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
+which may execute arbitrary commands specified in the configuration
+and hooks of the served repository. Listing a repository here tells
+`upload-pack` that it is trusted, so lazy fetching from the promisor
+remotes configured in it is allowed. This is equivalent to setting
+`GIT_NO_LAZY_FETCH` to `0` for the matching repositories. An
+explicitly set `GIT_NO_LAZY_FETCH` takes precedence over this setting.
++
+Note that this allows lazy fetching from any promisor remote
+configured in the served repository, not only from the promisor
+remotes that the client accepted using the "promisor-remote" protocol
+v2 capability (see linkgit:gitprotocol-v2[5]). The served repository
+is trusted as a whole, including its configuration, so the promisor
+remotes it configures are trusted too. It is the server operator's
+responsibility to make sure that the promisor remotes of a trusted
+repository are also trustworthy. In particular, a trusted repository
+should not be configured as its own promisor remote, as `upload-pack`
+would then try to lazily fetch missing objects from the repository
+itself, which is pointless.
++
+As this is a multi-valued setting, you can add more than one
+repository via `git config (--global|--system) --add`. To reset the
+list of trusted repositories (e.g. to override any such repositories
+specified in the system config), add an `uploadpack.lazyFetchTrusted`
+entry with an empty value.
++
+Note that this configuration variable is only respected when it is
+specified in protected configuration (see <<SCOPES>>). This prevents
+untrusted repositories from tampering with this value.
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
index 6f0075f918..ff78ce6eec 100644
--- a/Documentation/git.adoc
+++ b/Documentation/git.adoc
@@ -952,7 +952,9 @@ for full details.
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
index 32831fb879..53e76deb23 100644
--- a/builtin/upload-pack.c
+++ b/builtin/upload-pack.c
@@ -46,7 +46,6 @@ int cmd_upload_pack(int argc,
 	packet_trace_identity("upload-pack");
 	disable_replace_refs();
 	save_commit_buffer = 0;
-	xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 0);
 
 	argc = parse_options(argc, argv, prefix, options, upload_pack_usage, 0);
 
@@ -62,6 +61,24 @@ int cmd_upload_pack(int argc,
 	if (!enter_repo(the_repository, dir, enter_repo_flags))
 		die("'%s' does not appear to be a git repository", dir);
 
+	/*
+	 * Lazily fetching while serving a client would run `git fetch`,
+	 * which may execute arbitrary commands from the configuration
+	 * and hooks of the served repo, so we disable it by default as
+	 * we trust nobody. There are two ways for a server operator to
+	 * allow it though:
+	 *
+	 *   - if GIT_NO_LAZY_FETCH is already set, we leave it alone and
+	 *     honor whatever the operator put there,
+	 *
+	 *   - otherwise, if the served repo is in the
+	 *     "uploadpack.lazyFetchTrusted" protected allowlist, we
+	 *     don't disable lazy fetching.
+	 */
+	if (!getenv(NO_LAZY_FETCH_ENVIRONMENT) &&
+	    !upload_pack_lazy_fetch_trusted(the_repository))
+		xsetenv(NO_LAZY_FETCH_ENVIRONMENT, "1", 1);
+
 	switch (determine_protocol_version_server()) {
 	case protocol_v2:
 		if (advertise_refs)
diff --git a/t/t5710-promisor-remote-capability.sh b/t/t5710-promisor-remote-capability.sh
index 549acff23f..62f4b56006 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -173,6 +173,148 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
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
+test_expect_success "trusted repo as its own promisor remote does not recurse" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client" &&
+
+	# Add itself as its own remote
+	git -C server remote add self "$TRASH_DIRECTORY_URL/server" &&
+	git -C server config remote.self.promisor true &&
+	test_when_finished "git -C server remote remove self" &&
+
+	# Make "self" the only promisor remote of the server, so that it
+	# cannot get the missing object from "lop". Note that
+	# "remote.lop.partialCloneFilter" also makes "lop" a promisor
+	# remote, so it has to be unset too.
+	git -C server config --unset remote.lop.promisor &&
+	test_when_finished "git -C server config remote.lop.promisor true" &&
+	lop_filter="$(git -C server config remote.lop.partialCloneFilter)" &&
+	git -C server config --unset remote.lop.partialCloneFilter &&
+	test_when_finished "git -C server config remote.lop.partialCloneFilter \"$lop_filter\"" &&
+
+	# Allow lazy fetching from itself
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
+
+	# Check that lazy fetching fails
+	test_must_fail git clone --no-local --filter="blob:limit=5k" server client 2>err &&
+	test_grep "too many nested lazy fetches" err &&
+
+	# Check that the largest object is still missing on the server
+	check_missing_objects server 1 "$oid"
+'
+
+test_expect_success "uploadpack.lazyFetchTrusted needs the git dir of a non-bare repo" '
+	test_when_finished "rm -rf nonbare client client2" &&
+
+	# Create a non-bare repo, without any worktree content, so that
+	# its largest object can be filtered out below
+	git init nonbare &&
+	git -C nonbare remote add origin "$TRASH_DIRECTORY_URL/template" &&
+	git -C nonbare fetch origin &&
+	git -C nonbare update-ref HEAD FETCH_HEAD &&
+
+	git -C nonbare remote add lop "$TRASH_DIRECTORY_URL/lop" &&
+	git -C nonbare config remote.lop.promisor true &&
+	git -C nonbare config uploadpack.allowFilter true &&
+	git -C nonbare config uploadpack.allowAnySHA1InWant true &&
+	git -C nonbare config promisor.advertise false &&
+
+	# Repack everything, then repack without the largest object and
+	# create a promisor pack, like initialize_server() does
+	git -C nonbare -c repack.writebitmaps=false repack -a -d &&
+	rm -f nonbare/.git/objects/pack/*.promisor &&
+	git -C nonbare -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=5k --filter-to="$(pwd)/nonbare-pack" &&
+	promisor_file=$(ls nonbare/.git/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	>"$promisor_file" &&
+	check_missing_objects nonbare 1 "$oid" &&
+
+	# The worktree path does not identify the repo, so it is not
+	# trusted and the clone fails
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/nonbare" &&
+	test_must_fail git clone --no-local --filter="blob:limit=1k" \
+		nonbare client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+	check_missing_objects nonbare 1 "$oid" &&
+
+	# The git dir identifies the repo, so it is trusted and the
+	# clone succeeds
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/nonbare/.git" &&
+	git clone --no-local --filter="blob:limit=1k" nonbare client2 &&
+	check_missing_objects nonbare 0 ""
+'
+
 test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.56.0.rc2.20.g34f06850c1

