From: Jeff King <peff@peff.net>
Subject: Re: Bizarre missing changes (git bug?)
Date: Wed, 30 Jul 2008 00:23:31 -0400
Message-ID: <20080730042330.GA3350@sigill.intra.peff.net>
References: <alpine.LFD.1.10.0807271144520.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807272101470.6791@localhost.localdomain> <alpine.LFD.1.10.0807271613440.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807280141140.6791@localhost.localdomain> <alpine.LFD.1.10.0807272148030.3486@nehalem.linux-foundation.org> <Pine.LNX.4.64.0807281241180.6791@localhost.localdomain> <20080729053108.GH26997@sigill.intra.peff.net> <Pine.LNX.4.64.0807291339580.6791@localhost.localdomain> <20080729125247.GC12069@sigill.intra.peff.net> <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Tim Harper <timcharper@gmail.com>, git@vger.kernel.org
To: Roman Zippel <zippel@linux-m68k.org>
X-From: git-owner@vger.kernel.org Wed Jul 30 06:24:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO3Ep-0005Gr-DN
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 06:24:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbYG3EXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 00:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750921AbYG3EXf
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 00:23:35 -0400
Received: from peff.net ([208.65.91.99]:3716 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750844AbYG3EXe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 00:23:34 -0400
Received: (qmail 4769 invoked by uid 111); 30 Jul 2008 04:23:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 30 Jul 2008 00:23:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jul 2008 00:23:31 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0807300430590.6791@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90732>

On Wed, Jul 30, 2008 at 04:48:54AM +0200, Roman Zippel wrote:

> Now compare the output of "git-log file1", "git-log --full-history file1" 
> and "git-log --full-history --parents file1". You get either both merge 
> commits or none, but only one of it is relevant to file1.

Ah, I see.

So if I understand you, you wanted to see something like:


A--B
 \  \
  C--D

where

 A = initial commit
 B = duplicate change 1
 C = duplicate change 2
 D = merge branch 'test2' into HEAD

where the simplification isn't as aggressive (you still see the
duplicate commits and the merge), but we can get rid of the later merge
between A and D because A is already an ancestor of D.

So do you have a proposed set of simplification rules that will produce
that output?

-Peff
