From: David Howells <dhowells@redhat.com>
Subject: [PATCH] Simplified GIT usage guide
Date: Fri, 12 Dec 2008 18:28:27 +0000
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
Message-ID: <20081212182827.28408.40963.stgit@warthog.procyon.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: dhowells@redhat.com, git@vger.kernel.org,
	linux-kernel@vger.kernel.org
To: torvalds@osdl.org
X-From: git-owner@vger.kernel.org Fri Dec 12 19:30:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LBCmU-0003ko-VJ
	for gcvg-git-2@gmane.org; Fri, 12 Dec 2008 19:30:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758604AbYLLS3M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Dec 2008 13:29:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758385AbYLLS3M
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Dec 2008 13:29:12 -0500
Received: from mx2.redhat.com ([66.187.237.31]:60368 "EHLO mx2.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758038AbYLLS3H (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Dec 2008 13:29:07 -0500
Received: from int-mx2.corp.redhat.com (int-mx2.corp.redhat.com [172.16.27.26])
	by mx2.redhat.com (8.13.8/8.13.8) with ESMTP id mBCISV8p007211;
	Fri, 12 Dec 2008 13:28:31 -0500
Received: from ns3.rdu.redhat.com (ns3.rdu.redhat.com [10.11.255.199])
	by int-mx2.corp.redhat.com (8.13.1/8.13.1) with ESMTP id mBCISUXN017277;
	Fri, 12 Dec 2008 13:28:30 -0500
Received: from warthog.cambridge.redhat.com (kibblesnbits.boston.devel.redhat.com [10.16.60.12])
	by ns3.rdu.redhat.com (8.13.8/8.13.8) with ESMTP id mBCISRsd014143;
	Fri, 12 Dec 2008 13:28:28 -0500
Received: from [127.0.0.1] (helo=warthog.procyon.org.uk)
	by warthog.cambridge.redhat.com with esmtp (Exim 4.68 #1 (Red Hat Linux))
	id 1LBCkV-0007Og-I5; Fri, 12 Dec 2008 18:28:27 +0000
User-Agent: StGIT/0.14.3
X-Scanned-By: MIMEDefang 2.58 on 172.16.27.26
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102923>

Add a guide to using GIT's simpler features.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 Documentation/git-haters-guide.txt | 1283 ++++++++++++++++++++++++++++++++++++
 1 files changed, 1283 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-haters-guide.txt


diff --git a/Documentation/git-haters-guide.txt b/Documentation/git-haters-guide.txt
new file mode 100644
index 0000000..51e4dac
--- /dev/null
+++ b/Documentation/git-haters-guide.txt
@@ -0,0 +1,1283 @@
+		      ===================================
+		      THE GIT HATER'S GUIDE TO THE GALAXY
+		      ===================================
+
+By David Howells <dhowells@redhat.com>
+
+Contents:
+
+ (*) Introduction.
+
+     - Disclaimer.
+
+ (*) Overview of GIT.
+
+     - Git objects.
+     - Symbolic pointers.
+     - The GIT tree.
+     - GIT trees after merging.
+
+ (*) Downloading upstream trees.
+
+     - Local mirroring.
+     - Automatic updates.
+     - Using your local mirror.
+
+ (*) Accessing the repository.
+
+     - Viewing the history.
+     - Viewing a commit.
+     - Viewing source differences.
+
+ (*) Making changes.
+
+     - Applying patches.
+     - Applying formatted patches.
+     - Incorporating GIT trees.
+
+ (*) Amending and reverting changes.
+
+     - Amending committed changes.
+     - Discarding committed changes.
+     - Reverting committed changes.
+
+ (*) Publishing changes by GIT tree.
+
+     - Setting up.
+     - Updating your development tree.
+     - Publishing your changes.
+
+ (*) Manually merging failed fetches.
+
+ (*) Locating bugs.
+
+     - Bisection.
+     - Blame.
+
+
+============
+INTRODUCTION
+============
+
+So, you want to do some Linux kernel development?  And you hear there's this
+piece of software called 'GIT' that you probably ought to be using when dealing
+with the kernel community?  Then you find out that not only was Linux started
+by this Linus Torvalds person, but GIT was too!  Perhaps it doesn't seem fair:
+Linus has not just _one_ huge piece of software named after himself, but _two_!
+And on top of that, globe spanning hardware vendors just queue up to give him
+all the herring he can eat!!
+
+Then you look at webpages about GIT.  You look at the manpages!  You run the
+commands with --help!  And you *still* don't know how to do anything complex
+with it!!  You feel certain that there's some secret rite you have to perform
+to become a GIT initiate - probably something involving two goats, an altar and
+a full moon - oh, and lots of beer (we *are* talking about kernel developers
+after all).
+
+Then you ask around, and people look at you blankly, hedge or say that it's
+easy and obvious (they should know - they wrote the damned thing).  You realise
+that the manpages are more an aide-memoire and that what you really want is
+some sort of crib sheet; something that can hold your hand whilst you cut and
+paste things from of it until you can see the point.
+
+Well, let's see if I can help...
+
+
+DISCLAIMER
+----------
+
+I don't really know what I'm doing with GIT either.  I'm not sure anyone really
+does, apart from Linus (and then only after some strange Finnish snack
+involving red and white mushrooms).  If you'd pause to wonder why things are
+like they are, you'd realise that only someone totally barking would try to
+write a kernel in the first place... and then it'd dawn on you what the mental
+state must be like of someone who'd try writing something like a source code
+management system from scratch...  and then you'd consider what it must take to
+be someone who'd do *both*.
+
+
+===============
+OVERVIEW OF GIT
+===============
+
+GIT is a source code management system.  You give it your sources to retain,
+and it manages the history of all the changes and provides you with a set of
+tools by which that history can be viewed, extracted and extended.
+
+GIT is unusual in its design in that the objects it retains are referred to by
+hashes of their content.  Because it is mathematically possible for object IDs
+to collide, large hash IDs are used to reduce the probability of a collision.
+If the content of an object changes, rather than updating the existing object,
+GIT will create a new object with a new hash ID.  Objects are _invariant_.
+
+The GIT database in a GIT tree has two sets of data:
+
+ (1) A set of objects, indexed by the object hash ID.
+
+ (2) A set of symbolic object tree heads, as object hash IDs.
+
+
+GIT OBJECTS
+-----------
+
+There are three basic types of object:
+
+ (1) File objects.
+
+     A file object contains the contents of a source file and the attributes of
+     that file (such as file mode).
+
+ (2) Directory objects.
+
+     A directory object contains the attributes of that directory plus a list
+     of file and directory objects that are members of this directory.  The
+     list includes the names of the entries within that directory and the
+     object ID of each object.
+
+ (3) Commit objects.
+
+     A commit object contains the attribute of that commit (the author and the
+     date for instance), a textual description of the change imposed by that
+     commit as provided by the committer, a list of object IDs for the commits
+     on which this commit is based, and the object ID of the root directory
+     object representing the result of this commit.
+
+     Note that a commit does not literally describe the changes that have been
+     made in the way that, say, a diff file does; it merely carries the current
+     state of the sources after that change, and points to the commits that
+     describe the state of the sources before that change.  GIT's tools then
+     infer the changes when asked.
+
+     A commit object will typically refer to one base commit when someone has
+     merely committed some changes on top of the current state, and two base
+     commits when a couple of trees have been merged.
+
+Because objects are invariant, and because they can thus be referred to by a
+hash of their contents, objects can be shared between trees simply by using the
+same object ID in two different places.  This allows objects to be compared to
+see whether they are the same thing or not simply by comparing the object ID.
+
+
+SYMBOLIC POINTERS
+-----------------
+
+GIT retains its historical information in a set of overlapping, shared trees,
+but the notion of where a tree starts isn't really a primary concept with GIT.
+What it has instead is a number of symbolic pointers to commits within the tree
+that are considered to be of some sort of significance.  These are called
+'heads' and include:
+
+ (1) The base for the current working state of the checked out sources (HEAD).
+
+ (2) Branches (by branch name).
+
+ (3) Tags (by tag name).
+
+ (4) Merge base (for incomplete merges).
+
+ (5) Points of interest, such as those that pertain to a git fetch (FETCH_HEAD
+     and ORIG_HEAD).
+
+ (6) Bisection points (when bisection is being used to find a bug).
+
+In essence, these symbolic pointers are just names or conventions for
+particular roots in the tree.  They are a name that maps to the object ID of a
+commit object.
+
+Some of them have special meanings, such as branches, that can be configured to
+behave in various ways under certain conditions (such as when a git fetch is
+performed).
+
+
+THE GIT TREE
+------------
+
+The GIT tree in its simplest terms is a backbone of commits that point to
+directories that point to files.  To give a simple example of the commit
+process, consider the sources for a project that contains one directory, D,
+which contains three files, F1, F2 and F3.
+
+This could then be committed into GIT to begin a project, in this case as
+commit C0.  This would hold version D0 of the directory, and versions F1A, F2A
+and F3A of the three files, and the GIT repository HEAD pointer would point to
+C0:
+
+	                                        +-----+
+	                                    +-->| F3A |
+	                                    |   +-----+
+	                                    |
+	        +-----+        +-----+      |   +-----+
+	HEAD--->| C0  |------->| D0  |------+-->| F2A |
+	        +-----+        +-----+      |   +-----+
+	                                    |
+	                                    |   +-----+
+	                                    +-->| F1A |
+	                                        +-----+
+
+Now imagine that someone changes file F2 and commits the change.  F1A and F3A
+are still useful, and can be shared by the new view of the world, but F2 is now
+on a new version, F2B.  The old directory object, D0, pointed to F2A, so that
+cannot be reused, and so D1 is generated.  The commit process then writes a new
+commit object, C1, that points to D1 as the state of the tree after this
+commit, and points to C0 as the commit on which C1 was based.  Finally, HEAD is
+changed to point to C1.
+
+	                                        +-----+
+	                                  +---->| F2B |
+	        +-----+        +-----+    |     +-----+
+	HEAD--->| C1  |------->| D1  |----+
+	        +-----+        +-----+    |
+	           |                      |
+	           |                      |     +-----+
+	           |                      +---->| F3A |
+	           |                      | +-->+-----+
+	           V                      | |
+	        +-----+        +-----+    | |   +-----+
+	        | C0  |------->| D0  |------+-->| F2A |
+	        +-----+        +-----+    | |   +-----+
+	                                  | |
+	                                  +-|-->+-----+
+	                                    +-->| F1A |
+	                                        +-----+
+
+Then imagine that someone changes file F1 and commits the change.  F3A is still
+viable in its original state, and F2B is usable from commit C1, but F1A is now
+obsolete and gets replaced by version F1B.  This means that neither D0 nor D1
+are usable, so directory object D2 has to be created, and new commit C2 is
+created to point to that and base commit C1.  Then HEAD is set to point to C2:
+
+	                                        +-----+
+	                                +------>| F1B |
+	        +-----+        +-----+  |       +-----+
+	HEAD--->| C2  |------->| D2  |--+
+	        +-----+        +-----+  |
+	           |                    |
+	           |                    +------>+-----+
+	           V                    | +---->| F2B |
+	        +-----+        +-----+  | |     +-----+
+	        | C1  |------->| D1  |----+
+	        +-----+        +-----+  | |
+	           |                    | |
+	           |                    +-|---->+-----+
+	           |                      +---->| F3A |
+	           |                      | +-->+-----+
+	           V                      | |
+	        +-----+        +-----+    | |   +-----+
+	        | C0  |------->| D0  |------+-->| F2A |
+	        +-----+        +-----+    | |   +-----+
+	                                  | |
+	                                  +-|-->+-----+
+	                                    +-->| F1A |
+	                                        +-----+
+
+Now, consider what would have happened if, instead of changing F1A to be F1B to
+produce C2, F2B had been reverted to the same state as F2A.  GIT would realise
+that it already has a file object to represent F2A (by comparing object IDs)
+and would use that rather than creating a new one.  The new set of files in the
+directory would then be F1A, F2A and F3A - but there's already a directory
+object for that: D0.  This would also be discovered by object ID matching, and
+would be used instead.  Commit C3 would then point to base commit C1 and
+directory D0, and HEAD would be moved to point to C3:
+
+	        +-----+
+	HEAD--->| C3  |---+
+	        +-----+   |
+	           |      |
+	           |      |                     +-----+
+	           V      |               +---->| F2B |
+	        +-----+   |    +-----+    |     +-----+
+	        | C1  |------->| D1  |----+
+	        +-----+   |    +-----+    |
+	           |      |               |
+	           |      |               |     +-----+
+	           |      |               +---->| F3A |
+	           |      |               | +-->+-----+
+	           V      |               | |
+	        +-----+   +--->+-----+    | |   +-----+
+	        | C0  |------->| D0  |------+-->| F2A |
+	        +-----+        +-----+    | |   +-----+
+	                                  | |
+	                                  +-|-->+-----+
+	                                    +-->| F1A |
+	                                        +-----+
+
+
+GIT TREES AFTER MERGING
+-----------------------
+
+Now, imagine that two GIT trees are merged.  You start off with two sets of
+commits (for convenience, I'm going to leave out the directories and files, but
+you can just assume they're there):
+
+	        +-----+                         +-----+
+	HEAD--->| C3  |                 Branch->| B3  |
+	        +-----+                         +-----+
+	           |                               |
+	           V                               V
+	        +-----+                         +-----+
+	        | C2  |                         | B2  |
+	        +-----+                         +-----+
+	           |                               |
+	           V                               V
+	        +-----+                         +-----+
+	        | C1  |<------------------------| B1  |
+	        +-----+                         +-----+
+	           |
+	           V
+	        +-----+
+	        | C0  |
+	        +-----+
+
+In the above example, I've assumed that you've got your own tree with the head
+at commit C3, and that you've got a branch that you want to merge, which has
+its head at commit B3.  After merging them, you'd end up with a directed,
+cyclic tree:
+
+	        +-----+
+	HEAD--->| C4  |----------------------------+
+	        +-----+                            |
+	           |                               |
+	           V                               V
+	        +-----+                         +-----+
+	        | C3  |                 Branch->| B3  |
+	        +-----+                         +-----+
+	           |                               |
+	           V                               V
+	        +-----+                         +-----+
+	        | C2  |                         | B2  |
+	        +-----+                         +-----+
+	           |                               |
+	           V                               V
+	        +-----+                         +-----+
+	        | C1  |<------------------------| B1  |
+	        +-----+                         +-----+
+	           |
+	           V
+	        +-----+
+	        | C0  |
+	        +-----+
+
+and the C4 commit will have pointers to *both* contributing commits, C3 and B3.
+If GIT stored the differences at each commit rather than the terminal state, it
+would have to store a delta for each contributing commit.
+
+
+==========================
+DOWNLOADING UPSTREAM TREES
+==========================
+
+The first thing you'll usually want to do with GIT is to grab a copy of the
+cutting edge version of an upstream project and build it; perhaps you want to
+work on it, perhaps because it has a fix in it that you need or perhaps because
+you like living on the cutting edge and enjoy grepping your disks to recover
+your data when things go wrong.  Whatever your reasons, you need to be able
+make a local copy of an upstream GIT tree.
+
+With GIT-based projects, grabbing a local copy of an upstream repository is
+very easy:
+
+	git clone %UPSTREAM_REPO %MY_DIR
+
+This will create a checked-out copy of the the upstream repository
+(%UPSTREAM_REPO) by pulling over the internet and sticking it in a directory on
+the local machine.
+
+For example, to fetch Linus's cutting edge kernel tree, you'd do:
+
+	git clone git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
+		linux-2.6-local
+
+Then you look in linux-2.6-local and there is what you're looking for.
+
+
+LOCAL MIRRORING
+---------------
+
+You might find that you wish to run several concurrent, separate developments
+all based upon a single upstream repository.  You could simply clone each one
+as mentioned above, but that has the potential to use excessive amounts of disk
+space as each clone would include an independent copy of the entire source
+repository.
+
+What you might want to do is to set up a mirror of the upstream repository, and
+then share that mirror with each of the clones.  Even better, you can share it
+with other people who can also access the filesystem it is stored upon.
+
+So what you can do is create a local mirror:
+
+	git clone -n %UPSTREAM_REPO %MIRROR_DIR
+
+For example:
+
+	git clone -n git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git \
+		/warthog/git/linux-2.6.git
+
+The -n flag tells git to save space by not bothering to check the files out of
+the repository.  You don't really need the checkout if all you're going is to
+use this as a reference, but you can still check out if you like by omitting
+the -n.
+
+
+AUTOMATIC UPDATES
+-----------------
+
+Furthermore, you might want to automatically update your sources at some
+unfeasible hour of the morning when only Australians are awake because, say,
+your internet supply is rated more cheaply then - but you don't necessarily
+want the automatic update to dump into the sources you're actively meddling
+with.  A local mirror can help with this too.
+
+One way of automatically updating your mirror is to use cron.  To do this
+create a script that looks something like:
+
+	#!/bin/sh
+	cd %MIRROR_DIR || exit $?
+	exec git pull >/tmp/git-pull.log
+
+and chmod u+x it.  Then run the crontab program to modify your personal cron
+schedule and add something like the following line to it (not forgetting to
+remove the leading tab!):
+
+	0 %HOUR * * *       %MIRROR_SCRIPT
+
+where %HOUR is the hour you want it to go off every day.  For my local mirror
+of Linus's upstream kernel, I use:
+
+	#!/bin/sh
+	cd /warthog/git/linux-2.6 || exit $?
+	exec git pull >/tmp/git-pull.log
+
+and:
+
+	0 6 * * *       /home/dhowells/bin/do-git-pull.sh
+
+which will do the update every day at 6am.
+
+
+USING YOUR LOCAL MIRROR
+-----------------------
+
+You can then create a directory to actually do your development in by:
+
+	git clone -l -s %MIRROR_DIR %MY_DIR
+
+The "-l" tells git clone that the source (mirror) repository is on the local
+machine, that it shouldn't go over the internet for it, and that it should
+hardlink GIT objects from the source repository rather than copying them where
+possible.
+
+The "-s" says that git clone should insert a reference under %MY_DIR that
+points to the %MIRROR_DIR's collection of objects.  This means that GIT won't
+bother to copy the objects that it can get from %MIRROR_DIR at all, it'll just
+use them out of %MIRROR_DIR.
+
+    [!] NOTE: This makes %MY_DIR dependent on %MIRROR_DIR: if you delete
+    	%MIRROR_DIR or prune it you may make %MY_DIR unusable!
+
+You can repeat this again and again from the same mirror.  You can even share a
+mirror with other people that can access the filesystem holding the mirror.
+You don't need write access to it, only read.
+
+
+========================
+ACCESSING THE REPOSITORY
+========================
+
+One of the things you'll want to be able to do with what you've downloaded is
+look at changes other people have made.  GIT has some powerful tools to allow
+you to do this.
+
+
+VIEWING THE HISTORY
+-------------------
+
+You might wish, for example, to look back through the commit tree and see what
+changes have been made.  The command to do this is:
+
+	git log
+
+This will take you back through the commit information, starting at the current
+HEAD and going all the way back to the beginning if you let it:
+
+	warthog>git log
+	commit 8b1fae4e4200388b64dd88065639413cb3f1051c
+	Author: Linus Torvalds <torvalds@linux-foundation.org>
+	Date:   Wed Dec 10 15:11:51 2008 -0800
+
+	    Linux 2.6.28-rc8
+
+	commit f9fc05e7620b3ffc93eeeda6d02fc70436676152
+	Merge: b88ed20... 9a2bd24...
+	Author: Linus Torvalds <torvalds@linux-foundation.org>
+	Date:   Wed Dec 10 14:41:06 2008 -0800
+
+	    Merge branch 'sched-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip
+
+	    * 'sched-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/linux-2.6-tip:
+	      sched: CPU remove deadlock fix
+
+	commit b88ed20594db2c685555b68c52b693b75738b2f5
+	Author: Hugh Dickins <hugh@veritas.com>
+	Date:   Wed Dec 10 20:48:52 2008 +0000
+	...
+
+
+VIEWING A COMMIT
+----------------
+
+Now that you can see the commit IDs in the history, you can examine one more
+closely:
+
+	git show
+
+to see the current HEAD commit, or:
+
+	git show %COMMIT_ID
+
+to see a particular commit:
+
+	warthog>git show 1da177e
+	commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
+	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
+	Date:   Sat Apr 16 15:20:36 2005 -0700
+
+	    Linux-2.6.12-rc2
+
+	    Initial git repository build. I'm not bothering with the full history,
+	...
+	diff --git a/COPYING b/COPYING
+	new file mode 100644
+	index 0000000..2a7e338
+	--- /dev/null
+	+++ b/COPYING
+	@@ -0,0 +1,356 @@
+	+
+	+   NOTE! This copyright does *not* cover user programs that use kernel
+	...
+
+
+VIEWING SOURCE DIFFERENCES
+--------------------------
+
+The 'git-show' command shows you what it thinks the differences are that you
+want to see, between a commit and its first listed base commit.  However, there
+are other differences you might wish to see.
+
+Firstly, you might like to see the differences between what's in the current
+HEAD commit, and what you've got checked out:
+
+	git diff
+
+or you might wish to see the differences between two particular commits, for
+example:
+
+	git diff v2.6.24 v2.6.25
+
+
+==============
+MAKING CHANGES
+==============
+
+So you've got a fresh development GIT tree and you want to make changes in it
+and commit them to it.  The first is easy enough: just use your preferred text
+editor to edit the files directly, or you could use sed or perl to apply some
+textual transformations - that's entirely up to you.
+
+However, once you've made those changes and you've compiled and tested them,
+you'll probably want to consign them to GIT.
+
+Files you've added must be marked by:
+
+	git add <filename>
+
+and files you've deleted must be noted by:
+
+	git rm <filename>
+
+so that GIT knows to include or exclude these files from its tree.
+Furthermore, you must tell GIT about any files that have changed that you want
+to be updated also:
+
+	git add <filename>
+
+You can then commit your changes.  This is done by running:
+
+	git commit
+
+Rather than doing lots of git add and git rm commands to register updated and
+removed files, you can give git commit a '-a' flag.  Note, though, that this
+takes no account of new files that git doesn't already know about.  Those must
+be added manually.
+
+git commit will pop up your favourite editor, asking you to enter a commit
+message describing your changes (don't forget to add your sign-off).  It will
+list the files it sees that have been added, altered and removed, and will
+differentiate between those that it has been told about (and thus will include)
+and those it hasn't (which will be ignored).
+
+After git commit completes successfully, 'git show' should show the new commit
+you've just made, and gitk should show the new tree structure with your new
+commit at the top.
+
+
+APPLYING PATCHES
+----------------
+
+If you have a patch file you wish to apply, you can do that with:
+
+	git apply <patch-file>
+
+This will make the changes specified by the patch, but it won't register any of
+the changes and won't record any of the metadata that might be in the patch
+file, such as authorship, description or attribution.  That has to be done
+manually as if you'd made the changes yourself.
+
+
+APPLYING FORMATTED PATCHES
+--------------------------
+
+Sometimes you may wish to incorporate a patch that someone has emailed you.
+You could use the 'patch' or 'git apply' programs and then set up the commit
+information manually, but if someone has sent you an appropriately formatted
+message - perhaps in an email - you can have GIT import the metadata from the
+message rather than you having to type it manually.
+
+If someone has given you an email or appropriately formatted patch file, the
+following command can import it:
+
+	git am <patch-file>
+
+If successful, this will automatically register all added, altered and removed
+files and commit the changes for you.  The commit message will be concocted
+from the description and email headers (From: and Subject: for instance).  If
+you want to add your own sign-off to the bottom of the commit message whilst
+you're at it, you can add a '-s' flag:
+
+	git am -s <patch-file>
+
+You may find it convenient to edit unformatted patches to make it possible to
+use 'git am' rather than 'git apply'.
+
+
+INCORPORATING GIT TREES
+-----------------------
+
+And sometimes, rather then sending you patches, people may attempt to
+contribute changes to you that are contained within GIT trees and you may wish
+to incorporate these into your development tree.
+
+To do this, the following command will work:
+
+	git pull %CONTRIB_REPO %CONTRIB_BRANCH
+
+where %CONTRIB_REPO is the URL of a repository and %CONTRIB_BRANCH is the name
+of the branch within that repository (usually this will be 'master').
+
+If successful, this will either just stack the pulled changes directly on top
+of your tree (assuming the contributed tree is based on the head of your tree)
+or it will automatically produce a merge commit indicating that the resulting
+tree is a union of the changes in your tree and the contributed tree.
+
+If unsuccessful due to conflicting changes, you'll need to perform the merge
+manually and perform the commit yourself.  See the "Manually merging failed
+fetches" section.
+
+An example of the command line you might use is:
+
+	git pull git://git.infradead.org/mtd-2.6.git master
+
+which will pull master branch of the upstream MTD tree into the GIT tree you're
+currently in.
+
+
+==============================
+AMENDING AND REVERTING CHANGES
+==============================
+
+There will be times when you make a mistake in your changes, and you find that
+you either want to amend them, or you want to discard them entirely.  GIT
+provides a number of tools to do this.
+
+If you make a mistake in changes you haven't yet committed, you can just edit
+them again with your text editor, or if you'd prefer to discard all the changes
+you made to a particular file, you can do:
+
+	git checkout <filename>
+
+This will just wipe away the changes that you've made and restore the file to
+the state it has recorded for it as part of the topmost commit.
+
+
+AMENDING COMMITTED CHANGES
+--------------------------
+
+If you've committed some changes and you realise that those changes are
+incorrect, you can amend them without precisely making a whole new commit -
+provided you haven't committed anything else on top of them.
+
+To do this, you make your changes, run git add and git rm as normal, and then
+do:
+
+	git commit --amend
+
+This will replace the topmost commit with a similar commit that includes the
+amendments.  The old commit will be displaced from the tree and will not appear
+again.
+
+Changes that are buried beneath further commits unfortunately have to be
+altered by making a new commit with the amendments, unless you wish to discard
+all the commits down to the one that needs amending, and then apply them all
+again.
+
+
+DISCARDING COMMITTED CHANGES
+----------------------------
+
+Upon occasion, you'll want to discard one or more commits entirely from the top
+of your tree.  To do this you need to find the ID of the latest commit that you
+want to keep.  Everything from the commit after that to the current commit will
+be discarded.
+
+You can find the commit ID in a number of ways.  Firstly, you can use 'git log'
+to look back through the commits.  The commit ID is shown as something like:
+
+	commit 6c34bc2976b30dc8b56392c020e25bae1f363cab
+
+Secondly, you can use gitk: select the commit of interest; the commit ID
+appears in the box labelled "SHA1 ID".
+
+You can then perform the discard with the following command:
+
+	git reset --hard %COMMIT_ID
+
+Using the above commit ID as an example, you could do:
+
+	git reset --hard 6c34bc2976b30dc8b56392c020e25bae1f363cab
+
+
+REVERTING COMMITTED CHANGES
+---------------------------
+
+And sometimes you'll want to revert changes that you've committed, but that are
+now buried beneath other commits.  Short of discarding and reapplying commits,
+you have to apply a reverse patch:
+
+	git diff %COMMIT_ID | patch -p1 -R
+
+and then commit it.  Both the original application and the reversion will be
+retained by GIT.
+
+
+==============================
+PUBLISHING CHANGES BY GIT TREE
+==============================
+
+Now that you've got a tree and have mangled it in unspeakable ways, you
+probably want to donate the glory of your works back to the community - usually
+with an eye to getting your changes pulled into an upstream maintainer's
+repository.  Your upstream maintainer may then push your changes on to their
+upstream maintainer, until it ends into the ultimate upstream repository
+(Linus's linux-2.6 tree in the case of the Linux kernel).
+
+You could, of course, just push patches to the upstream maintainer, be that
+Linus or one of his cronies in the case of the Linux kernel, or some other
+person if some other project.
+
+GIT, however, leans strongly towards another option.  If you can get access to
+a computer that is accessible by way of the internet, you might be able to set
+up a public GIT tree upon it and ask an appropriate upstream maintainer to pull
+from that.
+
+That computer, however, may not be particularly convenient for developing on:
+it may be remote from where you're working, for example, perhaps even on a
+different continent - so you'll probably want to have two trees: a remote,
+public, published tree, and a local private tree where you can break stuff at
+will.  I'm going to assume the two trees approach.
+
+
+SETTING UP
+----------
+
+First of all, you'll need to set up your two trees.  There are a number of
+steps to go through to do this:
+
+ (1) Find somewhere that's accessible by the internet (%REMOTE_BOX) that you
+     have SSH access to, and set up a public GIT tree that's a clone of the
+     upstream tree you want to use as a base:
+
+	ssh %REMOTE_BOX
+	cd /my/git/trees
+	git clone -n --bare %UPSTREAM_REPO %MY_DIR
+
+     Where %UPSTREAM_REPO is something like:
+
+	git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+
+     This will create a directory called /my/git/trees/%MY_DIR that contains a
+     bare GIT repository to which you can upload your changes.  There will be
+     no checked out files here, and everything that would usually be in the
+     .git directory is in the top directory instead.
+
+     If your tree is on the same box as the tree you want to fork, you can
+     tell GIT to use that rather than going to the internet:
+
+	git clone -l -s -n --bare %UPSTREAM_DIR %MY_DIR
+
+     For example, I might wish to set up a tree to publish NOMMU changes so
+     that they're available through git.kernel.org.  To that end, I would do:
+
+	ssh master.kernel.org
+	cd /pub/scm/linux/kernel/git/dhowells
+	git clone -l -n -s --bare \
+		/pub/scm/linux/kernel/git/torvalds/linux-2.6.git linux-2.6-nommu
+
+
+ (2) You should set the description on your public repository:
+
+	echo %DESCRIPTION >%MY_DIR/description
+
+     For example:
+
+	echo "NOMMU development" >linux-2.6-nommu/description
+
+     This will be published through the GIT web interface if one is set up, and
+     so can be viewed by going to the appropriate URL.  For instance:
+
+	http://git.kernel.org/?p=linux/kernel/git/dhowells/linux-2.6-nommu.git
+
+
+ (3) Now go to the work machine on which you'll be doing your development.
+     You'll need to create a local fork of your public GIT repository.  You can
+     do this by:
+
+	git clone ssh://%REMOTE_BOX/my/git/trees/%MY_DIR %DEVEL_DIR
+
+     This will create a checked-out GIT tree in a directory (%DEVEL_DIR) that
+     you can later use for development.  If you have a local mirror of the
+     upstream tree that you're using as a base, you can tell git to use the
+     objects from that to save space:
+
+	git clone --reference %LOCAL_UPSTREAM_MIRROR \
+		ssh://%REMOTE_BOX/my/git/trees/%MY_DIR \
+		%DEVEL_DIR
+
+     [!] NOTE: You must use ssh: and not git: to clone your tree because you
+     	       need to be able to push back (write) to your public tree.
+
+     To continue my example, I have a local mirror of Linus's kernel, regularly
+     updated by cron, and so to make my local NOMMU development tree, I would
+     do:
+
+	git clone --reference /warthog/git/linux-2.6 \
+		ssh://master.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-2.6-nommu.git \
+		linux-2.6-nommu
+
+
+ (4) Now you need to set up your local GIT tree to make it possible (a) update
+     your development tree by pulling in the upstream tree, and (b) publish
+     your changes by pushing them to your public tree.
+
+	cd %DEVEL_DIR
+
+     Tell your repository where to find the upstream tree:
+
+	git remote add %UPSTREAM %UPSTREAM_REPO
+
+     where %UPSTREAM is the name you by which you want to refer to the upstream
+     repository to git pull.  For Linus's upstream kernel, you might wish to
+     use 'linus' for example.
+
+     In my example, I did the following to pull Linus's tree into branches of
+     my tree:
+
+	cd linux-2.6-nommu
+	git remote add linus \
+		git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+
+     Looking in .git/config, I now see section that looks like this:
+
+	[remote "origin"]
+		url = ssh://master.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-2.6-nommu.git
+		fetch = +refs/heads/*:refs/remotes/origin/*
+	[branch "master"]
+		remote = origin
+		merge = refs/heads/master
+	[remote "linus"]
+		url = git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git
+		fetch = +refs/heads/*:refs/remotes/linus/*
+
+
+ (5) You should now be able to update your development tree from the upstream
+     repository to make sure that works:
+
+	git fetch -v %UPSTREAM
+
+     In my case, that's:
+
+	git fetch -v linus
+
+     If you've just created the repository, it'll probably just say that things
+     are up to date:
+
+	From git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
+	 = [up to date]      master     -> linus/master
+
+     [!] NOTE: I cannot determine a way of making "git pull linus" work without
+     	 setting branch.master.remote to 'linus'.
+
+
+ (6) And then you should be able to publish your development tree by pushing it
+     to your public tree, thus allowing the rest of the world to see your
+     changes.
+
+	git push -v origin
+
+
+ (7) Finally you should be able to pull your published tree back into your
+     development tree, and it should just say that it's up to date:
+
+	git pull -v
+
+
+UPDATING YOUR DEVELOPMENT TREE
+------------------------------
+
+Okay: so you've got your tree, and you've made changes to it, and now Linus has
+gone and dumped five thousand patches into his tree, making the base for your
+changes obsolete.  You need to update your tree and fix up your changes.
+
+If you haven't yet committed your changes, you'll have to siphon them off into
+a file:
+
+	git diff >a.diff
+
+and deapply them:
+
+	patch -p1 -R <a.diff
+
+You can then update your tree from the upstream tree with no fear of a conflict
+(assuming you don't also have changes that you have committed).  Once you've
+updated your tree, you can reapply your changes:
+
+	patch -p1 <a.diff
+
+And then fix up the rejects with your favourite editor and a few choice curses.
+
+
+To actually update your tree, you can do the following:
+
+	git fetch %UPSTREAM
+
+In my example, that'd be:
+
+	git fetch linus
+
+If you have committed changes, this will attempt to merge them, but you may
+still need to fix them up.  If everything went smoothly this will automatically
+commit a merge on top of the tree and set the HEAD pointer to that.  This merge
+will point at your last tree and the tree you just merged from upstream, and
+will indicate that the resulting tree is a combination of both.  Of course, you
+shouldn't assume it will still compile, let alone still work...
+
+If you do need to fix them up, refer to the "Manually merging failed fetches"
+section for guidance.
+
+You can view the merge that git pull committed by:
+
+	git show
+
+And you can view the tree structure at that point with the gitk command.
+
+
+PUBLISHING YOUR CHANGES
+-----------------------
+
+Finally, you're in a position to make your changes available.  Firstly, you
+have to commit them to your development tree (as mentioned previously) and then
+you have to make them available to the rest of the world.  To do that, simply
+run:
+
+	git push
+
+which will apply the changes to your public tree.  If you have web access to
+your git tree, these will eventually become visible through there.
+
+You may then have to tell your upstream maintainer what you'd like them to pull
+from your tree.  The standard way to do this is to do:
+
+	git request-pull %BASE_ID %MY_REPO >/tmp/request.txt
+
+where %BASE_ID is the head of the tree on which your changes are based, and
+%MY_REPO is the public URL of your repository.  If you have your development
+git tree configured to know where the upstream remote repository is, then if
+you've ever done 'git fetch' you should have a branch for it, named something
+like "%UPSTREAM/%UPSTREAM_BRANCH" where %UPSTREAM is the name you gave to 'git
+remote' and %UPSTREAM_BRANCH is the upstream branch on which you've based your
+development (almost certainly 'master').
+
+This command will generate a list of all the patches between %BASE_ID and the
+head of your tree that you are asking to be pulled.
+
+In my example, I can do:
+
+	git request-pull linus/master \
+		git://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-2.6-nommu.git \
+		>/tmp/request.txt
+
+You should then edit /tmp/request.txt to include a description of what you're
+trying to achieve with these patches, and then mail the whole file to the
+upstream maintainer.
+
+[!] NOTE: It may take some time for the git push to take full effect.  Before
+    that time is up, git request-pull may give spurious warnings and the test
+    it produces may say that the branch is unverified.
+
+
+===============================
+MANUALLY MERGING FAILED FETCHES
+===============================
+
+Occasionally, when you pull someone else's tree in to your repository, either
+because the base needs updating or because you're incorporating stuff from a
+contributor, the merge will fail due to conflicts between the changes you have
+made in your tree, and the changes you're importing.
+
+GIT will try and automatically merge where possible, but it can't always manage
+it.  In such cases you have to unlimber your text editor and fix it manually.
+
+GIT will report the files that need merging during the git fetch/git pull:
+
+	CONFLICT (content): Merge conflict in drivers/char/tty_audit.c
+
+and they can also be determined by looking in ".git/MERGE_MSG".
+
+GIT will interpolate markers into the affected files, along with both versions
+of the code:
+
+	<<<<<<< HEAD:drivers/char/tty_audit.c
+					 tsk->pid, uid, loginuid, sessionid,
+	=======
+					 tsk->pid, tsk->uid, loginuid, sessionid,
+	>>>>>>> b3985e2bf6ce51ae943208af4bd336287fb34ed6:drivers/char/tty_audit.c
+
+The first section (<<<<<<<< to =======) is the version from your tree, the
+second section (======= to >>>>>>>) is the version from the tree being
+imported.  The markers must be removed, and the conflicting code resolved down
+to the appropriate final version.
+
+
+Once that is done, git add (or git rm) must be called on the changed files so
+that git commit knows to include them in the new head.  It works exactly like
+changing files normally (as per the "Making changes" section), except that GIT
+has stored extra data that will go into the merge commit when git commit
+creates it.
+
+
+=============
+LOCATING BUGS
+=============
+
+There will be times when the program you've built malfunctions.  It happens now
+and then even to the best of projects.  Sometimes you can easily locate the bug
+by looking at the symptoms and the debugging output and then eyeballing the
+code, and sometimes you can't.
+
+For very big projects such as the Linux kernel, finding a bug that someone else
+has inadvertently introduced can be very hard, but GIT allows you to take
+advantage of the fact that the changes are introduced a bit at a time with
+clear boundaries (commits) to make life a bit easier.
+
+
+BISECTION
+---------
+
+What you really want to be able to do is to isolate the commit that's causing
+the malfunction, but with automation support so that you don't have to trace
+the commit tree yourself.  GIT has a tool to do this: git bisect.
+
+The way this works is to take two points in the tree: one at which you know the
+program malfunctions, and one at which you know it doesn't, and then chop its
+way through the tree to locate the failing commit.
+
+To illustrate this:
+
+ (1) Assume that you're dealing with the kernel, and that you find that after
+     Linus's merge window, 2.6.25-rc1 does not boot for you, but you know that
+     2.6.24 did prior to the window.
+
+     Firstly you have to start your search and describe the bounds (the working
+     and non-working points).  This is done with the following commands:
+
+	git bisect start [%BAD_COMMIT [%GOOD_COMMIT]]
+	git bisect bad [%BAD_COMMIT]
+	git bisect good [%GOOD_COMMIT]
+
+     where %BAD_COMMIT and %GOOD_COMMIT are optional commit object IDs or
+     symbolic representations thereof.  The 'bad' command is unnecessary if
+     %BAD_COMMIT is given to 'start', and the 'good' command is not required if
+     %GOOD_COMMIT is given to 'start'.
+
+     So, in the example we're looking at, you could do:
+
+	git bisect start
+	git bisect bad v2.6.25-rc1
+	git bisect good v2.6.24
+
+     or:
+
+	git bisect start v2.6.25-rc1
+	git bisect good v2.6.24
+
+     or:
+
+	git bisect start v2.6.25-rc1 v2.6.24
+
+	[!] NOTE: This is using a symbolic tag 'v2.6.24' to refer to the last
+     	    commit before 2.6.24 was declared.
+
+
+     However, if 2.6.25-rc1 is at currently at the head of your tree, you can
+     do:
+
+	git bisect start
+	git bisect bad
+
+     to indicate that this malfunctioned, or you could do this in a single
+     command:
+
+	git bisect start HEAD
+
+     to start bisection _and_ indicate that the HEAD revision is bad.
+
+
+     Alternatively, if you're at a point where the program _does_ work, you can
+     pass either HEAD or no parameter to the 'good' bisection command, or pass
+     HEAD as the %GOOD_COMMIT parameter to the 'start' bisection command.
+
+
+ (2) Now GIT will rumble through the commits between the two points you have
+     declared, and set the current HEAD of the repository to a point that
+     approximates midway between the two:
+
+	warthog>git bisect start v2.6.25-rc1 v2.6.24
+	Bisecting: 4814 revisions left to test after this
+	[d2e626f45cc450c00f5f98a89b8b4c4ac3c9bf5f] x86: add PAGE_KERNEL_EXEC_NOCACHE
+
+     and then it will check out the sources to reflect their state at this point.
+
+
+ (3) You should now attempt to compile this and test it.  If the test succeeds,
+     you should run the command:
+
+	git bisect good
+
+     If the test fails, run the command:
+
+	git bisect bad
+
+     These will tell GIT to binary chop the commits between either the current
+     point and the good end or the current point and the bad end to find a new
+     commit to test:
+
+	warthog>git bisect bad
+	Bisecting: 2406 revisions left to test after this
+	[fb46990dba94866462e90623e183d02ec591cf8f] [NETFILTER]: nf_queue: remove unnecessary hook existance check
+	warthog>git bisect good
+	Bisecting: 1203 revisions left to test after this
+	[936722922f6d2366378de606a40c14f96915474d] [IPV4] fib_trie: compute size when needed
+
+     As for when bisection started, GIT will set the current HEAD pointer and
+     then check out the sources.  You should repeat step (3).
+
+     If the commit is broken for you and the compile fails, run the command:
+
+	git bisect skip
+
+     this will cause the bisection algorithm to move onto the next commit in
+     the hope that this one will be better:
+
+	warthog>git bisect skip
+	Bisecting: 1203 revisions left to test after this
+	[1328042e268c936189f15eba5bd9a5a4605a8581] [IPV4] fib_trie: use hash list
+
+     this will change the HEAD pointer and check out the sources.  Repeat step
+     (3).
+
+
+ (4) Eventually, after you've tested a number of different commits, GIT will
+     tell you that it has narrowed the problem down to either a single commit,
+     or if there were compile errors that got in the way, a range of commits:
+
+	warthog>git bisect bad
+	e3ac5298159c5286cef86f0865d4fa6a606bd391 is first bad commit
+	commit e3ac5298159c5286cef86f0865d4fa6a606bd391
+	Author: Patrick McHardy <kaber@trash.net>
+	Date:   Wed Dec 5 01:23:57 2007 -0800
+
+	    [NETFILTER]: nf_queue: make queue_handler const
+
+	    Signed-off-by: Patrick McHardy <kaber@trash.net>
+	    Signed-off-by: David S. Miller <davem@davemloft.net>
+	...
+
+
+ (5) At any time during the bisection process, you can use:
+
+	git show
+
+     to examine the commit currently selected for testing, and:
+
+	git bisect log
+
+     to view the log of information provided by you through git bisect start,
+     good and bad, and:
+
+	git bisect visualize
+
+     to start up the gitk program to show you a graphical view of the current
+     good-to-bad range of commits as narrowed down by bisection.
+
+
+ (6) You should then end the bisection process by:
+
+	git bisect reset
+
+
+BLAME
+-----
+
+Now imagine that rather than indulging in bisection you've found a bug by
+simply looking at the code: who do you tell about it?  You could look at the
+banner comment at the top of the file to look for names and email addresses,
+and you could also look in the kernel MAINTAINERS file or its equivalent, but
+the person you really want to harangue is whoever made the change...
+
+There's a very useful GIT tool to help determine this:
+
+	git blame <file>
+
+also known as:
+
+	git annotate <file>
+
+which will give you a list of lines in a source file against who changed them
+last and in what commit.  You may find that your favourite editor has a
+facility to run this for you (Emacs has vc-annotate, bound to C-x v g, for
+example).
+
+Running git blame on the kernel's README file, for example, might show:
+
+	warthog>git blame README
+	620034c8 (Jesper Juhl                    2006-12-07 00:45:58 +0100   1)         Linux kernel release 2.6.xx <http://kernel.org/>
+	^1da177e (Linus Torvalds                 2005-04-16 15:20:36 -0700   2)
+	^1da177e (Linus Torvalds                 2005-04-16 15:20:36 -0700   3) These are the release notes for Linux version 2.6.  Read them carefully,
+	...
+
+The hex number that occurs first on the line is a truncated commit object ID,
+and this can be passed to git-show (remove the '^' symbol first, if given).
+
+	warthog>git show 1da177e
+	commit 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2
+	Author: Linus Torvalds <torvalds@ppc970.osdl.org>
+	Date:   Sat Apr 16 15:20:36 2005 -0700
+	...
