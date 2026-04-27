Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3841E234994
	for <git@vger.kernel.org>; Mon, 27 Apr 2026 14:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777298737; cv=none; b=OuK8q3k9UqCkCyhbZp01PoaAPCPZ8VA8sLdWgy1ccLPWGIiwnmZUYSAKL7xPCVnPdTikFXe79SeV2KD1ImS4yD9oBeR3SRSwbhw8Ab0+TTzTAHTuI6HcUW032dCraIMAUmNf/rtU4sS0omK7FVSJcevJKgmbRrQHgTCGz0bhpbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777298737; c=relaxed/simple;
	bh=52sxjzOPjsVXmfRCH2rSapIxjZ79BR5y8L1Bdl/jMtA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qgzEYtpJW15yMGcFXG+9G56UYpcAoxwGtuPTA+uqMI2tF29w1F78Jpgc3toOIfveeztlmRk4E0ed4+Ysox9SAU3N8lWKMHT3ujDt3cVrMvhqr33Vib90rrS0f+0udk/A+z5UdLFKcynNIspM8esF6kE6cdsshrfQoR+73kasc/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bowTqsCV; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bowTqsCV"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-82fbf5d4dc2so6314246b3a.1
        for <git@vger.kernel.org>; Mon, 27 Apr 2026 07:05:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777298735; x=1777903535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uGpHFk2IM1JBRg1O/+7BrAFyKuNyqBtAaL3PpGsLA0c=;
        b=bowTqsCVMDMwg/kETbl/BThEegkdc69/n/3OXUnEJ4+cNi700wqe7X+W4pdfNlX7Ic
         faYI/uyxE1lA26aibCwJZRr361HGCzO2Z3nrU4vjlfk561ncszKg2s5WmKIrEoJPHSS0
         uL/4nsk7rW1HfEyg8twl7qdwGCNHvjroyapiONGFqIx8mjjLqb4pUtNiNBR8R7bBsut8
         1p7BR+J+sqa38E1kyo8q+O+plCA+Rb1mxXRsoNVeN4uA/DYfiyFdZM47q7JTM6EChmSu
         qGQkfScgdwuqeXjSl24E7kqs/Zx3tn+YzoLzNGbGkaxCrD3aqX5ZWcGv3C7WaJshMLci
         XWyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777298735; x=1777903535;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=uGpHFk2IM1JBRg1O/+7BrAFyKuNyqBtAaL3PpGsLA0c=;
        b=Pc7J1sqF47t3ODYSpZ1UVPuvw0sQGmnlZyByRZCmRZ6j8juYSG6CLawKTnr7sAh9mJ
         vU1NCAYevsfecT/vpFLRf3R1ZclaQT4O8p6OXEhXEgkjuLMs7458FiOw8rrzRzJy3gcn
         Dpd0R1N6F8TiEo3vIIFNlXrGbdsfEvQpEEWQF58vFNCEkR4Xlf/Uza2rEefANUE5jJrW
         l9zlwt/QE4CIcpPCzhU5DfIZco8KLfjShF7zQPm5TtXVa44pNwKM9HFcTxClhnXLHizT
         bFuV2mB87k4+anXKYKh1aRbnvgqP+GYd4YCb3rM17hVFXbFfFRCAlhLb1gDbyKNx/Fre
         yPiQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5ayUv4cl12Hh0VmC/zPpddjG/abqbPEusOz2BL9eKPRpfTEjtcmuEyZws2Z2+IkusTOc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwslDPVh96FV7+Ak9zBA80Xw8FMsI9ZhlCkZ+ARSU357wIW78V6
	7IxuXYW5fg7iWL8BdsjKRioFotFr2cPaJ6yZEyBJA50Yt+sqjcTQTdj/
