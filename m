From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: favor ~/.subversion/ ssl client cert settings
Date: Thu, 21 Jun 2007 17:25:08 -0700
Message-ID: <7vfy4kbztn.fsf@assigned-by-dhcp.pobox.com>
References: <11824677432401-git-send-email-hacker@klever.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael Krelin <hacker@klever.net>
X-From: git-owner@vger.kernel.org Fri Jun 22 02:25:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Wxd-0003qe-Dk
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 02:25:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751235AbXFVAZL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 20:25:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751289AbXFVAZL
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 20:25:11 -0400
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:61082 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751007AbXFVAZK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 20:25:10 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070622002509.KQDZ2558.fed1rmmtao107.cox.net@fed1rmimpo02.cox.net>;
          Thu, 21 Jun 2007 20:25:09 -0400
Received: from assigned-by-dhcp.pobox.com ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id EQR81X00Z1kojtg0000000; Thu, 21 Jun 2007 20:25:09 -0400
In-Reply-To: <11824677432401-git-send-email-hacker@klever.net> (Michael
	Krelin's message of "Fri, 22 Jun 2007 01:15:43 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50661>

Sorry, but I am not familiar with SVN API.

In plain English, what does this change mean and what does it
buy us?  An expected answer is something like:

	Without this change, there is no way to authenticate
        with client SSL certificates, as certificates registered
        in ~/.subvsersion are ignored.

BTW, if that is what you meant, it contradicts the word "favor"
in the proposed commit title.  "Favor" would mean "We do support
it already but in lower precedence than something else, which is
inconvenient, so let's move it up so that it is used if found
without bothering other possibilities".  

If that is what you really meant, then the answer would be in
the form of:

	Curently, even when the client wants to use SSL
        certificate to authenticate with the server, X
        authenticator is tried first which causes Y that is
        irritating.  This patch makes the client certificate
        authenticator be tried first.

But if that is what is going on, we need to judge if the
"irritation" factor is universally true, or just affects people
who want to use client SSL cert; if the change makes it more
convenient for client cert people by making it less convenient
for others, the relative merit needs to be debated to justify
the change.

I am guessing that you meant the former (we currently totally
ignore it, and the patch adds the missing support), but what
would I know...

And if that is the case, then I think the word you wanted to use
is not "favor" but "honor".

In any case, the patch needs a handful lines of proposed commit
log message to explain and justify the change, like the above
two examples I showed here.
