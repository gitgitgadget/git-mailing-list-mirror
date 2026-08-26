Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1572939B4A3
	for <git@vger.kernel.org>; Wed, 26 Aug 2026 23:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787787119; cv=none; b=Avy6KQsNBJO/nRr91i1LH4Mzi7lnpWpwFfRl2jwctWFcGOITpjDvX4/Fc5zozbaepp57wzrPWQWGtL8e9KK1eXzbgvgrGKXZ8NkHDhYCuy8UPPJjM7rhRGbTP1blEVNedr8OAUs9uhyXXvSxaTsy/GuXK5xhG/73Gy/cUH3D5/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787787119; c=relaxed/simple;
	bh=yXiJFZzptyY2uqJkIjlF3U/qIF1bqgwsPTMIbZJW/7Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e7t8cF/RiASLRWPK3fuqes9h2jzgMLlkNXss/LAeFzSj6H6iqbqjLMUtBtOegBLprzwOkJnU+uRoEu7QT0rTTXscfbRDPTLTkFoIaWnhLtUWT7EgnGDTmVojoRKRnPTL3XgfB9QRlIPEYqTkvTwQ28eTuYdzxa4cvkm0cVzLz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QGBOmLIH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aX4NeRok; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QGBOmLIH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aX4NeRok"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 5C4D01D000A6;
	Wed, 26 Aug 2026 19:31:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 26 Aug 2026 19:31:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-transfer-encoding:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1787787116; x=
	1787873516; bh=Xl94f4HJALONLw4HT2vQOFEpqO3ke15CNe3X0bPOk/c=; b=Q
	GBOmLIHeHGpy4gCjfAUTXzvlpj4SPxiB72sSTBbWCHDw0zLgJeN2jhKlvLPGXjiS
	A4YBxHpY+eZcU02S5ElgM+3S0qEyzCa+N1LyAuaWA+ZZEU41ryFgGmB2sLtjtNcV
	X/fBfAzWkgc21z+rqfFDXEQlGoK5pf+r4XNRuW/Y2nLjlXhcsrWub669RUMGloQi
	AKawR9qqi5ypN0/Cwxxg3OQIXrDBz3VNvwWi2o5/BVfuiLEOUQQNJSugm3AJB4lu
	6Nie7tPlLBe+UzJeDxwE+eEeyKFisc6uujx4IvUoaioG7GWpg7tP4I3g7a/EvzCY
	e0grmGEda6lpvIxna/yHg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:date:feedback-id:feedback-id:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1787787116; x=1787873516; bh=Xl94f4HJALONLw4HT2vQOFEpqO3k
	e15CNe3X0bPOk/c=; b=aX4NeRokaRDAPt5aZMBl3X20B/XO/Y7xrji9LDaai9WH
	9cb9iwqlW3O6Dgkj45RVoGpyH/YK/7LcaNy4f0pOcHBlgFptoziOq1996LIUjxY6
	r9d34QSOBZcfEJV6bOGk4poBfmz70/0kQ9vUBUsVuw1+MM0i/GnWLF2llF1lr0Gn
	4svkj7+H4KssY1PRyaUHQASvRXCS7Pw1yT1Q3SoT2tAezcUwcNvGXRWq4R1sqYsQ
	bmfsCdR/fvXR4MaddViVdKMo9eCwwWqMPsGl242JiDWjJk4T95q/ha1WLM/KwGrv
	GvWtCtH1QQp3yrvc3ShnRd7nINtD5hOtUSS4qRKWnA==
X-ME-Sender: <xms:bHePan-2V2BxDNQzQcM1_AUrDaHJukTNwNht5_QtfhLKQZFba3Vjug>
    <xme:bHePaptt9gq1IVQlNXNbCUD9q1_iOETb7GKPf4pfSt61NGb01iCr9pJmvH7jd3AKH
    lvpJWPaX75a7rAb2Q03OWapEC1ErdTTgxLU9TV3vEhZvLl9ZqtsEw>
