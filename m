X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Cleaning up git user-interface warts
Date: Wed, 15 Nov 2006 19:07:11 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611151859370.3349@woody.osdl.org>
References: <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org>
 <200611151858.51833.andyparkins@gmail.com> <Pine.LNX.4.64.0611151111250.3349@woody.osdl.org>
 <f2b55d220611151139v66fba16ax97ce6b9966b33ce7@mail.gmail.com>
 <Pine.LNX.4.64.0611151203450.3349@woody.osdl.org> <Pine.LNX.4.64.0611151516360.2591@xanadu.home>
 <Pine.LNX.4.64.0611151226590.3349@woody.osdl.org> <87velgs9hx.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0611151339500.3349@woody.osdl.org> <87psbos4pb.wl%cworth@cworth.org>
 <20061115230252.GH24861@spearce.org> <Pine.LNX.4.64.0611151523290.3349@woody.osdl.org>
 <Pine.LNX.4.64.0611151905460.2591@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 16 Nov 2006 03:07:38 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, Carl Worth <cworth@cworth.org>,
	"Michael K. Edwards" <medwards.linux@gmail.com>,
	git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611151905460.2591@xanadu.home>
X-MIMEDefang-Filter: osdl$Revision: 1.156 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31547>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkXbA-0008IP-RZ for gcvg-git@gmane.org; Thu, 16 Nov
 2006 04:07:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1031045AbWKPDH3 (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 15 Nov 2006
 22:07:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031039AbWKPDH3
 (ORCPT <rfc822;git-outgoing>); Wed, 15 Nov 2006 22:07:29 -0500
Received: from smtp.osdl.org ([65.172.181.4]:52368 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1030950AbWKPDH2 (ORCPT
 <rfc822;git@vger.kernel.org>); Wed, 15 Nov 2006 22:07:28 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAG37CoZ023115
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Wed, 15
 Nov 2006 19:07:13 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAG37Bqs009205; Wed, 15 Nov
 2006 19:07:11 -0800
To: Nicolas Pitre <nico@cam.org>
Sender: git-owner@vger.kernel.org



On Wed, 15 Nov 2006, Nicolas Pitre wrote:
> 
> That is an implementation detail that should be easily overcome once the 
> notion of tracking branch with URL attribute is implemented.

Nope.

I simply don't _have_ those branches.

Why? Because the kernel is _distributed_. There is no central place 
(certainly not my repository) that tracks all the possible branches that 
might get merged.

In other words, I repeat: in a TRULY DISTRIBUTED ENVIRONMENT it makes more 
sense to have a "pull" that fetches and merges, over something that 
fetches separately and then merges. Because in a truly distributed 
environment, you simply DO NOT HAVE static branches that you can associate 
with particular sources.

See?

And the thing is, I think the git design should be geared towards true 
distribution. It should NOT be geared toward a fairly static set of 
branches that all have a fairly static set of other repositories 
associated with them. Can you see the difference?

I'm personally convinced that one of the reasons people tend to use git in 
a centralized manner is just a mental disease that has its roots in how 
they used _other_ SCM's. I don't want git design to be polluted by such a 
centralized notion.

So to repeat: you can always make "pull" boil down to "pull from myself" 
(aka just "merge"), but you can _not_ make "fetch + merge" boil down to 
"pull" without meking up extra state to track separately. In other words, 
"pull" really is the strictly more powerful operation.

