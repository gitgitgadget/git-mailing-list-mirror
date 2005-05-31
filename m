From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: git-rev-list: proper lazy reachability
Date: Tue, 31 May 2005 07:39:41 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0505310735260.1876@ppc970.osdl.org>
References: <Pine.LNX.4.58.0505301847120.1876@ppc970.osdl.org>
 <17052.21846.816147.370354@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 31 16:39:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dd7sa-0002fS-A5
	for gcvg-git@gmane.org; Tue, 31 May 2005 16:38:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261893AbVEaOjL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 31 May 2005 10:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261688AbVEaOjL
	(ORCPT <rfc822;git-outgoing>); Tue, 31 May 2005 10:39:11 -0400
Received: from fire.osdl.org ([65.172.181.4]:30443 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261893AbVEaOhq (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 May 2005 10:37:46 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j4VEbbjA003428
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 31 May 2005 07:37:37 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j4VEbaYf020195;
	Tue, 31 May 2005 07:37:37 -0700
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17052.21846.816147.370354@cargo.ozlabs.ibm.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Tue, 31 May 2005, Paul Mackerras wrote:
> 
> I have made gitk use git-rev-list instead of git-rev-tree, but it
> still absorbs the whole of git-rev-list's output before drawing
> anything.  I'd like to make it draw the commit graph and list
> incrementally as it gets the output from git-rev-list, but to do that
> I need to know whether git-rev-list could ever print a commit ID
> *after* one of its parents.  If it never does that then I can
> restructure the code to do the drawing incrementally fairly easily.

You should never see a parent before a child from git-rev-list. I may have 
screwed something up when I move things between the two lists (the 
before/after thing needs to first do the reachability thing on one list, 
and then moves them to the "potential output list"), but I don't think so.

Anyway, at that point it would be a git-rev-list bug, so if you can make
your code notice and complain ("git-rev-list listed parent before child")  
rather than silently show crud, that would help debugging it if it ever 
happened.

		Linus