X-Gm-Gg: AeBDievgL/AWzMjHiHCZGbP6OWRMlxxE1JsqaQ4NCT57BWVmNA6RozJRDXK0v1uiP8K
	BVsNmT/FCA2fPp8G0+hY0cNGNhrMadolqgSU0Fwzt3jn90roxwv7CnQUqghoyPR8Go5maRBA//8
	7FgFa4nXIyMpzdayhcNoAgGVbsJzzHpjhfLD8V1ZXet+kHCwTou0hSxtpLw2TBt0dHxm59WqWNT
	FF3EAFaPvn2WGKpC50PRwdov5wSqijRJVvD/D1oIsPY2IL9OuLGXNfVEFVrcg+rmXM6Arqz1mYh
	WTer44cAlJelVwo0wwkcjArpEU8glysCpzYBx59xcE9Zkcsrtc1IfmOIBXstZWP7o7poXd62Ibw
	MGoOkI/G4JJ9/68UnPsdxiJEUywcg7sPP10ZGFZAn+GHptLK18WV/uzoix8+Eh1sO6ux8vZ8hmz
	xEdo1K48h7q0b7sYUI07Ge1QtpHDm8gt2/NY5jpEgywo4o65jPb8roY1gpBGJluz4E48HSWA==
X-Received: by 2002:a05:6a00:1c96:b0:82f:1369:7268 with SMTP id d2e1a72fcca58-82f8c8c7c2amr42008365b3a.30.1777298735237;
        Mon, 27 Apr 2026 07:05:35 -0700 (PDT)
Received: from archlinux ([14.194.19.14])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9fbb85sm37331623b3a.22.2026.04.27.07.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 07:05:34 -0700 (PDT)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: usmanakinyemi202@gmail.com
Cc: christian.couder@gmail.com,
	git@vger.kernel.org,
	gitster@pobox.com,
	me@ttaylorr.com,
	phillip.wood123@gmail.com,
	ps@pks.im
Subject: [RFC PATCH v3 0/2] push: add support for pushing to remote groups
Date: Mon, 27 Apr 2026 19:35:28 +0530
Message-ID: <20260427140530.856125-1-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
References: <20260325190906.1153080-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This RFC series adds support for `git push` to accept a remote group
name (as configured via `remotes.<name>` in config) in addition to a
single remote name, mirroring the behaviour that `git fetch` has
supported for some time.

A user with multiple remotes configured as a group can now do:

    git push all-remotes

instead of pushing to each remote individually, in the same way that:

    git fetch all-remotes

already works.

The series is split into two patches:

  - Patch 1 moves `get_remote_group`, `add_remote_or_group`, and the
    `remote_group_data` struct out of builtin/fetch.c and into
    remote.c/remote.h, making them part of the public remote API.

  - Patch 2 extends builtin/push.c to use the newly public
    `add_remote_or_group()` to resolve the repository argument as
    either a single remote or a group, and pushes to each member of
    the group in turn.

Changes in v4:

- Made the multiple push to use child process through `run_command`
  thereby making failure to in pushing to one remote not affect the
  others no matter the kind of failure it is.
- Update the test and the docs to reflect the above.

Range-diff v3 -> v4:

