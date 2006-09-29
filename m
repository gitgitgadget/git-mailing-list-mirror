From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Fix approxidate() to understand more extended numbers
Date: Thu, 28 Sep 2006 23:42:19 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0609282330440.3952@g5.osdl.org>
References: <Pine.LNX.4.64.0609281211260.3952@g5.osdl.org>
 <Pine.LNX.4.64.0609281212380.3952@g5.osdl.org>
 <118833cc0609281712u2ce01bc5r8f3e97ae9c9a749a@mail.gmail.com>
 <Pine.LNX.4.64.0609282300190.3952@g5.osdl.org> <7vd59fp5b9.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Morten Welinder <mwelinder@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Sep 29 08:42:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTC4q-0001sF-Ps
	for gcvg-git@gmane.org; Fri, 29 Sep 2006 08:42:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161448AbWI2Gm0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 02:42:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161451AbWI2Gm0
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 02:42:26 -0400
Received: from smtp.osdl.org ([65.172.181.4]:42220 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161448AbWI2GmZ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Sep 2006 02:42:25 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k8T6gKnW000415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 28 Sep 2006 23:42:20 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k8T6gJxQ006642;
	Thu, 28 Sep 2006 23:42:19 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vd59fp5b9.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.458 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.94__
X-MIMEDefang-Filter: osdl$Revision: 1.155 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28096>



On Thu, 28 Sep 2006, Junio C Hamano wrote:

> Linus Torvalds <torvalds@osdl.org> writes:
> 
> > On Thu, 28 Sep 2006, Morten Welinder wrote:
> >>
> >> Just don't hack at 12am or 12pm.
> >
> > I think 12pm is correct, but 12am probably isn't (12am should _subtract_ 
> > 12, while 12pm does _not_ add 12).
> 
> But you have "if (hour > 0 && hour < 12)" in both am and pm so
> assignment to tm would not trigger...

That's not the point.

If you write

	12:30 am

you really _should_ subtract 12, leaving you with 0:30. We don't. So we 
end up with a 24-hour time of 12:30, which is obviously _pm_, and wrong.

And "12 am" or "12 pm" doesn't work at all.

> > That said, I have a rice cooker that avoids the problem by saying "0:10 PM" 
> > for ten minutes past midday ;)
> 
> You eat rice?

Ok, is it just me, or is that just a very odd question?

I can see the question "You eat uni?". That really _does_ take a bit of 
getting used to. And Natto I really _really_ don't see the point of. 

But rice? Afaik, it's the most common food-staple in the world. It's not 
exactly odd and exotic..

> > Of course, all sane and civilized countries just use 24-hour format 
> > anyway.
> 
> You are referring to the US, but neither is Japan sane nor
> civilized ;-).

Yeah, well, they've been learning bad habits. But at least they are 
metric.

		Linus
