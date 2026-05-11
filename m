Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 329A71E885A
	for <git@vger.kernel.org>; Mon, 11 May 2026 15:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778514467; cv=none; b=k3Y49IltzQDFEUHNoi49ActGfuaJfmp/aJ0bEloqebZC2kf+VSN9uNIAKr40kgCgFwIAoD7zFJLcvgN735uF2kozrdjTS1QUjvKzksvOrlmjDjLffhbDa25AizEwRwnDS5E1x49UL2LWUSrM+nNEAhwCsI+NYbyxXriC+aOFdj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778514467; c=relaxed/simple;
	bh=ACe4a+nbaAiHn7T3CXNcizABm6pPRoiiyPSSUvPdh6I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWkj2CrOaFr9KOy4VCFt7p6yz3my5hjxpVsatlt6qpy74xNbwLe4FNqLc548I4DJkcJelkxh1w0Yucntql5e1uxjr3laPdvGz8olg+UrUIU0NkIRuMxS3M3ez6Wi3+5VDcLCVRBxy6klz/RjTPdhdXIE0nr6sufdFVYJ1nOVmaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com; spf=pass smtp.mailfrom=fastmail.com; dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b=pLewYy/d; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=H+csxTH0; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fastmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fastmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fastmail.com header.i=@fastmail.com header.b="pLewYy/d";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="H+csxTH0"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6A873EC0017;
	Mon, 11 May 2026 11:47:43 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Mon, 11 May 2026 11:47:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fastmail.com; h=
	cc:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1778514463;
	 x=1778600863; bh=kiCBgoKGmp0NFqRB0XkniIoDMvCPDX8XVx5aXyUqQ+A=; b=
	pLewYy/d5ARb1UF5FpW+vawlh8xeTEeb652x7LIvhYmjX2sePoAVSHOJFxLXLTcw
	/uii9Penmwx8gAN0jOUmPIG4m1gWojObihFsQZLUuD9uJYXj3f95QDlalkTNQUL9
	FHFXOMshRC+Ke7WR9DdVUpSHH59EZJdi0HU5oU6R5bgxVZY51gEbAKiyo91kZ8lg
	IOIXWR7vsrSeHIDkOW8+nWZ7eMuacVG/0/hkA99L4p3LDUJguVvXPo4ErqCfvGFB
	sGi+hriZKWtVzzfo5XWGFSV4kGw7sIrjikltbh32aHjQAypza1nxKwbh99ulrri9
	OTCaT9AvR0pqKXcmUixOKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1778514463; x=
	1778600863; bh=kiCBgoKGmp0NFqRB0XkniIoDMvCPDX8XVx5aXyUqQ+A=; b=H
	+csxTH0nD3LT15UUKT5U7E09lZcJpHAp1um7m/MxufJeIUZg5SJ7EsXYHC3DJ01I
	mU9U2dGDoJTe11C4SbS8HgtBf1fP6uawSO2utGouHSFpAGzhJtbJd+nK/1ZCfdP5
	f7ts4BLIVbvBk0j3LgROk0iUUtj8Cng6K8EABO7dAbVkfhyMzDtPKGpQ4fQSOT4J
	G6hO6sLoubpt9lBJNSUAameRWxA22tQ07Kf9n462Sx3+uuaGEeesyYmk3erDBe12
	k0p8fBsB8jMOsi7Efjd0RBisdKR+H1vmtpCrjOZessrrUBWnKaGEHuxEU4Y0ZKNb
	rB/SbgpTzuyAvmcPI3TDA==
X-ME-Sender: <xms:H_oBaoo-b9kHcdGm_s5AF-_XchnwYx711zd_lPSTYtD900srMxnaKtA>
    <xme:H_oBapm79WhK2xdZ5ZVH7LKFN1LmyQ0NYZEss6gR6-nEJh-QlFyJo3QMVTzRGBU7Q
    iMKtMoWZq9yL_mS2xSkU0dlPTTe5KNX1cbc0fCIZ6W1G_tXm9seFgY>
