From: Ben Walton <bwalton@artsci.utoronto.ca>
Subject: [PATCH] Documentation: Grammar correction, wording fixes and cleanup
Date: Tue, 23 Aug 2011 20:32:35 -0400
Message-ID: <1314145955-23444-1-git-send-email-bwalton@artsci.utoronto.ca>
References: <7vliujre93.fsf@alter.siamese.dyndns.org>
Cc: drew.northup@maine.edu, git@vger.kernel.org,
	Ben Walton <bwalton@artsci.utoronto.ca>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 24 02:32:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qw1Oh-0000cf-LK
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 02:32:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755461Ab1HXAcl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Aug 2011 20:32:41 -0400
Received: from jerry.cquest.utoronto.ca ([192.82.128.5]:47024 "EHLO
	jerry.cquest.utoronto.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752730Ab1HXAcl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Aug 2011 20:32:41 -0400
Received: from pinkfloyd.chass.utoronto.ca ([128.100.160.254]:53781 ident=93)
	by jerry.cquest.utoronto.ca with esmtp (Exim 4.63)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qw1OZ-0000hI-Bd; Tue, 23 Aug 2011 20:32:39 -0400
Received: from bwalton by pinkfloyd.chass.utoronto.ca with local (Exim 4.72)
	(envelope-from <bwalton@cquest.utoronto.ca>)
	id 1Qw1OZ-00066c-Ao; Tue, 23 Aug 2011 20:32:39 -0400
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <7vliujre93.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179983>

Correct a few grammar issues in gitrepository-layout.txt and also
rewords a few sections for clarity.

Remove references to using http-fetch without -a to create a broken
repository.

Mark a few areas of the repository structure as legacy.

Signed-off-by: Ben Walton <bwalton@artsci.utoronto.ca>
---
 Documentation/gitrepository-layout.txt |   58 +++++++++++++++-----------------
 1 files changed, 27 insertions(+), 31 deletions(-)

diff --git a/Documentation/gitrepository-layout.txt b/Documentation/gitrepository-layout.txt
index eb3d040..5c891f1 100644
--- a/Documentation/gitrepository-layout.txt
+++ b/Documentation/gitrepository-layout.txt
@@ -23,32 +23,25 @@ objects::
 	Object store associated with this repository.  Usually
 	an object store is self sufficient (i.e. all the objects
 	that are referred to by an object found in it are also
-	found in it), but there are couple of ways to violate
-	it.
+	found in it), but there are a few ways to violate it.
 +
-. You could populate the repository by running a commit walker
-without `-a` option.  Depending on which options are given, you
-could have only commit objects without associated blobs and
-trees this way, for example.  A repository with this kind of
-incomplete object store is not suitable to be published to the
-outside world but sometimes useful for private repository.
-. You also could have an incomplete but locally usable repository
-by cloning shallowly.  See linkgit:git-clone[1].
-. You can be using `objects/info/alternates` mechanism, or
-`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanism to 'borrow'
+. You could have an incomplete but locally usable repository
+by creating a shallow clone.  See linkgit:git-clone[1].
+. You could be using the `objects/info/alternates` or
+`$GIT_ALTERNATE_OBJECT_DIRECTORIES` mechanisms to 'borrow'
 objects from other object stores.  A repository with this kind
 of incomplete object store is not suitable to be published for
 use with dumb transports but otherwise is OK as long as
-`objects/info/alternates` points at the right object stores
-it borrows from.
+`objects/info/alternates` points at the object stores it
+borrows from.
 
 objects/[0-9a-f][0-9a-f]::
-	Traditionally, each object is stored in its own file.
-	They are split into 256 subdirectories using the first
-	two letters from its object name to keep the number of
-	directory entries `objects` directory itself needs to
-	hold.  Objects found here are often called 'unpacked'
-	(or 'loose') objects.
+	A newly created object is stored in its own file.
+	The objects are splayed over 256 subdirectories using
+	the first two characters of the sha1 object name to
+	keep the number of directory entries in `objects`
+	itself to a manageable number. Objects found
+	here are often called 'unpacked' (or 'loose') objects.
 
 objects/pack::
 	Packs (files that store many object in compressed form,
@@ -85,7 +78,7 @@ objects/info/http-alternates::
 
 refs::
 	References are stored in subdirectories of this
-	directory.  The 'git prune' command knows to keep
+	directory.  The 'git prune' command knows to preserve
 	objects reachable from refs found in this directory and
 	its subdirectories.
 
@@ -119,16 +112,17 @@ HEAD::
 +
 HEAD can also record a specific commit directly, instead of
 being a symref to point at the current branch.  Such a state
-is often called 'detached HEAD', and almost all commands work
-identically as normal.  See linkgit:git-checkout[1] for
-details.
+is often called 'detached HEAD.'  See linkgit:git-checkout[1]
+for details.
 
 branches::
 	A slightly deprecated way to store shorthands to be used
-	to specify URL to 'git fetch', 'git pull' and 'git push'
-	commands is to store a file in `branches/<name>` and
-	give 'name' to these commands in place of 'repository'
-	argument.
+	to specify a URL to 'git fetch', 'git pull' and 'git push'.
+	A file can be stored as `branches/<name>` and then
+	'name' can be given to these commands in place of
+	'repository' argument.  See the REMOTES section in
+	linkgit:git-fetch[1] for details.  This mechanism is legacy
+	and not likely to be found in modern repositories.
 
 hooks::
 	Hooks are customization scripts used by various git
@@ -173,9 +167,11 @@ info/exclude::
 	at it.  See also: linkgit:gitignore[5].
 
 remotes::
-	Stores shorthands to be used to give URL and default
-	refnames to interact with remote repository to
-	'git fetch', 'git pull' and 'git push' commands.
+	Stores shorthands for URL and default refnames for use
+	when interacting with remote repositories via 'git fetch',
+	'git pull' and 'git push' commands.  See the REMOTES section
+	in linkgit:git-fetch[1] for details.  This mechanism is legacy
+	and not likely to be found in modern repositories.
 
 logs::
 	Records of changes made to refs are stored in this
-- 
1.7.4.1
