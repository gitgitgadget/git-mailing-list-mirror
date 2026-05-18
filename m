Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AE2438A716
	for <git@vger.kernel.org>; Mon, 18 May 2026 18:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779128860; cv=none; b=qM1g/3o43YtwQmRnadsRfcjIhoYhwaTKTez/ZGKX1CqzcH34uduJfy0+L9FjzRPo10ol3X45Q49nr6OaMcqAssvHxy8itvmWwYkx+jwTG6LtkAwADU3Ws7Bw3YD3AaCj4Umzv9BlRTjP1XRQBYZiRDe72I0mJDhTPW/xUvi85ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779128860; c=relaxed/simple;
	bh=Z/yA/m0jglpuWDcsj+6aEuRTpqzxBLWma+5iKjBeNX0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZH1dVdwWPuqdJellje+8zfjXzVeGycoz7Eq5Hq5wSbxWrWDeMtfqGx5827GSjQM2gaiGNDSadzRRWd8etcUv5I+F8fEyWq0UUiwZSB39HbZ9JI+XlcNncv7rJo6xnXngm4/cQcynwDgjisqJ+c5qUtX164ghWLqlh9FEYyn+X0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pILLj3Iz; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pILLj3Iz"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2b4583f0a1aso16196555ad.3
        for <git@vger.kernel.org>; Mon, 18 May 2026 11:27:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779128855; x=1779733655; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VWFJvl0y6JAIMC+Chj+6Kxg6A+BOYyqlH5g1mZsiBTw=;
        b=pILLj3IzZhVBYbT9QQJ6RkLRw0j0wAI4OVUz2OdlAoXWos2AJwFK5nnU4I1nKL9Jv6
         yT5buKXlomtUBLl8lQo+ID0aDBBEKqOR6sY0jSyfpWjM6+Wtb/Ze4gBqwvb+gUeM0oqD
         ym1tOJWfLwHfUUxdrCRN9Tzm8cG2Fq/fpCs0CQS8cLj2bWTBWgTEa7n6OZlM9h7RP2ZI
         A/mwVQYHNZMaNM+ZAjuB4YmeI6kZQPXMBXaJ3sEYshM/xBNkTpZSklhoee2jFg51mFIr
         KMALMPluPcogMbzuARQS0NZvibst7OMu1MHZ2b0lUQGmV5xDEl5sJK4WN07ojR+wGMo+
         /ipQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779128855; x=1779733655;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VWFJvl0y6JAIMC+Chj+6Kxg6A+BOYyqlH5g1mZsiBTw=;
        b=s8EvXprlxmTjBN5+R8KSu1xh+ygTmCTfacki5bYwVENcZAu5PE4Tv/K0z8Ai/SryxZ
         dHKcCJ6avmi0NqHwEQh784X/sec33PUcM+5PCCJSDDAzPc+XAUZdn3g+COTp4Oer9pHh
         H0s+YC853v9wjvrvzt5Y9/ZhjVcLz4a6oWWNfu0JQJLJWMkBxN5UaillP3TGd9WJ+ieg
         mjth3Clz2b+LAyhEXD4DL7FYBLdq4Xgs+8OUirHx+VS0AtEHiDKoe54sEmkyHfPxAzhm
         hD7O/KKYDIbURg0cfYbgU8zQc5NQY3gLUvU4NPBro4cwzR1WKHUFgmIJJ3v0uHAD9/Q7
         GljA==
X-Forwarded-Encrypted: i=1; AFNElJ+gtEMNW/Qb7pRXAQdlXQA2jhvLKek9R9J2ODKmIo1kkxQX659wkDs/1+8IRc+8oSfgL7s=@vger.kernel.org
X-Gm-Message-State: AOJu0YxknQYUlPaHl5wjjxHxDbKSLUOVxZw23+kgzf3FuMClE/qjn5Am
	TjagR2/dc7FUJS5dQ9/zPzcOOuleO7gm6BzNXTACZuRVh5sgiGSjUlQw