X-ME-Received: <xmr:H_oBasPMQCQB39nWmJXPVBmhFz3nzXSHDKvjZ8-uDg2izmivX6ZWJEHm_3kSon2W9WNJeIief7fpbCvi9ffm1epmgzNAMgkZC3PNJhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudelfeefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnegfrh
    hlucfvnfffucdlvdefmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredt
    jeenucfhrhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrih
    hlrdgtohhmnecuggftrfgrthhtvghrnhephfekkeeuieefffdugeeuleegteejffegvedt
    lefhudetgeejhfefleekudegudetnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghdptg
    htgidruggrthgvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomhepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtoh
    hmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehg
    ihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgsh
    gsrghkkhdrnhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthho
    pehrrghmshgrhiesrhgrmhhsrgihjhhonhgvshdrphhluhhsrdgtohhm
X-ME-Proxy: <xmx:H_oBalNlIIRRLNoHym-aClpS9M4q6i_Al54gXCT-DXedNKsL59v74g>
    <xmx:H_oBaliSm6rm_W-FbWOGznRJrRrCUEGXy_WIIdzQ04schNil3-qFKA>
    <xmx:H_oBaqvNhzHH30vyGlNuM07TQSuAnx8OmnnV3nCLA67lMZQttrtrXA>
    <xmx:H_oBajQI80TbQbdxiL38-PSYAYHub_zfFQvZl2V52SK0hhoqGpHdVQ>
    <xmx:H_oBakA-T_8k-W3SxyYwZv1tB5li_7joMZ7VKHoBlxO02N4qcQ99HpqI>
Feedback-ID: i8b11424c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 May 2026 11:47:41 -0400 (EDT)
From: kristofferhaugsbakk@fastmail.com
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,
	git@vger.kernel.org,
	ben.knoble@gmail.com,
	Phillip Wood <phillip.wood@dunelm.org.uk>,
	Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH v5 5/5] format-rev: introduce builtin for on-demand pretty formatting
Date: Mon, 11 May 2026 17:45:49 +0200
Message-ID: <V5_format-rev_new_builtin.6ce@msgid.xyz>
X-Mailer: git-send-email 2.54.0.13.g9c7419e39f8
In-Reply-To: <V5_CV_format-rev.6c9@msgid.xyz>
References: <V4_CV_format-rev.6aa@msgid.xyz> <V5_CV_format-rev.6c9@msgid.xyz>
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

Helped-by: Phillip Wood <phillip.wood@dunelm.org.uk>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Kristoffer Haugsbakk <code@khaugsbakk.name>
---

