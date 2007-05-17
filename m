From: Jeff King <peff@peff.net>
Subject: Re: [3/4] What's not in 1.5.2 (new topics)
Date: Thu, 17 May 2007 12:25:42 -0400
Message-ID: <20070517162542.GA28501@coredump.intra.peff.net>
References: <11793556363795-git-send-email-junkio@cox.net> <11793556371774-git-send-email-junkio@cox.net> <200705170539.11402.andyparkins@gmail.com> <7v4pmcauu3.fsf@assigned-by-dhcp.cox.net> <20070517110225.GA3334@steel.home> <20070517124622.GP4489@pasky.or.cz> <20070517134649.GA20853@coredump.intra.peff.net> <20070517161002.GR4489@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Thu May 17 18:26:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hoinh-0006BV-66
	for gcvg-git@gmane.org; Thu, 17 May 2007 18:26:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755581AbXEQQZp (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 17 May 2007 12:25:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755575AbXEQQZp
	(ORCPT <rfc822;git-outgoing>); Thu, 17 May 2007 12:25:45 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:1147 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755554AbXEQQZp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 May 2007 12:25:45 -0400
Received: (qmail 19744 invoked from network); 17 May 2007 16:25:45 -0000
Received: from coredump.intra.peff.net (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 17 May 2007 16:25:45 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 17 May 2007 12:25:42 -0400
Content-Disposition: inline
In-Reply-To: <20070517161002.GR4489@pasky.or.cz>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47536>

On Thu, May 17, 2007 at 06:10:02PM +0200, Petr Baudis wrote:

> But, did you read what you actually quoted? Because I can only repeat my
> argument in the face of (1), and you didn't seem to dispute any part of
> it at all.

You said:
> Because kernel/ can get removed, moved around, or point at entirely
> *different* projects over time and branches - kernel/ can switch from
> linux-2.4 to linux-2.6, libc/ can switch between glibc and uClibc, ...

which I took to mean that we must be able to track changes to the URL
which is pointed to by the kernel/ submodule, and therefore this
configuration must be in a tracked file.  Which is _precisely_ what I
advocated: it goes in a .gitmodules (or .gitconfig) file in the tracked
directory. This is counter to what Alex says, which is that one should
simply pull the config down during clone time and never change it.

However, I think we _must_ have an override mechanism, since I don't
necessarily use the same URLs that you do. I propose that such overrides
should go into the local repo config. The only difference between what I
have proposed and what Junio mentioned is that I would base the config
override key on the directory name, not the URL. This means that if
upstream changes their pointer to the URL, yours will change with it
_unless you have an override_. With Junio's, their change of URL will
override your change (since the key will no longer match your config).

How do you propose to handle overrides?

> "kernel/" has _no_ meaning. Only a (treeid,"kernel/") pair has meaning,
> nothing less - a particular tree contains a submodule in given subtree.
> Different trees can have different submodules in different subtrees.

Right. In my proposal (unlike Alex's), it _is_ tied to the tree, since
that tree has a particular .gitmodules. But I also think you should be
able to override the submodule URL for kernel/ _for all time_ if you
want.

-Peff
