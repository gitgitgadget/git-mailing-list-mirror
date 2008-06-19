From: Jeff King <peff@peff.net>
Subject: Re: Including branch info in git format-patch
Date: Thu, 19 Jun 2008 16:28:43 -0400
Message-ID: <20080619202843.GA6207@sigill.intra.peff.net>
References: <20080619154251.GA16475@jurassic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Mukund Sivaraman <muks@banu.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 22:29:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9QlL-0005C1-Sn
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 22:29:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751059AbYFSU2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 16:28:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750950AbYFSU2s
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 16:28:48 -0400
Received: from peff.net ([208.65.91.99]:4737 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750792AbYFSU2r (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jun 2008 16:28:47 -0400
Received: (qmail 20704 invoked by uid 111); 19 Jun 2008 20:28:46 -0000
Received: from c-24-98-46-248.hsd1.ga.comcast.net (HELO sigill.intra.peff.net) (24.98.46.248)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Thu, 19 Jun 2008 16:28:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jun 2008 16:28:43 -0400
Content-Disposition: inline
In-Reply-To: <20080619154251.GA16475@jurassic>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85523>

On Thu, Jun 19, 2008 at 09:12:52PM +0530, Mukund Sivaraman wrote:

> When i use "git format-patch", it doesn't seem to include the branch (or
> remote) name in the email it creates. So a reader of this mail may not
> know what branch to apply it on to test it. Aside from adding in branch
> information manually in the body of the message, is there any other
> existing way to get git format-patch to include it?

No, there isn't a way to do it automatically. On this mailing list,
patches are assumed to be on top of "master" unless explicitly indicated
otherwise. And we usually just mention it manually.

You could potentially add a config option to put the branch name inside
the '[PATCH]' text. This text is generally stripped away before
applying, so it would still free up the receiver to apply on whatever
branch they wanted. I don't think it would make sense for git
development, since we typically use topic branches, so keeping it
configurable would make sense.

On the receiving end, the applying party could set up their MUA to split
patches based on the subject, and then apply them as appropriate (this
very much depends on their workflow for applying patches). You could
probably even do a pre-applypatch hook as a safety valve to make sure
things were being applied in the right place.

-Peff
