Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E811C3B6360
	for <git@vger.kernel.org>; Thu,  7 May 2026 19:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778182483; cv=none; b=g0wym9voYOYFTBFgOLl1c9mKO+UBmqey1tZneVw2pNq9ebX7p0ZwL1KZ/YKcGCFFnEisoAjiJt6BF7uVEfP3nPQW/9vJNGcCoLJuzAaW1H+YZFtSGt6iRDYEJcc/16f6LOORNkugguhQcgUDR0mH16UtJA1S2BjhQF3NlqvFqHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778182483; c=relaxed/simple;
	bh=0fIJYwI/Fi6Hs5+50tJ5SCv+Qrqem1HLXMd0nz/HCP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=vD4wyumUByqT96M31/YzVOoSm5C3UFP97R2TFSk1Lcrr9TeXmFVpLZ3AUcT39knjNvF2D4kRKtziZW1Y1Pat49tUHn98w0SKUZWVYivw0Sg/D7tUkK2GeHCXjvc2b3dmU5a5tPXLhExGCloshpCf6OjHLImOtIPAQDon6CwQn8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=F/W0uXtV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=teIk5s7k; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="F/W0uXtV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="teIk5s7k"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.phl.internal (Postfix) with ESMTP id F3431EC00CE;
	Thu,  7 May 2026 15:34:38 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-10.internal (MEProxy); Thu, 07 May 2026 15:34:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778182478;
	 x=1778268878; bh=p9658eFMMrcJpyyTsxXgZNZNwJkb20wf9xrSVLfDOJg=; b=
	F/W0uXtV6euK9mohKsJ99TZk1Jze9wRs7x3027gXG+SaTuewo0dTYSXN6vYX0xEy
	22kHlYSyKB8Ex/uDygfyuo1M1ggoejHLNPiSCHOZsZvG3QcLVIPZgEV07Iuj7cvE
	LrTS56wj/9qM9iKQBLWkB529zTP6esqJFkGdZeWmJ+vcp/WonaUfA7rAOtmj6Sx5
	7ElvD30iw2Yir0qCA19pUs6a2bE+oCvBBHmRpvZJDK5jYcwA5EqHjNI3QXq2/qPR
	WDfxaS4U2LazHfHFxSgSKEABrlsOvSusO7RzEzs0Jsd78DS5b5zgt8yeyiwGjn7E
	uotbbPvBEjKTiEBDye46vg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778182478; x=
	1778268878; bh=p9658eFMMrcJpyyTsxXgZNZNwJkb20wf9xrSVLfDOJg=; b=t
	eIk5s7kXvQ40lTSdKFERcmZZVE8tDk95n73aCPWtwz0DfH8ZwcykRv8FetKi3C5w
	514umEMlrGCkDbiGwS1kMOX2O/ThHqUc63fjfhnjYFTDqrGG5fvlZybgbCJuJsug
	txngXx7rwjDOrQvimkheuprXPdogDNtzy3njJMh+CMA4P3ItmMgs4TpaKJLZHB6Q
	Ookf93As7AoVuyW0tMOV2MIa8vjbtNM+SATD7t0xUUDSr2NfKrrOfYabj4rIYsLK
	mICEOAOpUK6xLPITqNG93+IHITerUlmE4PGmeFA6sInjVTrp0ScKoGAegdTY4tDu
	JMwVAHlcWOMi6yIYrC5kg==
X-ME-Sender: <xms:Tun8aSK0SYnWpC4BDqtYiYiGqtxoT31ZpZOO5t-hIHRm5kyRJGRlCiw>
    <xme:Tun8aYGGyY2GoumJe2x8uig-UHatBZx7xByiOXJV0mGIBO47fqguTPE-9EbEPOlpw
    oD26hbEW6QGAKrSxo8yFqfMrah3pyEZOxTRpMh5CkduMUvmi3nnhQ>
X-ME-Received: <xmr:Tun8aVBsA0JhyaTtGeWuPbw4N5M6yLL9cmddD8KIy30uHTRVJtcUVfxW2QXKan1enVkPQVOAt9nfmDXvI_Z7rCvtYRCYxT_QPY_1emA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddutdekfedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhepudelgfeuieeuteekleeifeegudefheetkefh
    jeffkedvueehtdevhfekieekhffgnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehkrhhishht
    ohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdpnhgspghrtghpth
    htohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhk
    vghrnhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrg
    hmvgdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphht
    thhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtth
    hopehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:Tun8ab9YSLH2_f98pbMXoZcmN5AKMhsmc7g86GtJSDF7oBlP7wmUQg>
    <xmx:Tun8aRDTitE12qMwG_VWKo2bTN48ZsjEOtrUG-_A1FHejZdlJTA8SQ>
    <xmx:Tun8aQQN8soubLZaKs6K8RRIVcIqsMFoCesXbppUz6EuD4Grs6UTvQ>
    <xmx:Tun8aYtBoedfL0NlVTh8Fcz06H1VRBqDT4ujRf_DOmm2NSDi1SwhYQ>
    <xmx:Tun8abNNysYYJ5FX1GnFBjLAcIXqmDpbDMxb2Zr2GHsxW-Y_2UtHknK_>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 7 May 2026 15:34:36 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: git@vger.kernel.org
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v4 0/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Thu,  7 May 2026 21:34:19 +0200
Message-ID: <V4_CV_format-rev.6aa@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V3_CV_format-rev.66a@msgid.xyz>
References: <V3_CV_format-rev.66a@msgid.xyz>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Kristoffer Haugsbakk <code@khaugsbakk.name>

