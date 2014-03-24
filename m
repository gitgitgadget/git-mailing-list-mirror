From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] parse-options: multi-word argh should use dash to separate words
Date: Mon, 24 Mar 2014 10:52:03 -0700
Message-ID: <1395683525-2868-2-git-send-email-gitster@pobox.com>
References: <1395481654-5920-1-git-send-email-ilya.bobyr@gmail.com>
 <1395683525-2868-1-git-send-email-gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 24 18:52:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WS933-0003Km-G3
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 18:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753677AbaCXRwR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Mar 2014 13:52:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41647 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753672AbaCXRwO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 13:52:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9180175B15;
	Mon, 24 Mar 2014 13:52:13 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=1LNI
	+50RklZbaX/fsIEXvXg4FR4=; b=Nm78NOKBvkUOv/Ly+heQs9KuiOKT/4vyBrAY
	ikiJdWLuC7LkQCn2kvcXuwEFG2zKCtlNVEcRzYh/w+oOk3uyd9TqxbTroBVW5BQN
	fADGYKiDQyNb0EGY8scKTcSBrrxIR+o/uSbRFMOBswrMvbfkhAvsIvdf7+N/tBmB
	lwaZrsA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:date:message-id:in-reply-to:references; q=dns; s=sasl; b=rvq6K9
	nhVA38F7pa6rKCa9o6LLzXCpwoUxfK2uuGcyDXXDMSQhQ3S13GksPDNy8QzV0/S7
	xGSPojaF4Yhi24gKt8gUAECh6o73hCpHJJku0lwx4C4QMJusN22WGAY2qHLZ7VuL
	bvRtmmnQ632KjG6bJyIQ6MZ08SzVF/LLNSj2Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7773B75B14;
	Mon, 24 Mar 2014 13:52:13 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9F67675B12;
	Mon, 24 Mar 2014 13:52:12 -0400 (EDT)
X-Mailer: git-send-email 1.9.1-471-g8d9dec6
In-Reply-To: <1395683525-2868-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 07560A82-B37D-11E3-A2E2-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244829>

"When you need to use space, use dash" is a strange way to say that
you must not use a space.  Because it is more common for the command
line descriptions to use dashed-multi-words, you do not even want to
use spaces in these places.  Rephrase the documentation to avoid
this strangeness.

Fix a few existing multi-word argument help strings, i.e.

 - GPG key-ids given to -S/--gpg-sign are "key-id";
 - Refs used for storing notes are "notes-ref"; and
 - Expiry timestamps given to --expire are "expiry-date".

and update the corresponding documentation pages.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Documentation/git-cherry-pick.txt |  6 +++---
 Documentation/git-commit.txt      |  2 +-
 Documentation/git-merge.txt       |  2 +-
 Documentation/git-notes.txt       |  2 +-
 Documentation/git-rev-parse.txt   | 16 ++++++++--------
 Documentation/git-revert.txt      |  6 +++---
 builtin/checkout.c                |  2 +-
 builtin/commit.c                  |  2 +-
 builtin/merge.c                   |  2 +-
 builtin/notes.c                   |  2 +-
 builtin/revert.c                  |  2 +-
 builtin/tag.c                     |  2 +-
 parse-options.h                   |  2 +-
 13 files changed, 24 insertions(+), 24 deletions(-)

diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-cherry-pick.txt
index f1e6b2f..1c03c79 100644
--- a/Documentation/git-cherry-pick.txt
+++ b/Documentation/git-cherry-pick.txt
@@ -9,7 +9,7 @@ SYNOPSIS
 --------
 [verse]
 'git cherry-pick' [--edit] [-n] [-m parent-number] [-s] [-x] [--ff]
-		  [-S[<keyid>]] <commit>...
+		  [-S[<key-id>]] <commit>...
 'git cherry-pick' --continue
 'git cherry-pick' --quit
 'git cherry-pick' --abort
@@ -101,8 +101,8 @@ effect to your index in a row.
 --signoff::
 	Add Signed-off-by line at the end of the commit message.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
+-S[<key-id>]::
+--gpg-sign[=<key-id>]::
 	GPG-sign commits.
 
 --ff::
diff --git a/Documentation/git-commit.txt b/Documentation/git-commit.txt
index 7c42e9c..d58758f 100644
--- a/Documentation/git-commit.txt
+++ b/Documentation/git-commit.txt
@@ -13,7 +13,7 @@ SYNOPSIS
 	   [-F <file> | -m <msg>] [--reset-author] [--allow-empty]
 	   [--allow-empty-message] [--no-verify] [-e] [--author=<author>]
 	   [--date=<date>] [--cleanup=<mode>] [--[no-]status]
