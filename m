Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D62D17BA1
	for <git@vger.kernel.org>; Sun,  3 Aug 2025 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754233311; cv=pass; b=A1ngFHh1VpffPja+zfvpvO/GY2U/6l0RfmhcdBdYUXjMdY7NgCETkUR6Yo/PAmh/s5kMPojKR7kxfxt6YZcuKQQ5YJQgn7dW8q88jPVbaW5J8T5MCbsCWYczP3emM8aOehz+ZxwtM07nnYNg4eTZk8nQd+Y4Pp0IgIgs6DV4m3o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754233311; c=relaxed/simple;
	bh=G4N8ZKBd51scuaoIINLjOuHbiLS+rKJniFyCrnU5i84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IzPZznGRfr0zzXJAiaW3z2zY/6rJveAwSWSZ0JRfzsHNZXZa1CnGk7mWBMMTqsD/oseyV7uhIT068tPwQYwyNfPBbLoed/jMV3tm9vfvmBe6BraFLkVNvzpBZ15JbLowgKjTqO/6NvrIWe8bbXZdgNpgLQP9xm/ocnpwA3D+gHY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty; spf=pass smtp.mailfrom=linux.beauty; dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b=HywLgtKM; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux.beauty
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.beauty
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.beauty header.i=me@linux.beauty header.b="HywLgtKM"
ARC-Seal: i=1; a=rsa-sha256; t=1754233282; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Bce9GcwimeTsVu0MgcohZVHH+IsmvMVBcBZDQ1QL/tgMFyrwc33ewC4e/49+mxykEq8r9MF7m45BxIv2zUDAKM9ekPsV7e2At7ukNPfJV4NB+/N9Lr2TYK3eOwNes+o3j6o+DjPrcU0n2PmhVXf8GH3WYnYP43eSGkjdpiAsous=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1754233282; h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc; 
	bh=JdhrZEVrPbULcWN5hwzg2Xc4d4zVqJTeLMS0MqsU2kQ=; 
	b=MoGwcbHGSVqjIDZmLP9av7jPtVgo8VPtSATqeXCIe2PSANgsbduitA7aRnQbH1I1Ux7gtKM6fRUVnpvAcVz6BDbLuXbKDzyjFCjO6v1YpcQ7X9ymjM/U32YVGzjVQu6s4D8VjWT3uNm3p18t4aBX4/RCLZgZ7bX/zuvEqUb6wA0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=linux.beauty;
	spf=pass  smtp.mailfrom=me@linux.beauty;
	dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1754233282;
	s=zmail; d=linux.beauty; i=me@linux.beauty;
	h=From:From:To:To:Subject:Subject:Date:Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
	bh=JdhrZEVrPbULcWN5hwzg2Xc4d4zVqJTeLMS0MqsU2kQ=;
	b=HywLgtKMZMCf18qo4T6OWH4JDKqO3vlTH870MPyfDY6JT0COSQIFMUtJrXO0y9QQ
	z0RHlj2fH+XsV7S5IEA/baHC+Mx8I5kbVQF+9FX75eUNFXHr9nX9w488N30M+Yl3fjd
	bYqzGwjTfWNogFUuoM+J28ZHPGgAtbxznrymFRfk=
Received: by mx.zohomail.com with SMTPS id 1754233271715591.2799346379745;
	Sun, 3 Aug 2025 08:01:11 -0700 (PDT)
From: Li Chen <me@linux.beauty>
To: "phillipwood" <phillip.wood@dunelm.org.uk>,
	"git" <git@vger.kernel.org>,
	"Junio C Hamano" <gitster@pobox.com>
Subject: [PATCH v3 2/2] rebase: support --trailer
Date: Sun,  3 Aug 2025 23:00:57 +0800
Message-ID: <20250803150059.402017-3-me@linux.beauty>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250803150059.402017-1-me@linux.beauty>
References: <20250803150059.402017-1-me@linux.beauty>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

From: Li Chen <chenl311@chinatelecom.cn>

