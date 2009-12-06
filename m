From: Jeff King <peff@peff.net>
Subject: Re: clang static analyzer
Date: Sun, 6 Dec 2009 09:57:44 -0500
Message-ID: <20091206145744.GA6725@coredump.intra.peff.net>
References: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git list <git@vger.kernel.org>
To: Tomas Carnecky <tom@dbservice.com>
X-From: git-owner@vger.kernel.org Sun Dec 06 15:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NHIYY-0005t2-VR
	for gcvg-git-2@lo.gmane.org; Sun, 06 Dec 2009 15:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933803AbZLFO5k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Dec 2009 09:57:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933796AbZLFO5j
	(ORCPT <rfc822;git-outgoing>); Sun, 6 Dec 2009 09:57:39 -0500
Received: from peff.net ([208.65.91.99]:51781 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933800AbZLFO5i (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Dec 2009 09:57:38 -0500
Received: (qmail 30368 invoked by uid 107); 6 Dec 2009 15:02:15 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sun, 06 Dec 2009 10:02:15 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Dec 2009 09:57:44 -0500
Content-Disposition: inline
In-Reply-To: <33ABC714-2BCC-4910-BCAE-D331AAF2A724@dbservice.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134665>

On Sun, Dec 06, 2009 at 07:11:24AM +0100, Tomas Carnecky wrote:

> Clang again found many dead assignments/increments, but in the earlier
> discussions you concluded that you want to keep those around. So I
> focussed on another class of potential bugs: Argument with 'nonnull'
> attribute passed null. There were a total of seven such issues. I then
> tried to look through the code and see if they are valid or false
> positives:

Thanks, I think you are moving in the right direction to manually
investigate the output of clang, since it obviously does generate some
false positives.

I think the next step for each site you found would be:

  1. If it really is a problem, then it should be easy to show a simple
     case that can trigger the issue. Submit a patch fixing that site,
     either describing the test case in the commit message, or adding a
     case to the test suite.

  2. If it is a false positive, see what it would take to silence clang
     and submit a patch.  I don't think we are opposed to annotations
     that help analysis tools as long as those annotations aren't too
     intrusive or make the code less readable.

-Peff
