From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH 03/10] glossary: expand and clarify some definitions, prune cross-references
Date: Mon, 14 May 2007 11:21:22 -0400
Message-ID: <5520.48510076037$1179156136@news.gmane.org>
References: <11791560893572-git-send-email->
 <1179156089759-git-send-email->
Cc: git@vger.kernel.org, "J. Bruce Fields" <bfields@citi.umich.edu>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon May 14 17:22:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HncNJ-0006P0-1H
	for gcvg-git@gmane.org; Mon, 14 May 2007 17:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756824AbXENPVp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 14 May 2007 11:21:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756460AbXENPVo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 May 2007 11:21:44 -0400
Received: from mail.fieldses.org ([66.93.2.214]:54963 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756248AbXENPVd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 May 2007 11:21:33 -0400
Received: from bfields by fieldses.org with local (Exim 4.67)
	(envelope-from <bfields@fieldses.org>)
	id 1HncMb-0004z4-LE; Mon, 14 May 2007 11:21:29 -0400
X-Mailer: git-send-email 1.5.1.4.19.g69e2
In-Reply-To: <1179156089759-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47255>

From: J. Bruce Fields <bfields@citi.umich.edu>

Revise and expand some of the definitions in the glossary, based in part
on a recent thread started by a user looking for help with some of the
jargon.  I've borrowed some of the language from Linus's email on that
thread.  (I'm assuming standing permission to plagiarize Linus's
email....)

Also start making a few changes to mitigate the appearance of
"circularity" mentioned in that thread:
	- feel free to use somewhat longer definitions and to explain
	  some things more than once instead of relying purely on
	  cross-references
	- don't use cross-references when they're redundant: eliminate
	  self-references and repeated references to the same entry.

Cc: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/glossary.txt |  229 ++++++++++++++++++++++++++------------------
 1 files changed, 135 insertions(+), 94 deletions(-)

diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 2465514..fcf5d59 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -2,12 +2,12 @@ GIT Glossary
 ============
 
 [[def_alternate_object_database]]alternate object database::
-	Via the alternates mechanism, a <<def_repository,repository>> can
-	inherit part of its <<def_object_database,object database>> from another
-	<<def_object_database,object database>>, which is called "alternate".
+	Via the alternates mechanism, a <<def_repository,repository>>
+	can inherit part of its <<def_object_database,object database>>
+	from another object database, which is called "alternate".
 
 [[def_bare_repository]]bare repository::
-	A <<def_bare_repository,bare repository>> is normally an appropriately
+	A bare repository is normally an appropriately
 	named <<def_directory,directory>> with a `.git` suffix that does not
 	have a locally checked-out copy of any of the files under
 	<<def_revision,revision>> control. That is, all of the `git`
@@ -21,10 +21,15 @@ GIT Glossary
 	Untyped <<def_object,object>>, e.g. the contents of a file.
 
 [[def_branch]]branch::
-	A non-cyclical graph of revisions, i.e. the complete history of a
-	particular <<def_revision,revision>>, which is called the
-	branch <<def_head,head>>. The heads
-	are stored in `$GIT_DIR/refs/heads/`.
+	A "branch" is an active line of development.  The most recent
+	<<def_commit,commit>> on a branch is referred to as the tip of
+	that branch.  The tip of the branch is referenced by a branch
+	<<def_head,head>>, which moves forward as additional development
+	is done on the branch.  A single git
+	<<def_repository,repository>> can track an arbitrary number of
+	branches, but your <<def_working_tree,working tree>> is
+	associated with just one of them (the "current" or "checked out"
+	branch), and <<def_HEAD,HEAD>> points to that branch.
 
 [[def_cache]]cache::
 	Obsolete for: <<def_index,index>>.
@@ -50,18 +55,25 @@ GIT Glossary
 	as a new series of changes on top of different codebase. In GIT, this is
 	performed by "git cherry-pick" command to extract the change introduced
 	by an existing <<def_commit,commit>> and to record it based on the tip
-	of the current <<def_branch,branch>> as a new <<def_commit,commit>>.
+	of the current <<def_branch,branch>> as a new commit.
 
 [[def_clean]]clean::
-	A <<def_working_tree,working tree>> is <<def_clean,clean>>, if it
+	A <<def_working_tree,working tree>> is clean, if it
 	corresponds to the <<def_revision,revision>> referenced by the current
 	<<def_head,head>>. Also see "<<def_dirty,dirty>>".
 
 [[def_commit]]commit::
-	As a verb: The action of storing the current state of the
-	<<def_index,index>> in the <<def_object_database,object database>>. The
-	result is a <<def_revision,revision>>. As a noun: Short hand for
-	<<def_commit_object,commit object>>.
+	As a noun: A single point in the
+	git history; the entire history of a project is represented as a
+	set of interrelated commits.  The word "commit" is used often
+	used by git in the same places other revision control systems
+	use the words "revision" or "version".  Also used as a short
+	hand for <<def_commit_object,commit object>>.
++
+As a verb: The action of storing a new snapshot of the project's
+state in the git history, by creating a new commit representing the current
+state of the <<def_index,index>> and advancing <<def_HEAD,HEAD>>
+to point at the new commit.)
 
 [[def_commit_object]]commit object::
 	An <<def_object,object>> which contains the information about a
