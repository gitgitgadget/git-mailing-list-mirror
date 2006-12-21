From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/3] Add a test for git-rerere
Date: Thu, 21 Dec 2006 00:41:53 -0800
Message-ID: <7vhcvpej3i.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0612201737190.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	<7v4prqfm6c.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.63.0612210927150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 21 09:42:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by dough.gmane.org with esmtp (Exim 4.50)
	id 1GxJUz-0006Tc-Ny
	for gcvg-git@gmane.org; Thu, 21 Dec 2006 09:41:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422830AbWLUIlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Dec 2006 03:41:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422864AbWLUIlz
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Dec 2006 03:41:55 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:38942 "EHLO
	fed1rmmtao01.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1422830AbWLUIly (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Dec 2006 03:41:54 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20061221084153.KXMX9173.fed1rmmtao01.cox.net@fed1rmimpo01.cox.net>;
          Thu, 21 Dec 2006 03:41:53 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 1LhB1W0091kojtg0000000; Thu, 21 Dec 2006 03:41:12 -0500
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
In-Reply-To: <Pine.LNX.4.63.0612210927150.19693@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Thu, 21 Dec 2006 09:34:07 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35029>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> > +rm $rr/postimage
>> > +echo -ne "$sha1\ta1\0" > .git/rr-cache/MERGE_RR
>> 
>> Hmmmmmm.  I've stayed away from "echo -e" so far...
>
> Rather do it with tr? Like this:
>
> 	echo -n "$sha1	a1X" | tr X '\0' > .git/rr-cache/MERGE_RR

Bog-standard old timer's way is not to use -n nor X but just do:

	echo "stuff you want to NUL terminate" | tr '\012' '\0'

> Is $((1+2)) portable enough? I always thought this is a bashism...

That's also in ksh and dash (and in POSIX) and recent updates to
out *.sh scripts make liberal use of them.  As long as you do
not overflow you are fine.
