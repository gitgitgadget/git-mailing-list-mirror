From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] stash: require a clean index to apply
Date: Sun, 7 Jun 2015 08:47:15 -0400
Message-ID: <20150607124714.GA17632@peff.net>
References: <5570F094.10007@quantopian.com>
 <20150607124001.GA11042@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Kamens <jkamens@quantopian.com>
X-From: git-owner@vger.kernel.org Sun Jun 07 14:47:27 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z1Zz1-0007K8-MT
	for gcvg-git-2@plane.gmane.org; Sun, 07 Jun 2015 14:47:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbbFGMrU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Jun 2015 08:47:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:42319 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751470AbbFGMrS (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Jun 2015 08:47:18 -0400
Received: (qmail 30929 invoked by uid 102); 7 Jun 2015 12:47:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Jun 2015 07:47:18 -0500
Received: (qmail 25517 invoked by uid 107); 7 Jun 2015 12:47:21 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 07 Jun 2015 08:47:21 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 07 Jun 2015 08:47:15 -0400
Content-Disposition: inline
In-Reply-To: <20150607124001.GA11042@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270969>

On Sun, Jun 07, 2015 at 08:40:01AM -0400, Jeff King wrote:

> Are you running flake8 across the whole tree, or just on the files with
> proposed changes? Does it need to see the whole tree? If you can get
> away with feeding it single files, then it should be very efficient to
> loop over the output of "git diff-index HEAD" and feed the proposed
> updated blobs to it. If you can get away with feeding single lines, then
> feeding the actual diffs to it would be even better, but I assume that
> is not enough (I do not use flake8 myself).

Like I said, I do not use it, but peeking at the flake8 source code, it
has an "--install-hook" option to set up a pre-commit hook. It looks
like the hook runs "git diff-index --cached --name-only HEAD" to get
the list of modified files, filters that only for "*.py", and then
copies the results into a temporary directory to operate on.

-Peff
