From: Jeff King <peff@peff.net>
Subject: Re: BUG. Git config pager when --edit
Date: Mon, 7 Nov 2011 12:18:00 -0500
Message-ID: <20111107171800.GA3621@sigill.intra.peff.net>
References: <20111107172652.0faade61@ashu.dyn.rarus.ru>
 <CAH6sp9Ox+6p4RkjCZ0j3tXG9F4u7SPuwbSrOWmLSXic9DxSKiQ@mail.gmail.com>
 <20111107164250.GC27055@sigill.intra.peff.net>
 <7vpqh327ds.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Frans Klaver <fransklaver@gmail.com>,
	Alexey Shumkin <Alex.Crezoff@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 07 18:18:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNSpl-00058B-TZ
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 18:18:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755898Ab1KGRSE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 12:18:04 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35827
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755119Ab1KGRSD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 12:18:03 -0500
Received: (qmail 27950 invoked by uid 107); 7 Nov 2011 17:18:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 12:18:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 12:18:00 -0500
Content-Disposition: inline
In-Reply-To: <7vpqh327ds.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185001>

On Mon, Nov 07, 2011 at 09:02:23AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I should probably polish and submit the patch here:
> >
> >   http://thread.gmane.org/gmane.comp.version-control.git/182238/focus=182475
> 
> I was actually hoping that you won't go that route, but the route to push
> further to decide/spawn pager as late as possible. Clearly no sane person
> would want to run --edit subcommand under pager and "pager.config = less"
> should just be ignored in such a case.

The problem with that is that it dumps the responsibility for running
the pager to every subcommand. For builtins, we can have a flag that
says "respect the pager.log config" or "foo will handle this itself;
don't respect pager.tag".

But what about externals? If "pager.stash" does nothing in git.c, and
leaves it to "git-stash.sh" to start the pager if and when it's
appropriate, then what about my personal "git-foo" that I drop into my
PATH? Now I can't use "config.foo" without carrying code to do so in my
external command.

Maybe that's an OK tradeoff. But it's more of a pain for existing
scripts, and it's not backwards compatible. What do you think?

-Peff
