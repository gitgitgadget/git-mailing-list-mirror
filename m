From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 19:38:03 +0200
Message-ID: <85tzrxslms.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
	<vpq4pk1vf7q.fsf@bauges.imag.fr>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.0707181004330.?= =?ISO-8859-1?Q?=04=0427?=
	=?ISO-8859-1?Q?353@woody.linux-?= =?ISO-8859-1?Q?foundation.org>?=
	<85644hxujp.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<851wf2bcqy.fsf@lola.goethe.zz>
	 =?ISO-8859-1?Q?=20<alpine.LFD.0.99?= =?ISO-8859-1?Q?9.07072=0402135450?= =?ISO-8859-1?Q?.27249?=
	=?ISO-8859-1?Q?@woody.linux-fou?= =?ISO-8859-1?Q?ndation.org>?=
	<alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
	<85odi69vgt.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Jul 21 19:38:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICIuQ-0006BG-CH
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 19:38:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751813AbXGURiL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 13:38:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXGURiK
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 13:38:10 -0400
Received: from mail-in-05.arcor-online.net ([151.189.21.45]:60872 "EHLO
	mail-in-05.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751385AbXGURiI (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Jul 2007 13:38:08 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-05.arcor-online.net (Postfix) with ESMTP id 1653F183B54;
	Sat, 21 Jul 2007 19:38:07 +0200 (CEST)
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net [151.189.21.49])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 00F59100C3;
	Sat, 21 Jul 2007 19:38:07 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-010-231.pools.arcor-ip.net [84.61.10.231])
	by mail-in-09.arcor-online.net (Postfix) with ESMTP id AABB03425E5;
	Sat, 21 Jul 2007 19:38:06 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id B92151CE0427; Sat, 21 Jul 2007 19:38:03 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> (Linus Torvalds's message of "Sat\, 21 Jul 2007 08\:53\:39 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3715/Sat Jul 21 14:39:12 2007 on mail-in-09.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53175>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 21 Jul 2007, David Kastrup wrote:
>
>> Linus Torvalds <torvalds@linux-foundation.org> writes:
>> 
>> > Of course, it seldom matters, but basically, you should test a directory 
>> > structure that has the files
>> >
>> > 	dir.c
>> > 	dir/test
>> >
>> > in it, and the "dir" directory should always sort _after_ "dir.c".
>> >
>> > And yes, having the index entry with a '/' at the end would handle
>> > that automatically.
>> 
>> You completely lost me here.  I guess I'll be able to pick this up
>> only after investing considerable more time into the data structures.

[Basic explanation about git sort order and trees sorting as tree/ in
order to be in the right sort order for a prefix]

Ok, I could not have figured this out on my own.  Are there any design
documents or does one just have to pester the list?

> So the basic issue is that not only does git obviously think that only 
> content matters, but it describes it with a single SHA1. 
>
> That's not an issue at all for a single file, but if you want to describe 
> *multiple* files with a single SHA1 (which git obviously very much wants 
> to do), the way you generate the SHA1 matters a lot.
>
> In particular, the order.
>
> So git is very very strict about the ordering of tree structures. A tree 
> structure is not just a random list of
>
> 	<ASCII mode> + <space> + <filename> + <NUL> + <SHA1>

Ok.

> So git filenames are very much a "stream of bytes", not anything
> else. And they need to sort 100% reliably, always the same way, and
> never with any localized meaning.

There is some utf-8/Unicode trouble to be expected in connection with
that eventually: some, but not all operating and/or file systems
canonicalize file names, replacing accented letters by a combining
accent and the letter.  But that's beside the point.

> And, partly because it seemed most natural, and partly for
> historical reasons, the way git sorts filenames is by sorting by
> *pathname*. So if you have three files named
>
> 	a.c
> 	a/c
> 	abc
>
> then they sort in that exact order, and no other! They sort as a
> "memcmp" in the full pathname, and that's really nice when you see
> whole collections of files, and you know the list is globally
> sorted.

It is amusing that my description of git having no external concept of
directories except as an expedience for representing slashes in
filenames was much closer to the mark that I would have expected.

> So that "global pathname sorting" has nice properties, and it seems 
> "obvious", but it means that because git actually *encodes* those three 
> files hierarchically as two different trees (because there's a 
> subdirectory there), the tree objects themselves sort a bit oddly. The 
> tree obejcts themselves will look like
>
>  top-level tree:
> 	100644 a.c -> blob1
> 	040000 a   -> tree2
> 	100644 abc -> blob3
>
>  sub-tree:
> 	100644 c    -> blob2
>
> and notice how the *tree* is not sorted alphabetically at all. It has a 
> subtly different sort, where the entry "a" sorts *after* the entry "a.c", 
> because we know that it's a tree entry, and thus will (in the *global* 
> order) sort as if it had a "/" at the end!
>
> Traditionally, when we have the index, the index sorting has been very 
> simple: you just sort the names as memcmp() would sort them. But note how 
> that changes, if "a" is an empty directory. Now the index needs to sort as
>
> 	file a.c
> 	dir  a
> 	file abc
>
> because when we create the tree entry, it needs to be sorted the same way 
> all tree entries are always sorted - as if "a" had a slash at the end!

