From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH/POLL] git-format-patch: the default suffix is now .patch, not .txt
Date: Wed, 17 Jan 2007 16:06:28 -0800
Message-ID: <7vd55dp5a3.fsf_-_@assigned-by-dhcp.cox.net>
References: <625fc13d0701170510x8883539g93f43d9ddffe56f0@mail.gmail.com>
	<87ps9d7j6t.fsf@morpheus.local>
	<7vejptsglj.fsf@assigned-by-dhcp.cox.net>
	<625fc13d0701171218i31585558wf89374eae9485341@mail.gmail.com>
	<7vsle9p8pg.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Thu Jan 18 01:06:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H7KnY-00076W-R0
	for gcvg-git@gmane.org; Thu, 18 Jan 2007 01:06:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751867AbXARAGa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Jan 2007 19:06:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751861AbXARAGa
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Jan 2007 19:06:30 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:64230 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751867AbXARAGa (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Jan 2007 19:06:30 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070118000629.OJRM20715.fed1rmmtao10.cox.net@fed1rmimpo02.cox.net>;
          Wed, 17 Jan 2007 19:06:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id CQ6m1W0011kojtg0000000; Wed, 17 Jan 2007 19:06:46 -0500
To: "Josh Boyer" <jwboyer@gmail.com>
In-Reply-To: <7vsle9p8pg.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 17 Jan 2007 14:52:27 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37047>

Editors often give easier handling of patch files if the
filename ends with .patch, so use it instead of .txt.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

  Junio C Hamano <junkio@cox.net> writes:

  > "Josh Boyer" <jwboyer@gmail.com> writes:
  >
  >> On 1/17/07, Junio C Hamano <junkio@cox.net> wrote:
  >>
  >>> Two minor objections to changing the default are: (1) it's a
  >>> change and any change is bad ;-) and (2) the reason I changed it
  >>> to .txt before submitting the original format-patch to Linus was
  >>> because Emacs wanted to go into its "diff" mode when files are
  >>> named with .patch suffix, which had two annoyances (read-only by
  >>> default, and editing patch tried to automatically recount diff
  >>> and its recounting screwed up in some cases I do not remember
  >>> the details about).
  >>
  >> Well there's your problem.  You're using Emacs.  ;)
  >
  > Fair enough.  Its probably that there is something wrong in the
  > way I am using Emacs diff/patch editing mode.  Even if the
  > problem I had were because of bugs in Emacs, the users of git
  > should not have to suffer from "unusual" suffixes to work them
  > around.
  >
  > So that lifts one of the objections.  What should be done to the
  > other one --- time for a quick poll?

 Documentation/git-format-patch.txt                 |   15 +++++++--------
 .../howto/rebase-from-internal-branch.txt          |    2 +-
 builtin-log.c                                      |    2 +-
 3 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index c0ffe99..49f51bb 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -79,9 +79,9 @@ OPTIONS
 	provide a new patch series.
 
 --suffix=.<sfx>::
-	Instead of using `.txt` as the suffix for generated
+	Instead of using `.patch` as the suffix for generated
 	filenames, use specifed suffix.  A common alternative is
-	`--suffix=.patch`.
+	`--suffix=.txt`.
 +
 Note that you would need to include the leading dot `.` if you
 want a filename like `0001-description-of-my-change.patch`, and
@@ -91,15 +91,14 @@ not add any suffix.
 CONFIGURATION
 -------------
 You can specify extra mail header lines to be added to each
-message in the repository configuration as follows:
+message in the repository configuration.  Also you can specify
+the default suffix different from the built-in one:
 
+------------
 [format]
         headers = "Organization: git-foo\n"
-
-You can specify default suffix used:
-
-[format]
-        suffix = .patch
+        suffix = .txt
+------------
 
 
 EXAMPLES
diff --git a/Documentation/howto/rebase-from-internal-branch.txt b/Documentation/howto/rebase-from-internal-branch.txt
index fcd64e9..3b3a5c2 100644
--- a/Documentation/howto/rebase-from-internal-branch.txt
+++ b/Documentation/howto/rebase-from-internal-branch.txt
@@ -106,7 +106,7 @@ prepare #2 and #3 for e-mail submission.
 
     $ git format-patch master^^ master
 
-This creates two files, 0001-XXXX.txt and 0002-XXXX.txt.  Send
+This creates two files, 0001-XXXX.patch and 0002-XXXX.patch.  Send
 them out "To: " your project maintainer and "Cc: " your mailing
 list.  You could use contributed script git-send-email if
 your host has necessary perl modules for this, but your usual
diff --git a/builtin-log.c b/builtin-log.c
index 930cc04..f3cff13 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -197,7 +197,7 @@ static int istitlechar(char c)
 
 static char *extra_headers = NULL;
 static int extra_headers_size = 0;
-static const char *fmt_patch_suffix = ".txt";
+static const char *fmt_patch_suffix = ".patch";
 
 static int git_format_config(const char *var, const char *value)
 {
-- 
1.5.0.rc1.gde38
