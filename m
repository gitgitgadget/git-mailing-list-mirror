From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Problem with a push
Date: Tue, 12 Jun 2007 11:46:41 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0706121144050.14121@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0706111632050.4406@www.mintpixels.com>
 <alpine.LFD.0.98.0706111556160.14121@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706111832070.4830@www.mintpixels.com>
 <alpine.LFD.0.98.0706111727240.14121@woody.linux-foundation.org>
 <Pine.LNX.4.64.0706121309260.7703@www.mintpixels.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: plexq@plexq.com
X-From: git-owner@vger.kernel.org Tue Jun 12 20:46:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HyBOG-0007lb-Ch
	for gcvg-git@gmane.org; Tue, 12 Jun 2007 20:46:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756922AbXFLSqv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 12 Jun 2007 14:46:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756898AbXFLSqv
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Jun 2007 14:46:51 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:38212 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756879AbXFLSqu (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 12 Jun 2007 14:46:50 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CIklRb007821
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 12 Jun 2007 11:46:48 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l5CIkfhs018209;
	Tue, 12 Jun 2007 11:46:42 -0700
In-Reply-To: <Pine.LNX.4.64.0706121309260.7703@www.mintpixels.com>
X-Spam-Status: No, hits=-2.674 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49987>



On Tue, 12 Jun 2007, Alex R.M. Turner wrote:
> 
> Based on what you've said, it seems like I should be initialising a blank 
> repo on machine A, then pushing from machine B to machine A, rather than 
> cloning on A from B.

That's generally what you'd do for a central repo, yes.
But:

> At this point would it just be sensible to delete the remote branches on 
> machine A?

Yes, in the current environment, the easiest thing to do is to just remove 
those branches.

OR, alternatively, just keep them, but on machine B, make your .git/config 
file have something like

	[remote "origin"]
		url = ssh://aturner@svn.mintpixels.com/data/git/mls
		fetch = +refs/heads/*:refs/remotes/origin/*
		push = refs/heads/*:refs/heads/*

which should just make it clear to "git push" than when you push from B to 
"origin", you should push everything under "refs/heads" (assuming that's 
what you want, of course)-


		Linus
