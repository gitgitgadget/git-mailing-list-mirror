From: Jeff King <peff@peff.net>
Subject: Re: Config variables and scripting // was Re: [RFC/PATCH] log: add
 log.firstparent option
Date: Wed, 22 Jul 2015 22:48:17 -0700
Message-ID: <20150723054816.GA1917@peff.net>
References: <20150723012343.GA21000@peff.net>
 <20150723044007.GA3651@gmail.com>
 <20150723051445.GA24029@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Josh Bleecher Snyder <josharian@gmail.com>
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 07:48:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZI9Mn-0008Do-HX
	for gcvg-git-2@plane.gmane.org; Thu, 23 Jul 2015 07:48:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbbGWFsV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Jul 2015 01:48:21 -0400
Received: from cloud.peff.net ([50.56.180.127]:33930 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750702AbbGWFsU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jul 2015 01:48:20 -0400
Received: (qmail 2624 invoked by uid 102); 23 Jul 2015 05:48:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 00:48:20 -0500
Received: (qmail 9439 invoked by uid 107); 23 Jul 2015 05:48:24 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Jul 2015 01:48:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 22 Jul 2015 22:48:17 -0700
Content-Disposition: inline
In-Reply-To: <20150723051445.GA24029@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/274478>

On Wed, Jul 22, 2015 at 10:14:45PM -0700, Jeff King wrote:

> Script writers should not care here, because they should not be parsing
> the output of the porcelain "log" command in the first place. It already
> has many gotchas (e.g., log.date, log.abbrevCommit).
> 
> I am sympathetic, though. There are some things that git-log can do that
> rev-list cannot, so people end up using it in scripts. I think you can
> avoid it with a "rev-list | diff-tree" pipeline, though I'm not 100%
> sure if that covers all cases. But I would much rather see a solution
> along the lines of making the plumbing cover more cases, rather than
> trying to make the porcelain behave in a script.

Ah, I see in a nearby thread that you just recently fixed a problem with
git-subtree and log.date, so I see now why you are so interested. :)

And I was also reminded by that usage of why rev-list is annoying in
scripts: even with "--format", it insists on writing the "commit ..."
header. I wonder if we could fix that...

-Peff
