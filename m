From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git, merging, and News/Relnotes files
Date: Sat, 5 Jul 2008 13:03:00 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0807051253000.2815@woody.linux-foundation.org>
References: <g4n7j6$359$1@ger.gmane.org> <alpine.LFD.1.10.0807051119170.2815@woody.linux-foundation.org> <486FC65C.70602@thewritingpot.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: pdebie@ai.rug.nl, Git Mailing List <git@vger.kernel.org>
To: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
X-From: git-owner@vger.kernel.org Sat Jul 05 22:04:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFDzo-0005OI-1i
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 22:04:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752355AbYGEUDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 16:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752194AbYGEUDi
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 16:03:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37535 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752167AbYGEUDh (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 5 Jul 2008 16:03:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m65K30qZ017073
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sat, 5 Jul 2008 13:03:01 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m65K30Nq004158;
	Sat, 5 Jul 2008 13:03:00 -0700
In-Reply-To: <486FC65C.70602@thewritingpot.com>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.362 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87460>



On Sat, 5 Jul 2008, Edward Z. Yang wrote:
> 
> I'm slightly surprised no one suggested that I can the file, given that
> both Git and the Linux kernel don't have one.

Well, I personally think ChangeLog files are a total waste of time. You're 
much better off autogenerating those from the real logs, I think.

[ Although in all honesty, I also think we could improve on our reporting 
  tools, and have ways to perhaps highlight big or important changes some 
  way ]

But a NEWS file that actually talks about new features is a different 
thing. It can make lots of sense to maintain something like that, so I 
wouldn't suggest canning it if it works for you. I'm not convinced it 
would work for the kernel, but I suspect it can work really well for other 
projects.

> > For example, the default 'union' merge will literally _duplicate_ 
> > identical that were added in both branches. So if you cherry-pick a commit 
> > so that it exists both in the branch you are merging _and_ the branch you 
> > are merging into, then any additions to the NEWS file will basically show 
> > up twice, and yet auto-merge "cleanly".
> 
> I suppose that's why we have git reset --hard HEAD~. :-) I will
> certainly keep this gotcha in mind.

Well, the real problem with a clean automatic merge is not that it can't 
be undone (or better yet - fixed: just edit the NEWS file and then do a 
"git commit --amend NEWS" to fix up the atomatic merge), but the fact that 
most of the time you'll simply never even notice.

IOW, when something merges cleanly (and the 'union' merge will basically 
always do so), the most common case is probably that people won't even 
_look_ at the end result - especially if it works fine most of the time. 

That's why a trivial conflict can often be better than a silently clean 
merge: at least it forces people to spend a small amount of brainpower to 
look at the obvious fix.

But hey, give it a try. Maybe you'll like the union merge, together with 
occasional manual fixups. Or maybe you'll decide that a specialized merge 
strategy isn't that painful after all (or can find somebody who already 
went through the pain and wrote one you can use).

		Linus
