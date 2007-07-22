From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git help for kernel archeology, suppress diffs caused by CVS
 keyword expansion
Date: Sun, 22 Jul 2007 12:37:22 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707221234250.3607@woody.linux-foundation.org>
References: <9e4733910707221148g69d7600bk632abb7452ce9c7c@mail.gmail.com> 
 <alpine.LFD.0.999.0707221205080.3607@woody.linux-foundation.org>
 <9e4733910707221212v2f6cc1c4kf7a35e84f351e4cd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	lkml <linux-kernel@vger.kernel.org>
To: Jon Smirl <jonsmirl@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jul 22 21:37:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IChFG-0007WB-F7
	for gcvg-git@gmane.org; Sun, 22 Jul 2007 21:37:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756766AbXGVThb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jul 2007 15:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755070AbXGVThb
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jul 2007 15:37:31 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45231 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754073AbXGVTha (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jul 2007 15:37:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MJbRLf020790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 22 Jul 2007 12:37:29 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6MJbME1019998;
	Sun, 22 Jul 2007 12:37:22 -0700
In-Reply-To: <9e4733910707221212v2f6cc1c4kf7a35e84f351e4cd@mail.gmail.com>
X-Spam-Status: No, hits=-2.718 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53305>



On Sun, 22 Jul 2007, Jon Smirl wrote:

> On 7/22/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > 
> > 
> > On Sun, 22 Jul 2007, Jon Smirl wrote:
> > >
> > > It would really be useful if git diff had an option for suppressing
> > > diffs caused by CVS keyword expansion.
> > 
> > I really think it's not a "git diff" issue, but it might be a "import"
> > issue.
> > 
> > IOW, I think you'd be a *lot* better off just not importing those things
> > in the first place (which is what CVS does internally), or possibly
> > importing them as two trees (ie you'd have the "non-log" version and the
> > "log expansion" version, so that you can track and compare both).
> > 
> > Doing the thing at "diff" time is certainly possible, but this is simply
> > much better done as a totally independent preprocessing phase. The diff
> > handling is already some of the more complex parts (and very central), it
> > would be much simpler and efficient to not try to make that thing fancier,
> > and instead solve the problem at the front-end.
> 
> These diffs are coming from companies doing GPL compliance without
> really wanting to comply. CVS servers are not made available.

That wasn't what I said. 

You want to supporess the CVS keyword expansion.

I'm telling you that you should just do so.

But I'm *also* telling you that this has nothing to do with "git diff".

The way to get "git diff" to not show the CVS expansion is to *remove* the 
CVS expansion. By simply running some pre-processing on the patches 
*before* you put them into git in the first place (or, like Dscho 
suggested: you could do it later too, by using git filter-branch).

Once you have the version that doesn't have the CVS log, "git diff" will 
automatically do the rigth thing.

In other words, I'm just saying that you're trying to solve the wrong 
problem. Once you solve the *right* problem, the wrong problem just goes 
away.

			Linus
