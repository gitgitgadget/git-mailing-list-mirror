From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: 'setup_work_tree()' considered harmful
Date: Tue, 17 Jun 2008 12:01:43 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0806171142290.6439@racer>
References: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Jun 17 13:04:18 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K8Yz4-0007M2-C6
	for gcvg-git-2@gmane.org; Tue, 17 Jun 2008 13:04:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbYFQLDV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Jun 2008 07:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754444AbYFQLDV
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jun 2008 07:03:21 -0400
Received: from mail.gmx.net ([213.165.64.20]:34375 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754299AbYFQLDV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jun 2008 07:03:21 -0400
Received: (qmail invoked by alias); 17 Jun 2008 11:03:19 -0000
Received: from almond.st-and.ac.uk (EHLO almond.st-and.ac.uk) [138.251.155.241]
  by mail.gmx.net (mp021) with SMTP; 17 Jun 2008 13:03:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+g2wokgmegz0jXlY1h4fmkQzMsMe7HAxP/gvGqca
	WuJQ+7Ci73+k4T
X-X-Sender: gene099@racer
In-Reply-To: <alpine.LFD.1.10.0806161723081.2949@woody.linux-foundation.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85289>

Hi,

On Mon, 16 Jun 2008, Linus Torvalds wrote:

> [ Dscho cc'd because I think he is the primary culprits for this thing, I 
>   think. Commit e90fdc39b6903502192b2dd11e5503cea721a1ad in particular, 
>   methinks. ]

Yes, I am not happy with work-tree.  In fact, I grew to positively hate 
it.  IMHO it was not well designed when it entered Git, and unfortunately 
my endeavors to clean it up were not very successful, either.

> [...]
>
> In particular, doing a "git add ." will use absolute pathnames for all 
> git files, while a "git diff" will not. And this is quite noticeable - 
> the absolute pathnames are not just longer, they have more path 
> components in them. Making them a lot slower to look up and use.
> 
> [...]
> 
> In general, I think we've gone in the wrong direction with a lot of the 
> "make_absolute_path" stuff. See above. 5% performance loss is not good.

Yes, that is true.  However, I think we need it for the case where 
work_tree is set (technically, we could try to be clever when work_tree is 
set in such a manner that we can operate with relative paths, but I think 
that is just not worth it).

So I am thinking about reverting to the old behavior, but _just_ for the 
common case that no work tree was set.

This might be more tricky than it used to be, because of the many special 
cases work trees require.

I briefly considered working on this now, but I simply do not have the 
time, and I seem to be unconcentrated these days.  Probably the best thing 
would be to scrap the whole work-tree thing and throw it out, admitting 
that it was a mistake to begin with.

Ciao,
Dscho
