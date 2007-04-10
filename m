From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 6/6] Teach core object handling functions about gitlinks
Date: Tue, 10 Apr 2007 12:45:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704101235160.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org>
 <200704101828.37453.Josef.Weidendorfer@gmx.de>
 <Pine.LNX.4.64.0704101122510.6730@woody.linux-foundation.org>
 <200704102129.04548.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 11 05:37:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbMIW-0003TU-2X
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 21:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753812AbXDJTqI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 15:46:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753808AbXDJTqI
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 15:46:08 -0400
Received: from smtp.osdl.org ([65.172.181.24]:42999 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753812AbXDJTqG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 15:46:06 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AJjwVZ009096
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 12:45:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AJjvp0015816;
	Tue, 10 Apr 2007 12:45:57 -0700
In-Reply-To: <200704102129.04548.Josef.Weidendorfer@gmx.de>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44174>



On Tue, 10 Apr 2007, Josef Weidendorfer wrote:
> 
> So when moving the kdelibs submodule around, you would
> have to update the .gitmodules file.

Right. The assumption here is:
 - submodules almost never actually change. You might add a new one 
   occasionally, and once a decade you might do some bigger 
   re-organization, but in general it's pretty much static.
 - when you do move submodules around, it's probably a big flag-day anyway 
   (ie I would expect that it's a big reorg, and that you'd quite likely 
   expect developers to have to re-check out their tree if you did major 
   surgery).

That's certainly how it works under CVS. I bet we can make it much nicer 
than CVS, but the point is, people really don't expect submodules to be 
something that you move around very dynamically. You want to be *able* to 
move them around, but it's not a normal operation.

> I like it.

The advantage with splitting things out like this is that it allows you 
much more flexibility than something automatic and deeply integrated does. 

You can still edit the modules setup even if you yourself might not even 
have that particular module checked out! That may sound insane, but it's 
actually *required* for things like "oh, the standard server for that 
module went away, I need to edit the module settings to get it from xyz 
instead".

		Linus
