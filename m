From: Jeff King <peff@peff.net>
Subject: Re: How to remove a specific hunk
Date: Fri, 26 Oct 2007 12:42:08 -0400
Message-ID: <20071026164207.GB19673@coredump.intra.peff.net>
References: <4722036E.5030204@wanadoo.fr> <472207AA.8030100@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pascal Obry <pascal.obry@wanadoo.fr>, git@vger.kernel.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Fri Oct 26 18:43:39 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IlSHR-0000ev-FB
	for gcvg-git-2@gmane.org; Fri, 26 Oct 2007 18:43:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765038AbXJZQmN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Oct 2007 12:42:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765110AbXJZQmM
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Oct 2007 12:42:12 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3492 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1765094AbXJZQmK (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Oct 2007 12:42:10 -0400
Received: (qmail 32015 invoked by uid 111); 26 Oct 2007 16:42:09 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 26 Oct 2007 12:42:09 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 26 Oct 2007 12:42:08 -0400
Content-Disposition: inline
In-Reply-To: <472207AA.8030100@op5.se>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/62426>

On Fri, Oct 26, 2007 at 05:28:42PM +0200, Andreas Ericsson wrote:

> Once you've added the other two hunks, they'll no longer show up in
> git-diff, so you can do something like this:
>
> $ git-add -i; # add the other two hunks to commit
> $ git-diff > middle-hunk.patch
> $ git-apply -R middle-hunk.patch
> test, test, test
> $ git-apply middle-hunk.patch

That has the side effect of changing the index state. My preferred
method would be to just excise the hunk from the diff using an editor
(and this actually has nothing to do with git; you could be using
diff/patch):

git-diff file >patch
# remove every hunk except what you want to cut out
$EDITOR patch
git-apply -R patch

-Peff
