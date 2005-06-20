From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git merging
Date: Mon, 20 Jun 2005 12:06:01 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506201156360.30848-100000@iabervon.org>
References: <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jens Axboe <axboe@suse.de>, Jeff Garzik <jgarzik@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 18:02:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkOiv-0007am-PZ
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 18:02:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261368AbVFTQH5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 20 Jun 2005 12:07:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261373AbVFTQH5
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Jun 2005 12:07:57 -0400
Received: from iabervon.org ([66.92.72.58]:39172 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261368AbVFTQHx (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 20 Jun 2005 12:07:53 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DkOmf-00021u-00; Mon, 20 Jun 2005 12:06:01 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506200844420.2268@ppc970.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, 20 Jun 2005, Linus Torvalds wrote:

> Daniel: I think git-ssh-pull has problems with any refs that aren't
> commits. I also noticed earlier that I can't use git-ssh-push -w to write
> a tag - it is apparently unhappy because it would write a "tag" object,
> and it only wants to write references to "commit" objects. The same thing
> might be true about the special "tag to a tree" object?

You're correct; it's actually that pull.c has never gotten extended to
look at the object you specify, determine what it is, and then behave
appropriately. Basically, it needs a "process_unknown()" which does the
appropriate thing, and pull() needs to call that instead of
process_commit(). It should also get a "process_tag()" which handles tags
(calling process_unknown() on their objects). I should be able to do it
Tuesday evening or Wednesday night, if nobody else gets it before then.

	-Daniel
*This .sig left intentionally blank*