@@ -77,16 +89,22 @@ GIT Glossary
 [[def_DAG]]DAG::
 	Directed acyclic graph. The <<def_commit,commit>> objects form a
 	directed acyclic graph, because they have parents (directed), and the
-	graph of <<def_commit,commit>> objects is acyclic (there is no
+	graph of commit objects is acyclic (there is no
 	<<def_chain,chain>> which begins and ends with the same
 	<<def_object,object>>).
 
 [[def_dangling_object]]dangling object::
 	An <<def_unreachable_object,unreachable object>> which is not
 	<<def_reachable,reachable>> even from other unreachable objects; a
-	<<def_dangling_object,dangling object>> has no references to it from any
+	dangling object has no references to it from any
 	reference or <<def_object,object>> in the <<def_repository,repository>>.
 
+[[def_detached_HEAD]]detached HEAD::
+	Normally HEAD refers to the tip of a
+	<<def_branch,branch>>.  However, git also allows you to check
+	out an arbitrary commit that isn't necessarily the tip of any
+	particular branch.  In this case HEAD is said to be "detached".
+
 [[def_dircache]]dircache::
 	You are *waaaaay* behind.
 
@@ -94,7 +112,7 @@ GIT Glossary
 	The list you get with "ls" :-)
 
 [[def_dirty]]dirty::
-	A <<def_working_tree,working tree>> is said to be <<def_dirty,dirty>> if
+	A <<def_working_tree,working tree>> is said to be "dirty" if
 	it contains modifications which have not been committed to the current
 	<<def_branch,branch>>.
 
@@ -109,16 +127,16 @@ GIT Glossary
 	<<def_branch,branch>>'s changes that happen to be a descendant of what
 	you have. In such these cases, you do not make a new <<def_merge,merge>>
 	<<def_commit,commit>> but instead just update to his
-	<<def_revision,revision>>. This will happen frequently on a
+	revision. This will happen frequently on a
 	<<def_tracking_branch,tracking branch>> of a remote
 	<<def_repository,repository>>.
 
 [[def_fetch]]fetch::
 	Fetching a <<def_branch,branch>> means to get the
-	<<def_branch,branch>>'s <<def_head_ref,head ref>> from a remote
-	<<def_repository,repository>>, to find out which objects are missing
-	from the local <<def_object_database,object database>>, and to get them,
-	too.
+	branch's <<def_head_ref,head ref>> from a remote
+	<<def_repository,repository>>, to find out which objects are
+	missing from the local <<def_object_database,object database>>,
+	and to get them, too.  See also gitlink:git-fetch[1].
 
 [[def_file_system]]file system::
 	Linus Torvalds originally designed git to be a user space file system,
