From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Seeing various mode changes on cygwin
Date: Mon, 10 Oct 2005 11:22:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510101120410.14597@g5.osdl.org>
References: <20051008180023.GC28875@diku.dk> <7vfyrbrgdw.fsf@assigned-by-dhcp.cox.net>
 <20051008213612.GA5794@steel.home> <7vzmpjoa32.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0510081909250.31407@g5.osdl.org> <Pine.LNX.4.63.0510100220330.23242@iabervon.org>
 <7vu0fpbz43.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 10 20:24:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EP2Ie-0005FE-2v
	for gcvg-git@gmane.org; Mon, 10 Oct 2005 20:23:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751149AbVJJSW4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 10 Oct 2005 14:22:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751152AbVJJSW4
	(ORCPT <rfc822;git-outgoing>); Mon, 10 Oct 2005 14:22:56 -0400
Received: from smtp.osdl.org ([65.172.181.4]:23192 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751149AbVJJSWz (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 10 Oct 2005 14:22:55 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9AIMl4s028628
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 10 Oct 2005 11:22:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9AIMki8029051;
	Mon, 10 Oct 2005 11:22:46 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.63.0510101354520.23242@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.51__
X-MIMEDefang-Filter: osdl$Revision: 1.122 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9904>



On Mon, 10 Oct 2005, Daniel Barkalow wrote:
> 
> Actually, you're right; it is information about the behavior of the 
> working tree, and is also needed if you want to compare the working tree 
> against a tree object, in which case you aren't using the index at all.

Git _always_ uses the index for working tree operations.

It may take the actual file _data_ from the working tree, but it will take 
the list of files from the index, so it's certainly possible to link the 
index to the working tree.

That said, I don't think it's necessarily a good idea. You can have 
temporary indexes for various operations that ignore the main one (ie any 
random

	GIT_INDEX_FILE=tmp git-read-tree ...

will create a new index).

So I think it's much better to have a config file.

I'll write something up. Make it extensible while at it.

		Linus
