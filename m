Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FD731B83B
	for <git@vger.kernel.org>; Tue, 28 Apr 2026 22:26:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777415194; cv=none; b=Hs1RhZDqZ+luhDlurVYarF0BUN04Lv0s/srpUyu/3lnbAUwRg3daZIcma+XmU/gM2dHSaDtgv1pRMEdQk5BlcZtullOjxD+Vnq4bCFhLpKBZX789Y/XaCAVokFgVmm5qKoQjaKJ/G4YRpUomPNDS17rgQem3Otfq+prigCUrJsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777415194; c=relaxed/simple;
	bh=xA/OdBssrQfZxPbACT95TND/fqIZWG86ASWqPpBChkI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=shn3WJ61D+tkvxNIkKgTpu1He4L9KGkgD2NfHeYekM9dwk5TGQ4zE3XXnWmw0c+HBK+y/yeF7QBOmZ+5oLwkiMV6dEuQqtjatxZ6+mC0jY3Myehvuk0SURDZYw2xT8YtxiofN1dBOMCKPJ/wZUgtpun9VeM2Gq2WYoJzJ5Q8QO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=NptPHyc+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CwrLlCo6; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="NptPHyc+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CwrLlCo6"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5550D7A0268;
	Tue, 28 Apr 2026 18:26:29 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Tue, 28 Apr 2026 18:26:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1777415189;
	 x=1777501589; bh=SB0YbMNcenXUmwB3wlSQRg6RGuMQ1L8NMqU+CcKaaqk=; b=
	NptPHyc+2niLY3Gw7W8tXnQOnt1e/OeK4UzGo0QjGKuT824YxqOISDZiu/IRsc9v
	aJmwgn56WM/eCg6Hh9JYFHoYwEoyRViODUbMxgIWWiwyl8muyDfkTE9uSlqe071r
	5aJAX2wG9f6DeId6sqiRgDZTV+6SermYSq1CoAzyfluTzO30GHwgnhcdknXJwZ4h
	9LjgJoDW4gl+Y5RamJf2guIS+l8gIGnHwD+ZROKLvQQ2HO1j4NNyHNmohAVEYnUc
	/6HuxdrMqa8nXi3oZZxZHmcYa8yzXuoG1TSf8RNmTKTnSXIXKGLHeJDr0ZbvEn8q
	3BvH3COFLpF6OIAj85imhQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1777415189; x=
	1777501589; bh=SB0YbMNcenXUmwB3wlSQRg6RGuMQ1L8NMqU+CcKaaqk=; b=C
	wrLlCo6IksinPyU6QfQN571DUVRB+kUECKqf/Y9dE8SJcd+ePGPa0erjB32bsxdO
	ZFmT5Gb1BABElmjrN5LO40f/UruMW+pMTnOTZUF9DMTIOG0+Jdxc3z5aFMYWotNV
	t4fZR10X5+R0CKxMmuFqHMnjTLs+jODuPoYNBQKq4rlghSr2bYk3t9a32oJyyWv2
	WDCWateNBGpvjcf82gNGXQm0t3m4aXPFp9hx+yglpenZRcTIBAxVKgnQMNQ8h+CO
	YSCQIhSBOhGiIWIO9IRvpU1G/+z80e1IUB3Hq6Oz6/lQrRlUYUUkU8SW/Xbos1j9
	7MsflGlyy22JHRTXWVbJg==
X-ME-Sender: <xms:FTTxaXy8HrOEbRZFiFu9ZedxlEFri2R02Ng-oc2ZFeOF04VfNio3_EU>
    <xme:FTTxaWugj92YFSO-oDCtfXgd2L7A0_oqi8M8kEef5pcSuYRyHf0wyP9iL6BBUUNGu
    lCSzBzFY1HzVNNrgg5deD6fjkoF0DJQin3NDbIsu0UXMfll4J_o7g>
X-ME-Received: <xmr:FTTxaet3aUFfYH3ZzQG7JpSiYQ58AQw7iSOVt8_ZOxgRe_rrIudz5LN3AUgryyToAvO3sJpd5MM7B3un0G4_ha21IQ2MJfj3km16ZPrlmYCGCobswTJz6XnnmQ>
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
X-ME-Proxy: <xmx:FTTxabO0E9tGn3QdCF68zvFd_-8UFqbaYomj6BpcnBmNA7ovenUdKQ>
    <xmx:FTTxac09IjUArbBl2FbEQ0ttB-NQnDybXvJ5Ik2HPBzJXfpP10kIYw>
    <xmx:FTTxaXP_pyyoNcaXWYNAPKqWb7Lt45YpRVJzfcvTnmCTloEiyd8Tpg>
    <xmx:FTTxac0f4Jiqi5Yu5xKX2gSpvgONAn4ih0D2k9dmTRELroIU7h1aYg>
    <xmx:FTTxaWveFoqW2aGuICKQHC1GOBjswjrjOSR7mHeAn6MK-dVlGJPD_24e>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 28 Apr 2026 18:26:27 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com
