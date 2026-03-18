Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB3C355F3B
	for <git@vger.kernel.org>; Wed, 18 Mar 2026 20:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773866443; cv=none; b=GVCJrH5YfKGuiPD3gl2zjDfeNkUyxFErZTcQpV0FLj3Sw5o52Bs9KSVpiJpDsgUlhdRqN/wK2v1AFzq4sPKTNRDR1hszc1B0ku9MXvpwP+tLhncHWrLKusFAADSEzReK3AezxX3NAaBxip1JI4uq1331EkzDrb5H0xjBQa64+hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773866443; c=relaxed/simple;
	bh=xbk7EUaO1ogXpPXaxE42NIwTTHzpL+arnvYkxPifASY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VSKHz40Zt2YTwoAdllMo4Vgu5qn0WJUV2krEAyKSQJdzgR/UwSDOaJDcJnggkn3lWPG8h9G2SlWSCNTyZa/lsmQiT/bjAjYA94C0qiMC62b87kf6Uiq5x/d2Jp1q6Kcz8huCQ0+4VaeLP/qurcCw3g4DgviUUmrhIs1sR/cZEvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4mxxMU8; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4mxxMU8"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c74280e3468so135876a12.3
        for <git@vger.kernel.org>; Wed, 18 Mar 2026 13:40:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773866440; x=1774471240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sghRWRozezwW/UltGuxzMsZ6/y740SA1BQiWmLGdvVQ=;
        b=J4mxxMU8iFR+qXmgqB4WQH9Jm6fsj66ZZBeOLUPzgb4XFsxVr2AZjP6f7//oJFrNIy
         5EZQoj5+vAR0p9cF9x/ytVEqqcjIjzzv1s2/lOWg3aPH0g1hi0wNDq2Fw2shsm0cjk3Z
         wq0XJBS8fMPtZs/i002E0VbbcDgg9YH6+cOrOPkYHYrOUOnz/ilj8gh32ZHmQ/1cDTbV
         zphZ7P2d44AOyIELbRVS+xybc9KI9CRkDRNu9zgNR5w8qJ5WvPpm+a/Ccda/bvzgfquy
         rbA7RpC9Hu5bqHdG3Jopte7cjs8BNCRBZuozngP6HCVXKfNGW0klg4hwahUQ7LNmkmqc
         H5xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773866440; x=1774471240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sghRWRozezwW/UltGuxzMsZ6/y740SA1BQiWmLGdvVQ=;
        b=tUZJVlrjVHl6t+YVt/N4FQUhBGAA5sM8AQRpndzUjX7td+gTivYLY12QE3KIn/1LNf
         +Q6gd+OBvV/mjYwkLnnB4VWp66A767vWDHbieLh25V5avdjJr+b2OWEtCbk3st70T7Wg
         vEdNxaHECIgJhe70sukY9PvlB4Pn2rXw2bRwQgiMPLsmVjjNevr4mtbd0NeXZzxuuMgV
         phi5xpVm6StyGZtA45GIFPih944vQgjU+X4J0PtUFQ/gdo9eLV4ZnfaALv8MGT4pVd6Q
         mVUvHbBPXT4vgT3dAojxoZ6khyWjLYKIBblwXS0nfh2/LtcQyP/Qeu+LevA1iRKcupOg
         jrNw==
X-Gm-Message-State: AOJu0YxCJrZIWl1ZUzIQibu6NZ2n/7xIUvSw6a/yhQj5AMJrbeTo29Rt
	3/znJuumBfLMoP4nFRbfOe+lyMS7JJ9inQAqRe71/ojv81cIGvT8zLu9JMD5M20a
X-Gm-Gg: ATEYQzyq8OL4TJ9pJOmkDYsTGRnoHvOCN6JAxiwDnnCZz2ssv8CGTaGB/ws3IM091we
	x8DlpZE/s7Evx0KkMqEKwxWYmy+jq8BrW4NIHwYLoYo2hm79itJCz6k0e41XlQYlesqNnk7paaX
	F3bZuqc6E4nN+Q51vm1cEaadORfuPAzN+d2N9xVbrZ12OnoUlh9BL0FjIu5yeG0tOSyQ3litZ+z
	oiMz3zhsTk4tKU0wg6Rg6lENUylxb9/3xshuwof1AepVFunCAhc70Af7iXTAGt5pu2c6sSeTf0L
	yxRBzgbZakkAnPHI9WixPngVTKRPMV4r6eJi3W4S+Pw2V6FNiSREtXRfTAHLhaBNsk81/eNX5tX
	ONYzdGfksjnTPqIm3+ilNPQqAvfTkANQJgArC+71L6quzg/0IWD6cqC9sk+P41rSoOAnRoLhAXh
	I3nxcosk8tbRGsEHUfJZvpcFBBk28NhB5gMg16MDZPlFmcdxAgQ9G0KDa2Qek=
