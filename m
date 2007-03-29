From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: basics... when reading docs doesn't help
Date: Thu, 29 Mar 2007 15:35:29 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 00:35:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HX3Dd-00035y-VC
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 00:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422675AbXC2Wfl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 18:35:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422684AbXC2Wfl
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 18:35:41 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41588 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422675AbXC2Wfk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 18:35:40 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2TMZVU2001668
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 29 Mar 2007 15:35:31 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2TMZTU9013954;
	Thu, 29 Mar 2007 15:35:30 -0700
In-Reply-To: <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
X-Spam-Status: No, hits=-0.463 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43486>



On Fri, 30 Mar 2007, Guennadi Liakhovetski wrote:
> > > 
> > > How about suggesting "clone -l -s"?
> 
> Yes, but how do "advanced git users" kernel developers work? Do they just 
> do 1 clone and build / clean every time they want to test another 
> configuration / arch, or do they clone -l or what? Do they create branches 
> for each development thread, then pull / push between trees?...

I suspect it depends on the developer.

I end up just using different branches and switching between them, but 
then, my branches tend to all be pretty small test-stuff (I only end up 
using one main branch, since 99% of what I do is merge other peoples stuff 
that has already gone through a test-cycle).

> But I don't want to re-build. Apart from i386 I build for a couple of ARM 
> and PPC targets too...

You're probably fine with "git clone -l -s" then.

> Strange. Is my git 1.4.0 criminally broken? I have a clone of Linus' tree 
> on a USB disk on ext3 without any objects, which I just cloned at some 
> point and then did a couple of pulls from the same source. Now
> 
> 1545084 /mnt/sda2/kernel-git/linux-2.6/
> 1255084 /mnt/sda2/kernel-git/linux-2.6/.git

The old git that always exploded all pulls and generated lots of loose 
objects? You can check with "git count-objects".

And to fix it, just do a "git gc" (or with older git versions, the secret 
handshake is just a simple "git repack -a -d").

> But that's a freshly cloned tree, without any pulls. I re-cloned it, 
> because the tree I had earlier had the problem with each pull:
> 
> Unpacking 12452 objects
>  100% (12452/12452) done
> * refs/heads/origin: does not fast forward to branch 'master' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
>   not updating.

Sounds like either Paul re-based his tree, or you did some work on your 
"origin" branch..

			Linus
