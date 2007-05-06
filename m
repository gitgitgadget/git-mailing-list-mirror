From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] submodule merge support
Date: Sun, 6 May 2007 15:18:53 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705061517380.12945@woody.linux-foundation.org>
References: <20070506190224.GG30511@admingilde.org>
 <20070506220745.GA2439@steel.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 00:19:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hkp4U-0001NG-Mh
	for gcvg-git@gmane.org; Mon, 07 May 2007 00:19:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbXEFWTL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 6 May 2007 18:19:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751789AbXEFWTL
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 18:19:11 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:54265 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751648AbXEFWTK (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 18:19:10 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l46MItZq011643
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 6 May 2007 15:18:56 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l46MIsr5025291;
	Sun, 6 May 2007 15:18:54 -0700
In-Reply-To: <20070506220745.GA2439@steel.home>
X-Spam-Status: No, hits=-4.983 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46382>



On Mon, 7 May 2007, Alex Riesen wrote:

> Martin Waitz, Sun, May 06, 2007 21:02:24 +0200:
> > When merge-recursive gets to a dirlink, it starts an automatic
> > submodule merge and then uses the resulting merge commit for the
> > top-level tree.
> 
> merge-recursive is a mess already, you just made even more so.
> Besides, you completely forgot all other merge strategies.
> 
> How about making all existing strategies just ignore submodules, and
> move recursive merge in the merge driver (git-merge.sh)?

Yes, I think that's the right thing to do.

I think it's the right thing for another reason: in a true "recursive" 
merge, the submodules shouldn't be recursively merged anyway. *THEIR* 
merge will have its own history, and doing it based on some random history 
of the superproject is actually wrong anyway!

		Linus
