From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 23:43:29 -0700
Message-ID: <7vbqp9d8j2.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210211570.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<20060921055252.GA29479@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 08:43:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQIHW-0008Dg-R5
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 08:43:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbWIUGnb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Sep 2006 02:43:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750734AbWIUGnb
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Sep 2006 02:43:31 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:55504 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1750719AbWIUGna (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Sep 2006 02:43:30 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060921064329.QDSG13992.fed1rmmtao11.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Sep 2006 02:43:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id QujF1V00E1kojtg0000000
	Thu, 21 Sep 2006 02:43:16 -0400
To: Jeff King <peff@peff.net>
In-Reply-To: <20060921055252.GA29479@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Sep 2006 01:52:53 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27456>

Jeff King <peff@peff.net> writes:

>>     X - a - b - c - Y
>>   /           /
>> o - d - e - f
>
> In your example, git-merge-base X Y returns X. In fact, I could only get
> one merge base out of git-merge-base --all. I tried looking in the tests
> to find a case that produced multiple merge bases, but I was unable to
> find one. Is there an example floating around somewhere?

There are quite a few in git.git itself.  In the recent history,
this counts 42, the answer to everything.

#!/bin/sh
LF='
'
git rev-list --parents master..next |
while read it p1 p2 octo
do
	case "$p2" in '') continue ;; esac
        mb=`git merge-base --all "$p1" "$p2"`
	case "$mb" in ?*"$LF"?*) echo "$p1 $p2" : $mb ;;
        esac
done
