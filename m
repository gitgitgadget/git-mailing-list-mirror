From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Terminology
Date: Fri, 5 Aug 2005 16:57:33 +0200 (CEST)
Message-ID: <Pine.LNX.4.63.0508051655480.8418@wgmdd8.biozentrum.uni-wuerzburg.de>
References: <Pine.LNX.4.58.0507311541340.29235@wgmdd8.biozentrum.uni-wuerzburg.de>
 <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 05 17:01:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E13h2-0006Vv-Bt
	for gcvg-git@gmane.org; Fri, 05 Aug 2005 17:01:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263060AbVHEPAL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Aug 2005 11:00:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263052AbVHEO6L
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Aug 2005 10:58:11 -0400
Received: from wrzx28.rz.uni-wuerzburg.de ([132.187.3.28]:22718 "EHLO
	wrzx28.rz.uni-wuerzburg.de") by vger.kernel.org with ESMTP
	id S263050AbVHEO5e (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Aug 2005 10:57:34 -0400
Received: from wrzx30.rz.uni-wuerzburg.de (wrzx30.rz.uni-wuerzburg.de [132.187.1.30])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id B0AC7E240A; Fri,  5 Aug 2005 16:57:33 +0200 (CEST)
Received: from virusscan (localhost [127.0.0.1])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 900A89C702; Fri,  5 Aug 2005 16:57:33 +0200 (CEST)
Received: from wrzx28.rz.uni-wuerzburg.de (wrzx28.rz.uni-wuerzburg.de [132.187.3.28])
	by wrzx30.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 6D9F096F2A; Fri,  5 Aug 2005 16:57:33 +0200 (CEST)
Received: from wgmdd8.biozentrum.uni-wuerzburg.de (wrzx68.rz.uni-wuerzburg.de [132.187.3.68])
	by wrzx28.rz.uni-wuerzburg.de (Postfix) with ESMTP
	id 3A18EE240A; Fri,  5 Aug 2005 16:57:33 +0200 (CEST)
X-X-Sender: gene099@wgmdd8.biozentrum.uni-wuerzburg.de
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vhdeaj05n.fsf@assigned-by-dhcp.cox.net>
X-Virus-Scanned: by amavisd-new (Rechenzentrum Universitaet Wuerzburg)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hi,

I am finally finished with my preliminary survey: I took what you sent as 
a strawman, and inserted what I found (I tried to say only something about 
ambiguous naming):

  - The unit of storage in GIT is called "object"; no other word
    is used and the word "object" is used only for this purpose
    so this one is OK.

  - A 20-byte SHA1 to uniquely identify "objects"; README and
    early Linus messages call this "object name" so does
    tutorial.  Many places say "object SHA1" or just "SHA1".

"Object" is short for "immutable object". git-cat-file.txt says
"repository object".

  - An "object database" stores a set of "objects", and an
    individial object can be retrieved by giving it its object
    name.

Tutorial calls it an "object store". git-fsck-cache.txt names it
"database" at first, but then also uses "object pool".

  - Storing a regular file or a symlink in the object database
    results in a "blob object" created.  You cannot directly
    store filesystem directory, but a collection of blob objects
    and other tree objects can be recorded as a "tree object"
    which corresponds to this notion.

  - $GIT_INDEX_FILE is "index file", which is a collection of
    "cache entries".  The former is sometimes called "cache
    file", the latter just "cache".

Tutorial says "cache" aka "index". Though technically, a cache
is the index file _plus_ the related objects in the object database.
git-update-cache.txt even makes the difference between the "index"
and the "directory cache".

  - the directory which corresponds to the top of the hierarchy
    described in the index file; I've seen words like "working
    tree", "working directory", "work tree" used.

The tutorial initially says "working tree", but then "working
directory". Usually, a directory does not include its
subdirectories, though. git-apply-patch-script.txt, git-apply.txt,
git-hash-object.txt, git-read-tree.txt
use "work tree". git-checkout-cache.txt, git-commit-tree.txt,
git-diff-cache.txt, git-ls-tree.txt, git-update-cache.txt contain
"working directory". git-diff-files.txt talks about a "working tree".

  - When the stat information a cache entry records matches what
    is in the work tree, the entry is called "clean" or
    "up-to-date".  The opposite is "dirty" or "not up-to-date".

  - An index file can be in "merged" or "unmerged" state.  The
    former is when it does not have anything but stage 0 entries,
    the latter otherwise.

That seems to be unambiguous (sometimes it's called "index",
sometimes "index file"; I don't think that matters).

  - An merged index file can be written as a "tree object", which
    is technically a set of interconnected tree objects but we
    equate it with the toplevel tree object with this set.

  - A "tree object" can be recorded as a part of a "commit
    object".  The tree object is said to be "associated with" the
    commit object.

In diffcore.txt, "changeset" is used in place of "commit".

  - A "tag object" can be recorded as a pointer to another object
    of any type. The act of following the pointer a tag object
    holds (this can go recursively) until we get to a non-tag
    object is sometimes called "resolving the tag".

  - The following objects are collectively called "tree-ish": a
    tree object, a commit object, a tag object that resolves to
    either a commit or a tree object, and can be given to
    commands that expect to work on a tree object.

We could call this category an "ent".

  - The files under $GIT_DIR/refs record object names, and are
    called "refs".  What is under refs/heads/ are called "heads",
    refs/tags/ "tags".  Typically, they are either object names
    of commit objects or tag objects that resolve to commit
    objects, but a tag can point at any object.

The tutorial never calls them "refs", but instead "references".

  - A "head" is always an object name of a commit, and marks the
    latest commit in one line of development.  A line of
    development is often called a "branch".  We sometimes use the
    word "branch head" to stress the fact that we are talking
    about a single commit that is the latest one in a "branch".

In the tutorial, the latter is used in reverse: it talks about a
"HEAD development branch" and a "HEAD branch".

I find it a little bit troublesome that $GIT_DIR/branches does not
really refer to a branch, but rather to a (possibly remote) repository.

  - Combining the states from more than one lines of developments
    is called "merging" and typically done between two branch
    heads.  This is called "resolving" in the tutorial and there
    is git-resolve-script command for it.

  - A set of "refs" with the set of objects reachable from them
    constitute a "repository".  Although currently there is no
    provision for a repository to say that its objects are stored
    in this and that object database, multiple repositories can
    share the same object database, and there is not a conceptual
    limit that a repository must retrive its objects from a
    single object database.

This is referred to as "git archive" in the tutorial at first,
and later as "repository". However, in "Copying archives", a
very confusing explanation tells us that a "repository" normally
is a "working tree", where I would rather say that the repository
lives inside a hidden subdirectory of the working tree.

git-fsck-cache.txt talks about an "archive", too. However, it then
says "valid tree", when sureley a repository is meant.

Everywhere else, it is called "repository".

  - The act of finding out the object names recorded in "refs" a
    different repository records, optionally updating a local
    "refs" with their values, and retrieving the objects
    reachable from them is called "fetching".  Fetching immediately
    followed by merging is called "pulling".

In that sense, git-http-pull would be more appropriately named
git-http-fetch, and analogous git-ssh-pull.

Also, git-pull-script.txt says "Pull and merge", contradicting this
definition.

  - The act of updating "refs" in a different repository with new
    value and populating the object database(s) associated with
    the repository is called "pushing".

  - Currently refs/heads records branch heads of both locally
    created branches and branches fetched from other
    repositories.

  - Currently, fetching always happen against a single branch
    head on a remote repository, and (a remote repository, name
    of the branch) is stored in $GIT_DIR/branches/ as a
    short-hand mechanism.  A file in this directory identifies
    a remote repository by its URL, and the branch to fetch/pull
    from is identified with the URL fragment notation, absense of
    which makes it default to "master".

  - a "pack" usually consists of two files: a file containing objects
    in a compressed format, and an index to the first file. If the
    pack is uncompressed at once (e.g. when git-clone is called), the
    index is not necessary.

git-pack-objects calls this a "packed archive" first, but then reverts
to "pack". git-show-index.txt and git-verify-pack.txt call the .pack file
"packed GIT archive", and the index "idx file". git-unpack-objects.txt
calls the .pack file "pack archive".

I'd also add a short explanation of the following unambiguous terms:

"plumbing", also referred to as "core": the basic set of programs and
scripts usable to half-gods like Linus.

"porcelain", also referred to as "SCM": a thin layer over the plumbing
making GIT usage nice to regular people.

"type": one of the identifiers "commit","tree","tag" and "blob" describing
the type of an object.

Ciao,
Dscho
