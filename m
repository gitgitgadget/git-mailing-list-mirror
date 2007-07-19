From: David Kastrup <dak@gnu.org>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Thu, 19 Jul 2007 08:08:14 +0200
Organization: Organization?!?
Message-ID: <85vechudrl.fsf@lola.goethe.zz>
References: <858x9ez1li.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> <vpq4pk1vf7q.fsf@bauges.imag.fr> <alpine.LFD.0.999.0707181004330.27353@woody.linux-foundation.org> <85644hxujp.fsf@lola.goethe.zz>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?alpine.LFD.0=04.99?= =?ISO-8859-1?Q?9.0707181444070.?=
	=?ISO-8859-1?Q?27353@woody.linu?= =?ISO-8859-1?Q?x-foundation.org?=
	=?ISO-8859-1?Q?>?= <alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org> <85abttwa7m.fsf@lola.goethe.zz> <alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>  =?ISO-8859-1?Q?=20<?=
	=?ISO-8859-1?Q?7vbqe93qtv.fsf@a?= =?ISO-8859-1?Q?ssigned-by-dhcp.?=
	=?ISO-8859-1?Q?cox.=04net>?= <20070719053858.GE32566@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 19 08:08:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBPBn-0004Mn-1a
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 08:08:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752987AbXGSGIe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 02:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752333AbXGSGIe
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 02:08:34 -0400
Received: from main.gmane.org ([80.91.229.2]:58668 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751552AbXGSGIc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 02:08:32 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1IBPBb-0004fq-61
	for git@vger.kernel.org; Thu, 19 Jul 2007 08:08:27 +0200
Received: from dslb-084-061-038-079.pools.arcor-ip.net ([84.61.38.79])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 08:08:27 +0200
Received: from dak by dslb-084-061-038-079.pools.arcor-ip.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Thu, 19 Jul 2007 08:08:27 +0200
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: dslb-084-061-038-079.pools.arcor-ip.net
X-Face: 2FEFf>]>q>2iw=B6,xrUubRI>pR&Ml9=ao@P@i)L:\urd*t9M~y1^:+Y]'C0~{mAl`oQuAl
 \!3KEIp?*w`|bL5qr,H)LFO6Q=qx~iH4DN;i";/yuIsqbLLCh/!U#X[S~(5eZ41to5f%E@'ELIi$t^
 Vc\LWP@J5p^rst0+('>Er0=^1{]M9!p?&:\z]|;&=NP3AhB!B_bi^]Pfkw
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Cancel-Lock: sha1:cN00pb9/+aX1E1CocsbvY7RjbnQ=
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52940>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Sadly yes.  But I don't think that's what the folks who want to
> track empty directories want to have happen here.
>
> Which is why I'm thinking we just need to track the directory, as a
> node in the index, even if there are files in it, and even if we got
> that directory and its contained files there by just unpacking
> trees.

I have come to about the same conclusion.  So if
backward-compatibility is any concern, one needs to work with some
sort of extension records, and designing them in a way that

new-git add tree
old-git rm tree

will not leave empty subdirectories in the index will be tricky, to
say the least.  One will likely have to add an extension record
"directory" for each directory as well as "my containing dir takes
care of itself" to each file that has been added with new-git and has
had its parent directory entered by other means.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
