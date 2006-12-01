X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] git-add update with all-0 object
Date: Fri, 1 Dec 2006 03:10:48 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0612010223010.20138@iabervon.org>
References: <Pine.LNX.4.64.0611301634080.20138@iabervon.org>
 <Pine.LNX.4.64.0611301431420.3513@woody.osdl.org> <Pine.LNX.4.64.0611301749450.20138@iabervon.org>
 <20061201045727.GA22622@thunk.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Fri, 1 Dec 2006 08:11:42 +0000 (UTC)
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org,
	Junio C Hamano <junkio@cox.net>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061201045727.GA22622@thunk.org>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32868>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Gq3UZ-0003U3-KX for gcvg-git@gmane.org; Fri, 01 Dec
 2006 09:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S933718AbWLAILK (ORCPT <rfc822;gcvg-git@m.gmane.org>); Fri, 1 Dec 2006
 03:11:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936105AbWLAILK
 (ORCPT <rfc822;git-outgoing>); Fri, 1 Dec 2006 03:11:10 -0500
Received: from iabervon.org ([66.92.72.58]:3087 "EHLO iabervon.org") by
 vger.kernel.org with ESMTP id S933718AbWLAILI (ORCPT
 <rfc822;git@vger.kernel.org>); Fri, 1 Dec 2006 03:11:08 -0500
Received: (qmail 30709 invoked by uid 1000); 1 Dec 2006 03:10:52 -0500
Received: from localhost (sendmail-bs@127.0.0.1) by localhost with SMTP; 1
 Dec 2006 03:10:52 -0500
To: Theodore Tso <tytso@mit.edu>
Sender: git-owner@vger.kernel.org

On Thu, 30 Nov 2006, Theodore Tso wrote:

> By the way, after thinking about this for a while, part of the problem
> is that the name "index" really sucks.  Which is perhaps why Linus is
> now trying to stop us from actually using the term "index" in these
> discussions.  :-)    If we called it a "staging area", as our Great
> Leader has suggested, I think it would be a lot easier for novice
> users to understand.    Consider what is in the git man page:
> 
> 	The index is a simple binary file, which contains an efficient
> 	representation of a virtual directory content at some random
> 	time.  It does so by a simple array that associates a set of
> 	names, dates, permissions and content (aka "blob") objects
> 	together. The cache is always kept ordered by name, and names
> 	are unique (with a few very specific rules) at any point in
> 	time, but the cache has no long-term meaning, and can be
> 	partially updated at any time.....
> 
> 	In particular, the index file can have the representation of
> 	an intermediate tree that has not yet been instantiated. So
> 	the index can be thought of as a write-back cache, which can
> 	contain dirty information that has not yet been written back
> 	to the backing store.
> 
> For a kernel programmer, this might not be understandable --- but for
> your typical application programmer, this is enough to cause him or
> her to conclude that git is simply not meant for use by mere mortals.

My position on this subject is that "index" is a good name, but that 
description is a terrible description, and "index" is a word that needs a 
good description in context. If we just said up front:

 Git's "index" is a staging area that you use to prepare commits. It maps 
 filenames to content. It allows git to remember changes you want to put 
 into the next commit while you do more work. For normal commits, it is 
 not necessary to use the index, but it is very helpful for complicated 
 commits, because it lets you focus on the part you're still working on 
 while git remembers the part you're done with.

I think people would get it. (If it were called the "cache" still, it 
would be hopeless, because "cache" implies false things; "index" doesn't 
imply anything initially.)

Of course, we'd still have to disabuse people of the notion that the index 
can store the information "there's nothing at this path yet, but I'm 
interested in it", because that's a piece of information people often know 
before a file is ready, and think git would be able to remember in a 
staging area.

	-Daniel
