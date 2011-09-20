From: Jeff King <peff@peff.net>
Subject: Re: Possible timestamp problems with diff-files?
Date: Tue, 20 Sep 2011 13:54:58 -0400
Message-ID: <20110920175458.GA3776@sigill.intra.peff.net>
References: <4E786B5D.40601@syntevo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Strapetz <marc.strapetz@syntevo.com>
X-From: git-owner@vger.kernel.org Tue Sep 20 19:55:26 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R64XU-0004iV-JH
	for gcvg-git-2@lo.gmane.org; Tue, 20 Sep 2011 19:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752275Ab1ITRzO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 Sep 2011 13:55:14 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:38335
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750814Ab1ITRzA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 Sep 2011 13:55:00 -0400
Received: (qmail 21025 invoked by uid 107); 20 Sep 2011 17:59:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 20 Sep 2011 13:59:58 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 20 Sep 2011 13:54:58 -0400
Content-Disposition: inline
In-Reply-To: <4E786B5D.40601@syntevo.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181774>

On Tue, Sep 20, 2011 at 12:30:53PM +0200, Marc Strapetz wrote:

> For our Git client, we are invoking
> 
> git diff-files--quiet --ignore-submodules
> 
> immediately after a commit of *all* changes. Hence, the expected exit
> code would be 0 (because there are no changes). A user has now reported
> that for commits with many changes, exit code is sometimes 1. For the
> last incident, the commit was started at 15:24:11,820 and finished at
> 15:24:12,329, diff-files was invoked at 15:24:12,455 and failed with
> exit code 1 at 15:24:21,394. A subsequent diff-files succeeded, so I'm
> wondering now, if that could be a timestamp problem (maybe related to
> the Index)?

diff-files is scriptable plumbing, which means it is up to the script
writer to decide exactly when the index should be refreshed with respect
to the working tree files (because doing so could be kind of expensive,
as it needs to stat every file in the working tree). Have you tried
running "git update-index --refresh" just before your diff-files?

-Peff
