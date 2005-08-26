From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Storing state in $GIT_DIR
Date: Thu, 25 Aug 2005 20:54:45 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508252051400.3317@g5.osdl.org>
References: <46a038f905082420323b025e3b@mail.gmail.com> 
 <Pine.LNX.4.58.0508251053000.3317@g5.osdl.org> <46a038f905082518306e9d7d2a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: GIT <git@vger.kernel.org>, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Aug 26 09:39:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8VJG-0000nw-64
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 05:55:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965049AbVHZDyy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Aug 2005 23:54:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVHZDyy
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Aug 2005 23:54:54 -0400
Received: from smtp.osdl.org ([65.172.181.4]:16852 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751491AbVHZDyy (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 25 Aug 2005 23:54:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j7Q3skjA002973
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 25 Aug 2005 20:54:47 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j7Q3sjKB020992;
	Thu, 25 Aug 2005 20:54:46 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905082518306e9d7d2a@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.114 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7769>



On Fri, 26 Aug 2005, Martin Langhoff wrote:
> 
> OTOH, storing the metadata in a branch will allow us to run the import
> in alternating repositories. But as Junio points out, unless I can
> guarantee that the metadata and the tree are in sync, I cannot
> trivially resume the import cycle from a new repo.

But you can.

Remember: the metadata is the pointers to the original git conversion, and 
objects are immutable.

In other words, if you just have a "last commit" pointer in your 
meta-data, then git is _by_definition_ in sync. There's never anything to 
get out of sync, because objects aren't going to change.

So you can think of your meta-data as a strange kind of head ref. Or 
rather, a _collection_ of these strange refs.

And it doesn't matter if somebody ends up committing on top of an arch 
import. The metadata by definition doesn't know about it, so the "import" 
head doesn't move anywhere (if you do git and arch work in parallell, you 
can then merge the two heads with git, of course).

			Linus
