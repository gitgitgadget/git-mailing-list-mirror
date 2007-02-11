From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: how to speed up "git log"?
Date: Mon, 12 Feb 2007 00:56:36 +0100 (CET)
Message-ID: <Pine.LNX.4.63.0702120051240.22628@wbgn013.biozentrum.uni-wuerzburg.de>
References: <200702111252.28393.bruno@clisp.org>
 <Pine.LNX.4.63.0702111745170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <200702120041.27419.bruno@clisp.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bruno Haible <bruno@clisp.org>
X-From: git-owner@vger.kernel.org Mon Feb 12 00:56:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HGOYj-0004h2-EX
	for gcvg-git@gmane.org; Mon, 12 Feb 2007 00:56:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932934AbXBKX4i (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 18:56:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932935AbXBKX4i
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 18:56:38 -0500
Received: from mail.gmx.net ([213.165.64.20]:55973 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S932934AbXBKX4h (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 18:56:37 -0500
Received: (qmail invoked by alias); 11 Feb 2007 23:56:36 -0000
X-Provags-ID: V01U2FsdGVkX19vjKwmo81vGD+9aCvZ5CJIZj68c522ZFBYhV/gOb
	baBQ==
X-X-Sender: gene099@wbgn013.biozentrum.uni-wuerzburg.de
In-Reply-To: <200702120041.27419.bruno@clisp.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39338>

Hi,

On Mon, 12 Feb 2007, Bruno Haible wrote:

> > Yes, because there were only 147 commits which changed the file. But git 
> > looked at all commits to find that.
> 
> Ouch.

Not so ouch:

> > Basically, we don't do file versions. File versions do not make sense, 
> > since they strip away the context.

You could have it faster, but you'd break a very useful concept by doing 
so.

> Is there some other concept or command that git offers? I'm in the 
> situation where I know that 'tr' in coreutils version 5.2.1 had a 
> certain bug and version 6.4 does not have the bug, and I want to review 
> all commits that are relevant to this.

So, only look at those:

	git log v5.2.1..v6.4 tr.c

(provided you have the tags for the releases). You can start reviewing 
right away, since the output will start very fast (much faster than it 
takes to complete the log!).

If you want to get the patches to tr.c with the logs, just add "-p":

	git log -p v5.2.1..v6.4 tr.c

> > > 2) Why so much system CPU time, but only on MacOS X?
> > 
> > Probably the mmap() problem. Does it go away when you use git 
> > 1.5.0-rc4?
> 
> No, it became even worse: git-1.5.0-rc4 is twice as slow as git-1.4.4 for
> this command:
>   git-1.4.4: 25 seconds real time, 24 seconds of CPU time (12 user, 12 system)
>   git-1.5.0: 50 seconds real time, 39 seconds of CPU time (20 user, 19 system)

Hmmm. I don't have MacOSX any more, so I cannot investigate. You might 
find this the perfect opening into working on git ;-)

Hth,
Dscho
