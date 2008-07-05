From: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
Subject: [PATCH v2] Documentation cvs: Clarify when a bare repository is needed
Date: Fri,  4 Jul 2008 22:43:41 -0600
Message-ID: <1215233021-19703-1-git-send-email-mmogilvi_git@miniinfo.net>
References: <1214023712-12361-1-git-send-email-mmogilvi_git@miniinfo.net>
Cc: gitster@pobox.com, Matthew Ogilvie <mmogilvi_git@miniinfo.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 06:53:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEzm9-0005ZN-SD
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 06:53:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751746AbYGEEtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 00:49:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751723AbYGEEtY
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 00:49:24 -0400
Received: from qmta02.westchester.pa.mail.comcast.net ([76.96.62.24]:57936
	"EHLO QMTA02.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751619AbYGEEtX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 00:49:23 -0400
X-Greylist: delayed 330 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Jul 2008 00:49:23 EDT
Received: from OMTA06.westchester.pa.mail.comcast.net ([76.96.62.51])
	by QMTA02.westchester.pa.mail.comcast.net with comcast
	id m3xX1Z00316LCl05202u00; Sat, 05 Jul 2008 04:43:52 +0000
Received: from mmogilvi.homeip.net ([75.70.160.185])
	by OMTA06.westchester.pa.mail.comcast.net with comcast
	id m4jp1Z00940J0Bv3S4jqod; Sat, 05 Jul 2008 04:43:51 +0000
X-Authority-Analysis: v=1.0 c=1 a=eg1ukNfqwBMA:10 a=aazN6ve7g5AA:10
 a=w-HtJ5sARNHSwOu689UA:9 a=uSIZrvzAtksNtFpmzoYA:7
 a=IEboluo8PeopTP7VX_La_Xnwv9EA:4 a=3cjVDzgxsZYA:10 a=7fDRFdMZ_OEA:10
Received: from localhost.localdomain (bean [192.168.30.96])
	by mmogilvi.homeip.net (Postfix) with ESMTP id 56FB089114;
	Fri,  4 Jul 2008 22:43:46 -0600 (MDT)
X-Mailer: git-send-email 1.5.6.1.204.g699135
In-Reply-To: <1214023712-12361-1-git-send-email-mmogilvi_git@miniinfo.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87428>

New users sometimes import a project and then immediately
try to use the imported repository as a central shared repository.
This provides pointers about setting up a bare repository for that
in the parts of the documentation dealing with CVS migration.

Signed-off-by: Matthew Ogilvie <mmogilvi_git@miniinfo.net>
---

I sent an earlier version of this patch about two weeks ago, but never
got any feedback about it.  This version rewords a couple of things
and expands the commit message a little.  I'll probably abandon it
after this.

This was inspired because occasionally someone asks the mailing list
about the "Index already exists in git repo" error message
from git-cvsserver, and I noticed that two relevant and common
starting points in the documentation (git-cvsserver and
get-cvsimport) do not mention that a shared repository should be bare.

Maybe someone should write up something similar for things like
git-push, git-svn, various other import scripts, etc.  I don't really
know enough about any of them and how they interact with non-bare
repositories to write reliable documentation.

Mostly unrelated: While in gitcvs-migration, I also noticed that
it doesn't mention git-cvsexportcommit at all, but I'm
not sure if it should just have a link in the "SEE ALSO"
section, a sentence or two near where it talks about
incremental imports (since if you need incrementatl import, you
likely also need incremental export), or a whole new section.
Since I've never used cvsexportcommit at all, I'm not real
confident on what to say about how to use it with incremental import.

          - Matthew Ogilvie

 Documentation/git-cvsimport.txt    |    6 ++++++
 Documentation/git-cvsserver.txt    |    3 +++
 Documentation/gitcvs-migration.txt |    5 +++++
 3 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/Documentation/git-cvsimport.txt b/Documentation/git-cvsimport.txt
index ed79bb8..aec1bca 100644
--- a/Documentation/git-cvsimport.txt
+++ b/Documentation/git-cvsimport.txt
@@ -31,6 +31,12 @@ to work with; after that, you need to `git-merge` incremental imports, or
 any CVS branches, yourself.  It is advisable to specify a named remote via
 -r to separate and protect the incoming branches.
 
+If you intend to set up a shared public repository that all developers can
+read/write, or if you want to use linkgit:git-cvsserver[1], then you
+probably want to make a bare clone of the imported repository,
+and use the clone as the shared repository.
+See linkgit:gitcvs-migration[7].
+
 
 OPTIONS
 -------
diff --git a/Documentation/git-cvsserver.txt b/Documentation/git-cvsserver.txt
index e0e35db..71433d7 100644
--- a/Documentation/git-cvsserver.txt
+++ b/Documentation/git-cvsserver.txt
@@ -133,6 +133,9 @@ write access to the log file and to the database (see
 <<dbbackend,Database Backend>>. If you want to offer write access over
 SSH, the users of course also need write access to the git repository itself.
 
+You also need to ensure that each repository is "bare" (without a git index
+file) for `cvs commit` to work. See linkgit:gitcvs-migration[7].
+
 [[configaccessmethod]]
 All configuration variables can also be overridden for a specific method of
 access. Valid method names are "ext" (for SSH access) and "pserver". The
diff --git a/Documentation/gitcvs-migration.txt b/Documentation/gitcvs-migration.txt
index 4dc7ec5..af453f2 100644
--- a/Documentation/gitcvs-migration.txt
+++ b/Documentation/gitcvs-migration.txt
@@ -143,6 +143,11 @@ work, you must not modify the imported branches; instead, create new
 branches for your own changes, and merge in the imported branches as
 necessary.
 
+If you want a shared repository, you will need to make a bare clone
+of the imported directory, as described above. Then treat the imported
+directory as another development clone for purposes of merging
+incremental imports.
+
 Advanced Shared Repository Management
 -------------------------------------
 
-- 
1.5.6.1.204.g699135
