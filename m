From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Git clone error
Date: Wed, 1 Aug 2007 09:36:47 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0708010929070.3582@woody.linux-foundation.org>
References: <C2D5F3B2.2B00%denbuen@sandia.gov>
 <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Denis Bueno <denbuen@sandia.gov>
X-From: git-owner@vger.kernel.org Wed Aug 01 18:37:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGHCG-0005Xv-Cx
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 18:37:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755907AbXHAQhB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Aug 2007 12:37:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757816AbXHAQhB
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Aug 2007 12:37:01 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:41783 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757756AbXHAQhA (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Aug 2007 12:37:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71GaqTV020550
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 1 Aug 2007 09:36:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l71GalNQ005284;
	Wed, 1 Aug 2007 09:36:47 -0700
In-Reply-To: <alpine.LFD.0.999.0708010846360.3582@woody.linux-foundation.org>
X-Spam-Status: No, hits=-2.423 required=5 tests=AWL,BAYES_00,J_CHICKENPOX_23
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.20__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54450>



On Wed, 1 Aug 2007, Linus Torvalds wrote:
> 
> > If I just recreate a version I'm happy with, can I add that to the repo and
> > go from there?
> 
> Well, it's not so much a version _you_ are happy with: you'd have to be 
> able to re-create the exact old version (with the exact same SHA1), in 
> order for git to be happy.

Btw, if you really cannot re-generate it, you'd basically need to create a 
whole new git archive without that blob (or basically with that blob 
replaced by another version).

We don't have wonderfully good support for that, because, quite frankly, 
we've not had this happen before. I think every time before, people have 
had the blob in some other copy of their git archive.

But the thing to use is "git filter-branch", which can take a git history 
and munge it arbitrarily. It would be the "tree-filter" that you'd use to 
replace that one blob that you cannot regenerate with another (ie you 
might decide to just replace the original version of the file with that 
*second* version, and regenerate the tree that way).

I'm cc'ing Dscho explicitly to see if he can help you with the exact 
syntax, and maybe we could even make this into a user-manual entry about 
how to handle corruption. I don't think we have anything in the 
documentation about this - we only cover the trivial cases where the 
objects are all good, but you've lost the pointers into it because you 
removed a branch by mistake or something.

		Linus
