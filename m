From: Alan <alan@clueserver.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 16:11:51 -0800
Message-ID: <1229645511.5770.29.camel@rotwang.fnordora.org>
References: <1229642734.5770.25.camel@rotwang.fnordora.org>
	 <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 01:13:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDSza-0005sn-2f
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 01:13:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823AbYLSAMB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 19:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751629AbYLSAMA
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 19:12:00 -0500
Received: from 216-99-213-120.dsl.aracnet.com ([216.99.213.120]:56028 "EHLO
	clueserver.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751334AbYLSAMA (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 19:12:00 -0500
Received: from [127.0.0.1] (blackbox.fnordora.org [127.0.0.1])
	by clueserver.org (Postfix) with ESMTP id 7A56CF501C8;
	Thu, 18 Dec 2008 16:11:53 -0800 (PST)
In-Reply-To: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain>
X-Mailer: Evolution 2.24.2 (2.24.2-1.fc10) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103514>

On Thu, 2008-12-18 at 15:58 -0800, Linus Torvalds wrote:
> 
> On Thu, 18 Dec 2008, Alan wrote:
> > 
> > What am i doing wrong here?
> 
> Reverting a merge is your problem.
> 
> You can do it, but you seem to have done it without understanding what it 
> causes.

Obviously.

> A revert of a merge becomes a regular commit that just undoes everything 
> that the merge did in your branch. When you then do the next merge, you'll 
> do that merge with that in mind, so now git will essentially consider the 
> previous merge to be the base line, but your revert undid everything that 
> that one brought in, so the new merge will really only contain the new 
> stuff from the branch you are merging. 

So I will have to look for previous reverts (or "pre-verts") before
merging again.

> So if a merge causes problems, you generally should either undo it 
> _entirely_ (ie do a 'git reset --hard ORIG_HEAD'), not revert it. 
> 
> Of course, if you had already made the merged state public, or done 
> development on top of it, you can't really do that. In which case a revert 
> works, but if you want it back, you should revert the revert, not merge 
> the branch again - because what you merged last time you threw away, and 
> won't be applied again.

On this code base, there were 30+ branches merged before the powers that
be decided to have me pull that one.  It was in the middle of the pile.

I think I know how to fix it.  I am just concerned about having it occur
again if someone else makes the same mistake I did.

Thanks.
