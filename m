From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC] Convert builin-mailinfo.c to use The Better String
 Library.
Date: Thu, 6 Sep 2007 18:50:28 +0100 (BST)
Message-ID: <alpine.LFD.0.999.0709061839510.5626@evo.linux-foundation.org>
References: <46DDC500.5000606@etek.chalmers.se><1189004090.20311.12.camel@hinata.boston.redhat.com>
 <vpq642pkoln.fsf@bauges.imag.fr>
 <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, Git <git@vger.kernel.org>
To: Dmitry Kakurin <dmitry.kakurin@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 06 19:51:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ITLVX-0003SQ-BQ
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 19:51:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbXIFRuv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 6 Sep 2007 13:50:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755198AbXIFRuu
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Sep 2007 13:50:50 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:45893 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751064AbXIFRut (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 6 Sep 2007 13:50:49 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86HoUip006364
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 6 Sep 2007 10:50:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l86HoSvT001164;
	Thu, 6 Sep 2007 10:50:29 -0700
In-Reply-To: <4AFD7EAD1AAC4E54A416BA3F6E6A9E52@ntdev.corp.microsoft.com>
X-Spam-Status: No, hits=-3.242 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.31__
X-MIMEDefang-Filter: lf$Revision: 1.185 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57918>



On Wed, 5 Sep 2007, Dmitry Kakurin wrote:
> 
> When I first looked at Git source code two things struck me as odd:
> 1. Pure C as opposed to C++. No idea why. Please don't talk about portability,
> it's BS.

*YOU* are full of bullshit.

C++ is a horrible language. It's made more horrible by the fact that a lot 
of substandard programmers use it, to the point where it's much much 
easier to generate total and utter crap with it. Quite frankly, even if 
the choice of C were to do *nothing* but keep the C++ programmers out, 
that in itself would be a huge reason to use C.

In other words: the choice of C is the only sane choice. I know Miles 
Bader jokingly said "to piss you off", but it's actually true. I've come 
to the conclusion that any programmer that would prefer the project to be 
in C++ over C is likely a programmer that I really *would* prefer to piss 
off, so that he doesn't come and screw up any project I'm involved with.

C++ leads to really really bad design choices. You invariably start using 
the "nice" library features of the language like STL and Boost and other 
total and utter crap, that may "help" you program, but causes:

 - infinite amounts of pain when they don't work (and anybody who tells me 
   that STL and especially Boost are stable and portable is just so full 
   of BS that it's not even funny)

 - inefficient abstracted programming models where two years down the road 
   you notice that some abstraction wasn't very efficient, but now all 
   your code depends on all the nice object models around it, and you 
   cannot fix it without rewriting your app.

In other words, the only way to do good, efficient, and system-level and 
portable C++ ends up to limit yourself to all the things that are 
basically available in C. And limiting your project to C means that people 
don't screw that up, and also means that you get a lot of programmers that 
do actually understand low-level issues and don't screw things up with any 
idiotic "object model" crap.

So I'm sorry, but for something like git, where efficiency was a primary 
objective, the "advantages" of C++ is just a huge mistake. The fact that 
we also piss off people who cannot see that is just a big additional 
advantage.

If you want a VCS that is written in C++, go play with Monotone. Really. 
They use a "real database". They use "nice object-oriented libraries". 
They use "nice C++ abstractions". And quite frankly, as a result of all 
these design decisions that sound so appealing to some CS people, the end 
result is a horrible and unmaintainable mess.

But I'm sure you'd like it more than git.

			Linus
