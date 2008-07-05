From: "Edward Z. Yang" <edwardzyang@thewritingpot.com>
Subject: Re: Git, merging, and News/Relnotes files
Date: Sat, 05 Jul 2008 15:07:08 -0400
Message-ID: <486FC65C.70602@thewritingpot.com>
References: <g4n7j6$359$1@ger.gmane.org> <alpine.LFD.1.10.0807051119170.2815@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: torvalds@linux-foundation.org, pdebie@ai.rug.nl
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 05 21:08:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KFD7S-00011W-0o
	for gcvg-git-2@gmane.org; Sat, 05 Jul 2008 21:08:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751246AbYGETHZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jul 2008 15:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbYGETHZ
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Jul 2008 15:07:25 -0400
Received: from main.gmane.org ([80.91.229.2]:34267 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750722AbYGETHY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jul 2008 15:07:24 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1KFD6R-0008Vj-Ce
	for git@vger.kernel.org; Sat, 05 Jul 2008 19:07:23 +0000
Received: from ool-18e45099.dyn.optonline.net ([24.228.80.153])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 19:07:23 +0000
Received: from edwardzyang by ool-18e45099.dyn.optonline.net with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Sat, 05 Jul 2008 19:07:23 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: ool-18e45099.dyn.optonline.net
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
In-Reply-To: <alpine.LFD.1.10.0807051119170.2815@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87459>

Linus Torvalds wrote:
> So the first thing you should do is probably to just *try* adding that
> 
> 	NEWS merge=union
> 
> line to your .gitattributes file, and see if it works for you.

Sounds like a good first-step. It's very unlikely that we're going to
bother writing our own merge strategy for the NEWS file, so if union
ends up being more trouble than its worth, we'll probably end sticking
with manual merges.

Pieter also suggested (for some reason, I don't see the post on this
list) the git-merge-changelog driver from Gnu Savannah. Unfortunately,
the log format is a little different from ours (entries are sorted into
BC-incompatible, features, bugfixes and internal changes), so the driver
may not work (it's still worth a try, I imagine).

I'm slightly surprised no one suggested that I can the file, given that
both Git and the Linux kernel don't have one.

> For example, the default 'union' merge will literally _duplicate_ 
> identical that were added in both branches. So if you cherry-pick a commit 
> so that it exists both in the branch you are merging _and_ the branch you 
> are merging into, then any additions to the NEWS file will basically show 
> up twice, and yet auto-merge "cleanly".

I suppose that's why we have git reset --hard HEAD~. :-) I will
certainly keep this gotcha in mind.