X-Received: by 2002:a05:6a21:693:b0:398:6b26:dbfb with SMTP id adf61e73a8af0-39b99fdad0dmr4367526637.49.1773866440254;
        Wed, 18 Mar 2026 13:40:40 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a6bbb96e4sm4428567b3a.35.2026.03.18.13.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 13:40:39 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: git@vger.kernel.org,
	gitster@pobox.com
Cc: usmanakinyemi202@gmail.com,
	christian.couder@gmail.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v2 2/2] push: support pushing to a remote group
Date: Thu, 19 Mar 2026 02:10:28 +0530
Message-ID: <20260318204028.1010487-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
References: <20260305223248.170785-1-usmanakinyemi202@gmail.com>
 <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

`git fetch` accepts a remote group name (configured via `remotes.<name>`
in config) and fetches from each member remote. `git push` has no
equivalent — it only accepts a single remote name.

Teach `git push` to resolve its repository argument through
`add_remote_or_group()`, which was made public in the previous patch,
so that a user can push to all remotes in a group with:

    git push <group>

When the argument resolves to a single remote the behaviour is
identical to before. When it resolves to a group, each member remote
is pushed in sequence.

The group push path rebuilds the refspec list (`rs`) from scratch for
each member remote so that per-remote push mappings configured via
`remote.<name>.push` are resolved correctly against each specific
remote. Without this, refspec entries would accumulate across iterations
and each subsequent remote would receive a growing list of duplicated
entries.

Mirror detection (`remote->mirror`) is also evaluated per remote using
a copy of the flags, so that a mirror remote in the group cannot set
TRANSPORT_PUSH_FORCE on subsequent non-mirror remotes in the same group.

