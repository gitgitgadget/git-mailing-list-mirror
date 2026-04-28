Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6660E2F25F4
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415285; cv=none; b=uecbffZHyXJEGB8mRrvfmdNOd7/AxeNWNO32m3x+rTN871yCDRwKqzUwiMbh1Z4DAG/MFCtdG1znhOpg1YwbIHXaHhRPXkmJQ7VaO/xS8C9UJF9057VA137gbKMp2ocOHeCsxAbJr8J9COgsxDsgIJEpCaeGfbS1gTYOgCzU2As=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415285; c=relaxed/simple;
	bh=Ik7klY3GFQUIgQjBg1f3s/1dG7wO5WMEHl9ZBLxSPP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2AQjCGla0AEYezGhen8IwJBqJwB4SyTmFoDu74Jsy/Kk9D42PFccstBf6pjf3TQ5P3+YoN9fRBGbfWkFp8FNNV6qUsz/l3y6qLr/3gSEk4b+PFzR8FnlWUz+jKUVD2H20ZplJxABL7+Fg8oRRMCtPWC4ccyBVz3XJDqUkb8Z2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=S2EoxH/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=p0ZTu5jp; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="S2EoxH/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="p0ZTu5jp"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id B7DC91D00178;
	Tue, 28 Apr 2026 18:28:02 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Tue, 28 Apr 2026 18:28:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777415282;
	 x=1777501682; bh=Evkpo17dPeCezayRZ7yKEWwPPDmXNRrALL1qtqiJIAk=; b=
	S2EoxH/cAY5bbWunDVk4BFzA5duCu8pZiHL0+VsS+MZzjTI2CS/5vTCbRzSX0HZA
	ieLDD6PRu6wLzBUmUmd6s/ILXuAy6gDzP4aSTzc/XAs57FUPh/vaLaCDtFaojr/B
	DzkO+nfVSYIs1elGHKvAGUb92q9Cbh6IFSTnW34T6+mWL4EL5GHV69Kvm829YndQ
	5W9I7dNWkHzuJZ3qA1vhrUqgMmY2rH3uqofpkvGBr/1JxL+n0f7wXtns6qjK5yUo
	ebzdkVIg0rxOoipTv8aaMQ9ZOeBohrH9FN6NR5VFjCxL5ooeeQA18yH/g2Plm1yU
	RyPA3yjBwHbwx/3cgvp6BA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777415282; x=
	1777501682; bh=Evkpo17dPeCezayRZ7yKEWwPPDmXNRrALL1qtqiJIAk=; b=p
	0ZTu5jpEihxHJ2VLJT/BoMgDverVByIqQY8rtwPjtHs6Gwh304iA+HvxzIWAhqwo
	1qZPEM+8Of0j0nZaDsPchPrapcDYbKKcZib4hx3gior2MB083wVkVzhvtRMCbcIf
	dpbx78luY+fQaCDsGH/cUNWW14pdXO1SNYFELTxwhNOOgV4OfijRhvBEM9hzFeOk
	7gaLlvLzkdHSKQ8k/BGKu4/20L/HpwQw0nc1SGJHZO2iMWjN7EjOOpVmupXVlAhT
	Tnl9swPjyjZoery9T90LRJo1K9nUbCCQM94f0JQH+slrJ92PFaqZ0+62WmDEpZru
	GdSB6c8KPArh8orBDdgkw==
X-ME-Sender: <xms:cjTxaZNfeW65uWROOIJNdspzJyMTuCs6jdx9ZlnyUdeo3b2YmNlh0CA>
    <xme:cjTxaTa74Vzvc6wPmLJgn98FPGuV_pscUoip9CBxXBOpCMM9XT9VW-49-UMw5eG3r
    uBYxngStQPugz3D09V3T3odC7gPA584KF1Dqmx9T9SWm0Lx9aGl>
