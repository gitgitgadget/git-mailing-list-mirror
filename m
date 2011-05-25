From: Jeff King <peff@peff.net>
Subject: Re: Supporting "-v" option for git-log
Date: Wed, 25 May 2011 11:11:15 -0400
Message-ID: <20110525151115.GB8795@sigill.intra.peff.net>
References: <BANLkTik70gu0NUzUEnGNWHQr8CfbdPVe5g@mail.gmail.com>
 <SNT124-W39164C74A457129811245DC4740@phx.gbl>
 <BANLkTi=v8j=VdBNgThRTFXk+YbPFOFvzwQ@mail.gmail.com>
 <SNT124-W5207D5461CD80509763B79C4740@phx.gbl>
 <BANLkTikT4s+Twfip2g7Zo-XcML1Wbd3qBg@mail.gmail.com>
 <20110525132816.GA6709@sigill.intra.peff.net>
 <m3boyqzy3f.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Elazar Leibovich <elazarl@gmail.com>,
	Tim Mazid <timmazid@hotmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 25 17:11:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QPFk3-0004QQ-J9
	for gcvg-git-2@lo.gmane.org; Wed, 25 May 2011 17:11:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755232Ab1EYPLS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 May 2011 11:11:18 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38235
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753432Ab1EYPLR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 May 2011 11:11:17 -0400
Received: (qmail 875 invoked by uid 107); 25 May 2011 15:11:17 -0000
Received: from sigill-wired.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.8)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 25 May 2011 11:11:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 May 2011 11:11:15 -0400
Content-Disposition: inline
In-Reply-To: <m3boyqzy3f.fsf@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174411>

On Wed, May 25, 2011 at 06:53:31AM -0700, Jakub Narebski wrote:

> > Which is a shame, because we already have all of the code for "--and",
> > "--or", and "--not" in git-grep. It is just a syntactic conflict. I
> > think you could get away with "--grep-and", "--grep-or", and
> > "--grep-not". They are obviously less nice to type, but there would be
> > not conflict.
> 
> Hmmm... perhaps short -! could be alias for --grep-not (it is the only
> that needs to be changed to avoid conflict, as there are no --or and
> --and for rev-list).

Ick. I really hate using shell metacharacters that need quoting
(especially "!", which even gets expanded inside double-quotes). But as
long as it's an alias, I guess people who care can use --grep-not.

We could use unadorned "--or" and "--and", though we should perhaps stop
and think whether taking those basic operators will block future use
that matches the current "--not" more.

Right now, "git log a b" is what I would expect "git log a --or b" to
do. I guess "git log a --and b" would be "git log $(git merge-base a
b)". So maybe it is not worth reserving them for the future, since what
they would (probably) accomplish is easy to do now.

-Peff
