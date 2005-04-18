From: Russell King <rmk@arm.linux.org.uk>
Subject: Re: Re-done kernel archive - real one?
Date: Mon, 18 Apr 2005 23:59:52 +0100
Message-ID: <20050418235951.D16789@flint.arm.linux.org.uk>
References: <Pine.LNX.4.58.0504161543590.7211@ppc970.osdl.org> <1113774736.3884.4.camel@localhost.localdomain> <Pine.LNX.4.58.0504171511210.7211@ppc970.osdl.org> <20050417231959.A30656@flint.arm.linux.org.uk> <20050417235136.B30656@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504171621330.7211@ppc970.osdl.org> <20050418102332.A21081@flint.arm.linux.org.uk> <Pine.LNX.4.58.0504180802060.7211@ppc970.osdl.org> <20050418225356.B16789@flint.arm.linux.org.uk> <20050418224852.GM5554@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Apr 19 00:56:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNf9t-0003q3-Q3
	for gcvg-git@gmane.org; Tue, 19 Apr 2005 00:56:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261170AbVDRW77 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 18 Apr 2005 18:59:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261169AbVDRW77
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Apr 2005 18:59:59 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:13065 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S261170AbVDRW74 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Apr 2005 18:59:56 -0400
Received: from flint.arm.linux.org.uk ([2002:d412:e8ba:1:201:2ff:fe14:8fad])
	by caramon.arm.linux.org.uk with asmtp (TLSv1:DES-CBC3-SHA:168)
	(Exim 4.41)
	id 1DNfDd-00019G-Eg; Mon, 18 Apr 2005 23:59:53 +0100
Received: from rmk by flint.arm.linux.org.uk with local (Exim 4.41)
	id 1DNfDc-0006Me-7e; Mon, 18 Apr 2005 23:59:52 +0100
To: Petr Baudis <pasky@ucw.cz>
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050418224852.GM5554@pasky.ji.cz>; from pasky@ucw.cz on Tue, Apr 19, 2005 at 12:48:52AM +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 19, 2005 at 12:48:52AM +0200, Petr Baudis wrote:
> Dear diary, on Mon, Apr 18, 2005 at 11:53:57PM CEST, I got a letter
> where Russell King <rmk@arm.linux.org.uk> told me that...
> > Maybe Petr can improve the error handling, and incorporate it (or at
> > least some of it) into git-pasky
> 
> This does not need to touch git pull at all now; all the relevant logic
> can change in git merge (and git commit), and I'm hacking that now. It
> should be rather easy, I think.
> 
> I think I won't make git merge commit automatically - I think the user
> should get a chance to do a git diff on what is getting merged to check
> if everything is all right.
> 
> What is actually a little annoying is having to cd ,,merge and then
> back, though. I don't know, but the current pull-merge script does not
> bother with the temporary merge directory neither, even though Linus
> wanted it. Linus, do you still do? ;-)

In the case I highlighted, we don't want to end up having to require
user intervention.  This is a common case here, and was one which was
entirely scripted with BK.

Essentially, with BK, at 7am localtime each morning, I'd:

- update my baseline linux 2.6 tree
- for each working tree which may be pulled from
  - if the baseline is a superset
    - update working tree from baseline

The net result is that my workflow consisted entirely of:

1. commit whatever into working tree
2. test
3. send linus a pull request
4. repeat next day

The tree resynchronisation happened completely and entirely in the
background with no user intervention required at all.

With your suggested requirement for user intervention whenever there's
a merge, it means that this just isn't possible - you could automate
the pulls, but you need to ensure that you'd visited each and every
unmerged tree before the next day, or you don't script it at all and
do the whole thing manually.

Hey, I'm lazy, and that means that just won't get done, and my trees
will end up being horrendously out of date all the time.  But isn't
this precisely what we have computers and scripts for?

-- 
Russell King