A known interaction: push.default = simple will die when the current
branch has no upstream configured, because setup_default_push_refspecs()
requires an upstream for that mode. Users pushing to a group should set
push.default = current or supply explicit refspecs. This is consistent
with how fetch handles default refspec resolution per remote.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/git-push.adoc |  76 +++++++++++++++++++---
 builtin/push.c              | 124 ++++++++++++++++++++++++++----------
 t/meson.build               |   1 +
 t/t5566-push-group.sh       |  95 +++++++++++++++++++++++++++
 4 files changed, 254 insertions(+), 42 deletions(-)
 create mode 100755 t/t5566-push-group.sh

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e5ba3a6742..1a3c309002 100644
--- a/Documentation/git-push.adoc
+++ b/Documentation/git-push.adoc
@@ -18,17 +18,28 @@ git push [--all | --branches | --mirror | --tags] [--follow-tags] [--atomic] [-n
 
 DESCRIPTION
 -----------
-
-Updates one or more branches, tags, or other references in a remote
-repository from your local repository, and sends all necessary data
-that isn't already on the remote.
+Updates one or more branches, tags, or other references in one or more
+remote repositories from your local repository, and sends all necessary
+data that isn't already on the remote.
 
 The simplest way to push is `git push <remote> <branch>`.
 `git push origin main` will push the local `main` branch to the `main`
 branch on the remote named `origin`.
 
-The `<repository>` argument defaults to the upstream for the current branch,
-or `origin` if there's no configured upstream.
+You can also push to multiple remotes at once by using a remote group.
+A remote group is a named list of remotes configured via `remotes.<name>`
+in your git config:
+
+	$ git config remotes.all-remotes "origin gitlab backup"
+
+Then `git push all-remotes` will push to `origin`, `gitlab`, and
+`backup` in turn, as if you had run `git push` against each one
+individually.  Each remote is pushed independently using its own
+push mapping configuration. There is a `remotes.<group>` entry in
+the configuration file. (See linkgit:git-config[1]).
+
+The `<repository>` argument defaults to the upstream for the current
+branch, or `origin` if there's no configured upstream.
 
 To decide which branches, tags, or other refs to push, Git uses
 (in order of precedence):
@@ -55,8 +66,10 @@ OPTIONS
 _<repository>_::
 	The "remote" repository that is the destination of a push
 	operation.  This parameter can be either a URL
-	(see the section <<URLS,GIT URLS>> below) or the name
-	of a remote (see the section <<REMOTES,REMOTES>> below).
+	(see the section <<URLS,GIT URLS>> below), the name
+	of a remote (see the section <<REMOTES,REMOTES>> below),
+	or the name of a remote group
+	(see the section <<REMOTE-GROUPS,REMOTE GROUPS>> below).
 
 `<refspec>...`::
 	Specify what destination ref to update with what source object.
@@ -430,6 +443,53 @@ further recursion will occur. In this case, `only` is treated as `on-demand`.
 
 include::urls-remotes.adoc[]
 
+[[REMOTE-GROUPS]]
+REMOTE GROUPS
+-------------
+
+A remote group is a named list of remotes configured via `remotes.<name>`
+in your git config:
+
+	$ git config remotes.all-remotes "r1 r2 r3"
+
+When a group name is given as the `<repository>` argument, the push is
+performed to each member remote in turn.  The defining principle is:
+
+	git push <options> all-remotes <args>
+
+is exactly equivalent to:
+
+	git push <options> r1 <args>
+	git push <options> r2 <args>
+	...
+	git push <options> rN <args>
+
+where r1, r2, ..., rN are the members of `all-remotes`.  No special
+behaviour is added or removed — the group is purely a shorthand for
+running the same push command against each member remote individually.
+
+This means the user is responsible for ensuring that the sequence of
+individual pushes makes sense.  For example, if `push.default = simple`
+is set and the current branch has no upstream configured, then
+`git push r1` may fail.  `git push all-remotes` will fail in the same
+way, on whichever member remote triggers the condition first.  Setting
+`push.default = current` or supplying explicit refspecs is recommended
+when pushing to a remote group.
+
+Similarly, if `--force-with-lease` is given without an explicit expected
+commit, Git will guess the expected commit for each remote independently
+from that remote's own remote-tracking branch, the same way it would if
+each push were run separately.  If an explicit commit is given with
+`--force-with-lease=<refname>:<expect>`, that same value is forwarded
+to every member remote, as if each of
+`git push --force-with-lease=<refname>:<expect> r1`,
+`git push --force-with-lease=<refname>:<expect> r2`, ...,
+`git push --force-with-lease=<refname>:<expect> rN` had been invoked.
+
+Each member remote is pushed using its own push mapping configuration
+(`remote.<name>.push`), so a refspec that maps differently on r1 than
+on r2 is resolved correctly for each one.
+
 OUTPUT
 ------
 
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..33de769a33 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -542,7 +542,6 @@ static int git_push_config(const char *k, const char *v,
 
 	return git_default_config(k, v, ctx, NULL);
 }
-
 int cmd_push(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -551,12 +550,13 @@ int cmd_push(int argc,
 	int flags = 0;
 	int tags = 0;
 	int push_cert = -1;
-	int rc;
+	int rc = 0;
+	int base_flags;
 	const char *repo = NULL;	/* default repository */
 	struct string_list push_options_cmdline = STRING_LIST_INIT_DUP;
+	struct string_list remote_group = STRING_LIST_INIT_DUP;
 	struct string_list *push_options;
 	const struct string_list_item *item;
-	struct remote *remote;
 
 	struct option options[] = {
 		OPT__VERBOSITY(&verbosity),
@@ -619,39 +619,45 @@ int cmd_push(int argc,
 	else if (recurse_submodules == RECURSE_SUBMODULES_ONLY)
 		flags |= TRANSPORT_RECURSE_SUBMODULES_ONLY;
 
-	if (tags)
-		refspec_append(&rs, "refs/tags/*");
-
 	if (argc > 0)
 		repo = argv[0];
 
-	remote = pushremote_get(repo);
-	if (!remote) {
-		if (repo)
-			die(_("bad repository '%s'"), repo);
-		die(_("No configured push destination.\n"
-		    "Either specify the URL from the command-line or configure a remote repository using\n"
-		    "\n"
-		    "    git remote add <name> <url>\n"
-		    "\n"
-		    "and then push using the remote name\n"
-		    "\n"
-		    "    git push <name>\n"));
-	}
-
-	if (argc > 0)
-		set_refspecs(argv + 1, argc - 1, remote);
-
-	if (remote->mirror)
-		flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
-
-	if (flags & TRANSPORT_PUSH_ALL) {
-		if (argc >= 2)
-			die(_("--all can't be combined with refspecs"));
-	}
-	if (flags & TRANSPORT_PUSH_MIRROR) {
-		if (argc >= 2)
-			die(_("--mirror can't be combined with refspecs"));
+	if (repo) {
+		if (!add_remote_or_group(repo, &remote_group)) {
+			/*
+			 * Not a configured remote name or group name.
+			 * Try treating it as a direct URL or path, e.g.
+			 *   git push /tmp/foo.git
+			 *   git push https://github.com/user/repo.git
+			 * pushremote_get() creates an anonymous remote
+			 * from the URL so the loop below can handle it
+			 * identically to a named remote.
+			 */
+			struct remote *r = pushremote_get(repo);
+			if (!r)
+				die(_("bad repository '%s'"), repo);
+			string_list_append(&remote_group, r->name);
+		}
+	} else {
+		struct remote *r = pushremote_get(NULL);
+		if (!r)
+			die(_("No configured push destination.\n"
+			    "Either specify the URL from the command-line or configure a remote repository using\n"
+			    "\n"
+			    "    git remote add <name> <url>\n"
+			    "\n"
+			    "and then push using the remote name\n"
+			    "\n"
+			    "    git push <name>\n"
+			    "\n"
+			    "To push to multiple remotes at once, configure a remote group using\n"
+			    "\n"
+			    "    git config remotes.<groupname> \"<remote1> <remote2>\"\n"
+			    "\n"
+			    "and then push using the group name\n"
+			    "\n"
+			    "    git push <groupname>\n"));
+		string_list_append(&remote_group, r->name);
 	}
 
 	if (!is_empty_cas(&cas) && (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES))
@@ -661,10 +667,60 @@ int cmd_push(int argc,
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(flags, push_options, remote);
+	/*
+	 * Push to each remote in remote_group. For a plain "git push <remote>"
+	 * or a default push, remote_group has exactly one entry and the loop
+	 * runs once — there is nothing structurally special about that case.
+	 * For a group, the loop runs once per member remote.
+	 *
+	 * Mirror detection and the --mirror/--all + refspec conflict checks
+	 * are done per remote inside the loop. A remote configured with
+	 * remote.NAME.mirror=true implies mirror mode for that remote only —
+	 * other non-mirror remotes in the same group are unaffected.
+	 *
+	 * rs is rebuilt from scratch for each remote so that per-remote push
+	 * mappings (remote.NAME.push config) are resolved against the correct
+	 * remote. iter_flags is derived from a clean snapshot of flags taken
+	 * before the loop so that a mirror remote cannot bleed
+	 * TRANSPORT_PUSH_FORCE into subsequent non-mirror remotes in the
+	 * same group.
+	 */
+	base_flags = flags;
+	for (int i = 0; i < remote_group.nr; i++) {
+		int iter_flags = base_flags;
+		struct remote *r = pushremote_get(remote_group.items[i].string);
+		if (!r)
+			die(_("no such remote or remote group: %s"),
+			    remote_group.items[i].string);
+
+		if (r->mirror)
+			iter_flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+
+		if (iter_flags & TRANSPORT_PUSH_ALL) {
+			if (argc >= 2)
+				die(_("--all can't be combined with refspecs"));
+		}
+		if (iter_flags & TRANSPORT_PUSH_MIRROR) {
+			if (argc >= 2)
+				die(_("--mirror can't be combined with refspecs"));
+		}
+
+		refspec_clear(&rs);
+		rs = (struct refspec) REFSPEC_INIT_PUSH;
+
+		if (tags)
+			refspec_append(&rs, "refs/tags/*");
+		if (argc > 0)
+			set_refspecs(argv + 1, argc - 1, r);
+
+		rc |= do_push(iter_flags, push_options, r);
+	}
+
 	string_list_clear(&push_options_cmdline, 0);
 	string_list_clear(&push_options_config, 0);
+	string_list_clear(&remote_group, 0);
 	clear_cas_option(&cas);
+
 	if (rc == -1)
 		usage_with_options(push_usage, options);
 	else
diff --git a/t/meson.build b/t/meson.build
index 6d91470ebc..eb123f456a 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -697,6 +697,7 @@ integration_tests = [
   't5563-simple-http-auth.sh',
   't5564-http-proxy.sh',
   't5565-push-multiple.sh',
+  't5566-push-group.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
diff --git a/t/t5566-push-group.sh b/t/t5566-push-group.sh
new file mode 100755
index 0000000000..9e0d378f2a
--- /dev/null
+++ b/t/t5566-push-group.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+
+test_description='push to remote group'
+
+. ./test-lib.sh
+
+test_expect_success 'setup' '
+	for i in 1 2 3
+	do
+		git init --bare dest-$i.git &&
+		git -C dest-$i.git symbolic-ref HEAD refs/heads/not-a-branch ||
+		return 1
+	done &&
+	test_tick &&
+	git commit --allow-empty -m "initial" &&
+	git config set remote.remote-1.url "file://$(pwd)/dest-1.git" &&
+	git config set remote.remote-1.fetch "+refs/heads/*:refs/remotes/remote-1/*" &&
+	git config set remote.remote-2.url "file://$(pwd)/dest-2.git" &&
+	git config set remote.remote-2.fetch "+refs/heads/*:refs/remotes/remote-2/*" &&
+	git config set remote.remote-3.url "file://$(pwd)/dest-3.git" &&
+	git config set remote.remote-3.fetch "+refs/heads/*:refs/remotes/remote-3/*" &&
+	git config set remotes.all-remotes "remote-1 remote-2 remote-3"
+'
+
+test_expect_success 'push to remote group pushes to all members' '
+	git push all-remotes HEAD:refs/heads/main &&
+	j= &&
+	for i in 1 2 3
+	do
+		git -C dest-$i.git for-each-ref >actual-$i &&
+		if test -n "$j"
+		then
+			test_cmp actual-$j actual-$i
+		else
+			cat actual-$i
+		fi &&
+		j=$i ||
+		return 1
+	done
+'
+
+test_expect_success 'push second commit to group updates all members' '
+	test_tick &&
+	git commit --allow-empty -m "second" &&
+	git push all-remotes HEAD:refs/heads/main &&
+	for i in 1 2 3
+	do
+		git -C dest-$i.git rev-parse refs/heads/main >hash-$i ||
+		return 1
+	done &&
+	test_cmp hash-1 hash-2 &&
+	test_cmp hash-2 hash-3
+'
+
+test_expect_success 'push to single remote in group does not affect others' '
+	test_tick &&
+	git commit --allow-empty -m "third" &&
+	git push remote-1 HEAD:refs/heads/main &&
+	git -C dest-1.git rev-parse refs/heads/main >hash-after-1 &&
+	git -C dest-2.git rev-parse refs/heads/main >hash-after-2 &&
+	! test_cmp hash-after-1 hash-after-2
+'
+
+test_expect_success 'push to nonexistent group fails with error' '
+	test_must_fail git push no-such-group HEAD:refs/heads/main
+'
+
+test_expect_success 'push explicit refspec to group' '
+	test_tick &&
+	git commit --allow-empty -m "fourth" &&
+	git push all-remotes HEAD:refs/heads/other &&
+	for i in 1 2 3
+	do
+		git -C dest-$i.git rev-parse refs/heads/other >other-hash-$i ||
+		return 1
+	done &&
+	test_cmp other-hash-1 other-hash-2 &&
+	test_cmp other-hash-2 other-hash-3
+'
+
+test_expect_success 'mirror remote in group with refspec fails' '
+	git config set remote.remote-1.mirror true &&
+	test_must_fail git push all-remotes HEAD:refs/heads/main 2>err &&
+	grep "mirror" err &&
+	git config unset remote.remote-1.mirror
+'
+test_expect_success 'push.default=current works with group push' '
+	git config set push.default current &&
+	test_tick &&
+	git commit --allow-empty -m "fifth" &&
+	git push all-remotes &&
+	git config unset push.default
+'
+
+test_done
-- 
2.53.0