(Subject from v2: name-rev: learn --format=<pretty>)

Topic name (applied): kh/name-rev-custom-format

Topic summary: Introduce a new builtin for pretty formatting either (1) one
revision expression per line or (2) commit object names found in running
text.

See the last patch for the motivation. In short there isn’t anything that I
have found that lets you format however many commits you want through one
process (so looping over `git show` is excepted).

The other patches prepare for this change.

§ Changes in v4

Main changes are all in the final patch, with details on the Note there:

• Fix `-Werror=maybe-uninitialized` error
• Add NUL terminator options
• Use `maybe_flush_or_die(...)` to avoid potential deadlocks.

Also changes to patch 3/5 (see details on the Note).

There is also a lot of discussion about the input and output format and how
it works. I don’t know if it is valuable or just noise. Like this part:

    Regarding input in this mode: using `-z` or `--null-input` makes sure
    that _NUL_ characters in the input are passed through correctly.

This is just saying that NUL in the input will cut the processing short
unless `--null-input` is given (because we loop over a NUL-terminated C
string in `name_rev_line(...)`).

§ CI/CB

This time I ran GitHub actions (in my private fork) and let it
finish *before* sending this out.[1]

A lot of failures there but I did not see any errors relating to my
changes. I could just see `git-compat-util.h` errors and C11 `Generic`.

† 1: https://lore.kernel.org/git/374661c1-4676-4538-af24-0564f38469ca@app.fastmail.com/

§ Why experimental command? (unchanged in v4)

This command is marked Experimental three times (like git-replay(1)).[2]
Not so much because the UI design seems difficult. It’s more so that it can
be thrown out if it doesn’t end up being worth having around.

(*Experimental* also implies wholesale trashing. Right? That’s one possible
change in behavior.)

Or the behavior here could be moved somewhere else.

† 2: I vaguely recall reading a good argument for emphasizing this on the
     mailing list. I wasn’t able to find back to it right now.

§ Outstanding work

I could look more into how to do the translation strings for “X is
require” (arg), I’m probably missing something that already exists.

§ Link to v3

https://lore.kernel.org/git/V3_format-rev_new_builtin.66f@msgid.xyz/

[1/5] name-rev: wrap both blocks in braces
[2/5] name-rev: run clang-format before factoring code
[3/5] name-rev: factor code for sharing with a new command
[4/5] name-rev: make dedicated --annotate-stdin --name-only test
[5/5] format-rev: introduce builtin for on-demand pretty formatting

 .gitignore                        |   1 +
 Documentation/git-format-rev.adoc | 215 +++++++++++++++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/name-rev.c                | 300 +++++++++++++++++++++++++++---
 command-list.txt                  |   1 +
 git.c                             |   1 +
 t/t1517-outside-repo.sh           |   3 +-
 t/t6120-describe.sh               | 208 +++++++++++++++++++++
 10 files changed, 706 insertions(+), 26 deletions(-)
 create mode 100644 Documentation/git-format-rev.adoc

Interdiff against v3:
diff --git a/.gitignore b/.gitignore
index 24635cf2d6f..e406d3741cd 100644
--- a/.gitignore
+++ b/.gitignore
@@ -71,6 +71,7 @@
 /git-for-each-ref
 /git-for-each-repo
 /git-format-patch
+/git-format-rev
 /git-fsck
 /git-fsck-objects
 /git-fsmonitor--daemon
diff --git a/Documentation/git-format-rev.adoc b/Documentation/git-format-rev.adoc
index d960001d750..436980012bc 100644
--- a/Documentation/git-format-rev.adoc
+++ b/Documentation/git-format-rev.adoc
@@ -9,7 +9,7 @@ git-format-rev - EXPERIMENTAL: Pretty format revisions on demand
 SYNOPSIS
 --------
 [synopsis]
-(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]
+(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--[no-]notes=<ref>] [-z] [--[no-]null-output] [--[no-]null-input]
 
 DESCRIPTION
 -----------
@@ -25,7 +25,8 @@ OPTIONS
 	How to interpret standard input data:
 +
 --
-`revs`:: Each line is interpreted as a commit. Any kind of revision
+`revs`:: Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
+	section) is interpreted as a commit. Any kind of revision
 	expression can be used (see linkgit:gitrevisions[7]). Annotated
 	tags are peeled (see linkgit:gitglossary[7]).
 +
@@ -33,6 +34,9 @@ The argument `rev` is also accepted.
 `text`:: Formats all commit object names found in freeform text. These
 	must the full object names, i.e. abbreviated hexidecimal object
 	names will not be interpreted.
++
+Anything that is parsed as an object name but that is not found to be a
+commit object name is left alone (echoed).
 --
 
 `--format=<pretty>`::
@@ -43,6 +47,63 @@ The argument `rev` is also accepted.
 	Custom notes ref. Notes are displayed when using the `%N`
 	atom. See linkgit:git-notes[1].
 