Subject: [PATCH v3 0/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Wed, 29 Apr 2026 00:25:51 +0200
Message-ID: <V3_CV_format-rev.66a@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V2_CV_name-rev_--format.51b@msgid.xyz>
References: <V2_CV_name-rev_--format.51b@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(Previous subject: name-rev: learn --format=<pretty>)

Topic name (applied): kh/name-rev-custom-format

Topic summary: Introduce a new builtin for pretty formatting one revision
expression per line or commit object names found in running text.

See the last patch for the motivation. In short there isn’t anything that I
have found that lets you format however many commits you want through one
process (so looping over `git show` is excepted).

The other patches prepare for this change.

§ Changes in v3

Rewrite from a git-name-rev(1) option add-on to a new builtin. I make room
in `builtin/name-rev.c` for it.

This was based on this part from the previous cover letter:

    git(1) already has a lot of commands. This doesn’t expand the footprint. On
    the other hand, I might be naive about what a proper formatter needs in
    terms of command options. Right now there is the helper `--notes`. But is
    more needed?

    • --abbrev ?
    • --date ?

    I don’t know. Maybe at some point this would be too much, too crowded, for
    git-name-rev(1). Then it might make sense to split it out to a separate
    builtin?

I did not want to expand this git-name-rev(1) command with more options
specific to pretty formatting.

§ Why experimental command?

This command is marked Experimental three times (like git-replay(1)).[1]
Not so much because the UI design seems difficult. It’s more so that it can
be thrown out if it doesn’t end up being worth having around.

(*Experimental* also implies wholesale trashing. Right? That’s one possible
change in behavior.)

Or the behavior here could be moved somewhere else.

† 1: I vaguely recall reading a good argument for emphasizing this on the
     mailing list. I wasn’t able to find back to it right now.

§ Outstanding work

I could look more into how to do the translation strings for “X is
require” (arg), I’m probably missing something that already exists. I could
probably also link to other commands on the git-format-rev(1) doc. But
right now I wanted to get this out there. There might not be any appetite
for builtin number 148 for this particular niche anyway.

§ Link to v2

https://lore.kernel.org/git/V2_CV_name-rev_--format.51b@msgid.xyz/

[1/5] name-rev: wrap both blocks in braces
[2/5] name-rev: run clang-format before factoring code
[3/5] name-rev: factor code for sharing with a new command
[4/5] name-rev: make dedicated --annotate-stdin --name-only test
[5/5] format-rev: introduce builtin for on-demand pretty formatting

 Documentation/git-format-rev.adoc | 148 +++++++++++++++++
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/name-rev.c                | 264 +++++++++++++++++++++++++++---
 command-list.txt                  |   1 +
 git.c                             |   1 +
 t/t1517-outside-repo.sh           |   3 +-
 t/t6120-describe.sh               | 118 +++++++++++++
 8 files changed, 511 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-format-rev.adoc

Interdiff against v2:
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
diff --git a/Documentation/git-name-rev.adoc b/Documentation/git-name-rev.adoc
index 65348690c8c..d4f1c4d5945 100644
--- a/Documentation/git-name-rev.adoc
+++ b/Documentation/git-name-rev.adoc
@@ -9,7 +9,7 @@ git-name-rev - Find symbolic names for given revs
 SYNOPSIS
 --------
 [verse]
-'git name-rev' [--tags] [--refs=<pattern>] [--format=<pretty>]
+'git name-rev' [--tags] [--refs=<pattern>]
 	       ( --all | --annotate-stdin | <commit-ish>... )
 
 DESCRIPTION
@@ -21,14 +21,6 @@ format parsable by 'git rev-parse'.
 OPTIONS
 -------
 
---format=<pretty>::
---no-format::
-	Format revisions instead of outputting symbolic names. The
-	default is `--no-format`.
-+
-Implies `--name-only`. The negation `--no-format` implies
-`--no-name-only` (the default for the command).
-
 --tags::
 	Do not use branch names, but only tags to name the commits
 
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
index 9a008d8b7a8..b60cc766279 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -36,16 +36,6 @@ struct rev_name {
 	int from_tag;
 };
 
-struct pretty_format {
-	struct pretty_print_context ctx;
-	struct userformat_want want;
-};
-
-struct format_cb_data {
-    const char *format;
-    int *name_only;
-};
-
 define_commit_slab(commit_rev_name, struct rev_name);
 
 static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
@@ -285,6 +275,43 @@ struct name_ref_data {
 	struct string_list exclude_filters;
 };
 
+struct pretty_format {
+	struct pretty_print_context ctx;
+	struct userformat_want want;
+};
+
+enum command_type {
+	NAME_REV = 1,
+	FORMAT_REV = 2,
+};
+
+enum stdin_mode {
+    TEXT = 1,
+    REVS = 2,
+};
+
+struct command {
+	enum command_type type;
+	union {
+		int name_only;
+		struct pretty_format *pretty_format;
+	} u;
+};
+
+static void init_name_rev_command(struct command *cmd,
+				  int name_only)
+{
+	cmd->type = NAME_REV;
+	cmd->u.name_only = name_only;
+}
+
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
@@ -467,9 +494,7 @@ static const char *get_exact_ref_match(const struct object *o)
 }
 
 /* may return a constant string or use "buf" as scratch space */