Here is the layout as I would scheme it:

tree1:
     0?0000 .   -> dir1
     100644 a.c -> blob1
     040000 a   -> tree2
     100644 abc -> blob3

sub-tree:
     0?0000 .    -> dir2
     100644 c    -> blob2

Remember that a tree evaporates when it is empty, and if we don't want
to mess with that (which appears like a good idea to me), the "don't
delete this" indication belongs in the subtree where its natural name
is ".".  Since the dir entries are _leaves_ in the tree, there is no
necessity for sorting them specially.  They will usually appear first,
but people to all sorts of things, so filenames starting with "!"
might still come before them.

So the sorted flat file list for the above would be
.    [dir]
a.c  [file]
a/   [tree]
a/.  [dir]
a/c  [file]
abc  [file]

Note that a tree is basically just a string arrangement tool which
gets only incidentally mapped to directories when checking out.

So I am quite unhappy that 040000 is already taken by it.  I can't
even say, "ok, let . look like an empty tree" because there should not
be something like an empty tree!  I find the correlation empty->gone
very important.

> [ Yeah, yeah, we could make a special case and just say "the empty
> tree sorts differently", but that actually results in huge problems
> when doing a "diff" between two trees: our diff machinery very much
> depends on the fact that the index and the trees always sort the
> same way, and if we sorted the "a" entry (when it is an empty
> directory) differently from the "a" entry (when it has entries in
> it), that would just be insane and cause no end of trouble for
> comparing two trees - one with an empty directory and one with
> content added to that directory.

It appears to me like our ideas are still out of sync: a directory
under my scheme is _not_ at all an empty tree, rather it is an entry
_inside_ of a tree, making the tree non-empty (which means that git
will not be tempted to delete the corresponing real-world directory
_until_ one deletes the directory entry keeping the tree alive).

>   So the sorting is doubly important: it's what makes "one content"
>   always have the same SHA1, but it is also much easier and
>   efficient to compare directories when we know they are sorted the
>   same way. ]
>
> It's *probably* just a few lines of code, and it actually would
> result in some nice changes ("git ls-files" would show a '/' at the
> end of an empty directory entry, for example), so this is not a big
> deal, but it's an example of how subtly different a directory is
> from a file when it comes to git.

Linus, a directory is simply non-existent inside of git.  Trees are an
indexing mechanism solely determined by their content.  That is not a
subtle difference.  Git _uses_ directories when exporting in order to
simulate a flat namespace.  But it is internally oblivious to their
existence.  And that is a perfectly elegant and reasonable approach
and I like it very much and don't want to mess with it at all.

But I also want to have directories represented within git, because
not doing so leads to awkward problems.  And the proper way as I see
it is _not_ to mess with trees and stick them with "stay when empty"
flags or similar.  This messes up the whole elegance of git's flat
name space.  The proper way is to create a distinct object that
represents a physical directory.  We don't need to represent the
contents of it: those are already tracked in the flat namespace fine,
with trees serving as an implementation detail.

All we need to represent is ".".

So git-ls-files on
.    [dir]
a.c  [file]
a/   [tree]
a/.  [dir]
a/c  [file]
abc  [file]

should likely list

.
a.c
a/.
a/c
abc

If one wants to see the _tree_ because of its SHA1, it may also be
listed.  The SHA1 of a _directory_ like a/., in contrast, is
uninteresting: it will be the same for every directory.

Whether the _tree_ is listed as "a" or "a/" is probably a matter of
taste.  Personally, I think "a/" is better for bringing across the
notion that it is a structuring device not really related to the
physical _directory_ a which is _identical_ (meaning inode-identical,
which is what counts in the physical world) to "a/." even though it is
another name of it.

And using "a/" puts it closer to its natural sort order.

I'd write up a philosophy paper about git's relation between trees,
files, directories if that were not utterly preposterous.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
