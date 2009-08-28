From: Jeff King <peff@peff.net>
Subject: Re: [BUG] git stash refuses to save after "add -N"
Date: Fri, 28 Aug 2009 15:22:17 -0400
Message-ID: <20090828192217.GA13023@coredump.intra.peff.net>
References: <54e098c45bffbf870bdfcee26b9ddecc.squirrel@intranet.linagora.com>
 <20090828190531.GB11488@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yann Dirson <ydirson@linagora.com>
X-From: git-owner@vger.kernel.org Fri Aug 28 21:22:28 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mh71n-0006bl-I6
	for gcvg-git-2@lo.gmane.org; Fri, 28 Aug 2009 21:22:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752754AbZH1TWS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Aug 2009 15:22:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752536AbZH1TWS
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Aug 2009 15:22:18 -0400
Received: from peff.net ([208.65.91.99]:36125 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752638AbZH1TWR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Aug 2009 15:22:17 -0400
Received: (qmail 7444 invoked by uid 107); 28 Aug 2009 19:22:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 28 Aug 2009 15:22:29 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Aug 2009 15:22:17 -0400
Content-Disposition: inline
In-Reply-To: <20090828190531.GB11488@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127339>

On Fri, Aug 28, 2009 at 03:05:31PM -0400, Jeff King wrote:

> For the index case, we unfortunately cannot represent the situation in
> the index using a tree, which means we cannot have a stash that doesn't
> lose information. So we have to choose either dropping those index
> entries, inserting them as blank files, or inserting them with
> working-tree contents.

Actually, you _could_ try representing the information by shoe-horning
it into the tree. For example, by allocating a bit of the mode as
"intent-to-add". That seems pretty ugly to me, though.

You could also try to stick the information in the stash's commit
message and recreate it during "stash apply". But again, that feels kind
of ugly.

-Peff
