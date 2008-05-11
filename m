From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] git show documentation: no longer refer to git-diff-tree options
Date: Mon, 12 May 2008 00:37:23 +0200
Message-ID: <1210545443-12665-1-git-send-email-vmiklos@frugalware.org>
References: <7v3ap7gq3d.fsf@gitster.siamese.dyndns.org>
Cc: git@vger.kernel.org, nanako3@bluebottle.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon May 12 00:38:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JvKBn-0003b2-P6
	for gcvg-git-2@gmane.org; Mon, 12 May 2008 00:38:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755474AbYEKWhb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 11 May 2008 18:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754519AbYEKWhb
	(ORCPT <rfc822;git-outgoing>); Sun, 11 May 2008 18:37:31 -0400
Received: from yugo.dsd.sztaki.hu ([195.111.2.114]:37845 "EHLO
	yugo.frugalware.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751254AbYEKWha (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 May 2008 18:37:30 -0400
Received: from vmobile.example.net (dsl5401CB48.pool.t-online.hu [84.1.203.72])
	by yugo.frugalware.org (Postfix) with ESMTP id D1D7D1DDC5B;
	Mon, 12 May 2008 00:37:27 +0200 (CEST)
Received: by vmobile.example.net (Postfix, from userid 1003)
	id 0AB03185E19; Mon, 12 May 2008 00:37:23 +0200 (CEST)
X-Mailer: git-send-email 1.5.5.1
In-Reply-To: <7v3ap7gq3d.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81822>

The only git-diff-tree option that makes sense with git-show is '-s',
but (from a user's point of view) it has sightly different meaning,
since you don't have a --stdin option when using git-show.

This patch removes the reference to git-diff-tree options and adds
documentation for '-s', in the context of git-show.

It also includes git-diff options, but excludes the ones which are not
relevant for this command.

Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

On Sun, Apr 27, 2008 at 10:33:26AM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> Hmm, yes but not exactly.
>
> You lost --stat, --name-only and friends that were implied by
> mentioning
> "diff-tree".
>
> I agree your _motivation_ behind your original patch is good.  Saying
> "see
> also that page if you want to do very exotic and rarely useful
> operation"
> is one thing, but saying "described are most often used ones" and not
> describing enough is bad.
>
> Perhaps we would want to include diff-options.txt.  There may be some
> options that are no-op or always-on in the context of "git show" in
> the
> file, but we already have an infrastracture to turn parts of the
> inclusion
> on and off depending on which manual page includes it.

This patch implements this, I hope.

(Sorry for the delay, BTW.)

 Documentation/diff-options.txt |   10 ++++++++++
 Documentation/git-show.txt     |   14 ++++++++------
 2 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/Documentation/diff-options.txt b/Documentation/diff-options.txt
index 13234fa..af7846d 100644
--- a/Documentation/diff-options.txt
+++ b/Documentation/diff-options.txt
@@ -17,6 +17,7 @@ ifdef::git-format-patch[]
 	Generate patches without diffstat.
 endif::git-format-patch[]
 
+ifndef::git-show[]
 ifndef::git-format-patch[]
 -p::
 	Generate patch (see section on generating patches).
@@ -25,6 +26,7 @@ endif::git-format-patch[]
 
 -u::
 	Synonym for "-p".
+endif::git-show[]
 
 -U<n>::
 	Shorthand for "--unified=<n>".
@@ -37,8 +39,10 @@ endif::git-format-patch[]
 	Generate the raw format.
 	{git-diff-core? This is the default.}
 
+ifndef::git-show[]
 --patch-with-raw::
 	Synonym for "-p --raw".
+endif::git-show[]
 
 --stat[=width[,name-width]]::
 	Generate a diffstat.  You can override the default
@@ -70,6 +74,7 @@ endif::git-format-patch[]
 	Output a condensed summary of extended header information
 	such as creations, renames and mode changes.
 
+ifndef::git-show[]
 --patch-with-stat::
 	Synonym for "-p --stat".
 	{git-format-patch? This is the default.}
@@ -78,6 +83,7 @@ endif::git-format-patch[]
 	NUL-line termination on output.  This affects the --raw
 	output field terminator.  Also output from commands such
 	as "git-log" will be delimited with NUL between commits.
+endif::git-show[]
 
 --name-only::
 	Show only names of changed files.
@@ -159,6 +165,7 @@ endif::git-format-patch[]
 	the number of rename/copy targets exceeds the specified
 	number.
 
+ifndef::git-show[]
 -S<string>::
 	Look for differences that contain the change in <string>.
 
@@ -170,6 +177,7 @@ endif::git-format-patch[]
 --pickaxe-regex::
 	Make the <string> not a plain string but an extended POSIX
 	regex to match.
+endif::git-show[]
 
 -O<orderfile>::
 	Output the patch in the order specified in the
@@ -212,6 +220,7 @@ endif::git-format-patch[]
 -w::
 	Shorthand for "--ignore-all-space".
 
+ifndef::git-show[]
 --exit-code::
 	Make the program exit with codes similar to diff(1).
 	That is, it exits with 1 if there were differences and
@@ -219,6 +228,7 @@ endif::git-format-patch[]
 
 --quiet::
 	Disable all output of the program. Implies --exit-code.
+endif::git-show[]
 
 --ext-diff::
 	Allow an external diff helper to be executed. If you set an
diff --git a/Documentation/git-show.txt b/Documentation/git-show.txt
index dccf0e2..6b5c3fb 100644
--- a/Documentation/git-show.txt
+++ b/Documentation/git-show.txt
@@ -25,12 +25,6 @@ with \--name-only).
 
 For plain blobs, it shows the plain contents.
 
-The command takes options applicable to the linkgit:git-diff-tree[1] command to
-control how the changes the commit introduces are shown.
-
-This manual page describes only the most frequently used options.
-
-
 OPTIONS
 -------
 <object>::
@@ -38,6 +32,14 @@ OPTIONS
 	For a more complete list of ways to spell object names, see
 	"SPECIFYING REVISIONS" section in linkgit:git-rev-parse[1].
 
+-s, --quiet::
+	Don't show a textural diff for commits.
+
+
+:git-show: 1
+include::diff-options.txt[]
+
+
 include::pretty-options.txt[]
 
 
-- 
1.5.5.1
