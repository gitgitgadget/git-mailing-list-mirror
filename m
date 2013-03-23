From: Jeff King <peff@peff.net>
Subject: Re: feature request - have git honor nested .gitconfig files
Date: Sat, 23 Mar 2013 04:03:41 -0400
Message-ID: <20130323080341.GA29768@sigill.intra.peff.net>
References: <CAM2RUGOOWnxRd2=04-NmKTC+tvnCD=ebgmmiexHas5bwyYrm4w@mail.gmail.com>
 <20130322182211.GD12223@google.com>
 <20130322183306.GA32448@sigill.intra.peff.net>
 <20130323000628.GM12223@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Josh Sharpe <josh.m.sharpe@gmail.com>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sat Mar 23 09:04:35 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UJJRK-00035X-Jx
	for gcvg-git-2@plane.gmane.org; Sat, 23 Mar 2013 09:04:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751762Ab3CWIDx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 23 Mar 2013 04:03:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36634 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751545Ab3CWIDv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 23 Mar 2013 04:03:51 -0400
Received: (qmail 8706 invoked by uid 107); 23 Mar 2013 08:05:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 23 Mar 2013 04:05:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 23 Mar 2013 04:03:41 -0400
Content-Disposition: inline
In-Reply-To: <20130323000628.GM12223@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218896>

On Fri, Mar 22, 2013 at 05:06:28PM -0700, Jonathan Nieder wrote:

> > I'd rather not invent a new language. It will either not be featureful
> > enough, or will end up bloated. Or both. How about something like:
> >
> >   [include]
> >        exec = "
> >          case \"$GIT_DIR\" in)
> >            */dev/*) cat ~/.config/git/dev-config ;;
> >                  *) cat ~/.config/git/nondev-config ;;
> >           esac
> >        "
> 
> Yes, an existing language like shell or lua would presumably be the
> way to go.  The scary aspect of shell is the "Prankster sets up a
> malicious configuration, asks a sysadmin to help in her repository"
> scenario.  Of course we already have that problem with command
> aliases, but if the sysadmin has perfect spelling then aliases would
> never trip, so...

And also external diff, textconv, clean/smudge filters, and I'm probably
forgetting more. Oh, and hooks. There's definitely a danger to running
arbitrary git commands against a maliciously constructed repo. We've
tried to make upload-pack safe, so you can at least make your own safe
copy to examine. We could probably do more safety checks when the
running user and repo owner or not the same, but it would be quite
complicated, and in practice it does not seem to be that huge a problem.

> Hopefully that's enough information for anyone interested to start and
> understand the relevant variables at play.

Yeah, I'm not planning to work on this, but I'd be happy to review
patches if somebody else wants to.

-Peff
