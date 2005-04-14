From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] merge-base
Date: Thu, 14 Apr 2005 13:17:59 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0504141234490.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0504132040020.7211@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 14 19:15:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DM7ve-0002tD-UC
	for gcvg-git@gmane.org; Thu, 14 Apr 2005 19:14:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261274AbVDNRSN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 14 Apr 2005 13:18:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261557AbVDNRSN
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Apr 2005 13:18:13 -0400
Received: from iabervon.org ([66.92.72.58]:27140 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261274AbVDNRRw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Apr 2005 13:17:52 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DM7yZ-0008GY-00; Thu, 14 Apr 2005 13:17:59 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0504132040020.7211@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 13 Apr 2005, Linus Torvalds wrote:

> I agree. But I did the silly "common revision tracking" part slightly
> differently and in particular I already made fsck and rev-tree use the 
> same exact code.

I think I only saw a cut-and-paste version, and I didn't want to follow
that pattern.

> Also, I don't see why you did the "common parent" thing as part of the
> "library", since that really does seem to be a very specific to this 
> problem, and neither fsck nor rev-tree really wants it. 

That was just silly; on the other hand, I think I'll eventually want to
have a "support-for-merging" library file, so that people can write
alternative merging programs which call library functions to pick out
history details. But that obviously shouldn't be the same file that
rev-tree and fsck share, and I'll probably do that by pulling main() out
of the program later.

> Also, the date parsing really is a separate issue from the revision 
> tracking (fsck does not want date parsing, but rev-tool does), so I think 
> you might want to do for date parsing what I just did for the revision.h 
> thing? No point in tying them together.

I think there is some value in having a library file that completely
parses "commit"-tagged files. Having the date field in struct revision
without the code to parse it in the file that defines the struct seems
poor to me.

> So could I ask you to re-factor it and base it on my current tree? Make 
> the "merge-base" program have that common parent thing in it, and factor 
> out the common date parsing into "parse-date.c" or something?

I'm not actually using the date in merge-base, either, so I'll just leave
that alone for now (merge-base is based on generations, not time,
currently).

	-Daniel
*This .sig left intentionally blank*

