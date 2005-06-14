From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: porcelain question: state of the art for undo-redo?
Date: Mon, 13 Jun 2005 21:25:25 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0506132056210.30848-100000@iabervon.org>
References: <2cfc40320506110151624b3ec1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jun 14 03:22:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Di07t-0002bO-EH
	for gcvg-git@gmane.org; Tue, 14 Jun 2005 03:22:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261238AbVFNB0o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Jun 2005 21:26:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261296AbVFNB0o
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Jun 2005 21:26:44 -0400
Received: from iabervon.org ([66.92.72.58]:10757 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261238AbVFNB0l (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 13 Jun 2005 21:26:41 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1Di0BB-00084H-00; Mon, 13 Jun 2005 21:25:25 -0400
To: jon@blackcubes.dyndns.org
In-Reply-To: <2cfc40320506110151624b3ec1@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 11 Jun 2005, Jon Seymour wrote:

> What porcelain layer solutions currently exist for effective undo-edit-redo?
> 
> For example, if you are working on a series of patches in a series,
> then realise there is a mistake in a patch early in the series, how
> does one mod that patch, then reapply all the following patches to
> produce a slightly modified patch series with as little stuffing
> around as possible?

I personally commit changes as I make them (essentially, and time I'm
about to make a change that might not work out, I commit the previous
state). Once I'm completely satisfied with the results, I redo the whole
thing as a series of commits from the base as self-contained changes.

To do this, I get a repository which contains the base (as master) and the
result of my previous work. Then I repeat the following steps:

Diff the work against the head into a temporary file.
Remove all of the hunks I don't want yet from the file.
Apply the file.
Commit.

I stop when the diff is either empty or contains only junk I didn't
actually mean to include.

Then I submit the series thus created.

I generally then diff once more, remove anything I actually don't want to
have (as opposed to wanting to have but not submit), apply and commit to
form a new work head. Then I throw away the old work head.

If I screw this up, I just start over, since I have all the actual content
safe.

	-Daniel
*This .sig left intentionally blank*