@@ -132,61 +150,84 @@ GIT Glossary
 	Grafts enables two otherwise different lines of development to be joined
 	together by recording fake ancestry information for commits. This way
 	you can make git pretend the set of parents a <<def_commit,commit>> has
-	is different from what was recorded when the <<def_commit,commit>> was
+	is different from what was recorded when the commit was
 	created. Configured via the `.git/info/grafts` file.
 
 [[def_hash]]hash::
 	In git's context, synonym to <<def_object_name,object name>>.
 
 [[def_head]]head::
-	The top of a <<def_branch,branch>>. It contains a <<def_ref,ref>> to the
-	corresponding <<def_commit_object,commit object>>.
+	A named reference to the <<def_commit,commit>> at the tip of a
+	<<def_branch,branch>>.  Heads are stored in
+	`$GIT_DIR/refs/heads/`, except when using packed refs. (See
+	gitlink:git-packed-refs[1].)
+
+[[def_HEAD]]HEAD::
+	The current branch.  In more detail: a reference to the most
+	recent <<def_commit,commit>> on the branch that you are
+	currently working on.  Your <<def_working_tree,working tree>> is
+	normally derived from the state of the tree referred to by HEAD.
+	HEAD is a reference to one of the <<def_head,heads>> in your
+	repository, except when using a <<def_detached_HEAD,detached
+	HEAD>>, in which case it may reference an arbitrary commit.
 
 [[def_head_ref]]head ref::
-	A <<def_ref,ref>> pointing to a <<def_head,head>>. Often, this is
-	abbreviated to "<<def_head,head>>". Head refs are stored in
-	`$GIT_DIR/refs/heads/`.
+	A synonym for <<def_head,head>>.
 
 [[def_hook]]hook::
 	During the normal execution of several git commands, call-outs are made
 	to optional scripts that allow a developer to add functionality or
 	checking. Typically, the hooks allow for a command to be pre-verified
 	and potentially aborted, and allow for a post-notification after the
-	operation is done. The <<def_hook,hook>> scripts are found in the
+	operation is done. The hook scripts are found in the
 	`$GIT_DIR/hooks/` <<def_directory,directory>>, and are enabled by simply
 	making them executable.
 
 [[def_index]]index::
 	A collection of files with stat information, whose contents are stored
-	as objects. The <<def_index,index>> is a stored version of your working
+	as objects. The index is a stored version of your working
 	<<def_tree,tree>>. Truth be told, it can also contain a second, and even
 	a third version of a <<def_working_tree,working tree>>, which are used
 	when merging.
 
 [[def_index_entry]]index entry::
 	The information regarding a particular file, stored in the
-	<<def_index,index>>. An <<def_index_entry,index entry>> can be unmerged,
-	if a <<def_merge,merge>> was started, but not yet finished (i.e. if the
-	<<def_index,index>> contains multiple versions of that file).
+	<<def_index,index>>. An index entry can be unmerged, if a
+	<<def_merge,merge>> was started, but not yet finished (i.e. if
+	the index contains multiple versions of that file).
 
 [[def_master]]master::
-	The default development <<def_branch,branch>>. Whenever you create a git
-	<<def_repository,repository>>, a <<def_branch,branch>> named
-	"<<def_master,master>>" is created, and becomes the active
-	<<def_branch,branch>>. In most cases, this contains the local
-	development, though that is purely conventional and not required.
+	The default development <<def_branch,branch>>. Whenever you
+	create a git <<def_repository,repository>>, a branch named
+	"master" is created, and becomes the active branch. In most
+	cases, this contains the local development, though that is
+	purely by convention and is not required.
 
 [[def_merge]]merge::
