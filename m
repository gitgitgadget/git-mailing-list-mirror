From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/3] Teach Git about the patience diff algorithm
Date: Fri, 2 Jan 2009 14:39:04 -0500
Message-ID: <20090102193904.GB9129@coredump.intra.peff.net>
References: <20081104152351.GA21842@artemis.corp> <alpine.DEB.1.00.0901011730190.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901011134210.5086@localhost.localdomain> <20090101204652.GA26128@chistera.yi.org> <alpine.LFD.2.00.0901011747010.5086@localhost.localdomain> <20090102105537.GA14691@localhost> <20090102105856.GB14691@localhost> <alpine.LFD.2.00.0901020833000.5086@localhost.localdomain> <alpine.DEB.1.00.0901021918100.30769@pacific.mpi-cbg.de> <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Clemens Buchacher <drizzd@aon.at>,
	Adeodato =?utf-8?B?U2ltw7M=?= <dato@net.com.org.es>,
	Pierre Habouzit <madcoder@debian.org>, davidel@xmailserver.org,
	Francis Galiegue <fg@one2team.net>,
	Git ML <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jan 02 20:40:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LIpsl-0006y5-A5
	for gcvg-git-2@gmane.org; Fri, 02 Jan 2009 20:40:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757888AbZABTjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 2 Jan 2009 14:39:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757134AbZABTjI
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Jan 2009 14:39:08 -0500
Received: from peff.net ([208.65.91.99]:3900 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753669AbZABTjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Jan 2009 14:39:07 -0500
Received: (qmail 19294 invoked by uid 111); 2 Jan 2009 19:39:05 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 02 Jan 2009 14:39:05 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 02 Jan 2009 14:39:04 -0500
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0901021050450.5086@localhost.localdomain>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/104410>

On Fri, Jan 02, 2009 at 11:03:07AM -0800, Linus Torvalds wrote:

> Well, it's also the test-case in the very first hit on google for 
> "patience diff" (with the quotes).
> 
> In fact, it's the _only_ one I ever found ;)

If you just want to see the results on some real-world cases (and don't
care about measuring performance), try installing bzr and using their
patiencediff test program as a GIT_EXTERNAL_DIFF.

On Debian, it's:

  $ sudo apt-get install bzr
  $ cat >$HOME/patience <<'EOF'
    #!/bin/sh
    exec python /usr/share/pyshared/bzrlib/patiencediff.py "$2" "$5"
    EOF
  $ chmod 755 patience
  $ GIT_EXTERNAL_DIFF=$HOME/patience git diff

Other distributions presumably install patiencediff.py somewhere
similar (or you can maybe even pull it from the source, but presumably
you have to install some other bzr modules, too).

-Peff
