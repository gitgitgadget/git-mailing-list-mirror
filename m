From: Alex Riesen <raa.lkml@gmail.com>
Subject: Re: pull into dirty working tree
Date: Wed, 13 Jun 2007 23:39:31 +0200
Message-ID: <20070613213931.GD3412@steel.home>
References: <18031.64456.948230.375333@lisa.zopyra.com> <86zm33291h.fsf@blue.stonehenge.com> <20070613192828.GB3412@steel.home> <86645r1wh8.fsf@blue.stonehenge.com> <20070613204711.GC3412@steel.home> <86odjjziek.fsf@blue.stonehenge.com>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Bill Lear <rael@zopyra.com>, git@vger.kernel.org
To: "Randal L. Schwartz" <merlyn@stonehenge.com>
X-From: git-owner@vger.kernel.org Wed Jun 13 23:39:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyaYz-0003S6-JG
	for gcvg-git@gmane.org; Wed, 13 Jun 2007 23:39:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753406AbXFMVjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jun 2007 17:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752915AbXFMVjg
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jun 2007 17:39:36 -0400
Received: from mo-p07-ob.rzone.de ([81.169.146.188]:63675 "EHLO
	mo-p07-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752826AbXFMVjf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jun 2007 17:39:35 -0400
Received: from tigra.home (Fcb25.f.strato-dslnet.de [195.4.203.37])
	by post.webmailer.de (fruni mo25) (RZmta 7.2)
	with ESMTP id D01b89j5DIAToj ; Wed, 13 Jun 2007 23:39:31 +0200 (MEST)
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id 5E232277BD;
	Wed, 13 Jun 2007 23:39:31 +0200 (CEST)
Received: by steel.home (Postfix, from userid 1000)
	id 22DCAD261; Wed, 13 Jun 2007 23:39:30 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <86odjjziek.fsf@blue.stonehenge.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
X-RZG-AUTH: z4gQVF2k5XWuW3CcuQaHqBkvAA==
X-RZG-CLASS-ID: mo07
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50134>

Randal L. Schwartz, Wed, Jun 13, 2007 22:52:35 +0200:
> Alex> No, it wont. What files are you going to add?
> 
> Whatever you are working on.  Whatever you want tracked.  It's a commit.
> I'm not sure why you're having trouble following me.  What did I leave out?

You left the process of figuring out what files should be temporarily
added to the index. _Automatically_. Because that's what you need if
you want "git pull" to just work. Otherwise it just fails.

> >> git-rebase *will* do the merge.  It must. :)
> Alex> It won't merge anything which isn't known to git.
> 
> And that's irrelevant, because my first step *did* a commit so they are
> *known* to git.

It is not enough. It didn't add the "other" files to index, so the
files are _not_ known to git.

Imagine you added a file to Makefile (which was known to git), wrote
the file, put some code in it, played with it. Never called "git add"
on it yet (you were just playing, as original poster suggested).
Now someone from team calls and asks you to tests his changes (and
imagine he added a file with exactly the same name as yours). You do a
pull from his repo and it breaks. With your method it will break too,
"git commit -a" wont add your file to index.

> Alex>  Now, I come to think
> Alex> about it, no existing merge method will help you here (and very likely
> Alex> it shouldn't).
> 
> Yes, it should.  You're merging your changes onto the upstream.  This
> happens dozens of times a day with git repos all over the world. :)

Other way around. You merge upstream in your branch. And it conflicts
with work you haven't told git about just yet.

> Alex> It is actually much simplier doing things right: all this stashing
> Alex> people keep talking about.
> 
> Yes, and that's what I said too.
> 

You (and others) just keep forgetting about this small detail with
"other" files. Junio noticed it too. This "small" detail can make the
whole stashing bussiness impossible except for maybe a common case.
Which is not very helpful for a newbie who meets the uncommon, but his
case. He'll learn his way though, of course. After saying out loud:
"git sucks!"; which what they already do.
