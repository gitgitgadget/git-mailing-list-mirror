From: Jeff King <peff@peff.net>
Subject: [PATCH 0/3] fix minor Makefile annoyances
Date: Fri, 29 May 2015 03:21:19 -0400
Message-ID: <20150529072119.GA5415@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri May 29 09:21:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YyEbf-0001Up-Ns
	for gcvg-git-2@plane.gmane.org; Fri, 29 May 2015 09:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755020AbbE2HVX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 May 2015 03:21:23 -0400
Received: from cloud.peff.net ([50.56.180.127]:37498 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752189AbbE2HVW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 May 2015 03:21:22 -0400
Received: (qmail 8039 invoked by uid 102); 29 May 2015 07:21:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 02:21:22 -0500
Received: (qmail 23474 invoked by uid 107); 29 May 2015 07:21:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 29 May 2015 03:21:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 29 May 2015 03:21:19 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270209>

I've noticed that running "make" on a fully-built git tree still builds
a lot of things:

  $ make >/dev/null 2>&1 && make
      GEN perl/PM.stamp
      SUBDIR gitweb
      GEN git-add--interactive
      GEN git-difftool
      GEN git-archimport
      GEN git-cvsexportcommit
      GEN git-cvsimport
      GEN git-cvsserver
      GEN git-relink
      GEN git-send-email
      GEN git-svn
      GEN git-p4
      SUBDIR ../
  make[2]: 'GIT-VERSION-FILE' is up to date.
      GEN git-instaweb
      SUBDIR perl
      SUBDIR templates

Here it is after this series:

  $ make >/dev/null 2>&1 && make
      SUBDIR perl
      SUBDIR templates

The patches are:

  [1/3]: Makefile: drop dependency between git-instaweb and gitweb
  [2/3]: Makefile: avoid timestamp updates to GIT-BUILD-OPTIONS
  [3/3]: Makefile: silence perl/PM.stamp recipe

-Peff
