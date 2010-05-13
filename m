From: Peter Vereshagin <peter@vereshagin.org>
Subject: Re: [PATCH 0/2] gitweb: Add support for running gitweb as FastCGI
	script
Date: Thu, 13 May 2010 17:10:16 +0400
Organization: '
Message-ID: <20100513131016.GA5250@screwed.box>
References: <1273236845-6523-1-git-send-email-jnareb@gmail.com> <201005111258.53388.jnareb@gmail.com> <20100511120924.GC5220@screwed.box> <201005111551.21316.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Cc: Petr Baudis <pasky@suse.cz>, Eric Wong <normalperson@yhbt.net>,
	git@vger.kernel.org, Sam Vilain <sam.vilain@catalyst.net.nz>,
	Juan Jose Comellas <juanjo@comellas.org>,
	John Goerzen <jgoerzen@complete.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 13 15:10:50 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OCYBa-0005Nk-0A
	for gcvg-git-2@lo.gmane.org; Thu, 13 May 2010 15:10:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751997Ab0EMNKj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 May 2010 09:10:39 -0400
Received: from ns1.skyriver.ru ([89.108.118.221]:61793 "EHLO mx1.skyriver.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751512Ab0EMNKh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 May 2010 09:10:37 -0400
Received: from localhost (load-me-in-a-browser-if-this-tor-node-is-causing-you-grief.riseup.net [77.109.139.87])
	by mx1.skyriver.ru (Postfix) with ESMTPSA id 30C445A94;
	Thu, 13 May 2010 16:58:59 +0400 (MSD)
Content-Disposition: inline
In-Reply-To: <201005111551.21316.jnareb@gmail.com>
X-Face: 8T>{1owI$Byj]]a;^G]kRf*dkq>E-3':F>4ODP[#X4s"dr?^b&2G@'3lukno]A1wvJ_L (~u 6>I2ra/<,j1%@C[LN=>p#_}RIV+#:KTszp-X$bQOj,K
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147002>

Hey Mr(s) Jakub show some good to me!
2010/05/11 15:51:15 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> On Tue, 11 May 2010, Peter Vereshagin wrote:
JN> > 2010/05/11 12:58:50 +0200 Jakub Narebski <jnareb@gmail.com> => To Peter Vereshagin :
JN> 
JN> > > > > I have changed this 'exit' to non-local goto to toplevel.  It could be
JN> > > > > done instead by redefining 'exit' subroutine, like shown below, but I
JN> > > > > feel that would be hacky if you can change gitweb code (it is not
JN> > > > > black box you should not touch).
JN> > > > 
JN> > > > Right, one shouldn't ever redefine perl built-in functions. I did only because
JN> > > > of no other way to 'get things working'
JN> > > 
JN> > > Why not?  For example CGI::Carp redefines 'die' to log errors.
JN> > 
JN> > Ouch, sorry, I meant 'last' or something like that.
JN> 
JN> "last" / "last LABEL" is a command, not a function, therefore you cannot
JN> redefine it.

it's a flow control statement thus it is a built-in thing same way as any other
functions are explained in a 'perldoc -f'
Therefore it is treated by monkeys crowd as function. It's obvious for me to
stay out here ( here != maillist ) yet in such an environment.
Anyway, I compare last() here  with exit() and die() which look to user just
like the same kind of: the flow control statements. I guess any perl user who
makes things like gitweb ( at least as a CGI-only app ) shouldn't care about
such an internal difference of flow control statements those are
hidden/incapsulated inside the implementation of those statements?
Needless to mention that the 'last LABEL' ( goto, gosub, ... named them )  is a
bad and a very deprecated style which is every schoolboy is aware about
nowadays to keep from using in the application, not system, programming in imho
every language.

JN> Well, perhaps you can with heavy hackery involving opcodes and the like,
JN> or something debugger-like, or/and something like B::* modules, taking
JN> over Perl parser.  See e.g. Devel::Declare or Template::Declare Perl
JN> modules on CPAN. :-)
JN> 
JN> > I just believe any non-system application development for end-user being a
JN> > non-developer doesn't need to redefine perl built-in functions. Just a sane
JN> > bone tone for common functioning in a sandbox.
JN> >
JN> > For example, I remember the Linux kernel  ( or Glibc? ) was criticised much of
JN> > being possible to override the str*cmp() inside. Because most of the existing
JN> > commerceware were protected from copying by password, e. g. serial number, etc.
JN> > sometimes by authors. So criticants supposed it's impossible to 'protect' their
JN> > software this way. And thus Linux was 'bad'. ;-)
JN> 
JN> What about libsafe (?) and similar security solutions, which replace
JN> str* functions from (g)libc with safer but slower counterparts?  What

