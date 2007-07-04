From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: How to rebase after upstream was merged?
Date: Wed, 4 Jul 2007 14:30:54 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041426570.4071@racer.site>
References: <468B918E.FBCADCB9@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 15:31:17 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I64wq-0004M5-7H
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 15:31:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760698AbXGDNbH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 09:31:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760637AbXGDNbG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 09:31:06 -0400
Received: from mail.gmx.net ([213.165.64.20]:58387 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759532AbXGDNbE (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 09:31:04 -0400
Received: (qmail invoked by alias); 04 Jul 2007 13:31:02 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp003) with SMTP; 04 Jul 2007 15:31:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/H0ccYbTTHuZJjR4LygUZdwGV0MB1I8Q3Yx+fnOV
	vpJ2wNQWTiJn6M
X-X-Sender: gene099@racer.site
In-Reply-To: <468B918E.FBCADCB9@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51611>

Hi,

On Wed, 4 Jul 2007, Johannes Sixt wrote:

> I have this history:
> 
> o--o--o--o--o   <- origin
>     \        \
>      x--x--x--M--x--x  <- master (HEAD)
> 
> At this point I would like to rebase to straighten the history, but it
> won't let me:
> 
>     $ git rebase origin
>     Current branch master is up to date.

I'd do something like

$ git checkout -b tmp HEAD~3
$ git rebase origin
$ git checkout master
$ git rebase --onto tmp HEAD~2
$ git branch -d tmp

> I would like to extend the check to also check for linear history. How
> can I do this most efficiently? My first try is along these lines:
> 
>   test $(git rev-list origin..HEAD | wc -l) = \
>        $(git rev-list --no-merges origin..HEAD | wc -l)
> 
> Is there a better approach?

I usually to

	test -z "$(git rev-list --parents origin..HEAD | grep " .* ")"

Hth,
Dscho
