From: Jeff King <peff@peff.net>
Subject: Re: speed of git reset -- file
Date: Wed, 1 Jun 2011 18:56:48 -0400
Message-ID: <20110601225647.GD16820@sigill.intra.peff.net>
References: <20110531190015.GA12113@gnu.kitenet.net>
 <20110531212639.GA13234@sigill.intra.peff.net>
 <7v62oqignm.fsf@alter.siamese.dyndns.org>
 <20110601195831.GA30070@sigill.intra.peff.net>
 <20110601201629.GA25354@gnu.kitenet.net>
 <20110601211847.GA31958@sigill.intra.peff.net>
 <20110601220502.GA28493@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Joey Hess <joey@kitenet.net>
X-From: git-owner@vger.kernel.org Thu Jun 02 00:56:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRuLP-00053q-5I
	for gcvg-git-2@lo.gmane.org; Thu, 02 Jun 2011 00:56:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756709Ab1FAW4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 18:56:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:60183
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751561Ab1FAW4u (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 18:56:50 -0400
Received: (qmail 18914 invoked by uid 107); 1 Jun 2011 22:56:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 18:56:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 18:56:48 -0400
Content-Disposition: inline
In-Reply-To: <20110601220502.GA28493@gnu.kitenet.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174918>

On Wed, Jun 01, 2011 at 06:05:02PM -0400, Joey Hess wrote:

> Jeff King wrote:
> > > My experience with semi-large trees[1] is that I have to remember to use
> > > "git status ." in a subdir; that "git commit -a" is of course slow when
> > > I need to use it; and that the index gets big and things that need to
> > > update it can become somewhat slow especially on slow disks, but that
> > 
> > Generally I find that the stats are very fast because everything is in
> > cache, and the disk doesn't come into it at all. Are you on an OS
> > besides Linux, or on a machine with low memory?
> 
> I have Linux and a gigabyte of ram and a not particularly good SSD.
> Here `git reset file` takes 30 seconds, `git status` 45 seconds.

OK, that's horrific. For me, the stat information for linux-2.6 all sits
in cache and it takes about 0.3 seconds to refresh the index. I have 8G
of ram and a nice SSD, though it doesn't actually hit the disk at all.

Is it really faulting the stat information from disk that takes so long?
Have you tried running "perf" on "git update-index --refresh"?

-Peff
