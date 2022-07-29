Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5D76C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:30:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238825AbiG2TaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238813AbiG2T3v (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:51 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEE87AB2E
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:49 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id ay11-20020a05600c1e0b00b003a3013da120so4576219wmb.5
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dyhp7QpKAZesUxp8Eg1oJuLJ7RasqexTwL2exERL+QI=;
        b=EQ2ak1OzTNnJNWNWEYzBXM6kT8X2dtHt0BiWmuoL/bAtj+CZxEg+eNh1wWPP3+Bb9O
         +FIeoYs6GRl+aLAl9qCLKmyLGwgUiJVD3IoUdOT1kUR6aGXsaB2r02hJvrXOX12jYfOZ
         1q/q5S0eRAZw6nszBSlrdVpqdRdv05vqgjCUoCn9DRQwwu1ZlyuTruIpU9syJ0u/9Qrc
         zzlgpi1j3T2TuL2nGO2OAyPJrOq5m7410Z/ZC0aQ/MSxC/QOySHAyhJl+7czGi7V0yOw
         /P4pEduseJdiO3ZuxTnU+jI+LpvXIyYdZHCM8YJSwVJpp46oX3huitc6F7pfJlhcXDS+
         nyCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dyhp7QpKAZesUxp8Eg1oJuLJ7RasqexTwL2exERL+QI=;
        b=CtV+CyQvrFyb7yDwYVO5TIobIb2TF8KgTZKF3x05zIiJ38d3er5pafNr4hfk4TnwFx
         dwiqYIWXgQYpRYUdChvYBCEi7hwW0FpmFRZj2TteXIkOqzXwRkhYAvnAFtWiplrR0/rJ
         My55vI9rBRBUrIElRJ12Obz6K3bIT90lQUj8NeJtrywR0C1bd7exitaMEFFmEpFiIyCb
         JM0lKEVX5TfsaT78sD9mSbqYs0nJ7jxFIrignZip/iqFtIQTT9m7GWEfqGjOx3pwqN6W
         /m/vphm4uwBcG7H2ttw1ugI2HChusmjxOGdFwx8e0GIcTGlKDEsXRxznSGpVOO5Dl7iX
         xMBA==
X-Gm-Message-State: AJIora/JScGkO5WPDYgcgDm053rMfNOoyH2TPkghGHd59/CXE+wvth8f
        rQ4cy+1qTySPlEJnQhSF2G+ZtfPPjkA=
X-Google-Smtp-Source: AGRyM1vgNPiIVYjoSFKdAfZXK9J9dgFhCMyEIKBsvzSL4f0CtSxOB6XMRZIrl6js0pmPFVfHV1H8Qg==
X-Received: by 2002:a05:600c:a18e:b0:3a3:4068:d845 with SMTP id id14-20020a05600ca18e00b003a34068d845mr3333198wmb.15.1659122987594;
        Fri, 29 Jul 2022 12:29:47 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a4-20020adffb84000000b0021e51c039c5sm4462694wrr.80.2022.07.29.12.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:47 -0700 (PDT)
Message-Id: <bec532fb8c63b3ae784d442f438687a4f0bbad37.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:35 +0000
Subject: [PATCH v2 06/10] log: add default decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

When a user runs 'git log', they expect a certain set of helpful
decorations. This includes:

* The HEAD ref
* Branches (refs/heads/)
* Stashes (refs/stash)
* Tags (refs/tags/)
* Remote branches (refs/remotes/)
* Replace refs (refs/replace/ or $GIT_REPLACE_REF_BASE)

Each of these namespaces was selected due to existing test cases that
verify these namespaces appear in the decorations. In particular,
stashes and replace refs can have custom colors from the
color.decorate.<slot> config option.

While one test checks for a decoration from notes, it only applies to
the tip of refs/notes/commit (or its configured ref name). Notes form
their own kind of decoration instead. Modify the expected output for the
tests in t4013 that expect this note decoration.  There are several
tests throughout the codebase that verify that --decorate-refs,
--decorate-refs-exclude, and log.excludeDecoration work as designed and
the tests continue to pass without intervention.

However, there are other refs that are less helpful to show as
decoration:

* Prefetch refs (refs/prefetch/)
* Rebase refs (refs/rebase-merge/ and refs/rebase-apply/)
* Bundle refs (refs/bundle/) [!]

[!] The bundle refs are part of a parallel series that bootstraps a repo
    from a bundle file, storing the bundle's refs into the repo's
    refs/bundle/ namespace.

In the case of prefetch refs, 96eaffebbf3d0 (maintenance: set
log.excludeDecoration durin prefetch, 2021-01-19) added logic to add
refs/prefetch/ to the log.excludeDecoration config option. Additional
feedback pointed out that having such a side-effect can be confusing and
perhaps not helpful to users. Instead, we should hide these ref
namespaces that are being used by Git for internal reasons but are not
helpful for the users to see.

The way to provide a seamless user experience without setting the config
is to modify the default decoration filters to match our expectation of
what refs the user actually wants to see.

In builtin/log.c, after parsing the --decorate-refs and
--decorate-refs-exclude options from the command-line, call
set_default_decoration_filter(). This method populates the exclusions
from log.excludeDecoration, then checks if the list of pattern
modifications are empty. If none are specified, then the default set is
restricted to the set of inclusions mentioned earlier (HEAD, branches,
etc.).  A previous change introduced the ref_namespaces array, which
includes all of these currently-used namespaces. The 'decoration' value
is non-zero when that namespace is associated with a special coloring
and fits into the list of "expected" decorations as described above,
which makes the implementation of this filter very simple.

Note that the logic in ref_filter_match() in log-tree.c follows this
matching pattern:

 1. If there are exclusion patterns and the ref matches one, then ignore
    the decoration.

 2. If there are inclusion patterns and the ref matches one, then
    definitely include the decoration.

 3. If there are config-based exclusions from log.excludeDecoration and
    the ref matches one, then ignore the decoration.

With this logic in mind, we need to ensure that we do not populate our
new defaults if any of these filters are manually set. Specifically, if
a user runs

	git -c log.excludeDecoration=HEAD log

then we expect the HEAD decoration to not appear. If we left the default
inclusions in the set, then HEAD would match that inclusion before
reaching the config-based exclusions.

A potential alternative would be to check the list of default inclusions
at the end, after the config-based exclusions. This would still create a
behavior change for some uses of --decorate-refs-exclude=<X>, and could
be overwritten somewhat with --decorate-refs=refs/ and
--decorate-refs=HEAD. However, it no longer becomes possible to include
refs outside of the defaults while also excluding some using
log.excludeDecoration.

Another alternative would be to exclude the known namespaces that are
not intended to be shown. This would reduce the visible effect of the
change for expert users who use their own custom ref namespaces. The
implementation change would be very simple to swap due to our use of
ref_namespaces:

	int i;
	struct string_list *exclude = decoration_filter->exclude_ref_pattern;

	/*
	 * No command-line or config options were given, so
	 * populate with sensible defaults.
	 */
	for (i = 0; i < NAMESPACE__COUNT; i++) {
		if (ref_namespaces[i].decoration)
			continue;

		string_list_append(exclude, ref_namespaces[i].ref);
	}

The main downside of this approach is that we expect to add new hidden
namespaces in the future, and that means that Git versions will be less
stable in how they behave as those namespaces are added.

It is critical that we provide ways for expert users to disable this
behavior change via command-line options and config keys. These changes
will be implemented in a future change.

Add a test that checks that the defaults are not added when
--decorate-refs is specified. We verify this by showing that HEAD is not
included as it normally would.  Also add a test that shows that the
default filter avoids the unwanted decorations from refs/prefetch,
refs/rebase-merge,
and refs/bundle.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 Documentation/git-log.txt              |  7 ++--
 builtin/log.c                          | 50 +++++++++++++++++++-------
 t/t4013/diff.log_--decorate=full_--all |  2 +-
 t/t4013/diff.log_--decorate_--all      |  2 +-
 t/t4202-log.sh                         | 22 ++++++++++++
 5 files changed, 66 insertions(+), 17 deletions(-)

diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index 20e87cecf49..b2ac89dfafc 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -45,13 +45,16 @@ OPTIONS
 
 --decorate-refs=<pattern>::
 --decorate-refs-exclude=<pattern>::
-	If no `--decorate-refs` is given, pretend as if all refs were
-	included.  For each candidate, do not use it for decoration if it
+	For each candidate reference, do not use it for decoration if it
 	matches any patterns given to `--decorate-refs-exclude` or if it
 	doesn't match any of the patterns given to `--decorate-refs`. The
 	`log.excludeDecoration` config option allows excluding refs from
 	the decorations, but an explicit `--decorate-refs` pattern will
 	override a match in `log.excludeDecoration`.
++
+If none of these options or config settings are given, then references are
+used as decoration if they match `HEAD`, `refs/heads/`, `refs/remotes/`,
+`refs/stash/`, or `refs/tags/`.
 
 --source::
 	Print out the ref name given on the command line by which each
diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..0b5efc9434c 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -162,6 +162,37 @@ static void cmd_log_init_defaults(struct rev_info *rev)
 		parse_date_format(default_date_mode, &rev->date_mode);
 }
 
