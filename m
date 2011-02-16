From: Jeff King <peff@peff.net>
Subject: Re: non-empty index with git commit -a
Date: Tue, 15 Feb 2011 21:36:46 -0500
Message-ID: <20110216023645.GA7085@sigill.intra.peff.net>
References: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git List <git@vger.kernel.org>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 16 03:37:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PpXGK-000370-GV
	for gcvg-git-2@lo.gmane.org; Wed, 16 Feb 2011 03:37:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754201Ab1BPCgu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Feb 2011 21:36:50 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:49925 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752706Ab1BPCgs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Feb 2011 21:36:48 -0500
Received: (qmail 2558 invoked by uid 111); 16 Feb 2011 02:36:47 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Wed, 16 Feb 2011 02:36:47 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 15 Feb 2011 21:36:46 -0500
Content-Disposition: inline
In-Reply-To: <AANLkTi=5E8D0mwMDNuMdgZS69kOnKCfs=Q8X5bpcjnYF@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166914>

On Tue, Feb 15, 2011 at 10:43:53PM +0000, Sverre Rabbelier wrote:

> Can we please fix this?
> 
> $ hack hack hack
> $ git add -p # carefully add my changes
> $ git commit -am "Add feature foo"
> $ DAAAMN YOUUU FINGERS!!
> 
> I remember bringing this up before, but I can't remember what the
> discussion ended up coming to.

How do you differentiate this from:

  $ hack hack hack
  $ git add -p ;# carefully add my changes
  $ hack hack hack
  $ git diff ;# ok, everything looks good
  $ git commit -am "Add feature foo"

? IOW, I don't think git can know that you are making a mistake in your
case, since from its perspectives those same actions might be
reasonable. The real problem is that your intermediate index state is
never saved. Do we need an index reflog? :)

-Peff