1:  dd370a19e7 = 1:  20ed79546f remote: move remote group resolution to remote.c
2:  6a7957e61c ! 2:  964694e587 push: support pushing to a remote group
    @@ Documentation/git-push.adoc: further recursion will occur. In this case, `only`
     +behaviour is added or removed — the group is purely a shorthand for
     +running the same push command against each member remote individually.
     +
    -+The behaviour upon failure depends on the kind of error encountered:
    -+
    -+If a member remote rejects the push, for example due to a
    -+non-fast-forward update, force needed but not given, an existing tag,
    -+or a server-side hook refusing a ref, Git reports the error and continues
    -+pushing to the remaining remotes in the group. The overall exit code is
    -+non-zero if any member push fails.
    -+
    -+If a member remote cannot be contacted at all, for example because the
    -+repository does not exist, authentication fails, or the network is
    -+unreachable, the push stops at that point and the remaining remotes
    -+are not attempted.
    ++When pushing to a group of more than one remote, Git spawns a separate
    ++`git push` subprocess for each member remote in sequence.  Each subprocess
    ++receives the same flags and refspecs as the original invocation.  This
    ++means that per-remote push mappings configured via `remote.<name>.push`
    ++and mirror mode (`remote.<name>.mirror`) are evaluated independently for
    ++each remote, and a mirror remote in the group cannot affect the push
    ++behaviour of other non-mirror remotes in the same group.
    ++
    ++The `--atomic` option is not supported for group pushes, because atomicity
    ++can only be guaranteed within a single transport connection to a single
    ++remote.  Git will refuse the invocation with an error if `--atomic` is
    ++combined with a group name.
    ++
    ++If any member remote fails whether due to a push rejection (e.g. a
    ++non-fast-forward update, a server-side hook refusing a ref) or a connection
    ++error (e.g. the repository does not exist, authentication fails, or the
    ++network is unreachable), Git reports the error and continues pushing to
    ++the remaining remotes in the group.  The overall exit code is non-zero if
    ++any member push fails.
     +
     +This means the user is responsible for ensuring that the sequence of
     +individual pushes makes sense. If `git push r1`` would fail for a given
    @@ Documentation/git-push.adoc: further recursion will occur. In this case, `only`
      
     
      ## builtin/push.c ##
    +@@
    + #include "config.h"
    + #include "environment.h"
    + #include "gettext.h"
    ++#include "hex.h"
    + #include "refspec.h"
    + #include "run-command.h"
    + #include "remote.h"
    +@@ builtin/push.c: static int git_push_config(const char *k, const char *v,
    + 	return git_default_config(k, v, ctx, NULL);
    + }
    + 
    ++static int push_multiple(struct string_list *list,
    ++			 const struct string_list *push_options,
    ++			 int flags,
    ++			 int tags,
    ++			 const char **refspecs,
    ++			 int refspec_nr)
    ++{
    ++	int i, result = 0;
    ++	struct strvec argv = STRVEC_INIT;
    ++
    ++	strvec_push(&argv, "push");
    ++
    ++	if (flags & TRANSPORT_PUSH_FORCE)
    ++		strvec_push(&argv, "--force");
    ++	if (flags & TRANSPORT_PUSH_DRY_RUN)
    ++		strvec_push(&argv, "--dry-run");
    ++	if (flags & TRANSPORT_PUSH_PORCELAIN)
    ++		strvec_push(&argv, "--porcelain");
    ++	if (flags & TRANSPORT_PUSH_PRUNE)
    ++		strvec_push(&argv, "--prune");
    ++	if (flags & TRANSPORT_PUSH_NO_HOOK)
    ++		strvec_push(&argv, "--no-verify");
    ++	if (flags & TRANSPORT_PUSH_FOLLOW_TAGS)
    ++		strvec_push(&argv, "--follow-tags");
    ++	if (flags & TRANSPORT_PUSH_SET_UPSTREAM)
    ++		strvec_push(&argv, "--set-upstream");
    ++	if (flags & TRANSPORT_PUSH_FORCE_IF_INCLUDES)
    ++		strvec_push(&argv, "--force-if-includes");
    ++	if (flags & TRANSPORT_PUSH_ALL)
    ++		strvec_push(&argv, "--all");
    ++	if (flags & TRANSPORT_PUSH_MIRROR)
    ++		strvec_push(&argv, "--mirror");
    ++
    ++	if (flags & TRANSPORT_PUSH_CERT_ALWAYS)
    ++		strvec_push(&argv, "--signed=yes");
    ++	else if (flags & TRANSPORT_PUSH_CERT_IF_ASKED)
    ++		strvec_push(&argv, "--signed=if-asked");
    ++	if (!thin)
    ++		strvec_push(&argv, "--no-thin");
    ++
    ++	if (deleterefs)
    ++		strvec_push(&argv, "--delete");
    ++
    ++	if (receivepack)
    ++		strvec_pushf(&argv, "--receive-pack=%s", receivepack);
    ++	if (verbosity >= 2)
    ++		strvec_push(&argv, "-v");
    ++	if (verbosity >= 1)
    ++		strvec_push(&argv, "-v");
    ++	else if (verbosity < 0)
    ++		strvec_push(&argv, "-q");
    ++	if (progress > 0)
    ++		strvec_push(&argv, "--progress");
    ++	else if (progress == 0)
    ++		strvec_push(&argv, "--no-progress");
    ++
    ++	if (family == TRANSPORT_FAMILY_IPV4)
    ++		strvec_push(&argv, "--ipv4");
    ++	else if (family == TRANSPORT_FAMILY_IPV6)
    ++		strvec_push(&argv, "--ipv6");
    ++
    ++	if (recurse_submodules == RECURSE_SUBMODULES_CHECK)
    ++		strvec_push(&argv, "--recurse-submodules=check");
    ++	else if (recurse_submodules == RECURSE_SUBMODULES_ON_DEMAND)
    ++		strvec_push(&argv, "--recurse-submodules=on-demand");
    ++	else if (recurse_submodules == RECURSE_SUBMODULES_ONLY)
    ++		strvec_push(&argv, "--recurse-submodules=only");
    ++	else if (recurse_submodules == RECURSE_SUBMODULES_OFF)
    ++		strvec_push(&argv, "--recurse-submodules=no");
    ++
    ++
    ++	if (tags)
    ++		strvec_push(&argv, "--tags");
    ++
    ++	for (i = 0; i < push_options->nr; i++)
    ++		strvec_pushf(&argv, "--push-option=%s",
    ++			     push_options->items[i].string);
    ++
    ++	for (i = 0; i < cas.nr; i++) {
    ++		if (cas.entry[i].use_tracking) {
    ++			strvec_pushf(&argv, "--force-with-lease=%s",
    ++				     cas.entry[i].refname);
    ++		} else if (!is_null_oid(&cas.entry[i].expect)) {
    ++			strvec_pushf(&argv, "--force-with-lease=%s:%s",
    ++				     cas.entry[i].refname,
    ++				     oid_to_hex(&cas.entry[i].expect));
    ++		} else {
    ++			strvec_push(&argv, "--force-with-lease");
    ++		}
    ++	}
    ++
    ++	for (i = 0; i < list->nr; i++) {
    ++		const char *name = list->items[i].string;
    ++		struct child_process cmd = CHILD_PROCESS_INIT;
    ++		int j;
    ++
    ++		strvec_pushv(&cmd.args, argv.v);
    ++		strvec_push(&cmd.args, name);
    ++
    ++		for (j = 0; j < refspec_nr; j++)
    ++			strvec_push(&cmd.args, refspecs[j]);
    ++
    ++		if (verbosity >= 0)
    ++			printf(_("Pushing to %s\n"), name);
    ++
    ++		cmd.git_cmd = 1;
    ++		if (run_command(&cmd)) {
    ++			error(_("could not push to %s"), name);
    ++			result = 1;
    ++		}
    ++	}
    ++
    ++	strvec_clear(&argv);
    ++	return result;
    ++}
    ++
    + int cmd_push(int argc,
    + 	     const char **argv,
    + 	     const char *prefix,
     @@ builtin/push.c: int cmd_push(int argc,
      	int flags = 0;
      	int tags = 0;
    @@ builtin/push.c: int cmd_push(int argc,
      			die(_("push options must not have new line characters"));
      
     -	rc = do_push(flags, push_options, remote);
    -+	/*
    -+	 * Push to each remote in remote_group. For a plain "git push <remote>"
    -+	 * or a default push, remote_group has exactly one entry and the loop
    -+	 * runs once — there is nothing structurally special about that case.
    -+	 * For a group, the loop runs once per member remote.
    -+	 *
    -+	 * Mirror detection and the --mirror/--all + refspec conflict checks
    -+	 * are done per remote inside the loop. A remote configured with
    -+	 * remote.NAME.mirror=true implies mirror mode for that remote only —
    -+	 * other non-mirror remotes in the same group are unaffected.
    -+	 *
    -+	 * rs is rebuilt from scratch for each remote so that per-remote push
    -+	 * mappings (remote.NAME.push config) are resolved against the correct
    -+	 * remote. iter_flags is derived from a clean snapshot of flags taken
    -+	 * before the loop so that a mirror remote cannot bleed
    -+	 * TRANSPORT_PUSH_FORCE into subsequent non-mirror remotes in the
    -+	 * same group.
    -+	 */
    -+	base_flags = flags;
    -+	for (size_t i = 0; i < remote_group.nr; i++) {
    -+		int iter_flags = base_flags;
    -+		struct remote *r = pushremote_get(remote_group.items[i].string);
    -+		if (!r)
    -+			die(_("no such remote or remote group: %s"),
    -+			    remote_group.items[i].string);
    -+
    -+		if (r->mirror)
    -+			iter_flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
    -+
    -+		if (iter_flags & TRANSPORT_PUSH_ALL) {
    -+			if (argc >= 2)
    -+				die(_("--all can't be combined with refspecs"));
    -+		}
    -+		if (iter_flags & TRANSPORT_PUSH_MIRROR) {
    -+			if (argc >= 2)
    -+				die(_("--mirror can't be combined with refspecs"));
    ++	if (remote_group.nr == 1) {
    ++		/*
    ++		 * Single remote (the common case): run do_push() directly
    ++		 * in this process.  The loop runs exactly once.
    ++		 *
    ++		 * Mirror detection and the --mirror/--all + refspec conflict
    ++		 * checks are done here.  rs is rebuilt so that per-remote push
    ++		 * mappings (remote.NAME.push config) are resolved against the
    ++		 * correct remote.  inner_flags is a snapshot of flags so that a
    ++		 * mirror remote cannot bleed TRANSPORT_PUSH_FORCE into any
    ++		 * subsequent call.
    ++		 */
    ++		base_flags = flags;
    ++		{
    ++			int inner_flags = base_flags;
    ++			struct remote *r = pushremote_get(remote_group.items[0].string);
    ++			if (!r)
    ++				die(_("no such remote or remote group: %s"),
    ++				    remote_group.items[0].string);
    ++
    ++			if (r->mirror)
    ++				inner_flags |= (TRANSPORT_PUSH_MIRROR|TRANSPORT_PUSH_FORCE);
    ++
    ++			if (inner_flags & TRANSPORT_PUSH_ALL) {
    ++				if (argc >= 2)
    ++					die(_("--all can't be combined with refspecs"));
    ++			}
    ++			if (inner_flags & TRANSPORT_PUSH_MIRROR) {
    ++				if (argc >= 2)
    ++					die(_("--mirror can't be combined with refspecs"));
    ++			}
    ++
    ++			refspec_clear(&rs);
    ++			rs = (struct refspec) REFSPEC_INIT_PUSH;
    ++
    ++			if (tags)
    ++				refspec_append(&rs, "refs/tags/*");
    ++			if (argc > 0)
    ++				set_refspecs(argv + 1, argc - 1, r);
    ++
    ++			rc = do_push(inner_flags, push_options, r);
     +		}
    -+
    -+		refspec_clear(&rs);
    -+		rs = (struct refspec) REFSPEC_INIT_PUSH;
    -+
    -+		if (tags)
    -+			refspec_append(&rs, "refs/tags/*");
    -+		if (argc > 0)
    -+			set_refspecs(argv + 1, argc - 1, r);
    -+
    -+		rc |= do_push(iter_flags, push_options, r);
    ++	} else {
    ++		/*
    ++		 * Multiple remotes: spawn one "git push <remote> [<refspecs>]"
    ++		 * subprocess per remote, sequentially.
    ++		 *
    ++		 * Options that only make sense for a single transport connection
    ++		 * are rejected here.
    ++		 */
    ++		if (flags & TRANSPORT_PUSH_ATOMIC)
    ++			die(_("--atomic can only be used when pushing to one remote"));
    ++
    ++		rc = push_multiple(&remote_group, push_options, flags,
    ++				   tags,
    ++				   argc > 1 ? argv + 1 : NULL,
    ++				   argc > 1 ? argc - 1 : 0);
     +	}
     +
      	string_list_clear(&push_options_cmdline, 0);
    @@ t/t5566-push-group.sh (new)
     +
     +test_description='push to remote group'
     +
    ++GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=default
    ++export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
    ++
     +. ./test-lib.sh
     +
     +test_expect_success 'setup' '
     +	for i in 1 2 3
     +	do
    -+		git init --bare dest-$i.git || return 1
    ++		git init --bare dest-$i.git &&
    ++		git -C dest-$i.git symbolic-ref HEAD refs/heads/not-a-branch ||
    ++		return 1
     +	done &&
     +	test_tick &&
     +	git commit --allow-empty -m "initial" &&
    @@ t/t5566-push-group.sh (new)
     +	test_grep "mirror" err &&
     +	git config unset remote.remote-1.mirror
     +'
    ++
     +test_expect_success 'push.default=current works with group push' '
     +	git config set push.default current &&
     +	test_tick &&
    @@ t/t5566-push-group.sh (new)
     +	git config unset push.default
     +'
     +
    ++test_expect_success '--atomic is rejected for group push' '
    ++	test_must_fail git push --atomic all-remotes HEAD:refs/heads/main 2>err &&
    ++	test_grep "atomic" err
    ++'
    ++
     +test_expect_success 'push continues past rejection to remaining remotes' '
     +	for i in c1 c2 c3
     +	do
    @@ t/t5566-push-group.sh (new)
     +	# initial sync
     +	git push continue-group HEAD:refs/heads/main &&
     +
    -+  # advance c2 independently
    -+  git clone dest-c2.git tmp-c2 &&
    -+  (
    -+    cd tmp-c2 &&
    -+    git checkout -b main origin/main &&
    -+    test_commit c2_independent &&
    -+    git push origin HEAD:refs/heads/main
    -+  ) &&
    -+  rm -rf tmp-c2 &&
    ++	# advance c2 independently
    ++	git clone dest-c2.git tmp-c2 &&
    ++	(
    ++		cd tmp-c2 &&
    ++		git checkout -b main origin/main &&
    ++		test_commit c2_independent &&
    ++		git push origin HEAD:refs/heads/main
    ++	) &&
    ++	rm -rf tmp-c2 &&
     +
     +	test_tick &&
     +	git commit --allow-empty -m "local diverging commit" &&
    @@ t/t5566-push-group.sh (new)
     +	! test_cmp expect actual-c2
     +'
     +
    -+test_expect_success 'fatal connection error stops remaining remotes' '
    ++test_expect_success 'fatal connection error does not stop remaining remotes' '
     +	for i in f1 f2 f3
     +	do
     +		git init --bare dest-$i.git || return 1
    @@ t/t5566-push-group.sh (new)
     +	test_tick &&
     +	git commit --allow-empty -m "after fatal setup" &&
     +
    ++	# overall exit code is non-zero because f2 failed
     +	test_must_fail git push fatal-group HEAD:refs/heads/main &&
     +
     +	git rev-parse HEAD >expect &&
    ++
    ++	# f1 and f3 should both have the new commit — subprocesses are independent
     +	git -C dest-f1.git rev-parse refs/heads/main >actual-f1 &&
     +	test_cmp expect actual-f1 &&
    -+
    -+	# f3 should not be updated
     +	git -C dest-f3.git rev-parse refs/heads/main >actual-f3 &&
    -+	! test_cmp expect actual-f3 &&
    ++	test_cmp expect actual-f3 &&
     +
     +	git config set remote.f2.url "file://$(pwd)/dest-f2.git"
     +'

Usman Akinyemi (2):
  remote: move remote group resolution to remote.c
  push: support pushing to a remote group

 Documentation/git-push.adoc |  80 ++++++++++--
 builtin/fetch.c             |  42 ------
 builtin/push.c              | 250 +++++++++++++++++++++++++++++++-----
 remote.c                    |  37 ++++++
 remote.h                    |  12 ++
 t/meson.build               |   1 +
 t/t5566-push-group.sh       | 160 +++++++++++++++++++++++
 7 files changed, 499 insertions(+), 83 deletions(-)
 create mode 100755 t/t5566-push-group.sh

-- 
2.53.0

