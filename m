X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: multi-project repos (was Re: Cleaning up git user-interface
 warts)
Date: Thu, 16 Nov 2006 16:49:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611161642320.3349@woody.osdl.org>
References: <87k61yt1x2.wl%cworth@cworth.org> <Pine.LNX.4.64.0611141518590.2591@xanadu.home>
 <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org>
 <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <455BBCE9.4050503@xs4all.nl> <Pine.LNX.4.64.0611151908130.3349@woody.osdl.org>
 <455C412D.1030408@xs4all.nl> <Pine.LNX.4.64.0611160814560.3349@woody.osdl.org>
 <455C94FA.3050903@xs4all.nl> <Pine.LNX.4.64.0611160904010.3349@woody.osdl.org>
 <455CA2A8.5010700@xs4all.nl> <Pine.LNX.4.64.0611160958170.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611162315110.13772@wbgn013.biozentrum.uni-wuerzburg.de>
 <Pine.LNX.4.64.0611161436230.3349@woody.osdl.org>
 <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 17 Nov 2006 00:50:26 +0000 (UTC)
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611170013590.13772@wbgn013.biozentrum.uni-wuerzburg.de>
X-MIMEDefang-Filter: osdl$Revision: 1.159 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31649>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gkrvq-0002xi-Sx for gcvg-git@gmane.org; Fri, 17 Nov
 2006 01:50:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424826AbWKQAtn (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 19:49:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424834AbWKQAtn
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 19:49:43 -0500
Received: from smtp.osdl.org ([65.172.181.4]:44451 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1424826AbWKQAth (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 19:49:37 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAH0nUoZ019340
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 16
 Nov 2006 16:49:30 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAH0nTps014042; Thu, 16 Nov
 2006 16:49:29 -0800
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org



On Fri, 17 Nov 2006, Johannes Schindelin wrote:
> > Why? We _do_ have the temporary branch. It's called FETCH_HEAD.
> 
> It is a terrible UI, because it was not that obvious to me. And I consider 
> myself not a git newbie.

Heh. The "temporary branches" are actually the _original_ branches as far 
as git is concerned. The long-term branches only came later.

So in many ways, HEAD, FETCH_HEAD, MERGE_HEAD and ORIG_HEAD are more 
fundamental than any long-term branch has ever been, and maybe they should 
be taught first as such.

So you're newbie enough that you've only seen those new-fangled "real" 
branches.

When I was young, we had to walk to school up-hill in three feet of snow 
every day. And we _liked_ our FETCH_HEAD's.

> Besides, it is not really a temporary branch. If it was, the pull would 
> _not_ download all these objects again, would it?

Well, exactly because they are temporary, we can't actually trust the 
objects they point to. They have no "real" long-term life, so no, I'm 
afraid that we always will have to re-fetch the objects, because fetching 
them is the only way to know that we still have them. 

That said, we could certainly _make_ them be honored by things like "git 
prune" and friends. But yes, they really _are_ temporary branches right 
now, and part of the meaning of that "temporary" is exactly the fact that 
git fetch will not trust that you still have the objects. 

For example, if you used one of the old-fashioned commit walkers, maybe we 
got the initial commit, but we may not have gotten the whole _chain_. See?

Temporary branch indeed.

> > Again, why didn't you use FETCH_HEAD?
> 
> Because I am a Jar-HEAD?

Well, we clearly should document them better. Anybody?

