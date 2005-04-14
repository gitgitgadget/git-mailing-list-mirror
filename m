From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] merge-base
Date: Wed, 13 Apr 2005 20:49:51 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504132040020.7211@ppc970.osdl.org>
References: <Pine.LNX.4.21.0504131447480.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 05:44:58 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DLvHd-0006is-0s
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 05:44:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261425AbVDNDr7 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Apr 2005 23:47:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbVDNDr7
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Apr 2005 23:47:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:31118 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261425AbVDNDr5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Apr 2005 23:47:57 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3E3lss4025681
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 13 Apr 2005 20:47:54 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3E3lrB6005992;
	Wed, 13 Apr 2005 20:47:53 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0504131447480.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 13 Apr 2005, Daniel Barkalow wrote:
>
> I wrote a pretty dumb program that will find some common ancestor for a
> pair of commits. It finds the one which is closest to one of the commits
> by number of generations. This is, at least, not strictly worse than any
> other common ancestor, at least (like picking the original release would
> be).
> 
> It wouldn't be too hard to do this much with rev-tree, but should be
> easier to extend.

I agree. But I did the silly "common revision tracking" part slightly
differently and in particular I already made fsck and rev-tree use the 
same exact code.

Also, I don't see why you did the "common parent" thing as part of the
"library", since that really does seem to be a very specific to this 
problem, and neither fsck nor rev-tree really wants it. 

Also, the date parsing really is a separate issue from the revision 
tracking (fsck does not want date parsing, but rev-tool does), so I think 
you might want to do for date parsing what I just did for the revision.h 
thing? No point in tying them together.

So could I ask you to re-factor it and base it on my current tree? Make 
the "merge-base" program have that common parent thing in it, and factor 
out the common date parsing into "parse-date.c" or something?

		Linus
