Received: from mail-wr2-f35.google.com (mail-wr2-f35.google.com [74.125.225.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C264398F5
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 08:23:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790929434; cv=none; b=lQBOvGABHXXTbUbnNNAbODBpjn3w3JIHRukfPcnhnpwGyDMaeJRLdHFLh0959Wkm16rYJxL8fip88uNiNd+vFLSAnMhF479rjfvBAodZyfg2DDJcBi2z2AVvLN9TJDnvZ+UTu3mDhKOnXFcgUL1tNP/yNcgU2QJ0o9hrSuks8eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790929434; c=relaxed/simple;
	bh=4jWAbFdBlwFm6A+giCFa4t2aYuGaFAZhq9A6n+ktS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q0VLhnap5ANoftESO9TJRdLUo6Jfx5w1PuocsNOuIINnaXBHVezuMTQQbYUgZcCljTte/rTnbVmYVUL3TvzGR7yWOOPKMp+3r+VtAuLCgCc0RCIEdIQGrebj6/rvQCik2M+a6qz4+iDwXxf57mvdWCroqQcvQNKNvJxuIcIAKA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YCbiUXtp; arc=none smtp.client-ip=74.125.225.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YCbiUXtp"
Received: by mail-wr2-f35.google.com with SMTP id ffacd0b85a97d-48b05fdb2f9so1738963f8f.0
        for <git@vger.kernel.org>; Fri, 02 Oct 2026 01:23:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790929428; x=1791534228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=58N1uNs4UEiCvwWhxP9UikWHHK4Ak0+zxoHsY/ZCh9Q=;
        b=YCbiUXtpPDb5/zzI4vdeBIQH1yELu/xVENeuUIw339sEib7R2I5D9vp/CzA7a5MWch
         wVl4tEoTeopXhcBeREX8IgLSkjehGkf4xTxJBFW5KX/1DddMtkSDe1uwqKchc9nHnEMY
         /0ED3zq4ii22lZ3FK8jyBWEwxZjaKtxd5MQAGtfjlklz5j32YFE8siYcC/06JtPY0f/8
         X5mOhnWtK1VK/6gTYNDYyO2fL3juseoppHUS/PK4YfS8/f6LoFRdXXcy7ZIilklPGhpf
         hwYo3lvogzIetgEEMSoMsku8mOMdwJQaHzlDjhAsfXKSQc6vyWkh6YBdgnVKV5bgmkms
         YiJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790929428; x=1791534228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=58N1uNs4UEiCvwWhxP9UikWHHK4Ak0+zxoHsY/ZCh9Q=;
        b=1iLEl1Oco2j0fvfGzdpizU1ONo5YcVwmgnmpcLnWNshay6mDUtbaQVzZb0LIJhxJ0X
         4O2ha1rCAL0eNSGxSa9Pzsa73lSoGj71HrZ1iZhHF9d5lvPxV33XPiM8QAxHhG0wtekj
         vmwlzj+UqGjZFCyOj2jxW1Ib6GlbTSKYXlriaSo8VUOpqBZ7q2+7lSX+HQBi0ONB8nh6
         y0LOHYa4gl55ZVep5FF6PJgZOD1hXRQsFxl4Q5EFmsj7XVHc48b7KMEUwZeLPtMYiMp7
         RWok1p6RxQNyRKAqyHA5QrEIae6wXzBd0V76gEK/o5V2Y+UMhxkM3O3lPc1G7nC50+96
         aYGQ==
X-Gm-Message-State: AFq9FYKT9UzOmvemdtm5ZY5GkDusoLjUM66tRttdhazlfGYKeIr9gIfC
	vZdcP0H6AK6PvIOvilUhI3s+YXUPs66U/gyU3t5VBUo9332YWBmQ/IhjmuqS2A==
X-Gm-Gg: AYBFou0CP9tbHyeaKBat3t3Y9LLm0gQnuv2ggPfgrQpA8qBb302NsfygngzvfJaw16J
	6D7rgFM2aYsRRX47yO+LkuRcpOxk2hepvWts/ekPnbb7uUraSCCTqaQn/+ie4kdsejqT57y78S2
	e//xk6tLvK8cVHYP18JAVrDoMYqseYu7KXEk8ZOPmz1iwOYTSjFPtpQgo9F55xItcE1/0solhs2
	JzQBCsJx4x21oa5qbxWXoMyPf+l6noiLdfB2J6q2QK0VrcpwEkU7m0iIK+yInBxEGZrYZqP6ZAp
	gfP+x6Ea8aM8KoDKh3DaDWXKMymI7mDZjc+bL8TYda3qFGMp8yBbg+sjiySQtP5imAPR8gb6vLP
	rfoU8D0d43mPjjKdWMFB6gsA9cRoktdTP++MQv07i3K4l2sL4r7xg9MGLkNL2P21FCx4QoF/97n
	FaCMawN0WrTh4zQtn0kug9zkHFg72qGZNoASn1gnfBSHRqFfIeZXHcMyGAKb4+X/wyT6PfGF0dv
	xWySZ72JFOOC5NqOW8TrPU4uM4hWGEDGa+zJUoRWP/cJ6x92Mnm5/RZiKgjWZBctxISx1vXSoz8
	JM96jWnnNww1M5GAubBUM9jVvraoP/9xKlwZhMiWFrijQpHxuPzzqDUg3wYfevBcnqt8Y1LeOkW
	xgNUewGeC
X-Received: by 2002:a05:6000:178f:b0:488:7927:9ca2 with SMTP id ffacd0b85a97d-48b12726369mr3579277f8f.49.1790929427563;
        Fri, 02 Oct 2026 01:23:47 -0700 (PDT)
Received: from christian--20230123--2G7D3 ([62.35.114.108])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48b382f8ab4sm3905817f8f.35.2026.10.02.01.23.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 01:23:46 -0700 (PDT)
From: Christian Couder <christian.couder@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m . carlson" <sandals@crustytoothpaste.net>,
	Patrick Steinhardt <ps@pks.im>,
	Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v5 5/5] builtin/upload-pack: don't disable lazy fetching on trusted repo
Date: Fri,  2 Oct 2026 10:23:22 +0200
Message-ID: <20261002082322.2682869-6-christian.couder@gmail.com>
X-Mailer: git-send-email 2.56.0.rc2.20.g34f06850c1
In-Reply-To: <20261002082322.2682869-1-christian.couder@gmail.com>
References: <20260928133846.2094261-1-christian.couder@gmail.com>
 <20261002082322.2682869-1-christian.couder@gmail.com>
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

As `pack-objects`, which performs the lazy fetch when serving a
client, is a child process of `upload-pack`, not setting
`GIT_NO_LAZY_FETCH` in `upload-pack` is enough for it to be allowed to
lazily fetch, without any further plumbing.

On the other hand, as we leave `GIT_NO_LAZY_FETCH` unset for a trusted
repo instead of setting it to 0, the trust doesn't propagate: if a
trusted repo lazily fetches from a promisor remote that is itself
served by `upload-pack` on the same machine, that nested `upload-pack`
decides for its own repo. This is unlike when a server operator sets
`GIT_NO_LAZY_FETCH` to 0, as that is inherited by all child processes.

Now that "uploadpack.lazyFetchTrusted" is actually doing something,
let's document it (including this difference with `GIT_NO_LAZY_FETCH`),
let's reference it from `GIT_NO_LAZY_FETCH`'s docs, and let's add tests
for it.

Signed-off-by: Christian Couder <christian.couder@gmail.com>
---
 Documentation/config/uploadpack.adoc  |  57 +++++++
 Documentation/git-upload-pack.adoc    |   9 +-
 Documentation/git.adoc                |   4 +-
 builtin/upload-pack.c                 |  19 ++-
 t/t5710-promisor-remote-capability.sh | 230 ++++++++++++++++++++++++++
 5 files changed, 316 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/uploadpack.adoc b/Documentation/config/uploadpack.adoc
index 0e1dda944a..242a2c485a 100644
--- a/Documentation/config/uploadpack.adoc
+++ b/Documentation/config/uploadpack.adoc
@@ -86,3 +86,60 @@ uploadpack.allowRefInWant::
 	is intended for the benefit of load-balanced servers which may
 	not have the same view of what OIDs their refs point to due to
 	replication delay.
+
+uploadpack.lazyFetchTrusted::
+	A multi-valued configuration variable, each value of which
+	specifies the absolute local path of a repository that
+	`upload-pack` is allowed to lazily fetch missing objects for.
++
+A repository is identified by its git directory, after following any
+`.git` file and resolving symbolic links. That is the repository
+itself if it is bare, the `.git` directory of a repository that has a
+worktree, or the directory that a `.git` file points to, for example
+when the repository was created with `--separate-git-dir` or for a
+linked worktree (see linkgit:git-worktree[1]). So a non-bare
+repository served as `/srv/repo` usually has to be allowlisted as
+`/srv/repo/.git`. Giving a path with `/*` appended to it will trust
+all repositories under the named directory. To trust all served
+repositories, set `uploadpack.lazyFetchTrusted` to the string `*`.
++
+The value of this setting is interpolated, i.e., `~/<path>` expands to
+a path relative to the home directory and `%(prefix)/<path>` expands
+to a path relative to Git's (runtime) prefix.
++
+By default, `upload-pack` refuses to lazily fetch (see the description
+of the `GIT_NO_LAZY_FETCH` environment variable in
+linkgit:git-upload-pack[1]), because doing so would run `git fetch`,
+which may execute arbitrary commands specified in the configuration
+and hooks of the served repository. Listing a repository here tells
+`upload-pack` that it is trusted, so lazy fetching from the promisor
+remotes configured in it is allowed. This is similar to setting
+`GIT_NO_LAZY_FETCH` to `0`, but only for the matching repositories:
+unlike that environment variable, the trust is not inherited by child
+processes. So if a trusted repository lazily fetches from a promisor
+remote that is itself served by `upload-pack` on the same machine,
+for example through a local path or a `file://` URL, lazy fetching is
+allowed there only if that promisor remote is also listed here. An
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
+list of trusted repositories (e.g., to override any such repositories
+specified in the system config), add an `uploadpack.lazyFetchTrusted`
+entry with an empty value.
++
+Note that this configuration variable is only respected when it is
+specified in protected configuration (see <<SCOPES>>). This prevents
+untrusted repositories from tampering with this value.
diff --git a/Documentation/git-upload-pack.adoc b/Documentation/git-upload-pack.adoc
index 9167a321d0..9e3a3fe142 100644
--- a/Documentation/git-upload-pack.adoc
+++ b/Documentation/git-upload-pack.adoc
@@ -70,7 +70,14 @@ This is implemented by having `upload-pack` internally set the
 `GIT_NO_LAZY_FETCH` variable to `1`. If you want to override it
 (because you are fetching from a partial clone, and you are sure
 you trust it), you can explicitly set `GIT_NO_LAZY_FETCH` to
-`0`.
+`0`. As it is an environment variable, it is also inherited by child
+processes, including any `upload-pack` run to lazily fetch from a
+promisor remote on the same machine.
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
index 549acff23f..463e9e00b0 100755
--- a/t/t5710-promisor-remote-capability.sh
+++ b/t/t5710-promisor-remote-capability.sh
@@ -173,6 +173,236 @@ test_expect_success "clone with promisor.acceptfromserver set to 'None'" '
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
+	test_when_finished "rm -rf nonbare nonbare-pack-* client client2" &&
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
+test_expect_success "uploadpack.lazyFetchTrusted needs the git dir a .git file points to" '
+	test_when_finished "rm -rf sepwt sepgit sep-pack-* client client2" &&
+
+	# Create a non-bare repo with a ".git" file pointing to a
+	# separate git dir, without any worktree content, so that its
+	# largest object can be filtered out below
+	git init --separate-git-dir="$(pwd)/sepgit" sepwt &&
+	test_path_is_file sepwt/.git &&
+	git -C sepwt remote add origin "$TRASH_DIRECTORY_URL/template" &&
+	git -C sepwt fetch origin &&
+	git -C sepwt update-ref HEAD FETCH_HEAD &&
+
+	git -C sepwt remote add lop "$TRASH_DIRECTORY_URL/lop" &&
+	git -C sepwt config remote.lop.promisor true &&
+	git -C sepwt config uploadpack.allowFilter true &&
+	git -C sepwt config uploadpack.allowAnySHA1InWant true &&
+	git -C sepwt config promisor.advertise false &&
+
+	# Repack everything, then repack without the largest object and
+	# create a promisor pack, like initialize_server() does
+	git -C sepwt -c repack.writebitmaps=false repack -a -d &&
+	rm -f sepgit/objects/pack/*.promisor &&
+	git -C sepwt -c repack.writebitmaps=false repack -a -d \
+		--filter=blob:limit=5k --filter-to="$(pwd)/sep-pack" &&
+	promisor_file=$(ls sepgit/objects/pack/*.pack | sed "s/\.pack/.promisor/") &&
+	>"$promisor_file" &&
+	check_missing_objects sepwt 1 "$oid" &&
+
+	# The ".git" file does not identify the repo, so it is not
+	# trusted and the clone fails
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/sepwt/.git" &&
+	test_must_fail git clone --no-local --filter="blob:limit=1k" \
+		sepwt client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+	check_missing_objects sepwt 1 "$oid" &&
+
+	# The git dir the ".git" file points to identifies the repo, so
+	# it is trusted and the clone succeeds
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/sepgit" &&
+	git clone --no-local --filter="blob:limit=1k" sepwt client2 &&
+	check_missing_objects sepwt 0 ""
+'
+
+test_expect_success "uploadpack.lazyFetchTrusted trust does not propagate to promisor remotes" '
+	# No promisors are advertised
+	git -C server config promisor.advertise false &&
+	test_when_finished "rm -rf client lop2" &&
+
+	# Create "lop2", a partial clone that is also missing the
+	# largest object, and that can lazily fetch it from "lop"
+	test_config -C template uploadpack.allowFilter true &&
+	git clone --bare --no-local --filter="blob:limit=5k" \
+		"$TRASH_DIRECTORY_URL/template" lop2 &&
+	git -C lop2 remote set-url origin "$TRASH_DIRECTORY_URL/lop" &&
+	git -C lop2 config uploadpack.allowFilter true &&
+	git -C lop2 config uploadpack.allowAnySHA1InWant true &&
+	check_missing_objects lop2 1 "$oid" &&
+
+	# Make "lop2" the only promisor remote of the server. Note that
+	# "remote.lop.partialCloneFilter" also makes "lop" a promisor
+	# remote, so it has to be unset too.
+	git -C server remote add lop2 "$TRASH_DIRECTORY_URL/lop2" &&
+	git -C server config remote.lop2.promisor true &&
+	test_when_finished "git -C server remote remove lop2" &&
+	git -C server config --unset remote.lop.promisor &&
+	test_when_finished "git -C server config remote.lop.promisor true" &&
+	lop_filter="$(git -C server config remote.lop.partialCloneFilter)" &&
+	git -C server config --unset remote.lop.partialCloneFilter &&
+	test_when_finished "git -C server config remote.lop.partialCloneFilter \"$lop_filter\"" &&
+
+	# Only the server is trusted, not "lop2", so the upload-pack
+	# serving "lop2" to the server refuses to lazily fetch from "lop"
+	test_config_global uploadpack.lazyFetchTrusted "$(pwd)/server" &&
+	test_must_fail git clone --no-local --filter="blob:limit=5k" \
+		server client 2>err &&
+	test_grep "lazy fetching disabled" err &&
+	check_missing_objects server 1 "$oid" &&
+	check_missing_objects lop2 1 "$oid" &&
+
+	# Once "lop2" is also trusted, the clone succeeds
+	git config --global --add uploadpack.lazyFetchTrusted "$(pwd)/lop2" &&
+	git clone --no-local --filter="blob:limit=5k" server client &&
+	check_missing_objects server 0 "" &&
+
+	# Reinitialize server so that the largest object is missing again
+	initialize_server 1 "$oid"
+'
+
 test_expect_success "init + fetch with promisor.advertise set to 'true'" '
 	git -C server config promisor.advertise true &&
 	test_when_finished "rm -rf client" &&
-- 
2.56.0.rc2.20.g34f06850c1

