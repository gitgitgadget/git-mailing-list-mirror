From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 19:15:51 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508271855100.23242@iabervon.org>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
 <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 28 01:20:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E99qY-0006n3-Kl
	for gcvg-git@gmane.org; Sun, 28 Aug 2005 01:12:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750737AbVH0XMN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 19:12:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbVH0XMN
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 19:12:13 -0400
Received: from iabervon.org ([66.92.72.58]:8974 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750737AbVH0XMM (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 19:12:12 -0400
Received: (qmail 5582 invoked by uid 1000); 27 Aug 2005 19:15:51 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 27 Aug 2005 19:15:51 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <Pine.LNX.4.63.0508271709530.23242@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7856>

On Sat, 27 Aug 2005, Daniel Barkalow wrote:

> Okay, so it looks to me like the only cases that care about the contents
> of the index, other than in stage 0 (which is effectively another tree,
> but already in index-form rather than tree-form), are 2 and 3, and these
> only care because read-tree modifies the stage of entries, rather
> than removing them and adding a stage-0 replacement entry; if it went
> through the add logic without SKIP_DFCHECK, that would reject the same
> things that causes_df_conflict rejects (at the point where whichever is
> second is done).
>
> So if I do the merge on tree entries (plus a stage-0 ce for the input from
> the index), and then add the result(s) to the cache, I can skip
> causes_df_conflict() in favor of just not using SKIP_DFCHECK. Is this
> right?

What I missed was that the effect of causes_df_conflict is to give "no
merge" for the entry, rather than giving an error overall. So I do need an
equivalent.

> Also, there doesn't actually seem to be a DF test in t1000; I think the
> t1005 DF test covers these cases (by the emu23 path into this code). Is
> this right?

Looks like stuff all over the place fails if causes_df_conflict is messed
up, so I should be covered.

	-Daniel
*This .sig left intentionally blank*
