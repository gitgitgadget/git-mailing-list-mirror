From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] commit encoding: store it in commit header rather than mucking with NUL
Date: Sun, 24 Dec 2006 23:27:27 -0800
Message-ID: <7vr6uoo2ow.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612241505290.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.63.0612241643440.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v3b74q1c9.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612250134040.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Dec 25 08:27:51 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GykFS-0003Ir-CB
	for gcvg-git@gmane.org; Mon, 25 Dec 2006 08:27:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754253AbWLYH13 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 25 Dec 2006 02:27:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754249AbWLYH13
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Dec 2006 02:27:29 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:63575 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751977AbWLYH12 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Dec 2006 02:27:28 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061225072728.EWWU25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Mon, 25 Dec 2006 02:27:28 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2vTh1W0031kojtg0000000; Mon, 25 Dec 2006 02:27:41 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612250134040.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Mon, 25 Dec 2006 01:41:47 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35380>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>>  - I was not sure if the "assume the whole commit->buffer is in
>>    the local encoding and recode it into UTF-8" is correct.
>
> For the purpose of showing it, there is no point in using two different 
> encodings. I am not aware of any terminal (and do not own such a terminal 
> anyway) which can display text with parts encoded differently from the 
> rest.

That's not what I meant.  Because the definition of the contents
of the commit has been (and will be --- the unpublished topic
was about suggesting stronger convention across Porcelains) just
the set of fixed headers plus binary blob, the use of different
encodings is entirely up to the users.

I was afraid that there might be something we did (or we did not
do) that encouraged people to have their names (via environment
variables, or perhaps user.name) always in UTF-8 while recording
the log messages in the legacy encoding, and if that kind of use
is already done in the wild, we would end up having to not
reencode the header field but reencode the body.

But I do not think we ever encouraged encoding names in UTF-8 or
anything else (we did encourage use of UTF-8 in the commit log),
so I think we are Ok.
 
