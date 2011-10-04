From: Jeff King <peff@peff.net>
Subject: Re: Git ksshaskpass to play nice with https and kwallet
Date: Tue, 4 Oct 2011 08:43:44 -0400
Message-ID: <20111004124344.GA30162@sigill.intra.peff.net>
References: <4E8ADDCF.6090406@drmicha.warpmail.net>
 <20111004105008.GA11789@sigill.intra.peff.net>
 <4E8AEDBD.4070404@drmicha.warpmail.net>
 <20111004113713.GA19171@sigill.intra.peff.net>
 <4E8AF812.5090906@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Oct 04 14:43:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RB4Lg-0007Qp-RW
	for gcvg-git-2@lo.gmane.org; Tue, 04 Oct 2011 14:43:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932078Ab1JDMns (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Oct 2011 08:43:48 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52162
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756575Ab1JDMnr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 4 Oct 2011 08:43:47 -0400
Received: (qmail 8277 invoked by uid 107); 4 Oct 2011 12:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 04 Oct 2011 08:48:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 04 Oct 2011 08:43:44 -0400
Content-Disposition: inline
In-Reply-To: <4E8AF812.5090906@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182767>

On Tue, Oct 04, 2011 at 02:12:02PM +0200, Michael J Gruber wrote:

> > The latter is especially useful if you have put a username in your
> > ~/.gitconfig, in which case you get:
> 
> I'm actually wondering why git can't infer the user from
> 
> https://user@host.com
> 
> with last week's next, at least.

It can, and it has for some time. Part of the configurable-username
thing was that it would be way nicer to just use a user-agnostic URL,
because it means it's easier to share with other people.

> >   $ git push https://example.com/foo.git
> >   Password for 'user@example.com':
> > 
> > which is a nice reminder. And it would happen to work with your askpass
> > magic (I also wonder if it should mention the protocol and the repo, but
> > most of the time that isn't relevant, and it does make the prompt harder
> > to read).
> 
> With the above, I can probably do without any magic: 'example.com' would
> be the wallet key for the username (if I let the wallet store it) and
> 'user@example.com' the key for the password, whether the username comes
> from the wallet or from the config. (Again, why not from the URL?)

Yeah, sorry, I should have said "ksshaskpass's magic". :)

And yes, it can come from the URL. Mentioning the user in the password
prompt is not as useful a reminder if it comes from:

  $ git push https://user@example.com/foo.git

but, if it's something like:

  $ git clone https://user@example.com/foo.git
  [months pass]

  $ git push
  Password for 'user@example.com':

then it's a nice reminder.

-Peff
