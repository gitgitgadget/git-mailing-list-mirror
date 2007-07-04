From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] git-init: set core.worktree if GIT_WORK_TREE is specified
Date: Wed, 4 Jul 2007 12:57:32 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707041255510.4071@racer.site>
References: <20070703224919.GA22578@moooo.ath.cx> <20070704092915.GA18597@moooo.ath.cx>
 <468B793D.53661D60@eudaptics.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Matthias Lederhofer <matled@gmx.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Wed Jul 04 13:57:48 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I63UO-0002ic-Tf
	for gcvg-git@gmane.org; Wed, 04 Jul 2007 13:57:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758778AbXGDL5m (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 Jul 2007 07:57:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758750AbXGDL5m
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jul 2007 07:57:42 -0400
Received: from mail.gmx.net ([213.165.64.20]:41763 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751331AbXGDL5l (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jul 2007 07:57:41 -0400
Received: (qmail invoked by alias); 04 Jul 2007 11:57:40 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp029) with SMTP; 04 Jul 2007 13:57:40 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19L9s5Ao8NL+mwnVwIQJmFuXvgvFZFqCsoADSAjjb
	YrKN1HiUCTHh2l
X-X-Sender: gene099@racer.site
In-Reply-To: <468B793D.53661D60@eudaptics.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51599>

Hi,

On Wed, 4 Jul 2007, Johannes Sixt wrote:

> Matthias Lederhofer wrote:
> > 
> > > +     if (!getcwd(cwd, sizeof(cwd)) || cwd[0] != '/')
> > > +             die("Unable to read current working directory");
> > 
> > Dscho just pointed out that this causes problems on windows.  The same
> > is also in setup_git_directory_gently and was there before I touched
> > it, introduced by Linus in d288a700.  What was the original reason to
> > do this?  Are there implementations of getcwd which return a relative
> > path?
> > 
> > Additionally there are other places which need to check if some user
> > supplied path is absolute.  Should we have a macro/function for that
> > which depends on the os and checks for path[0] = '/' on unix and
> > perhaps path[1] = ':' on windows?
> 
> I've modified some places (that check for an absolute path) in the MinGW
> port to read (path[0] == '/' || path[1] == ':'). I don't think that it's
> necessary that you cater for this case in your code - I'll take care of
> it in the MinGW port. Of course, a hint that there is another place to
> watch out for, or even better a test case in t/, is most appreciated.
> 
> I still hope to find some time to rework the MinGW port. Then such
> details will be hidden behind a is_path_absolute() function. Or maybe
> getcwd_or_die() ;)

Yes, but why not start early? is_path_absolute() makes perfect sense.

However, I was asking (out of lack of knowledge): is there any way 
getcwd() does not return an absolute path?

Ciao,
Dscho
