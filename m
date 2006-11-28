X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [RFC] Submodules in GIT
Date: Tue, 28 Nov 2006 13:53:29 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611281349540.4244@woody.osdl.org>
References: <Pine.LNX.4.64.0611251128170.3483@woody.osdl.org>
 <20061125234908.GC24909@nan92-1-81-57-214-146.fbx.proxad.net>
 <Pine.LNX.4.64.0611251936590.3483@woody.osdl.org> <Pine.LNX.4.64.0611260241320.20138@iabervon.org>
 <456C0313.3020308@op5.se> <Pine.LNX.4.64.0611281218290.20138@iabervon.org>
 <20061128180817.GA12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281315020.20138@iabervon.org>
 <20061128190618.GB12463MdfPADPa@greensroom.kotnet.org>
 <Pine.LNX.4.64.0611281407370.20138@iabervon.org> <20061128211012.GJ28337@spearce.org>
 <Pine.LNX.4.64.0611281614450.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Tue, 28 Nov 2006 21:58:20 +0000 (UTC)
Cc: Shawn Pearce <spearce@spearce.org>, skimo@liacs.nl,
	Andreas Ericsson <ae@op5.se>, Yann Dirson <ydirson@altern.org>,
	Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0611281614450.20138@iabervon.org>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32588>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpAxM-0000iv-7x for gcvg-git@gmane.org; Tue, 28 Nov
 2006 22:57:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1757263AbWK1V5d (ORCPT <rfc822;gcvg-git@m.gmane.org>); Tue, 28 Nov 2006
 16:57:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757214AbWK1V5d
 (ORCPT <rfc822;git-outgoing>); Tue, 28 Nov 2006 16:57:33 -0500
Received: from smtp.osdl.org ([65.172.181.25]:17317 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S1757263AbWK1V5c (ORCPT
 <rfc822;git@vger.kernel.org>); Tue, 28 Nov 2006 16:57:32 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kASLrXix005833
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Tue, 28
 Nov 2006 13:53:33 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kASLrUZB027274; Tue, 28 Nov
 2006 13:53:30 -0800
To: Daniel Barkalow <barkalow@iabervon.org>
Sender: git-owner@vger.kernel.org



On Tue, 28 Nov 2006, Daniel Barkalow wrote:
> 
> I don't think you'd ever want the same commit message for commits in two 
> projects.

I don't know about "ever", but yes, I do think submodule commits are 
generally totally separate things from supermodule commits.

> In any case where you'd commit a submodule in the process of 
> committing a supermodule, git would do this by recursively calling 
> git-commit, which would prompt for separate commit messages.

That certainly works, although I'm not convinved that it's necessarily a 
hugely important detail.

I suspect there may well be more important things UI-wise wrt submodules 
than the "you may have to commit submodules separately" question.

For example, doing a "git pull" is a lot more interesting, since that 
actually has the potential of having to resolve conflicts in submodules 
before the supermodule can be committed. Getting all the "git reset" 
behaviour right for when you decide "oops, that was too complicated" is 
probably a lot more important than whether you have to have a separate 
"commit subproject" phase for the simple cases of doing a bog-standard 
"git commit -a".

