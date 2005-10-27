From: Chris Shoemaker <c.shoemaker@cox.net>
Subject: Re: [PATCH gitweb] Visually indicating patch size with horizontal bars
Date: Thu, 27 Oct 2005 19:48:13 -0400
Message-ID: <20051027234813.GA512@pe.Belkin>
References: <20051027203945.GC1622@pe.Belkin> <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 28 01:49:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EVHTu-0006ZF-9N
	for gcvg-git@gmane.org; Fri, 28 Oct 2005 01:48:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932695AbVJ0XsQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 27 Oct 2005 19:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932697AbVJ0XsQ
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Oct 2005 19:48:16 -0400
Received: from eastrmmtao03.cox.net ([68.230.240.36]:34244 "EHLO
	eastrmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S932695AbVJ0XsP (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2005 19:48:15 -0400
Received: from localhost ([24.250.31.7]) by eastrmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051027234735.PXLQ2767.eastrmmtao03.cox.net@localhost>;
          Thu, 27 Oct 2005 19:47:35 -0400
Received: from chris by localhost with local (Exim 4.43)
	id 1EVHTi-0000Ie-0n; Thu, 27 Oct 2005 19:48:14 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vfyqm1uvx.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.4.1i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10730>

On Thu, Oct 27, 2005 at 03:02:10PM -0700, Junio C Hamano wrote:
> Chris Shoemaker <c.shoemaker@cox.net> writes:
> 
> > If anyone thinks this is a good feature, then please tell me an
> > efficient way to get some heuristic of the patch size.
> >
> > Right now, I'm using: 
> >
> > GIT_DIFF_OPTS='-U 0' $gitbin/git-diff-tree -p $hash | wc -l
> >
> > which is pretty slow.  Any suggestions?
> 
> * do we really want to know the number of lines?  sometimes the
>   number of pahts that are affected is more useful than number
>   of lines when assessing the damage, which can be done with
>   'git-diff-tree --name-only'.

That only shows the top-level names, so when 100s of files changes in
a subdir it looks just like one entry.  It's ok when there's no
subdirs, but it just doesn't work when 95% of the code is under,
e.g. src/.

> 
> * cache the result -- they never change.

True.  Maybe gitk and gitweb can share a cache containing the tree
diffs.  Or maybe git-core can cache tree diffs?

> 
> An interesting question is what to do with merges, but probably
> we can just ignore it for now.

It's trivial to, e.g. use a different image for merges, maybe based on
# of parents?

But, in general, is there interest in a visual indicator of commit
size and/or type in gitweb?

-chris
