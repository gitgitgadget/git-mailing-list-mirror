From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: q: git-fetch a tad slow?
Date: Wed, 30 Jul 2008 15:38:14 -0700
Message-ID: <20080730223814.GF28503@spearce.org>
References: <20080728160138.GA12777@elte.hu> <20080729055014.GE11947@spearce.org> <20080729090802.GA11373@elte.hu> <20080730044855.GA7225@spearce.org> <20080730190657.GC26389@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Thu Jul 31 00:39:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KOKKM-0005KA-Ui
	for gcvg-git-2@gmane.org; Thu, 31 Jul 2008 00:39:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753315AbYG3WiQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 18:38:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753014AbYG3WiP
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 18:38:15 -0400
Received: from george.spearce.org ([209.20.77.23]:41461 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752315AbYG3WiP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 18:38:15 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 90726383A4; Wed, 30 Jul 2008 22:38:14 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20080730190657.GC26389@elte.hu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90867>

Ingo Molnar <mingo@elte.hu> wrote:
> * Shawn O. Pearce <spearce@spearce.org> wrote:
> > 
> > What does `find .git/refs -type f | wc -l` give for the repository on 
> > the central server?  If its more than a handful (~20) I would suggest 
> > running git-gc before testing again.
> 
> ah, you are right, it gave 275, then git-gc brought it down to two:
> 
>   earth4:~/tip> find .git/refs -type f | wc -l
>   275
>   earth4:~/tip> git gc
>   earth4:~/tip> find .git/refs -type f | wc -l
>   2
> 
> alas, fetching still seems to be slow:
> 
>   titan:~/tip> time git-fetch origin
> 
>   real    0m5.112s
>   user    0m0.972s
>   sys     0m3.380s

Yea, OK, there's definately performance problems there.  And it
should be fast.  Its too common of a case (fetching small deltas).
 
> > I'll try to find some time to reproduce the issue and look at the 
> > bottleneck here.  I'm two days into a new job so my git time has been 
> > really quite short this week.  :-|
> 
> fetching the -tip repo:
> 
>    http://people.redhat.com/mingo/tip.git/README
> 
> and then running 'git remote update' will i think already show this 
> problem for you too. People have been complaining about how slow the 
> update is.

Thanks.  I'll try to poke at it this evening and see what I find.
git-fetch should be running faster than this.

-- 
Shawn.
