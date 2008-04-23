From: Jeff King <peff@peff.net>
Subject: Re: Git on Windows, CRLF issues
Date: Wed, 23 Apr 2008 04:10:26 -0400
Message-ID: <20080423081025.GB11935@sigill.intra.peff.net>
References: <alpine.DEB.1.00.0804212145570.21181@perkele.intern.softwolves.pp.se> <alpine.DEB.1.00.0804212104560.2298@eeepc-johanness> <32541b130804211453x77f3fd49hef645a417a9919ca@mail.gmail.com> <20080422023918.GA5402@sigill.intra.peff.net> <32541b130804220951p224c9be7ya4e8de5056481fd1@mail.gmail.com> <Pine.LNX.4.64.0804230806220.18401@ds9.cixit.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Peter Karlsson <peter@softwolves.pp.se>
X-From: git-owner@vger.kernel.org Wed Apr 23 10:11:24 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Joa4X-00035t-9K
	for gcvg-git-2@gmane.org; Wed, 23 Apr 2008 10:11:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752034AbYDWIKc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2008 04:10:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752014AbYDWIKc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Apr 2008 04:10:32 -0400
Received: from peff.net ([208.65.91.99]:4865 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751950AbYDWIK2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2008 04:10:28 -0400
Received: (qmail 573 invoked by uid 111); 23 Apr 2008 08:10:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 23 Apr 2008 04:10:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2008 04:10:26 -0400
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0804230806220.18401@ds9.cixit.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80197>

On Wed, Apr 23, 2008 at 08:11:49AM +0100, Peter Karlsson wrote:

> I ended up doing CRLF conversion for most of the repositories I had
> converted. Fortunately, most of them had a single branch, so after
> having created a small script that did CRLF->LF for the text files, I
> could do a
> 
>   git filter-branch --tree-filter 'c:/temp/crlf2lf.sh' \
>                     --tag-name-filter 'cat' HEAD
> 
> on each repository and get everything converted during my lunch break.

Sure, but that is quite slow on a larger tree, since it has to do a
full checkout for each commit. The idea of the specialized filter was to
avoid that. But if your project was small enough to do it that way, that
certainly works.

> What I couldn't figure out is why, after converting everything,
> removing all references to the repositories I cloned from, and removing
> references to the old objects in the reflogs, why
> 
>  git fsck --unreachable
> 
> did not report any unreachable objects? I would have guessed the entire
> old history and its objects would now be invalidated and could be
> killed off.

Did you remove refs/original/ ?

-Peff
