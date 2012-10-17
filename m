From: Eric Blake <eblake@redhat.com>
Subject: [PATCH] notes: mention --notes in more places
Date: Tue, 16 Oct 2012 21:19:35 -0600
Message-ID: <1350443975-19935-1-git-send-email-eblake@redhat.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 17 05:32:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TOKMR-000203-P2
	for gcvg-git-2@plane.gmane.org; Wed, 17 Oct 2012 05:32:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756012Ab2JQDbs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 23:31:48 -0400
Received: from qmta14.emeryville.ca.mail.comcast.net ([76.96.27.212]:44040
	"EHLO qmta14.emeryville.ca.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755690Ab2JQDbs (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 23:31:48 -0400
X-Greylist: delayed 426 seconds by postgrey-1.27 at vger.kernel.org; Tue, 16 Oct 2012 23:31:48 EDT
Received: from omta04.emeryville.ca.mail.comcast.net ([76.96.30.35])
	by qmta14.emeryville.ca.mail.comcast.net with comcast
	id C3KZ1k0030lTkoCAE3QibK; Wed, 17 Oct 2012 03:24:42 +0000
Received: from office.redhat.com ([24.10.251.25])
	by omta04.emeryville.ca.mail.comcast.net with comcast
	id C3Kc1k00H0ZdyUg8Q3Khys; Wed, 17 Oct 2012 03:19:42 +0000
X-Mailer: git-send-email 1.7.11.7
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207889>

Every so often, I search 'git send-email --help' to remember some
option I've used in the past, only to discover that the option is
documented instead in 'git format-patch --help'.  Worse, even that
command didn't document the option I was looking for today, which
was how to include 'git notes' in the body of the commits I was
mailing.  Reading 'git notes --help' didn't mention this either,
and I had to resort to searching the source code.  It can't hurt
to add some documentation to make this option less obscure.

* git-notes.txt: Mention that --notes option exists in many
commands to override defaults.
* git-format-patch.txt: Include pretty-options, for things like
--notes.
* git-send-email.txt: Mention that revision lists forwarded to
format-patch can also include options.

Signed-off-by: Eric Blake <eblake@redhat.com>
---
 Documentation/git-format-patch.txt | 2 ++
 Documentation/git-notes.txt        | 6 ++++--
 Documentation/git-send-email.txt   | 3 ++-
 3 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 6d43f56..a068f37 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -222,6 +222,8 @@ you can use `--suffix=-patch` to get `0001-description-of-my-change-patch`.
 	range are always formatted as creation patches, independently
 	of this flag.

+include::pretty-options.txt[]
+
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each message,
diff --git a/Documentation/git-notes.txt b/Documentation/git-notes.txt
index b95aafa..be9e60f 100644
--- a/Documentation/git-notes.txt
+++ b/Documentation/git-notes.txt
@@ -39,8 +39,10 @@ message stored in the commit object, the notes are indented like the
 message, after an unindented line saying "Notes (<refname>):" (or
 "Notes:" for `refs/notes/commits`).

-To change which notes are shown by 'git log', see the
-"notes.displayRef" configuration in linkgit:git-log[1].
+To change which notes are shown by default in 'git log', see the
+"notes.displayRef" configuration in linkgit:git-log[1].  Also,
+many commands understand a `--notes` option to alter the set of
+notes displayed (see linkgit:git-rev-list[1]).

 See the "notes.rewrite.<command>" configuration for a way to carry
 notes across commands that rewrite commits.
diff --git a/Documentation/git-send-email.txt b/Documentation/git-send-email.txt
index eeb561c..450d975 100644
--- a/Documentation/git-send-email.txt
+++ b/Documentation/git-send-email.txt
@@ -18,7 +18,8 @@ Takes the patches given on the command line and emails them out.
 Patches can be specified as files, directories (which will send all
 files in the directory), or directly as a revision list.  In the
 last case, any format accepted by linkgit:git-format-patch[1] can
-be passed to git send-email.
+be passed to git send-email, including additional command line
+options such as `--cover-letter` or `--notes`.

 The header of the email is configurable by command line options.  If not
 specified on the command line, the user will be prompted with a ReadLine
-- 
1.7.11.7