Implement a new `--trailer <text>` option for `git rebase`
(support merge backend only now), which appends arbitrary
trailer lines to each rebased commit message. Reject early
if used with the apply backend (git am) since it lacks
message‑filter/trailer hook. Automatically set REBASE_FORCE when
any trailer is supplied.

And reject invalid input before user edit the interactive file.

Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
---
 Documentation/git-rebase.adoc |  7 +++
 builtin/rebase.c              | 98 +++++++++++++++++++++++++++++++++++
 sequencer.c                   | 13 +++++
 sequencer.h                   |  3 ++
 t/meson.build                 |  1 +
 t/t3440-rebase-trailer.sh     | 95 +++++++++++++++++++++++++++++++++
 6 files changed, 217 insertions(+)
 create mode 100755 t/t3440-rebase-trailer.sh

diff --git a/Documentation/git-rebase.adoc b/Documentation/git-rebase.adoc
index 956d3048f5..df8fb97526 100644
--- a/Documentation/git-rebase.adoc
+++ b/Documentation/git-rebase.adoc
@@ -521,6 +521,13 @@ See also INCOMPATIBLE OPTIONS below.
 	that if `--interactive` is given then only commits marked to be
 	picked, edited or reworded will have the trailer added.
 +
+--trailer <trailer>::
+       Append the given trailer line(s) to every rebased commit
+       message, processed via linkgit:git-interpret-trailers[1].
+       When this option is present *rebase automatically enables*
+       `--force-rebase` so that fast‑forwarded commits are also
+       rewritten.
+
 See also INCOMPATIBLE OPTIONS below.
 
 -i::
diff --git a/builtin/rebase.c b/builtin/rebase.c
index e90562a3b8..3b4c45a616 100644
--- a/builtin/rebase.c
+++ b/builtin/rebase.c
@@ -36,6 +36,8 @@
 #include "reset.h"
 #include "trace2.h"
 #include "hook.h"
