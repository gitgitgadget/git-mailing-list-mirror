X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git and bzr
Date: Wed, 29 Nov 2006 09:29:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611290922410.3513@woody.osdl.org>
References: <45357CC3.4040507@utoronto.ca> <87slhcz8zh.wl%cworth@cworth.org>
 <a7e835d40610260152k658aeaf0hb900cb63870c04e4@mail.gmail.com>
 <7vu01ro20b.fsf@assigned-by-dhcp.cox.net> <a7e835d40610260257r5f05ea4gc934f1c1cc267977@mail.gmail.com>
 <20061026101038.GA13310@coredump.intra.peff.net> <877iyne4dm.fsf@alplog.fr>
 <Pine.LNX.4.64.0610260753090.3962@g5.osdl.org> <456B7C6A.80104@webdrake.net>
 <845b6e870611280410j58bdcd99nc05d0f67489293e4@mail.gmail.com>
 <ekhaeg$etk$1@sea.gmane.org> <Pine.LNX.4.63.0611281433270.30004@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611280754050.30076@woody.osdl.org> <456C7592.6020700@ableton.com>
 <ekhtnt$rkk$1@sea.gmane.org> <456C9DFF.1040407@onlinehome.de>
 <456CA981.4010808@onlinehome.de> <Pine.LNX.4.64.0611281346490.4244@woody.osdl.org>
 <456CB197.2030201@onlinehome.de> <Pine.LNX.4.64.0611281413310.4244@woody.osdl.org>
 <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Wed, 29 Nov 2006 17:31:42 +0000 (UTC)
Cc: Nicholas Allen <nick.allen@onlinehome.de>,
	Jakub Narebski <jnareb@gmail.com>,
	bazaar-ng@lists.canonical.com, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611291149440.30004@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32652>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpTGo-000802-Aq for gcvg-git@gmane.org; Wed, 29 Nov
 2006 18:30:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967482AbWK2Rat (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 12:30:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S935852AbWK2Rat
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 12:30:49 -0500
Received: from smtp.osdl.org ([65.172.181.25]:25250 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S934979AbWK2Ras (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 12:30:48 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kATHTrix012801
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 29
 Nov 2006 09:30:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kATHTq0d003238; Wed, 29 Nov
 2006 09:29:52 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Wed, 29 Nov 2006, Johannes Schindelin wrote:
> 
> On Tue, 28 Nov 2006, Linus Torvalds wrote:
> > 
> > The go-to command tends to be "git diff", which after a merge will not 
> > show anything that already merged correctly (because it will have been 
> > updated in the git index _and_ updated in the working tree, so there will 
> > be no diff from stuff that auto-merged).
> 
> This is actually the most meaningful argument for not hiding the index. 
> Usually I explain it to people as a "staging area" standing between your 
> working directory, and the next committed state.
> 
> But I will start explaining the index with "what if your merge failed?".

The thing is, the staging area is needed for a lot more than just merges. 
Every single SCM has one, because even something as _trivial_ as "commit 
all files" actually needs it. People don't just always think about it, and 
the git staging area is "bigger" than most others.

Most other SCM's have a staging area that is just a list of filenames 
(nobody thinks about it, but "commit everything" doesn't actually commit 
everything at all - it just commits everything /in the list of files that 
the SCM knows about/).

Git's staging area is just more complete than most other SCM's. It 
contains not just the list of filenames, but their permissions too (where 
a lot of other SCM's *cough*CVS*cough don't do permissions at all), but 
also their content, and in the case of a merge conflict, the content of 
the base version and the two branches to be merged.

So the index really _is_ required for pretty much all operations 
(including very much "git commit -a", if only because of the filename 
list), but yeah, if you start by talking about merge conflicts, maybe 
people understand WHY it's also important to actually stage the _contents_ 
of a file too (multiple times, in fact, for a merge conflict), not just 
its name.

So most of the time, when you use git, you can ignore the index. It's 
really important, and it's used _all_ the time, but you can still mostly 
ignore it. But when handling a merge conflict, the index is really what 
sets git apart, and what really helps a LOT.

I've used other systems, but the git handling of merge conflicts really is 
superior. Other SCM's think that the merge algorithm is interestign and 
important, and that's bullshit. Merge algorithms are largely trivial and 
uninteresting. The interestign and important thing is to just handle 
failures well, and git does that _really_ well.

