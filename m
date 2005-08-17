From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: First stab at glossary
Date: Wed, 17 Aug 2005 15:13:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508171341380.23242@iabervon.org>
References: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-1264248622-1124305980=:23242"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 17 21:11:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5TID-00085q-2t
	for gcvg-git@gmane.org; Wed, 17 Aug 2005 21:09:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751209AbVHQTJi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 17 Aug 2005 15:09:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751210AbVHQTJi
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Aug 2005 15:09:38 -0400
Received: from iabervon.org ([66.92.72.58]:22020 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751209AbVHQTJh (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 17 Aug 2005 15:09:37 -0400
Received: (qmail 2149 invoked by uid 1000); 17 Aug 2005 15:13:00 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 17 Aug 2005 15:13:00 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0508171655250.13502@wgmdd8.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-1264248622-1124305980=:23242
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 17 Aug 2005, Johannes Schindelin wrote:

> Hi,
>
> long, long time. Here=B4s my first stab at the glossary, attached the
> alphabetically sorted, asciidoc marked up txt file (Comments?
> Suggestions? Pizzas?):
>
> object::
> =09The unit of storage in GIT. It is uniquely identified by
> =09the SHA1 of its contents. Consequently, an object can not
> =09be changed.
>
> SHA1::
> =09A 20-byte sequence (or 41-byte file containing the hex
> =09representation and a newline). It is calculated from the
> =09contents of an object by the Secure Hash Algorithm 1.

It's also often 40-character string (with whatever termination) in places
like commit objects, tag objects, command-line arguments, listings, and so
forth.

> object database::
> =09Stores a set of "objects", and an individial object is identified
> =09by its SHA1 (its ref). The objects are either stored as single
> =09files, or live inside of packs.
>
> object name::
> =09Synonym for SHA1.

Have we killed the use of the third term "hash" for this? I'd say that
"object name" is the standard term, and "SHA1" is a nickname, if only
because "object name" is more descriptive of the particular use of the
term.

> blob object::
> =09Untyped object, i.e. the contents of a file.

This "i.e." should be "e.g.", since symlink targets are also stored as
blobs, and any other bulk data stored by itself would be. (IIRC, Junio has
a tagged blob to hold his public key, for example)

> tree object::
> =09An object containing a list of blob and/or tree objects.
> =09(A tree usually corresponds to a directory without
> =09subdirectories).
>
> tree::
> =09Either a working tree, or a tree object together with the
> =09dependent blob and tree objects (i.e. a stored representation
> =09of a working tree).
>
> cache::
> =09A collection of files whose contents are stored as objects.
> =09The cache is a stored version of your working tree. Well, can
> =09also contain a second, and even a third version of a working
> =09tree, which are used when merging.
>
> cache entry::
> =09The information regarding a particular file, stored in the index.
> =09A cache entry can be unmerged, if a merge was started, but not
> =09yet finished (i.e. if the cache contains multiple versions of
> =09that file).
>
> index::
> =09Contains information about the cache contents, in particular
> =09timestamps and mode flags ("stat information") for the files
> =09stored in the cache. An unmerged index is an index which contains
> =09unmerged cache entries.

I think we might want to entirely kill the "cache" term, and talk only
about the "index" and "index entries". Of course, a bunch of the code will
have to be renamed to make this completely successful, but we could change
the glossary and documentation, and mention "cache" and "cache entry" as
old names for "index" and "index entry" respectively.

> working tree::
> =09The set of files and directories currently being worked on.
> =09Think "ls -laR"

This is where the data is actually in the filesystem, and you can edit and
compile it (as opposed to a tree object or the index, which semantically
have the same contents, but aren't presented in the filesystem that way).

> directory::
> =09The list you get with "ls" :-)
>
> checkout::
> =09The action of updating the working tree to a revision which was
> =09stored in the object database.

Move after "revision"?

> revision::
> =09A particular state of files and directories which was stored in
> =09the object database. It is referenced by a commit object.
>
> commit::
> =09The action of storing the current state of the cache in the
> =09object database. The result is a revision.
>
> commit object::
> =09An object which contains the information about a particular
> =09revision, such as parents, committer, author, date and the
> =09tree object which corresponds to the top directory of the
> =09stored revision.

Move "parent" around here.

> changeset::
> =09BitKeeper/cvsps speak for "commit". Since git does not store
> =09changes, but states, it really does not make sense to use
> =09the term "changesets" with git.
>
> ent::
> =09Favorite synonym to "tree-ish" by some total geeks.

Move after "tree-ish".

> head::
> =09The top of a branch. It contains a ref to the corresponding
> =09commit object.
>
> branch::
> =09A non-cyclical graph of revisions, i.e. the complete history of
> =09a particular revision, which does not (yet) have children, which
> =09is called the branch head. The branch heads are stored in
> =09$GIT_DIR/refs/heads/.

A branch head might have children, if they're in another branch. (E.g., I
pull mainline, make a new branch based on it, and commit a change; the
head of mainline is still a branch head, even though it's the parent of my
new commit, because my new commit isn't in mainline.)

> ref::
> =09A 40-byte hex representation of a SHA1 pointing to a particular
> =09object. These are stored in $GIT_DIR/refs/.
>
> head ref::
> =09A ref pointing to a head. Often, this is abbreviated to "head".
> =09Head refs are stored in $GIT_DIR/refs/heads/.
>
> tree-ish::
> =09A ref pointing to either a commit object, a tree object, or a
> =09tag object pointing to a commit or tree object.
>
> tag object::
> =09An object containing a ref pointing to another object. It can
> =09contain a (PGP) signature, in which case it is called "signed
> =09tag object".
>
> tag::
> =09A ref pointing to a tag or commit object. In contrast to a head,
> =09a tag is not changed by a commit. Tags (not tag objects) are
> =09stored in $GIT_DIR/refs/tags/. A git tag has nothing to do with
> =09a Lisp tag (which is called object type in git's context).

As above, only the head for the branch being committed to is changed by a
commit. A tag, not being the head of a branch, is therefore never changed
by a commit.

> merge::
> =09To merge branches means to try to accumulate the changes since a
> =09common ancestor and apply them to the first branch. An automatic
> =09merge uses heuristics to accomplish that. Evidently, an automatic
> =09merge can fail.
>
> resolve::
> =09The action of fixing up manually what a failed automatic merge
> =09left behind.

"Resolve" is also used for the automatic case (e.g., in
"git-resolve-script", which goes from having two commits and a message to
having a new commit). I'm not sure what the distinction is supposed to be.

=09-Daniel
*This .sig left intentionally blank*
--1547844168-1264248622-1124305980=:23242--