+`-z`::
+`--null`::
+	Use _NUL_ character to terminate both input and output instead
+	of newline. This option cannot be negated.
++
+This is useful if both the input and output could contain newlines or if
+the input could contain _NUL_ characters; see the <<io,INPUT AND OUTPUT
+FORMATS>> section.
+
+`--null-output`::
+`--no-null-output`::
+	Use _NUL_ character to terminate output instead of newline. The
+	default is `--no-null-output`.
++
+This is useful if the output could contain newlines, for example if the
+`%n` (newline) atom is used.
+
+`--null-input`::
+`--no-null-input`::
+	Use _NUL_ character to terminate input instead of newline. The
+	default is `--no-null-input`.
++
+This is useful if the input revision expressions could contain newlines.
+It is also useful if the input could contain _NUL_ characters; see the
+<<io,INPUT AND OUTPUT FORMATS>> section.
+
+[[io]]
+INPUT AND OUTPUT FORMAT
+-----------------------
+
+The command uses newlines for both input and output termination by
+default. See the `-z`, `--null-output`, and `--null-input` options for
+using _NUL_ character as the terminator.
+
+The mode `--stdin-mode=revs` outputs one formatted commit followed by
+the terminator. This could either be called a _line_ or a _record_ in
+case "line" is too suggestive of newline termination.
+
+Note that this means that the terminator character (newline or _NUL_)
+acts as a _terminator_, not a _separator_. In other words, the final
+line or record is also terminated by the terminator character.
+
+The mode `--stdin-mode=text` replaces each object name with the
+formatted commit, i.e. the format `%s` would transform the object name
+`abcdef012...` to `<subject>` without any termination. Like this:
+
+----
+Did we not fix this in "<subject>"?
+----
+
+Regarding input in this mode: using `-z` or `--null-input` makes sure
+that _NUL_ characters in the input are passed through correctly.
+
+It is safe to interactively read and write from this command since each
+record is immediately flushed.
+
+[[examples]]
 EXAMPLES
 --------
 
@@ -110,7 +171,8 @@ DISCUSSION
 
 This command lets you format any number of revisions in any order
 through one command invocation. Consider the
-linkgit:git-last-modified[1] case from the "EXAMPLES" section above:
+linkgit:git-last-modified[1] case from the <<examples,EXAMPLES>> section
+above:
 
 1. There might be hundreds of files
 2. Commits can be repeated, i.e. two or more files were last modified in
@@ -123,7 +185,7 @@ not a good fit for the above use case.
 - The output of linkgit:git-last-modified[1] would have to be processed
   in stages since you need to transform the first column separately and
   then link the author to the filename. But this is surmountable.
-- You can feed each commit to `git show` or `git show --no-walk -1`. But
+- You can feed each commit to `git show` or `git log --no-walk -1`. But
   that means that you need to create a process for each line.
 - Let’s say that you want to use one process, not one per line. So you
   want to feed all the commits to the command. Now you face the problem
@@ -143,6 +205,11 @@ process per line. It is much more work if you just want to use one
 process, but still doable. In contrast, this problem is just another
 shell pipeline with this command.
 
