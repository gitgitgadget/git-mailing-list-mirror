From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git pull for update of netdev fails.
Date: Wed, 20 Sep 2006 09:49:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609200942550.4388@g5.osdl.org>
References: <20060920080308.673a1e93@localhost.localdomain>
 <Pine.LNX.4.64.0609200816400.4388@g5.osdl.org> <20060920155431.GO8259@pasky.or.cz>
 <Pine.LNX.4.63.0609201801110.19042@wbgn013.biozentrum.uni-wuerzburg.de>
 <20060920160756.GP8259@pasky.or.cz> <Pine.LNX.4.64.0609200915550.4388@g5.osdl.org>
 <Pine.LNX.4.64.0609200920290.4388@g5.osdl.org> <20060920163437.GC23260@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 18:55:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQ5Km-0004Hw-0M
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 18:54:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751925AbWITQvW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 12:51:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751926AbWITQuw
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 12:50:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:43909 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751910AbWITQuG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Sep 2006 12:50:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8KGnrnW022888
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 20 Sep 2006 09:49:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8KGnqrp003928;
	Wed, 20 Sep 2006 09:49:53 -0700
To: Shawn Pearce <spearce@spearce.org>
In-Reply-To: <20060920163437.GC23260@spearce.org>
X-Spam-Status: No, hits=-0.504 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.150 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27377>



On Wed, 20 Sep 2006, Shawn Pearce wrote:
> > 
> > This is not just a random thing. It is in fact one of the very core issues 
> > of having multiple people work together on the same remote repo. We don't 
> > do it very much (because it's often easier for everybody to have their 
> > own), but the "CVS workflow" with one common repository is another example 
> > why WE MUST NOT JUST RESET THE HEADS!
> 
> BTW `git push --force` works just great to reset the remote head.

Yes. That's why "--force" exists - it's a way of saying "the other end is 
wrong, and I really do want to force this update".

> I worked on a project not to long ago in which a user tried `git
> push`, received a "not a fast-forward" error, didn't know what it
> meant, tried `git push --force`, found that worked, and proceeded
> to force every push he did from then on.  To much gnashing of teeth
> from everyone else.

Ouch. That implies that we made it a bit too easy to force things, or that 
we have an insufficiently clear error message.

I think the current error message is fairly good: it says

	"remote '%s' is not a strict subset of local ref '%s'. maybe you 
	 are not up-to-date and need to pull first?"

which should be clear enough, but I'm hoping this was a long time ago when 
we weren't as clear (we added the "maybe you're not up-to-date .." 
language later)

> Of course an update hook finally took care of the problem, but having
> non fast-forward pushs be permitted on a shared, bare repository
> by default is interesting to say the least.  :-)

Yeah, well, it's not permitted "by default", but obviously "--force" ends 
up being a client-side decision, so with clueless clients, the default 
behaviour may not be enough to save you.

			Linus
