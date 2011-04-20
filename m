From: Michael Witten <mfwitten@gmail.com>
Subject: [RFC 4/5] Date Mode: Documentation
Date: Wed, 20 Apr 2011 02:45:20 +0000
Message-ID: <7671f2f1-73d3-4978-ba1c-54e5dcaecadb-mfwitten@gmail.com>
References: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 20 04:58:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCNcf-00058d-0q
	for gcvg-git-2@lo.gmane.org; Wed, 20 Apr 2011 04:58:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1DTC61 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 22:58:27 -0400
Received: from mail-ey0-f174.google.com ([209.85.215.174]:44807 "EHLO
	mail-ey0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753778Ab1DTC60 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 22:58:26 -0400
Received: by eyx24 with SMTP id 24so82338eyx.19
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 19:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:date:from:to:message-id:in-reply-to
         :references;
        bh=fGZLuDFcbBDRrjsOdLE4T5nnL4E11NLcaJXj6YF1waM=;
        b=mAQCkrApje4Wvqi9p5x/0aBeKWa81KeKEKYtzKKnLPw+8UrPzlnlNsM8uRSBOkFh6e
         CrCDZ6TwcnSzIDPVYoJOZd5RPNFm1vgRkamGuXsJMrMdxsp5sxxnSx03TXlpVe6t+Qdz
         CH5mm9H+LRDOGH/U86XPaG55X9hnd0WipCHF0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:date:from:to:message-id:in-reply-to:references;
        b=ECzPcVbFkUyI2j7Znw5QSDGISDkh5cou0MeYYtgkxz5ljizIpZYQxp/IpvYfxaDWbn
         +ZGMrz0ez/h7+EkQKnkSv7bFJ0dLlBD87PKYdpVJF8etJYaa32W6/2bZfhcxBJMPdKqo
         uOSPf4Qj6i+JllQblg3/xq4G75kgcNBH5XGhI=
Received: by 10.213.20.218 with SMTP id g26mr2975351ebb.133.1303268305054;
        Tue, 19 Apr 2011 19:58:25 -0700 (PDT)
Received: from gmail.com (server105708.santrex.net [188.165.236.117])
        by mx.google.com with ESMTPS id x54sm330743eeh.19.2011.04.19.19.58.22
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 19:58:24 -0700 (PDT)
In-Reply-To: <0f30e048-7dd2-4aff-8c1f-00bf0dfa3d34-mfwitten@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171835>

Date: Tue, 19 Apr 2011 19:06:02 +0000
This commit updates the git documentation to reflect the new
date mode time zone features. As a result, the common date
mode documentation has been factored out into one file:

  Documentation/date-mode-docs.txt

which is included where necessary (sometimes with attribute
reference substitutions); this file is somewhat messy at
first glance (AsciiDoc is difficult to tame), but now all
of the essential information is centralized and quite
modular.

Signed-off-by: Michael Witten <mfwitten@gmail.com>
---
 Documentation/blame-options.txt    |    9 +---
 Documentation/config.txt           |   32 +++++++------
 Documentation/date-mode-docs.txt   |   87 ++++++++++++++++++++++++++++++++++++
 Documentation/git-for-each-ref.txt |   19 +++++++-
 Documentation/git-log.txt          |   43 ------------------
 Documentation/git-rev-list.txt     |    4 +-
 Documentation/git-svn.txt          |    2 +-
 Documentation/rev-list-options.txt |   28 +-----------
 8 files changed, 128 insertions(+), 96 deletions(-)
 create mode 100644 Documentation/date-mode-docs.txt

diff --git a/Documentation/blame-options.txt b/Documentation/blame-options.txt
index 16e3c68..deb824e 100644
--- a/Documentation/blame-options.txt
+++ b/Documentation/blame-options.txt
@@ -70,13 +70,8 @@ of lines before or after the line given by <start>.
 	tree copy has the contents of the named file (specify
 	`-` to make the command read from the standard input).
 
---date <format>::
-	The value is one of the following alternatives:
-	{relative,local,default,iso,rfc,short}. If --date is not
-	provided, the value of the blame.date config variable is
-	used. If the blame.date config variable is also not set, the
-	iso format is used. For more information, See the discussion
-	of the --date option at linkgit:git-log[1].
+:date mode options:
+include::date-mode-docs.txt[]
 
 -M|<num>|::
 	Detect moved or copied lines within a file. When a commit
diff --git a/Documentation/config.txt b/Documentation/config.txt
index 480dd0a..5bf9366 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -607,6 +607,9 @@ apply.whitespace::
 	Tells 'git apply' how to handle whitespaces, in the same way
 	as the '--whitespace' option. See linkgit:git-apply[1].
 
+:date mode config: blame
+include::date-mode-docs.txt[]
+
 branch.autosetupmerge::
 	Tells 'git branch' and 'git checkout' to set up new branches
 	so that linkgit:git-pull[1] will appropriately merge from the
@@ -1262,7 +1265,8 @@ i18n.commitEncoding::
 
 i18n.logOutputEncoding::
 	Character encoding the commit messages are converted to when
-	running 'git log' and friends.
+	running 'git log' and friends.  Defaults to the value of
+	`i18n.commitEncoding` if set, UTF-8 otherwise.
 
 imap::
 	The configuration variables in the 'imap' section are described
@@ -1300,12 +1304,8 @@ interactive.singlekey::
 	linkgit:git-add[1].  Note that this setting is silently
 	ignored if portable keystroke input is not available.
 
-log.date::
-	Set the default date-time mode for the 'log' command.
-	Setting a value for log.date is similar to using 'git log''s
-	`\--date` option.  Possible values are `relative`, `local`,
-	`default`, `iso`, `rfc`, and `short`; see linkgit:git-log[1]
-	for details.
+:date mode config: log
+include::date-mode-docs.txt[]
 
 log.decorate::
 	Print out the ref names of any commits that are shown by the log
@@ -1315,10 +1315,11 @@ log.decorate::
 	This is the same as the log commands '--decorate' option.
 
 log.showroot::
-	If true, the initial commit will be shown as a big creation event.
-	This is equivalent to a diff against an empty tree.
-	Tools like linkgit:git-log[1] or linkgit:git-whatchanged[1], which
-	normally hide the root commit will now show it. True by default.
+	If `true`, the initial commit will be shown as a big creation event;
+	this is equivalent to a diff against an empty tree. If `false`,
+	'git log' and related commands will not treat the initial commit as
+	a big creation event.  Any root commits in `git log -p` output would
+	be shown without a diff attached.  The default is `true`.
 
 mailmap.file::
 	The location of an augmenting mailmap file. The default
@@ -1391,13 +1392,14 @@ notes.displayRef::
 	exist, but a glob that does not match any refs is silently
 	ignored.
 +
-This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
-environment variable, which must be a colon separated list of refs or
-globs.
-+
 The effective value of "core.notesRef" (possibly overridden by
 GIT_NOTES_REF) is also implicitly added to the list of refs to be
 displayed.
++
+This setting can be overridden with the `GIT_NOTES_DISPLAY_REF`
+environment variable, which must be a colon separated list of refs or
+globs. It can also be overridden with 'git log''s `--notes` option.
+Also, this setting can be disabled by using 'git log''s `--no-notes` option.
 
 notes.rewrite.<command>::
 	When rewriting commits with <command> (currently `amend` or
diff --git a/Documentation/date-mode-docs.txt b/Documentation/date-mode-docs.txt
new file mode 100644
index 0000000..8f07d3f
--- /dev/null
+++ b/Documentation/date-mode-docs.txt
@@ -0,0 +1,87 @@
+ifdef::datemodeoptions[]
+
+:datemodeoptions!:
+
+--time-zone=<zone>::
+
+	Only takes effect for timestamps shown in a human-readable format (such
+	as when using "--pretty") and when the timestamp is interpreted in terms
+	of a time zone (for instance, this option has no effect when
+	`--date=raw` is specified).
++
+The <zone> may be one of the following:
++
+:date mode time zone values:
+include::date-mode-docs.txt[]
+
+--date=<format>::
+
+	Only takes effect for timestamps shown in a human-readable format (such
+	as when using "--pretty").
++
+The <format> may be one of the following:
++
+:date mode format values:
+include::date-mode-docs.txt[]
+
+--relative-date::
+
+	Synonym for `--date=relative`.
+
+endif::datemodeoptions[]
+
+ifdef::datemodetimezonevalues[]
+* *default* causes timestamps to be interpreted in terms of the time zone
+            recorded in the history.
+* *local*   causes timestamps to be interpreted in terms of the user's
+            time zone; on POSIX systems, the time zone may be selected
+            by setting the `TZ` environment variable appropriately
+            (for example, on GNU systems, the timestamps could be
+            interpreted in the `+0000` (UTC) time zone by something
+            like the following: `TZ=:UTC git log --time-zone=local`).
+
+:datemodetimezonevalues!:
+endif::datemodetimezonevalues[]
+
+ifdef::datemodeformatvalues[]
+* *default*  shows timestamps in git's original human-friendly format,
+             e.g. "Sat Jul 20 00:00:00 1985 -0400".
+* *relative* shows timestamps relative to the current time,
+             e.g. "2 hours ago".
+* *iso8601* (or *iso*) shows timestamps in ISO 8601 format,
+             kke.g. "1985-07-20 00:00:00 -0400".
+* *rfc2822* (or *rfc*) shows timestamps in RFC 2822 format
+            (which is used in email messages),
+             e.g. "Sat, 20 Jul 1985 00:00:00 -0400".
+* *short*    shows timestamps as only the date (no time) in `YYYY-MM-DD` format,
+             e.g. "1985-07-20".
+* *raw*      shows timestamps in the internal git format (as in GNU `date`'s
+            `"+%s %z"` format; that is,
+            "<seconds since The Epoch> <time zone in +HHMM format>"),
+             e.g. "490680000 -0400".
+
+:datemodeformatvalues!:
+endif::datemodeformatvalues[]
+
+ifdef::datemodeconfig[]
+:command: {datemodeconfig}
+:datemodeconfig!:
+
+{command}.timezone::
+	Set the default date mode time zone for the '{command}' command.
+	Setting a value for `{command}.timezone` is similar to using
+	'git {command}''s `\--time-zone` option.  Possible values are:
++
+:date mode time zone values:
+include::date-mode-docs.txt[]
+
+{command}.date::
+	Set the default date mode format for the '{command}' command.
+	Setting a value for `{command}.date` is similar to using
+	'git {command}''s `\--date` option.  Possible values are:
++
+:date mode format values:
+include::date-mode-docs.txt[]
+
+:command!:
+endif::datemodeconfig[]
diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 152e695..a91d2bf 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -114,9 +114,22 @@ the object referred by the ref does not cause an error.  It
 returns an empty string instead.
 
 As a special case for the date-type fields, you may specify a format for
-the date by adding one of `:default`, `:relative`, `:short`, `:local`,
-`:iso8601` or `:rfc2822` to the end of the fieldname; e.g.
-`%(taggerdate:relative)`.
+the date by adding one of the following to the end of the fieldname
+(e.g. `%(taggerdate:rfc)`):
+
+:date mode format values:
+include::date-mode-docs.txt[]
+
+Similarly, you may specify the time zone in which to interpret the
+date by adding one of the following to the end of the fieldname
+(e.g. `%(taggerdate&#64;local)`):
+
+:date mode time zone values:
+include::date-mode-docs.txt[]
+
+Of course, both the format and time zone specifications may be added
+at the same time (e.g. `%(taggerdate:rfc@local)` or, equivalently,
+`%(taggerdate&#64;local:rfc)`).
 
 
 EXAMPLES
diff --git a/Documentation/git-log.txt b/Documentation/git-log.txt
index de5c0d3..03e0ae3 100644
--- a/Documentation/git-log.txt
+++ b/Documentation/git-log.txt
@@ -139,49 +139,6 @@ Discussion
 
 include::i18n.txt[]
 
-Configuration
--------------
-
-See linkgit:git-config[1] for core variables and linkgit:git-diff[1]
-for settings related to diff generation.
-
-format.pretty::
-	Default for the `--format` option.  (See "PRETTY FORMATS" above.)
-	Defaults to "medium".
-
-i18n.logOutputEncoding::
-	Encoding to use when displaying logs.  (See "Discussion", above.)
-	Defaults to the value of `i18n.commitEncoding` if set, UTF-8
-	otherwise.
-
-log.date::
-	Default format for human-readable dates.  (Compare the
-	`--date` option.)  Defaults to "default", which means to write
-	dates like `Sat May 8 19:35:34 2010 -0500`.
-
-log.showroot::
-	If `false`, 'git log' and related commands will not treat the
-	initial commit as a big creation event.  Any root commits in
-	`git log -p` output would be shown without a diff attached.
-	The default is `true`.
-
-mailmap.file::
-	See linkgit:git-shortlog[1].
-
-notes.displayRef::
-	Which refs, in addition to the default set by `core.notesRef`
-	or 'GIT_NOTES_REF', to read notes from when showing commit
-	messages with the 'log' family of commands.  See
-	linkgit:git-notes[1].
-+
-May be an unabbreviated ref name or a glob and may be specified
-multiple times.  A warning will be issued for refs that do not exist,
-but a glob that does not match any refs is silently ignored.
-+
-This setting can be disabled by the `--no-notes` option,
-overridden by the 'GIT_NOTES_DISPLAY_REF' environment variable,
-and overridden by the `--notes=<ref>` option.
-
 GIT
 ---
 Part of the linkgit:git[1] suite
diff --git a/Documentation/git-rev-list.txt b/Documentation/git-rev-list.txt
index 415f4f0..5909913 100644
--- a/Documentation/git-rev-list.txt
+++ b/Documentation/git-rev-list.txt
@@ -44,7 +44,9 @@ SYNOPSIS
 	     [ \--regexp-ignore-case | -i ]
 	     [ \--extended-regexp | -E ]
 	     [ \--fixed-strings | -F ]
-	     [ \--date=(local|relative|default|iso|rfc|short) ]
+	     [ \--time-zone=<zone> ]
+	     [ \--date=<format> ]
+	     [ \--time-zone=<zone> ]
 	     [ [\--objects | \--objects-edge] [ \--unpacked ] ]
 	     [ \--pretty | \--header ]
 	     [ \--bisect ]
diff --git a/Documentation/git-svn.txt b/Documentation/git-svn.txt
index 71fc0ae..3e3ef7f 100644
--- a/Documentation/git-svn.txt
+++ b/Documentation/git-svn.txt
@@ -104,7 +104,7 @@ COMMANDS
 
 --localtime;;
 	Store Git commit times in the local timezone instead of UTC.  This
-	makes 'git log' (even without --date=local) show the same times
+	makes 'git log' (even without --time-zone=local) show the same times
 	that `svn log` would in the local timezone.
 +
 This doesn't interfere with interoperating with the Subversion
diff --git a/Documentation/rev-list-options.txt b/Documentation/rev-list-options.txt
index 73111bb..1494247 100644
--- a/Documentation/rev-list-options.txt
+++ b/Documentation/rev-list-options.txt
@@ -634,32 +634,8 @@ endif::git-rev-list[]
 
 include::pretty-options.txt[]
 
---relative-date::
-
-	Synonym for `--date=relative`.
-
---date=(relative|local|default|iso|rfc|short|raw)::
-
-	Only takes effect for dates shown in human-readable format, such
-	as when using "--pretty". `log.date` config variable sets a default
-	value for log command's --date option.
-+
-`--date=relative` shows dates relative to the current time,
-e.g. "2 hours ago".
-+
-`--date=local` shows timestamps in user's local timezone.
-+
-`--date=iso` (or `--date=iso8601`) shows timestamps in ISO 8601 format.
-+
-`--date=rfc` (or `--date=rfc2822`) shows timestamps in RFC 2822
-format, often found in E-mail messages.
-+
-`--date=short` shows only date but not time, in `YYYY-MM-DD` format.
-+
-`--date=raw` shows the date in the internal raw git format `%s %z` format.
-+
-`--date=default` shows timestamps in the original timezone
-(either committer's or author's).
+:date mode options:
+include::date-mode-docs.txt[]
 
 ifdef::git-rev-list[]
 --header::
-- 
1.7.4.18.g68fe8
