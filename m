From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 07:53:01 +0200
Organization: Organization?!?
Message-ID: <851wf3vcxu.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org> <7vir8f24o2.fsf@assigned
 -by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 07:53:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBlQX-0008SE-2s
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752062AbXGTFxS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbXGTFxS
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:53:18 -0400
Received: from main.gmane.org ([80.91.229.2]:50075 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751848AbXGTFxQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 01:53:16 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBlQM-00019V-DD
	for git@vger.kernel.org; Fri, 20 Jul 2007 07:53:10 +0200
Received: from dslb-084-061-049-236.pools.arcor-ip.net ([84.61.49.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 07:53:10 +0200
Received: from dak by dslb-084-061-049-236.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 07:53:10 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-049-236.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:86h2lJFofvzsjavuFzUDNybCalw=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53057>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> So the whole notion of "remembering" whether a directory was added 
>> explicitly as an empty directory or not is just not a sensible concept in 
>> git. 
>
> That is true if it is implemented as David suggested, to have a
> phony "." entry in the tree object itself.  The object name of such
> a tree (when it contains blobs and trees underneath) will be
> different from a tree that contains the same set of blobs and trees.
> It would destroy the fundamental concepts of git.

How so?

> But you _could_ treat that "should-be-kept-even-when-empty"-ness
> just like we treat executable bit on blobs, I think.
>
> When blobs with the same contents but of different type (REG vs LNK)
> and regular file with or without executable bit are entered in git,
> they all get the same SHA-1 but we can still tell them apart because
> the index and the tree entry have mode bits.  So hypothetically, you
> could introduce "sticky" directory in tree entries to mark "this
> will not go away when emptied".

A tree containing files with and without executable bits will show
different SHA-1 sums.  There is no reason that this should be
different for a tree containing the conceptual "." or not.  I won't
fight for a specific implementation but if I am going to implement
this (and the current lack of enthusiasm points to that) I will not go
and duplicate the entire ignore/add/rm/index/repository machinery in
order to have a bit rather than an actual "." directory entry.

Most Unix file systems have an honest, physical, down-to-Earth
directory entry "." even on disk because it _simplifies_ matters, even
though one could special-case "." all throughout and make do without a
physical entry in theory.

And, as I explained, "." lends itself perfectly to the gitignore
machinery in order to policy projects to track or not track
directories.

> In a 'tree' object, they might appear as:
>
>         40000 ordinary-directory '\0' 20-byte SHA-1
>         41000 directory-dontremove-even-if-empty '\0' 20-byte SHA-1
>
> In 'index', as your "I'm soft" patch, we do not have to add
> nonsticky kind of tree nodes,

It does not work, since then you can't distinguish

mkdir A
touch B
git-add A/B

from

mkdir A
touch B
git-add A

It is very clear that git-rm A/B _mustn't_ leave an empty directory in
the first case, and _must_ leave an empty directory in the second case
_if_ and only if one tracks directories.

> Obviously, this "sticky" bit will cascade up and make your otherwise
> equivalent parent tree's different,

No, it must not "cascade up".  After

mkdir -p A/B
touch A/B/C
git-add A/B
git-rm A/B

there must be nothing tracked by git.  The "sticky" bit does not
"cascade up".  Its upward effect is only changing the SHA-1 of the
tree, like any change below does.

> This will involve a lot of changes, so I would not recommend anybody
> doing so, though.

Neither would I.  Why people want to complicate the code base
everywhere by avoiding to treat "." like a legitimate entry (as Unix
file systems do for a _reason_) is simply a miracle to me.

The framework is pretty much _there_.  There is no point in not making
use of it and duplicating the whole machinery because we want a "bit
set" implementation instead of a file name.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