-	   [-i | -o] [-S[<keyid>]] [--] [<file>...]
+	   [-i | -o] [-S[<key-id>]] [--] [<file>...]
 
 DESCRIPTION
 -----------
diff --git a/Documentation/git-merge.txt b/Documentation/git-merge.txt
index 4395459..a3c1fa3 100644
--- a/Documentation/git-merge.txt
+++ b/Documentation/git-merge.txt
@@ -10,7 +10,7 @@ SYNOPSIS
 --------
 [verse]
 'git merge' [-n] [--stat] [--no-commit] [--squash] [--[no-]edit]
-	[-s <strategy>] [-X <strategy-option>] [-S[<keyid>]]
+	[-s <strategy>] [-X <strategy-option>] [-S[<key-id>]]
 	[--[no-]rerere-autoupdate] [-m <msg>] [<commit>...]
 'git merge' <msg> HEAD <commit>...
 'git merge' --abort
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index 84bb0fe..310f0a5 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 'git notes' append [-F <file> | -m <msg> | (-c | -C) <object>] [<object>]
 'git notes' edit [<object>]
 'git notes' show [<object>]
-'git notes' merge [-v | -q] [-s <strategy> ] <notes_ref>
+'git notes' merge [-v | -q] [-s <strategy> ] <notes-ref>
 'git notes' merge --commit [-v | -q]
 'git notes' merge --abort [-v | -q]
 'git notes' remove [--ignore-missing] [--stdin] [<object>...]
diff --git a/Documentation/git-rev-parse.txt b/Documentation/git-rev-parse.txt
index e05e6b3..c452f33 100644
--- a/Documentation/git-rev-parse.txt
+++ b/Documentation/git-rev-parse.txt
@@ -290,14 +290,14 @@ The lines after the separator describe the options.
 Each line of options has this format:
 
 ------------
-<opt_spec><flags>*<arg_hint>? SP+ help LF
+<opt-spec><flags>*<arg-hint>? SP+ help LF
 ------------
 
-`<opt_spec>`::
+`<opt-spec>`::
 	its format is the short option character, then the long option name
 	separated by a comma. Both parts are not required, though at least one
 	is necessary. `h,help`, `dry-run` and `f` are all three correct
-	`<opt_spec>`.
+	`<opt-spec>`.
 
 `<flags>`::
 	`<flags>` are of `*`, `=`, `?` or `!`.
@@ -313,11 +313,11 @@ Each line of options has this format:
 
 	* Use `!` to not make the corresponding negated long option available.
 
-`<arg_hint>`::
-	`<arg_hint>`, if specified, is used as a name of the argument in the
-	help output, for options that take arguments. `<arg_hint>` is
-	terminated by the first whitespace. When you need to use space in the
-	argument hint use dash instead.
+`<arg-hint>`::
+	`<arg-hint>`, if specified, is used as a name of the argument in the
+	help output, for options that take arguments. `<arg-hint>` is
+	terminated by the first whitespace.  It is customary to use a
+	dash to separate words in a multi-word argument hint.
 
 The remainder of the line, after stripping the spaces, is used
 as the help associated to the option.
diff --git a/Documentation/git-revert.txt b/Documentation/git-revert.txt
index 9eb83f0..cceb5f2 100644
--- a/Documentation/git-revert.txt
+++ b/Documentation/git-revert.txt
@@ -8,7 +8,7 @@ git-revert - Revert some existing commits
 SYNOPSIS
 --------
 [verse]
-'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<keyid>]] <commit>...
+'git revert' [--[no-]edit] [-n] [-m parent-number] [-s] [-S[<key-id>]] <commit>...
 'git revert' --continue
 'git revert' --quit
 'git revert' --abort
@@ -80,8 +80,8 @@ more details.
 This is useful when reverting more than one commits'
 effect to your index in a row.
 
--S[<keyid>]::
---gpg-sign[=<keyid>]::
+-S[<key-id>]::
+--gpg-sign[=<key-id>]::
 	GPG-sign commits.
 
 -s::
diff --git a/builtin/checkout.c b/builtin/checkout.c
index ada51fa..a0e72d2 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1095,7 +1095,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 		OPT_BOOL(0, "detach", &opts.force_detach, N_("detach the HEAD at named commit")),
 		OPT_SET_INT('t', "track",  &opts.track, N_("set upstream info for new branch"),
 			BRANCH_TRACK_EXPLICIT),
