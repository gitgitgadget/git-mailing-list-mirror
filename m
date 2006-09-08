From: fork0@t-online.de (Alex Riesen)
Subject: Re: git refuses to switch to older branches
Date: Sat, 9 Sep 2006 00:00:53 +0200
Message-ID: <20060908220053.GA6011@steel.home>
References: <20060819202558.GE30022@admingilde.org> <7vac601hbb.fsf@assigned-by-dhcp.cox.net> <20060820072612.GA6003@steel.home> <20060820121935.GF30022@admingilde.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 09 00:01:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GLoPo-0003BN-4v
	for gcvg-git@gmane.org; Sat, 09 Sep 2006 00:01:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751084AbWIHWBd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 8 Sep 2006 18:01:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWIHWBd
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Sep 2006 18:01:33 -0400
Received: from mailout07.sul.t-online.com ([194.25.134.83]:11694 "EHLO
	mailout07.sul.t-online.com") by vger.kernel.org with ESMTP
	id S1751084AbWIHWBb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Sep 2006 18:01:31 -0400
Received: from fwd29.aul.t-online.de 
	by mailout07.sul.t-online.com with smtp 
	id 1GLoPR-0007Nk-00; Sat, 09 Sep 2006 00:01:13 +0200
Received: from tigra.home (bRlB7MZD8exr01EKW+hSk7p1XWa6MdYxRvLM2TV0xrMCh7nnPgDGcx@[84.160.126.157]) by fwd29.sul.t-online.de
	with esmtp id 1GLoPF-1Osu5w0; Sat, 9 Sep 2006 00:01:01 +0200
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id A69D1277AF;
	Sat,  9 Sep 2006 00:00:53 +0200 (CEST)
Received: from raa by steel.home with local (Exim 4.42 #1 (Debian))
	id 1GLoP7-0005qy-W6; Sat, 09 Sep 2006 00:00:54 +0200
To: Martin Waitz <tali@admingilde.org>
Content-Disposition: inline
In-Reply-To: <20060820121935.GF30022@admingilde.org>
User-Agent: Mutt/1.5.11
X-ID: bRlB7MZD8exr01EKW+hSk7p1XWa6MdYxRvLM2TV0xrMCh7nnPgDGcx
X-TOI-MSGID: 2f120095-fc36-46cd-b9d8-3a0c93ed0174
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26719>

Sorry for the answer long overdue, I was on vacation, and quite off
of the internet.

Martin Waitz, Sun, Aug 20, 2006 14:19:35 +0200:
> On Sun, Aug 20, 2006 at 09:26:12AM +0200, Alex Riesen wrote:
> > Junio C Hamano, Sun, Aug 20, 2006 00:39:20 +0200:
> > > Martin Waitz <tali@admingilde.org> writes:
> > > 
> > > > This safety measure is quite useful normally, but for files that are
> > > > explicitly marked as to-be-ignored it should not be neccessary.
> > > >
> > > > But all the code that handles .gitignore is only used by ls-files now.
> > > > Does it make sense to add exclude handling to unpack-trees.c, too?
> > > 
> > > In principle, I am not opposed to the idea of making read-tree
> > > take the ignore information into consideration.
> > > 
> > > But I would suggest you to be _extremely_ careful if you want to
> > 
> > It should be optional. And off by default, people already have got
> > scripts depending on this behaviour (well, I have).
> 
> but having this sort of behaviour optional is bad, I think.
> Some people will depend on one semantic and others on the other.
> And then get bite if they want to share their scripts.

So at least give the people who got there first a chance to have
their scripts working. Why break them?

> We have to find _one_ semantic that always works.

Well, the current semantics always work.

> > > try this.  I do not have an example offhand, but I would not be
> > > surprised at all if there is a valid use case where it is useful
> > > to have a pattern that matches a tracked file in .gitignore
> > > file.
> > 
> > Ignored directory and but some files/subdirectories in it are tracked,
> > because this is temporary or externally changed data (I have both
> > examples).
> 
> but do you have non-tracked files in the ignored directory that you
> really care about, i.e. which must not be overridden by a tracked file
> with the same name?
> 

I don't, but I can easily imagine someone has: a file contained some
build-local configuration, which developer later decided to start
tracking. Like config.mak in git.
