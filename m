From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/6 (v4)] man page and technical discussion for rev-cache
Date: Fri, 21 Aug 2009 00:22:22 -0700
Message-ID: <7vab1tk4wh.fsf@alter.siamese.dyndns.org>
References: <op.uys3qgmitdk399@sirnot.private>
 <op.uyuwkmv0tdk399@sirnot.private> <op.uyzwxpmbtdk399@sirnot>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Nicolas Pitre" <nico@cam.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Sam Vilain" <sam@vilain.net>,
	"Michael J Gruber" <git@drmicha.warpmail.net>,
	"Jeff King" <peff@peff.net>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	"Andreas Ericsson" <exon@op5.se>,
	"Christian Couder" <christian@couder.net>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: "Nick Edelen" <sirnot@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 21 09:22:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MeOSf-00043A-Uj
	for gcvg-git-2@lo.gmane.org; Fri, 21 Aug 2009 09:22:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753182AbZHUHWs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2009 03:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752751AbZHUHWs
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Aug 2009 03:22:48 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:47862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752743AbZHUHWr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2009 03:22:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 20DC812838;
	Fri, 21 Aug 2009 03:22:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=oE1zB/HmUg7nCs2WtoD92oIVUss=; b=ZLvLOF
	DVoD05sDa/jDshC5/lJ2rjUr6swuW+cM4HI1K3+FFObTu3LliOUlTmx4nomEige3
	YrdqqqVQK4XiXNMMTp976t/nk/SeBua6qsfq+k/q289wEJ/WVrviG7D/H146/f3b
	1OQSWBbq0Hz3I9nqrKGEMAHNhL6f1OnVMUb14=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=c0ektLkNVQWH12js0bXIQ1OcAHMj9Izh
	s+czWLcFWDn3msM4vC3SojlQFqRy6JxH1wzDIBFN8pLh/jo8wgby79oVD0JDp+IP
	z9Y3M+2s6ICHnzz+GvfolSDqdEws+/QDDhnAMoyBSBatz3ivSEUN7V36+gb7R5yA
	M6banVIcCW0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 8582D1282F;
	Fri, 21 Aug 2009 03:22:37 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7399E1282B; Fri, 21 Aug
 2009 03:22:25 -0400 (EDT)