X-ME-Received: <xmr:cjTxaVpClfgMUgPjKl_a2edtkS4PhmRFn3P7e23B9N0g9rvTQdreoR3F07TIgTvLxrHOhwSn1qS8f8_mrM58P24_w29jUUbXpatxiUP4tep-5OPNOn_5cj-Urw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdekvdejiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecufghrlhcuvffnffculddvfedmnecujfgurhephffvvefuff
    fkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhenucggtffrrghtthgvrhhnpefhkeekue
    eifeffudegueelgeetjeffgeevtdelhfduteegjefhfeelkedugeduteenucffohhmrghi
    nhepkhgvrhhnvghlrdhorhhgpdgtthigrdgurghtvgenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishhtohhffhgvrhhhrghughhssggr
    khhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehsmh
    htphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvgdprhgtphhtthhopegsvg
    hnrdhknhhosghlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:cjTxafaf7BBZaduEsx1x262ShzkVtBj_o_37lOCFmexxgSIM0VcGxg>
    <xmx:cjTxaVSboAGwi341wK6vv-RO0HTdQWh1uTaHliT0bHh2rT9v7kbFNg>
    <xmx:cjTxae4b8RDsSk5-4JtQgxpy0INQmz8dIc0BvGLWRAJkrHSKe5f8nw>
    <xmx:cjTxaSzC-2YLgS2B9Yw3XujghdNC6yLmPlsAU4Axm8b876ePIWN3pQ>
    <xmx:cjTxafZEXwtxR6BcbNcM7WHq6aBO5HaoG2vpAdadbC9Pnwk2I0wAc7ft>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:28:01 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 5/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Wed, 29 Apr 2026 00:25:56 +0200
Message-ID: <V3_format-rev_new_builtin.66f@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz> <V3_CV_format-rev.66a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

Introduce a new builtin for pretty formatting one revision expression
per line or commit object names found in running text.

Sometimes you want to format commits. Most of the time you’re
walking the graph, e.g. getting a range of commits like
`master..topic`. That’s a job for git-log(1).

But there are times when you want to format commits that you encounter
on demand:

• Full hashes in running text that you might want to pretty-print
• git-last-modified(1) outputs full hashes that you can do the same
  with
• git-cherry(1) has `-v` for commit subject, but maybe you want
  something else?

But now you can’t use git-log(1), git-show(1), or git-rev-list(1):

• You can’t feed commits piecemeal to these commands, one input
  for one output; they block until standard in is closed
• You can’t feed a list of possibly duplicate commits, like the output
  of git-last-modified(1); they effectively deduplicate the output

Beyond these two points there’s also the input massage problem: you
cannot feed mixed input (revisions mixed with arbitrary text).

One might hope that git-cat-file(1) can save us. But it doesn’t
support pretty formats.

But there is one command that already both handles revisions as
arguments, revisions on standard input, and even revisions mixed in
with arbitrary text. Namely git-name-rev(1): the command for outputting
symbolic names for commits.

We made some room in `builtin/name-rev.c` two commits ago. Let’s
now add this new git-format-rev(1) command. Taking inspiration from
git-name-rev(1), there are two modes:

• revs: like git-name-rev(1) in argv mode, but one revision per line
  on standard in
• text: like git-name-rev(1) with `--annotate-stdin`

***

We need to add this command to the exception list in
`t/t1517-outside-repo.sh` because it uses “EXPERIMENTAL!”
in the usage line.

Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v3:
    • And don’t forget to document --notes this time
    
          https://lore.kernel.org/git/CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com/

 Documentation/git-format-rev.adoc | 148 ++++++++++++++++++++++++
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/name-rev.c                | 186 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 git.c                             |   1 +
 t/t1517-outside-repo.sh           |   3 +-
 t/t6120-describe.sh               | 104 +++++++++++++++++
 8 files changed, 444 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-format-rev.adoc

diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
new file mode 100644
index 00000000000..d960001d750
--- /dev/null
+++ b/Documentation/git-format-rev.adoc
@@ -0,0 +1,148 @@
+git-format-rev(1)
+=================
+
+NAME
+----
+git-format-rev - EXPERIMENTAL: Pretty format revisions on demand
+
+
+SYNOPSIS
+--------
+[synopsis]
+(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]
+
+DESCRIPTION
+-----------
+
+Pretty format revisions from standard input.
+
+THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
+
+OPTIONS
+-------
+
+`--stdin-mode=<mode>`::
+	How to interpret standard input data:
++
+--
+`revs`:: Each line is interpreted as a commit. Any kind of revision
+	expression can be used (see linkgit:gitrevisions[7]). Annotated
+	tags are peeled (see linkgit:gitglossary[7]).
++
+The argument `rev` is also accepted.
+`text`:: Formats all commit object names found in freeform text. These
+	must the full object names, i.e. abbreviated hexidecimal object
+	names will not be interpreted.
+--
+
+`--format=<pretty>`::
+	Pretty format string.
+
+`--notes=<ref>`::
+`--no-notes`::
+	Custom notes ref. Notes are displayed when using the `%N`
+	atom. See linkgit:git-notes[1].
+
+EXAMPLES
+--------
+
+The command linkgit:git-last-modified[1] shows the commit that each file
+was last modified in.
+
+----
+$ git last-modified -- README.md Makefile
+7798034171030be0909c56377a4e0e10e6d2df93	Makefile
+c50fbb2dd225e7e82abba4380423ae105089f4d7	README.md
+----
+
+We can pipe the result to this command in order to replace the object
+name with the commit author.
+
+----
+$ git last-modified -- README.md Makefile |
+    git format-rev --stdin-mode=text --format=%an
+Junio C Hamano	Makefile
+Todd Zullinger	README.md
+----
+
+Another example is _formatting commits in commit messages_. Given this commit message:
+
+----
+Fix off-by-one error
+
+Fix off-by-one error introduced in
+e83c5163316f89bfbde7d9ab23ca2e25604af290.
+
+We thought we fixed this in 5569bf9bbedd63a00780fc5c110e0cfab3aa97b9 but
+that only covered 1/3 of the faulty cases.
+----
+
+We can format the commits and use par(1) to reflow the text, say in a
+`commit-msg` hook:
+
+----
+$ git config set hook.reference-commits.event commit-msg
+$ git config set hook.reference-commits.command reference-commits
+$ cat $(which reference-commits)
+#/bin/sh
+
+msg="$1"
+rewritten=$(mktemp)
+git format-rev --stdin-mode=text --format=reference <"$msg" |
+    par >"$rewritten"
+mv "$rewritten" "$msg"
+----
+
+Which will produce something like this:
+
+----
+Fix off-by-one error
+
+Fix off-by-one error introduced in e83c5163316 (Implement better memory
+allocator, 2005-04-07).
+
+We thought we fixed this in 5569bf9bbed (Fix memory allocator,
+2005-06-22) but that only covered 1/3 of the faulty cases.
+----
+
+DISCUSSION
+----------
+
+This command lets you format any number of revisions in any order
+through one command invocation. Consider the
+linkgit:git-last-modified[1] case from the "EXAMPLES" section above:
+
+1. There might be hundreds of files
+2. Commits can be repeated, i.e. two or more files were last modified in
+   the same commit
+
+Two widely-used commands which pretty formats commits are
+linkgit:git-log[1] and linkgit:git-show[1]. It turns out that they are
+not a good fit for the above use case.
+
+- The output of linkgit:git-last-modified[1] would have to be processed
+  in stages since you need to transform the first column separately and
+  then link the author to the filename. But this is surmountable.
+- You can feed each commit to `git show` or `git show --no-walk -1`. But
+  that means that you need to create a process for each line.
+- Let’s say that you want to use one process, not one per line. So you
+  want to feed all the commits to the command. Now you face the problem
+  that you have to feed all the commits to the commands before you get
+  any output (this is also the case for the `--stdin` modes). In other
+  words, you cannot loop through each line, get the author for the
+  commit, and output the author and the filename. You need to feed all
+  the commits, get back all the output, and match the output with the
+  filename.
+- But the next problem is that commands will deduplicate the input and
+  only output one commit one single time only. Thus you cannot make the
+  output order match the input order, since a commit could have been
+  repeated in the original input.
+
+In short, it is straightforward to use these two commands if you use one
+process per line. It is much more work if you just want to use one
+process, but still doable. In contrast, this problem is just another
+shell pipeline with this command.
+
+GIT
+---
+Part of the linkgit:git[1] suite
diff --git a/Makefile b/Makefile
index 15b1ded1a0b..cbaf91fd846 100644
--- a/Makefile
+++ b/Makefile
@@ -895,6 +895,7 @@ BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
 BUILT_INS += git-cherry$X
 BUILT_INS += git-cherry-pick$X
 BUILT_INS += git-format-patch$X
