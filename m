From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 07:15:52 +0200
Organization: Organization?!?
Message-ID: <85sl7i9w1j.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?=0427353@woody.lin?= =?ISO-8859-1?Q?ux-foundation.or?=
	=?ISO-8859-1?Q?g>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.07072=0402135450.?=
	=?ISO-8859-1?Q?27249@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?=
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 07:16:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7K9-0002y2-RV
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:16:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbXGUFQK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbXGUFQJ
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:16:09 -0400
Received: from main.gmane.org ([80.91.229.2]:48315 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753280AbXGUFQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 01:16:07 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IC7K1-0005nq-41
	for git@vger.kernel.org; Sat, 21 Jul 2007 07:16:05 +0200
Received: from dslb-084-061-013-246.pools.arcor-ip.net ([84.61.13.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 07:16:05 +0200
Received: from dak by dslb-084-061-013-246.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 07:16:05 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-013-246.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:rIX2qiQPYoxr7sPppYVX4LojdBM=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53138>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 21 Jul 2007, David Kastrup wrote:
>> 
>> Ok, I have now acquired enough passing familiarity with the code
>> that I find part of my way around it.  Most of your patch looks
>> like it caters for the S_ISDIR type not previously in use in the
>> index (how about the repository?).
>
> The object database has always had S_ISDIR (well, "always" is since
> very early on, when I realized that flat trees didn't cut it).

Then I think I have a bit of a problem: I should think that S_ISDIR in
the repository presumably marks a tree object (still very fuzzy around
the concepts here).  An explicitly checked-in directory (under my
scheme always named "." inside of its tree) would presumably also have
S_ISDIR in the repository but behave quite differently.

> As far as I can tell, it would have been exactly the same thing as the 
> S_IFDIR, just instead of the S_IFDIR check, you'd have had to check the 
> end of the filename for being '/'.

Relative file name of ".", more or less.  Both names satisfy S_IFDIR
in the filesystem, though.

> Otherwise? Exactly the same.

> The more important thing is in many ways the object storage, and
> that's also the reason for doing the index the way I did - it more
> closely matches what the object storage does (ie the "index" ends up
> mirroring a linearized and unpacked "tree" object).

I still have to get enough of a clue about the object store to see how
this pans out.  I would not want to have the "." objects marked as
type "tree" and empty if I can avoid it.  It seems unclean, would need
extra case separations all over the place, violate the "empty trees
evaporate" property and also waste a good place for tracking
permissions or other attributes in future.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
