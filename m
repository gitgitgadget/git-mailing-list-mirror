From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Fri, 20 Jul 2007 07:35:08 +0200
Organization: Organization?!?
Message-ID: <85644fvdrn.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org> <7vbqe93qtv.fsf@assigned-by-dhcp.cox.net> <20070719053858.GE32566@spearce.org> <9436820E-53D1-425D-922E-D4C76578E40A@silverinsanity.com> <863azk78yp.fsf@lola.quinscape.zz> <FA38709A-7C68-4D66-BA26-B5ED49DFA85A@silverinsanity.com> <7vk5sw2ba7.fsf@assigned-by-dhcp.cox.net> <alpine.LFD.0.999.0707191706120.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707191726510.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 20 07:35:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBl99-0005CT-KQ
	for gcvg-git@gmane.org; Fri, 20 Jul 2007 07:35:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751384AbXGTFfU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 20 Jul 2007 01:35:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751293AbXGTFfU
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Jul 2007 01:35:20 -0400
Received: from main.gmane.org ([80.91.229.2]:53961 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751130AbXGTFfT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jul 2007 01:35:19 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBl92-0008Nv-Hf
	for git@vger.kernel.org; Fri, 20 Jul 2007 07:35:16 +0200
Received: from dslb-084-061-049-236.pools.arcor-ip.net ([84.61.49.236])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 07:35:16 +0200
Received: from dak by dslb-084-061-049-236.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 20 Jul 2007 07:35:16 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-049-236.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:IhPUo1S1VLjGykUtL74xvbbORaE=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53055>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, 19 Jul 2007, Linus Torvalds wrote:
>> 
>> That's physically impossible with the git data-structures (since
>> there is no way of saving "this directory was added empty" in the
>> tree structures, nor any point to it), so I think it's just insane
>> rambling.
>
> Of course, it's physically *possible* to have a tree that contains
> two entries for the same name: first the "empty tree" and then the
> "real tree", and yeah, in theory you could track things that way.
>
> So I guess the "physically impossible" was a bit strong. You'd have
> to have a totally insane format, and you'd have to violate deeply
> seated rules about what trees look like (and the index too, for that
> matter: we'd have to do the same for the index, and keep the S_IFDIR
> entry alive despite having other entries that are children of it),
> but it's *possible*.

Excuse me?  You don't need a "totally insane format".  You need an
entry "." of a new type "directory" that can be part of the current
concept of a "tree".  This new type does _not_ have children.  It is
not a container for files.  It would be the thing that would carry
permissions or other properties if git were to store them.  It can be
put into .gitignore files like other files.

One drawback is that adding and removing it alone is not supported
with the current git-add and git-remove commands: they would require
an additional argument "-d" like "ls" does.

All of this is a straightforward extension fitting very well the
current paradigms and also existing file systems and their usage.

> It's just a really bad idea.

> So to be sane, when you add files, the empty directory entry has to
> go away.

You really have not followed the discussion at all.  This is not
possible since otherwise you could not distinguish the cases

mkdir A
touch A/B
git-add A
git-rm A/B

where A was added and not removed and should stay and

mkdir A
touch A/B
git-add A/B
git-rm A/B

where a single file was added and removed and nothing should stay.

> Otherwise you could have two very different trees that encode the
> same *content* (just with different ways of getting there -
> depending on whether you have a history with empty trees or not),
> and that's very much against the philosophy of git, and breaks some
> fundamental rules (like the fact that "same content == same SHA1").

No, the content is _different_.  One tree contains a tracked
directory, the other does not.  That means that the trees behave
_differently_ when you manipulate them, and that means that they are
_not_ the same tree.

> In fact, that may be the best way to explain why it's *not* an
> option to have "empty trees remain empty trees if we remove the last
> file from them": git fundamnetally tracks "content snapshots", and
> anything that implies the content containing any history is against
> the rules.
>
> So the whole notion of "remembering" whether a directory was added
> explicitly as an empty directory or not is just not a sensible
> concept in git.

Certainly.  That is why we instead remember whether or not a directory
entry "." was added or not.  It will be added (unless the defaults and
gitignore settings ask "." to be non-tracked) when git adds the
corresponding tree or subtree, and it will get removed when git
removes the corresponding tree or subtree.  Emptiness is not a special
case, and it can't be.  Currently, the main information associated
with "." is "stay around even if tree becomes empty".

Now you can do

    unlink .

in Solaris and have the name "." vanish while the directory still
works as a container by other names.

I don't propose that git be able to track this difference, though, and
I doubt that most file archivers would.

But git can or cannot ignore files, and in a similar way it can or
cannot ignore what a directory has more than being an abstract
container.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
