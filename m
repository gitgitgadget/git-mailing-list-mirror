From: Linus Torvalds <torvalds@osdl.org>
Subject: "git revert" (Re: pci_update_resource() getting called on sparc64)
Date: Mon, 8 Aug 2005 12:57:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0508081257190.3258@g5.osdl.org>
References: <20050808.103304.55507512.davem@davemloft.net>
 <Pine.LNX.4.58.0508081131540.3258@g5.osdl.org> <20050808160846.GA7710@kroah.com>
 <20050808.123209.59463259.davem@davemloft.net> <20050808194249.GA6729@kroah.com>
 <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-From: git-owner@vger.kernel.org Mon Aug 08 21:58:24 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E2Dkx-0001NB-Iq
	for gcvg-git@gmane.org; Mon, 08 Aug 2005 21:57:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932249AbVHHT5w (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 8 Aug 2005 15:57:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932252AbVHHT5w
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Aug 2005 15:57:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:26802 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932251AbVHHT5v (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 8 Aug 2005 15:57:51 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j78JvjjA004871
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO)
	for <git@vger.kernel.org>; Mon, 8 Aug 2005 12:57:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j78JvhGt022498
	for <git@vger.kernel.org>; Mon, 8 Aug 2005 12:57:44 -0700
To: Git Mailing List <git@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.58.0508081249110.3258@g5.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


Comments?

		Linus

On Mon, 8 Aug 2005, Linus Torvalds wrote:
> 
> 
> On Mon, 8 Aug 2005, Greg KH wrote:
> > 
> > Hm, how do you revert a git patch?
> 
> Something like this?
> 
> 	#!/bin/sh
> 	. git-sh-setup-script || die "Not a git archive"
> 	rev=$(git-rev-parse --verify --revs-only "$@") || exit
> 	git-diff-tree -R -p $rev | git-apply --index &&
> 		echo "Revert $rev" | git commit
> 
> Just name it "git-revert-script" and it might do what you want to do.
> 
> It may not have the nicest error messages: if you try to revert a merge
> (which won't have a diff), git-apply will say something like
> 
> 	fatal: No changes
> 
> which isn't exactly being helpful. And the revert message could be made 
> more interesting (like putting the first line of the description of what 
> we reverted into the message instead of just the revision number).
> 
> 		Linus
> 
