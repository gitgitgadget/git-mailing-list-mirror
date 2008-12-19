From: Alan <alan@clueserver.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 16:35:48 -0800
Message-ID: <1229646948.5770.33.camel@rotwang.fnordora.org>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>
	 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
	 <1229645511.5770.29.camel@rotwang.fnordora.org>
	 <alpine.LFD.2.00.0812181614070.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:37:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDTMm-0004XK-70
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752199AbYLSAf6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:35:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752185AbYLSAf6
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:35:58 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:45287 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752164AbYLSAf5 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:35:57 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id D20DDF501C8;
	Thu, 18 Dec 2008 16:35:50 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812181614070.14014@localhost.localdomain>
X-Mailer: Evolution 2.24.2 (2.24.2-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103519>

On Thu, 2008-12-18 at 16:21 -0800, Linus Torvalds wrote:
> 
> On Thu, 18 Dec 2008, Alan wrote:
> > 
> > I think I know how to fix it.  I am just concerned about having it occur
> > again if someone else makes the same mistake I did.
> 
> I suspect we should warn about reverting merges. I'm surprised we don't 
> already. Reverting a merge isn't "wrong", but it's a whole lot more subtle 
> than reverting a regular commit.
> 
> Reverting a regular commit just effectively undoes what that commit did, 
> and is fairly straightforward. But reverting a merge commit also undoes 
> the _data_ that the commit changed, but it does absolutely nothing to the 
> effects on _history_ that the merge had.
> 
> So the merge will still exist, and it will still be seen as joining the 
> two branches together, and future merges will see that merge as the last 
> shared state - and the revert that reverted the merge brought in will not 
> affect that at all.
> 
> So a "revert" undoes the data changes, but it's very much _not_ an "undo" 
> in the sense that it doesn't undo the effects of a commit on the 
> repository history.
> 
> So if you think of "revert" as "undo", then you're going to always miss 
> this part of reverts. Yes, it undoes the data, but no, it doesn't undo 
> history.

So what is the recommended way to undo mistaken merges caught after the
fact that will not fubar later merges?
