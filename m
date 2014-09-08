From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: git rebase: yet another newbie quest.
Date: Mon, 8 Sep 2014 13:32:51 -0400
Message-ID: <20140908173251.GA24855@thunk.org>
References: <87a96ecqe9.fsf@osv.gnss.ru>
 <20140905154159.GB1510@thunk.org>
 <87sik28bir.fsf@osv.gnss.ru>
 <20140908140758.GI1066@thunk.org>
 <87fvg23yhx.fsf@osv.gnss.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Sergey Organov <sorganov@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 08 19:33:03 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XR2oH-0000P4-TS
	for gcvg-git-2@plane.gmane.org; Mon, 08 Sep 2014 19:33:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754721AbaIHRc5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Sep 2014 13:32:57 -0400
Received: from imap.thunk.org ([74.207.234.97]:44115 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754304AbaIHRc5 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Sep 2014 13:32:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=kFyQX+6X6+UlTcLKZ9EUqG7PAXv6vKN9jSn2CZ1VCOk=;
	b=SBwJ8AxmPiJXEM0DirQ8RM2V8B+0tVBbBhd7JumnFBmfCX3yKoPvZn9PnCjhkgWCONLJbzHDFPwpXMB47nOSTT/hQ/RPqhWFQhk7YT3nfAEb7S1t+L0Adun6l5Raxwexl+/3IFyi3lJ8dXdPEzDacwUoEaKSdKQsOXtbnQ7FYiM=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1XR2o9-0005eC-Et; Mon, 08 Sep 2014 17:32:53 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id 545E558047A; Mon,  8 Sep 2014 13:32:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <87fvg23yhx.fsf@osv.gnss.ru>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256659>

On Mon, Sep 08, 2014 at 07:47:38PM +0400, Sergey Organov wrote:
> 
> except that I wanted to configure upstream as well for the topic-branch,
> that looks like pretty legit desire. If I didn't, I'd need to specify
> upstream explicitly in the "git rebase", and I'd not notice the problem
> at all, as the actual problem is that "git rebase" and "git rebase
> <upstream>" work differently!

Right, so I never do that.  I have master track origin/master, where
it automagically does the right thing, but I'm not even sure I can
articulate what it *means* to have topic also track origin/master.  I
just don't have a mental model for it, and so it falls in the category
of "it's too complicated for my simple brain to figure out".

So I just do "git rebase master", and I would never even *consider*
doing a "git pull --rebase".  I'll do a "git fetch", and then look at
what just landed, and and then checkout master, update it to
origin/master, and then run the regression tests to make sure what
just came in from outside actually was *sane*, and only then would I
do a "git checkout topic; git rebase master", and then re-run the
regression tests a third time.

Otherwise, how would I know whether the regression came in from
origin/master, or from my topic branch, or from the result of rebasing
the topic branch on top of origin/master?

And of course, this goes back to my observation that I don't rebase my
topic branchs all that often anyway, just because the moment you do
the rebase, you've invalidated all of the testing that you've done to
date.  In fact, some upstreams will tell explicitly tell you to never
rebase a topic branch before you ask them to pull it in, unless you
need to handle some non-trivial merge conflict.

Cheers,

						- Ted
