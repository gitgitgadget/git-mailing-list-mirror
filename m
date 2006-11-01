X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Problem with git-push
Date: Wed, 01 Nov 2006 07:33:28 -0800
Message-ID: <7v4ptj5ghj.fsf@assigned-by-dhcp.cox.net>
References: <1162306098.41547.4.camel@mayday.esat.net>
	<7v64e0qclo.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Wed, 1 Nov 2006 15:34:07 +0000 (UTC)
Cc: Florent Thoumie <flz@xbsd.org>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611011205340.1670@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 1 Nov 2006 12:12:43 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30643>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GfI5t-0006GU-Pq for gcvg-git@gmane.org; Wed, 01 Nov
 2006 16:33:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S2992620AbWKAPda (ORCPT <rfc822;gcvg-git@m.gmane.org>); Wed, 1 Nov 2006
 10:33:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992622AbWKAPda
 (ORCPT <rfc822;git-outgoing>); Wed, 1 Nov 2006 10:33:30 -0500
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:32226 "EHLO
 fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP id S2992620AbWKAPd3
 (ORCPT <rfc822;git@vger.kernel.org>); Wed, 1 Nov 2006 10:33:29 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72]) by fed1rmmtao04.cox.net
 (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP id
 <20061101153328.KRDM22409.fed1rmmtao04.cox.net@fed1rmimpo02.cox.net>; Wed, 1
 Nov 2006 10:33:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo02.cox.net with bizsmtp id hTZY1V00r1kojtg0000000 Wed, 01 Nov 2006
 10:33:33 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> but more importantly, if the directory in question was created by 
>> somebody else, I do not think this chmod() would succeed even if you are 
>> in the same group as the owner (i.e. previous creator) of the directory.
>
> But if somebody else created it, it should already have the correct 
> permissions in the first place (unless the user played around with them, 
> which is not a pilot error, but a willfull pointing of the barrel in the 
> general direction of your knee).

True; I think the yesterday's analysis is still incomplete.  I
haven't reached the point where I can explain "is a directory".
If the directory was there and mkdir() failed (but we do not
check its return value), it would have set errno to EEXIST not
to EISDIR.  There is something else going on.

>> [jc: I am CC'ing Johannes to blame him on commit 457f06d6;
>> git-pickaxe is turning out to be quite handy ;-)
>
> I am hating the tool already.

Well, we could rename it to "git credit" ;-).
