From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: How can I tell if a SHA1 is a submodule reference?
Date: Thu, 15 May 2008 13:13:24 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0805151311050.3019@woody.linux-foundation.org>
References: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Robin Luckey <robin@ohloh.net>
X-From: git-owner@vger.kernel.org Thu May 15 22:14:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwjqJ-0004xI-5P
	for gcvg-git-2@gmane.org; Thu, 15 May 2008 22:14:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754161AbYEOUNb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 May 2008 16:13:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753126AbYEOUNb
	(ORCPT <rfc822;git-outgoing>); Thu, 15 May 2008 16:13:31 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:42302 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754162AbYEOUNa (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 15 May 2008 16:13:30 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4FKDP5k016100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 15 May 2008 13:13:26 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m4FKDOjl008488;
	Thu, 15 May 2008 13:13:25 -0700
In-Reply-To: <7F242E8F-13CF-4BE5-B3E6-85F285391658@ohloh.net>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.422 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82228>



On Thu, 15 May 2008, Robin Luckey wrote:
>
> I am parsing the output of git-diff-tree to create some code analysis reports.
> 
> When a user adds a submodule to a repository, git-diff-tree reports the SHA1
> of the commit from the submodule.
> 
> However, if I subsequently try to pass this SHA1 to git-cat-file, or indeed
> any other git command I have tried, I receive an error:
> 
> error: unable to find b0f8c354b142e27333abd0f175544b71a0cc444e
> fatal: Not a valid object name b0f8c354b142e27333abd0f175544b71a0cc444e
> 
> This makes sense to me, since these objects are not stored locally; they are
> stored in the submodule repository.
> 
> However, is there a simple and reliable way for me to know which SHA1 hashes
> refer to such submodule objects? I'd like to simply ignore them.

Only if you still have the tree references they came from.

In other words, once you *only* have the SHA1, you're kind of screwed, 
because by that time you've lost the context, and the SHA1 itself contains 
no information about what kind of thing it is.

But when running git-diff-tree, you still have the source of the SHA1, and 
the tree entry in particular. The tree entry will have a "gitlink" marker, 
ie the "mode" will be 0160000. 

			Linus
