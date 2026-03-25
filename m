Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCDB3126D7
	for <git@vger.kernel.org>; Wed, 25 Mar 2026 19:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774465761; cv=none; b=Z/7hENMXqRMHqpFkqnqJxMpMRiLwnwsu5upxcJrI8i8rIS0hpS+6dH5hCVCUSWqurEEjoaEo6ETm/mIXgjh05kYqASTXuJfHe6s0JTJOsnkdRG6uf2LjSNlbpswCH7YpmnGd7o2lOHd5d5RtsGXuECXfoMxfLE7JNftb+ziZCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774465761; c=relaxed/simple;
	bh=XvdkGAYQW8504XVlDFK3y+NejTSs9uqn/rqA0/p6YTo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JVr46WZLIrZMR/TafvoxI74NhkiuLOIworUdnlqQHAAPyarnUmyyTTD4xNBOphMe7CLjV0X9+yQt85DHAQ/mVeQDcJM6NeoFm4WqHtfkAWd0B6EWQlGHBPXCNmJO4+dRbvOr0r6ZTiXVt/Wbir5/+MIQ2npwi47DGKzv1kLlJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q6h3W6yM; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q6h3W6yM"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-35c16db1b53so129165a91.1
        for <git@vger.kernel.org>; Wed, 25 Mar 2026 12:09:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774465759; x=1775070559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aDv0sWVOt6xlDZz9EN2AHRWJ7XHcLeq9mrPNf/IZ9u0=;
        b=Q6h3W6yMYJlePkiTGZfOi0FyUwgiBMEk3iMx7fMhpbAJFlXE64eJDpHLGDLTqXQMms
         1Y8NtXEt7RWF3g3V7vjlBLV7RERZZMhOQTZygW0CbcVrEJPQhi0N6HtAeluiUEGMfs7G
         jcft+LUFw0HeyEWXe44xsYZ0G5A2DDCcaUN3c1ntdBMExbFLHm5IAWkV03IN+0jw4Trq
         bzHvnXA7Dce41Wy2WqbiDQx3ej3XyjQWy2as/WfPUvWEzHeZi8n+se5IsXYQ2n67CvdZ
         oaoexcJK/h5Qb1rNdphxHTyd4G/sVIO3QbKozjLCWBRCA2eAVu1CLUZeLHPiHUEdenf9
         eU0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774465759; x=1775070559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aDv0sWVOt6xlDZz9EN2AHRWJ7XHcLeq9mrPNf/IZ9u0=;
        b=KtXRbJn0g97NyFqTxi3CzTgelBODG3gNiVQYLDB2/JQC7O2+QCqZqduWPwgpWA8Nu4
         +krOLTZnTaxN4kHZJ0vVTv3RZMbR8VvYdU9uq+mLKrG2IU7xjlqmiwWio2putaAUGvLr
         c9HI8jaVdhDRZsaPCmvBduU1TqulCGWAD/Ad6zYjsJMLE5DvGoKagzEXl1Qhy9pw58KC
         U5JcpsK2eHv9AhE3jrOue62J14y83illURMMA08xAVqaNj21OSNghvkchqGm21MvzKMJ
         Ox2IewpVfecRYbFqfwnRtbAJZIfS+QGwgvbQXrT4FJ68lsBuok58RQOBM4/Iv9/ri/rX
         JIxg==
X-Forwarded-Encrypted: i=1; AJvYcCVgWOZQtmYnzuEt+pU10gIBKhlOmk2y4axCDJXqpAs3dcs5Pi6p6OdeSsMZPv3uNhCOqV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQp+3Jv5PL0CWWJy8xlYXoLSQTscSjaCH1Zqdi9jzdhZ+qf5ml
	1WC8z8tyNaMiW1sqhdG3zE+sJ1Cc2Vw5sB7U5IC7YSOIhsxJZ99OZ5Bm
