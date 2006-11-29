X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH 0/2] Making "git commit" to mean "git commit -a".
Date: Wed, 29 Nov 2006 13:08:52 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0611291234350.9647@xanadu.home>
References: <Pine.LNX.4.64.0611271622260.9647@xanadu.home>
 <7vmz6cfsuw.fsf@assigned-by-dhcp.cox.net> <87bqmswm1e.wl%cworth@cworth.org>
 <7vodqse90q.fsf@assigned-by-dhcp.cox.net> <87ac2cwha4.wl%cworth@cworth.org>
 <7vy7pwcsgp.fsf@assigned-by-dhcp.cox.net> <878xhwwdyj.wl%cworth@cworth.org>
 <7vk61gcnzl.fsf@assigned-by-dhcp.cox.net>
 <7vd5786opj.fsf@assigned-by-dhcp.cox.net> <871wnnwi3k.wl%cworth@cworth.org>
 <7virgzuf38.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611282322320.9647@xanadu.home>
 <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Wed, 29 Nov 2006 18:09:23 +0000 (UTC)
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <7vr6vmsnly.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32653>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpTrl-0001Sg-NS for gcvg-git@gmane.org; Wed, 29 Nov
 2006 19:09:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967492AbWK2SIy (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 29 Nov 2006
 13:08:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967496AbWK2SIy
 (ORCPT <rfc822;git-outgoing>); Wed, 29 Nov 2006 13:08:54 -0500
Received: from relais.videotron.ca ([24.201.245.36]:30367 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S967492AbWK2SIx (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 29 Nov 2006 13:08:53 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J9I00C307QSORG0@VL-MO-MR002.ip.videotron.ca> for git@vger.kernel.org; Wed,
 29 Nov 2006 13:08:53 -0500 (EST)
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Tue, 28 Nov 2006, Junio C Hamano wrote:

> Nicolas Pitre <nico@cam.org> writes:
> 
> > This argument has its converse.  What you should _not_ have to worry 
> > about all the time is whether your index really includes all the changes 
> > you want included in your next commit.
> 
> That's what we have "git diff" with various output options for;
> I often do "git diff --stat" or "git diff --name-status" when I
> know I am about to commit in a dirty working tree.  I suspect
> that I am not getting your point.

I'm afraid this conversation is getting nowhere then.

> > And whether wanting to leave local changes in the working directory 
> > without commiting them actually happen more often than wanting to commit 
> > every changes is arguable.
> 
> I do not think anybody is talking about which happens more
> often.

But I do.

> "screw the index" people do not have to worry about the
> index during the course of their changes in the working tree
> toward the next commit, and the only time they need to tell git
> (which _IS_ a system based on the index, dammit) about what they
> want to do with the index is at the commit time, and they tell
> git to "screw the index" by passing "-a" to "git commit".

No one talked about "screw the index" people.  Those are happily using 
Cogito.

We're talking about flattening the GIT learning curve.  And as futile it 
may seem to you that newbies should just use "commit -a" without 
thinking, they still get bothered by that -a there.  And probably 
they'll forget about it once in a while and then GIT will _appear_ as 
malfunctioning to them.

Of course amongst those newbies that didn't went away at this point 
there will be those who decide to study further and come to the index 
concept.  And I hope that we all agree that the index is a powerful but 
still advanced concept that should not be presented up front.

But my point is: why not making a very little change to the default 
commit behavior. Really little change involving -a being the default.  
The impact on newbies will be significant as they won't have to grok 
everything at once to make sense of this -a we are telling them to use 
blindly. And it will sort of match known expectations to commit 
everything dirty.

And actually my point above is that in many cases, maybe the majoryty of 
those case but this is arguable, what one is doing is not keeping dirty 
and uncommited state around but rather committing every changes all the 
time.  In _that_ case, which might not be all the time but often enough, 
then using -a is annoying[1].

So having -a the default makes GIT much more friendly to new users.  You 
"add" files, you "commit", you edit some files, you "commit" again, and 
everything works fine, and you are happy and starts feeling good about 
GIT.

Now for those who've seen the light and want to use the index it is not 
much of a bother to add a -i to their commit invokation.  At this point 
if you understand the index you know what you're doing, and using -i 
won't bother you as much it bothered you to use -a without knowing 
why when you was a newbie.

But still, if you are a GIT old fart and have difficulties switching 
habits, or if you simply are the kind with dirty not-to-commit state in 
your tree and adding -i all the time bothers you just like [1] above, 
then there is a way out!  You are a GIT expert at this point of course 
and certainly know how to add an alias for the -i to be implicit with 
your "commit".

Therefore I think this is much more logical to ask the experts to add an 
alias for "commit -i" than asking such tricks from less experienced 
users. This is all my point is about.


