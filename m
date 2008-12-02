From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Grafting mis-aligned trees.
Date: Tue, 02 Dec 2008 18:38:43 +0100
Message-ID: <493572A3.4070205@drmicha.warpmail.net>
References: <200811171645.12869.bss03@volumehost.net> <200811281701.46778.bss03@volumehost.net> <4935606A.8050906@drmicha.warpmail.net> <200812021119.51857.bss03@volumehost.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss03@volumehost.net>
X-From: git-owner@vger.kernel.org Tue Dec 02 18:40:10 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L7ZED-0006TE-19
	for gcvg-git-2@gmane.org; Tue, 02 Dec 2008 18:40:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708AbYLBRis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Dec 2008 12:38:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754364AbYLBRis
	(ORCPT <rfc822;git-outgoing>); Tue, 2 Dec 2008 12:38:48 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:50078 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754012AbYLBRir (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Dec 2008 12:38:47 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id A572F1CA4DB;
	Tue,  2 Dec 2008 12:38:46 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 02 Dec 2008 12:38:46 -0500
X-Sasl-enc: l7SfsS5KnVUGhZOlPI+D51/Li2bTU1FVNOdpoPHCcXHw 1228239526
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 2719139665;
	Tue,  2 Dec 2008 12:38:46 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <200812021119.51857.bss03@volumehost.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102163>

Boyd Stephen Smith Jr. venit, vidit, dixit 02.12.2008 18:19:
...
> It does feel a bit "hacky", I was hoping git would have better support 
> this, through the subtree merge or something else.  It seems like 
> something that might happen to others, perhaps as a side-effect of a 
> failed attempt at using submodules.

Well, except for 'tar' my solution uses only git commands ;)

> I can't help thinking that rebase -ip might have helped.  I wasn't aware 
> of -p when I was initially working on this problem.  (It doesn't help that 
> I generally use Debian stable, and git 1.4 did not have -p.)

rebase rebases one branch at a time, but you need to rebase/rewrite
several, and the merge info between depends on rewritten sha1s.

...
> I probably don't need the -f.  If there are files that should be ignored 
> (and thus shouldn't be in the repo), I'll filter-branch to cut them out of 
> the history at some point.

'-f' is about not having to clean out refs/original from a previous
filter-branch run.

> What *exactly* is the subtree merge.  The documentation I've read sounds 
> like this case, sort of, but it's rather unclear to me.

I think 'subtree' does what you want, but 'merge' doesn't! 'subtree'
saves you the rewriting (putting TI into project/web), but you want a
one-time conversion anyway. 'subtree' allows you to repeatedly merge
branches with a different root. What it does is it looks for subdir,
'rewrites' the incoming tree automatically and merges the result.

But you don't want a merge, do you? Or else your whole TI history would
be tacked onto FT's head "to the left": a new (subtree) merge commit
would have FT's and TI's head as parents. This is one way of storing TI
history in the full repo, but not the one you said you wanted.

Michael
