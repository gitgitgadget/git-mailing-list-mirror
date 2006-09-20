From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] add receive.denyNonFastforwards config variable
Date: Wed, 20 Sep 2006 16:38:05 -0700
Message-ID: <7vlkoeds82.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0609210027430.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	<7vfyemf9ah.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 21 01:38:25 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GQBdz-0006oe-T5
	for gcvg-git@gmane.org; Thu, 21 Sep 2006 01:38:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750706AbWITXiJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Sep 2006 19:38:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750723AbWITXiJ
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Sep 2006 19:38:09 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:43749 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1750706AbWITXiH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Sep 2006 19:38:07 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060920233806.BWNB18985.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Wed, 20 Sep 2006 19:38:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Qnds1V00C1kojtg0000000
	Wed, 20 Sep 2006 19:37:53 -0400
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0609210107140.19042@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Sep 2006 01:07:54 +0200
	(CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27432>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> 	No longer barfs on new refs, and tries all merge bases (even if I
> 	cannot come up with any scenario where there is more than one merge
> 	base in the case of a fast forward).

Hmm.  If that is the case (and I think it is although I haven't
come up with a proof), the test can be written like this:

	if (bases && !bases->next &&
            hashcmp(old_sha1, bases->item->object.sha1))
        	; /* happy */
	else
        	return error("not a fast forward");

perhaps?
