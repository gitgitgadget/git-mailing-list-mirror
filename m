From: Miklos Vajna <vmiklos@frugalware.org>
Subject: [PATCH] User Manual: add a chapter for submodules
Date: Thu, 20 Sep 2007 02:01:07 +0200
Message-ID: <20070920000107.GH16235@genesis.frugalware.org>
References: <Pine.LNX.4.64.0709181405120.6203@juice.ott.cti.com> <20070919174250.GC16235@genesis.frugalware.org> <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 02:01:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY9U3-0006in-UC
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 02:01:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413AbXITABZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2007 20:01:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752072AbXITABZ
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 20:01:25 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:35881 "EHLO mx3.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751356AbXITABY (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2007 20:01:24 -0400
Received: from frugalware.elte.hu ([157.181.177.34] helo=genesis.frugalware.org)
	by mx3.mail.elte.hu with esmtp (Exim)
	id 1IY9Tq-0006Xs-Mq
	from <vmiklos@frugalware.org>; Thu, 20 Sep 2007 02:01:19 +0200
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id CC83C1678013; Thu, 20 Sep 2007 02:01:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7vbqbyphil.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13cvs-muttng-frugalware (2007-01-09)
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -1.4
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-1.4 required=5.9 tests=BAYES_00,FORGED_RCVD_HELO autolearn=no SpamAssassin version=3.1.7-deb
	0.1 FORGED_RCVD_HELO       Received: contains a forged HELO
	-1.5 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58744>

Signed-off-by: Michael Smith <msmith@cbnco.com>
Signed-off-by: Miklos Vajna <vmiklos@frugalware.org>
---

[ 2nd version ]

On Wed, Sep 19, 2007 at 12:44:18PM -0700, Junio C Hamano <gitster@pobox.com> wrote:
> > +To see how submodule support works, create (for example) four example
> > +repository that can be used later as a submodule:
> 
> s/repository/repositories/;

fixed.

> > +$ for i in a b c d
> > +do
> > +	mkdir $i
> > +	cd $i
> > +	git init
> > +	echo "module $i" > $i.txt
> > +	git add $i.txt
> > +	git commit -m "Initial commit, submodule $mod"
> 
> s/\$mod/$i/;

fixed

> > +$ echo hi > super.txt
> > +$ git add super.txt
> > +$ git commit -m "Initial commit of empty superproject"
> 
> This is not *empty*; do you even need this step?

in fact, no :) removed.

> > +-------------------------------------------------
> > +$ git commit -m "Add submodules a, b, c, d."
> > +-------------------------------------------------
> 
> s/c, d./c and d./;

fixed.

> > +$ ls -a a
> > +.  ..
> > +$ git submodule status
> > +-d266b9873ad50488163457f025db7cdd9683d88b a
> > +-e81d457da15309b4fef4249aba9b50187999670d b
> > +-c1536a972b9affea0f16e0680ba87332dc059146 c
> > +-d96249ff5d57de5de093e6baff9e0aafa5276a74 d
> > +-------------------------------------------------
> 
> You might want to mention...
> 
>     Note: the commit object names shown above would be different for
>     you, but they should match the HEAD commit object names of your
>     repositories.  You can check it by doing:
> 
>     $ git ls-remote ../a

i've added such a note.

> > +If you want to make a change within a submodule, you should first check out a
> > +branch, make your changes, publish the change within the submodule, and then
> > +update the superproject to reference the new commit:
> > +
> > +-------------------------------------------------
> > +$ git branch
> > +* (no branch)
> > +  master
> > +$ git checkout master
> 
> I am not so sure about this advice.  Don't you want to see how
> the detached HEAD and 'master' (or any other branches) are
> related before doing this?  You might even want to create a
> "fix-up" branch that is rooted at the detached HEAD if the
> change you are making is to fix minor details of the submodule
> to suit what superproject wants (i.e. "little feature that is
> applicable to the submodule as a standalone project, meant to
> be pushed back to the submodule upstream").

right, changed it to two examples, one about "git checkout master", and
the other about "git checkout -b fix-up"

> > +$ git push
> > +$ cd ..
> > +$ git add a
> 
> Before doing this "git add", it would be educational to have the
> user do
> 
>     $ git diff
> 
> which would say that now the submodule is being updated.

added.

> > +$ git commit -m "Updated submodule a."
> > +$ git push
> > +-------------------------------------------------
> > +
> > +NOTE: This means that you have to run `git submodule update` after `git pull`
> > +if you want to update the subprojects, too.
> 
> I do not quite understand this note.  I do understand the part
> after "that you have to", but I do not know how the above
> example relates to that --- iow, the above example does not
> seem to "mean" such thing to me.
> 
> Also "submodule" is used consistently in the rest of the
> document but this sentence talks about "subproject".

yes, it was illogical to use a 'note' here as it's not related. i've
just added a separte sentence about this without the 'this means'.

> > +Problems with submodules
> > +------------------------
> 
> The list is good, but are they Problems or pitfalls to watch out
> for?

the later :) title changed.

