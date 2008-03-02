From: Jeff King <peff@peff.net>
Subject: Re: git-rebase dirty index and email address bug?
Date: Sun, 2 Mar 2008 02:30:16 -0500
Message-ID: <20080302073016.GC3935@coredump.intra.peff.net>
References: <slrnfsjfpo.3fl.jgoerzen@katherina.lan.complete.org> <slrnfsjim1.5e0.jgoerzen@katherina.lan.complete.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: John Goerzen <jgoerzen@complete.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 08:30:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVieu-0000x6-7O
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 08:30:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752000AbYCBHaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 02:30:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751993AbYCBHaU
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 02:30:20 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2862 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751978AbYCBHaT (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 02:30:19 -0500
Received: (qmail 4378 invoked by uid 111); 2 Mar 2008 07:30:17 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Sun, 02 Mar 2008 02:30:17 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sun, 02 Mar 2008 02:30:16 -0500
Content-Disposition: inline
In-Reply-To: <slrnfsjim1.5e0.jgoerzen@katherina.lan.complete.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75738>

On Sat, Mar 01, 2008 at 03:29:37PM -0600, John Goerzen wrote:

> Two things to add:
> 
> 1) This was a clean branch prior to rebase (git status was empty)
> 
> 2) Adding -i to the rebase command, then making no changes to the
> list, caused the rebase to work perfectly.

Yes, "rebase -i" works somewhat differently than an ordinary rebase. It
uses a series of cherry-picks rather than "format-patch | am". And the
bug is, I think, in "git-am".

It probably would also have worked using "git rebase -m" which uses
merge strategies to rebase.

And yes, it is a bit crazy that there are so many ways to rebase. The
original, "format-patch | am" is faster than the other schemes, but
doesn't handle renames (as "rebase -m" does); nor is it flexible enough
to do what "rebase -i" does.

-Peff