X-Gm-Gg: Acq92OFIWhpM//RGLUqB0soUKxrEmi7ZuJl3sM1fqPKNtR9rz0aLBM3QL1N6H2+tHxM
	U5m7BBjRPYA2C7v6OGrQ8zK+Ld1hBZ3pYOtUVWwEFZIYFMD0ligDjRystyNFNFIdN8Nh5PLYSY8
	QyXdY/Ba0Bh5rWkaVrWJQIOrqEYveBvHb+ecGWmhdvRO+HA0zj3zmwjddMNoFSbHSchU/L0DGCf
	o1wZq92silBCRS44CAdZVjbaG+BBlZADlakayrjSD6fP6IvkrIeIDKB9SfvoDdsDKDNvq1gOx/n
	Ww9d0zY9E/A7oICHE77JELpgzcBesnht1vVSdk2b4NmC5StSRUkKOlamH5i86jS5d7HNWg5sLcn
	pEM0mCf3jdcMUSl/TSKAIYIIQc7/gHVa70rD5wyoXjsD0jeDInEQa2JEgBdNq7IUtd6bnrsL2vk
	us6+sbcFP7BPg3l9T9cpeu8dwF5VobjaZChWlJpDDozE3rrg+3MjOk2N4K3mxWCTo8
X-Received: by 2002:a17:903:2ce:b0:2bd:6cab:85d with SMTP id d9443c01a7336-2bd7e782281mr171003605ad.3.1779128855264;
        Mon, 18 May 2026 11:27:35 -0700 (PDT)
Received: from archlinux ([103.177.178.109])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c0600a4sm148530085ad.30.2026.05.18.11.27.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 11:27:34 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com,
	git@vger.kernel.org
Cc: christian.couder@gmail.com,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [PATCH v6 3/3] push: support pushing to a remote group
Date: Mon, 18 May 2026 23:57:21 +0530
Message-ID: <20260518182721.155070-4-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260518182721.155070-1-usmanakinyemi202@gmail.com>
References: <20260503153402.1333220-4-usmanakinyemi202@gmail.com>
 <20260518182721.155070-1-usmanakinyemi202@gmail.com>
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
 Documentation/git-push.adoc |  80 ++++++++++--
 builtin/push.c              | 251 +++++++++++++++++++++++++++++++-----
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 160 +++++++++++++++++++++++
 4 files changed, 451 insertions(+), 41 deletions(-)
 create mode 100755 t/t5566-push-group.sh

diff --git a/Documentation/git-push.adoc b/Documentation/git-push.adoc
index e5ba3a6742..2ac16a9d78 100644
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
@@ -430,6 +443,57 @@ further recursion will occur. In this case, `only` is treated as `on-demand`.
 
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
+where `r1`, `r2`, ..., `rN` are the members of `all-remotes`.  No special
+behaviour is added or removed — the group is purely a shorthand for
+running the same push command against each member remote individually.
+
+When pushing to a group of more than one remote, Git spawns a separate
+`git push` subprocess for each member remote in sequence.  Each subprocess
+receives the same flags and refspecs as the original invocation.  This
+means that per-remote push mappings configured via `remote.<name>.push`
+and mirror mode (`remote.<name>.mirror`) are evaluated independently for
+each remote, and a mirror remote in the group cannot affect the push
+behaviour of other non-mirror remotes in the same group.
+
+The `--atomic` option is not supported for group pushes, because atomicity
+can only be guaranteed within a single transport connection to a single
+remote.  Git will refuse the invocation with an error if `--atomic` is
+combined with a group name.
+
+If any member remote fails whether due to a push rejection (e.g. a
+non-fast-forward update, a server-side hook refusing a ref) or a connection
+error (e.g. the repository does not exist, authentication fails, or the
+network is unreachable), Git reports the error and continues pushing to
+the remaining remotes in the group.  The overall exit code is non-zero if
+any member push fails.
+
+This means the user is responsible for ensuring that the sequence of
+individual pushes makes sense. If `git push r1` would fail for a given
+set of options and arguments, then `git push all-remotes` will fail in
+the same way when it reaches `r1`. The group push does not do anything
+special to make a failing individual push succeed.
+
 OUTPUT
 ------
 
diff --git a/builtin/push.c b/builtin/push.c
index 7100ffba5d..6021b71d66 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -10,6 +10,7 @@
 #include "config.h"
 #include "environment.h"
 #include "gettext.h"
+#include "hex.h"
 #include "refspec.h"
 #include "run-command.h"
 #include "remote.h"
@@ -544,6 +545,123 @@ static int git_push_config(const char *k, const char *v,
 	return git_default_config(k, v, ctx, NULL);
 }
 
