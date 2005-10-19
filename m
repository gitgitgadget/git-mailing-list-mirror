From: Petr Baudis <pasky@suse.cz>
Subject: Re: git-send-pack segfaulting on DebianPPC (was: Re: cg-clone, tag objects and cg-push/git-push don't play nice)
Date: Thu, 20 Oct 2005 00:37:43 +0200
Message-ID: <20051019223743.GQ30889@pasky.or.cz>
References: <46a038f90510190202n60101c5cgf27bd714dce00513@mail.gmail.com> <Pine.LNX.4.64.0510190724000.3369@g5.osdl.org> <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 20 00:39:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ESMZf-0007AT-Tn
	for gcvg-git@gmane.org; Thu, 20 Oct 2005 00:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751613AbVJSWhv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 19 Oct 2005 18:37:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751617AbVJSWhv
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Oct 2005 18:37:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:29326 "EHLO machine.or.cz")
	by vger.kernel.org with ESMTP id S1751608AbVJSWhu (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Oct 2005 18:37:50 -0400
Received: (qmail 9980 invoked by uid 2001); 20 Oct 2005 00:37:43 +0200
To: Martin Langhoff <martin.langhoff@gmail.com>
Content-Disposition: inline
In-Reply-To: <46a038f90510191356w56b78413p6b9fe5b67fc9ee74@mail.gmail.com>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.10i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10321>

Dear diary, on Wed, Oct 19, 2005 at 10:56:35PM CEST, I got a letter
where Martin Langhoff <martin.langhoff@gmail.com> told me that...
> To recap: repo is slightly broken because cg-fetch has fetched tag
> objects, but hasn't followed them through to the commit objects they
> refer to.

That must be leftover of some old fetch, before cg-fetch got fixed wrt.
this issue.

> Internally cg-fetch is actually using git-ssh-fetch (I misreported it
> using git-fetch-pack), which is working correctly. However, cg-fetch
> attempts to optimize the fetch process, by not calling git-ssh-fetch
> if it has the tagobj that the ref points to. How those tag objects get
> there without commits in the first place I don't know. So I've removed
> the optimization and life is much better.

The "optimization" or something alike needs to be there at least for the
user interface, so that we can actually say what tags are we
downloading; besides, there can be a *lot* of tags. But I'm not sure how
moot will this all be after Cogito moves to the remote peeking (Real
Soon Now, promise ;-).

> There is a second bug during the tag fetch. Some of the references
> (created by git-cvsimport) are multiline, and break cg-fetch. It's
> probably a bug in git-cvsimport, but I'm fixing cg-fetch to use head
> -n1 instead of cat. I'll deal with git-cvsimport later.

Eek. Did I miss something and are multiline refs meaningful now? If not,
they are pretty bad and I'd imagine other parts of Cogito would be
pretty confused about that. I'd call this a corrupted repository,
tough. Perhaps a check should be added to fsck.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
VI has two modes: the one in which it beeps and the one in which
it doesn't.