X-ME-Received: <xmr:bHePairjkrpB5XgU9E29MaWONGJknJqC6k3VkmfUsieP5ZrUDehhglMUJVGDKvmu0GPxwmDCBbmnVyI8gEhV_d_ppipfg3BqSw>
X-ME-Proxy-Cause: dmFkZTEWvHRXWw5OcSIEAHg/ot4wFc72F/K5rZAElQLEdZ6DcdYSzJ23QHg7TtDk6wn8zr
    ZofjhMWcjN7hJujWCnOaFjg7xvRir0IdeHlKu1Dee2lrCqvco+TzAk/IjBhehjdQjlUeJL
    MXd8q1nBNu1EWFCZRFN0h84QP/2mocpIaf40sfvguKpOOR7CKZqzy/u0hRPFembixG0LP6
    fPVfUIqTpsdkCrgqhDpzRTiWCnk24a6VL6wOjpZBQ4r2MrZvjpwPQryh/lp1UY0OEdmXH3
    A1x9elZ0g0oX43rKfskm6948u5EOS8dTpaqI47bf8VHJuYRyzMUG+JC2owEcodcNcRPlmC
    U4emIsoGtT/6axls1qfPJJ++wRAXaIt+V9+giVhgW3+70nL94hBAj+aWQb9RKxSG+imQUo
    ojuq0/JKl29L43rwqZ1aOhJQLfIoo4aSPzaD08X/HVCApYS0cQYFWX2kb77ULASAlV0gRV
    yqGnxgpiGFmwCKmviIFysf7wi3ZJQNyr86mCHUkyQrxVEOtq9xgh2EqXWKRw/0dsx1YjQj
    E7nCWdOnE2ykyXt6pApn74o4ktKqe0FHHe9tFgU0quOu65FooCgq/cfzTXy4M37mmYU79O
    MmJgZM1un+G+AvK7kZxUSBDpT5C9Yh+pyyWgNwRxRwkvmcjD8adKGC81zq3A
X-ME-Proxy: <xmx:bHePaum9NGfOZNlKFcrsnpF69FZx6VjFFM87uDvvqkTsuM0tidPMHA>
    <xmx:bHePauyvpl7hc3ZfRsFjMpbGvxpVQpQVlvR9Edcruqt7sRE9shpY9A>
    <xmx:bHePaunaLoKWyq_IzuE85Wegjeelh64N-69AgAAKF2oLFoD608Vgog>
    <xmx:bHePavc9AT8rcpN56jw2iRJkXBU8AXIwlKsKg300YJ-VlRIhzi_UXA>
    <xmx:bHePajXwXDYNvaSHZ8u7hrettVCcJTdi6OGREqYmlzAZbNzZUdtFJtx1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 26 Aug 2026 19:31:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: [PATCH 1/2] die_for_incompatible_optN: swap the order of arguments
Date: Wed, 26 Aug 2026 16:31:51 -0700
Message-ID: <20260826233152.1703497-2-gitster@pobox.com>
X-Mailer: git-send-email 2.55.0-862-g3c6f97f7b9
In-Reply-To: <20260826233152.1703497-1-gitster@pobox.com>
References: <20260826233152.1703497-1-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

die_for_incompatible_opt<N>() takes N pairs of <int set, const char *name>
and complains if there is two or more pairs whose "set" part is non-zero.

To implement a vararg die_for_incompatible_opts() to supersede them,
however, having an integer parameter as the first of the pair is a
bit inconvenient sentinel.  Swap the order of these pairs so that
the "const char *name" comes first and then "int set_or_unset" comes
next.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/add.c          |  6 +++---
 builtin/clone.c        |  8 ++++----
 builtin/commit.c       | 24 ++++++++++++------------
 builtin/difftool.c     |  6 +++---
 builtin/gc.c           |  8 ++++----
 builtin/grep.c         |  6 +++---
 builtin/log.c          |  6 +++---
 builtin/merge-tree.c   |  8 ++++----
 builtin/pack-objects.c | 21 ++++++++++-----------
 builtin/push.c         |  8 ++++----
 builtin/repack.c       | 12 +++++++-----
 builtin/replay.c       | 18 +++++++++---------
 builtin/rev-list.c     |  6 +++---
 builtin/show-ref.c     |  7 ++++---
 parse-options.c        |  8 ++++----
 parse-options.h        | 33 ++++++++++++++++-----------------
 revision.c             | 26 +++++++++++++-------------
 17 files changed, 106 insertions(+), 105 deletions(-)

