From: Jeff King <peff@peff.net>
Subject: Re: Why doesn't git commit -a track new files
Date: Fri, 25 Feb 2011 04:01:26 -0500
Message-ID: <20110225090126.GA16861@sigill.intra.peff.net>
References: <20110224112246.3f811ac2@glyph>
 <4D6672F7.4020101@drmicha.warpmail.net>
 <20110224154908.GA29309@sigill.intra.peff.net>
 <4D667F1A.5060408@drmicha.warpmail.net>
 <20110224160027.GA30275@sigill.intra.peff.net>
 <4D6680F3.1000205@drmicha.warpmail.net>
 <20110224160932.GC30275@sigill.intra.peff.net>
 <4D676D99.2010600@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Marco <netuse@lavabit.com>, git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Fri Feb 25 10:01:38 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PstYP-0003XW-Gl
	for gcvg-git-2@lo.gmane.org; Fri, 25 Feb 2011 10:01:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932085Ab1BYJBc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Feb 2011 04:01:32 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:35113 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753978Ab1BYJBc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Feb 2011 04:01:32 -0500
Received: (qmail 32464 invoked by uid 111); 25 Feb 2011 09:01:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 25 Feb 2011 09:01:29 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 25 Feb 2011 04:01:26 -0500
Content-Disposition: inline
In-Reply-To: <4D676D99.2010600@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167886>

On Fri, Feb 25, 2011 at 09:51:37AM +0100, Michael J Gruber wrote:

> > I assumed that:
> > 
> >  git commit -a <path>
> > 
> > would behave more like the "git add -u <path>" case; add new stuff to
> > the index from <path>, and then commit those changes plus whatever was
> > already in the index.
> 
> Yes, you're right. I haven't wrapped my brain completely around those
> mixed cases yet (changes in index + pathspec argument). My aim is that
> 
> "git commit <addoptions> <commitoptions> [<pathspec>]"
> 
> would be equivalent to (the atomic version of)
> 
> "git add <addoptions> [<pathspec>] && git commit <commitoptions>"
> 
> and that is difficult because currently, pathspecs are "limiting" for
> commit and "additive" for add without -u. I mean, I don't want to break
> anything, at least not before 1.8.0..

I don't think there is any breakage with "-a" (or "-A") there, as you
are adding a new mode of operation that currently doesn't work (e.g.,
right now "git commit -a foo" will die). The only thing that would not
work is trying to make:

  git add <path> && git commit

the same as

  git commit <path>

But I am not sure that is a good idea anyway. Yes, it is a little
inconsistent with the other forms, but I think it is generally what you
want (which is why the default for commit with paths switched from "-i"
to "-o" long ago).

-Peff