+static int push_multiple(struct string_list *list,
+			 const struct string_list *push_options,
+			 int flags,
+			 int tags,
+			 const char **refspecs,
+			 int refspec_nr)
+{
+	int result = 0;
+	size_t i;
+	struct strvec argv = STRVEC_INIT;
+
+	strvec_push(&argv, "push");
+
+	if (flags & TRANSPORT_PUSH_FORCE)
+		strvec_push(&argv, "--force");
+	if (flags & TRANSPORT_PUSH_DRY_RUN)
+		strvec_push(&argv, "--dry-run");
+	if (flags & TRANSPORT_PUSH_PORCELAIN)
+		strvec_push(&argv, "--porcelain");
+	if (flags & TRANSPORT_PUSH_PRUNE)
+		strvec_push(&argv, "--prune");
+	if (flags & TRANSPORT_PUSH_NO_HOOK)
+		strvec_push(&argv, "--no-verify");
+	if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
+		strvec_push(&argv, "--follow-tags");
+	if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
+		strvec_push(&argv, "--set-upstream");
+	if (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES)
+		strvec_push(&argv, "--force-if-includes");
+	if (flags & TRANSPORT_PUSH_ALL)
+		strvec_push(&argv, "--all");
+	if (flags & TRANSPORT_PUSH_MIRROR)
+		strvec_push(&argv, "--mirror");
+
+	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
+		strvec_push(&argv, "--signed=yes");
+	else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED)
+		strvec_push(&argv, "--signed=if-asked");
+	if (!thin)
+		strvec_push(&argv, "--no-thin");
+
+	if (deleterefs)
+		strvec_push(&argv, "--delete");
+
+	if (receivepack)
+		strvec_pushf(&argv, "--receive-pack=%s", receivepack);
+	if (verbosity >= 2)
+		strvec_push(&argv, "-v");
+	if (verbosity >= 1)
+		strvec_push(&argv, "-v");
+	else if (verbosity < 0)
+		strvec_push(&argv, "-q");
+	if (progress > 0)
+		strvec_push(&argv, "--progress");
+	else if (progress == 0)
+		strvec_push(&argv, "--no-progress");
+
+	if (family == TRANSPORT_FAMILY_IPV4)
+		strvec_push(&argv, "--ipv4");
+	else if (family == TRANSPORT_FAMILY_IPV6)
+		strvec_push(&argv, "--ipv6");
+
+	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
+		strvec_push(&argv, "--recurse-submodules=check");
+	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
+		strvec_push(&argv, "--recurse-submodules=on-demand");
+	else if (recurse_submodules == RECURSE_SUBMODULES_ONLY)
+		strvec_push(&argv, "--recurse-submodules=only");
+	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
+		strvec_push(&argv, "--recurse-submodules=no");
+
+
+	if (tags)
+		strvec_push(&argv, "--tags");
+
+	for (i = 0; i < push_options->nr; i++)
+		strvec_pushf(&argv, "--push-option=%s",
+			     push_options->items[i].string);
+
+	for (i = 0; i < cas.nr; i++) {
+		if (cas.entry[i].use_tracking) {
+			strvec_pushf(&argv, "--force-with-lease=%s",
+				     cas.entry[i].refname);
+		} else if (!is_null_oid(&cas.entry[i].expect)) {
+			strvec_pushf(&argv, "--force-with-lease=%s:%s",
+				     cas.entry[i].refname,
+				     oid_to_hex(&cas.entry[i].expect));
+		} else {
+			strvec_push(&argv, "--force-with-lease");
+		}
+	}
+
+	for (i = 0; i < list->nr; i++) {
+		const char *name = list->items[i].string;
+		struct child_process cmd = CHILD_PROCESS_INIT;
+		int j;
+
+		strvec_pushv(&cmd.args, argv.v);
+		strvec_push(&cmd.args, name);
+
+		for (j = 0; j < refspec_nr; j++)
+			strvec_push(&cmd.args, refspecs[j]);
+
+		if (verbosity >= 0)
+			printf(_("Pushing to %s\n"), name);
+
+		cmd.git_cmd = 1;
+		if (run_command(&cmd)) {
+			error(_("could not push to %s"), name);
+			result = 1;
+		}
+	}
+
+	strvec_clear(&argv);
+	return result;
+}
+
 int cmd_push(int argc,
 	     const char **argv,
 	     const char *prefix,
@@ -552,12 +670,13 @@ int cmd_push(int argc,
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
@@ -620,39 +739,45 @@ int cmd_push(int argc,
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
@@ -662,10 +787,70 @@ int cmd_push(int argc,
 		if (strchr(item->string, '\n'))
 			die(_("push options must not have new line characters"));
 
-	rc = do_push(flags, push_options, remote);
+	if (remote_group.nr == 1) {
+		/*
+		 * Single remote (the common case): run do_push() directly
+		 * in this process.  The loop runs exactly once.
+		 *
+		 * Mirror detection and the --mirror/--all + refspec conflict
+		 * checks are done here.  rs is rebuilt so that per-remote push
+		 * mappings (remote.NAME.push config) are resolved against the
+		 * correct remote.  inner_flags is a snapshot of flags so that a
+		 * mirror remote cannot bleed TRANSPORT_PUSH_FORCE into any
+		 * subsequent call.
+		 */
+		base_flags = flags;
+		{
+			int inner_flags = base_flags;
+			struct remote *r = pushremote_get(remote_group.items[0].string);
+			if (!r)
+				die(_("no such remote or remote group: %s"),
+				    remote_group.items[0].string);
+
+			if (r->mirror)
+				inner_flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
+
+			if (inner_flags & TRANSPORT_PUSH_ALL) {
+				if (argc >= 2)
+					die(_("--all can't be combined with refspecs"));
+			}
+			if (inner_flags & TRANSPORT_PUSH_MIRROR) {
+				if (argc >= 2)
+					die(_("--mirror can't be combined with refspecs"));
+			}
+
+			refspec_clear(&rs);
+			rs = (struct refspec) REFSPEC_INIT_PUSH;
+
+			if (tags)
+				refspec_append(&rs, "refs/tags/*");
+			if (argc > 0)
+				set_refspecs(argv + 1, argc - 1, r);
+
+			rc = do_push(inner_flags, push_options, r);
+		}
+	} else {
+		/*
+		 * Multiple remotes: spawn one "git push <remote> [<refspecs>]"
+		 * subprocess per remote, sequentially.
+		 *
+		 * Options that only make sense for a single transport connection
+		 * are rejected here.
+		 */
+		if (flags & TRANSPORT_PUSH_ATOMIC)
+			die(_("--atomic can only be used when pushing to one remote"));
+
+		rc = push_multiple(&remote_group, push_options, flags,
+				   tags,
+				   argc > 1 ? argv + 1 : NULL,
+				   argc > 1 ? argc - 1 : 0);
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
index 7528e5cda5..bd090627e9 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -704,6 +704,7 @@ integration_tests = [
   't5563-simple-http-auth.sh',
   't5564-http-proxy.sh',
   't5565-push-multiple.sh',
+  't5566-push-group.sh',
   't5570-git-daemon.sh',
   't5571-pre-push-hook.sh',
   't5572-pull-submodule.sh',
diff --git a/t/t5566-push-group.sh b/t/t5566-push-group.sh
new file mode 100755
index 0000000000..a7d59352b1
--- /dev/null
+++ b/t/t5566-push-group.sh
@@ -0,0 +1,160 @@
+#!/bin/sh
+
+test_description='push to remote group'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=default
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
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
+
+test_expect_success 'push.default=current works with group push' '
+	git config set push.default current &&
+	test_tick &&
+	git commit --allow-empty -m "fifth" &&
+	git push all-remotes &&
+	git config unset push.default
+'
+
+test_expect_success '--atomic is rejected for group push' '
+	test_must_fail git push --atomic all-remotes HEAD:refs/heads/main 2>err &&
+	test_grep "atomic" err
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
+	# advance c2 independently
+	git clone dest-c2.git tmp-c2 &&
+	(
+		cd tmp-c2 &&
+		git checkout -b main origin/main &&
+		test_commit c2_independent &&
+		git push origin HEAD:refs/heads/main
+	) &&
+	rm -rf tmp-c2 &&
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
+test_expect_success 'fatal connection error does not stop remaining remotes' '
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
+	# overall exit code is non-zero because f2 failed
+	test_must_fail git push fatal-group HEAD:refs/heads/main &&
+
+	git rev-parse HEAD >expect &&
+
+	# f1 and f3 should both have the new commit — subprocesses are independent
+	git -C dest-f1.git rev-parse refs/heads/main >actual-f1 &&
+	test_cmp expect actual-f1 &&
+	git -C dest-f3.git rev-parse refs/heads/main >actual-f3 &&
+	test_cmp expect actual-f3 &&
+
+	git config set remote.f2.url "file://$(pwd)/dest-f2.git"
+'
+
+test_done
-- 
2.54.0

