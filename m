From: Jeff King <peff@peff.net>
Subject: Re: remote#branch
Date: Wed, 31 Oct 2007 17:26:55 -0400
Message-ID: <20071031212655.GB13823@coredump.intra.peff.net>
References: <vpq8x5kh4rr.fsf@bauges.imag.fr> <alpine.LFD.0.999.0710301056070.30120@woody.linux-foundation.org> <4727839B.9070205@obry.net> <alpine.LFD.0.999.0710301232000.30120@woody.linux-foundation.org> <20071030235823.GA22747@coredump.intra.peff.net> <fg8h9l$b4n$1@ger.gmane.org> <85lk9jzsxb.fsf@lola.goethe.zz> <alpine.LFD.0.999.0710310816180.30120@woody.linux-foundation.org> <20071031204729.GB13300@coredump.intra.peff.net> <alpine.LFD.0.999.0710311350100.3342@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, Jakub Narebski <jnareb@gmail.com>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Oct 31 22:27:12 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1InL5j-0005Yx-Rf
	for gcvg-git-2@gmane.org; Wed, 31 Oct 2007 22:27:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754326AbXJaV06 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Oct 2007 17:26:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754149AbXJaV06
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Oct 2007 17:26:58 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2613 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752759AbXJaV05 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2007 17:26:57 -0400
Received: (qmail 23664 invoked by uid 111); 31 Oct 2007 21:26:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 31 Oct 2007 17:26:56 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2007 17:26:55 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.0.999.0710311350100.3342@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62876>

On Wed, Oct 31, 2007 at 02:01:54PM -0700, Linus Torvalds wrote:

> > Yes, this means that if you have a bizarre repo name, you can't
> > necessarily switch between host:file syntax and git:// syntax by simple
> > cut and paste. But you really can't _anyway_, since there is no
> > guarantee that they are rooted at the same location, or have the same
> > view of the filesystem.
> 
> .. but in practice it works fine, especially for something like kernel.org 
> where it really *is* the same filesystem, just mirrored out.

Yes, and in practice, it works with or without URL encoding, since
people aren't using names that need encoded.

> Also, more importantly, I think the quoting is *stupid*. It adds pointless 
> code for absolutely zero gain. Are you going to unquote '/'? Or how about 
> '~'?

I don't think it's zero gain; I think it's exactly what users who use
repos with characters that need quoting will expect to happen. That
being said, _I_ don't personally care that much since I think spaces in
filenames are the work of the devil, and I will never use them. And as a
result, I'm not going to implement the code to do it.

But I do think your argument that there is no value in the URL syntax is
just wrong.

I don't understand your mention of '~' and '/'; they don't need quoted
in URLs, and generally are not (though of course they can be).

> .. because it's a simple format, and it *works*. The same way INI config 
> files are simple and *work*.

But if you wrote a bunch of documentation referring to the git config
file as an INI file, would you expect people to complain when it
_didn't_ follow the usual expectation for INI files?


OK, this discussion is just getting nowhere, and there is useful git
work I could be doing, so let me sum up my position:

  - We should either resolve that some repo specifiers are URLs, or we
    should resolve that they are not. I think they are.
  - If they are URLs, then we should treat them like URLs, and not
    handling quoting is probably a bug. I refuse to accept that it is an
    _important_ bug until somebody actually has a repo that needs
    quoting, finds that git is substandard, and provides a patch.
  - If they are not URLs, then we should probably stop calling them that
    in the documentation.

And with that, I shall say no more on the subject. In the spirit of not
saying "oh, I don't want to talk about it anymore, you don't get to say
anything else," I invite you to respond to any of my comments above.

-Peff
