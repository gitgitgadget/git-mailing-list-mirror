From: Jeff King <peff@peff.net>
Subject: Re: Large repo and pack.packsizelimit
Date: Tue, 8 May 2012 17:20:12 -0400
Message-ID: <20120508212012.GA20044@sigill.intra.peff.net>
References: <37267143.413194.1336046278583.JavaMail.ngmail@webmail07.arcor-online.net>
 <20120508203137.GA15707@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205081709010.21030@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: th.acker66@arcor.de, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue May 08 23:20:22 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRrpW-0002ij-HU
	for gcvg-git-2@plane.gmane.org; Tue, 08 May 2012 23:20:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755670Ab2EHVUP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 May 2012 17:20:15 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34434
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754397Ab2EHVUO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 May 2012 17:20:14 -0400
Received: (qmail 8721 invoked by uid 107); 8 May 2012 21:20:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 08 May 2012 17:20:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 May 2012 17:20:12 -0400
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.02.1205081709010.21030@xanadu.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197425>

On Tue, May 08, 2012 at 05:13:13PM -0400, Nicolas Pitre wrote:

> > This should be fixed in git. Unfortunately, I don't know that it is as
> > trivial as just splitting the incoming stream; we would also have to
> > make sure that there were no cross-pack deltas in the result.
> 
> IMHO this is the wrong fix.  The pack size limit was created to deal 
> with storage media with limited capacity.  In this case, the repack 
> process should be told to limit its memory usage, and pack-index should 
> simply be taught to cope.

Hmm, you're right. I was thinking it helped to deal with memory
addressing issues for 32-bit systems, but I guess
core.packedGitWindowSize should be handling that. IOW, the 10G packfile
should work just fine for normal access.

However, the OP did say he got an "out of memory" error during the
clone. So maybe there is a problem to be fixed in index-pack there.

-Peff
