From: "Sean" <seanlkml@sympatico.ca>
Subject: Re: [RFC] adding merge-node to parent lines in a commit
Date: Sun, 15 May 2005 18:07:56 -0400 (EDT)
Message-ID: <1441.10.10.10.24.1116194876.squirrel@linux1>
References: <1282.10.10.10.24.1116192147.squirrel@linux1>   
    <7vfywoqira.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon May 16 00:09:13 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DXRHY-0005xM-5C
	for gcvg-git@gmane.org; Mon, 16 May 2005 00:08:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261277AbVEOWIT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 May 2005 18:08:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261281AbVEOWIT
	(ORCPT <rfc822;git-outgoing>); Sun, 15 May 2005 18:08:19 -0400
Received: from simmts8.bellnexxia.net ([206.47.199.166]:5872 "EHLO
	simmts8-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id S261277AbVEOWH7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 May 2005 18:07:59 -0400
Received: from linux1 ([69.156.111.46]) by simmts8-srv.bellnexxia.net
          (InterMail vM.5.01.06.10 201-253-122-130-110-20040306) with ESMTP
          id <20050515220756.FTJ26867.simmts8-srv.bellnexxia.net@linux1>;
          Sun, 15 May 2005 18:07:56 -0400
Received: from linux1 (linux1.attic.local [127.0.0.1])
	by linux1 (8.12.11/8.12.11) with ESMTP id j4FM7usE009039;
	Sun, 15 May 2005 18:07:56 -0400
Received: from 10.10.10.24
        (SquirrelMail authenticated user sean)
        by linux1 with HTTP;
        Sun, 15 May 2005 18:07:56 -0400 (EDT)
To: "Junio C Hamano" <junkio@cox.net>
User-Agent: SquirrelMail/1.4.4-2
X-Priority: 3 (Normal)
Importance: Normal
In-Reply-To: <7vfywoqira.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, May 15, 2005 5:30 pm, Junio C Hamano said:
> It is not clear to me ID of what object is being recorded as
> SHA1-MERGE-NODE in your proposal.  Care to illustrate?

Hey Junio,

Yes, it's pretty basic unless i'm overlooking something:

Rn---\
>    Mn
>    Mn-1
Rn-1  |
Rn-2  |
Rn-3--/
Initial

So for this particular case it's rather simple, the Rn merge node would have:

parent  Rn-1  (ommitted)
parent  Mn    Rn-3

Essentially, you are recording in the merge commit the length of each
branch that represents new commits that did not exist in this repository
before this merge.

But there are more complicated cases with multiple parent merges.   What
this would avoid is the need to calculate common_anscestor in routines
like git-rev-list, because that information would already be stored.   As
far as I know this information is already available at merge time anyway,
so recording it shouldn't be a burden.   I'm not sure it buys you a ton
out the other end, but perhaps it would be slightly easier to piece the
merge history back together.

Sean