In-Reply-To: <op.uyzwxpmbtdk399@sirnot> (Nick Edelen's message of "Fri\, 21
 Aug 2009 06\:47\:41 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 6740387A-8E23-11DE-82E6-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126690>

"Nick Edelen" <sirnot@gmail.com> writes:

> +DESCRIPTION
> +-----------
> +The revision cache ('rev-cache') provides a mechanism for significantly
> +speeding up revision traversals.  It does this by creating an efficient
> +database (cache) of commits, their related objects and topological relations.
> +Independant of packs and the object store, this database is composed of

"independent"

> +rev-cache "slices" -- each a different file storing a given segment of commit
> +history.  To map commits to their respective slices, a single index file is
> +kept for the rev-cache.
> +
> +'git-rev-cache' provides a front-end for the rev-cache mechanism, intended for
> +updating and maintaining rev-cache slices in the current repository.  New cache
> +slice files can be 'add'ed, to keep the cache up-to-date; individual slices can
> +be traversed; smaller slices can be 'fuse'd into a larger slice; and the
> +rev-cache index can be regenerated.

What is the practical use of traversing a single individual slice?

> +COMMANDS
> +--------
> +
> +add
> +~~~
> +Add revisions to the cache by creating a new cache slice.  Reads a revision
> +list from the command line, formatted as: `START START ... \--not END END ...`
> +
> +Options:
> +
> +\--all::
> +	Include all refs in the new cache slice, like the \--all option in
> +	'rev-list'.
> +
> +\--fresh/\--incremental::
> +	Exclude everything already in the revision cache, analogous to
> +	\--incremental in 'pack-objects'.

Write these on separate lines, like this:

	--fresh::
        --incremental::
        	Exclude ...

> +\--stdin::
> +	Read newline-seperated revisions from the standard input.  Use \--not
> +	to exclude commits, as on the command line.
> +
> +\--legs::
> +	Ensure newly-generated cache slice has no partial ends.  This means that
> +	no commit has partially cached parents, in that all its parents are
> +	cached or none of them are.  99.9% of users can ignore this command.

Bad presentation.  I am sure 99.9% of readers would not understand what
you are talking about, and I am sure I am among them.

A "partial end" is an unexplained and undefined term at this point, and
you use it to explain what --legs is about in the first sentence.  This
results in giving _no_ information to the reader with the first sentence.
Then, the second sentence , by starting with "This means that", attempts
to define the unexplained term "partial end" by rephrasing it differently.

Such a presentation structure is good only if

  1. the rephrased explanation ("all or none of the parents are cached")
     is much more understandable the new unfamiliar term ("partial end");

  2. the new unfamiliar term is much concise; and

  3. the new unfamiliar term is used repeatedly in other parts of the
     documentation.

But the explanation of --legs does not satisfy any of the above three.  It
is not clear what it means for a commit to get its parents "cached"; the
rephasing explanation is not much longer than the "partial end", and you
do not use "partial ends" in order to further explain other things
anywhere in the documentation.

In such a case, you are better off dropping the first cryptic "has no
partial ends" together with "This means" and introduce the concept you are
introducing more directly.  And because you would be dropping the latter
half of the first sentence and "This means that", you can do this with
longer and easier to understand explanation.  Perhaps...

	--legs::
        	Make sure each and every commit in the created cache slice
        	either has its all parents in the same slice, or none of
        	its parents in it.

I said "in the _same_ slice" in my version, but I do not know if that is
what you meant by "cached".  Maybe you meant "in _some_ slice" instead.
That is the kind of clarification you can afford to make, once you stop
introducing otherwise unused term like "partial ends" here.

Also, I do not find the word "legs" particularly "click" with the "no
partial ends" concept you are trying to define.  It often is good to use a
verb that can be made into adjective for things like this.  How about
calling this "--close"?

	Close the newly created cache slice. i.e. make sure that each and
	every commit in the slice has its all parents in the same slice,
	or none of its parents in it.

Then later you could use "a closed slice" (vs "an open slice"), if the
distinction between a slice that was created with --legs and without
becomes useful.

> +walk
> +~~~~
> +Analogous to a slice-oriented 'rev-list', 'walk' will traverse a region in a
> +particular cache slice.  Interesting and uninteresting (delimited, as with
> +'rev-list', with \--not) are specified on the command line, and output is the
> +same as vanilla 'rev-list'.
> +
> +Options:
> +
> +\--objects::
> +	Like 'rev-list', 'walk' will normally only list commits.  Use this
> +	option to list non-commit objects as well, if they are present in the
> +	cache slice.
> +
> +Output:
> +
> +'walk' will simply dump the contents of the output commit list, work list, and
> +pending object array.  The headers are outputed on `stderr`, the object hashes
> +and names on `stdout`.

What is the practical use of traversing a single individual slice?  For
example, if you have a slice created by an earlier 'add' that was run
with, say, v1.6.0..v1.6.1 as the parameter (so presumably it will know
only about the commits and their associated objects between these
versions), and you tell the command to 'walk' v1.0.0..v1.3.0 on the slice,
what happens?

What I am getting at is if this command is also mainly intended for
debugging this command, just like --no-objects option above.

> +fuse
> +~~~~
> +Merge several cache slices into a single large slice, like 'repack' for
> +'rev-cache'.  On each invocation of 'add' a new file ("slice") is added to the

At this point, the reader has already read the explanation of what a slice
is, so it is easier to read if you said "... a new slice is added to the ..."
here, without using ambiguous but more familiar word "file".

> +Running 'fuse' every once in a while will solve this problem by coalescing all
> +the cache slices into one larger slice.  For very large projects, using
> +\--ignore-size is advisable to prevent overly large cache slices.  Setting git
> +'config' option 'gc.revcache' to 1 will enable cache slice fusion upon garbage
> +collection.

I am still unhappy with the word "--ignore-size".  Its the threashold,
existing slices larger than which will be kept uncoalesced; the option is
not about "ignoring" the size, but means entirely opposite.  The command
actively pays attention to the size while operating under this option.
Perhaps --keep-size might be slightly more appropriate; even though "size"
does not tell if it is a lower bound or upper bound, at least it makes it
clear that it is about keeping them from getting collapsed.

> +Note that 'fuse' uses the internal revision walker, so the options used in

Internal to what?  Internal to git?  Internal to rev-cache creator?
Internal to the fuze command implementation (and if so, why)?

> +This command prints the SHA-1 of the new slice on `stdout`, and information
> +about its work on `stderr` -- specifically which files it's removing.

When talking about the "standard output" in general terms, I'd prefer
spelling it out, reserving `stdout` as a precise technical term to refer
to the standard output stream from programming environments used only when
discussing actually programming naming the stream with that particular
spelling.

> +index
> +~~~~~
> +Regenerate the revision cache index.  If the rev-cache index file associating
> +objects with cache slices gets corrupted, lost, or otherwise becomes unusable,
> +'index' will quickly regenerate the file.  It's most likely that this won't be
> +needed in every day use, as it is targeted towards debugging and development.

Perhaps "reindex"?

> +alt
> +~~~
> +Create a cache slice pointer to another slice, identified by its full path:
> +`fuse path/to/other/slice`
> +
> +This command is useful if you have several repositories sharing a common
> +history.  Although space requirements for rev-cache are slim anyway, you can in
> +this situation reduce it further by using slice pointers, pointing to relavant
> +slices in other repositories.  Note that only one level of redirection is
> +allowed, and the slice pointer will break if the original slice is removed.

Hmm, why is this inconsistency?  I think other symbolic-link-like
construct we have follow 5 levels or so...

How would you break the dependency once you make your rev-cache dependent
on another?



> diff --git a/Documentation/technical/rev-cache.txt b/Documentation/technical/rev-cache.txt
> new file mode 100644
> index 0000000..91fce8b
> --- /dev/null
> +++ b/Documentation/technical/rev-cache.txt
> @@ -0,0 +1,634 @@
> +rev-cache
> +=========
> +
> +The revision cache API ('rev-cache') provides a method for efficiently storing
> +and accessing commit branch sections.  Such branch slices are defined by a
> +series of start/top (interesting) and end/bottom (uninteresting) commits.  Each

It is often necessary to list synonyms like "start/top (interesting)" in
description when a concept has been widely used before being formalized
and different people used different words to refer to the same concept.
But here you are introducing the rev-cache and its related concepts for
the first time.  You don't have to give three words to each of these two
concepts from the beginning.  Instead, pick one unambiguous pair and stick
to them everywhere, in the code, in the input/output to/from the commands,
and in the documentation.

If it is important to be able to distinguish "uninteresting"-ness used by
rev-list and "bottom"-ness used by rev-cache, then I would suggest to use
"top/bottom".  Otherwise, I would suggest "interesting/uninteresting".
