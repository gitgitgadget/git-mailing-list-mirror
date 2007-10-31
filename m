From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 16:47:29 -0400
Message-ID: <20071031204729.GB13300@coredump.intra.peff.net>
References: <20071030160232.GB2640@hermes.priv> <alpine.LFD.0.999.0710301037120.30120@woody.linux-foundation.org> <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org> <85lk9jzsxb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 21:48:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InKTb-0003Ep-Ef
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 21:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752965AbXJaUrc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 16:47:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752825AbXJaUrc
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 16:47:32 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2812 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751981AbXJaUrb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 16:47:31 -0400
Received: (qmail 23013 invoked by uid 111); 31 Oct 2007 20:47:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 16:47:30 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 16:47:29 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62866>

On Wed, Oct 31, 2007 at 08:28:36AM -0700, Linus Torvalds wrote:

> Because we don't care! This is *exactly* why I brought up the whole 
> discussion about "interoperability with a web browser", and pointed out 
> that there is no such thing *anyway*, since a GIT URL is generally not 
> suitable for browsing _regardless_ of any encoding issues!
> 
> So it doesn't matter one whit if a mail client recognizes GIT URL's or 
> not! Because the mail client cannot do the right thing with them anyway, 
> and would generally think that it's something that it should highlight so 
> that you can browse it!

Two points:

 1. Just because _your_ mail client can't do anything useful with git
    URLs^H^H^H^H repo specifications, doesn't mean that others can't.

 2. You are conflating syntax and semantics. Think of the task I
    mentioned as two subtasks: pulling the location specifier from the
    email, and then doing something useful with it (in this case,
    git-cloning it it). The first subtask depends _only_ on a parseable
    syntax. The user can provide the context necessary for accomplishing
    the second subtask.

For example, consider a terminal that, upon pressing some keyboard
combination, will highlight the first URL-ish looking blob on the
screen, prompt you for a command, and then execute '$command $url'.  The
terminal doesn't have to know the semantics of the blob, but it has to
know the syntax. The user provides the semantics.

And yes, such a terminal exists, and I'm using it right now.

> Besides, you generally shouldn't use http for git URL's in the first 
> place, and they are very much a secondary citizen. Yes, some people use 
> them because they have firewall issues, and they *work*, but giving them 
> as examples of GIT URL's and discussing them as it they were a big deal is 
> just *stupid* when no other - more realistic - git url works that way 
> anyway.

The example above is equally applicable to git:// URLs. As it is to
host:path specifiers, although obviously that is a syntax that the
highlighter would have to recognize. But the point is that by following
established syntaxes, you don't have to write a git-repo-specifier
syntax parser; it comes for free (and isn't that, after all, the entire
_point_ of URLs?).

> This was the whole and only point of my "interoperability" thing. The GIT 
> URL's - even when they are perfectly well-formed URL's (which is basically 
> 100% of the time, since no current git server tends to put things like 
> spaces in the path anyway) - are simply in a different "space" than most 
> other URL's.

Sure, you need context to use them correctly. But that doesn't
necessarily mean you should just give up on the syntax part. I would
rather the computer do half of the task and let me finish it than make
me do the whole thing.

> You cannot feed them to a web browser or a file browser anyway, since the 
> URL is actually mal-formed (on purpose) in *another* and more fundamental 
> way: it doesn't say what the "application domain" is, since it basically 
> just assumes that the application domain is git, and the "scheme" part of 
> the URL really talks only about the _protocol_, not about the fact that 
> it's a git thing.
> 
> So if you wanted to be inter-operable, you'd have add the "git" part to 
> the scheme, and do the (insane, in my opinion) cogito thing with 
> "git+http://xyz.hjashja/" thing!

Yes, if you did that, you could automate _both_ parts of the task. But
again, that doesn't mean there isn't value to automating the first part
But that aside, even git+http doesn't solve all of your problems,
because it doesn't say _what_ you want to do with the location. Web
browsers just assume you want to fetch and view a location. But other
tools which accept URLs might perform _other_ actions on a given
location. So URLs really are a "subject" that can be operated on. It's
just that we are most accustomed to seeing them used by the "retrieve
this and display it" tool.

>  - the only way to make git interoperate would be to be user-UNfriendly 
>    with stupid markers that no git program really needs or wants, and by 
>    making the escaping depend on the form of the GIT URL.

Some git specifiers clearly look like URLs. Why not accept URL encoding
for them? And if there are characters that _should_ have been encoded by
URL encoding standards, treat them as if they had been encoded (i.e.,
handing 'http://foo.tld/repo with space' would be treated the same as
'http://foo.tld/repo%20with%20space'). This means that most unencoded
repos will behave exactly the same, but we are more liberal in wht we
accept. The exception is that repos with a '%' in the specifier will
parse differently (i.e., if you actually had a repo with the literal
characters '%20' in it, it will no parse).

Yes, this means that if you have a bizarre repo name, you can't
necessarily switch between host:file syntax and git:// syntax by simple
cut and paste. But you really can't _anyway_, since there is no
guarantee that they are rooted at the same location, or have the same
view of the filesystem.

> Personally, I think it's a much better idea to just be git-specific. 

Then why in the world did you choose a specifier syntax that looks
_exactly_ like a URL?

-Peff