> > +Always publish the submodule change before publishing the change to the
> > +superproject that references it. If you forget to publish the submodule change,
> > +others won't be able to clone the repository:
> 
> The same caution applies not to rewind branches in submodule
> beyond commits that were ever recorded in any superproject.

i've added a paragraph about this issue.

> > +-------------------------------------------------
> > +$ echo i added another line to this file >> a.txt
> > +$ git commit -a -m "doing it wrong this time"
> 
> It is not clear in which repository you are supposed to try this
> command in the example sequence, as we crossed the section
> boundary.  I am _guessing_ that the above two commands are to be
> run inside ~/git/cloned-2/a after redoing ~/git/cloned-2 the
> same way as you did ~/git/cloned, but you may want to make it
> clear.

right, i forgot the 'cd ~/git/super/a'. provided the repos are
symmetric, i think it would just make the situation unnecessary
complicated to clone a third repo.

> > +$ git submodule update
> > +error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
> > +Did you forget to 'git add'?
> 
> I sense there is a bug in "git submodule update" here.  I do not
> have time to look at what it's doing right now, but this is a
> symptom of running:
> 
>     $ git checkout 261dfac35...
> 
> without checking if that is a valid commit object name, and git
> checkout cannot decide if the request is about detaching the
> head at commit 261dfac35 or checking the path 261dfac35 out of
> the current index.  Porcelains should check with "cat-file -t"
> first.

hm yes. i think as long as this behaviour is not changed, it would not
be good to remove the "Did you forget to 'git add'?" part from the
example

> > +Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path 'a'
> > +-------------------------------------------------
> > +
> > +It's not safe to run `git submodule update` if you've made changes within a
> > +submodule. They will be silently overwritten:
> 
> You want to distinguish two cases here.  Local uncommitted
> changes, and committed changes.  The latter case is switched
> away without too much noise, which is what you are demonstrating
> here.  I _think_ local uncommitted changes will not be
> overwritten at all, unless "submodule update" does "reset
> --hard", which I suspect it doesn't.

i've just checked that it does a git checkout, so uncommitted changes
are preserved. i've updated this part to mention this fact.

i've also added the suggestions by skimo.

VMiklos

 Documentation/user-manual.txt |  175 +++++++++++++++++++++++++++++++++++++++++
 1 files changed, 175 insertions(+), 0 deletions(-)

diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index ecb2bf9..ce0cf38 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3155,6 +3155,181 @@ a tree which you are in the process of working on.
 If you blow the index away entirely, you generally haven't lost any
 information as long as you have the name of the tree that it described.
 
