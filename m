From: Marius Storm-Olsen <marius@trolltech.com>
Subject: [PATCH v5 5/5] Move mailmap documentation into separate file
Date: Sun,  8 Feb 2009 15:34:31 +0100
Message-ID: <f970142e47c9992abb2aafd40843a5f4be846e96.1234102794.git.marius@trolltech.com>
References: <cover.1234102794.git.marius@trolltech.com>
 <3db7411da93f5ae4de5247170d4b821e7b0ed88a.1234102794.git.marius@trolltech.com>
 <8b7c8612d6948421813b707ae4e265d950b4bf41.1234102794.git.marius@trolltech.com>
 <b94c3ab1a2afb95b4243dea381024a432a2d9cc5.1234102794.git.marius@trolltech.com>
 <6e190d2b99c8044b782cf5991821e82da80ea957.1234102794.git.marius@trolltech.com>
Cc: gitster@pobox.com, Marius Storm-Olsen <marius@trolltech.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 08 15:40:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWAnR-0005cm-Ci
	for gcvg-git-2@gmane.org; Sun, 08 Feb 2009 15:38:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752959AbZBHOgY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 8 Feb 2009 09:36:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752909AbZBHOgW
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Feb 2009 09:36:22 -0500
Received: from hoat.troll.no ([62.70.27.150]:37743 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751816AbZBHOgM (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Feb 2009 09:36:12 -0500
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id BE69821165;
	Sun,  8 Feb 2009 15:36:02 +0100 (CET)
Received: from localhost.localdomain (unknown [172.24.90.96])
	by hoat.troll.no (Postfix) with ESMTP id 9ADF8211A4;
	Sun,  8 Feb 2009 15:36:02 +0100 (CET)
X-Mailer: git-send-email 1.6.2.rc0.5.gf970
In-Reply-To: <6e190d2b99c8044b782cf5991821e82da80ea957.1234102794.git.marius@trolltech.com>
In-Reply-To: <cover.1234102794.git.marius@trolltech.com>
References: <cover.1234102794.git.marius@trolltech.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108981>

Include it directly from git-shortlog.txt, and refer
to it from pretty-format.txt.

Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---
 Documentation/git-blame.txt      |    6 +++
 Documentation/git-shortlog.txt   |   89 ++++----------------------------------
 Documentation/mailmap.txt        |   75 ++++++++++++++++++++++++++++++++
 Documentation/pretty-formats.txt |    8 ++--
 4 files changed, 94 insertions(+), 84 deletions(-)
 create mode 100644 Documentation/mailmap.txt

diff --git a/Documentation/git-blame.txt b/Documentation/git-blame.txt
index fba374d..6999cf2 100644
--- a/Documentation/git-blame.txt
+++ b/Documentation/git-blame.txt
@@ -184,6 +184,12 @@ there is ever added information (like the commit encoding or extended
 commit commentary), a blame viewer won't ever care.
 
 
+MAPPING AUTHORS
+---------------
+
+include::mailmap.txt[]
+
+
 SEE ALSO
 --------
 linkgit:git-annotate[1]
diff --git a/Documentation/git-shortlog.txt b/Documentation/git-shortlog.txt
index a0eaab5..42463a9 100644
--- a/Documentation/git-shortlog.txt
+++ b/Documentation/git-shortlog.txt
@@ -45,86 +45,15 @@ OPTIONS
 	and subsequent lines are indented by `indent2` spaces. `width`,
 	`indent1`, and `indent2` default to 76, 6 and 9 respectively.
 
-FILES
------
-
-If the file `.mailmap` exists at the toplevel of the repository, or at
-the location pointed to by the mailmap.file configuration option, it
-is used to map author and committer names and email addresses to
-canonical real names and email addresses.
-This mapping can be used to coalesce together commits by the same
-person where their name and/or email address was spelled differently.
-
-In the simple form, each line in the file consists of the canonical
-real name of an author, whitespace, and an email address used in the
-commit (enclosed by '<' and '>') to map to the name. Thus, looks like
-this
---
-	Proper Name <commit@email.xx>
---
-
-The more complex forms are
---
-	<proper@email.xx> <commit@email.xx>
---
-which allows mailmap to replace only the email part of a commit, and
---
-	Proper Name <proper@email.xx> <commit@email.xx>
---
-which allows mailmap to replace both the name and the email of a
-commit matching the specified commit email address, and
---
-	Proper Name <proper@email.xx> Commit Name <commit@email.xx>
---
-which allows mailmap to replace both the name and the email of a
-commit matching both the specified commit name and email address.
-
-Example 1: Your history contains commits by two authors, Jane
-and Joe, whose names appear in the repository under several forms:
-
-------------
-Joe Developer <joe@example.com>
-Joe R. Developer <joe@example.com>
-Jane Doe <jane@example.com>
-Jane Doe <jane@laptop.(none)>
-Jane D. <jane@desktop.(none)>
-------------
-
-Now suppose that Joe wants his middle name initial used, and Jane
-prefers her family name fully spelled out. A proper `.mailmap` file
-would look like:
-
-------------
-Jane Doe         <jane@desktop.(none)>
-Joe R. Developer <joe@example.com>
-------------
-
-Note how we don't need an entry for <jane@laptop.(none)>, because the
-real name of that author is correct already, and coalesced directly.
-
-Example 2: Your repository contains commits from the following
-authors:
-
-------------
-nick1 <bugs@company.xx>
-nick2 <bugs@company.xx>
-nick2 <nick2@company.xx>
-santa <me@company.xx>
-claus <me@company.xx>
-CTO <cto@coompany.xx>
-------------
-
-Then, you might want a `.mailmap` file looking like:
-------------
-<cto@company.xx>                       <cto@coompany.xx>
-Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
-Other Author <other@author.xx>   nick2 <bugs@company.xx>
-Other Author <other@author.xx>         <nick2@company.xx>
-Santa Claus <santa.claus@northpole.xx> <me@company.xx>
-------------
-
-Use hash '#' for comments that are either on their own line, or after
-the email address.
+
+MAPPING AUTHORS
+---------------
+
+The `.mailmap` feature is used to coalesce together commits by the same
+person in the shortlog, where their name and/or email address was
+spelled differently.
+
+include::mailmap.txt[]
 
 
 Author
diff --git a/Documentation/mailmap.txt b/Documentation/mailmap.txt
new file mode 100644
index 0000000..e25b154
--- /dev/null
+++ b/Documentation/mailmap.txt
@@ -0,0 +1,75 @@
+If the file `.mailmap` exists at the toplevel of the repository, or at
+the location pointed to by the mailmap.file configuration option, it
+is used to map author and committer names and email addresses to
+canonical real names and email addresses.
+
+In the simple form, each line in the file consists of the canonical
+real name of an author, whitespace, and an email address used in the
+commit (enclosed by '<' and '>') to map to the name. Thus, looks like
+this
+--
+	Proper Name <commit@email.xx>
+--
+
+The more complex forms are
+--
+	<proper@email.xx> <commit@email.xx>
+--
+which allows mailmap to replace only the email part of a commit, and
+--
+	Proper Name <proper@email.xx> <commit@email.xx>
+--
+which allows mailmap to replace both the name and the email of a
+commit matching the specified commit email address, and
+--
+	Proper Name <proper@email.xx> Commit Name <commit@email.xx>
+--
+which allows mailmap to replace both the name and the email of a
+commit matching both the specified commit name and email address.
+
+Example 1: Your history contains commits by two authors, Jane
+and Joe, whose names appear in the repository under several forms:
+
+------------
+Joe Developer <joe@example.com>
+Joe R. Developer <joe@example.com>
+Jane Doe <jane@example.com>
+Jane Doe <jane@laptop.(none)>
+Jane D. <jane@desktop.(none)>
+------------
+
+Now suppose that Joe wants his middle name initial used, and Jane
+prefers her family name fully spelled out. A proper `.mailmap` file
+would look like:
+
+------------
+Jane Doe         <jane@desktop.(none)>
+Joe R. Developer <joe@example.com>
+------------
+
+Note how we don't need an entry for <jane@laptop.(none)>, because the
+real name of that author is correct already.
+
+Example 2: Your repository contains commits from the following
+authors:
+
+------------
+nick1 <bugs@company.xx>
+nick2 <bugs@company.xx>
+nick2 <nick2@company.xx>
+santa <me@company.xx>
+claus <me@company.xx>
+CTO <cto@coompany.xx>
+------------
+
+Then, you might want a `.mailmap` file looking like:
+------------
+<cto@company.xx>                       <cto@coompany.xx>
+Some Dude <some@dude.xx>         nick1 <bugs@company.xx>
+Other Author <other@author.xx>   nick2 <bugs@company.xx>
+Other Author <other@author.xx>         <nick2@company.xx>
+Santa Claus <santa.claus@northpole.xx> <me@company.xx>
+------------
+
+Use hash '#' for comments that are either on their own line, or after
+the email address.
\ No newline at end of file
diff --git a/Documentation/pretty-formats.txt b/Documentation/pretty-formats.txt
index 28808b7..159390c 100644
--- a/Documentation/pretty-formats.txt
+++ b/Documentation/pretty-formats.txt
@@ -101,18 +101,18 @@ The placeholders are:
 - '%P': parent hashes
 - '%p': abbreviated parent hashes
 - '%an': author name
-- '%aN': author name (respecting .mailmap)
+- '%aN': author name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ae': author email
-- '%aE': author email (respecting .mailmap)
+- '%aE': author email (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ad': author date (format respects --date= option)
 - '%aD': author date, RFC2822 style
 - '%ar': author date, relative
 - '%at': author date, UNIX timestamp
 - '%ai': author date, ISO 8601 format
 - '%cn': committer name
-- '%cN': committer name (respecting .mailmap)
+- '%cN': committer name (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%ce': committer email
-- '%cE': committer email (respecting .mailmap)
+- '%cE': committer email (respecting .mailmap, see linkgit:git-shortlog[1] or linkgit:git-blame[1])
 - '%cd': committer date
 - '%cD': committer date, RFC2822 style
 - '%cr': committer date, relative
-- 
1.6.1.2.354.g9a90
