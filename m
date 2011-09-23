From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: What's The Right Way to Do This?
Date: Fri, 23 Sep 2011 08:39:54 +0200
Message-ID: <4E7C29BA.5030403@viscovery.net>
References: <loom.20110923T064720-366@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jon Forrest <nobozo@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 23 08:40:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R6zQb-00015E-P3
	for gcvg-git-2@lo.gmane.org; Fri, 23 Sep 2011 08:40:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751768Ab1IWGkA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Sep 2011 02:40:00 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:53510 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751067Ab1IWGj7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Sep 2011 02:39:59 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1R6zQS-00037b-2g; Fri, 23 Sep 2011 08:39:56 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 2B7DE1660F;
	Fri, 23 Sep 2011 08:39:54 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.22) Gecko/20110902 Thunderbird/3.1.14
In-Reply-To: <loom.20110923T064720-366@post.gmane.org>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181947>

Am 9/23/2011 6:48, schrieb Jon Forrest:
> I'm just now starting to use git for more than trivial things.
> Today I got myself in trouble. Here's what happened:
> 
> 1) I pulled the master branch from the IT repository from our
> main git server.
> 
> 2) I created a branch from this called "J" and started making changes.
> 
> 3) Other people pulled master from IT and then pushed changes back.

OK, so you are basically using a central repo.

> 4) I merged J with my master branch.
> 
> 5) I tried pushing my master back to origin but this failed with
> the usual message saying I first needed to pull from origin.
> So, I pulled and then pushed. This worked.
> 
> 6) On another server where I was going to use my changes I pulled
> master from IT.

I assume you mention this because with this step you detected that your
changes were crap.

> 6) It turned out that my changes were incorrect. So, I tried to revert
> using various methods I found by googling "git revert". What happened
> was that when I tried to revert back to the commit before the one I
> made, the files I had modified *and* the files that apparently were
> modified by other people in #3 above were reverted. This wasn't what
> I wanted. I only wanted to revert the changes I had made.

It looks like you had reset the history, not just reverted your changes.

> With the help of someone more experienced than me we were able to get
> things back to normal but this experience left me wondering what I
> should have done in the first place. There's a chance I'm going to
> have to go through all this again as I try to fix the problem with
> my changes.

With a central repository, any push into it marks a "done deal". No matter
how wrong and bogus your changes are, as soon as you push them into the
central repository, they are cast in stone.

At this point, the best you can do is to revert you changes, and by this I
mean that you create and push out another commit on top that backs out the
changes that you made.

If this is not what you (or your team) wants, than the problem is not with
suboptimal use of the git toolset, but with the push policy within you
team. A good policy should forbid that untested stuff can be pushed into
the central repository.

My suggestion is that you find a way to move your changes to the test site
(the "another server" you mention in step 6) without going through the
central repository. For example, if you have ssh access between your
development machine and the test site, you can push or pull your changes
between them directly.

-- Hannes