X-Gm-Gg: ATEYQzx5ZT4Vonz5t1pLi+BNmN8Ec52R0L9XvfstKzjTZJLV7LMmA/iD1F/YaLG6K+v
	icwzYqLy52YspLgEgV9NKcDTY0DDKafCVVndikUhU46a+ngTN2WfYhD+J+im/p5VxPQIW8kpj3F
	Dhp21dV7B3qLld1+v9NJSOt2M587lojBcMiG8fMxJ+r6/9BIrgaEAbCGwXX7GwedVRmQ7TvKClP
	F81v16BTuJZOnfG3FWcEImoPnjhS8HZDWSmOLEy5P2lwij0RFfrQk+PisX2mIvAMlAfMxx2R3vs
	EOE/6TjvwWADo3Yc8fxzIQPxl8Qyddi2d+FFU4EvQn3saoy4jvjX1bINHlWabYqx1ZwHuKLVMI/
	fTFXNIey34w3Q8YjzvCK2SiMND1AyphBzvYU4YVZmazbCQogSLBsG9A+GmqUv/4pw4aDQM7CjWm
	rj5JUb4ifvEyO53CJVEU5SruXMH/HZyUc1Yjw6AzZhz5Nsx1RdEoUsW1XCT281wogTvnXjcv45
X-Received: by 2002:a17:902:f681:b0:2ae:b807:da61 with SMTP id d9443c01a7336-2b0b0a99b7amr51003555ad.35.1774465758513;
        Wed, 25 Mar 2026 12:09:18 -0700 (PDT)