-	To <<def_merge,merge>> branches means to try to accumulate the changes
-	since a common ancestor and apply them to the first
-	<<def_branch,branch>>. An automatic <<def_merge,merge>> uses heuristics
-	to accomplish that. Evidently, an automatic <<def_merge,merge>> can
-	fail.
+	As a verb: To bring the contents of another
+	<<def_branch,branch>> (possibly from an external
+	<<def_repository,repository>>) into the current branch.  In the
+	case where the merged-in branch is from a different repository,
+	this is done by first <<def_fetch,fetching>> the remote branch
+	and then merging the result into the current branch.  This
+	combination of fetch and merge operations is called a
+	<<def_pull,pull>>.  Merging is performed by an automatic process
+	that identifies changes made since the branches diverged, and to
+	apply all those changes together.  In cases where changes
+	conflict, manual intervention may be required to complete the
+	merge.
++
+As a noun: unless it is a <<def_fast_forward,fast forward>>, a
+successful merge results in the creation of a new <<def_commit,commit>>
+representing the result of the merge, and having as
+<<def_parent,parents>> the tips of the merged <<def_branch,branches>>.
+This commit is referred to as a "merge commit", or sometimes just a
+"merge".
 
 [[def_object]]object::
 	The unit of storage in git. It is uniquely identified by the
 	<<def_SHA1,SHA1>> of its contents. Consequently, an
-	<<def_object,object>> can not be changed.
+	object can not be changed.
 
 [[def_object_database]]object database::
 	Stores a set of "objects", and an individual <<def_object,object>> is
@@ -198,9 +239,9 @@ GIT Glossary
 
 [[def_object_name]]object name::
 	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
-	of the <<def_object,object>>'s contents using the Secure Hash Algorithm
+	of the object's contents using the Secure Hash Algorithm
 	1 and usually represented by the 40 character hexadecimal encoding of