+BUILT_INS += git-format-rev$X
 BUILT_INS += git-fsck-objects$X
 BUILT_INS += git-init$X
 BUILT_INS += git-maintenance$X
diff --git a/builtin.h b/builtin.h
index 235c51f30e5..63813c90125 100644
--- a/builtin.h
+++ b/builtin.h
@@ -189,6 +189,7 @@ int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct re
 int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo);
+int cmd_format_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
 int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo);
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index dc4136f4de3..b60cc766279 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,6 +18,9 @@
 #include "commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
+#include "pretty.h"
+#include "revision.h"
+#include "notes.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -272,14 +275,26 @@ struct name_ref_data {
 	struct string_list exclude_filters;
 };
 
+struct pretty_format {
+	struct pretty_print_context ctx;
+	struct userformat_want want;
+};
+
 enum command_type {
 	NAME_REV = 1,
+	FORMAT_REV = 2,
+};
+
+enum stdin_mode {
+    TEXT = 1,
+    REVS = 2,
 };
 
 struct command {
 	enum command_type type;
 	union {
 		int name_only;
+		struct pretty_format *pretty_format;
 	} u;
 };
 
@@ -290,6 +305,13 @@ static void init_name_rev_command(struct command *cmd,
 	cmd->u.name_only = name_only;
 }
 
+static void init_format_rev_command(struct command *cmd,
+				    struct pretty_format *pretty_format)
+{
+	cmd->type = FORMAT_REV;
+	cmd->u.pretty_format = pretty_format;
+}
+
 static struct tip_table {
 	struct tip_table_entry {
 		struct object_id oid;
@@ -495,6 +517,27 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 	}
 }
 
+static const char *get_format_rev(const struct commit *c,
+				  struct pretty_format *format_ctx,
+				  struct strbuf *buf)
+{
+	strbuf_reset(buf);
+
+	if (format_ctx->want.notes) {
+		struct strbuf notebuf = STRBUF_INIT;
+
+		format_display_notes(&c->object.oid, &notebuf,
+				     get_log_output_encoding(),
+				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
+		format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
+	}
+
+	pretty_print_commit(&format_ctx->ctx, c, buf);
+	FREE_AND_NULL(format_ctx->ctx.notes_message);
+
+	return buf->buf;
+}
+
 static void show_name(const struct object *obj,
 		      const char *caller_name,
 		      int always, int allow_undefined, int name_only)
@@ -565,6 +608,19 @@ static void name_rev_line(char *p, struct command *cmd)
 				else
 					printf("%.*s (%s)", p_len, p_start, name);
 				break;
+			case FORMAT_REV:
+				if (!oid_ret)
+					o = parse_object(the_repository, &oid);
+				if (o && o->type == OBJ_COMMIT)
+					name = get_format_rev((const struct commit *)o,
+							      cmd->u.pretty_format,
+							      &buf);
+				*(p + 1) = c;
+				if (name)
+					printf("%.*s%s", p_len - hexsz, p_start, name);
+				else
+					printf("%.*s", p_len, p_start);
+				break;
 			default:
 				BUG("uncovered case: %d", cmd->type);
 			}
@@ -718,3 +774,133 @@ int cmd_name_rev(int argc,
 	object_array_clear(&revs);
 	return 0;
 }
