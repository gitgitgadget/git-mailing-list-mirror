From: Jeff King <peff@peff.net>
Subject: Re: Working with Git and CVS in a team.
Date: Fri, 13 Jun 2008 16:55:26 -0400
Message-ID: <20080613205525.GA21165@sigill.intra.peff.net>
References: <200806131633.34980.mirko.stocker@hsr.ch> <20080613160911.GB3140@sigill.intra.peff.net> <200806132247.03947.m1stocke@hsr.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Mirko Stocker <m1stocke@hsr.ch>
X-From: git-owner@vger.kernel.org Fri Jun 13 22:56:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K7GJq-0001OT-Ne
	for gcvg-git-2@gmane.org; Fri, 13 Jun 2008 22:56:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753687AbYFMUz2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jun 2008 16:55:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753841AbYFMUz2
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Jun 2008 16:55:28 -0400
Received: from peff.net ([208.65.91.99]:1090 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753644AbYFMUz2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jun 2008 16:55:28 -0400
Received: (qmail 21908 invoked by uid 111); 13 Jun 2008 20:55:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Fri, 13 Jun 2008 16:55:27 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jun 2008 16:55:26 -0400
Content-Disposition: inline
In-Reply-To: <200806132247.03947.m1stocke@hsr.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84943>

On Fri, Jun 13, 2008 at 10:47:03PM +0200, Mirko Stocker wrote:

> Hm, I've tried that, but it doesnt seem to work.. git-proj is a bare 
> repository, and git-cvsimport always creates a new .git in it. I'm using 
> the -C option to specify the target. Is anything else needed?

Ah, I hadn't thought of that. Apparently git-cvsimport doesn't
understand bare repos. There is even a Debian bug reported:

  http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=472873

You might be able to hack around it with:

  mkdir bare.git && (cd bare.git && git init)
  mkdir cvsimport-hack && ln -s ../bare.git cvsimport-hack/.git
  git cvsimport -C cvsimport-hack

-Peff
