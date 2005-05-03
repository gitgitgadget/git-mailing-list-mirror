From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: questions about cg-update, cg-pull, and cg-clone.
Date: Tue, 3 May 2005 12:30:47 -0400 (EDT)
Message-ID: <Pine.LNX.4.21.0505031144280.30848-100000@iabervon.org>
References: <20050503152214.GA1704@tumblerings.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@ucw.cz>, Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue May 03 18:26:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DT0D8-0001ql-Us
	for gcvg-git@gmane.org; Tue, 03 May 2005 18:25:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261269AbVECQbb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 May 2005 12:31:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261307AbVECQbb
	(ORCPT <rfc822;git-outgoing>); Tue, 3 May 2005 12:31:31 -0400
Received: from iabervon.org ([66.92.72.58]:40199 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S261269AbVECQbI (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 May 2005 12:31:08 -0400
Received: from barkalow (helo=localhost)
	by iabervon.org with local-esmtp (Exim 2.12 #2)
	id 1DT0IJ-0004NE-00; Tue, 3 May 2005 12:30:47 -0400
To: Zack Brown <zbrown@tumblerings.org>
In-Reply-To: <20050503152214.GA1704@tumblerings.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Tue, 3 May 2005, Zack Brown wrote:

> So, suppose I'm working on your Cogito HEAD. I make some changes to my local
> tree and commit them to my tree, and then before I go forward, I want to grab
> whatever you've done recently, to make sure we're not in conflict before I add
> new changes. If I understand you right, this situation would be a 'fast forward
> merge'. So what is the command I give to just 'merge' your HEAD with mine,
> without requiring a changelog entry?

In this case, you have to do a tree merge, because you have some commits
and he has some commits, and you want to be in a state where you have your
commits and his; this state is new, so you need a new commit with both
lines as parents.

> Alternatively, suppose I'm you, the project lead, and Zackdude has some
> changes for me, based on my HEAD. I want to 'merge' his tree into mine. If
> I'm still understanding you, this is a 'tree merge'. Now I give a cg-update,
> and now I *want* to give a changelog entry to record the merge.  Correct?

In this case, you don't have any commits that the other guy doesn't
have. Zackdude took your tree, made some changes, and that's his
head. Your head is still the same. He's already specified what happens
when you go from your head to his head; that's what he did, so the answer
has to be his head. That's a fast-forward.

Now, if the project lead decided to update from a second contributor who
hadn't rebased their contribution on the new head, then a merge is
required, to resolve the potential conflicts, and this merge needs a
commit.

> No, I still don't see it. I don't see why I would want to add an additional
> changelog entry on top of whatever changelog entries Zackdude has made himself.
> It just seems to pollute the changelog with entries that are essentially
> meaningless. When I read back over the logs, I'm not going to be interested in
> the bookkeeping of when I merged with various developers, I'm going to be
> interested in what those developers actually did to the code, and what *I*
> actually did to the code.

If developer A's changes work, and developer B's changes work, but they
don't work in your merge of them, you'll want to see that. Furthermore,
without a commit with both of their commits as parents, you can't reach
both of their histories from anywhere.

> OK, I don't understand this either. What is the difference between fetching the
> stuff and merging the stuff? Suppose I am working on a local repo of Cogito
> HEAD. I make some changes, commit them, and then I do a cg-pull. What happens?
> Are my changes overwritten? Do they show up at all? Do they exist in some
> nebulous ether that I will never see until I do a merge?

If you do a "cg-pull pasky", this doesn't change any of your stuff, but it
means that "cg-diff -r pasky" will now compare against his new head,
rather than the head he had when you previously did stuff. "cg-log
pasky" will include the new messages, and so forth. Also, you can then do
the merge without a network connection; you can pull overnight and merge
on the train.

You don't see anything different in your working directory, but your
repository essentially "knows more".

	-Daniel
*This .sig left intentionally blank*


