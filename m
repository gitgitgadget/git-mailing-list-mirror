From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/2] Allow git-apply to fix up the line counts
Date: Thu, 5 Jun 2008 14:47:24 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806051441560.21190@racer>
References: <alpine.DEB.1.00.0806051115570.21190@racer> <4847CCD9.6000305@viscovery.net> <alpine.DEB.1.00.0806051403370.21190@racer> <4847EBC3.8060509@viscovery.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Thu Jun 05 15:49:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K4FqX-00043A-Ml
	for gcvg-git-2@gmane.org; Thu, 05 Jun 2008 15:49:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754701AbYFENsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jun 2008 09:48:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753018AbYFENsr
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Jun 2008 09:48:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:38383 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752549AbYFENsq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jun 2008 09:48:46 -0400
Received: (qmail invoked by alias); 05 Jun 2008 13:48:44 -0000
Received: from unknown (EHLO racer.local) [128.177.17.254]
  by mail.gmx.net (mp021) with SMTP; 05 Jun 2008 15:48:44 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/+ymcsywL+Jjl3RFQ2+xdkzB47zSSgGZpfaKRvft
	2r3R3cM8dMHIUg
X-X-Sender: gene099@racer
In-Reply-To: <4847EBC3.8060509@viscovery.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83933>

Hi,

On Thu, 5 Jun 2008, Johannes Sixt wrote:

> Johannes Schindelin schrieb:
> 
> > On Thu, 5 Jun 2008, Johannes Sixt wrote:
> > 
> >> Johannes Schindelin schrieb:
> >>> +--fixup-line-counts::
> >>> +	Fix up the line counts (e.g. after editing the patch without
> >>> +	adjusting the hunk headers appropriately).
> >>>
> >> This sort of implies that there is some kind of output that tells the 
> >> correct line counts. But that isn't the case (if I read the patch 
> >> correctly). So I suggest to name the option --ignore-line-counts.
> > 
> > But there is some kind of output: the hunks themselves.
> 
> Is there?

Yes!

> I did this (it rewrites all line counts to 1):
> 
> $ git diff ..HEAD~1 |
> 	sed -e '/^@@/s/,[0-9]+ /,1 /g' |
> 	./git-apply --fixup-line-counts
> 
> and there was no output. Instead, the patch was applied.

As I said, the data is in the _hunks_, but I maybe should have added _not 
in the hunk headers_.

So in a very real sense, you edit the hunks, and the hunk headers are 
adjusted to that.  You did not adjust the hunks, so they got applied.

It seems that you think the hunk header's line counts are heeded, and the 
hunk adjusted, with --fixup-line-counts?  Sorry, I find that rather 
counterintuitive.

> >  And the line counts are not ignored, but they are actively rewritten.
> 
> Of course, internally there is some sort of "output" from the fixup 
> routine, and the line counts are rewritten and then are not ignored. But 
> the user doesn't care about this internal procedure. From the user's 
> perspective, the line counts of the input patch are ignored.

But they are not!

There are _two_ things that are the line counts.  Those numbers in the 
hunk header, and the real line counts of the hunks.

Now, if you say they are _ignored_, would that not imply in plain English 
that they are left unchanged (in limbo, because those two types of numbers 
contradict each other)?

Okay, how about shikebedding this to --adjust-line-counts?

Ciao,
Dscho