diff --git a/builtin/add.c b/builtin/add.c
index eab8f03cad..c9cb4e8265 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -511,9 +511,9 @@ int cmd_add(int argc,
 	else if (take_worktree_changes && ADDREMOVE_DEFAULT)
 		addremove = 0; /* "-u" was given but not "-A" */
 
-	die_for_incompatible_opt3(take_worktree_changes, "-u/--update",
-				  0 < addremove_explicit, "-A/--all",
-				  add_resolved, "--resolved");
+	die_for_incompatible_opt3("-u/--update", take_worktree_changes,
+				  "-A/--all", 0 < addremove_explicit,
+				  "--resolved", add_resolved);
 
 	if (!show_only && ignore_missing)
 		die(_("the option '%s' requires '%s'"), "--ignore-missing", "--dry-run");
diff --git a/builtin/clone.c b/builtin/clone.c
index 5b25cca510..7ebf6c31e2 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1361,10 +1361,10 @@ int cmd_clone(int argc,
 
 	transport_set_option(transport, TRANS_OPT_KEEP, "yes");
 
-	die_for_incompatible_opt2(!!option_rev, "--revision",
-				  !!option_branch, "--branch");
-	die_for_incompatible_opt2(!!option_rev, "--revision",
-				  option_mirror, "--mirror");
+	die_for_incompatible_opt2("--revision", !!option_rev,
+				  "--branch", !!option_branch);
+	die_for_incompatible_opt2("--revision", !!option_rev,
+				  "--mirror", option_mirror);
 
 	if (reject_shallow)
 		transport_set_option(transport, TRANS_OPT_REJECT_SHALLOW, "1");
diff --git a/builtin/commit.c b/builtin/commit.c
index 28f6174503..31c58491aa 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1338,14 +1338,14 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	}
 	if (fixup_message && squash_message)
 		die(_("options '%s' and '%s' cannot be used together"), "--squash", "--fixup");
-	die_for_incompatible_opt4(!!use_message, "-C",
-				  !!edit_message, "-c",
-				  !!logfile, "-F",
-				  !!fixup_message, "--fixup");
-	die_for_incompatible_opt4(have_option_m, "-m",
-				  !!edit_message, "-c",
-				  !!use_message, "-C",
-				  !!logfile, "-F");
+	die_for_incompatible_opt4("-C", !!use_message,
+				  "-c", !!edit_message,
+				  "-F", !!logfile,
+				  "--fixup", !!fixup_message);
+	die_for_incompatible_opt4("-m", have_option_m,
+				  "-c", !!edit_message,
+				  "-C", !!use_message,
+				  "-F", !!logfile);
 	if (use_message || edit_message || logfile ||fixup_message || have_option_m)
 		FREE_AND_NULL(template_file);
 	if (edit_message)
@@ -1371,10 +1371,10 @@ static int parse_and_validate_options(int argc, const char *argv[],
 	if (patch_interactive)
 		interactive = 1;
 
-	die_for_incompatible_opt4(also, "-i/--include",
-				  only, "-o/--only",
-				  all, "-a/--all",
-				  interactive, "--interactive/-p/--patch");
+	die_for_incompatible_opt4("-i/--include", also,
+				  "-o/--only", only,
+				  "-a/--all", all,
+				  "--interactive/-p/--patch", interactive);
 	if (fixup_message) {
 		/*
 		 * We limit --fixup's suboptions to only alpha characters.
diff --git a/builtin/difftool.c b/builtin/difftool.c
index bc7b2ea443..ecdeaa3d2c 100644
--- a/builtin/difftool.c
+++ b/builtin/difftool.c
@@ -773,9 +773,9 @@ int cmd_difftool(int argc,
 	} else if (dir_diff)
 		die(_("options '%s' and '%s' cannot be used together"), "--dir-diff", "--no-index");
 
-	die_for_incompatible_opt3(use_gui_tool == 1, "--gui",
-				  !!difftool_cmd, "--tool",
-				  !!extcmd, "--extcmd");
+	die_for_incompatible_opt3("--gui", use_gui_tool == 1,
+				  "--tool", !!difftool_cmd,
+				  "--extcmd", !!extcmd);
 
 	/*
 	 * Explicitly specified GUI option is forwarded to git-mergetool--lib.sh;
diff --git a/builtin/gc.c b/builtin/gc.c
index de2f9e7fed..9aa69b6c6f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -1686,10 +1686,10 @@ static int maintenance_run(int argc, const char **argv, const char *prefix,
 			     builtin_maintenance_run_usage,
 			     PARSE_OPT_STOP_AT_NON_OPTION);
 
-	die_for_incompatible_opt2(opts.auto_flag, "--auto",
-				  opts.schedule, "--schedule=");
-	die_for_incompatible_opt2(selected_tasks.nr, "--task=",
-				  opts.schedule, "--schedule=");
+	die_for_incompatible_opt2("--auto", opts.auto_flag,
+				  "--schedule=", opts.schedule);
+	die_for_incompatible_opt2("--task=", selected_tasks.nr,
+				  "--schedule=", opts.schedule);
 
 	gc_config(&cfg);
 	initialize_task_config(&opts, &selected_tasks);
diff --git a/builtin/grep.c b/builtin/grep.c
index d3d86abe01..76b163c0da 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1396,9 +1396,9 @@ int cmd_grep(int argc,
 	if (!show_in_pager && !opt.status_only)
 		setup_pager(the_repository);
 
-	die_for_incompatible_opt3(!use_index, "--no-index",
-				  untracked, "--untracked",
-				  cached, "--cached");
+	die_for_incompatible_opt3("--no-index", !use_index,
+				  "--untracked", untracked,
+				  "--cached", cached);
 
 	if (!use_index || untracked) {
 		int use_exclude = (opt_exclude < 0) ? use_index : !!opt_exclude;
diff --git a/builtin/log.c b/builtin/log.c
index 350b35c556..1acc154aae 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -2247,9 +2247,9 @@ int cmd_format_patch(int argc,
 	if (rev.show_notes)
 		load_display_notes(&rev.notes_opt);
 
-	die_for_incompatible_opt3(use_stdout, "--stdout",
-				  rev.diffopt.close_file, "--output",
-				  !!output_directory, "--output-directory");
+	die_for_incompatible_opt3("--stdout", use_stdout,
+				  "--output", rev.diffopt.close_file,
+				  "--output-directory", !!output_directory);
 
 	if (use_stdout && stdout_mboxrd)
 		rev.commit_format = CMIT_FMT_MBOXRD;
diff --git a/builtin/merge-tree.c b/builtin/merge-tree.c
index 49f41e520f..efd9321fc1 100644
--- a/builtin/merge-tree.c
+++ b/builtin/merge-tree.c
@@ -600,10 +600,10 @@ int cmd_merge_tree(int argc,
 	if (quiet && o.show_messages == -1)
 		o.show_messages = 0;
 	o.merge_options.mergeability_only = quiet;
-	die_for_incompatible_opt2(quiet, "--quiet", o.show_messages, "--messages");
-	die_for_incompatible_opt2(quiet, "--quiet", o.name_only, "--name-only");
-	die_for_incompatible_opt2(quiet, "--quiet", o.use_stdin, "--stdin");
-	die_for_incompatible_opt2(quiet, "--quiet", !line_termination, "-z");
+	die_for_incompatible_opt2("--quiet", quiet, "--messages", o.show_messages);
+	die_for_incompatible_opt2("--quiet", quiet, "--name-only", o.name_only);
+	die_for_incompatible_opt2("--quiet", quiet, "--stdin", o.use_stdin);
+	die_for_incompatible_opt2("--quiet", quiet, "-z", !line_termination);
 
 	if (xopts.nr && o.mode == MODE_TRIVIAL)
 		die(_("--trivial-merge is incompatible with all other options"));
diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 1d9dc31454..864a9ca701 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -5340,10 +5340,10 @@ int cmd_pack_objects(int argc,
 		strvec_push(&rp, "--unpacked");
 	}
 
-	die_for_incompatible_opt2(exclude_promisor_objects,
-				  "--exclude-promisor-objects",
-				  exclude_promisor_objects_best_effort,
-				  "--exclude-promisor-objects-best-effort");
+	die_for_incompatible_opt2("--exclude-promisor-objects",
+				  exclude_promisor_objects,
+				  "--exclude-promisor-objects-best-effort",
+				  exclude_promisor_objects_best_effort);
 	if (exclude_promisor_objects) {
 		fetch_if_missing = 0;
 
@@ -5385,14 +5385,13 @@ int cmd_pack_objects(int argc,
 	if (!pack_to_stdout && thin)
 		die(_("--thin cannot be used to build an indexable pack"));
 
-	die_for_incompatible_opt2(keep_unreachable, "--keep-unreachable",
-				  unpack_unreachable, "--unpack-unreachable");
+	die_for_incompatible_opt2("--keep-unreachable", keep_unreachable,
+				  "--unpack-unreachable", unpack_unreachable);
 	if (!rev_list_all || !rev_list_reflog || !rev_list_index)
 		unpack_unreachable_expiration = 0;
 
-	die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
-				  filter_options.choice, "--filter");
-
+	die_for_incompatible_opt2("--stdin-packs", stdin_packs,
+				  "--filter", filter_options.choice);
 
 	if (stdin_packs && use_internal_rev_list)
 		die(_("cannot use internal rev list with --stdin-packs"));
@@ -5400,8 +5399,8 @@ int cmd_pack_objects(int argc,
 	if (cruft) {
 		if (use_internal_rev_list)
 			die(_("cannot use internal rev list with --cruft"));
-		die_for_incompatible_opt2(stdin_packs, "--stdin-packs",
-					  cruft, "--cruft");
+		die_for_incompatible_opt2("--stdin-packs", stdin_packs,
+					  "--cruft", cruft);
 	}
 
 	/*
diff --git a/builtin/push.c b/builtin/push.c
index 2377b5af55..f20b2a31fe 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -753,10 +753,10 @@ int cmd_push(int argc,
 
 	refspec_init_push(&rs, the_hash_algo);
 
-	die_for_incompatible_opt4(deleterefs, "--delete",
-				  tags, "--tags",
-				  flags & TRANSPORT_PUSH_ALL, "--all/--branches",
-				  flags & TRANSPORT_PUSH_MIRROR, "--mirror");
+	die_for_incompatible_opt4("--delete", deleterefs,
+				  "--tags", tags,
+				  "--all/--branches", flags & TRANSPORT_PUSH_ALL,
+				  "--mirror", flags & TRANSPORT_PUSH_MIRROR);
 	if (deleterefs && argc < 2)
 		die(_("--delete doesn't make sense without any refs"));
 
diff --git a/builtin/repack.c b/builtin/repack.c
index c4360382c1..bdac72a562 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -282,8 +282,8 @@ int cmd_repack(int argc,
 	po_args.depth = xstrdup_or_null(opt_depth);
 	po_args.threads = xstrdup_or_null(opt_threads);
 
-	die_for_incompatible_opt2(drop_filtered, "--drop-filtered",
-		!!filter_to, "--filter-to");
+	die_for_incompatible_opt2("--drop-filtered", drop_filtered,
+				  "--filter-to", !!filter_to);
 
 	if (dry_run && !drop_filtered)
 		die(_("--dry-run only takes effect with --drop-filtered"));
@@ -397,9 +397,11 @@ int cmd_repack(int argc,
 	if (delete_redundant && repo->repository_format_precious_objects)
 		die(_("cannot delete packs in a precious-objects repo"));
 
-	die_for_incompatible_opt3(unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE), "-A",
-				  keep_unreachable, "-k/--keep-unreachable",
-				  pack_everything & PACK_CRUFT, "--cruft");
+	die_for_incompatible_opt3("-A",
+				  unpack_unreachable ||
+				  (pack_everything & LOOSEN_UNREACHABLE),
+				  "-k/--keep-unreachable", keep_unreachable,
+				  "--cruft", pack_everything & PACK_CRUFT);
 
 	if (pack_everything & PACK_CRUFT)
 		pack_everything |= ALL_INTO_ONE;
diff --git a/builtin/replay.c b/builtin/replay.c
index 39e3a86f6c..b97d9de21f 100644
--- a/builtin/replay.c
+++ b/builtin/replay.c
@@ -123,15 +123,15 @@ int cmd_replay(int argc,
 		usage_with_options(replay_usage, replay_options);
 	}
 
-	die_for_incompatible_opt3(!!opts.onto, "--onto",
-				  !!opts.advance, "--advance",
-				  !!opts.revert, "--revert");
-	die_for_incompatible_opt2(!!opts.advance, "--advance",
-				  opts.contained, "--contained");
-	die_for_incompatible_opt2(!!opts.revert, "--revert",
-				  opts.contained, "--contained");
-	die_for_incompatible_opt2(!!opts.ref, "--ref",
-				  !!opts.contained, "--contained");
+	die_for_incompatible_opt3("--onto", !!opts.onto,
+				  "--advance", !!opts.advance,
+				  "--revert", !!opts.revert);
+	die_for_incompatible_opt2("--advance", !!opts.advance,
+				  "--contained", opts.contained);
+	die_for_incompatible_opt2("--revert", !!opts.revert,
+				  "--contained", opts.contained);
+	die_for_incompatible_opt2("--ref", !!opts.ref,
+				  "--contained", !!opts.contained);
 
 	/* Parse ref action mode from command line or config */
 	ref_mode = get_ref_action_mode(repo, ref_action);
diff --git a/builtin/rev-list.c b/builtin/rev-list.c
index 02818b81c6..8e962b09da 100644
--- a/builtin/rev-list.c
+++ b/builtin/rev-list.c
@@ -755,9 +755,9 @@ int cmd_rev_list(int argc,
 		}
 	}
 
-	die_for_incompatible_opt2(revs.exclude_promisor_objects,
-				  "--exclude_promisor_objects",
-				  arg_missing_action, "--missing");
+	die_for_incompatible_opt2("--exclude_promisor_objects",
+				  revs.exclude_promisor_objects,
+				  "--missing", arg_missing_action);
 
 	if (arg_missing_action)
 		revs.do_not_die_on_missing_objects = 1;
diff --git a/builtin/show-ref.c b/builtin/show-ref.c
index d508441632..8f942ecbfc 100644
--- a/builtin/show-ref.c
+++ b/builtin/show-ref.c
@@ -337,9 +337,10 @@ struct repository *repo UNUSED)
 	argc = parse_options(argc, argv, prefix, show_ref_options,
 			     show_ref_usage, 0);
 
-	die_for_incompatible_opt3(exclude_existing_opts.enabled, "--exclude-existing",
-				  verify, "--verify",
-				  exists, "--exists");
+	die_for_incompatible_opt3("--exclude-existing",
+				  exclude_existing_opts.enabled,
+				  "--verify", verify,
+				  "--exists", exists);
 
 	if (exclude_existing_opts.enabled)
 		return cmd_show_ref__exclude_existing(&exclude_existing_opts);
diff --git a/parse-options.c b/parse-options.c
index 4519ead9dc..b56bc7e419 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -1535,10 +1535,10 @@ void NORETURN usage_msg_optf(const char * const fmt,
 	usage_msg_opt(msg.buf, usagestr, options);
 }
 
-void die_for_incompatible_opt4(int opt1, const char *opt1_name,
-			       int opt2, const char *opt2_name,
-			       int opt3, const char *opt3_name,
-			       int opt4, const char *opt4_name)
+void die_for_incompatible_opt4(const char *opt1_name, int opt1,
+			       const char *opt2_name, int opt2,
+			       const char *opt3_name, int opt3,
+			       const char *opt4_name, int opt4)
 {
 	int count = 0;
 	const char *options[4];
diff --git a/parse-options.h b/parse-options.h
index d7f896a933..888949ab61 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -441,29 +441,28 @@ void NORETURN usage_msg_optf(const char *fmt,
 			     const char * const *usagestr,
 			     const struct option *options, ...);
 
-void die_for_incompatible_opt4(int opt1, const char *opt1_name,
-			       int opt2, const char *opt2_name,
-			       int opt3, const char *opt3_name,
-			       int opt4, const char *opt4_name);
+void die_for_incompatible_opt4(const char *opt1_name, int opt1,
+			       const char *opt2_name, int opt2,
+			       const char *opt3_name, int opt3,
+			       const char *opt4_name, int opt4);
 
 
-static inline void die_for_incompatible_opt3(int opt1, const char *opt1_name,
-					     int opt2, const char *opt2_name,
-					     int opt3, const char *opt3_name)
+static inline void die_for_incompatible_opt3(const char *opt1_name, int opt1,
+					     const char *opt2_name, int opt2,
+					     const char *opt3_name, int opt3)
 {
-	die_for_incompatible_opt4(opt1, opt1_name,
-				  opt2, opt2_name,
-				  opt3, opt3_name,
-				  0, "");
+	die_for_incompatible_opt4(opt1_name, opt1,
+				  opt2_name, opt2,
+				  opt3_name, opt3,
+				  "", 0);
 }
 
-static inline void die_for_incompatible_opt2(int opt1, const char *opt1_name,
-					     int opt2, const char *opt2_name)
+static inline void die_for_incompatible_opt2(const char *opt1_name, int opt1,
+					     const char *opt2_name, int opt2)
 {
-	die_for_incompatible_opt4(opt1, opt1_name,
-				  opt2, opt2_name,
-				  0, "",
-				  0, "");
+	die_for_incompatible_opt4(opt1_name, opt1,
+				  opt2_name, opt2,
+				  "", 0, "", 0);
 }
 
 /*
diff --git a/revision.c b/revision.c
index 50dc8b1991..b6108501fd 100644
--- a/revision.c
+++ b/revision.c
@@ -2352,27 +2352,27 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 
 	if ((argcount = parse_long_opt("max-count", argv, &optarg))) {
 		if (revs->max_count_type == 1)
-			die_for_incompatible_opt2(1, "--max-count", 1,
-						  "--max-count-oldest");
+			die_for_incompatible_opt2("--max-count", 1,
+						  "--max-count-oldest", 1);
 		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
 		revs->max_count_type = 0;
 		return argcount;
 	} else if ((argcount = parse_long_opt("max-count-oldest", argv, &optarg))) {
 		if (revs->max_count_type == 0 && revs->max_count != -1)
-			die_for_incompatible_opt2(1, "--max-count", 1,
-						  "--max-count-oldest");
+			die_for_incompatible_opt2("--max-count", 1,
+						  "--max-count-oldest", 1);
 		if (revs->skip_count > 0)
-			die_for_incompatible_opt2(1, "--skip", 1,
-						  "--max-count-oldest");
+			die_for_incompatible_opt2("--skip", 1,
+						  "--max-count-oldest", 1);
 		revs->max_count = parse_count(optarg);
 		revs->no_walk = 0;
 		revs->max_count_type = 1;
 		revs->max_count_stage = 0;
 	} else if ((argcount = parse_long_opt("skip", argv, &optarg))) {
 		if (revs->max_count_type == 1)
-			die_for_incompatible_opt2(1, "--skip", 1,
-						  "--max-count-oldest");
+			die_for_incompatible_opt2("--skip", 1,
+						  "--max-count-oldest", 1);
 		revs->skip_count = parse_count(optarg);
 		return argcount;
 	} else if ((*arg == '-') && isdigit(arg[1])) {
@@ -3205,12 +3205,12 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 	/*
 	 * Limitations on the graph functionality
 	 */
-	die_for_incompatible_opt3(!!revs->graph, "--graph",
-				  !!revs->reverse, "--reverse",
-				  !!revs->reflog_info, "--walk-reflogs");
+	die_for_incompatible_opt3("--graph", !!revs->graph,
+				  "--reverse", !!revs->reverse,
+				  "--walk-reflogs", !!revs->reflog_info);
 
-	die_for_incompatible_opt2(!!revs->boundary, "--boundary",
-				  !!revs->maximal_only, "--maximal-only");
+	die_for_incompatible_opt2("--boundary", !!revs->boundary,
+				  "--maximal-only", !!revs->maximal_only);
 
 	if (revs->no_walk && revs->graph)
 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
-- 
2.55.0-862-g3c6f97f7b9

