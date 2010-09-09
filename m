From: Jeff King <peff@peff.net>
Subject: Re: [RFC PATCH] git-help: find library man pages again
Date: Thu, 9 Sep 2010 15:58:08 -0400
Message-ID: <20100909195808.GD1146@sigill.intra.peff.net>
References: <0b8d803551f495e2494b43c6d95163daca82f62b.1283356852.git.git@drmicha.warpmail.net>
 <20100902081646.GK29713@burratino>
 <4C7F6354.70108@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Sep 09 21:58:05 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OtnG0-0003K3-J4
	for gcvg-git-2@lo.gmane.org; Thu, 09 Sep 2010 21:58:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755958Ab0IIT55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Sep 2010 15:57:57 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:40288 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752854Ab0IIT54 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Sep 2010 15:57:56 -0400
Received: (qmail 21356 invoked by uid 111); 9 Sep 2010 19:57:55 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 09 Sep 2010 19:57:55 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 Sep 2010 15:58:08 -0400
Content-Disposition: inline
In-Reply-To: <4C7F6354.70108@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155899>

On Thu, Sep 02, 2010 at 10:41:56AM +0200, Michael J Gruber wrote:

> >  i.e. I think that is the same issue after all and that
> > builtin/help.c ought to learn another heuristic than is_git_command().
> 
> One heuristic, which I would have left for a later patch because of its
> radicality (and I think we're in some phase of some rc something), is to
> simply not do any checks when calling the viewers. This requires that
> everything is prepended with "git-", which I see you have done in
> builtin/help.c. Still, none-command help pages will not show up with
> "git help -a". So it's not a complete solution.

That was my first thought upon reading your patch, too. And something
like "s/gitworkflows/git-workflows/" is reasonable. But you can do "git
help attributes" and "git help ignore" now, and those should almost
certainly remain "gitattributes" and "gitignore" (at the very least, we
should still allow "git help gitattributes", which works now, but which
your proposal would break).

So maybe we could get by with "prepend git- unless it starts with git".

I dunno. The current behavior seems hack-ish, but I am loathe to change
names if people really prefer the existing ones. FWIW, I would actually
say "git help git-sh-setup", which in fact works (leading me to get
puzzled by your patch at first). So who knows what people are typing in
practice.

-Peff