Notes (series):
    v5:
    • (All doc changes)
    • Fix definition list mistake
      • No blank line between the two modes
      • Also replace `::` delimiters with `;;`. This is not strictly
        needed since the definition list is inside an open block. But
        it is consistent with all other definition list in definition
        lists I’ve seen. (The command option section is a long
        definition list.)
    • Rewrite part that I was unhappy about regarding
      `--stdin-mode=text` and `-z`:
    
        https://lore.kernel.org/git/c04d9cf9-e6a9-4e12-8025-9baededfdafc@app.fastmail.com/
    • Replace `abcdef012...` with just “some object name”. The object
      name is arbitrary and my AsciiDoc output seems to do some weird
      things for `...` inside backticks for HTML.
    • Replace “this problem is just another” with “this problem
      *is solved* with...”
    
    ***
    
    v4:
    • Squash in “SQUASH???” commits from Junio’s branch:
      • Fix -Werror=maybe-uninitialized at builtin/name-rev.c:893:25
      • Add this new builtin to Meson build file as well
    • Flush every output line/record with `maybe_flush_or_die(...)` (Phillip)
    • Introduce `-z` and other NUL output options (Phillip)
    • Tests:
      • More tests: “name lookup failures” (This would have caught my
        uninitialized mistake from v3)
      • More tests: for NUL/LF termination
      • Fix stale setup command which uses “name-rev” in the name
      • Use `setup:` prefix for both (now two) setup tests
      • Drop some `:/fifth` expressions in favor just `fifth` (the tag from
      `test_commit`)
    • Flesh out documentation
    • --stdin-mode=revs: Replace “Could not get [sha1][object name]” since the
      user could be using SHA256
      • This error string was originally stolen from name-rev
    • Remember to add this command to `.gitignore` this time
    • Correct doc to `git [show][log] --no-walk -1` (next to `git show`)
    • Plus some minor things!
    v3:
    • And don’t forget to document --notes this time
    
          https://lore.kernel.org/git/CALnO6CB5WOTp_e7Kv3CrEbQ+3XE-gDxNVHf7qATBEbyKWfxpLg@mail.gmail.com/

 .gitignore                        |   1 +
 Documentation/git-format-rev.adoc | 215 ++++++++++++++++++++++++++++
 Documentation/meson.build         |   1 +
 Makefile                          |   1 +
 builtin.h                         |   1 +
 builtin/name-rev.c                | 223 ++++++++++++++++++++++++++++++
 command-list.txt                  |   1 +
 git.c                             |   1 +
 t/t1517-outside-repo.sh           |   3 +-
 t/t6120-describe.sh               | 194 ++++++++++++++++++++++++++
 10 files changed, 640 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/git-format-rev.adoc

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
new file mode 100644
index 00000000000..c40d52e9f6d
--- /dev/null
+++ b/Documentation/git-format-rev.adoc
@@ -0,0 +1,215 @@
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
+(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> --format=<pretty> [--[no-]notes=<ref>] [-z] [--[no-]null-output] [--[no-]null-input]
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
+`revs`;; Each line or record (see the <<io,INPUT AND OUTPUT FORMATS>>
+	section) is interpreted as a commit. Any kind of revision
+	expression can be used (see linkgit:gitrevisions[7]). Annotated
+	tags are peeled (see linkgit:gitglossary[7]).
++
+The argument `rev` is also accepted.
+
+`text`;; Formats all commit object names found in freeform text. These
+	must the full object names, i.e. abbreviated hexidecimal object
+	names will not be interpreted.
++
+Anything that is parsed as an object name but that is not found to be a
+commit object name is left alone (echoed).
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
+`-z`::
+`--null`::
+	Use _NUL_ character to terminate both input and output instead
+	of newline. This option cannot be negated.
++
+This is useful if both the input and output could contain newlines or if
+the input to this command also uses _NUL_ character termination; see the
+<<io,INPUT AND OUTPUT FORMATS>> section below.
++
+The mode `--stdin-mode=text` can have use for this option when it needs
+to process input like for example `git last-modified -z`; see the
+<<examples,EXAMPLES>> section below.
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
+formatted commit, i.e. the format `%s` would transform some commit
+object name to `<subject>` without any termination. Like this:
+
+----
+Did we not fix this in "<subject>"?
+----
+
+It is safe to interactively read and write from this command since each
+record is immediately flushed.
+
+[[examples]]
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
+linkgit:git-last-modified[1] case from the <<examples,EXAMPLES>> section
+above:
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
+- You can feed each commit to `git show` or `git log --no-walk -1`. But
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
+process, but still doable. In contrast, this problem is solved with just
+another shell pipeline with this command.
+
+SEE ALSO
+--------
+linkgit:git-name-rev[1],
+linkgit:git-log[1].
+
+GIT
+---
+Part of the linkgit:git[1] suite
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
index 475efb0b82b..5494b0424b3 100644
--- a/builtin/name-rev.c
+++ b/builtin/name-rev.c
@@ -18,6 +18,10 @@
 #include "commit-graph.h"
 #include "wildmatch.h"
 #include "mem-pool.h"
+#include "pretty.h"
+#include "revision.h"
+#include "notes.h"
+#include "write-or-die.h"
 
 /*
  * One day.  See the 'name a rev shortly after epoch' test in t6120 when
@@ -272,14 +276,26 @@ struct name_ref_data {
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
 
@@ -290,6 +306,13 @@ static void init_name_rev_command(struct command *cmd,
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
@@ -495,6 +518,27 @@ static const char *get_rev_name(const struct object *o, struct strbuf *buf)
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
@@ -564,6 +608,18 @@ static void name_rev_line(char *p, struct command *cmd)
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
+				if (name)
+					printf("%.*s%s", p_len - hexsz, p_start, name);
+				else
+					printf("%.*s", p_len, p_start);
+				break;
 			default:
 				BUG("uncovered case: %d", cmd->type);
 			}
@@ -717,3 +773,170 @@ int cmd_name_rev(int argc,
 	object_array_clear(&revs);
 	return 0;
 }
+
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
+	N_("(EXPERIMENTAL!) git format-rev --stdin-mode=<mode> "
+	   "--format=<pretty> [--[no-]notes=<ref>] "
+	   "[-z] [--[no-]null-output] [--[no-]null-input]"),
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
+	struct format_nul_data nul_data = { 0, 0 };
+	char output_terminator;
+	strbuf_getline_fn getline_fn;
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
+		OPT_CALLBACK_F('z', "null", &nul_data, N_("z"),
+			       N_("Use NUL for input and output termination"),
+			       PARSE_OPT_NOARG | PARSE_OPT_NONEG, format_nul_cb),
+		OPT_BOOL(0, "null-input", &nul_data.nul_input,
+			 N_("Use NUL for input termination")),
+		OPT_BOOL(0, "null-output", &nul_data.nul_output,
+			 N_("Use NUL for output termination")),
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
+	getline_fn = nul_data.nul_input ? strbuf_getline_nul : strbuf_getline_lf;
+	output_terminator = nul_data.nul_output ? '\0' : '\n';
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
+		while (getline_fn(&scratch_buf, stdin) != EOF) {
+			name_rev_line(scratch_buf.buf, &cmd);
+			/*
+			 * We do not pass on the terminator to name_rev_line,
+			 * unlike name-rev.
+			 */
+			printf("%c", output_terminator);
+			maybe_flush_or_die(stdout, "stdout");
+		}
+		break;
+	case REVS:
+		while (getline_fn(&scratch_buf, stdin) != EOF) {
+			struct object_id oid;
+			struct object *object;
+			struct object *peeled;
+
+			if (repo_get_oid(the_repository, scratch_buf.buf, &oid)) {
+				fprintf(stderr, "Could not get object name for %s. Skipping.\n",
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
+			if (!peeled || peeled->type != OBJ_COMMIT) {
+				fprintf(stderr,
+					"Could not get commit for %s. Skipping.\n",
+					scratch_buf.buf);
+				continue;
+			}
+
+			get_format_rev((struct commit *)peeled,
+				       &format_pp, &scratch_buf);
+			printf("%s%c", scratch_buf.buf, output_terminator);
+			maybe_flush_or_die(stdout, "stdout");
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
index 62789f76381..8ee3d2c37d0 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -801,4 +801,198 @@ test_expect_success 'do not be fooled by invalid describe format ' '
 	test_must_fail git cat-file -t "refs/tags/super-invalid/./../...../ ~^:/?*[////\\\\\\&}/busted.lock-42-g"$(cat out)
 '
 
+test_expect_success 'setup: format-rev' '
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
+	cmit_oid=$(git -C repo-format rev-parse fifth) &&
+	reference=$(git -C repo-format log -n1 --format=reference fifth) &&
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
+		>actual <<-\EOF &&
+	version
+	EOF
+	test_cmp expect actual
+'
+
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
-- 
2.54.0.13.g9c7419e39f8