+
+static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
+{
+	if (!strcmp(stdin_mode, "text"))
+		return TEXT;
+	else if (!strcmp(stdin_mode, "revs") ||
+		 !strcmp(stdin_mode, "rev"))
+		return REVS;
+	else
+		die(_("'%s' needs to be either text, revs, or rev"),
+		    "--stdin-mode");
+}
+
+static char const *const format_rev_usage[] = {
+	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]"),
+	NULL
+};
+
+int cmd_format_rev(int argc,
+		   const char **argv,
+		   const char *prefix,
+		   struct repository *repo UNUSED)
+{
+	const char *format = NULL;
+	enum stdin_mode stdin_mode;
+	const char *stdin_mode_arg = NULL;
+	struct display_notes_opt format_notes_opt;
+	struct rev_info format_rev = REV_INFO_INIT;
+	struct pretty_format format_pp = { 0 };
+	struct string_list notes = STRING_LIST_INIT_NODUP;
+	struct strbuf scratch_buf = STRBUF_INIT;
+	struct command cmd;
+	struct option opts[] = {
+		OPT_STRING(0, "format", &format, N_("format"),
+			   N_("pretty format to use")),
+		OPT_STRING(0, "stdin-mode", &stdin_mode_arg, N_("stdin-mode"),
+			   N_("how revs are processed")),
+		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
+				N_("display notes for pretty format")),
+		OPT_END(),
+	};
+
+	argc = parse_options(argc, argv, prefix, opts, format_rev_usage, 0);
+
+	if (argc > 0) {
+		error(_("too many arguments"));
+		usage_with_options(format_rev_usage, opts);
+	}
+
+	if (!format)
+		die(_("'%s' is required"), "--format");
+	if (!stdin_mode_arg)
+		die(_("'%s' is required"), "--stdin-mode");
+
+	init_display_notes(&format_notes_opt);
+	stdin_mode = parse_stdin_mode(stdin_mode_arg);
+
+	get_commit_format(format, &format_rev);
+	format_pp.ctx.rev = &format_rev;
+	format_pp.ctx.fmt = format_rev.commit_format;
+	format_pp.ctx.abbrev = format_rev.abbrev;
+	format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
+	format_pp.ctx.date_mode = format_rev.date_mode;
+	format_pp.ctx.color = GIT_COLOR_AUTO;
+
+	userformat_find_requirements(format,
+				     &format_pp.want);
+	if (format_pp.want.notes) {
+		int ignore_show_notes = 0;
+		struct string_list_item *n;
+
+		for_each_string_list_item(n, &notes)
+			enable_ref_display_notes(&format_notes_opt,
+						 &ignore_show_notes,
+						 n->string);
+		load_display_notes(&format_notes_opt);
+	}
+
+	init_format_rev_command(&cmd, &format_pp);
+
+	switch (stdin_mode) {
+	case TEXT:
+		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
+			strbuf_addch(&scratch_buf, '\n');
+			name_rev_line(scratch_buf.buf, &cmd);
+		}
+		break;
+	case REVS:
+		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
+			struct object_id oid;
+			struct object *object;
+			struct object *peeled;
+			struct commit *commit;
+
+			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
+				fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+					scratch_buf.buf);
+				continue;
+			}
+
+			object = parse_object(the_repository, &oid);
+			if (!object) {
+				fprintf(stderr, "Could not get object for %s. Skipping.\n",
+					scratch_buf.buf);
+				continue;
+			}
+
+			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
+			if (peeled && peeled->type == OBJ_COMMIT)
+				commit = (struct commit *)peeled;
+			if (!commit) {
+				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
+					*argv);
+				continue;
+			}
+
+			get_format_rev(commit, &format_pp, &scratch_buf);
+			printf("%s\n", scratch_buf.buf);
+			strbuf_release(&scratch_buf);
+		}
+		break;
+	default:
+		BUG("uncovered case: %d", stdin_mode);
+	}
+
+	strbuf_release(&scratch_buf);
+	string_list_clear(&notes, 0);
+	release_display_notes(&format_notes_opt);
+	return 0;
+}
diff --git a/command-list.txt b/command-list.txt
index f9005cf4597..df729872dca 100644
--- a/command-list.txt
+++ b/command-list.txt
@@ -108,6 +108,7 @@ git-fmt-merge-msg                       purehelpers
 git-for-each-ref                        plumbinginterrogators
 git-for-each-repo                       plumbinginterrogators
 git-format-patch                        mainporcelain
+git-format-rev                          plumbinginterrogators
 git-fsck                                ancillaryinterrogators          complete
 git-gc                                  mainporcelain
 git-get-tar-commit-id                   plumbinginterrogators
