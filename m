From: Dmitry Potapov <dpotapov@nbs-eng.ru>
Subject: Re: [OT] Re: C++ *for Git*
Date: Mon, 24 Sep 2007 01:22:39 +0400
Message-ID: <20070923212239.GA7249@potapov>
References: <877imishdp.fsf@catnip.gol.com> <46F55E03.2040404@krose.org> <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com> <20070923020951.GF24423@planck.djpig.de> <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz> <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com> <20070923104525.GC7118@artemis.corp> <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com> <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marco Costalba <mcostalba@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Sep 23 23:30:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZZ2N-00075o-Dn
	for gcvg-git-2@gmane.org; Sun, 23 Sep 2007 23:30:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753050AbXIWVam (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 23 Sep 2007 17:30:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752717AbXIWVam
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 17:30:42 -0400
Received: from smtp01.mtu.ru ([62.5.255.48]:64955 "EHLO smtp01.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752004AbXIWVal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 17:30:41 -0400
X-Greylist: delayed 473 seconds by postgrey-1.27 at vger.kernel.org; Sun, 23 Sep 2007 17:30:40 EDT
Received: from potapov.private (ppp85-140-169-177.pppoe.mtu-net.ru [85.140.169.177])
	by smtp01.mtu.ru (Postfix) with ESMTP id 03B45A5202A;
	Mon, 24 Sep 2007 01:22:40 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8NLMgEj012274;
	Mon, 24 Sep 2007 01:22:42 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8NLMdL2012273;
	Mon, 24 Sep 2007 01:22:39 +0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58986>

On Sun, Sep 23, 2007 at 09:54:10AM -0700, Linus Torvalds wrote:
> 
> And we do all of this in C. There is no need to go to C++ for any "object 
> oriented principles". It really is just a syntactic issue, and in many 
> ways the syntax "advantage" of C++ is actually a big *disadvantage*.

Certainly, in this respect, C++ provides only syntactic sugar over C,
and there is a real danger of abuse, which leads to horrible programs.
This is especially likely to happen to those who think that the evil
of C++ is lying in templates, exceptions, or something other feature
of C++, because they start to abuse the only "good" feature they know
and inevitably end up with horrible code.

> 	struct somestruct __user *p
> 
> to explicitly say that it's a pointer to user space - and then having 
> every function that takes that pointer have to have that "__user" there is 
> a VERY GOOD THING.

user_ptr<somestruct> p;

> 
> That's very different from having "accessor functions" and making "p" an 
> abstract type, and having the compiler automatically generate the right 
> kind of access. That kind of stuff is TOTAL CRAP, and it's an example of 
> how C++ has a horrible design, where you carry around _implicit_ knowledge 
> instead of making the knowledge explicit and visible locally too.

Whether it will convert to something or not depends entirely on the
definition of user_ptr. So, it can be as explicit as you wish, or
completely implicit. C++ does not impose anything on you here. So,
the problem is not in C++ but in the crappy mentality -- "let's hide
everything behind 'higher' abstraction" or "let's hide this thing too
because we can". Yes, these people end up with total crap. And yes,
those people tend to prefer C++ over C, just because C++ is better at
hiding. But I don't think that C++ forces anyone to do that...

> The same goes for things like memory allocation. Memory allocation issues 
> are often some of the *biggest* performance issues, and that means that 
> they have to be explicit. I'm actually a big fan of GC, but most languages 
> that implement GC do it exactly the wrong way in my opinion: they make it 
> a fundamental thing that covers everything, and it all happens implicitly, 
> instead of making it explicit.

Stroustrup was not a big fan of GC, so he made the language to be useful
in absence of any GC, and it allows to manage memory and some other
resources though not automatically, but with much less efforts than in C.

Maybe, your idea of more explicit GC is better than what C++ offers. It
is difficult for me to say without trying, but as you said most languages
implement GC in the wrong way in your opinion, so I don't think I will
have a chance to try any language that does it right. As to "caches" in
Git, it works really nicely, but Git is not a programming language.

> But other parts of C++ are just nasty. The whole OO layer seems designed 
> to do a lot of things implicitly and in the wrong way.

It could do a lot of things implicitly, but it does not force you,
except calling destructor when the control leaves the scope of
declaration, but I hardly can consider it as implicit.

> I also disagree with exception handling,

Perhaps, you look at it from the kernel point of view. Otherwise, I
would like to hear your arguments against it. In fact, I don't think
it is possible to write generic algorithms without exceptions. Of
course, if you write a program that can print an error to stderr and
exit, there is no much need for them. So, it may depend on the task.

>  - the stuff C++ *does* have is usually nasty. Implicit initializers and 
>    destructors and the magic lifetime rules of objects etc

I am not sure what is wrong with initializers and destructors in C++,
but certainly there is no magic lifetime rules in C++, as it is fully
determined by the scope. In fact, other high level languages that use
GC have much more unpredictable lifetime rules for objects.


Dmitry Potapov

PS Please, do not confuse me with Dmitry Kakurin, who started this
thread, because my position is opposite to his. Though I like C++,
I fully understand most of your consideration in choosing C for Git.
