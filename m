From: Nix <nix@esperi.org.uk>
Subject: Re: [RFC PATCH] Re: Empty directories...
Date: Tue, 24 Jul 2007 00:32:08 +0100
Message-ID: <873azen1c7.fsf@hades.wkstn.nix>
References: <alpine.LFD.0.999.0707181444070.27353@woody.linux-foundation.org>
	<alpine.LFD.0.999.0707181557270.27353@woody.linux-foundation.org>
	<85abttwa7m.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707181710271.27353@woody.linux-foundation.org>
	<7vbqe93qtv.fsf@assigned-by-dhcp.cox.net>
	<20070719053858.GE32566@spearce.org>
	<20070719060922.GF32566@spearce.org> <vpqvecgvmjh.fsf@bauges.imag.fr>
	<20070719105105.GA4929@moonlight.home>
	<86zm1sbpeh.fsf@lola.quinscape.zz>
	<20070719123214.GB4929@moonlight.home>
	<863azka7d4.fsf@lola.quinscape.zz> <87ps2inab5.fsf@hades.wkstn.nix>
	<85y7h6dewp.fsf@lola.goethe.zz> <87lkd6n62i.fsf@hades.wkstn.nix>
	<85k5sqdavo.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707231527050.3607@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jul 24 01:32:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ID7O4-0003t3-RB
	for gcvg-git@gmane.org; Tue, 24 Jul 2007 01:32:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755639AbXGWXcU (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 19:32:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755238AbXGWXcU
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 19:32:20 -0400
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]:37399 "EHLO
	mail.esperi.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753251AbXGWXcT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 19:32:19 -0400
Received: from esperi.org.uk (nix@hades.wkstn.nix [192.168.14.18])
	by mail.esperi.org.uk (8.12.11.20060614/8.12.11) with ESMTP id l6NNW98g030444;
	Tue, 24 Jul 2007 00:32:09 +0100
Received: (from nix@localhost)
	by esperi.org.uk (8.12.11.20060614/8.12.11/Submit) id l6NNW8Sb014724;
	Tue, 24 Jul 2007 00:32:08 +0100
Emacs: if it payed rent for disk space, you'd be rich.
In-Reply-To: <alpine.LFD.0.999.0707231527050.3607@woody.linux-foundation.org> (Linus Torvalds's message of "Mon, 23 Jul 2007 15:31:46 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.5-b27 (linux)
X-DCC-WEiAPG-Metrics: hades 1072; Body=3 Fuz1=3 Fuz2=3
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53503>

On 23 Jul 2007, Linus Torvalds spake thusly:
> So practically speaking, you want to track the *minimal* possible state, 
> not the maximal one. 

I think it depends on your use case. For source code and indeed anything
with heavy merges, this is true: but I'm increasingly using git as a
sort of `merged historical tar' to store images of entire random
filesystem trees across time, and gaining the benefit of the packer's
lovely space-efficiency as well (doing this with svn would be a lost
cause, twice the space usage before you even think about the
repository). And in that case, preserving everything you can makes
sense.

(Perhaps what I should be doing is tarring the directory tree up and
storing the *tarball* in git. I'll try that and see what it does to pack
sizes. These are version-controlled backups of my mother's magnum opus
in progress so you can understand that I don't want to destroy them
accidentally: I'd never hear the end of it! ;) )

> So this does mean that if you want to explicitly track certain things 
> (ownership and more complete file permissions, or ACL's, or "resource 
> forks", or any number of other things that a file *could* have on various 
> systems), you end up havign to track them in something else than git, or 
> you end up having to track them as a separate "metadata file".

Yes indeed: that's why I proposed doing this using a couple of new hooks
driving entirely optional permissions-preservation stuff. Most use cases
really won't want to track this, so this sort of stuff shouldn't impose
upon the git core or upon anyone who doesn't want it. (However, the
ability to have alternative file merging strategies *may* be useful
elsewhere, perhaps.)