+static void set_default_decoration_filter(struct decoration_filter *decoration_filter)
+{
+	int i;
+	struct string_list *include = decoration_filter->include_ref_pattern;
+	const struct string_list *config_exclude =
+			git_config_get_value_multi("log.excludeDecoration");
+
+	if (config_exclude) {
+		struct string_list_item *item;
+		for_each_string_list_item(item, config_exclude)
+			string_list_append(decoration_filter->exclude_ref_config_pattern,
+					   item->string);
+	}
+
+	if (decoration_filter->exclude_ref_pattern->nr ||
+	    decoration_filter->include_ref_pattern->nr ||
+	    decoration_filter->exclude_ref_config_pattern->nr)
+		return;
+
+	/*
+	 * No command-line or config options were given, so
+	 * populate with sensible defaults.
+	 */
+	for (i = 0; i < NAMESPACE__COUNT; i++) {
+		if (!ref_namespaces[i].decoration)
+			continue;
+
+		string_list_append(include, ref_namespaces[i].ref);
+	}
+}
+
 static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 			 struct rev_info *rev, struct setup_revision_opt *opt)
 {
@@ -171,9 +202,11 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	static struct string_list decorate_refs_exclude = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_exclude_config = STRING_LIST_INIT_NODUP;
 	static struct string_list decorate_refs_include = STRING_LIST_INIT_NODUP;
-	struct decoration_filter decoration_filter = {&decorate_refs_include,
-						      &decorate_refs_exclude,
-						      &decorate_refs_exclude_config};
+	struct decoration_filter decoration_filter = {
+		.exclude_ref_pattern = &decorate_refs_exclude,
+		.include_ref_pattern = &decorate_refs_include,
+		.exclude_ref_config_pattern = &decorate_refs_exclude_config,
+	};
 	static struct revision_sources revision_sources;
 
 	const struct option builtin_log_options[] = {
@@ -265,16 +298,7 @@ static void cmd_log_init_finish(int argc, const char **argv, const char *prefix,
 	}
 
 	if (decoration_style || rev->simplify_by_decoration) {
-		const struct string_list *config_exclude =
-			repo_config_get_value_multi(the_repository,
-						    "log.excludeDecoration");
-
-		if (config_exclude) {
-			struct string_list_item *item;
-			for_each_string_list_item(item, config_exclude)
-				string_list_append(&decorate_refs_exclude_config,
-						   item->string);
-		}
+		set_default_decoration_filter(&decoration_filter);
 
 		if (decoration_style)
 			rev->show_decorations = 1;
diff --git a/t/t4013/diff.log_--decorate=full_--all b/t/t4013/diff.log_--decorate=full_--all
index 3f9b872eceb..6b0b334a5d6 100644
--- a/t/t4013/diff.log_--decorate=full_--all
+++ b/t/t4013/diff.log_--decorate=full_--all
@@ -20,7 +20,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
 
diff --git a/t/t4013/diff.log_--decorate_--all b/t/t4013/diff.log_--decorate_--all
index f5e20e1e14a..c7df1f58141 100644
--- a/t/t4013/diff.log_--decorate_--all
+++ b/t/t4013/diff.log_--decorate_--all
@@ -20,7 +20,7 @@ Date:   Mon Jun 26 00:06:00 2006 +0000
 
     Rearranged lines in dir/sub
 
-commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0 (refs/notes/commits)
+commit cbacedd14cb8b89255a2c02b59e77a2e9a8021a0
 Author: A U Thor <author@example.com>
 Date:   Mon Jun 26 00:06:00 2006 +0000
 
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6b7d8e269f7..9ea9e835d43 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1031,6 +1031,12 @@ test_expect_success 'decorate-refs-exclude HEAD' '
 	! grep HEAD actual
 '
 
+test_expect_success 'decorate-refs focus from default' '
+	git log --decorate=full --oneline \
+		--decorate-refs="refs/heads" >actual &&
+	! grep HEAD actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
@@ -2198,6 +2204,22 @@ test_expect_success 'log --decorate includes all levels of tag annotated tags' '
 	test_cmp expect actual
 '
 
+test_expect_success 'log --decorate does not include things outside filter' '
+	reflist="refs/prefetch refs/rebase-merge refs/bundle" &&
+
+	for ref in $reflist
+	do
+		git update-ref $ref/fake HEAD || return 1
+	done &&
+
+	git log --decorate=full --oneline >actual &&
+
+	for ref in $reflist
+	do
+		! grep $ref/fake actual || return 1
+	done
+'
+
 test_expect_success 'log --end-of-options' '
        git update-ref refs/heads/--source HEAD &&
        git log --end-of-options --source >actual &&
-- 
gitgitgadget