+SEE ALSO
+--------
+linkgit:git-name-rev[1],
+linkgit:git-log[1].
+
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/meson.build b/Documentation/meson.build
index d6365b888bb..58e7c6a0b8a 100644
--- a/Documentation/meson.build
+++ b/Documentation/meson.build
@@ -55,6 +55,7 @@ manpages = {
   'git-for-each-ref.adoc' : 1,
   'git-for-each-repo.adoc' : 1,
   'git-format-patch.adoc' : 1,
+  'git-format-rev.adoc' : 1,
   'git-fsck-objects.adoc' : 1,
   'git-fsck.adoc' : 1,
   'git-fsmonitor--daemon.adoc' : 1,
diff --git a/builtin/name-rev.c b/builtin/name-rev.c
index b60cc766279..5494b0424b3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -21,6 +21,7 @@
 #include "pretty.h"
 #include "revision.h"
 #include "notes.h"
+#include "write-or-die.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -577,7 +578,6 @@ static void name_rev_line(char *p, struct command *cmd)
 
 	for (p_start = p; *p; p++) {
 #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
-	start:
 		if (!ishex(*p)) {
 			counter = 0;
 		} else if (++counter == hexsz &&
@@ -593,6 +593,7 @@ static void name_rev_line(char *p, struct command *cmd)
 
 			*(p + 1) = 0;
 			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
+			*(p + 1) = c;
 
 			switch (cmd->type) {
 			case NAME_REV:
@@ -600,9 +601,8 @@ static void name_rev_line(char *p, struct command *cmd)
 					o = lookup_object(the_repository, &oid);
 				if (o)
 					name = get_rev_name(o, &buf);
-				*(p + 1) = c;
 				if (!name)
-					goto start;
+					continue;
 				if (cmd->u.name_only)
 					printf("%.*s%s", p_len - hexsz, p_start, name);
 				else
@@ -615,7 +615,6 @@ static void name_rev_line(char *p, struct command *cmd)
 					name = get_format_rev((const struct commit *)o,
 							      cmd->u.pretty_format,
 							      &buf);
-				*(p + 1) = c;
 				if (name)
 					printf("%.*s%s", p_len - hexsz, p_start, name);
 				else
@@ -775,6 +774,23 @@ int cmd_name_rev(int argc,
 	return 0;
 }
 
+struct format_nul_data {
+	bool nul_input;
+	bool nul_output;
+};
+
+static int format_nul_cb(const struct option *option,
+			 const char *arg,
+			 int unset)
+{
+	struct format_nul_data *data = option->value;
+	data->nul_input = 1;
+	data->nul_output = 1;
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+	return 0;
+}
+
 static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
 {
 	if (!strcmp(stdin_mode, "text"))
@@ -788,7 +804,9 @@ static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
 }
 
 static char const *const format_rev_usage[] = {
-	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]"),
+	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> "
+	   "--format=<pretty> [--[no-]notes=<ref>] "
+	   "[-z] [--[no-]null-output] [--[no-]null-input]"),
 	NULL
 };
 
@@ -800,6 +818,9 @@ int cmd_format_rev(int argc,
 	const char *format = NULL;
 	enum stdin_mode stdin_mode;
 	const char *stdin_mode_arg = NULL;
+	struct format_nul_data nul_data = { 0, 0 };
+	char output_terminator;
+	strbuf_getline_fn getline_fn;
 	struct display_notes_opt format_notes_opt;
 	struct rev_info format_rev = REV_INFO_INIT;
 	struct pretty_format format_pp = { 0 };
@@ -813,6 +834,13 @@ int cmd_format_rev(int argc,
 			   N_("how revs are processed")),
 		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
 				N_("display notes for pretty format")),
+		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
+			       N_("Use NUL for input and output termination"),
+			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
+		OPT_BOOL(0, "null-input", &nul_data.nul_input,
+			 N_("Use NUL for input termination")),
+		OPT_BOOL(0, "null-output", &nul_data.nul_output,
+			 N_("Use NUL for output termination")),
 		OPT_END(),
 	};
 
@@ -828,6 +856,9 @@ int cmd_format_rev(int argc,
 	if (!stdin_mode_arg)
 		die(_("'%s' is required"), "--stdin-mode");
 
+	getline_fn = nul_data.nul_input ? strbuf_getline_nul : strbuf_getline_lf;
+	output_terminator = nul_data.nul_output ? '\0' : '\n';
+
 	init_display_notes(&format_notes_opt);
 	stdin_mode = parse_stdin_mode(stdin_mode_arg);
 
@@ -856,20 +887,24 @@ int cmd_format_rev(int argc,
 
 	switch (stdin_mode) {
 	case TEXT:
-		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
-			strbuf_addch(&scratch_buf, '\n');
+		while (getline_fn(&scratch_buf, stdin) != EOF) {
 			name_rev_line(scratch_buf.buf, &cmd);
+			/*
+			 * We do not pass on the terminator to name_rev_line,
+			 * unlike name-rev.
+			 */
+			printf("%c", output_terminator);
+			maybe_flush_or_die(stdout, "stdout");
 		}
 		break;
 	case REVS:
-		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
+		while (getline_fn(&scratch_buf, stdin) != EOF) {
 			struct object_id oid;
 			struct object *object;
 			struct object *peeled;
-			struct commit *commit;
 
 			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
-				fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
+				fprintf(stderr, "Could not get object name for %s. Skipping.\n",
 					scratch_buf.buf);
 				continue;
 			}
@@ -882,16 +917,17 @@ int cmd_format_rev(int argc,
 			}
 
 			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
-			if (peeled && peeled->type == OBJ_COMMIT)
-				commit = (struct commit *)peeled;
-			if (!commit) {
-				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
-					*argv);
+			if (!peeled || peeled->type != OBJ_COMMIT) {
+				fprintf(stderr,
+					"Could not get commit for %s. Skipping.\n",
+					scratch_buf.buf);
 				continue;
 			}
 
-			get_format_rev(commit, &format_pp, &scratch_buf);
-			printf("%s\n", scratch_buf.buf);
+			get_format_rev((struct commit *)peeled,
+				       &format_pp, &scratch_buf);
+			printf("%s%c", scratch_buf.buf, output_terminator);
+			maybe_flush_or_die(stdout, "stdout");
 			strbuf_release(&scratch_buf);
 		}
 		break;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 725f7d81b6b..8ee3d2c37d0 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -801,7 +801,7 @@ test_expect_success 'do not be fooled by invalid describe format ' '
 	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
 '
 
-test_expect_success 'name-rev --format setup' '
+test_expect_success 'setup: format-rev' '
 	mkdir repo-format &&
 	git -C repo-format init &&
 	test_commit -C repo-format first &&
@@ -839,8 +839,8 @@ test_expect_success 'format-rev --stdin-mode=text from rev-list same as log' '
 '
 
 test_expect_success 'format-rev --stdin-mode=text with running text and tree oid' '
-	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
-	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
+	cmit_oid=$(git -C repo-format rev-parse fifth) &&
+	reference=$(git -C repo-format log -n1 --format=reference fifth) &&
 	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
 	cat >expect <<-EOF &&
 	We thought we fixed this in ${reference}.
@@ -899,10 +899,100 @@ test_expect_success 'format-rev --stdin-mode=revs on annotated tag peels to comm
 	EOF
 	git -C repo-format format-rev --stdin-mode=revs \
 		--format=%s \
-		--notes=* >actual <<-\EOF &&
+		>actual <<-\EOF &&
 	version
 	EOF
 	test_cmp expect actual
 '
 
+test_expect_success 'format-rev --stdin-mode=revs lookup failures' '
+	test_when_finished "git -C repo-format tag -d tag-to-tree" &&
+	invalid_syntax=not-valid &&
+	non_existing_oid=${EMPTY_BLOB} &&
+	tree=$(git -C repo-format rev-parse eighth^{tree}) &&
+	git -C repo-format tag -a -mmessage tag-to-tree "$tree" &&
+	tag_to_tree=$(git -C repo-format rev-parse tag-to-tree) &&
+	cat >expect <<-EOF &&
+	Could not get object name for ${invalid_syntax}. Skipping.
+	Could not get object for ${non_existing_oid}. Skipping.
+	Could not get commit for ${tree}. Skipping.
+	Could not get commit for ${tag_to_tree}. Skipping.
+	EOF
+	git -C repo-format format-rev --stdin-mode=revs \
+		--format=%s \
+		2>actual >out <<-EOF &&
+	${invalid_syntax}
+	${non_existing_oid}
+	${tree}
+	${tag_to_tree}
+	EOF
+	test_line_count = 0 out &&
+	test_cmp expect actual
+'
+
+
+test_expect_success 'format-rev -z --stdin-mode=text with object name lookup failures' '
+	printf "%s\0" "$(git -C repo-format rev-parse HEAD)" >input &&
+	printf "%s\0" "$(git -C repo-format rev-parse HEAD^{tree})" >>input &&
+	printf "%s\0" "$EMPTY_BLOB" >>input &&
+	printf "%s\0" "$(git -C repo-format log --format=%s -1)" >expect &&
+	printf "%s\0" "$(git -C repo-format rev-parse HEAD^{tree})" >>expect &&
+	printf "%s\0" "$EMPTY_BLOB" >>expect &&
+	git -C repo-format format-rev --stdin-mode=text \
+		--format=%s -z <input >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'setup: format-rev input and output separators' '
+	git -C repo-format rev-list HEAD >input-lf &&
+	git -C repo-format rev-list -z HEAD >input-nul &&
+	git -C repo-format log --format=%s >output-lf &&
+	git -C repo-format log -z --format=%s >output-nul &&
+	echo revs >stdin-modes &&
+	echo text >>stdin-modes
+'
+
+while read mode
+do
+	test_expect_success "format-rev -z --stdin-mode=$mode" '
+		cat output-nul >expect &&
+		git -C repo-format format-rev --stdin-mode="$mode" \
+			--format=%s -z <input-nul >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "format-rev -z --no-null-input --no-null-output --stdin-mode=$mode" '
+		cat output-lf >expect &&
+		git -C repo-format format-rev --stdin-mode="$mode" \
+			--format=%s -z --no-null-input --no-null-output \
+			<input-lf >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "format-rev ---null-input --stdin-mode=$mode" '
+		cat output-lf >expect &&
+		git -C repo-format format-rev --stdin-mode="$mode" \
+			--format=%s --null-input \
+			<input-nul >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "format-rev --null-output --stdin-mode=$mode" '
+		cat output-nul >expect &&
+		git -C repo-format format-rev --stdin-mode="$mode" \
+			--format=%s --null-output \
+			<input-lf >actual &&
+		test_cmp expect actual
+	'
+
+	test_expect_success "format-rev -z --stdin-mode=$mode with multi-line output" '
+		format="%s%n%aI" &&
+		git -C repo-format log -z --format="$format" \
+			>expect &&
+		git -C repo-format format-rev --stdin-mode="$mode" \
+			--format="$format" -z <input-nul >actual &&
+		test_cmp expect actual
+	'
+done <stdin-modes
+
 test_done
Range-diff against v3:
1:  9cb5cfd1ec3 = 1:  9cb5cfd1ec3 name-rev: wrap both blocks in braces
2:  14900271321 = 2:  14900271321 name-rev: run clang-format before factoring code
3:  1f17f0b0090 ! 3:  724ec022894 name-rev: factor code for sharing with a new command
    @@ builtin/name-rev.c: static char const * const name_rev_usage[] = {
      	struct strbuf buf = STRBUF_INIT;
      	int counter = 0;
     @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *data)
    - 
    - 	for (p_start = p; *p; p++) {
    - #define ishex(x) (isdigit((x)) || ((x) >= 'a' && (x) <= 'f'))
    -+	start:
    - 		if (!ishex(*p)) {
    - 			counter = 0;
    - 		} else if (++counter == hexsz &&
    -@@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *data)
      			const char *name = NULL;
      			char c = *(p + 1);
      			int p_len = p - p_start + 1;
    @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
     -				struct object *o =
     -					lookup_object(the_repository, &oid);
     +			oid_ret = repo_get_oid(the_repository, p - (hexsz - 1), &oid);
    ++			*(p + 1) = c;
     +
     +			switch (cmd->type) {
     +			case NAME_REV:
    @@ builtin/name-rev.c: static void name_rev_line(char *p, struct name_ref_data *dat
     +					o = lookup_object(the_repository, &oid);
      				if (o)
      					name = get_rev_name(o, &buf);
    -+				*(p + 1) = c;
     +				if (!name)
    -+					goto start;
    ++					continue;
     +				if (cmd->u.name_only)
     +					printf("%.*s%s", p_len - hexsz, p_start, name);
     +				else
4:  40989b3672a = 4:  382efc3ddb8 name-rev: make dedicated --annotate-stdin --name-only test
5:  bb54e8f753e ! 5:  049a45e32bc format-rev: introduce builtin for on-demand pretty formatting
    @@ Commit message
         `t/t1517-outside-repo.sh` because it uses “EXPERIMENTAL!”
         in the usage line.
     
    +    Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
    +    Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
    +    Helped-by: Junio C Hamano <gitster@pobox.com>
         Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
     
    + ## .gitignore ##
    +@@
    + /git-for-each-ref
    + /git-for-each-repo
    + /git-format-patch
    ++/git-format-rev
    + /git-fsck
    + /git-fsck-objects
    + /git-fsmonitor--daemon
    +
      ## Documentation/git-format-rev.adoc (new) ##
     @@
     +git-format-rev(1)
    @@ Documentation/git-format-rev.adoc (new)
     +SYNOPSIS
     +--------
     +[synopsis]
    -+(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]
    ++(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--[no-]notes=<ref>] [-z] [--[no-]null-output] [--[no-]null-input]
     +
     +DESCRIPTION
     +-----------
    @@ Documentation/git-format-rev.adoc (new)
     +	How to interpret standard input data:
     ++
     +--
    -+`revs`:: Each line is interpreted as a commit. Any kind of revision
    ++`revs`:: Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
    ++	section) is interpreted as a commit. Any kind of revision
     +	expression can be used (see linkgit:gitrevisions[7]). Annotated
     +	tags are peeled (see linkgit:gitglossary[7]).
     ++
    @@ Documentation/git-format-rev.adoc (new)
     +`text`:: Formats all commit object names found in freeform text. These
     +	must the full object names, i.e. abbreviated hexidecimal object
     +	names will not be interpreted.
    +++
    ++Anything that is parsed as an object name but that is not found to be a
    ++commit object name is left alone (echoed).
     +--
     +
     +`--format=<pretty>`::
    @@ Documentation/git-format-rev.adoc (new)
     +	Custom notes ref. Notes are displayed when using the `%N`
     +	atom. See linkgit:git-notes[1].
     +
    ++`-z`::
    ++`--null`::
    ++	Use _NUL_ character to terminate both input and output instead
    ++	of newline. This option cannot be negated.
    +++
    ++This is useful if both the input and output could contain newlines or if
    ++the input could contain _NUL_ characters; see the <<io,INPUT AND OUTPUT
    ++FORMATS>> section.
    ++
    ++`--null-output`::
    ++`--no-null-output`::
    ++	Use _NUL_ character to terminate output instead of newline. The
    ++	default is `--no-null-output`.
    +++
    ++This is useful if the output could contain newlines, for example if the
    ++`%n` (newline) atom is used.
    ++
    ++`--null-input`::
    ++`--no-null-input`::
    ++	Use _NUL_ character to terminate input instead of newline. The
    ++	default is `--no-null-input`.
    +++
    ++This is useful if the input revision expressions could contain newlines.
    ++It is also useful if the input could contain _NUL_ characters; see the
    ++<<io,INPUT AND OUTPUT FORMATS>> section.
    ++
    ++[[io]]
    ++INPUT AND OUTPUT FORMAT
    ++-----------------------
    ++
    ++The command uses newlines for both input and output termination by
    ++default. See the `-z`, `--null-output`, and `--null-input` options for
    ++using _NUL_ character as the terminator.
    ++
    ++The mode `--stdin-mode=revs` outputs one formatted commit followed by
    ++the terminator. This could either be called a _line_ or a _record_ in
    ++case "line" is too suggestive of newline termination.
    ++
    ++Note that this means that the terminator character (newline or _NUL_)
    ++acts as a _terminator_, not a _separator_. In other words, the final
    ++line or record is also terminated by the terminator character.
    ++
    ++The mode `--stdin-mode=text` replaces each object name with the
    ++formatted commit, i.e. the format `%s` would transform the object name
    ++`abcdef012...` to `<subject>` without any termination. Like this:
    ++
    ++----
    ++Did we not fix this in "<subject>"?
    ++----
    ++
    ++Regarding input in this mode: using `-z` or `--null-input` makes sure
    ++that _NUL_ characters in the input are passed through correctly.
    ++
    ++It is safe to interactively read and write from this command since each
    ++record is immediately flushed.
    ++
    ++[[examples]]
     +EXAMPLES
     +--------
     +
    @@ Documentation/git-format-rev.adoc (new)
     +
     +This command lets you format any number of revisions in any order
     +through one command invocation. Consider the
    -+linkgit:git-last-modified[1] case from the "EXAMPLES" section above:
    ++linkgit:git-last-modified[1] case from the <<examples,EXAMPLES>> section
    ++above:
     +
     +1. There might be hundreds of files
     +2. Commits can be repeated, i.e. two or more files were last modified in
    @@ Documentation/git-format-rev.adoc (new)
     +- The output of linkgit:git-last-modified[1] would have to be processed
     +  in stages since you need to transform the first column separately and
     +  then link the author to the filename. But this is surmountable.
    -+- You can feed each commit to `git show` or `git show --no-walk -1`. But
    ++- You can feed each commit to `git show` or `git log --no-walk -1`. But
     +  that means that you need to create a process for each line.
     +- Let’s say that you want to use one process, not one per line. So you
     +  want to feed all the commits to the command. Now you face the problem
    @@ Documentation/git-format-rev.adoc (new)
     +process, but still doable. In contrast, this problem is just another
     +shell pipeline with this command.
     +
    ++SEE ALSO
    ++--------
    ++linkgit:git-name-rev[1],
    ++linkgit:git-log[1].
    ++
     +GIT
     +---
     +Part of the linkgit:git[1] suite
     
    + ## Documentation/meson.build ##
    +@@ Documentation/meson.build: manpages = {
    +   'git-for-each-ref.adoc' : 1,
    +   'git-for-each-repo.adoc' : 1,
    +   'git-format-patch.adoc' : 1,
    ++  'git-format-rev.adoc' : 1,
    +   'git-fsck-objects.adoc' : 1,
    +   'git-fsck.adoc' : 1,
    +   'git-fsmonitor--daemon.adoc' : 1,
    +
      ## Makefile ##
     @@ Makefile: BUILT_INS += $(patsubst builtin/%.o,git-%$X,$(BUILTIN_OBJS))
      BUILT_INS += git-cherry$X
    @@ builtin/name-rev.c
     +#include "pretty.h"
     +#include "revision.h"
     +#include "notes.h"
    ++#include "write-or-die.h"
      
      /*
       * One day.  See the 'name a rev shortly after epoch' test in t6120 when
    @@ builtin/name-rev.c: static void name_rev_line(char *p, struct command *cmd)
     +					name = get_format_rev((const struct commit *)o,
     +							      cmd->u.pretty_format,
     +							      &buf);
    -+				*(p + 1) = c;
     +				if (name)
     +					printf("%.*s%s", p_len - hexsz, p_start, name);
     +				else
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
      	return 0;
      }
     +
    ++struct format_nul_data {
    ++	bool nul_input;
    ++	bool nul_output;
    ++};
    ++
    ++static int format_nul_cb(const struct option *option,
    ++			 const char *arg,
    ++			 int unset)
    ++{
    ++	struct format_nul_data *data = option->value;
    ++	data->nul_input = 1;
    ++	data->nul_output = 1;
    ++	BUG_ON_OPT_NEG(unset);
    ++	BUG_ON_OPT_ARG(arg);
    ++	return 0;
    ++}
    ++
     +static enum stdin_mode parse_stdin_mode(const char *stdin_mode)
     +{
     +	if (!strcmp(stdin_mode, "text"))
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +}
     +
     +static char const *const format_rev_usage[] = {
    -+	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--notes=<ref>]"),
    ++	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> "
    ++	   "--format=<pretty> [--[no-]notes=<ref>] "
    ++	   "[-z] [--[no-]null-output] [--[no-]null-input]"),
     +	NULL
     +};
     +
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +	const char *format = NULL;
     +	enum stdin_mode stdin_mode;
     +	const char *stdin_mode_arg = NULL;
    ++	struct format_nul_data nul_data = { 0, 0 };
    ++	char output_terminator;
    ++	strbuf_getline_fn getline_fn;
     +	struct display_notes_opt format_notes_opt;
     +	struct rev_info format_rev = REV_INFO_INIT;
     +	struct pretty_format format_pp = { 0 };
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +			   N_("how revs are processed")),
     +		OPT_STRING_LIST(0, "notes", &notes, N_("notes"),
     +				N_("display notes for pretty format")),
    ++		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
    ++			       N_("Use NUL for input and output termination"),
    ++			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
    ++		OPT_BOOL(0, "null-input", &nul_data.nul_input,
    ++			 N_("Use NUL for input termination")),
    ++		OPT_BOOL(0, "null-output", &nul_data.nul_output,
    ++			 N_("Use NUL for output termination")),
     +		OPT_END(),
     +	};
     +
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +	if (!stdin_mode_arg)
     +		die(_("'%s' is required"), "--stdin-mode");
     +
    ++	getline_fn = nul_data.nul_input ? strbuf_getline_nul : strbuf_getline_lf;
    ++	output_terminator = nul_data.nul_output ? '\0' : '\n';
    ++
     +	init_display_notes(&format_notes_opt);
     +	stdin_mode = parse_stdin_mode(stdin_mode_arg);
     +
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +
     +	switch (stdin_mode) {
     +	case TEXT:
    -+		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
    -+			strbuf_addch(&scratch_buf, '\n');
    ++		while (getline_fn(&scratch_buf, stdin) != EOF) {
     +			name_rev_line(scratch_buf.buf, &cmd);
    ++			/*
    ++			 * We do not pass on the terminator to name_rev_line,
    ++			 * unlike name-rev.
    ++			 */
    ++			printf("%c", output_terminator);
    ++			maybe_flush_or_die(stdout, "stdout");
     +		}
     +		break;
     +	case REVS:
    -+		while (strbuf_getline(&scratch_buf, stdin) != EOF) {
    ++		while (getline_fn(&scratch_buf, stdin) != EOF) {
     +			struct object_id oid;
     +			struct object *object;
     +			struct object *peeled;
    -+			struct commit *commit;
     +
     +			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
    -+				fprintf(stderr, "Could not get sha1 for %s. Skipping.\n",
    ++				fprintf(stderr, "Could not get object name for %s. Skipping.\n",
     +					scratch_buf.buf);
     +				continue;
     +			}
    @@ builtin/name-rev.c: int cmd_name_rev(int argc,
     +			}
     +
     +			peeled = deref_tag(the_repository, object, scratch_buf.buf, 0);
    -+			if (peeled && peeled->type == OBJ_COMMIT)
    -+				commit = (struct commit *)peeled;
    -+			if (!commit) {
    -+				fprintf(stderr, "Could not get commit for %s. Skipping.\n",
    -+					*argv);
    ++			if (!peeled || peeled->type != OBJ_COMMIT) {
    ++				fprintf(stderr,
    ++					"Could not get commit for %s. Skipping.\n",
    ++					scratch_buf.buf);
     +				continue;
     +			}
     +
    -+			get_format_rev(commit, &format_pp, &scratch_buf);
    -+			printf("%s\n", scratch_buf.buf);
    ++			get_format_rev((struct commit *)peeled,
    ++				       &format_pp, &scratch_buf);
    ++			printf("%s%c", scratch_buf.buf, output_terminator);
    ++			maybe_flush_or_die(stdout, "stdout");
     +			strbuf_release(&scratch_buf);
     +		}
     +		break;
    @@ t/t6120-describe.sh: test_expect_success 'do not be fooled by invalid describe f
      	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
      '
      
    -+test_expect_success 'name-rev --format setup' '
    ++test_expect_success 'setup: format-rev' '
     +	mkdir repo-format &&
     +	git -C repo-format init &&
     +	test_commit -C repo-format first &&
    @@ t/t6120-describe.sh: test_expect_success 'do not be fooled by invalid describe f
     +'
     +
     +test_expect_success 'format-rev --stdin-mode=text with running text and tree oid' '
    -+	cmit_oid=$(git -C repo-format rev-parse :/fifth) &&
    -+	reference=$(git -C repo-format log -n1 --format=reference :/fifth) &&
    ++	cmit_oid=$(git -C repo-format rev-parse fifth) &&
    ++	reference=$(git -C repo-format log -n1 --format=reference fifth) &&
     +	tree=$(git -C repo-format rev-parse HEAD^{tree}) &&
     +	cat >expect <<-EOF &&
     +	We thought we fixed this in ${reference}.
    @@ t/t6120-describe.sh: test_expect_success 'do not be fooled by invalid describe f
     +	EOF
     +	git -C repo-format format-rev --stdin-mode=revs \
     +		--format=%s \
    -+		--notes=* >actual <<-\EOF &&
    ++		>actual <<-\EOF &&
     +	version
     +	EOF
     +	test_cmp expect actual
     +'
    ++
    ++test_expect_success 'format-rev --stdin-mode=revs lookup failures' '
    ++	test_when_finished "git -C repo-format tag -d tag-to-tree" &&
    ++	invalid_syntax=not-valid &&
    ++	non_existing_oid=${EMPTY_BLOB} &&
    ++	tree=$(git -C repo-format rev-parse eighth^{tree}) &&
    ++	git -C repo-format tag -a -mmessage tag-to-tree "$tree" &&
    ++	tag_to_tree=$(git -C repo-format rev-parse tag-to-tree) &&
    ++	cat >expect <<-EOF &&
    ++	Could not get object name for ${invalid_syntax}. Skipping.
    ++	Could not get object for ${non_existing_oid}. Skipping.
    ++	Could not get commit for ${tree}. Skipping.
    ++	Could not get commit for ${tag_to_tree}. Skipping.
    ++	EOF
    ++	git -C repo-format format-rev --stdin-mode=revs \
    ++		--format=%s \
    ++		2>actual >out <<-EOF &&
    ++	${invalid_syntax}
    ++	${non_existing_oid}
    ++	${tree}
    ++	${tag_to_tree}
    ++	EOF
    ++	test_line_count = 0 out &&
    ++	test_cmp expect actual
    ++'
    ++
    ++
    ++test_expect_success 'format-rev -z --stdin-mode=text with object name lookup failures' '
    ++	printf "%s\0" "$(git -C repo-format rev-parse HEAD)" >input &&
    ++	printf "%s\0" "$(git -C repo-format rev-parse HEAD^{tree})" >>input &&
    ++	printf "%s\0" "$EMPTY_BLOB" >>input &&
    ++	printf "%s\0" "$(git -C repo-format log --format=%s -1)" >expect &&
    ++	printf "%s\0" "$(git -C repo-format rev-parse HEAD^{tree})" >>expect &&
    ++	printf "%s\0" "$EMPTY_BLOB" >>expect &&
    ++	git -C repo-format format-rev --stdin-mode=text \
    ++		--format=%s -z <input >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'setup: format-rev input and output separators' '
    ++	git -C repo-format rev-list HEAD >input-lf &&
    ++	git -C repo-format rev-list -z HEAD >input-nul &&
    ++	git -C repo-format log --format=%s >output-lf &&
    ++	git -C repo-format log -z --format=%s >output-nul &&
    ++	echo revs >stdin-modes &&
    ++	echo text >>stdin-modes
    ++'
    ++
    ++while read mode
    ++do
    ++	test_expect_success "format-rev -z --stdin-mode=$mode" '
    ++		cat output-nul >expect &&
    ++		git -C repo-format format-rev --stdin-mode="$mode" \
    ++			--format=%s -z <input-nul >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "format-rev -z --no-null-input --no-null-output --stdin-mode=$mode" '
    ++		cat output-lf >expect &&
    ++		git -C repo-format format-rev --stdin-mode="$mode" \
    ++			--format=%s -z --no-null-input --no-null-output \
    ++			<input-lf >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "format-rev ---null-input --stdin-mode=$mode" '
    ++		cat output-lf >expect &&
    ++		git -C repo-format format-rev --stdin-mode="$mode" \
    ++			--format=%s --null-input \
    ++			<input-nul >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "format-rev --null-output --stdin-mode=$mode" '
    ++		cat output-nul >expect &&
    ++		git -C repo-format format-rev --stdin-mode="$mode" \
    ++			--format=%s --null-output \
    ++			<input-lf >actual &&
    ++		test_cmp expect actual
    ++	'
    ++
    ++	test_expect_success "format-rev -z --stdin-mode=$mode with multi-line output" '
    ++		format="%s%n%aI" &&
    ++		git -C repo-format log -z --format="$format" \
    ++			>expect &&
    ++		git -C repo-format format-rev --stdin-mode="$mode" \
    ++			--format="$format" -z <input-nul >actual &&
    ++		test_cmp expect actual
    ++	'
    ++done <stdin-modes
     +
      test_done

base-commit: 67006b9db8b772423ad0706029286096307d2567
-- 
2.54.0.13.g9c7419e39f8

