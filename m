From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: Question about handling of heterogeneous repositories
Date: Wed, 23 Nov 2005 00:22:28 +0100
Message-ID: <20051122232228.GB2916@steel.home>
References: <81b0412b0511220850w429d2f36lafe9de7ce19ce8f@mail.gmail.com> <43837442.9060602@op5.se>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 23 00:25:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EehTD-0005P9-2M
	for gcvg-git@gmane.org; Wed, 23 Nov 2005 00:22:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVKVXWg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 Nov 2005 18:22:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030246AbVKVXWg
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Nov 2005 18:22:36 -0500
Received: from devrace.com ([198.63.210.113]:25351 "EHLO devrace.com")
	by vger.kernel.org with ESMTP id S1030245AbVKVXWf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 22 Nov 2005 18:22:35 -0500
Received: from tigra.home (p54A0E32F.dip.t-dialin.net [84.160.227.47])
	(authenticated bits=0)
	by devrace.com (8.12.11/8.12.11) with ESMTP id jAMNMUV0003185;
	Tue, 22 Nov 2005 17:22:31 -0600 (CST)
	(envelope-from fork0@users.sourceforge.net)
Received: from steel.home ([192.168.1.2])
	by tigra.home with esmtp (Exim 3.36 #1 (Debian))
	id 1EehT2-0000gA-00; Wed, 23 Nov 2005 00:22:28 +0100
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1EehT2-0000vK-KV; Wed, 23 Nov 2005 00:22:28 +0100
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <43837442.9060602@op5.se>
User-Agent: Mutt/1.5.6i
X-Spam-Status: No, score=1.8 required=4.5 tests=AWL,BAYES_50,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.2
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.0.2 (2004-11-16) on devrace.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12585>

Andreas Ericsson, Tue, Nov 22, 2005 20:40:50 +0100:
> >it is sometimes the case that a project consists of parts which are
> >unrelated to each other, and only thing in common between them is that
> >they all are used in that particular project. For example a program
> >uses some library and the developer(s) of that program would like to
> >have the source of that library somewhere close. Well, for this simple
> >example one could just use two repositories, laid close to each other
> >in a directory, like project/lib and project/prog.
> >Now, if I make the example a bit more complex and say, that the
> >developers of the program are the developers in that project and
> >change everything under project/ directory, including
> >project/library/. They are also good people and ready to give the
> >changes to the library upstream.
> >
> >How do they achieve that, without sending project/ and project/program/?
> >
> >For everyone who have an experience with ClearCase or Perforce (I'm
> >sorry for mentioning it) it is what the "mappings" are often used for:
> >a project is build together from different parts, which can be worked
> >on separately.
> >
> >I'm trying to introduce git at work, but have to prepare myself for
> >possible questions first, and this is one of them :)
> >
> 
> We do like this;
> 
> core
> core/gui
> core/lib
> 
> $ cat .gitignore
> gui
> lib
> 
> This is also nice because it lets the gui maintainers have the gui as 
> the root with the core and lib parts as subdirectories. Everyone has 
> their own responsibility checked out at top-level with other pieces 
> below it. It's easy enough to script a pull of all repos so everyone's 
> up to sync and everybody's happy.

And than, do you have to announce a special procedure everyone's is to
execute after a clone so all subrepos are cloned? How do you handle
common configs and clone options in subrepos? It also would be nice to
have branches visible not only in in subrepos but in top-repo as well,
and the other way around.

I'm also wondering, what implications core/lib/.git/{config,remotes/,refs/}
under control in core/ can have?..

> It would certainly be nicer to have git ignore directories that have the 
> ".git" directory (so long as it's not the top of the repo, that is), but 
> I haven't had the energy to fix that when there's already a solution 
> that's simple enough and quite adequate.

BTW, will something like "*/.git/*" in info/exclude work? IOW, does *
match a "/"?
