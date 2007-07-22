From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sun, 22 Jul 2007 02:34:10 +0200
Organization: Organization?!?
Message-ID: <851wf1qnst.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707202135450.27249@woody.linux-foundation.org> <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org> <85odi69vgt.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707210832180.27249@woody.linux-foundation.org> <85tzrxslms.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707211650190.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 22 02:34:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICPPB-0002Ve-4B
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 02:34:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752724AbXGVAee (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 20:34:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752557AbXGVAee
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 20:34:34 -0400
Received: from main.gmane.org ([80.91.229.2]:52081 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752432AbXGVAed (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 20:34:33 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1ICPP3-0002R2-HL
	for git@vger.kernel.org; Sun, 22 Jul 2007 02:34:29 +0200
Received: from dslb-084-061-010-231.pools.arcor-ip.net ([84.61.10.231])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 02:34:29 +0200
Received: from dak by dslb-084-061-010-231.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sun, 22 Jul 2007 02:34:29 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-010-231.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:/Z5vSDwQoeEUXXKv4/CFrcWrmoQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53202>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 21 Jul 2007, David Kastrup wrote:
>
>> Linus, a directory is simply non-existent inside of git.
>
> You need to learn git first.
>
> A directory doesn't exist IN THE INDEX (until my patches). But you
> need to learn about the object database and the SHA1's. That's the
> real meat of git, and it sure as hell knows about directories.

To put it in another way: what would happen if trees were removed from
git's repository completely?  Instead we would just stipulate that git
should only track files, not trees, and that it would remove an
outside directory when removing the last file from the repository that
can't be accomodated without such a directory.

Now the effect would be that git would become quite inefficient.  But
it would not change its behavior in any other way.  Because it knows
_zilch_ about directories.  It knows about the hierarchy of the
_contents_, but the directories, the physical entities in the work
tree?  It deduces a convenient point of time to try deleting them
(when a tree collapses), and it deduces that they are there as long as
it is tracking their content, but no information about a _directory_
other than its _contents_ ever enter the repository or index.  About
its _existence_, git only keeps circumstantial evidence.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
