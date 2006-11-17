X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [DRAFT] Branching and merging with git
Date: Thu, 16 Nov 2006 17:31:23 -0800
Message-ID: <7v1wo22710.fsf@assigned-by-dhcp.cox.net>
References: <7vslgj2bug.fsf@assigned-by-dhcp.cox.net>
	<20061117011319.6738.qmail@science.horizon.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Fri, 17 Nov 2006 01:32:10 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <20061117011319.6738.qmail@science.horizon.com>
	(linux@horizon.com's message of "16 Nov 2006 20:13:19 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31656>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GksZo-00008X-RI for gcvg-git@gmane.org; Fri, 17 Nov
 2006 02:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424886AbWKQBbZ (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 20:31:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424887AbWKQBbZ
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 20:31:25 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:41604 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S1424886AbWKQBbY
 (ORCPT <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 20:31:24 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061117013124.ORKV7494.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Thu, 16
 Nov 2006 20:31:24 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id ndXW1V00P1kojtg0000000; Thu, 16 Nov 2006
 20:31:31 -0500
To: linux@horizon.com
Sender: git-owner@vger.kernel.org

linux@horizon.com writes:

> If anyone has any advice on how and why one would invoke git-merge
> directly (the one why I know is to do a >2-way merge), that would
> be appreciated.

I use "git pull . topicA topicB" for a tetrapus, so that is not
a reason for me, but when a topicA's older parts are worthy to
be in 'next' while later parts are not yet, I often do (on 'next'):


	git merge "Merge early part of branch 'topicA'" HEAD topicA~3

Also I used to do

	git merge fast HEAD someTopicIknowIsAFastForward

because it felt faster than "git pull . someTopicIknowisAFastForward"
but I do not do that these days and I would not recommend it to anybody.

>>> 2) Revert changes to a small number of files.
>>>
>>> 	git checkout [<revision>] [--] <paths>
>>>    will copy the version of the <paths> from the index to the working
>>>    directory.  If a <revision> is given, the index for those paths will
>>>    be updated from the given revision before copying from the index to
>>>    the working tree.
>>>
>>>    Unlike the version with no <paths> specified, this does NOT update
>>>    HEAD, even if <paths> is ".".
>> 
>> It's great that you talk correctly about the latest feature-fix
>> that is queued for maint but not yet pushed out.
>
> Um... there's a fix in there?  I thought that's how it always worked.

I do not think naming a directory (say, ".") to mean "revert
everything underneath this directory" worked until the patch I
sent out post 1.4.4 release.

> I also need to mention that if you want to pull a remote tag,
> you need to prefix it with "tags/".

Yes, recent -mm announce message says "git pull ... tag v2.x-mmY".
"tag v2.x-mmy" is a shorthand for "refs/tags/v2.x-mmY:refs/tags/v2.x-mmY"

