From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] apply.c: tolerate diff from a dirty but unchanged path
Date: Sun, 12 Jun 2005 11:34:22 -0700
Message-ID: <7vll5fl901.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0505261731050.17207@ppc970.osdl.org>
	<7vsm091887.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505270848220.17402@ppc970.osdl.org>
	<7vk6lk5lxt.fsf_-_@assigned-by-dhcp.cox.net>
	<7v3bs82rwh.fsf@assigned-by-dhcp.cox.net>
	<7vis13wth4.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505291151250.10545@ppc970.osdl.org>
	<7vpsusqxsy.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506120900200.2286@ppc970.osdl.org>
	<Pine.LNX.4.58.0506121003450.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jun 12 20:30:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DhXED-0000cl-Cw
	for gcvg-git@gmane.org; Sun, 12 Jun 2005 20:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVFLSew (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Jun 2005 14:34:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261819AbVFLSew
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Jun 2005 14:34:52 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:13462 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S261816AbVFLSeY (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Jun 2005 14:34:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050612183421.MOLL7275.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 12 Jun 2005 14:34:21 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506121003450.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Sun, 12 Jun 2005 10:05:56 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> One-liner fix checked in: we should ignore all git headers that are just a 
LT> single line. A valid git header is _always_ multiple lines: either you 
LT> have the "---/+++" lines of a diff, or you have the old/new lines of a 
LT> mode or name change.

Yup.  I was about to say "it always amazes me" but by now I
should instead say "I am used to see" that your fix to my
crapola is always cleaner, simpler, and shorter.

By the way, just to help you sort the heap of recent patches
from me, here is the list of patches from me not in your tree
that I think you _could_ consider.  Other patches I posted to
the list that have not been merged are mostly earlier attempts
that I consider you have already discarded; there _could_ be
something I am forgetting, but if even I myself forget, they
probably do not matter ;-):

------------
This is a fix for a bug that would embarrass me unless fixed.

    Subject: [PATCH] Fix rename/copy when dealing with temporarily broken...
    Date: Sat, 11 Jun 2005 20:55:20 -0700
    Message-ID: <7vwtp0p6tz.fsf@assigned-by-dhcp.cox.net>

A good test case is to run and compare these two in the GIT
repository.  The latter case is mishandled with unpatched code:

    commit=7ef76925d9c19ef74874e1735e2436e56d0c4897
    git-diff-tree -C $commit
    git-diff-tree -B -C $commit

------------
This one adjusts what the tutorial tells the user to expect to
the reality with the "corrected" -B behaviour we already have in
your tree.  We must have this before 1.0 in order not to confuse
the reader.  Unless you drop -B from git-status-script, that is.

    Subject: [PATCH 5/4] Tutorial update to adjust for -B fix
    Date: Fri, 03 Jun 2005 12:11:07 -0700
    Message-ID: <7vd5r3l0hg.fsf_-_@assigned-by-dhcp.cox.net>

------------
These two are enhancements that would help writing the
ultra-smart three-way merge that would look at not just merge
base and two heads, but the changes in the ancestry chain:

    Message-ID: <7vpsut7k89.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH] diff-tree: --find-copies-harder
    Date: Fri, 10 Jun 2005 18:31:02 -0700

    Message-ID: <7vr7f8p6qu.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH] Add --diff-filter= output restriction to diff-* family.
    Date: Sat, 11 Jun 2005 20:57:13 -0700

I mentioned them in the reply to this message from you:

    Date: Thu, 9 Jun 2005 08:15:52 -0700 (PDT)
    Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
    Message-ID: <Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>

    No, I think this is quite possibly wrong for several reasons.
    ...
    So I just need a little convincing that this is a good idea.

------------
These are reworked "help carrying forward local changes in 2-way
fast forward".

    Message-ID: <7vd5qt7k2d.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 1/3] Clean up read-tree two-way tests.
    Date: Fri, 10 Jun 2005 18:34:34 -0700

    Message-ID: <7v7jh17jzr.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 2/3] read-tree --emu23.
    Date: Fri, 10 Jun 2005 18:36:08 -0700

    Message-ID: <7v1x797jx0.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 3/3] read-tree: fix too strong index requirement #5ALT
    Date: Fri, 10 Jun 2005 18:37:47 -0700

    Message-ID: <7voeadxlvo.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 4/3] Finish making --emu23 equivalent to pure 2-way merge.
    Date: Sat, 11 Jun 2005 02:50:51 -0700

    Message-ID: <7vfyvpxlqi.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH 5/3] read-tree: loosen too strict index requirements
    Date: Sat, 11 Jun 2005 02:53:57 -0700

The first four implement --emu23, a two-tree fast forward
emulated internally using the three-way mechanism.  This is to
help cases where the user has local changes since the old head
by not refusing to run in many cases straight 2-tree fast
forward would refuse, and letting the user use the usual
merge-cache three-way merge postprocessing machinery to carry
local changes forward instead.

The changes these four introduce do affect 3-way in 3 cases,
which you objected, but this set has smaller impact than my
earlier attempts.  It only resolves 3 extra cases the original
3-way refuses to touch (my earlier one made it to resolve 3
cases that involve removed paths as well, none of which this
round touches, and leaves stages in the resulting index).  The
cases new code internally resolves, instead of refusing to run,
are:

 - only "merged head" created a new path, and the index happened
   to have the same change; we resolve it internally by taking
   the "merged head" and keep the index dirty if it was (#2ALT).

 - only "our head" created a new path, and the cache entry is
   dirty (i.e. user has local changes in the work tree file); we
   resolve it internally by taking "our head" and keep the index
   dirty if it was (#3ALT).

 - both "merged head" and "our head" created a new path
   identically, and the cache entry is dirty; we resolve it
   internally by taking "our head" and keep the index dirty if
   it was (#5ALT).

I think your earlier objection of "closing the door to the
clever merge algorithm" would not apply to these three cases.
Note that --emu23 does not need 3-way code to resolve the #2ALT
case, but needs the other two cases not refused; the patch makes
it resolve #2ALT case only to keep things symmetric with #3ALT
case --- otherwise users of 3-way merge would get confusing (but
still correct) results.

The last one [5/3] deals with the case where a path is only
changed in the merged head in 3-way case, and the index already
happens to have a version from the merged head (probably the
user was playing with a patch floating around in the mailing
list before initiating the merge).  In this case we can make the
3-way merge succeed instead of refusing to run, and that is what
this patch is about.  This does not change the outcome of the
merge, and I think your "closing the door" objection would not
apply to it.

------------
This is to enhance the git-*-script suite.  I do not mind too
much if it stays outside, but I think it would be useful to
other people as well, not just me.

    Message-ID: <7vll5h7k5t.fsf@assigned-by-dhcp.cox.net>
    Subject: [PATCH] Add script for patch submission via e-mail.
    Date: Fri, 10 Jun 2005 18:32:30 -0700

------------
This attempts to split the "too big main() that does it all"
which you hated.  Purely cosmetic at this point but as you
pointed out it is a good discipline to help later maintenance to
have a set of smaller single-task functions.

    Message-ID: <7vu0k56517.fsf_-_@assigned-by-dhcp.cox.net>
    Subject: [PATCH] diff-stages: unuglify the too big main() function.
    Date: Fri, 10 Jun 2005 18:44:36 -0700


