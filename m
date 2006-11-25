X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/5] get_shallow_commits: Avoid memory leak if a commit has been reached already.
Date: Sat, 25 Nov 2006 11:44:21 -0800
Message-ID: <7v1wnr2twq.fsf@assigned-by-dhcp.cox.net>
References: <87slg8uc0l.fsf@wine.dyndns.org> <ek9u4f$vmk$1@sea.gmane.org>
	<Pine.LNX.4.63.0611251947310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sat, 25 Nov 2006 19:44:37 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.63.0611251947310.30004@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Sat, 25 Nov 2006 19:49:32 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/32303>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1Go3Rw-0002Q1-3c for gcvg-git@gmane.org; Sat, 25 Nov
 2006 20:44:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S967139AbWKYToX (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sat, 25 Nov 2006
 14:44:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S967150AbWKYToX
 (ORCPT <rfc822;git-outgoing>); Sat, 25 Nov 2006 14:44:23 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37293 "EHLO
 fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP id S967139AbWKYToW
 (ORCPT <rfc822;git@vger.kernel.org>); Sat, 25 Nov 2006 14:44:22 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao03.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061125194422.QYPL4817.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>; Sat, 25
 Nov 2006 14:44:22 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id r7jq1V00m1kojtg0000000; Sat, 25 Nov 2006
 14:43:51 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Sat, 25 Nov 2006, Anand Kumria wrote:
>
>> Any reason you didn't do:
>> 
>> if (!commit->util)
>> 	commit->util = xcalloc(1, sizeof(int));
>
> xmalloc() does not initialize the memory. Therefore, it is usually 
> preferred if you initialize the memory yourself. In this case, the memory 
> is initialized to 0, even if it is not allocated.
>
> It may be a minor performance issue, but it is a good habit to use xcalloc 
> only if it is needed.

I think you could pretend the commit->util field to be of some
kind of int and avoid the allocation altogether ;-).
