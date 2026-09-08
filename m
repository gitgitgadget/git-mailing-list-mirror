Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E04DF583AAB
	for <git@vger.kernel.org>; Tue,  8 Sep 2026 16:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788885725; cv=none; b=FcXxecfEIXB+U9KLlbEPdCbQ9YJDABAmfMLQ5R/dNnwSZQO9huiHGA6pi24THWLNAh82kNBa8rpFNJU7BABXaSNj6dYIvTRJxHTpyFNh1Y9vn3mILSPpRb17tiKNJ0K354NiAwhC2mkmTKDNpIRSagSgOC0S0fUNf9vOsW6HQNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788885725; c=relaxed/simple;
	bh=FF9jJhHgFSicJeqIEvk43cZMbxspy4rTFhMws8ypcws=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TpkD39Vhc8cM3PixwYiezldfh53cgBxfrnxBevS5IItRyyA/4vjmAziPZfQG2CDeHNO54bkNsFOAtKjZpOo91rJzvOQXMvDCTUWiUPDuPG0UPhm0kPp+PXPgWUEurYJ2BjDiWtCaD8m8qc5UYw12pAeuJczjwdxrzOjIOff9hGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kiJBerqS; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kiJBerqS"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49557167508so57646785e9.1
        for <git@vger.kernel.org>; Tue, 08 Sep 2026 09:42:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788885721; x=1789490521; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2bP/NC4FmGA1+r6YhbO+CXAwHzRW8N9hZWHHDUsyQE=;
        b=kiJBerqShaPZuZq7sh2Ugj+yxM1ZpU9YgGpDd6qmhCiLRL1TZpcVNOn9u4e6wqpOe8
         jqzsRqRkjVfEC4+bYZNLrnlasJeLgeiHcHMAyT5NeSIelKj90ja8AFEREfqZtDTzLIl9
         fCXi/uH82WzHWlXmeAzHQ3tZ/ls62J/3LNxton4WrHcD7VbfPUfjIAeQQzChG1Nmtl3p
         cFaELy1RsLIsgDM06//ihXDwcL38gSPRjJi30QeU2lF04CmHv1tRqMV9pJF9Ec88oCIS
         T85HYlSOwIt0kO+YbzHMJHiYsAjgGE1hDL8WyRZYOKglAAsH9oVKiz0ujwFwIjRPCM6P
         HW/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788885721; x=1789490521;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2bP/NC4FmGA1+r6YhbO+CXAwHzRW8N9hZWHHDUsyQE=;
        b=h056eHcAMUZnAlKL4/ziLWN2ILrLxXAQh83IporLY6maScvG4D2gxPwIcGIVeOSgeM
         Cr1Ey+Ra+tW1+Elo58aex/mpk4Defx00q98l5W0xH3pNY9Ic//nF2EaPvplTDq7nOF1x
         Ls8fBw77GuI60279onGF9fwLaKCLmPwIXecRCDi3E6ByPyY50DE04kBWsPU1mcDxy3NJ
         F2Dg1RyWdVuIR7+WlPG7KDvt+hEFm7klWyUHgsAvumpiV9bHpokJjHOBaQA9W486WOdt
         3deEPy/eGactVq1nHWEAF603RWIqMRsm225SbRnjOFsKmA4jkd8OZSnSR/g+q+0edIv7
         k/iA==
X-Gm-Message-State: AFuF++mvsKmxKgCrZJwAjZLK5vMEBJ3ft5iSTxHh9qP6QXxVzxi7q9KV
	PJYTIl4kw14N9Bm5KOV503q4pknz36GIOf2BVT94uhzuXofflwJDqXGKcdYZ3AjC
X-Gm-Gg: AYBFou1iQdJmbAWxNbTBxOhZ5+c1KEtnisE+ixW7Lc8r61Mvt2rvmBhGb6jbI0tRO0d
	Qn6DXC3fLBf4SVn56qrQGiNEjIiW4ICJ0V1i9ZAvv30ODEra9wIZS6TfL5QVfI6LJuCFn7QhWpn
	jpWHD1VoLh8Si8zsmu7jIrObTy+77Bgvxuqsg2ZwDoje/VXxQE9YCy8SQgMW77X1qZ8XNq/OFO6
	uYqgFZgn8TLD2vNNtykgYovGgxEfVyBPq/302lUviDxpgHokpdu1U6W3HGTB4F467BMDREgQ3LW
	fW2HD6gHRAANVn9EDdMfO0uGN5X4Uu7fn64xZvu3ium9tjiE0SLNFwz122w8SeifQg+LkOh5pJh
	r60zwGIfq18P12w9f9ooLGoltRn9PAZ7Sfu54tXpEcP5wNSIsfwCE4bgP4+yGLlfSW2229AZmkB
	EoNxS0FCP1e18JcafHhVIXPF8ZfmtyOGmQGSB1+ZgBgUaBxVfVQASnuJb8lwB1+myLy/dxdQvAZ
	WBkYQ7xLCqy0GIwc8sJ6DUtodWZWUHyjwJ1JcpUPPafkrE+u8sRxZkSutr9xgza6gJhF1mqtSKY
	i9XHInRGsJFY9mzBgUpsX3QjLjEWEraKCNaHpdlDKNw0VrDZOcfL16SQaeYqireel9C7rSeF9hs
	=
X-Received: by 2002:a05:600c:3485:b0:49c:cee0:e7c1 with SMTP id 5b1f17b1804b1-49cf825c119mr668232965e9.16.1788885720821;
        Tue, 08 Sep 2026 09:42:00 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48591eb3d3bsm24081689f8f.0.2026.09.08.09.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 09:42:00 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 5/5] builtin/upload-pack: set GIT_NO_LAZY_FETCH to 0 on trusted repo
Date: Tue,  8 Sep 2026 18:41:29 +0200
Message-ID: <20260908164129.560396-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.55.0.792.ged91fccac1.dirty
In-Reply-To: <20260908164129.560396-1-christian.couder@gmail.com>
References: <20260813154748.2378747-1-christian.couder@gmail.com>
 <20260908164129.560396-1-christian.couder@gmail.com>
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

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/config/uploadpack.adoc  |  49 +++++++++
 Documentation/git-upload-pack.adoc    |   5 +
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  11 ++
 t/t5710-promisor-remote-capability.sh | 142 ++++++++++++++++++++++++++
 5 files changed, 210 insertions(+), 1 deletion(-)

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
2.55.0.792.ged91fccac1.dirty

