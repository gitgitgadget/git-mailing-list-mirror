From: linux@horizon.com
Subject: Re: n-heads and patch dependency chains
Date: 3 Apr 2006 18:13:24 -0400
Message-ID: <20060403221324.21960.qmail@science.horizon.com>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 04 00:13:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FQXIr-0001iX-Tg
	for gcvg-git@gmane.org; Tue, 04 Apr 2006 00:13:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751808AbWDCWNf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 3 Apr 2006 18:13:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751809AbWDCWNf
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Apr 2006 18:13:35 -0400
Received: from science.horizon.com ([192.35.100.1]:53557 "HELO
	science.horizon.com") by vger.kernel.org with SMTP id S1751808AbWDCWNf
	(ORCPT <rfc822;git@vger.kernel.org>); Mon, 3 Apr 2006 18:13:35 -0400
Received: (qmail 21961 invoked by uid 1000); 3 Apr 2006 18:13:24 -0400
To: junkio@cox.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18352>

> I suspect people have hard time grasping _why_ you are jumping
> through hoops.  At least I do.  What problem are you trying to
> solve?  You perhaps described your mechanism well enough, but it
> is not quite clear to me what kind of operations are made easier
> with this exercise, against which possible downside of it, if
> any, would be judged.

Oh... I thought he explained that pretty well.

The problem is a long-lived out-of-tree patch, or anything else that's
going to undergo repeated test releases before merging.

Think about swsusp2 or resiser4 or gfs or user-mode linux (now merged)
or nommu linux (now merged) or some similar large patch that takes a
lot of review.

The challenge is to be able to maintain a "latest Linux release + patches"
distribution and still keep a clean patch to submit to Linus that
doesn't have a zillion cross-merges because he doesn't like that,
and they confuse the development history.

It happens with a single developer when you're working on several
independent features and want a "latest & greatest" tree while still
keeping the feature branches separate.

This is the sort of thing that git-rebase and pu branches are used for,
and jgarzik's libata-dev ALL branch is basically a manually operated
hydra.


Some combination of automatic rebasing and automatic generation of
a pu/ALL tree seems like what's being asked for here.  The former
adds new history "before" the branch development, and the latter
adds additional changes "after" it.  All this subterfuge is in
the name of keeping the feature development history clean.


But all of darcs' "patch calculus" ideas are just basically
rebase strategies.  If someone can come up with a good alternative
to diff-and-patch, perhaps git-rebase can develop a number of
underlying strategies like git-merge.
