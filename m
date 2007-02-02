From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: newbie questions about git design and features (some wrt hg)
Date: Fri, 2 Feb 2007 11:01:08 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702021050350.15057@woody.linux-foundation.org>
References: <3c6c07c20701300820l42cfc8dbsb80393fc1469f667@mail.gmail.com>
 <200702010058.43431.jnareb@gmail.com> <20070201003429.GQ10108@waste.org>
 <200702021055.49428.jnareb@gmail.com> <slrnes6mmr.3l6.mdw@metalzone.distorted.org.uk>
 <epvnln$fmn$1@sea.gmane.org> <Pine.LNX.4.64.0702020835550.15057@woody.linux-foundation.org>
 <20070202175923.GA6304@xanadu.kublai.com> <20070202182709.GA3861@kobe.laptop>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: jnareb@gmail.com, mercurial@selenic.com, git@vger.kernel.org
To: Giorgos Keramidas <keramida@ceid.upatras.gr>
X-From: git-owner@vger.kernel.org Fri Feb 02 20:01:37 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HD3fA-0006Gy-3L
	for gcvg-git@gmane.org; Fri, 02 Feb 2007 20:01:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422977AbXBBTB0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Feb 2007 14:01:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422985AbXBBTB0
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Feb 2007 14:01:26 -0500
Received: from smtp.osdl.org ([65.172.181.24]:35311 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422977AbXBBTBZ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Feb 2007 14:01:25 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l12J1943013573
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Feb 2007 11:01:10 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l12J18JD015170;
	Fri, 2 Feb 2007 11:01:09 -0800
In-Reply-To: <20070202182709.GA3861@kobe.laptop>
X-Spam-Status: No, hits=-0.415 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38525>



On Fri, 2 Feb 2007, Giorgos Keramidas wrote:
> 
> Sometimes, 'sliding a tag' is a real-world need.  Losing the information
> of who did the tag sliding and when, is not good.

In practice, this is not much of an issue. 

First off, CVS tag usage is insane, but it's insane for *other* reasons 
(ie people use tags differently in CVS, but they do it not because they 
want to use tags that way, but because CVS makes it impossible to do 
anything saner).

So pointing to CVS tag usage as an argument is pointless. You might as 
well say that you shouldn't save the merge information, because CVS 
doesn't do it, and manual tags are a good way to do it. 

Secondly, the problems with tags having "history" is that you can't really 
resolve them anyway. You have to pick one. You can't "merge" them. 

In other words, tags are atomic *events*, not history. And I certainly 
agree that you shouldn't lose the events (unless you want to, of course).

I also do agree that you can absolutely have something that is basically a 
"tag that moves, and that you want to tie back to the previous state of 
the tag". In git, we just happen to call those things "branches". You 
*could* technically put one of those things into the tag-namespace if you 
want to, although it would largely be considered insane by most git users 
(and you could see it historically: each "tag" would be a merge that 
points to its previous incarnation and to the point in time that got 
tagged).

More commonly, you'd just use a "real tag", which includes the tagger 
information and a message about why something got tagged, plus possibly a 
PGP signature. That way, you can see (and save) all the individual events.

		Linus
