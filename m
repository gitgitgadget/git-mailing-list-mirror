From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Tutorial: Importing patches
Date: Tue, 28 Oct 2008 21:42:23 +0100
Message-ID: <20081028204223.9539.89315.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Oct 28 21:43:48 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KuvPk-0002si-Uu
	for gcvg-git-2@gmane.org; Tue, 28 Oct 2008 21:43:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752791AbYJ1Umb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 28 Oct 2008 16:42:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752687AbYJ1Umb
	(ORCPT <rfc822;git-outgoing>); Tue, 28 Oct 2008 16:42:31 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1534 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752558AbYJ1Umb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Oct 2008 16:42:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KuvOU-0005Bp-00; Tue, 28 Oct 2008 20:42:26 +0000
User-Agent: StGIT/0.14.3.236.g0c611
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/99321>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/tutorial.txt |   89 ++++++++++++++++++++++++++++++++++++=
++++++++
 1 files changed, 88 insertions(+), 1 deletions(-)


diff --git a/Documentation/tutorial.txt b/Documentation/tutorial.txt
index 2808462..283b358 100644
--- a/Documentation/tutorial.txt
+++ b/Documentation/tutorial.txt
@@ -621,7 +621,94 @@ get rid of such empty patches if you don't want th=
em hanging around:
 Importing patches
 -----------------
=20
-TODO:: import, ...
+While you are busy producing patches, there's hopefully someone -- the
+'maintainer' -- at the other end who recieves them and 'applies' them
+to her Git tree, which is then published for all (or parts of) the
+world to see.
+
+It's perfectly fine for this person to not have the foggiest idea what
+StGit is. In that case, she'll probably apply your patches with
+something like +git am+, and everything will just work, exactly as if
+you'd used Git to send those patches. But she might be an StGit user
+too, in which case she might use stglink:import[].
+
+There are basically four kinds if stuff you can import with
+stglink:import[]:
+
+  1. A patch in a file.
+
+  2. Several files containing one patch each, and a 'series' file
+     listing those other files in the correct order.
+
+  3. An e-mail containing a single patch.
+
+  4. A mailbox file (in standard Unix +mbox+ format) containing
+     multiple e-mails with one patch in each.
+
+
+Importing a plain patch
+~~~~~~~~~~~~~~~~~~~~~~~
+
+Importing a plain patch, such as produced by e.g. GNU +diff+, +git
+diff+, +git show+, stglink:diff[], or stglink:show[], is very easy.
+Just say
+
+  $ stg import my-patch
+
+and you'll have a new patch at the top of your stack.
+
+If you don't give a file name on the command line, stglink:import[]
+will read the patch from its standard input -- in other words, you can
+pipe a patch to it directly from the command that produces it.
+
+By default, the new patch's name will be taken from the file name, and
+its commit message and author info will be taken from the beginning of
+the patch, if they are there. However, there are command line switches
+to override all of these things; see the man page for details.
+
+
+Importing several patches at once
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Some programs -- among them stglink:export[] -- will create a bunch of
+files with one patch in each, and a 'series' file (often called
++series+) listing the other files in the correct order. Give
++$$--series$$+ and the name of the series file to stglink:import[],
+and it will import all the patches for you, in the correct order.
+
+
+Importing a patch from an e-mail
+~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
+
+Importing a patch from an e-mail is simple too:
+
+  $ stg import --mail my-mail
+
+The e-mail should be in standard Git mail format (which is what e.g.
+stglink:mail[] produces) -- that is, with the patch in-line in the
+mail, not attached. The authorship info is taken from the mail
+headers, and the commit message is read from the 'Subject:' line and
+the mail body.
+
+If you don't give a file name, the mail will be read from the standard
+input. This means that, if your mail reader supports it, you can pipe
+a mail directly to +stg import $$--mail$$+ and the patch will be
+applied.
+
+
+Importing a mailbox full of patches
+^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
+
+Finally, in case importing one patch at a time is too much work,
+stglink:import[] also accepts an entire Unix +mbox+-format mailbox,
+either on the command line or on its standard input; just use the
++$$--mbox$$+ flag. Each mail should contain one patch, and is imported
+just like with +$$--mail$$+.
+
+Mailboxes full of patches are produced by e.g. stglink:mail[] with the
++$$--mbox$$+ flag, but most mail readers can produce them too, meaning
+that you can copy all the patch mails you want to apply to a separate
+mailbox, and then import them all in one go.
=20
=20
 Other stuff that needs to be placed somewhere