+[[submodules]]
+Submodules
+==========
+
+This tutorial explains how to create and publish a repository with submodules
+using the gitlink:git-submodule[1] command.
+
+Submodules maintain their own identity; the submodule support just stores the
+submodule repository location and commit ID, so other developers who clone the
+superproject can easily clone all the submodules at the same revision.
+
+To see how submodule support works, create (for example) four example
+repository that can be used later as a submodule:
+
+-------------------------------------------------
+$ mkdir ~/git
+$ cd ~/git
+$ for i in a b c d
+do
+	mkdir $i
+	cd $i
+	git init
+	echo "module $i" > $i.txt
+	git add $i.txt
+	git commit -m "Initial commit, submodule $mod"
+	cd ..
+done
+-------------------------------------------------
+
+Now create the superproject and add all the submodules:
+
+-------------------------------------------------
+$ mkdir super
+$ cd super
+$ git init
+$ echo hi > super.txt
+$ git add super.txt
+$ git commit -m "Initial commit of empty superproject"
+$ for i in a b c d
+do
+	git submodule add ~/git/$i
+done
+-------------------------------------------------
+
+See what files `git submodule` created:
+
+-------------------------------------------------
+$ ls -a
+.  ..  .git  .gitmodules  a  b  c  d  super.txt
+-------------------------------------------------
+
+The `git submodule add` command does a couple of things:
+
+- It clones the submodule under the current directory and by default checks out
+  the master branch.
+- It adds the submodule's clone path to the `.gitmodules` file and adds this
+  file to the index, ready to be committed.
+- It adds the submodule's current commit ID to the index, ready to be
+  committed.
+
+Commit the superproject:
+
+-------------------------------------------------
+$ git commit -m "Add submodules a, b, c, d."
+-------------------------------------------------
+
+Now clone the superproject:
+
+-------------------------------------------------
+$ cd ..
+$ git clone super cloned
+$ cd cloned
+-------------------------------------------------
+
+The submodule directories are there, but they're empty:
+
+-------------------------------------------------
+$ ls -a a
+.  ..
+$ git submodule status
+-d266b9873ad50488163457f025db7cdd9683d88b a
+-e81d457da15309b4fef4249aba9b50187999670d b
+-c1536a972b9affea0f16e0680ba87332dc059146 c
+-d96249ff5d57de5de093e6baff9e0aafa5276a74 d
+-------------------------------------------------
+
+Pulling down the submodules is a two-step process. First run `git submodule
+init` to add the submodule repository URLs to `.git/config`:
+
+-------------------------------------------------
+$ git submodule init
+-------------------------------------------------
+
+Now use `git submodule update` to clone the repositories and check out the
+commits specified in the superproject:
+
+-------------------------------------------------
+$ git submodule update
+$ cd a
+$ ls -a
+.  ..  .git  a.txt
+-------------------------------------------------
+
+One major difference between `git submodule update` and `git submodule add` is
+that `git submodule update` checks out a specific commit, rather than the tip
+of a branch. It's like checking out a tag: the head is detached, so you're not
+working on a branch.
+
+-------------------------------------------------
+$ git branch
+* (no branch)
+  master
+-------------------------------------------------
+
+If you want to make a change within a submodule, you should first check out a
+branch, make your changes, publish the change within the submodule, and then
+update the superproject to reference the new commit:
+
+-------------------------------------------------
+$ git branch
+* (no branch)
+  master
+$ git checkout master
+$ echo "adding a line again" >> a.txt
+$ git commit -a -m "Updated the submodule from within the superproject."
+$ git push
+$ cd ..
+$ git add a
+$ git commit -m "Updated submodule a."
+$ git push
+-------------------------------------------------
+
+NOTE: This means that you have to run `git submodule update` after `git pull`
+if you want to update the subprojects, too.
+
+Problems with submodules
+------------------------
+
+Always publish the submodule change before publishing the change to the
+superproject that references it. If you forget to publish the submodule change,
+others won't be able to clone the repository:
+
+-------------------------------------------------
+$ echo i added another line to this file >> a.txt
+$ git commit -a -m "doing it wrong this time"
+$ cd ..
+$ git add a
+$ git commit -m "Updated submodule a again."
+$ git push
+$ cd ~/git/cloned
+$ git pull
+$ git submodule update
+error: pathspec '261dfac35cb99d380eb966e102c1197139f7fa24' did not match any file(s) known to git.
+Did you forget to 'git add'?
+Unable to checkout '261dfac35cb99d380eb966e102c1197139f7fa24' in submodule path 'a'
+-------------------------------------------------
+
+It's not safe to run `git submodule update` if you've made changes within a
+submodule. They will be silently overwritten:
+
+-------------------------------------------------
+$ cat a.txt
+module a
+$ echo line added from private2 >> a.txt
+$ git commit -a -m "line added inside private2"
+$ cd ..
+$ git submodule update
+Submodule path 'a': checked out 'd266b9873ad50488163457f025db7cdd9683d88b'
+$ cd a
+$ cat a.txt
+module a
+-------------------------------------------------
+
+NOTE: The changes are still visible in the submodule's reflog.
+
 [[low-level-operations]]
 Low-level git operations
 ========================
-- 
1.5.3.1.1.g1e61-dirty