diff --git a/git.c b/git.c
index 2b212e6675d..af5b0422b00 100644
--- a/git.c
+++ b/git.c
@@ -578,6 +578,7 @@ static struct cmd_struct commands[] = {
 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
 	{ "for-each-repo", cmd_for_each_repo, RUN_SETUP_GENTLY },
 	{ "format-patch", cmd_format_patch, RUN_SETUP },
+	{ "format-rev", cmd_format_rev, RUN_SETUP },
 	{ "fsck", cmd_fsck, RUN_SETUP },
 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
 	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
diff --git a/t/t1517-outside-repo.sh b/t/t1517-outside-repo.sh
index c824c1a25cf..360a9323343 100755
--- a/t/t1517-outside-repo.sh
+++ b/t/t1517-outside-repo.sh
@@ -114,7 +114,8 @@ do
 	archimport | citool | credential-netrc | credential-libsecret | \
 	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
 	daemon | \
-	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
+	difftool--helper | filter-branch | format-rev | fsck-objects | \
+	get-tar-commit-id | \
 	gui | gui--askpass | \
 	http-backend | http-fetch | http-push | init-db | \
 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 62789f76381..725f7d81b6b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -801,4 +801,108 @@ test_expect_success 'do not be fooled by invalid describe format ' '
 	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
 '
 
+test_expect_success 'name-rev --format setup' '
+	mkdir repo-format &&
+	git -C repo-format init &&
+	test_commit -C repo-format first &&
+	test_commit -C repo-format second &&
+	test_commit -C repo-format third &&
+	test_commit -C repo-format fourth &&
+	test_commit -C repo-format fifth &&
+	test_commit -C repo-format sixth &&
+	test_commit -C repo-format seventh &&
+	test_commit -C repo-format eighth
+'
+
+test_expect_success 'format-rev --stdin-mode=revs' '
+	cat >expect <<-\EOF &&
+	eighth
+	seventh
+	fifth
+	EOF
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format=%s >actual <<-\EOF &&
+	HEAD
+	HEAD~
+	HEAD~3
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-rev --stdin-mode=text from rev-list same as log' '
+	git -C repo-format log --format=reference >expect &&
+	test_file_not_empty expect &&
+	git -C repo-format rev-list HEAD >list &&
+	git -C repo-format format-rev --stdin-mode=text \
+		--format=reference <list >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'format-rev --stdin-mode=text with running text and tree oid' '
+	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
+	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
+	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
+	cat >expect <<-EOF &&
+	We thought we fixed this in ${reference}.
+	But look at this tree: ${tree}.
+	EOF
+	git -C repo-format format-rev --stdin-mode=text --format=reference \
+		>actual <<-EOF &&
+	We thought we fixed this in ${cmit_oid}.
+	But look at this tree: ${tree}.
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-rev with %N (note)' '
+	test_when_finished "git -C repo-format notes remove" &&
+	git -C repo-format notes add -m"Make a note" &&
+	printf "Make a note\n\n\n" >expect &&
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format="tformat:%N" \
+		>actual <<-\EOF &&
+	HEAD
+	HEAD~
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-rev --notes<ref> (custom notes ref)' '
+	# One custom notes ref
+	test_when_finished "git -C repo-format notes remove" &&
+	test_when_finished "git -C repo-format notes --ref=word remove" &&
+	git -C repo-format notes add -m"default" &&
+	git -C repo-format notes --ref=word add -m"custom" &&
+	printf "custom\n\n" >expect &&
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format="tformat:%N" \
+		--notes=word \
+		>actual <<-\EOF &&
+	HEAD
+	EOF
+	test_cmp expect actual &&
+	# Glob all
+	printf "default\ncustom\n\n" >expect &&
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format="tformat:%N" \
+		--notes=* >actual <<-\EOF &&
+	HEAD
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'format-rev --stdin-mode=revs on annotated tag peels to commit' '
+	test_when_finished "git -C repo-format tag -d version" &&
+	git -C repo-format tag -a -m"new version" version &&
+	cat >expect <<-\EOF &&
+	eighth
+	EOF
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format=%s \
+		--notes=* >actual <<-\EOF &&
+	version
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.54.0.13.g9c7419e39f8