-static const char *get_rev_name(const struct object *o,
-				struct pretty_format *format_ctx,
-				struct strbuf *buf)
+static const char *get_rev_name(const struct object *o, struct strbuf *buf)
 {
 	struct rev_name *n;
 	const struct commit *c;
@@ -477,25 +502,6 @@ static const char *get_rev_name(const struct object *o,
 	if (o->type != OBJ_COMMIT)
 		return get_exact_ref_match(o);
 	c = (const struct commit *) o;
-
-	if (format_ctx) {
-		strbuf_reset(buf);
-
-		if (format_ctx->want.notes) {
-			struct strbuf notebuf = STRBUF_INIT;
-
-			format_display_notes(&c->object.oid, &notebuf,
-					     get_log_output_encoding(),
-					     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
-			format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
-		}
-
-		pretty_print_commit(&format_ctx->ctx, c, buf);
-		FREE_AND_NULL(format_ctx->ctx.notes_message);
-
-		return buf->buf;
-	}
-
 	n = get_commit_rev_name(c);
 	if (!n)
 		return NULL;
@@ -511,9 +517,29 @@ static const char *get_rev_name(const struct object *o,
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
-		      struct pretty_format *format_ctx,
 		      int always, int allow_undefined, int name_only)
 {
 	const char *name;
@@ -522,7 +548,7 @@ static void show_name(const struct object *obj,
 
 	if (!name_only)
 		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
-	name = get_rev_name(obj, format_ctx, &buf);
+	name = get_rev_name(obj, &buf);
 	if (name)
 		printf("%s\n", name);
 	else if (allow_undefined)
@@ -542,9 +568,7 @@ static char const * const name_rev_usage[] = {
 	NULL
 };
 
-static void name_rev_line(char *p,
-			  struct name_ref_data *data,
-			  struct pretty_format *format_ctx)
+static void name_rev_line(char *p, struct command *cmd)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int counter = 0;
@@ -553,33 +577,54 @@ static void name_rev_line(char *p,
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
+	start:
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
-			 !ishex(*(p+1))) {
+			   !ishex(*(p + 1))) {
 			struct object_id oid;
 			const char *name = NULL;
-			char c = *(p+1);
+			char c = *(p + 1);
 			int p_len = p - p_start + 1;
+			struct object *o = NULL;
+			int oid_ret = 1;
 
 			counter = 0;
 
-			*(p+1) = 0;
-			if (!repo_get_oid(the_repository, p - (hexsz - 1), &oid)) {
-				struct object *o =
-					lookup_object(the_repository, &oid);
+			*(p + 1) = 0;
+			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
+
+			switch (cmd->type) {
+			case NAME_REV:
+				if (!oid_ret)
+					o = lookup_object(the_repository, &oid);
 				if (o)
-					name = get_rev_name(o, format_ctx, &buf);
+					name = get_rev_name(o, &buf);
+				*(p + 1) = c;
+				if (!name)
+					goto start;
+				if (cmd->u.name_only)
+					printf("%.*s%s", p_len - hexsz, p_start, name);
+				else
+					printf("%.*s (%s)", p_len, p_start, name);
+				break;
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
+			default:
+				BUG("uncovered case: %d", cmd->type);
 			}
-			*(p+1) = c;
 
-			if (!name)
-				continue;
-
-			if (data->name_only)
-				printf("%.*s%s", p_len - hexsz, p_start, name);
-			else
-				printf("%.*s (%s)", p_len, p_start, name);
 			p_start = p + 1;
 		}
 	}
@@ -591,16 +636,6 @@ static void name_rev_line(char *p,
 	strbuf_release(&buf);
 }
 
-static int format_cb(const struct option *option,
-		     const char *arg,
-		     int unset)
-{
-	struct format_cb_data *data = option->value;
-	data->format = arg;
-	*data->name_only = !unset;
-	return 0;
-}
-
 int cmd_name_rev(int argc,
 		 const char **argv,
 		 const char *prefix,
@@ -614,19 +649,14 @@ int cmd_name_rev(int argc,
 #endif
 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
-	static struct format_cb_data format_cb_data = { 0 };
-	struct display_notes_opt format_notes_opt;
-	struct rev_info format_rev = REV_INFO_INIT;
-	struct pretty_format *format_ctx = NULL;
-	struct pretty_format format_pp = { 0 };
-	struct string_list notes = STRING_LIST_INIT_NODUP;
+	struct command cmd;
 	struct option opts[] = {
 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
 		OPT_STRING_LIST(0, "refs", &data.ref_filters, N_("pattern"),
-				   N_("only use refs matching <pattern>")),
+				N_("only use refs matching <pattern>")),
 		OPT_STRING_LIST(0, "exclude", &data.exclude_filters, N_("pattern"),
-				   N_("ignore refs matching <pattern>")),
+				N_("ignore refs matching <pattern>")),
 		OPT_GROUP(""),
 		OPT_BOOL(0, "all", &all, N_("list all commits reachable from all refs")),
 #ifndef WITH_BREAKING_CHANGES
@@ -637,24 +667,19 @@ int cmd_name_rev(int argc,
 			   PARSE_OPT_HIDDEN),
 #endif /* WITH_BREAKING_CHANGES */
 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
-		OPT_CALLBACK(0, "format", &format_cb_data, N_("format"),
-			     N_("pretty-print output instead"), format_cb),
-		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
-				N_("display notes for --format")),
 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
-		OPT_BOOL(0, "always",     &always,
-			   N_("show abbreviated commit object as fallback")),
+		OPT_BOOL(0, "always", &always,
+			 N_("show abbreviated commit object as fallback")),
 		OPT_HIDDEN_BOOL(0, "peel-tag", &peel_tag,
-			   N_("dereference tags in the input (internal use)")),
+				N_("dereference tags in the input (internal use)")),
 		OPT_END(),
 	};
 
-	init_display_notes(&format_notes_opt);
-	format_cb_data.name_only = &data.name_only;
 	mem_pool_init(&string_pool, 0);
 	init_commit_rev_name(&rev_names);
 	repo_config(the_repository, git_default_config, NULL);
 	argc = parse_options(argc, argv, prefix, opts, name_rev_usage, 0);
+	init_name_rev_command(&cmd, data.name_only);
 
 #ifndef WITH_BREAKING_CHANGES
 	if (transform_stdin) {
@@ -665,31 +690,6 @@ int cmd_name_rev(int argc,
 	}
 #endif
 
-	if (format_cb_data.format) {
-		get_commit_format(format_cb_data.format, &format_rev);
-		format_pp.ctx.rev = &format_rev;
-		format_pp.ctx.fmt = format_rev.commit_format;
-		format_pp.ctx.abbrev = format_rev.abbrev;
-		format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
-		format_pp.ctx.date_mode = format_rev.date_mode;
-		format_pp.ctx.color = GIT_COLOR_AUTO;
-
-		userformat_find_requirements(format_cb_data.format,
-					     &format_pp.want);
-		if (format_pp.want.notes) {
-			int ignore_show_notes = 0;
-			struct string_list_item *n;
-
-			for_each_string_list_item(n, &notes)
-				enable_ref_display_notes(&format_notes_opt,
-							 &ignore_show_notes,
-							 n->string);
-			load_display_notes(&format_notes_opt);
-		}
-
-		format_ctx = &format_pp;
-	}
-
 	if (all + annotate_stdin + !!argc > 1) {
 		error("Specify either a list, or --all, not both!");
 		usage_with_options(name_rev_usage, opts);
@@ -747,7 +747,7 @@ int cmd_name_rev(int argc,
 
 		while (strbuf_getline(&sb, stdin) != EOF) {
 			strbuf_addch(&sb, '\n');
-			name_rev_line(sb.buf, &data, format_ctx);
+			name_rev_line(sb.buf, &cmd);
 		}
 		strbuf_release(&sb);
 	} else if (all) {
@@ -758,21 +758,149 @@ int cmd_name_rev(int argc,
 			struct object *obj = get_indexed_object(the_repository, i);
 			if (!obj || obj->type != OBJ_COMMIT)
 				continue;
-			show_name(obj, NULL, format_ctx,
+			show_name(obj, NULL,
 				  always, allow_undefined, data.name_only);
 		}
 	} else {
 		int i;
 		for (i = 0; i < revs.nr; i++)
-			show_name(revs.objects[i].item, revs.objects[i].name, format_ctx,
+			show_name(revs.objects[i].item, revs.objects[i].name,
 				  always, allow_undefined, data.name_only);
 	}
 
 	string_list_clear(&data.ref_filters, 0);
 	string_list_clear(&data.exclude_filters, 0);
-	string_list_clear(&notes, 0);
-	release_display_notes(&format_notes_opt);
 	mem_pool_discard(&string_pool, 0);
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
index 0b7e9fe396d..725f7d81b6b 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -298,6 +298,20 @@ test_expect_success 'name-rev --annotate-stdin' '
 	test_cmp expect actual
 '
 
+test_expect_success 'name-rev --annotate-stdin --name-only' '
+	>expect.unsorted &&
+	for rev in $(git rev-list --all)
+	do
+		name=$(git name-rev --name-only $rev) &&
+		echo "$name" >>expect.unsorted || return 1
+	done &&
+	sort <expect.unsorted >expect &&
+	git name-rev --annotate-stdin --name-only \
+		<list >actual.unsorted &&
+	sort <actual.unsorted >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'name-rev --stdin deprecated' '
 	git rev-list --all >list &&
 	if ! test_have_prereq WITH_BREAKING_CHANGES
@@ -658,102 +672,6 @@ test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
 	)
 '
 
-test_expect_success 'name-rev --format setup' '
-	mkdir repo-format &&
-	git -C repo-format init &&
-	test_commit -C repo-format first &&
-	test_commit -C repo-format second &&
-	test_commit -C repo-format third &&
-	test_commit -C repo-format fourth &&
-	test_commit -C repo-format fifth &&
-	test_commit -C repo-format sixth &&
-	test_commit -C repo-format seventh &&
-	test_commit -C repo-format eighth
-'
-
-test_expect_success 'name-rev --format --no-name-only' '
-	cat >expect <<-\EOF &&
-	HEAD~3 [fifth]
-	HEAD [eighth]
-	HEAD~5 [third]
-	EOF
-	git -C repo-format name-rev --format="[%s]" \
-		--no-name-only HEAD~3 HEAD HEAD~5 >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'name-rev --format --no-format is the same as regular name-rev' '
-	git -C repo-format name-rev HEAD~2 HEAD~3 >expect &&
-	test_file_not_empty expect &&
-	git -C repo-format name-rev --format="huh?" \
-		--no-format HEAD~2 HEAD~3 >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'name-rev --format=%s for argument revs' '
-	cat >expect <<-\EOF &&
-	eighth
-	seventh
-	fifth
-	EOF
-	git -C repo-format name-rev --format=%s \
-		HEAD HEAD~ HEAD~3 >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success '--name-rev --format=reference --annotate-stdin from rev-list same as log' '
-	git -C repo-format log --format=reference >expect &&
-	test_file_not_empty expect &&
-	git -C repo-format rev-list HEAD >list &&
-	git -C repo-format name-rev --format=reference \
-		--annotate-stdin <list >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success '--name-rev --format=<pretty> --annotate-stdin with running text and tree oid' '
-	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
-	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
-	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
-	cat >expect <<-EOF &&
-	We thought we fixed this in ${reference}.
-	But look at this tree: ${tree}.
-	EOF
-	git -C repo-format name-rev --format=reference --annotate-stdin \
-		>actual <<-EOF &&
-	We thought we fixed this in ${cmit_oid}.
-	But look at this tree: ${tree}.
-	EOF
-	test_cmp expect actual
-'
-
-test_expect_success 'name-rev --format=<pretty> with %N (note)' '
-	test_when_finished "git -C repo-format notes remove" &&
-	git -C repo-format notes add -m"Make a note" &&
-	printf "Make a note\n\n\n" >expect &&
-	git -C repo-format name-rev --format="tformat:%N" \
-		HEAD HEAD~ >actual &&
-	test_cmp expect actual
-'
-
-test_expect_success 'name-rev --format=<pretty> --notes<ref>' '
-	# One custom notes ref
-	test_when_finished "git -C repo-format notes remove" &&
-	test_when_finished "git -C repo-format notes --ref=word remove" &&
-	git -C repo-format notes add -m"default" &&
-	git -C repo-format notes --ref=word add -m"custom" &&
-	printf "custom\n\n" >expect &&
-	git -C repo-format name-rev --format="tformat:%N" \
-		--notes=word \
-		HEAD >actual &&
-	test_cmp expect actual &&
-	# Glob all
-	printf "default\ncustom\n\n" >expect &&
-	git -C repo-format name-rev --format="tformat:%N" \
-		--notes=* \
-		HEAD >actual &&
-	test_cmp expect actual
-'
-
 #               B
 #               o
 #  H             \
@@ -883,4 +801,108 @@ test_expect_success 'do not be fooled by invalid describe format ' '
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
Range-diff against v2:
1:  9cb5cfd1ec3 = 1:  9cb5cfd1ec3 name-rev: wrap both blocks in braces
-:  ----------- > 2:  14900271321 name-rev: run clang-format before factoring code
-:  ----------- > 3:  1f17f0b0090 name-rev: factor code for sharing with a new command
-:  ----------- > 4:  40989b3672a name-rev: make dedicated --annotate-stdin --name-only test
2:  52a52060776 ! 5:  bb54e8f753e name-rev: learn --format=<pretty>
    @@ Metadata
     Author: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
      ## Commit message ##
    -    name-rev: learn --format=<pretty>
    +    format-rev: introduce builtin for on-demand pretty formatting
     
    -    Teach git-name-rev(1) to format the given revisions instead of creating
    -    symbolic names.
    +    Introduce a new builtin for pretty formatting one revision expression
    +    per line or commit object names found in running text.
     
    -    Sometimes you want to format commits. Most of the time you’re walking
    -    the graph, e.g. getting a range of commits like `master..topic`. That’s
    -    a job for git-log(1).
    +    Sometimes you want to format commits. Most of the time you’re
    +    walking the graph, e.g. getting a range of commits like
    +    `master..topic`. That’s a job for git-log(1).
     
    -    But sometimes you might want to format commits that you encounter
    +    But there are times when you want to format commits that you encounter
         on demand:
     
         • Full hashes in running text that you might want to pretty-print
    -    • git-last-modified(1) outputs full hashes that you can do the same with
    +    • git-last-modified(1) outputs full hashes that you can do the same
    +      with
         • git-cherry(1) has `-v` for commit subject, but maybe you want
           something else?
     
         But now you can’t use git-log(1), git-show(1), or git-rev-list(1):
     
    -    • You can’t feed commits piecemeal to these commands, one input for one
    -      output; they block until standard in is closed
    +    • You can’t feed commits piecemeal to these commands, one input
    +      for one output; they block until standard in is closed
         • You can’t feed a list of possibly duplicate commits, like the output
           of git-last-modified(1); they effectively deduplicate the output
     
         Beyond these two points there’s also the input massage problem: you
         cannot feed mixed input (revisions mixed with arbitrary text).
     
    -    One might hope that git-cat-file(1) can save us. But it doesn’t support
    -    pretty formats.
    +    One might hope that git-cat-file(1) can save us. But it doesn’t
    +    support pretty formats.
     
         But there is one command that already both handles revisions as
    -    arguments, revisions on standard input, and even revisions mixed
    -    in with arbitrary text. Namely git-name-rev(1).
    +    arguments, revisions on standard input, and even revisions mixed in
    +    with arbitrary text. Namely git-name-rev(1): the command for outputting
    +    symbolic names for commits.
     
    -    Teach it to work in a format mode where the output for each revision is
    -    the pretty output (implies `--name-only`). This can be used to format
    -    any revision expression when given as arguments, and all full commit
    -    hashes in running text on stdin.
    +    We made some room in `builtin/name-rev.c` two commits ago. Let’s
    +    now add this new git-format-rev(1) command. Taking inspiration from
    +    git-name-rev(1), there are two modes:
     
    -    Just bring the hashes (to the pipeline). We will pretty print them.
    +    • revs: like git-name-rev(1) in argv mode, but one revision per line
    +      on standard in
    +    • text: like git-name-rev(1) with `--annotate-stdin`
    +
    +    ***
    +
    +    We need to add this command to the exception list in
    +    `t/t1517-outside-repo.sh` because it uses “EXPERIMENTAL!”
    +    in the usage line.
     
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    - ## Documentation/git-name-rev.adoc ##
    -@@ Documentation/git-name-rev.adoc: git-name-rev - Find symbolic names for given revs
    - SYNOPSIS
    - --------
    - [verse]
    --'git name-rev' [--tags] [--refs=<pattern>]
    -+'git name-rev' [--tags] [--refs=<pattern>] [--format=<pretty>]
    - 	       ( --all | --annotate-stdin | <commit-ish>... )
    - 
    - DESCRIPTION
    -@@ Documentation/git-name-rev.adoc: format parsable by 'git rev-parse'.
    - OPTIONS
    - -------
    - 
    -+--format=<pretty>::
    -+--no-format::
    -+	Format revisions instead of outputting symbolic names. The
    -+	default is `--no-format`.
    + ## Documentation/git-format-rev.adoc (new) ##
    +@@
    ++git-format-rev(1)
    ++=================
    ++
    ++NAME
    ++----
    ++git-format-rev - EXPERIMENTAL: Pretty format revisions on demand
    ++
    ++
    ++SYNOPSIS
    ++--------
    ++[synopsis]
    ++(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]
    ++
    ++DESCRIPTION
    ++-----------
    ++
    ++Pretty format revisions from standard input.
    ++
    ++THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
    ++
    ++OPTIONS
    ++-------
    ++
    ++`--stdin-mode=<mode>`::
    ++	How to interpret standard input data:
    +++
    ++--
    ++`revs`:: Each line is interpreted as a commit. Any kind of revision
    ++	expression can be used (see linkgit:gitrevisions[7]). Annotated
    ++	tags are peeled (see linkgit:gitglossary[7]).
     ++
    -+Implies `--name-only`. The negation `--no-format` implies
    -+`--no-name-only` (the default for the command).
    ++The argument `rev` is also accepted.
    ++`text`:: Formats all commit object names found in freeform text. These
    ++	must the full object names, i.e. abbreviated hexidecimal object
    ++	names will not be interpreted.
    ++--
     +
    - --tags::
    - 	Do not use branch names, but only tags to name the commits
    - 
    ++`--format=<pretty>`::
    ++	Pretty format string.
    ++
    ++`--notes=<ref>`::
    ++`--no-notes`::
    ++	Custom notes ref. Notes are displayed when using the `%N`
    ++	atom. See linkgit:git-notes[1].
    ++
    ++EXAMPLES
    ++--------
    ++
    ++The command linkgit:git-last-modified[1] shows the commit that each file
    ++was last modified in.
    ++
    ++----
    ++$ git last-modified -- README.md Makefile
    ++7798034171030be0909c56377a4e0e10e6d2df93	Makefile
    ++c50fbb2dd225e7e82abba4380423ae105089f4d7	README.md
    ++----
    ++
    ++We can pipe the result to this command in order to replace the object
    ++name with the commit author.
    ++
    ++----
    ++$ git last-modified -- README.md Makefile |
    ++    git format-rev --stdin-mode=text --format=%an
    ++Junio C Hamano	Makefile
    ++Todd Zullinger	README.md
    ++----
    ++
    ++Another example is _formatting commits in commit messages_. Given this commit message:
    ++
    ++----
    ++Fix off-by-one error
    ++
    ++Fix off-by-one error introduced in
    ++e83c5163316f89bfbde7d9ab23ca2e25604af290.
    ++
    ++We thought we fixed this in 5569bf9bbedd63a00780fc5c110e0cfab3aa97b9 but
    ++that only covered 1/3 of the faulty cases.
    ++----
    ++
    ++We can format the commits and use par(1) to reflow the text, say in a
    ++`commit-msg` hook:
    ++
    ++----
    ++$ git config set hook.reference-commits.event commit-msg
    ++$ git config set hook.reference-commits.command reference-commits
    ++$ cat $(which reference-commits)
    ++#/bin/sh
    ++
    ++msg="$1"
    ++rewritten=$(mktemp)
    ++git format-rev --stdin-mode=text --format=reference <"$msg" |
    ++    par >"$rewritten"
    ++mv "$rewritten" "$msg"
    ++----
    ++
    ++Which will produce something like this:
    ++
    ++----
    ++Fix off-by-one error
    ++
    ++Fix off-by-one error introduced in e83c5163316 (Implement better memory
    ++allocator, 2005-04-07).
    ++
    ++We thought we fixed this in 5569bf9bbed (Fix memory allocator,
    ++2005-06-22) but that only covered 1/3 of the faulty cases.
    ++----
    ++
    ++DISCUSSION
    ++----------
    ++
    ++This command lets you format any number of revisions in any order
    ++through one command invocation. Consider the
    ++linkgit:git-last-modified[1] case from the "EXAMPLES" section above:
    ++
    ++1. There might be hundreds of files
    ++2. Commits can be repeated, i.e. two or more files were last modified in
    ++   the same commit
    ++
    ++Two widely-used commands which pretty formats commits are
    ++linkgit:git-log[1] and linkgit:git-show[1]. It turns out that they are
    ++not a good fit for the above use case.
    ++
    ++- The output of linkgit:git-last-modified[1] would have to be processed
    ++  in stages since you need to transform the first column separately and
    ++  then link the author to the filename. But this is surmountable.
    ++- You can feed each commit to `git show` or `git show --no-walk -1`. But
    ++  that means that you need to create a process for each line.
    ++- Let’s say that you want to use one process, not one per line. So you
    ++  want to feed all the commits to the command. Now you face the problem
    ++  that you have to feed all the commits to the commands before you get
    ++  any output (this is also the case for the `--stdin` modes). In other
    ++  words, you cannot loop through each line, get the author for the
    ++  commit, and output the author and the filename. You need to feed all
    ++  the commits, get back all the output, and match the output with the
    ++  filename.
    ++- But the next problem is that commands will deduplicate the input and
    ++  only output one commit one single time only. Thus you cannot make the
    ++  output order match the input order, since a commit could have been
    ++  repeated in the original input.
    ++
    ++In short, it is straightforward to use these two commands if you use one
    ++process per line. It is much more work if you just want to use one
    ++process, but still doable. In contrast, this problem is just another
    ++shell pipeline with this command.
    ++
    ++GIT
    ++---
    ++Part of the linkgit:git[1] suite
    +
    + ## Makefile ##
    +@@ Makefile: BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
    + BUILT_INS += git-cherry$X
    + BUILT_INS += git-cherry-pick$X
    + BUILT_INS += git-format-patch$X
    ++BUILT_INS += git-format-rev$X
    + BUILT_INS += git-fsck-objects$X
    + BUILT_INS += git-init$X
    + BUILT_INS += git-maintenance$X
    +
    + ## builtin.h ##
    +@@ builtin.h: int cmd_fmt_merge_msg(int argc, const char **argv, const char *prefix, struct re
    + int cmd_for_each_ref(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_for_each_repo(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_format_patch(int argc, const char **argv, const char *prefix, struct repository *repo);
    ++int cmd_format_rev(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_fsck(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_fsmonitor__daemon(int argc, const char **argv, const char *prefix, struct repository *repo);
    + int cmd_gc(int argc, const char **argv, const char *prefix, struct repository *repo);
     
      ## builtin/name-rev.c ##
     @@
    @@ builtin/name-rev.c
      
      /*
       * One day.  See the 'name a rev shortly after epoch' test in t6120 when
    -@@ builtin/name-rev.c: struct rev_name {
    - 	int from_tag;
    +@@ builtin/name-rev.c: struct name_ref_data {
    + 	struct string_list exclude_filters;
      };
      
     +struct pretty_format {
    @@ builtin/name-rev.c: struct rev_name {
     +	struct userformat_want want;
     +};
     +
    -+struct format_cb_data {
    -+    const char *format;
    -+    int *name_only;
    + enum command_type {
    + 	NAME_REV = 1,
    ++	FORMAT_REV = 2,
     +};
     +
    - define_commit_slab(commit_rev_name, struct rev_name);
    ++enum stdin_mode {
    ++    TEXT = 1,
    ++    REVS = 2,
    + };
    + 
    + struct command {
    + 	enum command_type type;
    + 	union {
    + 		int name_only;
    ++		struct pretty_format *pretty_format;
    + 	} u;
    + };
      
    - static timestamp_t generation_cutoff = GENERATION_NUMBER_INFINITY;
    -@@ builtin/name-rev.c: static const char *get_exact_ref_match(const struct object *o)
    +@@ builtin/name-rev.c: static void init_name_rev_command(struct command *cmd,
    + 	cmd->u.name_only = name_only;
      }
      
    - /* may return a constant string or use "buf" as scratch space */
    --static const char *get_rev_name(const struct object *o, struct strbuf *buf)
    -+static const char *get_rev_name(const struct object *o,
    -+				struct pretty_format *format_ctx,
    -+				struct strbuf *buf)
    - {
    - 	struct rev_name *n;
    - 	const struct commit *c;
    -@@ builtin/name-rev.c: static const char *get_rev_name(const struct object *o, struct strbuf *buf)
    - 	if (o->type != OBJ_COMMIT)
    - 		return get_exact_ref_match(o);
    - 	c = (const struct commit *) o;
    ++static void init_format_rev_command(struct command *cmd,
    ++				    struct pretty_format *pretty_format)
    ++{
    ++	cmd->type = FORMAT_REV;
    ++	cmd->u.pretty_format = pretty_format;
    ++}
     +
    -+	if (format_ctx) {
    -+		strbuf_reset(buf);
    + static struct tip_table {
    + 	struct tip_table_entry {
    + 		struct object_id oid;
    +@@ builtin/name-rev.c: static const char *get_rev_name(const struct object *o, struct strbuf *buf)
    + 	}
    + }
    + 
    ++static const char *get_format_rev(const struct commit *c,
    ++				  struct pretty_format *format_ctx,
    ++				  struct strbuf *buf)
    ++{
    ++	strbuf_reset(buf);
     +
    -+		if (format_ctx->want.notes) {
    -+			struct strbuf notebuf = STRBUF_INIT;
    ++	if (format_ctx->want.notes) {
    ++		struct strbuf notebuf = STRBUF_INIT;
     +
    -+			format_display_notes(&c->object.oid, &notebuf,
    -+					     get_log_output_encoding(),
    -+					     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
    -+			format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
    -+		}
    ++		format_display_notes(&c->object.oid, &notebuf,
    ++				     get_log_output_encoding(),
    ++				     format_ctx->ctx.fmt == CMIT_FMT_USERFORMAT);
    ++		format_ctx->ctx.notes_message = strbuf_detach(&notebuf, NULL);
    ++	}
     +
    -+		pretty_print_commit(&format_ctx->ctx, c, buf);
    -+		FREE_AND_NULL(format_ctx->ctx.notes_message);
    ++	pretty_print_commit(&format_ctx->ctx, c, buf);
    ++	FREE_AND_NULL(format_ctx->ctx.notes_message);
     +
    -+		return buf->buf;
    -+	}
    ++	return buf->buf;
    ++}
     +
    - 	n = get_commit_rev_name(c);
    - 	if (!n)
    - 		return NULL;
    -@@ builtin/name-rev.c: static const char *get_rev_name(const struct object *o, struct strbuf *buf)
    - 
      static void show_name(const struct object *obj,
      		      const char *caller_name,
    -+		      struct pretty_format *format_ctx,
      		      int always, int allow_undefined, int name_only)
    - {
    - 	const char *name;
    -@@ builtin/name-rev.c: static void show_name(const struct object *obj,
    - 
    - 	if (!name_only)
    - 		printf("%s ", caller_name ? caller_name : oid_to_hex(oid));
    --	name = get_rev_name(obj, &buf);
    -+	name = get_rev_name(obj, format_ctx, &buf);
    - 	if (name)
    - 		printf("%s\n", name);
    - 	else if (allow_undefined)
    -@@ builtin/name-rev.c: static char const * const name_rev_usage[] = {
    - 	NULL
    - };
    - 
    --static void name_rev_line(char *p, struct name_ref_data *data)
    -+static void name_rev_line(char *p,
    -+			  struct name_ref_data *data,
    -+			  struct pretty_format *format_ctx)
    - {
    - 	struct strbuf buf = STRBUF_INIT;
    - 	int counter = 0;
    -@@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *data)
    - 				struct object *o =
    - 					lookup_object(the_repository, &oid);
    - 				if (o)
    --					name = get_rev_name(o, &buf);
    -+					name = get_rev_name(o, format_ctx, &buf);
    +@@ builtin/name-rev.c: static void name_rev_line(char *p, struct command *cmd)
    + 				else
    + 					printf("%.*s (%s)", p_len, p_start, name);
    + 				break;
    ++			case FORMAT_REV:
    ++				if (!oid_ret)
    ++					o = parse_object(the_repository, &oid);
    ++				if (o && o->type == OBJ_COMMIT)
    ++					name = get_format_rev((const struct commit *)o,
    ++							      cmd->u.pretty_format,
    ++							      &buf);
    ++				*(p + 1) = c;
    ++				if (name)
    ++					printf("%.*s%s", p_len - hexsz, p_start, name);
    ++				else
    ++					printf("%.*s", p_len, p_start);
    ++				break;
    + 			default:
    + 				BUG("uncovered case: %d", cmd->type);
      			}
    - 			*(p+1) = c;
    - 
    -@@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *data)
    - 	strbuf_release(&buf);
    +@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    + 	object_array_clear(&revs);
    + 	return 0;
      }
    - 
    -+static int format_cb(const struct option *option,
    -+		     const char *arg,
    -+		     int unset)
    ++
    ++static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
     +{
    -+	struct format_cb_data *data = option->value;
    -+	data->format = arg;
    -+	*data->name_only = !unset;
    -+	return 0;
    ++	if (!strcmp(stdin_mode, "text"))
    ++		return TEXT;
    ++	else if (!strcmp(stdin_mode, "revs") ||
    ++		 !strcmp(stdin_mode, "rev"))
    ++		return REVS;
    ++	else
    ++		die(_("'%s' needs to be either text, revs, or rev"),
    ++		    "--stdin-mode");
     +}
     +
    - int cmd_name_rev(int argc,
    - 		 const char **argv,
    - 		 const char *prefix,
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - #endif
    - 	int all = 0, annotate_stdin = 0, allow_undefined = 1, always = 0, peel_tag = 0;
    - 	struct name_ref_data data = { 0, 0, STRING_LIST_INIT_NODUP, STRING_LIST_INIT_NODUP };
    -+	static struct format_cb_data format_cb_data = { 0 };
    ++static char const *const format_rev_usage[] = {
    ++	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]"),
    ++	NULL
    ++};
    ++
    ++int cmd_format_rev(int argc,
    ++		   const char **argv,
    ++		   const char *prefix,
    ++		   struct repository *repo UNUSED)
    ++{
    ++	const char *format = NULL;
    ++	enum stdin_mode stdin_mode;
    ++	const char *stdin_mode_arg = NULL;
     +	struct display_notes_opt format_notes_opt;
     +	struct rev_info format_rev = REV_INFO_INIT;
    -+	struct pretty_format *format_ctx = NULL;
     +	struct pretty_format format_pp = { 0 };
     +	struct string_list notes = STRING_LIST_INIT_NODUP;
    - 	struct option opts[] = {
    - 		OPT_BOOL(0, "name-only", &data.name_only, N_("print only ref-based names (no object names)")),
    - 		OPT_BOOL(0, "tags", &data.tags_only, N_("only use tags to name the commits")),
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - 			   PARSE_OPT_HIDDEN),
    - #endif /* WITH_BREAKING_CHANGES */
    - 		OPT_BOOL(0, "annotate-stdin", &annotate_stdin, N_("annotate text from stdin")),
    -+		OPT_CALLBACK(0, "format", &format_cb_data, N_("format"),
    -+			     N_("pretty-print output instead"), format_cb),
    ++	struct strbuf scratch_buf = STRBUF_INIT;
    ++	struct command cmd;
    ++	struct option opts[] = {
    ++		OPT_STRING(0, "format", &format, N_("format"),
    ++			   N_("pretty format to use")),
    ++		OPT_STRING(0, "stdin-mode", &stdin_mode_arg, N_("stdin-mode"),
    ++			   N_("how revs are processed")),
     +		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
    -+				N_("display notes for --format")),
    - 		OPT_BOOL(0, "undefined", &allow_undefined, N_("allow to print `undefined` names (default)")),
    - 		OPT_BOOL(0, "always",     &always,
    - 			   N_("show abbreviated commit object as fallback")),
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - 		OPT_END(),
    - 	};
    - 
    ++				N_("display notes for pretty format")),
    ++		OPT_END(),
    ++	};
    ++
    ++	argc = parse_options(argc, argv, prefix, opts, format_rev_usage, 0);
    ++
    ++	if (argc > 0) {
    ++		error(_("too many arguments"));
    ++		usage_with_options(format_rev_usage, opts);
    ++	}
    ++
    ++	if (!format)
    ++		die(_("'%s' is required"), "--format");
    ++	if (!stdin_mode_arg)
    ++		die(_("'%s' is required"), "--stdin-mode");
    ++
     +	init_display_notes(&format_notes_opt);
    -+	format_cb_data.name_only = &data.name_only;
    - 	mem_pool_init(&string_pool, 0);
    - 	init_commit_rev_name(&rev_names);
    - 	repo_config(the_repository, git_default_config, NULL);
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - 	}
    - #endif
    - 
    -+	if (format_cb_data.format) {
    -+		get_commit_format(format_cb_data.format, &format_rev);
    -+		format_pp.ctx.rev = &format_rev;
    -+		format_pp.ctx.fmt = format_rev.commit_format;
    -+		format_pp.ctx.abbrev = format_rev.abbrev;
    -+		format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
    -+		format_pp.ctx.date_mode = format_rev.date_mode;
    -+		format_pp.ctx.color = GIT_COLOR_AUTO;
    -+
    -+		userformat_find_requirements(format_cb_data.format,
    -+					     &format_pp.want);
    -+		if (format_pp.want.notes) {
    -+			int ignore_show_notes = 0;
    -+			struct string_list_item *n;
    -+
    -+			for_each_string_list_item(n, &notes)
    -+				enable_ref_display_notes(&format_notes_opt,
    -+							 &ignore_show_notes,
    -+							 n->string);
    -+			load_display_notes(&format_notes_opt);
    ++	stdin_mode = parse_stdin_mode(stdin_mode_arg);
    ++
    ++	get_commit_format(format, &format_rev);
    ++	format_pp.ctx.rev = &format_rev;
    ++	format_pp.ctx.fmt = format_rev.commit_format;
    ++	format_pp.ctx.abbrev = format_rev.abbrev;
    ++	format_pp.ctx.date_mode_explicit = format_rev.date_mode_explicit;
    ++	format_pp.ctx.date_mode = format_rev.date_mode;
    ++	format_pp.ctx.color = GIT_COLOR_AUTO;
    ++
    ++	userformat_find_requirements(format,
    ++				     &format_pp.want);
    ++	if (format_pp.want.notes) {
    ++		int ignore_show_notes = 0;
    ++		struct string_list_item *n;
    ++
    ++		for_each_string_list_item(n, &notes)
    ++			enable_ref_display_notes(&format_notes_opt,
    ++						 &ignore_show_notes,
    ++						 n->string);
    ++		load_display_notes(&format_notes_opt);
    ++	}
    ++
    ++	init_format_rev_command(&cmd, &format_pp);
    ++
    ++	switch (stdin_mode) {
    ++	case TEXT:
    ++		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
    ++			strbuf_addch(&scratch_buf, '\n');
    ++			name_rev_line(scratch_buf.buf, &cmd);
     +		}
    ++		break;
    ++	case REVS:
    ++		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
    ++			struct object_id oid;
    ++			struct object *object;
    ++			struct object *peeled;
    ++			struct commit *commit;
    ++
    ++			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
    ++				fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
    ++					scratch_buf.buf);
    ++				continue;
    ++			}
    ++
    ++			object = parse_object(the_repository, &oid);
    ++			if (!object) {
    ++				fprintf(stderr, "Could not get object for %s. Skipping.\n",
    ++					scratch_buf.buf);
    ++				continue;
    ++			}
     +
    -+		format_ctx = &format_pp;
    ++			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
    ++			if (peeled && peeled->type == OBJ_COMMIT)
    ++				commit = (struct commit *)peeled;
    ++			if (!commit) {
    ++				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
    ++					*argv);
    ++				continue;
    ++			}
    ++
    ++			get_format_rev(commit, &format_pp, &scratch_buf);
    ++			printf("%s\n", scratch_buf.buf);
    ++			strbuf_release(&scratch_buf);
    ++		}
    ++		break;
    ++	default:
    ++		BUG("uncovered case: %d", stdin_mode);
     +	}
     +
    - 	if (all + annotate_stdin + !!argc > 1) {
    - 		error("Specify either a list, or --all, not both!");
    - 		usage_with_options(name_rev_usage, opts);
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - 
    - 		while (strbuf_getline(&sb, stdin) != EOF) {
    - 			strbuf_addch(&sb, '\n');
    --			name_rev_line(sb.buf, &data);
    -+			name_rev_line(sb.buf, &data, format_ctx);
    - 		}
    - 		strbuf_release(&sb);
    - 	} else if (all) {
    -@@ builtin/name-rev.c: int cmd_name_rev(int argc,
    - 			struct object *obj = get_indexed_object(the_repository, i);
    - 			if (!obj || obj->type != OBJ_COMMIT)
    - 				continue;
    --			show_name(obj, NULL,
    -+			show_name(obj, NULL, format_ctx,
    - 				  always, allow_undefined, data.name_only);
    - 		}
    - 	} else {
    - 		int i;
    - 		for (i = 0; i < revs.nr; i++)
    --			show_name(revs.objects[i].item, revs.objects[i].name,
    -+			show_name(revs.objects[i].item, revs.objects[i].name, format_ctx,
    - 				  always, allow_undefined, data.name_only);
    - 	}
    - 
    - 	string_list_clear(&data.ref_filters, 0);
    - 	string_list_clear(&data.exclude_filters, 0);
    ++	strbuf_release(&scratch_buf);
     +	string_list_clear(&notes, 0);
     +	release_display_notes(&format_notes_opt);
    - 	mem_pool_discard(&string_pool, 0);
    - 	object_array_clear(&revs);
    - 	return 0;
    ++	return 0;
    ++}
    +
    + ## command-list.txt ##
    +@@ command-list.txt: git-fmt-merge-msg                       purehelpers
    + git-for-each-ref                        plumbinginterrogators
    + git-for-each-repo                       plumbinginterrogators
    + git-format-patch                        mainporcelain
    ++git-format-rev                          plumbinginterrogators
    + git-fsck                                ancillaryinterrogators          complete
    + git-gc                                  mainporcelain
    + git-get-tar-commit-id                   plumbinginterrogators
    +
    + ## git.c ##
    +@@ git.c: static struct cmd_struct commands[] = {
    + 	{ "for-each-ref", cmd_for_each_ref, RUN_SETUP },
    + 	{ "for-each-repo", cmd_for_each_repo, RUN_SETUP_GENTLY },
    + 	{ "format-patch", cmd_format_patch, RUN_SETUP },
    ++	{ "format-rev", cmd_format_rev, RUN_SETUP },
    + 	{ "fsck", cmd_fsck, RUN_SETUP },
    + 	{ "fsck-objects", cmd_fsck, RUN_SETUP },
    + 	{ "fsmonitor--daemon", cmd_fsmonitor__daemon, RUN_SETUP },
    +
    + ## t/t1517-outside-repo.sh ##
    +@@ t/t1517-outside-repo.sh: do
    + 	archimport | citool | credential-netrc | credential-libsecret | \
    + 	credential-osxkeychain | cvsexportcommit | cvsimport | cvsserver | \
    + 	daemon | \
    +-	difftool--helper | filter-branch | fsck-objects | get-tar-commit-id | \
    ++	difftool--helper | filter-branch | format-rev | fsck-objects | \
    ++	get-tar-commit-id | \
    + 	gui | gui--askpass | \
    + 	http-backend | http-fetch | http-push | init-db | \
    + 	merge-octopus | merge-one-file | merge-resolve | mergetool | \
     
      ## t/t6120-describe.sh ##
    -@@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with commitGraph' '
    - 	)
    +@@ t/t6120-describe.sh: test_expect_success 'do not be fooled by invalid describe format ' '
    + 	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
      '
      
     +test_expect_success 'name-rev --format setup' '
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	test_commit -C repo-format eighth
     +'
     +
    -+test_expect_success 'name-rev --format --no-name-only' '
    -+	cat >expect <<-\EOF &&
    -+	HEAD~3 [fifth]
    -+	HEAD [eighth]
    -+	HEAD~5 [third]
    -+	EOF
    -+	git -C repo-format name-rev --format="[%s]" \
    -+		--no-name-only HEAD~3 HEAD HEAD~5 >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'name-rev --format --no-format is the same as regular name-rev' '
    -+	git -C repo-format name-rev HEAD~2 HEAD~3 >expect &&
    -+	test_file_not_empty expect &&
    -+	git -C repo-format name-rev --format="huh?" \
    -+		--no-format HEAD~2 HEAD~3 >actual &&
    -+	test_cmp expect actual
    -+'
    -+
    -+test_expect_success 'name-rev --format=%s for argument revs' '
    ++test_expect_success 'format-rev --stdin-mode=revs' '
     +	cat >expect <<-\EOF &&
     +	eighth
     +	seventh
     +	fifth
     +	EOF
    -+	git -C repo-format name-rev --format=%s \
    -+		HEAD HEAD~ HEAD~3 >actual &&
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format=%s >actual <<-\EOF &&
    ++	HEAD
    ++	HEAD~
    ++	HEAD~3
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--name-rev --format=reference --annotate-stdin from rev-list same as log' '
    ++test_expect_success 'format-rev --stdin-mode=text from rev-list same as log' '
     +	git -C repo-format log --format=reference >expect &&
     +	test_file_not_empty expect &&
     +	git -C repo-format rev-list HEAD >list &&
    -+	git -C repo-format name-rev --format=reference \
    -+		--annotate-stdin <list >actual &&
    ++	git -C repo-format format-rev --stdin-mode=text \
    ++		--format=reference <list >actual &&
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success '--name-rev --format=<pretty> --annotate-stdin with running text and tree oid' '
    ++test_expect_success 'format-rev --stdin-mode=text with running text and tree oid' '
     +	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
     +	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
     +	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	We thought we fixed this in ${reference}.
     +	But look at this tree: ${tree}.
     +	EOF
    -+	git -C repo-format name-rev --format=reference --annotate-stdin \
    ++	git -C repo-format format-rev --stdin-mode=text --format=reference \
     +		>actual <<-EOF &&
     +	We thought we fixed this in ${cmit_oid}.
     +	But look at this tree: ${tree}.
    @@ t/t6120-describe.sh: test_expect_success 'name-rev --annotate-stdin works with c
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'name-rev --format=<pretty> with %N (note)' '
    ++test_expect_success 'format-rev with %N (note)' '
     +	test_when_finished "git -C repo-format notes remove" &&
     +	git -C repo-format notes add -m"Make a note" &&
     +	printf "Make a note\n\n\n" >expect &&
    -+	git -C repo-format name-rev --format="tformat:%N" \
    -+		HEAD HEAD~ >actual &&
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format="tformat:%N" \
    ++		>actual <<-\EOF &&
    ++	HEAD
    ++	HEAD~
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    -+test_expect_success 'name-rev --format=<pretty> --notes<ref>' '
    ++test_expect_success 'format-rev --notes<ref> (custom notes ref)' '
     +	# One custom notes ref
     +	test_when_finished "git -C repo-format notes remove" &&
     +	test_when_finished "git -C repo-format notes --ref=word remove" &&
     +	git -C repo-format notes add -m"default" &&
     +	git -C repo-format notes --ref=word add -m"custom" &&
     +	printf "custom\n\n" >expect &&
    -+	git -C repo-format name-rev --format="tformat:%N" \
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format="tformat:%N" \
     +		--notes=word \
    -+		HEAD >actual &&
    ++		>actual <<-\EOF &&
    ++	HEAD
    ++	EOF
     +	test_cmp expect actual &&
     +	# Glob all
     +	printf "default\ncustom\n\n" >expect &&
    -+	git -C repo-format name-rev --format="tformat:%N" \
    -+		--notes=* \
    -+		HEAD >actual &&
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format="tformat:%N" \
    ++		--notes=* >actual <<-\EOF &&
    ++	HEAD
    ++	EOF
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'format-rev --stdin-mode=revs on annotated tag peels to commit' '
    ++	test_when_finished "git -C repo-format tag -d version" &&
    ++	git -C repo-format tag -a -m"new version" version &&
    ++	cat >expect <<-\EOF &&
    ++	eighth
    ++	EOF
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format=%s \
    ++		--notes=* >actual <<-\EOF &&
    ++	version
    ++	EOF
     +	test_cmp expect actual
     +'
     +
    - #               B
    - #               o
    - #  H             \
    + test_done

base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
2.54.0.13.g9c7419e39f8

