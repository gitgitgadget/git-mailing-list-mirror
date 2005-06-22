From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Patch (apply) vs. Pull
Date: Wed, 22 Jun 2005 13:22:46 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506221315201.2353@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506221350130.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 22 22:19:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DlBgr-00067H-4g
	for gcvg-git@gmane.org; Wed, 22 Jun 2005 22:19:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262151AbVFVUXj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Jun 2005 16:23:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262025AbVFVUXY
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jun 2005 16:23:24 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60605 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262057AbVFVUUt (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jun 2005 16:20:49 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5MKKfjA019579
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 22 Jun 2005 13:20:41 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5MKKe9M031136;
	Wed, 22 Jun 2005 13:20:40 -0700
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <Pine.LNX.4.21.0506221350130.30848-100000@iabervon.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 22 Jun 2005, Daniel Barkalow wrote:
>
> If each patch is given an ID by the author (not committer) which is
> preserved across various later modifications, we could at least recognize
> which patch it was.

I really don't like it.

I do realize that people use patch ID's inside various companies already, 
because it's a nice way to track things. But the fact is, especially with 
the patch going outside the SCM (which is the whole _point_ here, after 
all), any modifications will make that ID be dubious.

And if it _isn't_ modified, then the ID is pointless - you might as well 
use the SHA1 of the patch itself as its ID, ie not use an explicit ID at 
all.

So I think introducing extra ID's in the process only creates the
possibility for more confusion. Either the patch is unmodified (and the ID
is not needed in the first place) or the patch is modified (and the ID
doesn't convey that). Not to mention the fact that the ID then becomes 
just another thing that can get corrupted or lost or just plain mistakenly 
edited from another patch..

So while I do accept ID's in my workflow (the XFS guys use them to track
commits between their own internal system and the kernel releases), I
really don't like it as a primary mechanism. I think it's useful for
specific projects, but any such usefulness is exactly the fact that then
the tracking of the ID's is totally outside of git itself or any of the
processes of git users.

Which of course is ok, but it's _not_ what I'm interested in if we're
discussing trying to make git itself have some support for "end-developer
merges" (re-write history) as opposed to "maintainer merges" (merge
history).

		Linus
