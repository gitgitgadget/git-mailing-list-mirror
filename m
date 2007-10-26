From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make rebase smarter
Date: Fri, 26 Oct 2007 10:57:12 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710261054300.4362@racer.site>
References: <1193328386.4522.352.camel@cacharro.xalalinux.org>
 <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, federico@novell.com
To: Steven Walter <stevenrwalter@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 26 11:58:10 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlLx6-0004Rr-Tw
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 11:58:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757636AbXJZJ5p (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 05:57:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757670AbXJZJ5o
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 05:57:44 -0400
Received: from mail.gmx.net ([213.165.64.20]:51146 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1756384AbXJZJ5n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 05:57:43 -0400
Received: (qmail invoked by alias); 26 Oct 2007 09:57:42 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp015) with SMTP; 26 Oct 2007 11:57:42 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19COzIxbeFCk18NFGrxnLxRKhPmjlibrRZ2yCXhDi
	nU0Spmf1iNOqh9
X-X-Sender: gene099@racer.site
In-Reply-To: <1193373682-3608-1-git-send-email-stevenrwalter@gmail.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62406>

Hi,

On Fri, 26 Oct 2007, Steven Walter wrote:

> It is a common workflow to run "git fetch; git rebase origin/<foo>" 
> Where foo is the remote tracking branch.  git-rebase should default to 
> using the remote tracking branch if no other ref is given.

This is potentially dangerous, as git-rebase does not use a detached HEAD 
to replay the operations.  Therefore you cannot go back easily when 
you started "git rebase" just to see its usage, and instead it did 
unwanted things.

So I really think that you need a patch before this one, so that

	git reset --hard <branchname>@{1}

goes back to the pre-merge state after an inadvertent rebase.  (Note: this 
behaviour is already implemented in rebase -i, because detached HEAD was 
available at that time, as opposed to the time when git-rebase was 
written.)

Ciao,
Dscho
