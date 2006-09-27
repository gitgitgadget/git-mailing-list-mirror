From: David Rientjes <rientjes@cs.washington.edu>
Subject: Re: [PATCH 3/3] diff --stat: sometimes use non-linear scaling.
Date: Tue, 26 Sep 2006 22:32:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64N.0609262216390.12560@attu2.cs.washington.edu>
References: <7vfyeejakq.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64N.0609262005150.520@attu4.cs.washington.edu>
 <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 27 07:32:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GSS2Q-0006s6-E9
	for gcvg-git@gmane.org; Wed, 27 Sep 2006 07:32:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965346AbWI0Fcv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Sep 2006 01:32:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965347AbWI0Fcv
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Sep 2006 01:32:51 -0400
Received: from mx2.cs.washington.edu ([128.208.2.105]:34742 "EHLO
	mx2.cs.washington.edu") by vger.kernel.org with ESMTP
	id S965346AbWI0Fcu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Sep 2006 01:32:50 -0400
Received: from attu2.cs.washington.edu (attu2.cs.washington.edu [128.208.1.138])
	by mx2.cs.washington.edu (8.13.7/8.13.7/1.6) with ESMTP id k8R5WmUj014497
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 26 Sep 2006 22:32:48 -0700
	(envelope-from rientjes@cs.washington.edu)
Received: from localhost (rientjes@localhost)
	by attu2.cs.washington.edu (8.13.7/8.13.7/Submit/1.2) with ESMTP id k8R5WlWv013441;
	Tue, 26 Sep 2006 22:32:47 -0700
	(envelope-from rientjes@cs.washington.edu)
X-Authentication-Warning: attu2.cs.washington.edu: rientjes owned process doing -bs
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz8lj3pl.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27875>

On Tue, 26 Sep 2006, Junio C Hamano wrote:

> David Rientjes <rientjes@cs.washington.edu> writes:
> 
> > Again with the constant placement in a comparison expression.
> 
> I won't comment on this one.  See list archives ;-).
> 

I'm very familiar with the list archives and your support of writing 
relationals like 0 < x.  It's a matter of taste.  And since the large 
majority of programmers in any language write x > 0 instead, I think it's 
preferrable to write code that is in the style and taste of the majority.

Large software projects require a conformity in the style in which the 
code is written.  Granted the git developer community is small, there is 
still a need for this confomity so that developers don't have to put up 
with the subtleties in the style of which individuals decide to code.

When I read "x > 0", my mind parses that very easily.  When I read "0 < 
x", it takes me a few cycles longer.  I think the goal of any software 
project is to not only emit efficient and quality code, but also code that 
can be read and deciphered with ease unless it's impossible otherwise.

> What's happening here in this particular case is:
> 
> 	if the changes fits within the alloted width
> 		; /* we do not have to do anything */
> 	else if we are using non-linear scale {
>                	scale it like this
> 	}
> 	else {
>                	scale it like that
> 	}
> 
> so the code actually matches the flow of thought perfectly well.
> 
> I first tried to write it without "if () ;/*empty*/ else" chain
> like this:
> 
> 	if given width is narrower than changes we have {
>         	if we are doing non-linear scale {
>                 	scale it like this
>                 }
>                 else {
>                 	scale it like that
> 		}
> 	}
> 
> 
> It made the indentation unnecessarily deep.
> 

To change the code itself because of a hard 80-column limit or because 
you're tired of hitting the tab key is poor style.  The idents are there 
for a purpose: it tells the reader that the code is inside a block.  So 
when this conditional becomes a screen wide, I can understand it on the 
second screen and remember that I'm inside a conditional and not rely on 
the previous 'else' to jog my memory.  C is not a whitespace-dependent 
language like Python, but since when did idents (which are there _solely_ 
for the purpose of helping the reader) become deprecated?

		David
