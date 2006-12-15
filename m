X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] make commit message a little more consistent and conforting
Date: Fri, 15 Dec 2006 11:01:55 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612151032240.18171@xanadu.home>
References: <7v4przfpir.fsf@assigned-by-dhcp.cox.net>
 <200612132237.10051.andyparkins@gmail.com>
 <7vk60vbcfz.fsf@assigned-by-dhcp.cox.net>
 <200612140959.19209.andyparkins@gmail.com>
 <7v7iwu93rv.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0612141343200.18171@xanadu.home>
 <Pine.LNX.4.64.0612142307160.18171@xanadu.home>
 <20061215042459.GC27343@spearce.org> <45825E0B.5010200@op5.se>
 <20061215150909.GE17860@spearce.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Fri, 15 Dec 2006 16:02:19 +0000 (UTC)
Cc: Andreas Ericsson <ae@op5.se>, Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <20061215150909.GE17860@spearce.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/34525>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GvFVn-0006fi-BD for gcvg-git@gmane.org; Fri, 15 Dec
 2006 17:02:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1752785AbWLOQCK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 15 Dec 2006
 11:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbWLOQCK
 (ORCPT <rfc822;git-outgoing>); Fri, 15 Dec 2006 11:02:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:14299 "EHLO
 relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
 id S1752785AbWLOQCJ (ORCPT <rfc822;git@vger.kernel.org>); Fri, 15 Dec 2006
 11:02:09 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0JAB00GEPOJ7YOD0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Fri,
 15 Dec 2006 11:01:55 -0500 (EST)
To: Shawn Pearce <spearce@spearce.org>
Sender: git-owner@vger.kernel.org

On Thu, 14 Dec 2006, Shawn Pearce wrote:

> Nicolas Pitre <nico@cam.org> wrote:
> > It is nicer to let the user know when a commit succeeded all the time, 
> > not only the first time.  Also the commit sha1 is much more useful than 
> > the tree sha1 in this case.
> 
> I agree the commit sha1 is more useful than the tree sha1, but I'm
> not really sure its useful to show the commit sha1 post commit.

It is useful, even if it is not essential.

Since I believe it is a good thing to display _something_ by default 
(and not only with -v as suggested -- please see the reasoning I posted 
yesterday as to what should have some output and what shouldn't), it 
doesn't hurt to display the commit sha1 as well.

First it has the very desirable side effect of making the user slightly 
aware of how git identifies things.  From the first commit a new user 
will notice that git doesn't use any incremental version number but a 
unique identifier that has nothing to do with sequence.  It is not 
expected that people will start _using_ the information printed, but it 
will at least give a feel of how git works.  And it is not like if the 
whole thing took multiple lines to be displayed.

Next it _might_ be used by people.  The fact that it is there might turn 
to be useful.  It is useful in the context of Documentation/tutorial-2.txt
for one where the notion of objects and their relationship is explained 
based on the least amount of steps possible.

So in short I do think there should be something shown after a 
successful commit, and including the commit sha1 doesn't hurt.

> If you want to show something the diffstat like what git merge does
> is better.
> 
> For one thing it confirms that git accepted the changes.  For another
> it shows you *which* changes it accepted.  Plus it responds just
> like git-merge or git-pull does.

I disagree.  My patch does confirm that git accepted the change with 
only one line.  As to which changes were accepted I think that when you 
do the commit you certainly have a pretty good idea already of what is 
going to be committed (you modified/added/removed files yourself, and by 
default git-commit provides you with a summary in the text editor for 
the commit message).

On Fri, 15 Dec 2006, Shawn Pearce wrote:

> Andreas Ericsson <ae@op5.se> wrote:
> > diffstats can be huge though. I'd rather have those only with -v option.
> 
> But they are on by default for pull/merge, and disabled by -n.
> 
> They are on to tell you what you just got during the pull/merge.

The pull/merge case is different.  You are most likely to not know in 
advance what the overall changes will be.  Of course you're supposed to 
know what you're pulling, but unlikely to know about the detail since 
what you merge is remote to your current working tree by definition, and 
even if you happen to be the one who did the changes in the other 
branch/repo, it is certainly not as fresh in your mind than the changes 
you did prior a commit.

And it is true that diffstat can be quite large.  I wouldn't mind the 
diffstat to be added to the commit message summary in the text editor 
though.  And displaying it when -v is used makes also a lot of sense.  
But not by default please.