-		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new branch"), N_("new unparented branch")),
+		OPT_STRING(0, "orphan", &opts.new_orphan_branch, N_("new-branch"), N_("new unparented branch")),
 		OPT_SET_INT('2', "ours", &opts.writeout_stage, N_("checkout our version for unmerged files"),
 			    2),
 		OPT_SET_INT('3', "theirs", &opts.writeout_stage, N_("checkout their version for unmerged files"),
diff --git a/builtin/commit.c b/builtin/commit.c
index 3783bca..96bf762 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1472,7 +1472,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('e', "edit", &edit_flag, N_("force edit of commit")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("default"), N_("how to strip spaces and #comments from message")),
 		OPT_BOOL(0, "status", &include_status, N_("include status in commit message template")),
-		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
+		{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		/* end commit message options */
 
diff --git a/builtin/merge.c b/builtin/merge.c
index f0cf120..2a144e1 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -220,7 +220,7 @@ static struct option builtin_merge_options[] = {
 	OPT_BOOL(0, "abort", &abort_current_merge,
 		N_("abort the current in-progress merge")),
 	OPT_SET_INT(0, "progress", &show_progress, N_("force progress reporting"), 1),
-	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key id"),
+	{ OPTION_STRING, 'S', "gpg-sign", &sign_commit, N_("key-id"),
 	  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 	OPT_BOOL(0, "overwrite-ignore", &overwrite_ignore, N_("update ignored files (default)")),
 	OPT_END()
diff --git a/builtin/notes.c b/builtin/notes.c
index bb89930..39c8573 100644
--- a/builtin/notes.c
+++ b/builtin/notes.c
@@ -939,7 +939,7 @@ int cmd_notes(int argc, const char **argv, const char *prefix)
 	int result;
 	const char *override_notes_ref = NULL;
 	struct option options[] = {
-		OPT_STRING(0, "ref", &override_notes_ref, N_("notes_ref"),
+		OPT_STRING(0, "ref", &override_notes_ref, N_("notes-ref"),
 			   N_("use notes from <notes_ref>")),
 		OPT_END()
 	};
diff --git a/builtin/revert.c b/builtin/revert.c
index 065d88d..f9ed5bd 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -89,7 +89,7 @@ static void parse_args(int argc, const char **argv, struct replay_opts *opts)
 		OPT_STRING(0, "strategy", &opts->strategy, N_("strategy"), N_("merge strategy")),
 		OPT_CALLBACK('X', "strategy-option", &opts, N_("option"),
 			N_("option for merge strategy"), option_parse_x),
-		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key id"),
+		{ OPTION_STRING, 'S', "gpg-sign", &opts->gpg_sign, N_("key-id"),
 		  N_("GPG sign commit"), PARSE_OPT_OPTARG, NULL, (intptr_t) "" },
 		OPT_END(),
 		OPT_END(),
diff --git a/builtin/tag.c b/builtin/tag.c
index 40356e3..6c7c6bd 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -513,7 +513,7 @@ int cmd_tag(int argc, const char **argv, const char *prefix)
 		OPT_BOOL('s', "sign", &opt.sign, N_("annotated and GPG-signed tag")),
 		OPT_STRING(0, "cleanup", &cleanup_arg, N_("mode"),
 			N_("how to strip spaces and #comments from message")),
-		OPT_STRING('u', "local-user", &keyid, N_("key id"),
+		OPT_STRING('u', "local-user", &keyid, N_("key-id"),
 					N_("use another key to sign the tag")),
 		OPT__FORCE(&force, N_("replace the tag if exists")),
 		OPT_COLUMN(0, "column", &colopts, N_("show tag list in columns")),
diff --git a/parse-options.h b/parse-options.h
index d670cb9..8fa02dc 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -143,7 +143,7 @@ struct option {
 	{ OPTION_CALLBACK, (s), (l), (v), N_("time"),(h), 0,	\
 	  parse_opt_approxidate_cb }
 #define OPT_EXPIRY_DATE(s, l, v, h) \
-	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry date"),(h), 0,	\
+	{ OPTION_CALLBACK, (s), (l), (v), N_("expiry-date"),(h), 0,	\
 	  parse_opt_expiry_date_cb }
 #define OPT_CALLBACK(s, l, v, a, h, f) \
 	{ OPTION_CALLBACK, (s), (l), (v), (a), (h), 0, (f) }
-- 
1.9.1-471-gcccbd8b
