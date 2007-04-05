From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: 'git checkout -f' versus 'git reset --hard'
Date: Thu, 5 Apr 2007 08:43:15 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704050837330.6730@woody.linux-foundation.org>
References: <17940.64329.10165.993967@lisa.zopyra.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Thu Apr 05 17:43:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HZU7N-0003KJ-Ty
	for gcvg-git@gmane.org; Thu, 05 Apr 2007 17:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767101AbXDEPnS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 5 Apr 2007 11:43:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767113AbXDEPnS
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Apr 2007 11:43:18 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41436 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1767101AbXDEPnR (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Apr 2007 11:43:17 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l35FhGPD031604
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 5 Apr 2007 08:43:16 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l35FhG4q019262;
	Thu, 5 Apr 2007 08:43:16 -0700
In-Reply-To: <17940.64329.10165.993967@lisa.zopyra.com>
X-Spam-Status: No, hits=-0.457 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43836>



On Thu, 5 Apr 2007, Bill Lear wrote:
>
> After a failed merge, I want to undo things.  I typically use git
> reset --hard, and it works like a charm.  Others have tried to use git
> checkout -f, but I have cautioned that git reset --hard is really the
> way to do it.  Is there a difference here, or are they equivalent?

They are equivalent, but *only* if not given any other arguments (or if 
given "HEAD", which is obviously the default).

HOWEVER! If you give them an argument, they work very differently. So

	git checkout -f <branchname>
	git reset --hard <branchname>

are fundamentally different operations: the "git checkout -f" thing will 
*switch* to the named branch (or create a detached HEAD if it's just a 
random commit SHA1 and not a branchname), while the "git reset --hard" 
thing will *force* the current branch top commit to the same as for
<branchname>.

It just so happens that without any branchname they both default to the 
"current branch", and then the two end up doing the exact same thing, even 
though conceptually they are very different operations.

So they really are fundamentally different, it's just that for the common 
special case they end up doing the same thing.

		Linus
