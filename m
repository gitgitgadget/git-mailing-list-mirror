From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [FAQ?] Rationale for git's way to manage the index
Date: Mon, 7 May 2007 21:45:32 -0700 (PDT)
Message-ID: <alpine.LFD.0.98.0705072137450.3974@woody.linux-foundation.org>
References: <vpqwszm9bm9.fsf@bauges.imag.fr> 
 <alpine.LFD.0.98.0705060951460.25245@woody.linux-foundation.org> 
 <vpqbqgxak1i.fsf@bauges.imag.fr>
 <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: git@vger.kernel.org
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 08 06:45:43 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlHa1-0001ZY-H7
	for gcvg-git@gmane.org; Tue, 08 May 2007 06:45:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966571AbXEHEph (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 8 May 2007 00:45:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967752AbXEHEpg
	(ORCPT <rfc822;git-outgoing>); Tue, 8 May 2007 00:45:36 -0400
Received: from smtp1.linux-foundation.org ([65.172.181.25]:52790 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S966571AbXEHEpg (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 8 May 2007 00:45:36 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l484jXg3025029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 7 May 2007 21:45:34 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l484jW32013698;
	Mon, 7 May 2007 21:45:32 -0700
In-Reply-To: <46a038f90705072016x17bd60c3ic779459438ffc19@mail.gmail.com>
X-Spam-Status: No, hits=-3.488 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.53 on 65.172.181.25
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46537>



On Tue, 8 May 2007, Martin Langhoff wrote:
> 
> Heh. Making the index very visible makes sense when you are merging,
> Linus and Junio are both integrators and spend a lot of time merging.
> Hence the default is for git-commit to observe the index.

It is definitely true that some of the advantages of the way git does the 
index really start shinign when merging and you have content conflicts. 
What we've done to "git diff" really makes things a lot easier (and 
anybody who hasn't used "gitk --merge" after a content conflict really 
hasn't realized how *helpful* git is when merging content conflicts).

However, in all honesty, while the whole "index for merges" comes from 
pretty damn early in git history (the whole "stage number" thing appeared 
on April 15th 2005 - so it was about a week after the first release), it 
wasn't the original impetus of the way git works.

Git used explicit index updates from day 1, even before it did the first 
merge. It's simply how I've always worked. I tend to have dirty trees, 
with some random patch in my tree that I do *not* want to commit, because 
it's just a Makefile update for the next version (to remind me - I've 
released kernel versions too many times with an old version number, just 
because I forgot to update the Makefile).

Or other things like that - I have small test-patches in my tree that I 
want to build, but that I don't want to commit, and I end up doing big 
merges and whole patch-application sequences with such a dirty tree 
(obviously if the patch or merge wants to change that file, I then need to 
do something about that dirty state, but it happens surprisingly seldom).

So the whole "update stuff to be committed explicitly" ends up _really_ 
shining during a merge, but it actually is how I do non-merge development 
too.

			Linus
