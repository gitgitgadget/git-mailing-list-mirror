From: Jeff King <peff@peff.net>
Subject: Re: How to check repository/working tree status from a script
Date: Thu, 21 May 2009 11:37:45 -0400
Message-ID: <20090521153745.GA23463@coredump.intra.peff.net>
References: <20090519143537.GA23505@torres.zugschlus.de> <20090521132457.GB5625@torres.zugschlus.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Haber <mh+git@zugschlus.de>
X-From: git-owner@vger.kernel.org Thu May 21 17:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M7ALE-00005K-6L
	for gcvg-git-2@gmane.org; Thu, 21 May 2009 17:37:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754006AbZEUPhr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 May 2009 11:37:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753999AbZEUPhq
	(ORCPT <rfc822;git-outgoing>); Thu, 21 May 2009 11:37:46 -0400
Received: from peff.net ([208.65.91.99]:52704 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753986AbZEUPhp (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 May 2009 11:37:45 -0400
Received: (qmail 14632 invoked by uid 107); 21 May 2009 15:37:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 21 May 2009 11:37:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 21 May 2009 11:37:45 -0400
Content-Disposition: inline
In-Reply-To: <20090521132457.GB5625@torres.zugschlus.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119690>

On Thu, May 21, 2009 at 03:24:57PM +0200, Marc Haber wrote:

> I am now looking for a solution for (b). I tried 
> 
> git log -n1 --pretty=oneline master..origin/master
> 
> but that seems to always give empty output even if a later issued git
> pull will actually pull in changes.

Try running "git fetch" beforehand, which will actually update
origin/master with what is on the remote.

Also, if you are just checking to see whether there is any output, you
can use the plumbing "git rev-list" instead of "git log". So something
like:

  git fetch origin || { echo >&2 unable to fetch; exit 1; }
  test -z "`git rev-list -1 master..origin/master`"

-Peff
