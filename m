From: Martin Mares <mj@ucw.cz>
Subject: Re: git-cvs-import retries
Date: Sat, 18 Feb 2006 14:14:07 +0100
Message-ID: <mj+md-20060218.130645.5680.albireo@ucw.cz>
References: <mj+md-20060217.193146.10308.albireo@ucw.cz> <7v1wy1t9cb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 18 14:14:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FARuk-0000Zs-52
	for gcvg-git@gmane.org; Sat, 18 Feb 2006 14:14:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751248AbWBRNOO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 18 Feb 2006 08:14:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751249AbWBRNOO
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Feb 2006 08:14:14 -0500
Received: from albireo.ucw.cz ([84.242.65.108]:25473 "EHLO albireo.ucw.cz")
	by vger.kernel.org with ESMTP id S1751248AbWBRNOO (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Feb 2006 08:14:14 -0500
Received: by albireo.ucw.cz (Postfix, from userid 1000)
	id 012B9110090; Sat, 18 Feb 2006 14:14:07 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v1wy1t9cb.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16412>

Hi Junio!

> First, one technicality.  You can see what's wrong with the
> above, right?  Remember, the top part of your message goes into
> the commit log, so we do not want "Hello!" nor signature.

Sorry about that, the patch was intended more for discussion than
for applying.

> I read _line() three times but its return value is the lexical
> variable $res which is initialized to 0 and then either reset to
> 0 by assignment or updated with $res += somethingelse.  So I do
> not see how you can get a defined but empty string in there.

You almost convinced me that my fix couldn't have changed anything :-)

But it did and I finally understand why: _line() can exit not only
by return, but also by falling over when readline() returns undef.
In this case, something weird is returned (the most recent expression
evaluated) and it's *sometimes* the empty string.

I will send a new patch.

				Have a nice fortnight
-- 
Martin `MJ' Mares   <mj@ucw.cz>   http://atrey.karlin.mff.cuni.cz/~mj/
Faculty of Math and Physics, Charles University, Prague, Czech Rep., Earth
The first myth of management is that it exists.
