From: Trevor Saunders <tbsaunde+mozilla@tbsaunde.org>
Subject: Re: support git+mosh for unreliable connections
Date: Wed, 15 Apr 2015 14:59:07 -0400
Message-ID: <20150415185907.GC21768@tsaunders-iceball.corp.tor1.mozilla.com>
References: <552E628C.7040809@debian.org>
 <552E6D07.5030903@drmicha.warpmail.net>
 <552E732E.20107@debian.org>
 <0cf0485caae569a71a8bd1aa8d1033cb@www.dscho.org>
 <20150415153317.GA21768@tsaunders-iceball.corp.tor1.mozilla.com>
 <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Trevor Saunders <tbsaunde@tbsaunde.org>,
	Pirate Praveen <praveen@debian.org>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	git@vger.kernel.org, git-owner@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Apr 15 20:59:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YiSWy-0005L0-O5
	for gcvg-git-2@plane.gmane.org; Wed, 15 Apr 2015 20:59:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756442AbbDOS7U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 15 Apr 2015 14:59:20 -0400
Received: from tbsaunde.org ([66.228.47.254]:59016 "EHLO
	paperclip.tbsaunde.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756277AbbDOS7P (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 15 Apr 2015 14:59:15 -0400
Received: from tsaunders-iceball.corp.tor1.mozilla.com (unknown [66.207.208.102])
	by paperclip.tbsaunde.org (Postfix) with ESMTPSA id D6B93C072;
	Wed, 15 Apr 2015 18:59:12 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <31749ad9ba57ada7f9c553191ffaddb3@www.dscho.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267231>

On Wed, Apr 15, 2015 at 07:46:15PM +0200, Johannes Schindelin wrote:
> Hi Trevor,
> 
> On 2015-04-15 17:33, Trevor Saunders wrote:
> > On Wed, Apr 15, 2015 at 04:41:42PM +0200, Johannes Schindelin wrote:
> >>
> >> On 2015-04-15 16:18, Pirate Praveen wrote:
> >> > On Wednesday 15 April 2015 07:22 PM, Michael J Gruber wrote:
> >> >> What would that require git to do, beyond taking whatever you tell it
> >> >> (using GIT_SSH or _GIT_SSH_COMMAND) to use as a drop in replacement for ssh?
> >> >
> >> > May be support git+mosh as a protocol, since it is not a drop in
> >> > replacement. It is redesigned remote shell. The ideas it uses for
> >> > session resumption needs to be reimplemented. This will need support
> >> > from git, because it needs server side to be modified. Use SSP to return
> >> > the the current progress for a particular session (it uses AES session ids).
> >>
> >> It will need support from Git alright, but not as much as from mosh, see my other reply: Mosh was not designed for non-interactive use. That support would have to be added before we can go any further.
> > 
> > is that really relevent? mosh doesn't support things like X forwarding
> > or port forwarding, but it certainly does support ssh <host> <command>
> > and then doing IO.
> 
> Ah, so mosh's README lied to me!

I wouldn't say it lied, its just not really clear what is "interactive"
I'd say git's use of ssh is kind of interactive compared to things like
port forwarding.

> If `mosh <user>@<host> <command>` works, then a simple `GIT_SSH=mosh` should work out of the box, too. Have you tried it?

it does work, I just tried mosh $host cat and then typing stuff and
having it printed back at me.  However it clears the terminal before
hand and prints a message on exit.  I tried GIT_SSH=mosh git clone and
it failed, but I haven't really dug into why.  SO I suspect this can be
made to work with some work on the mosh side, but I'm not sure exactly
how ssh and mosh are behaving differently here.

Trev

> 
> Ciao,
> Johannes
>   It might not support not doing terminal emulation
> > stuff, but that seems like a simple thing to change in principal at which
> > point I think it would support enough of ssh's functionality its a drop
> > in replacement as far as git is concerned.  Seems to me mosh is close
> > enough on its own its worth experimentation by someone who cares.
> > 
> > Trev
> > 
> >> > So when a client connect with a session id, git server side can respond
> >> > with the current state, how many objects received in that session, and
> >> > client can continue from where it stopped. Client also will need to
> >> > store session information.
> >>
> >> No, the protocol can stay exactly the same, once you have a way to communicate non-interactively via mosh.
> >>
> >> Ciao,
> >> Johannes
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe git" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > --
> > To unsubscribe from this list: send the line "unsubscribe git" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
