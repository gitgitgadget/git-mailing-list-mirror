From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH 2/3] add new Git::Repo API
Date: Fri, 18 Jul 2008 20:19:40 +0200
Message-ID: <20080718181940.GW10151@machine.or.cz>
References: <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <200807150141.39186.jnareb@gmail.com> <4876B223.4070707@gmail.com> <1215738665-5153-1-git-send-email-LeWiemann@gmail.com> <20080714014051.GK10151@machine.or.cz> <487BD0F3.2060508@gmail.com> <20080718164828.GT10151@machine.or.cz> <4880DC6C.7090708@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	John Hawley <warthog19@eaglescrag.net>
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 20:20:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KJuZO-0005iZ-Pi
	for gcvg-git-2@gmane.org; Fri, 18 Jul 2008 20:20:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753733AbYGRSTn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Jul 2008 14:19:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754096AbYGRSTm
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Jul 2008 14:19:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:43074 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753733AbYGRSTm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Jul 2008 14:19:42 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id 6F4C1393B288; Fri, 18 Jul 2008 20:19:40 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <4880DC6C.7090708@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89066>

On Fri, Jul 18, 2008 at 08:09:48PM +0200, Lea Wiemann wrote:
> Also, gitweb isn't using cmd_output because it needs a pipe interface,
> but because it needs a caching layer in between -- most applications
> would do just fine with open calls.

One of the points of the API is to abstract these out.

> > As I said, majority of Git API usage is actually the pipe API. So we
> > should figure out how to provide it. I agree that it's not immediately
> > within your scope, but you are introducing new Perl API and this just
> > needs to be embedded somewhere there consistently.
> 
> Sure, but pleeeease not as part of this patch series! :-)  Look, our
> conversation is going something like this:
> 
> Lea: Here's a Perl API that fell out of my gitweb development for free.
> Petr: I want a pony with the API!
> Lea: But I don't have a pony.  Can we please just go with the Perl API
> as a start, even if I don't supply ponies with it?
> 
> (Cf. the very cute <http://c2.com/cgi/wiki?IwantaPony>.)

I'm fine with that, as long as the version that enters into master will
have a pony so that we stay with a single pony within the codebase in
the end, not two ponies with differently shaped saddles.

But as I said, I'm going to work on that.

> >> If you're getting a SHA1 through the user-interface, check its existence
> >> with get_sha1 before passing it to the constructor.
> > 
> > But that's an expensive operation, you need extra Git exec for this,
> 
> For the gazillionth time in this thread, there is no extra exec.  It's a
> write to a bidirectional cat-file --batch-check pipe.  It's not
> expensive.  Really. ;-)

But the API is still obnoxiously elaborate, as I complained in another
mail.

> >> I have resolving code in gitweb's git_get_sha1_or_die
> > 
> > The thing that concerns me about this is that this might show that your
> > approach to error handling is not flexible enough for some real-world
> > usage and this might be a design mistake - is that not so?
> 
> I don't think so; the error handling is fine.  Given that I want
> fine-granular error reporting for gitweb, there *needs* to be a
> git_get_sha1_or_die function; you can't move that into the API.

Wait, this doesn't compute here. The error handling is fine, but it is
actually not fine for gitweb. Can't we make it fine for everyone?

-- 
				Petr "Pasky" Baudis
As in certain cults it is possible to kill a process if you know
its true name.  -- Ken Thompson and Dennis M. Ritchie
