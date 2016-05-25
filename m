From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] transport, send-pack: append period to up-to-date message
Date: Wed, 25 May 2016 17:47:34 -0500
Message-ID: <20160525224733.GF13776@sigill.intra.peff.net>
References: <1464123104-45513-1-git-send-email-junk@humanoriented.com>
 <CAGZ79kayB59-U52oAw=13a2CAhJLsfmoD6JbAURbt0p8g8a8fg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Yong Bakos <junk@humanoriented.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>, barkalow@iabervon.org,
	Yong Bakos <ybakos@humanoriented.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Thu May 26 00:47:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b5haX-0002J2-Q2
	for gcvg-git-2@plane.gmane.org; Thu, 26 May 2016 00:47:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752344AbcEYWri (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2016 18:47:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:44303 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751829AbcEYWrh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2016 18:47:37 -0400
Received: (qmail 23026 invoked by uid 102); 25 May 2016 22:47:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:47:37 -0400
Received: (qmail 14812 invoked by uid 107); 25 May 2016 22:47:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 May 2016 18:47:41 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2016 17:47:34 -0500
Content-Disposition: inline
In-Reply-To: <CAGZ79kayB59-U52oAw=13a2CAhJLsfmoD6JbAURbt0p8g8a8fg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/295607>

On Tue, May 24, 2016 at 02:21:00PM -0700, Stefan Beller wrote:

> On Tue, May 24, 2016 at 1:51 PM, Yong Bakos <junk@humanoriented.com> wrote:
> > Appending a period to "Everything up-to-date" makes the output message
> > consistent with similar output in builtin/merge.c.
> >
> > Signed-off-by: Yong Bakos <ybakos@humanoriented.com>
> > ---
> >  builtin/send-pack.c | 2 +-
> >  transport.c         | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/builtin/send-pack.c b/builtin/send-pack.c
> > index 1ff5a67..67d9304 100644
> > --- a/builtin/send-pack.c
> > +++ b/builtin/send-pack.c
> 
> While consistency is a good idea in general, I wonder how that applies here.
> git-send-pack is a low level (i.e. plumbing) command.
> 
>        The interface (input, output, set of options and the semantics) to
>        these low-level commands are meant to be a lot more stable than
>        Porcelain level commands, because these commands are primarily for
>        scripted use. The interface to Porcelain commands on the other hand are
>        subject to change in order to improve the end user experience.
> 
> So if another porcelain exists and compares the output string
> exactly, this would be a regression for them. That is why I'd refrain
> from updating these strings

I think messages to stderr are generally fair game for changing, even in
plumbing. In many cases they are also translated (and I would argue that
these messages probably should be translated, too).

That being said, CodingGuidelines says:

   - Do not end error messages with a full stop.

This isn't an error message exactly, but I think it's in the same vein.
I will note that we have not historically been consistent here, though
(as evidenced by the noted message in git-merge).

-Peff
