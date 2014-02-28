From: Jeff King <peff@peff.net>
Subject: Re: GSoC idea: allow "git rebase --interactive" todo lines to take
 options
Date: Fri, 28 Feb 2014 07:52:41 -0500
Message-ID: <20140228125241.GA23448@sigill.intra.peff.net>
References: <530DA00E.4090402@alum.mit.edu>
 <20140226105249.GE25711@sigill.intra.peff.net>
 <CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Brandon McCaig <bamccaig@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 28 13:52:54 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJMvq-0001jf-7D
	for gcvg-git-2@plane.gmane.org; Fri, 28 Feb 2014 13:52:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbaB1Mwq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 07:52:46 -0500
Received: from cloud.peff.net ([50.56.180.127]:58733 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751532AbaB1Mwp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 07:52:45 -0500
Received: (qmail 606 invoked by uid 102); 28 Feb 2014 12:52:45 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Feb 2014 06:52:45 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Feb 2014 07:52:41 -0500
Content-Disposition: inline
In-Reply-To: <CANUGeEY2qE2LPq=-bhaKrKrv+uJUaPRqAeW_X1sFyZH-_PRVeA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242953>

On Thu, Feb 27, 2014 at 01:10:30PM -0500, Brandon McCaig wrote:

> On Wed, Feb 26, 2014 at 5:52 AM, Jeff King <peff@peff.net> wrote:
> > This seems like a reasonable feature to me. All of your examples are
> > possible with an "e"dit and another git command, but the convenience may
> > be worth it (though personally, most of the examples you gave are
> > particularly interesting to me[1]).
> 
> This strikes me as over-complicating the rebase --interactive
> interface.

Sorry, I missed an important word in my final sentence. It should have
been "the examples you gave are NOT particularly interesting to me".

> Particularly all of the ideas expressed later on about
> merge commits and resetting authors, etc. It seems like you're trying
> to define a whole new command set (i.e., API) for Git, but within the
> context of rebase --interactive. I think it would be hard to document
> this, and hard to learn it, and harder still to remember it (even
> though it would obviously try to mirror the existing Git command API).

I agree some of the examples are getting esoteric. Things like --signoff
and --reset-author are a fairly straightforward convenience feature:
they save you from writing "exec git commit --amend --signoff".

For others that cannot currently be done with a simple option to "git
commit", I think a reasonable first step would be to implement them
there. For example, you cannot currently "git commit --tree". Maybe that
is too insane and low-level an option for "git commit". But if it is,
then it is almost certainly too insane and low-level for a rebase
instruction.

For others from Michael's list, I expect they may not make _sense_
outside of a rebase. That is, they are operations whose input is not a
single commit, but a sequence of commits (e.g., if you had some
high-level command that allowed swapping two commits without having to
redo the conflicts from the second commit). Those ones might make sense
to exist as part of rebase and nowhere else (but then they are not
necessarily just options, but rather new instructions).

> That said, I do think that this is probably a bad direction and
> shouldn't be rushed into too fast.

I'm not sure whether it is a good idea or not. But I think it is looking
decreasingly like a good GSoC project.

-Peff
