From: Jeff King <peff@peff.net>
Subject: Re: Question regarding git fetch
Date: Thu, 27 Aug 2009 17:53:05 -0400
Message-ID: <20090827215305.GA6348@coredump.intra.peff.net>
References: <1251387045053-3527289.post@n2.nabble.com>
 <32541b130908270836m50553ccatddf4c870eec54ddb@mail.gmail.com>
 <20090827164657.GA17090@atjola.homenet>
 <32541b130908271022i6a825198i37e2ec82ed5f833c@mail.gmail.com>
 <20090827204835.GC4399@coredump.intra.peff.net>
 <20090827213426.GD4399@coredump.intra.peff.net>
 <7v7hwpors9.fsf@alter.siamese.dyndns.org>
 <20090827215007.GA6231@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	=?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Tom Lambda <tom.lambda@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 27 23:53:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MgmuC-0007LT-Km
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 23:53:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753255AbZH0VxI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 17:53:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753063AbZH0VxG
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 17:53:06 -0400
Received: from peff.net ([208.65.91.99]:60074 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752714AbZH0VxF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 17:53:05 -0400
Received: (qmail 927 invoked by uid 107); 27 Aug 2009 21:53:16 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 27 Aug 2009 17:53:16 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 27 Aug 2009 17:53:05 -0400
Content-Disposition: inline
In-Reply-To: <20090827215007.GA6231@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127222>

On Thu, Aug 27, 2009 at 05:50:07PM -0400, Jeff King wrote:

> > I think this is a good example that any change results from this
> > discussion should apply _only_ to cases where command line refspecs lack
> > colon (i.e. used to mean "do not store this anywhere but in FETCH_HEAD").
> 
> I don't think the colon is the issue. Consider the same situation, but I
> say:
> 
>   # but today let's demo it first
>   $ git fetch origin master
>   $ git checkout -b demo FETCH_HEAD
> 
> I'm still screwed. The issue is that you consider your configured
> refspec destinations to be precious, and not merely a cache for what's
> happening on the remote side.

Which, btw, led me to consider whether there are heuristics for deciding
when a fetch refspec means one thing and not the other. I don't think
there are reliable ones (probably the default configured
refs/remotes/$remotename/* would not yield false positives, but I think
limiting to that would yield false negatives). So maybe this is
something that should be configurable, disabled by default for now, and
maybe enabled by default in the future (v1.7.0?).

-Peff
