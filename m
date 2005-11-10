From: Petr Baudis <pasky@suse.cz>
Subject: Getting rid of symlinks in .git?
Date: Thu, 10 Nov 2005 21:45:43 +0100
Message-ID: <20051110204543.GZ30496@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Nov 10 21:46:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EaJIs-0006Bm-AW
	for gcvg-git@gmane.org; Thu, 10 Nov 2005 21:45:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932095AbVKJUpr (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 10 Nov 2005 15:45:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932098AbVKJUpq
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Nov 2005 15:45:46 -0500
Received: from w241.dkm.cz ([62.24.88.241]:42433 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S932095AbVKJUpq (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 10 Nov 2005 15:45:46 -0500
Received: (qmail 1398 invoked by uid 2001); 10 Nov 2005 21:45:43 +0100
To: Pavel Roskin <proski@gnu.org>
Content-Disposition: inline
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11524>

I'm deliberately breaking up the thread here, not to make the list
reading even more difficult for all the poor readers not so interested
in electronic archaeology (but I feel better after I began taking my
new meds, I can even resist this huge urge to start replying to mails
from June).

In-Reply-To: <1131653507.11283.31.camel@dv>
7261 N T Nov 10 Pavel Roskin    ( 1.8K)
	Re: [PATCH] cg-pull to stop treating "master" specially,
	fix fetch_local for .git/HEAD
(deliberately quoted in entirety)

Dear diary, on Thu, Nov 10, 2005 at 09:11:47PM CET, I got a letter
where Pavel Roskin <proski@gnu.org> said that...
> On Thu, 2005-11-10 at 20:24 +0100, Petr Baudis wrote:
> >   can you still remember why did you introduce this? In GNU cp
> > documentation, I can see just
> > 
> >        -b, --backup
> >               Make backups of files that are about to be overwritten or removed.
> > 
> > which doesn't make sense to me - -L dereferences symlinks.
> 
> You are right, it must be my error.  Anyway, it was so long ago that I
> would need to review and retest it.

Is it correct that all there is to it is to check if cloning locally
works properly with symlinked HEAD in the remote repository?

> While at that, let's stop using symlinks.  git doesn't use symlinks on
> Cygwin.  I think git should use that code on all OSes, since the
> benefits of using symlinks are minimal (I think the only benefits are
> their atomicity and resolving the reference in the kernel rather than in
> userspace).  Having more uniform code for all platforms would simplify
> development and testing.  It could also reduce requirements for the
> transport protocols.  Finally, symlinks could be still used by the users
> (if they know what they are doing) - git and cogito would simply become
> symlink agnostic.
> 
> When files are copied around, symlinks are pain to deal with.  They
> require special handling to be preserved both for remote operation and
> dereferenced for local operation (that's what my patch was intended to
> do).  I'm not even considering what would happen when cloning from Linux
> to Windows or vice versa.

I personally would not mind getting rid of symlinks completely, but we
will still have to support them for some reasonable time period (several
major releases, as far as Cogito is concerned - actually, there is
plenty of people still using 0.13 and such).

If more people think this is good idea, I could even again introduce
some compatibility code to cg-Xlib which will rewrite symlinkish HEAD
when it hits it (the kind of stuff we did in the old times).

> Sure, it can wait until git 1.0, but it would be great to keep this goal
> in mind.
> 
> Disclaimer - I'm not reading the git mailing list, so if it was
> discussed, I'm sorry, I don't intend to restart that discussion - just
> give me the pointer and I'll read it.

I didn't notice such a discussion yet.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
