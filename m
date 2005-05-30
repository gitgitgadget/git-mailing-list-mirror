From: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 14:11:00 +0200
Message-ID: <20050530121100.GS12290@cip.informatik.uni-erlangen.de>
References: <20050529231053.GD12290@cip.informatik.uni-erlangen.de> <20050529231621.GE12290@cip.informatik.uni-erlangen.de> <20050529234606.GF12290@cip.informatik.uni-erlangen.de> <20050529235630.GG12290@cip.informatik.uni-erlangen.de> <7vsm05bkps.fsf@assigned-by-dhcp.cox.net> <20050530013056.GH12290@cip.informatik.uni-erlangen.de> <7vmzqd4041.fsf@assigned-by-dhcp.cox.net> <20050530083653.GL12290@cip.informatik.uni-erlangen.de> <20050530092140.GQ12290@cip.informatik.uni-erlangen.de> <7vhdgl2ext.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 14:09:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dcj50-0002Y6-CG
	for gcvg-git@gmane.org; Mon, 30 May 2005 14:09:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261495AbVE3MLd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 08:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVE3MLd
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 08:11:33 -0400
Received: from faui03.informatik.uni-erlangen.de ([131.188.30.103]:1970 "EHLO
	faui03.informatik.uni-erlangen.de") by vger.kernel.org with ESMTP
	id S261495AbVE3MLN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 08:11:13 -0400
Received: from faui03.informatik.uni-erlangen.de (faui03.informatik.uni-erlangen.de [131.188.30.103])
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) with ESMTP id j4UCB0S8002783
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Mon, 30 May 2005 12:11:01 GMT
Received: (from sithglan@localhost)
	by faui03.informatik.uni-erlangen.de (8.12.9/8.12.9) id j4UCB0Xa002782;
	Mon, 30 May 2005 14:11:00 +0200 (CEST)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vhdgl2ext.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Hello,

> I think merge-base between A and A is always A, so the second pass
> would eliminate the dups anyway...

two scenarios come into my mind which could clash (second ommited
because it would rely that the 'local' HEAD is changes on threeway
merge)

consider the follow MERGE_HEADS = (A B B)

    /----- A
   /
-GCA------ B

Now B gets twice automatic/threeway/manual merged into A which is just
stupid and couldn't work out.

------------------------------------------------------------------------------

But I still don't know how to handle the following scenario:

    /----- A
   /
-GCA------GCA---- B
            \---- C

MERGES_HEAD = (A B C). I think the best way would be introduce a
temporary commit object otherwise  C into AB merge would have merge_base
on the first GCA which is suboptimal and maybe wrong isn't it?

    /----- A -------D---E
   /               /   /
-GCA------GCA---- B   /
            \------- C

Where D is a temporary COMMIT obeject to use the second GCA to merge C
with D and gets E.

Gruesse,
	Thomas