+#include "trailer.h"
+#include "parse-options.h"
 
 static char const * const builtin_rebase_usage[] = {
 	N_("git rebase [-i] [options] [--exec <cmd>] "
@@ -113,6 +115,7 @@ struct rebase_options {
 	enum action action;
 	char *reflog_action;
 	int signoff;
+	struct strvec trailer_args;
 	int allow_rerere_autoupdate;
 	int keep_empty;
 	int autosquash;
@@ -143,6 +146,7 @@ struct rebase_options {
 		.flags = REBASE_NO_QUIET, 		\
 		.git_am_opts = STRVEC_INIT,		\
 		.exec = STRING_LIST_INIT_NODUP,		\
+		.trailer_args = STRVEC_INIT,  \
 		.git_format_patch_opt = STRBUF_INIT,	\
 		.fork_point = -1,			\
 		.reapply_cherry_picks = -1,             \
@@ -166,6 +170,7 @@ static void rebase_options_release(struct rebase_options *opts)
 	free(opts->strategy);
 	string_list_clear(&opts->strategy_opts, 0);
 	strbuf_release(&opts->git_format_patch_opt);
+	strvec_clear(&opts->trailer_args);
 }
 
 static struct replay_opts get_replay_opts(const struct rebase_options *opts)
@@ -177,6 +182,10 @@ static struct replay_opts get_replay_opts(const struct rebase_options *opts)
 	sequencer_init_config(&replay);
 
 	replay.signoff = opts->signoff;
+
+	for (size_t i = 0; i < opts->trailer_args.nr; i++)
+		strvec_push(&replay.trailer_args, opts->trailer_args.v[i]);
+
 	replay.allow_ff = !(opts->flags & REBASE_FORCE);
 	if (opts->allow_rerere_autoupdate)
 		replay.allow_rerere_auto = opts->allow_rerere_autoupdate;
@@ -435,6 +444,8 @@ static int read_basic_state(struct rebase_options *opts)
 	struct strbuf head_name = STRBUF_INIT;
 	struct strbuf buf = STRBUF_INIT;
 	struct object_id oid;
+	const char trailer_state_name[] = "trailer";
+	const char *path = state_dir_path(trailer_state_name, opts);
 
 	if (!read_oneliner(&head_name, state_dir_path("head-name", opts),
 			   READ_ONELINER_WARN_MISSING) ||
@@ -503,11 +514,31 @@ static int read_basic_state(struct rebase_options *opts)
 
 	strbuf_release(&buf);
 
+	if (strbuf_read_file(&buf, path, 0) >= 0) {
+		const char *p = buf.buf, *end = buf.buf + buf.len;
+
+		while (p < end) {
+			char *nl = memchr(p, '\n', end - p);
+			if (!nl)
+				die("nl shouldn't be NULL");
+			*nl = '\0';
+
+			if (*p)
+				strvec_push(&opts->trailer_args, p);
+
+			p = nl + 1;
+		}
+		strbuf_release(&buf);
+	}
+	strbuf_release(&buf);
+
 	return 0;
 }
 
 static int rebase_write_basic_state(struct rebase_options *opts)
 {
+	const char trailer_state_name[] = "trailer";
+
 	write_file(state_dir_path("head-name", opts), "%s",
 		   opts->head_name ? opts->head_name : "detached HEAD");
 	write_file(state_dir_path("onto", opts), "%s",
@@ -529,6 +560,22 @@ static int rebase_write_basic_state(struct rebase_options *opts)
 	if (opts->signoff)
 		write_file(state_dir_path("signoff", opts), "--signoff");
 
+    /*
+     * save opts->trailer_args into state_dir/trailer
+     */
+    if (opts->trailer_args.nr) {
+            struct strbuf buf = STRBUF_INIT;
+            size_t i;
+
+            for (i = 0; i < opts->trailer_args.nr; i++) {
+                    strbuf_addstr(&buf, opts->trailer_args.v[i]);
+                    strbuf_addch(&buf, '\n');
+            }
+            write_file(state_dir_path(trailer_state_name, opts),
+                       "%s", buf.buf);
+            strbuf_release(&buf);
+    }
+
 	return 0;
 }
 
@@ -1085,6 +1132,37 @@ static int check_exec_cmd(const char *cmd)
 	return 0;
 }
 
+static int validate_trailer_args_after_config(const struct strvec *cli_args,
+				       struct strbuf *err)
+{
+	size_t i;
+
+	for (i = 0; i < cli_args->nr; i++) {
+		const char *raw = cli_args->v[i];
+		const char *txt; // Key[:=]Val
+		const char *sep;
+
+		if (!skip_prefix(raw, "--trailer=", &txt))
+			txt = raw;
+
+		if (!*txt) {
+			strbuf_addstr(err, _("empty --trailer argument"));
+			return -1;
+		}
+
+		sep = strpbrk(txt, ":=");
+
+		/* there must be key bfore seperator */
+		if (sep && sep == txt) {
+			strbuf_addf(err,
+				    _("invalid trailer '%s': missing key before separator"),
+				    txt);
+			return -1;
+		}
+	}
+	return 0;
+}
+
 int cmd_rebase(int argc,
 	       const char **argv,
 	       const char *prefix,
@@ -1133,6 +1211,7 @@ int cmd_rebase(int argc,
 			.flags = PARSE_OPT_NOARG,
 			.defval = REBASE_DIFFSTAT,
 		},
+		OPT_STRVEC(0, "trailer", &options.trailer_args, N_("trailer"), N_("add custom trailer(s)")),
 		OPT_BOOL(0, "signoff", &options.signoff,
 			 N_("add a Signed-off-by trailer to each commit")),
 		OPT_BOOL(0, "committer-date-is-author-date",
@@ -1283,6 +1362,17 @@ int cmd_rebase(int argc,
 			     builtin_rebase_options,
 			     builtin_rebase_usage, 0);
 
+    /* if add --trailer，force rebase */
+	if (options.trailer_args.nr) {
+        struct strbuf err = STRBUF_INIT;
+
+		if (validate_trailer_args_after_config(&options.trailer_args, &err))
+			die("%s", err.buf);
+
+        options.flags |= REBASE_FORCE;
+        strbuf_release(&err);
+	}
+
 	if (preserve_merges_selected)
 		die(_("--preserve-merges was replaced by --rebase-merges\n"
 			"Note: Your `pull.rebase` configuration may also be set to 'preserve',\n"
@@ -1540,6 +1630,14 @@ int cmd_rebase(int argc,
 	if (options.root && !options.onto_name)
 		imply_merge(&options, "--root without --onto");
 
+	/*
+	 * The apply‑based backend (git am) cannot append trailers because
+	 * it lacks a message‑filter facility.  Reject early, before any
+	 * state (index, HEAD, etc.) is modified.
+	 */
+	if (options.trailer_args.nr)
+		imply_merge(&options, "--trailer");
+
 	if (isatty(2) && options.flags & REBASE_NO_QUIET)
 		strbuf_addstr(&options.git_format_patch_opt, " --progress");
 
diff --git a/sequencer.c b/sequencer.c
index 67e4310edc..58faf6aed5 100644
--- a/sequencer.c
+++ b/sequencer.c
@@ -422,6 +422,7 @@ void replay_opts_release(struct replay_opts *opts)
 	free(opts->revs);
 	replay_ctx_release(ctx);
 	free(opts->ctx);
+	strvec_clear(&opts->trailer_args);
 }
 
 int sequencer_remove_state(struct replay_opts *opts)
@@ -2529,6 +2530,18 @@ static int do_pick_commit(struct repository *r,
 			_("dropping %s %s -- patch contents already upstream\n"),
 			oid_to_hex(&commit->object.oid), msg.subject);
 	} /* else allow == 0 and there's nothing special to do */
+
+    if (!res && opts->trailer_args.nr && !drop_commit) {
+            const char *trailer_file =
+                    msg_file ? msg_file : git_path_merge_msg(r);
+
+            if (amend_file_with_trailers(trailer_file,
+                                         &opts->trailer_args)) {
+                    res = error(_("unable to add trailers to commit message"));
+                    goto leave;
+            }
+    }
+
 	if (!opts->no_commit && !drop_commit) {
 		if (author || command == TODO_REVERT || (flags & AMEND_MSG))
 			res = do_commit(r, msg_file, author, reflog_action,
diff --git a/sequencer.h b/sequencer.h
index 304ba4b4d3..28f2da6375 100644
--- a/sequencer.h
+++ b/sequencer.h
@@ -4,6 +4,7 @@
 #include "strbuf.h"
 #include "strvec.h"
 #include "wt-status.h"
+#include <stddef.h>
 
 struct commit;
 struct index_state;
@@ -44,6 +45,7 @@ struct replay_opts {
 	int record_origin;
 	int no_commit;
 	int signoff;
+	struct strvec trailer_args;
 	int allow_ff;
 	int allow_rerere_auto;
 	int allow_empty;
@@ -86,6 +88,7 @@ struct replay_opts {
 	.action = -1,				\
 	.xopts = STRVEC_INIT,			\
 	.ctx = replay_ctx_new(),		\
+	.trailer_args = STRVEC_INIT, \
 }
 
 /*
diff --git a/t/meson.build b/t/meson.build
index 09f3068f98..3c58f562da 100644
--- a/t/meson.build
+++ b/t/meson.build
@@ -373,6 +373,7 @@ integration_tests = [
   't3436-rebase-more-options.sh',
   't3437-rebase-fixup-options.sh',
   't3438-rebase-broken-files.sh',
+  't3440-rebase-trailer.sh',
   't3500-cherry.sh',
   't3501-revert-cherry-pick.sh',
   't3502-cherry-pick-merge.sh',
diff --git a/t/t3440-rebase-trailer.sh b/t/t3440-rebase-trailer.sh
new file mode 100755
index 0000000000..a580449628
--- /dev/null
+++ b/t/t3440-rebase-trailer.sh
@@ -0,0 +1,95 @@
+#!/bin/sh
+#
+
+test_description='git rebase --trailer integration tests
+We verify that --trailer on the merge/interactive/exec/root backends,
+and that it is rejected early when the apply backend is requested.'
+
+GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
+export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
+
+. ./test-lib.sh
+. "$TEST_DIRECTORY"/lib-rebase.sh # test_commit_message, helpers
+
+create_expect() {
+	cat >"$1" <<-EOF
+		$2
+
+		Reviewed-by: Dev <dev@example.com>
+	EOF
+}
+
+test_expect_success 'setup repo with a small history' '
+	git commit --allow-empty -m "Initial empty commit" &&
+	test_commit first file a &&
+	test_commit second file &&
+	git checkout -b conflict-branch first &&
+	test_commit file-2 file-2 &&
+	test_commit conflict file &&
+	test_commit third file &&
+	ident="$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>" &&
+	create_expect initial-signed  "Initial empty commit" &&
+	create_expect first-signed    "first"                 &&
+	create_expect second-signed   "second"                &&
+	create_expect file2-signed    "file-2"                &&
+	create_expect third-signed    "third"                 &&
+	create_expect conflict-signed "conflict"
+'
+
+test_expect_success 'apply backend is rejected with --trailer' '
+	git reset --hard third &&
+	head_before=$(git rev-parse HEAD) &&
+    test_expect_code 128 \
+    		git rebase --apply --trailer "Reviewed-by: Dev <dev@example.com>" \
+    			HEAD^ 2>err &&
+	test_grep "requires the merge backend" err &&
+	test_cmp_rev HEAD $head_before
+'
+
+test_expect_success 'reject empty --trailer argument' '
+        git reset --hard third &&
+        test_expect_code 128 git rebase -m --trailer "" HEAD^ 2>err &&
+        test_grep "empty --trailer" err
+'
+
+test_expect_success 'reject trailer with missing key before separator' '
+        git reset --hard third &&
+        test_expect_code 128 git rebase -m --trailer ": no-key" HEAD^ 2>err &&
+        test_grep "missing key before separator" err
+'
+
+test_expect_success 'CLI trailer duplicates allowed; replace policy keeps last' '
+        git reset --hard third &&
+        git -c trailer.Bug.ifexists=replace -c trailer.Bug.ifmissing=add rebase -m --trailer "Bug: 123" --trailer "Bug: 456" HEAD~1 &&
+        git cat-file commit HEAD | grep "^Bug: 456" &&
+        git cat-file commit HEAD | grep -v "^Bug: 123"
+'
+
+test_expect_success 'multiple Signed-off-by trailers all preserved' '
+        git reset --hard third &&
+        git rebase -m \
+            --trailer "Signed-off-by: Dev A <a@ex.com>" \
+            --trailer "Signed-off-by: Dev B <b@ex.com>" HEAD~1 &&
+        git cat-file commit HEAD | grep -c "^Signed-off-by:" >count &&
+        test "$(cat count)" = 2   # two new commits
+'
+
+test_expect_success 'rebase -m --trailer adds trailer after conflicts' '
+	git reset --hard third &&
+	test_must_fail git rebase -m \
+		--trailer "Reviewed-by: Dev <dev@example.com>" \
+		second third &&
+	git checkout --theirs file &&
+	git add file &&
+    git rebase --continue &&
+	test_commit_message HEAD~2 file2-signed
+'
+
+test_expect_success 'rebase --root --trailer updates every commit' '
+	git checkout first &&
+	git rebase --root --keep-empty \
+		--trailer "Reviewed-by: Dev <dev@example.com>" &&
+	test_commit_message HEAD   first-signed &&
+	test_commit_message HEAD^  initial-signed
+'
+test_done
-- 
2.50.0

