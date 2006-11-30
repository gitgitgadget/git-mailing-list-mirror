X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: v2.6.11 tag in kernel tree
Date: Thu, 30 Nov 2006 08:04:30 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0611300758290.3513@woody.osdl.org>
References: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
NNTP-Posting-Date: Thu, 30 Nov 2006 16:05:08 +0000 (UTC)
Cc: Git Mailing List <git@vger.kernel.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <9e4733910611292002o289dc4d1u7bde2d457fa97d73@mail.gmail.com>
X-MIMEDefang-Filter: osdl$Revision: 1.161 $
X-Scanned-By: MIMEDefang 2.36
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32763>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GpoOr-0003ur-Dw for gcvg-git@gmane.org; Thu, 30 Nov
 2006 17:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967835AbWK3QEe (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 30 Nov 2006
 11:04:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967828AbWK3QEe
 (ORCPT <rfc822;git-outgoing>); Thu, 30 Nov 2006 11:04:34 -0500
Received: from smtp.osdl.org ([65.172.181.25]:34002 "EHLO smtp.osdl.org") by
 vger.kernel.org with ESMTP id S967835AbWK3QEe (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 30 Nov 2006 11:04:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6]) by
 smtp.osdl.org (8.12.8/8.12.8) with ESMTP id kAUG4VjQ026461
 (version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO); Thu, 30
 Nov 2006 08:04:31 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31]) by
 shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id kAUG4UjX009886; Thu, 30 Nov
 2006 08:04:30 -0800
To: Jon Smirl <jonsmirl@gmail.com>
Sender: git-owner@vger.kernel.org



On Wed, 29 Nov 2006, Jon Smirl wrote:
>
> Using this tree
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6
> 
> These two tags appear to be pointing to a tree instead of a commit.
> v2.6.11
> v2.6.11-tree

Yes. We don't have that as a commit. The commit history starts with 
v2.6.12-rc2.

> I'm trying to check out v2.6.11 so that I can figure out the changes a
> vendor made to it.

You can't check it out, since it's not a commit, but since it is a tree, 
you can:

 - use it as a base for "git diff"

	git diff v2.6.11 <any-commit-goes-here>

 - or if you want to use it as a base for development, create a new commit 
   and branch from it:

	git-commit-tree v2.6.11 <<EOF
	This is an initial commit starting at the state of Linux-v2.6.11
	EOF

   and then you can take the resulting SHA1 (that it wrote out to stdout), 
   and do

	git checkout -b my-new-branch <sha1thatyoujustgot>

However, whatever you do, it won't be connected to the rest of the git 
history.

Another possibility may be to get the historical Linux tree (which _does_ 
have a real v2.6.11, and that you _can_ graft together with the current 
tree, and thus get full history), and then use that grafted whole-history 
tree for whatever you want to do. That allows you to do things like 
rebasing the end result (if you started a new branch based on 2.6.11) etc, 
since it's now all connected.

