From: Jeff King <peff@peff.net>
Subject: Re: Error: "You have some suspicious patch lines"
Date: Tue, 22 Jul 2008 03:26:20 -0400
Message-ID: <20080722072620.GA3796@sigill.intra.peff.net>
References: <4885895C.5050108@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ben Aurel <ben.aurel@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 22 09:27:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLCHI-0007x4-Je
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 09:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751089AbYGVH0W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 03:26:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751169AbYGVH0V
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 03:26:21 -0400
Received: from peff.net ([208.65.91.99]:3376 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750869AbYGVH0V (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 03:26:21 -0400
Received: (qmail 3397 invoked by uid 111); 22 Jul 2008 07:26:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Jul 2008 03:26:20 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Jul 2008 03:26:20 -0400
Content-Disposition: inline
In-Reply-To: <4885895C.5050108@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89458>

On Tue, Jul 22, 2008 at 09:16:44AM +0200, Ben Aurel wrote:

> -----------------------------------------
>
> Editing '.git/hooks/pre-commit' and comment out the following lines
> --
> 61             if (/^\s* \t/) {
> 62                 bad_line("indent SP followed by a TAB", $_);
> 63             }
> --
>
> And finally "git commit" works again.
>
> The question now is: Is it really necessary to edit the git script  
> everytime? Is there a urgent reason why git refuses to commit because of  
> "suspicious" lines? Is it really necessary?

The pre-commit hook that ships with git checks whitespace as an example
of what one _could_ do with hooks. It is not meant to be enabled by
default (unless you want that whitespace checking).

So either:

 1. You enabled it by setting the execute bit. If so, then don't do
    that.

 2. Something is broken, and it has caused the hook to be enabled
    accidentally. I recall somebody complaining that hooks were enabled
    by default under cygwin because the filesystem didn't support the
    execute bit. Are you working on an exec-bit challenged filesystem?

In newer versions of git, the hooks actually ship with a .sample
extension so that they will not be used accidentally, regardless of the
executable bit. In the meantime, it is safe to simply delete
.git/hooks/pre-commit if it is bothering you.

-Peff
