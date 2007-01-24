From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to pull only a few files from one branch to another?
Date: Wed, 24 Jan 2007 11:16:35 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0701241104300.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <17846.53626.895660.762096@lisa.zopyra.com>
 <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Bill Lear <rael@zopyra.com>,
	Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jan 24 11:16:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H9fBK-0006sw-37
	for gcvg-git@gmane.org; Wed, 24 Jan 2007 11:16:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750943AbXAXKQi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 24 Jan 2007 05:16:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750955AbXAXKQi
	(ORCPT <rfc822;git-outgoing>); Wed, 24 Jan 2007 05:16:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:41608 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750949AbXAXKQh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jan 2007 05:16:37 -0500
Received: (qmail invoked by alias); 24 Jan 2007 10:16:35 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO dumbo2) [132.187.25.13]
  by mail.gmx.net (mp014) with SMTP; 24 Jan 2007 11:16:35 +0100
X-Authenticated: #1490710
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <Pine.LNX.4.64.0701231937310.3606@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37620>

Hi,

On Tue, 23 Jan 2007, Linus Torvalds wrote:

> NOTE NOTE NOTE! I don't actually think "git merge-one-file" really works 
> correctly as-is for your usage case. It _kind_of_ gets the result you 
> want, but it's not really written to be used like that, and you'll get an 
> error from the
> 
> 	git-checkout-index -f --stage=2 -- "$4" &&
> 		cat "$src1" >"$4"
> 
> stage because stage 2 didn't exist ("git-merge-one-file" is really only 
> supposed to be called by a real merge).
> 
> But it's _almost_ usable that way. Maybe Dscho or Junio wants to make it 
> work the extra final mile.

I don't really see the point, but yes, it would be easy enough (at least 
in the builtin version I sent out last night).

Note that the checkout-index is used _purely_ to set the correct mode (at 
least as far as I can tell). *Clickety-click* well, seems you had 
something different in mind on June 8th, 2005. "make sure that the full 
pathname is created". This, of course, is missing from the builtin 
merge-one-file (yet).

> Not exactly pretty. If this is something people want to do often, we'd 
> need to generate some porcelain for it.

I fully expect people to agree that this is not the way to go. I think 
cherry-picking is what you were after, Bill, correct?

Having said that, I find myself picking changes from a side-branch (with 
too many one-liner commits) with this command:

	git diff -R sidebranch file1 file2.. | git apply --index

Ciao,
Dscho