-	the <<def_hash,hash>> of the <<def_object,object>> (possibly followed by
+	the <<def_hash,hash>> of the object (possibly followed by
 	a white space).
 
 [[def_object_type]]object type::
@@ -215,7 +256,7 @@ GIT Glossary
 [[def_origin]]origin::
 	The default upstream <<def_repository,repository>>. Most projects have
 	at least one upstream project which they track. By default
-	'<<def_origin,origin>>' is used for that purpose. New upstream updates
+	'origin' is used for that purpose. New upstream updates
 	will be fetched into remote tracking branches named
 	origin/name-of-upstream-branch, which you can see using
 	"git <<def_branch,branch>> -r".
@@ -227,7 +268,7 @@ GIT Glossary
 [[def_pack_index]]pack index::
 	The list of identifiers, and other information, of the objects in a
 	<<def_pack,pack>>, to assist in efficiently accessing the contents of a
-	<<def_pack,pack>>.
+	pack.
 
 [[def_parent]]parent::
 	A <<def_commit_object,commit object>> contains a (possibly empty) list
@@ -247,29 +288,29 @@ GIT Glossary
 [[def_porcelain]]porcelain::
 	Cute name for programs and program suites depending on
 	<<def_core_git,core git>>, presenting a high level access to
-	<<def_core_git,core git>>. Porcelains expose more of a <<def_SCM,SCM>>
+	core git. Porcelains expose more of a <<def_SCM,SCM>>
 	interface than the <<def_plumbing,plumbing>>.
 
 [[def_pull]]pull::
 	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
-	<<def_merge,merge>> it.
+	<<def_merge,merge>> it.  See also gitlink:git-pull[1].
 
 [[def_push]]push::
-	Pushing a <<def_branch,branch>> means to get the <<def_branch,branch>>'s
+	Pushing a <<def_branch,branch>> means to get the branch's
 	<<def_head_ref,head ref>> from a remote <<def_repository,repository>>,
-	find out if it is an ancestor to the <<def_branch,branch>>'s local
-	<<def_head_ref,head ref>> is a direct, and in that case, putting all
+	find out if it is an ancestor to the branch's local
+	head ref is a direct, and in that case, putting all
 	objects, which are <<def_reachable,reachable>> from the local
-	<<def_head_ref,head ref>>, and which are missing from the remote
-	<<def_repository,repository>>, into the remote
+	head ref, and which are missing from the remote
+	repository, into the remote
 	<<def_object_database,object database>>, and updating the remote
-	<<def_head_ref,head ref>>. If the remote <<def_head,head>> is not an
-	ancestor to the local <<def_head,head>>, the <<def_push,push>> fails.
+	head ref. If the remote <<def_head,head>> is not an
+	ancestor to the local head, the push fails.
 
 [[def_reachable]]reachable::
 	All of the ancestors of a given <<def_commit,commit>> are said to be
-	<<def_reachable,reachable>> from that <<def_commit,commit>>. More
-	generally, one <<def_object,object>> is <<def_reachable,reachable>> from
+	"reachable" from that commit. More
+	generally, one <<def_object,object>> is reachable from
 	another if we can reach the one from the other by a <<def_chain,chain>>
 	that follows <<def_tag,tags>> to whatever they tag,
 	<<def_commit_object,commits>> to their parents or trees, and
@@ -288,24 +329,23 @@ GIT Glossary
 
 [[def_refspec]]refspec::
 	A <<def_refspec,refspec>> is used by <<def_fetch,fetch>> and
-	<<def_push,push>> to describe the mapping between remote <<def_ref,ref>>
-	and local <<def_ref,ref>>. They are combined with a colon in the format
-	<src>:<dst>, preceded by an optional plus sign, +. For example: `git
-	fetch $URL refs/heads/master:refs/heads/origin` means
-	"grab the master <<def_branch,branch>> <<def_head,head>>
-	from the $URL and store it as my origin
-	<<def_branch,branch>> <<def_head,head>>". And `git <<def_push,push>>
-	$URL refs/heads/master:refs/heads/to-upstream` means
-	"publish my master <<def_branch,branch>>
-	<<def_head,head>> as to-upstream <<def_branch,branch>> at $URL". See
-	also gitlink:git-push[1]
+	<<def_push,push>> to describe the mapping between remote
+	<<def_ref,ref>> and local ref. They are combined with a colon in
+	the format <src>:<dst>, preceded by an optional plus sign, +.
+	For example: `git fetch $URL
+	refs/heads/master:refs/heads/origin` means "grab the master
+	<<def_branch,branch>> <<def_head,head>> from the $URL and store
+	it as my origin branch head". And `git push
+	$URL refs/heads/master:refs/heads/to-upstream` means "publish my
+	master branch head as to-upstream branch at $URL". See also
+	gitlink:git-push[1]
 
 [[def_repository]]repository::
-	A collection of refs together with an <<def_object_database,object
-	database>> containing all objects which are <<def_reachable,reachable>>
-	from the refs, possibly accompanied by meta data from one or more
-	porcelains. A <<def_repository,repository>> can share an
-	<<def_object_database,object database>> with other repositories.
+	A collection of refs together with an
+	<<def_object_database,object database>> containing all objects
+	which are <<def_reachable,reachable>> from the refs, possibly
+	accompanied by meta data from one or more porcelains. A
+	repository can share an object database with other repositories.
 
 [[def_resolve]]resolve::
 	The action of fixing up manually what a failed automatic
@@ -327,36 +367,37 @@ GIT Glossary
 	Synonym for <<def_object_name,object name>>.
 
 [[def_shallow_repository]]shallow repository::
-	A <<def_shallow_repository,shallow repository>> has an incomplete
+	A shallow repository has an incomplete
 	history some of whose commits have parents cauterized away (in other
 	words, git is told to pretend that these commits do not have the
 	parents, even though they are recorded in the <<def_commit_object,commit
 	object>>). This is sometimes useful when you are interested only in the
 	recent history of a project even though the real history recorded in the
-	upstream is much larger. A <<def_shallow_repository,shallow repository>>
+	upstream is much larger. A shallow repository
 	is created by giving the `--depth` option to gitlink:git-clone[1], and
 	its history can be later deepened with gitlink:git-fetch[1].
 
 [[def_symref]]symref::
-	Symbolic reference: instead of containing the <<def_SHA1,SHA1>> id
-	itself, it is of the format 'ref: refs/some/thing' and when
-	referenced, it recursively dereferences to this reference. 'HEAD' is a
-	prime example of a <<def_symref,symref>>. Symbolic references are
-	manipulated with the gitlink:git-symbolic-ref[1] command.
+	Symbolic reference: instead of containing the <<def_SHA1,SHA1>>
+	id itself, it is of the format 'ref: refs/some/thing' and when
+	referenced, it recursively dereferences to this reference.
+	'<<def_HEAD,HEAD>>' is a prime example of a symref. Symbolic
+	references are manipulated with the gitlink:git-symbolic-ref[1]
+	command.
 
 [[def_tag]]tag::
-	A <<def_ref,ref>> pointing to a <<def_tag,tag>> or
+	A <<def_ref,ref>> pointing to a tag or
 	<<def_commit_object,commit object>>. In contrast to a <<def_head,head>>,
 	a tag is not changed by a <<def_commit,commit>>. Tags (not
 	<<def_tag_object,tag objects>>) are stored in `$GIT_DIR/refs/tags/`. A
 	git tag has nothing to do with a Lisp tag (which would be
 	called an <<def_object_type,object type>> in git's context). A
 	tag is most typically used to mark a particular point in the
-	<<def_commit,commit>> ancestry <<def_chain,chain>>.
+	commit ancestry <<def_chain,chain>>.
 
 [[def_tag_object]]tag object::
 	An <<def_object,object>> containing a <<def_ref,ref>> pointing to
-	another <<def_object,object>>, which can contain a message just like a
+	another object, which can contain a message just like a
 	<<def_commit_object,commit object>>. It can also contain a (PGP)
 	signature, in which case it is called a "signed <<def_tag_object,tag
 	object>>".
@@ -370,16 +411,16 @@ GIT Glossary
 
 [[def_tracking_branch]]tracking branch::
 	A regular git <<def_branch,branch>> that is used to follow changes from
-	another <<def_repository,repository>>. A <<def_tracking_branch,tracking
-	branch>> should not contain direct modifications or have local commits
-	made to it. A <<def_tracking_branch,tracking branch>> can usually be
+	another <<def_repository,repository>>. A tracking
+	branch should not contain direct modifications or have local commits
+	made to it. A tracking branch can usually be
 	identified as the right-hand-side <<def_ref,ref>> in a Pull:
 	<<def_refspec,refspec>>.
 
 [[def_tree]]tree::
 	Either a <<def_working_tree,working tree>>, or a <<def_tree_object,tree
-	object>> together with the dependent blob and <<def_tree,tree>> objects
-	(i.e. a stored representation of a <<def_working_tree,working tree>>).
+	object>> together with the dependent blob and tree objects
+	(i.e. a stored representation of a working tree).
 
 [[def_tree_object]]tree object::
 	An <<def_object,object>> containing a list of file names and modes along
@@ -389,8 +430,7 @@ GIT Glossary
 [[def_tree-ish]]tree-ish::
 	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
 	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
-	object>> pointing to a <<def_tag,tag>> or <<def_commit,commit>> or
-	<<def_tree_object,tree object>>.
+	object>> pointing to a tag or commit or tree object.
 
 [[def_unmerged_index]]unmerged index::
 	An <<def_index,index>> which contains unmerged
@@ -401,5 +441,6 @@ GIT Glossary
 	<<def_branch,branch>>, <<def_tag,tag>>, or any other reference.
 
 [[def_working_tree]]working tree::
-	The set of files and directories currently being worked on, i.e. you can
-	work in your <<def_working_tree,working tree>> without using git at all.
+	The tree of actual checked out files.  The working tree is
+	normally equal to the <<def_HEAD,HEAD>> plus any local changes
+	that you have made but not yet committed.
-- 
1.5.1.4.19.g69e2
