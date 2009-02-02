From: Jakub Narebski <jnareb@gmail.com>
Subject: Comments on "Understanding Version Control" by Eric S. Raymond
Date: Mon, 2 Feb 2009 19:48:53 +0100
Message-ID: <200902021948.54700.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Cc: "Eric S. Raymond" <esr@thyrsus.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 19:49:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LU3rX-0006VM-E3
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 19:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753896AbZBBSsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 13:48:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753806AbZBBSsM
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 13:48:12 -0500
Received: from fg-out-1718.google.com ([72.14.220.158]:40499 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753726AbZBBSsJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 13:48:09 -0500
Received: by fg-out-1718.google.com with SMTP id 16so678330fgg.17
        for <git@vger.kernel.org>; Mon, 02 Feb 2009 10:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        bh=Dl1KZa66lSgtBXkuVQKFqbmODNHulFQCasVJc4xoJaU=;
        b=l86cnNIPeJT2LsJIEW3gFy2Wg/oegAbk79LVkmgiTEu6/mV63/TLKoYGLJh5R9YsCx
         fsndeyB+OIdP3clZBBD8+T+FPDoB8YatDMEFpfZLdMQnIsMvZfUoyN8b/9V5RdUgdY/V
         jp5c/T+i0kmU+dhbWxMN8koeWkyRw1g396wzM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        b=emAQdd5jODHNT/bUu6VoLXNRlTmeR0J9b5NTdIVwJ8zyOyEgIZiFwXjH0LdmpmZ7ua
         TwGh1fhoOb4GJzejn0eGG6KPA5U8SN83V70x6Zkt8+zXPIWymz5PJWoaXc+j91X3hq/4
         FuAJrd6c1i1U9IGOMRLk/TVipzGw1xfNwE9wg=
Received: by 10.103.176.20 with SMTP id d20mr972675mup.27.1233600486357;
        Mon, 02 Feb 2009 10:48:06 -0800 (PST)
Received: from ?192.168.1.13? (abwn190.neoplus.adsl.tpnet.pl [83.8.237.190])
        by mx.google.com with ESMTPS id b9sm6473212mug.56.2009.02.02.10.48.03
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Feb 2009 10:48:05 -0800 (PST)
User-Agent: KMail/1.9.3
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108106>

Some time ago I have found "Understanding Version-Control Systems"
(http://www.catb.org/esr/writings/version-control/version-control.html)
paper (in draft version) by Eric S. Raymond, via Joel Spolsky
recommendation in 'Podcast #37' entry in Stackoverflow Blog
(http://blog.stackoverflow.com/2009/01/podcast-37/).

This is a very nice _survey paper_, currently in development, so we
now have time for comments, corrections and suggestions.  It is
currently on hiatus (it seems that last changes are from the Jan 2008,
slightly more than a year ago), but it is not abandoned.  ESR plans to
get back to it after Wesnoth and gpsd do their upcoming releases.

In my opinion the most important issue is concentrating on "container
identity" instead of on the underlying issue of renames in version
control, which includes intelligent, rename-aware merge; talk about
issues and not about possible solution.  I will concentrate on this
issue for now, and leave for example issue of workflows, and of VCS
history for possible later posts (it is long enough as is).


Below you can find my comments; quoted fragments of "Understanding
Version Control' essay are prefixed with 'UVC> '.  'TODO' refers to
http://www.catb.org/esr/writings/version-control/TODO.html

Please do participate in this discussion, especially if you have
something to say with respect to rename detection versus rename
tracking issue.  Thanks in advance.

----------------------------------------------------------------------
http://www.catb.org/esr/writings/version-control/version-control.html

(Independent comment)

[...]
UVC> This leads to an awkward case called a cross-merge which tends to
UVC> confuse history-aware merging tools.

First, please remember that history-unaware merging tools, such as CVS
merge operation (unless you manually specified points in history) have
trouble with much simpler case of repeated merging into the same
branch.

Second, I think that currently DVCS can deal with criss-cross merges
correctly; for example git with its recursive merge strategy, or so
called MarkMerge from revctrl.org [TODO: probably needs survey how
other modern merging DVCS, such as Mercurial, Bazaar or Monotone, deal
with criss-cross merges].

......................................................................

UVC> == Container identity ==
UVC> 
UVC> In a VCS with container identity, files and directories have a
UVC> stable internal identity, initialized when the file is added to
UVC> the repository. This identity follows them through renames and
UVC> moves. This means that filenames and directories are versioned,
UVC> so that it is possible (for example) for the VCS to notice while
UVC> doing a merge between branches that two files with different
UVC> names are descendants of the same file and do a smarter merge of
UVC> their contents.

This whole subsection confuses in my opinion the goal (rename-aware
merge) with means (container identity).  It should concentrate on
intelligent merging after renames or moves, not on the possible ways
to do this.  It should list what is expected of modern VCS to do,
_then_ enumerate possible ways to do this.

But the most important thing is that "container identity" is a wrong
idea to have: wholesame rename (or copy) of a file is just special
case of more generic code movement and copying.

UVC> 
UVC> Container identity can be implemented by giving each file in the
UVC> repository a 'true name' analogous to a Unix inode,
UVC> Alternatively, it can be implemented implicitly by keeping all
UVC> records of renames in history and chasing through them each time
UVC> the VCS needs to check what file X was called in revision Y.

If I understand correctly 'file-ids' is the way original Arch (and its
descendant) did this, and how Bazaar deal with file and directory
renames, while 'tracking renames' is what Mercurial doea (a bit
incompletly).

But there is _another_ way to have rename-aware merge, and it is how
Git does it.  Git uses heuristic similarity based _rename detection_
to find how to do a merge in presence of renames.  This works quite
well _in practice_ (but it makes it harder to _test_ this solution).


Those three ways of dealing with renames have the following advantages
and disadvantages:

1. Need to use VCS to do file and directory renames and copies.

   Both 'file-ids' and 'rename tracking' have this limitation.

   This means that you cannot use your favorite filemanager, or IDE
   if it doesn't have support for your VCS, or patches to move and
   copy files.  This might be migitated a bit by doing rename
   detection at commit time (Mercurial has this ability wia
   hg-addremove, but it is not automatic), but that means freezing
   current algorithm results; with rename detection you can always
   take advantage of improved rename detection.

2. Ability to improve and correct errors in rename information.

   Both 'file-ids' and 'rename tracking' make it hard to correct
   errors in rename info, for example if you incorrectly marked file
   as copy or rename, or forgot to mark it as copy or rename.  If
   'file-ids' info is stored separately from history, it is less of an
   issue, but I don't see how you can correct errorneous rename
   information in 'rename tracking' solution short of rewriting
   history.

   In the case of 'rename detection' solution Git uses it is
   non-issue, as no rename information is stored.

3. Dealing with independently (in separate branches) added files.
   (this issue can be found in "Test suite" section of TODO).

   Most 'file-ids' solution have the problem if you add the same file
   independently on different branches (e.g. adding file via patch).
   First, one of histories must vanish; second, you have to repeat
   resolution if file-id conflict for every repeated merge.

   From TODO 'rename tracking' solution used in Mercurial doesn't have
   this problem, and of course Git's 'rename detection' doesn't have
   it either.

   Note that there are different versions of this issue: same name
   and same contents, different name same contents (rename without
   ancestor), and same name different contents.  The last case is of
   issue with automatic file-ids if they are dependent on file name;
   first case is of issue with automatic file-ids if they depend on
   branch/comitter/time, i.e. if file-ids differ on different
   branches.  Note: same contents here migh mean _almost_ the same
   contents.

4. Creating new files in renamed directories.
   
   Usually called support for directory renames; the problem is if one
   side (on one branch) renames some directory, and other side (other
   branch) creates new files in the old-name directory.

   For 'file-ids' solution this means that there have to be 'file-ids'
   ('inodes') also for directories; Bazaar has this feature.  For
   'rename tracking' solution this means that rename information for
   directories has to be stored somewhere; from what I understand
   Mercurial with its filename-hashed storage and per-file stored
   rename information doesn't have this feature.  For both 'file-id'
   and 'rename tracking' ('rename info') solutions this I think
   usually mean that you have to do directory renames using VCS
   tools.

   Whle on first glance it might seem that 'rename detection' solution
   (like the one used in Git) cannot deal with this problem it is not
   true.  VCS employing similarity based rename detection can detect
   wholesame directory rename based on pattern of file renames, and
   can put new file in new-name of directory.  Moreover it should be
   able to deal quite sanely with more complicated cases like
   splitting or merging of directories.  _However_ Git currently does
   not support this case (but see the note below), although there were
   some preliminary patches adding 'wholesame directory rename
   detection', so it is not purely theoretical.

   Note: usually you cannot simply move file to new directory without
   any other changes, so automatic creating new file (from the point
   of view of branch we merge into) in new-name directory instead of
   old-name directory might be not a good idea without stopping for
   manual merge conflict resolution, as it would result in semantic
   conflict.
   
5. Misdetection of file renames, and remembering manual corrections.
   (this problem concerns only 'rename detection' solution).

   Of course 'rename detection' algorithm is not perfect.  It can find
   rename when there isn't any if many files consist mainly from
   identical boilerplate (e.g. copyright, license, etc.).  It can fail
   to detect rename if files differ too much (usually then files
   cannot be merged automatically anyway then), or if files are too
   small (like usually in simple test cases used).  In the presence of
   multiple file renames and copies it can assign move or copy source
   to the wrong file.

   Closely related to this issue is a problem of remembering manual
   corrections to rename detection algorithm, and manual hints (like
   inn 'rename tracking' solution).  Both were discussed on git
   mailing list, the former under the name of having git-rerere2,
   remembering (and reusing) of recorded resolutions of tree-level
   conflicted merge, but there were (if I remember correctly) no
   conclusion and no patches.
   
6. Performance bottlenecks in managing renames during merge

   I don't know if it is a problem for 'file-id' solution (Bazaar), or
   for 'rename tracking' solution (Mercurial), but with 'rename
   detection' (Git) if there were a lot of reorganization of directory
   hierarchy between merge points then merge can take a lot of time.


UVC> 
UVC> Absence of container identity has the symptom that file
UVC> rename/move operations have to be modeled as a file add followed
UVC> by a delete, with the deleted file's history magically copied
UVC> during the add. 

I don't know if this paragraph was meant to be about another issue
with renames in VCS, namely dealing with renames and copise during
history browsing (which includes both log of changes, and tracking
line-wise file history aka. annotate/blame/praise).


1. Rename-aware changelog (commit logs).

1.1. Showing renames in "<scm> log", i.e. in whole project history.

     The only complication with rename detection here is choosing a
     level of rename and copy detection, as it might be CPU
     intensive.  In Git those are 'detect renames', 'detect copies as
     well as renames' and 'find copies harder'. That can, of course,
     be configured.

1.2. Following renames in "<scm> log <filename>", i.e. in single file
     history.

     Currently Git does not support it very well.  There is '--follow'
     option for git-log, but it is more of a hack to have something
     similar to what for example Subversion provides, than a full
     solution.  It works for simple histories, and might fail for more
     complicated ones; it is not however fundamental limitation.  On
     can always use "git log -- <old name> <new name>"...

     On the other hand single file history should be for developers
     second-class citizen in VCS supporting changesets; full history
     is _more_ than sum of single-file histories.


2. Rename-aware line-wise file history (which means annotating file
   with history of each line, something like "cvs annotate").

   Note that line-wise file history cannot deal with _deletions_;
   it is a known limitation of this tool.

2.1. Following wholesame file renames and copying.

     The issue is not stopping at file rename when tracking where
     given line came from... and of course representing this
     information in blame/annotate output.  git-blame supports this,
     and I think other VCS (Bazaar, Mercurial) also does.
     [TODO: check this]

2.2. Following code movement and copying.

     You can request that git-blame detect moving lines in the file
     (e.g. moving around code), and detect lines copied from other
     files (code moved across files).  I think it is (together with
     ability to ignore changes in whitespace in blame/annotate)
     currently (?) feature unique to Git; it also shows that idea of
     "container identities" is limited and narrow-minded, and that one
     should think of file renames as of special case of code
     movement. 
     [TODO: perhaps sreenshot of "git gui blame" or equivalent?]
     [TODO: some stats about file renames and other code movement]

UVC> 
UVC> Usually VCSes that lack container identity also create parent
UVC> directories on the fly whenever a file is added or checked out, and
UVC> you cannot actually have an empty directory in a repository.
 
In my opinion this is an fundamentally unrelated issue.  The question
if directories are created and deleted on demand is behavioral issue;
note that _not_ having directories deleted on the fly result in higher
probability of file/directory conflict.

Git is a bit peculiar in this case: empty directories _can_ be
represented in repository, currently cannot be represented in (flat)
staging area aka. index although it shouldn't be too hard to add, and
are removed on the fly which again shouldn't be too hard to change.

Note that you can track empty directories in Git (even if VCS adds
them and removes them on the fly) by trick of having for example empty
'.gitignore' file in it.


UVC> == Snapshots vs. changesets ==
UVC> 
UVC> There are two ways to model the history of a line of
UVC> development. One is as a series of snapshots of an evolving tree
UVC> of files. The other is as a series of changesets transforming
UVC> that tree from a root state (usually empty) to a tip state.

Git is snapshot-based (although packed format uses [binary] delta
compression).  Mercurial is changeset-based.  Bazaar uses different
representation altogether, I think[1] (used to use weave); wiki
says that it is snapshot-oriented, but it has file-ids.

[1] http://bazaar-vcs.org/BazaarFormats is a bit lacking in details

[...]
UVC> Changeset-based systems have some further distinctions based on
UVC> what kinds of data a changeset carries. At minimum, a changeset
UVC> is a group of deltas to individual files, but there are
UVC> variations in what kind of file-tree operations are represented
UVC> in changesets.  

I think most famous _example_ here is Darcs, with _idea_ of other
operations than simple text delta, like "rename this variable to that
name" example in documentation, but I don't know if it was actually
went beyound hand-waving.

Note that patch commutation algebra of Darcs (most pure-changeset VCS
there, in my opinion) might look like a neat idea, but please remember
than Darcs had (and perhaps has still) exponential bad performance of
merging in some cases.

UVC> 
UVC> Changesets which include an explicit representation of
UVC> file/directory moves and renames make it easy to implement
UVC> container identity. (Container identity could also be implemented
UVC> as a separate sequence of transaction records running parallel to
UVC> a snapshot-sequence representation, but I know of no VCS that
UVC> actually does this.) 

[TODO: check how Bazaar actually does this, as it is example of VCS
with 'file-ids', also for directories; check where Mercurial stores
'rename tracking' information].

[...]
UVC> Snapshot and changesets are not perfectly dual
UVC> representations. It took a long time for VCS designers to notice
UVC> this; the broken symmetry was at the core of a well-known
UVC> argument between the designers of Arch and Subversion in 2003,
UVC> and did not begin to become widely understood until after Martin
UVC> Pool's 2004 essay "Integrals and Derivatives"[2]. Pool, a
UVC> co-author of bzr, correctly noted that attempts to stick with the
UVC> more intuitive sequence-of-snapshots representation have several
UVC> troubling consequences, including making container identity and
UVC> past merges between branches more difficult to track. 
UVC> 
UVC> [2] http://sourcefrog.net/weblog/software/vc/derivatives.html

Below there is excerpt from OLD "Integrals and Derivatives" essay
(I hope I have choosen relevant part of this essay).

ID> Working in terms of changesets, or at least having the option to
ID> do so allows more powerful operation. 
ID>
ID> For example, consider repeated merges among a related set of
ID> trees. Arch and Darcs [which work primarily in the changeset
ID> domain] handle this well, because they can easily remember which
ID> changesets have already come across. Subversion and CVS tend to
ID> handle it poorly, because merely tracking which version from the
ID> other tree has merged doesn't really capture the right
ID> information.

This is, as we now know, _wrong_.  Subversion and CVS handle this
poorly not because they are snapshot based (CVS most certainly is not:
it is file-level delta based), but because they do not store merge
information (which revisions were merged to form a merge commit,
i.e. all parents of a merge commit): they lack merge tracking.
Therefore it is not possible to find common ancestors (merge bases),
because there is no enough information.  _Not_ because being
snapshot-based.

Additionally it is now I think universally acknowledged that three-way
merge (with a bit extra to deal with possibly multiple merge-bases,
e.g. in presence of criss-cross merge) is superior merge algorithm; it
is certainly superior to "reapply patches skipping already present"
algorithm that quoted example seems to imply that Arch and Darcs use
(which is available in modern DVCS as well, either as some patch
management / patch queue extensions, or as git-rebase, Mercurial's
transplant extension, or Bazaar graft extension).


[...]

UVC> = What, if anything, have we learned from history? =
UVC> 
UVC> There's a folk saying that "It's not what you don't know that
UVC> hurts you, it's what you think you know that ain't so." In
UVC> examining the pattern of development of VCSes, it seems to me
UVC> that the this sub-field of computer science has been less
UVC> hampered than most by difficulties in finding appropriate
UVC> techniques, but more hampered than most by wrong assumptions that
UVC> hung on far longer than they should have. 
UVC> 
UVC> First wrong assumption: Conflict resolution by merging is
UVC> intractably difficult, so we'll have to settle for locking. It
UVC> took at least fifteen and arguably twenty years for VCS designers
UVC> to get shut of that one. But it's historical now. 

I'm not sure if it has place here, i.e. if it was wrong assumption or
just lack of thought, but I would emphasize that commit-before-merge 
is much, much better than merge-before-commit (or update-before-commit, 
as it is _implicit_ merge that might need to be performed) workflow.

One of more important tasks of VCS is to not lose your changes; the
merge-before-commit does not fill this tack completely, in my opinion,
especially nowadays with networked large-group collarboration.

?merge strategies

UVC> 
UVC> Second wrong assumption: Change history representation as a
UVC> snapshot sequence is perfectly dual to the representation as
UVC> change/add/delete/rename sequences.. This folk theorem is well
UVC> expressed in the 2004 essay "On Arch and Subversion"[3]. It is
UVC> appealing, widely held, and dead wrong.
UVC> 
UVC> File renames break the apparent symmetry. The failure of
UVC> snapshot-based models to correctly address this has caused
UVC> endless design failures, subtle bugs, and user misery. 

It is not true.  Example of snapshot-based Git, which with its rename
detection deals very well in practice with file renames contradict
this theory.  Bazaar which is supposedly snapshot-based, yet support
"container identities" ('file-ids') contradict this further.

The symmetry might be broken _only_ if there are other operators in
changesets than simple delta.  But one has to remember that if
representation is not equivalent to snapshot-based in the sense that
you can do a (3-way) merge based on endpoints (branches to be merged
and common ancestors aka. merge bases) _only_, and one has to take
_whole_ history into account when merging, then there is high
probability of cases where merge performance suffers badly.  Please do
not say that performance doesn't matter, because it does; if operation
takes minutes (or more) rather than seconds, then this would affect
workflow used, as people try to avoid unpleasant operations...

UVC> 
UVC> Practically speaking, failure to address this broken symmetry
UVC> goes a long way towards explaining why CVS became such a
UVC> disaster. But the damage didn't end there, which is why I'm
UVC> courting controversy by pointing out that it underlies a debate
UVC> about third-generation designs that is still live today. Should
UVC> VCSes be purely content-addressable filesystems (the Mercurial
UVC> and git approach) or should they have container identity (as in
UVC> Arch, monotone, and bzr)? 
UVC> 
UVC> That debate is not over, but at least VCS designers are grappling
UVC> with it now. 

CVS was disaster no because of (supposedly) broken symmetry between
snapshots (snapshot-based operations) and changesets; it was disaster
because its per-file versioning roots were very visible in: non-atomic
commits, no support for changesets, heavyweight (bad performance)
branching and tagging, complete lack of support for renaming files.

I agree that the issue of content-addressed filesystem versus
container identities (file-ids) is importnat one, but I would say that
neither one won over the other...

UVC> 
UVC> I have a guess about the third wrong assumption. I think it goes
UVC> something like this: The correct choice of abstractions,
UVC> operations, and containers in a VCS is the one that makes the
UVC> cleverest sorts of data-shuffling possible. I suspect that, as
UVC> our algorithms get better, we're going to find that the best
UVC> choices are not the most theoretically clever ones but rather the
UVC> ones that are easiest for human beings to intuitively model.

Here I think Git model wins hands down: DAG (Direct Acyclic Graph) of
commits (Monotone had it first), clear relation between objects:
commit object contain metadata (like authorship and commit message),
link to zero (root / initial commit), one (usual case), or two or more
(merges) parent commits, and link to snapshot of a state of project at
given version...  Having branches and tags (and remote-tracking
branches) to exist outside DAG of commits, in a separate namespaces;
not that disaster of conventions for imitation of branches and tags in
Subversion.  Having current branch to be just pointer to one of
branches.

Having delta compression "under the hood" in the packfiles allow to
combine efficiency of deltas for repository size and network transfer,
while retaining very clear model of snapshot-based VCS.

UVC> 
UVC> This is why, even though I find constructions like today's
UVC> elaborate merge theory[4] fascinating to think about. I'm not
UVC> sure it is actually going anywhere useful. Naive merge algorithms
UVC> with poor behavior at edge cases may actually be preferable to
UVC> more sophisticated ones that handle edge cases well but that
UVC> humans have trouble anticipating effectively.

Nowadays even Bram Cohen of Codeville merge agrees[citation needed]
that 3-way merge, which works in most cases but if fails is easy to
understood, is better than advanced merge strategies which can merge
automatically a few more cases, but if fail it is difficult to resolve
conflicts; note that fail include wrongly resolved merge (merge
strategy gives no conflicts, but merge resolution is wrong).

UVC> 
UVC> An even more interesting question is this: what are the fourth,
UVC> and nth wrong assumptions --- the ones we haven't noticed we're
UVC> making yet? 
UVC> 
UVC> [3] http://www.reverberate.org/computers/ArchAndSVN.html
UVC> [4] http://revctrl.org/CategoryMergeAlgorithm

Well, Linus probably would say that concentrating on special case of
file and directory renames instead of more generic code movement is a
wrong idea.

But what do YOU think?

-- 
Jakub Narebski
Poland
