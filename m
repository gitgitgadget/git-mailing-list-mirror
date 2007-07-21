From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Sat, 21 Jul 2007 07:28:18 +0200
Organization: Organization?!?
Message-ID: <85odi69vgt.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz> <Pine.LNX.4.64.0707180135200.14781@racer.site> <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.0707181004330.=04?=
	=?ISO-8859-1?Q?=0427353@woody.lin?= =?ISO-8859-1?Q?ux-foundation.or?=
	=?ISO-8859-1?Q?g>?= <85644hxujp.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org> <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <851wf2bcqy.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0.999?= =?ISO-8859-1?Q?.07072=0402135450.?=
	=?ISO-8859-1?Q?27249@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <alpine.LFD.0.999.0707202154220.27249@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 21 07:28:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IC7WF-0004nh-4Z
	for gcvg-git@gmane.org; Sat, 21 Jul 2007 07:28:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753582AbXGUF2b (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Jul 2007 01:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753447AbXGUF2a
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Jul 2007 01:28:30 -0400
Received: from main.gmane.org ([80.91.229.2]:54530 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753496AbXGUF23 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Jul 2007 01:28:29 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IC7W0-0006UX-4f
	for git@vger.kernel.org; Sat, 21 Jul 2007 07:28:28 +0200
Received: from dslb-084-061-013-246.pools.arcor-ip.net ([84.61.13.246])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 07:28:28 +0200
Received: from dak by dslb-084-061-013-246.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 21 Jul 2007 07:28:28 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-013-246.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:8WHtBXuhh55/WBJD4LIj25mL/LI=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53139>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Fri, 20 Jul 2007, Linus Torvalds wrote:
>> 
>> As far as I can tell, it would have been exactly the same thing as the 
>> S_IFDIR, just instead of the S_IFDIR check, you'd have had to check the 
>> end of the filename for being '/'.
>
> BTW, there is actually one big difference, and the '/' at the end actually 
> has one huge advantage.
>
> Why? Because my preliminary patches sort the index entries wrong. A 
> directory should always sort *as*if* it had the '/' at the end.

Hm, that's bad.  The thing is that the directory names I am tracking
are called "." (that's what I was currently trying to reconcile your
code with).

> And I *should* have done it that way, but I never did. It now makes
> the S_ISDIR handling harder, because directories really do have to
> be sorted as if they had the '/' at the end, or "git-fsck" will
> complain about bad sorting.

Hm, I'll have to check what git-fsck does.

> Of course, it seldom matters, but basically, you should test a directory 
> structure that has the files
>
> 	dir.c
> 	dir/test
>
> in it, and the "dir" directory should always sort _after_ "dir.c".
>
> And yes, having the index entry with a '/' at the end would handle
> that automatically.

You completely lost me here.  I guess I'll be able to pick this up
only after investing considerable more time into the data structures.
And I have to goto bed right now.

> As it is, with the "mode" difference, it instead needs to fix up
> "cache_name_compare()". Admittedly, that would actually be a cleanup
> (since it would now match base_name_compare() in logic, and could
> actually use that to do the name comparison!), but it's a damn
> painful cleanup because we don't even pass in the mode to
> "cache_name_compare()", since we never needed it.
>
> Gaah.
>
> cache_name_compare itself isn't used in that many places, but it's
> used by "index_name_pos()/cache_name_pos()", which *is* used in many
> places.  And again, that one doesn't even have the mode, so it
> cannot pass it down.
>
> So it probably *is* easier to add the '/' at the end of the name instead, 
> to make directories sort the right way in the index. I'd still suggest you 
> *also* make the mode be S_IFDIR, though (and preferably make git-fsck 
> actually verify that the mode and the last character of the name 
> matches!).

The _flattened_ directory name would end in /. in my scheme.  I would
not want to use "xxx/" for a directory name, and "xxx" for a tree:
that would be completely backwards.  And I also don't like the
duplication of xxx when listing objects.

Sure, that's an implementation detail, but I don't like
implementations hurting my eyes...

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
