From: Jens Axboe <axboe@suse.de>
Subject: Re: git merging
Date: Fri, 17 Jun 2005 21:16:28 +0200
Message-ID: <20050617191627.GZ6957@suse.de>
References: <20050617133440.GI6957@suse.de> <Pine.LNX.4.58.0506170937260.8487@ppc970.osdl.org> <20050617175653.GS6957@suse.de> <Pine.LNX.4.58.0506171101450.2268@ppc970.osdl.org> <20050617181156.GT6957@suse.de> <Pine.LNX.4.58.0506171132390.2268@ppc970.osdl.org> <20050617183914.GX6957@suse.de> <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 17 21:10:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DjMEK-0000vZ-D7
	for gcvg-git@gmane.org; Fri, 17 Jun 2005 21:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262066AbVFQTPX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 17 Jun 2005 15:15:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262068AbVFQTPX
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jun 2005 15:15:23 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:1766 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262066AbVFQTPO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 17 Jun 2005 15:15:14 -0400
Received: from [62.242.22.158] (helo=router.home.kernel.dk)
	by virtualhost.dk with esmtp (Exim 3.36 #1)
	id 1DjMJ6-0005Jk-00; Fri, 17 Jun 2005 21:15:12 +0200
Received: from nelson.home.kernel.dk ([192.168.0.33] helo=kernel.dk)
	by router.home.kernel.dk with esmtp (Exim 4.22)
	id 1DjMJ3-0002Zv-Aw; Fri, 17 Jun 2005 21:15:09 +0200
Received: by kernel.dk (Postfix, from userid 1000)
	id 92A3A1E135; Fri, 17 Jun 2005 21:16:28 +0200 (CEST)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0506171142500.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, Jun 17 2005, Linus Torvalds wrote:
> 
> [ Git mailing list cc'd, since this is a general question that maybe 
>   others have wondered about ]
> 
> On Fri, 17 Jun 2005, Jens Axboe wrote:
> > 
> > btw (and forgive me for just asking you), what is the canonical way to
> > kill a branch in case you want to redo it? right now I have a block tree
> > with a bunch of brances, and I would like to redo one of the branches
> > because I forgot to add the signed-off-by entries in there.
> 
> You can just simply remove the .git/refs/heads/branch-name file (obviously 
> after having made sure that ".git/HEAD" points to something else), and 
> then you can run "git prune", which will remove all objects that aren't 
> referenced (directly or indirectly) by anything in ".git/refs/**".
> 
> Be very very careful, though. "git prune" is a dangerous script, since it
> will remove objects from the object store. If you had something that you
> don't have a proper reference for, or if you give "git prune" a list of
> references manually and it's not complete, "git prune" will happily remove
> objects that you didn't mean for it to remove.
> 
> The "git prune" script is really trivial, you can see for yourself what 
> "git-prune-script" does.

That worked! Thanks.

> NOTE! It's entirely possible to not actually delete the old branch, but 
> just rename it, and use it as a reference while you build up the new 
> branch with the same contents (but maybe different commit log messages, or 
> maybe just re-ordering the commits in the new version). To rename a 
> branch, just rename the ".git/refs/heads/<branch-name>" file to something 
> else.
> 
> So you may decide to remove (and prune) the old branch only after you've 
> re-created a new version of it, for example. That way you can use git 
> itself to extract the contents of the branch you want to re-do, which is 
> often easier.

Yeah that's very handy. I love the way the branches work, with just the
sha in the file name. So easy to manipulate.

-- 
Jens Axboe

