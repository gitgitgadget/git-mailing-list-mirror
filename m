X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Petr Baudis <pasky@suse.cz>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 14:58:28 +0100
Message-ID: <20061116135828.GY7201@pasky.or.cz>
References: <87k61yt1x2.wl%cworth@cworth.org> <455A1137.8030301@shadowen.org> <87hcx1u934.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home> <87bqn9u43s.wl%cworth@cworth.org> <7vr6w5y7to.fsf@assigned-by-dhcp.cox.net> <7virhhy76h.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 13:58:48 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org,
	Andy Whitcroft <apw@shadowen.org>,
	Carl Worth <cworth@cworth.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611142048350.2591@xanadu.home>
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31584>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkhlD-0005Cv-12 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 14:58:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424062AbWKPN6b (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 08:58:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424064AbWKPN6b
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 08:58:31 -0500
Received: from w241.dkm.cz ([62.24.88.241]:31130 "EHLO machine.or.cz") by
 vger.kernel.org with ESMTP id S1424062AbWKPN6a (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 08:58:30 -0500
Received: (qmail 25788 invoked by uid 2001); 16 Nov 2006 14:58:28 +0100
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 05:32:06AM CET, Nicolas Pitre wrote:
> 1) make "git init" an alias for "git init-db".
> 
> What's the point of "-db"?  Sure we're initializing the GIT database.  
> But who cares?  The user doesn't care if GIT uses a "database" or 
> whatever.  And according to some people's definition of a "database" it 
> could be argued that GIT doesn't use a database at all in the purist 
> sense of it. What the user wants is to get started and "init" (without 
> the "-db" is so much more to the point. Doesn't matter if incidentally 
> it happens to be the same keyword HG uses for the same operation because 
> we are not afflicted by the NIH disease, right? And it has 3 chars less 
> to type which is for sure a premium improvement to the very first GIT 
> user experience!

(This is somewhat related to the HEAD issue, e.g.
<7v1wo3d6g4.fsf@assigned-by-dhcp.cox.net>, by virtue of basically
eliminating it.)

Let's see. If you are adding the alias, you can as well add some
porcelain stuffing in it, too.

What are the 99% of use cases when doing "init"?

(a) You are going to do an initial commit right away; the repository is
at this point basically useless for anything but initial commit. So you
might have "init" well just perform it for you right away.

(b) You are setting up a bare repository on a server and you will push
to it in a minute. Cogito has a separate cg-admin-setuprepo command for
it, which will also prepare it for usage by dumb servers and optionally
for shared usage in a group of users. Git could have something similar.


> 2) "pull" and "push" should be symmetrical operations
..snip..
> Conclusion:  git-pull must not perform any merge.  It is the symmetrical 
> operation of a push meaning that it pulls content from a remote branch 
> and does no more.  People understands that pretty well, .  This makes 
> git-fetch redundant (or an alias to git-pull) in that case, and again we 
> don't mind it becoming similar to in HG because we admit HG was right 
> about it.

If you _really_ want to do it in Git, the only sensible way to do it is
to stop using the "pull" verb for a command name altogether for at least
some rather long period of time, otherwise that's a blatant backwards
compatibility breakage.

> 3) remote branch handling should become more straight forward.
> 
> OK! Now that we've solved the pull issue and that everybody agrees with 
> me (how can't you all agree with me anyway) let's have a look at remote 
> branches.  It should be simple:
..snip..

By the way, due to the way you describe it, it's not all that clear to
me how is this (in)compatible with the current way we do it, on other
than the usage and git-pull's auto-creation magic level.

Is it that what you are describing _is_ in fact what we do support now,
with "branch groups" meaning "remotes" etc, and you are only proposing
some enhancements to automatically create remotes in git-pull, or are
there some other differences I've missed?

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
#!/bin/perl -sp0777i<X+d*lMLa^*lN%0]dsXx++lMlN/dsM0<j]dsj
$/=unpack('H*',$_);$_=`echo 16dio\U$k"SK$/SM$n\EsN0p[lN*1