That was bad sound for commerceware vendors. Because such a in-core functions
substititions can make the user safer but not the investments ( targeted on
squeezing users' pursues).

JN> about Dmalloc, Electric Fence and the like which replace malloc etc.?

I think malloc implementation details cannot keep software's serial number from
being verified. ;-)
Back to perl built-ins: should it be normal if gitweb will be dependent on a
usage of a particular malloc implementation? In my perl, I can have a choice of
them. ;-)

JN> > So one who use CORE:: namespace in their sources should always know it can be
JN> > grepped and considered as dangerous, especially if those are 3rd+ party
JN> > sources, not approved by any reasonable authority, and there are lots of such a
JN> > software off the shelves to choose. And most of them doesn't use to override
JN> > perl built-in functions. ;-)
JN> 
JN> It is true that messing with / overriding things from CORE:: (or
JN> UNIVERSAL:: for OOP) namespace is dangerous, and should be avoided if
JN> possible... but well, sometimes it is a best solution.

I think the state line between area to avoid one and the area where it can ever
happen to be the best of the solutions is built socially: it is where system
coder's work about daemon interfaces like the FCGI/PSGI/SCGI/etc. and the
applied coder one: the application architecture, used libraries, application
layers, etc.
This is just where FCGI::Spawn is about to help. Because 'regular system admin'
is typically unaware of details of usage of system daemon interfaces in perl.
But (s)he could be the perl application coder since perl is that easy as a
language tool. This is just who and when, and thus in what parts of the code
used by the same Perl interpreter shouldn't play with built-ins like the CORE::
namespace and thanks perl it can be easily grepped.

JN> > > I know this from painful experience of trying to find bug in a
JN> > > test... when the error was in parsing file in 'do $file;'.
JN> > 
JN> > I handle them just fine like in any other CGI program using
JN> > CGI::Carp:fatalsToBrowser. Are you about to 'make test' via the http? ;-)
JN> 
JN> I don't think you understand what I wanted to say there.
JN> 
JN> If you don't check if there were parse errors from 'do $file;', you can
JN> get later some error message which is totally unrelated to the parsing
JN> error.  If you don't know or forget that you should check $@ after 
JN> 'do $file;', and are unlucky, you can chase elusive error from there
JN> to kingdom come...

Got it, it's about the inclusion failure via the do() which is the development,
not a production, situation.
I think this should be an adjective noun to use the both strict and the warnings?
And yes, since it's about development but not production use, die is just fine
in the inclusion code like this:

eval( 'use Module;' ); die $@ if $@;

as always, require() can do the trick, not to mention usual 

use Module;

This all will cause die() when it's necessary as only the application developer
knows how strict is the dependence on the Module. In some cases, application
can work without some Module but it's just better with it.

JN> For example when debugging gitweb output caching code using automated
JN> tests, I got the following error:
JN> 
JN>   'Undefined subroutine &GitwebCache::SimpleFileCache::compute called'
JN> 
JN> The subroutine was defined, but there was a bug in parsing included
JN> file, so Perl didn't make it to definition of said compute() subroutine.

What is the code? Where and what file was included via the do()?
Interesting situation. If the sub was compiled, was it present then in the
symbol table?
I can't see the code of ... GitwebCache::SimpleFileCache package to contain the do()? 

JN> > [...]
JN> > 
JN> > >   builder {
JN> > >         $app;
JN> > >   }
JN> > 
JN> > that's the wow to try. I will after some of my whiles.
JN> 
JN> Check out http://plackperl.org, especially presentations and Perl Advent
JN> Calendar which describes PSGI/Plack step by step (links at the bottom of
JN> the page).
JN>  
JN> > > or even without it ($app should be the last expression).
JN> > > Or did you mean here something like mod_rewrite, or
JN> > > Plack::Middleware::Rewrite?
JN> > 
JN> > No, nginx rewrites just fine, it's a matter of another application level I
JN> > believe.
JN> >
JN> > The scoop is meat and potatoes: here is the CGI app, just do it over FastCGI.
JN> > There are no such a thing as a mandatory mounts and paths tweaks in PHP's
JN> > FastCGI. Hope PSGI has no them either.
JN> 
JN> PSGI is interface, Plack is reference implementation.  You can run PSGI
JN> app on any supported web server; this includes running PSGI apps on
JN> FastCGI.

Existing problem FCGI::Spawn for is not the PSGI applications to be run as a
FastCGI, but the bunch of existing CGI.pm applications ( even gitorious ) need
to be more effective with the widest-spread protocol FastCGI. Best without any
patching of the application, deployed the same simple way as with apache's cgi
implementation.
Will check on this.

73! Peter pgp: A0E26627 (4A42 6841 2871 5EA7 52AB  12F8 0CE1 4AAC A0E2 6627)
-- 
http://vereshagin.org
