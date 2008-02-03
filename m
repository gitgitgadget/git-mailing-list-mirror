From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] git log picks up bad commit
Date: Sat, 2 Feb 2008 22:00:54 -0500
Message-ID: <20080203030054.GA18654@coredump.intra.peff.net>
References: <20080202122135.GA5783@code-monkey.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 04:02:07 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLV7N-0003H7-1A
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 04:02:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936043AbYBCDBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Feb 2008 22:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936051AbYBCDA7
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Feb 2008 22:00:59 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3106 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S936043AbYBCDA6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Feb 2008 22:00:58 -0500
Received: (qmail 13731 invoked by uid 111); 3 Feb 2008 03:00:56 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sat, 02 Feb 2008 22:00:55 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 02 Feb 2008 22:00:54 -0500
Content-Disposition: inline
In-Reply-To: <20080202122135.GA5783@code-monkey.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72320>

On Sat, Feb 02, 2008 at 01:21:36PM +0100, Tilman Sauerbeck wrote:

> I think I either found a bug in git log, or I'm working with a broken
> repository. I can reproduce this with current git master.

I think it is a bug in your command line.

> git log -n 3 --abbrev-commit --pretty=oneline \
> 1dd567d596b072e3ce44ea5ad8c373871686b078.. 2.4

The space betwen ".." and "2.4" means that they are two separate
arguments. Thus the second part of your ".." operator is blank, which is
treated as HEAD. Thus it is equivalent to:

  1dd567d596b072e3ce44ea5ad8c373871686b078..HEAD 2.4

When you switch to branch 2.4, then 2.4 becomes your HEAD.

That being said, the commit in your 'master' branch _is_ part of
1dd567d5, and should be culled. So I'm not clear on why it shows up only
when you ask to see both branches, and that may be a bug.

-Peff
