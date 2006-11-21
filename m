X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Submodules in GIT
Date: Wed, 22 Nov 2006 00:54:29 +0100
Message-ID: <20061121235429.GH5443@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20061120215116.GA20736@admingilde.org> <ejt9dh$kfm$1@sea.gmane.org> <7v7ixp20za.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611201501230.3338@woody.osdl.org> <20061121223130.GA24909@nan92-1-81-57-214-146.fbx.proxad.net> <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Tue, 21 Nov 2006 23:55:38 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0611211437430.3338@woody.osdl.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32060>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GmfSQ-0003H2-2p for gcvg-git@gmane.org; Wed, 22 Nov
 2006 00:55:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1756882AbWKUXzN (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 21 Nov 2006
 18:55:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756883AbWKUXzM
 (ORCPT <rfc822;git-outgoing>); Tue, 21 Nov 2006 18:55:12 -0500
Received: from smtp3-g19.free.fr ([212.27.42.29]:62627 "EHLO
 smtp3-g19.free.fr") by vger.kernel.org with ESMTP id S1756882AbWKUXzK (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 21 Nov 2006 18:55:10 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net
 [81.57.214.146]) by smtp3-g19.free.fr (Postfix) with ESMTP id EDC7549F5D;
 Wed, 22 Nov 2006 00:55:08 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000) id EFC471F06E;
 Wed, 22 Nov 2006 00:54:29 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

On Tue, Nov 21, 2006 at 02:51:56PM -0800, Linus Torvalds wrote:
> 
> 
> On Tue, 21 Nov 2006, Yann Dirson wrote:
> > 
> > I'm not sure I get the reason why the submodule should not be recorded
> > on "commit level".
> 
> Because that would be STUPID.
> 
> What does the submodules have to do with the commit level? Nothing. Nada. 
> Zero.

Oh, I see I may have expressed something in the wrong way :)
Namely, I brought an idea coming from partial merges into a discussion
on submodules, because when thinking about the former, I realized
we could maybe use similar mechanisms for both.

Note that the proposal I outlined did not break the tree, in that the
sumodule tree is still in the same place.  In the case of a partial
merge, the info that a subtree has been merged in this commit is indeeed
part of the commit itself.

I agree that the subtree case is somewhat different, and my idea may not
apply to submodules after all :)

A question would be, do "submodules" have to be permanent objects ?
I suppose it depends on what people want to use them for.  Indeed, the
"submodule" names strongly carries the idea of a permanent subset of the
repository.  My proposal partial merges could be seen as using transient
submodules: they do not matter much during most of the repo life.

Put it another way, I see the proposal of allowing tree entries to be
commits in addition to trees and blobs, akin to recording the submodule
_history_ inside the _tree_, which I feel precisely violates the
distinction you want to keep between those 2 concepts.


> And a sub-project simply doesn't even _do_ that. Much of the time, a 
> subproject stays constant, and is not something that comes and goes on an 
> individual commit basis. 

What about the case of a subproject that would evolve fast, and for
which we may not want intermediate versions to be part of the
supermodule ?  (just exploring an idea without real connection to the
one discussed above)

I mean, I have a tree in which the whole software for an embedded
platform is stored, including kernel, apps, etc.  While working on the
kernel, I may want to do several commits to that submodule, and may not want
to commit to the supermodule for each kernel commit, only when I feel the
kernel is stable enough.

One may argue I just have to use a branch.  Anyway, there will be a need
for submodule-specific branches - eg. kernel.org ones in my case.

An alternative would be to allow committing to the submodule without
creating matching supermodule commits, and let the user decide when he
wants to commit at the higher level.  That way, 2 successive supermodule
commits could have non-successive "subcommits".

Best regards,
-- 
