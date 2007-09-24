From: Dmitry Potapov <dpotapov@gmail.com>
Subject: Re: [OT] Re: C++ *for Git*
Date: Mon, 24 Sep 2007 14:46:03 +0400
Message-ID: <20070924104603.GB25435@potapov>
References: <5e4707340709221550o6d0a6062qd51c16a278727c29@mail.gmail.com> <20070923020951.GF24423@planck.djpig.de> <20070923062527.GA8979@old.davidb.org> <851wcpsv4z.fsf@lola.goethe.zz> <e5bfff550709230229t79004ce2j5ce8c2ae7744a7f2@mail.gmail.com> <20070923104525.GC7118@artemis.corp> <e5bfff550709230642v7fa5e837s7a5b9082b043672d@mail.gmail.com> <alpine.LFD.0.999.0709230911360.16478@woody.linux-foundation.org> <20070923212239.GA7249@potapov> <3f4fd2640709231525q52a9865alc834ca46b85998fe@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Marco Costalba <mcostalba@gmail.com>,
	Pierre Habouzit <madcoder@debian.org>,
	David Kastrup <dak@gnu.org>,
	Frank Lichtenheld <frank@lichtenheld.de>,
	Alex Unleashed <alex@flawedcode.org>,
	Kyle Rose <krose@krose.org>, Miles Bader <miles@gnu.org>,
	Dmitry Kakurin <dmitry.kakurin@gmail.com>,
	Git <git@vger.kernel.org>
To: Reece Dunn <msclrhd@googlemail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 12:46:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZlSQ-0006Ws-SS
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 12:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753493AbXIXKqZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2007 06:46:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752839AbXIXKqZ
	(ORCPT <rfc822;git-outgoing>); Mon, 24 Sep 2007 06:46:25 -0400
Received: from smtp06.mtu.ru ([62.5.255.53]:52322 "EHLO smtp06.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752712AbXIXKqY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2007 06:46:24 -0400
Received: from potapov.private (ppp85-140-171-48.pppoe.mtu-net.ru [85.140.171.48])
	by smtp06.mtu.ru (Postfix) with ESMTP id 02AEB7BF474;
	Mon, 24 Sep 2007 14:46:08 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8OAk8N2026248;
	Mon, 24 Sep 2007 14:46:08 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8OAk3rv026246;
	Mon, 24 Sep 2007 14:46:03 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
In-Reply-To: <3f4fd2640709231525q52a9865alc834ca46b85998fe@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59036>

On Sun, Sep 23, 2007 at 11:25:01PM +0100, Reece Dunn wrote:
> The next version of C++ is going to have garbage collection that the
> user can enable, disable or remain neutral about. However, this is
> program-wide and has many traps that you could fall into.

Sure. C++ has not been design to be garbage collection friendly, in
fact, even now, you can use some GC with C++, but it can be painful.
I don't think that the new standard will change much in this respect.

> > > But other parts of C++ are just nasty. The whole OO layer seems designed
> > > to do a lot of things implicitly and in the wrong way.
> >
> > It could do a lot of things implicitly, but it does not force you,
> > except calling destructor when the control leaves the scope of
> > declaration, but I hardly can consider it as implicit.
> 
> You have to add the explicit keyword to any constructor to prevent an
> automatic conversion. Therefore, the constructors that are called are
> implicit by default.

Yes, I would prefer if it were opposite by default, but it was an
initial mistake in design, and you cannot change it without breaking
a lot of people code.

> If you have a conversion operator, this is always
> implicitly called when there is a match by the compiler.

Conversation operator should be written only if you do want an implicit
conversation, and that may be useful sometimes, albeit very rarely.

> 
> I agree with Linus here, there are a lot of things that happen implicily.
> 
> > > I also disagree with exception handling,
> >
> > Perhaps, you look at it from the kernel point of view. Otherwise, I
> > would like to hear your arguments against it. In fact, I don't think
> > it is possible to write generic algorithms without exceptions. Of
> > course, if you write a program that can print an error to stderr and
> > exit, there is no much need for them. So, it may depend on the task.
> 
> There are many issues with exceptions.
> 
> Firstly, there is throwing an exception from a destructor, which is
> warned against in any good C++ book, but does not prevent you from
> doing so (even if it is inadvertantly)!

In general, the compiler does not have all information to know whether
a destructor can or cannot throw an exception, and even less it knows
about your real intentions. There are many ways to write something
that will not work. You can create an infinite recursion, but I don't
think it is a good argument against recursion.

> 
> More importantly though, is the loss of contextual information.

Do you think that an error code contains much more contextual
information?

> Consider throwing the same exception on all calls to API that return
> the same error code type. 

I did not mean that all error codes should be returned as an exception.
Exception in C++ is something that should not normally happen, like
failure to allocate memory. So, you usually do not want to handle
this situation immediate.

> The code that processes this may be anywhere
> in the system. This makes it impossible to do any sensible recovery
> (if possible), or error reporting. The exception can be rethrown or
> translated to another exception, making it impossible to find the
> originator of the exception. This makes it harder, if not impossible,
> to track the exception back to the source when you are at a breakpoint
> in the exception handler.

In gdb, you can catch all exception when thrown using "catch throw".
And again, I don't see how it is better when a program returns an
error code, especially if this error code is recoded couple times
in the process of returning. So the problem is not with exceptions,
but usually with bad design.

> Then there is dealing with caller boundaries. That is, when a callback
> or interface function in the application will return to the operating
> system (e.g. when handling a draw request from X11), or another
> language such as Python. Also, because different compiler vendors and
> versions handle exceptions differently, if you want to support
> different compilers (and you have resolved the name mangling
> incompatibilities), you need to handle exceptions correctly in these
> cases, or risk having major problems that would be impossible to
> trace.

You named some interoperability issues with C++ (and there are many
of them), but it is not an argument against exceptions per se.

> Not to mention that anywhere new, dynamic_cast and other
> language features are used may throw exceptions.

dynamic_cast throws an exception only for references, but not for
pointers, and there is a good reason for that -- references should
not be NULL; and if you want to avoid bad_alloc exception, you can
use "T* p = new (std::nothrow) T;" but it is rarely needed.


Dmitry Potapov