Received: from archlinux ([182.75.25.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc773472sm6466235ad.7.2026.03.25.12.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2026 12:09:18 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v3 2/2] push: support pushing to a remote group
Date: Thu, 26 Mar 2026 00:39:06 +0530
Message-ID: <20260325190906.1153080-3-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
References: <20260318204028.1010487-1-usmanakinyemi202@gmail.com>
 <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
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

When the argument resolves to a single remote, the behaviour is
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

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 Documentation/git-push.adoc |  73 ++++++++++++++++--
 builtin/push.c              | 123 +++++++++++++++++++++--------
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 150 ++++++++++++++++++++++++++++++++++++
 4 files changed, 306 insertions(+), 41 deletions(-)
 create mode 100755 t/t5566-push-group.sh

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e5ba3a6742..b7f617a290 100644
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
@@ -430,6 +443,50 @@ further recursion will occur. In this case, `only` is treated as `on-demand`.
 
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
+The behaviour upon failure depends on the kind of error encountered:
+
+If a member remote rejects the push, for example due to a
+non-fast-forward update, force needed but not given, an existing tag,
+or a server-side hook refusing a ref, Git reports the error and continues
+pushing to the remaining remotes in the group. The overall exit code is
+non-zero if any member push fails.
+
+If a member remote cannot be contacted at all, for example because the
+repository does not exist, authentication fails, or the network is
+unreachable, the push stops at that point and the remaining remotes
+are not attempted.
+
+This means the user is responsible for ensuring that the sequence of
+individual pushes makes sense. If `git push r1`` would fail for a given
+set of options and arguments, then `git push all-remotes` will fail in
+the same way when it reaches r1. The group push does not do anything
+special to make a failing individual push succeed.
+
 OUTPUT
 ------
 
diff --git a/builtin/push.c b/builtin/push.c
index 5b6cebbb85..4a19d3879d 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -551,12 +551,13 @@ int cmd_push(int argc,
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
@@ -619,39 +620,45 @@ int cmd_push(int argc,
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
@@ -661,10 +668,60 @@ int cmd_push(int argc,
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
+	for (size_t i = 0; i < remote_group.nr; i++) {
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
index 0000000000..b9962946c7
--- /dev/null
+++ b/t/t5566-push-group.sh
@@ -0,0 +1,150 @@
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
+test_expect_success 'push to remote group updates all members correctly' '
+	git push all-remotes HEAD:refs/heads/main &&
+	git rev-parse HEAD >expect &&
+	for i in 1 2 3
+	do
+		git -C dest-$i.git rev-parse refs/heads/main >actual ||
+		return 1
+		test_cmp expect actual || return 1
+	done
+'
+
+test_expect_success 'push second commit to group updates all members' '
+	test_tick &&
+	git commit --allow-empty -m "second" &&
+	git push all-remotes HEAD:refs/heads/main &&
+	git rev-parse HEAD >expect &&
+	for i in 1 2 3
+	do
+		git -C dest-$i.git rev-parse refs/heads/main >actual ||
+		return 1
+		test_cmp expect actual || return 1
+	done
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
+test_expect_success 'mirror remote in group with refspec fails' '
+	git config set remote.remote-1.mirror true &&
+	test_must_fail git push all-remotes HEAD:refs/heads/main 2>err &&
+	test_grep "mirror" err &&
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
+test_expect_success 'push continues past rejection to remaining remotes' '
+	for i in c1 c2 c3
+	do
+		git init --bare dest-$i.git || return 1
+	done &&
+	git config set remote.c1.url "file://$(pwd)/dest-c1.git" &&
+	git config set remote.c2.url "file://$(pwd)/dest-c2.git" &&
+	git config set remote.c3.url "file://$(pwd)/dest-c3.git" &&
+	git config set remotes.continue-group "c1 c2 c3" &&
+
+	test_tick &&
+	git commit --allow-empty -m "base for continue test" &&
+
+	# initial sync
+	git push continue-group HEAD:refs/heads/main &&
+
+  # advance c2 independently
+  git clone dest-c2.git tmp-c2 &&
+  (
+    cd tmp-c2 &&
+    git checkout -b main origin/main &&
+    test_commit c2_independent &&
+    git push origin HEAD:refs/heads/main
+  ) &&
+  rm -rf tmp-c2 &&
+
+	test_tick &&
+	git commit --allow-empty -m "local diverging commit" &&
+
+	# push: c2 rejects, others succeed
+	test_must_fail git push continue-group HEAD:refs/heads/main &&
+
+	git rev-parse HEAD >expect &&
+	git -C dest-c1.git rev-parse refs/heads/main >actual-c1 &&
+	git -C dest-c3.git rev-parse refs/heads/main >actual-c3 &&
+	test_cmp expect actual-c1 &&
+	test_cmp expect actual-c3 &&
+
+	# c2 should not have the new commit
+	git -C dest-c2.git rev-parse refs/heads/main >actual-c2 &&
+	! test_cmp expect actual-c2
+'
+
+test_expect_success 'fatal connection error stops remaining remotes' '
+	for i in f1 f2 f3
+	do
+		git init --bare dest-$i.git || return 1
+	done &&
+	git config set remote.f1.url "file://$(pwd)/dest-f1.git" &&
+	git config set remote.f2.url "file://$(pwd)/dest-f2.git" &&
+	git config set remote.f3.url "file://$(pwd)/dest-f3.git" &&
+	git config set remotes.fatal-group "f1 f2 f3" &&
+
+	test_tick &&
+	git commit --allow-empty -m "base for fatal test" &&
+
+	# initial sync
+	git push fatal-group HEAD:refs/heads/main &&
+
+	# break f2
+	git config set remote.f2.url "file:///tmp/does-not-exist-$$" &&
+
+	test_tick &&
+	git commit --allow-empty -m "after fatal setup" &&
+
+	test_must_fail git push fatal-group HEAD:refs/heads/main &&
+
+	git rev-parse HEAD >expect &&
+	git -C dest-f1.git rev-parse refs/heads/main >actual-f1 &&
+	test_cmp expect actual-f1 &&
+
+	# f3 should not be updated
+	git -C dest-f3.git rev-parse refs/heads/main >actual-f3 &&
+	! test_cmp expect actual-f3 &&
+
+	git config set remote.f2.url "file://$(pwd)/dest-f2.git"
+'
+
+test_done
-- 
2.48.0.rc0.4242.g73eb647d24.dirty

