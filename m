From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: Help breaking up a large merge.
Date: Thu, 18 Sep 2008 18:41:34 +0200
Message-ID: <48D284BE.5040107@viscovery.net>
References: <20080918152154.GA27019@linode.davidb.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: David Brown <git@davidb.org>
X-From: git-owner@vger.kernel.org Thu Sep 18 18:42:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KgMah-0005CX-4v
	for gcvg-git-2@gmane.org; Thu, 18 Sep 2008 18:42:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753523AbYIRQlh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Sep 2008 12:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753085AbYIRQlh
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Sep 2008 12:41:37 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:52342 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752789AbYIRQlh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Sep 2008 12:41:37 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1KgMZT-0007DW-46; Thu, 18 Sep 2008 18:41:35 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id D3B484FB; Thu, 18 Sep 2008 18:41:34 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <20080918152154.GA27019@linode.davidb.org>
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96216>

David Brown schrieb:
> Say we have a tree that we've been working on for a few months.  An
> outside vendor has also been working on the same tree during this
> time, and we need to merge with their work.
> 
> The difficulty I'm having is that there are a lot of conflicts
> resulting from the merge (expected), and it would be nice to somehow
> be able to work on a smaller set of these conflicts at a time.
> 
> Some of the conflicts are caused by a single change in the other tree.
> This is easy to cherry-pick into my tree, resolve, and then test those
> changes independently.
> 
> But other conflicts are caused by groups of commits that are
> interleaved with others.

In a similar situation I was thinking about this approach:

1. Do the merge.
2. Resolve conflicts in an area that can be tested in isolation.
3. Undo all other changes that the merge brought in.
4. Commit.
5. Install a graft that removes the second parent of the merge commit.
6. Rinse and repeat.
7. Finally, remove the grafts, and perhaps collapse the merge commits.

I didn't test this, yet.

Hmm, thinking a bit more about this, 1 and 5 can probably be replaced by a
mere 'git merge --squash'.

-- Hannes
