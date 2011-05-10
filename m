From: Jeff King <peff@peff.net>
Subject: Re: [BUG] Autocompletion fails with "bash: words: bad array
 subscript"
Date: Tue, 10 May 2011 17:10:16 -0400
Message-ID: <20110510211016.GB26231@sigill.intra.peff.net>
References: <BANLkTi=nOUEp_J+2dkZZp=HvER-eAdG9eg@mail.gmail.com>
 <20110510203101.GG14456@sigill.intra.peff.net>
 <20110510203943.GH14456@sigill.intra.peff.net>
 <BANLkTi=0r_hCgt3wh4EkRqS6gnCyyKrY2g@mail.gmail.com>
 <20110510210116.GA25224@sigill.intra.peff.net>
 <BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Git List <git@vger.kernel.org>,
	"Shawn O. Pearce" <gsoc@spearce.org>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>,
	Stephen Boyd <bebarino@gmail.com>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 10 23:10:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QJuCI-00030c-0x
	for gcvg-git-2@lo.gmane.org; Tue, 10 May 2011 23:10:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751361Ab1EJVKS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2011 17:10:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38290
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750761Ab1EJVKS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2011 17:10:18 -0400
Received: (qmail 27469 invoked by uid 107); 10 May 2011 21:12:15 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 10 May 2011 17:12:15 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 May 2011 17:10:16 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTin9=7y+2eqUgo_ObcYeGs3TQ7YMGw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173366>

On Tue, May 10, 2011 at 11:02:53PM +0200, Sverre Rabbelier wrote:

> On Tue, May 10, 2011 at 23:01, Jeff King <peff@peff.net> wrote:
> > Right. Bash calls into our __git() completion function, which calls the
> > implementation of _get_comp_words_by_ref from /etc/bash_completion,
> > which has the bug. If you don't source git completion, then you are just
> > getting bash's default file completion.
> 
> So should we file this bug with bash's completion people?

Probably, but it would be nice to reduce it to a smaller test case (or
one that happens just with completions shipped by Debian) just to rule
out anything git is doing.

> Also, how did you manage to reproduce?  It doesn't happen all the time
> for me.

Initially, with:

  $ git init repo && cd repo
  $ echo content >file && git add file
  $ git commit -am foo
  $ <C-R>git commit -am f<Tab>

but I also get it with just:

  $ cd /anywhere ;# do not have to even be in a git repo
  $ <C-R>git<Tab>

-Peff
